package final_project

import chisel3._
import chisel3.util._

import chisel3._
import chisel3.tester._
import org.scalatest._
import chisel3.experimental.BundleLiterals._
import chisel3.iotesters._

class Global2(_w: Int, h_w: Int, c_w: Int, id_w: Int, big_w: Int, addr_w: Int, bias_w: Int, num: Int) extends Module{
    val io = IO(new Bundle{
        val rd_addr1 = Output(new AddressReadGroup(addr_w, id_w))
        val rd_addr2 = Output(new AddressReadGroup(addr_w, id_w))
        val rd_big = Input(Vec(2, new BigBankReadData(_w)))
        val rd_small = Input(Vec(2, Vec(4, new SmallBankReadData(_w))))
        val rd_valid_in = Input(Bool())
        val rd_valid_out = Output(Bool())
        val weight_addr = Output(UInt(addr_w.W))
        val weight_in = Input(Vec(9, SInt(16.W)))
        val wr_addr = Output(new AddressWriteGroup(addr_w, id_w))
        val bias_in = Input(SInt(bias_w.W))
        val bias_addr = Output(UInt(addr_w.W))
        val packed = Output(new PackedData(_w))
        //val wr_small = Output(Vec(4, UInt((_w*8).W)))
        //val wr_big = Output(Vec(1, UInt((_w*48).W)))
        val quanted = Output(new QuantedData(_w))
        val wr_valid_out = Output(Bool())
        val test_valid_out = Output(Bool())
        val to_bigbank = Output(new BigBankWriteData(_w))
        val to_smallbank = Output(Vec(2, new SmallBankWriteData(_w)))
    })




    val reader1 = Module(new GraphReader(addr_w, h_w, c_w, id_w, big_w)).io
    val reader2 = Module(new GraphReader(addr_w, h_w, c_w, id_w, big_w)).io
    val read_pack = Module(new PackReadData(_w, h_w, c_w, big_w)).io
    val read_switch = Module(new ReadSwitch(_w, h_w, c_w, 1)).io
    val read_weight = Module(new WeightReader(_w, addr_w)).io
    val calc8x8 = Module(new Calc8x8(_w, 1)).io
    val accu = Module(new Accumu(_w, addr_w, bias_w, 1)).io
    val quant = Module(new Quant(_w)).io
    val write_switch = Module(new WriteSwitch(_w, 3)).io
    val writer = Module(new RealWriter(_w, addr_w, h_w, c_w, id_w)).io
    val maxpool = Module(new Maxpool(_w)).io
    
    io.rd_addr1 := 0.U.asTypeOf(io.rd_addr1)
    io.rd_addr2 := 0.U.asTypeOf(io.rd_addr2)
    io.rd_valid_out := false.B
    io.weight_addr := 0.U.asTypeOf(io.weight_addr)


    io.rd_addr1 := reader1.to_banks
    reader1.flag_job := false.B
    reader1.valid_in := false.B
    reader1.job := 0.U.asTypeOf(reader1.job)
    reader1.job_type := 0.U.asTypeOf(reader1.job_type)

    io.rd_valid_out := reader2.valid_out
    io.rd_addr2 := reader2.to_banks
    reader2.flag_job := false.B
    reader2.valid_in := false.B
    reader2.job := 0.U.asTypeOf(reader2.job)
    reader2.job_type := 0.U.asTypeOf(reader2.job_type)

    read_weight.valid_in := false.B
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
    read_switch.from_weight(0) := io.weight_in
    read_switch.in_h := 0.U
    read_switch.in_chan := 0.U

    calc8x8.input := read_switch.to_calc8x8
    calc8x8.flag := 0.U.asTypeOf(calc8x8.flag)
    calc8x8.weight := read_switch.to_weight
    calc8x8.valid_in := read_switch.valid_out_calc8x8
    calc8x8.mask := 0.U
    calc8x8.multmap := read_switch.to_multmap

    
    
    accu.in_from_calc8x8 := calc8x8.output
    accu.valid_in := calc8x8.valid_out
    accu.flag_job := false.B
    accu.csum := 0.U
    accu.bias_begin_addr := 0.U
    accu.bias_end_addr := 0.U
    io.bias_addr := accu.bias_addr
    accu.bias_in(0) := io.bias_in
    accu.is_in_use := false.B


    quant.in_from_accumu := accu.result(0)
    quant.valid_in := accu.valid_out(0)
    quant.flag_job := false.B
    quant.quant_in := 0.U.asTypeOf(quant.quant_in)

   
    maxpool.from_big := io.rd_big
    for(t <- 0 to 1){
        maxpool.from_small(t)(0) := io.rd_small(t)(0)
        maxpool.from_small(t)(1) := io.rd_small(t)(1)
    }
        
    maxpool.valid_in := read_switch.valid_out_maxp

    //write_switch.valid_in(1) := false.B
    //write_switch.input(1) := 0.U.asTypeOf(write_switch.input(1))

    write_switch.valid_in(0) := quant.valid_out // conv
    write_switch.valid_in(1) := maxpool.valid_out // maxpool
    write_switch.valid_in(2) := read_switch.valid_out_copy // go through

