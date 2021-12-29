package final_project

import chisel3._
import chisel3.util._

class TrueDualPortWire(w: Int, addr_w: Int) extends Bundle{
    val addra = Input(UInt(addr_w.W))
    val dina = Input(UInt(w.W))
    val douta = Output(UInt(w.W))
    val wea = Input(Bool())
    val addrb = Input(UInt(addr_w.W))
    val dinb = Input(UInt(w.W))
    val doutb = Output(UInt(w.W))
    val web = Input(Bool())
}


class TrueDualPort(w: Int, addr_w: Int) extends Bundle{
    val clka = Input(Clock())
    val clkb = Input(Clock())
    
    val addra = Input(UInt(addr_w.W))
    val dina = Input(UInt(w.W))
    val douta = Output(UInt(w.W))
    val wea = Input(Bool())
    val addrb = Input(UInt(addr_w.W))
    val dinb = Input(UInt(w.W))
    val doutb = Output(UInt(w.W))
    val web = Input(Bool())
}

object TrueDualPortWire{
    def apply(x: TrueDualPort, w: Int, addr_w: Int): TrueDualPortWire = {
        val ret = Wire(new TrueDualPortWire(w, addr_w))
        x.addra := ret.addra
        x.dina := ret.dina
        ret.douta := x.douta
        x.wea := ret.wea
        x.addrb := ret.addrb
        x.dinb := ret.dinb
        ret.doutb := x.doutb
        x.web := ret.web
        ret.addra := 0.U
        ret.dina := 0.U
        ret.wea := false.B
        ret.addrb := 0.U
        ret.dinb := 0.U
        ret.web := false.B
        return ret
    }
}

class SinglePortROM(w: Int, addr_w: Int) extends Bundle{
    val addra = Input(UInt(addr_w.W))
    val clka = Input(Clock())
    val douta = Output(UInt(w.W))
}

class big_bank0(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new TrueDualPort(w, addr_w))
}

class big_bank1(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new TrueDualPort(w, addr_w))
}

class small_bank0(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new TrueDualPort(w, addr_w))
}
class small_bank1(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new TrueDualPort(w, addr_w))
}

class small_bank2(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new TrueDualPort(w, addr_w))
}

class small_bank3(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new TrueDualPort(w, addr_w))
}

class small_bank4(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new TrueDualPort(w, addr_w))
}

class small_bank5(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new TrueDualPort(w, addr_w))
}

class small_bank6(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new TrueDualPort(w, addr_w))
}

class small_bank7(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new TrueDualPort(w, addr_w))
}
class weight0(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new SinglePortROM(w, addr_w))
}

class bias0(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new SinglePortROM(w, addr_w))
}
class weight0_2(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new SinglePortROM(w, addr_w))
}

class bias0_2(w: Int, addr_w: Int) extends BlackBox{
    val io = IO(new SinglePortROM(w, addr_w))
}

class RAMGroupBundle(w: Int, addr_w: Int, id_w: Int) extends Bundle{
    val rd_valid_in = Input(Bool())
    val rd_valid_out = Output(Bool())
    val rd_addr1 = Input(new AddressReadGroup(addr_w, id_w))
    val rd_addr2 = Input(new AddressReadGroup(addr_w, id_w))
    val rd_big = Output(Vec(2, new BigBankReadData(w)))
    val rd_small = Output(Vec(2, Vec(4, new SmallBankReadData(w))))
    val wr_addr = Input(new AddressWriteGroup(addr_w, id_w))
    val wr_valid_in = Input(Bool())
    val to_bigbank = Input(new BigBankWriteData(w))
    val to_smallbank = Input(Vec(2, new SmallBankWriteData(w)))
}

class RAMGroup(w: Int, addr_w: Int, id_w: Int) extends Module{
    val io = IO(new RAMGroupBundle(w, addr_w, id_w))

    val reg_valid = RegNext(RegNext(io.rd_valid_in, 0.U), 0.U)
    io.rd_valid_out := reg_valid
    io.rd_big := 0.U.asTypeOf(io.rd_big)
    io.rd_small := 0.U.asTypeOf(io.rd_small)



    val a_big_bank0 = Module(new big_bank0(StdPara.big_bank_w, StdPara.big_bank_addr_w))
    val a_big_bank1 = Module(new big_bank1(StdPara.big_bank_w, StdPara.big_bank_addr_w))

    a_big_bank0.io.clka := clock
    a_big_bank0.io.clkb := clock
    a_big_bank1.io.clka := clock
    a_big_bank1.io.clkb := clock



