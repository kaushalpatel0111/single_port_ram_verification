vlib work

vlog -coveropt 3 +acc +cover ../RTL/ram_rtl.v ../TOP/ram_define.sv ../TOP/ram_pkg.sv ../TOP/ram_top.sv +incdir+../TOP +incdir+../ENV +incdir+../TEST

vsim -voptargs=+acc -coverage ram_top +clk_freq=250 +init_rst +UVM_TESTNAME=ram_in_bw_rst -l ram.log -c -do "coverage save -onexit -directive -cvg -codeall ram_fc.ucdb;"

add wave -r /*

run -all
