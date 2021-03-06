package final_project

import chisel3._
import chisel3.util._

import chisel3.experimental.BundleLiterals._

class Top extends Module{
    //val io = IO(new)
    val io = IO(new Bundle{
        val start = Input(Bool())
        val input = Input(SInt(16.W))
        val complete = Output(Bool())
        val valid = Output(Bool())
        val complete_output = Output(Bool())
        // val output = Output(UInt(1.W))
        val output = Output(SInt(16.W))
        val checksum = Output(UInt(16.W))
    })

    val reader1 = Module(new GraphReader(StdPara.addr_w, StdPara.h_w, StdPara.c_w, StdPara.id_w, StdPara.big_w)).io
    val reader2 = Module(new GraphReader(StdPara.addr_w, StdPara.h_w, StdPara.c_w, StdPara.id_w, StdPara.big_w)).io
    val read_pack = Module(new PackReadData(StdPara.w, StdPara.h_w, StdPara.c_w, StdPara.big_w)).io
    val read_switch = Module(new ReadSwitch(StdPara.w, StdPara.h_w, StdPara.c_w, StdPara.para_num)).io
    val read_weight = Module(new WeightReader(StdPara.w, StdPara.weight_addr_w)).io
    val calc8x8 = Module(new Calc8x8(StdPara.w, StdPara.para_num)).io
    val accu = Module(new Accumu(StdPara.w, StdPara.bias_addr_w, StdPara.bias_w, StdPara.para_num)).io

    val cache_writer = Module(new CacheWriter(StdPara.w, StdPara.para_num)).io
    val quant = Module(new Quant(StdPara.w)).io
    val write_switch = Module(new WriteSwitch(StdPara.w, 3)).io
    val writer = Module(new RealWriter(StdPara.w, StdPara.addr_w, StdPara.h_w, StdPara.c_w, StdPara.id_w)).io
    val maxpool = Module(new Maxpool(StdPara.w)).io

    val rom_weight = if(StdPara.para_num==4) Module(new ROMWeight(StdPara.para_num)).io else Module(new ROMHalfWeight(StdPara.para_num)).io
    val rom_bias = if(StdPara.para_num==4) Module(new ROMBias(StdPara.para_num)).io else Module(new ROMHalfBias(StdPara.para_num)).io
    // val rom_weight = Module(new ROMWeight(StdPara.para_num)).io
    // val rom_bias = Module(new ROMBias(StdPara.para_num)).io
    val bram = Module(new RAMGroup(StdPara.w, StdPara.addr_w, StdPara.id_w)).io

    io.complete := false.B
    io.valid := false.B
    io.output := 0.S
    bram.rd_addr1 := reader1.to_banks
    reader1.flag_job := false.B
    reader1.valid_in := false.B
    reader1.job := 0.U.asTypeOf(reader1.job)
    reader1.job_type := 0.U.asTypeOf(reader1.job_type)
    reader1.job2 := 0.U.asTypeOf(reader1.job2)
    reader1.signal := false.B

    bram.rd_valid_in := reader2.valid_out
    bram.rd_addr2 := reader2.to_banks
    reader2.flag_job := false.B
    reader2.valid_in := false.B
    reader2.job := 0.U.asTypeOf(reader2.job)
    reader2.job_type := 0.U.asTypeOf(reader2.job_type)
    reader2.job2 := 0.U.asTypeOf(reader2.job2)
    reader2.signal := false.B

    read_weight.valid_in := false.B
    read_weight.addr_end := 0.U
    read_weight.begin_addr := 0.U
    rom_weight.addr := read_weight.addr
    read_weight.flag_job := false.B
    

    read_pack.valid_in := bram.rd_valid_out
    read_pack.flag_job := false.B
    read_pack.job := 0.U.asTypeOf(read_pack.job)
    read_pack.from_big := bram.rd_big
    read_pack.from_small := bram.rd_small
    
    read_switch.flag_job := false.B
    read_switch.job := 0.U.asTypeOf(read_switch.job)
    read_switch.valid_in := read_pack.valid_out
    read_switch.from := read_pack.output
    read_switch.from_weight := rom_weight.out
    read_switch.in_h := 0.U
    read_switch.in_chan := 0.U
    read_switch.valid_in_from_user := false.B
    read_switch.data_from_user := 0.U.asTypeOf(read_switch.data_from_user)

