package final_project

import chisel3._
import chisel3.util._

import chisel3._
import chisel3.tester._
import org.scalatest._
import chisel3.experimental.BundleLiterals._
import chisel3.iotesters._

class Global1(_w: Int, h_w: Int, c_w: Int, id_w: Int, addr_w: Int, bias_w: Int, num: Int) extends Module{
    val io = IO(new Bundle{
        val rd_addr1 = Output(new AddressReadGroup(addr_w, id_w))
        val rd_addr2 = Output(new AddressReadGroup(addr_w, id_w))
        val rd_big = Input(Vec(2, new BigBankReadData(_w)))
        val rd_small = Input(Vec(2, Vec(4, new SmallBankReadData(_w))))
        val rd_valid_in = Input(Bool())
        val rd_valid_out = Output(Bool())
        val weight_addr = Output(UInt(addr_w.W))
        val weight_in = Input(new WeightData())
        val wr_addr = Output(new AddressWriteGroup(addr_w, id_w))
        val bias_in = Input(SInt(bias_w.W))
        val bias_addr = Output(UInt(addr_w.W))
        val packed = Output(new PackedData(_w))
        //val wr_small = Output(Vec(4, UInt((_w*8).W)))
        //val wr_big = Output(Vec(1, UInt((_w*48).W)))
        val quanted = Output(new QuantedData(_w))
        val wr_valid_out = Output(Bool())
        val test_valid_out = Output(Bool())
    })


    val reader1 = Module(new GraphReader(addr_w, h_w, c_w, id_w)).io
    val reader2 = Module(new GraphReader(addr_w, h_w, c_w, id_w)).io
    val read_pack = Module(new PackReadData(_w, h_w, c_w)).io
    val read_switch = Module(new ReadSwitch(_w)).io
    val read_weight = Module(new WeightReader(_w, addr_w)).io
    val calc8x8 = Module(new Calc8x8(_w)).io
    val accu = Module(new Accumu(_w, addr_w, bias_w)).io
    val quant = Module(new Quant(_w)).io
    //val write_switch = Module(new WriteSwitch(w, num))
    //val writer = Module(new Writer())
    //val maxpool = Module(new Maxpool(w))

    

    io.rd_addr1 := reader1.to_banks
    reader1.flag_job := false.B
    reader1.enable := false.B
    reader1.job := 0.U.asTypeOf(reader1.job)
    reader1.job_type := 0.U.asTypeOf(reader1.job_type)

    io.rd_valid_out := reader2.valid_out
    io.rd_addr2 := reader2.to_banks
    reader2.flag_job := false.B
    reader2.enable := false.B
    reader2.job := 0.U.asTypeOf(reader2.job)
    reader2.job_type := 0.U.asTypeOf(reader2.job_type)

    read_weight.enable := false.B
    read_weight.addr_end := 0.U
    read_weight.begin_addr := 0.U
    io.weight_addr := read_weight.addr
    read_weight.flag_job := false.B
    

    read_pack.valid_in := io.rd_valid_in
    read_pack.flag_job := false.B
    read_pack.job := 0.U.asTypeOf(read_pack.job)
    read_pack.from_big := io.rd_big
    read_pack.from_small := io.rd_small

    
    
    read_switch.flag_job := false.B
    read_switch.job := 0.U.asTypeOf(read_switch.job)
    read_switch.valid_in := read_pack.valid_out
    read_switch.from := read_pack.output
    read_switch.from_weight := io.weight_in

    calc8x8.input := read_switch.to_calc8x8
    calc8x8.flag := 0.U.asTypeOf(calc8x8.flag)
    calc8x8.weight := read_switch.to_weight
    calc8x8.valid_in := read_switch.valid_out_calc8x8

    
    accu.in_from_calc8x8 := calc8x8.output
    accu.valid_in := calc8x8.valid_out
    accu.flag_job := false.B
    accu.csum := 0.U.asTypeOf(new AccumuCounter())
    accu.bias_begin_addr := 0.U
    accu.bias_end_addr := 0.U
    io.bias_addr := accu.bias_addr
    accu.bias_in := io.bias_in
    accu.is_in_use := false.B


