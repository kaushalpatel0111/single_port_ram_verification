vlib work

vlog ../rtl/single_port_ram_rtl.v ../inc/ram_pkg.sv ../top/top.sv +incdir+../inf +incdir+../env +incidr+../test 

#vsim -voptargs=+acc work.top +clk_freq=250 +rand_wr_rd +single_wr_rd +multi_wr_rd +b2b_wr_rd +error_test -l ram.log -c -do "coverage save -onexit -directive -cvg -codeall ram_fc.ucdb;"

vsim -voptargs=+acc work.top +clk_freq=250 +b2b_wr_rd -l ram.log -c -do "coverage save -onexit -directive -cvg -codeall ram_fc.ucdb;"

add wave -r \*
run -all