    calc8x8.input := read_switch.to_calc8x8
    calc8x8.flag := 0.U.asTypeOf(calc8x8.flag)
    calc8x8.weight := read_switch.to_weight
    calc8x8.valid_in := read_switch.valid_out_calc8x8
    calc8x8.mask := 0.U
    calc8x8.multmap := read_switch.to_multmap
    
    
    accu.in_from_calc8x8 := calc8x8.output
    accu.valid_in := calc8x8.valid_out
    accu.flag_job := false.B
    accu.csum := 0.U
    accu.bias_begin_addr := 0.U
    accu.bias_end_addr := 0.U
    rom_bias.addr := accu.bias_addr
    accu.bias_in := rom_bias.out
    accu.is_in_use := false.B

    cache_writer.in_from_accumu := accu.result
    cache_writer.valid_in := accu.valid_out


    quant.in_from_accumu := cache_writer.out
    quant.valid_in := cache_writer.valid_out
    quant.flag_job := false.B
    quant.quant_in := 0.U.asTypeOf(quant.quant_in)

   
    maxpool.from_big := bram.rd_big
    for(t <- 0 to 1){
        maxpool.from_small(t)(0) := bram.rd_small(t)(0)
        maxpool.from_small(t)(1) := bram.rd_small(t)(1)
    }
        
    maxpool.valid_in := read_switch.valid_out_maxp

    //write_switch.valid_in(1) := false.B
    //write_switch.input(1) := 0.U.asTypeOf(write_switch.input(1))

    write_switch.valid_in(0) := quant.valid_out // conv
    write_switch.valid_in(1) := maxpool.valid_out // maxpool
    write_switch.valid_in(2) := read_switch.valid_out_copy // go through

    write_switch.input(0) := quant.result
    write_switch.input(1) := maxpool.result
    write_switch.input(2) := read_switch.to_copy

    writer.in_from_quant := write_switch.output
    writer.valid_in := write_switch.valid_out
    writer.flag_job := false.B
    writer.job := 0.U.asTypeOf(writer.job)

    // io.output_ls := quant.result.mat(0)


    /*dontTouch(writer.to_banks)
    dontTouch(writer.to_bigbank)
    dontTouch(writer.to_smallbank)
    dontTouch(writer.valid_out)*/
    bram.wr_addr := writer.to_banks
    bram.to_bigbank := writer.to_bigbank
    bram.to_smallbank := writer.to_smallbank
    bram.wr_valid_in := writer.valid_out

    def nxt_big(x: Int): Int = {
        val L = StdPara.big_min_addr
        val R = StdPara.big_max_addr
        return (x-L)%(R-L+1)+L
    }
    def nxt_small(x: Int): Int = {
        val L = StdPara.small_min_addr
        val R = StdPara.small_max_addr
        return (x-L)%(R-L+1)+L
    }

    var big_addr = 0
    var small_addr = 0
    var weight_addr = 0
    var bias_addr = 0
    

    
    
    val counter = RegInit(0.U.asTypeOf(ACounter(16.W)))
    val state = RegInit(0.U(8.W))


    val output_cache = RegInit(VecInit(Seq.fill(64)(0.S(16.W))))

    var num_stages = 0

    io.complete_output := false.B

    WAIT_START()
    CONV(4, 4, 4, 16, 30, 15)
    // WRITEHALF_CONV1(8, 8, 17, 8)
    // LAST_PRINT(4, 4, 32)
    
    // CONV(4, 4, 16, 32, 32, 16)
    // RELU(4, 4, 16, 15+15, 17)
    // LAST_PRINT(4, 4, 16)
    RELU0(4, 4, 16, 15+15, 17)
    // weight_addr = 0
    // bias_addr = 0
    // big_addr = 0
    // small_addr = 0
    // CONV(4, 4, 4, 16, 30, 15)
    // RELU(4, 4, 16, 15+15, 17)
    // LAST_PRINT(4, 4, 16)

    CONV1(4, 4, 16, 32, 32, 16)
    RELU1(4, 4, 32, 16+15, 17)
    MAXPOOL(4, 4, 32)
    //conv_2
    CONV(2, 2, 32, 64, 32, 14)
    RELU(2, 2, 64, 14+15, 14)

    // conv_6
    CONV(2, 2, 64, 64, 29, 11)                 
    RELU(2, 2, 64, 11+15, 11)


    // conv_u1
    UPS(2, 2, 64)

    CONV(4, 4, 64, 32, 26, 8)
    RELU(4, 4, 32, 8+15, 8)
    // LAST_PRINT(4, 4, 32)
    println(num_stages)
    CONVMULT()
    println(num_stages)

