package final_project

import chisel3._
import chisel3.util._

class AccumuCounter extends Bundle{
    val csum = UInt(20.W)
    val fsum = UInt(20.W)
}

class AccumuRawData(val w: Int) extends Bundle{
    val mat = Vec(64, SInt((w*2+12).W))
}

// for x.. for y.. for ic.. for oc..
// get the sum of a 8x8 block

class Accumu(w: Int, addr_w: Int, bias_w: Int) extends Module{
    val io = IO(new Bundle{
        val in_from_calc8x8 = Input(new RawData(w))
        val result = Output(new AccumuRawData(w))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
        val flag_job = Input(Bool())
        val csum = Input(new AccumuCounter())
        val begin_addr = Input(UInt(addr_w.W))
        val bias_addr = Output(UInt(addr_w.W))
        val bias_in = Input(SInt(bias_w.W))
        val is_in_use = Input(Bool())
    })

    val counter = RegInit(Reg(new AccumuCounter()))
    val output = RegInit(Reg(new AccumuRawData(w)))
    val now_addr = RegInit(Reg(UInt(addr_w.W)))
    val enable = RegInit(Reg(Bool()))

    io.valid_out := false.B
    io.bias_addr := now_addr
    when(io.flag_job){
        counter := io.csum
        output := 0.S.asTypeOf(output)
        now_addr := io.bias_addr
        enable := io.is_in_use
    }.elsewhen(enable){
        when(io.valid_in){
            when(counter.csum===0.U){
                io.valid_out := true.B
                for(i <- 0 to 63)  
                    io.result.mat(i) := output.mat(i)
                for(i <- 0 to 63)  
                    output.mat(i) := io.in_from_calc8x8.mat(i)+io.bias_in
                counter.csum := counter.fsum
            }.otherwise{
                io.valid_out := false.B
                for(i <- 0 to 63)
                    output.mat(i) := output.mat(i)+io.in_from_calc8x8.mat(i)
                counter.csum := counter.csum-1.U
            }
            when(counter.csum===1.U){
                now_addr := now_addr+1.U
            }
        }
        
        
    }

}