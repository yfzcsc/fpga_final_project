package final_project

import chisel3._
import chisel3.experimental.ChiselEnum

class TransBundle extends Bundle{
    val valid_in = Input(Bool())
    val valid_out = Output(Bool())
    val flag_job = Input(Bool())
}

class ACounter(val w: chisel3.internal.firrtl.Width) extends Bundle{
    val ccnt = UInt(w)
    val cend = UInt(w)
    def inc(): Bool = {
        val nxt = Wire(Bool())
        nxt := ccnt===cend
        ccnt := Mux(nxt, 0.U, ccnt+1.U)
        return nxt
    }
    def set(csum: UInt): Unit = {
        cend := csum
        ccnt := 0.U
    }
    def set(begin: UInt, csum: UInt): Unit = {
        cend := csum
        ccnt := begin
    }
    def clr(): Unit = {
        ccnt := 0.U
        cend := 0.U
    }
}

object ACounter{
    def apply(w: Int) = new ACounter(w.W)
    def apply(w: chisel3.internal.firrtl.Width) = new ACounter(w)
}