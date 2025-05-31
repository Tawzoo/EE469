onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Instruction_Fetch_tb/CLOCK_PERIOD
add wave -noupdate /Instruction_Fetch_tb/clk
add wave -noupdate /Instruction_Fetch_tb/reset
add wave -noupdate /Instruction_Fetch_tb/BrTaken
add wave -noupdate /Instruction_Fetch_tb/BrTakenAddr
add wave -noupdate /Instruction_Fetch_tb/PC_Addr
add wave -noupdate /Instruction_Fetch_tb/PC_BL
add wave -noupdate /Instruction_Fetch_tb/instruction
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
WaveRestoreZoom {0 ps} {1 ns}
