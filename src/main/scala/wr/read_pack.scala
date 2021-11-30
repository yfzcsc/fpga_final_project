package final_project

import chisel3._
import chisel3.util._

class BigBankReadData(val w: Int) extends Bundle{
    val data = Vec(48, SInt(w.W))
}

class SmallBankReadData(val w: Int) extends Bundle{
    val data = Vec(8, SInt(w.W))
}

class PackReadData(val w: Int, val h_w: Int) extends Module{
    val io = IO(new Bundle{
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
        val flag_job = Input(Bool())
        val height_in = Input(UInt(h_w.W))          // H-1
        val from_big0 = Input(new BigBankReadData(w))
        val from_small0 = Input(new SmallBankReadData(w))
        val from_big1 = Input(new BigBankReadData(w))
        val from_small1 = Input(new SmallBankReadData(w))
        val output = Output(new PackedData(w))
    })
    val state = RegInit(Reg(UInt(h_w.W)))
    val height = RegInit(Reg(UInt(h_w.W)))
    val cache = RegInit(Reg(Vec(10, SInt(w.W))))

    io.valid_out := false.B
    io.output := 0.U.asTypeOf(output)
    when(io.flag_job){
        height := io.height_in
    }
    def copy64_left_right(flag: Int): Unit = {
        if(flag==0){
            for(i <- 0 to 7){
                for(j <- 1 to 6)
                    io.output.mat(i*8+j) := io.from_big0.data(i*6+(j-1))
                io.output.mat(i*8+0) := io.from_small0(1).data(i)
                io.output.mat(i*8+7) := io.from_small0(2).data(i)
            }
            io.output.left := io.from_small0(0)
            io.output.right := io.from_small0(3)
        } else {
            for(i <- 0 to 7){
                for(j <- 1 to 6)
                    io.output.mat(i*8+j) := io.from_big1.data(i*6+(j-1))
                io.output.mat(i*8+0) := io.from_small1(1).data(i)
                io.output.mat(i*8+7) := io.from_small1(2).data(i)
            }
            io.output.left := io.from_small1(0)
            io.output.right := io.from_small1(3)
        }
    }
    def copyup(flag: Int): Unit = {
        if(flag==-1){
            for(i <- 2 to 7)
                io.output.up(i) := io.from_big0.data(6+i-1)
            io.output.up(0) := io.from_small0(0).data(1)
            io.output.up(1) := io.from_small0(1).data(1)
            io.output.up(8) := io.from_small0(2).data(1)
            io.output.up(9) := io.from_small0(3).data(1)
        }else {
            io.output.up := cache
        }
    }

    def save_cache(flag: Int): UInt = {
        if(flag==0){
            for(i <- 2 to 7)
                cache(i) := io.from_big0.data(48-6+i-2)
            cache(0) := io.from_small0(0).data(7)
            cache(1) := io.from_small0(1).data(7)
            cache(8) := io.from_small0(2).data(7)
            cache(9) := io.from_small0(3).data(7)    
        }else{
            for(i <- 2 to 7)
                cache(i) := io.from_big1.data(48-6+i-2)
            cache(0) := io.from_small1(0).data(7)
            cache(1) := io.from_small1(1).data(7)
            cache(8) := io.from_small1(2).data(7)
            cache(9) := io.from_small1(3).data(7)  
        }
        
    }

    def copydown(flag: Int): UInt = {
        if(flag==-1){
            for(i <- 2 to 7)
                io.output.down(i) := io.from_big0.data(48-12+i-2)
            io.output.down(0) := io.from_small0(0).data(6)
            io.output.down(1) := io.from_small0(1).data(6)
            io.output.down(8) := io.from_small0(2).data(6)
            io.output.down(9) := io.from_small0(3).data(6)
        }else if(flag==0){
            for(i <- 2 to 7)
                io.output.down(i) := io.from_big1.data(i-2)
            io.output.down(0) := io.from_small1(0).data(0)
            io.output.down(1) := io.from_small1(1).data(0)
            io.output.down(8) := io.from_small1(2).data(0)
            io.output.down(9) := io.from_small1(3).data(0)
        }else if(flag==1){
            for(i <- 2 to 7)
                io.output.down(i) := io.from_big0.data(i-2)
            io.output.down(0) := io.from_small0(0).data(0)
            io.output.down(1) := io.from_small0(1).data(0)
            io.output.down(8) := io.from_small0(2).data(0)
            io.output.down(9) := io.from_small0(3).data(0)
        }
    }
    when(io.valid_in){
        io.valid_out := true.B
        state := Mux(state===height, 0.U, state+1.U)
        when(state===0.U){
            copy64_left_right(0)
            copyup(-1)
            copydown(0)
        }.elsewhen(state===height){
            copy64_left_right(1)
            copyup(0)
            copydown(-1)
        }.otherwise{
            when(state(0)){
                copy64_left_right(1)
                copyup(1)
                copydown(1)
            }.otherwise{
                copy64_left_right(0)
                copyup(0)
                copydown(0)
            }
        }
        when(state(0)){
            save_cache(1)
        }.otherwise{
            save_cache(0)
        }
    }
}