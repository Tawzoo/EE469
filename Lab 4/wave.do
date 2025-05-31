onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/CLOCK_PERIOD
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/clk
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/reset
add wave -noupdate -divider IF
add wave -noupdate -radix unsigned /Pipelined_CPU_testbench/dut/IF/PC_Addr
add wave -noupdate -divider ID
add wave -noupdate -radix unsigned /Pipelined_CPU_testbench/dut/ID/BrTakenAddr
add wave -noupdate -radix decimal -childformat {{{/Pipelined_CPU_testbench/dut/ID/registers/register_32[31]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[30]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[29]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[28]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[27]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[26]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[25]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[24]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[23]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[22]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[21]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[20]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[19]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[18]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[17]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[16]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[15]} -radix unsigned} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[14]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[13]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[12]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[11]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[10]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[9]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[8]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[7]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[6]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[5]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[4]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[3]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[2]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[1]} -radix decimal} {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[0]} -radix decimal}} -subitemconfig {{/Pipelined_CPU_testbench/dut/ID/registers/register_32[31]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[30]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[29]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[28]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[27]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[26]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[25]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[24]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[23]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[22]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[21]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[20]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[19]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[18]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[17]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[16]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[15]} {-height 15 -radix unsigned} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[14]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[13]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[12]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[11]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[10]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[9]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[8]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[7]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[6]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[5]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[4]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[3]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[2]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[1]} {-height 15 -radix decimal} {/Pipelined_CPU_testbench/dut/ID/registers/register_32[0]} {-height 15 -radix decimal}} /Pipelined_CPU_testbench/dut/ID/registers/register_32
add wave -noupdate -radix binary /Pipelined_CPU_testbench/dut/ID/controlUnit/opcode
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/IF/instruction_memory/instruction
add wave -noupdate -radix binary /Pipelined_CPU_testbench/dut/Memory/MemRead
add wave -noupdate -radix unsigned /Pipelined_CPU_testbench/dut/ID/BrTaken
add wave -noupdate /Pipelined_CPU_testbench/dut/ID/controlUnit/SetFlag
add wave -noupdate /Pipelined_CPU_testbench/dut/ID/ALU_SetFlag
add wave -noupdate /Pipelined_CPU_testbench/dut/ID/controlUnit/negflag
add wave -noupdate /Pipelined_CPU_testbench/dut/ID/controlUnit/overflag
add wave -noupdate -divider Execution
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/Execution/ALU_Read_data1
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/Execution/ALU_Read_data2
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/Memory/ALU_Result_in
add wave -noupdate /Pipelined_CPU_testbench/dut/Memory/forwardC
add wave -noupdate -divider MEM
add wave -noupdate -radix unsigned /Pipelined_CPU_testbench/dut/Memory/ALU_FF
add wave -noupdate /Pipelined_CPU_testbench/dut/Memory/datamemory/mem
add wave -noupdate /Pipelined_CPU_testbench/dut/Memory/datamemory/address
add wave -noupdate -radix binary /Pipelined_CPU_testbench/dut/Memory/MemWrite
add wave -noupdate /Pipelined_CPU_testbench/dut/Memory/ALU_Result_in
add wave -noupdate -radix binary /Pipelined_CPU_testbench/dut/Memory/DM_Read_Data
add wave -noupdate -radix unsigned /Pipelined_CPU_testbench/dut/Memory/WB_Write_Data
add wave -noupdate -divider WB
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/Execution/MEM_ALUResult
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/Execution/MEM_WB_ALUResult
add wave -noupdate /Pipelined_CPU_testbench/dut/Execution/ALUSrc
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/ID/Read_Reg2
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/ID/Read_data1
add wave -noupdate -radix binary /Pipelined_CPU_testbench/dut/ID/Read_data2
add wave -noupdate -radix unsigned /Pipelined_CPU_testbench/dut/WriteBack/Write_Data
add wave -noupdate -radix unsigned /Pipelined_CPU_testbench/dut/ID/wrt_reg
add wave -noupdate /Pipelined_CPU_testbench/dut/WriteBack/MemtoReg
add wave -noupdate /Pipelined_CPU_testbench/dut/WriteBack/BrLink
add wave -noupdate -divider Forwarding
add wave -noupdate -radix unsigned /Pipelined_CPU_testbench/dut/Execution/fwd/ID_Rn
add wave -noupdate -radix unsigned /Pipelined_CPU_testbench/dut/Execution/fwd/ID_Rm
add wave -noupdate -radix unsigned /Pipelined_CPU_testbench/dut/Execution/fwd/EX_Rd
add wave -noupdate -radix unsigned /Pipelined_CPU_testbench/dut/Execution/fwd/MEM_Rd
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/Execution/fwd/EX_RegWrite
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/Execution/fwd/MEM_RegWrite
add wave -noupdate -radix decimal /Pipelined_CPU_testbench/dut/Execution/fwd/MEM_WB_BRLink
add wave -noupdate -radix binary /Pipelined_CPU_testbench/dut/Execution/fwd/forwardA
add wave -noupdate -radix binary /Pipelined_CPU_testbench/dut/Execution/fwd/forwardB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1545200 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 202
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
WaveRestoreZoom {1004988 ps} {1437090 ps}
