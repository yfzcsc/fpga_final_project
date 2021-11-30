package final_project

import chisel3._
import chisel3.util._

object ReadType extends ChiselEnum{
    val ToConv = Value(0.U)         // Sigmoid, conv, mult
    val ToMaxp = Value(1.U)         // Maxpool
    val ToUps = Value(2.U)          // Upsample
}

class ReadJob(val addr_w: Int, val h_w: Int, val c_w: Int, val id_w: Int) extends Bundle{
    val begin_addr = UInt(addr_w.W)
    val max_addr = UInt(addr_w.W)
    val min_addr = UInt(addr_w.W)
    val h = UInt(h_w.W)
    val w = UInt(h_w.W)
    val loop_num = UInt(c_w.W)
    val block_size = UInt(c_w.W)
    val bank_id: UInt(id_w.W)
}

class ReadGroupJob(val addr_w: Int, val h_w: Int, val c_w: Int) extends Bundle{
    val big = ReadJob(addr_w, h_w, c_w)
    val small = Vec(4, ReadJob(addr_w, h_w, c_w))
}

class GraphReader(val w: Int, val addr_w: Int, val num: Int, val h_w: Int, val c_w: Int, val id_w: Int) extends Module{
    val io = IO(new Bundle{
        val flag_job = Input(Bool())
        val job_in = Input(Vec(2, ReadGroupJob(addr_w, h_w, c_w, id_w)))
        val enable = Input(Bool())
        val valid_out = Output(Bool())
        val to_banks = Output(new AddressGroup(addr_w, id_w))
    })

    val job = RegInit(Reg(new ReadJob(addr_w)))
    val cache = RegInit(Reg(Vec(10, SInt(w.W))))

    val gen0 = RegInit(Reg(ReadGroup()))
    val gen1 = RegInit(Reg(ReadGroup()))

    val state = RegInit(Reg(UInt(1.W)))
    io.enable := false.B
    io.to_banks := 0.U.asTypeOf(io.to_banks)

    when(io.enable){
        when(flag_job){
            gen0 := ReadGroup(job_in(0))
            gen1 := ReadGroup(job_in(1))
            state := 0.U
        }.otherwise{
            switch(job.job_type){
                is(ReadType.ToConv){
                    when(state(0)){
                        gen0.gen_conv()
                    }.otherwise{
                        gen1.gen_conv()
                    }
                    state := ~state
                }
                is(ReadType.ToMaxp){
                    when(state(0)){
                        gen0.gen_maxp()
                    }.otherwise{
                        gen1.gen_maxp()
                    }
                }
                is(ReadType.ToUps){
                    when(state(0)){
                        gen0.gen_through()
                    }.otherwise{
                        gen1.gen_through()
                    }
                    state := ~state
                }
            }
            when(state(0)){
                when(gen0.is_end()){
                    io.to_banks := gen0.output()
                    valid_out := true.B
                }.otherwise{
                    valid_out := false.B
                }
            }.otherwise{
                when(gen1.is_end()){
                    io.to_banks := gen1.output()
                    valid_out := true.B
                }.otherwise{
                    valid_out := false.B
                }
            }
        }    
    }
    
    
}