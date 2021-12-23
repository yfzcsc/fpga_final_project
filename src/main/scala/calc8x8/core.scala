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
    dsp48.io.in_b := RegNext(io.in_b, 0.S)
    val r_in_a = RegInit(0.S(18.W))
    dsp48.io.in_a := r_in_a
    io.result := RegNext(dsp48.io.out, 0.S)
    
    switch(io.flag){
        is(CoreType.leakyReLU){
            when(io.in_b(io.in_b.getWidth-1)){
                r_in_a := 6554.S
            }.otherwise{
                r_in_a := 32768.S
            }
        }
        is(CoreType.calcMult){
            r_in_a := io.w_a
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


class ComplexCore extends Module{
    val io = IO(new Bundle{
        val sbx = Input(SInt(18.W))
        val rbx = Input(Bool())
        val bx = Input(SInt(18.W))
        val by = Input(SInt(18.W))
        val ax = Input(SInt(20.W))
        val ay = Input(SInt(20.W))
        val x = Output(SInt(40.W))
        val y = Output(SInt(40.W))
    })
    val _ax = RegNext(io.ax, 0.S(20.W))
    val _ay = RegNext(io.ay, 0.S(20.W))
    val _bx = RegNext(io.bx, 0.S(18.W))
    val _by = RegNext(io.by, 0.S(18.W))
    val w = RegNext((io.ay<<(1.U))*io.sbx+&Mux(io.rbx, io.ay, 0.S), 0.S)
    io.x := RegNext((_ax+&_ay)*_bx-&w, 0.S)
    io.y := RegNext((_ax-&_ay)*_by+&w, 0.S)
}