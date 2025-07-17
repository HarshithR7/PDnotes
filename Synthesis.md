Synthesis is a process converting a high-level description at RTL to basic logic gates. 
Mapping those gates to technology dependent logic gates accessible in tech libraries.
Optimizing the translated netlist.

# Goals of Synthesis
Gate-level netlist, Inserting clock gates, Logic optimization, inserting DFT logic, Logic equivalence betwwen RTL & Netlist.

# Inputs
RTL, Timing Library Lib, SDC, UPF, Physical Library LEF, 

# Outputs
Gate level netlist, SDC, Timing, power & area reports

> set_link_library <macro.lib> # macros , implemented hard 
> set_target_library <cells.lib> # compiler maps logic to real gates from this library

# Read HDL files - 
read_hdl top.v block1.v block2.v  -  genus reads files and 
elaborate  - creates a design hierarchy of all modules. transform modules to netlist. infer registers in design - if-else to mux, check semantics
read_sdc 

# Optimization
set_db .preserve true
set_db design_power_effort <none|low|high>
path_adjust –delay <delay> -from <start_point> -to <end_point>
set_db <lib_cell> .area_multiplier 1.1

# Synthesize

Set_db synth_gen_effort low|medium|high
Set_db synth_map_effort low|medium|high
Set_db synth_opt_effort low|medium|high

# Generic synthesize
syn_generic
syn_map 
syn_opt




set DESIGN <design name >
set GEN_EFF medium 
set MAP_EFF high 
set_db init_lib_search_path { \ ..}
set_db init_hdl_search_path { ../rtl }
set_db script_search_path { . }
set_db syn_generic_effort $SYN_EFF 
set_db syn_map_effort $MAP_EFF
set_db opt_spatial_effort extreme 
read_mmmc mmmc_config.tcl 
read_physical -lef {} 
read_hdl $rtl_list 
elaborate $DESIGN init_design 
check_design -unresolved 
read_def ../def/fp.def
syn_gen -physical syn_map -physical 
syn_opt -spatial 
write_netlist $DESIGN > netlist.v
Genus – logical synthesis
Genus ispatial flow – physical aware synthesis
Floorplan def- macro locations # Invokes the P&R engines of innovus

# Low power synthesis – UPF (Unified power format) Multiple voltage domains 
Read_power_intent <path/name.upf>
