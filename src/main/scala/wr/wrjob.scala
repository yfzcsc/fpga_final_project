package final_project

import chisel3._
import chisel3.util._

class WRJob(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends Bundle{
    val begin_addr = UInt(addr_w.W)
    val max_addr = UInt(addr_w.W)
    val min_addr = UInt(addr_w.W)
    val bank_id = UInt(id_w.W)
    val block_size = UInt(addr_w.W)
    val column_size = UInt(addr_w.W)
    val cnt_x_end = UInt(h_w.W)
    val cnt_y_end = UInt(h_w.W)
    val cnt_ic_end = UInt(c_w.W)
}

class WriteBigJob(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends WRJob(addr_w, h_w, c_w, id_w){
    val a = UInt(c_w.W)
}

class WriteSmallJob(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends WRJob(addr_w, h_w, c_w, id_w){
    val a = UInt(c_w.W)
    val ano_bank_id = UInt(id_w.W)
}

class ReadBigJob(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends WRJob(addr_w, h_w, c_w, id_w){
    val cnt_loop_end = UInt((2*c_w).W)
    val begin_loop = UInt((2*c_w).W)
    val cnt_ups_end = UInt(1.W)
}

class ReadSmallJob(addr_w: Int, h_w: Int, c_w: Int, id_w: Int, big_w: Int) extends WRJob(addr_w, h_w, c_w, id_w){
    val ano_bank_id = UInt(id_w.W)
    val cnt_loop_end = UInt((2*c_w).W)
    val begin_loop = UInt((2*c_w).W)
    val cnt_invalid_end = UInt(big_w.W)
    val cnt_ups_end = UInt(1.W)
    val begin_swap = UInt(1.W)
}

class ReadJobs(addr_w: Int, h_w: Int, c_w: Int, id_w: Int, big_w: Int) extends Bundle{
    val big = new ReadBigJob(addr_w, h_w, c_w, id_w)
    val small = Vec(4, new ReadSmallJob(addr_w, h_w, c_w, id_w, big_w))
}

class WriteJobs(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends Bundle{
    val big = new WriteBigJob(addr_w, h_w, c_w, id_w)
    val small = Vec(2, new WriteSmallJob(addr_w, h_w, c_w, id_w))
}

class RealWriteJobs(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends Bundle{
    val job = Vec(2, new WriteJobs(addr_w, h_w, c_w, id_w))
    val out_chan = UInt(c_w.W)
}

object GenConvReadJob{
    def gen(addr_w: Int, h_w: Int, c_w: Int, id_w: Int, big_w: Int, loop_num: Int, begin_loop_num: Int, loop_h: Int, 
            h: Int, w: Int, in_chan: Int, begin_addr: Int, min_addr: Int, max_addr: Int,
            small_begin_addr: Int, small_min_addr: Int, small_max_addr: Int, 
            bank_id_big: Int, bank_id_small: Array[Int]): ReadJobs = {
        val ret = Wire(new ReadJobs(addr_w, h_w, c_w, id_w, big_w))
        ret.big.begin_addr := begin_addr.U
        ret.big.min_addr := min_addr.U
        ret.big.max_addr := max_addr.U
        ret.big.bank_id := bank_id_big.U
        ret.big.block_size := in_chan.U
        ret.big.column_size := (in_chan*h).U
        ret.big.cnt_x_end := (w-1).U
        ret.big.cnt_y_end := (h-1).U
        ret.big.cnt_ic_end := (in_chan-1).U
        ret.big.cnt_loop_end := (loop_num-1).U
        ret.big.cnt_ups_end := (loop_h-1).U
        ret.big.begin_loop := begin_loop_num.U
        for(i <- 0 to 3){
            ret.small(i).begin_addr := small_begin_addr.U
            ret.small(i).min_addr := small_min_addr.U
            ret.small(i).max_addr := small_max_addr.U
            ret.small(i).block_size := in_chan.U
            ret.small(i).column_size := (in_chan*h).U
            ret.small(i).cnt_x_end := (w/2-1).U
            ret.small(i).cnt_y_end := (h-1).U
            ret.small(i).cnt_ic_end := (in_chan-1).U
            ret.small(i).cnt_loop_end := (loop_num-1).U
            ret.small(i).cnt_invalid_end := (if(i==0) (loop_num*in_chan*h*loop_h).U else 0.U)
            ret.small(i).cnt_ups_end := (loop_h-1).U
            ret.small(i).begin_loop := begin_loop_num.U
            if(i==0){
                ret.small(i).bank_id := bank_id_small(2).U
                ret.small(i).ano_bank_id := bank_id_small(0).U   
            } else {
                ret.small(i).bank_id := bank_id_small(i).U
                ret.small(i).ano_bank_id := bank_id_small(i^2).U    
            }
            if(i==3){
                ret.small(i).begin_swap := (1).U
            } else {
                ret.small(i).begin_swap := 0.U
            }
            
        }
        return ret
    }
}

object GenMaxpReadJob{
    def gen(addr_w: Int, h_w: Int, c_w: Int, id_w: Int, big_w: Int, loop_num: Int, begin_loop_num: Int, loop_h: Int, 
            h: Int, w: Int, in_chan: Int, begin_addr: Int, min_addr: Int, max_addr: Int,
            small_begin_addr: Int, small_min_addr: Int, small_max_addr: Int, 
            bank_id_big: Int, bank_id_small: Array[Int]): ReadJobs = {
        val ret = Wire(new ReadJobs(addr_w, h_w, c_w, id_w, big_w))
        ret := 0.U.asTypeOf(new ReadJobs(addr_w, h_w, c_w, id_w, big_w))
        ret.big.begin_addr := begin_addr.U
        ret.big.min_addr := min_addr.U
        ret.big.max_addr := max_addr.U
        ret.big.bank_id := bank_id_big.U
        ret.big.block_size := in_chan.U
        ret.big.column_size := (in_chan*h).U
        ret.big.cnt_x_end := (w/2-1).U
        ret.big.cnt_y_end := (h-1).U
        ret.big.cnt_ic_end := (in_chan-1).U
        for(i <- 0 to 1){
            ret.small(i).begin_addr := small_begin_addr.U
            ret.small(i).min_addr := small_min_addr.U
            ret.small(i).max_addr := small_max_addr.U
            if(i==0){
                ret.small(i).bank_id := bank_id_small(2).U
                ret.small(i).ano_bank_id := bank_id_small(0).U   
            } else {
                ret.small(i).bank_id := bank_id_small(i).U
                ret.small(i).ano_bank_id := bank_id_small(i^2).U    
            }
            
        }
        return ret
    }
}


object GenWriteConvJob{
    def gen(addr_w: Int, h_w: Int, c_w: Int, id_w: Int, 
            h: Int, w: Int, out_chan: Int, begin_addr: Int, min_addr: Int, max_addr: Int,
            small_begin_addr: Int, small_min_addr: Int, small_max_addr: Int, 
            bank_id_big: Int, bank_id_small: Array[Int], al: Int, ar: Int): WriteJobs = {
        val ret = Wire(new WriteJobs(addr_w, h_w, c_w, id_w))
        ret.big.begin_addr := begin_addr.U
        ret.big.min_addr := min_addr.U
        ret.big.max_addr := max_addr.U
        ret.big.bank_id := bank_id_big.U
        ret.big.block_size := out_chan.U
        ret.big.column_size := (out_chan*h).U
        ret.big.cnt_x_end := (w-1).U
        ret.big.cnt_y_end := (h-1).U
        ret.big.cnt_ic_end := (ar-al).U
        ret.big.a := (out_chan-ar+al).U
        for(i <- 0 to 1){
            ret.small(i).begin_addr := small_begin_addr.U
            ret.small(i).min_addr := small_min_addr.U
            ret.small(i).max_addr := small_max_addr.U
            ret.small(i).block_size := out_chan.U
            ret.small(i).column_size := (out_chan*h).U
            ret.small(i).cnt_x_end := (w/2-1).U
            ret.small(i).cnt_y_end := (h-1).U
            ret.small(i).cnt_ic_end := (ar-al).U
            ret.small(i).a := (out_chan-ar+al).U
            ret.small(i).bank_id := bank_id_small(i).U
            ret.small(i).ano_bank_id := bank_id_small(i+2).U
        }
        return ret            
    }
}


class PackJob(addr_w: Int, h_w: Int, c_w: Int, big_w: Int) extends Bundle{
    val cnt_x_end = UInt(h_w.W)
    val cnt_y_end = UInt(h_w.W)
    val in_chan = UInt(c_w.W)
    val cnt_swap_end = UInt(big_w.W)
}

object GenPackJob{
    def gen(addr_w: Int, h_w: Int, c_w: Int, big_w: Int, cnt_x_end: Int, cnt_y_end: Int, cnt_swap_end: Int, in_chan: Int): PackJob = {
        val ret = Wire(new PackJob(addr_w, h_w, c_w, big_w))
        ret.cnt_x_end := cnt_x_end.U
        ret.cnt_y_end := cnt_y_end.U
        ret.in_chan := in_chan.U
        ret.cnt_swap_end := cnt_swap_end.U
        return ret
    }
}