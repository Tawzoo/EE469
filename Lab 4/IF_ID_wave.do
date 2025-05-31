onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /IF_ID_tb/clk_PERIOD
add wave -noupdate /IF_ID_tb/IF_ID_en
add wave -noupdate /IF_ID_tb/reset
add wave -noupdate /IF_ID_tb/clk
add wave -noupdate /IF_ID_tb/PC_Addr_in
add wave -noupdate /IF_ID_tb/Instruction_in
add wave -noupdate /IF_ID_tb/PC_Addr_out
add wave -noupdate /IF_ID_tb/Instruction_out
add wave -noupdate /IF_ID_tb/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6159 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 48
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {9455 ps}