    val a_small_bank0 = Module(new small_bank0(StdPara.small_bank_w, StdPara.small_bank_addr_w))
    val a_small_bank1 = Module(new small_bank1(StdPara.small_bank_w, StdPara.small_bank_addr_w))
    val a_small_bank2 = Module(new small_bank2(StdPara.small_bank_w, StdPara.small_bank_addr_w))
    val a_small_bank3 = Module(new small_bank3(StdPara.small_bank_w, StdPara.small_bank_addr_w))
    val a_small_bank4 = Module(new small_bank4(StdPara.small_bank_w, StdPara.small_bank_addr_w))
    val a_small_bank5 = Module(new small_bank5(StdPara.small_bank_w, StdPara.small_bank_addr_w))
    val a_small_bank6 = Module(new small_bank6(StdPara.small_bank_w, StdPara.small_bank_addr_w))
    val a_small_bank7 = Module(new small_bank7(StdPara.small_bank_w, StdPara.small_bank_addr_w))

    a_small_bank0.io.clka := clock
    a_small_bank0.io.clkb := clock
    a_small_bank1.io.clka := clock
    a_small_bank1.io.clkb := clock
    a_small_bank2.io.clka := clock
    a_small_bank2.io.clkb := clock
    a_small_bank3.io.clka := clock
    a_small_bank3.io.clkb := clock
    a_small_bank4.io.clka := clock
    a_small_bank4.io.clkb := clock
    a_small_bank5.io.clka := clock
    a_small_bank5.io.clkb := clock
    a_small_bank6.io.clka := clock
    a_small_bank6.io.clkb := clock
    a_small_bank7.io.clka := clock
    a_small_bank7.io.clkb := clock


    val big_banks = Array.fill(2)(new TrueDualPortWire(StdPara.big_bank_w, StdPara.big_bank_addr_w))
    val small_banks = Array.fill(8)(new TrueDualPortWire(StdPara.small_bank_w, StdPara.small_bank_addr_w))

    big_banks(0) = TrueDualPortWire(a_big_bank0.io, StdPara.big_bank_w, StdPara.big_bank_addr_w)
    big_banks(1) = TrueDualPortWire(a_big_bank1.io, StdPara.big_bank_w, StdPara.big_bank_addr_w)

    small_banks(0) = TrueDualPortWire(a_small_bank0.io, StdPara.small_bank_w, StdPara.small_bank_addr_w)
    small_banks(1) = TrueDualPortWire(a_small_bank1.io, StdPara.small_bank_w, StdPara.small_bank_addr_w)
    small_banks(2) = TrueDualPortWire(a_small_bank2.io, StdPara.small_bank_w, StdPara.small_bank_addr_w)
    small_banks(3) = TrueDualPortWire(a_small_bank3.io, StdPara.small_bank_w, StdPara.small_bank_addr_w)
    small_banks(4) = TrueDualPortWire(a_small_bank4.io, StdPara.small_bank_w, StdPara.small_bank_addr_w)
    small_banks(5) = TrueDualPortWire(a_small_bank5.io, StdPara.small_bank_w, StdPara.small_bank_addr_w)
    small_banks(6) = TrueDualPortWire(a_small_bank6.io, StdPara.small_bank_w, StdPara.small_bank_addr_w)
    small_banks(7) = TrueDualPortWire(a_small_bank7.io, StdPara.small_bank_w, StdPara.small_bank_addr_w)

    big_banks(0).addra := io.rd_addr1.addrs(0).addr
    big_banks(1).addra := io.rd_addr2.addrs(0).addr

    io.rd_big(0) := RegNext(big_banks(0).douta.asTypeOf(new BigBankReadData(w)), 0.U.asTypeOf(new BigBankReadData(w)))
    io.rd_big(1) := RegNext(big_banks(1).douta.asTypeOf(new BigBankReadData(w)), 0.U.asTypeOf(new BigBankReadData(w)))

    // magic
    val typ = RegInit(VecInit(Seq.fill(2)(0.U(id_w.W))))
    typ(0) := io.rd_addr1.addrs(2).bank_id
    typ(1) := io.rd_addr2.addrs(2).bank_id

    val magic_mat = Array(Array(0, 2, 3, 1), Array(1, 3, 0, 2), Array(2, 0, 1, 3), Array(3, 1, 2, 0))
    def get_which(bank: Int, addr1: Int): Int = {
        for(i <- 0 to 3) if(addr1==magic_mat(1)(i)){
            for(j <- 0 to 3) if(bank==magic_mat(j)(i))
                return j+1
        }
        return -1
    }

    def get_which_res(rd: Int, addr1: Int): Int = {
        for(i <- 0 to 3) if(addr1==magic_mat(1)(i)){
            return magic_mat(rd)(i)
        }
        return -1
    }


