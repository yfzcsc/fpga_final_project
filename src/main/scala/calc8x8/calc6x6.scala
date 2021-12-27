package final_project

import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

class FirstTransInput(val w: Int) extends Bundle{
    val mat_real = Vec(36, SInt(w.W))
    val mat_comp = Vec(12, SInt(w.W))
}

class FinalTransInput(val w: Int) extends Bundle{
    val mat_real = Vec(36, SInt(w.W))
    val mat_comp = Vec(10, SInt(w.W))
}

class TransOutput(val w: Int) extends Bundle{
    val mat_real = Vec(36, SInt(w.W))
    val mat_comp = Vec(36, SInt(w.W))
}

class FirstTransOutput(val w: Int) extends Bundle{
    val mat_real = Vec(24, SInt(w.W))
    val mat_comp = Vec(24, SInt(w.W))
}

class CalcWeightData extends Bundle{
    val real = Vec(16, SInt(16.W))
}

class WeightData extends Bundle{
    val real = Vec(16, SInt(StdPara.dsp_w.W))
    val sbx = Vec(10, SInt(StdPara.dsp_w.W))
    val rbx = Vec(10, Bool())
    val bx = Vec(10, SInt(StdPara.dsp_w.W))
    val by = Vec(10, SInt(StdPara.dsp_w.W))
}

class InputData(w: Int) extends Bundle {
    val mat = Vec(36, SInt(w.W))
}

class OutputData(val w: Int) extends Bundle {
    val mat = Vec(16, SInt((w*2+6).W))
}


object CalcType extends ChiselEnum {
    val empty  = Value(0.U)
    val leakyReLU = Value(1.U)
    val calcMult = Value(2.U)
    val calcConv = Value(3.U)
}

class Calc6x6(val w: Int, val para_num: Int) extends Module{
    val io = IO(new Bundle{
        val input = Input(new InputData(w))
        val flag = Input(CalcType())
        val weight = Input(Vec(para_num, new WeightData()))
        val output = Output(Vec(para_num, new OutputData(w)))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
    })
    
    io.output := 0.U.asTypeOf(io.output)
    io.valid_out := false.B
    
    val real = Array.fill(para_num, 16)(Module(new Core()).io)
    
    for(t <- 0 to para_num-1)
        for(i <- 0 to 15){
            real(t)(i).flag := 0.U.asTypeOf(real(t)(i).flag)
            real(t)(i).w_a := 0.U.asTypeOf(real(t)(i).w_a)
            real(t)(i).in_b := 0.U.asTypeOf(real(t)(i).in_b)
        }

    val comp = Array.fill(para_num, 10)(Module(new ComplexCore()).io)
    
    for(t <- 0 to para_num-1)
        for(i <- 0 to 9){
            comp(t)(i).sbx := 0.S
            comp(t)(i).rbx := false.B
            comp(t)(i).bx := 0.S
            comp(t)(i).by := 0.S
            comp(t)(i).ax := 0.S
            comp(t)(i).ay := 0.S
        }
    
    
    val reg1 = RegInit(0.U.asTypeOf(new FirstTransInput(w+2)))
    val reg2 = RegInit(0.U.asTypeOf(new FinalTransInput(w+4)))
    val w3 = RegInit(VecInit(Seq.fill(para_num)(0.U.asTypeOf(new TransOutput(w+StdPara.dsp_w+5)))))
    val reg3 = RegInit(VecInit(Seq.fill(para_num)(0.U.asTypeOf(new FirstTransOutput(w+StdPara.dsp_w+6)))))

    _w3 := 0.U.asTypeOf(_w3)
    
    
    def g6(x: Int, y: Int): Int = {
        return x*6+y
    }
    def g4(x: Int, y: Int): Int = {
        return x*4+y
    }

    
    def carry_save(A: SInt, B: SInt, C: SInt): SInt = {
        val _A = Wire(SInt((A.getWidth+1).W))
        val _B = Wire(SInt((A.getWidth+1).W))
        val _C = Wire(SInt((A.getWidth+1).W))
        _A := A
        _B := B
        _C := C
        val r_and = Wire(SInt((A.getWidth+1).W))
        val r_xor = Wire(SInt((A.getWidth+1).W))
        r_and := (_A&(_B|_C))|(_B&_C)
        r_xor := _A^_B^_C
        return (r_and<<1.U)+&r_xor
    }