    // conv_u4
    UPS(4, 4, 16)
    CONV(8, 8, 16, 16, 27, 12)
    RELU(8, 8, 16, 12+15, 12)

    // conv_10
    CONV(8, 8, 16, 4, 29, 13)
    LAST_PRINT(8, 8, 4)

    val checksum = RegInit(0.U(16.W))
    CHECK_PRINT()
    // LAST_CHECK(8, 8, 4)
    // LAST_PRINT(2, 2, 32)


    def WAIT_START(){
        when(state===(num_stages).U){
            when(io.start){
                state := (num_stages+1).U 
            }    
        }
        num_stages += 1
    }
    def CONVMULT(){
        WRITEHALF_CONV1(8, 8, 17, 8)
        println(num_stages)
        CONV(4, 4, 64, 16, 22, 6)
        println(num_stages)
        RELU(4, 4, 16, 6+15, 6)
        println(num_stages)
        MULT(6+17, 11)   
        // LAST_PRINT(4, 4, 16)
    }

    def MULT(q_in: Int, q_out: Int){
        val paras = GenAllPara(addr_w=StdPara.addr_w, h_w=StdPara.h_w, c_w=StdPara.c_w, id_w=StdPara.id_w, big_w=StdPara.big_w, 
            width=4, 
            height=4, 
            wr_width=4, 
            wr_height=4,
            in_chan=16, 
            out_chan=16,
            para_num=StdPara.para_num, 
            mask=StdPara.mask,
            big_begin_addr=big_addr, 
            big_max_addr=StdPara.big_max_addr, 
            big_min_addr=StdPara.big_min_addr,   
            wr_big_begin_addr=nxt_big(big_addr+16*4*4/2), 
            wr_big_max_addr=StdPara.big_max_addr, 
            wr_big_min_addr=StdPara.big_min_addr, 
            small_begin_addr=small_addr, 
            small_max_addr=StdPara.small_max_addr, 
            small_min_addr=StdPara.small_min_addr,    
            wr_small_begin_addr=nxt_small(small_addr+16*4*4/4), 
            wr_small_max_addr=StdPara.small_max_addr, 
            wr_small_min_addr=StdPara.small_min_addr, 
            weight_begin_addr=0, 
            bias_begin_addr=0, 
            quant_q_in=q_in, 
            quant_q_out=q_out   
        )

        val paras2 = GenAllPara(addr_w=StdPara.addr_w, h_w=StdPara.h_w, c_w=StdPara.c_w, id_w=StdPara.id_w, big_w=StdPara.big_w, 
            width=4, 
            height=4, 
            wr_width=4, 
            wr_height=4,
            in_chan=16, 
            out_chan=16,
            para_num=StdPara.para_num, 
            mask=StdPara.mask,
            big_begin_addr=StdPara.big_conv0_addr, 
            big_max_addr=StdPara.big_global_addr, 
            big_min_addr=0,   
            wr_big_begin_addr=0, 
            wr_big_max_addr=0, 
            wr_big_min_addr=0, 
            small_begin_addr=StdPara.small_conv0_addr, 
            small_max_addr=StdPara.small_global_addr, 
            small_min_addr=0,     
            wr_small_begin_addr=0, 
            wr_small_max_addr=0, 
            wr_small_min_addr=0, 
            weight_begin_addr=0, 
            bias_begin_addr=0, 
            quant_q_in=0, 
            quant_q_out=0 
        )

        big_addr = nxt_big(big_addr+16*4*4/2)
        small_addr = nxt_small(small_addr+16*4*4/4)
        when(state===(num_stages).U){
            paras.set_copy_reader1(reader1, 1)
            paras.set_copy_reader2(reader2, 1)
            paras2.set_copy_reader1_job2(reader1, 1)
            paras2.set_copy_reader2_job2(reader2, 1)
            paras.set_ups_read_pack(read_pack)
            paras.set_mult_switch(read_switch)
            paras.set_unuse_accu(accu)
            paras.set_quant(quant)
            paras.set_write(writer)
            counter.set((16*4*4-1).U)
            state := (num_stages+1).U
        }
        num_stages += 1
        when(state===(num_stages).U){
            when(writer.valid_out){
                when(counter.inc()){
                    state := (num_stages+1).U
                }
            }
            reader1.valid_in := true.B
            reader2.valid_in := true.B
            reader1.signal := true.B
            reader2.signal := true.B
            calc8x8.flag := CalcType.calcMult
        }
        num_stages += 1

    }

