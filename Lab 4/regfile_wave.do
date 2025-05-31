onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regfile_testbench/dut/ReadData1
add wave -noupdate /regfile_testbench/dut/ReadData2
add wave -noupdate /regfile_testbench/dut/WriteData
add wave -noupdate /regfile_testbench/dut/ReadRegister1
add wave -noupdate /regfile_testbench/dut/ReadRegister2
add wave -noupdate /regfile_testbench/dut/WriteRegister
add wave -noupdate /regfile_testbench/dut/RegWrite
add wave -noupdate /regfile_testbench/dut/clk
add wave -noupdate /regfile_testbench/dut/register_32
add wave -noupdate /regfile_testbench/dut/sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 227
configure wave -valuecolwidth 418
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
WaveRestoreZoom {0 ps} {318 ps}
