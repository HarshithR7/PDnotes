# source designs/RCA/sta.tcl

read_liberty /home/harshithr7/.ciel/ciel/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_100C_1v65.lib
# read_liberty -max <path_to_max_lib.lib>
read_verilog /home/harshithr7/OpenLane/designs/RCA/rca_gatelevel.v
link_design rca
#read_sdc /home/harshithr7/OpenLane/designs/RCA/constraints.sdc

report_checks -path_delay min
report_checks -path_delay max

#report_clock
report_tns       ;# Total Negative Slack
report_wns       ;# Worst Negative Slack
report_power     ;# If switching activity is defined

# Timing Paths
report_checks -from [get_ports A[*]] -to [get_ports Sum[0]]
#report_checks -delay_type min -max_paths 5