    write_switch.input(0) := quant.result
    write_switch.input(1) := maxpool.result
    write_switch.input(2) := read_switch.to_copy

    writer.in_from_quant := write_switch.output
    writer.valid_in := write_switch.valid_out
    writer.flag_job := false.B
    writer.job := 0.U.asTypeOf(writer.job)
    io.wr_addr := writer.to_banks
    io.to_bigbank := writer.to_bigbank
    io.to_smallbank := writer.to_smallbank
    io.wr_valid_out := writer.valid_out
    
    /*
    io.wr_addr := 0.U.asTypeOf(io.wr_addr)
    io.to_bigbank := 0.U.asTypeOf(io.to_bigbank)
    io.to_smallbank := 0.U.asTypeOf(io.to_smallbank)
    io.wr_valid_out := false.B
    io.bias_addr := 0.U*/

    
    io.quanted := quant.result
    io.test_valid_out := calc8x8.valid_out
    // io.quanted := read_pack.output

    io.packed := 0.U.asTypeOf(io.packed)
    io.packed.mat := calc8x8.output(0).mat
    /*
        // w, h, wr_w, wr_h
        // in out chan
        // para
        // big addr
        // wr big addr
        // small addr
        // wr small addr
    */
    val paras = GenAllPara(addr_w, h_w, c_w, id_w, big_w,
        2, 2, 2, 2, 
        2, 2,          
        1, 1,            
        0, 1023, 0,   
        1020, 1023, 0, 
        0, 1023, 0,    
        1020, 1023, 0, 
        0, 0, 17, 16
    )
    
    
    val state = RegInit(0.U(3.W))
    switch(state){
        is(0.U){
            paras.set_maxp_reader1(reader1)
            paras.set_maxp_reader2(reader2)
            paras.set_write(writer)
            paras.set_maxpool_switch(read_switch)

            state := 1.U
        }
        is(1.U){
            reader1.valid_in := true.B
            reader2.valid_in := true.B

        }
    }
}


class MaxpoolTester(dut: Global2, _w: Int, h_w: Int, c_w: Int, id_w: Int, addr_w: Int, bias_w: Int, num: Int) extends PeekPokeTester(dut){
    
    var bank_id_big = Array(0, 1)
    var bank_id_small = Array(Array(3, 0, 1, 2), Array(7, 4, 5, 6))
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
    var weight_bank = Array.fill[Int](9*in_chan*out_chan)(0)
    var bias_bank = Array.tabulate(out_chan){
        i => i
    }
    for(i <- 0 to out_chan-1)
        for(j <- 0 to in_chan-1){
            val B = Array.tabulate(3, 3) {
                (i, j) => i*3+j
            }
            for(k <- 0 to 8)
                weight_bank((i*in_chan+j)*9+k) = B(k/3)(k%3)
        }
    var read_reg = 0
    var T = 0
    var stop = 0

    val std = Array.tabulate(8, 8, 2){
        (i, j, t) => {
            var mx = 0
            for(x <- i*2 to i*2+1)
                for(y <- j*2 to j*2+1)
                    if(mx < A(((y/8)*h+(x/8))*64+(x%8)*8+(y%8))(t))
                        mx = A(((y/8)*h+(x/8))*64+(x%8)*8+(y%8))(t)
            mx
        }
    }

    var tt = 0
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
            for(i <- 0 to 8)
                poke(dut.io.weight_in(i), weight_bank(rd_w*9+i))
            
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
            var addr_str = ""
            
            for(i <- 0 to 2)
                addr_str += "("+peek(dut.io.wr_addr.addrs(i).addr)+", "+peek(dut.io.wr_addr.addrs(i).bank_id)+"), "
            println("wr_addr1: "+addr_str)

            println("Written Result:")
            for(j <- 0 to 7){
                var str = peek(dut.io.to_smallbank(0).data(j)).toString()+" "
                expect(dut.io.to_smallbank(0).data(j), std(j)(0)(tt))
                for(k <- 0 to 5){
                    var x = peek(dut.io.to_bigbank.data(j*6+k)).toString()
                    expect(dut.io.to_bigbank.data(j*6+k), std(j)(k+1)(tt))
                    str = str+x+" "
                } 
                str = str+peek(dut.io.to_smallbank(1).data(j)).toString()+" "
                expect(dut.io.to_smallbank(1).data(j), std(j)(7)(tt))
                println(str)
            }

            tt = tt+1
        }
        step(1)
    }
}



class MaxpoolSpec extends FlatSpec with Matchers {
    /*
    it should "Maxpool should pass" in {
        val w = 16
        val h_w = 16
        val c_w = 16
        val id_w = 16
        val addr_w = 16
        val bias_w = 36
        val big_w = 16
        val num = 1
        chisel3.iotesters.Driver(() => new Global2(w, h_w, c_w, id_w, big_w, addr_w, bias_w, num)) { c =>
            new MaxpoolTester(c, w, h_w, c_w, id_w, addr_w, bias_w, num)
        } should be (true)
    }*/
}
