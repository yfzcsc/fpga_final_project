// See README.md for license details.

package final_project

import chisel3._
import chisel3.tester._
import org.scalatest._
import chisel3.experimental.BundleLiterals._
import chisel3.iotesters._

class LeakyReLUTester(dut: Calc8x8) extends PeekPokeTester(dut) {

    //val rnd = new scala.util.Random
    var A = Array.tabulate(8, 8) {
        (i, j) => rnd.nextInt(65536)-32768
    }
    for(i <- 0 to 63){
        poke(dut.io.input.mat(i), A(i/8)(i%8))
    }


    val std = Array.tabulate(8, 8) {
        (i, j) => {
            if(A(i)(j)<0) A(i)(j)*6554 else A(i)(j)*32768
        }
    }

    poke(dut.io.flag, 1)
    poke(dut.io.mask, 1)
    poke(dut.io.valid_in, true)
    var stop = false
    var fuck = 0
    while(!stop&&fuck<=20){
        step(1)
        fuck += 1
        println("[valid: " + peek(dut.io.valid_out).toString + "] Result:")
        if(peek(dut.io.valid_out)==1){
            for(j <- 0 to 7){
                var str = ""
                for(k <- 0 to 7){
                    var x = peek(dut.io.output(0).mat(j*8+k)).toString()
                    expect(dut.io.output(0).mat(j*8+k), std(j)(k))
                    str = str+x+" "
                } 
                println(str)
            }

            stop = true
        }
        
    }
    
}


class LeakyReLUSpec extends FlatSpec with Matchers {

  it should "LeakyReLU should pass" in {
        chisel3.iotesters.Driver(() => new Calc8x8(16, 4)) { c =>
            new LeakyReLUTester(c)
        } should be (true)
    }
}