    def WRITEHALF_CONV1(q_in: Int, q_out: Int, q_in2: Int, q_out2: Int){
        val in_chan = 32
        val paras = GenAllPara(addr_w=StdPara.addr_w, h_w=StdPara.h_w, c_w=StdPara.c_w, id_w=StdPara.id_w, big_w=StdPara.big_w, 
            width=4, 
            height=4, 
            wr_width=4, 
            wr_height=4,
            in_chan=in_chan, 
            out_chan=in_chan*2,
            para_num=StdPara.para_num, 
            mask=StdPara.mask,
            big_begin_addr=big_addr, 
            big_max_addr=StdPara.big_max_addr, 
            big_min_addr=StdPara.big_min_addr,   
            wr_big_begin_addr=nxt_big(big_addr+in_chan*4*4/2+0), 
            wr_big_max_addr=StdPara.big_max_addr, 
            wr_big_min_addr=StdPara.big_min_addr, 
            small_begin_addr=small_addr, 
            small_max_addr=StdPara.small_max_addr, 
            small_min_addr=StdPara.small_min_addr,    
            wr_small_begin_addr=nxt_small(small_addr+in_chan*4*4/4+0), 
            wr_small_max_addr=StdPara.small_max_addr, 
            wr_small_min_addr=StdPara.small_min_addr, 
            weight_begin_addr=0, 
            bias_begin_addr=0, 
            quant_q_in=q_in, 
            quant_q_out=q_out   
        )

        val paras2 = GenAllPara(addr_w=StdPara.addr_w, h_w=StdPara.h_w, c_w=StdPara.c_w, id_w=StdPara.id_w, big_w=StdPara.big_w, 
            width=4, 
            height=4, 
            wr_width=4, 
            wr_height=4,
            in_chan=in_chan, 
            out_chan=in_chan*2,
            para_num=StdPara.para_num, 
            mask=StdPara.mask,
            big_begin_addr=StdPara.big_conv1_addr, 
            big_max_addr=StdPara.big_global_addr, 
            big_min_addr=0,   
            wr_big_begin_addr=nxt_big(big_addr+in_chan*4*4/2+in_chan), 
            wr_big_max_addr=StdPara.big_max_addr, 
            wr_big_min_addr=StdPara.big_min_addr, 
            small_begin_addr=StdPara.small_conv1_addr, 
            small_max_addr=StdPara.small_global_addr, 
            small_min_addr=0,     
            wr_small_begin_addr=nxt_small(small_addr+in_chan*4*4/4+in_chan), 
            wr_small_max_addr=StdPara.small_max_addr, 
            wr_small_min_addr=StdPara.small_min_addr, 
            weight_begin_addr=0, 
            bias_begin_addr=0, 
            quant_q_in=q_in2, 
            quant_q_out=q_out2  
        )

        big_addr = nxt_big(big_addr+in_chan*4*4/2)
        small_addr = nxt_small(small_addr+in_chan*4*4/4)
        when(state===(num_stages).U){
            paras.set_copy_reader1(reader1, 1)
            paras.set_copy_reader2(reader2, 1)
            paras.set_copy_read_pack(read_pack)
            paras.set_copy_switch(read_switch)
            paras.set_unuse_accu(accu)
            paras.set_quant(quant)
            paras.set_write_alar(writer, 0, in_chan-1)
            counter.set((in_chan*4*4-1).U)
            state := (num_stages+1).U
        }
        num_stages += 1
        when(state===(num_stages).U){
            when(writer.valid_out){
                when(counter.inc()){
                    state := (num_stages+1).U
                }
            }
            reader1.valid_in := true.B
            reader2.valid_in := true.B
        }
        num_stages += 1
        when(state===(num_stages).U){
            paras2.set_copy_reader1(reader1, 1)
            paras2.set_copy_reader2(reader2, 1)
            paras2.set_copy_read_pack(read_pack)
            paras2.set_conv_read_switch(read_switch)
            paras2.set_unuse_accu(accu)
            paras2.set_quant(quant)
            paras2.set_write_alar(writer, in_chan, 2*in_chan-1)
            counter.set((in_chan*4*4-1).U)
            state := (num_stages+1).U
        }
        num_stages += 1
        when(state===(num_stages).U){
            when(writer.valid_out){
                when(counter.inc()){
                    state := (num_stages+1).U
                }
            }
            reader1.valid_in := true.B
            reader2.valid_in := true.B
            calc8x8.flag := CalcType.empty
        }
        num_stages += 1
    }


