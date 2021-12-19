package final_project

import chisel3._
import chisel3.util._

class Maxpool(val w: Int) extends Module{
    val io = IO(new Bundle{
        val from_big = Input(Vec(2, new BigBankReadData(w)))
        val from_small = Input(Vec(2, Vec(2, new SmallBankReadData(w))))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
        val result = Output(new QuantedData(w))
    })
    val state = RegInit(0.U(1.W))
    val output = RegInit(VecInit(Seq.fill(32)(0.S(w.W))))
    val cache = Wire(Vec(32, SInt(w.W)))

    cache := 0.U.asTypeOf(cache)
 
    io.valid_out := false.B
    io.result := 0.U.asTypeOf(io.result)
    
    for(t <- 0 to 1){
        for(ii <- 0 to 3){
            for(jj <- 0 to 3){
                val w4 = Wire(Vec(4, SInt(w.W)))
                val a2 = Wire(SInt(w.W))
                val b2 = Wire(SInt(w.W))
                for(i <- 0 to 1){
                    for(j <- 0 to 1){
                        val x = ii*2+i
                        val y = jj*2+j
                        if(y==0){
                            w4(i*2+j) := io.from_small(t)(0).data(x)
                        } else if(y==7){
                            w4(i*2+j) := io.from_small(t)(1).data(x)
                        } else {
                            w4(i*2+j) := io.from_big(t).data(x*6+y-1)
                        }
                    }
                }
                a2 := Mux(w4(0)<w4(1), w4(1), w4(0))
                b2 := Mux(w4(2)<w4(3), w4(2), w4(3))
                cache((ii+t*4)*4+jj) := Mux(a2<b2, b2, a2)
            }
        }
    }
    when(io.valid_in){
        switch(state){
            is(0.U){
                output := cache
                state := 1.U
            }
            is(1.U){
                for(i <- 0 to 3)
                    for(j <- 0 to 3)
                        io.result.mat(i*8+j) := output(i*4+j)
                for(i <- 0 to 3)
                    for(j <- 0 to 3)
                        io.result.mat((i+4)*8+j) := output((i+4)*4+j)
                
                for(i <- 0 to 3)
                    for(j <- 0 to 3)
                        io.result.mat((i)*8+j+4) := cache((i)*4+j)

                for(i <- 0 to 3)
                    for(j <- 0 to 3)
                        io.result.mat((i+4)*8+j+4) := cache((i+4)*4+j)
                io.valid_out := true.B
                state := 0.U
            }
        }
    }
}