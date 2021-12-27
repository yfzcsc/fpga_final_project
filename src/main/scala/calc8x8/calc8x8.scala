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
    val mat = Vec(64, SInt((w*2+20).W))
}

class Calc8x8(val w: Int, val para_num: Int) extends Module{
    val io = IO(new Bundle{
        val input = Input(new PackedData(w))
        val flag = Input(CalcType())
        val mask = Input(UInt(para_num.W))
        val weight = Input(Vec(para_num, new CalcWeightData()))
        val multmap = Input(Vec(4, new CalcWeightData()))
        val output = Output(Vec(para_num, new RawData(w)))
        val valid_in = Input(Bool())
        val valid_out = Output(UInt(para_num.W))
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
    io.output := 0.U.asTypeOf(io.output)
    io.valid_out := 0.U
    
    val A = VecInit(Seq.fill(4)(Module(new Calc6x6(w, para_num)).io))
    for(i <- 0 to 3){
        A(i).input := 0.U.asTypeOf(A(i).input)
        A(i).flag := 0.U.asTypeOf(A(i).flag)
        A(i).weight := 0.U.asTypeOf(A(i).weight)
        A(i).valid_in := false.B
    }
        
    
    
    val B = Wire(Vec(para_num, Vec(3, Vec(3, SInt(16.W)))))
    val _B = RegInit(0.U.asTypeOf(Vec(para_num, Vec(6, Vec(3, SInt(18.W))))))
    val _Bi = RegInit(0.U.asTypeOf(Vec(para_num, Vec(6, Vec(3, SInt(18.W))))))

    for(t <- 0 to para_num-1)
        for(i <- 0 to 8)
            B(t)(i/3)(i%3) := io.weight(t).real(i)

    for(t <- 0 to para_num-1)
        for(j <- 0 to 2){
            val w0m2 = RegNext(B(t)(0)(j)-&B(t)(2)(j), 0.S)
            val w0a2 = RegNext(B(t)(0)(j)+&B(t)(2)(j), 0.S)

            val b_t_1_j = RegNext(B(t)(1)(j), 0.S)

            _B(t)(0)(j) := RegNext(B(t)(0)(j), 0.S)
            _B(t)(1)(j) := w0a2+&b_t_1_j
            _B(t)(2)(j) := w0a2-&b_t_1_j
            _B(t)(3)(j) := w0m2
            _B(t)(4)(j) := w0m2
            _B(t)(5)(j) := RegNext(B(t)(2)(j), 0.S)
            _Bi(t)(3)(j) := b_t_1_j
            _Bi(t)(4)(j) := -b_t_1_j
        }

    
    val __B = RegInit(0.U.asTypeOf(Vec(para_num, Vec(6, Vec(6, SInt(20.W))))))
    val __Bi = RegInit(0.U.asTypeOf(Vec(para_num, Vec(6, Vec(6, SInt(20.W))))))

    for(t <- 0 to para_num-1)
        for(i <- 0 to 5){

            
            val w0m2 = RegNext(_B(t)(i)(0)-&_B(t)(i)(2), 0.S)
            val w0a2 =RegNext(_B(t)(i)(0)+&_B(t)(i)(2), 0.S)

            val b_t_i_1 = RegNext(_B(t)(i)(1), 0.S)
            val bi_t_i_1 = RegNext(_Bi(t)(i)(1), 0.S)


            __B(t)(i)(0) := RegNext(_B(t)(i)(0), 0.S)
            __B(t)(i)(1) := w0a2+&b_t_i_1
            __B(t)(i)(2) := w0a2-&b_t_i_1
            __B(t)(i)(3) := w0m2-&bi_t_i_1
            __B(t)(i)(4) := w0m2+&bi_t_i_1
            __B(t)(i)(5) := RegNext(_B(t)(i)(2), 0.S)

            val cw0m2 = RegNext(_Bi(t)(i)(0)-&_Bi(t)(i)(2), 0.S)
            val cw0a2 = RegNext(_Bi(t)(i)(0)+&_Bi(t)(i)(2), 0.S)

            __Bi(t)(i)(0) := RegNext(_Bi(t)(i)(0), 0.S)
            __Bi(t)(i)(1) := cw0a2+&bi_t_i_1
            __Bi(t)(i)(2) := cw0a2-&bi_t_i_1
            __Bi(t)(i)(3) := cw0m2+&b_t_i_1
            __Bi(t)(i)(4) := cw0m2-&b_t_i_1
            __Bi(t)(i)(5) := RegNext(_Bi(t)(i)(2), 0.S)
        }

    val conv_weight = Wire(Vec(para_num, new WeightData()))
    // val conv_weight = RegInit(0.U.asTypeOf(new WeightData()))

    def clamp_18(x: SInt): SInt = {
        // return x
        val xx = StdPara.dsp_w
        val r = ((1<<(xx-1))-1).S(20.W)
        val l = (-(1<<(xx-1))).S(20.W)
        return Mux(x>=r, r, Mux(x<=l, l, x))
        //return Mux((~x(18))&&x(17), ((1<<17)-1).S(18.W), Mux(x(18)&&(~x(17)), (-(1<<17)).S(18.W), x))
    }

    for(t <- 0 to para_num-1){
        var x = 0
        var y = 0
        for(i <- 0 to 5){
            for(j <- 0 to 5){
                if(i!=3&&i!=4&&j!=3&&j!=4){
                    conv_weight(t).real(x) := clamp_18(__B(t)(i)(j))
                    x = x+1
                } else if(i==3||(i!=4&&j==3)){
                    val __Bx = Wire(SInt(StdPara.dsp_w.W))
                    val __Bix = Wire(SInt(StdPara.dsp_w.W))
                    __Bx := clamp_18(__B(t)(i)(j))
                    __Bix := clamp_18(__Bi(t)(i)(j))
                    conv_weight(t).sbx(y) := ((__Bx+&__Bix)>>1.U)
                    conv_weight(t).rbx(y) := __Bx(0)^__Bix(0)
                    conv_weight(t).bx(y) := __Bx
                    conv_weight(t).by(y) := __Bix
                    y = y+1
                }
            }
        }
    }
        


    switch(io.flag){
        is(CalcType.leakyReLU){
            A(0).input := get_area(io.input, 1, 1, 4, 4)
            A(1).input := get_area(io.input, 1, 5, 4, 8)
            A(2).input := get_area(io.input, 5, 1, 8, 4)
            A(3).input := get_area(io.input, 5, 5, 8, 8)
            for(i <- 0 to 3){
                A(i).flag := CalcType.leakyReLU
                A(i).valid_in := io.valid_in
            }
            io.output(0) := set_output(A(0).output(0), A(1).output(0), A(2).output(0), A(3).output(0))
            io.valid_out := (if(para_num==1) A(0).valid_out else Cat(0.U((para_num-1).W), A(0).valid_out))
        }
        is(CalcType.calcMult){
            A(0).input := get_area(io.input, 1, 1, 4, 4)
            A(1).input := get_area(io.input, 1, 5, 4, 8)
            A(2).input := get_area(io.input, 5, 1, 8, 4)
            A(3).input := get_area(io.input, 5, 5, 8, 8)
            for(i <- 0 to 3){
                A(i).weight(0).real := io.multmap(i).real
                A(i).flag := CalcType.calcMult
                A(i).valid_in := io.valid_in
            }
            io.output(0) := set_output(A(0).output(0), A(1).output(0), A(2).output(0), A(3).output(0))
            io.valid_out := (if(para_num==1) A(0).valid_out else Cat(0.U((para_num-1).W), A(0).valid_out))
        }
        is(CalcType.calcConv){
            A(0).input := get_area(io.input, 0, 0, 5, 5)
            A(1).input := get_area(io.input, 0, 4, 5, 9)
            A(2).input := get_area(io.input, 4, 0, 9, 5)
            A(3).input := get_area(io.input, 4, 4, 9, 9)
            for(i <- 0 to 3){
                A(i).weight := conv_weight
                A(i).flag := CalcType.calcConv
                A(i).valid_in := io.valid_in
            }
            for(t <- 0 to para_num-1)
                io.output(t) := set_output(A(0).output(t), A(1).output(t), A(2).output(t), A(3).output(t))
            io.valid_out := Cat(Seq.tabulate(para_num){
                i => A(0).valid_out&io.mask(para_num-1-i)
            }) 
        }
        
        is(CalcType.empty){
            io.valid_out := io.valid_in
            for(i <- 0 to 63)
                io.output(0).mat(i) := io.input.mat(i)
        }
    }
}
