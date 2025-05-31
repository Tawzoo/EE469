onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fullSubtractor64_tb/A
add wave -noupdate /fullSubtractor64_tb/B
add wave -noupdate /fullSubtractor64_tb/out
add wave -noupdate /fullSubtractor64_tb/carryout
add wave -noupdate /fullSubtractor64_tb/overflow
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 75
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
WaveRestoreZoom {0 ps} {6432 ps}
