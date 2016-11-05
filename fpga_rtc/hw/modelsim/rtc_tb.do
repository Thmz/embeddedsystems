onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /rtc_tb/DUV/clk
add wave -noupdate -radix decimal /rtc_tb/DUV/nReset
add wave -noupdate -radix decimal /rtc_tb/DUV/Address
add wave -noupdate -radix decimal /rtc_tb/DUV/ChipSelect
add wave -noupdate -radix decimal /rtc_tb/DUV/Read
add wave -noupdate -radix decimal /rtc_tb/DUV/Write
add wave -noupdate -radix decimal /rtc_tb/DUV/ReadData
add wave -noupdate -radix decimal /rtc_tb/DUV/WriteData
add wave -noupdate -radix binary /rtc_tb/DUV/SelSeg
add wave -noupdate -radix decimal /rtc_tb/DUV/Reset_Led
add wave -noupdate -radix binary /rtc_tb/DUV/nSelDig
add wave -noupdate -radix decimal /rtc_tb/DUV/SwLed
add wave -noupdate -radix decimal /rtc_tb/DUV/nButton
add wave -noupdate -radix decimal /rtc_tb/DUV/LedButton
add wave -noupdate -radix decimal /rtc_tb/DUV/hundreds
add wave -noupdate -radix decimal /rtc_tb/DUV/seconds
add wave -noupdate -radix decimal /rtc_tb/DUV/minutes
add wave -noupdate -radix decimal /rtc_tb/DUV/enable_1khz
add wave -noupdate -radix decimal /rtc_tb/DUV/enable_100hz
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {6218124 ps} {7242124 ps}
