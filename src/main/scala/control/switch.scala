package final_project

import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

object ReadSwitchType extends ChiselEnum{
    val toCopy = Value(0.U)
    val toConv = Value(1.U)
    val toMult2 = Value(2.U)
    val toMaxp = Value(3.U)
    val idle = Value(4.U)
}

class ReadSwitchBundle(val w: Int, val para_num: Int) extends Bundle{
    val flag_job = Input(Bool())
    val job = Input(ReadSwitchType())
    val valid_in = Input(Bool())
    val valid_out_calc8x8 = Output(Bool())
    val valid_out_copy = Output(Bool())
    val valid_out_maxp = Output(Bool())
    val from = Input(new PackedData(w))
    val from_weight = Input(Vec(para_num, Vec(9, SInt(16.W))))
    val to_calc8x8 = Output(new PackedData(w))
    val to_copy = Output(new QuantedData(w))
    val to_weight = Output(Vec(para_num, new CalcWeightData()))
    val to_multmap = Output(Vec(4, new CalcWeightData()))
}

class ReadSwitch(val w: Int, val para_num: Int) extends Module{
    val io = IO(new ReadSwitchBundle(w, para_num))
    val job_type = RegInit(0.U.asTypeOf(ReadSwitchType()))

    val cache = RegInit(VecInit(Seq.fill(64){0.S(w.W)}))
    val state = RegInit(0.U.asTypeOf(ACounter(1.W)))

    io.valid_out_calc8x8 := false.B
    io.valid_out_copy := false.B
    io.valid_out_maxp := false.B
    io.to_calc8x8 := 0.U.asTypeOf(io.to_calc8x8)
    io.to_weight := 0.U.asTypeOf(io.to_weight)
    io.to_copy := 0.U.asTypeOf(io.to_copy)
    io.to_multmap := 0.U.asTypeOf(io.to_multmap)
    
    io.to_calc8x8 :=io.from
    io.to_copy.mat := io.from.mat
    when(io.flag_job){
        job_type := io.job
        state.set(1.U)
    }.elsewhen(io.valid_in){
        switch(job_type){
            is(ReadSwitchType.toConv){
                for(t <- 0 to para_num-1)
                    for(i <- 0 to 8)
                        io.to_weight(t).real(i) := io.from_weight(t)(i)
                io.valid_out_calc8x8 := true.B
            }
            is(ReadSwitchType.toCopy){
                io.valid_out_copy := true.B
            }
            is(ReadSwitchType.toMult2){
                when(state.inc()){                
                    io.valid_out_calc8x8 := true.B
                    for(ii <- 0 to 1)
                        for(jj <- 0 to 1)
                            for(i <- 0 to 3)
                                for(j <- 0 to 3)
                                    io.to_multmap(ii*2+jj).real(i*4+j) := cache((i+ii*4)*8+(j+jj*4))
                }.otherwise{
                    cache := io.from.mat
                }
            }
            is(ReadSwitchType.toMaxp){
                io.valid_out_maxp := true.B
            }
            is(ReadSwitchType.idle){

            }
        }
    }
}

class WriteSwitch(val w: Int, val num: Int) extends Module{
    val io = IO(new Bundle{
        val valid_in = Input(Vec(num, new Bool()))
        val valid_out = Output(Bool())
        val input = Input(Vec(num, new QuantedData(w)))
        val output = Output(new QuantedData(w))
    })
    io.output := MuxCase(0.U.asTypeOf(io.output), Seq.tabulate(num){
        i => (io.valid_in(i) -> io.input(i))
    })
    io.valid_out := io.valid_in.reduce(_ | _)
}