    def CONV(w: Int, h: Int, in_chan: Int, out_chan: Int, conv_q_in: Int, 
                        conv_q_out: Int): Unit = {
        val paras = GenAllPara(addr_w=StdPara.addr_w, h_w=StdPara.h_w, c_w=StdPara.c_w, id_w=StdPara.id_w, big_w=StdPara.big_w, 
            width=w, 
            height=h, 
            wr_width=w, 
            wr_height=h,
            in_chan=in_chan, 
            out_chan=out_chan,
            para_num=StdPara.para_num, 
            mask=StdPara.mask,
            big_begin_addr=big_addr, 
            big_max_addr=StdPara.big_max_addr, 
            big_min_addr=StdPara.big_min_addr,   
            wr_big_begin_addr=nxt_big(big_addr+in_chan*w*h/2), 
            wr_big_max_addr=StdPara.big_max_addr, 
            wr_big_min_addr=StdPara.big_min_addr, 
            small_begin_addr=small_addr, 
            small_max_addr=StdPara.small_max_addr, 
            small_min_addr=StdPara.small_min_addr,    
            wr_small_begin_addr=nxt_small(small_addr+in_chan*w*h/4), 
            wr_small_max_addr=StdPara.small_max_addr, 
            wr_small_min_addr=StdPara.small_min_addr, 
            weight_begin_addr=weight_addr, 
            bias_begin_addr=bias_addr, 
            quant_q_in=conv_q_in, 
            quant_q_out=conv_q_out   
        )
        big_addr = nxt_big(big_addr+in_chan*w*h/2)
        small_addr = nxt_small(small_addr+in_chan*w*h/4)
        weight_addr += in_chan*out_chan/StdPara.para_num
        bias_addr += out_chan/StdPara.para_num

        when(state===(num_stages).U){
            paras.set_conv_reader1(reader1)
            paras.set_conv_reader2(reader2)
            paras.set_read_weight(read_weight)
            paras.set_conv_read_pack(read_pack)
            paras.set_conv_accu(accu)
            paras.set_quant(quant)
            paras.set_write(writer)
            paras.set_conv_read_switch(read_switch)

            counter.set((out_chan*w*h-1).U)
            state := (num_stages+1).U
        }
        num_stages += 1
        when(state===(num_stages).U){
            when(writer.valid_out){
                when(counter.inc()){
                    state := (num_stages+1).U
                }
            }
            reader1.valid_in := true.B
            reader2.valid_in := true.B
            read_weight.valid_in := true.B
            calc8x8.flag := CalcType.calcConv
            calc8x8.mask := paras.mask.U
        }
        num_stages += 1
    }

    def CONV1(w: Int, h: Int, in_chan: Int, out_chan: Int, conv_q_in: Int, 
                        conv_q_out: Int): Unit = {
        val paras = GenAllPara(addr_w=StdPara.addr_w, h_w=StdPara.h_w, c_w=StdPara.c_w, id_w=StdPara.id_w, big_w=StdPara.big_w, 
            width=w, 
            height=h, 
            wr_width=w, 
            wr_height=h,
            in_chan=in_chan, 
            out_chan=out_chan,
            para_num=StdPara.para_num, 
            mask=StdPara.mask,
            big_begin_addr=StdPara.big_conv0_addr, 
            big_max_addr=StdPara.big_global_addr, 
            big_min_addr=0,   
            wr_big_begin_addr=big_addr, 
            wr_big_max_addr=StdPara.big_max_addr, 
            wr_big_min_addr=StdPara.big_min_addr, 
            small_begin_addr=StdPara.small_conv0_addr, 
            small_max_addr=StdPara.small_global_addr, 
            small_min_addr=0,    
            wr_small_begin_addr=small_addr, 
            wr_small_max_addr=StdPara.small_max_addr, 
            wr_small_min_addr=StdPara.small_min_addr, 
            weight_begin_addr=weight_addr, 
            bias_begin_addr=bias_addr, 
            quant_q_in=conv_q_in, 
            quant_q_out=conv_q_out   
        )
        weight_addr += in_chan*out_chan/StdPara.para_num
        bias_addr += out_chan/StdPara.para_num

        when(state===(num_stages).U){
            paras.set_conv_reader1(reader1)
            paras.set_conv_reader2(reader2)
            paras.set_read_weight(read_weight)
            paras.set_conv_read_pack(read_pack)
            paras.set_conv_accu(accu)
            paras.set_quant(quant)
            paras.set_write(writer)
            paras.set_conv_read_switch(read_switch)

            calc8x8.mask := paras.mask.U
            counter.set((out_chan*w*h-1).U)
            state := (num_stages+1).U
        }
        num_stages += 1
        when(state===(num_stages).U){
            when(writer.valid_out){
                when(counter.inc()){
                    state := (num_stages+1).U
                }
            }
            reader1.valid_in := true.B
            reader2.valid_in := true.B
            read_weight.valid_in := true.B
            calc8x8.flag := CalcType.calcConv
            calc8x8.mask := paras.mask.U
        }
        num_stages += 1
    }

