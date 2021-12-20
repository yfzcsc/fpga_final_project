package final_project

import chisel3._
import chisel3.util._

import chisel3.experimental.BundleLiterals._

import chisel3.stage.ChiselStage

// test

class Fuck extends Module{
    val io = IO(new Bundle{
        val sbx = Input(SInt(18.W))
        val rbx = Input(SInt(40.W))
        val bx = Input(SInt(18.W))
        val by = Input(SInt(18.W))
        val ax = Input(SInt(20.W))
        val ay = Input(SInt(20.W))
        val x = Output(SInt(40.W))
        val y = Output(SInt(40.W))
    })
    val _ax = RegNext(io.ax, 0.S(18.W))
    val _ay = RegNext(io.ay, 0.S(18.W))
    val _bx = RegNext(io.bx, 0.S(18.W))
    val _by = RegNext(io.by, 0.S(18.W))
    val w = RegInit(0.S(40.W))
    w := (io.ay<<(1.U))*io.sbx+&io.rbx
    io.x := (_ax+&_ay)*_bx-&w
    io.y := (_ax-&_ay)*_by-&w
}

object FafaDriver extends App {
    (new ChiselStage).emitVerilog(
        new Top,
        //new ROMBias,
        //new RAMGroup(StdPara.w, StdPara.addr_w, StdPara.id_w), 
        Array("--target-dir", "C:\\Users\\yfz\\Desktop\\data\\Plan\\homework\\AI_fpga\\final_project\\project_1\\")
    )
}

object FuckDriver extends App {
    (new ChiselStage).emitVerilog(
        new Fuck,
        //new ROMBias,
        //new RAMGroup(StdPara.w, StdPara.addr_w, StdPara.id_w), 
        Array("--target-dir", "C:\\Users\\yfz\\Desktop\\data\\Plan\\homework\\AI_fpga\\final_project\\project_test\\")
    )
}