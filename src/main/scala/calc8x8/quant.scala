package final_project

import chisel3._
import chisel3.util._

class QuantedData(val w: Int) extends Bundle{
    val mat = Vec(64, SInt(w.W))
}

class QuantJob(val w: Int) extends Bundle{
    val in_q = UInt(6.W)
    val out_q = UInt(6.W)
    /*
    def clamp_ls(x: SInt, a: UInt): Data = {
        val ret1 = Wire(SInt(w.W))
        val ret2 = Wire(((1<<(w-1))-1).S(w.W))
        val ret3 = Wire((-(1<<(w-1))).S(w.W))
        ret1 := x<<a
        return Mux(x((x.getWidth-1)),
            Mux(x((x.getWidth-1).U, 15.U-a).andR, 
                ret1,
                ret3
            ),
            Mux(x(x.getWidth-1, 15.U-a).orR,
                ret2,
                ret1
            )
        )
    }
    def clamp_rs(x: SInt, a: UInt): Data = {
        val ret1 = Wire(SInt(w.W))
        val ret2 = Wire(((1<<(w-1))-1).S(w.W))
        val ret3 = Wire((-(1<<(w-1))).S(w.W))
        ret1 := x>>a
        return Mux(x(x.getWidth-1),
            Mux(x(x.getWidth-1, 15.U+a).andR, 
                ret1,
                ret3
            ),
            Mux(x(x.getWidth-1, 15.U+a).orR,
                ret2,
                ret1
            )
        )
    }
    */
    
    def clamp_ls(x: SInt, a: UInt): Data = {
        val ret2 = ((1<<(w-1))-1).S(64.W)
        val ret3 = (-(1<<(w-1))).S(64.W)
        val ret1 = Wire(SInt(64.W))
        ret1 := x<<a
        return Mux(ret1<=ret3, ret3, Mux(ret1>=ret2, ret2, ret1))
    }
    def clamp_rs(x: SInt, a: UInt): Data = {
        val ret2 = ((1<<(w-1))-1).S(64.W)
        val ret3 = (-(1<<(w-1))).S(64.W)
        val ret1 = Wire(SInt(64.W))
        ret1 := x>>a
        return Mux(ret1<=ret3, ret3, Mux(ret1>=ret2, ret2, ret1))
    }
    def F(in: SInt): Data = {
        return Mux(in_q<=out_q, clamp_ls(in, out_q-in_q), clamp_rs(in, in_q-out_q))
    }
}

class Quant(val w: Int) extends Module{
    val io = IO(new Bundle{
        val in_from_accumu = Input(new AccumuRawData(w))
        val result = Output(new QuantedData(w))
        val flag_job = Input(Bool())
        val quant_in = Input(new QuantJob(w))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
    })


    val quant = RegInit(0.U.asTypeOf(new QuantJob(w)))

    io.valid_out := false.B
    io.result := 0.U.asTypeOf(new QuantedData(w))
    
    when(io.flag_job){
        quant := io.quant_in
    }.otherwise{
        io.valid_out := io.valid_in
        for(i <- 0 to 63)
            io.result.mat(i) := quant.F(io.in_from_accumu.mat(i))
    }

}