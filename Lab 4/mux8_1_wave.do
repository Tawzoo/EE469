onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux8_1_testbench/in
add wave -noupdate {/mux8_1_testbench/in[7]}
add wave -noupdate {/mux8_1_testbench/in[6]}
add wave -noupdate {/mux8_1_testbench/in[5]}
add wave -noupdate {/mux8_1_testbench/in[4]}
add wave -noupdate {/mux8_1_testbench/in[3]}
add wave -noupdate {/mux8_1_testbench/in[2]}
add wave -noupdate {/mux8_1_testbench/in[1]}
add wave -noupdate {/mux8_1_testbench/in[0]}
add wave -noupdate /mux8_1_testbench/sel
add wave -noupdate {/mux8_1_testbench/sel[2]}
add wave -noupdate {/mux8_1_testbench/sel[1]}
add wave -noupdate {/mux8_1_testbench/sel[0]}
add wave -noupdate /mux8_1_testbench/out
add wave -noupdate /mux8_1_testbench/i
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
WaveRestoreZoom {0 ps} {171 ps}
