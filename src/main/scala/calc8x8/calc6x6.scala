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
    val mat = Vec(16, SInt((w*2+5).W))
}


object CalcType extends ChiselEnum {
    val leakyReLU = Value(0.U)
    val calcMult = Value(1.U)
    val calcConv = Value(2.U)
}

class Calc6x6(val w: Int) extends Module{
    val io = IO(new Bundle{
        val input = Input(new InputData(w))
        val flag = Input(CalcType())
        val weight = Input(new WeightData())
        val output = Output(new OutputData(w))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
    })
    
    
    val real = VecInit(Seq.fill(16){Module(new Core()).io})
    for(i <- 0 to 15){
        real(i).flag := 0.U.asTypeOf(real(i).flag)
        real(i).w_a := 0.U.asTypeOf(real(i).w_a)
        real(i).in_b := 0.U.asTypeOf(real(i).in_b)
    }

    val comp1 = VecInit(Seq.fill(10){Module(new Core()).io})
    val comp2 = VecInit(Seq.fill(10){Module(new Core()).io})
    val comp3 = VecInit(Seq.fill(10){Module(new Core()).io})
    

    for(i <- 0 to 9){
        comp1(i).flag := 0.U.asTypeOf(comp1(i).flag)
        comp1(i).w_a := 0.U.asTypeOf(comp1(i).w_a)
        comp1(i).in_b := 0.U.asTypeOf(comp1(i).in_b)
        comp2(i).flag := 0.U.asTypeOf(comp2(i).flag)
        comp2(i).w_a := 0.U.asTypeOf(comp2(i).w_a)
        comp2(i).in_b := 0.U.asTypeOf(comp2(i).in_b)
        comp3(i).flag := 0.U.asTypeOf(comp3(i).flag)
        comp3(i).w_a := 0.U.asTypeOf(comp3(i).w_a)
        comp3(i).in_b := 0.U.asTypeOf(comp3(i).in_b)
    }
    io.output := 0.U.asTypeOf(io.output)
    io.valid_out := false.B
    

    val reg1 = RegInit(0.U.asTypeOf(new FirstTransInput(w+2)))
    val reg2 = RegInit(0.U.asTypeOf(new FinalTransInput(w+4)))
    val w3 = RegInit(0.U.asTypeOf(new TransOutput(w*2+6)))
    val reg3 = RegInit(0.U.asTypeOf(new FirstTransOutput(w*2+6)))

    
    
    def g6(x: Int, y: Int): Int = {
        return x*6+y
    }
    def g4(x: Int, y: Int): Int = {
        return x*4+y
    }

    


    def first_trans_input(in: InputData): Unit = {
        for(i <- 0 to 5){
            reg1.mat_real(g6(0, i)) := in.mat(g6(0, i))-&in.mat(g6(4, i))
            reg1.mat_real(g6(1, i)) := in.mat(g6(1, i))+&in.mat(g6(2, i))+&in.mat(g6(3, i))+&in.mat(g6(4, i))
            reg1.mat_real(g6(2, i)) := -in.mat(g6(1, i))+&in.mat(g6(2, i))-&in.mat(g6(3, i))+&in.mat(g6(4, i))
            reg1.mat_real(g6(3, i)) := -in.mat(g6(2, i))+&in.mat(g6(4, i))
            reg1.mat_real(g6(4, i)) := -in.mat(g6(2, i))+&in.mat(g6(4, i))
            reg1.mat_real(g6(5, i)) := -in.mat(g6(1, i))+&in.mat(g6(5, i))

            reg1.mat_comp(g6(0, i)) := -in.mat(g6(1, i))+&in.mat(g6(3, i))  // g(3, i, 6)
            reg1.mat_comp(g6(1, i)) := in.mat(g6(1, i))-&in.mat(g6(3, i))  // g(4, i, 6)
        }
    }

