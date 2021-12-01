package final_project

import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

object ReadType extends ChiselEnum{
    val ToConv = Value(0.U)         // Sigmoid, conv, mult
    val ToMaxp = Value(1.U)         // Maxpool
    val ToUps = Value(2.U)          // Upsample
}

class GraphReader(val w: Int, val addr_w: Int, val num: Int, val h_w: Int, val c_w: Int, val id_w: Int) extends Module{
    val io = IO(new Bundle{
        val flag_job = Input(Bool())
        val job = Input(new ReadJobs(addr_w, h_w, c_w, id_w))
        val job_type = Input(ReadType())
        val enable = Input(Bool())
        val valid_out = Output(Bool())
        val to_banks = Output(new AddressReadGroup(addr_w, id_w))
    })
    val job_type = RegInit(Reg(ReadType()))

    val gen = RegInit(Reg(new ReadGroup(addr_w, id_w)))

    io.enable := false.B
    io.to_banks := 0.U.asTypeOf(io.to_banks)

    when(io.flag_job){
        gen.set(io.job)
        job_type := io.job_type
    }.elsewhen(io.enable){
        switch(job_type){
            is(ReadType.ToConv){
                gen.gen_conv()
            }
            is(ReadType.ToMaxp){
                gen.gen_maxp()
            }
            is(ReadType.ToUps){
                gen.gen_ups()
            }
        }
        io.valid_out := ~gen.is_end()
        io.to_banks := gen.output()
    }    
    
    
}