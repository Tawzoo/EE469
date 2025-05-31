onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /datapath_tb/dut/clk
add wave -noupdate -radix unsigned /datapath_tb/dut/reset
add wave -noupdate -radix unsigned /datapath_tb/dut/instr
add wave -noupdate -radix unsigned /datapath_tb/dut/pc_out
add wave -noupdate -radix unsigned /datapath_tb/dut/read_data2
add wave -noupdate -radix unsigned /datapath_tb/dut/alu_result
add wave -noupdate -radix unsigned /datapath_tb/dut/reg2loc_in
add wave -noupdate -radix unsigned /datapath_tb/dut/mem_to_reg
add wave -noupdate -radix unsigned /datapath_tb/dut/regwrite
add wave -noupdate -radix unsigned /datapath_tb/dut/setflag
add wave -noupdate -radix unsigned /datapath_tb/dut/br2reg
add wave -noupdate /datapath_tb/dut/reg2loc_mux/Delay
add wave -noupdate /datapath_tb/dut/reg2loc_mux/i0
add wave -noupdate /datapath_tb/dut/reg2loc_mux/i1
add wave -noupdate /datapath_tb/dut/reg2loc_mux/sel
add wave -noupdate /datapath_tb/dut/reg2loc_mux/out
add wave -noupdate /datapath_tb/dut/reg2loc_mux/i0_out
add wave -noupdate /datapath_tb/dut/reg2loc_mux/i1_out
add wave -noupdate /datapath_tb/dut/reg2loc_mux/sel_not
add wave -noupdate -radix unsigned -childformat {{{/datapath_tb/dut/read_reg2_input[4]} -radix unsigned} {{/datapath_tb/dut/read_reg2_input[3]} -radix unsigned} {{/datapath_tb/dut/read_reg2_input[2]} -radix unsigned} {{/datapath_tb/dut/read_reg2_input[1]} -radix unsigned} {{/datapath_tb/dut/read_reg2_input[0]} -radix unsigned}} -subitemconfig {{/datapath_tb/dut/read_reg2_input[4]} {-radix unsigned} {/datapath_tb/dut/read_reg2_input[3]} {-radix unsigned} {/datapath_tb/dut/read_reg2_input[2]} {-radix unsigned} {/datapath_tb/dut/read_reg2_input[1]} {-radix unsigned} {/datapath_tb/dut/read_reg2_input[0]} {-radix unsigned}} /datapath_tb/dut/read_reg2_input
add wave -noupdate -radix unsigned /datapath_tb/dut/alu_control
add wave -noupdate -radix unsigned /datapath_tb/dut/alusrc
add wave -noupdate -radix unsigned /datapath_tb/dut/read_data1
add wave -noupdate -radix unsigned /datapath_tb/dut/pc_in
add wave -noupdate -radix unsigned /datapath_tb/dut/pc_mux1_in
add wave -noupdate -radix unsigned /datapath_tb/dut/alusrc_mux_out
add wave -noupdate -radix unsigned /datapath_tb/dut/dp_writedata
add wave -noupdate -radix unsigned /datapath_tb/dut/shift_out
add wave -noupdate -radix unsigned /datapath_tb/dut/Imm12Ext
add wave -noupdate -radix unsigned /datapath_tb/dut/registers/ReadData1
add wave -noupdate -radix unsigned /datapath_tb/dut/registers/ReadData2
add wave -noupdate -radix unsigned /datapath_tb/dut/registers/WriteData
add wave -noupdate -radix unsigned /datapath_tb/dut/registers/ReadRegister1
add wave -noupdate -radix unsigned /datapath_tb/dut/registers/ReadRegister2
add wave -noupdate -radix unsigned /datapath_tb/dut/registers/WriteRegister
add wave -noupdate -radix unsigned /datapath_tb/dut/registers/RegWrite
add wave -noupdate -radix unsigned /datapath_tb/dut/registers/register_32
add wave -noupdate -radix unsigned /datapath_tb/dut/registers/sel
add wave -noupdate -radix unsigned /datapath_tb/dut/alu1/A
add wave -noupdate -radix unsigned /datapath_tb/dut/alu1/B
add wave -noupdate -radix unsigned /datapath_tb/dut/alu1/cntrl
add wave -noupdate -radix unsigned /datapath_tb/dut/alu1/result
add wave -noupdate -radix unsigned /datapath_tb/dut/alu1/negative
add wave -noupdate -radix unsigned /datapath_tb/dut/alu1/zero
add wave -noupdate -radix unsigned /datapath_tb/dut/alu1/overflow
add wave -noupdate -radix unsigned /datapath_tb/dut/alu1/carry_out
add wave -noupdate -radix unsigned /datapath_tb/dut/alu1/temp_out
add wave -noupdate -radix unsigned /datapath_tb/dut/alu1/temp_cout
add wave -noupdate -radix unsigned /datapath_tb/dut/alu1/temp_ovrflow
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {145093 ps} 0} {{Cursor 2} {207727 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 315
configure wave -valuecolwidth 376
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {225750 ps}
