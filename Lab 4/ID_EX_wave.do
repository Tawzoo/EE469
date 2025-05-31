onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /ID_EX_tb/CLOCK_PERIOD
add wave -noupdate -radix unsigned /ID_EX_tb/clk
add wave -noupdate -radix unsigned /ID_EX_tb/reset
add wave -noupdate -radix unsigned /ID_EX_tb/WB_en_in
add wave -noupdate -radix unsigned /ID_EX_tb/WB_en_out
add wave -noupdate -radix unsigned /ID_EX_tb/MEM_en_in
add wave -noupdate -radix unsigned /ID_EX_tb/MEM_en_out
add wave -noupdate -radix unsigned /ID_EX_tb/EX_en_in
add wave -noupdate -radix unsigned /ID_EX_tb/SetFlag_in
add wave -noupdate -radix unsigned /ID_EX_tb/SetFlag_out
add wave -noupdate -radix unsigned /ID_EX_tb/MemRead_in
add wave -noupdate -radix unsigned /ID_EX_tb/MemRead_out
add wave -noupdate -radix unsigned /ID_EX_tb/MemtoReg_in
add wave -noupdate -radix unsigned /ID_EX_tb/MemtoReg_out
add wave -noupdate -radix unsigned /ID_EX_tb/MemWrite_in
add wave -noupdate -radix unsigned /ID_EX_tb/MemWrite_out
add wave -noupdate -radix unsigned /ID_EX_tb/RegWrite_in
add wave -noupdate -radix unsigned /ID_EX_tb/RegWrite_out
add wave -noupdate -radix unsigned /ID_EX_tb/BrLink_in
add wave -noupdate -radix unsigned /ID_EX_tb/BrLink_out
add wave -noupdate -radix unsigned /ID_EX_tb/PC_BL_in
add wave -noupdate -radix unsigned /ID_EX_tb/PC_BL_out
add wave -noupdate -radix unsigned /ID_EX_tb/Read_data1_in
add wave -noupdate -radix unsigned /ID_EX_tb/Read_data1_out
add wave -noupdate -radix unsigned /ID_EX_tb/Read_data2_in
add wave -noupdate -radix unsigned /ID_EX_tb/Read_data2_out
add wave -noupdate -radix unsigned /ID_EX_tb/Imm9Ext_in
add wave -noupdate -radix unsigned /ID_EX_tb/Imm9Ext_out
add wave -noupdate -radix unsigned /ID_EX_tb/Imm12Ext_in
add wave -noupdate -radix unsigned /ID_EX_tb/Imm12Ext_out
add wave -noupdate -radix unsigned /ID_EX_tb/Instruction_in
add wave -noupdate -radix unsigned /ID_EX_tb/Instruction_out
add wave -noupdate -radix unsigned /ID_EX_tb/ALUSrc_in
add wave -noupdate -radix unsigned /ID_EX_tb/ALUSrc_out
add wave -noupdate -radix unsigned /ID_EX_tb/ALUOp_in
add wave -noupdate -radix unsigned /ID_EX_tb/ALUOp_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {123 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {591 ps}
