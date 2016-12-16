onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lcd_top_tb/phase_id
add wave -noupdate -expand -group Slave -color {Slate Blue} /lcd_top_tb/DUV/SLAV/clk
add wave -noupdate -expand -group Slave -color {Slate Blue} /lcd_top_tb/DUV/SLAV/rst_n
add wave -noupdate -expand -group Slave -color Cyan /lcd_top_tb/DUV/SLAV/AS_Address
add wave -noupdate -expand -group Slave -color Cyan /lcd_top_tb/DUV/SLAV/AS_ChipSelect
add wave -noupdate -expand -group Slave -color Cyan /lcd_top_tb/DUV/SLAV/AS_Wr
add wave -noupdate -expand -group Slave -color Cyan /lcd_top_tb/DUV/SLAV/AS_WrData
add wave -noupdate -expand -group Slave -color Cyan /lcd_top_tb/DUV/SLAV/AS_Rd
add wave -noupdate -expand -group Slave -color Cyan /lcd_top_tb/DUV/SLAV/AS_RdData
add wave -noupdate -expand -group Slave -color Cyan /lcd_top_tb/DUV/SLAV/AS_IRQ
add wave -noupdate -expand -group Slave -color Cyan /lcd_top_tb/DUV/SLAV/AS_WaitRequest
add wave -noupdate -expand -group Slave -color Gold /lcd_top_tb/DUV/SLAV/LS_Busy
add wave -noupdate -expand -group Slave -color Gold /lcd_top_tb/DUV/SLAV/LS_DC_n
add wave -noupdate -expand -group Slave -color Gold /lcd_top_tb/DUV/SLAV/LS_Wr_n
add wave -noupdate -expand -group Slave -color Gold /lcd_top_tb/DUV/SLAV/LS_Rd_n
add wave -noupdate -expand -group Slave -color Gold /lcd_top_tb/DUV/SLAV/LS_WrData
add wave -noupdate -expand -group Slave -color Gold /lcd_top_tb/DUV/SLAV/LS_RdData
add wave -noupdate -expand -group Slave -color Orchid /lcd_top_tb/DUV/SLAV/MS_Address
add wave -noupdate -expand -group Slave -color Orchid /lcd_top_tb/DUV/SLAV/MS_Length
add wave -noupdate -expand -group Slave -color Orchid /lcd_top_tb/DUV/SLAV/MS_StartDMA
add wave -noupdate -expand -group Slave /lcd_top_tb/DUV/SLAV/state_reg
add wave -noupdate -expand -group Slave /lcd_top_tb/DUV/SLAV/state_next
add wave -noupdate -expand -group Slave /lcd_top_tb/DUV/SLAV/addr_reg
add wave -noupdate -expand -group Slave /lcd_top_tb/DUV/SLAV/addr_next
add wave -noupdate -expand -group Slave -radix unsigned /lcd_top_tb/DUV/SLAV/len_reg
add wave -noupdate -expand -group Slave -radix unsigned /lcd_top_tb/DUV/SLAV/len_next
add wave -noupdate -expand -group Master -color {Slate Blue} /lcd_top_tb/DUV/MAST/clk
add wave -noupdate -expand -group Master -color {Slate Blue} /lcd_top_tb/DUV/MAST/rst_n
add wave -noupdate -expand -group Master -color Cyan /lcd_top_tb/DUV/MAST/AM_Address
add wave -noupdate -expand -group Master -color Cyan /lcd_top_tb/DUV/MAST/AM_ByteEnable
add wave -noupdate -expand -group Master -color Cyan /lcd_top_tb/DUV/MAST/AM_Rd
add wave -noupdate -expand -group Master -color Cyan /lcd_top_tb/DUV/MAST/AM_RdDataValid
add wave -noupdate -expand -group Master -color Cyan /lcd_top_tb/DUV/MAST/AM_Burstcount
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/AM_RdData
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/AM_WaitRequest
add wave -noupdate -expand -group Master -color {Medium Orchid} /lcd_top_tb/DUV/MAST/MS_Address
add wave -noupdate -expand -group Master -color {Medium Orchid} /lcd_top_tb/DUV/MAST/MS_Length
add wave -noupdate -expand -group Master -color {Medium Orchid} /lcd_top_tb/DUV/MAST/MS_StartDMA
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/ML_Busy
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/FIFO_Full
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/FIFO_Wr
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/FIFO_WrData
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/FIFO_Almost_Full
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/state_reg
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/state_next
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/addr_reg
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/addr_next
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/len_reg
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/len_next
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/burst_counter_reg
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/burst_counter_next
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/word_counter_reg
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/word_counter_next
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/BURST_LENGTH
add wave -noupdate -expand -group Master /lcd_top_tb/DUV/MAST/BURST_COUNT
add wave -noupdate -expand -group Controller -color {Slate Blue} /lcd_top_tb/DUV/CTRL/clk
add wave -noupdate -expand -group Controller -color {Slate Blue} /lcd_top_tb/DUV/CTRL/rst_n
add wave -noupdate -expand -group Controller -color Cyan /lcd_top_tb/DUV/CTRL/CS_n
add wave -noupdate -expand -group Controller -color Cyan /lcd_top_tb/DUV/CTRL/DC_n
add wave -noupdate -expand -group Controller -color Cyan /lcd_top_tb/DUV/CTRL/Wr_n
add wave -noupdate -expand -group Controller -color Cyan /lcd_top_tb/DUV/CTRL/Rd_n
add wave -noupdate -expand -group Controller -color Cyan /lcd_top_tb/DUV/CTRL/D
add wave -noupdate -expand -group Controller -color Cyan /lcd_top_tb/DUV/CTRL/LCD_ON
add wave -noupdate -expand -group Controller -color Cyan /lcd_top_tb/DUV/CTRL/RESET_N
add wave -noupdate -expand -group Controller -color Orange /lcd_top_tb/DUV/CTRL/LS_DC_n
add wave -noupdate -expand -group Controller -color Orange /lcd_top_tb/DUV/CTRL/LS_Wr_n
add wave -noupdate -expand -group Controller -color Orange /lcd_top_tb/DUV/CTRL/LS_WrData
add wave -noupdate -expand -group Controller -color Orange /lcd_top_tb/DUV/CTRL/LS_RdData
add wave -noupdate -expand -group Controller -color Orange /lcd_top_tb/DUV/CTRL/LS_Rd_n
add wave -noupdate -expand -group Controller -color Orange /lcd_top_tb/DUV/CTRL/LS_Busy
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/ML_Busy
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/FIFO_Rd
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/FIFO_RdData
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/FIFO_Empty
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/curr_word_reg
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/curr_word_next
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/state_reg
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/state_next
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/phase_reg
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/phase_next
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/flipper
add wave -noupdate -expand -group Controller /lcd_top_tb/DUV/CTRL/NEW_FRAME_CMD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {94 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 247
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
WaveRestoreZoom {402 ns} {1348 ns}
