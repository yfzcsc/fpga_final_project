package final_project

import chisel3._
import chisel3.experimental.ChiselEnum


class GenAllPara(val addr_w: Int, val h_w: Int, val c_w: Int, val id_w: Int){
    var width = 0
    var height = 0
    var wr_width = 0
    var wr_height = 0
    var in_chan = 0
    var out_chan = 0
    var bank_id_big = Array[Int]()
    var bank_id_small = Array[Array[Int]]()
    var para_num = 0
    var mask = 0
    var big_begin_addr = 0
    var big_max_addr = 0
    var big_min_addr = 0
    var wr_big_begin_addr = 0
    var wr_big_max_addr = 0
    var wr_big_min_addr = 0
    var small_begin_addr = 0
    var small_max_addr = 0
    var small_min_addr = 0
    var wr_small_begin_addr = 0
    var wr_small_max_addr = 0
    var wr_small_min_addr = 0
    var weight_begin_addr = 0
    var bias_begin_addr = 0
    var quant_q_in = 0
    var quant_q_out = 0
    def set_conv_reader1(reader1: GraphReaderBundle): Bundle = {
        val (loop_num, loop_h) = (2*out_chan/para_num, 1)
        val begin_loop_num1 = out_chan/para_num
        reader1.flag_job := true.B
        reader1.job_type := ReadType.toConvOrCopy
        
        reader1.job := GenConvReadJob.gen(
            addr_w, h_w, c_w, id_w,
            loop_num, begin_loop_num1, loop_h,
            height/2, width, in_chan, 
            big_begin_addr, big_min_addr, big_max_addr,
            small_begin_addr, small_min_addr, small_max_addr,
            bank_id_big(0), bank_id_small(0)
        )

        return reader1
    }

    def set_conv_reader2(reader2: GraphReaderBundle): Bundle = {
        val (loop_num, loop_h) = (2*out_chan/para_num, 1)
        val begin_loop_num2 = 0

        reader2.flag_job := true.B
        reader2.job_type := ReadType.toConvOrCopy

        reader2.job := GenConvReadJob.gen(
            addr_w, h_w, c_w, id_w,
            loop_num, begin_loop_num2, loop_h,
            height/2, width, in_chan, 
            big_begin_addr, big_min_addr, big_max_addr,
            small_begin_addr, small_min_addr, small_max_addr,
            bank_id_big(1), bank_id_small(1)
        )

        return reader2
    }

    def set_copy_reader1(reader1: GraphReaderBundle, copy_cnt: Int): Bundle = {
        val (loop_num, loop_h) = (2, copy_cnt)
        val begin_loop_num1 = 1
        reader1.flag_job := true.B
        reader1.job_type := ReadType.toConvOrCopy
        
        reader1.job := GenConvReadJob.gen(
            addr_w, h_w, c_w, id_w,
            loop_num, begin_loop_num1, loop_h,
            height/2, width, in_chan, 
            big_begin_addr, big_min_addr, big_max_addr,
            small_begin_addr, small_min_addr, small_max_addr,
            bank_id_big(0), bank_id_small(0)
        )

        return reader1
    }

    def set_copy_reader2(reader2: GraphReaderBundle, copy_cnt: Int): Bundle = {
        val (loop_num, loop_h) = (2, copy_cnt)
        val begin_loop_num2 = 0

        reader2.flag_job := true.B
        reader2.job_type := ReadType.toConvOrCopy

        reader2.job := GenConvReadJob.gen(
            addr_w, h_w, c_w, id_w,
            loop_num, begin_loop_num2, loop_h,
            height/2, width, in_chan, 
            big_begin_addr, big_min_addr, big_max_addr,
            small_begin_addr, small_min_addr, small_max_addr,
            bank_id_big(1), bank_id_small(1)
        )

        return reader2
    }

