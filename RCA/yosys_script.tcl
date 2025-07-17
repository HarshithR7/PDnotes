read_verilog designs/RCA/fa.v
read_verilog designs/RCA/rca.v
read_verilog -D ICE40_HX -lib -specify +/ice40/cells_sim.v   # loads ice40 cell models
hierarchy -check -top rca
proc  # sub-commands work to convert the behavioral logic of processes into multiplexers and registers. (Internal representation) - convert processes to netlist
# always @. The if statements are now modeled with $mux cells, while the register uses an $adff
clean # not synthesizable, wires not connected cleaned up
opt_expr  #  performs constant folding and simple expression rewriting. 
show -format dot -prefix rca_show rca  # generates dot schematic file using Graphviz
# dot -Tsvg rca_show.dot -o rca_schematic.svg # convert to svg and see schematic file

# Flattening
flatten;; # it makes 1 top module, removes sub modules
tribuf -logic # tri-state constructs replaced with logic suitable for the model
deminout # replace in-out constructs to input or outputs

# Coarse grain representation - ICE40 flow starts
# This is also where we convert our FSMs and hard blocks like DSPs or memories. Such elements have to be inferred from patterns in the design.
opt_expr
opt_clean # removes unused cells or wires
check # checks for obvious problems
opt -nodffe -nosdff # do not optimize or remove dff with enable or scan dff
fsm # detects fsm structure
opt # optimize FSMs
opt_dff #  fold mux cells to dff cell

# Series of Optimization
wreduce # reducing word size of cells
peepopt # run peephole optimizers
opt_clean
share # SAT-based resource sharing
techmap -map +/cmp2lut.v -D LUT_WIDTH=4 # map to technology primitives LUTs
opt_expr # perform const folding
opt_clean
memory_dff # merging $dff cells to $memrd [-no-rw-checks]

# Mapping to DSPs
# check https://yosyshq.readthedocs.io/projects/yosys/en/latest/getting_started/example_synth.html

# final
alumacc # create $alu and $macc cells , help in reusing logic
opt
memory -nomap # convert mux to ROMs, consolidate read/write and more
opt_clean


# synth_ice40 -top fifo -run :map_ram 
# -run <from_label>:<to_label> option with an empty <from_label> starts from the begin section, while the <to_label> runs up to but including the map_ram section.

#
opt -fast -mux_undef -undriven -fine
memory_map  # converts leftover memory cells to FFs
opt -undriven -fine

# Arithmetic
ice40_wrapcarry
techmap -map +/techmap.v -map +/ice40/arith_map.v
opt -fast
#abc -dff -D 1    (only if -retime)
ice40_opt

# FFs
dfflegalize -cell $_DFF_?_ 0 -cell $_DFFE_?P_ 0 -cell $_DFF_?P?_ 0 -cell $_DFFE_?P?P_ 0 -cell $_SDFF_?P?_ 0 -cell $_SDFFCE_?P?P_ 0 -cell $_DLATCH_?_ x -mince -1
# convert FFs to supported types of the target
techmap -map +/ice40/ff_map.v # Mapping
opt_expr -mux_undef 
simplemap # map simple cells to gate primitives
ice40_opt -full

# LUTs
techmap -map +/ice40/latches_map.v # map to tech primitives
read_verilog -D ICE40_HX -icells -lib -specify +/ice40/abc9_model.v
abc9 -W 250 
ice40_wrapcarry -unwrap
techmap -map +/ice40/ff_map.v
clean

# Finally we use techmap to map the generic $lut cells to iCE40 SB_LUT4 cells
techmap -map +/ice40/cells_map.v
clean


# Final Steps
autoname # automatically assigns names to objects
hierarchy -check
stat # print some Statistics
check -noinit
#bloackbox =A:whitebox # convert modules into blackbox modules.

dfflibmap -liberty /home/harshithr7/.ciel/ciel/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_100C_1v65.lib
abc -liberty /home/harshithr7/.ciel/ciel/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_100C_1v65.lib
# read_liberty -max <path_to_max_lib.lib>

# Syntehsis output
# write_blif - write design to BLIF file,

# write_edif - write design to EDIF netlist file, and

#write_json netlist.json #write design to a JSON file.
write_verilog designs/RCA/netlist_1.v

# ABC for fine grained optimizaition and LUT mapping - abc,abc9

clean

script designs/RCA/yosys_script.tcl
