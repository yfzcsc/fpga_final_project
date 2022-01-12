# fpga-npu-final-project

The final project of Introduction to Artificial Intelligence Chip：From Verilog to FPGA （人工智能芯片入门：从硬件描述语言到FPGA实现）in Tsinghua University.

An NPU by chisel 3.4.3.

It supports to calculate leakyReLU, 2D convolution by F(6x6, 3x3) winograd transform, Maxpool, Upsample. 

It can run at 125MHz or more on Xilinx Zynq7000 xc7z035 ffg676.

## Requirements

* sbt

## Usage


To generate verilog: `sbt "runMain  final_project.XDriver"`

To test some modules: `sbt "test"`

where `X` is a class in `top/emit.scala`. The target directory can be modified.

## Documentation

终期报告.docx
