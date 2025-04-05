regress: vlib vlog sim cover delete
vlib:
	vlib work
vlog:
	vlog -coveropt 3 +acc +cover ../RTL/ram_rtl.v ../TOP/ram_define.sv ../TOP/ram_pkg.sv ../TOP/ram_top.sv +incdir+../TOP +incdir+../ENV +incdir+../TEST
sim:
	vsim -voptargs=+acc -coverage ram_top +clk_freq=250 +init_rst +UVM_TESTNAME=ram_single_wr_rd -l ram.log  -c -do "coverage save -onexit -directive -cvg -codeall test1.ucdb; run -all; exit"
	vsim -voptargs=+acc -coverage ram_top +clk_freq=250 +init_rst +UVM_TESTNAME=ram_multi_wr_rd -l ram.log  -c -do "coverage save -onexit -directive -cvg -codeall test2.ucdb; run -all; exit"
	vsim -voptargs=+acc -coverage ram_top +clk_freq=250 +init_rst +UVM_TESTNAME=ram_random_wr_rd -l ram.log  -c -do "coverage save -onexit -directive -cvg -codeall test3.ucdb; run -all; exit"
	vsim -voptargs=+acc -coverage ram_top +clk_freq=250 +init_rst +UVM_TESTNAME=ram_b2b_wr_rd -l ram.log  -c -do "coverage save -onexit -directive -cvg -codeall test4.ucdb; run -all; exit"
	vsim -voptargs=+acc -coverage ram_top +clk_freq=250 +init_rst +UVM_TESTNAME=ram_err_test -l ram.log  -c -do "coverage save -onexit -directive -cvg -codeall test5.ucdb; run -all; exit"
	vsim -voptargs=+acc -coverage ram_top +clk_freq=250 +in_bw_rst +UVM_TESTNAME=ram_in_bw_rst -l ram.log  -c -do "coverage save -onexit -directive -cvg -codeall test6.ucdb; run -all; exit"
cover:
	vcover merge ram.ucdb test1.ucdb test2.ucdb test3.ucdb test4.ucdb test5.ucdb test6.ucdb
delete:	 
	del test1.ucbd test2.ucbd test3.ucbd test4.ucbd test5.ucbd test6.ucbd 
	vcover report -details -html ram.ucdb -output RAM_TESTs