    def first_trans_input(in: InputData): Unit = {
        for(i <- 0 to 5){

            
            val w2m4 = RegInit(0.S((in.mat(g6(2, i)).getWidth+1).W))
            val w2a4 = RegInit(0.S((in.mat(g6(2, i)).getWidth+1).W))
            val w1a3 = RegInit(0.S((in.mat(g6(1, i)).getWidth+1).W))

            w2m4 := in.mat(g6(4, i))-&in.mat(g6(2, i))
            w2a4 := in.mat(g6(2, i))+&in.mat(g6(4, i))

            w1a3 := in.mat(g6(1, i))+&in.mat(g6(3, i))

            reg1.mat_real(g6(0, i)) := RegNext(in.mat(g6(0, i))-&in.mat(g6(4, i)), 0.S)
            reg1.mat_real(g6(1, i)) := w1a3+&w2a4
            reg1.mat_real(g6(2, i)) := w2a4-&w1a3
            reg1.mat_real(g6(3, i)) := w2m4
            reg1.mat_real(g6(4, i)) := w2m4
            reg1.mat_real(g6(5, i)) := RegNext(in.mat(g6(5, i))-&in.mat(g6(1, i)), 0.S)

            val w1m3 = RegInit(0.S((in.mat(g6(1, i)).getWidth+1).W))
            w1m3 := in.mat(g6(1, i))-&in.mat(g6(3, i))


            reg1.mat_comp(g6(0, i)) := -w1m3  // g(3, i, 6)
            reg1.mat_comp(g6(1, i)) := w1m3  // g(4, i, 6)
        }
    }


    def final_trans_input(in: FirstTransInput): Unit = {
        for(i <- 0 to 5){

            val w13 = RegInit(0.S((in.mat_real(g6(i, 1)).getWidth+1).W))
            val w24 = RegInit(0.S((in.mat_real(g6(i, 2)).getWidth+1).W))
            val w2m4 = RegInit(0.S((in.mat_real(g6(i, 2)).getWidth+1).W))

            w13 := in.mat_real(g6(i, 1))+&in.mat_real(g6(i, 3))
            w24 := in.mat_real(g6(i, 2))+&in.mat_real(g6(i, 4))
            w2m4 := in.mat_real(g6(i, 4))-&in.mat_real(g6(i, 2))
            if(i>=3&&i<=4){
                val c13 = RegInit(0.S((in.mat_comp(g6(i-3, 3)).getWidth+1).W))
                c13 := in.mat_comp(g6(i-3, 3))-&in.mat_comp(g6(i-3, 1))
                reg2.mat_real(g6(i, 3)) := w2m4-&c13
                reg2.mat_real(g6(i, 4)) := w2m4+&c13
            } else {
                reg2.mat_real(g6(i, 3)) := w2m4
                reg2.mat_real(g6(i, 4)) := w2m4
            }
            

            reg2.mat_real(g6(i, 0)) := RegNext(in.mat_real(g6(i, 0))-&in.mat_real(g6(i, 4)), 0.S)
            reg2.mat_real(g6(i, 1)) := w13+&w24
            reg2.mat_real(g6(i, 2)) := w24-&w13
            reg2.mat_real(g6(i, 5)) := RegNext(in.mat_real(g6(i, 5))-&in.mat_real(g6(i, 1)), 0.S)
        }
        val w13 = RegInit(0.S((in.mat_real(g6(0, 1)).getWidth+1).W))
        val w33 = RegInit(0.S((in.mat_real(g6(0, 1)).getWidth+1).W))
        val w24 = RegInit(0.S((in.mat_real(g6(0, 2)).getWidth+1).W))
        val w2m4 = RegInit(0.S((in.mat_real(g6(0, 2)).getWidth+1).W))

        w13 := in.mat_comp(g6(0, 1))+&in.mat_comp(g6(0, 3))
        w24 := in.mat_comp(g6(0, 2))+&in.mat_comp(g6(0, 4))
        w2m4 := in.mat_comp(g6(0, 4))-&in.mat_comp(g6(0, 2))
        w33 := in.mat_real(g6(3, 1))-&in.mat_real(g6(3, 3))

        //(3, 0...5)
        reg2.mat_comp(0) := RegNext(in.mat_comp(g6(0, 0))-&in.mat_comp(g6(0, 4)), 0.S)
        reg2.mat_comp(1) := w13+&w24
        reg2.mat_comp(2) := w24-&w13
        reg2.mat_comp(3) := w2m4-&w33
        reg2.mat_comp(4) := w2m4+&w33
        reg2.mat_comp(5) := RegNext(in.mat_comp(g6(0, 5))-&in.mat_comp(g6(0, 1)), 0.S)

        // (0, 3) (1, 3) (2, 3) (5, 3)
        reg2.mat_comp(6) := RegNext(in.mat_real(g6(0, 3))-&in.mat_real(g6(0, 1)), 0.S)
        reg2.mat_comp(7) := RegNext(in.mat_real(g6(1, 3))-&in.mat_real(g6(1, 1)), 0.S)
        reg2.mat_comp(8) := RegNext(in.mat_real(g6(2, 3))-&in.mat_real(g6(2, 1)), 0.S)
        reg2.mat_comp(9) := RegNext(in.mat_real(g6(5, 3))-&in.mat_real(g6(5, 1)), 0.S)
    }

