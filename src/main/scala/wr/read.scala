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
    val ToConv = Value(0.U)
    val ToMaxp = Value(1.U)
    val ToUps = Value(2.U)
}

class ReadJob(val addr_w: Int) extends Bundle{
    val begin_addr_big = new Address(addr_w.W)
    val begin_addr_small = Vec(4, new Address(addr_w.W))
    val begin_small_bank = UInt(2.W)
    val graph_size_big = UInt(addr_w.W)
    val graph_size_small = UInt(addr_w.W)
    val graph_num = UInt(addr_w.W)
    val type = ReadType()
}

class AutoReader(val w: Int, val addr_w: Int) extends Module{
    val io = IO(new Bundle{
        val flag_job = Input(Bool())
        val job_in = Input(new ReadJob(addr_w))
        val enable = Input(Bool())
        val valid_out = Output(Bool())
        val to_bigbank = Output(new Address(addr_w))
        val to_smallbank = Output(Vec(4, new Address(addr_w)))
        val to_weight = Output(new Address(addr_w))
        val from_bigbank = Input(new BigBankReadData(w))
        val from_smallbank = Input(Vec(4, new BigBankReadData(w)))
        val from_weight = Input(new WeightData(w))
        val to_nxt = Output(new PackedData(w))
    })

    
}