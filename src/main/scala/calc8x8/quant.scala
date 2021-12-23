package final_project

import chisel3._
import chisel3.util._

class QuantedData(val w: Int) extends Bundle{
    val mat = Vec(64, SInt(w.W))
}

class QuantJob(val w: Int) extends Bundle{
    val in_q = UInt(6.W)
    val out_q = UInt(6.W)
}

class QuantBundle(val w: Int) extends TransBundle{
    val in_from_accumu = Input(new AccumuRawData(w))
    val result = Output(new QuantedData(w))
    val quant_in = Input(new QuantJob(w))
}

class Quant(val w: Int) extends Module{
    val io = IO(new QuantBundle(w))


    val quant = RegInit(0.U.asTypeOf(new QuantJob(w)))
    val r_q = RegInit(0.U(5.W))

    io.valid_out := false.B
    io.result := 0.U.asTypeOf(new QuantedData(w))

    def clamp_rs(x: SInt, a: UInt): Data = {
        val ret2 = ((1<<(w-1))-1).S(32.W)
        val ret3 = (-(1<<(w-1))).S(32.W)
        val ret1 = Wire(SInt(32.W))
        ret1 := x>>a
        return Mux(ret1<=ret3, ret3, Mux(ret1>=ret2, ret2, ret1))
    }
    for(i <- 0 to 63)
        io.result.mat(i) := clamp_rs(io.in_from_accumu.mat(i), r_q)
    
    when(io.flag_job){
        quant := io.quant_in
        r_q := io.quant_in.in_q-io.quant_in.out_q
    }.otherwise{
        io.valid_out := io.valid_in
    }

}