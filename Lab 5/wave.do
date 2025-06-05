onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /lab5_testbench/USERID
add wave -noupdate -radix unsigned /lab5_testbench/ADDRESS_WIDTH
add wave -noupdate -radix unsigned /lab5_testbench/DATA_WIDTH
add wave -noupdate -radix unsigned /lab5_testbench/CLOCK_PERIOD
add wave -noupdate -radix unsigned /lab5_testbench/address
add wave -noupdate -radix unsigned /lab5_testbench/data_in
add wave -noupdate -radix unsigned /lab5_testbench/bytemask
add wave -noupdate -radix unsigned /lab5_testbench/write
add wave -noupdate -radix unsigned /lab5_testbench/start_access
add wave -noupdate -radix unsigned /lab5_testbench/access_done
add wave -noupdate -radix unsigned /lab5_testbench/data_out
add wave -noupdate -radix unsigned /lab5_testbench/clk
add wave -noupdate -radix unsigned /lab5_testbench/reset
add wave -noupdate -radix unsigned /lab5_testbench/cycles
add wave -noupdate -radix unsigned /lab5_testbench/addr
add wave -noupdate -radix unsigned /lab5_testbench/delay
add wave -noupdate -radix unsigned /lab5_testbench/minval
add wave -noupdate -radix unsigned /lab5_testbench/maxval
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {101616000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 5000
configure wave -gridperiod 10000
configure wave -griddelta 4
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {853141800 ps}
