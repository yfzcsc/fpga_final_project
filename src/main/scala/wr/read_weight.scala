package final_project

import chisel3._
import chisel3.util._

class WeightReader(val w: Int, val addr_w: Int) extends Module{
    val io = IO(new Bundle{
        val flag_job = Input(Bool())
        val begin_addr = Input(UInt(addr_w.W))
        val enable = Input(Bool())
        val addr = Output(UInt(addr_w.W))
    })

    val now_addr = RegInit(Reg(UInt(addr_w.W)))
    io.addr := 0.U

    when(io.flag_job){
        now_addr := io.begin_addr
    }.elsewhen(io.enable){
        now_addr := now_addr+1.U
        io.addr := now_addr
    }
}

