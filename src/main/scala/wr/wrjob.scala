package final_project

import chisel3._
import chisel3.util._

class WRJob(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends Bundle{
    val begin_addr = UInt(addr_w.W)
    val max_addr = UInt(addr_w.W)
    val min_addr = UInt(addr_w.W)
    val cnt_end = UInt(h_w.W)
    val block_num = UInt(c_w.W)
    val bank_id = UInt(id_w.W)
    val dist_nxt_width = UInt(h_w.W)
}

class WriteBigJob(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends WRJob(addr_w, h_w, c_w, id_w){
    val al = UInt(c_w.W)
    val ar = UInt(c_w.W)
}

class WriteSmallJob(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends WRJob(addr_w, h_w, c_w, id_w){
    val al = UInt(c_w.W)
    val ar = UInt(c_w.W)
    val ano_bank_id = UInt(id_w.W)
}

class ReadBigJob(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends WRJob(addr_w, h_w, c_w, id_w){
    val loop_num = UInt(c_w.W)
    val cnt_h = UInt(h_w.W)
}

class ReadSmallJob(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends WRJob(addr_w, h_w, c_w, id_w){
    val loop_num = UInt(c_w.W)
    val ano_bank_id = UInt(id_w.W)
    val validL = UInt(h_w.W)
}

class ReadJobs(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends Bundle{
    val big = Vec(2, new ReadBigJob(addr_w, h_w, c_w, id_w))
    val small = Vec(2, Vec(4, new ReadSmallJob(addr_w, h_w, c_w, id_w)))
}

class WriteJobs(addr_w: Int, h_w: Int, c_w: Int, id_w: Int) extends Bundle{
    val big = new ReadBigJob(addr_w, h_w, c_w, id_w)
    val small = Vec(2, new ReadSmallJob(addr_w, h_w, c_w, id_w))
}