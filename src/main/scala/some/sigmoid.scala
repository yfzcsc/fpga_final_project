package final_project

import chisel3._
import chisel3.util._

class Sigmoid extends Module{
    val io = IO(new Bundle{
        val input = Input(SInt(16.W))
        val output = Output(UInt(8.W))
        val valid_in = Input(Bool())
        val valid_out = Output(Bool())
    })
    val break_point = Array[Int](
        -32768,
        -32768,
        -32768,
        -32768,
        -32768,
        -32768,
        -32768,
        -32768,
        -32730,
        -28943,
        -25776,
        -22930,
        -20377,
        -17946,
        -15514,
        -13144,
        -10846,
        -8547,
        -6099,
        -3390,
        3576,
        6579,
        9212,
        11741,
        14318,
        17060,
        19939,
        23036,
        26344,
        29979,
        32767,
        32767,
        32767,
        32767,
        32767,
        32767,
        32767,
        32767,
        32767,
        32767,
        32767,
        32767)
    val icp = Array[Int](
        0,
        31493,
        1389071,
        3050892,
        8799815,
        21910378,
        44101408,
        76574928,
        114888824,
        155831360,
        200579984,
        247736064,
        295831904,
        346265824,
        396514144,
        441932544,
        479941856,
        509673824,
        528951360,
        536854528,
        546518528,
        570247552,
        605663744,
        651094720,
        705129024,
        763917312,
        822980864,
        878899584,
        928578752,
        971567040,
        1007801664,
        1036436608,
        1058213120,
        1069382976,
        1069071296,
        1079579008,
        1071388352,
        1072187968,
        1072625856,
        1072723008,
        1073040448,
        1073741824
    )
    val slope = Array[Int](
        0,
        0,
        17,
        41,
        135,
        391,
        897,
        1760,
        2930,
        4345,
        6081,
        8137,
        10498,
        13308,
        16547,
        20002,
        23507,
        26985,
        30146,
        32477,
        29775,
        26168,
        22323,
        18454,
        14680,
        11234,
        8272,
        5844,
        3959,
        2525,
        1464,
        734,
        260,
        61,
        66,
        -91,
        31,
        19,
        13,
        12,
        8,
        0
    )
    val len = 42
    val quant = 30-15
    val last_quant = 15-8
    val valid_reg = RegInit(VecInit(Seq.fill(len+2)(false.B)))
    val state = RegInit(VecInit(Seq.fill(len+2)(false.B)))
    val ans = RegInit(VecInit(Seq.fill(len+1)(0.S(17.W))))
    val input_reg = RegInit(VecInit(Seq.fill(len+2)(0.S(16.W))))
    val ans_reg = RegInit(0.U(8.W))

    valid_reg(0) := io.valid_in
    for(i <- 1 to len+1)
        valid_reg(i) := valid_reg(i-1)
    
    input_reg(0) := io.input
    for(i <- 1 to len+1)
        input_reg(i) := input_reg(i-1)
    
    io.output := ans_reg
    io.valid_out := valid_reg(len+1)

    state(0) := false.B

    for(i <- 0 to len-1){
        when(state(i)===false.B){
            ans(i+1) := (slope(i).S*input_reg(i)+&icp(i).S)>>quant.U
            state(i+1) := input_reg(i)<break_point(i).S
        }.otherwise{
            ans(i+1) := ans(i)
            state(i+1) := state(i)
        }
    }

    def clamp(x: SInt): UInt = {
        val ret2 = ((1<<(16-1))-1).S(17.W)
        return Mux(x>=ret2, ret2, x).asUInt
    }

    ans_reg := clamp(ans(len)) >> last_quant.U
}