    def first_trans_output(out: FirstTransOutput, in: TransOutput): Unit = {
        for(i <- 0 to 5)if(i!=4){
            
            val w1a2 = RegInit(0.S((in.mat_real(g6(1, i)).getWidth+1).W))
            val w1m2 = RegInit(0.S((in.mat_real(g6(1, i)).getWidth+1).W))


            w1a2 := in.mat_real(g6(1, i))+&in.mat_real(g6(2, i))
            w1m2 := in.mat_real(g6(1, i))-&in.mat_real(g6(2, i))


            val r34 = RegInit(0.S((in.mat_real(g6(3, i)).getWidth+1).W))
            val c34 = RegInit(0.S((in.mat_comp(g6(3, i)).getWidth+1).W))
            
            if(i==3){
                r34 := in.mat_real(g6(3, 3))+&in.mat_real(g6(3, 4))
                c34 := in.mat_comp(g6(3, 3))+&in.mat_comp(g6(3, 4))    
            } else {
                r34 := in.mat_real(g6(3, i))<<1.U
                c34 := in.mat_comp(g6(3, i))<<1.U
            }
            val r_mat_0_i = RegInit(0.S((in.mat_real(g6(0, i)).getWidth+2).W))
            val r_mat_5_i = RegInit(0.S((in.mat_comp(g6(5, i)).getWidth+2).W))
            
            r_mat_0_i := in.mat_real(g6(0, i))<<(2.U)
            r_mat_5_i := in.mat_real(g6(5, i))<<(2.U)

            out.mat_real(g6(0, i)) := carry_save(w1a2, r34, r_mat_0_i)>>2.U
            out.mat_real(g6(1, i)) := (w1m2-&c34)>>2.U
            out.mat_real(g6(2, i)) := (w1a2-&r34)>>2.U
            out.mat_real(g6(3, i)) := carry_save(w1m2, c34, r_mat_5_i)>>2.U
            
        }

        val _w1a2 = RegInit(0.S((in.mat_real(g6(1, 3)).getWidth+1).W))
        val _w1m2 = RegInit(0.S((in.mat_real(g6(1, 3)).getWidth+1).W))


        _w1a2 := in.mat_comp(g6(1, 3))+&in.mat_comp(g6(2, 3))
        _w1m2 := in.mat_comp(g6(1, 3))-&in.mat_comp(g6(2, 3))

        val _r34 = RegInit(0.S((in.mat_real(g6(3, 3)).getWidth+1).W))
        val _c34 = RegInit(0.S((in.mat_comp(g6(3, 3)).getWidth+1).W))

        _r34 := in.mat_real(g6(3, 4))-&in.mat_real(g6(3, 3))
        _c34 := in.mat_comp(g6(3, 3))-&in.mat_comp(g6(3, 4))
        
        val c_mat_0_3 = RegInit(0.S((in.mat_real(g6(0, 3)).getWidth+2).W))
        val c_mat_5_3 = RegInit(0.S((in.mat_comp(g6(5, 3)).getWidth+2).W))

        c_mat_0_3 := in.mat_comp(g6(0, 3))<<(2.U)
        c_mat_5_3 := in.mat_comp(g6(5, 3))<<(2.U)

        out.mat_comp(g6(0, 3)) := carry_save(_w1a2, _c34, c_mat_0_3)>>2.U
        out.mat_comp(g6(1, 3)) := (_w1m2-&_r34)>>2.U
        out.mat_comp(g6(2, 3)) := (_w1a2-&_c34)>>2.U
        out.mat_comp(g6(3, 3)) := carry_save(_w1m2, _r34, c_mat_5_3)>>2.U
    
    }

