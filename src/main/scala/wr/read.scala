package final_project

import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

object ReadType extends ChiselEnum{
    val toConvOrCopy = Value(0.U)         // Sigmoid, conv, mult
    val toMaxp = Value(1.U)              // Maxpool
}

class GraphReaderBundle(val addr_w: Int, val h_w: Int, val c_w: Int, val id_w: Int, val big_w: Int) extends TransBundle{
    val job = Input(new ReadJobs(addr_w, h_w, c_w, id_w, big_w))
    val job2 = Input(new ReadJobs(addr_w, h_w, c_w, id_w, big_w))
    val signal = Input(Bool())
    val job_type = Input(ReadType())
    val to_banks = Output(new AddressReadGroup(addr_w, id_w))
}

class GraphReader(val addr_w: Int, val h_w: Int, val c_w: Int, val id_w: Int, val big_w: Int) extends Module{
    val io = IO(new GraphReaderBundle(addr_w, h_w, c_w, id_w, big_w))

    io.valid_out := false.B
    io.to_banks := 0.U.asTypeOf(io.to_banks)
    
    val job_type = RegInit(ReadType.toConvOrCopy)

    val gen = RegInit(0.U.asTypeOf(Vec(2, new ReadGroup(addr_w, h_w, c_w, id_w, big_w))))

    val state = RegInit(0.U(1.W))

    when(io.flag_job){
        gen(0).set(io.job)
        gen(1).set(io.job2)
        state := 0.U
        job_type := io.job_type
    }.elsewhen(io.valid_in){
        state := state^io.signal.asUInt
        switch(job_type){
            is(ReadType.toConvOrCopy){
                gen(state).go()
            }
            is(ReadType.toMaxp){
                gen(state).go_maxp()
            }
        }
        io.valid_out := ~gen(state).is_end()
        io.to_banks := gen(state).output()  
    }
    
    
}