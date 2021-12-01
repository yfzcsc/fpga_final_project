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

    val gen = RegInit(Reg(new WriteGroup(addr_w, id_w)))
    val job_type = RegInit(Reg(ReadType()))

    io.valid_out := false.B 
    io.to_bigbank := 0.U.asTypeOf(io.to_bigbank)
    io.to_smallbank := 0.U.asTypeOf(io.to_smallbank)
    io.to_banks := 0.U.asTypeOf(io.to_banks)
    
    when(io.flag_job){
        gen.set(io.job)
    }.otherwise{
        when(io.valid_in){
            io.valid_out := true.B
            for(i <- 0 to 7)
                for(j <- 0 to 5)
                    io.to_bigbank.data(i*6+j) := io.in_from_quant.mat(i*8+(j+1))
            for(i <- 0 to 7)
                io.to_smallbank(0).data(i) := io.in_from_quant.mat(i*8)
            for(i <- 0 to 7)
                io.to_smallbank(1).data(i) := io.in_from_quant.mat(i*8+7)
            io.to_banks := gen.output()
            gen.gen_conv()
        }
    }
}


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
    val cache = RegInit(Reg(VecInit(Seq.fill(num)(new QuantedData(w)))))
    val cache_valid = RegInit(Reg(Vec(num, Bool())))
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

}