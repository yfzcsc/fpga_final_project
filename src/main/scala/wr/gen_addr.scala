package final_project

import chisel3._
import chisel3.util._

class Address(val addr_w: Int, val id_w: Int) extends Bundle{
    val addr = UInt(addr_w.W)
    val bank_id = UInt(id_w.W)
}

object Address{
    def apply(addr_w: Int, id_w: Int) = new Address(addr_w, id_w)
    def apply(addr: Data, id: Data): Data = {
        val ret = Wire(Address(addr.getWidth, id.getWidth))
        ret.addr := addr
        ret.bank_id := id
        return ret
    }
}

class AddressReadGroup(val addr_w: Int, val id_w: Int) extends Bundle{
    val addrs = Vec(5, Address(addr_w, id_w))
}

class AddressWriteGroup(val addr_w: Int, val id_w: Int) extends Bundle{
    val addrs = Vec(3, Address(addr_w, id_w))
}


trait GenAddressInterface{
    def gen_conv(): Unit
    def gen_maxp(): Unit
    def output(): Data
}

// remember this is a register, not wire
trait GenAddress extends Bundle with GenAddressInterface{
    val block_num = UInt()             // a is in [0, block_num=block_size-1]
    val max_addr = UInt() 
    val min_addr = UInt() 
    val now_addr = UInt() 
    val a = UInt() 
    val cnt = UInt() 
    val cnt_end = UInt() 
    val bank_id = UInt() 
    val dist_nxt_height = UInt() 
    def clamp(addr: UInt): UInt = {
        return Mux(addr>=max_addr, addr-max_addr+min_addr, addr)
    }
    def nxt_a(): Unit = {
        a := Mux(a===block_num, 0.U, a+1.U)
        now_addr := clamp(Mux(a===block_num, now_addr-block_num, now_addr+1.U))
    }
    def nxt(): Unit = {
        when(a===block_num){
            a := 0.U
            cnt := cnt+1.U
        }.otherwise{
            a := a+1.U
        }
        now_addr := clamp(now_addr+1.U)
    }
    def set(x: WRJob): Unit = {
        block_num := x.block_num
        max_addr := x.max_addr
        min_addr := x.min_addr
        now_addr := x.begin_addr
        cnt_end := x.cnt_end
        bank_id := x.bank_id
        dist_nxt_height := x.dist_nxt_width
        a := 0.U(x.block_num.getWidth)
        cnt := 0.U(x.cnt_end.getWidth)
    }
    override def output(): Data = {
        return Address(now_addr, bank_id)
    }
}

class GenReadBigBankAddress extends GenAddress{
    val loop_num = UInt() 
    val state = UInt() 
    val state_maxp = UInt() 
    val state_ups = UInt() 
    val flag_end = Bool() 
    val cnt_h = UInt() 
    override def gen_conv(): Unit = {
        when(state===loop_num){
            nxt()
        }.otherwise{
            nxt_a()
        }
        state := Mux(a===block_num, Mux(state===loop_num, 0.U, state+1.U), state)
        flag_end := flag_end||(state===loop_num&&a===block_num&&cnt===cnt_end)
    }
    override def gen_maxp(): Unit = {
        flag_end := flag_end||(a===block_num&&cnt===cnt_end)
        val nxt_addr = Wire(UInt())
        when(a===block_num){
            when(state_maxp(0)){
                nxt_addr := now_addr-dist_nxt_height+1.U
                a := 0.U
                cnt := cnt+1.U
            }.otherwise{
                nxt_addr := now_addr+dist_nxt_height
                cnt := cnt+1.U
            }
        }.otherwise{
            when(state_maxp(0)){
                nxt_addr := now_addr-dist_nxt_height
                a := a+1.U
            }.otherwise{
                nxt_addr := now_addr+dist_nxt_height
            }
        }
        now_addr := clamp(nxt_addr)
        state_maxp := ~state_maxp
    }
    def gen_ups(): Unit = {
        val nxt_addr = Wire(UInt())
        flag_end := flag_end||(a===block_num&&cnt===cnt_end&&state_maxp(0))
        when(a===block_num){
            when(state_ups===cnt_h){
                when(state_maxp(0)){
                    nxt_addr := now_addr+1.U
                }.otherwise{
                    nxt_addr := now_addr-dist_nxt_height+1.U
                }
                state_ups := 0.U
                state_maxp(0) := ~state_maxp(0)
            }.otherwise{
                nxt_addr := now_addr+1.U
                when(state_maxp(0)){
                    cnt := cnt+1.U
                }
            }
            a := 0.U
        }.otherwise{
            nxt_addr := now_addr+1.U
            a := a+1.U
        }
        now_addr := clamp(nxt_addr)
    }
    def is_end(): Bool = {
        return flag_end
    }
    def set(x: ReadBigJob): Unit = {
        super.set(x)
        loop_num := x.loop_num
        state := 0.U(x.loop_num.getWidth)
        state_maxp := 0.U(1.W)
        state_ups := 0.U(x.cnt_h.getWidth)
        flag_end := false.B
        cnt_h := x.cnt_h
    }
}

