package final_project

import chisel3._
import chisel3.util._


class PackedData(val w: Int) extends Bundle {
    val mat = Vec(64, SInt(w.W))
    val up = Vec(10, SInt(w.W))
    val down = Vec(10, SInt(w.W))
    val left = Vec(8, SInt(w.W))
    val right = Vec(8, SInt(w.W))
}

class RawData(val w: Int) extends Bundle {
    val mat = Vec(64, SInt((w*2+5).W))
}

class Calc8x8(val w: Int) extends Module{
    val io = IO(new Bundle{
        val input = Input(new PackedData(w))
        val flag = Input(CalcType())
        val weight = Input(Vec(4, new WeightData(w)))
        val output = Output(new RawData(w))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
    })

    def get_one(a: PackedData, x: Int, y: Int): Data = {
        if(x==0) return a.up(y)
        if(x==9) return a.down(y)
        if(y==0) return a.left(x-1)
        if(y==9) return a.right(x-1)
        return a.mat((x-1)*8+(y-1))
    }
    def get_area(a: PackedData, lx: Int, ly: Int, rx: Int, ry: Int): Data = {
        val ret = Wire(new InputData(w))
        for(i <- 0 to 5)
            for(j <- 0 to 5)
                ret.mat(i*6+j) := (if(i<rx-lx+1&&j<ry-ly+1) get_one(a, i+lx, j+ly) else 0.S)
        return ret
    }

    def set_output(a0: OutputData, a1: OutputData, a2: OutputData, a3: OutputData): Data = {
        val ret = Wire(new RawData(w))
        for(i <- 0 to 3)
            for(j <- 0 to 3)
                ret.mat(i*8+j) := a0.mat(i*4+j)
        for(i <- 0 to 3)
            for(j <- 4 to 7)
                ret.mat(i*8+j) := a1.mat(i*4+(j-4))
        for(i <- 4 to 7)
            for(j <- 0 to 3)
                ret.mat(i*8+j) := a2.mat((i-4)*4+j)
        for(i <- 4 to 7)
            for(j <- 4 to 7)
                ret.mat(i*8+j) := a3.mat((i-4)*4+(j-4))
        return ret
    }
    
    val A = VecInit(Seq.fill(4)(Module(new Calc6x6(w)).io))
    for(i <- 0 to 3){
        A(i).input := 0.S.asTypeOf(A(i).input)
        A(i).flag := CalcType.saveWeight
        A(i).weight := 0.S.asTypeOf(A(i).weight)
    }
        
    io.output := 0.S.asTypeOf(io.output)

    switch(io.flag){
        is(CalcType.leakyReLU){
            A(0).input := get_area(io.input, 1, 1, 4, 4)
            A(1).input := get_area(io.input, 1, 4, 4, 8)
            A(2).input := get_area(io.input, 4, 1, 8, 4)
            A(3).input := get_area(io.input, 4, 4, 8, 8)
            for(i <- 0 to 3)
                A(i).flag := CalcType.leakyReLU
            io.output := set_output(A(0).output, A(1).output, A(2).output, A(3).output)
        }
        is(CalcType.calcMult){
            A(0).input := get_area(io.input, 1, 1, 4, 4)
            A(1).input := get_area(io.input, 1, 4, 4, 8)
            A(2).input := get_area(io.input, 4, 1, 8, 4)
            A(3).input := get_area(io.input, 4, 4, 8, 8)
            for(i <- 0 to 3)
                A(i).weight := io.weight(i)
            for(i <- 0 to 3)
                A(i).flag := CalcType.preCalcMult
            io.output := set_output(A(0).output, A(1).output, A(2).output, A(3).output)
        }
        is(CalcType.calcConv){
            A(0).input := get_area(io.input, 0, 0, 5, 5)
            A(1).input := get_area(io.input, 0, 4, 5, 9)
            A(2).input := get_area(io.input, 4, 0, 9, 5)
            A(3).input := get_area(io.input, 4, 4, 9, 9)
            for(i <- 0 to 3)
                A(i).weight := io.weight(i)
            for(i <- 0 to 3)
                A(i).flag := CalcType.preCalcMult
            io.output := set_output(A(0).output, A(1).output, A(2).output, A(3).output)
        }
    }
}