    def RELU0(w: Int, h: Int, in_chan: Int, relu_q_in: Int, relu_q_out: Int): Unit = {
        val paras = GenAllPara(addr_w=StdPara.addr_w, h_w=StdPara.h_w, c_w=StdPara.c_w, id_w=StdPara.id_w, big_w=StdPara.big_w, 
            width=w, 
            height=h, 
            wr_width=w, 
            wr_height=h,
            in_chan=in_chan, 
            out_chan=in_chan,
            para_num=1, 
            mask=1,
            big_begin_addr=big_addr, 
            big_max_addr=StdPara.big_max_addr, 
            big_min_addr=StdPara.big_min_addr,   
            wr_big_begin_addr=StdPara.big_conv0_addr, 
            wr_big_max_addr=StdPara.big_global_addr, 
            wr_big_min_addr=0, 
            small_begin_addr=small_addr, 
            small_max_addr=StdPara.small_max_addr, 
            small_min_addr=StdPara.small_min_addr,    
            wr_small_begin_addr=StdPara.small_conv0_addr,
            wr_small_max_addr=StdPara.small_global_addr,
            wr_small_min_addr=0,
            weight_begin_addr=0, 
            bias_begin_addr=0, 
            quant_q_in=relu_q_in, 
            quant_q_out=relu_q_out   
        )

        when(state===(num_stages).U){
            paras.set_copy_reader1(reader1, 1)
            paras.set_copy_reader2(reader2, 1)
            paras.set_copy_read_pack(read_pack)
            paras.set_conv_read_switch(read_switch)
            paras.set_unuse_accu(accu)
            paras.set_quant(quant)
            paras.set_write(writer)
            counter.set((in_chan*w*h-1).U)
            state := (num_stages+1).U
        }
        num_stages += 1
        when(state===(num_stages).U){
            when(writer.valid_out){
                when(counter.inc()){
                    state := (num_stages+1).U
                }
            }
            reader1.valid_in := true.B
            reader2.valid_in := true.B
            calc8x8.flag := CalcType.leakyReLU
        }
        num_stages += 1
    }

    def RELU1(w: Int, h: Int, in_chan: Int, relu_q_in: Int, relu_q_out: Int): Unit = {
        val paras = GenAllPara(addr_w=StdPara.addr_w, h_w=StdPara.h_w, c_w=StdPara.c_w, id_w=StdPara.id_w, big_w=StdPara.big_w, 
            width=w, 
            height=h, 
            wr_width=w, 
            wr_height=h,
            in_chan=in_chan, 
            out_chan=in_chan,
            para_num=1, 
            mask=1,
            big_begin_addr=big_addr, 
            big_max_addr=StdPara.big_max_addr, 
            big_min_addr=StdPara.big_min_addr,   
            wr_big_begin_addr=StdPara.big_conv1_addr, 
            wr_big_max_addr=StdPara.big_global_addr, 
            wr_big_min_addr=0, 
            small_begin_addr=small_addr, 
            small_max_addr=StdPara.small_max_addr, 
            small_min_addr=StdPara.small_min_addr,    
            wr_small_begin_addr=StdPara.small_conv1_addr,
            wr_small_max_addr=StdPara.small_global_addr,
            wr_small_min_addr=0,
            weight_begin_addr=0, 
            bias_begin_addr=0, 
            quant_q_in=relu_q_in, 
            quant_q_out=relu_q_out   
        )

        when(state===(num_stages).U){
            paras.set_copy_reader1(reader1, 1)
            paras.set_copy_reader2(reader2, 1)
            paras.set_copy_read_pack(read_pack)
            paras.set_conv_read_switch(read_switch)
            paras.set_unuse_accu(accu)
            paras.set_quant(quant)
            paras.set_write(writer)
            counter.set((in_chan*w*h-1).U)
            state := (num_stages+1).U
        }
        num_stages += 1
        when(state===(num_stages).U){
            when(writer.valid_out){
                when(counter.inc()){
                    state := (num_stages+1).U
                }
            }
            reader1.valid_in := true.B
            reader2.valid_in := true.B
            calc8x8.flag := CalcType.leakyReLU
        }
        num_stages += 1
    }

