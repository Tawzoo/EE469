onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /en_reg_testbench/clk
add wave -noupdate /en_reg_testbench/wrt_en
add wave -noupdate /en_reg_testbench/datain
add wave -noupdate /en_reg_testbench/reset
add wave -noupdate /en_reg_testbench/dataout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2068 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 93
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
WaveRestoreZoom {0 ps} {2554 ps}
