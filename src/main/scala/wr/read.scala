package final_project

import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

object ReadType extends ChiselEnum{
    val toConvOrCopy = Value(0.U)         // Sigmoid, conv, mult
    val toMaxp = Value(1.U)              // Maxpool
}

class GraphReaderBundle(val addr_w: Int, val h_w: Int, val c_w: Int, val id_w: Int) extends TransBundle{
    val job = Input(new ReadJobs(addr_w, h_w, c_w, id_w))
    val job_type = Input(ReadType())
    val to_banks = Output(new AddressReadGroup(addr_w, id_w))
}

class GraphReader(val addr_w: Int, val h_w: Int, val c_w: Int, val id_w: Int) extends Module{
    val io = IO(new GraphReaderBundle(addr_w, h_w, c_w, id_w))

    io.valid_out := false.B
    io.to_banks := 0.U.asTypeOf(io.to_banks)
    
    val job_type = RegInit(ReadType.toConvOrCopy)

    val gen = RegInit(0.U.asTypeOf(new ReadGroup(addr_w, h_w, c_w, id_w)))

    when(io.flag_job){
        gen.set(io.job)
        job_type := io.job_type
    }.elsewhen(io.valid_in){
        switch(job_type){
            is(ReadType.toConvOrCopy){
                gen.go()
            }
            is(ReadType.toMaxp){
                gen.go_maxp()
            }
        }
        io.valid_out := ~gen.is_end()
        io.to_banks := gen.output()
    }
    
    
}