read_verilog designs/RCA/fa.v
read_verilog designs/RCA/rca.v

# Set top module
hierarchy -check -top rca

# Generic synthesis
synth -top rca

# Map flip-flops
dfflibmap -liberty /home/harshithr7/.ciel/ciel/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_100C_1v65.lib

# Logic optimization and mapping to gates
abc -liberty /home/harshithr7/.ciel/ciel/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_100C_1v65.lib

# Clean intermediate names
clean

# Write final gate-level netlist
write_verilog designs/RCA/rca_gatelevel.v
