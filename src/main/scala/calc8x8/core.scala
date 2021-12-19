package final_project

import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

object CoreType extends ChiselEnum {
    val leakyReLU = Value(0.U)
    val calcMult = Value(1.U)
}


class Core extends Module{
    val io = IO(new Bundle{
        val w_a = Input(SInt(18.W))
        val in_b = Input(SInt(20.W))
        val flag = Input(CoreType())
        val result = Output(SInt(38.W))
    })
    
    val dsp48 = Module(new DSP48())
    dsp48.io.in_b := io.in_b
    dsp48.io.in_a := 0.S
    io.result := dsp48.io.out
    
    switch(io.flag){
        is(CoreType.leakyReLU){
            when(io.in_b(io.in_b.getWidth-1)){
                dsp48.io.in_a := 32767.S
            }.otherwise{
                dsp48.io.in_a := 6554.S
            }
        }
        is(CoreType.calcMult){
            dsp48.io.in_a := io.w_a
        }
    }
}

class ip_dsp48 extends BlackBox{
    val io = IO(new Bundle{
        val A = Input(SInt(25.W))
        val B = Input(SInt(18.W))
        val P = Output(SInt(43.W))
    })
}

class DSP48 extends Module{
    val io = IO(new Bundle{
        val in_a = Input(SInt(18.W))
        val in_b = Input(SInt(20.W))
        val out = Output(SInt(38.W))
    })
    /*
    val M = Module(new ip_dsp48).io
    M.A := io.in_b
    M.B := io.in_a
    io.out := M.P*/
    io.out := io.in_a*io.in_b
}