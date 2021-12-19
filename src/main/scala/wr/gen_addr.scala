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
    def go(): Unit
    def output(): Data
}

// remember this is a register, not wire
abstract class GenAddress(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends Bundle with GenAddressInterface{
    val max_addr = UInt(addr_w.W) 
    val min_addr = UInt(addr_w.W) 
    val now_addr = UInt(addr_w.W)
    val cnt_ic = ACounter(h_w.W)
    val cnt_x = ACounter(h_w.W)
    val cnt_y = ACounter(h_w.W)
    val bank_id = UInt(id_w.W)
    val block_size = UInt(c_w.W)
    val column_size = UInt(addr_w.W)
    def clamp(addr: UInt): UInt = {
        val nxt = Wire(UInt(addr_w.W))
        when(addr>=max_addr){
            nxt := addr-max_addr+min_addr
        }.otherwise{
            nxt := addr
        }
        return nxt
    }
    def set(x: WRJob): Unit = {
        max_addr := x.max_addr
        min_addr := x.min_addr
        now_addr := x.begin_addr
        block_size := x.block_size
        column_size := x.column_size
        cnt_ic.set(x.cnt_ic_end)
        cnt_x.set(x.cnt_x_end)
        cnt_y.set(x.cnt_y_end)
        bank_id := x.bank_id
    }
    override def output(): Data = {
        return Address(now_addr, bank_id)
    }
}

class GenReadBigBankAddress(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends GenAddress(addr_w, h_w, c_w, id_w){
    val cnt_loop = ACounter(h_w.W)
    val cnt_ups = ACounter(1.W)
    val cnt_maxp = ACounter(2.W)
    val y_begin_addr = UInt(addr_w.W)
    val ic_begin_addr = UInt(addr_w.W)
    val flag_end = Bool() 
    override def go(): Unit = {
        val nxt_addr = Wire(UInt(addr_w.W))
        nxt_addr := 0.U
        when(cnt_ic.inc()){
            when(cnt_loop.inc()){
                when(cnt_y.inc()){
                    when(cnt_ups.inc()){
                        when(cnt_x.inc()){
                            flag_end := true.B
                        }.otherwise{
                            nxt_addr := now_addr+1.U
                        }
                        y_begin_addr := clamp(nxt_addr)
                    }.otherwise{
                        nxt_addr := y_begin_addr
                    }
                }.otherwise{
                    nxt_addr := now_addr+1.U
                }
                ic_begin_addr := clamp(nxt_addr)
            }.otherwise{
                nxt_addr := ic_begin_addr
            }
        }.otherwise{
            nxt_addr := now_addr+1.U
        }
        now_addr := clamp(nxt_addr)
    }
    def go_maxp(): Unit = {
        val nxt_addr = Wire(UInt(addr_w.W))
        nxt_addr := 0.U
        when(cnt_maxp.inc()){
            when(cnt_ic.inc()){
                when(cnt_y.inc()){
                    when(cnt_x.inc()){
                        flag_end := true.B
                    }.otherwise{
                        nxt_addr := now_addr+1.U
                    }
                }.otherwise{
                    nxt_addr := y_begin_addr+block_size+1.U
                }
            }.otherwise{
                nxt_addr := y_begin_addr+1.U
            }
            y_begin_addr := clamp(nxt_addr)
        }.otherwise{
            switch(cnt_maxp.ccnt){
                is(0.U){
                    nxt_addr := y_begin_addr+block_size
                }
                is(1.U){
                    nxt_addr := y_begin_addr+column_size
                }
                is(2.U){
                    nxt_addr := y_begin_addr+column_size+block_size
                }
            }
        }
        now_addr := clamp(nxt_addr)
    }
    def is_end(): Bool = {
        return flag_end
    }
    def set(x: ReadBigJob): Unit = {
        super.set(x)
        flag_end := false.B
        cnt_loop.set(x.begin_loop, x.cnt_loop_end)
        cnt_ups.set(x.cnt_ups_end)
        cnt_maxp.set(3.U)
        y_begin_addr := x.begin_addr
        ic_begin_addr := x.begin_addr
    }
}

class GenReadSmallBankAddress(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends GenAddress(addr_w, h_w, c_w, id_w){
    val ano_bank_id = UInt(id_w.W) 
    val cnt_invalid = ACounter(h_w.W)
    val cnt_maxp = ACounter(2.W)
    val cnt_ups = ACounter(1.W)
    val cnt_loop = ACounter(h_w.W)
    val cnt_swap = ACounter(1.W)
    val y_begin_addr = UInt(addr_w.W)
    val ic_begin_addr = UInt(addr_w.W)
    val start = Bool()
    override def go(): Unit = {
        val nxt_addr = Wire(UInt(addr_w.W))
        nxt_addr := 0.U
        when(cnt_invalid.inc()||start){
            start := true.B
            when(cnt_ic.inc()){
                when(cnt_loop.inc()){
                    when(cnt_y.inc()){
                        when(cnt_ups.inc()){
                            when(cnt_swap.inc()){
                                nxt_addr := now_addr+1.U
                                y_begin_addr := clamp(nxt_addr)
                            }.otherwise{
                                nxt_addr := y_begin_addr
                            }
                            bank_id := ano_bank_id
                            ano_bank_id := bank_id
                        }.otherwise{
                            nxt_addr := y_begin_addr
                        }
                    }.otherwise{
                        nxt_addr := now_addr+1.U
                    }
                    ic_begin_addr := clamp(nxt_addr)
                }.otherwise{
                    nxt_addr := ic_begin_addr
                }
            }.otherwise{
                nxt_addr := now_addr+1.U
            }
            now_addr := clamp(nxt_addr)    
        }
    }
    def go_maxp(): Unit = {
        val nxt_addr = Wire(UInt(addr_w.W))
        nxt_addr := 0.U
        when(cnt_maxp.inc()){
            when(cnt_ic.inc()){
                nxt_addr := now_addr+1.U
                bank_id := ano_bank_id
                ano_bank_id := bank_id
            }.otherwise{
                nxt_addr := y_begin_addr+1.U
                bank_id := ano_bank_id
                ano_bank_id := bank_id
            }
            y_begin_addr := clamp(nxt_addr)
        }.otherwise{
            switch(cnt_maxp.ccnt){
                is(0.U){
                    nxt_addr := y_begin_addr+block_size
                }
                is(1.U){
                    nxt_addr := y_begin_addr
                    bank_id := ano_bank_id
                    ano_bank_id := bank_id
                }
                is(2.U){
                    nxt_addr := y_begin_addr+block_size
                }
            }
        }
        now_addr := clamp(nxt_addr)
    }
    def set(x: ReadSmallJob): Unit = {
        super.set(x)
        ano_bank_id := x.ano_bank_id
        cnt_loop.set(x.begin_loop, x.cnt_loop_end)
        cnt_invalid.set(x.cnt_invalid_end)
        cnt_ups.set(x.cnt_ups_end)
        cnt_maxp.set(3.U)
        cnt_swap.set(x.begin_swap, 1.U)
        start := false.B
        y_begin_addr := x.begin_addr
        ic_begin_addr := x.begin_addr
    }
}


class GenWriteSmallBankAddress(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends GenAddress(addr_w, h_w, c_w, id_w){
    // a is the output_chan that it outputs,
    val a = UInt(c_w.W)
    val ano_bank_id = UInt(id_w.W) 
    val cnt_swap = ACounter(1.W)
    val y_begin_addr = UInt(h_w.W)
    override def go(): Unit = {
        val nxt_addr = Wire(UInt(addr_w.W))
        nxt_addr := 0.U
        when(cnt_ic.inc()){
            when(cnt_y.inc()){
                when(cnt_swap.inc()){
                    nxt_addr := now_addr+a
                    y_begin_addr := clamp(nxt_addr)
                }.otherwise{
                    nxt_addr := y_begin_addr
                }
                bank_id := ano_bank_id
                ano_bank_id := bank_id
            }.otherwise{
                nxt_addr := now_addr+a
            }
        }.otherwise{
            nxt_addr := now_addr+1.U
        }
        now_addr := clamp(nxt_addr)
    }

    def set(x: WriteSmallJob): Unit = {
        super.set(x)
        a := x.a
        ano_bank_id := x.ano_bank_id
        y_begin_addr := x.begin_addr
        cnt_swap.set(1.U)
    }
}

class GenWriteBigBankAddress(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends GenAddress(addr_w, h_w, c_w, id_w){
    val a = UInt(c_w.W) 
    override def go(): Unit = {
        val nxt_addr = Wire(UInt(addr_w.W))
        when(cnt_ic.inc()){
            nxt_addr := now_addr+a
        }.otherwise{
            nxt_addr := now_addr+1.U
        }
        now_addr := clamp(nxt_addr)
    }
    
    def set(x: WriteBigJob): Unit = {
        super.set(x)
        a := x.a
    }

}

class ReadGroup(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends Bundle{
    val big = new GenReadBigBankAddress(addr_w, h_w, c_w, id_w)
    val small = Vec(4, new GenReadSmallBankAddress(addr_w, h_w, c_w, id_w))
    def set(x: ReadJobs): Unit = {
        big.set(x.big)
        for(i <- 0 to 3)
            small(i).set(x.small(i))
    }
    def go(): Unit = {
        big.go()
        for(i <- 0 to 3)
            small(i).go()
    }
    def go_maxp(): Unit = {
        big.go_maxp()
        for(i <- 0 to 1)
            small(i).go_maxp()
    }
    def output(): Data = {
        val ret = Wire(new AddressReadGroup(addr_w, id_w))
        ret.addrs(0) := big.output()
        for(j <- 0 to 3)
            ret.addrs(j+1) := small(j).output()
        return ret
    }
    def is_end(): Bool = {
        return big.is_end()
    }
}


class WriteGroup(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends Bundle{
    val big = new GenWriteBigBankAddress(addr_w, h_w, c_w, id_w)
    val small = Vec(2, new GenWriteSmallBankAddress(addr_w, h_w, c_w, id_w))
    def set(x: WriteJobs): Unit = {
        big.set(x.big)
        for(j <- 0 to 1)
            small(j).set(x.small(j))
    }
    def go(): Unit = {
        big.go()
        for(j <- 0 to 1)
            small(j).go()
    }
    def output(): Data = {
        val ret = Wire(new AddressWriteGroup(addr_w, id_w))
        ret.addrs(0) := big.output()
        for(j <- 0 to 1)
            ret.addrs(j+1) := small(j).output()
        return ret
    }
}