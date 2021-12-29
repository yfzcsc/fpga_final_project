package final_project

import chisel3._
import chisel3.util._

class BigBankReadData(val w: Int) extends Bundle{
    val data = Vec(48, SInt(w.W))
}

class SmallBankReadData(val w: Int) extends Bundle{
    val data = Vec(8, SInt(w.W))
}

class PackReadDataBundle(val w: Int, val h_w: Int, val c_w: Int, val big_w: Int) extends TransBundle{
    val job = Input(new PackJob(w, h_w, c_w, big_w))
    val from_big = Input(Vec(2, new BigBankReadData(w)))
    val from_small = Input(Vec(2, Vec(4, new SmallBankReadData(w))))
    val output = Output(new PackedData(w))
}

class PackReadData(val w: Int, val h_w: Int, val c_w: Int, val big_w: Int) extends Module{
    val io = IO(new PackReadDataBundle(w, h_w, c_w, big_w))
    val cache = RegInit(0.U.asTypeOf(Vec(2, Vec(64, Vec(10, SInt(w.W))))))

    val cnt_ic = RegInit(0.U.asTypeOf(ACounter(c_w.W)))
    val cnt_swap = RegInit(0.U.asTypeOf(ACounter(big_w.W)))
    val cnt_x = RegInit(0.U.asTypeOf(ACounter(h_w.W)))
    val cnt_y = RegInit(0.U.asTypeOf(ACounter(h_w.W)))

    val output_reg = Wire((new PackedData(w)))
    io.output := output_reg

    
    val state = RegInit(0.U(1.W))
    
    def copy64(): Unit = {
        for(i <- 0 to 7){
            for(j <- 1 to 6)
                output_reg.mat(i*8+j) := io.from_big(state).data(i*6+j-1)
            output_reg.mat(i*8+0) := io.from_small(state)(1).data(i)
            output_reg.mat(i*8+7) := io.from_small(state)(2).data(i)
        }
    }

    copy64()
    when(cnt_y.ccnt===0.U){
        for(i <- 2 to 7)
            output_reg.up(i) := io.from_big(state).data(6+i-2)
        output_reg.up(1) := io.from_small(state)(1).data(1)
        output_reg.up(8) := io.from_small(state)(2).data(1)
        when(cnt_x.ccnt===0.U){
            output_reg.up(0) := io.from_big(state).data(6)
        }.otherwise{
            output_reg.up(0) := io.from_small(state)(0).data(1)
        }
        when(cnt_x.ccnt===cnt_x.cend){
            output_reg.up(9) := io.from_big(state).data(6+5)
        }.otherwise{
            output_reg.up(9) := io.from_small(state)(3).data(1) 
        }
    }.otherwise{
        output_reg.up := cache(~state)(0)
    }

    var x = 1
    for(i <- 0 to 63){
        if(i==(1<<x)-1){
            val t = (1<<x)-1
            when(if(x==6) cnt_ic.cend(x-1) else ~cnt_ic.cend(x)&&cnt_ic.cend(x-1)){
                cache(~state)(t) := cache(~state)(0)
            }.otherwise{
                if(t<63)
                    cache(~state)(t) := cache(~state)(t+1)
            }
            x += 1
        }
    }
    x = 1
    for(i <- 0 to 63){
        if(i==(1<<x)-1){
            x += 1
        } else {
            for(j <- 0 to 1){
                cache(j)(i) := cache(j)(i+1)
            }
        }
    }
    
    when(cnt_y.ccnt===cnt_y.cend){
        for(i <- 2 to 7)
            output_reg.down(i) := io.from_big(state).data(48-12+i-2)
        output_reg.down(1) := io.from_small(state)(1).data(6)
        output_reg.down(8) := io.from_small(state)(2).data(6)
        when(cnt_x.ccnt===0.U){
            output_reg.down(0) := io.from_big(state).data(48-12)
        }.otherwise{
            output_reg.down(0) := io.from_small(state)(0).data(6)
        }
        when(cnt_x.ccnt===cnt_x.cend){
            output_reg.down(9) := io.from_big(state).data(48-12+5)
        }.otherwise{
            output_reg.down(9) := io.from_small(state)(3).data(6) 
        }
    }.otherwise{
        for(i <- 2 to 7)
            output_reg.down(i) := io.from_big(~state).data(i-2)
        output_reg.down(1) := io.from_small(~state)(1).data(0)
        output_reg.down(8) := io.from_small(~state)(2).data(0)
        when(cnt_x.ccnt===0.U){
            output_reg.down(0) := io.from_big(~state).data(0)
        }.otherwise{
            output_reg.down(0) := io.from_small(~state)(0).data(0)
        }
        when(cnt_x.ccnt===cnt_x.cend){
            output_reg.down(9) := io.from_big(~state).data(5)
        }.otherwise{
            output_reg.down(9) := io.from_small(~state)(3).data(0) 
        }
    }

    when(cnt_x.ccnt===0.U){
        for(i <- 0 to 7)
            output_reg.left(i) := io.from_big(state).data(i*6)
    }.otherwise{
        output_reg.left := io.from_small(state)(0).data
    }
    when(cnt_x.ccnt===cnt_x.cend){
        for(i <- 0 to 7)
            output_reg.right(i) := io.from_big(state).data(i*6+5)
    }.otherwise{
        output_reg.right := io.from_small(state)(3).data
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
    x = 1
    for(i <- 0 to 63){
        if(i==(1<<x)-1){
            val t = (1<<x)-1
            when(if(x==6) cnt_ic.cend(x-1) else ~cnt_ic.cend(x)&&cnt_ic.cend(x-1)){
                cache(state)(t) := nxt_up
            }.otherwise{
                if(t<63)
                    cache(state)(t) := cache(state)(t+1)
            }
            x += 1
        }
    }
    io.valid_out := io.valid_in
    when(io.flag_job){
        cnt_x.set(io.job.cnt_x_end)
        cnt_y.set(io.job.cnt_y_end)
        cnt_ic.set(io.job.in_chan)
        cnt_swap.set(io.job.cnt_swap_end)
        state := 0.U
    }.elsewhen(io.valid_in){
        cnt_ic.inc()
        when(cnt_swap.inc()){
            state := ~state
            when(cnt_y.inc()){
                cnt_x.inc()
            }
        }
        
    }
}