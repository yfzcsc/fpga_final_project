package final_project

import chisel3._
import chisel3.util._

object AccumuType extends ChiselEnum{
    val goThrough = Value(0.U)
    val waitCounter = Value(1.U)
}

class AccumuCounter extends Bundle{
    val csum = UInt(20.W)
}

class AccumuRawData(val w: Int) extends Bundle{
    val mat = Vec(64, SInt((w*2+12).W))
}

// for x.. for y.. for ic.. for oc..
// get the sum of a 8x8 block

class Accumu(w: Int) extends Module{
    val io = IO(new Bundle{
        val in_from_calc8x8 = Input(new RawData(w))
        val csum = Input(new AccumuCounter())
        val result = Output(new AccumuRawData(w))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
        val flag_job = Input(Bool())
    })

    val counter = RegInit(0.U.asTypeOf(AccumuCounter))
    val output = RegInit(0.S.asTypeOf(AccumuRawData))

    io.valid_out := false.B
    when(flag_job){
        counter.csum := io.csum
        output := 0.S.asTypeOf(AccumuRawData)
    }.otherwise{
        counter.csum := Mux(valid_in, counter.csum-1, counter.csum)
        when(counter.csum===0.U){
            io.valid_out := io.valid_in
            for(i <- 0 to 63)  
                io.result(i) := io.in_from_calc8x8(i)
        }.elsewhen(counter.csum===1.U){
            io.valid_out := io.valid_in
            for(i <- 0 to 63)  
                io.result(i) := Mux(io.valid_in, output(i)+io.in_from_calc8x8(i), 0.S.asTypeOf(AccumuRawData))
        }.otherwise{
            io.valid_out := false.B
            for(i <- 0 to 63)
                output(i) := Mux(io.valid_in, output(i)+io.in_from_calc8x8(i), output(i))
        }
    }

}