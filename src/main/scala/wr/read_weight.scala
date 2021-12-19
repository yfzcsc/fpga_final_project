package final_project

import chisel3._
import chisel3.util._

class WeightReaderBundle(val w: Int, val addr_w: Int) extends TransBundle{
    val addr_end = Input(UInt(addr_w.W))
    val begin_addr = Input(UInt(addr_w.W))
    val addr = Output(UInt(addr_w.W))
}

class WeightReader(val w: Int, val addr_w: Int) extends Module{
    val io = IO(new WeightReaderBundle(w, addr_w))

    val now_addr = RegInit(0.U.asTypeOf(ACounter(addr_w)))
    io.addr := now_addr.ccnt
    io.valid_out := false.B
    when(io.flag_job){
        now_addr.set(io.begin_addr, io.addr_end)
    }.elsewhen(io.valid_in){
        now_addr.inc()
    }
}

