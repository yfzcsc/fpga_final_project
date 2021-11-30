package final_project

import chisel3._
import chisel3.util._

class BigBankReadData(val w: Int) extends Bundle{
    val data = Vec(48, SInt(w.W))
}

class SmallBankReadData(val w: Int) extends Bundle{
    val data = Vec(8, SInt(w.W))
}

class PackReadData(val w: Int) extends Module{
    val io = IO(new Bundle{
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
        val from_big0 = Input(new BigBankReadData(w))
        val from_small0 = Input(new SmallBankReadData(w))
        val from_big1 = Input(new BigBankReadData(w))
        val from_small1 = Input(new SmallBankReadData(w))
        val output = Output(new PackedData(w))
    })
    val valid = RegNext(valid_out, 0.U)
    val state = RegInit(Reg(UInt(1.W)))
    valid_out := false.B
    output := 0.U.asTypeOf(output)
    when(valid){
        valid_out := true.B
        state := ~state
        
    }
}