package final_project

import chisel3._
import chisel3.util._

class WeightReader(val w: Int, val addr_w: Int) extends Module{
    val io = IO(new Bundle{
        val flag_job = Input(Bool())
        val addr_end = Input(UInt(addr_w.W))
        val begin_addr = Input(UInt(addr_w.W))
        val enable = Input(Bool())
        val addr = Output(UInt(addr_w.W))
    })

    val now_addr = RegInit(0.U.asTypeOf(ACounter(addr_w)))
    io.addr := 0.U
    
    io.addr := now_addr.ccnt
    when(io.flag_job){
        now_addr.set(io.begin_addr, io.addr_end)
    }.elsewhen(io.enable){
        now_addr.inc()
    }
}

