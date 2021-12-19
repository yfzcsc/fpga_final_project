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
    val real = Vec(16, SInt(18.W))
    val comp1 = Vec(10, SInt(18.W))
    val comp2 = Vec(10, SInt(18.W))
    val comp3 = Vec(10, SInt(18.W))
}

class InputData(w: Int) extends Bundle {
    val mat = Vec(36, SInt(w.W))
}

class OutputData(val w: Int) extends Bundle {
    val mat = Vec(16, SInt((w*2+6).W))
}


object CalcType extends ChiselEnum {
    val leakyReLU = Value(0.U)
    val calcMult = Value(1.U)
    val calcConv = Value(2.U)
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

    val comp1 = Array.fill(para_num, 10)(Module(new Core()).io)
    val comp2 = Array.fill(para_num, 10)(Module(new Core()).io)
    val comp3 = Array.fill(para_num, 10)(Module(new Core()).io)
    
    for(t <- 0 to para_num-1)
        for(i <- 0 to 9){
            comp1(t)(i).flag := 0.U.asTypeOf(comp1(t)(i).flag)
            comp1(t)(i).w_a := 0.U.asTypeOf(comp1(t)(i).w_a)
            comp1(t)(i).in_b := 0.U.asTypeOf(comp1(t)(i).in_b)
            comp2(t)(i).flag := 0.U.asTypeOf(comp2(t)(i).flag)
            comp2(t)(i).w_a := 0.U.asTypeOf(comp2(t)(i).w_a)
            comp2(t)(i).in_b := 0.U.asTypeOf(comp2(t)(i).in_b)
            comp3(t)(i).flag := 0.U.asTypeOf(comp3(t)(i).flag)
            comp3(t)(i).w_a := 0.U.asTypeOf(comp3(t)(i).w_a)
            comp3(t)(i).in_b := 0.U.asTypeOf(comp3(t)(i).in_b)
        }
    
    
    val reg1 = RegInit(0.U.asTypeOf(new FirstTransInput(w+2)))
    val reg2 = RegInit(0.U.asTypeOf(new FinalTransInput(w+4)))
    val _w3 = Wire(Vec(para_num, new TransOutput(w*2+6)))
    val w3 = RegInit(VecInit(Seq.fill(para_num)(0.U.asTypeOf(new TransOutput(w*2+6)))))
    val reg3 = RegInit(VecInit(Seq.fill(para_num)(0.U.asTypeOf(new FirstTransOutput(w*2+6)))))

    _w3 := 0.U.asTypeOf(_w3)
    
    
    def g6(x: Int, y: Int): Int = {
        return x*6+y
    }
    def g4(x: Int, y: Int): Int = {
        return x*4+y
    }

    


    def first_trans_input(in: InputData): Unit = {
        for(i <- 0 to 5){

            
            val w2m4 = Wire(SInt((in.mat(g6(i, 2)).getWidth+1).W))
            val w2a4 = Wire(SInt((in.mat(g6(i, 2)).getWidth+1).W))
            val w1a3 = Wire(SInt((in.mat(g6(1, i)).getWidth+1).W))

            w2m4 := -in.mat(g6(2, i))+&in.mat(g6(4, i))
            w2a4 := in.mat(g6(2, i))+&in.mat(g6(4, i))

            w1a3 := in.mat(g6(1, i))+&in.mat(g6(3, i))

            reg1.mat_real(g6(0, i)) := in.mat(g6(0, i))-&in.mat(g6(4, i))
            reg1.mat_real(g6(1, i)) := w1a3+&w2a4
            reg1.mat_real(g6(2, i)) := -w1a3+&w2a4
            reg1.mat_real(g6(3, i)) := w2m4
            reg1.mat_real(g6(4, i)) := w2m4
            reg1.mat_real(g6(5, i)) := -in.mat(g6(1, i))+&in.mat(g6(5, i))

            val w1m3 = Wire(SInt((in.mat(g6(1, i)).getWidth+1).W))
            w1m3 := in.mat(g6(1, i))-&in.mat(g6(3, i))


            reg1.mat_comp(g6(0, i)) := -w1m3  // g(3, i, 6)
            reg1.mat_comp(g6(1, i)) := w1m3  // g(4, i, 6)
        }
    }

