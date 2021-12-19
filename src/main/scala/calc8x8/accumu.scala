package final_project

import chisel3._
import chisel3.util._

class AccumuRawData(val w: Int) extends Bundle{
    val mat = Vec(64, SInt((w*2+12).W))
}

class AccumuBundle(w: Int, addr_w: Int, bias_w: Int, para_num: Int) extends Bundle{
    val in_from_calc8x8 = Input(Vec(para_num, new RawData(w)))
    val result = Output(Vec(para_num, new AccumuRawData(w)))
    val csum = Input(UInt(addr_w.W))
    val bias_begin_addr = Input(UInt(addr_w.W))
    val bias_end_addr = Input(UInt(addr_w.W))
    val bias_addr = Output(UInt(addr_w.W))
    val bias_in = Input(Vec(para_num, SInt(bias_w.W)))
    val is_in_use = Input(Bool())
    val valid_in = Input(UInt(para_num.W))
    val valid_out = Output(UInt(para_num.W))
    val flag_job = Input(Bool())
}

// for x.. for y.. for ic.. for oc..
// get the sum of a 8x8 block

class Accumu(w: Int, addr_w: Int, bias_w: Int, para_num: Int) extends Module{
    val io = IO(new AccumuBundle(w, addr_w, bias_w, para_num))

    val counter = RegInit(0.U.asTypeOf(ACounter(addr_w)))
    val output = RegInit(0.U.asTypeOf(Vec(para_num, new AccumuRawData(w))))
    val now_addr = RegInit(0.U.asTypeOf(ACounter(addr_w)))
    val enable = RegInit(false.B)

    io.result := 0.U.asTypeOf(Vec(para_num, new AccumuRawData(w)))
    io.valid_out := false.B
    io.bias_addr := now_addr.ccnt

    val b64 = Wire(Vec(para_num, new AccumuRawData(w)))
    val r64 = Wire(Vec(para_num, new AccumuRawData(w)))

    when(counter.ccnt===counter.cend){
        for(t <- 0 to para_num-1)
            for(i <- 0 to 63){
                b64(t).mat(i) := io.bias_in(t)
            }
    }.otherwise{
        b64 := output
    }
    for(t <- 0 to para_num-1)
        for(i <- 0 to 63){
            r64(t).mat(i) := io.in_from_calc8x8(t).mat(i)+b64(t).mat(i)
        }

    output := r64
    io.result := r64
    
    when(io.flag_job){
        counter.set(io.csum, io.csum)
        output := 0.S.asTypeOf(output)
        now_addr.set(io.bias_begin_addr, io.bias_end_addr)
        enable := io.is_in_use
    }.elsewhen(enable){
        when(io.valid_in.orR){
            when(counter.ccnt===counter.cend){
                io.valid_out := 0.U
                counter.ccnt := counter.ccnt-1.U
            }.elsewhen(counter.ccnt===0.U){
                io.valid_out := io.valid_in
                counter.ccnt := counter.cend
            }.otherwise{
                io.valid_out := 0.U
                counter.ccnt := counter.ccnt-1.U
            }
            when(counter.ccnt===1.U){
                now_addr.inc()
            }
        }
        
        
    }

}