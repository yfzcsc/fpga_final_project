package final_project

import chisel3._
import chisel3.util._

// remember this is register, not wire
trait GenAddress extends Bundle{
    val block_num: UInt             // [0, block_num=block_size-1]
    val dist_nxt_height: UInt       // H*block_size
    val max_addr: UInt
    val min_addr: UInt
    val now_addr: UInt
    val begin_addr: UInt
    val height: UInt                // [0, H-1]
    val width: UInt                 // [0, W-1]
    val a: UInt
    val x: UInt
    val y: UInt
    val flag_end: Bool
    def reset(): Unit = {
        now_addr := begin_addr
    }
    def clamp(addr: UInt): UInt = {
        return Mux(addr>=max_addr, addr-max_addr+min_addr, addr)
    }
    def gen_conv(): UInt    // conv and ups
    def gen_maxp(): UInt
}

class GenReadBankAddress extends GenAddress{
    val loop_num: UInt
    val state: UInt
    val state_maxp: UInt
    def nxt(): UInt = {
        val a_end = a===block_num
        y := Mux(a_end, Mux(x===height, y+1.U, y), y)
        x := Mux(a_end, Mux(x===height, 0.U, x+1.U), x)
        a := Mux(a_end, 0.U, a+1.U)
        now_addr := clamp(now_addr+1.U)
        return now_addr
    }
    
    def nxt_cycle(): UInt = {
        val a_end = a===block_num
        a := Mux(a_end, 0.U, a+1.U)
        now_addr := clamp(Mux(a_end, now_addr-block_num, now_addr+1.U))
        return now_addr
    }
    override def gen_conv(): UInt = {
        val a_end = a===block_num
        flag_end := flag_end||(x===width&&y===height&&a_end&&state===loop_num)
        state := Mux(state===loop_num&&a_end, 0.U, state+1.U)
        return Mux(state===loop_num&&a_end, nxt(), nxt_cycle())
    }
    override def gen_maxp(): Unit = { 
        val nxt_addr = Wire(UInt)
        when(x===height&&y===width&&a===block_num){
            flag_end := true.B
        }.otherwise{
            switch(state_maxp){
                is(0.U){
                    nxt_addr := now_addr+dist_nxt_height
                    state_maxp := ~state_maxp
                }
                is(1.U){
                    when(a===block_num){
                        a := 0
                        when(x===height){
                            y := y+1.U
                            x := 0.U
                            nxt_addr := now_addr+1.U
                        }.otherwise{
                            x := x+1.U
                            y := y
                            nxt_addr := now_addr-dist_nxt_height+1.U
                        }
                    }.otherwise{
                        nxt_addr := now_addr-dist_nxt_height+1.U
                        a := a+1.U
                    }
                    state_maxp := ~state_maxp
                }
            }
        }
        now_addr := clamp(nxt_addr)
    }
}


class GenWriteBankAddress extends GenAddress{
    // a is the output_chan that it outputs,
    val al: UInt
    val ar: UInt 
    override def gen_conv(): Unit = {
        val a_end = a===ar
        flag_end := flag_end||(x===width&&y===height&&a_end)
        now_addr = Mux(a_end, now_addr+block_num-ar+1.U, now_addr+1.U)
        a := Mux(a_end, al, a+1.U)
        y := Mux(a_end, Mux(x===height, y+1.U, y), y)
        x := Mux(a_end, Mux(x===height, 0.U, x+1.U), x)
    }
    override def gen_maxp(): Unit = {
        val a_end = a===block_num
        y := Mux(a_end, Mux(x===height, y+1.U, y), y)
        x := Mux(a_end, Mux(x===height, 0.U, x+1.U), x)
        a := Mux(a_end, 0.U, a+1.U)
        now_addr := clamp(now_addr+1.U)
        return now_addr
    }
}

object ReadBigBank{
    def apply()
} 

object WriteBigBank{
    def apply() = new GenWriteBankAddress()
    def apply(job: WriteJob) = Data {
        ret := Wire(new GenWriteBankAddress)
        ret.al := job.al
        ret.ar := job.ar
        ret.block_num := job.block_size-1.U
        ret.dist_nxt_height := job.block_size*job.h
        ret.max_addr := job.max_addr
        ret.min_addr := job.min_addr
        ret.begin_addr := job.begin_addr
        ret.height := job.h-1.U
        ret.width := job.w-1.U
        ret.begin_addr := job.begin_addr
        ret.a := 0.U
        ret.x := 0.U
        ret.y := 0.U
        ret.now_addr := job.begin_addr
        ret.flag_end := false.B
        return ret
    }
}

object ReadBigBank{
    def apply() = new GenReadBankAddress()
    def apply(job: ReadJob) = Data {
        ret := Wire(new GenReadBankAddress)
        ret.loop_num := job.loop_num
        ret.block_num := job.block_size-1.U
        ret.dist_nxt_height := job.block_size*job.h
        ret.max_addr := job.max_addr
        ret.min_addr := job.min_addr
        ret.begin_addr := job.begin_addr
        ret.height := job.h-1.U
        ret.width := job.w-1.U
        ret.begin_addr := job.begin_addr
        ret.a := 0.U
        ret.x := 0.U
        ret.y := 0.U
        ret.now_addr := job.begin_addr
        ret.flag_end := false.B
        return ret
    }
}

class ReadGroup{
    
}