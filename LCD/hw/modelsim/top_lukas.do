onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lcd_top_tb/clk_tb
add wave -noupdate /lcd_top_tb/rst_n_tb
add wave -noupdate /lcd_top_tb/AS_Address_tb
add wave -noupdate /lcd_top_tb/AS_ChipSelect_tb
add wave -noupdate /lcd_top_tb/AS_Wr_tb
add wave -noupdate /lcd_top_tb/AS_WrData_tb
add wave -noupdate /lcd_top_tb/AS_Rd_tb
add wave -noupdate /lcd_top_tb/AS_RdData_tb
add wave -noupdate /lcd_top_tb/AS_IRQ_tb
add wave -noupdate /lcd_top_tb/AS_WaitRequest_tb
add wave -noupdate /lcd_top_tb/AM_Address_tb
add wave -noupdate /lcd_top_tb/AM_ByteEnable_tb
add wave -noupdate /lcd_top_tb/AM_Rd_tb
add wave -noupdate /lcd_top_tb/AM_RdDataValid_tb
add wave -noupdate /lcd_top_tb/AM_Burstcount_tb
add wave -noupdate /lcd_top_tb/AM_RdData_tb
add wave -noupdate /lcd_top_tb/AM_WaitRequest_tb
add wave -noupdate /lcd_top_tb/CS_n_tb
add wave -noupdate /lcd_top_tb/DC_n_tb
add wave -noupdate /lcd_top_tb/Wr_n_tb
add wave -noupdate /lcd_top_tb/Rd_n_tb
add wave -noupdate /lcd_top_tb/D_tb
add wave -noupdate /lcd_top_tb/phase_id
add wave -noupdate /lcd_top_tb/done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {592 ns} 0}
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
