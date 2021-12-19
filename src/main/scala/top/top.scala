package final_project

import chisel3._
import chisel3.util._

import chisel3.experimental.BundleLiterals._

class Top extends Module{
    //val io = IO(new)
    val io = IO(new Bundle{
        val complete = Output(Bool())
        val valid = Output(Bool())
        val output = Output(SInt(16.W))
    })

    val reader1 = Module(new GraphReader(StdPara.addr_w, StdPara.h_w, StdPara.c_w, StdPara.id_w)).io
    val reader2 = Module(new GraphReader(StdPara.addr_w, StdPara.h_w, StdPara.c_w, StdPara.id_w)).io
    val read_pack = Module(new PackReadData(StdPara.w, StdPara.h_w, StdPara.c_w)).io
    val read_switch = Module(new ReadSwitch(StdPara.w, StdPara.para_num)).io
    val read_weight = Module(new WeightReader(StdPara.w, StdPara.weight_addr_w)).io
    val calc8x8 = Module(new Calc8x8(StdPara.w, StdPara.para_num)).io
    val accu = Module(new Accumu(StdPara.w, StdPara.addr_w, StdPara.bias_w, StdPara.para_num)).io

    val cache_writer = Module(new CacheWriter(StdPara.w, StdPara.para_num)).io
    val quant = Module(new Quant(StdPara.w)).io
    val write_switch = Module(new WriteSwitch(StdPara.w, 3)).io
    val writer = Module(new RealWriter(StdPara.w, StdPara.addr_w, StdPara.h_w, StdPara.c_w, StdPara.id_w)).io
    val maxpool = Module(new Maxpool(StdPara.w)).io

    val rom_weight = Module(new ROMWeight(StdPara.para_num)).io
    val rom_bias = Module(new ROMBias(StdPara.para_num)).io
    val bram = Module(new RAMGroup(StdPara.w, StdPara.addr_w, StdPara.id_w)).io

    io.complete := false.B
    io.valid := false.B
    io.output := 0.S
    bram.rd_addr1 := reader1.to_banks
    reader1.flag_job := false.B
    reader1.valid_in := false.B
    reader1.job := 0.U.asTypeOf(reader1.job)
    reader1.job_type := 0.U.asTypeOf(reader1.job_type)

    bram.rd_valid_in := reader2.valid_out
    bram.rd_addr2 := reader2.to_banks
    reader2.flag_job := false.B
    reader2.valid_in := false.B
    reader2.job := 0.U.asTypeOf(reader2.job)
    reader2.job_type := 0.U.asTypeOf(reader2.job_type)

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
        maxpool.from_small(t)(0) := bram.rd_small(t)(1)
        maxpool.from_small(t)(1) := bram.rd_small(t)(2)
    }
        
    maxpool.valid_in := read_switch.valid_out_maxp

    //write_switch.valid_in(1) := false.B
    //write_switch.input(1) := 0.U.asTypeOf(write_switch.input(1))

    write_switch.valid_in(0) := quant.valid_out // conv
    write_switch.valid_in(1) := maxpool.valid_out // maxpool
    write_switch.valid_in(2) := read_switch.valid_out_copy // go through

    write_switch.valid_in(1) := false.B
    write_switch.valid_in(2) := false.B

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


    val paras = GenAllPara(StdPara.addr_w, StdPara.h_w, StdPara.c_w, StdPara.id_w, 
        4, 4, 4, 4, // w, h, wr_w, wr_h
        4, 16,          // in out chan
        4, 15,            // para mask
        0, 899, 0,   // big addr
        64, 899, 0, // wr big addr
        0, 449, 0,    // small addr
        32, 449, 0, // wr small addr
        0, 0, 30, 15    // 
    )

    val paras_print = GenAllPara(StdPara.addr_w, StdPara.h_w, StdPara.c_w, StdPara.id_w,
        4, 4, 4, 4, 
        16, 1,
        1, 0,
        64, 899, 0,
        0, 0, 0,
        32, 449, 0,
        0, 0, 0,
        0, 0, 0, 0
    )
    
    val counter = RegInit(0.U.asTypeOf(ACounter(10.W)))

    val lst_counter = RegInit(0.U.asTypeOf(ACounter(10.W)))
    val lst_64_counter = RegInit(0.U.asTypeOf(ACounter(10.W)))

    val output_cache = RegInit(VecInit(Seq.fill(64)(0.S(16.W))))

    val state = RegInit(0.U(6.W))
    switch(state){
        is(0.U){
            paras.set_conv_reader1(reader1)
            paras.set_conv_reader2(reader2)
            paras.set_read_weight(read_weight)
            paras.set_conv_read_pack(read_pack)
            paras.set_conv_accu(accu)
            paras.set_quant(quant)
            paras.set_write(writer, 0)
            paras.set_conv_read_switch(read_switch)

            calc8x8.flag := CalcType.calcConv
            calc8x8.mask := paras.mask.U
            counter.set(255.U)
            state := 1.U
        }
        is(1.U){
            when(writer.valid_out){
                when(counter.inc()){
                  //  io.complete := true.B
                    state := 2.U
                }
            }
            reader1.valid_in := true.B
            reader2.valid_in := true.B
            read_weight.valid_in := true.B
            calc8x8.flag := CalcType.calcConv
            calc8x8.mask := paras.mask.U
        }
        is(2.U){
            state := 3.U
            paras_print.set_conv_reader1(reader1)
            paras_print.set_conv_reader2(reader2)
            paras_print.set_conv_read_pack(read_pack)
            read_switch.flag_job := true.B
            read_switch.job := ReadSwitchType.idle
            lst_64_counter.set(63.U)
            lst_counter.set(255.U)
        }
        is(3.U){
            reader1.valid_in := true.B
            reader2.valid_in := true.B
            state := 4.U
        }
        is(4.U){
            when(lst_64_counter.inc()){
                when(lst_counter.inc()){
                    state := 5.U
                }.otherwise{
                    reader1.valid_in := true.B
                    reader2.valid_in := true.B    
                }
            }
            when(read_pack.valid_out){
                io.complete := true.B
                io.valid := true.B
                output_cache := read_pack.output.mat
                io.output := read_pack.output.mat(0)
            }.otherwise{
                io.valid := true.B
                io.output := output_cache(lst_64_counter.ccnt)
            }
        }
        is(5.U){
            state := 5.U
        }
    }
}