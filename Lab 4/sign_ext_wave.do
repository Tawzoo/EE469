onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sign_ext_testbench/IN_WIDTH
add wave -noupdate /sign_ext_testbench/clk_PERIOD
add wave -noupdate /sign_ext_testbench/in
add wave -noupdate /sign_ext_testbench/out
add wave -noupdate /sign_ext_testbench/clk
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
