package final_project

import chisel3._
import chisel3.util._

class BigBankReadData(val w: Int, val addr_w: Int) extends Bundle{
    val data = Vec(48, SInt(w.W))
}

class SmallBankReadData(val w: Int, val addr_w: Int) extends Bundle{
    val data = Vec(8, SInt(w.W))
}

object ReadType extends ChiselEnum{
    val ToConv = Value(0.U)         // Sigmoid, conv, mult
    val ToMaxp = Value(1.U)         // Maxpool
    val ToUps = Value(2.U)          // Upsample
}

class ReadJob(val addr_w: Int, val h_w: Int, val c_w: Int) extends Bundle{
    val begin_addr = UInt(addr_w.W)
    val max_addr = UInt(addr_w.W)
    val min_addr = UInt(addr_w.W)
    val h = UInt(h_w.W)
    val w = UInt(h_w.W)
    val loop_num = UInt(c_w.W)
    val block_size = UInt(c_w.W)
}

class GraphReader(val w: Int, val addr_w: Int, val num: Int, val h_w: Int, val c_w: Int) extends Module{
    val io = IO(new Bundle{
        val flag_job = Input(Bool())
        val big_job_in = Input(Vec(2, new ReadJob(addr_w, h_w, c_w)))
        val small_job_in = Input(Vec(8, new ReadJob(addr_w, h_w, c_w)))
        val enable = Input(Bool())
        val valid_out = Output(Bool())
        val to_bigbank = Output(new Address(addr_w))
        val to_smallbank = Output(Vec(4, new Address(addr_w)))
        val from_bigbank = Input(new BigBankReadData(w))
        val from_smallbank = Input(Vec(4, new BigBankReadData(w)))
        val to_nxt = Output(Vec(num, new PackedData(w)))
    })

    val job = RegInit(Reg(new ReadJob(addr_w)))
    val cache = RegInit(Reg(Vec(10, SInt(w.W))))

    // val gen = RegInit(Reg(Vec(2, ReadBigBank())))

    when(flag_job){
        // gen := ReadBigBank(big_job_in)

    }.otherwise{
        switch(job.job_type){
            is(ReadType.ToConv){
                // (0, 0) --> 
            }
            is(ReadType.ToMaxp){

            }
            is(ReadType.ToUps){

            }
        }
    }
    
}