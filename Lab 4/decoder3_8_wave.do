onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /decoder3_8_testbench/i0
add wave -noupdate /decoder3_8_testbench/i1
add wave -noupdate /decoder3_8_testbench/i2
add wave -noupdate /decoder3_8_testbench/en
add wave -noupdate /decoder3_8_testbench/out
add wave -noupdate /decoder3_8_testbench/en_arr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {15050 ps} {16050 ps}
