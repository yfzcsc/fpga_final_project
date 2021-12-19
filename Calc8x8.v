module DSP48(
  input  [17:0] io_in_a,
  input  [24:0] io_in_b,
  output [42:0] io_out
);
  assign io_out = $signed(io_in_a) * $signed(io_in_b); // @[core.scala 53:22]
endmodule
module Core(
  input  [17:0] io_w_a,
  input  [24:0] io_in_b,
  input         io_flag,
  output [42:0] io_result
);
  wire [17:0] dsp48_io_in_a; // @[core.scala 21:23]
  wire [24:0] dsp48_io_in_b; // @[core.scala 21:23]
  wire [42:0] dsp48_io_out; // @[core.scala 21:23]
  wire  _T_2 = ~io_flag; // @[Conditional.scala 37:30]
  wire [15:0] _GEN_0 = io_in_b[24] ? $signed(16'sh7fff) : $signed(16'sh199a); // @[core.scala 27:30 core.scala 28:31 core.scala 30:31]
  wire [17:0] _GEN_1 = io_flag ? $signed(io_w_a) : $signed(18'sh0); // @[Conditional.scala 39:67 core.scala 34:27 core.scala 23:19]
  DSP48 dsp48 ( // @[core.scala 21:23]
    .io_in_a(dsp48_io_in_a),
    .io_in_b(dsp48_io_in_b),
    .io_out(dsp48_io_out)
  );
  assign io_result = dsp48_io_out; // @[core.scala 24:15]
  assign dsp48_io_in_a = _T_2 ? $signed({{2{_GEN_0[15]}},_GEN_0}) : $signed(_GEN_1); // @[Conditional.scala 40:58]
  assign dsp48_io_in_b = io_in_b; // @[core.scala 22:19]
endmodule
module Calc6x6(
  input         clock,
  input         reset,
  input  [15:0] io_input_mat_0,
  input  [15:0] io_input_mat_1,
  input  [15:0] io_input_mat_2,
  input  [15:0] io_input_mat_3,
  input  [15:0] io_input_mat_4,
  input  [15:0] io_input_mat_5,
  input  [15:0] io_input_mat_6,
  input  [15:0] io_input_mat_7,
  input  [15:0] io_input_mat_8,
  input  [15:0] io_input_mat_9,
  input  [15:0] io_input_mat_10,
  input  [15:0] io_input_mat_11,
  input  [15:0] io_input_mat_12,
  input  [15:0] io_input_mat_13,
  input  [15:0] io_input_mat_14,
  input  [15:0] io_input_mat_15,
  input  [15:0] io_input_mat_16,
  input  [15:0] io_input_mat_17,
  input  [15:0] io_input_mat_18,
  input  [15:0] io_input_mat_19,
  input  [15:0] io_input_mat_20,
  input  [15:0] io_input_mat_21,
  input  [15:0] io_input_mat_22,
  input  [15:0] io_input_mat_23,
  input  [15:0] io_input_mat_24,
  input  [15:0] io_input_mat_25,
  input  [15:0] io_input_mat_26,
  input  [15:0] io_input_mat_27,
  input  [15:0] io_input_mat_28,
  input  [15:0] io_input_mat_29,
  input  [15:0] io_input_mat_30,
  input  [15:0] io_input_mat_31,
  input  [15:0] io_input_mat_32,
  input  [15:0] io_input_mat_33,
  input  [15:0] io_input_mat_34,
  input  [15:0] io_input_mat_35,
  input  [1:0]  io_flag,
  input  [17:0] io_weight_real_0,
  input  [17:0] io_weight_real_1,
  input  [17:0] io_weight_real_2,
  input  [17:0] io_weight_real_3,
  input  [17:0] io_weight_real_4,
  input  [17:0] io_weight_real_5,
  input  [17:0] io_weight_real_6,
  input  [17:0] io_weight_real_7,
  input  [17:0] io_weight_real_8,
  input  [17:0] io_weight_real_9,
  input  [17:0] io_weight_real_10,
  input  [17:0] io_weight_real_11,
  input  [17:0] io_weight_real_12,
  input  [17:0] io_weight_real_13,
  input  [17:0] io_weight_real_14,
  input  [17:0] io_weight_real_15,
  input  [17:0] io_weight_comp1_0,
  input  [17:0] io_weight_comp1_1,
  input  [17:0] io_weight_comp1_2,
  input  [17:0] io_weight_comp1_3,
  input  [17:0] io_weight_comp1_4,
  input  [17:0] io_weight_comp1_5,
  input  [17:0] io_weight_comp1_6,
  input  [17:0] io_weight_comp1_7,
  input  [17:0] io_weight_comp1_8,
  input  [17:0] io_weight_comp1_9,
  input  [17:0] io_weight_comp2_0,
  input  [17:0] io_weight_comp2_1,
  input  [17:0] io_weight_comp2_2,
  input  [17:0] io_weight_comp2_3,
  input  [17:0] io_weight_comp2_4,
  input  [17:0] io_weight_comp2_5,
  input  [17:0] io_weight_comp2_6,
  input  [17:0] io_weight_comp2_7,
  input  [17:0] io_weight_comp2_8,
  input  [17:0] io_weight_comp2_9,
  input  [17:0] io_weight_comp3_0,
  input  [17:0] io_weight_comp3_1,
  input  [17:0] io_weight_comp3_2,
  input  [17:0] io_weight_comp3_3,
  input  [17:0] io_weight_comp3_4,
  input  [17:0] io_weight_comp3_5,
  input  [17:0] io_weight_comp3_6,
  input  [17:0] io_weight_comp3_7,
  input  [17:0] io_weight_comp3_8,
  input  [17:0] io_weight_comp3_9,
  output [36:0] io_output_mat_0,
  output [36:0] io_output_mat_1,
  output [36:0] io_output_mat_2,
  output [36:0] io_output_mat_3,
  output [36:0] io_output_mat_4,
  output [36:0] io_output_mat_5,
  output [36:0] io_output_mat_6,
  output [36:0] io_output_mat_7,
  output [36:0] io_output_mat_8,
  output [36:0] io_output_mat_9,
  output [36:0] io_output_mat_10,
  output [36:0] io_output_mat_11,
  output [36:0] io_output_mat_12,
  output [36:0] io_output_mat_13,
  output [36:0] io_output_mat_14,
  output [36:0] io_output_mat_15,
  input         io_valid_in,
  output        io_valid_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [63:0] _RAND_72;
  reg [63:0] _RAND_73;
  reg [63:0] _RAND_74;
  reg [63:0] _RAND_75;
  reg [63:0] _RAND_76;
  reg [63:0] _RAND_77;
  reg [63:0] _RAND_78;
  reg [63:0] _RAND_79;
  reg [63:0] _RAND_80;
  reg [63:0] _RAND_81;
  reg [63:0] _RAND_82;
  reg [63:0] _RAND_83;
  reg [63:0] _RAND_84;
  reg [63:0] _RAND_85;
  reg [63:0] _RAND_86;
  reg [63:0] _RAND_87;
  reg [63:0] _RAND_88;
  reg [63:0] _RAND_89;
  reg [63:0] _RAND_90;
  reg [63:0] _RAND_91;
  reg [63:0] _RAND_92;
  reg [63:0] _RAND_93;
  reg [63:0] _RAND_94;
  reg [63:0] _RAND_95;
  reg [63:0] _RAND_96;
  reg [63:0] _RAND_97;
  reg [63:0] _RAND_98;
  reg [63:0] _RAND_99;
  reg [63:0] _RAND_100;
  reg [63:0] _RAND_101;
  reg [63:0] _RAND_102;
  reg [63:0] _RAND_103;
  reg [63:0] _RAND_104;
  reg [63:0] _RAND_105;
  reg [63:0] _RAND_106;
  reg [63:0] _RAND_107;
  reg [63:0] _RAND_108;
  reg [63:0] _RAND_109;
  reg [63:0] _RAND_110;
  reg [63:0] _RAND_111;
  reg [63:0] _RAND_112;
  reg [63:0] _RAND_113;
  reg [63:0] _RAND_114;
  reg [63:0] _RAND_115;
  reg [63:0] _RAND_116;
  reg [63:0] _RAND_117;
  reg [63:0] _RAND_118;
  reg [63:0] _RAND_119;
  reg [63:0] _RAND_120;
  reg [63:0] _RAND_121;
  reg [63:0] _RAND_122;
  reg [63:0] _RAND_123;
  reg [63:0] _RAND_124;
  reg [63:0] _RAND_125;
  reg [63:0] _RAND_126;
  reg [63:0] _RAND_127;
  reg [63:0] _RAND_128;
  reg [63:0] _RAND_129;
  reg [63:0] _RAND_130;
  reg [63:0] _RAND_131;
  reg [63:0] _RAND_132;
  reg [63:0] _RAND_133;
  reg [63:0] _RAND_134;
  reg [63:0] _RAND_135;
  reg [63:0] _RAND_136;
  reg [63:0] _RAND_137;
  reg [63:0] _RAND_138;
  reg [63:0] _RAND_139;
  reg [63:0] _RAND_140;
  reg [63:0] _RAND_141;
  reg [63:0] _RAND_142;
  reg [63:0] _RAND_143;
  reg [63:0] _RAND_144;
  reg [63:0] _RAND_145;
  reg [63:0] _RAND_146;
  reg [63:0] _RAND_147;
  reg [63:0] _RAND_148;
  reg [63:0] _RAND_149;
  reg [63:0] _RAND_150;
  reg [63:0] _RAND_151;
  reg [63:0] _RAND_152;
  reg [63:0] _RAND_153;
  reg [63:0] _RAND_154;
  reg [63:0] _RAND_155;
  reg [63:0] _RAND_156;
  reg [63:0] _RAND_157;
  reg [63:0] _RAND_158;
  reg [63:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
`endif // RANDOMIZE_REG_INIT
  wire [17:0] Core_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_1_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_1_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_1_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_1_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_2_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_2_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_2_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_2_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_3_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_3_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_3_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_3_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_4_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_4_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_4_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_4_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_5_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_5_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_5_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_5_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_6_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_6_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_6_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_6_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_7_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_7_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_7_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_7_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_8_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_8_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_8_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_8_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_9_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_9_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_9_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_9_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_10_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_10_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_10_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_10_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_11_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_11_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_11_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_11_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_12_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_12_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_12_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_12_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_13_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_13_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_13_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_13_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_14_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_14_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_14_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_14_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_15_io_w_a; // @[calc6x6.scala 64:43]
  wire [24:0] Core_15_io_in_b; // @[calc6x6.scala 64:43]
  wire  Core_15_io_flag; // @[calc6x6.scala 64:43]
  wire [42:0] Core_15_io_result; // @[calc6x6.scala 64:43]
  wire [17:0] Core_16_io_w_a; // @[calc6x6.scala 71:44]
  wire [24:0] Core_16_io_in_b; // @[calc6x6.scala 71:44]
  wire  Core_16_io_flag; // @[calc6x6.scala 71:44]
  wire [42:0] Core_16_io_result; // @[calc6x6.scala 71:44]
  wire [17:0] Core_17_io_w_a; // @[calc6x6.scala 71:44]
  wire [24:0] Core_17_io_in_b; // @[calc6x6.scala 71:44]
  wire  Core_17_io_flag; // @[calc6x6.scala 71:44]
  wire [42:0] Core_17_io_result; // @[calc6x6.scala 71:44]
  wire [17:0] Core_18_io_w_a; // @[calc6x6.scala 71:44]
  wire [24:0] Core_18_io_in_b; // @[calc6x6.scala 71:44]
  wire  Core_18_io_flag; // @[calc6x6.scala 71:44]
  wire [42:0] Core_18_io_result; // @[calc6x6.scala 71:44]
  wire [17:0] Core_19_io_w_a; // @[calc6x6.scala 71:44]
  wire [24:0] Core_19_io_in_b; // @[calc6x6.scala 71:44]
  wire  Core_19_io_flag; // @[calc6x6.scala 71:44]
  wire [42:0] Core_19_io_result; // @[calc6x6.scala 71:44]
  wire [17:0] Core_20_io_w_a; // @[calc6x6.scala 71:44]
  wire [24:0] Core_20_io_in_b; // @[calc6x6.scala 71:44]
  wire  Core_20_io_flag; // @[calc6x6.scala 71:44]
  wire [42:0] Core_20_io_result; // @[calc6x6.scala 71:44]
  wire [17:0] Core_21_io_w_a; // @[calc6x6.scala 71:44]
  wire [24:0] Core_21_io_in_b; // @[calc6x6.scala 71:44]
  wire  Core_21_io_flag; // @[calc6x6.scala 71:44]
  wire [42:0] Core_21_io_result; // @[calc6x6.scala 71:44]
  wire [17:0] Core_22_io_w_a; // @[calc6x6.scala 71:44]
  wire [24:0] Core_22_io_in_b; // @[calc6x6.scala 71:44]
  wire  Core_22_io_flag; // @[calc6x6.scala 71:44]
  wire [42:0] Core_22_io_result; // @[calc6x6.scala 71:44]
  wire [17:0] Core_23_io_w_a; // @[calc6x6.scala 71:44]
  wire [24:0] Core_23_io_in_b; // @[calc6x6.scala 71:44]
  wire  Core_23_io_flag; // @[calc6x6.scala 71:44]
  wire [42:0] Core_23_io_result; // @[calc6x6.scala 71:44]
  wire [17:0] Core_24_io_w_a; // @[calc6x6.scala 71:44]
  wire [24:0] Core_24_io_in_b; // @[calc6x6.scala 71:44]
  wire  Core_24_io_flag; // @[calc6x6.scala 71:44]
  wire [42:0] Core_24_io_result; // @[calc6x6.scala 71:44]
  wire [17:0] Core_25_io_w_a; // @[calc6x6.scala 71:44]
  wire [24:0] Core_25_io_in_b; // @[calc6x6.scala 71:44]
  wire  Core_25_io_flag; // @[calc6x6.scala 71:44]
  wire [42:0] Core_25_io_result; // @[calc6x6.scala 71:44]
  wire [17:0] Core_26_io_w_a; // @[calc6x6.scala 72:44]
  wire [24:0] Core_26_io_in_b; // @[calc6x6.scala 72:44]
  wire  Core_26_io_flag; // @[calc6x6.scala 72:44]
  wire [42:0] Core_26_io_result; // @[calc6x6.scala 72:44]
  wire [17:0] Core_27_io_w_a; // @[calc6x6.scala 72:44]
  wire [24:0] Core_27_io_in_b; // @[calc6x6.scala 72:44]
  wire  Core_27_io_flag; // @[calc6x6.scala 72:44]
  wire [42:0] Core_27_io_result; // @[calc6x6.scala 72:44]
  wire [17:0] Core_28_io_w_a; // @[calc6x6.scala 72:44]
  wire [24:0] Core_28_io_in_b; // @[calc6x6.scala 72:44]
  wire  Core_28_io_flag; // @[calc6x6.scala 72:44]
  wire [42:0] Core_28_io_result; // @[calc6x6.scala 72:44]
  wire [17:0] Core_29_io_w_a; // @[calc6x6.scala 72:44]
  wire [24:0] Core_29_io_in_b; // @[calc6x6.scala 72:44]
  wire  Core_29_io_flag; // @[calc6x6.scala 72:44]
  wire [42:0] Core_29_io_result; // @[calc6x6.scala 72:44]
  wire [17:0] Core_30_io_w_a; // @[calc6x6.scala 72:44]
  wire [24:0] Core_30_io_in_b; // @[calc6x6.scala 72:44]
  wire  Core_30_io_flag; // @[calc6x6.scala 72:44]
  wire [42:0] Core_30_io_result; // @[calc6x6.scala 72:44]
  wire [17:0] Core_31_io_w_a; // @[calc6x6.scala 72:44]
  wire [24:0] Core_31_io_in_b; // @[calc6x6.scala 72:44]
  wire  Core_31_io_flag; // @[calc6x6.scala 72:44]
  wire [42:0] Core_31_io_result; // @[calc6x6.scala 72:44]
  wire [17:0] Core_32_io_w_a; // @[calc6x6.scala 72:44]
  wire [24:0] Core_32_io_in_b; // @[calc6x6.scala 72:44]
  wire  Core_32_io_flag; // @[calc6x6.scala 72:44]
  wire [42:0] Core_32_io_result; // @[calc6x6.scala 72:44]
  wire [17:0] Core_33_io_w_a; // @[calc6x6.scala 72:44]
  wire [24:0] Core_33_io_in_b; // @[calc6x6.scala 72:44]
  wire  Core_33_io_flag; // @[calc6x6.scala 72:44]
  wire [42:0] Core_33_io_result; // @[calc6x6.scala 72:44]
  wire [17:0] Core_34_io_w_a; // @[calc6x6.scala 72:44]
  wire [24:0] Core_34_io_in_b; // @[calc6x6.scala 72:44]
  wire  Core_34_io_flag; // @[calc6x6.scala 72:44]
  wire [42:0] Core_34_io_result; // @[calc6x6.scala 72:44]
  wire [17:0] Core_35_io_w_a; // @[calc6x6.scala 72:44]
  wire [24:0] Core_35_io_in_b; // @[calc6x6.scala 72:44]
  wire  Core_35_io_flag; // @[calc6x6.scala 72:44]
  wire [42:0] Core_35_io_result; // @[calc6x6.scala 72:44]
  wire [17:0] Core_36_io_w_a; // @[calc6x6.scala 73:44]
  wire [24:0] Core_36_io_in_b; // @[calc6x6.scala 73:44]
  wire  Core_36_io_flag; // @[calc6x6.scala 73:44]
  wire [42:0] Core_36_io_result; // @[calc6x6.scala 73:44]
  wire [17:0] Core_37_io_w_a; // @[calc6x6.scala 73:44]
  wire [24:0] Core_37_io_in_b; // @[calc6x6.scala 73:44]
  wire  Core_37_io_flag; // @[calc6x6.scala 73:44]
  wire [42:0] Core_37_io_result; // @[calc6x6.scala 73:44]
  wire [17:0] Core_38_io_w_a; // @[calc6x6.scala 73:44]
  wire [24:0] Core_38_io_in_b; // @[calc6x6.scala 73:44]
  wire  Core_38_io_flag; // @[calc6x6.scala 73:44]
  wire [42:0] Core_38_io_result; // @[calc6x6.scala 73:44]
  wire [17:0] Core_39_io_w_a; // @[calc6x6.scala 73:44]
  wire [24:0] Core_39_io_in_b; // @[calc6x6.scala 73:44]
  wire  Core_39_io_flag; // @[calc6x6.scala 73:44]
  wire [42:0] Core_39_io_result; // @[calc6x6.scala 73:44]
  wire [17:0] Core_40_io_w_a; // @[calc6x6.scala 73:44]
  wire [24:0] Core_40_io_in_b; // @[calc6x6.scala 73:44]
  wire  Core_40_io_flag; // @[calc6x6.scala 73:44]
  wire [42:0] Core_40_io_result; // @[calc6x6.scala 73:44]
  wire [17:0] Core_41_io_w_a; // @[calc6x6.scala 73:44]
  wire [24:0] Core_41_io_in_b; // @[calc6x6.scala 73:44]
  wire  Core_41_io_flag; // @[calc6x6.scala 73:44]
  wire [42:0] Core_41_io_result; // @[calc6x6.scala 73:44]
  wire [17:0] Core_42_io_w_a; // @[calc6x6.scala 73:44]
  wire [24:0] Core_42_io_in_b; // @[calc6x6.scala 73:44]
  wire  Core_42_io_flag; // @[calc6x6.scala 73:44]
  wire [42:0] Core_42_io_result; // @[calc6x6.scala 73:44]
  wire [17:0] Core_43_io_w_a; // @[calc6x6.scala 73:44]
  wire [24:0] Core_43_io_in_b; // @[calc6x6.scala 73:44]
  wire  Core_43_io_flag; // @[calc6x6.scala 73:44]
  wire [42:0] Core_43_io_result; // @[calc6x6.scala 73:44]
  wire [17:0] Core_44_io_w_a; // @[calc6x6.scala 73:44]
  wire [24:0] Core_44_io_in_b; // @[calc6x6.scala 73:44]
  wire  Core_44_io_flag; // @[calc6x6.scala 73:44]
  wire [42:0] Core_44_io_result; // @[calc6x6.scala 73:44]
  wire [17:0] Core_45_io_w_a; // @[calc6x6.scala 73:44]
  wire [24:0] Core_45_io_in_b; // @[calc6x6.scala 73:44]
  wire  Core_45_io_flag; // @[calc6x6.scala 73:44]
  wire [42:0] Core_45_io_result; // @[calc6x6.scala 73:44]
  reg [17:0] reg1_mat_real_0; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_1; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_2; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_3; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_4; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_5; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_6; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_7; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_8; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_9; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_10; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_11; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_12; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_13; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_14; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_15; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_16; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_17; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_18; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_19; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_20; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_21; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_22; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_23; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_30; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_31; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_32; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_33; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_34; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_real_35; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_comp_0; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_comp_1; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_comp_2; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_comp_3; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_comp_4; // @[calc6x6.scala 91:23]
  reg [17:0] reg1_mat_comp_5; // @[calc6x6.scala 91:23]
  reg [19:0] reg2_mat_real_0; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_1; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_2; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_3; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_5; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_6; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_7; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_8; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_9; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_11; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_12; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_13; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_14; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_15; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_17; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_18; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_19; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_20; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_21; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_22; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_23; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_30; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_31; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_32; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_33; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_real_35; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_comp_0; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_comp_1; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_comp_2; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_comp_3; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_comp_4; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_comp_5; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_comp_6; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_comp_7; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_comp_8; // @[calc6x6.scala 92:23]
  reg [19:0] reg2_mat_comp_9; // @[calc6x6.scala 92:23]
  reg [37:0] w3_mat_real_0; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_1; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_2; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_3; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_4; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_5; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_6; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_7; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_8; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_9; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_10; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_11; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_12; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_13; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_14; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_15; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_16; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_17; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_18; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_19; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_20; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_21; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_22; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_23; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_24; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_25; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_26; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_27; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_28; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_29; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_30; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_31; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_32; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_33; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_34; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_real_35; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_3; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_4; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_9; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_10; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_15; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_16; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_18; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_19; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_20; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_21; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_22; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_23; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_24; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_25; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_26; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_27; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_28; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_29; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_33; // @[calc6x6.scala 93:21]
  reg [37:0] w3_mat_comp_34; // @[calc6x6.scala 93:21]
  reg [37:0] reg3_mat_real_0; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_1; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_2; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_3; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_4; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_5; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_6; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_7; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_8; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_9; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_10; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_11; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_12; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_13; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_14; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_15; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_16; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_17; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_18; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_19; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_20; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_21; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_22; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_real_23; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_comp_3; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_comp_4; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_comp_9; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_comp_10; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_comp_15; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_comp_16; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_comp_21; // @[calc6x6.scala 94:23]
  reg [37:0] reg3_mat_comp_22; // @[calc6x6.scala 94:23]
  reg  valid_reg_0; // @[calc6x6.scala 172:28]
  reg  valid_reg_1; // @[calc6x6.scala 172:28]
  reg  valid_reg_2; // @[calc6x6.scala 172:28]
  reg  valid_reg_3; // @[calc6x6.scala 172:28]
  wire [16:0] _reg1_mat_real_0_T = $signed(io_input_mat_0) - $signed(io_input_mat_24); // @[calc6x6.scala 110:56]
  wire [16:0] _reg1_mat_real_6_T = $signed(io_input_mat_6) + $signed(io_input_mat_12); // @[calc6x6.scala 111:56]
  wire [16:0] _GEN_632 = {{1{io_input_mat_18[15]}},io_input_mat_18}; // @[calc6x6.scala 111:74]
  wire [17:0] _reg1_mat_real_6_T_1 = $signed(_reg1_mat_real_6_T) + $signed(_GEN_632); // @[calc6x6.scala 111:74]
  wire [17:0] _GEN_633 = {{2{io_input_mat_24[15]}},io_input_mat_24}; // @[calc6x6.scala 111:92]
  wire [18:0] _reg1_mat_real_6_T_2 = $signed(_reg1_mat_real_6_T_1) + $signed(_GEN_633); // @[calc6x6.scala 111:92]
  wire [15:0] _reg1_mat_real_12_T_2 = 16'sh0 - $signed(io_input_mat_6); // @[calc6x6.scala 112:40]
  wire [16:0] _reg1_mat_real_12_T_3 = $signed(_reg1_mat_real_12_T_2) + $signed(io_input_mat_12); // @[calc6x6.scala 112:57]
  wire [17:0] _reg1_mat_real_12_T_4 = $signed(_reg1_mat_real_12_T_3) - $signed(_GEN_632); // @[calc6x6.scala 112:75]
  wire [18:0] _reg1_mat_real_12_T_5 = $signed(_reg1_mat_real_12_T_4) + $signed(_GEN_633); // @[calc6x6.scala 112:93]
  wire [15:0] _reg1_mat_real_18_T_2 = 16'sh0 - $signed(io_input_mat_12); // @[calc6x6.scala 113:40]
  wire [16:0] _reg1_mat_real_18_T_3 = $signed(_reg1_mat_real_18_T_2) + $signed(io_input_mat_24); // @[calc6x6.scala 113:57]
  wire [16:0] _reg1_mat_real_30_T_3 = $signed(_reg1_mat_real_12_T_2) + $signed(io_input_mat_30); // @[calc6x6.scala 115:57]
  wire [16:0] _reg1_mat_comp_0_T_3 = $signed(_reg1_mat_real_12_T_2) + $signed(io_input_mat_18); // @[calc6x6.scala 117:57]
  wire [16:0] _reg1_mat_real_1_T = $signed(io_input_mat_1) - $signed(io_input_mat_25); // @[calc6x6.scala 110:56]
  wire [16:0] _reg1_mat_real_7_T = $signed(io_input_mat_7) + $signed(io_input_mat_13); // @[calc6x6.scala 111:56]
  wire [16:0] _GEN_636 = {{1{io_input_mat_19[15]}},io_input_mat_19}; // @[calc6x6.scala 111:74]
  wire [17:0] _reg1_mat_real_7_T_1 = $signed(_reg1_mat_real_7_T) + $signed(_GEN_636); // @[calc6x6.scala 111:74]
  wire [17:0] _GEN_637 = {{2{io_input_mat_25[15]}},io_input_mat_25}; // @[calc6x6.scala 111:92]
  wire [18:0] _reg1_mat_real_7_T_2 = $signed(_reg1_mat_real_7_T_1) + $signed(_GEN_637); // @[calc6x6.scala 111:92]
  wire [15:0] _reg1_mat_real_13_T_2 = 16'sh0 - $signed(io_input_mat_7); // @[calc6x6.scala 112:40]
  wire [16:0] _reg1_mat_real_13_T_3 = $signed(_reg1_mat_real_13_T_2) + $signed(io_input_mat_13); // @[calc6x6.scala 112:57]
  wire [17:0] _reg1_mat_real_13_T_4 = $signed(_reg1_mat_real_13_T_3) - $signed(_GEN_636); // @[calc6x6.scala 112:75]
  wire [18:0] _reg1_mat_real_13_T_5 = $signed(_reg1_mat_real_13_T_4) + $signed(_GEN_637); // @[calc6x6.scala 112:93]
  wire [15:0] _reg1_mat_real_19_T_2 = 16'sh0 - $signed(io_input_mat_13); // @[calc6x6.scala 113:40]
  wire [16:0] _reg1_mat_real_19_T_3 = $signed(_reg1_mat_real_19_T_2) + $signed(io_input_mat_25); // @[calc6x6.scala 113:57]
  wire [16:0] _reg1_mat_real_31_T_3 = $signed(_reg1_mat_real_13_T_2) + $signed(io_input_mat_31); // @[calc6x6.scala 115:57]
  wire [16:0] _reg1_mat_comp_1_T_3 = $signed(_reg1_mat_real_13_T_2) + $signed(io_input_mat_19); // @[calc6x6.scala 117:57]
  wire [16:0] _reg1_mat_real_2_T = $signed(io_input_mat_2) - $signed(io_input_mat_26); // @[calc6x6.scala 110:56]
  wire [16:0] _reg1_mat_real_8_T = $signed(io_input_mat_8) + $signed(io_input_mat_14); // @[calc6x6.scala 111:56]
  wire [16:0] _GEN_640 = {{1{io_input_mat_20[15]}},io_input_mat_20}; // @[calc6x6.scala 111:74]
  wire [17:0] _reg1_mat_real_8_T_1 = $signed(_reg1_mat_real_8_T) + $signed(_GEN_640); // @[calc6x6.scala 111:74]
  wire [17:0] _GEN_641 = {{2{io_input_mat_26[15]}},io_input_mat_26}; // @[calc6x6.scala 111:92]
  wire [18:0] _reg1_mat_real_8_T_2 = $signed(_reg1_mat_real_8_T_1) + $signed(_GEN_641); // @[calc6x6.scala 111:92]
  wire [15:0] _reg1_mat_real_14_T_2 = 16'sh0 - $signed(io_input_mat_8); // @[calc6x6.scala 112:40]
  wire [16:0] _reg1_mat_real_14_T_3 = $signed(_reg1_mat_real_14_T_2) + $signed(io_input_mat_14); // @[calc6x6.scala 112:57]
  wire [17:0] _reg1_mat_real_14_T_4 = $signed(_reg1_mat_real_14_T_3) - $signed(_GEN_640); // @[calc6x6.scala 112:75]
  wire [18:0] _reg1_mat_real_14_T_5 = $signed(_reg1_mat_real_14_T_4) + $signed(_GEN_641); // @[calc6x6.scala 112:93]
  wire [15:0] _reg1_mat_real_20_T_2 = 16'sh0 - $signed(io_input_mat_14); // @[calc6x6.scala 113:40]
  wire [16:0] _reg1_mat_real_20_T_3 = $signed(_reg1_mat_real_20_T_2) + $signed(io_input_mat_26); // @[calc6x6.scala 113:57]
  wire [16:0] _reg1_mat_real_32_T_3 = $signed(_reg1_mat_real_14_T_2) + $signed(io_input_mat_32); // @[calc6x6.scala 115:57]
  wire [16:0] _reg1_mat_comp_2_T_3 = $signed(_reg1_mat_real_14_T_2) + $signed(io_input_mat_20); // @[calc6x6.scala 117:57]
  wire [16:0] _reg1_mat_real_3_T = $signed(io_input_mat_3) - $signed(io_input_mat_27); // @[calc6x6.scala 110:56]
  wire [16:0] _reg1_mat_real_9_T = $signed(io_input_mat_9) + $signed(io_input_mat_15); // @[calc6x6.scala 111:56]
  wire [16:0] _GEN_644 = {{1{io_input_mat_21[15]}},io_input_mat_21}; // @[calc6x6.scala 111:74]
  wire [17:0] _reg1_mat_real_9_T_1 = $signed(_reg1_mat_real_9_T) + $signed(_GEN_644); // @[calc6x6.scala 111:74]
  wire [17:0] _GEN_645 = {{2{io_input_mat_27[15]}},io_input_mat_27}; // @[calc6x6.scala 111:92]
  wire [18:0] _reg1_mat_real_9_T_2 = $signed(_reg1_mat_real_9_T_1) + $signed(_GEN_645); // @[calc6x6.scala 111:92]
  wire [15:0] _reg1_mat_real_15_T_2 = 16'sh0 - $signed(io_input_mat_9); // @[calc6x6.scala 112:40]
  wire [16:0] _reg1_mat_real_15_T_3 = $signed(_reg1_mat_real_15_T_2) + $signed(io_input_mat_15); // @[calc6x6.scala 112:57]
  wire [17:0] _reg1_mat_real_15_T_4 = $signed(_reg1_mat_real_15_T_3) - $signed(_GEN_644); // @[calc6x6.scala 112:75]
  wire [18:0] _reg1_mat_real_15_T_5 = $signed(_reg1_mat_real_15_T_4) + $signed(_GEN_645); // @[calc6x6.scala 112:93]
  wire [15:0] _reg1_mat_real_21_T_2 = 16'sh0 - $signed(io_input_mat_15); // @[calc6x6.scala 113:40]
  wire [16:0] _reg1_mat_real_21_T_3 = $signed(_reg1_mat_real_21_T_2) + $signed(io_input_mat_27); // @[calc6x6.scala 113:57]
  wire [16:0] _reg1_mat_real_33_T_3 = $signed(_reg1_mat_real_15_T_2) + $signed(io_input_mat_33); // @[calc6x6.scala 115:57]
  wire [16:0] _reg1_mat_comp_3_T_3 = $signed(_reg1_mat_real_15_T_2) + $signed(io_input_mat_21); // @[calc6x6.scala 117:57]
  wire [16:0] _reg1_mat_real_4_T = $signed(io_input_mat_4) - $signed(io_input_mat_28); // @[calc6x6.scala 110:56]
  wire [16:0] _reg1_mat_real_10_T = $signed(io_input_mat_10) + $signed(io_input_mat_16); // @[calc6x6.scala 111:56]
  wire [16:0] _GEN_648 = {{1{io_input_mat_22[15]}},io_input_mat_22}; // @[calc6x6.scala 111:74]
  wire [17:0] _reg1_mat_real_10_T_1 = $signed(_reg1_mat_real_10_T) + $signed(_GEN_648); // @[calc6x6.scala 111:74]
  wire [17:0] _GEN_649 = {{2{io_input_mat_28[15]}},io_input_mat_28}; // @[calc6x6.scala 111:92]
  wire [18:0] _reg1_mat_real_10_T_2 = $signed(_reg1_mat_real_10_T_1) + $signed(_GEN_649); // @[calc6x6.scala 111:92]
  wire [15:0] _reg1_mat_real_16_T_2 = 16'sh0 - $signed(io_input_mat_10); // @[calc6x6.scala 112:40]
  wire [16:0] _reg1_mat_real_16_T_3 = $signed(_reg1_mat_real_16_T_2) + $signed(io_input_mat_16); // @[calc6x6.scala 112:57]
  wire [17:0] _reg1_mat_real_16_T_4 = $signed(_reg1_mat_real_16_T_3) - $signed(_GEN_648); // @[calc6x6.scala 112:75]
  wire [18:0] _reg1_mat_real_16_T_5 = $signed(_reg1_mat_real_16_T_4) + $signed(_GEN_649); // @[calc6x6.scala 112:93]
  wire [15:0] _reg1_mat_real_22_T_2 = 16'sh0 - $signed(io_input_mat_16); // @[calc6x6.scala 113:40]
  wire [16:0] _reg1_mat_real_22_T_3 = $signed(_reg1_mat_real_22_T_2) + $signed(io_input_mat_28); // @[calc6x6.scala 113:57]
  wire [16:0] _reg1_mat_real_34_T_3 = $signed(_reg1_mat_real_16_T_2) + $signed(io_input_mat_34); // @[calc6x6.scala 115:57]
  wire [16:0] _reg1_mat_comp_4_T_3 = $signed(_reg1_mat_real_16_T_2) + $signed(io_input_mat_22); // @[calc6x6.scala 117:57]
  wire [16:0] _reg1_mat_real_5_T = $signed(io_input_mat_5) - $signed(io_input_mat_29); // @[calc6x6.scala 110:56]
  wire [16:0] _reg1_mat_real_11_T = $signed(io_input_mat_11) + $signed(io_input_mat_17); // @[calc6x6.scala 111:56]
  wire [16:0] _GEN_652 = {{1{io_input_mat_23[15]}},io_input_mat_23}; // @[calc6x6.scala 111:74]
  wire [17:0] _reg1_mat_real_11_T_1 = $signed(_reg1_mat_real_11_T) + $signed(_GEN_652); // @[calc6x6.scala 111:74]
  wire [17:0] _GEN_653 = {{2{io_input_mat_29[15]}},io_input_mat_29}; // @[calc6x6.scala 111:92]
  wire [18:0] _reg1_mat_real_11_T_2 = $signed(_reg1_mat_real_11_T_1) + $signed(_GEN_653); // @[calc6x6.scala 111:92]
  wire [15:0] _reg1_mat_real_17_T_2 = 16'sh0 - $signed(io_input_mat_11); // @[calc6x6.scala 112:40]
  wire [16:0] _reg1_mat_real_17_T_3 = $signed(_reg1_mat_real_17_T_2) + $signed(io_input_mat_17); // @[calc6x6.scala 112:57]
  wire [17:0] _reg1_mat_real_17_T_4 = $signed(_reg1_mat_real_17_T_3) - $signed(_GEN_652); // @[calc6x6.scala 112:75]
  wire [18:0] _reg1_mat_real_17_T_5 = $signed(_reg1_mat_real_17_T_4) + $signed(_GEN_653); // @[calc6x6.scala 112:93]
  wire [15:0] _reg1_mat_real_23_T_2 = 16'sh0 - $signed(io_input_mat_17); // @[calc6x6.scala 113:40]
  wire [16:0] _reg1_mat_real_23_T_3 = $signed(_reg1_mat_real_23_T_2) + $signed(io_input_mat_29); // @[calc6x6.scala 113:57]
  wire [16:0] _reg1_mat_real_35_T_3 = $signed(_reg1_mat_real_17_T_2) + $signed(io_input_mat_35); // @[calc6x6.scala 115:57]
  wire [16:0] _reg1_mat_comp_5_T_3 = $signed(_reg1_mat_real_17_T_2) + $signed(io_input_mat_23); // @[calc6x6.scala 117:57]
  wire [18:0] _reg2_mat_real_0_T = $signed(reg1_mat_real_0) - $signed(reg1_mat_real_4); // @[calc6x6.scala 124:61]
  wire [18:0] _reg2_mat_real_1_T = $signed(reg1_mat_real_1) + $signed(reg1_mat_real_2); // @[calc6x6.scala 125:61]
  wire [18:0] _GEN_656 = {{1{reg1_mat_real_3[17]}},reg1_mat_real_3}; // @[calc6x6.scala 125:84]
  wire [19:0] _reg2_mat_real_1_T_1 = $signed(_reg2_mat_real_1_T) + $signed(_GEN_656); // @[calc6x6.scala 125:84]
  wire [19:0] _GEN_657 = {{2{reg1_mat_real_4[17]}},reg1_mat_real_4}; // @[calc6x6.scala 125:107]
  wire [20:0] _reg2_mat_real_1_T_2 = $signed(_reg2_mat_real_1_T_1) + $signed(_GEN_657); // @[calc6x6.scala 125:107]
  wire [17:0] _reg2_mat_real_2_T_2 = 18'sh0 - $signed(reg1_mat_real_1); // @[calc6x6.scala 126:40]
  wire [18:0] _reg2_mat_real_2_T_3 = $signed(_reg2_mat_real_2_T_2) + $signed(reg1_mat_real_2); // @[calc6x6.scala 126:62]
  wire [19:0] _reg2_mat_real_2_T_4 = $signed(_reg2_mat_real_2_T_3) - $signed(_GEN_656); // @[calc6x6.scala 126:85]
  wire [20:0] _reg2_mat_real_2_T_5 = $signed(_reg2_mat_real_2_T_4) + $signed(_GEN_657); // @[calc6x6.scala 126:108]
  wire [17:0] _reg2_mat_real_3_T_2 = 18'sh0 - $signed(reg1_mat_real_2); // @[calc6x6.scala 127:158]
  wire [18:0] _reg2_mat_real_3_T_3 = $signed(_reg2_mat_real_3_T_2) + $signed(reg1_mat_real_4); // @[calc6x6.scala 127:180]
  wire [18:0] _reg2_mat_real_5_T_3 = $signed(_reg2_mat_real_2_T_2) + $signed(reg1_mat_real_5); // @[calc6x6.scala 129:62]
  wire [18:0] _reg2_mat_real_6_T = $signed(reg1_mat_real_6) - $signed(reg1_mat_real_10); // @[calc6x6.scala 124:61]
  wire [18:0] _reg2_mat_real_7_T = $signed(reg1_mat_real_7) + $signed(reg1_mat_real_8); // @[calc6x6.scala 125:61]
  wire [18:0] _GEN_660 = {{1{reg1_mat_real_9[17]}},reg1_mat_real_9}; // @[calc6x6.scala 125:84]
  wire [19:0] _reg2_mat_real_7_T_1 = $signed(_reg2_mat_real_7_T) + $signed(_GEN_660); // @[calc6x6.scala 125:84]
  wire [19:0] _GEN_661 = {{2{reg1_mat_real_10[17]}},reg1_mat_real_10}; // @[calc6x6.scala 125:107]
  wire [20:0] _reg2_mat_real_7_T_2 = $signed(_reg2_mat_real_7_T_1) + $signed(_GEN_661); // @[calc6x6.scala 125:107]
  wire [17:0] _reg2_mat_real_8_T_2 = 18'sh0 - $signed(reg1_mat_real_7); // @[calc6x6.scala 126:40]
  wire [18:0] _reg2_mat_real_8_T_3 = $signed(_reg2_mat_real_8_T_2) + $signed(reg1_mat_real_8); // @[calc6x6.scala 126:62]
  wire [19:0] _reg2_mat_real_8_T_4 = $signed(_reg2_mat_real_8_T_3) - $signed(_GEN_660); // @[calc6x6.scala 126:85]
  wire [20:0] _reg2_mat_real_8_T_5 = $signed(_reg2_mat_real_8_T_4) + $signed(_GEN_661); // @[calc6x6.scala 126:108]
  wire [17:0] _reg2_mat_real_9_T_2 = 18'sh0 - $signed(reg1_mat_real_8); // @[calc6x6.scala 127:158]
  wire [18:0] _reg2_mat_real_9_T_3 = $signed(_reg2_mat_real_9_T_2) + $signed(reg1_mat_real_10); // @[calc6x6.scala 127:180]
  wire [18:0] _reg2_mat_real_11_T_3 = $signed(_reg2_mat_real_8_T_2) + $signed(reg1_mat_real_11); // @[calc6x6.scala 129:62]
  wire [18:0] _reg2_mat_real_12_T = $signed(reg1_mat_real_12) - $signed(reg1_mat_real_16); // @[calc6x6.scala 124:61]
  wire [18:0] _reg2_mat_real_13_T = $signed(reg1_mat_real_13) + $signed(reg1_mat_real_14); // @[calc6x6.scala 125:61]
  wire [18:0] _GEN_664 = {{1{reg1_mat_real_15[17]}},reg1_mat_real_15}; // @[calc6x6.scala 125:84]
  wire [19:0] _reg2_mat_real_13_T_1 = $signed(_reg2_mat_real_13_T) + $signed(_GEN_664); // @[calc6x6.scala 125:84]
  wire [19:0] _GEN_665 = {{2{reg1_mat_real_16[17]}},reg1_mat_real_16}; // @[calc6x6.scala 125:107]
  wire [20:0] _reg2_mat_real_13_T_2 = $signed(_reg2_mat_real_13_T_1) + $signed(_GEN_665); // @[calc6x6.scala 125:107]
  wire [17:0] _reg2_mat_real_14_T_2 = 18'sh0 - $signed(reg1_mat_real_13); // @[calc6x6.scala 126:40]
  wire [18:0] _reg2_mat_real_14_T_3 = $signed(_reg2_mat_real_14_T_2) + $signed(reg1_mat_real_14); // @[calc6x6.scala 126:62]
  wire [19:0] _reg2_mat_real_14_T_4 = $signed(_reg2_mat_real_14_T_3) - $signed(_GEN_664); // @[calc6x6.scala 126:85]
  wire [20:0] _reg2_mat_real_14_T_5 = $signed(_reg2_mat_real_14_T_4) + $signed(_GEN_665); // @[calc6x6.scala 126:108]
  wire [17:0] _reg2_mat_real_15_T_2 = 18'sh0 - $signed(reg1_mat_real_14); // @[calc6x6.scala 127:158]
  wire [18:0] _reg2_mat_real_15_T_3 = $signed(_reg2_mat_real_15_T_2) + $signed(reg1_mat_real_16); // @[calc6x6.scala 127:180]
  wire [18:0] _reg2_mat_real_17_T_3 = $signed(_reg2_mat_real_14_T_2) + $signed(reg1_mat_real_17); // @[calc6x6.scala 129:62]
  wire [18:0] _reg2_mat_real_18_T = $signed(reg1_mat_real_18) - $signed(reg1_mat_real_22); // @[calc6x6.scala 124:61]
  wire [18:0] _reg2_mat_real_19_T = $signed(reg1_mat_real_19) + $signed(reg1_mat_real_20); // @[calc6x6.scala 125:61]
  wire [18:0] _GEN_668 = {{1{reg1_mat_real_21[17]}},reg1_mat_real_21}; // @[calc6x6.scala 125:84]
  wire [19:0] _reg2_mat_real_19_T_1 = $signed(_reg2_mat_real_19_T) + $signed(_GEN_668); // @[calc6x6.scala 125:84]
  wire [19:0] _GEN_669 = {{2{reg1_mat_real_22[17]}},reg1_mat_real_22}; // @[calc6x6.scala 125:107]
  wire [20:0] _reg2_mat_real_19_T_2 = $signed(_reg2_mat_real_19_T_1) + $signed(_GEN_669); // @[calc6x6.scala 125:107]
  wire [17:0] _reg2_mat_real_20_T_2 = 18'sh0 - $signed(reg1_mat_real_19); // @[calc6x6.scala 126:40]
  wire [18:0] _reg2_mat_real_20_T_3 = $signed(_reg2_mat_real_20_T_2) + $signed(reg1_mat_real_20); // @[calc6x6.scala 126:62]
  wire [19:0] _reg2_mat_real_20_T_4 = $signed(_reg2_mat_real_20_T_3) - $signed(_GEN_668); // @[calc6x6.scala 126:85]
  wire [20:0] _reg2_mat_real_20_T_5 = $signed(_reg2_mat_real_20_T_4) + $signed(_GEN_669); // @[calc6x6.scala 126:108]
  wire [17:0] _reg2_mat_real_21_T_2 = 18'sh0 - $signed(reg1_mat_real_20); // @[calc6x6.scala 127:57]
  wire [18:0] _reg2_mat_real_21_T_3 = $signed(_reg2_mat_real_21_T_2) + $signed(reg1_mat_real_22); // @[calc6x6.scala 127:79]
  wire [18:0] _GEN_672 = {{1{reg1_mat_comp_3[17]}},reg1_mat_comp_3}; // @[calc6x6.scala 127:102]
  wire [19:0] _reg2_mat_real_21_T_4 = $signed(_reg2_mat_real_21_T_3) - $signed(_GEN_672); // @[calc6x6.scala 127:102]
  wire [19:0] _GEN_673 = {{2{reg1_mat_comp_1[17]}},reg1_mat_comp_1}; // @[calc6x6.scala 127:127]
  wire [20:0] _reg2_mat_real_21_T_5 = $signed(_reg2_mat_real_21_T_4) + $signed(_GEN_673); // @[calc6x6.scala 127:127]
  wire [19:0] _reg2_mat_real_22_T_4 = $signed(_reg2_mat_real_21_T_3) + $signed(_GEN_672); // @[calc6x6.scala 128:102]
  wire [20:0] _reg2_mat_real_22_T_5 = $signed(_reg2_mat_real_22_T_4) - $signed(_GEN_673); // @[calc6x6.scala 128:127]
  wire [18:0] _reg2_mat_real_23_T_3 = $signed(_reg2_mat_real_20_T_2) + $signed(reg1_mat_real_23); // @[calc6x6.scala 129:62]
  wire [18:0] _reg2_mat_real_30_T = $signed(reg1_mat_real_30) - $signed(reg1_mat_real_34); // @[calc6x6.scala 124:61]
  wire [18:0] _reg2_mat_real_31_T = $signed(reg1_mat_real_31) + $signed(reg1_mat_real_32); // @[calc6x6.scala 125:61]
  wire [18:0] _GEN_684 = {{1{reg1_mat_real_33[17]}},reg1_mat_real_33}; // @[calc6x6.scala 125:84]
  wire [19:0] _reg2_mat_real_31_T_1 = $signed(_reg2_mat_real_31_T) + $signed(_GEN_684); // @[calc6x6.scala 125:84]
  wire [19:0] _GEN_685 = {{2{reg1_mat_real_34[17]}},reg1_mat_real_34}; // @[calc6x6.scala 125:107]
  wire [20:0] _reg2_mat_real_31_T_2 = $signed(_reg2_mat_real_31_T_1) + $signed(_GEN_685); // @[calc6x6.scala 125:107]
  wire [17:0] _reg2_mat_real_32_T_2 = 18'sh0 - $signed(reg1_mat_real_31); // @[calc6x6.scala 126:40]
  wire [18:0] _reg2_mat_real_32_T_3 = $signed(_reg2_mat_real_32_T_2) + $signed(reg1_mat_real_32); // @[calc6x6.scala 126:62]
  wire [19:0] _reg2_mat_real_32_T_4 = $signed(_reg2_mat_real_32_T_3) - $signed(_GEN_684); // @[calc6x6.scala 126:85]
  wire [20:0] _reg2_mat_real_32_T_5 = $signed(_reg2_mat_real_32_T_4) + $signed(_GEN_685); // @[calc6x6.scala 126:108]
  wire [17:0] _reg2_mat_real_33_T_2 = 18'sh0 - $signed(reg1_mat_real_32); // @[calc6x6.scala 127:158]
  wire [18:0] _reg2_mat_real_33_T_3 = $signed(_reg2_mat_real_33_T_2) + $signed(reg1_mat_real_34); // @[calc6x6.scala 127:180]
  wire [18:0] _reg2_mat_real_35_T_3 = $signed(_reg2_mat_real_32_T_2) + $signed(reg1_mat_real_35); // @[calc6x6.scala 129:62]
  wire [18:0] _reg2_mat_comp_0_T = $signed(reg1_mat_comp_0) - $signed(reg1_mat_comp_4); // @[calc6x6.scala 132:50]
  wire [18:0] _reg2_mat_comp_1_T = $signed(reg1_mat_comp_1) + $signed(reg1_mat_comp_2); // @[calc6x6.scala 133:50]
  wire [19:0] _reg2_mat_comp_1_T_1 = $signed(_reg2_mat_comp_1_T) + $signed(_GEN_672); // @[calc6x6.scala 133:73]
  wire [19:0] _GEN_689 = {{2{reg1_mat_comp_4[17]}},reg1_mat_comp_4}; // @[calc6x6.scala 133:96]
  wire [20:0] _reg2_mat_comp_1_T_2 = $signed(_reg2_mat_comp_1_T_1) + $signed(_GEN_689); // @[calc6x6.scala 133:96]
  wire [17:0] _reg2_mat_comp_2_T_2 = 18'sh0 - $signed(reg1_mat_comp_1); // @[calc6x6.scala 134:29]
  wire [18:0] _reg2_mat_comp_2_T_3 = $signed(_reg2_mat_comp_2_T_2) + $signed(reg1_mat_comp_2); // @[calc6x6.scala 134:51]
  wire [19:0] _reg2_mat_comp_2_T_4 = $signed(_reg2_mat_comp_2_T_3) - $signed(_GEN_672); // @[calc6x6.scala 134:74]
  wire [20:0] _reg2_mat_comp_2_T_5 = $signed(_reg2_mat_comp_2_T_4) + $signed(_GEN_689); // @[calc6x6.scala 134:97]
  wire [17:0] _reg2_mat_comp_3_T_2 = 18'sh0 - $signed(reg1_mat_comp_2); // @[calc6x6.scala 135:29]
  wire [18:0] _reg2_mat_comp_3_T_3 = $signed(_reg2_mat_comp_3_T_2) + $signed(reg1_mat_comp_4); // @[calc6x6.scala 135:51]
  wire [18:0] _GEN_692 = {{1{reg1_mat_real_19[17]}},reg1_mat_real_19}; // @[calc6x6.scala 135:74]
  wire [19:0] _reg2_mat_comp_3_T_4 = $signed(_reg2_mat_comp_3_T_3) - $signed(_GEN_692); // @[calc6x6.scala 135:74]
  wire [19:0] _GEN_693 = {{2{reg1_mat_real_21[17]}},reg1_mat_real_21}; // @[calc6x6.scala 135:97]
  wire [20:0] _reg2_mat_comp_3_T_5 = $signed(_reg2_mat_comp_3_T_4) + $signed(_GEN_693); // @[calc6x6.scala 135:97]
  wire [19:0] _reg2_mat_comp_4_T_4 = $signed(_reg2_mat_comp_3_T_3) + $signed(_GEN_692); // @[calc6x6.scala 136:74]
  wire [20:0] _reg2_mat_comp_4_T_5 = $signed(_reg2_mat_comp_4_T_4) - $signed(_GEN_693); // @[calc6x6.scala 136:97]
  wire [18:0] _reg2_mat_comp_5_T_3 = $signed(_reg2_mat_comp_2_T_2) + $signed(reg1_mat_comp_5); // @[calc6x6.scala 137:51]
  wire [18:0] _reg2_mat_comp_6_T_3 = $signed(_reg2_mat_real_2_T_2) + $signed(reg1_mat_real_3); // @[calc6x6.scala 140:51]
  wire [18:0] _reg2_mat_comp_7_T_3 = $signed(_reg2_mat_real_8_T_2) + $signed(reg1_mat_real_9); // @[calc6x6.scala 141:51]
  wire [18:0] _reg2_mat_comp_8_T_3 = $signed(_reg2_mat_real_14_T_2) + $signed(reg1_mat_real_15); // @[calc6x6.scala 142:51]
  wire [18:0] _reg2_mat_comp_9_T_3 = $signed(_reg2_mat_real_32_T_2) + $signed(reg1_mat_real_33); // @[calc6x6.scala 143:51]
  wire [37:0] _reg3_mat_real_0_T_2 = $signed(w3_mat_real_6) + $signed(w3_mat_real_12); // @[calc6x6.scala 148:85]
  wire [37:0] _reg3_mat_real_0_T_5 = $signed(_reg3_mat_real_0_T_2) + $signed(w3_mat_real_18); // @[calc6x6.scala 149:62]
  wire [37:0] _reg3_mat_real_0_T_8 = $signed(_reg3_mat_real_0_T_5) + $signed(w3_mat_real_24); // @[calc6x6.scala 149:84]
  wire [35:0] _GEN_696 = _reg3_mat_real_0_T_8[37:2]; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_0_T_9 = {{2{_GEN_696[35]}},_GEN_696}; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_0_T_12 = $signed(w3_mat_real_0) + $signed(_reg3_mat_real_0_T_9); // @[calc6x6.scala 148:61]
  wire [37:0] _reg3_mat_real_6_T_2 = $signed(w3_mat_real_6) - $signed(w3_mat_real_12); // @[calc6x6.scala 150:62]
  wire [37:0] _reg3_mat_real_6_T_5 = $signed(_reg3_mat_real_6_T_2) - $signed(w3_mat_comp_18); // @[calc6x6.scala 150:84]
  wire [37:0] _reg3_mat_real_6_T_8 = $signed(_reg3_mat_real_6_T_5) + $signed(w3_mat_comp_24); // @[calc6x6.scala 150:106]
  wire [35:0] _GEN_697 = _reg3_mat_real_6_T_8[37:2]; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_6_T_9 = {{2{_GEN_697[35]}},_GEN_697}; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_12_T_5 = $signed(_reg3_mat_real_0_T_2) - $signed(w3_mat_real_18); // @[calc6x6.scala 151:84]
  wire [37:0] _reg3_mat_real_12_T_8 = $signed(_reg3_mat_real_12_T_5) - $signed(w3_mat_real_24); // @[calc6x6.scala 151:106]
  wire [35:0] _GEN_698 = _reg3_mat_real_12_T_8[37:2]; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_12_T_9 = {{2{_GEN_698[35]}},_GEN_698}; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_18_T_5 = $signed(_reg3_mat_real_6_T_2) + $signed(w3_mat_comp_18); // @[calc6x6.scala 152:85]
  wire [37:0] _reg3_mat_real_18_T_8 = $signed(_reg3_mat_real_18_T_5) - $signed(w3_mat_comp_24); // @[calc6x6.scala 152:107]
  wire [35:0] _GEN_699 = _reg3_mat_real_18_T_8[37:2]; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_18_T_9 = {{2{_GEN_699[35]}},_GEN_699}; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_18_T_12 = $signed(_reg3_mat_real_18_T_9) + $signed(w3_mat_real_30); // @[calc6x6.scala 152:136]
  wire [37:0] _reg3_mat_real_1_T_2 = $signed(w3_mat_real_7) + $signed(w3_mat_real_13); // @[calc6x6.scala 148:85]
  wire [37:0] _reg3_mat_real_1_T_5 = $signed(_reg3_mat_real_1_T_2) + $signed(w3_mat_real_19); // @[calc6x6.scala 149:62]
  wire [37:0] _reg3_mat_real_1_T_8 = $signed(_reg3_mat_real_1_T_5) + $signed(w3_mat_real_25); // @[calc6x6.scala 149:84]
  wire [35:0] _GEN_704 = _reg3_mat_real_1_T_8[37:2]; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_1_T_9 = {{2{_GEN_704[35]}},_GEN_704}; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_1_T_12 = $signed(w3_mat_real_1) + $signed(_reg3_mat_real_1_T_9); // @[calc6x6.scala 148:61]
  wire [37:0] _reg3_mat_real_7_T_2 = $signed(w3_mat_real_7) - $signed(w3_mat_real_13); // @[calc6x6.scala 150:62]
  wire [37:0] _reg3_mat_real_7_T_5 = $signed(_reg3_mat_real_7_T_2) - $signed(w3_mat_comp_19); // @[calc6x6.scala 150:84]
  wire [37:0] _reg3_mat_real_7_T_8 = $signed(_reg3_mat_real_7_T_5) + $signed(w3_mat_comp_25); // @[calc6x6.scala 150:106]
  wire [35:0] _GEN_705 = _reg3_mat_real_7_T_8[37:2]; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_7_T_9 = {{2{_GEN_705[35]}},_GEN_705}; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_13_T_5 = $signed(_reg3_mat_real_1_T_2) - $signed(w3_mat_real_19); // @[calc6x6.scala 151:84]
  wire [37:0] _reg3_mat_real_13_T_8 = $signed(_reg3_mat_real_13_T_5) - $signed(w3_mat_real_25); // @[calc6x6.scala 151:106]
  wire [35:0] _GEN_706 = _reg3_mat_real_13_T_8[37:2]; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_13_T_9 = {{2{_GEN_706[35]}},_GEN_706}; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_19_T_5 = $signed(_reg3_mat_real_7_T_2) + $signed(w3_mat_comp_19); // @[calc6x6.scala 152:85]
  wire [37:0] _reg3_mat_real_19_T_8 = $signed(_reg3_mat_real_19_T_5) - $signed(w3_mat_comp_25); // @[calc6x6.scala 152:107]
  wire [35:0] _GEN_707 = _reg3_mat_real_19_T_8[37:2]; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_19_T_9 = {{2{_GEN_707[35]}},_GEN_707}; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_19_T_12 = $signed(_reg3_mat_real_19_T_9) + $signed(w3_mat_real_31); // @[calc6x6.scala 152:136]
  wire [37:0] _reg3_mat_real_2_T_2 = $signed(w3_mat_real_8) + $signed(w3_mat_real_14); // @[calc6x6.scala 148:85]
  wire [37:0] _reg3_mat_real_2_T_5 = $signed(_reg3_mat_real_2_T_2) + $signed(w3_mat_real_20); // @[calc6x6.scala 149:62]
  wire [37:0] _reg3_mat_real_2_T_8 = $signed(_reg3_mat_real_2_T_5) + $signed(w3_mat_real_26); // @[calc6x6.scala 149:84]
  wire [35:0] _GEN_712 = _reg3_mat_real_2_T_8[37:2]; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_2_T_9 = {{2{_GEN_712[35]}},_GEN_712}; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_2_T_12 = $signed(w3_mat_real_2) + $signed(_reg3_mat_real_2_T_9); // @[calc6x6.scala 148:61]
  wire [37:0] _reg3_mat_real_8_T_2 = $signed(w3_mat_real_8) - $signed(w3_mat_real_14); // @[calc6x6.scala 150:62]
  wire [37:0] _reg3_mat_real_8_T_5 = $signed(_reg3_mat_real_8_T_2) - $signed(w3_mat_comp_20); // @[calc6x6.scala 150:84]
  wire [37:0] _reg3_mat_real_8_T_8 = $signed(_reg3_mat_real_8_T_5) + $signed(w3_mat_comp_26); // @[calc6x6.scala 150:106]
  wire [35:0] _GEN_713 = _reg3_mat_real_8_T_8[37:2]; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_8_T_9 = {{2{_GEN_713[35]}},_GEN_713}; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_14_T_5 = $signed(_reg3_mat_real_2_T_2) - $signed(w3_mat_real_20); // @[calc6x6.scala 151:84]
  wire [37:0] _reg3_mat_real_14_T_8 = $signed(_reg3_mat_real_14_T_5) - $signed(w3_mat_real_26); // @[calc6x6.scala 151:106]
  wire [35:0] _GEN_714 = _reg3_mat_real_14_T_8[37:2]; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_14_T_9 = {{2{_GEN_714[35]}},_GEN_714}; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_20_T_5 = $signed(_reg3_mat_real_8_T_2) + $signed(w3_mat_comp_20); // @[calc6x6.scala 152:85]
  wire [37:0] _reg3_mat_real_20_T_8 = $signed(_reg3_mat_real_20_T_5) - $signed(w3_mat_comp_26); // @[calc6x6.scala 152:107]
  wire [35:0] _GEN_715 = _reg3_mat_real_20_T_8[37:2]; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_20_T_9 = {{2{_GEN_715[35]}},_GEN_715}; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_20_T_12 = $signed(_reg3_mat_real_20_T_9) + $signed(w3_mat_real_32); // @[calc6x6.scala 152:136]
  wire [37:0] _reg3_mat_real_3_T_2 = $signed(w3_mat_real_9) + $signed(w3_mat_real_15); // @[calc6x6.scala 148:85]
  wire [37:0] _reg3_mat_real_3_T_5 = $signed(_reg3_mat_real_3_T_2) + $signed(w3_mat_real_21); // @[calc6x6.scala 149:62]
  wire [37:0] _reg3_mat_real_3_T_8 = $signed(_reg3_mat_real_3_T_5) + $signed(w3_mat_real_27); // @[calc6x6.scala 149:84]
  wire [35:0] _GEN_720 = _reg3_mat_real_3_T_8[37:2]; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_3_T_9 = {{2{_GEN_720[35]}},_GEN_720}; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_3_T_12 = $signed(w3_mat_real_3) + $signed(_reg3_mat_real_3_T_9); // @[calc6x6.scala 148:61]
  wire [37:0] _reg3_mat_real_9_T_2 = $signed(w3_mat_real_9) - $signed(w3_mat_real_15); // @[calc6x6.scala 150:62]
  wire [37:0] _reg3_mat_real_9_T_5 = $signed(_reg3_mat_real_9_T_2) - $signed(w3_mat_comp_21); // @[calc6x6.scala 150:84]
  wire [37:0] _reg3_mat_real_9_T_8 = $signed(_reg3_mat_real_9_T_5) + $signed(w3_mat_comp_27); // @[calc6x6.scala 150:106]
  wire [35:0] _GEN_721 = _reg3_mat_real_9_T_8[37:2]; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_9_T_9 = {{2{_GEN_721[35]}},_GEN_721}; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_15_T_5 = $signed(_reg3_mat_real_3_T_2) - $signed(w3_mat_real_21); // @[calc6x6.scala 151:84]
  wire [37:0] _reg3_mat_real_15_T_8 = $signed(_reg3_mat_real_15_T_5) - $signed(w3_mat_real_27); // @[calc6x6.scala 151:106]
  wire [35:0] _GEN_722 = _reg3_mat_real_15_T_8[37:2]; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_15_T_9 = {{2{_GEN_722[35]}},_GEN_722}; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_21_T_5 = $signed(_reg3_mat_real_9_T_2) + $signed(w3_mat_comp_21); // @[calc6x6.scala 152:85]
  wire [37:0] _reg3_mat_real_21_T_8 = $signed(_reg3_mat_real_21_T_5) - $signed(w3_mat_comp_27); // @[calc6x6.scala 152:107]
  wire [35:0] _GEN_723 = _reg3_mat_real_21_T_8[37:2]; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_21_T_9 = {{2{_GEN_723[35]}},_GEN_723}; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_21_T_12 = $signed(_reg3_mat_real_21_T_9) + $signed(w3_mat_real_33); // @[calc6x6.scala 152:136]
  wire [37:0] _reg3_mat_comp_3_T_2 = $signed(w3_mat_comp_9) + $signed(w3_mat_comp_15); // @[calc6x6.scala 154:85]
  wire [37:0] _reg3_mat_comp_3_T_5 = $signed(_reg3_mat_comp_3_T_2) + $signed(w3_mat_comp_21); // @[calc6x6.scala 155:62]
  wire [37:0] _reg3_mat_comp_3_T_8 = $signed(_reg3_mat_comp_3_T_5) + $signed(w3_mat_comp_27); // @[calc6x6.scala 155:84]
  wire [35:0] _GEN_724 = _reg3_mat_comp_3_T_8[37:2]; // @[calc6x6.scala 155:107]
  wire [37:0] _reg3_mat_comp_3_T_9 = {{2{_GEN_724[35]}},_GEN_724}; // @[calc6x6.scala 155:107]
  wire [37:0] _reg3_mat_comp_3_T_12 = $signed(w3_mat_comp_3) + $signed(_reg3_mat_comp_3_T_9); // @[calc6x6.scala 154:61]
  wire [37:0] _reg3_mat_comp_9_T_2 = $signed(w3_mat_comp_9) - $signed(w3_mat_comp_15); // @[calc6x6.scala 156:62]
  wire [37:0] _reg3_mat_comp_9_T_5 = $signed(_reg3_mat_comp_9_T_2) + $signed(w3_mat_real_21); // @[calc6x6.scala 156:84]
  wire [37:0] _reg3_mat_comp_9_T_8 = $signed(_reg3_mat_comp_9_T_5) - $signed(w3_mat_real_27); // @[calc6x6.scala 156:106]
  wire [35:0] _GEN_725 = _reg3_mat_comp_9_T_8[37:2]; // @[calc6x6.scala 156:129]
  wire [37:0] _reg3_mat_comp_9_T_9 = {{2{_GEN_725[35]}},_GEN_725}; // @[calc6x6.scala 156:129]
  wire [37:0] _reg3_mat_comp_15_T_5 = $signed(_reg3_mat_comp_3_T_2) - $signed(w3_mat_comp_21); // @[calc6x6.scala 157:84]
  wire [37:0] _reg3_mat_comp_15_T_8 = $signed(_reg3_mat_comp_15_T_5) - $signed(w3_mat_comp_27); // @[calc6x6.scala 157:106]
  wire [35:0] _GEN_726 = _reg3_mat_comp_15_T_8[37:2]; // @[calc6x6.scala 157:129]
  wire [37:0] _reg3_mat_comp_15_T_9 = {{2{_GEN_726[35]}},_GEN_726}; // @[calc6x6.scala 157:129]
  wire [37:0] _reg3_mat_comp_21_T_5 = $signed(_reg3_mat_comp_9_T_2) - $signed(w3_mat_real_21); // @[calc6x6.scala 158:85]
  wire [37:0] _reg3_mat_comp_21_T_8 = $signed(_reg3_mat_comp_21_T_5) + $signed(w3_mat_real_27); // @[calc6x6.scala 158:107]
  wire [35:0] _GEN_727 = _reg3_mat_comp_21_T_8[37:2]; // @[calc6x6.scala 158:130]
  wire [37:0] _reg3_mat_comp_21_T_9 = {{2{_GEN_727[35]}},_GEN_727}; // @[calc6x6.scala 158:130]
  wire [37:0] _reg3_mat_comp_21_T_12 = $signed(_reg3_mat_comp_21_T_9) + $signed(w3_mat_comp_33); // @[calc6x6.scala 158:136]
  wire [37:0] _reg3_mat_real_4_T_2 = $signed(w3_mat_real_10) + $signed(w3_mat_real_16); // @[calc6x6.scala 148:85]
  wire [37:0] _reg3_mat_real_4_T_5 = $signed(_reg3_mat_real_4_T_2) + $signed(w3_mat_real_22); // @[calc6x6.scala 149:62]
  wire [37:0] _reg3_mat_real_4_T_8 = $signed(_reg3_mat_real_4_T_5) + $signed(w3_mat_real_28); // @[calc6x6.scala 149:84]
  wire [35:0] _GEN_728 = _reg3_mat_real_4_T_8[37:2]; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_4_T_9 = {{2{_GEN_728[35]}},_GEN_728}; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_4_T_12 = $signed(w3_mat_real_4) + $signed(_reg3_mat_real_4_T_9); // @[calc6x6.scala 148:61]
  wire [37:0] _reg3_mat_real_10_T_2 = $signed(w3_mat_real_10) - $signed(w3_mat_real_16); // @[calc6x6.scala 150:62]
  wire [37:0] _reg3_mat_real_10_T_5 = $signed(_reg3_mat_real_10_T_2) - $signed(w3_mat_comp_22); // @[calc6x6.scala 150:84]
  wire [37:0] _reg3_mat_real_10_T_8 = $signed(_reg3_mat_real_10_T_5) + $signed(w3_mat_comp_28); // @[calc6x6.scala 150:106]
  wire [35:0] _GEN_729 = _reg3_mat_real_10_T_8[37:2]; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_10_T_9 = {{2{_GEN_729[35]}},_GEN_729}; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_16_T_5 = $signed(_reg3_mat_real_4_T_2) - $signed(w3_mat_real_22); // @[calc6x6.scala 151:84]
  wire [37:0] _reg3_mat_real_16_T_8 = $signed(_reg3_mat_real_16_T_5) - $signed(w3_mat_real_28); // @[calc6x6.scala 151:106]
  wire [35:0] _GEN_730 = _reg3_mat_real_16_T_8[37:2]; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_16_T_9 = {{2{_GEN_730[35]}},_GEN_730}; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_22_T_5 = $signed(_reg3_mat_real_10_T_2) + $signed(w3_mat_comp_22); // @[calc6x6.scala 152:85]
  wire [37:0] _reg3_mat_real_22_T_8 = $signed(_reg3_mat_real_22_T_5) - $signed(w3_mat_comp_28); // @[calc6x6.scala 152:107]
  wire [35:0] _GEN_731 = _reg3_mat_real_22_T_8[37:2]; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_22_T_9 = {{2{_GEN_731[35]}},_GEN_731}; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_22_T_12 = $signed(_reg3_mat_real_22_T_9) + $signed(w3_mat_real_34); // @[calc6x6.scala 152:136]
  wire [37:0] _reg3_mat_comp_4_T_2 = $signed(w3_mat_comp_10) + $signed(w3_mat_comp_16); // @[calc6x6.scala 154:85]
  wire [37:0] _reg3_mat_comp_4_T_5 = $signed(_reg3_mat_comp_4_T_2) + $signed(w3_mat_comp_22); // @[calc6x6.scala 155:62]
  wire [37:0] _reg3_mat_comp_4_T_8 = $signed(_reg3_mat_comp_4_T_5) + $signed(w3_mat_comp_28); // @[calc6x6.scala 155:84]
  wire [35:0] _GEN_732 = _reg3_mat_comp_4_T_8[37:2]; // @[calc6x6.scala 155:107]
  wire [37:0] _reg3_mat_comp_4_T_9 = {{2{_GEN_732[35]}},_GEN_732}; // @[calc6x6.scala 155:107]
  wire [37:0] _reg3_mat_comp_4_T_12 = $signed(w3_mat_comp_4) + $signed(_reg3_mat_comp_4_T_9); // @[calc6x6.scala 154:61]
  wire [37:0] _reg3_mat_comp_10_T_2 = $signed(w3_mat_comp_10) - $signed(w3_mat_comp_16); // @[calc6x6.scala 156:62]
  wire [37:0] _reg3_mat_comp_10_T_5 = $signed(_reg3_mat_comp_10_T_2) + $signed(w3_mat_real_22); // @[calc6x6.scala 156:84]
  wire [37:0] _reg3_mat_comp_10_T_8 = $signed(_reg3_mat_comp_10_T_5) - $signed(w3_mat_real_28); // @[calc6x6.scala 156:106]
  wire [35:0] _GEN_733 = _reg3_mat_comp_10_T_8[37:2]; // @[calc6x6.scala 156:129]
  wire [37:0] _reg3_mat_comp_10_T_9 = {{2{_GEN_733[35]}},_GEN_733}; // @[calc6x6.scala 156:129]
  wire [37:0] _reg3_mat_comp_16_T_5 = $signed(_reg3_mat_comp_4_T_2) - $signed(w3_mat_comp_22); // @[calc6x6.scala 157:84]
  wire [37:0] _reg3_mat_comp_16_T_8 = $signed(_reg3_mat_comp_16_T_5) - $signed(w3_mat_comp_28); // @[calc6x6.scala 157:106]
  wire [35:0] _GEN_734 = _reg3_mat_comp_16_T_8[37:2]; // @[calc6x6.scala 157:129]
  wire [37:0] _reg3_mat_comp_16_T_9 = {{2{_GEN_734[35]}},_GEN_734}; // @[calc6x6.scala 157:129]
  wire [37:0] _reg3_mat_comp_22_T_5 = $signed(_reg3_mat_comp_10_T_2) - $signed(w3_mat_real_22); // @[calc6x6.scala 158:85]
  wire [37:0] _reg3_mat_comp_22_T_8 = $signed(_reg3_mat_comp_22_T_5) + $signed(w3_mat_real_28); // @[calc6x6.scala 158:107]
  wire [35:0] _GEN_735 = _reg3_mat_comp_22_T_8[37:2]; // @[calc6x6.scala 158:130]
  wire [37:0] _reg3_mat_comp_22_T_9 = {{2{_GEN_735[35]}},_GEN_735}; // @[calc6x6.scala 158:130]
  wire [37:0] _reg3_mat_comp_22_T_12 = $signed(_reg3_mat_comp_22_T_9) + $signed(w3_mat_comp_34); // @[calc6x6.scala 158:136]
  wire [37:0] _reg3_mat_real_5_T_2 = $signed(w3_mat_real_11) + $signed(w3_mat_real_17); // @[calc6x6.scala 148:85]
  wire [37:0] _reg3_mat_real_5_T_5 = $signed(_reg3_mat_real_5_T_2) + $signed(w3_mat_real_23); // @[calc6x6.scala 149:62]
  wire [37:0] _reg3_mat_real_5_T_8 = $signed(_reg3_mat_real_5_T_5) + $signed(w3_mat_real_29); // @[calc6x6.scala 149:84]
  wire [35:0] _GEN_736 = _reg3_mat_real_5_T_8[37:2]; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_5_T_9 = {{2{_GEN_736[35]}},_GEN_736}; // @[calc6x6.scala 149:107]
  wire [37:0] _reg3_mat_real_5_T_12 = $signed(w3_mat_real_5) + $signed(_reg3_mat_real_5_T_9); // @[calc6x6.scala 148:61]
  wire [37:0] _reg3_mat_real_11_T_2 = $signed(w3_mat_real_11) - $signed(w3_mat_real_17); // @[calc6x6.scala 150:62]
  wire [37:0] _reg3_mat_real_11_T_5 = $signed(_reg3_mat_real_11_T_2) - $signed(w3_mat_comp_23); // @[calc6x6.scala 150:84]
  wire [37:0] _reg3_mat_real_11_T_8 = $signed(_reg3_mat_real_11_T_5) + $signed(w3_mat_comp_29); // @[calc6x6.scala 150:106]
  wire [35:0] _GEN_737 = _reg3_mat_real_11_T_8[37:2]; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_11_T_9 = {{2{_GEN_737[35]}},_GEN_737}; // @[calc6x6.scala 150:129]
  wire [37:0] _reg3_mat_real_17_T_5 = $signed(_reg3_mat_real_5_T_2) - $signed(w3_mat_real_23); // @[calc6x6.scala 151:84]
  wire [37:0] _reg3_mat_real_17_T_8 = $signed(_reg3_mat_real_17_T_5) - $signed(w3_mat_real_29); // @[calc6x6.scala 151:106]
  wire [35:0] _GEN_738 = _reg3_mat_real_17_T_8[37:2]; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_17_T_9 = {{2{_GEN_738[35]}},_GEN_738}; // @[calc6x6.scala 151:129]
  wire [37:0] _reg3_mat_real_23_T_5 = $signed(_reg3_mat_real_11_T_2) + $signed(w3_mat_comp_23); // @[calc6x6.scala 152:85]
  wire [37:0] _reg3_mat_real_23_T_8 = $signed(_reg3_mat_real_23_T_5) - $signed(w3_mat_comp_29); // @[calc6x6.scala 152:107]
  wire [35:0] _GEN_739 = _reg3_mat_real_23_T_8[37:2]; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_23_T_9 = {{2{_GEN_739[35]}},_GEN_739}; // @[calc6x6.scala 152:130]
  wire [37:0] _reg3_mat_real_23_T_12 = $signed(_reg3_mat_real_23_T_9) + $signed(w3_mat_real_35); // @[calc6x6.scala 152:136]
  wire  _T_2 = 2'h0 == io_flag; // @[Conditional.scala 37:30]
  wire  _T_5 = 2'h1 == io_flag; // @[Conditional.scala 37:30]
  wire  _T_8 = 2'h2 == io_flag; // @[Conditional.scala 37:30]
  wire [37:0] _io_output_mat_0_T_2 = $signed(reg3_mat_real_1) + $signed(reg3_mat_real_2); // @[calc6x6.scala 164:85]
  wire [37:0] _io_output_mat_0_T_5 = $signed(_io_output_mat_0_T_2) + $signed(reg3_mat_real_3); // @[calc6x6.scala 165:62]
  wire [37:0] _io_output_mat_0_T_8 = $signed(_io_output_mat_0_T_5) + $signed(reg3_mat_real_4); // @[calc6x6.scala 165:84]
  wire [35:0] _GEN_744 = _io_output_mat_0_T_8[37:2]; // @[calc6x6.scala 165:107]
  wire [37:0] _io_output_mat_0_T_9 = {{2{_GEN_744[35]}},_GEN_744}; // @[calc6x6.scala 165:107]
  wire [37:0] _io_output_mat_0_T_12 = $signed(reg3_mat_real_0) + $signed(_io_output_mat_0_T_9); // @[calc6x6.scala 164:61]
  wire [37:0] _io_output_mat_1_T_2 = $signed(reg3_mat_real_1) - $signed(reg3_mat_real_2); // @[calc6x6.scala 166:63]
  wire [37:0] _io_output_mat_1_T_5 = $signed(_io_output_mat_1_T_2) - $signed(reg3_mat_comp_3); // @[calc6x6.scala 166:85]
  wire [37:0] _io_output_mat_1_T_8 = $signed(_io_output_mat_1_T_5) + $signed(reg3_mat_comp_4); // @[calc6x6.scala 166:107]
  wire [35:0] _GEN_745 = _io_output_mat_1_T_8[37:2]; // @[calc6x6.scala 166:130]
  wire [37:0] _io_output_mat_1_T_9 = {{2{_GEN_745[35]}},_GEN_745}; // @[calc6x6.scala 166:130]
  wire [37:0] _io_output_mat_2_T_5 = $signed(_io_output_mat_0_T_2) - $signed(reg3_mat_real_3); // @[calc6x6.scala 167:85]
  wire [37:0] _io_output_mat_2_T_8 = $signed(_io_output_mat_2_T_5) - $signed(reg3_mat_real_4); // @[calc6x6.scala 167:107]
  wire [35:0] _GEN_746 = _io_output_mat_2_T_8[37:2]; // @[calc6x6.scala 167:130]
  wire [37:0] _io_output_mat_2_T_9 = {{2{_GEN_746[35]}},_GEN_746}; // @[calc6x6.scala 167:130]
  wire [37:0] _io_output_mat_3_T_5 = $signed(_io_output_mat_1_T_2) + $signed(reg3_mat_comp_3); // @[calc6x6.scala 168:85]
  wire [37:0] _io_output_mat_3_T_8 = $signed(_io_output_mat_3_T_5) - $signed(reg3_mat_comp_4); // @[calc6x6.scala 168:107]
  wire [35:0] _GEN_747 = _io_output_mat_3_T_8[37:2]; // @[calc6x6.scala 168:130]
  wire [37:0] _io_output_mat_3_T_9 = {{2{_GEN_747[35]}},_GEN_747}; // @[calc6x6.scala 168:130]
  wire [37:0] _io_output_mat_3_T_12 = $signed(_io_output_mat_3_T_9) + $signed(reg3_mat_real_5); // @[calc6x6.scala 168:136]
  wire [37:0] _io_output_mat_4_T_2 = $signed(reg3_mat_real_7) + $signed(reg3_mat_real_8); // @[calc6x6.scala 164:85]
  wire [37:0] _io_output_mat_4_T_5 = $signed(_io_output_mat_4_T_2) + $signed(reg3_mat_real_9); // @[calc6x6.scala 165:62]
  wire [37:0] _io_output_mat_4_T_8 = $signed(_io_output_mat_4_T_5) + $signed(reg3_mat_real_10); // @[calc6x6.scala 165:84]
  wire [35:0] _GEN_748 = _io_output_mat_4_T_8[37:2]; // @[calc6x6.scala 165:107]
  wire [37:0] _io_output_mat_4_T_9 = {{2{_GEN_748[35]}},_GEN_748}; // @[calc6x6.scala 165:107]
  wire [37:0] _io_output_mat_4_T_12 = $signed(reg3_mat_real_6) + $signed(_io_output_mat_4_T_9); // @[calc6x6.scala 164:61]
  wire [37:0] _io_output_mat_5_T_2 = $signed(reg3_mat_real_7) - $signed(reg3_mat_real_8); // @[calc6x6.scala 166:63]
  wire [37:0] _io_output_mat_5_T_5 = $signed(_io_output_mat_5_T_2) - $signed(reg3_mat_comp_9); // @[calc6x6.scala 166:85]
  wire [37:0] _io_output_mat_5_T_8 = $signed(_io_output_mat_5_T_5) + $signed(reg3_mat_comp_10); // @[calc6x6.scala 166:107]
  wire [35:0] _GEN_749 = _io_output_mat_5_T_8[37:2]; // @[calc6x6.scala 166:130]
  wire [37:0] _io_output_mat_5_T_9 = {{2{_GEN_749[35]}},_GEN_749}; // @[calc6x6.scala 166:130]
  wire [37:0] _io_output_mat_6_T_5 = $signed(_io_output_mat_4_T_2) - $signed(reg3_mat_real_9); // @[calc6x6.scala 167:85]
  wire [37:0] _io_output_mat_6_T_8 = $signed(_io_output_mat_6_T_5) - $signed(reg3_mat_real_10); // @[calc6x6.scala 167:107]
  wire [35:0] _GEN_750 = _io_output_mat_6_T_8[37:2]; // @[calc6x6.scala 167:130]
  wire [37:0] _io_output_mat_6_T_9 = {{2{_GEN_750[35]}},_GEN_750}; // @[calc6x6.scala 167:130]
  wire [37:0] _io_output_mat_7_T_5 = $signed(_io_output_mat_5_T_2) + $signed(reg3_mat_comp_9); // @[calc6x6.scala 168:85]
  wire [37:0] _io_output_mat_7_T_8 = $signed(_io_output_mat_7_T_5) - $signed(reg3_mat_comp_10); // @[calc6x6.scala 168:107]
  wire [35:0] _GEN_751 = _io_output_mat_7_T_8[37:2]; // @[calc6x6.scala 168:130]
  wire [37:0] _io_output_mat_7_T_9 = {{2{_GEN_751[35]}},_GEN_751}; // @[calc6x6.scala 168:130]
  wire [37:0] _io_output_mat_7_T_12 = $signed(_io_output_mat_7_T_9) + $signed(reg3_mat_real_11); // @[calc6x6.scala 168:136]
  wire [37:0] _io_output_mat_8_T_2 = $signed(reg3_mat_real_13) + $signed(reg3_mat_real_14); // @[calc6x6.scala 164:85]
  wire [37:0] _io_output_mat_8_T_5 = $signed(_io_output_mat_8_T_2) + $signed(reg3_mat_real_15); // @[calc6x6.scala 165:62]
  wire [37:0] _io_output_mat_8_T_8 = $signed(_io_output_mat_8_T_5) + $signed(reg3_mat_real_16); // @[calc6x6.scala 165:84]
  wire [35:0] _GEN_752 = _io_output_mat_8_T_8[37:2]; // @[calc6x6.scala 165:107]
  wire [37:0] _io_output_mat_8_T_9 = {{2{_GEN_752[35]}},_GEN_752}; // @[calc6x6.scala 165:107]
  wire [37:0] _io_output_mat_8_T_12 = $signed(reg3_mat_real_12) + $signed(_io_output_mat_8_T_9); // @[calc6x6.scala 164:61]
  wire [37:0] _io_output_mat_9_T_2 = $signed(reg3_mat_real_13) - $signed(reg3_mat_real_14); // @[calc6x6.scala 166:63]
  wire [37:0] _io_output_mat_9_T_5 = $signed(_io_output_mat_9_T_2) - $signed(reg3_mat_comp_15); // @[calc6x6.scala 166:85]
  wire [37:0] _io_output_mat_9_T_8 = $signed(_io_output_mat_9_T_5) + $signed(reg3_mat_comp_16); // @[calc6x6.scala 166:107]
  wire [35:0] _GEN_753 = _io_output_mat_9_T_8[37:2]; // @[calc6x6.scala 166:130]
  wire [37:0] _io_output_mat_9_T_9 = {{2{_GEN_753[35]}},_GEN_753}; // @[calc6x6.scala 166:130]
  wire [37:0] _io_output_mat_10_T_5 = $signed(_io_output_mat_8_T_2) - $signed(reg3_mat_real_15); // @[calc6x6.scala 167:85]
  wire [37:0] _io_output_mat_10_T_8 = $signed(_io_output_mat_10_T_5) - $signed(reg3_mat_real_16); // @[calc6x6.scala 167:107]
  wire [35:0] _GEN_754 = _io_output_mat_10_T_8[37:2]; // @[calc6x6.scala 167:130]
  wire [37:0] _io_output_mat_10_T_9 = {{2{_GEN_754[35]}},_GEN_754}; // @[calc6x6.scala 167:130]
  wire [37:0] _io_output_mat_11_T_5 = $signed(_io_output_mat_9_T_2) + $signed(reg3_mat_comp_15); // @[calc6x6.scala 168:85]
  wire [37:0] _io_output_mat_11_T_8 = $signed(_io_output_mat_11_T_5) - $signed(reg3_mat_comp_16); // @[calc6x6.scala 168:107]
  wire [35:0] _GEN_755 = _io_output_mat_11_T_8[37:2]; // @[calc6x6.scala 168:130]
  wire [37:0] _io_output_mat_11_T_9 = {{2{_GEN_755[35]}},_GEN_755}; // @[calc6x6.scala 168:130]
  wire [37:0] _io_output_mat_11_T_12 = $signed(_io_output_mat_11_T_9) + $signed(reg3_mat_real_17); // @[calc6x6.scala 168:136]
  wire [37:0] _io_output_mat_12_T_2 = $signed(reg3_mat_real_19) + $signed(reg3_mat_real_20); // @[calc6x6.scala 164:85]
  wire [37:0] _io_output_mat_12_T_5 = $signed(_io_output_mat_12_T_2) + $signed(reg3_mat_real_21); // @[calc6x6.scala 165:62]
  wire [37:0] _io_output_mat_12_T_8 = $signed(_io_output_mat_12_T_5) + $signed(reg3_mat_real_22); // @[calc6x6.scala 165:84]
  wire [35:0] _GEN_756 = _io_output_mat_12_T_8[37:2]; // @[calc6x6.scala 165:107]
  wire [37:0] _io_output_mat_12_T_9 = {{2{_GEN_756[35]}},_GEN_756}; // @[calc6x6.scala 165:107]
  wire [37:0] _io_output_mat_12_T_12 = $signed(reg3_mat_real_18) + $signed(_io_output_mat_12_T_9); // @[calc6x6.scala 164:61]
  wire [37:0] _io_output_mat_13_T_2 = $signed(reg3_mat_real_19) - $signed(reg3_mat_real_20); // @[calc6x6.scala 166:63]
  wire [37:0] _io_output_mat_13_T_5 = $signed(_io_output_mat_13_T_2) - $signed(reg3_mat_comp_21); // @[calc6x6.scala 166:85]
  wire [37:0] _io_output_mat_13_T_8 = $signed(_io_output_mat_13_T_5) + $signed(reg3_mat_comp_22); // @[calc6x6.scala 166:107]
  wire [35:0] _GEN_757 = _io_output_mat_13_T_8[37:2]; // @[calc6x6.scala 166:130]
  wire [37:0] _io_output_mat_13_T_9 = {{2{_GEN_757[35]}},_GEN_757}; // @[calc6x6.scala 166:130]
  wire [37:0] _io_output_mat_14_T_5 = $signed(_io_output_mat_12_T_2) - $signed(reg3_mat_real_21); // @[calc6x6.scala 167:85]
  wire [37:0] _io_output_mat_14_T_8 = $signed(_io_output_mat_14_T_5) - $signed(reg3_mat_real_22); // @[calc6x6.scala 167:107]
  wire [35:0] _GEN_758 = _io_output_mat_14_T_8[37:2]; // @[calc6x6.scala 167:130]
  wire [37:0] _io_output_mat_14_T_9 = {{2{_GEN_758[35]}},_GEN_758}; // @[calc6x6.scala 167:130]
  wire [37:0] _io_output_mat_15_T_5 = $signed(_io_output_mat_13_T_2) + $signed(reg3_mat_comp_21); // @[calc6x6.scala 168:85]
  wire [37:0] _io_output_mat_15_T_8 = $signed(_io_output_mat_15_T_5) - $signed(reg3_mat_comp_22); // @[calc6x6.scala 168:107]
  wire [35:0] _GEN_759 = _io_output_mat_15_T_8[37:2]; // @[calc6x6.scala 168:130]
  wire [37:0] _io_output_mat_15_T_9 = {{2{_GEN_759[35]}},_GEN_759}; // @[calc6x6.scala 168:130]
  wire [37:0] _io_output_mat_15_T_12 = $signed(_io_output_mat_15_T_9) + $signed(reg3_mat_real_23); // @[calc6x6.scala 168:136]
  wire [19:0] _comp1_0_in_b_T_3 = $signed(reg2_mat_real_3) + $signed(reg2_mat_comp_6); // @[calc6x6.scala 261:65]
  wire [42:0] comp2_0_result = Core_26_io_result; // @[calc6x6.scala 72:24 calc6x6.scala 72:24]
  wire [42:0] comp3_0_result = Core_36_io_result; // @[calc6x6.scala 73:24 calc6x6.scala 73:24]
  wire [42:0] _w3_mat_real_3_T_2 = $signed(comp2_0_result) - $signed(comp3_0_result); // @[calc6x6.scala 264:65]
  wire [42:0] comp1_0_result = Core_16_io_result; // @[calc6x6.scala 71:24 calc6x6.scala 71:24]
  wire [42:0] _w3_mat_comp_3_T_2 = $signed(comp1_0_result) - $signed(comp2_0_result); // @[calc6x6.scala 265:65]
  wire [42:0] _w3_mat_comp_3_T_5 = $signed(_w3_mat_comp_3_T_2) - $signed(comp3_0_result); // @[calc6x6.scala 265:81]
  wire [42:0] _w3_mat_comp_4_T_2 = 43'sh0 - $signed(comp1_0_result); // @[calc6x6.scala 272:50]
  wire [42:0] _w3_mat_comp_4_T_5 = $signed(_w3_mat_comp_4_T_2) + $signed(comp2_0_result); // @[calc6x6.scala 272:71]
  wire [42:0] _w3_mat_comp_4_T_8 = $signed(_w3_mat_comp_4_T_5) + $signed(comp3_0_result); // @[calc6x6.scala 272:92]
  wire [19:0] _comp1_1_in_b_T_3 = $signed(reg2_mat_real_9) + $signed(reg2_mat_comp_7); // @[calc6x6.scala 261:65]
  wire [42:0] comp2_1_result = Core_27_io_result; // @[calc6x6.scala 72:24 calc6x6.scala 72:24]
  wire [42:0] comp3_1_result = Core_37_io_result; // @[calc6x6.scala 73:24 calc6x6.scala 73:24]
  wire [42:0] _w3_mat_real_9_T_2 = $signed(comp2_1_result) - $signed(comp3_1_result); // @[calc6x6.scala 264:65]
  wire [42:0] comp1_1_result = Core_17_io_result; // @[calc6x6.scala 71:24 calc6x6.scala 71:24]
  wire [42:0] _w3_mat_comp_9_T_2 = $signed(comp1_1_result) - $signed(comp2_1_result); // @[calc6x6.scala 265:65]
  wire [42:0] _w3_mat_comp_9_T_5 = $signed(_w3_mat_comp_9_T_2) - $signed(comp3_1_result); // @[calc6x6.scala 265:81]
  wire [42:0] _w3_mat_comp_10_T_2 = 43'sh0 - $signed(comp1_1_result); // @[calc6x6.scala 272:50]
  wire [42:0] _w3_mat_comp_10_T_5 = $signed(_w3_mat_comp_10_T_2) + $signed(comp2_1_result); // @[calc6x6.scala 272:71]
  wire [42:0] _w3_mat_comp_10_T_8 = $signed(_w3_mat_comp_10_T_5) + $signed(comp3_1_result); // @[calc6x6.scala 272:92]
  wire [19:0] _comp1_2_in_b_T_3 = $signed(reg2_mat_real_15) + $signed(reg2_mat_comp_8); // @[calc6x6.scala 261:65]
  wire [42:0] comp2_2_result = Core_28_io_result; // @[calc6x6.scala 72:24 calc6x6.scala 72:24]
  wire [42:0] comp3_2_result = Core_38_io_result; // @[calc6x6.scala 73:24 calc6x6.scala 73:24]
  wire [42:0] _w3_mat_real_15_T_2 = $signed(comp2_2_result) - $signed(comp3_2_result); // @[calc6x6.scala 264:65]
  wire [42:0] comp1_2_result = Core_18_io_result; // @[calc6x6.scala 71:24 calc6x6.scala 71:24]
  wire [42:0] _w3_mat_comp_15_T_2 = $signed(comp1_2_result) - $signed(comp2_2_result); // @[calc6x6.scala 265:65]
  wire [42:0] _w3_mat_comp_15_T_5 = $signed(_w3_mat_comp_15_T_2) - $signed(comp3_2_result); // @[calc6x6.scala 265:81]
  wire [42:0] _w3_mat_comp_16_T_2 = 43'sh0 - $signed(comp1_2_result); // @[calc6x6.scala 272:50]
  wire [42:0] _w3_mat_comp_16_T_5 = $signed(_w3_mat_comp_16_T_2) + $signed(comp2_2_result); // @[calc6x6.scala 272:71]
  wire [42:0] _w3_mat_comp_16_T_8 = $signed(_w3_mat_comp_16_T_5) + $signed(comp3_2_result); // @[calc6x6.scala 272:92]
  wire [19:0] _comp1_3_in_b_T_3 = $signed(reg2_mat_real_18) + $signed(reg2_mat_comp_0); // @[calc6x6.scala 238:65]
  wire [42:0] comp2_3_result = Core_29_io_result; // @[calc6x6.scala 72:24 calc6x6.scala 72:24]
  wire [42:0] comp3_3_result = Core_39_io_result; // @[calc6x6.scala 73:24 calc6x6.scala 73:24]
  wire [42:0] _w3_mat_real_18_T_2 = $signed(comp2_3_result) - $signed(comp3_3_result); // @[calc6x6.scala 241:65]
  wire [42:0] comp1_3_result = Core_19_io_result; // @[calc6x6.scala 71:24 calc6x6.scala 71:24]
  wire [42:0] _w3_mat_comp_18_T_2 = $signed(comp1_3_result) - $signed(comp2_3_result); // @[calc6x6.scala 242:65]
  wire [42:0] _w3_mat_comp_18_T_5 = $signed(_w3_mat_comp_18_T_2) - $signed(comp3_3_result); // @[calc6x6.scala 242:81]
  wire [19:0] _comp1_4_in_b_T_3 = $signed(reg2_mat_real_19) + $signed(reg2_mat_comp_1); // @[calc6x6.scala 238:65]
  wire [42:0] comp2_4_result = Core_30_io_result; // @[calc6x6.scala 72:24 calc6x6.scala 72:24]
  wire [42:0] comp3_4_result = Core_40_io_result; // @[calc6x6.scala 73:24 calc6x6.scala 73:24]
  wire [42:0] _w3_mat_real_19_T_2 = $signed(comp2_4_result) - $signed(comp3_4_result); // @[calc6x6.scala 241:65]
  wire [42:0] comp1_4_result = Core_20_io_result; // @[calc6x6.scala 71:24 calc6x6.scala 71:24]
  wire [42:0] _w3_mat_comp_19_T_2 = $signed(comp1_4_result) - $signed(comp2_4_result); // @[calc6x6.scala 242:65]
  wire [42:0] _w3_mat_comp_19_T_5 = $signed(_w3_mat_comp_19_T_2) - $signed(comp3_4_result); // @[calc6x6.scala 242:81]
  wire [19:0] _comp1_5_in_b_T_3 = $signed(reg2_mat_real_20) + $signed(reg2_mat_comp_2); // @[calc6x6.scala 238:65]
  wire [42:0] comp2_5_result = Core_31_io_result; // @[calc6x6.scala 72:24 calc6x6.scala 72:24]
  wire [42:0] comp3_5_result = Core_41_io_result; // @[calc6x6.scala 73:24 calc6x6.scala 73:24]
  wire [42:0] _w3_mat_real_20_T_2 = $signed(comp2_5_result) - $signed(comp3_5_result); // @[calc6x6.scala 241:65]
  wire [42:0] comp1_5_result = Core_21_io_result; // @[calc6x6.scala 71:24 calc6x6.scala 71:24]
  wire [42:0] _w3_mat_comp_20_T_2 = $signed(comp1_5_result) - $signed(comp2_5_result); // @[calc6x6.scala 242:65]
  wire [42:0] _w3_mat_comp_20_T_5 = $signed(_w3_mat_comp_20_T_2) - $signed(comp3_5_result); // @[calc6x6.scala 242:81]
  wire [19:0] _comp1_6_in_b_T_3 = $signed(reg2_mat_real_21) + $signed(reg2_mat_comp_3); // @[calc6x6.scala 238:65]
  wire [42:0] comp2_6_result = Core_32_io_result; // @[calc6x6.scala 72:24 calc6x6.scala 72:24]
  wire [42:0] comp3_6_result = Core_42_io_result; // @[calc6x6.scala 73:24 calc6x6.scala 73:24]
  wire [42:0] _w3_mat_real_21_T_2 = $signed(comp2_6_result) - $signed(comp3_6_result); // @[calc6x6.scala 241:65]
  wire [42:0] comp1_6_result = Core_22_io_result; // @[calc6x6.scala 71:24 calc6x6.scala 71:24]
  wire [42:0] _w3_mat_comp_21_T_2 = $signed(comp1_6_result) - $signed(comp2_6_result); // @[calc6x6.scala 242:65]
  wire [42:0] _w3_mat_comp_21_T_5 = $signed(_w3_mat_comp_21_T_2) - $signed(comp3_6_result); // @[calc6x6.scala 242:81]
  wire [19:0] _comp1_7_in_b_T_3 = $signed(reg2_mat_real_22) + $signed(reg2_mat_comp_4); // @[calc6x6.scala 238:65]
  wire [42:0] comp2_7_result = Core_33_io_result; // @[calc6x6.scala 72:24 calc6x6.scala 72:24]
  wire [42:0] comp3_7_result = Core_43_io_result; // @[calc6x6.scala 73:24 calc6x6.scala 73:24]
  wire [42:0] _w3_mat_real_22_T_2 = $signed(comp2_7_result) - $signed(comp3_7_result); // @[calc6x6.scala 241:65]
  wire [42:0] comp1_7_result = Core_23_io_result; // @[calc6x6.scala 71:24 calc6x6.scala 71:24]
  wire [42:0] _w3_mat_comp_22_T_2 = $signed(comp1_7_result) - $signed(comp2_7_result); // @[calc6x6.scala 242:65]
  wire [42:0] _w3_mat_comp_22_T_5 = $signed(_w3_mat_comp_22_T_2) - $signed(comp3_7_result); // @[calc6x6.scala 242:81]
  wire [19:0] _comp1_8_in_b_T_3 = $signed(reg2_mat_real_23) + $signed(reg2_mat_comp_5); // @[calc6x6.scala 238:65]
  wire [42:0] comp2_8_result = Core_34_io_result; // @[calc6x6.scala 72:24 calc6x6.scala 72:24]
  wire [42:0] comp3_8_result = Core_44_io_result; // @[calc6x6.scala 73:24 calc6x6.scala 73:24]
  wire [42:0] _w3_mat_real_23_T_2 = $signed(comp2_8_result) - $signed(comp3_8_result); // @[calc6x6.scala 241:65]
  wire [42:0] comp1_8_result = Core_24_io_result; // @[calc6x6.scala 71:24 calc6x6.scala 71:24]
  wire [42:0] _w3_mat_comp_23_T_2 = $signed(comp1_8_result) - $signed(comp2_8_result); // @[calc6x6.scala 242:65]
  wire [42:0] _w3_mat_comp_23_T_5 = $signed(_w3_mat_comp_23_T_2) - $signed(comp3_8_result); // @[calc6x6.scala 242:81]
  wire [42:0] _w3_mat_comp_24_T_2 = 43'sh0 - $signed(comp1_3_result); // @[calc6x6.scala 250:50]
  wire [42:0] _w3_mat_comp_24_T_5 = $signed(_w3_mat_comp_24_T_2) + $signed(comp2_3_result); // @[calc6x6.scala 250:71]
  wire [42:0] _w3_mat_comp_24_T_8 = $signed(_w3_mat_comp_24_T_5) + $signed(comp3_3_result); // @[calc6x6.scala 250:92]
  wire [42:0] _w3_mat_comp_25_T_2 = 43'sh0 - $signed(comp1_4_result); // @[calc6x6.scala 250:50]
  wire [42:0] _w3_mat_comp_25_T_5 = $signed(_w3_mat_comp_25_T_2) + $signed(comp2_4_result); // @[calc6x6.scala 250:71]
  wire [42:0] _w3_mat_comp_25_T_8 = $signed(_w3_mat_comp_25_T_5) + $signed(comp3_4_result); // @[calc6x6.scala 250:92]
  wire [42:0] _w3_mat_comp_26_T_2 = 43'sh0 - $signed(comp1_5_result); // @[calc6x6.scala 250:50]
  wire [42:0] _w3_mat_comp_26_T_5 = $signed(_w3_mat_comp_26_T_2) + $signed(comp2_5_result); // @[calc6x6.scala 250:71]
  wire [42:0] _w3_mat_comp_26_T_8 = $signed(_w3_mat_comp_26_T_5) + $signed(comp3_5_result); // @[calc6x6.scala 250:92]
  wire [42:0] _w3_mat_comp_27_T_2 = 43'sh0 - $signed(comp1_7_result); // @[calc6x6.scala 250:50]
  wire [42:0] _w3_mat_comp_27_T_5 = $signed(_w3_mat_comp_27_T_2) + $signed(comp2_7_result); // @[calc6x6.scala 250:71]
  wire [42:0] _w3_mat_comp_27_T_8 = $signed(_w3_mat_comp_27_T_5) + $signed(comp3_7_result); // @[calc6x6.scala 250:92]
  wire [42:0] _w3_mat_comp_28_T_2 = 43'sh0 - $signed(comp1_6_result); // @[calc6x6.scala 250:50]
  wire [42:0] _w3_mat_comp_28_T_5 = $signed(_w3_mat_comp_28_T_2) + $signed(comp2_6_result); // @[calc6x6.scala 250:71]
  wire [42:0] _w3_mat_comp_28_T_8 = $signed(_w3_mat_comp_28_T_5) + $signed(comp3_6_result); // @[calc6x6.scala 250:92]
  wire [42:0] _w3_mat_comp_29_T_2 = 43'sh0 - $signed(comp1_8_result); // @[calc6x6.scala 250:50]
  wire [42:0] _w3_mat_comp_29_T_5 = $signed(_w3_mat_comp_29_T_2) + $signed(comp2_8_result); // @[calc6x6.scala 250:71]
  wire [42:0] _w3_mat_comp_29_T_8 = $signed(_w3_mat_comp_29_T_5) + $signed(comp3_8_result); // @[calc6x6.scala 250:92]
  wire [19:0] _comp1_9_in_b_T_3 = $signed(reg2_mat_real_33) + $signed(reg2_mat_comp_9); // @[calc6x6.scala 261:65]
  wire [42:0] comp2_9_result = Core_35_io_result; // @[calc6x6.scala 72:24 calc6x6.scala 72:24]
  wire [42:0] comp3_9_result = Core_45_io_result; // @[calc6x6.scala 73:24 calc6x6.scala 73:24]
  wire [42:0] _w3_mat_real_33_T_2 = $signed(comp2_9_result) - $signed(comp3_9_result); // @[calc6x6.scala 264:65]
  wire [42:0] comp1_9_result = Core_25_io_result; // @[calc6x6.scala 71:24 calc6x6.scala 71:24]
  wire [42:0] _w3_mat_comp_33_T_2 = $signed(comp1_9_result) - $signed(comp2_9_result); // @[calc6x6.scala 265:65]
  wire [42:0] _w3_mat_comp_33_T_5 = $signed(_w3_mat_comp_33_T_2) - $signed(comp3_9_result); // @[calc6x6.scala 265:81]
  wire [42:0] _w3_mat_comp_34_T_2 = 43'sh0 - $signed(comp1_9_result); // @[calc6x6.scala 272:50]
  wire [42:0] _w3_mat_comp_34_T_5 = $signed(_w3_mat_comp_34_T_2) + $signed(comp2_9_result); // @[calc6x6.scala 272:71]
  wire [42:0] _w3_mat_comp_34_T_8 = $signed(_w3_mat_comp_34_T_5) + $signed(comp3_9_result); // @[calc6x6.scala 272:92]
  wire [37:0] _GEN_0 = _T_8 ? $signed(_io_output_mat_0_T_12) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 164:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_1 = _T_8 ? $signed(_io_output_mat_1_T_9) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 166:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_2 = _T_8 ? $signed(_io_output_mat_2_T_9) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 167:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_3 = _T_8 ? $signed(_io_output_mat_3_T_12) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 168:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_4 = _T_8 ? $signed(_io_output_mat_4_T_12) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 164:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_5 = _T_8 ? $signed(_io_output_mat_5_T_9) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 166:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_6 = _T_8 ? $signed(_io_output_mat_6_T_9) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 167:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_7 = _T_8 ? $signed(_io_output_mat_7_T_12) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 168:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_8 = _T_8 ? $signed(_io_output_mat_8_T_12) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 164:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_9 = _T_8 ? $signed(_io_output_mat_9_T_9) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 166:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_10 = _T_8 ? $signed(_io_output_mat_10_T_9) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 167:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_11 = _T_8 ? $signed(_io_output_mat_11_T_12) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 168:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_12 = _T_8 ? $signed(_io_output_mat_12_T_12) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 164:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_13 = _T_8 ? $signed(_io_output_mat_13_T_9) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 166:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_14 = _T_8 ? $signed(_io_output_mat_14_T_9) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 167:37 calc6x6.scala 87:15]
  wire [37:0] _GEN_15 = _T_8 ? $signed(_io_output_mat_15_T_12) : $signed(38'sh0); // @[Conditional.scala 39:67 calc6x6.scala 168:37 calc6x6.scala 87:15]
  wire [24:0] _GEN_17 = _T_8 ? $signed({{5{reg2_mat_real_0[19]}},reg2_mat_real_0}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_18 = _T_8 ? $signed(io_weight_real_0) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_0_result = Core_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_19 = _T_8 ? $signed(real_0_result) : $signed({{5{w3_mat_real_0[37]}},w3_mat_real_0}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_21 = _T_8 ? $signed({{5{reg2_mat_real_1[19]}},reg2_mat_real_1}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_22 = _T_8 ? $signed(io_weight_real_1) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_1_result = Core_1_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_23 = _T_8 ? $signed(real_1_result) : $signed({{5{w3_mat_real_1[37]}},w3_mat_real_1}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_25 = _T_8 ? $signed({{5{reg2_mat_real_2[19]}},reg2_mat_real_2}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_26 = _T_8 ? $signed(io_weight_real_2) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_2_result = Core_2_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_27 = _T_8 ? $signed(real_2_result) : $signed({{5{w3_mat_real_2[37]}},w3_mat_real_2}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [17:0] _GEN_31 = _T_8 ? $signed(io_weight_comp1_0) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 257:38 calc6x6.scala 78:22]
  wire [17:0] _GEN_32 = _T_8 ? $signed(io_weight_comp2_0) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 258:38 calc6x6.scala 81:22]
  wire [17:0] _GEN_33 = _T_8 ? $signed(io_weight_comp3_0) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 259:38 calc6x6.scala 84:22]
  wire [24:0] _GEN_34 = _T_8 ? $signed({{5{_comp1_0_in_b_T_3[19]}},_comp1_0_in_b_T_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 261:39 calc6x6.scala 79:23]
  wire [24:0] _GEN_35 = _T_8 ? $signed({{5{reg2_mat_real_3[19]}},reg2_mat_real_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 262:39 calc6x6.scala 82:23]
  wire [24:0] _GEN_36 = _T_8 ? $signed({{5{reg2_mat_comp_6[19]}},reg2_mat_comp_6}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 263:39 calc6x6.scala 85:23]
  wire [42:0] _GEN_37 = _T_8 ? $signed(_w3_mat_real_3_T_2) : $signed({{5{w3_mat_real_3[37]}},w3_mat_real_3}); // @[Conditional.scala 39:67 calc6x6.scala 264:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_38 = _T_8 ? $signed(_w3_mat_comp_3_T_5) : $signed({{5{w3_mat_comp_3[37]}},w3_mat_comp_3}); // @[Conditional.scala 39:67 calc6x6.scala 265:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_39 = _T_8 ? $signed(_w3_mat_real_3_T_2) : $signed({{5{w3_mat_real_4[37]}},w3_mat_real_4}); // @[Conditional.scala 39:67 calc6x6.scala 271:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_40 = _T_8 ? $signed(_w3_mat_comp_4_T_8) : $signed({{5{w3_mat_comp_4[37]}},w3_mat_comp_4}); // @[Conditional.scala 39:67 calc6x6.scala 272:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_42 = _T_8 ? $signed({{5{reg2_mat_real_5[19]}},reg2_mat_real_5}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_43 = _T_8 ? $signed(io_weight_real_3) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_3_result = Core_3_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_44 = _T_8 ? $signed(real_3_result) : $signed({{5{w3_mat_real_5[37]}},w3_mat_real_5}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_46 = _T_8 ? $signed({{5{reg2_mat_real_6[19]}},reg2_mat_real_6}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_47 = _T_8 ? $signed(io_weight_real_4) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_4_result = Core_4_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_48 = _T_8 ? $signed(real_4_result) : $signed({{5{w3_mat_real_6[37]}},w3_mat_real_6}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_50 = _T_8 ? $signed({{5{reg2_mat_real_7[19]}},reg2_mat_real_7}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_51 = _T_8 ? $signed(io_weight_real_5) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_5_result = Core_5_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_52 = _T_8 ? $signed(real_5_result) : $signed({{5{w3_mat_real_7[37]}},w3_mat_real_7}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_54 = _T_8 ? $signed({{5{reg2_mat_real_8[19]}},reg2_mat_real_8}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_55 = _T_8 ? $signed(io_weight_real_6) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_6_result = Core_6_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_56 = _T_8 ? $signed(real_6_result) : $signed({{5{w3_mat_real_8[37]}},w3_mat_real_8}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [17:0] _GEN_60 = _T_8 ? $signed(io_weight_comp1_1) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 257:38 calc6x6.scala 78:22]
  wire [17:0] _GEN_61 = _T_8 ? $signed(io_weight_comp2_1) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 258:38 calc6x6.scala 81:22]
  wire [17:0] _GEN_62 = _T_8 ? $signed(io_weight_comp3_1) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 259:38 calc6x6.scala 84:22]
  wire [24:0] _GEN_63 = _T_8 ? $signed({{5{_comp1_1_in_b_T_3[19]}},_comp1_1_in_b_T_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 261:39 calc6x6.scala 79:23]
  wire [24:0] _GEN_64 = _T_8 ? $signed({{5{reg2_mat_real_9[19]}},reg2_mat_real_9}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 262:39 calc6x6.scala 82:23]
  wire [24:0] _GEN_65 = _T_8 ? $signed({{5{reg2_mat_comp_7[19]}},reg2_mat_comp_7}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 263:39 calc6x6.scala 85:23]
  wire [42:0] _GEN_66 = _T_8 ? $signed(_w3_mat_real_9_T_2) : $signed({{5{w3_mat_real_9[37]}},w3_mat_real_9}); // @[Conditional.scala 39:67 calc6x6.scala 264:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_67 = _T_8 ? $signed(_w3_mat_comp_9_T_5) : $signed({{5{w3_mat_comp_9[37]}},w3_mat_comp_9}); // @[Conditional.scala 39:67 calc6x6.scala 265:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_68 = _T_8 ? $signed(_w3_mat_real_9_T_2) : $signed({{5{w3_mat_real_10[37]}},w3_mat_real_10}); // @[Conditional.scala 39:67 calc6x6.scala 271:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_69 = _T_8 ? $signed(_w3_mat_comp_10_T_8) : $signed({{5{w3_mat_comp_10[37]}},w3_mat_comp_10}); // @[Conditional.scala 39:67 calc6x6.scala 272:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_71 = _T_8 ? $signed({{5{reg2_mat_real_11[19]}},reg2_mat_real_11}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_72 = _T_8 ? $signed(io_weight_real_7) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_7_result = Core_7_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_73 = _T_8 ? $signed(real_7_result) : $signed({{5{w3_mat_real_11[37]}},w3_mat_real_11}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_75 = _T_8 ? $signed({{5{reg2_mat_real_12[19]}},reg2_mat_real_12}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_76 = _T_8 ? $signed(io_weight_real_8) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_8_result = Core_8_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_77 = _T_8 ? $signed(real_8_result) : $signed({{5{w3_mat_real_12[37]}},w3_mat_real_12}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_79 = _T_8 ? $signed({{5{reg2_mat_real_13[19]}},reg2_mat_real_13}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_80 = _T_8 ? $signed(io_weight_real_9) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_9_result = Core_9_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_81 = _T_8 ? $signed(real_9_result) : $signed({{5{w3_mat_real_13[37]}},w3_mat_real_13}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_83 = _T_8 ? $signed({{5{reg2_mat_real_14[19]}},reg2_mat_real_14}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_84 = _T_8 ? $signed(io_weight_real_10) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_10_result = Core_10_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_85 = _T_8 ? $signed(real_10_result) : $signed({{5{w3_mat_real_14[37]}},w3_mat_real_14}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [17:0] _GEN_89 = _T_8 ? $signed(io_weight_comp1_2) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 257:38 calc6x6.scala 78:22]
  wire [17:0] _GEN_90 = _T_8 ? $signed(io_weight_comp2_2) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 258:38 calc6x6.scala 81:22]
  wire [17:0] _GEN_91 = _T_8 ? $signed(io_weight_comp3_2) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 259:38 calc6x6.scala 84:22]
  wire [24:0] _GEN_92 = _T_8 ? $signed({{5{_comp1_2_in_b_T_3[19]}},_comp1_2_in_b_T_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 261:39 calc6x6.scala 79:23]
  wire [24:0] _GEN_93 = _T_8 ? $signed({{5{reg2_mat_real_15[19]}},reg2_mat_real_15}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 262:39 calc6x6.scala 82:23]
  wire [24:0] _GEN_94 = _T_8 ? $signed({{5{reg2_mat_comp_8[19]}},reg2_mat_comp_8}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 263:39 calc6x6.scala 85:23]
  wire [42:0] _GEN_95 = _T_8 ? $signed(_w3_mat_real_15_T_2) : $signed({{5{w3_mat_real_15[37]}},w3_mat_real_15}); // @[Conditional.scala 39:67 calc6x6.scala 264:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_96 = _T_8 ? $signed(_w3_mat_comp_15_T_5) : $signed({{5{w3_mat_comp_15[37]}},w3_mat_comp_15}); // @[Conditional.scala 39:67 calc6x6.scala 265:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_97 = _T_8 ? $signed(_w3_mat_real_15_T_2) : $signed({{5{w3_mat_real_16[37]}},w3_mat_real_16}); // @[Conditional.scala 39:67 calc6x6.scala 271:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_98 = _T_8 ? $signed(_w3_mat_comp_16_T_8) : $signed({{5{w3_mat_comp_16[37]}},w3_mat_comp_16}); // @[Conditional.scala 39:67 calc6x6.scala 272:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_100 = _T_8 ? $signed({{5{reg2_mat_real_17[19]}},reg2_mat_real_17}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_101 = _T_8 ? $signed(io_weight_real_11) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_11_result = Core_11_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_102 = _T_8 ? $signed(real_11_result) : $signed({{5{w3_mat_real_17[37]}},w3_mat_real_17}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [17:0] _GEN_106 = _T_8 ? $signed(io_weight_comp1_3) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 234:38 calc6x6.scala 78:22]
  wire [17:0] _GEN_107 = _T_8 ? $signed(io_weight_comp2_3) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 235:38 calc6x6.scala 81:22]
  wire [17:0] _GEN_108 = _T_8 ? $signed(io_weight_comp3_3) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 236:38 calc6x6.scala 84:22]
  wire [24:0] _GEN_109 = _T_8 ? $signed({{5{_comp1_3_in_b_T_3[19]}},_comp1_3_in_b_T_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 238:39 calc6x6.scala 79:23]
  wire [24:0] _GEN_110 = _T_8 ? $signed({{5{reg2_mat_real_18[19]}},reg2_mat_real_18}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 239:39 calc6x6.scala 82:23]
  wire [24:0] _GEN_111 = _T_8 ? $signed({{5{reg2_mat_comp_0[19]}},reg2_mat_comp_0}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 240:39 calc6x6.scala 85:23]
  wire [42:0] _GEN_112 = _T_8 ? $signed(_w3_mat_real_18_T_2) : $signed({{5{w3_mat_real_18[37]}},w3_mat_real_18}); // @[Conditional.scala 39:67 calc6x6.scala 241:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_113 = _T_8 ? $signed(_w3_mat_comp_18_T_5) : $signed({{5{w3_mat_comp_18[37]}},w3_mat_comp_18}); // @[Conditional.scala 39:67 calc6x6.scala 242:47 calc6x6.scala 93:21]
  wire [17:0] _GEN_117 = _T_8 ? $signed(io_weight_comp1_4) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 234:38 calc6x6.scala 78:22]
  wire [17:0] _GEN_118 = _T_8 ? $signed(io_weight_comp2_4) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 235:38 calc6x6.scala 81:22]
  wire [17:0] _GEN_119 = _T_8 ? $signed(io_weight_comp3_4) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 236:38 calc6x6.scala 84:22]
  wire [24:0] _GEN_120 = _T_8 ? $signed({{5{_comp1_4_in_b_T_3[19]}},_comp1_4_in_b_T_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 238:39 calc6x6.scala 79:23]
  wire [24:0] _GEN_121 = _T_8 ? $signed({{5{reg2_mat_real_19[19]}},reg2_mat_real_19}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 239:39 calc6x6.scala 82:23]
  wire [24:0] _GEN_122 = _T_8 ? $signed({{5{reg2_mat_comp_1[19]}},reg2_mat_comp_1}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 240:39 calc6x6.scala 85:23]
  wire [42:0] _GEN_123 = _T_8 ? $signed(_w3_mat_real_19_T_2) : $signed({{5{w3_mat_real_19[37]}},w3_mat_real_19}); // @[Conditional.scala 39:67 calc6x6.scala 241:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_124 = _T_8 ? $signed(_w3_mat_comp_19_T_5) : $signed({{5{w3_mat_comp_19[37]}},w3_mat_comp_19}); // @[Conditional.scala 39:67 calc6x6.scala 242:47 calc6x6.scala 93:21]
  wire [17:0] _GEN_128 = _T_8 ? $signed(io_weight_comp1_5) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 234:38 calc6x6.scala 78:22]
  wire [17:0] _GEN_129 = _T_8 ? $signed(io_weight_comp2_5) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 235:38 calc6x6.scala 81:22]
  wire [17:0] _GEN_130 = _T_8 ? $signed(io_weight_comp3_5) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 236:38 calc6x6.scala 84:22]
  wire [24:0] _GEN_131 = _T_8 ? $signed({{5{_comp1_5_in_b_T_3[19]}},_comp1_5_in_b_T_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 238:39 calc6x6.scala 79:23]
  wire [24:0] _GEN_132 = _T_8 ? $signed({{5{reg2_mat_real_20[19]}},reg2_mat_real_20}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 239:39 calc6x6.scala 82:23]
  wire [24:0] _GEN_133 = _T_8 ? $signed({{5{reg2_mat_comp_2[19]}},reg2_mat_comp_2}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 240:39 calc6x6.scala 85:23]
  wire [42:0] _GEN_134 = _T_8 ? $signed(_w3_mat_real_20_T_2) : $signed({{5{w3_mat_real_20[37]}},w3_mat_real_20}); // @[Conditional.scala 39:67 calc6x6.scala 241:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_135 = _T_8 ? $signed(_w3_mat_comp_20_T_5) : $signed({{5{w3_mat_comp_20[37]}},w3_mat_comp_20}); // @[Conditional.scala 39:67 calc6x6.scala 242:47 calc6x6.scala 93:21]
  wire [17:0] _GEN_139 = _T_8 ? $signed(io_weight_comp1_6) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 234:38 calc6x6.scala 78:22]
  wire [17:0] _GEN_140 = _T_8 ? $signed(io_weight_comp2_6) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 235:38 calc6x6.scala 81:22]
  wire [17:0] _GEN_141 = _T_8 ? $signed(io_weight_comp3_6) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 236:38 calc6x6.scala 84:22]
  wire [24:0] _GEN_142 = _T_8 ? $signed({{5{_comp1_6_in_b_T_3[19]}},_comp1_6_in_b_T_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 238:39 calc6x6.scala 79:23]
  wire [24:0] _GEN_143 = _T_8 ? $signed({{5{reg2_mat_real_21[19]}},reg2_mat_real_21}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 239:39 calc6x6.scala 82:23]
  wire [24:0] _GEN_144 = _T_8 ? $signed({{5{reg2_mat_comp_3[19]}},reg2_mat_comp_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 240:39 calc6x6.scala 85:23]
  wire [42:0] _GEN_145 = _T_8 ? $signed(_w3_mat_real_21_T_2) : $signed({{5{w3_mat_real_21[37]}},w3_mat_real_21}); // @[Conditional.scala 39:67 calc6x6.scala 241:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_146 = _T_8 ? $signed(_w3_mat_comp_21_T_5) : $signed({{5{w3_mat_comp_21[37]}},w3_mat_comp_21}); // @[Conditional.scala 39:67 calc6x6.scala 242:47 calc6x6.scala 93:21]
  wire [17:0] _GEN_150 = _T_8 ? $signed(io_weight_comp1_7) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 234:38 calc6x6.scala 78:22]
  wire [17:0] _GEN_151 = _T_8 ? $signed(io_weight_comp2_7) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 235:38 calc6x6.scala 81:22]
  wire [17:0] _GEN_152 = _T_8 ? $signed(io_weight_comp3_7) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 236:38 calc6x6.scala 84:22]
  wire [24:0] _GEN_153 = _T_8 ? $signed({{5{_comp1_7_in_b_T_3[19]}},_comp1_7_in_b_T_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 238:39 calc6x6.scala 79:23]
  wire [24:0] _GEN_154 = _T_8 ? $signed({{5{reg2_mat_real_22[19]}},reg2_mat_real_22}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 239:39 calc6x6.scala 82:23]
  wire [24:0] _GEN_155 = _T_8 ? $signed({{5{reg2_mat_comp_4[19]}},reg2_mat_comp_4}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 240:39 calc6x6.scala 85:23]
  wire [42:0] _GEN_156 = _T_8 ? $signed(_w3_mat_real_22_T_2) : $signed({{5{w3_mat_real_22[37]}},w3_mat_real_22}); // @[Conditional.scala 39:67 calc6x6.scala 241:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_157 = _T_8 ? $signed(_w3_mat_comp_22_T_5) : $signed({{5{w3_mat_comp_22[37]}},w3_mat_comp_22}); // @[Conditional.scala 39:67 calc6x6.scala 242:47 calc6x6.scala 93:21]
  wire [17:0] _GEN_161 = _T_8 ? $signed(io_weight_comp1_8) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 234:38 calc6x6.scala 78:22]
  wire [17:0] _GEN_162 = _T_8 ? $signed(io_weight_comp2_8) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 235:38 calc6x6.scala 81:22]
  wire [17:0] _GEN_163 = _T_8 ? $signed(io_weight_comp3_8) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 236:38 calc6x6.scala 84:22]
  wire [24:0] _GEN_164 = _T_8 ? $signed({{5{_comp1_8_in_b_T_3[19]}},_comp1_8_in_b_T_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 238:39 calc6x6.scala 79:23]
  wire [24:0] _GEN_165 = _T_8 ? $signed({{5{reg2_mat_real_23[19]}},reg2_mat_real_23}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 239:39 calc6x6.scala 82:23]
  wire [24:0] _GEN_166 = _T_8 ? $signed({{5{reg2_mat_comp_5[19]}},reg2_mat_comp_5}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 240:39 calc6x6.scala 85:23]
  wire [42:0] _GEN_167 = _T_8 ? $signed(_w3_mat_real_23_T_2) : $signed({{5{w3_mat_real_23[37]}},w3_mat_real_23}); // @[Conditional.scala 39:67 calc6x6.scala 241:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_168 = _T_8 ? $signed(_w3_mat_comp_23_T_5) : $signed({{5{w3_mat_comp_23[37]}},w3_mat_comp_23}); // @[Conditional.scala 39:67 calc6x6.scala 242:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_169 = _T_8 ? $signed(_w3_mat_real_18_T_2) : $signed({{5{w3_mat_real_24[37]}},w3_mat_real_24}); // @[Conditional.scala 39:67 calc6x6.scala 249:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_170 = _T_8 ? $signed(_w3_mat_comp_24_T_8) : $signed({{5{w3_mat_comp_24[37]}},w3_mat_comp_24}); // @[Conditional.scala 39:67 calc6x6.scala 250:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_171 = _T_8 ? $signed(_w3_mat_real_19_T_2) : $signed({{5{w3_mat_real_25[37]}},w3_mat_real_25}); // @[Conditional.scala 39:67 calc6x6.scala 249:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_172 = _T_8 ? $signed(_w3_mat_comp_25_T_8) : $signed({{5{w3_mat_comp_25[37]}},w3_mat_comp_25}); // @[Conditional.scala 39:67 calc6x6.scala 250:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_173 = _T_8 ? $signed(_w3_mat_real_20_T_2) : $signed({{5{w3_mat_real_26[37]}},w3_mat_real_26}); // @[Conditional.scala 39:67 calc6x6.scala 249:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_174 = _T_8 ? $signed(_w3_mat_comp_26_T_8) : $signed({{5{w3_mat_comp_26[37]}},w3_mat_comp_26}); // @[Conditional.scala 39:67 calc6x6.scala 250:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_175 = _T_8 ? $signed(_w3_mat_real_22_T_2) : $signed({{5{w3_mat_real_27[37]}},w3_mat_real_27}); // @[Conditional.scala 39:67 calc6x6.scala 249:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_176 = _T_8 ? $signed(_w3_mat_comp_27_T_8) : $signed({{5{w3_mat_comp_27[37]}},w3_mat_comp_27}); // @[Conditional.scala 39:67 calc6x6.scala 250:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_177 = _T_8 ? $signed(_w3_mat_real_21_T_2) : $signed({{5{w3_mat_real_28[37]}},w3_mat_real_28}); // @[Conditional.scala 39:67 calc6x6.scala 249:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_178 = _T_8 ? $signed(_w3_mat_comp_28_T_8) : $signed({{5{w3_mat_comp_28[37]}},w3_mat_comp_28}); // @[Conditional.scala 39:67 calc6x6.scala 250:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_179 = _T_8 ? $signed(_w3_mat_real_23_T_2) : $signed({{5{w3_mat_real_29[37]}},w3_mat_real_29}); // @[Conditional.scala 39:67 calc6x6.scala 249:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_180 = _T_8 ? $signed(_w3_mat_comp_29_T_8) : $signed({{5{w3_mat_comp_29[37]}},w3_mat_comp_29}); // @[Conditional.scala 39:67 calc6x6.scala 250:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_182 = _T_8 ? $signed({{5{reg2_mat_real_30[19]}},reg2_mat_real_30}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_183 = _T_8 ? $signed(io_weight_real_12) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_12_result = Core_12_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_184 = _T_8 ? $signed(real_12_result) : $signed({{5{w3_mat_real_30[37]}},w3_mat_real_30}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_186 = _T_8 ? $signed({{5{reg2_mat_real_31[19]}},reg2_mat_real_31}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_187 = _T_8 ? $signed(io_weight_real_13) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_13_result = Core_13_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_188 = _T_8 ? $signed(real_13_result) : $signed({{5{w3_mat_real_31[37]}},w3_mat_real_31}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_190 = _T_8 ? $signed({{5{reg2_mat_real_32[19]}},reg2_mat_real_32}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_191 = _T_8 ? $signed(io_weight_real_14) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_14_result = Core_14_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_192 = _T_8 ? $signed(real_14_result) : $signed({{5{w3_mat_real_32[37]}},w3_mat_real_32}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire [17:0] _GEN_196 = _T_8 ? $signed(io_weight_comp1_9) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 257:38 calc6x6.scala 78:22]
  wire [17:0] _GEN_197 = _T_8 ? $signed(io_weight_comp2_9) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 258:38 calc6x6.scala 81:22]
  wire [17:0] _GEN_198 = _T_8 ? $signed(io_weight_comp3_9) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 259:38 calc6x6.scala 84:22]
  wire [24:0] _GEN_199 = _T_8 ? $signed({{5{_comp1_9_in_b_T_3[19]}},_comp1_9_in_b_T_3}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 261:39 calc6x6.scala 79:23]
  wire [24:0] _GEN_200 = _T_8 ? $signed({{5{reg2_mat_real_33[19]}},reg2_mat_real_33}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 262:39 calc6x6.scala 82:23]
  wire [24:0] _GEN_201 = _T_8 ? $signed({{5{reg2_mat_comp_9[19]}},reg2_mat_comp_9}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 263:39 calc6x6.scala 85:23]
  wire [42:0] _GEN_202 = _T_8 ? $signed(_w3_mat_real_33_T_2) : $signed({{5{w3_mat_real_33[37]}},w3_mat_real_33}); // @[Conditional.scala 39:67 calc6x6.scala 264:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_203 = _T_8 ? $signed(_w3_mat_comp_33_T_5) : $signed({{5{w3_mat_comp_33[37]}},w3_mat_comp_33}); // @[Conditional.scala 39:67 calc6x6.scala 265:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_204 = _T_8 ? $signed(_w3_mat_real_33_T_2) : $signed({{5{w3_mat_real_34[37]}},w3_mat_real_34}); // @[Conditional.scala 39:67 calc6x6.scala 271:47 calc6x6.scala 93:21]
  wire [42:0] _GEN_205 = _T_8 ? $signed(_w3_mat_comp_34_T_8) : $signed({{5{w3_mat_comp_34[37]}},w3_mat_comp_34}); // @[Conditional.scala 39:67 calc6x6.scala 272:47 calc6x6.scala 93:21]
  wire [24:0] _GEN_207 = _T_8 ? $signed({{5{reg2_mat_real_35[19]}},reg2_mat_real_35}) : $signed(25'sh0); // @[Conditional.scala 39:67 calc6x6.scala 225:38 calc6x6.scala 68:22]
  wire [17:0] _GEN_208 = _T_8 ? $signed(io_weight_real_15) : $signed(18'sh0); // @[Conditional.scala 39:67 calc6x6.scala 226:37 calc6x6.scala 67:21]
  wire [42:0] real_15_result = Core_15_io_result; // @[calc6x6.scala 64:23 calc6x6.scala 64:23]
  wire [42:0] _GEN_209 = _T_8 ? $signed(real_15_result) : $signed({{5{w3_mat_real_35[37]}},w3_mat_real_35}); // @[Conditional.scala 39:67 calc6x6.scala 227:47 calc6x6.scala 93:21]
  wire  _GEN_210 = _T_5 | _T_8; // @[Conditional.scala 39:67 calc6x6.scala 195:30]
  wire [24:0] _GEN_211 = _T_5 ? $signed({{9{io_input_mat_0[15]}},io_input_mat_0}) : $signed(_GEN_17); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_212 = _T_5 ? $signed(io_weight_real_0) : $signed(_GEN_18); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_213 = _T_5 ? $signed(real_0_result) : $signed({{5{_GEN_0[37]}},_GEN_0}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_215 = _T_5 ? $signed({{9{io_input_mat_1[15]}},io_input_mat_1}) : $signed(_GEN_21); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_216 = _T_5 ? $signed(io_weight_real_1) : $signed(_GEN_22); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_217 = _T_5 ? $signed(real_1_result) : $signed({{5{_GEN_1[37]}},_GEN_1}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_219 = _T_5 ? $signed({{9{io_input_mat_2[15]}},io_input_mat_2}) : $signed(_GEN_25); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_220 = _T_5 ? $signed(io_weight_real_2) : $signed(_GEN_26); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_221 = _T_5 ? $signed(real_2_result) : $signed({{5{_GEN_2[37]}},_GEN_2}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_223 = _T_5 ? $signed({{9{io_input_mat_3[15]}},io_input_mat_3}) : $signed(_GEN_42); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_224 = _T_5 ? $signed(io_weight_real_3) : $signed(_GEN_43); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_225 = _T_5 ? $signed(real_3_result) : $signed({{5{_GEN_3[37]}},_GEN_3}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_227 = _T_5 ? $signed({{9{io_input_mat_4[15]}},io_input_mat_4}) : $signed(_GEN_46); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_228 = _T_5 ? $signed(io_weight_real_4) : $signed(_GEN_47); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_229 = _T_5 ? $signed(real_4_result) : $signed({{5{_GEN_4[37]}},_GEN_4}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_231 = _T_5 ? $signed({{9{io_input_mat_5[15]}},io_input_mat_5}) : $signed(_GEN_50); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_232 = _T_5 ? $signed(io_weight_real_5) : $signed(_GEN_51); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_233 = _T_5 ? $signed(real_5_result) : $signed({{5{_GEN_5[37]}},_GEN_5}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_235 = _T_5 ? $signed({{9{io_input_mat_6[15]}},io_input_mat_6}) : $signed(_GEN_54); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_236 = _T_5 ? $signed(io_weight_real_6) : $signed(_GEN_55); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_237 = _T_5 ? $signed(real_6_result) : $signed({{5{_GEN_6[37]}},_GEN_6}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_239 = _T_5 ? $signed({{9{io_input_mat_7[15]}},io_input_mat_7}) : $signed(_GEN_71); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_240 = _T_5 ? $signed(io_weight_real_7) : $signed(_GEN_72); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_241 = _T_5 ? $signed(real_7_result) : $signed({{5{_GEN_7[37]}},_GEN_7}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_243 = _T_5 ? $signed({{9{io_input_mat_8[15]}},io_input_mat_8}) : $signed(_GEN_75); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_244 = _T_5 ? $signed(io_weight_real_8) : $signed(_GEN_76); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_245 = _T_5 ? $signed(real_8_result) : $signed({{5{_GEN_8[37]}},_GEN_8}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_247 = _T_5 ? $signed({{9{io_input_mat_9[15]}},io_input_mat_9}) : $signed(_GEN_79); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_248 = _T_5 ? $signed(io_weight_real_9) : $signed(_GEN_80); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_249 = _T_5 ? $signed(real_9_result) : $signed({{5{_GEN_9[37]}},_GEN_9}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_251 = _T_5 ? $signed({{9{io_input_mat_10[15]}},io_input_mat_10}) : $signed(_GEN_83); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_252 = _T_5 ? $signed(io_weight_real_10) : $signed(_GEN_84); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_253 = _T_5 ? $signed(real_10_result) : $signed({{5{_GEN_10[37]}},_GEN_10}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_255 = _T_5 ? $signed({{9{io_input_mat_11[15]}},io_input_mat_11}) : $signed(_GEN_100); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_256 = _T_5 ? $signed(io_weight_real_11) : $signed(_GEN_101); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_257 = _T_5 ? $signed(real_11_result) : $signed({{5{_GEN_11[37]}},_GEN_11}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_259 = _T_5 ? $signed({{9{io_input_mat_12[15]}},io_input_mat_12}) : $signed(_GEN_182); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_260 = _T_5 ? $signed(io_weight_real_12) : $signed(_GEN_183); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_261 = _T_5 ? $signed(real_12_result) : $signed({{5{_GEN_12[37]}},_GEN_12}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_263 = _T_5 ? $signed({{9{io_input_mat_13[15]}},io_input_mat_13}) : $signed(_GEN_186); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_264 = _T_5 ? $signed(io_weight_real_13) : $signed(_GEN_187); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_265 = _T_5 ? $signed(real_13_result) : $signed({{5{_GEN_13[37]}},_GEN_13}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_267 = _T_5 ? $signed({{9{io_input_mat_14[15]}},io_input_mat_14}) : $signed(_GEN_190); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_268 = _T_5 ? $signed(io_weight_real_14) : $signed(_GEN_191); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_269 = _T_5 ? $signed(real_14_result) : $signed({{5{_GEN_14[37]}},_GEN_14}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire [24:0] _GEN_271 = _T_5 ? $signed({{9{io_input_mat_15[15]}},io_input_mat_15}) : $signed(_GEN_207); // @[Conditional.scala 39:67 calc6x6.scala 196:30]
  wire [17:0] _GEN_272 = _T_5 ? $signed(io_weight_real_15) : $signed(_GEN_208); // @[Conditional.scala 39:67 calc6x6.scala 197:29]
  wire [42:0] _GEN_273 = _T_5 ? $signed(real_15_result) : $signed({{5{_GEN_15[37]}},_GEN_15}); // @[Conditional.scala 39:67 calc6x6.scala 198:34]
  wire  _GEN_274 = _T_5 ? io_valid_in : valid_reg_3; // @[Conditional.scala 39:67 calc6x6.scala 201:25 calc6x6.scala 180:18]
  wire [42:0] _GEN_275 = _T_5 ? $signed({{5{w3_mat_real_0[37]}},w3_mat_real_0}) : $signed(_GEN_19); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_276 = _T_5 ? $signed({{5{w3_mat_real_1[37]}},w3_mat_real_1}) : $signed(_GEN_23); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_277 = _T_5 ? $signed({{5{w3_mat_real_2[37]}},w3_mat_real_2}) : $signed(_GEN_27); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire  _GEN_278 = _T_5 ? 1'h0 : _T_8; // @[Conditional.scala 39:67 calc6x6.scala 77:23]
  wire [17:0] _GEN_281 = _T_5 ? $signed(18'sh0) : $signed(_GEN_31); // @[Conditional.scala 39:67 calc6x6.scala 78:22]
  wire [17:0] _GEN_282 = _T_5 ? $signed(18'sh0) : $signed(_GEN_32); // @[Conditional.scala 39:67 calc6x6.scala 81:22]
  wire [17:0] _GEN_283 = _T_5 ? $signed(18'sh0) : $signed(_GEN_33); // @[Conditional.scala 39:67 calc6x6.scala 84:22]
  wire [24:0] _GEN_284 = _T_5 ? $signed(25'sh0) : $signed(_GEN_34); // @[Conditional.scala 39:67 calc6x6.scala 79:23]
  wire [24:0] _GEN_285 = _T_5 ? $signed(25'sh0) : $signed(_GEN_35); // @[Conditional.scala 39:67 calc6x6.scala 82:23]
  wire [24:0] _GEN_286 = _T_5 ? $signed(25'sh0) : $signed(_GEN_36); // @[Conditional.scala 39:67 calc6x6.scala 85:23]
  wire [42:0] _GEN_287 = _T_5 ? $signed({{5{w3_mat_real_3[37]}},w3_mat_real_3}) : $signed(_GEN_37); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_288 = _T_5 ? $signed({{5{w3_mat_comp_3[37]}},w3_mat_comp_3}) : $signed(_GEN_38); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_289 = _T_5 ? $signed({{5{w3_mat_real_4[37]}},w3_mat_real_4}) : $signed(_GEN_39); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_290 = _T_5 ? $signed({{5{w3_mat_comp_4[37]}},w3_mat_comp_4}) : $signed(_GEN_40); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_291 = _T_5 ? $signed({{5{w3_mat_real_5[37]}},w3_mat_real_5}) : $signed(_GEN_44); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_292 = _T_5 ? $signed({{5{w3_mat_real_6[37]}},w3_mat_real_6}) : $signed(_GEN_48); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_293 = _T_5 ? $signed({{5{w3_mat_real_7[37]}},w3_mat_real_7}) : $signed(_GEN_52); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_294 = _T_5 ? $signed({{5{w3_mat_real_8[37]}},w3_mat_real_8}) : $signed(_GEN_56); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [17:0] _GEN_298 = _T_5 ? $signed(18'sh0) : $signed(_GEN_60); // @[Conditional.scala 39:67 calc6x6.scala 78:22]
  wire [17:0] _GEN_299 = _T_5 ? $signed(18'sh0) : $signed(_GEN_61); // @[Conditional.scala 39:67 calc6x6.scala 81:22]
  wire [17:0] _GEN_300 = _T_5 ? $signed(18'sh0) : $signed(_GEN_62); // @[Conditional.scala 39:67 calc6x6.scala 84:22]
  wire [24:0] _GEN_301 = _T_5 ? $signed(25'sh0) : $signed(_GEN_63); // @[Conditional.scala 39:67 calc6x6.scala 79:23]
  wire [24:0] _GEN_302 = _T_5 ? $signed(25'sh0) : $signed(_GEN_64); // @[Conditional.scala 39:67 calc6x6.scala 82:23]
  wire [24:0] _GEN_303 = _T_5 ? $signed(25'sh0) : $signed(_GEN_65); // @[Conditional.scala 39:67 calc6x6.scala 85:23]
  wire [42:0] _GEN_304 = _T_5 ? $signed({{5{w3_mat_real_9[37]}},w3_mat_real_9}) : $signed(_GEN_66); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_305 = _T_5 ? $signed({{5{w3_mat_comp_9[37]}},w3_mat_comp_9}) : $signed(_GEN_67); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_306 = _T_5 ? $signed({{5{w3_mat_real_10[37]}},w3_mat_real_10}) : $signed(_GEN_68); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_307 = _T_5 ? $signed({{5{w3_mat_comp_10[37]}},w3_mat_comp_10}) : $signed(_GEN_69); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_308 = _T_5 ? $signed({{5{w3_mat_real_11[37]}},w3_mat_real_11}) : $signed(_GEN_73); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_309 = _T_5 ? $signed({{5{w3_mat_real_12[37]}},w3_mat_real_12}) : $signed(_GEN_77); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_310 = _T_5 ? $signed({{5{w3_mat_real_13[37]}},w3_mat_real_13}) : $signed(_GEN_81); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_311 = _T_5 ? $signed({{5{w3_mat_real_14[37]}},w3_mat_real_14}) : $signed(_GEN_85); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [17:0] _GEN_315 = _T_5 ? $signed(18'sh0) : $signed(_GEN_89); // @[Conditional.scala 39:67 calc6x6.scala 78:22]
  wire [17:0] _GEN_316 = _T_5 ? $signed(18'sh0) : $signed(_GEN_90); // @[Conditional.scala 39:67 calc6x6.scala 81:22]
  wire [17:0] _GEN_317 = _T_5 ? $signed(18'sh0) : $signed(_GEN_91); // @[Conditional.scala 39:67 calc6x6.scala 84:22]
  wire [24:0] _GEN_318 = _T_5 ? $signed(25'sh0) : $signed(_GEN_92); // @[Conditional.scala 39:67 calc6x6.scala 79:23]
  wire [24:0] _GEN_319 = _T_5 ? $signed(25'sh0) : $signed(_GEN_93); // @[Conditional.scala 39:67 calc6x6.scala 82:23]
  wire [24:0] _GEN_320 = _T_5 ? $signed(25'sh0) : $signed(_GEN_94); // @[Conditional.scala 39:67 calc6x6.scala 85:23]
  wire [42:0] _GEN_321 = _T_5 ? $signed({{5{w3_mat_real_15[37]}},w3_mat_real_15}) : $signed(_GEN_95); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_322 = _T_5 ? $signed({{5{w3_mat_comp_15[37]}},w3_mat_comp_15}) : $signed(_GEN_96); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_323 = _T_5 ? $signed({{5{w3_mat_real_16[37]}},w3_mat_real_16}) : $signed(_GEN_97); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_324 = _T_5 ? $signed({{5{w3_mat_comp_16[37]}},w3_mat_comp_16}) : $signed(_GEN_98); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_325 = _T_5 ? $signed({{5{w3_mat_real_17[37]}},w3_mat_real_17}) : $signed(_GEN_102); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [17:0] _GEN_329 = _T_5 ? $signed(18'sh0) : $signed(_GEN_106); // @[Conditional.scala 39:67 calc6x6.scala 78:22]
  wire [17:0] _GEN_330 = _T_5 ? $signed(18'sh0) : $signed(_GEN_107); // @[Conditional.scala 39:67 calc6x6.scala 81:22]
  wire [17:0] _GEN_331 = _T_5 ? $signed(18'sh0) : $signed(_GEN_108); // @[Conditional.scala 39:67 calc6x6.scala 84:22]
  wire [24:0] _GEN_332 = _T_5 ? $signed(25'sh0) : $signed(_GEN_109); // @[Conditional.scala 39:67 calc6x6.scala 79:23]
  wire [24:0] _GEN_333 = _T_5 ? $signed(25'sh0) : $signed(_GEN_110); // @[Conditional.scala 39:67 calc6x6.scala 82:23]
  wire [24:0] _GEN_334 = _T_5 ? $signed(25'sh0) : $signed(_GEN_111); // @[Conditional.scala 39:67 calc6x6.scala 85:23]
  wire [42:0] _GEN_335 = _T_5 ? $signed({{5{w3_mat_real_18[37]}},w3_mat_real_18}) : $signed(_GEN_112); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_336 = _T_5 ? $signed({{5{w3_mat_comp_18[37]}},w3_mat_comp_18}) : $signed(_GEN_113); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [17:0] _GEN_340 = _T_5 ? $signed(18'sh0) : $signed(_GEN_117); // @[Conditional.scala 39:67 calc6x6.scala 78:22]
  wire [17:0] _GEN_341 = _T_5 ? $signed(18'sh0) : $signed(_GEN_118); // @[Conditional.scala 39:67 calc6x6.scala 81:22]
  wire [17:0] _GEN_342 = _T_5 ? $signed(18'sh0) : $signed(_GEN_119); // @[Conditional.scala 39:67 calc6x6.scala 84:22]
  wire [24:0] _GEN_343 = _T_5 ? $signed(25'sh0) : $signed(_GEN_120); // @[Conditional.scala 39:67 calc6x6.scala 79:23]
  wire [24:0] _GEN_344 = _T_5 ? $signed(25'sh0) : $signed(_GEN_121); // @[Conditional.scala 39:67 calc6x6.scala 82:23]
  wire [24:0] _GEN_345 = _T_5 ? $signed(25'sh0) : $signed(_GEN_122); // @[Conditional.scala 39:67 calc6x6.scala 85:23]
  wire [42:0] _GEN_346 = _T_5 ? $signed({{5{w3_mat_real_19[37]}},w3_mat_real_19}) : $signed(_GEN_123); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_347 = _T_5 ? $signed({{5{w3_mat_comp_19[37]}},w3_mat_comp_19}) : $signed(_GEN_124); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [17:0] _GEN_351 = _T_5 ? $signed(18'sh0) : $signed(_GEN_128); // @[Conditional.scala 39:67 calc6x6.scala 78:22]
  wire [17:0] _GEN_352 = _T_5 ? $signed(18'sh0) : $signed(_GEN_129); // @[Conditional.scala 39:67 calc6x6.scala 81:22]
  wire [17:0] _GEN_353 = _T_5 ? $signed(18'sh0) : $signed(_GEN_130); // @[Conditional.scala 39:67 calc6x6.scala 84:22]
  wire [24:0] _GEN_354 = _T_5 ? $signed(25'sh0) : $signed(_GEN_131); // @[Conditional.scala 39:67 calc6x6.scala 79:23]
  wire [24:0] _GEN_355 = _T_5 ? $signed(25'sh0) : $signed(_GEN_132); // @[Conditional.scala 39:67 calc6x6.scala 82:23]
  wire [24:0] _GEN_356 = _T_5 ? $signed(25'sh0) : $signed(_GEN_133); // @[Conditional.scala 39:67 calc6x6.scala 85:23]
  wire [42:0] _GEN_357 = _T_5 ? $signed({{5{w3_mat_real_20[37]}},w3_mat_real_20}) : $signed(_GEN_134); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_358 = _T_5 ? $signed({{5{w3_mat_comp_20[37]}},w3_mat_comp_20}) : $signed(_GEN_135); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [17:0] _GEN_362 = _T_5 ? $signed(18'sh0) : $signed(_GEN_139); // @[Conditional.scala 39:67 calc6x6.scala 78:22]
  wire [17:0] _GEN_363 = _T_5 ? $signed(18'sh0) : $signed(_GEN_140); // @[Conditional.scala 39:67 calc6x6.scala 81:22]
  wire [17:0] _GEN_364 = _T_5 ? $signed(18'sh0) : $signed(_GEN_141); // @[Conditional.scala 39:67 calc6x6.scala 84:22]
  wire [24:0] _GEN_365 = _T_5 ? $signed(25'sh0) : $signed(_GEN_142); // @[Conditional.scala 39:67 calc6x6.scala 79:23]
  wire [24:0] _GEN_366 = _T_5 ? $signed(25'sh0) : $signed(_GEN_143); // @[Conditional.scala 39:67 calc6x6.scala 82:23]
  wire [24:0] _GEN_367 = _T_5 ? $signed(25'sh0) : $signed(_GEN_144); // @[Conditional.scala 39:67 calc6x6.scala 85:23]
  wire [42:0] _GEN_368 = _T_5 ? $signed({{5{w3_mat_real_21[37]}},w3_mat_real_21}) : $signed(_GEN_145); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_369 = _T_5 ? $signed({{5{w3_mat_comp_21[37]}},w3_mat_comp_21}) : $signed(_GEN_146); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [17:0] _GEN_373 = _T_5 ? $signed(18'sh0) : $signed(_GEN_150); // @[Conditional.scala 39:67 calc6x6.scala 78:22]
  wire [17:0] _GEN_374 = _T_5 ? $signed(18'sh0) : $signed(_GEN_151); // @[Conditional.scala 39:67 calc6x6.scala 81:22]
  wire [17:0] _GEN_375 = _T_5 ? $signed(18'sh0) : $signed(_GEN_152); // @[Conditional.scala 39:67 calc6x6.scala 84:22]
  wire [24:0] _GEN_376 = _T_5 ? $signed(25'sh0) : $signed(_GEN_153); // @[Conditional.scala 39:67 calc6x6.scala 79:23]
  wire [24:0] _GEN_377 = _T_5 ? $signed(25'sh0) : $signed(_GEN_154); // @[Conditional.scala 39:67 calc6x6.scala 82:23]
  wire [24:0] _GEN_378 = _T_5 ? $signed(25'sh0) : $signed(_GEN_155); // @[Conditional.scala 39:67 calc6x6.scala 85:23]
  wire [42:0] _GEN_379 = _T_5 ? $signed({{5{w3_mat_real_22[37]}},w3_mat_real_22}) : $signed(_GEN_156); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_380 = _T_5 ? $signed({{5{w3_mat_comp_22[37]}},w3_mat_comp_22}) : $signed(_GEN_157); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [17:0] _GEN_384 = _T_5 ? $signed(18'sh0) : $signed(_GEN_161); // @[Conditional.scala 39:67 calc6x6.scala 78:22]
  wire [17:0] _GEN_385 = _T_5 ? $signed(18'sh0) : $signed(_GEN_162); // @[Conditional.scala 39:67 calc6x6.scala 81:22]
  wire [17:0] _GEN_386 = _T_5 ? $signed(18'sh0) : $signed(_GEN_163); // @[Conditional.scala 39:67 calc6x6.scala 84:22]
  wire [24:0] _GEN_387 = _T_5 ? $signed(25'sh0) : $signed(_GEN_164); // @[Conditional.scala 39:67 calc6x6.scala 79:23]
  wire [24:0] _GEN_388 = _T_5 ? $signed(25'sh0) : $signed(_GEN_165); // @[Conditional.scala 39:67 calc6x6.scala 82:23]
  wire [24:0] _GEN_389 = _T_5 ? $signed(25'sh0) : $signed(_GEN_166); // @[Conditional.scala 39:67 calc6x6.scala 85:23]
  wire [42:0] _GEN_390 = _T_5 ? $signed({{5{w3_mat_real_23[37]}},w3_mat_real_23}) : $signed(_GEN_167); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_391 = _T_5 ? $signed({{5{w3_mat_comp_23[37]}},w3_mat_comp_23}) : $signed(_GEN_168); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_392 = _T_5 ? $signed({{5{w3_mat_real_24[37]}},w3_mat_real_24}) : $signed(_GEN_169); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_393 = _T_5 ? $signed({{5{w3_mat_comp_24[37]}},w3_mat_comp_24}) : $signed(_GEN_170); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_394 = _T_5 ? $signed({{5{w3_mat_real_25[37]}},w3_mat_real_25}) : $signed(_GEN_171); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_395 = _T_5 ? $signed({{5{w3_mat_comp_25[37]}},w3_mat_comp_25}) : $signed(_GEN_172); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_396 = _T_5 ? $signed({{5{w3_mat_real_26[37]}},w3_mat_real_26}) : $signed(_GEN_173); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_397 = _T_5 ? $signed({{5{w3_mat_comp_26[37]}},w3_mat_comp_26}) : $signed(_GEN_174); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_398 = _T_5 ? $signed({{5{w3_mat_real_27[37]}},w3_mat_real_27}) : $signed(_GEN_175); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_399 = _T_5 ? $signed({{5{w3_mat_comp_27[37]}},w3_mat_comp_27}) : $signed(_GEN_176); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_400 = _T_5 ? $signed({{5{w3_mat_real_28[37]}},w3_mat_real_28}) : $signed(_GEN_177); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_401 = _T_5 ? $signed({{5{w3_mat_comp_28[37]}},w3_mat_comp_28}) : $signed(_GEN_178); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_402 = _T_5 ? $signed({{5{w3_mat_real_29[37]}},w3_mat_real_29}) : $signed(_GEN_179); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_403 = _T_5 ? $signed({{5{w3_mat_comp_29[37]}},w3_mat_comp_29}) : $signed(_GEN_180); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_404 = _T_5 ? $signed({{5{w3_mat_real_30[37]}},w3_mat_real_30}) : $signed(_GEN_184); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_405 = _T_5 ? $signed({{5{w3_mat_real_31[37]}},w3_mat_real_31}) : $signed(_GEN_188); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_406 = _T_5 ? $signed({{5{w3_mat_real_32[37]}},w3_mat_real_32}) : $signed(_GEN_192); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [17:0] _GEN_410 = _T_5 ? $signed(18'sh0) : $signed(_GEN_196); // @[Conditional.scala 39:67 calc6x6.scala 78:22]
  wire [17:0] _GEN_411 = _T_5 ? $signed(18'sh0) : $signed(_GEN_197); // @[Conditional.scala 39:67 calc6x6.scala 81:22]
  wire [17:0] _GEN_412 = _T_5 ? $signed(18'sh0) : $signed(_GEN_198); // @[Conditional.scala 39:67 calc6x6.scala 84:22]
  wire [24:0] _GEN_413 = _T_5 ? $signed(25'sh0) : $signed(_GEN_199); // @[Conditional.scala 39:67 calc6x6.scala 79:23]
  wire [24:0] _GEN_414 = _T_5 ? $signed(25'sh0) : $signed(_GEN_200); // @[Conditional.scala 39:67 calc6x6.scala 82:23]
  wire [24:0] _GEN_415 = _T_5 ? $signed(25'sh0) : $signed(_GEN_201); // @[Conditional.scala 39:67 calc6x6.scala 85:23]
  wire [42:0] _GEN_416 = _T_5 ? $signed({{5{w3_mat_real_33[37]}},w3_mat_real_33}) : $signed(_GEN_202); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_417 = _T_5 ? $signed({{5{w3_mat_comp_33[37]}},w3_mat_comp_33}) : $signed(_GEN_203); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_418 = _T_5 ? $signed({{5{w3_mat_real_34[37]}},w3_mat_real_34}) : $signed(_GEN_204); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_419 = _T_5 ? $signed({{5{w3_mat_comp_34[37]}},w3_mat_comp_34}) : $signed(_GEN_205); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_420 = _T_5 ? $signed({{5{w3_mat_real_35[37]}},w3_mat_real_35}) : $signed(_GEN_209); // @[Conditional.scala 39:67 calc6x6.scala 93:21]
  wire [42:0] _GEN_423 = _T_2 ? $signed(real_0_result) : $signed(_GEN_213); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_426 = _T_2 ? $signed(real_1_result) : $signed(_GEN_217); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_429 = _T_2 ? $signed(real_2_result) : $signed(_GEN_221); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_432 = _T_2 ? $signed(real_3_result) : $signed(_GEN_225); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_435 = _T_2 ? $signed(real_4_result) : $signed(_GEN_229); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_438 = _T_2 ? $signed(real_5_result) : $signed(_GEN_233); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_441 = _T_2 ? $signed(real_6_result) : $signed(_GEN_237); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_444 = _T_2 ? $signed(real_7_result) : $signed(_GEN_241); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_447 = _T_2 ? $signed(real_8_result) : $signed(_GEN_245); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_450 = _T_2 ? $signed(real_9_result) : $signed(_GEN_249); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_453 = _T_2 ? $signed(real_10_result) : $signed(_GEN_253); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_456 = _T_2 ? $signed(real_11_result) : $signed(_GEN_257); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_459 = _T_2 ? $signed(real_12_result) : $signed(_GEN_261); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_462 = _T_2 ? $signed(real_13_result) : $signed(_GEN_265); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_465 = _T_2 ? $signed(real_14_result) : $signed(_GEN_269); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_468 = _T_2 ? $signed(real_15_result) : $signed(_GEN_273); // @[Conditional.scala 40:58 calc6x6.scala 187:34]
  wire [42:0] _GEN_486 = _T_2 ? $signed({{5{w3_mat_real_0[37]}},w3_mat_real_0}) : $signed(_GEN_275); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_487 = _T_2 ? $signed({{5{w3_mat_real_1[37]}},w3_mat_real_1}) : $signed(_GEN_276); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_488 = _T_2 ? $signed({{5{w3_mat_real_2[37]}},w3_mat_real_2}) : $signed(_GEN_277); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_498 = _T_2 ? $signed({{5{w3_mat_real_3[37]}},w3_mat_real_3}) : $signed(_GEN_287); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_499 = _T_2 ? $signed({{5{w3_mat_comp_3[37]}},w3_mat_comp_3}) : $signed(_GEN_288); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_500 = _T_2 ? $signed({{5{w3_mat_real_4[37]}},w3_mat_real_4}) : $signed(_GEN_289); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_501 = _T_2 ? $signed({{5{w3_mat_comp_4[37]}},w3_mat_comp_4}) : $signed(_GEN_290); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_502 = _T_2 ? $signed({{5{w3_mat_real_5[37]}},w3_mat_real_5}) : $signed(_GEN_291); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_503 = _T_2 ? $signed({{5{w3_mat_real_6[37]}},w3_mat_real_6}) : $signed(_GEN_292); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_504 = _T_2 ? $signed({{5{w3_mat_real_7[37]}},w3_mat_real_7}) : $signed(_GEN_293); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_505 = _T_2 ? $signed({{5{w3_mat_real_8[37]}},w3_mat_real_8}) : $signed(_GEN_294); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_515 = _T_2 ? $signed({{5{w3_mat_real_9[37]}},w3_mat_real_9}) : $signed(_GEN_304); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_516 = _T_2 ? $signed({{5{w3_mat_comp_9[37]}},w3_mat_comp_9}) : $signed(_GEN_305); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_517 = _T_2 ? $signed({{5{w3_mat_real_10[37]}},w3_mat_real_10}) : $signed(_GEN_306); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_518 = _T_2 ? $signed({{5{w3_mat_comp_10[37]}},w3_mat_comp_10}) : $signed(_GEN_307); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_519 = _T_2 ? $signed({{5{w3_mat_real_11[37]}},w3_mat_real_11}) : $signed(_GEN_308); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_520 = _T_2 ? $signed({{5{w3_mat_real_12[37]}},w3_mat_real_12}) : $signed(_GEN_309); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_521 = _T_2 ? $signed({{5{w3_mat_real_13[37]}},w3_mat_real_13}) : $signed(_GEN_310); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_522 = _T_2 ? $signed({{5{w3_mat_real_14[37]}},w3_mat_real_14}) : $signed(_GEN_311); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_532 = _T_2 ? $signed({{5{w3_mat_real_15[37]}},w3_mat_real_15}) : $signed(_GEN_321); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_533 = _T_2 ? $signed({{5{w3_mat_comp_15[37]}},w3_mat_comp_15}) : $signed(_GEN_322); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_534 = _T_2 ? $signed({{5{w3_mat_real_16[37]}},w3_mat_real_16}) : $signed(_GEN_323); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_535 = _T_2 ? $signed({{5{w3_mat_comp_16[37]}},w3_mat_comp_16}) : $signed(_GEN_324); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_536 = _T_2 ? $signed({{5{w3_mat_real_17[37]}},w3_mat_real_17}) : $signed(_GEN_325); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_546 = _T_2 ? $signed({{5{w3_mat_real_18[37]}},w3_mat_real_18}) : $signed(_GEN_335); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_547 = _T_2 ? $signed({{5{w3_mat_comp_18[37]}},w3_mat_comp_18}) : $signed(_GEN_336); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_557 = _T_2 ? $signed({{5{w3_mat_real_19[37]}},w3_mat_real_19}) : $signed(_GEN_346); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_558 = _T_2 ? $signed({{5{w3_mat_comp_19[37]}},w3_mat_comp_19}) : $signed(_GEN_347); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_568 = _T_2 ? $signed({{5{w3_mat_real_20[37]}},w3_mat_real_20}) : $signed(_GEN_357); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_569 = _T_2 ? $signed({{5{w3_mat_comp_20[37]}},w3_mat_comp_20}) : $signed(_GEN_358); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_579 = _T_2 ? $signed({{5{w3_mat_real_21[37]}},w3_mat_real_21}) : $signed(_GEN_368); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_580 = _T_2 ? $signed({{5{w3_mat_comp_21[37]}},w3_mat_comp_21}) : $signed(_GEN_369); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_590 = _T_2 ? $signed({{5{w3_mat_real_22[37]}},w3_mat_real_22}) : $signed(_GEN_379); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_591 = _T_2 ? $signed({{5{w3_mat_comp_22[37]}},w3_mat_comp_22}) : $signed(_GEN_380); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_601 = _T_2 ? $signed({{5{w3_mat_real_23[37]}},w3_mat_real_23}) : $signed(_GEN_390); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_602 = _T_2 ? $signed({{5{w3_mat_comp_23[37]}},w3_mat_comp_23}) : $signed(_GEN_391); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_603 = _T_2 ? $signed({{5{w3_mat_real_24[37]}},w3_mat_real_24}) : $signed(_GEN_392); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_604 = _T_2 ? $signed({{5{w3_mat_comp_24[37]}},w3_mat_comp_24}) : $signed(_GEN_393); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_605 = _T_2 ? $signed({{5{w3_mat_real_25[37]}},w3_mat_real_25}) : $signed(_GEN_394); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_606 = _T_2 ? $signed({{5{w3_mat_comp_25[37]}},w3_mat_comp_25}) : $signed(_GEN_395); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_607 = _T_2 ? $signed({{5{w3_mat_real_26[37]}},w3_mat_real_26}) : $signed(_GEN_396); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_608 = _T_2 ? $signed({{5{w3_mat_comp_26[37]}},w3_mat_comp_26}) : $signed(_GEN_397); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_609 = _T_2 ? $signed({{5{w3_mat_real_27[37]}},w3_mat_real_27}) : $signed(_GEN_398); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_610 = _T_2 ? $signed({{5{w3_mat_comp_27[37]}},w3_mat_comp_27}) : $signed(_GEN_399); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_611 = _T_2 ? $signed({{5{w3_mat_real_28[37]}},w3_mat_real_28}) : $signed(_GEN_400); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_612 = _T_2 ? $signed({{5{w3_mat_comp_28[37]}},w3_mat_comp_28}) : $signed(_GEN_401); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_613 = _T_2 ? $signed({{5{w3_mat_real_29[37]}},w3_mat_real_29}) : $signed(_GEN_402); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_614 = _T_2 ? $signed({{5{w3_mat_comp_29[37]}},w3_mat_comp_29}) : $signed(_GEN_403); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_615 = _T_2 ? $signed({{5{w3_mat_real_30[37]}},w3_mat_real_30}) : $signed(_GEN_404); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_616 = _T_2 ? $signed({{5{w3_mat_real_31[37]}},w3_mat_real_31}) : $signed(_GEN_405); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_617 = _T_2 ? $signed({{5{w3_mat_real_32[37]}},w3_mat_real_32}) : $signed(_GEN_406); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_627 = _T_2 ? $signed({{5{w3_mat_real_33[37]}},w3_mat_real_33}) : $signed(_GEN_416); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_628 = _T_2 ? $signed({{5{w3_mat_comp_33[37]}},w3_mat_comp_33}) : $signed(_GEN_417); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_629 = _T_2 ? $signed({{5{w3_mat_real_34[37]}},w3_mat_real_34}) : $signed(_GEN_418); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_630 = _T_2 ? $signed({{5{w3_mat_comp_34[37]}},w3_mat_comp_34}) : $signed(_GEN_419); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  wire [42:0] _GEN_631 = _T_2 ? $signed({{5{w3_mat_real_35[37]}},w3_mat_real_35}) : $signed(_GEN_420); // @[Conditional.scala 40:58 calc6x6.scala 93:21]
  Core Core ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_io_w_a),
    .io_in_b(Core_io_in_b),
    .io_flag(Core_io_flag),
    .io_result(Core_io_result)
  );
  Core Core_1 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_1_io_w_a),
    .io_in_b(Core_1_io_in_b),
    .io_flag(Core_1_io_flag),
    .io_result(Core_1_io_result)
  );
  Core Core_2 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_2_io_w_a),
    .io_in_b(Core_2_io_in_b),
    .io_flag(Core_2_io_flag),
    .io_result(Core_2_io_result)
  );
  Core Core_3 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_3_io_w_a),
    .io_in_b(Core_3_io_in_b),
    .io_flag(Core_3_io_flag),
    .io_result(Core_3_io_result)
  );
  Core Core_4 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_4_io_w_a),
    .io_in_b(Core_4_io_in_b),
    .io_flag(Core_4_io_flag),
    .io_result(Core_4_io_result)
  );
  Core Core_5 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_5_io_w_a),
    .io_in_b(Core_5_io_in_b),
    .io_flag(Core_5_io_flag),
    .io_result(Core_5_io_result)
  );
  Core Core_6 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_6_io_w_a),
    .io_in_b(Core_6_io_in_b),
    .io_flag(Core_6_io_flag),
    .io_result(Core_6_io_result)
  );
  Core Core_7 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_7_io_w_a),
    .io_in_b(Core_7_io_in_b),
    .io_flag(Core_7_io_flag),
    .io_result(Core_7_io_result)
  );
  Core Core_8 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_8_io_w_a),
    .io_in_b(Core_8_io_in_b),
    .io_flag(Core_8_io_flag),
    .io_result(Core_8_io_result)
  );
  Core Core_9 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_9_io_w_a),
    .io_in_b(Core_9_io_in_b),
    .io_flag(Core_9_io_flag),
    .io_result(Core_9_io_result)
  );
  Core Core_10 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_10_io_w_a),
    .io_in_b(Core_10_io_in_b),
    .io_flag(Core_10_io_flag),
    .io_result(Core_10_io_result)
  );
  Core Core_11 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_11_io_w_a),
    .io_in_b(Core_11_io_in_b),
    .io_flag(Core_11_io_flag),
    .io_result(Core_11_io_result)
  );
  Core Core_12 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_12_io_w_a),
    .io_in_b(Core_12_io_in_b),
    .io_flag(Core_12_io_flag),
    .io_result(Core_12_io_result)
  );
  Core Core_13 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_13_io_w_a),
    .io_in_b(Core_13_io_in_b),
    .io_flag(Core_13_io_flag),
    .io_result(Core_13_io_result)
  );
  Core Core_14 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_14_io_w_a),
    .io_in_b(Core_14_io_in_b),
    .io_flag(Core_14_io_flag),
    .io_result(Core_14_io_result)
  );
  Core Core_15 ( // @[calc6x6.scala 64:43]
    .io_w_a(Core_15_io_w_a),
    .io_in_b(Core_15_io_in_b),
    .io_flag(Core_15_io_flag),
    .io_result(Core_15_io_result)
  );
  Core Core_16 ( // @[calc6x6.scala 71:44]
    .io_w_a(Core_16_io_w_a),
    .io_in_b(Core_16_io_in_b),
    .io_flag(Core_16_io_flag),
    .io_result(Core_16_io_result)
  );
  Core Core_17 ( // @[calc6x6.scala 71:44]
    .io_w_a(Core_17_io_w_a),
    .io_in_b(Core_17_io_in_b),
    .io_flag(Core_17_io_flag),
    .io_result(Core_17_io_result)
  );
  Core Core_18 ( // @[calc6x6.scala 71:44]
    .io_w_a(Core_18_io_w_a),
    .io_in_b(Core_18_io_in_b),
    .io_flag(Core_18_io_flag),
    .io_result(Core_18_io_result)
  );
  Core Core_19 ( // @[calc6x6.scala 71:44]
    .io_w_a(Core_19_io_w_a),
    .io_in_b(Core_19_io_in_b),
    .io_flag(Core_19_io_flag),
    .io_result(Core_19_io_result)
  );
  Core Core_20 ( // @[calc6x6.scala 71:44]
    .io_w_a(Core_20_io_w_a),
    .io_in_b(Core_20_io_in_b),
    .io_flag(Core_20_io_flag),
    .io_result(Core_20_io_result)
  );
  Core Core_21 ( // @[calc6x6.scala 71:44]
    .io_w_a(Core_21_io_w_a),
    .io_in_b(Core_21_io_in_b),
    .io_flag(Core_21_io_flag),
    .io_result(Core_21_io_result)
  );
  Core Core_22 ( // @[calc6x6.scala 71:44]
    .io_w_a(Core_22_io_w_a),
    .io_in_b(Core_22_io_in_b),
    .io_flag(Core_22_io_flag),
    .io_result(Core_22_io_result)
  );
  Core Core_23 ( // @[calc6x6.scala 71:44]
    .io_w_a(Core_23_io_w_a),
    .io_in_b(Core_23_io_in_b),
    .io_flag(Core_23_io_flag),
    .io_result(Core_23_io_result)
  );
  Core Core_24 ( // @[calc6x6.scala 71:44]
    .io_w_a(Core_24_io_w_a),
    .io_in_b(Core_24_io_in_b),
    .io_flag(Core_24_io_flag),
    .io_result(Core_24_io_result)
  );
  Core Core_25 ( // @[calc6x6.scala 71:44]
    .io_w_a(Core_25_io_w_a),
    .io_in_b(Core_25_io_in_b),
    .io_flag(Core_25_io_flag),
    .io_result(Core_25_io_result)
  );
  Core Core_26 ( // @[calc6x6.scala 72:44]
    .io_w_a(Core_26_io_w_a),
    .io_in_b(Core_26_io_in_b),
    .io_flag(Core_26_io_flag),
    .io_result(Core_26_io_result)
  );
  Core Core_27 ( // @[calc6x6.scala 72:44]
    .io_w_a(Core_27_io_w_a),
    .io_in_b(Core_27_io_in_b),
    .io_flag(Core_27_io_flag),
    .io_result(Core_27_io_result)
  );
  Core Core_28 ( // @[calc6x6.scala 72:44]
    .io_w_a(Core_28_io_w_a),
    .io_in_b(Core_28_io_in_b),
    .io_flag(Core_28_io_flag),
    .io_result(Core_28_io_result)
  );
  Core Core_29 ( // @[calc6x6.scala 72:44]
    .io_w_a(Core_29_io_w_a),
    .io_in_b(Core_29_io_in_b),
    .io_flag(Core_29_io_flag),
    .io_result(Core_29_io_result)
  );
  Core Core_30 ( // @[calc6x6.scala 72:44]
    .io_w_a(Core_30_io_w_a),
    .io_in_b(Core_30_io_in_b),
    .io_flag(Core_30_io_flag),
    .io_result(Core_30_io_result)
  );
  Core Core_31 ( // @[calc6x6.scala 72:44]
    .io_w_a(Core_31_io_w_a),
    .io_in_b(Core_31_io_in_b),
    .io_flag(Core_31_io_flag),
    .io_result(Core_31_io_result)
  );
  Core Core_32 ( // @[calc6x6.scala 72:44]
    .io_w_a(Core_32_io_w_a),
    .io_in_b(Core_32_io_in_b),
    .io_flag(Core_32_io_flag),
    .io_result(Core_32_io_result)
  );
  Core Core_33 ( // @[calc6x6.scala 72:44]
    .io_w_a(Core_33_io_w_a),
    .io_in_b(Core_33_io_in_b),
    .io_flag(Core_33_io_flag),
    .io_result(Core_33_io_result)
  );
  Core Core_34 ( // @[calc6x6.scala 72:44]
    .io_w_a(Core_34_io_w_a),
    .io_in_b(Core_34_io_in_b),
    .io_flag(Core_34_io_flag),
    .io_result(Core_34_io_result)
  );
  Core Core_35 ( // @[calc6x6.scala 72:44]
    .io_w_a(Core_35_io_w_a),
    .io_in_b(Core_35_io_in_b),
    .io_flag(Core_35_io_flag),
    .io_result(Core_35_io_result)
  );
  Core Core_36 ( // @[calc6x6.scala 73:44]
    .io_w_a(Core_36_io_w_a),
    .io_in_b(Core_36_io_in_b),
    .io_flag(Core_36_io_flag),
    .io_result(Core_36_io_result)
  );
  Core Core_37 ( // @[calc6x6.scala 73:44]
    .io_w_a(Core_37_io_w_a),
    .io_in_b(Core_37_io_in_b),
    .io_flag(Core_37_io_flag),
    .io_result(Core_37_io_result)
  );
  Core Core_38 ( // @[calc6x6.scala 73:44]
    .io_w_a(Core_38_io_w_a),
    .io_in_b(Core_38_io_in_b),
    .io_flag(Core_38_io_flag),
    .io_result(Core_38_io_result)
  );
  Core Core_39 ( // @[calc6x6.scala 73:44]
    .io_w_a(Core_39_io_w_a),
    .io_in_b(Core_39_io_in_b),
    .io_flag(Core_39_io_flag),
    .io_result(Core_39_io_result)
  );
  Core Core_40 ( // @[calc6x6.scala 73:44]
    .io_w_a(Core_40_io_w_a),
    .io_in_b(Core_40_io_in_b),
    .io_flag(Core_40_io_flag),
    .io_result(Core_40_io_result)
  );
  Core Core_41 ( // @[calc6x6.scala 73:44]
    .io_w_a(Core_41_io_w_a),
    .io_in_b(Core_41_io_in_b),
    .io_flag(Core_41_io_flag),
    .io_result(Core_41_io_result)
  );
  Core Core_42 ( // @[calc6x6.scala 73:44]
    .io_w_a(Core_42_io_w_a),
    .io_in_b(Core_42_io_in_b),
    .io_flag(Core_42_io_flag),
    .io_result(Core_42_io_result)
  );
  Core Core_43 ( // @[calc6x6.scala 73:44]
    .io_w_a(Core_43_io_w_a),
    .io_in_b(Core_43_io_in_b),
    .io_flag(Core_43_io_flag),
    .io_result(Core_43_io_result)
  );
  Core Core_44 ( // @[calc6x6.scala 73:44]
    .io_w_a(Core_44_io_w_a),
    .io_in_b(Core_44_io_in_b),
    .io_flag(Core_44_io_flag),
    .io_result(Core_44_io_result)
  );
  Core Core_45 ( // @[calc6x6.scala 73:44]
    .io_w_a(Core_45_io_w_a),
    .io_in_b(Core_45_io_in_b),
    .io_flag(Core_45_io_flag),
    .io_result(Core_45_io_result)
  );
  assign io_output_mat_0 = _GEN_423[36:0];
  assign io_output_mat_1 = _GEN_426[36:0];
  assign io_output_mat_2 = _GEN_429[36:0];
  assign io_output_mat_3 = _GEN_432[36:0];
  assign io_output_mat_4 = _GEN_435[36:0];
  assign io_output_mat_5 = _GEN_438[36:0];
  assign io_output_mat_6 = _GEN_441[36:0];
  assign io_output_mat_7 = _GEN_444[36:0];
  assign io_output_mat_8 = _GEN_447[36:0];
  assign io_output_mat_9 = _GEN_450[36:0];
  assign io_output_mat_10 = _GEN_453[36:0];
  assign io_output_mat_11 = _GEN_456[36:0];
  assign io_output_mat_12 = _GEN_459[36:0];
  assign io_output_mat_13 = _GEN_462[36:0];
  assign io_output_mat_14 = _GEN_465[36:0];
  assign io_output_mat_15 = _GEN_468[36:0];
  assign io_valid_out = _T_2 ? io_valid_in : _GEN_274; // @[Conditional.scala 40:58 calc6x6.scala 189:26]
  assign Core_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_212); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_io_in_b = _T_2 ? $signed({{9{io_input_mat_0[15]}},io_input_mat_0}) : $signed(_GEN_211); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_1_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_216); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_1_io_in_b = _T_2 ? $signed({{9{io_input_mat_1[15]}},io_input_mat_1}) : $signed(_GEN_215); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_1_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_2_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_220); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_2_io_in_b = _T_2 ? $signed({{9{io_input_mat_2[15]}},io_input_mat_2}) : $signed(_GEN_219); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_2_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_3_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_224); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_3_io_in_b = _T_2 ? $signed({{9{io_input_mat_3[15]}},io_input_mat_3}) : $signed(_GEN_223); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_3_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_4_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_228); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_4_io_in_b = _T_2 ? $signed({{9{io_input_mat_4[15]}},io_input_mat_4}) : $signed(_GEN_227); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_4_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_5_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_232); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_5_io_in_b = _T_2 ? $signed({{9{io_input_mat_5[15]}},io_input_mat_5}) : $signed(_GEN_231); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_5_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_6_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_236); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_6_io_in_b = _T_2 ? $signed({{9{io_input_mat_6[15]}},io_input_mat_6}) : $signed(_GEN_235); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_6_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_7_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_240); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_7_io_in_b = _T_2 ? $signed({{9{io_input_mat_7[15]}},io_input_mat_7}) : $signed(_GEN_239); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_7_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_8_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_244); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_8_io_in_b = _T_2 ? $signed({{9{io_input_mat_8[15]}},io_input_mat_8}) : $signed(_GEN_243); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_8_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_9_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_248); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_9_io_in_b = _T_2 ? $signed({{9{io_input_mat_9[15]}},io_input_mat_9}) : $signed(_GEN_247); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_9_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_10_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_252); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_10_io_in_b = _T_2 ? $signed({{9{io_input_mat_10[15]}},io_input_mat_10}) : $signed(_GEN_251); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_10_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_11_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_256); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_11_io_in_b = _T_2 ? $signed({{9{io_input_mat_11[15]}},io_input_mat_11}) : $signed(_GEN_255); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_11_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_12_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_260); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_12_io_in_b = _T_2 ? $signed({{9{io_input_mat_12[15]}},io_input_mat_12}) : $signed(_GEN_259); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_12_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_13_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_264); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_13_io_in_b = _T_2 ? $signed({{9{io_input_mat_13[15]}},io_input_mat_13}) : $signed(_GEN_263); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_13_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_14_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_268); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_14_io_in_b = _T_2 ? $signed({{9{io_input_mat_14[15]}},io_input_mat_14}) : $signed(_GEN_267); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_14_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_15_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_272); // @[Conditional.scala 40:58 calc6x6.scala 67:21]
  assign Core_15_io_in_b = _T_2 ? $signed({{9{io_input_mat_15[15]}},io_input_mat_15}) : $signed(_GEN_271); // @[Conditional.scala 40:58 calc6x6.scala 186:30]
  assign Core_15_io_flag = _T_2 ? 1'h0 : _GEN_210; // @[Conditional.scala 40:58 calc6x6.scala 185:30]
  assign Core_16_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_281); // @[Conditional.scala 40:58 calc6x6.scala 78:22]
  assign Core_16_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_284); // @[Conditional.scala 40:58 calc6x6.scala 79:23]
  assign Core_16_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 77:23]
  assign Core_17_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_298); // @[Conditional.scala 40:58 calc6x6.scala 78:22]
  assign Core_17_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_301); // @[Conditional.scala 40:58 calc6x6.scala 79:23]
  assign Core_17_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 77:23]
  assign Core_18_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_315); // @[Conditional.scala 40:58 calc6x6.scala 78:22]
  assign Core_18_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_318); // @[Conditional.scala 40:58 calc6x6.scala 79:23]
  assign Core_18_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 77:23]
  assign Core_19_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_329); // @[Conditional.scala 40:58 calc6x6.scala 78:22]
  assign Core_19_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_332); // @[Conditional.scala 40:58 calc6x6.scala 79:23]
  assign Core_19_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 77:23]
  assign Core_20_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_340); // @[Conditional.scala 40:58 calc6x6.scala 78:22]
  assign Core_20_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_343); // @[Conditional.scala 40:58 calc6x6.scala 79:23]
  assign Core_20_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 77:23]
  assign Core_21_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_351); // @[Conditional.scala 40:58 calc6x6.scala 78:22]
  assign Core_21_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_354); // @[Conditional.scala 40:58 calc6x6.scala 79:23]
  assign Core_21_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 77:23]
  assign Core_22_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_362); // @[Conditional.scala 40:58 calc6x6.scala 78:22]
  assign Core_22_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_365); // @[Conditional.scala 40:58 calc6x6.scala 79:23]
  assign Core_22_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 77:23]
  assign Core_23_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_373); // @[Conditional.scala 40:58 calc6x6.scala 78:22]
  assign Core_23_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_376); // @[Conditional.scala 40:58 calc6x6.scala 79:23]
  assign Core_23_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 77:23]
  assign Core_24_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_384); // @[Conditional.scala 40:58 calc6x6.scala 78:22]
  assign Core_24_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_387); // @[Conditional.scala 40:58 calc6x6.scala 79:23]
  assign Core_24_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 77:23]
  assign Core_25_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_410); // @[Conditional.scala 40:58 calc6x6.scala 78:22]
  assign Core_25_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_413); // @[Conditional.scala 40:58 calc6x6.scala 79:23]
  assign Core_25_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 77:23]
  assign Core_26_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_282); // @[Conditional.scala 40:58 calc6x6.scala 81:22]
  assign Core_26_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_285); // @[Conditional.scala 40:58 calc6x6.scala 82:23]
  assign Core_26_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 80:23]
  assign Core_27_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_299); // @[Conditional.scala 40:58 calc6x6.scala 81:22]
  assign Core_27_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_302); // @[Conditional.scala 40:58 calc6x6.scala 82:23]
  assign Core_27_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 80:23]
  assign Core_28_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_316); // @[Conditional.scala 40:58 calc6x6.scala 81:22]
  assign Core_28_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_319); // @[Conditional.scala 40:58 calc6x6.scala 82:23]
  assign Core_28_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 80:23]
  assign Core_29_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_330); // @[Conditional.scala 40:58 calc6x6.scala 81:22]
  assign Core_29_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_333); // @[Conditional.scala 40:58 calc6x6.scala 82:23]
  assign Core_29_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 80:23]
  assign Core_30_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_341); // @[Conditional.scala 40:58 calc6x6.scala 81:22]
  assign Core_30_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_344); // @[Conditional.scala 40:58 calc6x6.scala 82:23]
  assign Core_30_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 80:23]
  assign Core_31_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_352); // @[Conditional.scala 40:58 calc6x6.scala 81:22]
  assign Core_31_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_355); // @[Conditional.scala 40:58 calc6x6.scala 82:23]
  assign Core_31_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 80:23]
  assign Core_32_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_363); // @[Conditional.scala 40:58 calc6x6.scala 81:22]
  assign Core_32_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_366); // @[Conditional.scala 40:58 calc6x6.scala 82:23]
  assign Core_32_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 80:23]
  assign Core_33_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_374); // @[Conditional.scala 40:58 calc6x6.scala 81:22]
  assign Core_33_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_377); // @[Conditional.scala 40:58 calc6x6.scala 82:23]
  assign Core_33_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 80:23]
  assign Core_34_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_385); // @[Conditional.scala 40:58 calc6x6.scala 81:22]
  assign Core_34_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_388); // @[Conditional.scala 40:58 calc6x6.scala 82:23]
  assign Core_34_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 80:23]
  assign Core_35_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_411); // @[Conditional.scala 40:58 calc6x6.scala 81:22]
  assign Core_35_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_414); // @[Conditional.scala 40:58 calc6x6.scala 82:23]
  assign Core_35_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 80:23]
  assign Core_36_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_283); // @[Conditional.scala 40:58 calc6x6.scala 84:22]
  assign Core_36_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_286); // @[Conditional.scala 40:58 calc6x6.scala 85:23]
  assign Core_36_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 83:23]
  assign Core_37_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_300); // @[Conditional.scala 40:58 calc6x6.scala 84:22]
  assign Core_37_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_303); // @[Conditional.scala 40:58 calc6x6.scala 85:23]
  assign Core_37_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 83:23]
  assign Core_38_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_317); // @[Conditional.scala 40:58 calc6x6.scala 84:22]
  assign Core_38_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_320); // @[Conditional.scala 40:58 calc6x6.scala 85:23]
  assign Core_38_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 83:23]
  assign Core_39_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_331); // @[Conditional.scala 40:58 calc6x6.scala 84:22]
  assign Core_39_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_334); // @[Conditional.scala 40:58 calc6x6.scala 85:23]
  assign Core_39_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 83:23]
  assign Core_40_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_342); // @[Conditional.scala 40:58 calc6x6.scala 84:22]
  assign Core_40_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_345); // @[Conditional.scala 40:58 calc6x6.scala 85:23]
  assign Core_40_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 83:23]
  assign Core_41_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_353); // @[Conditional.scala 40:58 calc6x6.scala 84:22]
  assign Core_41_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_356); // @[Conditional.scala 40:58 calc6x6.scala 85:23]
  assign Core_41_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 83:23]
  assign Core_42_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_364); // @[Conditional.scala 40:58 calc6x6.scala 84:22]
  assign Core_42_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_367); // @[Conditional.scala 40:58 calc6x6.scala 85:23]
  assign Core_42_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 83:23]
  assign Core_43_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_375); // @[Conditional.scala 40:58 calc6x6.scala 84:22]
  assign Core_43_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_378); // @[Conditional.scala 40:58 calc6x6.scala 85:23]
  assign Core_43_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 83:23]
  assign Core_44_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_386); // @[Conditional.scala 40:58 calc6x6.scala 84:22]
  assign Core_44_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_389); // @[Conditional.scala 40:58 calc6x6.scala 85:23]
  assign Core_44_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 83:23]
  assign Core_45_io_w_a = _T_2 ? $signed(18'sh0) : $signed(_GEN_412); // @[Conditional.scala 40:58 calc6x6.scala 84:22]
  assign Core_45_io_in_b = _T_2 ? $signed(25'sh0) : $signed(_GEN_415); // @[Conditional.scala 40:58 calc6x6.scala 85:23]
  assign Core_45_io_flag = _T_2 ? 1'h0 : _GEN_278; // @[Conditional.scala 40:58 calc6x6.scala 83:23]
  always @(posedge clock) begin
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_0 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_0 <= {{1{_reg1_mat_real_0_T[16]}},_reg1_mat_real_0_T}; // @[calc6x6.scala 110:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_1 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_1 <= {{1{_reg1_mat_real_1_T[16]}},_reg1_mat_real_1_T}; // @[calc6x6.scala 110:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_2 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_2 <= {{1{_reg1_mat_real_2_T[16]}},_reg1_mat_real_2_T}; // @[calc6x6.scala 110:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_3 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_3 <= {{1{_reg1_mat_real_3_T[16]}},_reg1_mat_real_3_T}; // @[calc6x6.scala 110:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_4 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_4 <= {{1{_reg1_mat_real_4_T[16]}},_reg1_mat_real_4_T}; // @[calc6x6.scala 110:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_5 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_5 <= {{1{_reg1_mat_real_5_T[16]}},_reg1_mat_real_5_T}; // @[calc6x6.scala 110:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_6 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_6 <= _reg1_mat_real_6_T_2[17:0]; // @[calc6x6.scala 111:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_7 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_7 <= _reg1_mat_real_7_T_2[17:0]; // @[calc6x6.scala 111:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_8 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_8 <= _reg1_mat_real_8_T_2[17:0]; // @[calc6x6.scala 111:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_9 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_9 <= _reg1_mat_real_9_T_2[17:0]; // @[calc6x6.scala 111:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_10 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_10 <= _reg1_mat_real_10_T_2[17:0]; // @[calc6x6.scala 111:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_11 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_11 <= _reg1_mat_real_11_T_2[17:0]; // @[calc6x6.scala 111:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_12 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_12 <= _reg1_mat_real_12_T_5[17:0]; // @[calc6x6.scala 112:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_13 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_13 <= _reg1_mat_real_13_T_5[17:0]; // @[calc6x6.scala 112:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_14 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_14 <= _reg1_mat_real_14_T_5[17:0]; // @[calc6x6.scala 112:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_15 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_15 <= _reg1_mat_real_15_T_5[17:0]; // @[calc6x6.scala 112:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_16 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_16 <= _reg1_mat_real_16_T_5[17:0]; // @[calc6x6.scala 112:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_17 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_17 <= _reg1_mat_real_17_T_5[17:0]; // @[calc6x6.scala 112:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_18 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_18 <= {{1{_reg1_mat_real_18_T_3[16]}},_reg1_mat_real_18_T_3}; // @[calc6x6.scala 113:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_19 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_19 <= {{1{_reg1_mat_real_19_T_3[16]}},_reg1_mat_real_19_T_3}; // @[calc6x6.scala 113:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_20 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_20 <= {{1{_reg1_mat_real_20_T_3[16]}},_reg1_mat_real_20_T_3}; // @[calc6x6.scala 113:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_21 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_21 <= {{1{_reg1_mat_real_21_T_3[16]}},_reg1_mat_real_21_T_3}; // @[calc6x6.scala 113:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_22 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_22 <= {{1{_reg1_mat_real_22_T_3[16]}},_reg1_mat_real_22_T_3}; // @[calc6x6.scala 113:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_23 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_23 <= {{1{_reg1_mat_real_23_T_3[16]}},_reg1_mat_real_23_T_3}; // @[calc6x6.scala 113:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_30 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_30 <= {{1{_reg1_mat_real_30_T_3[16]}},_reg1_mat_real_30_T_3}; // @[calc6x6.scala 115:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_31 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_31 <= {{1{_reg1_mat_real_31_T_3[16]}},_reg1_mat_real_31_T_3}; // @[calc6x6.scala 115:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_32 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_32 <= {{1{_reg1_mat_real_32_T_3[16]}},_reg1_mat_real_32_T_3}; // @[calc6x6.scala 115:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_33 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_33 <= {{1{_reg1_mat_real_33_T_3[16]}},_reg1_mat_real_33_T_3}; // @[calc6x6.scala 115:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_34 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_34 <= {{1{_reg1_mat_real_34_T_3[16]}},_reg1_mat_real_34_T_3}; // @[calc6x6.scala 115:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_real_35 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_real_35 <= {{1{_reg1_mat_real_35_T_3[16]}},_reg1_mat_real_35_T_3}; // @[calc6x6.scala 115:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_comp_0 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_comp_0 <= {{1{_reg1_mat_comp_0_T_3[16]}},_reg1_mat_comp_0_T_3}; // @[calc6x6.scala 117:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_comp_1 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_comp_1 <= {{1{_reg1_mat_comp_1_T_3[16]}},_reg1_mat_comp_1_T_3}; // @[calc6x6.scala 117:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_comp_2 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_comp_2 <= {{1{_reg1_mat_comp_2_T_3[16]}},_reg1_mat_comp_2_T_3}; // @[calc6x6.scala 117:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_comp_3 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_comp_3 <= {{1{_reg1_mat_comp_3_T_3[16]}},_reg1_mat_comp_3_T_3}; // @[calc6x6.scala 117:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_comp_4 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_comp_4 <= {{1{_reg1_mat_comp_4_T_3[16]}},_reg1_mat_comp_4_T_3}; // @[calc6x6.scala 117:37]
    end
    if (reset) begin // @[calc6x6.scala 91:23]
      reg1_mat_comp_5 <= 18'sh0; // @[calc6x6.scala 91:23]
    end else begin
      reg1_mat_comp_5 <= {{1{_reg1_mat_comp_5_T_3[16]}},_reg1_mat_comp_5_T_3}; // @[calc6x6.scala 117:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_0 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_0 <= {{1{_reg2_mat_real_0_T[18]}},_reg2_mat_real_0_T}; // @[calc6x6.scala 124:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_1 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_1 <= _reg2_mat_real_1_T_2[19:0]; // @[calc6x6.scala 125:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_2 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_2 <= _reg2_mat_real_2_T_5[19:0]; // @[calc6x6.scala 126:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_3 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_3 <= {{1{_reg2_mat_real_3_T_3[18]}},_reg2_mat_real_3_T_3}; // @[calc6x6.scala 127:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_5 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_5 <= {{1{_reg2_mat_real_5_T_3[18]}},_reg2_mat_real_5_T_3}; // @[calc6x6.scala 129:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_6 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_6 <= {{1{_reg2_mat_real_6_T[18]}},_reg2_mat_real_6_T}; // @[calc6x6.scala 124:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_7 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_7 <= _reg2_mat_real_7_T_2[19:0]; // @[calc6x6.scala 125:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_8 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_8 <= _reg2_mat_real_8_T_5[19:0]; // @[calc6x6.scala 126:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_9 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_9 <= {{1{_reg2_mat_real_9_T_3[18]}},_reg2_mat_real_9_T_3}; // @[calc6x6.scala 127:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_11 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_11 <= {{1{_reg2_mat_real_11_T_3[18]}},_reg2_mat_real_11_T_3}; // @[calc6x6.scala 129:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_12 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_12 <= {{1{_reg2_mat_real_12_T[18]}},_reg2_mat_real_12_T}; // @[calc6x6.scala 124:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_13 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_13 <= _reg2_mat_real_13_T_2[19:0]; // @[calc6x6.scala 125:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_14 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_14 <= _reg2_mat_real_14_T_5[19:0]; // @[calc6x6.scala 126:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_15 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_15 <= {{1{_reg2_mat_real_15_T_3[18]}},_reg2_mat_real_15_T_3}; // @[calc6x6.scala 127:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_17 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_17 <= {{1{_reg2_mat_real_17_T_3[18]}},_reg2_mat_real_17_T_3}; // @[calc6x6.scala 129:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_18 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_18 <= {{1{_reg2_mat_real_18_T[18]}},_reg2_mat_real_18_T}; // @[calc6x6.scala 124:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_19 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_19 <= _reg2_mat_real_19_T_2[19:0]; // @[calc6x6.scala 125:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_20 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_20 <= _reg2_mat_real_20_T_5[19:0]; // @[calc6x6.scala 126:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_21 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_21 <= _reg2_mat_real_21_T_5[19:0]; // @[calc6x6.scala 127:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_22 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_22 <= _reg2_mat_real_22_T_5[19:0]; // @[calc6x6.scala 128:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_23 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_23 <= {{1{_reg2_mat_real_23_T_3[18]}},_reg2_mat_real_23_T_3}; // @[calc6x6.scala 129:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_30 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_30 <= {{1{_reg2_mat_real_30_T[18]}},_reg2_mat_real_30_T}; // @[calc6x6.scala 124:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_31 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_31 <= _reg2_mat_real_31_T_2[19:0]; // @[calc6x6.scala 125:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_32 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_32 <= _reg2_mat_real_32_T_5[19:0]; // @[calc6x6.scala 126:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_33 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_33 <= {{1{_reg2_mat_real_33_T_3[18]}},_reg2_mat_real_33_T_3}; // @[calc6x6.scala 127:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_real_35 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_real_35 <= {{1{_reg2_mat_real_35_T_3[18]}},_reg2_mat_real_35_T_3}; // @[calc6x6.scala 129:37]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_comp_0 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_comp_0 <= {{1{_reg2_mat_comp_0_T[18]}},_reg2_mat_comp_0_T}; // @[calc6x6.scala 132:26]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_comp_1 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_comp_1 <= _reg2_mat_comp_1_T_2[19:0]; // @[calc6x6.scala 133:26]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_comp_2 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_comp_2 <= _reg2_mat_comp_2_T_5[19:0]; // @[calc6x6.scala 134:26]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_comp_3 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_comp_3 <= _reg2_mat_comp_3_T_5[19:0]; // @[calc6x6.scala 135:26]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_comp_4 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_comp_4 <= _reg2_mat_comp_4_T_5[19:0]; // @[calc6x6.scala 136:26]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_comp_5 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_comp_5 <= {{1{_reg2_mat_comp_5_T_3[18]}},_reg2_mat_comp_5_T_3}; // @[calc6x6.scala 137:26]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_comp_6 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_comp_6 <= {{1{_reg2_mat_comp_6_T_3[18]}},_reg2_mat_comp_6_T_3}; // @[calc6x6.scala 140:26]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_comp_7 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_comp_7 <= {{1{_reg2_mat_comp_7_T_3[18]}},_reg2_mat_comp_7_T_3}; // @[calc6x6.scala 141:26]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_comp_8 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_comp_8 <= {{1{_reg2_mat_comp_8_T_3[18]}},_reg2_mat_comp_8_T_3}; // @[calc6x6.scala 142:26]
    end
    if (reset) begin // @[calc6x6.scala 92:23]
      reg2_mat_comp_9 <= 20'sh0; // @[calc6x6.scala 92:23]
    end else begin
      reg2_mat_comp_9 <= {{1{_reg2_mat_comp_9_T_3[18]}},_reg2_mat_comp_9_T_3}; // @[calc6x6.scala 143:26]
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_0 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_0 <= _GEN_486[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_1 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_1 <= _GEN_487[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_2 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_2 <= _GEN_488[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_3 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_3 <= _GEN_498[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_4 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_4 <= _GEN_500[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_5 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_5 <= _GEN_502[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_6 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_6 <= _GEN_503[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_7 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_7 <= _GEN_504[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_8 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_8 <= _GEN_505[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_9 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_9 <= _GEN_515[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_10 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_10 <= _GEN_517[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_11 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_11 <= _GEN_519[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_12 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_12 <= _GEN_520[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_13 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_13 <= _GEN_521[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_14 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_14 <= _GEN_522[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_15 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_15 <= _GEN_532[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_16 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_16 <= _GEN_534[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_17 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_17 <= _GEN_536[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_18 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_18 <= _GEN_546[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_19 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_19 <= _GEN_557[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_20 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_20 <= _GEN_568[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_21 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_21 <= _GEN_579[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_22 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_22 <= _GEN_590[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_23 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_23 <= _GEN_601[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_24 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_24 <= _GEN_603[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_25 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_25 <= _GEN_605[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_26 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_26 <= _GEN_607[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_27 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_27 <= _GEN_609[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_28 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_28 <= _GEN_611[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_29 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_29 <= _GEN_613[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_30 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_30 <= _GEN_615[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_31 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_31 <= _GEN_616[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_32 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_32 <= _GEN_617[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_33 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_33 <= _GEN_627[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_34 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_34 <= _GEN_629[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_real_35 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_real_35 <= _GEN_631[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_3 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_3 <= _GEN_499[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_4 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_4 <= _GEN_501[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_9 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_9 <= _GEN_516[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_10 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_10 <= _GEN_518[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_15 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_15 <= _GEN_533[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_16 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_16 <= _GEN_535[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_18 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_18 <= _GEN_547[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_19 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_19 <= _GEN_558[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_20 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_20 <= _GEN_569[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_21 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_21 <= _GEN_580[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_22 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_22 <= _GEN_591[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_23 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_23 <= _GEN_602[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_24 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_24 <= _GEN_604[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_25 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_25 <= _GEN_606[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_26 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_26 <= _GEN_608[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_27 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_27 <= _GEN_610[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_28 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_28 <= _GEN_612[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_29 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_29 <= _GEN_614[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_33 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_33 <= _GEN_628[37:0];
    end
    if (reset) begin // @[calc6x6.scala 93:21]
      w3_mat_comp_34 <= 38'sh0; // @[calc6x6.scala 93:21]
    end else begin
      w3_mat_comp_34 <= _GEN_630[37:0];
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_0 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_0 <= _reg3_mat_real_0_T_12; // @[calc6x6.scala 148:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_1 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_1 <= _reg3_mat_real_1_T_12; // @[calc6x6.scala 148:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_2 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_2 <= _reg3_mat_real_2_T_12; // @[calc6x6.scala 148:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_3 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_3 <= _reg3_mat_real_3_T_12; // @[calc6x6.scala 148:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_4 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_4 <= _reg3_mat_real_4_T_12; // @[calc6x6.scala 148:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_5 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_5 <= _reg3_mat_real_5_T_12; // @[calc6x6.scala 148:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_6 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_6 <= _reg3_mat_real_6_T_9; // @[calc6x6.scala 150:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_7 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_7 <= _reg3_mat_real_7_T_9; // @[calc6x6.scala 150:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_8 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_8 <= _reg3_mat_real_8_T_9; // @[calc6x6.scala 150:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_9 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_9 <= _reg3_mat_real_9_T_9; // @[calc6x6.scala 150:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_10 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_10 <= _reg3_mat_real_10_T_9; // @[calc6x6.scala 150:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_11 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_11 <= _reg3_mat_real_11_T_9; // @[calc6x6.scala 150:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_12 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_12 <= _reg3_mat_real_12_T_9; // @[calc6x6.scala 151:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_13 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_13 <= _reg3_mat_real_13_T_9; // @[calc6x6.scala 151:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_14 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_14 <= _reg3_mat_real_14_T_9; // @[calc6x6.scala 151:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_15 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_15 <= _reg3_mat_real_15_T_9; // @[calc6x6.scala 151:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_16 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_16 <= _reg3_mat_real_16_T_9; // @[calc6x6.scala 151:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_17 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_17 <= _reg3_mat_real_17_T_9; // @[calc6x6.scala 151:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_18 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_18 <= _reg3_mat_real_18_T_12; // @[calc6x6.scala 152:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_19 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_19 <= _reg3_mat_real_19_T_12; // @[calc6x6.scala 152:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_20 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_20 <= _reg3_mat_real_20_T_12; // @[calc6x6.scala 152:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_21 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_21 <= _reg3_mat_real_21_T_12; // @[calc6x6.scala 152:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_22 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_22 <= _reg3_mat_real_22_T_12; // @[calc6x6.scala 152:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_real_23 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_real_23 <= _reg3_mat_real_23_T_12; // @[calc6x6.scala 152:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_comp_3 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_comp_3 <= _reg3_mat_comp_3_T_12; // @[calc6x6.scala 154:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_comp_4 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_comp_4 <= _reg3_mat_comp_4_T_12; // @[calc6x6.scala 154:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_comp_9 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_comp_9 <= _reg3_mat_comp_9_T_9; // @[calc6x6.scala 156:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_comp_10 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_comp_10 <= _reg3_mat_comp_10_T_9; // @[calc6x6.scala 156:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_comp_15 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_comp_15 <= _reg3_mat_comp_15_T_9; // @[calc6x6.scala 157:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_comp_16 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_comp_16 <= _reg3_mat_comp_16_T_9; // @[calc6x6.scala 157:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_comp_21 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_comp_21 <= _reg3_mat_comp_21_T_12; // @[calc6x6.scala 158:37]
    end
    if (reset) begin // @[calc6x6.scala 94:23]
      reg3_mat_comp_22 <= 38'sh0; // @[calc6x6.scala 94:23]
    end else begin
      reg3_mat_comp_22 <= _reg3_mat_comp_22_T_12; // @[calc6x6.scala 158:37]
    end
    if (reset) begin // @[calc6x6.scala 172:28]
      valid_reg_0 <= 1'h0; // @[calc6x6.scala 172:28]
    end else begin
      valid_reg_0 <= io_valid_in; // @[calc6x6.scala 173:18]
    end
    if (reset) begin // @[calc6x6.scala 172:28]
      valid_reg_1 <= 1'h0; // @[calc6x6.scala 172:28]
    end else begin
      valid_reg_1 <= valid_reg_0; // @[calc6x6.scala 175:18]
    end
    if (reset) begin // @[calc6x6.scala 172:28]
      valid_reg_2 <= 1'h0; // @[calc6x6.scala 172:28]
    end else begin
      valid_reg_2 <= valid_reg_1; // @[calc6x6.scala 177:18]
    end
    if (reset) begin // @[calc6x6.scala 172:28]
      valid_reg_3 <= 1'h0; // @[calc6x6.scala 172:28]
    end else begin
      valid_reg_3 <= valid_reg_2; // @[calc6x6.scala 179:18]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg1_mat_real_0 = _RAND_0[17:0];
  _RAND_1 = {1{`RANDOM}};
  reg1_mat_real_1 = _RAND_1[17:0];
  _RAND_2 = {1{`RANDOM}};
  reg1_mat_real_2 = _RAND_2[17:0];
  _RAND_3 = {1{`RANDOM}};
  reg1_mat_real_3 = _RAND_3[17:0];
  _RAND_4 = {1{`RANDOM}};
  reg1_mat_real_4 = _RAND_4[17:0];
  _RAND_5 = {1{`RANDOM}};
  reg1_mat_real_5 = _RAND_5[17:0];
  _RAND_6 = {1{`RANDOM}};
  reg1_mat_real_6 = _RAND_6[17:0];
  _RAND_7 = {1{`RANDOM}};
  reg1_mat_real_7 = _RAND_7[17:0];
  _RAND_8 = {1{`RANDOM}};
  reg1_mat_real_8 = _RAND_8[17:0];
  _RAND_9 = {1{`RANDOM}};
  reg1_mat_real_9 = _RAND_9[17:0];
  _RAND_10 = {1{`RANDOM}};
  reg1_mat_real_10 = _RAND_10[17:0];
  _RAND_11 = {1{`RANDOM}};
  reg1_mat_real_11 = _RAND_11[17:0];
  _RAND_12 = {1{`RANDOM}};
  reg1_mat_real_12 = _RAND_12[17:0];
  _RAND_13 = {1{`RANDOM}};
  reg1_mat_real_13 = _RAND_13[17:0];
  _RAND_14 = {1{`RANDOM}};
  reg1_mat_real_14 = _RAND_14[17:0];
  _RAND_15 = {1{`RANDOM}};
  reg1_mat_real_15 = _RAND_15[17:0];
  _RAND_16 = {1{`RANDOM}};
  reg1_mat_real_16 = _RAND_16[17:0];
  _RAND_17 = {1{`RANDOM}};
  reg1_mat_real_17 = _RAND_17[17:0];
  _RAND_18 = {1{`RANDOM}};
  reg1_mat_real_18 = _RAND_18[17:0];
  _RAND_19 = {1{`RANDOM}};
  reg1_mat_real_19 = _RAND_19[17:0];
  _RAND_20 = {1{`RANDOM}};
  reg1_mat_real_20 = _RAND_20[17:0];
  _RAND_21 = {1{`RANDOM}};
  reg1_mat_real_21 = _RAND_21[17:0];
  _RAND_22 = {1{`RANDOM}};
  reg1_mat_real_22 = _RAND_22[17:0];
  _RAND_23 = {1{`RANDOM}};
  reg1_mat_real_23 = _RAND_23[17:0];
  _RAND_24 = {1{`RANDOM}};
  reg1_mat_real_30 = _RAND_24[17:0];
  _RAND_25 = {1{`RANDOM}};
  reg1_mat_real_31 = _RAND_25[17:0];
  _RAND_26 = {1{`RANDOM}};
  reg1_mat_real_32 = _RAND_26[17:0];
  _RAND_27 = {1{`RANDOM}};
  reg1_mat_real_33 = _RAND_27[17:0];
  _RAND_28 = {1{`RANDOM}};
  reg1_mat_real_34 = _RAND_28[17:0];
  _RAND_29 = {1{`RANDOM}};
  reg1_mat_real_35 = _RAND_29[17:0];
  _RAND_30 = {1{`RANDOM}};
  reg1_mat_comp_0 = _RAND_30[17:0];
  _RAND_31 = {1{`RANDOM}};
  reg1_mat_comp_1 = _RAND_31[17:0];
  _RAND_32 = {1{`RANDOM}};
  reg1_mat_comp_2 = _RAND_32[17:0];
  _RAND_33 = {1{`RANDOM}};
  reg1_mat_comp_3 = _RAND_33[17:0];
  _RAND_34 = {1{`RANDOM}};
  reg1_mat_comp_4 = _RAND_34[17:0];
  _RAND_35 = {1{`RANDOM}};
  reg1_mat_comp_5 = _RAND_35[17:0];
  _RAND_36 = {1{`RANDOM}};
  reg2_mat_real_0 = _RAND_36[19:0];
  _RAND_37 = {1{`RANDOM}};
  reg2_mat_real_1 = _RAND_37[19:0];
  _RAND_38 = {1{`RANDOM}};
  reg2_mat_real_2 = _RAND_38[19:0];
  _RAND_39 = {1{`RANDOM}};
  reg2_mat_real_3 = _RAND_39[19:0];
  _RAND_40 = {1{`RANDOM}};
  reg2_mat_real_5 = _RAND_40[19:0];
  _RAND_41 = {1{`RANDOM}};
  reg2_mat_real_6 = _RAND_41[19:0];
  _RAND_42 = {1{`RANDOM}};
  reg2_mat_real_7 = _RAND_42[19:0];
  _RAND_43 = {1{`RANDOM}};
  reg2_mat_real_8 = _RAND_43[19:0];
  _RAND_44 = {1{`RANDOM}};
  reg2_mat_real_9 = _RAND_44[19:0];
  _RAND_45 = {1{`RANDOM}};
  reg2_mat_real_11 = _RAND_45[19:0];
  _RAND_46 = {1{`RANDOM}};
  reg2_mat_real_12 = _RAND_46[19:0];
  _RAND_47 = {1{`RANDOM}};
  reg2_mat_real_13 = _RAND_47[19:0];
  _RAND_48 = {1{`RANDOM}};
  reg2_mat_real_14 = _RAND_48[19:0];
  _RAND_49 = {1{`RANDOM}};
  reg2_mat_real_15 = _RAND_49[19:0];
  _RAND_50 = {1{`RANDOM}};
  reg2_mat_real_17 = _RAND_50[19:0];
  _RAND_51 = {1{`RANDOM}};
  reg2_mat_real_18 = _RAND_51[19:0];
  _RAND_52 = {1{`RANDOM}};
  reg2_mat_real_19 = _RAND_52[19:0];
  _RAND_53 = {1{`RANDOM}};
  reg2_mat_real_20 = _RAND_53[19:0];
  _RAND_54 = {1{`RANDOM}};
  reg2_mat_real_21 = _RAND_54[19:0];
  _RAND_55 = {1{`RANDOM}};
  reg2_mat_real_22 = _RAND_55[19:0];
  _RAND_56 = {1{`RANDOM}};
  reg2_mat_real_23 = _RAND_56[19:0];
  _RAND_57 = {1{`RANDOM}};
  reg2_mat_real_30 = _RAND_57[19:0];
  _RAND_58 = {1{`RANDOM}};
  reg2_mat_real_31 = _RAND_58[19:0];
  _RAND_59 = {1{`RANDOM}};
  reg2_mat_real_32 = _RAND_59[19:0];
  _RAND_60 = {1{`RANDOM}};
  reg2_mat_real_33 = _RAND_60[19:0];
  _RAND_61 = {1{`RANDOM}};
  reg2_mat_real_35 = _RAND_61[19:0];
  _RAND_62 = {1{`RANDOM}};
  reg2_mat_comp_0 = _RAND_62[19:0];
  _RAND_63 = {1{`RANDOM}};
  reg2_mat_comp_1 = _RAND_63[19:0];
  _RAND_64 = {1{`RANDOM}};
  reg2_mat_comp_2 = _RAND_64[19:0];
  _RAND_65 = {1{`RANDOM}};
  reg2_mat_comp_3 = _RAND_65[19:0];
  _RAND_66 = {1{`RANDOM}};
  reg2_mat_comp_4 = _RAND_66[19:0];
  _RAND_67 = {1{`RANDOM}};
  reg2_mat_comp_5 = _RAND_67[19:0];
  _RAND_68 = {1{`RANDOM}};
  reg2_mat_comp_6 = _RAND_68[19:0];
  _RAND_69 = {1{`RANDOM}};
  reg2_mat_comp_7 = _RAND_69[19:0];
  _RAND_70 = {1{`RANDOM}};
  reg2_mat_comp_8 = _RAND_70[19:0];
  _RAND_71 = {1{`RANDOM}};
  reg2_mat_comp_9 = _RAND_71[19:0];
  _RAND_72 = {2{`RANDOM}};
  w3_mat_real_0 = _RAND_72[37:0];
  _RAND_73 = {2{`RANDOM}};
  w3_mat_real_1 = _RAND_73[37:0];
  _RAND_74 = {2{`RANDOM}};
  w3_mat_real_2 = _RAND_74[37:0];
  _RAND_75 = {2{`RANDOM}};
  w3_mat_real_3 = _RAND_75[37:0];
  _RAND_76 = {2{`RANDOM}};
  w3_mat_real_4 = _RAND_76[37:0];
  _RAND_77 = {2{`RANDOM}};
  w3_mat_real_5 = _RAND_77[37:0];
  _RAND_78 = {2{`RANDOM}};
  w3_mat_real_6 = _RAND_78[37:0];
  _RAND_79 = {2{`RANDOM}};
  w3_mat_real_7 = _RAND_79[37:0];
  _RAND_80 = {2{`RANDOM}};
  w3_mat_real_8 = _RAND_80[37:0];
  _RAND_81 = {2{`RANDOM}};
  w3_mat_real_9 = _RAND_81[37:0];
  _RAND_82 = {2{`RANDOM}};
  w3_mat_real_10 = _RAND_82[37:0];
  _RAND_83 = {2{`RANDOM}};
  w3_mat_real_11 = _RAND_83[37:0];
  _RAND_84 = {2{`RANDOM}};
  w3_mat_real_12 = _RAND_84[37:0];
  _RAND_85 = {2{`RANDOM}};
  w3_mat_real_13 = _RAND_85[37:0];
  _RAND_86 = {2{`RANDOM}};
  w3_mat_real_14 = _RAND_86[37:0];
  _RAND_87 = {2{`RANDOM}};
  w3_mat_real_15 = _RAND_87[37:0];
  _RAND_88 = {2{`RANDOM}};
  w3_mat_real_16 = _RAND_88[37:0];
  _RAND_89 = {2{`RANDOM}};
  w3_mat_real_17 = _RAND_89[37:0];
  _RAND_90 = {2{`RANDOM}};
  w3_mat_real_18 = _RAND_90[37:0];
  _RAND_91 = {2{`RANDOM}};
  w3_mat_real_19 = _RAND_91[37:0];
  _RAND_92 = {2{`RANDOM}};
  w3_mat_real_20 = _RAND_92[37:0];
  _RAND_93 = {2{`RANDOM}};
  w3_mat_real_21 = _RAND_93[37:0];
  _RAND_94 = {2{`RANDOM}};
  w3_mat_real_22 = _RAND_94[37:0];
  _RAND_95 = {2{`RANDOM}};
  w3_mat_real_23 = _RAND_95[37:0];
  _RAND_96 = {2{`RANDOM}};
  w3_mat_real_24 = _RAND_96[37:0];
  _RAND_97 = {2{`RANDOM}};
  w3_mat_real_25 = _RAND_97[37:0];
  _RAND_98 = {2{`RANDOM}};
  w3_mat_real_26 = _RAND_98[37:0];
  _RAND_99 = {2{`RANDOM}};
  w3_mat_real_27 = _RAND_99[37:0];
  _RAND_100 = {2{`RANDOM}};
  w3_mat_real_28 = _RAND_100[37:0];
  _RAND_101 = {2{`RANDOM}};
  w3_mat_real_29 = _RAND_101[37:0];
  _RAND_102 = {2{`RANDOM}};
  w3_mat_real_30 = _RAND_102[37:0];
  _RAND_103 = {2{`RANDOM}};
  w3_mat_real_31 = _RAND_103[37:0];
  _RAND_104 = {2{`RANDOM}};
  w3_mat_real_32 = _RAND_104[37:0];
  _RAND_105 = {2{`RANDOM}};
  w3_mat_real_33 = _RAND_105[37:0];
  _RAND_106 = {2{`RANDOM}};
  w3_mat_real_34 = _RAND_106[37:0];
  _RAND_107 = {2{`RANDOM}};
  w3_mat_real_35 = _RAND_107[37:0];
  _RAND_108 = {2{`RANDOM}};
  w3_mat_comp_3 = _RAND_108[37:0];
  _RAND_109 = {2{`RANDOM}};
  w3_mat_comp_4 = _RAND_109[37:0];
  _RAND_110 = {2{`RANDOM}};
  w3_mat_comp_9 = _RAND_110[37:0];
  _RAND_111 = {2{`RANDOM}};
  w3_mat_comp_10 = _RAND_111[37:0];
  _RAND_112 = {2{`RANDOM}};
  w3_mat_comp_15 = _RAND_112[37:0];
  _RAND_113 = {2{`RANDOM}};
  w3_mat_comp_16 = _RAND_113[37:0];
  _RAND_114 = {2{`RANDOM}};
  w3_mat_comp_18 = _RAND_114[37:0];
  _RAND_115 = {2{`RANDOM}};
  w3_mat_comp_19 = _RAND_115[37:0];
  _RAND_116 = {2{`RANDOM}};
  w3_mat_comp_20 = _RAND_116[37:0];
  _RAND_117 = {2{`RANDOM}};
  w3_mat_comp_21 = _RAND_117[37:0];
  _RAND_118 = {2{`RANDOM}};
  w3_mat_comp_22 = _RAND_118[37:0];
  _RAND_119 = {2{`RANDOM}};
  w3_mat_comp_23 = _RAND_119[37:0];
  _RAND_120 = {2{`RANDOM}};
  w3_mat_comp_24 = _RAND_120[37:0];
  _RAND_121 = {2{`RANDOM}};
  w3_mat_comp_25 = _RAND_121[37:0];
  _RAND_122 = {2{`RANDOM}};
  w3_mat_comp_26 = _RAND_122[37:0];
  _RAND_123 = {2{`RANDOM}};
  w3_mat_comp_27 = _RAND_123[37:0];
  _RAND_124 = {2{`RANDOM}};
  w3_mat_comp_28 = _RAND_124[37:0];
  _RAND_125 = {2{`RANDOM}};
  w3_mat_comp_29 = _RAND_125[37:0];
  _RAND_126 = {2{`RANDOM}};
  w3_mat_comp_33 = _RAND_126[37:0];
  _RAND_127 = {2{`RANDOM}};
  w3_mat_comp_34 = _RAND_127[37:0];
  _RAND_128 = {2{`RANDOM}};
  reg3_mat_real_0 = _RAND_128[37:0];
  _RAND_129 = {2{`RANDOM}};
  reg3_mat_real_1 = _RAND_129[37:0];
  _RAND_130 = {2{`RANDOM}};
  reg3_mat_real_2 = _RAND_130[37:0];
  _RAND_131 = {2{`RANDOM}};
  reg3_mat_real_3 = _RAND_131[37:0];
  _RAND_132 = {2{`RANDOM}};
  reg3_mat_real_4 = _RAND_132[37:0];
  _RAND_133 = {2{`RANDOM}};
  reg3_mat_real_5 = _RAND_133[37:0];
  _RAND_134 = {2{`RANDOM}};
  reg3_mat_real_6 = _RAND_134[37:0];
  _RAND_135 = {2{`RANDOM}};
  reg3_mat_real_7 = _RAND_135[37:0];
  _RAND_136 = {2{`RANDOM}};
  reg3_mat_real_8 = _RAND_136[37:0];
  _RAND_137 = {2{`RANDOM}};
  reg3_mat_real_9 = _RAND_137[37:0];
  _RAND_138 = {2{`RANDOM}};
  reg3_mat_real_10 = _RAND_138[37:0];
  _RAND_139 = {2{`RANDOM}};
  reg3_mat_real_11 = _RAND_139[37:0];
  _RAND_140 = {2{`RANDOM}};
  reg3_mat_real_12 = _RAND_140[37:0];
  _RAND_141 = {2{`RANDOM}};
  reg3_mat_real_13 = _RAND_141[37:0];
  _RAND_142 = {2{`RANDOM}};
  reg3_mat_real_14 = _RAND_142[37:0];
  _RAND_143 = {2{`RANDOM}};
  reg3_mat_real_15 = _RAND_143[37:0];
  _RAND_144 = {2{`RANDOM}};
  reg3_mat_real_16 = _RAND_144[37:0];
  _RAND_145 = {2{`RANDOM}};
  reg3_mat_real_17 = _RAND_145[37:0];
  _RAND_146 = {2{`RANDOM}};
  reg3_mat_real_18 = _RAND_146[37:0];
  _RAND_147 = {2{`RANDOM}};
  reg3_mat_real_19 = _RAND_147[37:0];
  _RAND_148 = {2{`RANDOM}};
  reg3_mat_real_20 = _RAND_148[37:0];
  _RAND_149 = {2{`RANDOM}};
  reg3_mat_real_21 = _RAND_149[37:0];
  _RAND_150 = {2{`RANDOM}};
  reg3_mat_real_22 = _RAND_150[37:0];
  _RAND_151 = {2{`RANDOM}};
  reg3_mat_real_23 = _RAND_151[37:0];
  _RAND_152 = {2{`RANDOM}};
  reg3_mat_comp_3 = _RAND_152[37:0];
  _RAND_153 = {2{`RANDOM}};
  reg3_mat_comp_4 = _RAND_153[37:0];
  _RAND_154 = {2{`RANDOM}};
  reg3_mat_comp_9 = _RAND_154[37:0];
  _RAND_155 = {2{`RANDOM}};
  reg3_mat_comp_10 = _RAND_155[37:0];
  _RAND_156 = {2{`RANDOM}};
  reg3_mat_comp_15 = _RAND_156[37:0];
  _RAND_157 = {2{`RANDOM}};
  reg3_mat_comp_16 = _RAND_157[37:0];
  _RAND_158 = {2{`RANDOM}};
  reg3_mat_comp_21 = _RAND_158[37:0];
  _RAND_159 = {2{`RANDOM}};
  reg3_mat_comp_22 = _RAND_159[37:0];
  _RAND_160 = {1{`RANDOM}};
  valid_reg_0 = _RAND_160[0:0];
  _RAND_161 = {1{`RANDOM}};
  valid_reg_1 = _RAND_161[0:0];
  _RAND_162 = {1{`RANDOM}};
  valid_reg_2 = _RAND_162[0:0];
  _RAND_163 = {1{`RANDOM}};
  valid_reg_3 = _RAND_163[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Calc8x8(
  input         clock,
  input         reset,
  input  [15:0] io_input_mat_0,
  input  [15:0] io_input_mat_1,
  input  [15:0] io_input_mat_2,
  input  [15:0] io_input_mat_3,
  input  [15:0] io_input_mat_4,
  input  [15:0] io_input_mat_5,
  input  [15:0] io_input_mat_6,
  input  [15:0] io_input_mat_7,
  input  [15:0] io_input_mat_8,
  input  [15:0] io_input_mat_9,
  input  [15:0] io_input_mat_10,
  input  [15:0] io_input_mat_11,
  input  [15:0] io_input_mat_12,
  input  [15:0] io_input_mat_13,
  input  [15:0] io_input_mat_14,
  input  [15:0] io_input_mat_15,
  input  [15:0] io_input_mat_16,
  input  [15:0] io_input_mat_17,
  input  [15:0] io_input_mat_18,
  input  [15:0] io_input_mat_19,
  input  [15:0] io_input_mat_20,
  input  [15:0] io_input_mat_21,
  input  [15:0] io_input_mat_22,
  input  [15:0] io_input_mat_23,
  input  [15:0] io_input_mat_24,
  input  [15:0] io_input_mat_25,
  input  [15:0] io_input_mat_26,
  input  [15:0] io_input_mat_27,
  input  [15:0] io_input_mat_28,
  input  [15:0] io_input_mat_29,
  input  [15:0] io_input_mat_30,
  input  [15:0] io_input_mat_31,
  input  [15:0] io_input_mat_32,
  input  [15:0] io_input_mat_33,
  input  [15:0] io_input_mat_34,
  input  [15:0] io_input_mat_35,
  input  [15:0] io_input_mat_36,
  input  [15:0] io_input_mat_37,
  input  [15:0] io_input_mat_38,
  input  [15:0] io_input_mat_39,
  input  [15:0] io_input_mat_40,
  input  [15:0] io_input_mat_41,
  input  [15:0] io_input_mat_42,
  input  [15:0] io_input_mat_43,
  input  [15:0] io_input_mat_44,
  input  [15:0] io_input_mat_45,
  input  [15:0] io_input_mat_46,
  input  [15:0] io_input_mat_47,
  input  [15:0] io_input_mat_48,
  input  [15:0] io_input_mat_49,
  input  [15:0] io_input_mat_50,
  input  [15:0] io_input_mat_51,
  input  [15:0] io_input_mat_52,
  input  [15:0] io_input_mat_53,
  input  [15:0] io_input_mat_54,
  input  [15:0] io_input_mat_55,
  input  [15:0] io_input_mat_56,
  input  [15:0] io_input_mat_57,
  input  [15:0] io_input_mat_58,
  input  [15:0] io_input_mat_59,
  input  [15:0] io_input_mat_60,
  input  [15:0] io_input_mat_61,
  input  [15:0] io_input_mat_62,
  input  [15:0] io_input_mat_63,
  input  [15:0] io_input_up_0,
  input  [15:0] io_input_up_1,
  input  [15:0] io_input_up_2,
  input  [15:0] io_input_up_3,
  input  [15:0] io_input_up_4,
  input  [15:0] io_input_up_5,
  input  [15:0] io_input_up_6,
  input  [15:0] io_input_up_7,
  input  [15:0] io_input_up_8,
  input  [15:0] io_input_up_9,
  input  [15:0] io_input_down_0,
  input  [15:0] io_input_down_1,
  input  [15:0] io_input_down_2,
  input  [15:0] io_input_down_3,
  input  [15:0] io_input_down_4,
  input  [15:0] io_input_down_5,
  input  [15:0] io_input_down_6,
  input  [15:0] io_input_down_7,
  input  [15:0] io_input_down_8,
  input  [15:0] io_input_down_9,
  input  [15:0] io_input_left_0,
  input  [15:0] io_input_left_1,
  input  [15:0] io_input_left_2,
  input  [15:0] io_input_left_3,
  input  [15:0] io_input_left_4,
  input  [15:0] io_input_left_5,
  input  [15:0] io_input_left_6,
  input  [15:0] io_input_left_7,
  input  [15:0] io_input_right_0,
  input  [15:0] io_input_right_1,
  input  [15:0] io_input_right_2,
  input  [15:0] io_input_right_3,
  input  [15:0] io_input_right_4,
  input  [15:0] io_input_right_5,
  input  [15:0] io_input_right_6,
  input  [15:0] io_input_right_7,
  input  [1:0]  io_flag,
  input  [15:0] io_weight_0_real_0,
  input  [15:0] io_weight_0_real_1,
  input  [15:0] io_weight_0_real_2,
  input  [15:0] io_weight_0_real_3,
  input  [15:0] io_weight_0_real_4,
  input  [15:0] io_weight_0_real_5,
  input  [15:0] io_weight_0_real_6,
  input  [15:0] io_weight_0_real_7,
  input  [15:0] io_weight_0_real_8,
  input  [15:0] io_weight_0_real_9,
  input  [15:0] io_weight_0_real_10,
  input  [15:0] io_weight_0_real_11,
  input  [15:0] io_weight_0_real_12,
  input  [15:0] io_weight_0_real_13,
  input  [15:0] io_weight_0_real_14,
  input  [15:0] io_weight_0_real_15,
  input  [15:0] io_weight_1_real_0,
  input  [15:0] io_weight_1_real_1,
  input  [15:0] io_weight_1_real_2,
  input  [15:0] io_weight_1_real_3,
  input  [15:0] io_weight_1_real_4,
  input  [15:0] io_weight_1_real_5,
  input  [15:0] io_weight_1_real_6,
  input  [15:0] io_weight_1_real_7,
  input  [15:0] io_weight_1_real_8,
  input  [15:0] io_weight_1_real_9,
  input  [15:0] io_weight_1_real_10,
  input  [15:0] io_weight_1_real_11,
  input  [15:0] io_weight_1_real_12,
  input  [15:0] io_weight_1_real_13,
  input  [15:0] io_weight_1_real_14,
  input  [15:0] io_weight_1_real_15,
  input  [15:0] io_weight_2_real_0,
  input  [15:0] io_weight_2_real_1,
  input  [15:0] io_weight_2_real_2,
  input  [15:0] io_weight_2_real_3,
  input  [15:0] io_weight_2_real_4,
  input  [15:0] io_weight_2_real_5,
  input  [15:0] io_weight_2_real_6,
  input  [15:0] io_weight_2_real_7,
  input  [15:0] io_weight_2_real_8,
  input  [15:0] io_weight_2_real_9,
  input  [15:0] io_weight_2_real_10,
  input  [15:0] io_weight_2_real_11,
  input  [15:0] io_weight_2_real_12,
  input  [15:0] io_weight_2_real_13,
  input  [15:0] io_weight_2_real_14,
  input  [15:0] io_weight_2_real_15,
  input  [15:0] io_weight_3_real_0,
  input  [15:0] io_weight_3_real_1,
  input  [15:0] io_weight_3_real_2,
  input  [15:0] io_weight_3_real_3,
  input  [15:0] io_weight_3_real_4,
  input  [15:0] io_weight_3_real_5,
  input  [15:0] io_weight_3_real_6,
  input  [15:0] io_weight_3_real_7,
  input  [15:0] io_weight_3_real_8,
  input  [15:0] io_weight_3_real_9,
  input  [15:0] io_weight_3_real_10,
  input  [15:0] io_weight_3_real_11,
  input  [15:0] io_weight_3_real_12,
  input  [15:0] io_weight_3_real_13,
  input  [15:0] io_weight_3_real_14,
  input  [15:0] io_weight_3_real_15,
  output [36:0] io_output_mat_0,
  output [36:0] io_output_mat_1,
  output [36:0] io_output_mat_2,
  output [36:0] io_output_mat_3,
  output [36:0] io_output_mat_4,
  output [36:0] io_output_mat_5,
  output [36:0] io_output_mat_6,
  output [36:0] io_output_mat_7,
  output [36:0] io_output_mat_8,
  output [36:0] io_output_mat_9,
  output [36:0] io_output_mat_10,
  output [36:0] io_output_mat_11,
  output [36:0] io_output_mat_12,
  output [36:0] io_output_mat_13,
  output [36:0] io_output_mat_14,
  output [36:0] io_output_mat_15,
  output [36:0] io_output_mat_16,
  output [36:0] io_output_mat_17,
  output [36:0] io_output_mat_18,
  output [36:0] io_output_mat_19,
  output [36:0] io_output_mat_20,
  output [36:0] io_output_mat_21,
  output [36:0] io_output_mat_22,
  output [36:0] io_output_mat_23,
  output [36:0] io_output_mat_24,
  output [36:0] io_output_mat_25,
  output [36:0] io_output_mat_26,
  output [36:0] io_output_mat_27,
  output [36:0] io_output_mat_28,
  output [36:0] io_output_mat_29,
  output [36:0] io_output_mat_30,
  output [36:0] io_output_mat_31,
  output [36:0] io_output_mat_32,
  output [36:0] io_output_mat_33,
  output [36:0] io_output_mat_34,
  output [36:0] io_output_mat_35,
  output [36:0] io_output_mat_36,
  output [36:0] io_output_mat_37,
  output [36:0] io_output_mat_38,
  output [36:0] io_output_mat_39,
  output [36:0] io_output_mat_40,
  output [36:0] io_output_mat_41,
  output [36:0] io_output_mat_42,
  output [36:0] io_output_mat_43,
  output [36:0] io_output_mat_44,
  output [36:0] io_output_mat_45,
  output [36:0] io_output_mat_46,
  output [36:0] io_output_mat_47,
  output [36:0] io_output_mat_48,
  output [36:0] io_output_mat_49,
  output [36:0] io_output_mat_50,
  output [36:0] io_output_mat_51,
  output [36:0] io_output_mat_52,
  output [36:0] io_output_mat_53,
  output [36:0] io_output_mat_54,
  output [36:0] io_output_mat_55,
  output [36:0] io_output_mat_56,
  output [36:0] io_output_mat_57,
  output [36:0] io_output_mat_58,
  output [36:0] io_output_mat_59,
  output [36:0] io_output_mat_60,
  output [36:0] io_output_mat_61,
  output [36:0] io_output_mat_62,
  output [36:0] io_output_mat_63,
  input         io_valid_in,
  output        io_valid_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
`endif // RANDOMIZE_REG_INIT
  wire  Calc6x6_clock; // @[calc8x8.scala 59:39]
  wire  Calc6x6_reset; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_0; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_1; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_2; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_3; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_4; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_5; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_6; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_7; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_8; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_9; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_10; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_11; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_12; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_13; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_14; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_15; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_16; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_17; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_18; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_19; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_20; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_21; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_22; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_23; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_24; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_25; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_26; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_27; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_28; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_29; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_30; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_31; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_32; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_33; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_34; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_io_input_mat_35; // @[calc8x8.scala 59:39]
  wire [1:0] Calc6x6_io_flag; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_10; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_11; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_12; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_13; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_14; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_real_15; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp1_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp1_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp1_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp1_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp1_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp1_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp1_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp1_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp1_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp1_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp2_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp2_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp2_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp2_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp2_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp2_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp2_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp2_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp2_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp2_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp3_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp3_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp3_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp3_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp3_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp3_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp3_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp3_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp3_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_io_weight_comp3_9; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_0; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_1; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_2; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_3; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_4; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_5; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_6; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_7; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_8; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_9; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_10; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_11; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_12; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_13; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_14; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_io_output_mat_15; // @[calc8x8.scala 59:39]
  wire  Calc6x6_io_valid_in; // @[calc8x8.scala 59:39]
  wire  Calc6x6_io_valid_out; // @[calc8x8.scala 59:39]
  wire  Calc6x6_1_clock; // @[calc8x8.scala 59:39]
  wire  Calc6x6_1_reset; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_0; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_1; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_2; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_3; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_4; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_5; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_6; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_7; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_8; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_9; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_10; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_11; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_12; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_13; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_14; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_15; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_16; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_17; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_18; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_19; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_20; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_21; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_22; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_23; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_24; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_25; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_26; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_27; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_28; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_29; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_30; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_31; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_32; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_33; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_34; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_1_io_input_mat_35; // @[calc8x8.scala 59:39]
  wire [1:0] Calc6x6_1_io_flag; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_10; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_11; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_12; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_13; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_14; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_real_15; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp1_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp1_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp1_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp1_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp1_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp1_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp1_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp1_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp1_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp1_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp2_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp2_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp2_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp2_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp2_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp2_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp2_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp2_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp2_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp2_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp3_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp3_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp3_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp3_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp3_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp3_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp3_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp3_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp3_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_1_io_weight_comp3_9; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_0; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_1; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_2; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_3; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_4; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_5; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_6; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_7; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_8; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_9; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_10; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_11; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_12; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_13; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_14; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_1_io_output_mat_15; // @[calc8x8.scala 59:39]
  wire  Calc6x6_1_io_valid_in; // @[calc8x8.scala 59:39]
  wire  Calc6x6_1_io_valid_out; // @[calc8x8.scala 59:39]
  wire  Calc6x6_2_clock; // @[calc8x8.scala 59:39]
  wire  Calc6x6_2_reset; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_0; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_1; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_2; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_3; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_4; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_5; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_6; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_7; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_8; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_9; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_10; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_11; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_12; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_13; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_14; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_15; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_16; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_17; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_18; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_19; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_20; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_21; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_22; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_23; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_24; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_25; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_26; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_27; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_28; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_29; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_30; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_31; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_32; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_33; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_34; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_2_io_input_mat_35; // @[calc8x8.scala 59:39]
  wire [1:0] Calc6x6_2_io_flag; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_10; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_11; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_12; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_13; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_14; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_real_15; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp1_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp1_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp1_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp1_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp1_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp1_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp1_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp1_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp1_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp1_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp2_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp2_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp2_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp2_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp2_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp2_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp2_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp2_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp2_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp2_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp3_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp3_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp3_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp3_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp3_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp3_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp3_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp3_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp3_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_2_io_weight_comp3_9; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_0; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_1; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_2; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_3; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_4; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_5; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_6; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_7; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_8; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_9; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_10; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_11; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_12; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_13; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_14; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_2_io_output_mat_15; // @[calc8x8.scala 59:39]
  wire  Calc6x6_2_io_valid_in; // @[calc8x8.scala 59:39]
  wire  Calc6x6_2_io_valid_out; // @[calc8x8.scala 59:39]
  wire  Calc6x6_3_clock; // @[calc8x8.scala 59:39]
  wire  Calc6x6_3_reset; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_0; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_1; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_2; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_3; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_4; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_5; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_6; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_7; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_8; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_9; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_10; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_11; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_12; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_13; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_14; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_15; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_16; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_17; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_18; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_19; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_20; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_21; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_22; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_23; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_24; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_25; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_26; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_27; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_28; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_29; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_30; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_31; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_32; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_33; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_34; // @[calc8x8.scala 59:39]
  wire [15:0] Calc6x6_3_io_input_mat_35; // @[calc8x8.scala 59:39]
  wire [1:0] Calc6x6_3_io_flag; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_10; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_11; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_12; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_13; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_14; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_real_15; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp1_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp1_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp1_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp1_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp1_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp1_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp1_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp1_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp1_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp1_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp2_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp2_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp2_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp2_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp2_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp2_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp2_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp2_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp2_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp2_9; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp3_0; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp3_1; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp3_2; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp3_3; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp3_4; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp3_5; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp3_6; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp3_7; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp3_8; // @[calc8x8.scala 59:39]
  wire [17:0] Calc6x6_3_io_weight_comp3_9; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_0; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_1; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_2; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_3; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_4; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_5; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_6; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_7; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_8; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_9; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_10; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_11; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_12; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_13; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_14; // @[calc8x8.scala 59:39]
  wire [36:0] Calc6x6_3_io_output_mat_15; // @[calc8x8.scala 59:39]
  wire  Calc6x6_3_io_valid_in; // @[calc8x8.scala 59:39]
  wire  Calc6x6_3_io_valid_out; // @[calc8x8.scala 59:39]
  reg [17:0] _B_0_0; // @[calc8x8.scala 71:21]
  reg [17:0] _B_0_1; // @[calc8x8.scala 71:21]
  reg [17:0] _B_0_2; // @[calc8x8.scala 71:21]
  reg [17:0] _B_1_0; // @[calc8x8.scala 71:21]
  reg [17:0] _B_1_1; // @[calc8x8.scala 71:21]
  reg [17:0] _B_1_2; // @[calc8x8.scala 71:21]
  reg [17:0] _B_2_0; // @[calc8x8.scala 71:21]
  reg [17:0] _B_2_1; // @[calc8x8.scala 71:21]
  reg [17:0] _B_2_2; // @[calc8x8.scala 71:21]
  reg [17:0] _B_3_0; // @[calc8x8.scala 71:21]
  reg [17:0] _B_3_1; // @[calc8x8.scala 71:21]
  reg [17:0] _B_3_2; // @[calc8x8.scala 71:21]
  reg [17:0] _B_5_0; // @[calc8x8.scala 71:21]
  reg [17:0] _B_5_1; // @[calc8x8.scala 71:21]
  reg [17:0] _B_5_2; // @[calc8x8.scala 71:21]
  reg [17:0] _Bi_3_0; // @[calc8x8.scala 72:22]
  reg [17:0] _Bi_3_1; // @[calc8x8.scala 72:22]
  reg [17:0] _Bi_3_2; // @[calc8x8.scala 72:22]
  wire [15:0] __B_1_0_T_2 = $signed(io_weight_0_real_0) + $signed(io_weight_0_real_3); // @[calc8x8.scala 79:28]
  wire [15:0] __B_1_0_T_5 = $signed(__B_1_0_T_2) + $signed(io_weight_0_real_6); // @[calc8x8.scala 79:36]
  wire [15:0] __B_2_0_T_2 = $signed(io_weight_0_real_0) - $signed(io_weight_0_real_3); // @[calc8x8.scala 80:28]
  wire [15:0] __B_2_0_T_5 = $signed(__B_2_0_T_2) + $signed(io_weight_0_real_6); // @[calc8x8.scala 80:36]
  wire [15:0] __B_3_0_T_2 = $signed(io_weight_0_real_0) - $signed(io_weight_0_real_6); // @[calc8x8.scala 81:28]
  wire [15:0] __B_1_1_T_2 = $signed(io_weight_0_real_1) + $signed(io_weight_0_real_4); // @[calc8x8.scala 79:28]
  wire [15:0] __B_1_1_T_5 = $signed(__B_1_1_T_2) + $signed(io_weight_0_real_7); // @[calc8x8.scala 79:36]
  wire [15:0] __B_2_1_T_2 = $signed(io_weight_0_real_1) - $signed(io_weight_0_real_4); // @[calc8x8.scala 80:28]
  wire [15:0] __B_2_1_T_5 = $signed(__B_2_1_T_2) + $signed(io_weight_0_real_7); // @[calc8x8.scala 80:36]
  wire [15:0] __B_3_1_T_2 = $signed(io_weight_0_real_1) - $signed(io_weight_0_real_7); // @[calc8x8.scala 81:28]
  wire [15:0] __B_1_2_T_2 = $signed(io_weight_0_real_2) + $signed(io_weight_0_real_5); // @[calc8x8.scala 79:28]
  wire [15:0] __B_1_2_T_5 = $signed(__B_1_2_T_2) + $signed(io_weight_0_real_8); // @[calc8x8.scala 79:36]
  wire [15:0] __B_2_2_T_2 = $signed(io_weight_0_real_2) - $signed(io_weight_0_real_5); // @[calc8x8.scala 80:28]
  wire [15:0] __B_2_2_T_5 = $signed(__B_2_2_T_2) + $signed(io_weight_0_real_8); // @[calc8x8.scala 80:36]
  wire [15:0] __B_3_2_T_2 = $signed(io_weight_0_real_2) - $signed(io_weight_0_real_8); // @[calc8x8.scala 81:28]
  reg [18:0] __B_0_0; // @[calc8x8.scala 89:22]
  reg [18:0] __B_0_1; // @[calc8x8.scala 89:22]
  reg [18:0] __B_0_2; // @[calc8x8.scala 89:22]
  reg [18:0] __B_0_3; // @[calc8x8.scala 89:22]
  reg [18:0] __B_0_5; // @[calc8x8.scala 89:22]
  reg [18:0] __B_1_0; // @[calc8x8.scala 89:22]
  reg [18:0] __B_1_1; // @[calc8x8.scala 89:22]
  reg [18:0] __B_1_2; // @[calc8x8.scala 89:22]
  reg [18:0] __B_1_3; // @[calc8x8.scala 89:22]
  reg [18:0] __B_1_5; // @[calc8x8.scala 89:22]
  reg [18:0] __B_2_0; // @[calc8x8.scala 89:22]
  reg [18:0] __B_2_1; // @[calc8x8.scala 89:22]
  reg [18:0] __B_2_2; // @[calc8x8.scala 89:22]
  reg [18:0] __B_2_3; // @[calc8x8.scala 89:22]
  reg [18:0] __B_2_5; // @[calc8x8.scala 89:22]
  reg [18:0] __B_3_0; // @[calc8x8.scala 89:22]
  reg [18:0] __B_3_1; // @[calc8x8.scala 89:22]
  reg [18:0] __B_3_2; // @[calc8x8.scala 89:22]
  reg [18:0] __B_3_3; // @[calc8x8.scala 89:22]
  reg [18:0] __B_3_4; // @[calc8x8.scala 89:22]
  reg [18:0] __B_3_5; // @[calc8x8.scala 89:22]
  reg [18:0] __B_5_0; // @[calc8x8.scala 89:22]
  reg [18:0] __B_5_1; // @[calc8x8.scala 89:22]
  reg [18:0] __B_5_2; // @[calc8x8.scala 89:22]
  reg [18:0] __B_5_3; // @[calc8x8.scala 89:22]
  reg [18:0] __B_5_5; // @[calc8x8.scala 89:22]
  reg [18:0] __Bi_0_3; // @[calc8x8.scala 90:23]
  reg [18:0] __Bi_1_3; // @[calc8x8.scala 90:23]
  reg [18:0] __Bi_2_3; // @[calc8x8.scala 90:23]
  reg [18:0] __Bi_3_0; // @[calc8x8.scala 90:23]
  reg [18:0] __Bi_3_1; // @[calc8x8.scala 90:23]
  reg [18:0] __Bi_3_2; // @[calc8x8.scala 90:23]
  reg [18:0] __Bi_3_3; // @[calc8x8.scala 90:23]
  reg [18:0] __Bi_3_4; // @[calc8x8.scala 90:23]
  reg [18:0] __Bi_3_5; // @[calc8x8.scala 90:23]
  reg [18:0] __Bi_5_3; // @[calc8x8.scala 90:23]
  wire [17:0] ___B_0_1_T_2 = $signed(_B_0_0) + $signed(_B_0_1); // @[calc8x8.scala 94:30]
  wire [17:0] ___B_0_1_T_5 = $signed(___B_0_1_T_2) + $signed(_B_0_2); // @[calc8x8.scala 94:39]
  wire [17:0] ___B_0_2_T_2 = $signed(_B_0_0) - $signed(_B_0_1); // @[calc8x8.scala 95:30]
  wire [17:0] ___B_0_2_T_5 = $signed(___B_0_2_T_2) + $signed(_B_0_2); // @[calc8x8.scala 95:39]
  wire [17:0] ___B_0_3_T_2 = $signed(_B_0_0) - $signed(_B_0_2); // @[calc8x8.scala 96:30]
  wire [17:0] ___B_0_3_T_5 = $signed(___B_0_3_T_2) - 18'sh0; // @[calc8x8.scala 96:39]
  wire [18:0] ___Bi_0_3_T_3 = {{1{_B_0_1[17]}},_B_0_1}; // @[calc8x8.scala 102:42]
  wire [17:0] ___Bi_0_3_T_5 = ___Bi_0_3_T_3[17:0]; // @[calc8x8.scala 102:42]
  wire [17:0] ___B_1_1_T_2 = $signed(_B_1_0) + $signed(_B_1_1); // @[calc8x8.scala 94:30]
  wire [17:0] ___B_1_1_T_5 = $signed(___B_1_1_T_2) + $signed(_B_1_2); // @[calc8x8.scala 94:39]
  wire [17:0] ___B_1_2_T_2 = $signed(_B_1_0) - $signed(_B_1_1); // @[calc8x8.scala 95:30]
  wire [17:0] ___B_1_2_T_5 = $signed(___B_1_2_T_2) + $signed(_B_1_2); // @[calc8x8.scala 95:39]
  wire [17:0] ___B_1_3_T_2 = $signed(_B_1_0) - $signed(_B_1_2); // @[calc8x8.scala 96:30]
  wire [17:0] ___B_1_3_T_5 = $signed(___B_1_3_T_2) - 18'sh0; // @[calc8x8.scala 96:39]
  wire [18:0] ___Bi_1_3_T_3 = {{1{_B_1_1[17]}},_B_1_1}; // @[calc8x8.scala 102:42]
  wire [17:0] ___Bi_1_3_T_5 = ___Bi_1_3_T_3[17:0]; // @[calc8x8.scala 102:42]
  wire [17:0] ___B_2_1_T_2 = $signed(_B_2_0) + $signed(_B_2_1); // @[calc8x8.scala 94:30]
  wire [17:0] ___B_2_1_T_5 = $signed(___B_2_1_T_2) + $signed(_B_2_2); // @[calc8x8.scala 94:39]
  wire [17:0] ___B_2_2_T_2 = $signed(_B_2_0) - $signed(_B_2_1); // @[calc8x8.scala 95:30]
  wire [17:0] ___B_2_2_T_5 = $signed(___B_2_2_T_2) + $signed(_B_2_2); // @[calc8x8.scala 95:39]
  wire [17:0] ___B_2_3_T_2 = $signed(_B_2_0) - $signed(_B_2_2); // @[calc8x8.scala 96:30]
  wire [17:0] ___B_2_3_T_5 = $signed(___B_2_3_T_2) - 18'sh0; // @[calc8x8.scala 96:39]
  wire [18:0] ___Bi_2_3_T_3 = {{1{_B_2_1[17]}},_B_2_1}; // @[calc8x8.scala 102:42]
  wire [17:0] ___Bi_2_3_T_5 = ___Bi_2_3_T_3[17:0]; // @[calc8x8.scala 102:42]
  wire [17:0] ___B_3_1_T_2 = $signed(_B_3_0) + $signed(_B_3_1); // @[calc8x8.scala 94:30]
  wire [17:0] ___B_3_1_T_5 = $signed(___B_3_1_T_2) + $signed(_B_3_2); // @[calc8x8.scala 94:39]
  wire [17:0] ___B_3_2_T_2 = $signed(_B_3_0) - $signed(_B_3_1); // @[calc8x8.scala 95:30]
  wire [17:0] ___B_3_2_T_5 = $signed(___B_3_2_T_2) + $signed(_B_3_2); // @[calc8x8.scala 95:39]
  wire [17:0] ___B_3_3_T_2 = $signed(_B_3_0) - $signed(_B_3_2); // @[calc8x8.scala 96:30]
  wire [17:0] ___B_3_3_T_5 = $signed(___B_3_3_T_2) - $signed(_Bi_3_1); // @[calc8x8.scala 96:39]
  wire [17:0] ___B_3_4_T_5 = $signed(___B_3_3_T_2) + $signed(_Bi_3_1); // @[calc8x8.scala 97:39]
  wire [17:0] ___Bi_3_1_T_2 = $signed(_Bi_3_0) + $signed(_Bi_3_1); // @[calc8x8.scala 100:32]
  wire [17:0] ___Bi_3_1_T_5 = $signed(___Bi_3_1_T_2) + $signed(_Bi_3_2); // @[calc8x8.scala 100:42]
  wire [17:0] ___Bi_3_2_T_2 = $signed(_Bi_3_0) - $signed(_Bi_3_1); // @[calc8x8.scala 101:32]
  wire [17:0] ___Bi_3_2_T_5 = $signed(___Bi_3_2_T_2) + $signed(_Bi_3_2); // @[calc8x8.scala 101:42]
  wire [17:0] ___Bi_3_3_T_2 = $signed(_Bi_3_0) - $signed(_Bi_3_2); // @[calc8x8.scala 102:32]
  wire [17:0] ___Bi_3_3_T_5 = $signed(___Bi_3_3_T_2) + $signed(_B_3_1); // @[calc8x8.scala 102:42]
  wire [17:0] ___Bi_3_4_T_5 = $signed(___Bi_3_3_T_2) - $signed(_B_3_1); // @[calc8x8.scala 103:42]
  wire [17:0] ___B_5_1_T_2 = $signed(_B_5_0) + $signed(_B_5_1); // @[calc8x8.scala 94:30]
  wire [17:0] ___B_5_1_T_5 = $signed(___B_5_1_T_2) + $signed(_B_5_2); // @[calc8x8.scala 94:39]
  wire [17:0] ___B_5_2_T_2 = $signed(_B_5_0) - $signed(_B_5_1); // @[calc8x8.scala 95:30]
  wire [17:0] ___B_5_2_T_5 = $signed(___B_5_2_T_2) + $signed(_B_5_2); // @[calc8x8.scala 95:39]
  wire [17:0] ___B_5_3_T_2 = $signed(_B_5_0) - $signed(_B_5_2); // @[calc8x8.scala 96:30]
  wire [17:0] ___B_5_3_T_5 = $signed(___B_5_3_T_2) - 18'sh0; // @[calc8x8.scala 96:39]
  wire [18:0] ___Bi_5_3_T_3 = {{1{_B_5_1[17]}},_B_5_1}; // @[calc8x8.scala 102:42]
  wire [17:0] ___Bi_5_3_T_5 = ___Bi_5_3_T_3[17:0]; // @[calc8x8.scala 102:42]
  wire [18:0] _conv_weight_real_0_T_8 = __B_0_0[18] & ~__B_0_0[17] ? $signed(-19'sh20000) : $signed(__B_0_0); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_0_T_9 = ~__B_0_0[18] & __B_0_0[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_0_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_1_T_8 = __B_0_1[18] & ~__B_0_1[17] ? $signed(-19'sh20000) : $signed(__B_0_1); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_1_T_9 = ~__B_0_1[18] & __B_0_1[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_1_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_2_T_8 = __B_0_2[18] & ~__B_0_2[17] ? $signed(-19'sh20000) : $signed(__B_0_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_2_T_9 = ~__B_0_2[18] & __B_0_2[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_2_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp1_0_T_2 = $signed(__B_0_3) + $signed(__Bi_0_3); // @[calc8x8.scala 127:59]
  wire [18:0] _conv_weight_comp1_0_T_11 = _conv_weight_comp1_0_T_2[18] & ~_conv_weight_comp1_0_T_2[17] ? $signed(-19'sh20000
    ) : $signed(_conv_weight_comp1_0_T_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp1_0_T_12 = ~_conv_weight_comp1_0_T_2[18] & _conv_weight_comp1_0_T_2[17] ? $signed(19'sh1ffff
    ) : $signed(_conv_weight_comp1_0_T_11); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp2_0_T_8 = __B_0_3[18] & ~__B_0_3[17] ? $signed(-19'sh20000) : $signed(__B_0_3); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp2_0_T_9 = ~__B_0_3[18] & __B_0_3[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp2_0_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp3_0_T_8 = __Bi_0_3[18] & ~__Bi_0_3[17] ? $signed(-19'sh20000) : $signed(__Bi_0_3); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp3_0_T_9 = ~__Bi_0_3[18] & __Bi_0_3[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp3_0_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_3_T_8 = __B_0_5[18] & ~__B_0_5[17] ? $signed(-19'sh20000) : $signed(__B_0_5); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_3_T_9 = ~__B_0_5[18] & __B_0_5[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_3_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_4_T_8 = __B_1_0[18] & ~__B_1_0[17] ? $signed(-19'sh20000) : $signed(__B_1_0); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_4_T_9 = ~__B_1_0[18] & __B_1_0[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_4_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_5_T_8 = __B_1_1[18] & ~__B_1_1[17] ? $signed(-19'sh20000) : $signed(__B_1_1); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_5_T_9 = ~__B_1_1[18] & __B_1_1[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_5_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_6_T_8 = __B_1_2[18] & ~__B_1_2[17] ? $signed(-19'sh20000) : $signed(__B_1_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_6_T_9 = ~__B_1_2[18] & __B_1_2[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_6_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp1_1_T_2 = $signed(__B_1_3) + $signed(__Bi_1_3); // @[calc8x8.scala 127:59]
  wire [18:0] _conv_weight_comp1_1_T_11 = _conv_weight_comp1_1_T_2[18] & ~_conv_weight_comp1_1_T_2[17] ? $signed(-19'sh20000
    ) : $signed(_conv_weight_comp1_1_T_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp1_1_T_12 = ~_conv_weight_comp1_1_T_2[18] & _conv_weight_comp1_1_T_2[17] ? $signed(19'sh1ffff
    ) : $signed(_conv_weight_comp1_1_T_11); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp2_1_T_8 = __B_1_3[18] & ~__B_1_3[17] ? $signed(-19'sh20000) : $signed(__B_1_3); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp2_1_T_9 = ~__B_1_3[18] & __B_1_3[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp2_1_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp3_1_T_8 = __Bi_1_3[18] & ~__Bi_1_3[17] ? $signed(-19'sh20000) : $signed(__Bi_1_3); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp3_1_T_9 = ~__Bi_1_3[18] & __Bi_1_3[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp3_1_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_7_T_8 = __B_1_5[18] & ~__B_1_5[17] ? $signed(-19'sh20000) : $signed(__B_1_5); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_7_T_9 = ~__B_1_5[18] & __B_1_5[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_7_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_8_T_8 = __B_2_0[18] & ~__B_2_0[17] ? $signed(-19'sh20000) : $signed(__B_2_0); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_8_T_9 = ~__B_2_0[18] & __B_2_0[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_8_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_9_T_8 = __B_2_1[18] & ~__B_2_1[17] ? $signed(-19'sh20000) : $signed(__B_2_1); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_9_T_9 = ~__B_2_1[18] & __B_2_1[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_9_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_10_T_8 = __B_2_2[18] & ~__B_2_2[17] ? $signed(-19'sh20000) : $signed(__B_2_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_10_T_9 = ~__B_2_2[18] & __B_2_2[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_10_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp1_2_T_2 = $signed(__B_2_3) + $signed(__Bi_2_3); // @[calc8x8.scala 127:59]
  wire [18:0] _conv_weight_comp1_2_T_11 = _conv_weight_comp1_2_T_2[18] & ~_conv_weight_comp1_2_T_2[17] ? $signed(-19'sh20000
    ) : $signed(_conv_weight_comp1_2_T_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp1_2_T_12 = ~_conv_weight_comp1_2_T_2[18] & _conv_weight_comp1_2_T_2[17] ? $signed(19'sh1ffff
    ) : $signed(_conv_weight_comp1_2_T_11); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp2_2_T_8 = __B_2_3[18] & ~__B_2_3[17] ? $signed(-19'sh20000) : $signed(__B_2_3); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp2_2_T_9 = ~__B_2_3[18] & __B_2_3[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp2_2_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp3_2_T_8 = __Bi_2_3[18] & ~__Bi_2_3[17] ? $signed(-19'sh20000) : $signed(__Bi_2_3); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp3_2_T_9 = ~__Bi_2_3[18] & __Bi_2_3[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp3_2_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_11_T_8 = __B_2_5[18] & ~__B_2_5[17] ? $signed(-19'sh20000) : $signed(__B_2_5); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_11_T_9 = ~__B_2_5[18] & __B_2_5[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_11_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp1_3_T_2 = $signed(__B_3_0) + $signed(__Bi_3_0); // @[calc8x8.scala 122:59]
  wire [18:0] _conv_weight_comp1_3_T_11 = _conv_weight_comp1_3_T_2[18] & ~_conv_weight_comp1_3_T_2[17] ? $signed(-19'sh20000
    ) : $signed(_conv_weight_comp1_3_T_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp1_3_T_12 = ~_conv_weight_comp1_3_T_2[18] & _conv_weight_comp1_3_T_2[17] ? $signed(19'sh1ffff
    ) : $signed(_conv_weight_comp1_3_T_11); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp2_3_T_8 = __B_3_0[18] & ~__B_3_0[17] ? $signed(-19'sh20000) : $signed(__B_3_0); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp2_3_T_9 = ~__B_3_0[18] & __B_3_0[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp2_3_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp3_3_T_8 = __Bi_3_0[18] & ~__Bi_3_0[17] ? $signed(-19'sh20000) : $signed(__Bi_3_0); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp3_3_T_9 = ~__Bi_3_0[18] & __Bi_3_0[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp3_3_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp1_4_T_2 = $signed(__B_3_1) + $signed(__Bi_3_1); // @[calc8x8.scala 122:59]
  wire [18:0] _conv_weight_comp1_4_T_11 = _conv_weight_comp1_4_T_2[18] & ~_conv_weight_comp1_4_T_2[17] ? $signed(-19'sh20000
    ) : $signed(_conv_weight_comp1_4_T_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp1_4_T_12 = ~_conv_weight_comp1_4_T_2[18] & _conv_weight_comp1_4_T_2[17] ? $signed(19'sh1ffff
    ) : $signed(_conv_weight_comp1_4_T_11); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp2_4_T_8 = __B_3_1[18] & ~__B_3_1[17] ? $signed(-19'sh20000) : $signed(__B_3_1); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp2_4_T_9 = ~__B_3_1[18] & __B_3_1[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp2_4_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp3_4_T_8 = __Bi_3_1[18] & ~__Bi_3_1[17] ? $signed(-19'sh20000) : $signed(__Bi_3_1); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp3_4_T_9 = ~__Bi_3_1[18] & __Bi_3_1[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp3_4_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp1_5_T_2 = $signed(__B_3_2) + $signed(__Bi_3_2); // @[calc8x8.scala 122:59]
  wire [18:0] _conv_weight_comp1_5_T_11 = _conv_weight_comp1_5_T_2[18] & ~_conv_weight_comp1_5_T_2[17] ? $signed(-19'sh20000
    ) : $signed(_conv_weight_comp1_5_T_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp1_5_T_12 = ~_conv_weight_comp1_5_T_2[18] & _conv_weight_comp1_5_T_2[17] ? $signed(19'sh1ffff
    ) : $signed(_conv_weight_comp1_5_T_11); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp2_5_T_8 = __B_3_2[18] & ~__B_3_2[17] ? $signed(-19'sh20000) : $signed(__B_3_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp2_5_T_9 = ~__B_3_2[18] & __B_3_2[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp2_5_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp3_5_T_8 = __Bi_3_2[18] & ~__Bi_3_2[17] ? $signed(-19'sh20000) : $signed(__Bi_3_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp3_5_T_9 = ~__Bi_3_2[18] & __Bi_3_2[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp3_5_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp1_6_T_2 = $signed(__B_3_3) + $signed(__Bi_3_3); // @[calc8x8.scala 122:59]
  wire [18:0] _conv_weight_comp1_6_T_11 = _conv_weight_comp1_6_T_2[18] & ~_conv_weight_comp1_6_T_2[17] ? $signed(-19'sh20000
    ) : $signed(_conv_weight_comp1_6_T_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp1_6_T_12 = ~_conv_weight_comp1_6_T_2[18] & _conv_weight_comp1_6_T_2[17] ? $signed(19'sh1ffff
    ) : $signed(_conv_weight_comp1_6_T_11); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp2_6_T_8 = __B_3_3[18] & ~__B_3_3[17] ? $signed(-19'sh20000) : $signed(__B_3_3); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp2_6_T_9 = ~__B_3_3[18] & __B_3_3[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp2_6_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp3_6_T_8 = __Bi_3_3[18] & ~__Bi_3_3[17] ? $signed(-19'sh20000) : $signed(__Bi_3_3); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp3_6_T_9 = ~__Bi_3_3[18] & __Bi_3_3[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp3_6_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp1_7_T_2 = $signed(__B_3_4) + $signed(__Bi_3_4); // @[calc8x8.scala 122:59]
  wire [18:0] _conv_weight_comp1_7_T_11 = _conv_weight_comp1_7_T_2[18] & ~_conv_weight_comp1_7_T_2[17] ? $signed(-19'sh20000
    ) : $signed(_conv_weight_comp1_7_T_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp1_7_T_12 = ~_conv_weight_comp1_7_T_2[18] & _conv_weight_comp1_7_T_2[17] ? $signed(19'sh1ffff
    ) : $signed(_conv_weight_comp1_7_T_11); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp2_7_T_8 = __B_3_4[18] & ~__B_3_4[17] ? $signed(-19'sh20000) : $signed(__B_3_4); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp2_7_T_9 = ~__B_3_4[18] & __B_3_4[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp2_7_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp3_7_T_8 = __Bi_3_4[18] & ~__Bi_3_4[17] ? $signed(-19'sh20000) : $signed(__Bi_3_4); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp3_7_T_9 = ~__Bi_3_4[18] & __Bi_3_4[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp3_7_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp1_8_T_2 = $signed(__B_3_5) + $signed(__Bi_3_5); // @[calc8x8.scala 122:59]
  wire [18:0] _conv_weight_comp1_8_T_11 = _conv_weight_comp1_8_T_2[18] & ~_conv_weight_comp1_8_T_2[17] ? $signed(-19'sh20000
    ) : $signed(_conv_weight_comp1_8_T_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp1_8_T_12 = ~_conv_weight_comp1_8_T_2[18] & _conv_weight_comp1_8_T_2[17] ? $signed(19'sh1ffff
    ) : $signed(_conv_weight_comp1_8_T_11); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp2_8_T_8 = __B_3_5[18] & ~__B_3_5[17] ? $signed(-19'sh20000) : $signed(__B_3_5); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp2_8_T_9 = ~__B_3_5[18] & __B_3_5[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp2_8_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp3_8_T_8 = __Bi_3_5[18] & ~__Bi_3_5[17] ? $signed(-19'sh20000) : $signed(__Bi_3_5); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp3_8_T_9 = ~__Bi_3_5[18] & __Bi_3_5[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp3_8_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_12_T_8 = __B_5_0[18] & ~__B_5_0[17] ? $signed(-19'sh20000) : $signed(__B_5_0); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_12_T_9 = ~__B_5_0[18] & __B_5_0[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_12_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_13_T_8 = __B_5_1[18] & ~__B_5_1[17] ? $signed(-19'sh20000) : $signed(__B_5_1); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_13_T_9 = ~__B_5_1[18] & __B_5_1[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_13_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_14_T_8 = __B_5_2[18] & ~__B_5_2[17] ? $signed(-19'sh20000) : $signed(__B_5_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_14_T_9 = ~__B_5_2[18] & __B_5_2[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_14_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp1_9_T_2 = $signed(__B_5_3) + $signed(__Bi_5_3); // @[calc8x8.scala 127:59]
  wire [18:0] _conv_weight_comp1_9_T_11 = _conv_weight_comp1_9_T_2[18] & ~_conv_weight_comp1_9_T_2[17] ? $signed(-19'sh20000
    ) : $signed(_conv_weight_comp1_9_T_2); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp1_9_T_12 = ~_conv_weight_comp1_9_T_2[18] & _conv_weight_comp1_9_T_2[17] ? $signed(19'sh1ffff
    ) : $signed(_conv_weight_comp1_9_T_11); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp2_9_T_8 = __B_5_3[18] & ~__B_5_3[17] ? $signed(-19'sh20000) : $signed(__B_5_3); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp2_9_T_9 = ~__B_5_3[18] & __B_5_3[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp2_9_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_comp3_9_T_8 = __Bi_5_3[18] & ~__Bi_5_3[17] ? $signed(-19'sh20000) : $signed(__Bi_5_3); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_comp3_9_T_9 = ~__Bi_5_3[18] & __Bi_5_3[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_comp3_9_T_8); // @[calc8x8.scala 111:19]
  wire [18:0] _conv_weight_real_15_T_8 = __B_5_5[18] & ~__B_5_5[17] ? $signed(-19'sh20000) : $signed(__B_5_5); // @[calc8x8.scala 111:61]
  wire [18:0] _conv_weight_real_15_T_9 = ~__B_5_5[18] & __B_5_5[17] ? $signed(19'sh1ffff) : $signed(
    _conv_weight_real_15_T_8); // @[calc8x8.scala 111:19]
  wire  _T_2 = 2'h0 == io_flag; // @[Conditional.scala 37:30]
  wire  _T_5 = 2'h1 == io_flag; // @[Conditional.scala 37:30]
  wire  _T_8 = 2'h2 == io_flag; // @[Conditional.scala 37:30]
  wire [15:0] _GEN_0 = _T_8 ? $signed(io_input_up_0) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_1 = _T_8 ? $signed(io_input_up_1) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_2 = _T_8 ? $signed(io_input_up_2) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_3 = _T_8 ? $signed(io_input_up_3) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_4 = _T_8 ? $signed(io_input_up_4) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_5 = _T_8 ? $signed(io_input_up_5) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_6 = _T_8 ? $signed(io_input_left_0) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_7 = _T_8 ? $signed(io_input_mat_0) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_8 = _T_8 ? $signed(io_input_mat_1) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_9 = _T_8 ? $signed(io_input_mat_2) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_10 = _T_8 ? $signed(io_input_mat_3) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_11 = _T_8 ? $signed(io_input_mat_4) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_12 = _T_8 ? $signed(io_input_left_1) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_13 = _T_8 ? $signed(io_input_mat_8) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_14 = _T_8 ? $signed(io_input_mat_9) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_15 = _T_8 ? $signed(io_input_mat_10) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_16 = _T_8 ? $signed(io_input_mat_11) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_17 = _T_8 ? $signed(io_input_mat_12) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_18 = _T_8 ? $signed(io_input_left_2) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_19 = _T_8 ? $signed(io_input_mat_16) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_20 = _T_8 ? $signed(io_input_mat_17) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_21 = _T_8 ? $signed(io_input_mat_18) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_22 = _T_8 ? $signed(io_input_mat_19) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_23 = _T_8 ? $signed(io_input_mat_20) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_24 = _T_8 ? $signed(io_input_left_3) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_25 = _T_8 ? $signed(io_input_mat_24) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_26 = _T_8 ? $signed(io_input_mat_25) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_27 = _T_8 ? $signed(io_input_mat_26) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_28 = _T_8 ? $signed(io_input_mat_27) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_29 = _T_8 ? $signed(io_input_mat_28) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_30 = _T_8 ? $signed(io_input_left_4) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_31 = _T_8 ? $signed(io_input_mat_32) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_32 = _T_8 ? $signed(io_input_mat_33) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_33 = _T_8 ? $signed(io_input_mat_34) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_34 = _T_8 ? $signed(io_input_mat_35) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_35 = _T_8 ? $signed(io_input_mat_36) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 163:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_38 = _T_8 ? $signed(io_input_up_6) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_39 = _T_8 ? $signed(io_input_up_7) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_40 = _T_8 ? $signed(io_input_up_8) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_41 = _T_8 ? $signed(io_input_up_9) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_44 = _T_8 ? $signed(io_input_mat_5) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_45 = _T_8 ? $signed(io_input_mat_6) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_46 = _T_8 ? $signed(io_input_mat_7) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_47 = _T_8 ? $signed(io_input_right_0) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_50 = _T_8 ? $signed(io_input_mat_13) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_51 = _T_8 ? $signed(io_input_mat_14) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_52 = _T_8 ? $signed(io_input_mat_15) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_53 = _T_8 ? $signed(io_input_right_1) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_56 = _T_8 ? $signed(io_input_mat_21) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_57 = _T_8 ? $signed(io_input_mat_22) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_58 = _T_8 ? $signed(io_input_mat_23) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_59 = _T_8 ? $signed(io_input_right_2) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_62 = _T_8 ? $signed(io_input_mat_29) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_63 = _T_8 ? $signed(io_input_mat_30) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_64 = _T_8 ? $signed(io_input_mat_31) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_65 = _T_8 ? $signed(io_input_right_3) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_68 = _T_8 ? $signed(io_input_mat_37) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_69 = _T_8 ? $signed(io_input_mat_38) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_70 = _T_8 ? $signed(io_input_mat_39) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_71 = _T_8 ? $signed(io_input_right_4) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 164:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_84 = _T_8 ? $signed(io_input_left_5) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_85 = _T_8 ? $signed(io_input_mat_40) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_86 = _T_8 ? $signed(io_input_mat_41) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_87 = _T_8 ? $signed(io_input_mat_42) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_88 = _T_8 ? $signed(io_input_mat_43) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_89 = _T_8 ? $signed(io_input_mat_44) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_90 = _T_8 ? $signed(io_input_left_6) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_91 = _T_8 ? $signed(io_input_mat_48) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_92 = _T_8 ? $signed(io_input_mat_49) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_93 = _T_8 ? $signed(io_input_mat_50) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_94 = _T_8 ? $signed(io_input_mat_51) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_95 = _T_8 ? $signed(io_input_mat_52) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_96 = _T_8 ? $signed(io_input_left_7) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_97 = _T_8 ? $signed(io_input_mat_56) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_98 = _T_8 ? $signed(io_input_mat_57) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_99 = _T_8 ? $signed(io_input_mat_58) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_100 = _T_8 ? $signed(io_input_mat_59) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_101 = _T_8 ? $signed(io_input_mat_60) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_102 = _T_8 ? $signed(io_input_down_0) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_103 = _T_8 ? $signed(io_input_down_1) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_104 = _T_8 ? $signed(io_input_down_2) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_105 = _T_8 ? $signed(io_input_down_3) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_106 = _T_8 ? $signed(io_input_down_4) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_107 = _T_8 ? $signed(io_input_down_5) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 165:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_122 = _T_8 ? $signed(io_input_mat_45) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_123 = _T_8 ? $signed(io_input_mat_46) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_124 = _T_8 ? $signed(io_input_mat_47) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_125 = _T_8 ? $signed(io_input_right_5) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_128 = _T_8 ? $signed(io_input_mat_53) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_129 = _T_8 ? $signed(io_input_mat_54) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_130 = _T_8 ? $signed(io_input_mat_55) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_131 = _T_8 ? $signed(io_input_right_6) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_134 = _T_8 ? $signed(io_input_mat_61) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_135 = _T_8 ? $signed(io_input_mat_62) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_136 = _T_8 ? $signed(io_input_mat_63) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_137 = _T_8 ? $signed(io_input_right_7) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_140 = _T_8 ? $signed(io_input_down_6) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_141 = _T_8 ? $signed(io_input_down_7) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_142 = _T_8 ? $signed(io_input_down_8) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [15:0] _GEN_143 = _T_8 ? $signed(io_input_down_9) : $signed(16'sh0); // @[Conditional.scala 39:67 calc8x8.scala 166:24 calc8x8.scala 61:20]
  wire [17:0] conv_weight_comp3_0 = _conv_weight_comp3_0_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 129:38]
  wire [17:0] _GEN_144 = _T_8 ? $signed(conv_weight_comp3_0) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp3_1 = _conv_weight_comp3_1_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 129:38]
  wire [17:0] _GEN_145 = _T_8 ? $signed(conv_weight_comp3_1) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp3_2 = _conv_weight_comp3_2_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 129:38]
  wire [17:0] _GEN_146 = _T_8 ? $signed(conv_weight_comp3_2) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp3_3 = _conv_weight_comp3_3_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 124:38]
  wire [17:0] _GEN_147 = _T_8 ? $signed(conv_weight_comp3_3) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp3_4 = _conv_weight_comp3_4_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 124:38]
  wire [17:0] _GEN_148 = _T_8 ? $signed(conv_weight_comp3_4) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp3_5 = _conv_weight_comp3_5_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 124:38]
  wire [17:0] _GEN_149 = _T_8 ? $signed(conv_weight_comp3_5) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp3_6 = _conv_weight_comp3_6_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 124:38]
  wire [17:0] _GEN_150 = _T_8 ? $signed(conv_weight_comp3_6) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp3_7 = _conv_weight_comp3_7_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 124:38]
  wire [17:0] _GEN_151 = _T_8 ? $signed(conv_weight_comp3_7) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp3_8 = _conv_weight_comp3_8_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 124:38]
  wire [17:0] _GEN_152 = _T_8 ? $signed(conv_weight_comp3_8) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp3_9 = _conv_weight_comp3_9_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 129:38]
  wire [17:0] _GEN_153 = _T_8 ? $signed(conv_weight_comp3_9) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp2_0 = _conv_weight_comp2_0_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 128:38]
  wire [17:0] _GEN_154 = _T_8 ? $signed(conv_weight_comp2_0) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp2_1 = _conv_weight_comp2_1_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 128:38]
  wire [17:0] _GEN_155 = _T_8 ? $signed(conv_weight_comp2_1) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp2_2 = _conv_weight_comp2_2_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 128:38]
  wire [17:0] _GEN_156 = _T_8 ? $signed(conv_weight_comp2_2) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp2_3 = _conv_weight_comp2_3_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 123:38]
  wire [17:0] _GEN_157 = _T_8 ? $signed(conv_weight_comp2_3) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp2_4 = _conv_weight_comp2_4_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 123:38]
  wire [17:0] _GEN_158 = _T_8 ? $signed(conv_weight_comp2_4) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp2_5 = _conv_weight_comp2_5_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 123:38]
  wire [17:0] _GEN_159 = _T_8 ? $signed(conv_weight_comp2_5) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp2_6 = _conv_weight_comp2_6_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 123:38]
  wire [17:0] _GEN_160 = _T_8 ? $signed(conv_weight_comp2_6) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp2_7 = _conv_weight_comp2_7_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 123:38]
  wire [17:0] _GEN_161 = _T_8 ? $signed(conv_weight_comp2_7) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp2_8 = _conv_weight_comp2_8_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 123:38]
  wire [17:0] _GEN_162 = _T_8 ? $signed(conv_weight_comp2_8) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp2_9 = _conv_weight_comp2_9_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 128:38]
  wire [17:0] _GEN_163 = _T_8 ? $signed(conv_weight_comp2_9) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp1_0 = _conv_weight_comp1_0_T_12[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 127:38]
  wire [17:0] _GEN_164 = _T_8 ? $signed(conv_weight_comp1_0) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp1_1 = _conv_weight_comp1_1_T_12[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 127:38]
  wire [17:0] _GEN_165 = _T_8 ? $signed(conv_weight_comp1_1) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp1_2 = _conv_weight_comp1_2_T_12[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 127:38]
  wire [17:0] _GEN_166 = _T_8 ? $signed(conv_weight_comp1_2) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp1_3 = _conv_weight_comp1_3_T_12[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 122:38]
  wire [17:0] _GEN_167 = _T_8 ? $signed(conv_weight_comp1_3) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp1_4 = _conv_weight_comp1_4_T_12[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 122:38]
  wire [17:0] _GEN_168 = _T_8 ? $signed(conv_weight_comp1_4) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp1_5 = _conv_weight_comp1_5_T_12[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 122:38]
  wire [17:0] _GEN_169 = _T_8 ? $signed(conv_weight_comp1_5) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp1_6 = _conv_weight_comp1_6_T_12[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 122:38]
  wire [17:0] _GEN_170 = _T_8 ? $signed(conv_weight_comp1_6) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp1_7 = _conv_weight_comp1_7_T_12[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 122:38]
  wire [17:0] _GEN_171 = _T_8 ? $signed(conv_weight_comp1_7) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp1_8 = _conv_weight_comp1_8_T_12[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 122:38]
  wire [17:0] _GEN_172 = _T_8 ? $signed(conv_weight_comp1_8) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_comp1_9 = _conv_weight_comp1_9_T_12[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 127:38]
  wire [17:0] _GEN_173 = _T_8 ? $signed(conv_weight_comp1_9) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_0 = _conv_weight_real_0_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_174 = _T_8 ? $signed(conv_weight_real_0) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_1 = _conv_weight_real_1_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_175 = _T_8 ? $signed(conv_weight_real_1) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_2 = _conv_weight_real_2_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_176 = _T_8 ? $signed(conv_weight_real_2) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_3 = _conv_weight_real_3_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_177 = _T_8 ? $signed(conv_weight_real_3) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_4 = _conv_weight_real_4_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_178 = _T_8 ? $signed(conv_weight_real_4) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_5 = _conv_weight_real_5_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_179 = _T_8 ? $signed(conv_weight_real_5) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_6 = _conv_weight_real_6_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_180 = _T_8 ? $signed(conv_weight_real_6) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_7 = _conv_weight_real_7_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_181 = _T_8 ? $signed(conv_weight_real_7) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_8 = _conv_weight_real_8_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_182 = _T_8 ? $signed(conv_weight_real_8) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_9 = _conv_weight_real_9_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_183 = _T_8 ? $signed(conv_weight_real_9) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_10 = _conv_weight_real_10_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_184 = _T_8 ? $signed(conv_weight_real_10) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_11 = _conv_weight_real_11_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_185 = _T_8 ? $signed(conv_weight_real_11) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_12 = _conv_weight_real_12_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_186 = _T_8 ? $signed(conv_weight_real_12) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_13 = _conv_weight_real_13_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_187 = _T_8 ? $signed(conv_weight_real_13) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_14 = _conv_weight_real_14_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_188 = _T_8 ? $signed(conv_weight_real_14) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [17:0] conv_weight_real_15 = _conv_weight_real_15_T_9[17:0]; // @[calc8x8.scala 107:27 calc8x8.scala 119:37]
  wire [17:0] _GEN_189 = _T_8 ? $signed(conv_weight_real_15) : $signed(18'sh0); // @[Conditional.scala 39:67 calc8x8.scala 168:29 calc8x8.scala 63:21]
  wire [1:0] _GEN_190 = _T_8 ? 2'h2 : 2'h0; // @[Conditional.scala 39:67 calc8x8.scala 169:27 calc8x8.scala 62:19]
  wire  _GEN_191 = _T_8 & io_valid_in; // @[Conditional.scala 39:67 calc8x8.scala 170:31 calc8x8.scala 64:23]
  wire [36:0] A_0_output_mat_0 = Calc6x6_io_output_mat_0; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_333 = _T_8 ? $signed(A_0_output_mat_0) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_1 = Calc6x6_io_output_mat_1; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_334 = _T_8 ? $signed(A_0_output_mat_1) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_2 = Calc6x6_io_output_mat_2; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_335 = _T_8 ? $signed(A_0_output_mat_2) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_3 = Calc6x6_io_output_mat_3; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_336 = _T_8 ? $signed(A_0_output_mat_3) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_0 = Calc6x6_1_io_output_mat_0; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_337 = _T_8 ? $signed(A_1_output_mat_0) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_1 = Calc6x6_1_io_output_mat_1; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_338 = _T_8 ? $signed(A_1_output_mat_1) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_2 = Calc6x6_1_io_output_mat_2; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_339 = _T_8 ? $signed(A_1_output_mat_2) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_3 = Calc6x6_1_io_output_mat_3; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_340 = _T_8 ? $signed(A_1_output_mat_3) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_4 = Calc6x6_io_output_mat_4; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_341 = _T_8 ? $signed(A_0_output_mat_4) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_5 = Calc6x6_io_output_mat_5; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_342 = _T_8 ? $signed(A_0_output_mat_5) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_6 = Calc6x6_io_output_mat_6; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_343 = _T_8 ? $signed(A_0_output_mat_6) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_7 = Calc6x6_io_output_mat_7; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_344 = _T_8 ? $signed(A_0_output_mat_7) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_4 = Calc6x6_1_io_output_mat_4; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_345 = _T_8 ? $signed(A_1_output_mat_4) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_5 = Calc6x6_1_io_output_mat_5; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_346 = _T_8 ? $signed(A_1_output_mat_5) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_6 = Calc6x6_1_io_output_mat_6; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_347 = _T_8 ? $signed(A_1_output_mat_6) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_7 = Calc6x6_1_io_output_mat_7; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_348 = _T_8 ? $signed(A_1_output_mat_7) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_8 = Calc6x6_io_output_mat_8; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_349 = _T_8 ? $signed(A_0_output_mat_8) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_9 = Calc6x6_io_output_mat_9; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_350 = _T_8 ? $signed(A_0_output_mat_9) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_10 = Calc6x6_io_output_mat_10; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_351 = _T_8 ? $signed(A_0_output_mat_10) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_11 = Calc6x6_io_output_mat_11; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_352 = _T_8 ? $signed(A_0_output_mat_11) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_8 = Calc6x6_1_io_output_mat_8; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_353 = _T_8 ? $signed(A_1_output_mat_8) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_9 = Calc6x6_1_io_output_mat_9; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_354 = _T_8 ? $signed(A_1_output_mat_9) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_10 = Calc6x6_1_io_output_mat_10; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_355 = _T_8 ? $signed(A_1_output_mat_10) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_11 = Calc6x6_1_io_output_mat_11; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_356 = _T_8 ? $signed(A_1_output_mat_11) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_12 = Calc6x6_io_output_mat_12; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_357 = _T_8 ? $signed(A_0_output_mat_12) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_13 = Calc6x6_io_output_mat_13; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_358 = _T_8 ? $signed(A_0_output_mat_13) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_14 = Calc6x6_io_output_mat_14; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_359 = _T_8 ? $signed(A_0_output_mat_14) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_0_output_mat_15 = Calc6x6_io_output_mat_15; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_360 = _T_8 ? $signed(A_0_output_mat_15) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_12 = Calc6x6_1_io_output_mat_12; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_361 = _T_8 ? $signed(A_1_output_mat_12) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_13 = Calc6x6_1_io_output_mat_13; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_362 = _T_8 ? $signed(A_1_output_mat_13) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_14 = Calc6x6_1_io_output_mat_14; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_363 = _T_8 ? $signed(A_1_output_mat_14) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_1_output_mat_15 = Calc6x6_1_io_output_mat_15; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_364 = _T_8 ? $signed(A_1_output_mat_15) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_0 = Calc6x6_2_io_output_mat_0; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_365 = _T_8 ? $signed(A_2_output_mat_0) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_1 = Calc6x6_2_io_output_mat_1; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_366 = _T_8 ? $signed(A_2_output_mat_1) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_2 = Calc6x6_2_io_output_mat_2; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_367 = _T_8 ? $signed(A_2_output_mat_2) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_3 = Calc6x6_2_io_output_mat_3; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_368 = _T_8 ? $signed(A_2_output_mat_3) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_0 = Calc6x6_3_io_output_mat_0; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_369 = _T_8 ? $signed(A_3_output_mat_0) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_1 = Calc6x6_3_io_output_mat_1; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_370 = _T_8 ? $signed(A_3_output_mat_1) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_2 = Calc6x6_3_io_output_mat_2; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_371 = _T_8 ? $signed(A_3_output_mat_2) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_3 = Calc6x6_3_io_output_mat_3; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_372 = _T_8 ? $signed(A_3_output_mat_3) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_4 = Calc6x6_2_io_output_mat_4; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_373 = _T_8 ? $signed(A_2_output_mat_4) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_5 = Calc6x6_2_io_output_mat_5; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_374 = _T_8 ? $signed(A_2_output_mat_5) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_6 = Calc6x6_2_io_output_mat_6; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_375 = _T_8 ? $signed(A_2_output_mat_6) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_7 = Calc6x6_2_io_output_mat_7; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_376 = _T_8 ? $signed(A_2_output_mat_7) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_4 = Calc6x6_3_io_output_mat_4; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_377 = _T_8 ? $signed(A_3_output_mat_4) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_5 = Calc6x6_3_io_output_mat_5; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_378 = _T_8 ? $signed(A_3_output_mat_5) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_6 = Calc6x6_3_io_output_mat_6; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_379 = _T_8 ? $signed(A_3_output_mat_6) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_7 = Calc6x6_3_io_output_mat_7; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_380 = _T_8 ? $signed(A_3_output_mat_7) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_8 = Calc6x6_2_io_output_mat_8; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_381 = _T_8 ? $signed(A_2_output_mat_8) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_9 = Calc6x6_2_io_output_mat_9; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_382 = _T_8 ? $signed(A_2_output_mat_9) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_10 = Calc6x6_2_io_output_mat_10; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_383 = _T_8 ? $signed(A_2_output_mat_10) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_11 = Calc6x6_2_io_output_mat_11; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_384 = _T_8 ? $signed(A_2_output_mat_11) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_8 = Calc6x6_3_io_output_mat_8; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_385 = _T_8 ? $signed(A_3_output_mat_8) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_9 = Calc6x6_3_io_output_mat_9; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_386 = _T_8 ? $signed(A_3_output_mat_9) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_10 = Calc6x6_3_io_output_mat_10; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_387 = _T_8 ? $signed(A_3_output_mat_10) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_11 = Calc6x6_3_io_output_mat_11; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_388 = _T_8 ? $signed(A_3_output_mat_11) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_12 = Calc6x6_2_io_output_mat_12; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_389 = _T_8 ? $signed(A_2_output_mat_12) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_13 = Calc6x6_2_io_output_mat_13; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_390 = _T_8 ? $signed(A_2_output_mat_13) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_14 = Calc6x6_2_io_output_mat_14; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_391 = _T_8 ? $signed(A_2_output_mat_14) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_2_output_mat_15 = Calc6x6_2_io_output_mat_15; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_392 = _T_8 ? $signed(A_2_output_mat_15) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_12 = Calc6x6_3_io_output_mat_12; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_393 = _T_8 ? $signed(A_3_output_mat_12) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_13 = Calc6x6_3_io_output_mat_13; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_394 = _T_8 ? $signed(A_3_output_mat_13) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_14 = Calc6x6_3_io_output_mat_14; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_395 = _T_8 ? $signed(A_3_output_mat_14) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire [36:0] A_3_output_mat_15 = Calc6x6_3_io_output_mat_15; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire [36:0] _GEN_396 = _T_8 ? $signed(A_3_output_mat_15) : $signed(37'sh0); // @[Conditional.scala 39:67 calc8x8.scala 172:23 calc8x8.scala 67:15]
  wire  A_0_valid_out = Calc6x6_io_valid_out; // @[calc8x8.scala 59:20 calc8x8.scala 59:20]
  wire  _GEN_397 = _T_8 & A_0_valid_out; // @[Conditional.scala 39:67 calc8x8.scala 173:26 calc8x8.scala 68:18]
  wire [15:0] _GEN_398 = _T_5 ? $signed(io_input_mat_0) : $signed(_GEN_0); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_399 = _T_5 ? $signed(io_input_mat_1) : $signed(_GEN_1); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_400 = _T_5 ? $signed(io_input_mat_2) : $signed(_GEN_2); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_401 = _T_5 ? $signed(io_input_mat_3) : $signed(_GEN_3); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_402 = _T_5 ? $signed(16'sh0) : $signed(_GEN_4); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_403 = _T_5 ? $signed(16'sh0) : $signed(_GEN_5); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_404 = _T_5 ? $signed(io_input_mat_8) : $signed(_GEN_6); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_405 = _T_5 ? $signed(io_input_mat_9) : $signed(_GEN_7); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_406 = _T_5 ? $signed(io_input_mat_10) : $signed(_GEN_8); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_407 = _T_5 ? $signed(io_input_mat_11) : $signed(_GEN_9); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_408 = _T_5 ? $signed(16'sh0) : $signed(_GEN_10); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_409 = _T_5 ? $signed(16'sh0) : $signed(_GEN_11); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_410 = _T_5 ? $signed(io_input_mat_16) : $signed(_GEN_12); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_411 = _T_5 ? $signed(io_input_mat_17) : $signed(_GEN_13); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_412 = _T_5 ? $signed(io_input_mat_18) : $signed(_GEN_14); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_413 = _T_5 ? $signed(io_input_mat_19) : $signed(_GEN_15); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_414 = _T_5 ? $signed(16'sh0) : $signed(_GEN_16); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_415 = _T_5 ? $signed(16'sh0) : $signed(_GEN_17); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_416 = _T_5 ? $signed(io_input_mat_24) : $signed(_GEN_18); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_417 = _T_5 ? $signed(io_input_mat_25) : $signed(_GEN_19); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_418 = _T_5 ? $signed(io_input_mat_26) : $signed(_GEN_20); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_419 = _T_5 ? $signed(io_input_mat_27) : $signed(_GEN_21); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_420 = _T_5 ? $signed(16'sh0) : $signed(_GEN_22); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_421 = _T_5 ? $signed(16'sh0) : $signed(_GEN_23); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_422 = _T_5 ? $signed(16'sh0) : $signed(_GEN_24); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_423 = _T_5 ? $signed(16'sh0) : $signed(_GEN_25); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_424 = _T_5 ? $signed(16'sh0) : $signed(_GEN_26); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_425 = _T_5 ? $signed(16'sh0) : $signed(_GEN_27); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_426 = _T_5 ? $signed(16'sh0) : $signed(_GEN_28); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_427 = _T_5 ? $signed(16'sh0) : $signed(_GEN_29); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_428 = _T_5 ? $signed(16'sh0) : $signed(_GEN_30); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_429 = _T_5 ? $signed(16'sh0) : $signed(_GEN_31); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_430 = _T_5 ? $signed(16'sh0) : $signed(_GEN_32); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_431 = _T_5 ? $signed(16'sh0) : $signed(_GEN_33); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_432 = _T_5 ? $signed(16'sh0) : $signed(_GEN_34); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_433 = _T_5 ? $signed(16'sh0) : $signed(_GEN_35); // @[Conditional.scala 39:67 calc8x8.scala 150:24]
  wire [15:0] _GEN_434 = _T_5 ? $signed(io_input_mat_3) : $signed(_GEN_4); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_435 = _T_5 ? $signed(io_input_mat_4) : $signed(_GEN_5); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_436 = _T_5 ? $signed(io_input_mat_5) : $signed(_GEN_38); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_437 = _T_5 ? $signed(io_input_mat_6) : $signed(_GEN_39); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_438 = _T_5 ? $signed(io_input_mat_7) : $signed(_GEN_40); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_439 = _T_5 ? $signed(16'sh0) : $signed(_GEN_41); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_440 = _T_5 ? $signed(io_input_mat_11) : $signed(_GEN_10); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_441 = _T_5 ? $signed(io_input_mat_12) : $signed(_GEN_11); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_442 = _T_5 ? $signed(io_input_mat_13) : $signed(_GEN_44); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_443 = _T_5 ? $signed(io_input_mat_14) : $signed(_GEN_45); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_444 = _T_5 ? $signed(io_input_mat_15) : $signed(_GEN_46); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_445 = _T_5 ? $signed(16'sh0) : $signed(_GEN_47); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_446 = _T_5 ? $signed(io_input_mat_19) : $signed(_GEN_16); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_447 = _T_5 ? $signed(io_input_mat_20) : $signed(_GEN_17); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_448 = _T_5 ? $signed(io_input_mat_21) : $signed(_GEN_50); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_449 = _T_5 ? $signed(io_input_mat_22) : $signed(_GEN_51); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_450 = _T_5 ? $signed(io_input_mat_23) : $signed(_GEN_52); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_451 = _T_5 ? $signed(16'sh0) : $signed(_GEN_53); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_452 = _T_5 ? $signed(io_input_mat_27) : $signed(_GEN_22); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_453 = _T_5 ? $signed(io_input_mat_28) : $signed(_GEN_23); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_454 = _T_5 ? $signed(io_input_mat_29) : $signed(_GEN_56); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_455 = _T_5 ? $signed(io_input_mat_30) : $signed(_GEN_57); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_456 = _T_5 ? $signed(io_input_mat_31) : $signed(_GEN_58); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_457 = _T_5 ? $signed(16'sh0) : $signed(_GEN_59); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_460 = _T_5 ? $signed(16'sh0) : $signed(_GEN_62); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_461 = _T_5 ? $signed(16'sh0) : $signed(_GEN_63); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_462 = _T_5 ? $signed(16'sh0) : $signed(_GEN_64); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_463 = _T_5 ? $signed(16'sh0) : $signed(_GEN_65); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_466 = _T_5 ? $signed(16'sh0) : $signed(_GEN_68); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_467 = _T_5 ? $signed(16'sh0) : $signed(_GEN_69); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_468 = _T_5 ? $signed(16'sh0) : $signed(_GEN_70); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_469 = _T_5 ? $signed(16'sh0) : $signed(_GEN_71); // @[Conditional.scala 39:67 calc8x8.scala 151:24]
  wire [15:0] _GEN_470 = _T_5 ? $signed(io_input_mat_24) : $signed(_GEN_24); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_471 = _T_5 ? $signed(io_input_mat_25) : $signed(_GEN_25); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_472 = _T_5 ? $signed(io_input_mat_26) : $signed(_GEN_26); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_473 = _T_5 ? $signed(io_input_mat_27) : $signed(_GEN_27); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_476 = _T_5 ? $signed(io_input_mat_32) : $signed(_GEN_30); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_477 = _T_5 ? $signed(io_input_mat_33) : $signed(_GEN_31); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_478 = _T_5 ? $signed(io_input_mat_34) : $signed(_GEN_32); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_479 = _T_5 ? $signed(io_input_mat_35) : $signed(_GEN_33); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_482 = _T_5 ? $signed(io_input_mat_40) : $signed(_GEN_84); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_483 = _T_5 ? $signed(io_input_mat_41) : $signed(_GEN_85); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_484 = _T_5 ? $signed(io_input_mat_42) : $signed(_GEN_86); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_485 = _T_5 ? $signed(io_input_mat_43) : $signed(_GEN_87); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_486 = _T_5 ? $signed(16'sh0) : $signed(_GEN_88); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_487 = _T_5 ? $signed(16'sh0) : $signed(_GEN_89); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_488 = _T_5 ? $signed(io_input_mat_48) : $signed(_GEN_90); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_489 = _T_5 ? $signed(io_input_mat_49) : $signed(_GEN_91); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_490 = _T_5 ? $signed(io_input_mat_50) : $signed(_GEN_92); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_491 = _T_5 ? $signed(io_input_mat_51) : $signed(_GEN_93); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_492 = _T_5 ? $signed(16'sh0) : $signed(_GEN_94); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_493 = _T_5 ? $signed(16'sh0) : $signed(_GEN_95); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_494 = _T_5 ? $signed(io_input_mat_56) : $signed(_GEN_96); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_495 = _T_5 ? $signed(io_input_mat_57) : $signed(_GEN_97); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_496 = _T_5 ? $signed(io_input_mat_58) : $signed(_GEN_98); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_497 = _T_5 ? $signed(io_input_mat_59) : $signed(_GEN_99); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_498 = _T_5 ? $signed(16'sh0) : $signed(_GEN_100); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_499 = _T_5 ? $signed(16'sh0) : $signed(_GEN_101); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_500 = _T_5 ? $signed(16'sh0) : $signed(_GEN_102); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_501 = _T_5 ? $signed(16'sh0) : $signed(_GEN_103); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_502 = _T_5 ? $signed(16'sh0) : $signed(_GEN_104); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_503 = _T_5 ? $signed(16'sh0) : $signed(_GEN_105); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_504 = _T_5 ? $signed(16'sh0) : $signed(_GEN_106); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_505 = _T_5 ? $signed(16'sh0) : $signed(_GEN_107); // @[Conditional.scala 39:67 calc8x8.scala 152:24]
  wire [15:0] _GEN_506 = _T_5 ? $signed(io_input_mat_27) : $signed(_GEN_28); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_507 = _T_5 ? $signed(io_input_mat_28) : $signed(_GEN_29); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_508 = _T_5 ? $signed(io_input_mat_29) : $signed(_GEN_62); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_509 = _T_5 ? $signed(io_input_mat_30) : $signed(_GEN_63); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_510 = _T_5 ? $signed(io_input_mat_31) : $signed(_GEN_64); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_512 = _T_5 ? $signed(io_input_mat_35) : $signed(_GEN_34); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_513 = _T_5 ? $signed(io_input_mat_36) : $signed(_GEN_35); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_514 = _T_5 ? $signed(io_input_mat_37) : $signed(_GEN_68); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_515 = _T_5 ? $signed(io_input_mat_38) : $signed(_GEN_69); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_516 = _T_5 ? $signed(io_input_mat_39) : $signed(_GEN_70); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_518 = _T_5 ? $signed(io_input_mat_43) : $signed(_GEN_88); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_519 = _T_5 ? $signed(io_input_mat_44) : $signed(_GEN_89); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_520 = _T_5 ? $signed(io_input_mat_45) : $signed(_GEN_122); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_521 = _T_5 ? $signed(io_input_mat_46) : $signed(_GEN_123); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_522 = _T_5 ? $signed(io_input_mat_47) : $signed(_GEN_124); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_523 = _T_5 ? $signed(16'sh0) : $signed(_GEN_125); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_524 = _T_5 ? $signed(io_input_mat_51) : $signed(_GEN_94); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_525 = _T_5 ? $signed(io_input_mat_52) : $signed(_GEN_95); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_526 = _T_5 ? $signed(io_input_mat_53) : $signed(_GEN_128); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_527 = _T_5 ? $signed(io_input_mat_54) : $signed(_GEN_129); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_528 = _T_5 ? $signed(io_input_mat_55) : $signed(_GEN_130); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_529 = _T_5 ? $signed(16'sh0) : $signed(_GEN_131); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_530 = _T_5 ? $signed(io_input_mat_59) : $signed(_GEN_100); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_531 = _T_5 ? $signed(io_input_mat_60) : $signed(_GEN_101); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_532 = _T_5 ? $signed(io_input_mat_61) : $signed(_GEN_134); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_533 = _T_5 ? $signed(io_input_mat_62) : $signed(_GEN_135); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_534 = _T_5 ? $signed(io_input_mat_63) : $signed(_GEN_136); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_535 = _T_5 ? $signed(16'sh0) : $signed(_GEN_137); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_538 = _T_5 ? $signed(16'sh0) : $signed(_GEN_140); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_539 = _T_5 ? $signed(16'sh0) : $signed(_GEN_141); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_540 = _T_5 ? $signed(16'sh0) : $signed(_GEN_142); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [15:0] _GEN_541 = _T_5 ? $signed(16'sh0) : $signed(_GEN_143); // @[Conditional.scala 39:67 calc8x8.scala 153:24]
  wire [17:0] _GEN_542 = _T_5 ? $signed({{2{io_weight_0_real_0[15]}},io_weight_0_real_0}) : $signed(_GEN_174); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_543 = _T_5 ? $signed({{2{io_weight_0_real_1[15]}},io_weight_0_real_1}) : $signed(_GEN_175); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_544 = _T_5 ? $signed({{2{io_weight_0_real_2[15]}},io_weight_0_real_2}) : $signed(_GEN_176); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_545 = _T_5 ? $signed({{2{io_weight_0_real_3[15]}},io_weight_0_real_3}) : $signed(_GEN_177); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_546 = _T_5 ? $signed({{2{io_weight_0_real_4[15]}},io_weight_0_real_4}) : $signed(_GEN_178); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_547 = _T_5 ? $signed({{2{io_weight_0_real_5[15]}},io_weight_0_real_5}) : $signed(_GEN_179); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_548 = _T_5 ? $signed({{2{io_weight_0_real_6[15]}},io_weight_0_real_6}) : $signed(_GEN_180); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_549 = _T_5 ? $signed({{2{io_weight_0_real_7[15]}},io_weight_0_real_7}) : $signed(_GEN_181); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_550 = _T_5 ? $signed({{2{io_weight_0_real_8[15]}},io_weight_0_real_8}) : $signed(_GEN_182); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_551 = _T_5 ? $signed({{2{io_weight_0_real_9[15]}},io_weight_0_real_9}) : $signed(_GEN_183); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_552 = _T_5 ? $signed({{2{io_weight_0_real_10[15]}},io_weight_0_real_10}) : $signed(_GEN_184); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_553 = _T_5 ? $signed({{2{io_weight_0_real_11[15]}},io_weight_0_real_11}) : $signed(_GEN_185); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_554 = _T_5 ? $signed({{2{io_weight_0_real_12[15]}},io_weight_0_real_12}) : $signed(_GEN_186); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_555 = _T_5 ? $signed({{2{io_weight_0_real_13[15]}},io_weight_0_real_13}) : $signed(_GEN_187); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_556 = _T_5 ? $signed({{2{io_weight_0_real_14[15]}},io_weight_0_real_14}) : $signed(_GEN_188); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_557 = _T_5 ? $signed({{2{io_weight_0_real_15[15]}},io_weight_0_real_15}) : $signed(_GEN_189); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [1:0] _GEN_558 = _T_5 ? 2'h1 : _GEN_190; // @[Conditional.scala 39:67 calc8x8.scala 156:27]
  wire  _GEN_559 = _T_5 ? io_valid_in : _GEN_191; // @[Conditional.scala 39:67 calc8x8.scala 157:31]
  wire [17:0] _GEN_560 = _T_5 ? $signed({{2{io_weight_1_real_0[15]}},io_weight_1_real_0}) : $signed(_GEN_174); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_561 = _T_5 ? $signed({{2{io_weight_1_real_1[15]}},io_weight_1_real_1}) : $signed(_GEN_175); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_562 = _T_5 ? $signed({{2{io_weight_1_real_2[15]}},io_weight_1_real_2}) : $signed(_GEN_176); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_563 = _T_5 ? $signed({{2{io_weight_1_real_3[15]}},io_weight_1_real_3}) : $signed(_GEN_177); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_564 = _T_5 ? $signed({{2{io_weight_1_real_4[15]}},io_weight_1_real_4}) : $signed(_GEN_178); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_565 = _T_5 ? $signed({{2{io_weight_1_real_5[15]}},io_weight_1_real_5}) : $signed(_GEN_179); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_566 = _T_5 ? $signed({{2{io_weight_1_real_6[15]}},io_weight_1_real_6}) : $signed(_GEN_180); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_567 = _T_5 ? $signed({{2{io_weight_1_real_7[15]}},io_weight_1_real_7}) : $signed(_GEN_181); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_568 = _T_5 ? $signed({{2{io_weight_1_real_8[15]}},io_weight_1_real_8}) : $signed(_GEN_182); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_569 = _T_5 ? $signed({{2{io_weight_1_real_9[15]}},io_weight_1_real_9}) : $signed(_GEN_183); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_570 = _T_5 ? $signed({{2{io_weight_1_real_10[15]}},io_weight_1_real_10}) : $signed(_GEN_184); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_571 = _T_5 ? $signed({{2{io_weight_1_real_11[15]}},io_weight_1_real_11}) : $signed(_GEN_185); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_572 = _T_5 ? $signed({{2{io_weight_1_real_12[15]}},io_weight_1_real_12}) : $signed(_GEN_186); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_573 = _T_5 ? $signed({{2{io_weight_1_real_13[15]}},io_weight_1_real_13}) : $signed(_GEN_187); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_574 = _T_5 ? $signed({{2{io_weight_1_real_14[15]}},io_weight_1_real_14}) : $signed(_GEN_188); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_575 = _T_5 ? $signed({{2{io_weight_1_real_15[15]}},io_weight_1_real_15}) : $signed(_GEN_189); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_577 = _T_5 ? $signed({{2{io_weight_2_real_0[15]}},io_weight_2_real_0}) : $signed(_GEN_174); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_578 = _T_5 ? $signed({{2{io_weight_2_real_1[15]}},io_weight_2_real_1}) : $signed(_GEN_175); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_579 = _T_5 ? $signed({{2{io_weight_2_real_2[15]}},io_weight_2_real_2}) : $signed(_GEN_176); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_580 = _T_5 ? $signed({{2{io_weight_2_real_3[15]}},io_weight_2_real_3}) : $signed(_GEN_177); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_581 = _T_5 ? $signed({{2{io_weight_2_real_4[15]}},io_weight_2_real_4}) : $signed(_GEN_178); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_582 = _T_5 ? $signed({{2{io_weight_2_real_5[15]}},io_weight_2_real_5}) : $signed(_GEN_179); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_583 = _T_5 ? $signed({{2{io_weight_2_real_6[15]}},io_weight_2_real_6}) : $signed(_GEN_180); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_584 = _T_5 ? $signed({{2{io_weight_2_real_7[15]}},io_weight_2_real_7}) : $signed(_GEN_181); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_585 = _T_5 ? $signed({{2{io_weight_2_real_8[15]}},io_weight_2_real_8}) : $signed(_GEN_182); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_586 = _T_5 ? $signed({{2{io_weight_2_real_9[15]}},io_weight_2_real_9}) : $signed(_GEN_183); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_587 = _T_5 ? $signed({{2{io_weight_2_real_10[15]}},io_weight_2_real_10}) : $signed(_GEN_184); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_588 = _T_5 ? $signed({{2{io_weight_2_real_11[15]}},io_weight_2_real_11}) : $signed(_GEN_185); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_589 = _T_5 ? $signed({{2{io_weight_2_real_12[15]}},io_weight_2_real_12}) : $signed(_GEN_186); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_590 = _T_5 ? $signed({{2{io_weight_2_real_13[15]}},io_weight_2_real_13}) : $signed(_GEN_187); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_591 = _T_5 ? $signed({{2{io_weight_2_real_14[15]}},io_weight_2_real_14}) : $signed(_GEN_188); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_592 = _T_5 ? $signed({{2{io_weight_2_real_15[15]}},io_weight_2_real_15}) : $signed(_GEN_189); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_594 = _T_5 ? $signed({{2{io_weight_3_real_0[15]}},io_weight_3_real_0}) : $signed(_GEN_174); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_595 = _T_5 ? $signed({{2{io_weight_3_real_1[15]}},io_weight_3_real_1}) : $signed(_GEN_175); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_596 = _T_5 ? $signed({{2{io_weight_3_real_2[15]}},io_weight_3_real_2}) : $signed(_GEN_176); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_597 = _T_5 ? $signed({{2{io_weight_3_real_3[15]}},io_weight_3_real_3}) : $signed(_GEN_177); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_598 = _T_5 ? $signed({{2{io_weight_3_real_4[15]}},io_weight_3_real_4}) : $signed(_GEN_178); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_599 = _T_5 ? $signed({{2{io_weight_3_real_5[15]}},io_weight_3_real_5}) : $signed(_GEN_179); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_600 = _T_5 ? $signed({{2{io_weight_3_real_6[15]}},io_weight_3_real_6}) : $signed(_GEN_180); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_601 = _T_5 ? $signed({{2{io_weight_3_real_7[15]}},io_weight_3_real_7}) : $signed(_GEN_181); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_602 = _T_5 ? $signed({{2{io_weight_3_real_8[15]}},io_weight_3_real_8}) : $signed(_GEN_182); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_603 = _T_5 ? $signed({{2{io_weight_3_real_9[15]}},io_weight_3_real_9}) : $signed(_GEN_183); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_604 = _T_5 ? $signed({{2{io_weight_3_real_10[15]}},io_weight_3_real_10}) : $signed(_GEN_184); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_605 = _T_5 ? $signed({{2{io_weight_3_real_11[15]}},io_weight_3_real_11}) : $signed(_GEN_185); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_606 = _T_5 ? $signed({{2{io_weight_3_real_12[15]}},io_weight_3_real_12}) : $signed(_GEN_186); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_607 = _T_5 ? $signed({{2{io_weight_3_real_13[15]}},io_weight_3_real_13}) : $signed(_GEN_187); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_608 = _T_5 ? $signed({{2{io_weight_3_real_14[15]}},io_weight_3_real_14}) : $signed(_GEN_188); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [17:0] _GEN_609 = _T_5 ? $signed({{2{io_weight_3_real_15[15]}},io_weight_3_real_15}) : $signed(_GEN_189); // @[Conditional.scala 39:67 calc8x8.scala 155:34]
  wire [36:0] _GEN_611 = _T_5 ? $signed(A_0_output_mat_0) : $signed(_GEN_333); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_612 = _T_5 ? $signed(A_0_output_mat_1) : $signed(_GEN_334); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_613 = _T_5 ? $signed(A_0_output_mat_2) : $signed(_GEN_335); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_614 = _T_5 ? $signed(A_0_output_mat_3) : $signed(_GEN_336); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_615 = _T_5 ? $signed(A_1_output_mat_0) : $signed(_GEN_337); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_616 = _T_5 ? $signed(A_1_output_mat_1) : $signed(_GEN_338); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_617 = _T_5 ? $signed(A_1_output_mat_2) : $signed(_GEN_339); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_618 = _T_5 ? $signed(A_1_output_mat_3) : $signed(_GEN_340); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_619 = _T_5 ? $signed(A_0_output_mat_4) : $signed(_GEN_341); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_620 = _T_5 ? $signed(A_0_output_mat_5) : $signed(_GEN_342); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_621 = _T_5 ? $signed(A_0_output_mat_6) : $signed(_GEN_343); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_622 = _T_5 ? $signed(A_0_output_mat_7) : $signed(_GEN_344); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_623 = _T_5 ? $signed(A_1_output_mat_4) : $signed(_GEN_345); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_624 = _T_5 ? $signed(A_1_output_mat_5) : $signed(_GEN_346); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_625 = _T_5 ? $signed(A_1_output_mat_6) : $signed(_GEN_347); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_626 = _T_5 ? $signed(A_1_output_mat_7) : $signed(_GEN_348); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_627 = _T_5 ? $signed(A_0_output_mat_8) : $signed(_GEN_349); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_628 = _T_5 ? $signed(A_0_output_mat_9) : $signed(_GEN_350); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_629 = _T_5 ? $signed(A_0_output_mat_10) : $signed(_GEN_351); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_630 = _T_5 ? $signed(A_0_output_mat_11) : $signed(_GEN_352); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_631 = _T_5 ? $signed(A_1_output_mat_8) : $signed(_GEN_353); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_632 = _T_5 ? $signed(A_1_output_mat_9) : $signed(_GEN_354); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_633 = _T_5 ? $signed(A_1_output_mat_10) : $signed(_GEN_355); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_634 = _T_5 ? $signed(A_1_output_mat_11) : $signed(_GEN_356); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_635 = _T_5 ? $signed(A_0_output_mat_12) : $signed(_GEN_357); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_636 = _T_5 ? $signed(A_0_output_mat_13) : $signed(_GEN_358); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_637 = _T_5 ? $signed(A_0_output_mat_14) : $signed(_GEN_359); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_638 = _T_5 ? $signed(A_0_output_mat_15) : $signed(_GEN_360); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_639 = _T_5 ? $signed(A_1_output_mat_12) : $signed(_GEN_361); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_640 = _T_5 ? $signed(A_1_output_mat_13) : $signed(_GEN_362); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_641 = _T_5 ? $signed(A_1_output_mat_14) : $signed(_GEN_363); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_642 = _T_5 ? $signed(A_1_output_mat_15) : $signed(_GEN_364); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_643 = _T_5 ? $signed(A_2_output_mat_0) : $signed(_GEN_365); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_644 = _T_5 ? $signed(A_2_output_mat_1) : $signed(_GEN_366); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_645 = _T_5 ? $signed(A_2_output_mat_2) : $signed(_GEN_367); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_646 = _T_5 ? $signed(A_2_output_mat_3) : $signed(_GEN_368); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_647 = _T_5 ? $signed(A_3_output_mat_0) : $signed(_GEN_369); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_648 = _T_5 ? $signed(A_3_output_mat_1) : $signed(_GEN_370); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_649 = _T_5 ? $signed(A_3_output_mat_2) : $signed(_GEN_371); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_650 = _T_5 ? $signed(A_3_output_mat_3) : $signed(_GEN_372); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_651 = _T_5 ? $signed(A_2_output_mat_4) : $signed(_GEN_373); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_652 = _T_5 ? $signed(A_2_output_mat_5) : $signed(_GEN_374); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_653 = _T_5 ? $signed(A_2_output_mat_6) : $signed(_GEN_375); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_654 = _T_5 ? $signed(A_2_output_mat_7) : $signed(_GEN_376); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_655 = _T_5 ? $signed(A_3_output_mat_4) : $signed(_GEN_377); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_656 = _T_5 ? $signed(A_3_output_mat_5) : $signed(_GEN_378); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_657 = _T_5 ? $signed(A_3_output_mat_6) : $signed(_GEN_379); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_658 = _T_5 ? $signed(A_3_output_mat_7) : $signed(_GEN_380); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_659 = _T_5 ? $signed(A_2_output_mat_8) : $signed(_GEN_381); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_660 = _T_5 ? $signed(A_2_output_mat_9) : $signed(_GEN_382); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_661 = _T_5 ? $signed(A_2_output_mat_10) : $signed(_GEN_383); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_662 = _T_5 ? $signed(A_2_output_mat_11) : $signed(_GEN_384); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_663 = _T_5 ? $signed(A_3_output_mat_8) : $signed(_GEN_385); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_664 = _T_5 ? $signed(A_3_output_mat_9) : $signed(_GEN_386); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_665 = _T_5 ? $signed(A_3_output_mat_10) : $signed(_GEN_387); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_666 = _T_5 ? $signed(A_3_output_mat_11) : $signed(_GEN_388); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_667 = _T_5 ? $signed(A_2_output_mat_12) : $signed(_GEN_389); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_668 = _T_5 ? $signed(A_2_output_mat_13) : $signed(_GEN_390); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_669 = _T_5 ? $signed(A_2_output_mat_14) : $signed(_GEN_391); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_670 = _T_5 ? $signed(A_2_output_mat_15) : $signed(_GEN_392); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_671 = _T_5 ? $signed(A_3_output_mat_12) : $signed(_GEN_393); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_672 = _T_5 ? $signed(A_3_output_mat_13) : $signed(_GEN_394); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_673 = _T_5 ? $signed(A_3_output_mat_14) : $signed(_GEN_395); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire [36:0] _GEN_674 = _T_5 ? $signed(A_3_output_mat_15) : $signed(_GEN_396); // @[Conditional.scala 39:67 calc8x8.scala 159:23]
  wire  _GEN_675 = _T_5 ? A_0_valid_out : _GEN_397; // @[Conditional.scala 39:67 calc8x8.scala 160:26]
  wire [17:0] _GEN_676 = _T_5 ? $signed(18'sh0) : $signed(_GEN_144); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_677 = _T_5 ? $signed(18'sh0) : $signed(_GEN_145); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_678 = _T_5 ? $signed(18'sh0) : $signed(_GEN_146); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_679 = _T_5 ? $signed(18'sh0) : $signed(_GEN_147); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_680 = _T_5 ? $signed(18'sh0) : $signed(_GEN_148); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_681 = _T_5 ? $signed(18'sh0) : $signed(_GEN_149); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_682 = _T_5 ? $signed(18'sh0) : $signed(_GEN_150); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_683 = _T_5 ? $signed(18'sh0) : $signed(_GEN_151); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_684 = _T_5 ? $signed(18'sh0) : $signed(_GEN_152); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_685 = _T_5 ? $signed(18'sh0) : $signed(_GEN_153); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_686 = _T_5 ? $signed(18'sh0) : $signed(_GEN_154); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_687 = _T_5 ? $signed(18'sh0) : $signed(_GEN_155); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_688 = _T_5 ? $signed(18'sh0) : $signed(_GEN_156); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_689 = _T_5 ? $signed(18'sh0) : $signed(_GEN_157); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_690 = _T_5 ? $signed(18'sh0) : $signed(_GEN_158); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_691 = _T_5 ? $signed(18'sh0) : $signed(_GEN_159); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_692 = _T_5 ? $signed(18'sh0) : $signed(_GEN_160); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_693 = _T_5 ? $signed(18'sh0) : $signed(_GEN_161); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_694 = _T_5 ? $signed(18'sh0) : $signed(_GEN_162); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_695 = _T_5 ? $signed(18'sh0) : $signed(_GEN_163); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_696 = _T_5 ? $signed(18'sh0) : $signed(_GEN_164); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_697 = _T_5 ? $signed(18'sh0) : $signed(_GEN_165); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_698 = _T_5 ? $signed(18'sh0) : $signed(_GEN_166); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_699 = _T_5 ? $signed(18'sh0) : $signed(_GEN_167); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_700 = _T_5 ? $signed(18'sh0) : $signed(_GEN_168); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_701 = _T_5 ? $signed(18'sh0) : $signed(_GEN_169); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_702 = _T_5 ? $signed(18'sh0) : $signed(_GEN_170); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_703 = _T_5 ? $signed(18'sh0) : $signed(_GEN_171); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_704 = _T_5 ? $signed(18'sh0) : $signed(_GEN_172); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  wire [17:0] _GEN_705 = _T_5 ? $signed(18'sh0) : $signed(_GEN_173); // @[Conditional.scala 39:67 calc8x8.scala 63:21]
  Calc6x6 Calc6x6 ( // @[calc8x8.scala 59:39]
    .clock(Calc6x6_clock),
    .reset(Calc6x6_reset),
    .io_input_mat_0(Calc6x6_io_input_mat_0),
    .io_input_mat_1(Calc6x6_io_input_mat_1),
    .io_input_mat_2(Calc6x6_io_input_mat_2),
    .io_input_mat_3(Calc6x6_io_input_mat_3),
    .io_input_mat_4(Calc6x6_io_input_mat_4),
    .io_input_mat_5(Calc6x6_io_input_mat_5),
    .io_input_mat_6(Calc6x6_io_input_mat_6),
    .io_input_mat_7(Calc6x6_io_input_mat_7),
    .io_input_mat_8(Calc6x6_io_input_mat_8),
    .io_input_mat_9(Calc6x6_io_input_mat_9),
    .io_input_mat_10(Calc6x6_io_input_mat_10),
    .io_input_mat_11(Calc6x6_io_input_mat_11),
    .io_input_mat_12(Calc6x6_io_input_mat_12),
    .io_input_mat_13(Calc6x6_io_input_mat_13),
    .io_input_mat_14(Calc6x6_io_input_mat_14),
    .io_input_mat_15(Calc6x6_io_input_mat_15),
    .io_input_mat_16(Calc6x6_io_input_mat_16),
    .io_input_mat_17(Calc6x6_io_input_mat_17),
    .io_input_mat_18(Calc6x6_io_input_mat_18),
    .io_input_mat_19(Calc6x6_io_input_mat_19),
    .io_input_mat_20(Calc6x6_io_input_mat_20),
    .io_input_mat_21(Calc6x6_io_input_mat_21),
    .io_input_mat_22(Calc6x6_io_input_mat_22),
    .io_input_mat_23(Calc6x6_io_input_mat_23),
    .io_input_mat_24(Calc6x6_io_input_mat_24),
    .io_input_mat_25(Calc6x6_io_input_mat_25),
    .io_input_mat_26(Calc6x6_io_input_mat_26),
    .io_input_mat_27(Calc6x6_io_input_mat_27),
    .io_input_mat_28(Calc6x6_io_input_mat_28),
    .io_input_mat_29(Calc6x6_io_input_mat_29),
    .io_input_mat_30(Calc6x6_io_input_mat_30),
    .io_input_mat_31(Calc6x6_io_input_mat_31),
    .io_input_mat_32(Calc6x6_io_input_mat_32),
    .io_input_mat_33(Calc6x6_io_input_mat_33),
    .io_input_mat_34(Calc6x6_io_input_mat_34),
    .io_input_mat_35(Calc6x6_io_input_mat_35),
    .io_flag(Calc6x6_io_flag),
    .io_weight_real_0(Calc6x6_io_weight_real_0),
    .io_weight_real_1(Calc6x6_io_weight_real_1),
    .io_weight_real_2(Calc6x6_io_weight_real_2),
    .io_weight_real_3(Calc6x6_io_weight_real_3),
    .io_weight_real_4(Calc6x6_io_weight_real_4),
    .io_weight_real_5(Calc6x6_io_weight_real_5),
    .io_weight_real_6(Calc6x6_io_weight_real_6),
    .io_weight_real_7(Calc6x6_io_weight_real_7),
    .io_weight_real_8(Calc6x6_io_weight_real_8),
    .io_weight_real_9(Calc6x6_io_weight_real_9),
    .io_weight_real_10(Calc6x6_io_weight_real_10),
    .io_weight_real_11(Calc6x6_io_weight_real_11),
    .io_weight_real_12(Calc6x6_io_weight_real_12),
    .io_weight_real_13(Calc6x6_io_weight_real_13),
    .io_weight_real_14(Calc6x6_io_weight_real_14),
    .io_weight_real_15(Calc6x6_io_weight_real_15),
    .io_weight_comp1_0(Calc6x6_io_weight_comp1_0),
    .io_weight_comp1_1(Calc6x6_io_weight_comp1_1),
    .io_weight_comp1_2(Calc6x6_io_weight_comp1_2),
    .io_weight_comp1_3(Calc6x6_io_weight_comp1_3),
    .io_weight_comp1_4(Calc6x6_io_weight_comp1_4),
    .io_weight_comp1_5(Calc6x6_io_weight_comp1_5),
    .io_weight_comp1_6(Calc6x6_io_weight_comp1_6),
    .io_weight_comp1_7(Calc6x6_io_weight_comp1_7),
    .io_weight_comp1_8(Calc6x6_io_weight_comp1_8),
    .io_weight_comp1_9(Calc6x6_io_weight_comp1_9),
    .io_weight_comp2_0(Calc6x6_io_weight_comp2_0),
    .io_weight_comp2_1(Calc6x6_io_weight_comp2_1),
    .io_weight_comp2_2(Calc6x6_io_weight_comp2_2),
    .io_weight_comp2_3(Calc6x6_io_weight_comp2_3),
    .io_weight_comp2_4(Calc6x6_io_weight_comp2_4),
    .io_weight_comp2_5(Calc6x6_io_weight_comp2_5),
    .io_weight_comp2_6(Calc6x6_io_weight_comp2_6),
    .io_weight_comp2_7(Calc6x6_io_weight_comp2_7),
    .io_weight_comp2_8(Calc6x6_io_weight_comp2_8),
    .io_weight_comp2_9(Calc6x6_io_weight_comp2_9),
    .io_weight_comp3_0(Calc6x6_io_weight_comp3_0),
    .io_weight_comp3_1(Calc6x6_io_weight_comp3_1),
    .io_weight_comp3_2(Calc6x6_io_weight_comp3_2),
    .io_weight_comp3_3(Calc6x6_io_weight_comp3_3),
    .io_weight_comp3_4(Calc6x6_io_weight_comp3_4),
    .io_weight_comp3_5(Calc6x6_io_weight_comp3_5),
    .io_weight_comp3_6(Calc6x6_io_weight_comp3_6),
    .io_weight_comp3_7(Calc6x6_io_weight_comp3_7),
    .io_weight_comp3_8(Calc6x6_io_weight_comp3_8),
    .io_weight_comp3_9(Calc6x6_io_weight_comp3_9),
    .io_output_mat_0(Calc6x6_io_output_mat_0),
    .io_output_mat_1(Calc6x6_io_output_mat_1),
    .io_output_mat_2(Calc6x6_io_output_mat_2),
    .io_output_mat_3(Calc6x6_io_output_mat_3),
    .io_output_mat_4(Calc6x6_io_output_mat_4),
    .io_output_mat_5(Calc6x6_io_output_mat_5),
    .io_output_mat_6(Calc6x6_io_output_mat_6),
    .io_output_mat_7(Calc6x6_io_output_mat_7),
    .io_output_mat_8(Calc6x6_io_output_mat_8),
    .io_output_mat_9(Calc6x6_io_output_mat_9),
    .io_output_mat_10(Calc6x6_io_output_mat_10),
    .io_output_mat_11(Calc6x6_io_output_mat_11),
    .io_output_mat_12(Calc6x6_io_output_mat_12),
    .io_output_mat_13(Calc6x6_io_output_mat_13),
    .io_output_mat_14(Calc6x6_io_output_mat_14),
    .io_output_mat_15(Calc6x6_io_output_mat_15),
    .io_valid_in(Calc6x6_io_valid_in),
    .io_valid_out(Calc6x6_io_valid_out)
  );
  Calc6x6 Calc6x6_1 ( // @[calc8x8.scala 59:39]
    .clock(Calc6x6_1_clock),
    .reset(Calc6x6_1_reset),
    .io_input_mat_0(Calc6x6_1_io_input_mat_0),
    .io_input_mat_1(Calc6x6_1_io_input_mat_1),
    .io_input_mat_2(Calc6x6_1_io_input_mat_2),
    .io_input_mat_3(Calc6x6_1_io_input_mat_3),
    .io_input_mat_4(Calc6x6_1_io_input_mat_4),
    .io_input_mat_5(Calc6x6_1_io_input_mat_5),
    .io_input_mat_6(Calc6x6_1_io_input_mat_6),
    .io_input_mat_7(Calc6x6_1_io_input_mat_7),
    .io_input_mat_8(Calc6x6_1_io_input_mat_8),
    .io_input_mat_9(Calc6x6_1_io_input_mat_9),
    .io_input_mat_10(Calc6x6_1_io_input_mat_10),
    .io_input_mat_11(Calc6x6_1_io_input_mat_11),
    .io_input_mat_12(Calc6x6_1_io_input_mat_12),
    .io_input_mat_13(Calc6x6_1_io_input_mat_13),
    .io_input_mat_14(Calc6x6_1_io_input_mat_14),
    .io_input_mat_15(Calc6x6_1_io_input_mat_15),
    .io_input_mat_16(Calc6x6_1_io_input_mat_16),
    .io_input_mat_17(Calc6x6_1_io_input_mat_17),
    .io_input_mat_18(Calc6x6_1_io_input_mat_18),
    .io_input_mat_19(Calc6x6_1_io_input_mat_19),
    .io_input_mat_20(Calc6x6_1_io_input_mat_20),
    .io_input_mat_21(Calc6x6_1_io_input_mat_21),
    .io_input_mat_22(Calc6x6_1_io_input_mat_22),
    .io_input_mat_23(Calc6x6_1_io_input_mat_23),
    .io_input_mat_24(Calc6x6_1_io_input_mat_24),
    .io_input_mat_25(Calc6x6_1_io_input_mat_25),
    .io_input_mat_26(Calc6x6_1_io_input_mat_26),
    .io_input_mat_27(Calc6x6_1_io_input_mat_27),
    .io_input_mat_28(Calc6x6_1_io_input_mat_28),
    .io_input_mat_29(Calc6x6_1_io_input_mat_29),
    .io_input_mat_30(Calc6x6_1_io_input_mat_30),
    .io_input_mat_31(Calc6x6_1_io_input_mat_31),
    .io_input_mat_32(Calc6x6_1_io_input_mat_32),
    .io_input_mat_33(Calc6x6_1_io_input_mat_33),
    .io_input_mat_34(Calc6x6_1_io_input_mat_34),
    .io_input_mat_35(Calc6x6_1_io_input_mat_35),
    .io_flag(Calc6x6_1_io_flag),
    .io_weight_real_0(Calc6x6_1_io_weight_real_0),
    .io_weight_real_1(Calc6x6_1_io_weight_real_1),
    .io_weight_real_2(Calc6x6_1_io_weight_real_2),
    .io_weight_real_3(Calc6x6_1_io_weight_real_3),
    .io_weight_real_4(Calc6x6_1_io_weight_real_4),
    .io_weight_real_5(Calc6x6_1_io_weight_real_5),
    .io_weight_real_6(Calc6x6_1_io_weight_real_6),
    .io_weight_real_7(Calc6x6_1_io_weight_real_7),
    .io_weight_real_8(Calc6x6_1_io_weight_real_8),
    .io_weight_real_9(Calc6x6_1_io_weight_real_9),
    .io_weight_real_10(Calc6x6_1_io_weight_real_10),
    .io_weight_real_11(Calc6x6_1_io_weight_real_11),
    .io_weight_real_12(Calc6x6_1_io_weight_real_12),
    .io_weight_real_13(Calc6x6_1_io_weight_real_13),
    .io_weight_real_14(Calc6x6_1_io_weight_real_14),
    .io_weight_real_15(Calc6x6_1_io_weight_real_15),
    .io_weight_comp1_0(Calc6x6_1_io_weight_comp1_0),
    .io_weight_comp1_1(Calc6x6_1_io_weight_comp1_1),
    .io_weight_comp1_2(Calc6x6_1_io_weight_comp1_2),
    .io_weight_comp1_3(Calc6x6_1_io_weight_comp1_3),
    .io_weight_comp1_4(Calc6x6_1_io_weight_comp1_4),
    .io_weight_comp1_5(Calc6x6_1_io_weight_comp1_5),
    .io_weight_comp1_6(Calc6x6_1_io_weight_comp1_6),
    .io_weight_comp1_7(Calc6x6_1_io_weight_comp1_7),
    .io_weight_comp1_8(Calc6x6_1_io_weight_comp1_8),
    .io_weight_comp1_9(Calc6x6_1_io_weight_comp1_9),
    .io_weight_comp2_0(Calc6x6_1_io_weight_comp2_0),
    .io_weight_comp2_1(Calc6x6_1_io_weight_comp2_1),
    .io_weight_comp2_2(Calc6x6_1_io_weight_comp2_2),
    .io_weight_comp2_3(Calc6x6_1_io_weight_comp2_3),
    .io_weight_comp2_4(Calc6x6_1_io_weight_comp2_4),
    .io_weight_comp2_5(Calc6x6_1_io_weight_comp2_5),
    .io_weight_comp2_6(Calc6x6_1_io_weight_comp2_6),
    .io_weight_comp2_7(Calc6x6_1_io_weight_comp2_7),
    .io_weight_comp2_8(Calc6x6_1_io_weight_comp2_8),
    .io_weight_comp2_9(Calc6x6_1_io_weight_comp2_9),
    .io_weight_comp3_0(Calc6x6_1_io_weight_comp3_0),
    .io_weight_comp3_1(Calc6x6_1_io_weight_comp3_1),
    .io_weight_comp3_2(Calc6x6_1_io_weight_comp3_2),
    .io_weight_comp3_3(Calc6x6_1_io_weight_comp3_3),
    .io_weight_comp3_4(Calc6x6_1_io_weight_comp3_4),
    .io_weight_comp3_5(Calc6x6_1_io_weight_comp3_5),
    .io_weight_comp3_6(Calc6x6_1_io_weight_comp3_6),
    .io_weight_comp3_7(Calc6x6_1_io_weight_comp3_7),
    .io_weight_comp3_8(Calc6x6_1_io_weight_comp3_8),
    .io_weight_comp3_9(Calc6x6_1_io_weight_comp3_9),
    .io_output_mat_0(Calc6x6_1_io_output_mat_0),
    .io_output_mat_1(Calc6x6_1_io_output_mat_1),
    .io_output_mat_2(Calc6x6_1_io_output_mat_2),
    .io_output_mat_3(Calc6x6_1_io_output_mat_3),
    .io_output_mat_4(Calc6x6_1_io_output_mat_4),
    .io_output_mat_5(Calc6x6_1_io_output_mat_5),
    .io_output_mat_6(Calc6x6_1_io_output_mat_6),
    .io_output_mat_7(Calc6x6_1_io_output_mat_7),
    .io_output_mat_8(Calc6x6_1_io_output_mat_8),
    .io_output_mat_9(Calc6x6_1_io_output_mat_9),
    .io_output_mat_10(Calc6x6_1_io_output_mat_10),
    .io_output_mat_11(Calc6x6_1_io_output_mat_11),
    .io_output_mat_12(Calc6x6_1_io_output_mat_12),
    .io_output_mat_13(Calc6x6_1_io_output_mat_13),
    .io_output_mat_14(Calc6x6_1_io_output_mat_14),
    .io_output_mat_15(Calc6x6_1_io_output_mat_15),
    .io_valid_in(Calc6x6_1_io_valid_in),
    .io_valid_out(Calc6x6_1_io_valid_out)
  );
  Calc6x6 Calc6x6_2 ( // @[calc8x8.scala 59:39]
    .clock(Calc6x6_2_clock),
    .reset(Calc6x6_2_reset),
    .io_input_mat_0(Calc6x6_2_io_input_mat_0),
    .io_input_mat_1(Calc6x6_2_io_input_mat_1),
    .io_input_mat_2(Calc6x6_2_io_input_mat_2),
    .io_input_mat_3(Calc6x6_2_io_input_mat_3),
    .io_input_mat_4(Calc6x6_2_io_input_mat_4),
    .io_input_mat_5(Calc6x6_2_io_input_mat_5),
    .io_input_mat_6(Calc6x6_2_io_input_mat_6),
    .io_input_mat_7(Calc6x6_2_io_input_mat_7),
    .io_input_mat_8(Calc6x6_2_io_input_mat_8),
    .io_input_mat_9(Calc6x6_2_io_input_mat_9),
    .io_input_mat_10(Calc6x6_2_io_input_mat_10),
    .io_input_mat_11(Calc6x6_2_io_input_mat_11),
    .io_input_mat_12(Calc6x6_2_io_input_mat_12),
    .io_input_mat_13(Calc6x6_2_io_input_mat_13),
    .io_input_mat_14(Calc6x6_2_io_input_mat_14),
    .io_input_mat_15(Calc6x6_2_io_input_mat_15),
    .io_input_mat_16(Calc6x6_2_io_input_mat_16),
    .io_input_mat_17(Calc6x6_2_io_input_mat_17),
    .io_input_mat_18(Calc6x6_2_io_input_mat_18),
    .io_input_mat_19(Calc6x6_2_io_input_mat_19),
    .io_input_mat_20(Calc6x6_2_io_input_mat_20),
    .io_input_mat_21(Calc6x6_2_io_input_mat_21),
    .io_input_mat_22(Calc6x6_2_io_input_mat_22),
    .io_input_mat_23(Calc6x6_2_io_input_mat_23),
    .io_input_mat_24(Calc6x6_2_io_input_mat_24),
    .io_input_mat_25(Calc6x6_2_io_input_mat_25),
    .io_input_mat_26(Calc6x6_2_io_input_mat_26),
    .io_input_mat_27(Calc6x6_2_io_input_mat_27),
    .io_input_mat_28(Calc6x6_2_io_input_mat_28),
    .io_input_mat_29(Calc6x6_2_io_input_mat_29),
    .io_input_mat_30(Calc6x6_2_io_input_mat_30),
    .io_input_mat_31(Calc6x6_2_io_input_mat_31),
    .io_input_mat_32(Calc6x6_2_io_input_mat_32),
    .io_input_mat_33(Calc6x6_2_io_input_mat_33),
    .io_input_mat_34(Calc6x6_2_io_input_mat_34),
    .io_input_mat_35(Calc6x6_2_io_input_mat_35),
    .io_flag(Calc6x6_2_io_flag),
    .io_weight_real_0(Calc6x6_2_io_weight_real_0),
    .io_weight_real_1(Calc6x6_2_io_weight_real_1),
    .io_weight_real_2(Calc6x6_2_io_weight_real_2),
    .io_weight_real_3(Calc6x6_2_io_weight_real_3),
    .io_weight_real_4(Calc6x6_2_io_weight_real_4),
    .io_weight_real_5(Calc6x6_2_io_weight_real_5),
    .io_weight_real_6(Calc6x6_2_io_weight_real_6),
    .io_weight_real_7(Calc6x6_2_io_weight_real_7),
    .io_weight_real_8(Calc6x6_2_io_weight_real_8),
    .io_weight_real_9(Calc6x6_2_io_weight_real_9),
    .io_weight_real_10(Calc6x6_2_io_weight_real_10),
    .io_weight_real_11(Calc6x6_2_io_weight_real_11),
    .io_weight_real_12(Calc6x6_2_io_weight_real_12),
    .io_weight_real_13(Calc6x6_2_io_weight_real_13),
    .io_weight_real_14(Calc6x6_2_io_weight_real_14),
    .io_weight_real_15(Calc6x6_2_io_weight_real_15),
    .io_weight_comp1_0(Calc6x6_2_io_weight_comp1_0),
    .io_weight_comp1_1(Calc6x6_2_io_weight_comp1_1),
    .io_weight_comp1_2(Calc6x6_2_io_weight_comp1_2),
    .io_weight_comp1_3(Calc6x6_2_io_weight_comp1_3),
    .io_weight_comp1_4(Calc6x6_2_io_weight_comp1_4),
    .io_weight_comp1_5(Calc6x6_2_io_weight_comp1_5),
    .io_weight_comp1_6(Calc6x6_2_io_weight_comp1_6),
    .io_weight_comp1_7(Calc6x6_2_io_weight_comp1_7),
    .io_weight_comp1_8(Calc6x6_2_io_weight_comp1_8),
    .io_weight_comp1_9(Calc6x6_2_io_weight_comp1_9),
    .io_weight_comp2_0(Calc6x6_2_io_weight_comp2_0),
    .io_weight_comp2_1(Calc6x6_2_io_weight_comp2_1),
    .io_weight_comp2_2(Calc6x6_2_io_weight_comp2_2),
    .io_weight_comp2_3(Calc6x6_2_io_weight_comp2_3),
    .io_weight_comp2_4(Calc6x6_2_io_weight_comp2_4),
    .io_weight_comp2_5(Calc6x6_2_io_weight_comp2_5),
    .io_weight_comp2_6(Calc6x6_2_io_weight_comp2_6),
    .io_weight_comp2_7(Calc6x6_2_io_weight_comp2_7),
    .io_weight_comp2_8(Calc6x6_2_io_weight_comp2_8),
    .io_weight_comp2_9(Calc6x6_2_io_weight_comp2_9),
    .io_weight_comp3_0(Calc6x6_2_io_weight_comp3_0),
    .io_weight_comp3_1(Calc6x6_2_io_weight_comp3_1),
    .io_weight_comp3_2(Calc6x6_2_io_weight_comp3_2),
    .io_weight_comp3_3(Calc6x6_2_io_weight_comp3_3),
    .io_weight_comp3_4(Calc6x6_2_io_weight_comp3_4),
    .io_weight_comp3_5(Calc6x6_2_io_weight_comp3_5),
    .io_weight_comp3_6(Calc6x6_2_io_weight_comp3_6),
    .io_weight_comp3_7(Calc6x6_2_io_weight_comp3_7),
    .io_weight_comp3_8(Calc6x6_2_io_weight_comp3_8),
    .io_weight_comp3_9(Calc6x6_2_io_weight_comp3_9),
    .io_output_mat_0(Calc6x6_2_io_output_mat_0),
    .io_output_mat_1(Calc6x6_2_io_output_mat_1),
    .io_output_mat_2(Calc6x6_2_io_output_mat_2),
    .io_output_mat_3(Calc6x6_2_io_output_mat_3),
    .io_output_mat_4(Calc6x6_2_io_output_mat_4),
    .io_output_mat_5(Calc6x6_2_io_output_mat_5),
    .io_output_mat_6(Calc6x6_2_io_output_mat_6),
    .io_output_mat_7(Calc6x6_2_io_output_mat_7),
    .io_output_mat_8(Calc6x6_2_io_output_mat_8),
    .io_output_mat_9(Calc6x6_2_io_output_mat_9),
    .io_output_mat_10(Calc6x6_2_io_output_mat_10),
    .io_output_mat_11(Calc6x6_2_io_output_mat_11),
    .io_output_mat_12(Calc6x6_2_io_output_mat_12),
    .io_output_mat_13(Calc6x6_2_io_output_mat_13),
    .io_output_mat_14(Calc6x6_2_io_output_mat_14),
    .io_output_mat_15(Calc6x6_2_io_output_mat_15),
    .io_valid_in(Calc6x6_2_io_valid_in),
    .io_valid_out(Calc6x6_2_io_valid_out)
  );
  Calc6x6 Calc6x6_3 ( // @[calc8x8.scala 59:39]
    .clock(Calc6x6_3_clock),
    .reset(Calc6x6_3_reset),
    .io_input_mat_0(Calc6x6_3_io_input_mat_0),
    .io_input_mat_1(Calc6x6_3_io_input_mat_1),
    .io_input_mat_2(Calc6x6_3_io_input_mat_2),
    .io_input_mat_3(Calc6x6_3_io_input_mat_3),
    .io_input_mat_4(Calc6x6_3_io_input_mat_4),
    .io_input_mat_5(Calc6x6_3_io_input_mat_5),
    .io_input_mat_6(Calc6x6_3_io_input_mat_6),
    .io_input_mat_7(Calc6x6_3_io_input_mat_7),
    .io_input_mat_8(Calc6x6_3_io_input_mat_8),
    .io_input_mat_9(Calc6x6_3_io_input_mat_9),
    .io_input_mat_10(Calc6x6_3_io_input_mat_10),
    .io_input_mat_11(Calc6x6_3_io_input_mat_11),
    .io_input_mat_12(Calc6x6_3_io_input_mat_12),
    .io_input_mat_13(Calc6x6_3_io_input_mat_13),
    .io_input_mat_14(Calc6x6_3_io_input_mat_14),
    .io_input_mat_15(Calc6x6_3_io_input_mat_15),
    .io_input_mat_16(Calc6x6_3_io_input_mat_16),
    .io_input_mat_17(Calc6x6_3_io_input_mat_17),
    .io_input_mat_18(Calc6x6_3_io_input_mat_18),
    .io_input_mat_19(Calc6x6_3_io_input_mat_19),
    .io_input_mat_20(Calc6x6_3_io_input_mat_20),
    .io_input_mat_21(Calc6x6_3_io_input_mat_21),
    .io_input_mat_22(Calc6x6_3_io_input_mat_22),
    .io_input_mat_23(Calc6x6_3_io_input_mat_23),
    .io_input_mat_24(Calc6x6_3_io_input_mat_24),
    .io_input_mat_25(Calc6x6_3_io_input_mat_25),
    .io_input_mat_26(Calc6x6_3_io_input_mat_26),
    .io_input_mat_27(Calc6x6_3_io_input_mat_27),
    .io_input_mat_28(Calc6x6_3_io_input_mat_28),
    .io_input_mat_29(Calc6x6_3_io_input_mat_29),
    .io_input_mat_30(Calc6x6_3_io_input_mat_30),
    .io_input_mat_31(Calc6x6_3_io_input_mat_31),
    .io_input_mat_32(Calc6x6_3_io_input_mat_32),
    .io_input_mat_33(Calc6x6_3_io_input_mat_33),
    .io_input_mat_34(Calc6x6_3_io_input_mat_34),
    .io_input_mat_35(Calc6x6_3_io_input_mat_35),
    .io_flag(Calc6x6_3_io_flag),
    .io_weight_real_0(Calc6x6_3_io_weight_real_0),
    .io_weight_real_1(Calc6x6_3_io_weight_real_1),
    .io_weight_real_2(Calc6x6_3_io_weight_real_2),
    .io_weight_real_3(Calc6x6_3_io_weight_real_3),
    .io_weight_real_4(Calc6x6_3_io_weight_real_4),
    .io_weight_real_5(Calc6x6_3_io_weight_real_5),
    .io_weight_real_6(Calc6x6_3_io_weight_real_6),
    .io_weight_real_7(Calc6x6_3_io_weight_real_7),
    .io_weight_real_8(Calc6x6_3_io_weight_real_8),
    .io_weight_real_9(Calc6x6_3_io_weight_real_9),
    .io_weight_real_10(Calc6x6_3_io_weight_real_10),
    .io_weight_real_11(Calc6x6_3_io_weight_real_11),
    .io_weight_real_12(Calc6x6_3_io_weight_real_12),
    .io_weight_real_13(Calc6x6_3_io_weight_real_13),
    .io_weight_real_14(Calc6x6_3_io_weight_real_14),
    .io_weight_real_15(Calc6x6_3_io_weight_real_15),
    .io_weight_comp1_0(Calc6x6_3_io_weight_comp1_0),
    .io_weight_comp1_1(Calc6x6_3_io_weight_comp1_1),
    .io_weight_comp1_2(Calc6x6_3_io_weight_comp1_2),
    .io_weight_comp1_3(Calc6x6_3_io_weight_comp1_3),
    .io_weight_comp1_4(Calc6x6_3_io_weight_comp1_4),
    .io_weight_comp1_5(Calc6x6_3_io_weight_comp1_5),
    .io_weight_comp1_6(Calc6x6_3_io_weight_comp1_6),
    .io_weight_comp1_7(Calc6x6_3_io_weight_comp1_7),
    .io_weight_comp1_8(Calc6x6_3_io_weight_comp1_8),
    .io_weight_comp1_9(Calc6x6_3_io_weight_comp1_9),
    .io_weight_comp2_0(Calc6x6_3_io_weight_comp2_0),
    .io_weight_comp2_1(Calc6x6_3_io_weight_comp2_1),
    .io_weight_comp2_2(Calc6x6_3_io_weight_comp2_2),
    .io_weight_comp2_3(Calc6x6_3_io_weight_comp2_3),
    .io_weight_comp2_4(Calc6x6_3_io_weight_comp2_4),
    .io_weight_comp2_5(Calc6x6_3_io_weight_comp2_5),
    .io_weight_comp2_6(Calc6x6_3_io_weight_comp2_6),
    .io_weight_comp2_7(Calc6x6_3_io_weight_comp2_7),
    .io_weight_comp2_8(Calc6x6_3_io_weight_comp2_8),
    .io_weight_comp2_9(Calc6x6_3_io_weight_comp2_9),
    .io_weight_comp3_0(Calc6x6_3_io_weight_comp3_0),
    .io_weight_comp3_1(Calc6x6_3_io_weight_comp3_1),
    .io_weight_comp3_2(Calc6x6_3_io_weight_comp3_2),
    .io_weight_comp3_3(Calc6x6_3_io_weight_comp3_3),
    .io_weight_comp3_4(Calc6x6_3_io_weight_comp3_4),
    .io_weight_comp3_5(Calc6x6_3_io_weight_comp3_5),
    .io_weight_comp3_6(Calc6x6_3_io_weight_comp3_6),
    .io_weight_comp3_7(Calc6x6_3_io_weight_comp3_7),
    .io_weight_comp3_8(Calc6x6_3_io_weight_comp3_8),
    .io_weight_comp3_9(Calc6x6_3_io_weight_comp3_9),
    .io_output_mat_0(Calc6x6_3_io_output_mat_0),
    .io_output_mat_1(Calc6x6_3_io_output_mat_1),
    .io_output_mat_2(Calc6x6_3_io_output_mat_2),
    .io_output_mat_3(Calc6x6_3_io_output_mat_3),
    .io_output_mat_4(Calc6x6_3_io_output_mat_4),
    .io_output_mat_5(Calc6x6_3_io_output_mat_5),
    .io_output_mat_6(Calc6x6_3_io_output_mat_6),
    .io_output_mat_7(Calc6x6_3_io_output_mat_7),
    .io_output_mat_8(Calc6x6_3_io_output_mat_8),
    .io_output_mat_9(Calc6x6_3_io_output_mat_9),
    .io_output_mat_10(Calc6x6_3_io_output_mat_10),
    .io_output_mat_11(Calc6x6_3_io_output_mat_11),
    .io_output_mat_12(Calc6x6_3_io_output_mat_12),
    .io_output_mat_13(Calc6x6_3_io_output_mat_13),
    .io_output_mat_14(Calc6x6_3_io_output_mat_14),
    .io_output_mat_15(Calc6x6_3_io_output_mat_15),
    .io_valid_in(Calc6x6_3_io_valid_in),
    .io_valid_out(Calc6x6_3_io_valid_out)
  );
  assign io_output_mat_0 = _T_2 ? $signed(A_0_output_mat_0) : $signed(_GEN_611); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_1 = _T_2 ? $signed(A_0_output_mat_1) : $signed(_GEN_612); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_2 = _T_2 ? $signed(A_0_output_mat_2) : $signed(_GEN_613); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_3 = _T_2 ? $signed(A_0_output_mat_3) : $signed(_GEN_614); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_4 = _T_2 ? $signed(A_1_output_mat_0) : $signed(_GEN_615); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_5 = _T_2 ? $signed(A_1_output_mat_1) : $signed(_GEN_616); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_6 = _T_2 ? $signed(A_1_output_mat_2) : $signed(_GEN_617); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_7 = _T_2 ? $signed(A_1_output_mat_3) : $signed(_GEN_618); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_8 = _T_2 ? $signed(A_0_output_mat_4) : $signed(_GEN_619); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_9 = _T_2 ? $signed(A_0_output_mat_5) : $signed(_GEN_620); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_10 = _T_2 ? $signed(A_0_output_mat_6) : $signed(_GEN_621); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_11 = _T_2 ? $signed(A_0_output_mat_7) : $signed(_GEN_622); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_12 = _T_2 ? $signed(A_1_output_mat_4) : $signed(_GEN_623); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_13 = _T_2 ? $signed(A_1_output_mat_5) : $signed(_GEN_624); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_14 = _T_2 ? $signed(A_1_output_mat_6) : $signed(_GEN_625); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_15 = _T_2 ? $signed(A_1_output_mat_7) : $signed(_GEN_626); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_16 = _T_2 ? $signed(A_0_output_mat_8) : $signed(_GEN_627); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_17 = _T_2 ? $signed(A_0_output_mat_9) : $signed(_GEN_628); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_18 = _T_2 ? $signed(A_0_output_mat_10) : $signed(_GEN_629); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_19 = _T_2 ? $signed(A_0_output_mat_11) : $signed(_GEN_630); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_20 = _T_2 ? $signed(A_1_output_mat_8) : $signed(_GEN_631); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_21 = _T_2 ? $signed(A_1_output_mat_9) : $signed(_GEN_632); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_22 = _T_2 ? $signed(A_1_output_mat_10) : $signed(_GEN_633); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_23 = _T_2 ? $signed(A_1_output_mat_11) : $signed(_GEN_634); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_24 = _T_2 ? $signed(A_0_output_mat_12) : $signed(_GEN_635); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_25 = _T_2 ? $signed(A_0_output_mat_13) : $signed(_GEN_636); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_26 = _T_2 ? $signed(A_0_output_mat_14) : $signed(_GEN_637); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_27 = _T_2 ? $signed(A_0_output_mat_15) : $signed(_GEN_638); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_28 = _T_2 ? $signed(A_1_output_mat_12) : $signed(_GEN_639); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_29 = _T_2 ? $signed(A_1_output_mat_13) : $signed(_GEN_640); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_30 = _T_2 ? $signed(A_1_output_mat_14) : $signed(_GEN_641); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_31 = _T_2 ? $signed(A_1_output_mat_15) : $signed(_GEN_642); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_32 = _T_2 ? $signed(A_2_output_mat_0) : $signed(_GEN_643); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_33 = _T_2 ? $signed(A_2_output_mat_1) : $signed(_GEN_644); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_34 = _T_2 ? $signed(A_2_output_mat_2) : $signed(_GEN_645); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_35 = _T_2 ? $signed(A_2_output_mat_3) : $signed(_GEN_646); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_36 = _T_2 ? $signed(A_3_output_mat_0) : $signed(_GEN_647); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_37 = _T_2 ? $signed(A_3_output_mat_1) : $signed(_GEN_648); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_38 = _T_2 ? $signed(A_3_output_mat_2) : $signed(_GEN_649); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_39 = _T_2 ? $signed(A_3_output_mat_3) : $signed(_GEN_650); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_40 = _T_2 ? $signed(A_2_output_mat_4) : $signed(_GEN_651); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_41 = _T_2 ? $signed(A_2_output_mat_5) : $signed(_GEN_652); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_42 = _T_2 ? $signed(A_2_output_mat_6) : $signed(_GEN_653); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_43 = _T_2 ? $signed(A_2_output_mat_7) : $signed(_GEN_654); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_44 = _T_2 ? $signed(A_3_output_mat_4) : $signed(_GEN_655); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_45 = _T_2 ? $signed(A_3_output_mat_5) : $signed(_GEN_656); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_46 = _T_2 ? $signed(A_3_output_mat_6) : $signed(_GEN_657); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_47 = _T_2 ? $signed(A_3_output_mat_7) : $signed(_GEN_658); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_48 = _T_2 ? $signed(A_2_output_mat_8) : $signed(_GEN_659); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_49 = _T_2 ? $signed(A_2_output_mat_9) : $signed(_GEN_660); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_50 = _T_2 ? $signed(A_2_output_mat_10) : $signed(_GEN_661); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_51 = _T_2 ? $signed(A_2_output_mat_11) : $signed(_GEN_662); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_52 = _T_2 ? $signed(A_3_output_mat_8) : $signed(_GEN_663); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_53 = _T_2 ? $signed(A_3_output_mat_9) : $signed(_GEN_664); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_54 = _T_2 ? $signed(A_3_output_mat_10) : $signed(_GEN_665); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_55 = _T_2 ? $signed(A_3_output_mat_11) : $signed(_GEN_666); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_56 = _T_2 ? $signed(A_2_output_mat_12) : $signed(_GEN_667); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_57 = _T_2 ? $signed(A_2_output_mat_13) : $signed(_GEN_668); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_58 = _T_2 ? $signed(A_2_output_mat_14) : $signed(_GEN_669); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_59 = _T_2 ? $signed(A_2_output_mat_15) : $signed(_GEN_670); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_60 = _T_2 ? $signed(A_3_output_mat_12) : $signed(_GEN_671); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_61 = _T_2 ? $signed(A_3_output_mat_13) : $signed(_GEN_672); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_62 = _T_2 ? $signed(A_3_output_mat_14) : $signed(_GEN_673); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_output_mat_63 = _T_2 ? $signed(A_3_output_mat_15) : $signed(_GEN_674); // @[Conditional.scala 40:58 calc8x8.scala 146:23]
  assign io_valid_out = _T_2 ? A_0_valid_out : _GEN_675; // @[Conditional.scala 40:58 calc8x8.scala 147:26]
  assign Calc6x6_clock = clock;
  assign Calc6x6_reset = reset;
  assign Calc6x6_io_input_mat_0 = _T_2 ? $signed(io_input_mat_0) : $signed(_GEN_398); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_1 = _T_2 ? $signed(io_input_mat_1) : $signed(_GEN_399); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_2 = _T_2 ? $signed(io_input_mat_2) : $signed(_GEN_400); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_3 = _T_2 ? $signed(io_input_mat_3) : $signed(_GEN_401); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_4 = _T_2 ? $signed(16'sh0) : $signed(_GEN_402); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_5 = _T_2 ? $signed(16'sh0) : $signed(_GEN_403); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_6 = _T_2 ? $signed(io_input_mat_8) : $signed(_GEN_404); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_7 = _T_2 ? $signed(io_input_mat_9) : $signed(_GEN_405); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_8 = _T_2 ? $signed(io_input_mat_10) : $signed(_GEN_406); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_9 = _T_2 ? $signed(io_input_mat_11) : $signed(_GEN_407); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_10 = _T_2 ? $signed(16'sh0) : $signed(_GEN_408); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_11 = _T_2 ? $signed(16'sh0) : $signed(_GEN_409); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_12 = _T_2 ? $signed(io_input_mat_16) : $signed(_GEN_410); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_13 = _T_2 ? $signed(io_input_mat_17) : $signed(_GEN_411); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_14 = _T_2 ? $signed(io_input_mat_18) : $signed(_GEN_412); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_15 = _T_2 ? $signed(io_input_mat_19) : $signed(_GEN_413); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_16 = _T_2 ? $signed(16'sh0) : $signed(_GEN_414); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_17 = _T_2 ? $signed(16'sh0) : $signed(_GEN_415); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_18 = _T_2 ? $signed(io_input_mat_24) : $signed(_GEN_416); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_19 = _T_2 ? $signed(io_input_mat_25) : $signed(_GEN_417); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_20 = _T_2 ? $signed(io_input_mat_26) : $signed(_GEN_418); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_21 = _T_2 ? $signed(io_input_mat_27) : $signed(_GEN_419); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_22 = _T_2 ? $signed(16'sh0) : $signed(_GEN_420); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_23 = _T_2 ? $signed(16'sh0) : $signed(_GEN_421); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_24 = _T_2 ? $signed(16'sh0) : $signed(_GEN_422); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_25 = _T_2 ? $signed(16'sh0) : $signed(_GEN_423); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_26 = _T_2 ? $signed(16'sh0) : $signed(_GEN_424); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_27 = _T_2 ? $signed(16'sh0) : $signed(_GEN_425); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_28 = _T_2 ? $signed(16'sh0) : $signed(_GEN_426); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_29 = _T_2 ? $signed(16'sh0) : $signed(_GEN_427); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_30 = _T_2 ? $signed(16'sh0) : $signed(_GEN_428); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_31 = _T_2 ? $signed(16'sh0) : $signed(_GEN_429); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_32 = _T_2 ? $signed(16'sh0) : $signed(_GEN_430); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_33 = _T_2 ? $signed(16'sh0) : $signed(_GEN_431); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_34 = _T_2 ? $signed(16'sh0) : $signed(_GEN_432); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_input_mat_35 = _T_2 ? $signed(16'sh0) : $signed(_GEN_433); // @[Conditional.scala 40:58 calc8x8.scala 138:24]
  assign Calc6x6_io_flag = _T_2 ? 2'h0 : _GEN_558; // @[Conditional.scala 40:58 calc8x8.scala 143:27]
  assign Calc6x6_io_weight_real_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_542); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_543); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_544); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_545); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_546); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_547); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_548); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_549); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_550); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_551); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_10 = _T_2 ? $signed(18'sh0) : $signed(_GEN_552); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_11 = _T_2 ? $signed(18'sh0) : $signed(_GEN_553); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_12 = _T_2 ? $signed(18'sh0) : $signed(_GEN_554); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_13 = _T_2 ? $signed(18'sh0) : $signed(_GEN_555); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_14 = _T_2 ? $signed(18'sh0) : $signed(_GEN_556); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_real_15 = _T_2 ? $signed(18'sh0) : $signed(_GEN_557); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp1_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_696); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp1_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_697); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp1_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_698); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp1_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_699); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp1_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_700); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp1_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_701); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp1_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_702); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp1_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_703); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp1_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_704); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp1_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_705); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp2_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_686); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp2_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_687); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp2_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_688); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp2_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_689); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp2_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_690); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp2_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_691); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp2_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_692); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp2_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_693); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp2_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_694); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp2_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_695); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp3_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_676); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp3_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_677); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp3_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_678); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp3_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_679); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp3_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_680); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp3_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_681); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp3_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_682); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp3_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_683); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp3_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_684); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_weight_comp3_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_685); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_io_valid_in = _T_2 ? io_valid_in : _GEN_559; // @[Conditional.scala 40:58 calc8x8.scala 144:31]
  assign Calc6x6_1_clock = clock;
  assign Calc6x6_1_reset = reset;
  assign Calc6x6_1_io_input_mat_0 = _T_2 ? $signed(io_input_mat_3) : $signed(_GEN_434); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_1 = _T_2 ? $signed(io_input_mat_4) : $signed(_GEN_435); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_2 = _T_2 ? $signed(io_input_mat_5) : $signed(_GEN_436); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_3 = _T_2 ? $signed(io_input_mat_6) : $signed(_GEN_437); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_4 = _T_2 ? $signed(io_input_mat_7) : $signed(_GEN_438); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_5 = _T_2 ? $signed(16'sh0) : $signed(_GEN_439); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_6 = _T_2 ? $signed(io_input_mat_11) : $signed(_GEN_440); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_7 = _T_2 ? $signed(io_input_mat_12) : $signed(_GEN_441); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_8 = _T_2 ? $signed(io_input_mat_13) : $signed(_GEN_442); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_9 = _T_2 ? $signed(io_input_mat_14) : $signed(_GEN_443); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_10 = _T_2 ? $signed(io_input_mat_15) : $signed(_GEN_444); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_11 = _T_2 ? $signed(16'sh0) : $signed(_GEN_445); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_12 = _T_2 ? $signed(io_input_mat_19) : $signed(_GEN_446); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_13 = _T_2 ? $signed(io_input_mat_20) : $signed(_GEN_447); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_14 = _T_2 ? $signed(io_input_mat_21) : $signed(_GEN_448); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_15 = _T_2 ? $signed(io_input_mat_22) : $signed(_GEN_449); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_16 = _T_2 ? $signed(io_input_mat_23) : $signed(_GEN_450); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_17 = _T_2 ? $signed(16'sh0) : $signed(_GEN_451); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_18 = _T_2 ? $signed(io_input_mat_27) : $signed(_GEN_452); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_19 = _T_2 ? $signed(io_input_mat_28) : $signed(_GEN_453); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_20 = _T_2 ? $signed(io_input_mat_29) : $signed(_GEN_454); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_21 = _T_2 ? $signed(io_input_mat_30) : $signed(_GEN_455); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_22 = _T_2 ? $signed(io_input_mat_31) : $signed(_GEN_456); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_23 = _T_2 ? $signed(16'sh0) : $signed(_GEN_457); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_24 = _T_2 ? $signed(16'sh0) : $signed(_GEN_426); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_25 = _T_2 ? $signed(16'sh0) : $signed(_GEN_427); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_26 = _T_2 ? $signed(16'sh0) : $signed(_GEN_460); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_27 = _T_2 ? $signed(16'sh0) : $signed(_GEN_461); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_28 = _T_2 ? $signed(16'sh0) : $signed(_GEN_462); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_29 = _T_2 ? $signed(16'sh0) : $signed(_GEN_463); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_30 = _T_2 ? $signed(16'sh0) : $signed(_GEN_432); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_31 = _T_2 ? $signed(16'sh0) : $signed(_GEN_433); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_32 = _T_2 ? $signed(16'sh0) : $signed(_GEN_466); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_33 = _T_2 ? $signed(16'sh0) : $signed(_GEN_467); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_34 = _T_2 ? $signed(16'sh0) : $signed(_GEN_468); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_input_mat_35 = _T_2 ? $signed(16'sh0) : $signed(_GEN_469); // @[Conditional.scala 40:58 calc8x8.scala 139:24]
  assign Calc6x6_1_io_flag = _T_2 ? 2'h0 : _GEN_558; // @[Conditional.scala 40:58 calc8x8.scala 143:27]
  assign Calc6x6_1_io_weight_real_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_560); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_561); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_562); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_563); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_564); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_565); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_566); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_567); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_568); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_569); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_10 = _T_2 ? $signed(18'sh0) : $signed(_GEN_570); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_11 = _T_2 ? $signed(18'sh0) : $signed(_GEN_571); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_12 = _T_2 ? $signed(18'sh0) : $signed(_GEN_572); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_13 = _T_2 ? $signed(18'sh0) : $signed(_GEN_573); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_14 = _T_2 ? $signed(18'sh0) : $signed(_GEN_574); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_real_15 = _T_2 ? $signed(18'sh0) : $signed(_GEN_575); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp1_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_696); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp1_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_697); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp1_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_698); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp1_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_699); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp1_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_700); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp1_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_701); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp1_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_702); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp1_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_703); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp1_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_704); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp1_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_705); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp2_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_686); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp2_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_687); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp2_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_688); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp2_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_689); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp2_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_690); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp2_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_691); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp2_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_692); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp2_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_693); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp2_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_694); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp2_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_695); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp3_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_676); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp3_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_677); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp3_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_678); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp3_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_679); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp3_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_680); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp3_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_681); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp3_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_682); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp3_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_683); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp3_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_684); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_weight_comp3_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_685); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_1_io_valid_in = _T_2 ? io_valid_in : _GEN_559; // @[Conditional.scala 40:58 calc8x8.scala 144:31]
  assign Calc6x6_2_clock = clock;
  assign Calc6x6_2_reset = reset;
  assign Calc6x6_2_io_input_mat_0 = _T_2 ? $signed(io_input_mat_24) : $signed(_GEN_470); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_1 = _T_2 ? $signed(io_input_mat_25) : $signed(_GEN_471); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_2 = _T_2 ? $signed(io_input_mat_26) : $signed(_GEN_472); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_3 = _T_2 ? $signed(io_input_mat_27) : $signed(_GEN_473); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_4 = _T_2 ? $signed(16'sh0) : $signed(_GEN_426); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_5 = _T_2 ? $signed(16'sh0) : $signed(_GEN_427); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_6 = _T_2 ? $signed(io_input_mat_32) : $signed(_GEN_476); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_7 = _T_2 ? $signed(io_input_mat_33) : $signed(_GEN_477); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_8 = _T_2 ? $signed(io_input_mat_34) : $signed(_GEN_478); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_9 = _T_2 ? $signed(io_input_mat_35) : $signed(_GEN_479); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_10 = _T_2 ? $signed(16'sh0) : $signed(_GEN_432); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_11 = _T_2 ? $signed(16'sh0) : $signed(_GEN_433); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_12 = _T_2 ? $signed(io_input_mat_40) : $signed(_GEN_482); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_13 = _T_2 ? $signed(io_input_mat_41) : $signed(_GEN_483); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_14 = _T_2 ? $signed(io_input_mat_42) : $signed(_GEN_484); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_15 = _T_2 ? $signed(io_input_mat_43) : $signed(_GEN_485); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_16 = _T_2 ? $signed(16'sh0) : $signed(_GEN_486); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_17 = _T_2 ? $signed(16'sh0) : $signed(_GEN_487); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_18 = _T_2 ? $signed(io_input_mat_48) : $signed(_GEN_488); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_19 = _T_2 ? $signed(io_input_mat_49) : $signed(_GEN_489); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_20 = _T_2 ? $signed(io_input_mat_50) : $signed(_GEN_490); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_21 = _T_2 ? $signed(io_input_mat_51) : $signed(_GEN_491); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_22 = _T_2 ? $signed(16'sh0) : $signed(_GEN_492); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_23 = _T_2 ? $signed(16'sh0) : $signed(_GEN_493); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_24 = _T_2 ? $signed(io_input_mat_56) : $signed(_GEN_494); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_25 = _T_2 ? $signed(io_input_mat_57) : $signed(_GEN_495); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_26 = _T_2 ? $signed(io_input_mat_58) : $signed(_GEN_496); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_27 = _T_2 ? $signed(io_input_mat_59) : $signed(_GEN_497); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_28 = _T_2 ? $signed(16'sh0) : $signed(_GEN_498); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_29 = _T_2 ? $signed(16'sh0) : $signed(_GEN_499); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_30 = _T_2 ? $signed(16'sh0) : $signed(_GEN_500); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_31 = _T_2 ? $signed(16'sh0) : $signed(_GEN_501); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_32 = _T_2 ? $signed(16'sh0) : $signed(_GEN_502); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_33 = _T_2 ? $signed(16'sh0) : $signed(_GEN_503); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_34 = _T_2 ? $signed(16'sh0) : $signed(_GEN_504); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_input_mat_35 = _T_2 ? $signed(16'sh0) : $signed(_GEN_505); // @[Conditional.scala 40:58 calc8x8.scala 140:24]
  assign Calc6x6_2_io_flag = _T_2 ? 2'h0 : _GEN_558; // @[Conditional.scala 40:58 calc8x8.scala 143:27]
  assign Calc6x6_2_io_weight_real_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_577); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_578); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_579); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_580); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_581); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_582); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_583); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_584); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_585); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_586); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_10 = _T_2 ? $signed(18'sh0) : $signed(_GEN_587); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_11 = _T_2 ? $signed(18'sh0) : $signed(_GEN_588); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_12 = _T_2 ? $signed(18'sh0) : $signed(_GEN_589); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_13 = _T_2 ? $signed(18'sh0) : $signed(_GEN_590); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_14 = _T_2 ? $signed(18'sh0) : $signed(_GEN_591); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_real_15 = _T_2 ? $signed(18'sh0) : $signed(_GEN_592); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp1_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_696); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp1_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_697); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp1_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_698); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp1_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_699); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp1_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_700); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp1_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_701); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp1_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_702); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp1_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_703); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp1_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_704); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp1_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_705); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp2_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_686); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp2_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_687); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp2_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_688); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp2_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_689); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp2_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_690); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp2_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_691); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp2_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_692); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp2_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_693); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp2_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_694); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp2_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_695); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp3_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_676); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp3_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_677); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp3_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_678); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp3_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_679); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp3_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_680); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp3_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_681); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp3_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_682); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp3_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_683); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp3_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_684); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_weight_comp3_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_685); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_2_io_valid_in = _T_2 ? io_valid_in : _GEN_559; // @[Conditional.scala 40:58 calc8x8.scala 144:31]
  assign Calc6x6_3_clock = clock;
  assign Calc6x6_3_reset = reset;
  assign Calc6x6_3_io_input_mat_0 = _T_2 ? $signed(io_input_mat_27) : $signed(_GEN_506); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_1 = _T_2 ? $signed(io_input_mat_28) : $signed(_GEN_507); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_2 = _T_2 ? $signed(io_input_mat_29) : $signed(_GEN_508); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_3 = _T_2 ? $signed(io_input_mat_30) : $signed(_GEN_509); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_4 = _T_2 ? $signed(io_input_mat_31) : $signed(_GEN_510); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_5 = _T_2 ? $signed(16'sh0) : $signed(_GEN_463); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_6 = _T_2 ? $signed(io_input_mat_35) : $signed(_GEN_512); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_7 = _T_2 ? $signed(io_input_mat_36) : $signed(_GEN_513); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_8 = _T_2 ? $signed(io_input_mat_37) : $signed(_GEN_514); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_9 = _T_2 ? $signed(io_input_mat_38) : $signed(_GEN_515); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_10 = _T_2 ? $signed(io_input_mat_39) : $signed(_GEN_516); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_11 = _T_2 ? $signed(16'sh0) : $signed(_GEN_469); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_12 = _T_2 ? $signed(io_input_mat_43) : $signed(_GEN_518); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_13 = _T_2 ? $signed(io_input_mat_44) : $signed(_GEN_519); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_14 = _T_2 ? $signed(io_input_mat_45) : $signed(_GEN_520); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_15 = _T_2 ? $signed(io_input_mat_46) : $signed(_GEN_521); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_16 = _T_2 ? $signed(io_input_mat_47) : $signed(_GEN_522); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_17 = _T_2 ? $signed(16'sh0) : $signed(_GEN_523); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_18 = _T_2 ? $signed(io_input_mat_51) : $signed(_GEN_524); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_19 = _T_2 ? $signed(io_input_mat_52) : $signed(_GEN_525); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_20 = _T_2 ? $signed(io_input_mat_53) : $signed(_GEN_526); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_21 = _T_2 ? $signed(io_input_mat_54) : $signed(_GEN_527); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_22 = _T_2 ? $signed(io_input_mat_55) : $signed(_GEN_528); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_23 = _T_2 ? $signed(16'sh0) : $signed(_GEN_529); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_24 = _T_2 ? $signed(io_input_mat_59) : $signed(_GEN_530); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_25 = _T_2 ? $signed(io_input_mat_60) : $signed(_GEN_531); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_26 = _T_2 ? $signed(io_input_mat_61) : $signed(_GEN_532); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_27 = _T_2 ? $signed(io_input_mat_62) : $signed(_GEN_533); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_28 = _T_2 ? $signed(io_input_mat_63) : $signed(_GEN_534); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_29 = _T_2 ? $signed(16'sh0) : $signed(_GEN_535); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_30 = _T_2 ? $signed(16'sh0) : $signed(_GEN_504); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_31 = _T_2 ? $signed(16'sh0) : $signed(_GEN_505); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_32 = _T_2 ? $signed(16'sh0) : $signed(_GEN_538); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_33 = _T_2 ? $signed(16'sh0) : $signed(_GEN_539); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_34 = _T_2 ? $signed(16'sh0) : $signed(_GEN_540); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_input_mat_35 = _T_2 ? $signed(16'sh0) : $signed(_GEN_541); // @[Conditional.scala 40:58 calc8x8.scala 141:24]
  assign Calc6x6_3_io_flag = _T_2 ? 2'h0 : _GEN_558; // @[Conditional.scala 40:58 calc8x8.scala 143:27]
  assign Calc6x6_3_io_weight_real_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_594); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_595); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_596); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_597); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_598); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_599); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_600); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_601); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_602); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_603); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_10 = _T_2 ? $signed(18'sh0) : $signed(_GEN_604); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_11 = _T_2 ? $signed(18'sh0) : $signed(_GEN_605); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_12 = _T_2 ? $signed(18'sh0) : $signed(_GEN_606); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_13 = _T_2 ? $signed(18'sh0) : $signed(_GEN_607); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_14 = _T_2 ? $signed(18'sh0) : $signed(_GEN_608); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_real_15 = _T_2 ? $signed(18'sh0) : $signed(_GEN_609); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp1_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_696); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp1_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_697); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp1_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_698); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp1_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_699); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp1_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_700); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp1_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_701); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp1_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_702); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp1_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_703); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp1_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_704); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp1_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_705); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp2_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_686); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp2_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_687); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp2_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_688); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp2_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_689); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp2_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_690); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp2_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_691); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp2_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_692); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp2_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_693); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp2_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_694); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp2_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_695); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp3_0 = _T_2 ? $signed(18'sh0) : $signed(_GEN_676); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp3_1 = _T_2 ? $signed(18'sh0) : $signed(_GEN_677); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp3_2 = _T_2 ? $signed(18'sh0) : $signed(_GEN_678); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp3_3 = _T_2 ? $signed(18'sh0) : $signed(_GEN_679); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp3_4 = _T_2 ? $signed(18'sh0) : $signed(_GEN_680); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp3_5 = _T_2 ? $signed(18'sh0) : $signed(_GEN_681); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp3_6 = _T_2 ? $signed(18'sh0) : $signed(_GEN_682); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp3_7 = _T_2 ? $signed(18'sh0) : $signed(_GEN_683); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp3_8 = _T_2 ? $signed(18'sh0) : $signed(_GEN_684); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_weight_comp3_9 = _T_2 ? $signed(18'sh0) : $signed(_GEN_685); // @[Conditional.scala 40:58 calc8x8.scala 63:21]
  assign Calc6x6_3_io_valid_in = _T_2 ? io_valid_in : _GEN_559; // @[Conditional.scala 40:58 calc8x8.scala 144:31]
  always @(posedge clock) begin
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_0_0 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_0_0 <= {{2{io_weight_0_real_0[15]}},io_weight_0_real_0}; // @[calc8x8.scala 78:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_0_1 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_0_1 <= {{2{io_weight_0_real_1[15]}},io_weight_0_real_1}; // @[calc8x8.scala 78:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_0_2 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_0_2 <= {{2{io_weight_0_real_2[15]}},io_weight_0_real_2}; // @[calc8x8.scala 78:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_1_0 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_1_0 <= {{2{__B_1_0_T_5[15]}},__B_1_0_T_5}; // @[calc8x8.scala 79:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_1_1 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_1_1 <= {{2{__B_1_1_T_5[15]}},__B_1_1_T_5}; // @[calc8x8.scala 79:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_1_2 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_1_2 <= {{2{__B_1_2_T_5[15]}},__B_1_2_T_5}; // @[calc8x8.scala 79:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_2_0 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_2_0 <= {{2{__B_2_0_T_5[15]}},__B_2_0_T_5}; // @[calc8x8.scala 80:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_2_1 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_2_1 <= {{2{__B_2_1_T_5[15]}},__B_2_1_T_5}; // @[calc8x8.scala 80:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_2_2 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_2_2 <= {{2{__B_2_2_T_5[15]}},__B_2_2_T_5}; // @[calc8x8.scala 80:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_3_0 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_3_0 <= {{2{__B_3_0_T_2[15]}},__B_3_0_T_2}; // @[calc8x8.scala 81:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_3_1 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_3_1 <= {{2{__B_3_1_T_2[15]}},__B_3_1_T_2}; // @[calc8x8.scala 81:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_3_2 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_3_2 <= {{2{__B_3_2_T_2[15]}},__B_3_2_T_2}; // @[calc8x8.scala 81:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_5_0 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_5_0 <= {{2{io_weight_0_real_6[15]}},io_weight_0_real_6}; // @[calc8x8.scala 83:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_5_1 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_5_1 <= {{2{io_weight_0_real_7[15]}},io_weight_0_real_7}; // @[calc8x8.scala 83:18]
    end
    if (reset) begin // @[calc8x8.scala 71:21]
      _B_5_2 <= 18'sh0; // @[calc8x8.scala 71:21]
    end else begin
      _B_5_2 <= {{2{io_weight_0_real_8[15]}},io_weight_0_real_8}; // @[calc8x8.scala 83:18]
    end
    if (reset) begin // @[calc8x8.scala 72:22]
      _Bi_3_0 <= 18'sh0; // @[calc8x8.scala 72:22]
    end else begin
      _Bi_3_0 <= {{2{io_weight_0_real_3[15]}},io_weight_0_real_3}; // @[calc8x8.scala 84:19]
    end
    if (reset) begin // @[calc8x8.scala 72:22]
      _Bi_3_1 <= 18'sh0; // @[calc8x8.scala 72:22]
    end else begin
      _Bi_3_1 <= {{2{io_weight_0_real_4[15]}},io_weight_0_real_4}; // @[calc8x8.scala 84:19]
    end
    if (reset) begin // @[calc8x8.scala 72:22]
      _Bi_3_2 <= 18'sh0; // @[calc8x8.scala 72:22]
    end else begin
      _Bi_3_2 <= {{2{io_weight_0_real_5[15]}},io_weight_0_real_5}; // @[calc8x8.scala 84:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_0_0 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_0_0 <= {{1{_B_0_0[17]}},_B_0_0}; // @[calc8x8.scala 93:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_0_1 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_0_1 <= {{1{___B_0_1_T_5[17]}},___B_0_1_T_5}; // @[calc8x8.scala 94:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_0_2 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_0_2 <= {{1{___B_0_2_T_5[17]}},___B_0_2_T_5}; // @[calc8x8.scala 95:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_0_3 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_0_3 <= {{1{___B_0_3_T_5[17]}},___B_0_3_T_5}; // @[calc8x8.scala 96:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_0_5 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_0_5 <= {{1{_B_0_2[17]}},_B_0_2}; // @[calc8x8.scala 98:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_1_0 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_1_0 <= {{1{_B_1_0[17]}},_B_1_0}; // @[calc8x8.scala 93:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_1_1 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_1_1 <= {{1{___B_1_1_T_5[17]}},___B_1_1_T_5}; // @[calc8x8.scala 94:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_1_2 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_1_2 <= {{1{___B_1_2_T_5[17]}},___B_1_2_T_5}; // @[calc8x8.scala 95:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_1_3 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_1_3 <= {{1{___B_1_3_T_5[17]}},___B_1_3_T_5}; // @[calc8x8.scala 96:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_1_5 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_1_5 <= {{1{_B_1_2[17]}},_B_1_2}; // @[calc8x8.scala 98:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_2_0 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_2_0 <= {{1{_B_2_0[17]}},_B_2_0}; // @[calc8x8.scala 93:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_2_1 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_2_1 <= {{1{___B_2_1_T_5[17]}},___B_2_1_T_5}; // @[calc8x8.scala 94:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_2_2 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_2_2 <= {{1{___B_2_2_T_5[17]}},___B_2_2_T_5}; // @[calc8x8.scala 95:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_2_3 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_2_3 <= {{1{___B_2_3_T_5[17]}},___B_2_3_T_5}; // @[calc8x8.scala 96:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_2_5 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_2_5 <= {{1{_B_2_2[17]}},_B_2_2}; // @[calc8x8.scala 98:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_3_0 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_3_0 <= {{1{_B_3_0[17]}},_B_3_0}; // @[calc8x8.scala 93:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_3_1 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_3_1 <= {{1{___B_3_1_T_5[17]}},___B_3_1_T_5}; // @[calc8x8.scala 94:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_3_2 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_3_2 <= {{1{___B_3_2_T_5[17]}},___B_3_2_T_5}; // @[calc8x8.scala 95:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_3_3 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_3_3 <= {{1{___B_3_3_T_5[17]}},___B_3_3_T_5}; // @[calc8x8.scala 96:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_3_4 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_3_4 <= {{1{___B_3_4_T_5[17]}},___B_3_4_T_5}; // @[calc8x8.scala 97:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_3_5 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_3_5 <= {{1{_B_3_2[17]}},_B_3_2}; // @[calc8x8.scala 98:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_5_0 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_5_0 <= {{1{_B_5_0[17]}},_B_5_0}; // @[calc8x8.scala 93:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_5_1 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_5_1 <= {{1{___B_5_1_T_5[17]}},___B_5_1_T_5}; // @[calc8x8.scala 94:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_5_2 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_5_2 <= {{1{___B_5_2_T_5[17]}},___B_5_2_T_5}; // @[calc8x8.scala 95:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_5_3 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_5_3 <= {{1{___B_5_3_T_5[17]}},___B_5_3_T_5}; // @[calc8x8.scala 96:19]
    end
    if (reset) begin // @[calc8x8.scala 89:22]
      __B_5_5 <= 19'sh0; // @[calc8x8.scala 89:22]
    end else begin
      __B_5_5 <= {{1{_B_5_2[17]}},_B_5_2}; // @[calc8x8.scala 98:19]
    end
    if (reset) begin // @[calc8x8.scala 90:23]
      __Bi_0_3 <= 19'sh0; // @[calc8x8.scala 90:23]
    end else begin
      __Bi_0_3 <= {{1{___Bi_0_3_T_5[17]}},___Bi_0_3_T_5}; // @[calc8x8.scala 102:20]
    end
    if (reset) begin // @[calc8x8.scala 90:23]
      __Bi_1_3 <= 19'sh0; // @[calc8x8.scala 90:23]
    end else begin
      __Bi_1_3 <= {{1{___Bi_1_3_T_5[17]}},___Bi_1_3_T_5}; // @[calc8x8.scala 102:20]
    end
    if (reset) begin // @[calc8x8.scala 90:23]
      __Bi_2_3 <= 19'sh0; // @[calc8x8.scala 90:23]
    end else begin
      __Bi_2_3 <= {{1{___Bi_2_3_T_5[17]}},___Bi_2_3_T_5}; // @[calc8x8.scala 102:20]
    end
    if (reset) begin // @[calc8x8.scala 90:23]
      __Bi_3_0 <= 19'sh0; // @[calc8x8.scala 90:23]
    end else begin
      __Bi_3_0 <= {{1{_Bi_3_0[17]}},_Bi_3_0}; // @[calc8x8.scala 99:20]
    end
    if (reset) begin // @[calc8x8.scala 90:23]
      __Bi_3_1 <= 19'sh0; // @[calc8x8.scala 90:23]
    end else begin
      __Bi_3_1 <= {{1{___Bi_3_1_T_5[17]}},___Bi_3_1_T_5}; // @[calc8x8.scala 100:20]
    end
    if (reset) begin // @[calc8x8.scala 90:23]
      __Bi_3_2 <= 19'sh0; // @[calc8x8.scala 90:23]
    end else begin
      __Bi_3_2 <= {{1{___Bi_3_2_T_5[17]}},___Bi_3_2_T_5}; // @[calc8x8.scala 101:20]
    end
    if (reset) begin // @[calc8x8.scala 90:23]
      __Bi_3_3 <= 19'sh0; // @[calc8x8.scala 90:23]
    end else begin
      __Bi_3_3 <= {{1{___Bi_3_3_T_5[17]}},___Bi_3_3_T_5}; // @[calc8x8.scala 102:20]
    end
    if (reset) begin // @[calc8x8.scala 90:23]
      __Bi_3_4 <= 19'sh0; // @[calc8x8.scala 90:23]
    end else begin
      __Bi_3_4 <= {{1{___Bi_3_4_T_5[17]}},___Bi_3_4_T_5}; // @[calc8x8.scala 103:20]
    end
    if (reset) begin // @[calc8x8.scala 90:23]
      __Bi_3_5 <= 19'sh0; // @[calc8x8.scala 90:23]
    end else begin
      __Bi_3_5 <= {{1{_Bi_3_2[17]}},_Bi_3_2}; // @[calc8x8.scala 104:20]
    end
    if (reset) begin // @[calc8x8.scala 90:23]
      __Bi_5_3 <= 19'sh0; // @[calc8x8.scala 90:23]
    end else begin
      __Bi_5_3 <= {{1{___Bi_5_3_T_5[17]}},___Bi_5_3_T_5}; // @[calc8x8.scala 102:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  _B_0_0 = _RAND_0[17:0];
  _RAND_1 = {1{`RANDOM}};
  _B_0_1 = _RAND_1[17:0];
  _RAND_2 = {1{`RANDOM}};
  _B_0_2 = _RAND_2[17:0];
  _RAND_3 = {1{`RANDOM}};
  _B_1_0 = _RAND_3[17:0];
  _RAND_4 = {1{`RANDOM}};
  _B_1_1 = _RAND_4[17:0];
  _RAND_5 = {1{`RANDOM}};
  _B_1_2 = _RAND_5[17:0];
  _RAND_6 = {1{`RANDOM}};
  _B_2_0 = _RAND_6[17:0];
  _RAND_7 = {1{`RANDOM}};
  _B_2_1 = _RAND_7[17:0];
  _RAND_8 = {1{`RANDOM}};
  _B_2_2 = _RAND_8[17:0];
  _RAND_9 = {1{`RANDOM}};
  _B_3_0 = _RAND_9[17:0];
  _RAND_10 = {1{`RANDOM}};
  _B_3_1 = _RAND_10[17:0];
  _RAND_11 = {1{`RANDOM}};
  _B_3_2 = _RAND_11[17:0];
  _RAND_12 = {1{`RANDOM}};
  _B_5_0 = _RAND_12[17:0];
  _RAND_13 = {1{`RANDOM}};
  _B_5_1 = _RAND_13[17:0];
  _RAND_14 = {1{`RANDOM}};
  _B_5_2 = _RAND_14[17:0];
  _RAND_15 = {1{`RANDOM}};
  _Bi_3_0 = _RAND_15[17:0];
  _RAND_16 = {1{`RANDOM}};
  _Bi_3_1 = _RAND_16[17:0];
  _RAND_17 = {1{`RANDOM}};
  _Bi_3_2 = _RAND_17[17:0];
  _RAND_18 = {1{`RANDOM}};
  __B_0_0 = _RAND_18[18:0];
  _RAND_19 = {1{`RANDOM}};
  __B_0_1 = _RAND_19[18:0];
  _RAND_20 = {1{`RANDOM}};
  __B_0_2 = _RAND_20[18:0];
  _RAND_21 = {1{`RANDOM}};
  __B_0_3 = _RAND_21[18:0];
  _RAND_22 = {1{`RANDOM}};
  __B_0_5 = _RAND_22[18:0];
  _RAND_23 = {1{`RANDOM}};
  __B_1_0 = _RAND_23[18:0];
  _RAND_24 = {1{`RANDOM}};
  __B_1_1 = _RAND_24[18:0];
  _RAND_25 = {1{`RANDOM}};
  __B_1_2 = _RAND_25[18:0];
  _RAND_26 = {1{`RANDOM}};
  __B_1_3 = _RAND_26[18:0];
  _RAND_27 = {1{`RANDOM}};
  __B_1_5 = _RAND_27[18:0];
  _RAND_28 = {1{`RANDOM}};
  __B_2_0 = _RAND_28[18:0];
  _RAND_29 = {1{`RANDOM}};
  __B_2_1 = _RAND_29[18:0];
  _RAND_30 = {1{`RANDOM}};
  __B_2_2 = _RAND_30[18:0];
  _RAND_31 = {1{`RANDOM}};
  __B_2_3 = _RAND_31[18:0];
  _RAND_32 = {1{`RANDOM}};
  __B_2_5 = _RAND_32[18:0];
  _RAND_33 = {1{`RANDOM}};
  __B_3_0 = _RAND_33[18:0];
  _RAND_34 = {1{`RANDOM}};
  __B_3_1 = _RAND_34[18:0];
  _RAND_35 = {1{`RANDOM}};
  __B_3_2 = _RAND_35[18:0];
  _RAND_36 = {1{`RANDOM}};
  __B_3_3 = _RAND_36[18:0];
  _RAND_37 = {1{`RANDOM}};
  __B_3_4 = _RAND_37[18:0];
  _RAND_38 = {1{`RANDOM}};
  __B_3_5 = _RAND_38[18:0];
  _RAND_39 = {1{`RANDOM}};
  __B_5_0 = _RAND_39[18:0];
  _RAND_40 = {1{`RANDOM}};
  __B_5_1 = _RAND_40[18:0];
  _RAND_41 = {1{`RANDOM}};
  __B_5_2 = _RAND_41[18:0];
  _RAND_42 = {1{`RANDOM}};
  __B_5_3 = _RAND_42[18:0];
  _RAND_43 = {1{`RANDOM}};
  __B_5_5 = _RAND_43[18:0];
  _RAND_44 = {1{`RANDOM}};
  __Bi_0_3 = _RAND_44[18:0];
  _RAND_45 = {1{`RANDOM}};
  __Bi_1_3 = _RAND_45[18:0];
  _RAND_46 = {1{`RANDOM}};
  __Bi_2_3 = _RAND_46[18:0];
  _RAND_47 = {1{`RANDOM}};
  __Bi_3_0 = _RAND_47[18:0];
  _RAND_48 = {1{`RANDOM}};
  __Bi_3_1 = _RAND_48[18:0];
  _RAND_49 = {1{`RANDOM}};
  __Bi_3_2 = _RAND_49[18:0];
  _RAND_50 = {1{`RANDOM}};
  __Bi_3_3 = _RAND_50[18:0];
  _RAND_51 = {1{`RANDOM}};
  __Bi_3_4 = _RAND_51[18:0];
  _RAND_52 = {1{`RANDOM}};
  __Bi_3_5 = _RAND_52[18:0];
  _RAND_53 = {1{`RANDOM}};
  __Bi_5_3 = _RAND_53[18:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
