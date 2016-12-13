onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lcd_master_tb/clk_tb
add wave -noupdate /lcd_master_tb/rst_n_tb
add wave -noupdate /lcd_master_tb/AM_Address_tb
add wave -noupdate /lcd_master_tb/AM_ByteEnable_tb
add wave -noupdate /lcd_master_tb/AM_Rd_tb
add wave -noupdate /lcd_master_tb/AM_RdDataValid_tb
add wave -noupdate /lcd_master_tb/AM_Burstcount_tb
add wave -noupdate /lcd_master_tb/AM_RdData_tb
add wave -noupdate /lcd_master_tb/AM_WaitRequest_tb
add wave -noupdate /lcd_master_tb/MS_Address_tb
add wave -noupdate /lcd_master_tb/MS_Length_tb
add wave -noupdate /lcd_master_tb/MS_StartDMA_tb
add wave -noupdate /lcd_master_tb/ML_Busy_tb
add wave -noupdate /lcd_master_tb/FIFO_Full_tb
add wave -noupdate /lcd_master_tb/FIFO_Wr_tb
add wave -noupdate /lcd_master_tb/FIFO_WrData_tb
add wave -noupdate /lcd_master_tb/FIFO_Almost_Full_tb
add wave -noupdate /lcd_master_tb/phase_id
add wave -noupdate /lcd_master_tb/done
add wave -noupdate /lcd_master_tb/CLK_PER
add wave -noupdate /lcd_master_tb/DELAY_TESTS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {510 ns} 0}
quietly wave cursor active 1
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