    def final_trans_input(in: FirstTransInput): Unit = {
        for(i <- 0 to 5){

            val w13 = Wire(SInt((in.mat_real(g6(i, 1)).getWidth+1).W))
            val w24 = Wire(SInt((in.mat_real(g6(i, 2)).getWidth+1).W))
            val w2m4 = Wire(SInt((in.mat_real(g6(i, 2)).getWidth+1).W))

            w13 := in.mat_real(g6(i, 1))+&in.mat_real(g6(i, 3))
            w24 := in.mat_real(g6(i, 2))+&in.mat_real(g6(i, 4))
            w2m4 := -in.mat_real(g6(i, 2))+&in.mat_real(g6(i, 4))
            if(i>=3&&i<=4){
                val c13 = Wire(SInt((in.mat_comp(g6(i-3, 3)).getWidth+1).W))
                c13 := in.mat_comp(g6(i-3, 3))-&in.mat_comp(g6(i-3, 1))
                reg2.mat_real(g6(i, 3)) := w2m4-&c13
                reg2.mat_real(g6(i, 4)) := w2m4+&c13
            } else {
                reg2.mat_real(g6(i, 3)) := w2m4
                reg2.mat_real(g6(i, 4)) := w2m4
            }
            

            reg2.mat_real(g6(i, 0)) := in.mat_real(g6(i, 0))-&in.mat_real(g6(i, 4))
            reg2.mat_real(g6(i, 1)) := w13+&w24
            reg2.mat_real(g6(i, 2)) := -w13+&w24
            reg2.mat_real(g6(i, 5)) := -in.mat_real(g6(i, 1))+&in.mat_real(g6(i, 5))
        }
        //(3, 0...5)
        reg2.mat_comp(0) := in.mat_comp(g6(0, 0))-&in.mat_comp(g6(0, 4))
        reg2.mat_comp(1) := in.mat_comp(g6(0, 1))+&in.mat_comp(g6(0, 2))+&in.mat_comp(g6(0, 3))+&in.mat_comp(g6(0, 4))
        reg2.mat_comp(2) := -in.mat_comp(g6(0, 1))+&in.mat_comp(g6(0, 2))-&in.mat_comp(g6(0, 3))+&in.mat_comp(g6(0, 4))
        reg2.mat_comp(3) := -in.mat_comp(g6(0, 2))+&in.mat_comp(g6(0, 4))-&in.mat_real(g6(3, 1))+&in.mat_real(g6(3, 3))
        reg2.mat_comp(4) := -in.mat_comp(g6(0, 2))+&in.mat_comp(g6(0, 4))+&in.mat_real(g6(3, 1))-&in.mat_real(g6(3, 3))
        reg2.mat_comp(5) := -in.mat_comp(g6(0, 1))+&in.mat_comp(g6(0, 5))

        // (0, 3) (1, 3) (2, 3) (5, 3)
        reg2.mat_comp(6) := -in.mat_real(g6(0, 1))+&in.mat_real(g6(0, 3))
        reg2.mat_comp(7) := -in.mat_real(g6(1, 1))+&in.mat_real(g6(1, 3))
        reg2.mat_comp(8) := -in.mat_real(g6(2, 1))+&in.mat_real(g6(2, 3))
        reg2.mat_comp(9) := -in.mat_real(g6(5, 1))+&in.mat_real(g6(5, 3))
    }