    for(i <- 0 to 3){
        small_banks(i).addra := MuxCase(0.U.asTypeOf(small_banks(i).addra), Seq.tabulate(4){
            j => ((io.rd_addr1.addrs(2).bank_id(j)) -> io.rd_addr1.addrs(get_which(i, j)).addr)
        })
        small_banks(i+4).addra := MuxCase(0.U.asTypeOf(small_banks(i+4).addra), Seq.tabulate(4){
            j => ((io.rd_addr2.addrs(2).bank_id(j+4)) -> io.rd_addr2.addrs(get_which(i, j)).addr)
        })   
    }
    for(i <- 0 to 3){
        val x0 = Wire(new SmallBankReadData(w))
        val x1 = Wire(new SmallBankReadData(w))
        x0 := MuxCase(0.U.asTypeOf(new SmallBankReadData(w)), Seq.tabulate(4){
            j => ((typ(0)(j)) -> small_banks(get_which_res(i, j)).douta.asTypeOf(new SmallBankReadData(w)))
        })
        x1 := MuxCase(0.U.asTypeOf(new SmallBankReadData(w)), Seq.tabulate(4){
            j => ((typ(1)(j+4)) -> small_banks(get_which_res(i, j)+4).douta.asTypeOf(new SmallBankReadData(w)))
        })
        io.rd_small(0)(i) := RegNext(x0, 0.U.asTypeOf(new SmallBankReadData(w)))
        io.rd_small(1)(i) := RegNext(x1, 0.U.asTypeOf(new SmallBankReadData(w)))
    }


    big_banks(1).addrb := io.wr_addr.addrs(0).addr
    big_banks(1).dinb := io.to_bigbank.asUInt
    big_banks(0).addrb := io.wr_addr.addrs(0).addr
    big_banks(0).dinb := io.to_bigbank.asUInt
    when(io.wr_addr.addrs(0).bank_id(0)){
        big_banks(0).web := io.wr_valid_in
    }.otherwise{
        big_banks(1).web := io.wr_valid_in
    }
    for(i <- 0 to 3){
        small_banks(i*2).addrb := io.wr_addr.addrs(1).addr
        small_banks(i*2).dinb := io.to_smallbank(0).asUInt
        small_banks(i*2+1).addrb := io.wr_addr.addrs(2).addr
        small_banks(i*2+1).dinb := io.to_smallbank(1).asUInt
        when(io.wr_addr.addrs(1).bank_id(i*2)){
            small_banks(i*2).web := io.wr_valid_in
            small_banks(i*2+1).web := io.wr_valid_in
        }    
    }
    
}

class ROMBiasBundle(para_num: Int) extends Bundle{
    val addr = Input(UInt(StdPara.bias_addr_w.W))
    val out = Output(Vec(para_num, SInt(StdPara.bias_w.W)))
}

class ROMBias(para_num: Int) extends Module{
    val io = IO(new ROMBiasBundle(para_num))
    val rom = Module(new bias0(para_num*StdPara.bias_w, StdPara.bias_addr_w)).io
    rom.clka := clock
    rom.addra := io.addr
    io.out := rom.douta.asTypeOf(Vec(para_num, SInt(StdPara.bias_w.W)))
}

class ROMWeightBundle(para_num: Int) extends Bundle{
    val addr = Input(UInt(StdPara.weight_addr_w.W))
    val out = Output(Vec(para_num, Vec(9, SInt(16.W))))
}

class ROMWeight(para_num: Int) extends Module{
    val io = IO(new ROMWeightBundle(para_num))
    val rom = Module(new weight0(para_num*StdPara.weight_w, StdPara.weight_addr_w)).io
    rom.clka := clock
    rom.addra := RegNext(io.addr, 0.U)
    io.out := rom.douta.asTypeOf(Vec(para_num, Vec(9, SInt(16.W))))
}


class ROMHalfBias(para_num: Int) extends Module{
    val io = IO(new ROMBiasBundle(para_num))
    val rom = Module(new bias0_2(para_num*StdPara.bias_w, StdPara.bias_addr_w)).io
    rom.clka := clock
    rom.addra := io.addr
    io.out := rom.douta.asTypeOf(Vec(para_num, SInt(StdPara.bias_w.W)))

}

class ROMHalfWeight(para_num: Int) extends Module{
    val io = IO(new ROMWeightBundle(para_num))
    val rom = Module(new weight0_2(para_num*StdPara.weight_w, StdPara.weight_addr_w)).io
    rom.clka := clock
    rom.addra := RegNext(io.addr, 0.U)
    io.out := rom.douta.asTypeOf(Vec(para_num, Vec(9, SInt(16.W))))
}