    def RELU(w: Int, h: Int, in_chan: Int, relu_q_in: Int, relu_q_out: Int): Unit = {
        val paras = GenAllPara(addr_w=StdPara.addr_w, h_w=StdPara.h_w, c_w=StdPara.c_w, id_w=StdPara.id_w, big_w=StdPara.big_w, 
            width=w, 
            height=h, 
            wr_width=w, 
            wr_height=h,
            in_chan=in_chan, 
            out_chan=in_chan,
            para_num=StdPara.para_num, 
            mask=StdPara.mask,
            big_begin_addr=big_addr, 
            big_max_addr=StdPara.big_max_addr, 
            big_min_addr=StdPara.big_min_addr,   
            wr_big_begin_addr=nxt_big(big_addr+in_chan*w*h/2), 
            wr_big_max_addr=StdPara.big_max_addr, 
            wr_big_min_addr=StdPara.big_min_addr, 
            small_begin_addr=small_addr, 
            small_max_addr=StdPara.small_max_addr, 
            small_min_addr=StdPara.small_min_addr,    
            wr_small_begin_addr=nxt_small(small_addr+in_chan*w*h/4), 
            wr_small_max_addr=StdPara.small_max_addr, 
            wr_small_min_addr=StdPara.small_min_addr, 
            weight_begin_addr=0, 
            bias_begin_addr=0, 
            quant_q_in=relu_q_in, 
            quant_q_out=relu_q_out   
        )

        big_addr = nxt_big(big_addr+in_chan*w*h/2)
        small_addr = nxt_small(small_addr+in_chan*w*h/4)
        when(state===(num_stages).U){
            paras.set_copy_reader1(reader1, 1)
            paras.set_copy_reader2(reader2, 1)
            paras.set_copy_read_pack(read_pack)
            paras.set_conv_read_switch(read_switch)
            paras.set_unuse_accu(accu)
            paras.set_quant(quant)
            paras.set_write(writer)
            counter.set((in_chan*w*h-1).U)
            state := (num_stages+1).U
        }
        num_stages += 1
        when(state===(num_stages).U){
            when(writer.valid_out){
                when(counter.inc()){
                    state := (num_stages+1).U
                }
            }
            reader1.valid_in := true.B
            reader2.valid_in := true.B
            calc8x8.flag := CalcType.leakyReLU
        }
        num_stages += 1
    }

    def MAXPOOL(w: Int, h: Int, in_chan: Int): Unit = {
        val paras = GenAllPara(addr_w=StdPara.addr_w, h_w=StdPara.h_w, c_w=StdPara.c_w, id_w=StdPara.id_w, big_w=StdPara.big_w, 
            width=w, 
            height=h, 
            wr_width=w/2, 
            wr_height=h/2,
            in_chan=in_chan, 
            out_chan=in_chan,
            para_num=1, 
            mask=0,
            big_begin_addr=StdPara.big_conv1_addr, 
            big_max_addr=StdPara.big_global_addr, 
            big_min_addr=0,   
            wr_big_begin_addr=big_addr, 
            wr_big_max_addr=StdPara.big_max_addr, 
            wr_big_min_addr=StdPara.big_min_addr, 
            small_begin_addr=StdPara.small_conv1_addr, 
            small_max_addr=StdPara.small_global_addr, 
            small_min_addr=0,    
            wr_small_begin_addr=small_addr, 
            wr_small_max_addr=StdPara.small_max_addr, 
            wr_small_min_addr=StdPara.small_min_addr, 
            weight_begin_addr=0, 
            bias_begin_addr=0, 
            quant_q_in=0, 
            quant_q_out=0   
        )

        when(state===(num_stages).U){
            paras.set_maxp_reader1(reader1)
            paras.set_maxp_reader2(reader2)
            paras.set_write(writer)
            paras.set_maxpool_switch(read_switch)
            counter.set((in_chan*w*h/4-1).U)

            state := (num_stages+1).U
        }
        num_stages += 1
        when(state===(num_stages).U){
            when(writer.valid_out){
                when(counter.inc()){
                    state := (num_stages+1).U
                }
            }
            reader1.valid_in := true.B
            reader2.valid_in := true.B
        }
        num_stages += 1
    }

