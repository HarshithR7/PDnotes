# IR Drop 
The power supply VDD, VSS are distributed through metail rails & stripes, it is PDN power delivery network.
Each metal layer in PDN has finite resistivity V=I.R , so IR drop.
Static and Dynamic IR Drop. Decaps- only capacitors- reduces dynamic ir drop.

# IR Analysis - RedHawk of Ansys, Voltus of CDS
> insert_decap_cells -area 5000 -cell_type DECAP1

# Power Noises
Sudden drop in VDD is voltage drop.
Sudden increase in ground voltage is ground bounce.

# Fixes
> increasing no.of decap cells
> Increase width of metal stripes or decrease seperation between them.
> load distribution by spreading the logic


# Clock Gating - Reduce dynamic power consumption
Technique used for low power designs. ICG(Integrated clock design) cell specially designed with a neg latch[EN and clk] and AND gate.
> Stop clock signal propagation to logic cells when they are not needed to operate. cells have clock enable attached to EN of ICG cell.

# Power Gating
Reduce leakage power by turning power supply to inactive blocks. reduces standby power.