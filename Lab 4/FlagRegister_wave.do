onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /FlagRegister_tb/clk_PERIOD
add wave -noupdate /FlagRegister_tb/clk
add wave -noupdate /FlagRegister_tb/reset
add wave -noupdate /FlagRegister_tb/en
add wave -noupdate /FlagRegister_tb/in
add wave -noupdate /FlagRegister_tb/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 40
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
WaveRestoreZoom {0 ps} {11773 ps}