    def final_trans_input(in: FirstTransInput): Unit = {
        for(i <- 0 to 5){
            reg2.mat_real(g6(i, 0)) := in.mat_real(g6(i, 0))-&in.mat_real(g6(i, 4))
            reg2.mat_real(g6(i, 1)) := in.mat_real(g6(i, 1))+&in.mat_real(g6(i, 2))+&in.mat_real(g6(i, 3))+&in.mat_real(g6(i, 4))
            reg2.mat_real(g6(i, 2)) := -in.mat_real(g6(i, 1))+&in.mat_real(g6(i, 2))-&in.mat_real(g6(i, 3))+&in.mat_real(g6(i, 4));
            reg2.mat_real(g6(i, 3)) := (if (i>=3&&i<=4) -in.mat_real(g6(i, 2))+&in.mat_real(g6(i, 4))-&in.mat_comp(g6(i-3, 3))+&in.mat_comp(g6(i-3, 1)) else -in.mat_real(g6(i, 2))+&in.mat_real(g6(i, 4)));
            reg2.mat_real(g6(i, 4)) := (if (i>=3&&i<=4) -in.mat_real(g6(i, 2))+&in.mat_real(g6(i, 4))+&in.mat_comp(g6(i-3, 3))-&in.mat_comp(g6(i-3, 1)) else -in.mat_real(g6(i, 2))+&in.mat_real(g6(i, 4)));
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

    def first_trans_output(in: TransOutput): Unit = {
        for(i <- 0 to 5){
            reg3.mat_real(g6(0, i)) := in.mat_real(g6(0, i))+((in.mat_real(g6(1, i))+
                                        in.mat_real(g6(2, i))+in.mat_real(g6(3, i))+in.mat_real(g6(4, i)))>>2.U)
            reg3.mat_real(g6(1, i)) := (in.mat_real(g6(1, i))-in.mat_real(g6(2, i))-in.mat_comp(g6(3, i))+in.mat_comp(g6(4, i)))>>2.U
            reg3.mat_real(g6(2, i)) := (in.mat_real(g6(1, i))+in.mat_real(g6(2, i))-in.mat_real(g6(3, i))-in.mat_real(g6(4, i)))>>2.U
            reg3.mat_real(g6(3, i)) := ((in.mat_real(g6(1, i))-in.mat_real(g6(2, i))+in.mat_comp(g6(3, i))-in.mat_comp(g6(4, i)))>>2.U)+(in.mat_real(g6(5, i)))
            
            reg3.mat_comp(g6(0, i)) := in.mat_comp(g6(0, i))+((in.mat_comp(g6(1, i))+
                                        in.mat_comp(g6(2, i))+in.mat_comp(g6(3, i))+in.mat_comp(g6(4, i)))>>2.U)
            reg3.mat_comp(g6(1, i)) := (in.mat_comp(g6(1, i))-in.mat_comp(g6(2, i))+in.mat_real(g6(3, i))-in.mat_real(g6(4, i)))>>2.U
            reg3.mat_comp(g6(2, i)) := (in.mat_comp(g6(1, i))+in.mat_comp(g6(2, i))-in.mat_comp(g6(3, i))-in.mat_comp(g6(4, i)))>>2.U
            reg3.mat_comp(g6(3, i)) := ((in.mat_comp(g6(1, i))-in.mat_comp(g6(2, i))-in.mat_real(g6(3, i))+in.mat_real(g6(4, i)))>>2.U)+(in.mat_comp(g6(5, i)))
        }
    }

    def final_trans_output(in: FirstTransOutput): Unit = {
        for(i <- 0 to 3){
            io.output.mat(g4(i, 0)) := in.mat_real(g6(i, 0))+((in.mat_real(g6(i, 1))+
                                        in.mat_real(g6(i, 2))+in.mat_real(g6(i, 3))+in.mat_real(g6(i, 4)))>>2.U)
            io.output.mat(g4(i, 1)) := ((in.mat_real(g6(i, 1))-in.mat_real(g6(i, 2))-in.mat_comp(g6(i, 3))+in.mat_comp(g6(i, 4)))>>2.U)
            io.output.mat(g4(i, 2)) := ((in.mat_real(g6(i, 1))+in.mat_real(g6(i, 2))-in.mat_real(g6(i, 3))-in.mat_real(g6(i, 4)))>>2.U)
            io.output.mat(g4(i, 3)) := ((in.mat_real(g6(i, 1))-in.mat_real(g6(i, 2))+in.mat_comp(g6(i, 3))-in.mat_comp(g6(i, 4)))>>2.U)+(in.mat_real(g6(i, 5)))
        }
    }

    val valid_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
    valid_reg(0) := io.valid_in
    first_trans_input(io.input)
    valid_reg(1) := valid_reg(0)
    final_trans_input(reg1)
    valid_reg(2) := valid_reg(1)
    first_trans_output(w3)
    valid_reg(3) := valid_reg(2)
    io.valid_out := valid_reg(3)
    switch(io.flag){
        // in 0 cycle
        is(CalcType.leakyReLU){
            for(i <- 0 to 15){
                real(i).flag := CoreType.leakyReLU
                real(i).in_b := io.input.mat(i)
                io.output.mat(i) := real(i).result
            }
            io.valid_out := io.valid_in
        }

        // in 0 cycle
        is(CalcType.calcMult){
            for(i <- 0 to 15){
                real(i).flag := CoreType.calcMult
                real(i).in_b := io.input.mat(i)
                real(i).w_a := io.weight.real(i)
                io.output.mat(i) := real(i).result
            }
         
           io.valid_out := io.valid_in
        }
        
        // in 3 cycle
        is(CalcType.calcConv){
            /*
            first_trans_input(io.input)
            final_trans_input(reg1)
            first_trans_output(w3)
            final_trans_output(reg3)
            //for(i <- 0 to 3)
               // for(j <- 0 to 3)
                //    io.output.mat(i*4+j) := reg3.mat_real((i)*6+(j+2))
                  // io.output.mat(i*4+j) := io.input.mat(i*6+j)
            */
            final_trans_output(reg3)
            
            var x = 0
            var y = 0
            val A = new Array[Int](40)
            for(i <- 0 to 5){
                for(j <- 0 to 5){
                    if(i!=3&&i!=4&&j!=3&&j!=4){
                        real(x).flag := CoreType.calcMult
                        real(x).in_b := reg2.mat_real(g6(i, j))
                        real(x).w_a := io.weight.real(x)
                        w3.mat_real(g6(i, j)) := real(x).result
                        x = x+1
                    } else if(i==3){
                        comp1(y).flag := CoreType.calcMult
                        comp2(y).flag := CoreType.calcMult
                        comp3(y).flag := CoreType.calcMult

                        comp1(y).w_a := io.weight.comp1(y)
                        comp2(y).w_a := io.weight.comp2(y)
                        comp3(y).w_a := io.weight.comp3(y)

                        comp1(y).in_b := reg2.mat_real(g6(i, j))+reg2.mat_comp(j)
                        comp2(y).in_b := reg2.mat_real(g6(i, j))
                        comp3(y).in_b := reg2.mat_comp(j)
                        w3.mat_real(g6(i, j)) := comp2(y).result-comp3(y).result
                        w3.mat_comp(g6(i, j)) := comp1(y).result-comp2(y).result-comp3(y).result
                        A(g6(i, j)) = y
                        y = y+1
                    } else if(i==4){
                        val real_j = if(j>=3&&j<=4) 7-j else j
                        val real_y = A(g6(3, real_j))

                        w3.mat_real(g6(i, j)) := comp2(real_y).result-comp3(real_y).result
                        w3.mat_comp(g6(i, j)) := -comp1(real_y).result+comp2(real_y).result+comp3(real_y).result
                    } else if(j==3){
                        val real_i = if(i>=5) 9 else i+6
                        comp1(y).flag := CoreType.calcMult
                        comp2(y).flag := CoreType.calcMult
                        comp3(y).flag := CoreType.calcMult
                        
                        comp1(y).w_a := io.weight.comp1(y)
                        comp2(y).w_a := io.weight.comp2(y)
                        comp3(y).w_a := io.weight.comp3(y)

                        comp1(y).in_b := reg2.mat_real(g6(i, j))+reg2.mat_comp(real_i)
                        comp2(y).in_b := reg2.mat_real(g6(i, j))
                        comp3(y).in_b := reg2.mat_comp(real_i)
                        w3.mat_real(g6(i, j)) := comp2(y).result-comp3(y).result
                        w3.mat_comp(g6(i, j)) := comp1(y).result-comp2(y).result-comp3(y).result
                        A(g6(i, j)) = y
                        y = y+1
                    } else if(j==4){
                        val real_y = A(g6(i, 3))

                        w3.mat_real(g6(i, j)) := comp2(real_y).result-comp3(real_y).result
                        w3.mat_comp(g6(i, j)) := -comp1(real_y).result+comp2(real_y).result+comp3(real_y).result
                    }
                }
            }
            
        }
    }
}