    def final_trans_output(output: OutputData, in: FirstTransOutput): Unit = {
        for(i <- 0 to 3){
            val w1a2 = RegInit(0.S((in.mat_real(g6(i, 1)).getWidth).W))
            val w1m2 = RegInit(0.S((in.mat_real(g6(i, 1)).getWidth).W))

            w1a2 := (in.mat_real(g6(i, 1))+&in.mat_real(g6(i, 2)))>>1.U
            w1m2 := (in.mat_real(g6(i, 1))-&in.mat_real(g6(i, 2)))>>1.U

            val r34 = RegInit(0.S((in.mat_real(g6(i, 3)).getWidth).W))
            val c34 = RegInit(0.S((in.mat_comp(g6(i, 3)).getWidth).W))

            r34 := in.mat_real(g6(i, 3))
            c34 := in.mat_comp(g6(i, 3))
            
            val r_mat_0_i = RegInit(0.S((in.mat_real(g6(i, 0)).getWidth+1).W))
            val r_mat_5_i = RegInit(0.S((in.mat_real(g6(i, 5)).getWidth+1).W))

            r_mat_0_i := in.mat_real(g6(i, 0))<<(1.U)
            r_mat_5_i := in.mat_real(g6(i, 5))<<(1.U)

            output.mat(g4(i, 0)) := RegNext(carry_save(w1a2, r34, r_mat_0_i)>>1.U, 0.S)
            output.mat(g4(i, 1)) := RegNext(((w1m2-&c34)>>1.U), 0.S)
            output.mat(g4(i, 2)) := RegNext(((w1a2-&r34)>>1.U), 0.S)
            output.mat(g4(i, 3)) := RegNext(carry_save(w1m2, c34, r_mat_5_i)>>1.U, 0.S)
        }
    }

    val valid_reg = RegInit(VecInit(Seq.fill(11)(false.B)))
    
    first_trans_input(io.input)
    final_trans_input(reg1)
    for(t <- 0 to para_num-1)
        first_trans_output(reg3(t), w3(t))
    valid_reg(1) := valid_reg(0)
    valid_reg(2) := valid_reg(1)
    valid_reg(3) := valid_reg(2)
    valid_reg(4) := valid_reg(3)
    valid_reg(5) := valid_reg(4)
    valid_reg(6) := valid_reg(5)
    valid_reg(7) := valid_reg(6)
    valid_reg(8) := valid_reg(7)
    valid_reg(9) := valid_reg(8)
    valid_reg(10) := valid_reg(9)
    
    for(t <- 0 to para_num-1){
        var y = 0
        for(i <- 0 to 5){
            for(j <- 0 to 5){
                if(i==3){
                    comp(t)(y).sbx := io.weight(t).sbx(y)
                    comp(t)(y).rbx := io.weight(t).rbx(y)
                    comp(t)(y).bx := io.weight(t).bx(y)
                    comp(t)(y).by := io.weight(t).by(y)
                    comp(t)(y).ax := reg2.mat_real(g6(i, j))
                    comp(t)(y).ay := reg2.mat_comp(j)

                    w3(t).mat_real(g6(i, j)) := comp(t)(y).x
                    w3(t).mat_comp(g6(i, j)) := comp(t)(y).y
                    
                    y = y+1
                } else if(i!=4&&j==3){
                    val real_i = if(i>=5) 9 else i+6
                    comp(t)(y).sbx := io.weight(t).sbx(y)
                    comp(t)(y).rbx := io.weight(t).rbx(y)
                    comp(t)(y).bx := io.weight(t).bx(y)
                    comp(t)(y).by := io.weight(t).by(y)
                    comp(t)(y).ax := reg2.mat_real(g6(i, j))
                    comp(t)(y).ay := reg2.mat_comp(real_i)

                    w3(t).mat_real(g6(i, j)) := comp(t)(y).x
                    w3(t).mat_comp(g6(i, j)) := comp(t)(y).y

                    y = y+1
                }
            }
        }
    }
    switch(io.flag){
        is(CalcType.leakyReLU){
            for(i <- 0 to 15){
                real(0)(i).flag := CoreType.leakyReLU
                real(0)(i).in_b := io.input.mat((i/4)*6+(i%4))
                io.output(0).mat(i) := real(0)(i).result
            }
            io.valid_out := RegNext(RegNext(io.valid_in, false.B), false.B)
        }

        is(CalcType.calcMult){
            for(i <- 0 to 15){
                real(0)(i).flag := CoreType.calcMult
                real(0)(i).in_b := io.input.mat((i/4)*6+(i%4))
                real(0)(i).w_a := io.weight(0).real(i)
                io.output(0).mat(i) := real(0)(i).result
            }
         
            io.valid_out := RegNext(RegNext(io.valid_in, false.B), false.B)
        }
        
        is(CalcType.calcConv){
            valid_reg(0) := io.valid_in
            for(t <- 0 to para_num-1)
                final_trans_output(io.output(t), reg3(t))
			
            
            for(t <- 0 to para_num-1){
                var x = 0
                var y = 0
                for(i <- 0 to 5){
                    for(j <- 0 to 5){
                        if(i!=3&&i!=4&&j!=3&&j!=4){
                            real(t)(x).flag := CoreType.calcMult
                            real(t)(x).in_b := reg2.mat_real(g6(i, j))
                            real(t)(x).w_a := io.weight(t).real(x)
                            _w3(t).mat_real(g6(i, j)) := real(t)(x).result
                            x = x+1
                        }
                    }
                }
            }
            io.valid_out := valid_reg(10)
            
        }
    }
}
