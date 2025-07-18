# Yosys - https://yosyshq.readthedocs.io/projects/yosys/en/latest/introduction.html
Yosys is used for synthesis in the ASIC Design flow targetting the SkyWater 130nmmPDK. Yosys is a Verilog HDL synthesis tool. This means that it takes a behavioural design description as input and generates an RTL, logical gate or physical gate level description of the design as output. Yosys’ main strengths are behavioural and RTL synthesis.we can couple yosys with place and route tool nextpnr with fully end-to-end FPGA Design flow(Lattice iCE40 and ECP5).
* A commercial extension, Tabby CAD Suite, includes the Verific frontend for industry-grade SystemVerilog and VHDL support, formal verification with SVA, and formal apps.
# What Yosys can do
* Perform logic optimizations(https://yosyshq.readthedocs.io/projects/yosys/en/latest/using_yosys/synthesis/opt.html) and gate mapping(Translating optimized logic into a form that can be implemented on a target architecture) with ABC (A Berkeley Compiler).
* Read and process modern verilog-2005 code.
* perform all kinds of operations on netlist.