    quant.in_from_accumu := accu.result
    quant.valid_in := accu.valid_out
    quant.flag_job := false.B
    quant.quant_in := 0.U.asTypeOf(quant.quant_in)
    
    io.quanted := quant.result
    io.test_valid_out := calc8x8.valid_out
    // io.quanted := read_pack.output
    io.wr_valid_out := quant.valid_out

    io.packed := 0.U.asTypeOf(io.packed)
    io.packed.mat := calc8x8.output.mat
    
    io.wr_addr := 0.U.asTypeOf(io.wr_addr)

    
    val state = RegInit(0.U(3.W))
    switch(state){
        is(0.U){
            val (begin_addr, max_addr, min_addr) = (0, 1024, 0)
            val in_chan = 2
            val out_chan = 2
            val (h, w) = (2, 2)
            val (loop_num, loop_h) = (2*out_chan, 1)
            val begin_loop_num1 = out_chan
            val begin_loop_num2 = 0
            val (small_begin_addr, small_max_addr, small_min_addr) = (0, 1024, 0)
            var bank_id_big1 = 0
            var bank_id_small1 = Array(4, 1, 2, 3)
            var bank_id_big2 = 5
            var bank_id_small2 = Array(9, 6, 7, 8)

            var weight_begin_addr = 0
            var weight_addr_end = in_chan*out_chan-1
            
            var accu_csum = out_chan
            var accu_bias_begin_addr = 0
            var accu_bias_end_addr = (out_chan-1)

            var quant_in = 14
            var quant_out = 16
            reader1.flag_job := true.B
            reader1.job_type := ReadType.toConvOrCopy
            reader1.job := GenConvReadJob.gen(
                addr_w, h_w, c_w, id_w,
                loop_num, begin_loop_num1, loop_h,
                h/2, w, in_chan, 
                begin_addr, min_addr, max_addr,
                small_begin_addr, small_min_addr, small_max_addr,
                bank_id_big1, bank_id_small1
            )

            reader2.flag_job := true.B
            reader2.job_type := ReadType.toConvOrCopy
            reader2.job := GenConvReadJob.gen(
                addr_w, h_w, c_w, id_w,
                loop_num, begin_loop_num2, loop_h,
                h/2, w, in_chan, 
                begin_addr, min_addr, max_addr,
                small_begin_addr, small_min_addr, small_max_addr,
                bank_id_big2, bank_id_small2
            )
            
            read_weight.flag_job := true.B
            read_weight.begin_addr := weight_begin_addr.U
            read_weight.addr_end := weight_addr_end.U

            read_pack.flag_job := true.B
            read_pack.job := GenPackJob.gen(addr_w, h_w, c_w, w-1, h-1, in_chan*out_chan-1)

            read_switch.flag_job := true.B
            read_switch.job := ReadSwitchType.toConv

            calc8x8.flag := CalcType.calcConv

            accu.flag_job := true.B
            accu.csum.csum := (accu_csum-1).U
            accu.csum.fsum := (accu_csum-1).U
            accu.is_in_use := true.B
            accu.bias_begin_addr := accu_bias_begin_addr.U
            accu.bias_end_addr := accu_bias_end_addr.U

            quant.flag_job := true.B
            quant.quant_in.in_q := quant_in.U
            quant.quant_in.out_q := quant_out.U

            state := 1.U

        }
        is(1.U){
            reader1.enable := true.B
            reader2.enable := true.B
            read_weight.enable := true.B
            calc8x8.flag := CalcType.calcConv
        }
    }
}

object GenTestWeight{
    def gen(B: Array[Array[Int]]): Array[Int] = {
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
        
        val ret = Array.fill[Int](46)(0)
        var sz = 0
        for(i <- 0 to 5){
            for(j <- 0 to 5){
                if(i!=3&&i!=4&&j!=3&&j!=4){
                    ret(sz) = __B(i)(j)
                    sz = sz+1
                } 
            }
        }
        for(i <- 0 to 5)
            for(j <- 0 to 5)
                if(!(i!=3&&i!=4&&j!=3&&j!=4)&&((i==3)||(i!=4&&j==3))){
                    ret(sz) = __B(i)(j)+__Bi(i)(j)
                    sz = sz+1
                    ret(sz) = __B(i)(j)
                    sz = sz+1
                    ret(sz) = __Bi(i)(j)
                    sz = sz+1
                }
        return ret
    }
}