    def first_trans_output(out: FirstTransOutput, in: TransOutput): Unit = {
        for(i <- 0 to 5){
            
            val w1a2 = Wire(SInt(in.mat_real(g6(1, i)).getWidth.W))
            val w1m2 = Wire(SInt(in.mat_real(g6(1, i)).getWidth.W))

            w1a2 := in.mat_real(g6(1, i))+in.mat_real(g6(2, i))
            w1m2 := in.mat_real(g6(1, i))-in.mat_real(g6(2, i))

            val r34 = Wire(SInt(in.mat_real(g6(3, i)).getWidth.W))
            val c34 = Wire(SInt(in.mat_comp(g6(3, i)).getWidth.W))

            r34 := in.mat_real(g6(3, i))+in.mat_real(g6(4, i))
            c34 := in.mat_comp(g6(3, i))-in.mat_comp(g6(4, i))

            out.mat_real(g6(0, i)) := in.mat_real(g6(0, i))+((w1a2+r34)>>2.U)
            out.mat_real(g6(1, i)) := (w1m2-c34)>>2.U
            out.mat_real(g6(2, i)) := (w1a2-r34)>>2.U
            out.mat_real(g6(3, i)) := ((w1m2+c34)>>2.U)+(in.mat_real(g6(5, i)))
            
            if(i<=4&&i>=3){
                val _w1a2 = Wire(SInt(in.mat_comp(g6(1, i)).getWidth.W))
                val _w1m2 = Wire(SInt(in.mat_comp(g6(1, i)).getWidth.W))
                _w1a2 := in.mat_comp(g6(1, i))+in.mat_comp(g6(2, i))
                _w1m2 := in.mat_comp(g6(1, i))-in.mat_comp(g6(2, i))

                val _r34 = Wire(SInt(in.mat_real(g6(3, i)).getWidth.W))
                val _c34 = Wire(SInt(in.mat_comp(g6(3, i)).getWidth.W))

                _r34 := in.mat_real(g6(3, i))-in.mat_real(g6(4, i))
                _c34 := in.mat_comp(g6(3, i))+in.mat_comp(g6(4, i))

                out.mat_comp(g6(0, i)) := in.mat_comp(g6(0, i))+((_w1a2+_c34)>>2.U)
                out.mat_comp(g6(1, i)) := (_w1m2+_r34)>>2.U
                out.mat_comp(g6(2, i)) := (_w1a2-_c34)>>2.U
                out.mat_comp(g6(3, i)) := ((_w1m2-_r34)>>2.U)+(in.mat_comp(g6(5, i)))
                
            }
        }
    }

    def final_trans_output(output: OutputData, in: FirstTransOutput): Unit = {
        for(i <- 0 to 3){
            val w1a2 = Wire(SInt(in.mat_real(g6(i, 1)).getWidth.W))
            val w1m2 = Wire(SInt(in.mat_real(g6(i, 1)).getWidth.W))

            w1a2 := in.mat_real(g6(i, 1))+in.mat_real(g6(i, 2))
            w1m2 := in.mat_real(g6(i, 1))-in.mat_real(g6(i, 2))

            
            val r34 = Wire(SInt(in.mat_real(g6(i, 3)).getWidth.W))
            val c34 = Wire(SInt(in.mat_comp(g6(i, 3)).getWidth.W))

            r34 := in.mat_real(g6(i, 3))+in.mat_real(g6(i, 4))
            c34 := in.mat_comp(g6(i, 3))-in.mat_comp(g6(i, 4))

            output.mat(g4(i, 0)) := in.mat_real(g6(i, 0))+((w1a2+r34)>>2.U)
            output.mat(g4(i, 1)) := ((w1m2-c34)>>2.U)
            output.mat(g4(i, 2)) := ((w1a2-r34)>>2.U)
            output.mat(g4(i, 3)) := ((w1m2+c34)>>2.U)+(in.mat_real(g6(i, 5)))
        }
    }

    val valid_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
    valid_reg(0) := io.valid_in
    first_trans_input(io.input)
    valid_reg(1) := valid_reg(0)
    final_trans_input(reg1)
    valid_reg(2) := valid_reg(1)
    for(t <- 0 to para_num-1)
        first_trans_output(reg3(t), w3(t))
    valid_reg(3) := valid_reg(2)
    io.valid_out := valid_reg(3)
    
