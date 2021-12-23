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

class RCounter(val w: chisel3.internal.firrtl.Width) extends Bundle{
    val ccnt = UInt(w)
    val cr = UInt(w)
    val cl = UInt(w)
    def inc(): Bool = {
        val nxt = Wire(Bool())
        nxt := ccnt===cr
        ccnt := Mux(nxt, cl, ccnt+1.U)
        return nxt
    }
    def set(r: UInt): Unit = {
        cr := r
        cl := 0.U
        ccnt := 0.U
    }
    def set(l: UInt, r: UInt): Unit = {
        cr := r
        cl := l
        ccnt := l
    }
}

object RCounter{
    def apply(w: Int) = new RCounter(w.W)
    def apply(w: chisel3.internal.firrtl.Width) = new RCounter(w)
}