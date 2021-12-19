package final_project

import chisel3._
import chisel3.util._

import chisel3.experimental.BundleLiterals._

import chisel3.stage.ChiselStage

class Fuck extends Module{
    val io = IO(new Bundle{
        val f = Output(Bool())
    })
    val A = Module(new big_bank0(10, 20)).io
    val x = RegInit(0.U.asTypeOf(ACounter(6.W)))
    val state = RegInit(0.U(6.W))
    io.f := false.B
    switch(state){
        is(0.U){
            x.set(10.U)
            state := 1.U
        }
        is(1.U){
            when(x.inc()){
                state := 2.U
            }.otherwise{
                A.addra := x.ccnt
                A.dina := x.ccnt    
            }
            
        }
        is(2.U){
            when(x.inc()){
                state := 3.U
            }.otherwise{
                A.addrb := x.ccnt
                when(A.doutb=/=x.ccnt){
                    state := 4.U
                }
            }
        }
        is(3.U){
            io.f := true.B
        }
        is(4.U){
            io.f := false.B
        }
    }
}

object FafaDriver extends App {
    (new ChiselStage).emitVerilog(
        new Top,
        //new ROMBias,
        //new RAMGroup(StdPara.w, StdPara.addr_w, StdPara.id_w), 
        Array("--target-dir", "C:\\Users\\yfz\\Desktop\\data\\Plan\\homework\\AI_fpga\\final_project\\project_1\\")
    )
}