onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fullAdder64_tb/A
add wave -noupdate /fullAdder64_tb/B
add wave -noupdate /fullAdder64_tb/out
add wave -noupdate /fullAdder64_tb/carryout
add wave -noupdate /fullAdder64_tb/overflow
add wave -noupdate /fullAdder64_tb/negative
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
WaveRestoreZoom {0 ps} {30 ps}