    for(t <- 0 to para_num-1){
        for(i <- 0 to 5){
            for(j <- 0 to 5){
                if(i!=3&&i!=4&&j!=3&&j!=4){
                    w3(t).mat_real(g6(i, j)) := _w3(t).mat_real(g6(i, j))
                } else if(i==3){
                    w3(t).mat_real(g6(i, j)) := _w3(t).mat_real(g6(i, j))
                    w3(t).mat_comp(g6(i, j)) := _w3(t).mat_comp(g6(i, j))
                } else if(i==4){
                    val real_j = if(j>=3&&j<=4) 7-j else j

                    w3(t).mat_real(g6(i, j)) := _w3(t).mat_real(g6(3, real_j))
                    w3(t).mat_comp(g6(i, j)) := -_w3(t).mat_comp(g6(3, real_j))

                } else if(j==3){
                    w3(t).mat_real(g6(i, j)) := _w3(t).mat_real(g6(i, j))
                    w3(t).mat_comp(g6(i, j)) := _w3(t).mat_comp(g6(i, j))
                } else if(j==4){
                    
                    w3(t).mat_real(g6(i, j)) := _w3(t).mat_real(g6(i, 3))
                    w3(t).mat_comp(g6(i, j)) := -_w3(t).mat_comp(g6(i, 3))
                }
            }
        }
    }
    switch(io.flag){
        // in 0 cycle
        is(CalcType.leakyReLU){
            for(i <- 0 to 15){
                real(0)(i).flag := CoreType.leakyReLU
                real(0)(i).in_b := io.input.mat(i)
                io.output(0).mat(i) := real(0)(i).result
            }
            io.valid_out := io.valid_in
        }

        // in 0 cycle
        is(CalcType.calcMult){
            for(i <- 0 to 15){
                real(0)(i).flag := CoreType.calcMult
                real(0)(i).in_b := io.input.mat(i)
                real(0)(i).w_a := io.weight(0).real(i)
                io.output(0).mat(i) := real(0)(i).result
            }
         
           io.valid_out := io.valid_in
        }
        
        // in 3 cycle
        is(CalcType.calcConv){
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
                        } else if(i==3){
                            comp1(t)(y).flag := CoreType.calcMult
                            comp2(t)(y).flag := CoreType.calcMult
                            comp3(t)(y).flag := CoreType.calcMult

                            comp1(t)(y).w_a := io.weight(t).comp1(y)
                            comp2(t)(y).w_a := io.weight(t).comp2(y)
                            comp3(t)(y).w_a := io.weight(t).comp3(y)

                            comp1(t)(y).in_b := reg2.mat_real(g6(i, j))+reg2.mat_comp(j)
                            comp2(t)(y).in_b := reg2.mat_real(g6(i, j))
                            comp3(t)(y).in_b := reg2.mat_comp(j)
                            _w3(t).mat_real(g6(i, j)) := comp2(t)(y).result-&comp3(t)(y).result
                            _w3(t).mat_comp(g6(i, j)) := comp1(t)(y).result-&comp2(t)(y).result-&comp3(t)(y).result
                            
                            y = y+1
                        } else if(i!=4&&j==3){
                            val real_i = if(i>=5) 9 else i+6
                            comp1(t)(y).flag := CoreType.calcMult
                            comp2(t)(y).flag := CoreType.calcMult
                            comp3(t)(y).flag := CoreType.calcMult
                            
                            comp1(t)(y).w_a := io.weight(t).comp1(y)
                            comp2(t)(y).w_a := io.weight(t).comp2(y)
                            comp3(t)(y).w_a := io.weight(t).comp3(y)

                            comp1(t)(y).in_b := reg2.mat_real(g6(i, j))+reg2.mat_comp(real_i)
                            comp2(t)(y).in_b := reg2.mat_real(g6(i, j))
                            comp3(t)(y).in_b := reg2.mat_comp(real_i)
                            _w3(t).mat_real(g6(i, j)) := comp2(t)(y).result-&comp3(t)(y).result
                            _w3(t).mat_comp(g6(i, j)) := comp1(t)(y).result-&comp2(t)(y).result-&comp3(t)(y).result
                            
                            y = y+1
                        }
                    }
                }
            }
            
        }
    }
}
