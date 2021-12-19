package final_project

import chisel3._
import chisel3.util._

class BigBankReadData(val w: Int) extends Bundle{
    val data = Vec(48, SInt(w.W))
}

class SmallBankReadData(val w: Int) extends Bundle{
    val data = Vec(8, SInt(w.W))
}

class PackReadDataBundle(val w: Int, val h_w: Int, val c_w: Int) extends TransBundle{
    val job = Input(new PackJob(w, h_w, c_w))
    val from_big = Input(Vec(2, new BigBankReadData(w)))
    val from_small = Input(Vec(2, Vec(4, new SmallBankReadData(w))))
    val output = Output(new PackedData(w))
}

class PackReadData(val w: Int, val h_w: Int, val c_w: Int) extends Module{
    val io = IO(new PackReadDataBundle(w, h_w, c_w))
    val cache = RegInit(0.U.asTypeOf(Vec(64, Vec(10, SInt(w.W)))))

    val cnt_ic = RegInit(0.U.asTypeOf(ACounter(c_w.W)))
    val cnt_x = RegInit(0.U.asTypeOf(ACounter(h_w.W)))
    val cnt_y = RegInit(0.U.asTypeOf(ACounter(h_w.W)))

    io.valid_out := false.B
    io.output := 0.U.asTypeOf(io.output)

    
    val state = RegInit(0.U(1.W))
    
    def copy64(): Unit = {
        for(i <- 0 to 7){
            for(j <- 1 to 6)
                io.output.mat(i*8+j) := io.from_big(state).data(i*6+j-1)
            io.output.mat(i*8+0) := io.from_small(state)(1).data(i)
            io.output.mat(i*8+7) := io.from_small(state)(2).data(i)
        }
    }

    copy64()
    when(cnt_y.ccnt===0.U){
        for(i <- 2 to 7)
            io.output.up(i) := io.from_big(state).data(6+i-2)
        io.output.up(1) := io.from_small(state)(1).data(1)
        io.output.up(8) := io.from_small(state)(2).data(1)
        when(cnt_x.ccnt===0.U){
            io.output.up(0) := io.from_big(state).data(6)
        }.otherwise{
            io.output.up(0) := io.from_small(state)(0).data(1)
        }
        when(cnt_x.ccnt===cnt_x.cend){
            io.output.up(9) := io.from_big(state).data(6+5)
        }.otherwise{
            io.output.up(9) := io.from_small(state)(3).data(1) 
        }
    }.otherwise{
        io.output.up := cache(cnt_ic.ccnt)
    }
    
    when(cnt_y.ccnt===cnt_y.cend){
        for(i <- 2 to 7)
            io.output.down(i) := io.from_big(state).data(48-12+i-2)
        io.output.down(1) := io.from_small(state)(1).data(6)
        io.output.down(8) := io.from_small(state)(2).data(6)
        when(cnt_x.ccnt===0.U){
            io.output.down(0) := io.from_big(state).data(48-12)
        }.otherwise{
            io.output.down(0) := io.from_small(state)(0).data(6)
        }
        when(cnt_x.ccnt===cnt_x.cend){
            io.output.down(9) := io.from_big(state).data(48-12+5)
        }.otherwise{
            io.output.down(9) := io.from_small(state)(3).data(6) 
        }
    }.otherwise{
        for(i <- 2 to 7)
            io.output.down(i) := io.from_big(~state).data(i-2)
        io.output.down(1) := io.from_small(~state)(1).data(0)
        io.output.down(8) := io.from_small(~state)(2).data(0)
        when(cnt_x.ccnt===0.U){
            io.output.down(0) := io.from_big(~state).data(0)
        }.otherwise{
            io.output.down(0) := io.from_small(~state)(0).data(0)
        }
        when(cnt_x.ccnt===cnt_x.cend){
            io.output.down(9) := io.from_big(~state).data(5)
        }.otherwise{
            io.output.down(9) := io.from_small(~state)(3).data(0) 
        }
    }

    when(cnt_x.ccnt===0.U){
        for(i <- 0 to 7)
            io.output.left(i) := io.from_big(state).data(i*6)
    }.otherwise{
        io.output.left := io.from_small(state)(0).data
    }
    when(cnt_x.ccnt===cnt_x.cend){
        for(i <- 0 to 7)
            io.output.right(i) := io.from_big(state).data(i*6+5)
    }.otherwise{
        io.output.right := io.from_small(state)(3).data
    }

    val nxt_up = Wire(Vec(10, SInt(w.W)))
    for(i <- 2 to 7)
        nxt_up(i) := io.from_big(state).data(48-6+i-2)
    nxt_up(1) := io.from_small(state)(1).data(7)
    nxt_up(8) := io.from_small(state)(2).data(7)
    when(cnt_x.ccnt===0.U){
        nxt_up(0) := io.from_big(state).data(48-6)
    }.otherwise{
        nxt_up(0) := io.from_small(state)(0).data(7)
    }
    when(cnt_x.ccnt===cnt_x.cend){
        nxt_up(9) := io.from_big(state).data(48-6+5)
    }.otherwise{
        nxt_up(9) := io.from_small(state)(3).data(7) 
    }
    cache(cnt_ic.ccnt) := nxt_up

    when(io.flag_job){
        cnt_x.set(io.job.cnt_x_end)
        cnt_y.set(io.job.cnt_y_end)
        cnt_ic.set(io.job.in_chan)
        state := 0.U
    }.elsewhen(io.valid_in){
        io.valid_out := true.B
        when(cnt_ic.inc()){
            state := ~state
            when(cnt_y.inc()){
                cnt_x.inc()
            }
        }
    }
}