class ConvTester(dut: Global1, _w: Int, h_w: Int, c_w: Int, id_w: Int, addr_w: Int, bias_w: Int, num: Int) extends PeekPokeTester(dut){
    
    var bank_id_big = Array(0, 5)
    var bank_id_small = Array(Array(4, 1, 2, 3), Array(9, 6, 7, 8))
    var (w, h) = (2, 2)
    var (in_chan, out_chan) = (2, 2)
    var A = Array.tabulate(8*8*w*h, in_chan){
        (i, ic) => i*in_chan+ic
    }
    var small_bank = Array.fill[Int](10, (h/2)*(w/2)*8*in_chan+64*in_chan)(0)
    var big_bank = Array.fill[Int](10, (h/2)*w*48*in_chan+64*in_chan)(0)
    for(i <- 0 to w-1)
        for(j <- 0 to h-1){
            var t1 = bank_id_small(j%2)(if(i%2==1) 3 else 1)
            var t2 = bank_id_small(j%2)(if(i%2==1) 0 else 2)
            for(ic <- 0 to in_chan-1){
                for(k <- 0 to 7){
                    small_bank(t1)((i/2)*(h/2)*8*in_chan+(j/2)*8*in_chan+ic*8+k) = A((i*h+j)*64+k*8)(ic)
                    small_bank(t2)((i/2)*(h/2)*8*in_chan+(j/2)*8*in_chan+ic*8+k) = A((i*h+j)*64+k*8+7)(ic)
                }
                for(k <- 0 to 7)
                    for(l <- 0 to 5){
                        big_bank(bank_id_big(j%2))(i*(h/2)*48*in_chan+(j/2)*48*in_chan+ic*48+(k*6+l)) = A((i*h+j)*64+k*8+l+1)(ic)
                    }
            }
            
        }
    var weight_bank = Array.fill[Int](46*in_chan*out_chan)(0)
    var bias_bank = Array.tabulate(out_chan){
        i => i
    }
    for(i <- 0 to out_chan-1)
        for(j <- 0 to in_chan-1){
            val B = Array.tabulate(3, 3) {
                (i, j) => i*3+j
            }
            val w = GenTestWeight.gen(B)
            for(k <- 0 to 45)
                weight_bank((i*in_chan+j)*46+k) = w(k)
        }
    var read_reg = 0
    var T = 0
    var stop = 0
    while(T<20&&(stop==0)){
        T += 1
        val rd_bias = peek(dut.io.bias_addr).toInt
        poke(dut.io.bias_in, bias_bank(rd_bias))
        if(peek(dut.io.rd_valid_out)==1){
            poke(dut.io.rd_valid_in, true)
            val rd_w = (peek(dut.io.weight_addr)).toInt
            val vis = Array.fill[Int](10, 10)(0)
            val vis_id = Array.fill[Int](10, 10)(0)
            def get_addr(i: Int, j: Int): Int = {
                if(vis(i)(j)!=0) return vis(i)(j)
                //println("("+i+","+j+") addr: "+(if(i==1) (peek(dut.io.rd_addr1.addrs(j).addr)).toInt else (peek(dut.io.rd_addr2.addrs(j).addr)).toInt))
                vis(i)(j) = (if(i==1) (peek(dut.io.rd_addr1.addrs(j).addr)).toInt else (peek(dut.io.rd_addr2.addrs(j).addr)).toInt)
                return vis(i)(j)
            }
            def get_id(i: Int, j: Int): Int = {
                if(vis_id(i)(j)!=0) return vis_id(i)(j)
                //return 0
                //println("("+i+","+j+") addr: "+(if(i==1) (peek(dut.io.rd_addr1.addrs(j).bank_id)).toInt else (peek(dut.io.rd_addr2.addrs(j).bank_id)).toInt))
                vis_id(i)(j) = (if(i==1) (peek(dut.io.rd_addr1.addrs(j).bank_id)).toInt else (peek(dut.io.rd_addr2.addrs(j).bank_id)).toInt)
                return vis_id(i)(j)
            }
            for(i <- 1 to 4){
                for(j <- 0 to 7)
                    poke(dut.io.rd_small(0)(i-1).data(j), small_bank(get_id(1, i))(get_addr(1, i)*8+j))
            }
            for(j <- 0 to 47)  
                poke(dut.io.rd_big(0).data(j), big_bank(get_id(1, 0))(get_addr(1, 0)*48+j))
            for(i <- 1 to 4){
                for(j <- 0 to 7)
                    poke(dut.io.rd_small(1)(i-1).data(j), small_bank(get_id(2, i))(get_addr(2, i)*8+j))
            }
            for(j <- 0 to 47)  
                poke(dut.io.rd_big(1).data(j), big_bank(get_id(2, 0))(get_addr(2, 0)*48+j))
            for(i <- 0 to 15)
                poke(dut.io.weight_in.real(i), weight_bank(rd_w*46+i))
            for(i <- 0 to 9){
                poke(dut.io.weight_in.comp1(i), weight_bank(rd_w*46+16+i*3))
                poke(dut.io.weight_in.comp2(i), weight_bank(rd_w*46+16+i*3+1))
                poke(dut.io.weight_in.comp3(i), weight_bank(rd_w*46+16+i*3+2))
            }
            var addr_str = ""

            for(i <- 0 to 4)
                addr_str += "("+get_addr(1, i)+", "+get_id(1, i)+"), "
            println("rd_addr1: "+addr_str)
            addr_str = ""
            for(i <- 0 to 4)
                addr_str += "("+get_addr(2, i)+", "+get_id(2, i)+"), "
            println("rd_addr2: "+addr_str)

            read_reg = 0
        } else {
            poke(dut.io.rd_valid_in, false)
        }
        if(peek(dut.io.wr_valid_out)==1){
            //stop = 1
            
            println("Quanted Result:")
            for(j <- 0 to 7){
                var str = ""
                for(k <- 0 to 7){
                    var x = peek(dut.io.quanted.mat(j*8+k)).toString()
                    //expect(result.mat(j*8+k), std(j)(k))
                    str = str+x+" "
                } 
                println(str)
            }

        }
        if(peek(dut.io.test_valid_out)==1){
            println("Switch Result:")
            for(j <- 0 to 9){
                var str = ""
                if(j==0){            
                    for(k <- 0 to 9){
                        var x = peek(dut.io.packed.up(k)).toString()
                        //expect(result.mat(j*8+k), std(j)(k))
                        str = str+x+" "
                    }
                } else if(j>=1&&j<=8) {
                    str = str+peek(dut.io.packed.left(j-1)).toString()+" "
                    for(k <- 0 to 7){
                        var x = peek(dut.io.packed.mat((j-1)*8+k)).toString()
                        //expect(result.mat(j*8+k), std(j)(k))
                        str = str+x+" "
                    } 
                    str = str+peek(dut.io.packed.right(j-1)).toString()+" "
                } else {
                    for(k <- 0 to 9){
                        var x = peek(dut.io.packed.down(k)).toString()
                        //expect(result.mat(j*8+k), std(j)(k))
                        str = str+x+" "
                    }
                }
                
                println(str)
            }

        }
        step(1)
    }
}



class ConvSpec extends FlatSpec with Matchers {
    it should "Conv should pass" in {
        val w = 16
        val h_w = 16
        val c_w = 16
        val id_w = 16
        val addr_w = 16
        val bias_w = 36
        val num = 1
        chisel3.iotesters.Driver(() => new Global1(w, h_w, c_w, id_w, addr_w, bias_w, num)) { c =>
            new ConvTester(c, w, h_w, c_w, id_w, addr_w, bias_w, num)
        } should be (true)
    }
}
