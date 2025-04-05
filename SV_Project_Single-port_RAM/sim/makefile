all: lib comp sim
lib:
	vlib work
 
comp:
	vlog ../rtl/single_port_ram_rtl.v ../inc/ram_pkg.sv ../top/top.sv +incdir+../inf +incdir+../env +incidr+../test
 
sim:
	vsim -voptargs=+acc top -c -do "add wave -r \*; run -all;"
