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
    val now_addr = RegInit(0.U.asTypeOf(RCounter(addr_w)))
    val enable = RegInit(false.B)
    val valid_out_reg = RegInit(0.U(para_num.W))

    io.result := 0.U.asTypeOf(Vec(para_num, new AccumuRawData(w)))
    io.valid_out := 0.U
    io.bias_addr := now_addr.ccnt

    val b64 = Wire(Vec(para_num, new AccumuRawData(w)))
    val r64 = RegInit(0.U.asTypeOf(Vec(para_num, new AccumuRawData(w))))
    when(counter.ccnt===counter.cend){
        for(t <- 0 to para_num-1)
            for(i <- 0 to 63){
                b64(t).mat(i) := io.bias_in(t)
            }
    }.otherwise{
        b64 := r64
    }
    
    io.result := r64
    when(io.flag_job){
        counter.set(io.csum, io.csum)
        now_addr.set(io.bias_begin_addr, io.bias_end_addr)
        r64 := 0.U.asTypeOf(r64)
        enable := io.is_in_use
        valid_out_reg := 0.U
    }.elsewhen(enable){
        
        io.valid_out := valid_out_reg
        when(io.valid_in.orR){
            for(t <- 0 to para_num-1)
                for(i <- 0 to 63){
                    r64(t).mat(i) := io.in_from_calc8x8(t).mat(i)+b64(t).mat(i)
                }
            
            when(counter.ccnt===counter.cend){
                valid_out_reg := 0.U
                counter.ccnt := counter.ccnt-1.U
            }.elsewhen(counter.ccnt===0.U){
                valid_out_reg := io.valid_in
                counter.ccnt := counter.cend
            }.otherwise{
                valid_out_reg := 0.U
                counter.ccnt := counter.ccnt-1.U
            }
            when(counter.ccnt===1.U){
                now_addr.inc()
            }
        }.otherwise{        
            valid_out_reg := 0.U
        }
    }.otherwise{
        io.result(0) := io.in_from_calc8x8(0)
        io.valid_out := io.valid_in
    }

}