    def set_maxp_reader1(reader1: GraphReaderBundle): Bundle = {
        reader1.flag_job := true.B
        reader1.job_type := ReadType.toMaxp
        val bank_id_small0 = Array[Int](bank_id_small(0)(3), bank_id_small(0)(2), bank_id_small(0)(1), bank_id_small(0)(0))
        
        reader1.job := GenMaxpReadJob.gen(
            addr_w, h_w, c_w, id_w,
            1, 1, 1,
            height/2, width, in_chan, 
            big_begin_addr, big_min_addr, big_max_addr,
            small_begin_addr, small_min_addr, small_max_addr,
            bank_id_big(0), bank_id_small0
        )

        return reader1
    }

    def set_maxp_reader2(reader2: GraphReaderBundle): Bundle = {

        reader2.flag_job := true.B
        reader2.job_type := ReadType.toMaxp
        val bank_id_small1 = Array[Int](bank_id_small(1)(3), bank_id_small(1)(2), bank_id_small(1)(1), bank_id_small(1)(0))
        
        reader2.job := GenMaxpReadJob.gen(
            addr_w, h_w, c_w, id_w,
            1, 1, 1,
            height/2, width, in_chan, 
            big_begin_addr, big_min_addr, big_max_addr,
            small_begin_addr, small_min_addr, small_max_addr,
            bank_id_big(1), bank_id_small1
        )

        return reader2
    }

    def set_read_weight(rw: WeightReaderBundle): Bundle = {
        rw.flag_job := true.B
        val weight_end_addr = weight_begin_addr+in_chan*out_chan/para_num-1
        rw.begin_addr := weight_begin_addr.U
        rw.addr_end := weight_end_addr.U
        return rw
    }

    def set_conv_read_pack(rp: PackReadDataBundle): Bundle = {
        rp.flag_job := true.B
        rp.job := GenPackJob.gen(addr_w, h_w, c_w, width-1, height-1, in_chan*out_chan/para_num-1)
        return rp
    }

    def set_copy_read_pack(rp: PackReadDataBundle): Bundle = {
        rp.flag_job := true.B
        rp.job := GenPackJob.gen(addr_w, h_w, c_w, width-1, height-1, in_chan-1)
        return rp
    }

    def set_conv_read_switch(rs: ReadSwitchBundle): Bundle = {
        rs.flag_job := true.B
        rs.job := ReadSwitchType.toConv
        return rs
    }

    def set_maxpool_switch(rs: ReadSwitchBundle): Bundle = {
        rs.flag_job := true.B
        rs.job := ReadSwitchType.toMaxp
        return rs
    }

    def set_copy_switch(rs: ReadSwitchBundle): Bundle = {
        rs.flag_job := true.B
        rs.job := ReadSwitchType.toCopy
        return rs
    }

    def set_conv_accu(ac: AccumuBundle): Bundle = {
        ac.flag_job := true.B
        ac.csum := (in_chan-1).U
        ac.is_in_use := true.B
        val bias_end_addr = bias_begin_addr+out_chan/para_num-1
        ac.bias_begin_addr := bias_begin_addr.U
        ac.bias_end_addr := bias_end_addr.U
        return ac
    }

    def set_unuse_accu(ac: AccumuBundle): Bundle = {
        ac.flag_job := true.B
        ac.is_in_use := false.B
        return ac
    }

    def set_quant(q: QuantBundle): Bundle = {
        q.flag_job := true.B
        q.quant_in.in_q := quant_q_in.U
        q.quant_in.out_q := quant_q_out.U
        return q
    }

