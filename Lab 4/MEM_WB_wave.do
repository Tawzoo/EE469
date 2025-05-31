onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /MEM_WB_tb/CLOCK_PERIOD
add wave -noupdate -radix unsigned /MEM_WB_tb/clk
add wave -noupdate -radix unsigned /MEM_WB_tb/reset
add wave -noupdate -radix unsigned /MEM_WB_tb/WB_en_in
add wave -noupdate -radix unsigned /MEM_WB_tb/MemtoReg_in
add wave -noupdate -radix unsigned /MEM_WB_tb/MemtoReg_out
add wave -noupdate -radix unsigned /MEM_WB_tb/BrLink_in
add wave -noupdate -radix unsigned /MEM_WB_tb/BrLink_out
add wave -noupdate -radix unsigned /MEM_WB_tb/PC_BL_in
add wave -noupdate -radix unsigned /MEM_WB_tb/PC_BL_out
add wave -noupdate -radix unsigned /MEM_WB_tb/DM_Read_Data_in
add wave -noupdate -radix unsigned /MEM_WB_tb/DM_Read_Data_out
add wave -noupdate -radix unsigned /MEM_WB_tb/ALU_Result_in
add wave -noupdate -radix unsigned /MEM_WB_tb/ALU_Result_out
add wave -noupdate -radix unsigned /MEM_WB_tb/Instruction4_0
add wave -noupdate -radix unsigned /MEM_WB_tb/MEM_WB_Rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {2556 ps}
