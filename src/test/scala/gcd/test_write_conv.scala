// See README.md for license details.

package final_project

import chisel3._
import chisel3.util._
import chisel3.tester._
import org.scalatest._
import chisel3.experimental.BundleLiterals._
import chisel3.iotesters._

class WriteConvTestModule(addr_w: Int, h_w: Int, c_w: Int, id_w: Int, 
            h: Int, w: Int, in_chan: Int, begin_addr: Int, min_addr: Int, max_addr: Int,
            small_begin_addr: Int, small_min_addr: Int, small_max_addr: Int, 
            bank_id_big: Int, bank_id_small: Array[Int], al: Int, ar: Int) extends Module{
    val io = IO(new Bundle{
        val start = Input(Bool())
        val valid_out = Output(Bool())
        val to_banks = Output(new AddressWriteGroup(addr_w, id_w))
    })
    val r = Module(new Writer(16, addr_w, h_w, c_w, id_w))
    val state = RegInit(0.U(2.W))
    
    r.io.flag_job := false.B
    r.io.job := 0.U.asTypeOf(r.io.job)
    r.io.valid_in := false.B
    r.io.in_from_quant := 0.U.asTypeOf(r.io.in_from_quant)
    io.to_banks := r.io.to_banks
    io.valid_out := r.io.valid_out
    when(io.start){
        state := 1.U
    }.otherwise{
        switch(state){
            is(1.U){
                r.io.flag_job := true.B
                r.io.job := GenWriteConvJob.gen(
                    addr_w, h_w, c_w, id_w,
                    h, w, in_chan, begin_addr, max_addr, min_addr, small_begin_addr, small_min_addr, small_max_addr,
                    bank_id_big, bank_id_small, al, ar
                )
                r.io.valid_in := true.B
                state := 2.U
            }
            is(2.U){
                r.io.flag_job := false.B
                r.io.valid_in := true.B
                state := 2.U
            }
        }
    }
}

class WriteConvTester(dut: WriteConvTestModule, std: Array[Array[Tuple2[Int, Int]]]) extends PeekPokeTester(dut) {
    poke(dut.io.start, true.B)
    step(1)
    poke(dut.io.start, false.B)
    step(1)
    for(i <- 0 to 300){
        var str = ""
        str = str+"["+peek(dut.io.valid_out)+"]"
        for(j <- 0 to 2){
            str = str+"("+peek(dut.io.to_banks.addrs(j).bank_id)+","+peek(dut.io.to_banks.addrs(j).addr)+"), "
            if(std(i)(j)._1!=(-1)&&peek(dut.io.valid_out)==1){
                expect(dut.io.to_banks.addrs(j).bank_id, std(i)(j)._1)
                expect(dut.io.to_banks.addrs(j).addr, std(i)(j)._2)    
            }
        }
        //if(i%100==0)
        println(str)
        step(1)
    }
}


class WriteConvSpec extends FlatSpec with Matchers {


    it should "WriteConv should pass" in {
        var (h, w) = (8, 8)
        var in_chan = 8
        var (begin_addr, max_addr, min_addr) = (990, 1010, 12)
        var (small_begin_addr, small_max_addr, small_min_addr) = (540, 600, 29)
        var bank_id_big = 0
        var bank_id_small = Array(1, 2, 3, 4)
        var al = 1
        var ar = 5

        var std = Array.tabulate(10000, 3){
            (i, j) => (0, 0)
        }

        def f(x: Int, L: Int, R: Int): Int = {
            return (x-L)%(R-L+1)+L
        }

        var x = 0
        for(i <- 0 to w-1)
            for(j <- 0 to h-1)
                for(k <- al to ar){
                    std(x)(1) = (
                        bank_id_small(if(i%2==0) 0 else 2),
                        f((((i)/2)*h+j)*in_chan+k+small_begin_addr, small_min_addr, small_max_addr)
                    )
                    std(x)(2) = (
                        bank_id_small(if(i%2==0) 1 else 3),
                        f(((i/2)*(h)+j)*in_chan+k+small_begin_addr, small_min_addr, small_max_addr)
                    )
                    std(x)(0) = (
                        bank_id_big,
                        f((i*(h)+j)*in_chan+k+begin_addr, min_addr, max_addr)
                    )
                    x += 1
                }


        chisel3.iotesters.Driver(() => new WriteConvTestModule(10, 10, 6, 4, 
            h, w, in_chan, begin_addr+al, max_addr, min_addr, small_begin_addr+al, small_min_addr, small_max_addr,
            bank_id_big, bank_id_small, al, ar
        )) { c =>
            new WriteConvTester(c, std)
        } should be (true)
    }
}
