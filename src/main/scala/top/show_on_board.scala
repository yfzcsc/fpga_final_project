package final_project

import chisel3._
import chisel3.util._

import chisel3.experimental.BundleLiterals._

class Show extends Module{
    val io = IO(new Bundle{
        val start = Input(Bool())
        val ok = Output(Bool())
    })
    val fuck = Module(new Top).io
    fuck.start := io.start
    fuck.input := 0.S
    io.ok := false.B
    when(fuck.complete_output){
        io.ok := fuck.checksum===26782.U
    }
}