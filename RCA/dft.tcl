# DFT - design for testing. new nets or logic are added to allow IC designs to be tested for errors in manufacturing.
# A simple DFT insertion consist of the following parts:
# A scan_in pin where the test patterns are shifted in.
# A scan_out pin where the test patterns are read from.
# Scan cells that replace flops with registers that allow for testing.
# One or more scan chains (shift registers created from your scan cells).
# A scan_enable pin to allow your design to enter and leave the test mode.

# set_dft_config  [-max_length <int>] [-max_chains <int>]  [-clock_mixing <string>] [-scan_enable_name_pattern <string>] [-scan_in_name_pattern <string>] [-scan_out_name_pattern <string>]

# max_length - max no.of bits that can be in each scan chains
# max_chains - max scan chains that will be generated. priority over max_length
# clock_mixing - 

# report_dft_config # prints current dft configuration
# scan_replace # replace all FF with scan FF
# report_dft_plan # preview of scan chains that will be stitiched to execute_dft_plan
# execute_dft_plan
# scan_opt

# example
set_dft_config -max_length 10 -clock_mixing clock_mix
report_dft_config
scan_replace
# Run global placement...
report_dft_plan -verbose
execute_dft_plan