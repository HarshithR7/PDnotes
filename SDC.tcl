create_clock -name clk -period 10 -waveform {0 5} [get_ports clk] # 10 nS 50% duty cycle
create_clk -name clk1 -period 10 -waveform {2.5 7.5} [get_ports clk1] # 50% clk with phase shift

create_clk -name clk2 -period 10 -waveform {0 6} [get_ports clk2] 
# phase shift in time = phase shift(degrees) * clk_period/360

# Generated clock
create_clock -name clk -period 10 -waveform {0 5} [get_ports clk] # base clock is created
create_generated_clock -name gen_clk -divide_by2 -source [get_ports clk] [get_pins tff/Q] # at Q divided output is observed
create_generated_clock -name clk2 -source [get_pins tff/Q] -multiply_by2 [get_pins tff/Q1]

#Synchronous clocks
create_generated_clock -name clk2 -source [get_ports clk1] [get_ports clk2]
# asynchronous clocks
create_clock -name clk1 -period 3
create_clock -name clk2 -period 6 [get_ports p1] [gte_ports tff/q]

# Exclusive clocks
set_clock_groups -logically_exclusive -group {clk1} -group {clk2}
set_clock_groups -physiclly_exclusive -group {gclk1} -group {gclk2}

set_input_delay 4.5 -clock PHI1 {IN1} # -add_delay can add additional delay on top without overwriting. input arrives late 4.5 to IN1 wrt clock PHI1
set_output_delay 

# Max Capacitance and Max fanout constaints
set_max_transition 0.2 [all_inputs] {hard}
set_max_transition 0.3 [all_output]

report_constraints -all_violators

set_max_capacitance 0.4 [get_ports "OUT*"]
set_min_capacitance 0.1 [current_design]

set_max_fanout 2 [get_ports "IN*"]
set_max_fanout 5 [current_design]

# CLock Uncertainity
set_clock_uncertainty 5 [get_clocks CLKA] # clock edges can arrive upto +- 5 ns, making timing analysis more conservative
set_clock_uncertainty 2 -from [get_clocks CLKB] -to [get_clocks CLKA]

# Clock Larency
set_clock_latency 2.35 [get_pins ABC/XYZ/CP] # inside the chip. Modeling internal clock delay
set_clock_latency 5 -source [get_pins FF/Q] # clock entering the chip. when clock comes from outside.

# Timing Path Exceptions
set_false_path -from [get_clocks ck1] \-to [get_clocks ck2] # not analyzed for timing. remove timing constraints on teh Path
set_max_delay
set_min_delay
set_multicycle_path  -setup 2 -from [get_cells FF4] -to [get_cells FF5]  # relaxing the setup timing constaints
set_disable_timing_arc -from -to # timing arcs disable for mux, because only 1 is ON 


set_case_analysis 0 [get_ports S1]
set_case_analysis 0 [get_ports S2]

