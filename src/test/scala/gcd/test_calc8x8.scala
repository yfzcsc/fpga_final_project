// See README.md for license details.

package final_project

import chisel3._
import chisel3.tester._
import org.scalatest._
import chisel3.experimental.BundleLiterals._
import chisel3.iotesters._

class Calc8x8Tester(dut: Calc8x8) extends PeekPokeTester(dut) {

    //val rnd = new scala.util.Random
    val T = 10
    for(t <- 0 until T){
        var A = Array.tabulate(10, 10) {
            (i, j) => rnd.nextInt(5)-32768
        }
        for(i <- 0 to 63){
            poke(dut.io.input.mat(i), A(i/8+1)(i%8+1))
        }
        for(i <- 0 to 9) {
            poke(dut.io.input.up(i), A(0)(i))
        }
        for(i <- 0 to 7) {
            poke(dut.io.input.left(i), A(i+1)(0))
        }
        for(i <- 0 to 7) {
            poke(dut.io.input.right(i), A(i+1)(9))
        }
        for(i <- 0 to 9) {
            poke(dut.io.input.down(i), A(9)(i))
        }

        val B = Array.fill[Int](4, 3, 3)(0)
        for(t <- 0 to 3)
            for(i <- 0 to 8) B(t)(i/3)(i%3) = rnd.nextInt(32768)-16384
            //rnd.nextInt(5)-32768

        val std = Array.tabulate(4, 8, 8) {
            (t, i, j) => {
                var sum = BigInt(0)
                for(ii <- i to i+2)
                    for(jj <- j to j+2){
                        var a = A(ii)(jj)
                        var b = B(t)(ii-i)(jj-j)
                        sum = sum+BigInt(a)*b
                    }
                        
                sum
            }
        }
        for(t <- 0 to 3)
            for(i <- 0 to 8)
                poke(dut.io.weight(t).real(i), B(t)(i/3)(i%3))

        poke(dut.io.flag, 3)
        poke(dut.io.mask, 15)
        poke(dut.io.valid_in, true)
        var stop = false
        while(!stop){
            step(1)
            poke(dut.io.valid_in, false)
            if(peek(dut.io.valid_out)==15){
                println("[valid: " + peek(dut.io.valid_out).toString + "] Result:")
                for(t <- 0 to 3)
                    for(j <- 0 to 7){
                        var str = ""
                        for(k <- 0 to 7){
                            var x = peek(dut.io.output(t).mat(j*8+k)).toString()
                            expect(dut.io.output(t).mat(j*8+k), std(t)(j)(k))
                            str = str+x+" "
                        } 
                        println(str)
                    }

                stop = true
            }
            
        }
    }
    
    /*
    val _B = Array.fill[Int](6, 3)(0)
    val _Bi = Array.fill[Int](6, 3)(0)
    for(j <- 0 to 2){
        _B(0)(j) = B(0)(j)
        _B(1)(j) = B(0)(j)+B(1)(j)+B(2)(j)
        _B(2)(j) = B(0)(j)-B(1)(j)+B(2)(j)
        _B(3)(j) = B(0)(j)-B(2)(j)
        _B(4)(j) = B(0)(j)-B(2)(j)
        _B(5)(j) = B(2)(j)
        _Bi(3)(j) = B(1)(j)
        _Bi(4)(j) = -B(1)(j)
    }

    val __B = Array.fill[Int](6, 6)(0)
    val __Bi = Array.fill[Int](6, 6)(0)

    for(i <- 0 to 5){
        __B(i)(0) = _B(i)(0)
        __B(i)(1) = _B(i)(0)+_B(i)(1)+_B(i)(2)
        __B(i)(2) = _B(i)(0)-_B(i)(1)+_B(i)(2)
        __B(i)(3) = _B(i)(0)-_B(i)(2)-_Bi(i)(1)
        __B(i)(4) = _B(i)(0)-_B(i)(2)+_Bi(i)(1)
        __B(i)(5) = _B(i)(2)
        __Bi(i)(0) = _Bi(i)(0)
        __Bi(i)(1) = _Bi(i)(0)+_Bi(i)(1)+_Bi(i)(2)
        __Bi(i)(2) = _Bi(i)(0)-_Bi(i)(1)+_Bi(i)(2)
        __Bi(i)(3) = _Bi(i)(0)-_Bi(i)(2)+_B(i)(1)
        __Bi(i)(4) = _Bi(i)(0)-_Bi(i)(2)-_B(i)(1)
        __Bi(i)(5) = _Bi(i)(2)
    }
    
    for(t <- 0 to 3){
        var x = 0
        var y = 0
        for(i <- 0 to 5){
            for(j <- 0 to 5){
                if(i!=3&&i!=4&&j!=3&&j!=4){
                    poke(dut.io.weight(t).real(x), __B(i)(j))
                    x = x+1
                } else if(i==3){
                    poke(dut.io.weight(t).comp1(y), __B(i)(j)+__Bi(i)(j))
                    poke(dut.io.weight(t).comp2(y), __B(i)(j))
                    poke(dut.io.weight(t).comp3(y), __Bi(i)(j))
                    y = y+1
                } else if(i!=4&&j==3){
                    poke(dut.io.weight(t).comp1(y), __B(i)(j)+__Bi(i)(j))
                    poke(dut.io.weight(t).comp2(y), __B(i)(j))
                    poke(dut.io.weight(t).comp3(y), __Bi(i)(j))
                    y = y+1
                }
            }
        }
    }*/
    
}


class Calc8x8Spec extends FlatSpec with Matchers {

  it should "Calc8x8 should pass" in {
        chisel3.iotesters.Driver(() => new Calc8x8(16, 4)) { c =>
            new Calc8x8Tester(c)
        } should be (true)
    }
}
