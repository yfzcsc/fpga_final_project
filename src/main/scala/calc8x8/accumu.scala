package final_project

import chisel3._
import chisel3.util._
import chisel3.util.HasBlackBoxInline

class AccumuRawData(val w: Int) extends Bundle{
    val mat = Vec(64, SInt((w*2+10).W))
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

    val r64 = RegInit(0.U.asTypeOf(Vec(para_num, new AccumuRawData(w))))
    
    for(t <- 0 to para_num-1)
        for(i <- 0 to 63){
            val adder = Module(new DSP48Adder).io
            adder.a := io.in_from_calc8x8(t).mat(i)
            adder.b := r64(t).mat(i)
            adder.t := io.bias_in(t)
            adder.flag := counter.ccnt===counter.cend
            when(io.valid_in(0)){
                r64(t).mat(i) := adder.c
            }
        }
    io.result := r64
    when(io.flag_job){
        counter.set(io.csum, io.csum)
        now_addr.set(io.bias_begin_addr, io.bias_end_addr)
        r64 := 0.U.asTypeOf(r64)
        enable := io.is_in_use
        valid_out_reg := 0.U
    }.elsewhen(enable){
        when(io.valid_in(0)){
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
        io.valid_out := valid_out_reg
    }.otherwise{
        io.result(0) := io.in_from_calc8x8(0)
        io.valid_out := io.valid_in
    }

}

class DSP48Adder extends BlackBox with HasBlackBoxInline{
    val io = IO(new Bundle{
        val a = Input(SInt(36.W))
        val t = Input(SInt(36.W))
        val flag = Input(Bool())
        val b = Input(SInt(42.W))
        val c = Output(SInt(42.W))
    })
    setInline(
        "BlackBoxAdder3642.v",
        """(*use_dsp="yes"*)
        |module DSP48Adder(
        |    input[35:0] a,
        |    input[35:0] t,
        |    input flag,
        |    input[41:0] b,
        |    output[41:0] c
        |);
        |wire[41:0] x;
        |assign x = flag? {{6{t[35]}}, t}: b;
        |assign c = x + $signed({{6{a[35]}}, a});
        |endmodule
        """.stripMargin)
}