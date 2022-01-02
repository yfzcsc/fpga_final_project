package final_project

import chisel3._
import chisel3.util._

import chisel3.experimental.BundleLiterals._

class Wrapper extends Module{
    val io = IO(new Bundle{
        val raw_bram_addr = Output(UInt(32.W))
        val rgb_bram_wr_en = Output(Bool())
        val rgb_bram_addr = Output(UInt(12.W))
        val rgb_bram_data = Output(UInt(24.W))
        val raw_bram_data = Input(UInt(32.W))
    })

    val quant_in = 4

    val top = Module(new FinalTop).io
    val sigmoid = Module(new Sigmoid).io
    sigmoid.valid_in := top.valid
    sigmoid.input := top.output

    top.input := 0.S
    top.valid_in := false.B
    top.start := true.B

    io.raw_bram_addr := 0.U
    io.rgb_bram_wr_en := false.B
    io.rgb_bram_addr := 0.U
    io.rgb_bram_data := 0.U

    val in_state = RegInit(0.U(2.W))
    val raw_addr = RegInit(0.U(20.W))
    val raw_addr_0 = RegInit(false.B)
    val in_w = RegInit(0.U.asTypeOf(ACounter(2.W)))
    val in_h = RegInit(0.U.asTypeOf(ACounter(2.W)))
    val in_chan = RegInit(0.U.asTypeOf(ACounter(2.W)))
    val x = RegInit(0.U.asTypeOf(ACounter(3.W)))
    val y = RegInit(0.U.asTypeOf(ACounter(3.W)))
    
    switch(in_state){
        is(0.U){
            when(top.complete){
                in_state := 1.U
            }
            io.raw_bram_addr := 0.U
            in_w.set(3.U)
            in_h.set(3.U)
            in_chan.set(3.U)
            x.set(7.U)
            y.set(2.U, 7.U)
            // raw_addr := Cat(in_chan.ccnt, y.ccnt, in_h.ccnt, x.ccnt, in_w.ccnt)
            raw_addr := 4.U
            raw_addr_0 := false.B
        }
        is(1.U){
            when(y.inc()){
                when(x.inc()){
                    when(in_chan.inc()){
                        when(in_w.inc()){
                            when(in_h.inc()){
                                in_state := 2.U
                            }
                        }
                    }
                }
            }
            // raw_addr := ((in_w.ccnt*8+x.ccnt)*32+(in_h.ccnt*8+y.ccnt))*2+(in_chan.ccnt>>1.U)
            // raw_addr := Cat(in_chan.ccnt, y.ccnt, in_h.ccnt, x.ccnt, in_w.ccnt)
            raw_addr := Cat(in_w.ccnt, x.ccnt, in_h.ccnt, y.ccnt, in_chan.ccnt)
            raw_addr_0 := raw_addr(0)
            io.raw_bram_addr := (raw_addr >> 1.U) << 2.U // (AXI32)
            top.input := Cat(0.U(1.W), Mux(raw_addr_0, io.raw_bram_data(7, 0).asUInt, io.raw_bram_data(15, 8).asUInt) << quant_in.U).asSInt
            top.valid_in := true.B
        }
        is(2.U){
            io.raw_bram_addr := (raw_addr >> 1.U) << 2.U
            top.input := Cat(0.U(1.W), Mux(raw_addr_0, io.raw_bram_data(7, 0).asUInt, io.raw_bram_data(15, 8).asUInt) << quant_in.U).asSInt
            top.valid_in := true.B
            when(top.complete_output){
                in_state := 0.U
            }.otherwise{
                in_state := 3.U
            }
        }
        is(3.U){
            when(top.complete_output){
                in_state := 0.U
            }
        }
    }

    val out_state = RegInit(0.U(3.W))
    val out_reg = RegInit(VecInit(Seq.fill(64)(0.U(24.W))))
    val out_64_counter = RegInit(0.U.asTypeOf(ACounter(6.W)))
    
    val out_w = RegInit(0.U.asTypeOf(ACounter(3.W)))
    val out_h = RegInit(0.U.asTypeOf(ACounter(3.W)))
    val out_x = RegInit(0.U.asTypeOf(ACounter(3.W)))
    val out_y = RegInit(0.U.asTypeOf(ACounter(3.W)))
    for(i <- 0 to 62)
        out_reg(i) := out_reg(i+1)
        
    switch(out_state){
        is(0.U){
            when(sigmoid.valid_out){
                out_state := 1.U
            }
            out_reg(63) := Cat(sigmoid.output, 0.U(16.W))
            out_w.set(7.U)
            out_h.set(7.U)
            out_x.set(7.U)
            out_y.set(7.U)
            out_64_counter.set(1.U, 63.U)
        }
        is(6.U){
            when(sigmoid.valid_out){
                out_state := 1.U
            }.otherwise{
                out_state := 0.U
            }
            out_reg(63) := Cat(sigmoid.output, 0.U(16.W))
            out_64_counter.set(1.U, 63.U)
        }
        is(1.U){
            when(out_64_counter.inc()){
                out_state := 2.U
            }
            out_reg(63) := Cat(sigmoid.output, 0.U(16.W))
        }
        is(2.U){
            when(out_64_counter.inc()){
                out_state := 3.U
            }
            out_reg(63) := Cat(out_reg(0)(23, 16), sigmoid.output, 0.U(8.W))
        }
        is(3.U){
            when(out_64_counter.inc()){
                out_state := 5.U
            }
            out_reg(63) := Cat(out_reg(0)(23, 8), sigmoid.output)
        }
        is(5.U){
            when(out_y.inc()){
                when(out_x.inc()){
                    out_state := 6.U
                    when(out_h.inc()){
                        out_w.inc()
                    }
                }
            }
            // io.rgb_bram_addr := Cat(out_y.ccnt, out_h.ccnt, out_x.ccnt, out_w.ccnt)
            io.rgb_bram_addr := Cat(out_h.ccnt, out_x.ccnt, out_w.ccnt, out_y.ccnt)
            io.rgb_bram_data := out_reg(0)
            io.rgb_bram_wr_en := true.B
        }
    }
    
}  