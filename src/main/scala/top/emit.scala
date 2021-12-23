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
    io.y := (_ax-&_ay)*_by+&w
}
/*
class FuckAdd extends Module{
    val io = IO(new Bundle{
        val t = Input(SInt(48.W))
        val tx = Input(SInt(48.W))
        val tg = Input(Bool())
        val hi_y = Input(SInt(24.W))
        val lo_y = Input(SInt(24.W))
        val hi_out = Output(SInt(24.W))
        val lo_out = Output(SInt(24.W))
    })
    val state = RegInit(0.U(1.W))
    val hi_and = RegInit(0.S(24.W))
    val lo_and = RegInit(0.S(24.W))
    val hi_xor = RegInit(0.S(24.W))
    val lo_xor = RegInit(0.S(24.W))
    val lst_hi = RegInit(VecInit(Seq.fill(2)(0.S(24.W))))
    val lst_lo = RegInit(VecInit(Seq.fill(2)(0.S(24.W))))
    when(tg){
        lo_and := t(23, 0)&tx(23, 0)
        lo_xor := t(23, 0)^tx(23, 0)
        hi_xor := t(47, 24)^tx(47, 24)
        hi_and := t(47, 24)&tx(47, 24)
        lst_hi(0) := t(23, 0)
        lst_lo(0) := t(47, 24)
        lst_hi(1) := tx(23, 0)
        lst_lo(1) := tx(47, 24)
        state := 0.U
    }.otherwise{
        hi_and := 
    }
    
}
*/
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
        new Accumu(16, 10, 10, 4),
        //new ROMBias,
        //new RAMGroup(StdPara.w, StdPara.addr_w, StdPara.id_w), 
        Array("--target-dir", "C:\\Users\\yfz\\Desktop\\data\\Plan\\homework\\AI_fpga\\final_project\\project_test\\")
    )
}