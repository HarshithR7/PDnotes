🕒 Timing Report
WNS: -0.75ns
TNS: -7.451ns

This means your design violates timing constraints.

🔍 What this means:
WNS (Worst Negative Slack): The longest single path is 750 ps too slow.

TNS (Total Negative Slack): All paths together miss timing by 7.451 ns, which is significant.

🧠 How to fix timing:
Check Critical Path
Run:

tcl
Copy
Edit
report_timing -sort_by group -max_paths 5
Pipeline the design
Add registers between stages of combinational logic.

Reduce fanout
Buffer or register outputs that drive many other nets.

Check constraints
Ensure create_clock, set_input_delay, set_output_delay are realistic.