    def UPS(w: Int, h: Int, in_chan: Int): Unit = {
        val paras = GenAllPara(addr_w=StdPara.addr_w, h_w=StdPara.h_w, c_w=StdPara.c_w, id_w=StdPara.id_w, big_w=StdPara.big_w, 
            width=w, 
            height=h, 
            wr_width=w*2, 
            wr_height=h*2,
            in_chan=in_chan, 
            out_chan=in_chan,
            para_num=StdPara.para_num, 
            mask=StdPara.mask,
            big_begin_addr=big_addr, 
            big_max_addr=StdPara.big_max_addr, 
            big_min_addr=StdPara.big_min_addr,   
            wr_big_begin_addr=nxt_big(big_addr+in_chan*w*h/2), 
            wr_big_max_addr=StdPara.big_max_addr, 
            wr_big_min_addr=StdPara.big_min_addr, 
            small_begin_addr=small_addr, 
            small_max_addr=StdPara.small_max_addr, 
            small_min_addr=StdPara.small_min_addr,    
            wr_small_begin_addr=nxt_small(small_addr+in_chan*w*h/4), 
            wr_small_max_addr=StdPara.small_max_addr, 
            wr_small_min_addr=StdPara.small_min_addr, 
            weight_begin_addr=0, 
            bias_begin_addr=0, 
            quant_q_in=0, 
            quant_q_out=0  
        )

        big_addr = nxt_big(big_addr+in_chan*w*h/2)
        small_addr = nxt_small(small_addr+in_chan*w*h/4)

        when(state===(num_stages).U){
            paras.set_ups_reader1(reader1)
            paras.set_ups_reader2(reader2)
            paras.set_ups_read_pack(read_pack)
            paras.set_write(writer)
            paras.set_ups_switch(read_switch)
            counter.set((in_chan*w*h*4-1).U)

            state := (num_stages+1).U
        }
        num_stages += 1
        when(state===(num_stages).U){
            when(writer.valid_out){
                when(counter.inc()){
                    state := (num_stages+1).U
                }
            }
            reader1.valid_in := true.B
            reader2.valid_in := true.B
        }
        num_stages += 1
    }

    def LAST_PRINT(w: Int, h: Int, in_chan: Int): Unit = {
        val lst_counter = RegInit(0.U.asTypeOf(ACounter(16.W)))
        val lst_64_counter = RegInit(0.U.asTypeOf(ACounter(16.W)))
        val paras_print = GenAllPara(StdPara.addr_w, StdPara.h_w, StdPara.c_w, StdPara.id_w, big_w=StdPara.big_w, 
            w, h, w, h, 
            in_chan, 1,
            1, 0,
            big_addr, StdPara.big_max_addr, StdPara.big_min_addr,
            // StdPara.big_conv1_addr, 899, 0,
            0, 0, 0,
            small_addr, StdPara.small_max_addr, StdPara.small_min_addr,
            // StdPara.small_conv1_addr, 449, 0,
            0, 0, 0,
            0, 0, 0, 0
        )
        when(state===(num_stages).U){
            state := (num_stages+1).U
            paras_print.set_conv_reader1(reader1)
            paras_print.set_conv_reader2(reader2)
            paras_print.set_conv_read_pack(read_pack)
            read_switch.flag_job := true.B
            read_switch.job := ReadSwitchType.idle
            lst_64_counter.set(63.U)
            lst_counter.set((w*h*in_chan-1).U)
        }
        when(state===(num_stages+1).U){
            reader1.valid_in := true.B
            reader2.valid_in := true.B
            state := (num_stages+2).U
        }
        when(state===(num_stages+2).U){
            state := (num_stages+3).U
        }
        when(state===(num_stages+3).U){
            when(lst_64_counter.inc()){
                when(lst_counter.inc()){
                    state := (num_stages+4).U
                }
            }.elsewhen(lst_64_counter.ccnt===62.U){
                reader1.valid_in := true.B
                reader2.valid_in := true.B  
            }
            when(read_pack.valid_out){
                io.complete := true.B
                io.valid := true.B
                io.output := read_pack.output.mat(0)
                for(i <- 0 to 62)
                    output_cache(i) := read_pack.output.mat(i+1)
            }.otherwise{
                io.valid := true.B
                io.output := output_cache(0)
                for(i <- 0 to 62)
                    output_cache(i) := output_cache(i+1)
            }
        }
        when(state===(num_stages+4).U){
            state := (num_stages+4).U
            io.complete_output := true.B
        }
        num_stages += 5
    }

    def CHECK_PRINT(): Unit = {
        when(io.valid){
            checksum := checksum^io.output.asUInt
        }
        io.checksum := checksum
    }
}