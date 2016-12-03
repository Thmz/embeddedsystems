onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lcd_controller_tb/clk_tb
add wave -noupdate /lcd_controller_tb/rst_tb
add wave -noupdate /lcd_controller_tb/CS_n_tb
add wave -noupdate /lcd_controller_tb/DC_n_tb
add wave -noupdate /lcd_controller_tb/Wr_n_tb
add wave -noupdate /lcd_controller_tb/Rd_n_tb
add wave -noupdate /lcd_controller_tb/D_tb
add wave -noupdate /lcd_controller_tb/LS_DC_n_tb
add wave -noupdate /lcd_controller_tb/LS_Wr_tb
add wave -noupdate /lcd_controller_tb/LS_Rd_tb
add wave -noupdate /lcd_controller_tb/LS_WrData_tb
add wave -noupdate /lcd_controller_tb/LS_RdData_tb
add wave -noupdate /lcd_controller_tb/LS_Busy_tb
add wave -noupdate /lcd_controller_tb/ML_Busy_tb
add wave -noupdate /lcd_controller_tb/FIFO_Rd_tb
add wave -noupdate /lcd_controller_tb/FIFO_RdData_tb
add wave -noupdate /lcd_controller_tb/FIFO_Empty_tb
add wave -noupdate /lcd_controller_tb/phase_id
add wave -noupdate /lcd_controller_tb/CLK_PER
add wave -noupdate /lcd_controller_tb/DELAY_TESTS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
