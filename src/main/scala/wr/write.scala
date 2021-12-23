package final_project

import chisel3._
import chisel3.util._

class BigBankWriteData(val w: Int) extends Bundle{
    val data = Vec(48, SInt(w.W))
}


class SmallBankWriteData(val w: Int) extends Bundle{
    val data = Vec(8, SInt(w.W))
}

// 2 groups, each group has:
// 4 small banks
// 1 big bank

// h_w: (w*h)(height)
// c_w: w(num of channels)


class Writer(val w: Int, val addr_w: Int, val h_w: Int, val c_w: Int, val id_w: Int) extends Module{
    val io = IO(new Bundle{
        val in_from_quant = Input(new QuantedData(w))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
        val flag_job = Input(Bool())
        val job = Input(new WriteJobs(addr_w, h_w, c_w, id_w))
        val to_bigbank = Output(new BigBankWriteData(w))
        val to_smallbank = Output(Vec(2, new SmallBankWriteData(w)))
        val to_banks = Output(new AddressWriteGroup(addr_w, id_w))
    })

    val gen = RegInit(0.U.asTypeOf(new WriteGroup(addr_w, h_w, c_w, id_w)))

    io.valid_out := false.B 
    io.to_bigbank := 0.U.asTypeOf(io.to_bigbank)
    io.to_smallbank := 0.U.asTypeOf(io.to_smallbank)
    io.to_banks := 0.U.asTypeOf(io.to_banks)
    
    for(i <- 0 to 7)
        for(j <- 0 to 5)
            io.to_bigbank.data(i*6+j) := io.in_from_quant.mat(i*8+(j+1))
    for(i <- 0 to 7)
        io.to_smallbank(0).data(i) := io.in_from_quant.mat(i*8)
    for(i <- 0 to 7)
        io.to_smallbank(1).data(i) := io.in_from_quant.mat(i*8+7)
    io.to_banks := gen.output()
    when(io.flag_job){
        gen.set(io.job)
    }.otherwise{
        when(io.valid_in){
            io.valid_out := true.B
            gen.go()
        }
    }
}

class RealWriterBundle(val w: Int, val addr_w: Int, val h_w: Int, val c_w: Int, val id_w: Int) extends TransBundle{
    val in_from_quant = Input(new QuantedData(w))
    val job = Input(new RealWriteJobs(addr_w, h_w, c_w, id_w))
    val to_bigbank = Output(new BigBankWriteData(w))
    val to_smallbank = Output(Vec(2, new SmallBankWriteData(w)))
    val to_banks = Output(new AddressWriteGroup(addr_w, id_w))
}

class RealWriter(val w: Int, val addr_w: Int, val h_w: Int, val c_w: Int, val id_w: Int) extends Module{
    val io = IO(new RealWriterBundle(w, addr_w, h_w, c_w, id_w))

    val gen = RegInit(VecInit(Seq.fill(2)(0.U.asTypeOf(new WriteGroup(addr_w, h_w, c_w, id_w)))))
    val cnt_ic = RegInit(0.U.asTypeOf(ACounter(c_w)))
    val state = RegInit(0.U(1.W))

    for(i <- 0 to 7)
        for(j <- 0 to 5)
            io.to_bigbank.data(i*6+j) := io.in_from_quant.mat(i*8+(j+1))
    for(i <- 0 to 7)
        io.to_smallbank(0).data(i) := io.in_from_quant.mat(i*8)
    for(i <- 0 to 7)
        io.to_smallbank(1).data(i) := io.in_from_quant.mat(i*8+7)

    io.to_banks := gen(state).output()
    io.valid_out := false.B
    when(io.flag_job){
        gen(0).set(io.job.job(0))
        gen(1).set(io.job.job(1))
        cnt_ic.set(io.job.out_chan)
        state := 0.U
    }.otherwise{
        when(io.valid_in){
            io.valid_out := true.B
            gen(state).go()
            when(cnt_ic.inc()){
                state := ~state
            }
        }
    }

}

class CacheWriter(val w: Int, val para_num: Int) extends Module{
    val io = IO(new Bundle{
        val in_from_accumu = Input(Vec(para_num, new AccumuRawData(w)))
        val valid_in = Input(UInt(para_num.W))
        val out = Output(new AccumuRawData(w))
        val valid_out = Output(Bool())
    })


    val cache_valid = RegInit(0.U(para_num.W))
    cache_valid := (cache_valid >> 1.U)|io.valid_in

    val cache = RegInit(0.U.asTypeOf(Vec(para_num, new AccumuRawData(w))))
    for(i <- 0 to para_num-2)
        cache(i) := Mux(io.valid_in(i), io.in_from_accumu(i), cache(i+1))
    cache(para_num-1) := Mux(io.valid_in(para_num-1), io.in_from_accumu(para_num-1), 0.U.asTypeOf(cache(para_num-1)))
    
    io.out := cache(0)
    io.valid_out := cache_valid(0)

}

/*
class CacheWriter(val w: Int, val addr_w: Int, val num: Int, val h_w: Int, val c_w: Int, val id_w: Int) extends Module{
    val io = IO(new Bundle{
        val in_from_quant = Input(Vec(num, new QuantedData(w)))
        val valid_in = Input(Vec(num, Bool()))
        val valid_out = Output(Bool())
        val flag_job = Input(Bool())
        val jobs = Input(Vec(num, new WriteJobs(addr_w, h_w, c_w, id_w)))
        val to_bigbank = Output(new BigBankWriteData(w))
        val to_smallbank = Output(Vec(2, new SmallBankWriteData(w)))
        val to_banks = Output(new AddressWriteGroup(addr_w, id_w))
    })

    val writers = VecInit(Seq.fill(num)(Module(new Writer(w, addr_w, h_w, c_w, id_w)).io))
    val cache = RegInit(0.U.asTypeOf(VecInit(Seq.fill(num)(new QuantedData(w)))))
    val cache_valid = RegInit(0.U.asTypeOf(Vec(num, Bool())))
    val now = PriorityMux(Seq.tabulate(num){i => cache_valid(i)}, Seq.tabulate(num){i => i.U})

    io.to_bigbank := 0.U.asTypeOf(io.to_bigbank)
    io.to_smallbank := 0.U.asTypeOf(io.to_smallbank)
    io.to_banks := 0.U.asTypeOf(io.to_banks)
    io.valid_out := false.B
    for(i <- 0 to num-1)
        writers(i) := 0.U.asTypeOf(writers(i))

    when(io.flag_job){
        cache_valid := 0.U.asTypeOf(cache_valid)
        for(i <- 0 to num-1){
            writers(i).job := io.jobs(i)
            writers(i).flag_job := true.B
        }
    }.otherwise{
        for(i <- 0 to num-1)
            cache := io.in_from_quant(i)
        for(i <- 0 to num-1)
            cache_valid(i) := cache_valid(i)|io.valid_in(i)
        when(cache_valid(now)){
            writers(now).valid_in := true.B
            writers(now).in_from_quant := cache(now)
            io.to_bigbank := writers(now).to_bigbank
            io.to_smallbank := writers(now).to_smallbank
            io.to_banks := writers(now).to_banks
            cache_valid(now) := io.valid_in(now)
        }
    }

}*/