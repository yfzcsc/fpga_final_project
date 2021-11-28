package final_project

import chisel3._
import chisel3.util._

class BigBankWriteData(val w: Int, val addr_w: Int) extends Bundle{
    val data = Vec(48, SInt(w.W))
    val addr = UInt(addr_w.W)
    val wra = Bool()
}

class SmallBankWriteData(val w: Int, val addr_w: Int) extends Bundle{
    val data = Vec(8, SInt(w.W))
    val addr = UInt(addr_w.W)
    val wra = Bool()
}


// 2*18K (4 banks) and 22*18K (1 bank)

class Writer(val w: Int, val addr_w: Int) extends Module{
    val io = IO(new Bundle{
        val in_from_quant = Input(new QuantedData(w))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
        val flag_job = Input(Bool())
        val begin_addr_in = Input(UInt(addr_w.W))
        val begin_small_bank_in = Input(UInt(2.W))
        val to_bigbank = Output(new BigBankWriteData(w, addr_w))
        val to_smallbank = Output(Vec(4, new SmallBankWriteData(w, addr_w)))
    })

    val addr = RegInit(0.U(addr_w.W))
    val small_bank = RegInit(0.U(2.W))

    io.valid_out := false.B
    io.to_bigbank.wra := false.B
    for(i <- 0 to 3)
        io.to_smallbank(i).wra := false.B
    when(io.flag_job){
        addr := io.begin_addr_in
        small_bank := io.begin_small_bank_in
    }.otherwise{
        when(io.valid_in){
            io.valid_out := true.B
            io.to_bigbank.wra := true.B
            io.to_smallbank(small_bank).wra := true.B
            io.to_smallbank(small_bank+1.U).wra := true.B
            for(i <- 0 to 7)
                for(j <- 0 to 5)
                    io.to_bigbank.data(i*6+j) := io.in_from_quant.mat(i*8+(j+1))
            for(i <- 0 to 7)
                io.to_smallbank.data(small_bank) := io.in_from_quant.mat(i*8)
            for(i <- 0 to 7)
                io.to_smallbank.data(small_bank+1.U) := io.in_from_quant.mat(i*8+7)
            small_bank := small_bank+2.U
        }
    }
}

class CachedWriter extends Module{
    
}