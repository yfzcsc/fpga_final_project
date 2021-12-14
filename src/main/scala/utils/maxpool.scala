package final_project

import chisel3._
import chisel3.util._

class Maxpool(val w: Int) extends Module{
    val io = IO(new Bundle{
        val data = Input(new PackedData(w))
        val result = Output(new QuantedData(w))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
    })
    val state = RegInit(0.U(2.W))
    val output = RegInit(0.U.asTypeOf(new QuantedData(w)))
    val cache = Wire(Vec(16, SInt(w.W)))

    io.valid_out := false.B
    io.result := 0.U.asTypeOf(io.result)

    when(io.valid_in){
        for(ii <- 0 to 3)
            for(jj <- 0 to 3){
                val w4 = Wire(Vec(4, SInt(w.W)))
                val a2 = Wire(SInt(w.W))
                val b2 = Wire(SInt(w.W))
                for(i <- 0 to 1)
                    for(j <- 0 to 1)
                        w4(i*2+j) := io.data.mat((ii*2+i)*8+(jj*2+j))
                a2 := Mux(w4(0)<w4(1), w4(1), w4(0))
                b2 := Mux(w4(2)<w4(3), w4(2), w4(3))
                cache(ii*4+jj) := Mux(a2<b2, b2, a2)
            }
        switch(state){
            is(0.U){
                for(i <- 0 to 3)
                    for(j <- 0 to 3)
                        output.mat(i*8+j) := cache(i*4+j)
                state := 1.U
            }
            is(1.U){
                for(i <- 0 to 3)
                    for(j <- 0 to 3)
                        output.mat(i*8+j+4) := cache(i*4+j)
                state := 2.U
            }
            is(2.U){
                for(i <- 0 to 3)
                    for(j <- 0 to 3)
                        output.mat((i+4)*8+j) := cache(i*4+j)
                state := 3.U
            }
            is(3.U){
                for(i <- 0 to 3)
                    for(j <- 0 to 3)
                        io.result.mat(i*8+j) := output.mat(i*8+j)
                for(i <- 0 to 3)
                    for(j <- 0 to 3)
                        io.result.mat(i*8+j+4) := output.mat(i*8+j+4)
                
                for(i <- 0 to 3)
                    for(j <- 0 to 3)
                        io.result.mat((i+4)*8+j) := output.mat((i+4)*8+j)

                for(i <- 0 to 3)
                    for(j <- 0 to 3)
                        io.result.mat((i+4)*8+j+4) := cache(i*4+j)
                io.valid_out := true.B
                state := 0.U
            }
        }
    }
}