// cnt is not the same as BigBank. it means height [H-1].
class GenReadSmallBankAddress extends GenAddress{
    val ano_bank_id = UInt() 
    val validL = UInt() 
    val state = UInt() 
    val loop_num = UInt() 
    val loop_state = UInt() 
    override def gen_conv(): Unit = {
        val nxt_addr = Wire(UInt())
        when(validL.orR){
            validL := validL-1.U
        }.otherwise{
            when(a===block_num&&loop_state===loop_num){
                when(cnt===cnt_end){
                    when(state(0)){
                        nxt_addr := now_addr+1.U
                    }.otherwise{
                        nxt_addr := now_addr-dist_nxt_height+1.U
                    }  
                    cnt := 0.U
                    bank_id := ano_bank_id
                    ano_bank_id := bank_id
                    state := ~state 
                }.otherwise{
                    cnt := cnt+1.U
                    nxt_addr := now_addr+1.U
                }
                loop_state := 0.U
                a := 0.U
            }.otherwise{
                when(a===block_num){
                    a := 0.U
                    loop_state := loop_state+1.U
                }.otherwise{
                    a := a+1.U
                }
                nxt_addr := now_addr+1.U
            }
            now_addr := clamp(nxt_addr)
        }
    }
    override def gen_maxp(): Unit = {
        gen_conv()
    }
    def gen_ups(): Unit = {
        // validL = 0
        gen_conv()
    }
    def set(x: ReadSmallJob): Unit = {
        super.set(x)
        ano_bank_id := x.ano_bank_id
        validL := x.validL
        loop_num := x.loop_num
        state := 0.U(1.W)
        loop_state := 0.U(x.loop_num.getWidth)
    }
}


class GenWriteSmallBankAddress extends GenAddress{
    // a is the output_chan that it outputs,
    val al = UInt() 
    val ar = UInt() 
    val ano_bank_id = UInt() 
    val state = UInt() 
    def gen(_al: UInt, _ar: UInt): Unit = {
        val nxt_addr = Wire(UInt())
        when(a===_ar){
            when(cnt===cnt_end){
                cnt := 0.U
                nxt_addr := Mux(state(0), now_addr+block_num-ar+al, now_addr+block_num-ar+1.U-dist_nxt_height) 
                bank_id := ano_bank_id
                ano_bank_id := bank_id
            }.otherwise{
                cnt := cnt+1.U
                nxt_addr := now_addr+block_num-ar+1.U
            }   
            a := _al
        }.otherwise{
            a := a+1.U
            nxt_addr := now_addr+1.U
        }
        now_addr := clamp(now_addr+1.U)
    }
    override def gen_conv(): Unit = {
        gen(al, ar)
    }
    override def gen_maxp(): Unit = {
        gen(0.U, block_num)
    }

    def set(x: WriteSmallJob): Unit = {
        super.set(x)
        al := x.al
        ar := x.ar
        ano_bank_id := x.ano_bank_id
        state := 0.U(1.W)
    }
}

class GenWriteBigBankAddress extends GenAddress{
    // a is the output_chan that it outputs,
    val al = UInt() 
    val ar = UInt() 
    def gen(_al: UInt, _ar: UInt): Unit = {
        val nxt_addr = Wire(UInt())
        when(a===_ar){
            nxt_addr := now_addr+block_num-ar+1.U
            a := _al
        }.otherwise{
            a := a+1.U
            nxt_addr := now_addr+1.U
        }
        now_addr := clamp(now_addr+1.U)
    }
    override def gen_conv(): Unit = {
        gen(al, ar)
    }
    override def gen_maxp(): Unit = {
        gen(0.U, block_num)
    }
    
    def set(x: WriteSmallJob): Unit = {
        super.set(x)
        al := x.al
        ar := x.ar
    }

}

class ReadGroup(val addr_w: Int, val id_w: Int) extends Bundle{
    val big = Vec(2, new GenReadBigBankAddress())
    val small = Vec(2, Vec(4, new GenReadSmallBankAddress()))
    val state = UInt(3.W)
    def set(x: ReadJobs): Unit = {
        for(i <- 0 to 1)
            big(i).set(x.big(i))
        for(i <- 0 to 1)
            for(j <- 0 to 3)
                small(i)(j).set(x.small(i)(j))
        state := 0.U
    }
    def gen_conv(): Unit = {
        big(state(1)).gen_conv()
        for(j <- 0 to 3)
            small(state(1))(j).gen_conv()
        state(1) := ~state(1)
    }
    def gen_maxp(): Unit = {
        state(1, 0) := state(1, 0)+1.U
        big(state(1)).gen_maxp()
        when(state(0)){
            for(j <- 2 to 3)
                small(state(1))(j).gen_maxp()
        }.otherwise{
            for(j <- 0 to 1)
                small(state(1))(j).gen_maxp()
        }
    }
    def gen_ups(): Unit = {
        big(state(1)).gen_ups()
        for(j <- 0 to 1)
            small(state(1))(j).gen_conv()
        state(1) := ~state(1)
    }
    def output(): Data = {
        val ret = Wire(new AddressReadGroup(addr_w, id_w))
        ret.addrs(0) := big(state(1)).output()
        for(j <- 0 to 3)
            ret.addrs(j+1) := small(state(1))(j).output()
        return ret
    }
    def is_end(): Bool = {
        return big(0).is_end()&&big(1).is_end()
    }
}


class WriteGroup(val addr_w: Int, val id_w: Int) extends Bundle{
    val big = new GenWriteBigBankAddress()
    val small = Vec(2, new GenWriteSmallBankAddress())
    def set(x: WriteJobs): Unit = {
        big.set(x.big)
        for(j <- 0 to 3)
            small(j).set(x.small(j))
    }
    def gen_conv(): Unit = {
        big.gen_conv()
        for(j <- 0 to 1)
            small(j).gen_conv()
    }
    def output(): Data = {
        val ret = Wire(new AddressWriteGroup(addr_w, id_w))
        ret.addrs(0) := big.output()
        for(j <- 0 to 1)
            ret.addrs(j+1) := small(j).output()
        return ret
    }
}