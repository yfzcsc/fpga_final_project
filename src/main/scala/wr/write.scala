package final_project

import chisel3._
import chisel3.util._

class Address(val addr_w: Int) extends Bundle{
    val addr = UInt(addr_w.W)
    def inc[T <: Data](x: T): Data = {
        addr := addr+x
        return addr
    }
}

object Address{
    def zero(addr_w: Int): Address{
        val ret = new Address(addr_w)
        ret.addr = 0.U(addr_w)
        return ret
    }
}

class BigBankWriteData(val w: Int, val addr_w: Int) extends Bundle{
    val data = Vec(48, SInt(w.W))
    val addr = new Address(addr_w)
    val wra = Bool()
}

class SmallBankWriteData(val w: Int, val addr_w: Int) extends Bundle{
    val data = Vec(8, SInt(w.W))
    val addr = new Address(addr_w)
    val wra = Bool()
}

class WriteJob(val addr_w: Int) extends Bundle{
    val begin_addr_big = new Address(addr_w.W)
    val begin_addr_small = Vec(4, new Address(addr_w.W))
    val begin_small_bank = UInt(2.W)
    val is_in_use = Bool()
}

object WriteJob{
    def zero(addr_w: Int): WriteJob{
        val ret = new WriteJob(addr_w)
        ret.begin_addr_big = Address.zero(addr_w)
        for(i <- 0 to 3)
            ret.begin_addr_small(i) = Address.zero(addr_w)
        ret.begin_small_bank = 0.U
        ret.is_in_use = false.B
        return ret
    }
}

// 2*18K (4 banks) and 22*18K (1 bank)

class Writer(val w: Int, val addr_w: Int) extends Module{
    val io = IO(new Bundle{
        val in_from_quant = Input(new QuantedData(w))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
        val flag_job = Input(Bool())
        val job = Input(new WriteJob(addr_w))
        val to_bigbank = Output(new BigBankWriteData(w, addr_w))
        val to_smallbank = Output(Vec(4, new SmallBankWriteData(w, addr_w)))
    })

    val big_addr = RegInit(0.U(addr_w.W).asTypeOf(io.job.begin_addr_big))
    val small_addr = RegInit(Vec(4, 0.U(addr_w.W).asTypeOf(io.job.begin_addr_small)))
    val small_bank = RegInit(0.U(2.W))
    val is_in_use = RegInit(false.B)

    io.valid_out := false.B 
    io.to_bigbank := 0.U.asTypeOf(io.to_bigbank)
    io.to_smallbank := 0.U.asTypeOf(io.to_smallbank)
    
    when(io.flag_job){
        big_addr := io.job.begin_addr_big
        small_addr := io.job.begin_addr_small
        small_bank := io.job.begin_small_bank
        is_in_use := io.job.is_in_use
    }.elsewhen(is_in_use){
        when(io.valid_in){
            io.valid_out := true.B
            io.to_bigbank.wra := true.B
            io.to_smallbank(small_bank).wra := true.B
            io.to_smallbank(small_bank+1.U).wra := true.B
            io.to_bigbank.addr := big_addr.addr.inc(1.U)
            io.to_smallbank(small_bank).addr := small_Addr(small_bank).inc(1.U)
            io.to_smallbank(small_bank+1.U).addr := small_Addr(small_bank+1.U).inc(1.U)

            io.to_smallbank(small_bank).addr := true.B
            io.to_smallbank(small_bank+1.U).addr := true.B
            for(i <- 0 to 7)
                for(j <- 0 to 5)
                    io.to_bigbank.data(i*6+j) := io.in_from_quant.mat(i*8+(j+1))
            for(i <- 0 to 7)
                io.to_smallbank.data(small_bank) := io.in_from_quant.mat(i*8)
            for(i <- 0 to 7)
                io.to_smallbank.data(small_bank+1.U) := io.in_from_quant.mat(i*8+7)
            small_bank := small_bank+2.U

        }
    }
}


class CacheWriter(val w: Int, val addr_w: Int, val num: Int) extends Module{
    val io = IO(new Bundle{
        val in_from_quant = Input(Vec(num, new QuantedData(w)))
        val valid_in = Input(Vec(num, Bool()))
        val valid_out = Output(Bool())
        val flag_job = Input(Bool())
        val jobs_in = Input(Vec(num, new WriteJob(addr_w)))
        val to_bigbank = Output(new BigBankWriteData(w, addr_w))
        val to_smallbank = Output(Vec(4, new SmallBankWriteData(w, addr_w)))
    })

    val writers = VecInit(Seq.fill(num)(Module(new Writer).io))
    val cache = RegInit(Reg(VecInit(Seq.fill(num)(new QuantedData(w)))))
    val cache_valid = RegInit(Reg(Vec(num, Bool())))
    val now = PriorityMux(cache_valid, Seq.tabulate(num){i => i})
    val jobs = RegInit(Reg(Vec(num, new WriteJob(addr_w))))

    io.to_bigbank := 0.U.asTypeOf(io.to_bigbank)
    io.to_smallbank := 0.U.asTypeOf(io.to_smallbank)
    valid_out := false.B
    for(i <- 0 to num-1)
        writers(i) := 0.U.asTypeOf(writers(i))

    when(io.flag_job){
        jobs := io.jobs_in
        cache_valid := 0.U.asTypeOf(cache_valid)
        for(i <- 0 to num-1){
            writers(i).job := jobs(i)
            writers(i).flag_job := true.B
        }
    }.otherwise{
        for(i <- 0 to num-1)
            cache := io.in_from_quant(i)
        for(i <- 0 to num-1)
            cache_valid := cache_valid|io.valid_in(i)
        when(cache_valid[now]){
            writers(now).valid_in := true.B
            writers(now).in_from_quant := cache(now)
            io.to_bigbank := writers(now).to_bigbank
            io.to_smallbank := writers(now).to_smallbank
            cache_valid(now) := io.valid_in(i)
        }
    }

}