    def set_write(wr: RealWriterBundle): Bundle = {
        wr.flag_job := true.B
        val al = 0
        val _min = (x: Int, y: Int) => (if(x>=y) y else x)
        val ar = out_chan-1
        val bank_id_small0 = Array[Int](bank_id_small(0)(1), bank_id_small(0)(2), bank_id_small(0)(3), bank_id_small(0)(0))
        val bank_id_small1 = Array[Int](bank_id_small(1)(1), bank_id_small(1)(2), bank_id_small(1)(3), bank_id_small(1)(0))
        wr.job.job(0) := GenWriteConvJob.gen(
            addr_w, h_w, c_w, id_w,
            wr_height/2, wr_width, out_chan, 
            wr_big_begin_addr, wr_big_min_addr, wr_big_max_addr,
            wr_small_begin_addr, wr_small_min_addr, wr_small_max_addr,
            bank_id_big(0), bank_id_small0, al, ar
        )
        wr.job.job(1) := GenWriteConvJob.gen(
            addr_w, h_w, c_w, id_w,
            wr_height/2, wr_width, out_chan, 
            wr_big_begin_addr, wr_big_min_addr, wr_big_max_addr,
            wr_small_begin_addr, wr_small_min_addr, wr_small_max_addr,
            bank_id_big(1), bank_id_small1, al, ar
        )
        wr.job.out_chan := (out_chan-1).U
        return wr
    }
}

object GenAllPara{
    def apply(
        addr_w: Int, 
        h_w: Int, 
        c_w: Int, 
        id_w: Int,
        width: Int,
        height: Int,
        wr_width: Int,
        wr_height: Int,
        in_chan: Int,
        out_chan: Int,
        para_num: Int,
        mask: Int,
        big_begin_addr: Int,
        big_max_addr: Int,
        big_min_addr: Int,
        wr_big_begin_addr: Int,
        wr_big_max_addr: Int,
        wr_big_min_addr: Int,
        small_begin_addr: Int,
        small_max_addr: Int,
        small_min_addr: Int,
        wr_small_begin_addr: Int,
        wr_small_max_addr: Int,
        wr_small_min_addr: Int,
        weight_begin_addr: Int,
        bias_begin_addr: Int,
        quant_q_in: Int,
        quant_q_out: Int
    ): GenAllPara = {
        val ret = new GenAllPara(addr_w, h_w, c_w, id_w)
        ret.width = width
        ret.height = height
        ret.wr_width = wr_width
        ret.wr_height = wr_height
        ret.in_chan = in_chan
        ret.out_chan = out_chan
        ret.bank_id_big = Array(0, 1)
        ret.bank_id_small = Array(Array(3, 0, 1, 2), Array(7, 4, 5, 6))
        ret.para_num = para_num
        ret.big_begin_addr = big_begin_addr
        ret.big_max_addr = big_max_addr
        ret.big_min_addr = big_min_addr
        ret.wr_big_begin_addr = wr_big_begin_addr
        ret.wr_big_max_addr = wr_big_max_addr
        ret.wr_big_min_addr = wr_big_min_addr
        ret.small_begin_addr = small_begin_addr
        ret.small_max_addr = small_max_addr
        ret.small_min_addr = small_min_addr
        ret.wr_small_begin_addr = wr_small_begin_addr
        ret.wr_small_max_addr = wr_small_max_addr
        ret.wr_small_min_addr = wr_small_min_addr
        ret.weight_begin_addr = weight_begin_addr
        ret.bias_begin_addr = bias_begin_addr
        ret.quant_q_in = quant_q_in
        ret.quant_q_out = quant_q_out
        ret.mask = mask
        return ret
    }
}

object StdPara{
    val w = 16
    val big_bank_w = 768
    val big_bank_addr_w = 10
    val small_bank_w = 128
    val small_bank_addr_w = 9
    val bias_w = 36
    val weight_w = 576
    val bias_addr_w = 7
    val weight_addr_w = 12
    val h_w = 16
    val addr_w = 10
    val c_w = 10
    val id_w = 3
    val para_num = 4
    val mask = 15
    val big_max_addr = 515
    val small_max_addr = 257

    val big_min_addr = 0
    val small_min_addr = 0
    val big_conv0_addr = 772
    val big_conv1_addr = 516
    val small_conv0_addr = 386
    val small_conv1_addr = 258
    val big_global_addr = 899
    val small_global_addr = 449
}