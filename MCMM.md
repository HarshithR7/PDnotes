Day 6, 10

# Multi-Corner Multi-Mode
A MMMC (Multi-Mode Multi-Corner) file is needed to perform timing analysis across different operating modes (like functional, test) and process-voltage-temperature corners, ensuring the design meets timing under all realistic conditions.

> It enables design tools to optimize across all metrics simultaneously. 
> Ensures timing closures across multiple scenarios
> helps in optimizing PPA


Mode: is defined by set of clocks, Supply voltages, timing constraints, libraries; functional modes, test mode, sleep mode
Corner: a set libraries characterized for Process, Voltage and Temperature variations.
Corners are not dependent on functional settings.

# PVT conditions (Corners)
Temperature: Best case, Worst case, Typical – 3 corners

Process for cells: Fast-Fast, Slow-Slow, Fast-Slow, Slow-Fast, Typical = 5 corners
Typical: will have moderate delays. Both PMOS and NMOS works normally.
Slow-Slow :will have worst delays (Max delays). Both PMOS and NMOS works slow.
Fast-Fast: will have best delays (Min delays). Both PMOS and NMOS works fast.

Voltage: Best case, Worst case, Typical – 3 comers

Process for interconnect: Max C, Min C, Max RC, Min RC, Typical = 5 corners.

Example
> Scenario =  Mode + Corner
FUNC mode – SS, worst, Best, Max C
FUNC mode – SF, worst, Best, Max C
FUNC mode – FS, worst, Best, Max C
FUNC mode – FF, worst, Best, Max C
TEST mode – SS, best, Best, Max C

create_corner -name WORST_CASE -libraries {slow.lib} -spef {worst_case.spef}
create_corner -name BEST_CASE -libraries {fast.lib} -spef {best_case.spef}
create_mode -name FUNCTIONAL_MODE
create_scenario -name FUNC_WC -mode FUNCTIONAL_MODE -corner WORST_CASE


# OCV on-chip variations - fixed derate
variations in process, voltage, and temperature (PVT) that occur within a single chip. These variations can impact transistor speeds, wire delays, and overall timing.
> In OCV a fixed timing derate factor is applied to the delay of all the cells present in the design so that in case of process variation affects the delay of any cells during the fabrication, it will not affect the timing requirements, and the chip will not fail after fabrication.
> Within-Die (WID) Process Variation: Variations within a single chip (handled using oCV, AOCV, POCV).
Setup violations occur at SS, Vmin, High Temp (slowest case).
Hold violations occur at FF, Vmax, Low Temp (fastest case).

> set_timing_derate -cell_delay-rise -data -early 0.92 #early timing derate; late timing derate -late 1.10
> set_timing_derate -cell_delay-rise -clock -early 0.92

# Advance On chip Variation (AOCV): 
> Uses depth-based and distance-based derate tables. The derate factor varies depending on the number of stages (logic depth) and the physical distance between cells.
> In AOCV derate is applied on each cell based on path depth and distance of the cell in the timing path and it also varies with cell type and drive strength of the cell.

# Parametric oCV
> Uses a statistical model for each cell’s delay, incorporating both mean (μ) and standard deviation (σ).
