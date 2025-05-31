onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /EX_MEM_tb/clk_PERIOD
add wave -noupdate -radix unsigned /EX_MEM_tb/MEM_en_in
add wave -noupdate -radix unsigned /EX_MEM_tb/WB_en_in
add wave -noupdate -radix unsigned /EX_MEM_tb/reset
add wave -noupdate -radix unsigned /EX_MEM_tb/clk
add wave -noupdate -radix unsigned /EX_MEM_tb/BrTaken_in
add wave -noupdate -radix unsigned /EX_MEM_tb/MemRead_in
add wave -noupdate -radix unsigned /EX_MEM_tb/MemtoReg_in
add wave -noupdate -radix unsigned /EX_MEM_tb/MemWrite_in
add wave -noupdate -radix unsigned /EX_MEM_tb/RegWrite_in
add wave -noupdate -radix unsigned /EX_MEM_tb/BrLink_in
add wave -noupdate -radix unsigned /EX_MEM_tb/negative_in
add wave -noupdate -radix unsigned /EX_MEM_tb/zero_in
add wave -noupdate -radix unsigned /EX_MEM_tb/overflow_in
add wave -noupdate -radix unsigned /EX_MEM_tb/carry_out_in
add wave -noupdate -radix unsigned /EX_MEM_tb/PC_BL_in
add wave -noupdate -radix unsigned /EX_MEM_tb/ALU_Result_in
add wave -noupdate -radix unsigned /EX_MEM_tb/ALU_FF_in
add wave -noupdate -radix unsigned /EX_MEM_tb/Set_Flags
add wave -noupdate -radix unsigned /EX_MEM_tb/Instruction4_0
add wave -noupdate -radix unsigned /EX_MEM_tb/WB_en_out
add wave -noupdate -radix unsigned /EX_MEM_tb/BrTaken_out
add wave -noupdate -radix unsigned /EX_MEM_tb/MemRead_out
add wave -noupdate -radix unsigned /EX_MEM_tb/MemtoReg_out
add wave -noupdate -radix unsigned /EX_MEM_tb/MemWrite_out
add wave -noupdate -radix unsigned /EX_MEM_tb/RegWrite_out
add wave -noupdate -radix unsigned /EX_MEM_tb/BrLink_out
add wave -noupdate -radix unsigned /EX_MEM_tb/negative_out
add wave -noupdate -radix unsigned /EX_MEM_tb/zero_out
add wave -noupdate -radix unsigned /EX_MEM_tb/overflow_out
add wave -noupdate -radix unsigned /EX_MEM_tb/carry_out_out
add wave -noupdate -radix unsigned /EX_MEM_tb/PC_BL_out
add wave -noupdate -radix unsigned /EX_MEM_tb/ALU_Result_out
add wave -noupdate -radix unsigned /EX_MEM_tb/ALU_FF_out
add wave -noupdate -radix unsigned /EX_MEM_tb/EX_MEM_Set_Flags
add wave -noupdate -radix unsigned /EX_MEM_tb/EX_MEM_Rd
add wave -noupdate -radix unsigned /EX_MEM_tb/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4785 ps} 0}
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
WaveRestoreZoom {0 ps} {42 ns}
