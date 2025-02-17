###############################################################################
# pin_assignment_DE0_Nano_SoC_TRDB_D5M_VGA.tcl
#
# BOARD         : DE0-Nano-SoC from Terasic
# Author        : Sahand Kashani-Akhavan from Terasic documentation
# Revision      : 1.5
# Creation date : 11/06/2015
#
# Syntax Rule : GROUP_NAME_N[bit]
#
# GROUP : specify a particular interface (ex: SDR_)
# NAME  : signal name (ex: CONFIG, D, ...)
# bit   : signal index
# _N    : to specify an active-low signal
#
# You can run this script from Quartus by observing the following steps:
# 1. Place this TCL script in your project directory
# 2. Open your project in Quartus
# 3. Go to the View > Utility Windows -> Tcl Console
# 4. In the Tcl Console type:
#        source pin_assignment_DE0_Nano_SoC.tcl
#
# 5. The script will assign pins and return an "assignment made" message.
###############################################################################

set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CSEMA4U23C6
set_global_assignment -name DEVICE_FILTER_PACKAGE UFBGA
set_global_assignment -name DEVICE_FILTER_PIN_COUNT 896
set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 6

#============================================================
# ADC
#============================================================
set_location_assignment PIN_U9  -to ADC_CONVST
set_location_assignment PIN_V10 -to ADC_SCK
set_location_assignment PIN_AC4 -to ADC_SDI
set_location_assignment PIN_AD4 -to ADC_SDO

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_CONVST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_SCK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_SDI
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_SDO

#============================================================
# ARDUINO
#============================================================
set_location_assignment PIN_AG13 -to ARDUINO_IO[0]
set_location_assignment PIN_AG13 -to ARDUINO_IO_0
set_location_assignment PIN_AF13 -to ARDUINO_IO[1]
set_location_assignment PIN_AF13 -to ARDUINO_IO_1
set_location_assignment PIN_AG10 -to ARDUINO_IO[2]
set_location_assignment PIN_AG10 -to ARDUINO_IO_2
set_location_assignment PIN_AG9  -to ARDUINO_IO[3]
set_location_assignment PIN_AG9  -to ARDUINO_IO_3
set_location_assignment PIN_U14  -to ARDUINO_IO[4]
set_location_assignment PIN_U14  -to ARDUINO_IO_4
set_location_assignment PIN_U13  -to ARDUINO_IO[5]
set_location_assignment PIN_U13  -to ARDUINO_IO_5
set_location_assignment PIN_AG8  -to ARDUINO_IO[6]
set_location_assignment PIN_AG8  -to ARDUINO_IO_6
set_location_assignment PIN_AH8  -to ARDUINO_IO[7]
set_location_assignment PIN_AH8  -to ARDUINO_IO_7
set_location_assignment PIN_AF17 -to ARDUINO_IO[8]
set_location_assignment PIN_AF17 -to ARDUINO_IO_8
set_location_assignment PIN_AE15 -to ARDUINO_IO[9]
set_location_assignment PIN_AE15 -to ARDUINO_IO_9
set_location_assignment PIN_AF15 -to ARDUINO_IO[10]
set_location_assignment PIN_AF15 -to ARDUINO_IO_10
set_location_assignment PIN_AG16 -to ARDUINO_IO[11]
set_location_assignment PIN_AG16 -to ARDUINO_IO_11
set_location_assignment PIN_AH11 -to ARDUINO_IO[12]
set_location_assignment PIN_AH11 -to ARDUINO_IO_12
set_location_assignment PIN_AH12 -to ARDUINO_IO[13]
set_location_assignment PIN_AH12 -to ARDUINO_IO_13
set_location_assignment PIN_AH9  -to ARDUINO_IO[14]
set_location_assignment PIN_AH9  -to ARDUINO_IO_14
set_location_assignment PIN_AG11 -to ARDUINO_IO[15]
set_location_assignment PIN_AG11 -to ARDUINO_IO_15
set_location_assignment PIN_AH7  -to ARDUINO_RESET_N

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_8
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_9
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_10
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_11
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_12
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_13
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_14
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO_15
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_RESET_N

#============================================================
# CLOCK
#============================================================
set_location_assignment PIN_V11 -to FPGA_CLK1_50
set_location_assignment PIN_Y13 -to FPGA_CLK2_50
set_location_assignment PIN_E11 -to FPGA_CLK3_50

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FPGA_CLK1_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FPGA_CLK2_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FPGA_CLK3_50

#============================================================
# HPS
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_CONV_USB_N
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_1
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_2
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[3]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_3
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[4]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_4
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[5]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_5
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[6]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_6
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[7]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_7
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[8]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_8
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[9]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_9
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[10]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_10
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[11]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_11
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[12]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_12
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[13]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_13
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[14]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR_14
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA_0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA_1
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA_2
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CAS_N
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CKE
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_CK_N
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_CK_P
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CS_N
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM_0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM_1
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM_2
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[3]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM_3
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_1
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_2
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[3]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_3
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[4]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_4
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[5]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_5
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[6]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_6
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[7]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_7
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[8]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_8
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[9]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_9
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[10]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_10
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[11]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_11
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[12]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_12
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[13]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_13
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[14]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_14
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[15]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_15
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[16]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_16
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[17]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_17
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[18]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_18
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[19]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_19
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[20]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_20
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[21]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_21
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[22]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_22
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[23]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_23
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[24]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_24
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[25]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_25
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[26]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_26
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[27]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_27
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[28]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_28
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[29]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_29
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[30]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_30
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[31]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ_31
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[0]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N_0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[1]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N_1
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[2]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N_2
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[3]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N_3
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[0]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P_0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[1]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P_1
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[2]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P_2
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[3]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P_3
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ODT
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RAS_N
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RESET_N
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RZQ
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_WE_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_GTX_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_INT_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_MDC
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_MDIO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DV
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_EN
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_GSENSOR_INT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C0_SCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C0_SDAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C1_SCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C1_SDAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_KEY_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_LED
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_LTC_GPIO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_CMD
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_MISO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_MOSI
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_SS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_UART_RX
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_UART_TX
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_CLKOUT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA_7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DIR
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_NXT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_STP

#============================================================
# KEY_N
#============================================================
set_location_assignment PIN_AH17 -to KEY_N[0]
set_location_assignment PIN_AH17 -to KEY_N_0
set_location_assignment PIN_AH16 -to KEY_N[1]
set_location_assignment PIN_AH16 -to KEY_N_1

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N_1

#============================================================
# LED
#============================================================
set_location_assignment PIN_W15  -to LED[0]
set_location_assignment PIN_W15  -to LED_0
set_location_assignment PIN_AA24 -to LED[1]
set_location_assignment PIN_AA24 -to LED_1
set_location_assignment PIN_V16  -to LED[2]
set_location_assignment PIN_V16  -to LED_2
set_location_assignment PIN_V15  -to LED[3]
set_location_assignment PIN_V15  -to LED_3
set_location_assignment PIN_AF26 -to LED[4]
set_location_assignment PIN_AF26 -to LED_4
set_location_assignment PIN_AE26 -to LED[5]
set_location_assignment PIN_AE26 -to LED_5
set_location_assignment PIN_Y16  -to LED[6]
set_location_assignment PIN_Y16  -to LED_6
set_location_assignment PIN_AA23 -to LED[7]
set_location_assignment PIN_AA23 -to LED_7

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED_7

#============================================================
# SW
#============================================================
set_location_assignment PIN_L10 -to SW[0]
set_location_assignment PIN_L10 -to SW_0
set_location_assignment PIN_L9  -to SW[1]
set_location_assignment PIN_L9  -to SW_1
set_location_assignment PIN_H6  -to SW[2]
set_location_assignment PIN_H6  -to SW_2
set_location_assignment PIN_H5  -to SW[3]
set_location_assignment PIN_H5  -to SW_3

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_3

#============================================================
# GPIO_0, GPIO_0 connect to VGA extension board
#============================================================
set_location_assignment PIN_AF7  -to GPIO_0_VGA_CAM_PAL_VGA_SCL
set_location_assignment PIN_AF8  -to GPIO_0_VGA_CAM_PAL_VGA_SDA
set_location_assignment PIN_Y5   -to GPIO_0_VGA_VIDEO_HSYNC
set_location_assignment PIN_U11  -to GPIO_0_VGA_BOARD_ID
set_location_assignment PIN_T8   -to GPIO_0_VGA_VIDEO_VSYNC
set_location_assignment PIN_T12  -to GPIO_0_VGA_VIDEO_CLK
set_location_assignment PIN_AG6  -to GPIO_0_VGA_VIDEO_B[0]
set_location_assignment PIN_AG6  -to GPIO_0_VGA_VIDEO_B_0
set_location_assignment PIN_AF4  -to GPIO_0_VGA_VIDEO_B[1]
set_location_assignment PIN_AF4  -to GPIO_0_VGA_VIDEO_B_1
set_location_assignment PIN_AH2  -to GPIO_0_VGA_VIDEO_B[2]
set_location_assignment PIN_AH2  -to GPIO_0_VGA_VIDEO_B_2
set_location_assignment PIN_AH3  -to GPIO_0_VGA_VIDEO_B[3]
set_location_assignment PIN_AH3  -to GPIO_0_VGA_VIDEO_B_3
set_location_assignment PIN_AG5  -to GPIO_0_VGA_VIDEO_B[4]
set_location_assignment PIN_AG5  -to GPIO_0_VGA_VIDEO_B_4
set_location_assignment PIN_AH4  -to GPIO_0_VGA_VIDEO_B[5]
set_location_assignment PIN_AH4  -to GPIO_0_VGA_VIDEO_B_5
set_location_assignment PIN_AH6  -to GPIO_0_VGA_VIDEO_B[6]
set_location_assignment PIN_AH6  -to GPIO_0_VGA_VIDEO_B_6
set_location_assignment PIN_AH5  -to GPIO_0_VGA_VIDEO_B[7]
set_location_assignment PIN_AH5  -to GPIO_0_VGA_VIDEO_B_7
set_location_assignment PIN_AE8  -to GPIO_0_VGA_VIDEO_G[0]
set_location_assignment PIN_AE8  -to GPIO_0_VGA_VIDEO_G_0
set_location_assignment PIN_AF9  -to GPIO_0_VGA_VIDEO_G[1]
set_location_assignment PIN_AF9  -to GPIO_0_VGA_VIDEO_G_1
set_location_assignment PIN_AF6  -to GPIO_0_VGA_VIDEO_G[2]
set_location_assignment PIN_AF6  -to GPIO_0_VGA_VIDEO_G_2
set_location_assignment PIN_AE7  -to GPIO_0_VGA_VIDEO_G[3]
set_location_assignment PIN_AE7  -to GPIO_0_VGA_VIDEO_G_3
set_location_assignment PIN_T11  -to GPIO_0_VGA_VIDEO_G[4]
set_location_assignment PIN_T11  -to GPIO_0_VGA_VIDEO_G_4
set_location_assignment PIN_T13  -to GPIO_0_VGA_VIDEO_G[5]
set_location_assignment PIN_T13  -to GPIO_0_VGA_VIDEO_G_5
set_location_assignment PIN_AE4  -to GPIO_0_VGA_VIDEO_G[6]
set_location_assignment PIN_AE4  -to GPIO_0_VGA_VIDEO_G_6
set_location_assignment PIN_AF5  -to GPIO_0_VGA_VIDEO_G[7]
set_location_assignment PIN_AF5  -to GPIO_0_VGA_VIDEO_G_7
set_location_assignment PIN_AE12 -to GPIO_0_VGA_VIDEO_R[0]
set_location_assignment PIN_AE12 -to GPIO_0_VGA_VIDEO_R_0
set_location_assignment PIN_AF11 -to GPIO_0_VGA_VIDEO_R[1]
set_location_assignment PIN_AF11 -to GPIO_0_VGA_VIDEO_R_1
set_location_assignment PIN_AE11 -to GPIO_0_VGA_VIDEO_R[2]
set_location_assignment PIN_AE11 -to GPIO_0_VGA_VIDEO_R_2
set_location_assignment PIN_AD12 -to GPIO_0_VGA_VIDEO_R[3]
set_location_assignment PIN_AD12 -to GPIO_0_VGA_VIDEO_R_3
set_location_assignment PIN_AF10 -to GPIO_0_VGA_VIDEO_R[4]
set_location_assignment PIN_AF10 -to GPIO_0_VGA_VIDEO_R_4
set_location_assignment PIN_AD11 -to GPIO_0_VGA_VIDEO_R[5]
set_location_assignment PIN_AD11 -to GPIO_0_VGA_VIDEO_R_5
set_location_assignment PIN_AE9  -to GPIO_0_VGA_VIDEO_R[6]
set_location_assignment PIN_AE9  -to GPIO_0_VGA_VIDEO_R_6
set_location_assignment PIN_AD10 -to GPIO_0_VGA_VIDEO_R[7]
set_location_assignment PIN_AD10 -to GPIO_0_VGA_VIDEO_R_7

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_CAM_PAL_VGA_SCL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_CAM_PAL_VGA_SDA
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_HSYNC
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_BOARD_ID
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_VSYNC
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_B_7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_G_7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_VGA_VIDEO_R_7

#============================================================
# GPIO_1, GPIO connect to D5M - 5M Pixel Camera
#============================================================
set_location_assignment PIN_AG18 -to GPIO_1_D5M_D[0]
set_location_assignment PIN_AG18 -to GPIO_1_D5M_D_0
set_location_assignment PIN_AC23 -to GPIO_1_D5M_D[1]
set_location_assignment PIN_AC23 -to GPIO_1_D5M_D_1
set_location_assignment PIN_AF20 -to GPIO_1_D5M_D[2]
set_location_assignment PIN_AF20 -to GPIO_1_D5M_D_2
set_location_assignment PIN_AG19 -to GPIO_1_D5M_D[3]
set_location_assignment PIN_AG19 -to GPIO_1_D5M_D_3
set_location_assignment PIN_AG20 -to GPIO_1_D5M_D[4]
set_location_assignment PIN_AG20 -to GPIO_1_D5M_D_4
set_location_assignment PIN_AF21 -to GPIO_1_D5M_D[5]
set_location_assignment PIN_AF21 -to GPIO_1_D5M_D_5
set_location_assignment PIN_AE22 -to GPIO_1_D5M_D[6]
set_location_assignment PIN_AE22 -to GPIO_1_D5M_D_6
set_location_assignment PIN_AF23 -to GPIO_1_D5M_D[7]
set_location_assignment PIN_AF23 -to GPIO_1_D5M_D_7
set_location_assignment PIN_AH24 -to GPIO_1_D5M_D[8]
set_location_assignment PIN_AH24 -to GPIO_1_D5M_D_8
set_location_assignment PIN_AG26 -to GPIO_1_D5M_D[9]
set_location_assignment PIN_AG26 -to GPIO_1_D5M_D_9
set_location_assignment PIN_AH27 -to GPIO_1_D5M_D[10]
set_location_assignment PIN_AH27 -to GPIO_1_D5M_D_10
set_location_assignment PIN_AG28 -to GPIO_1_D5M_D[11]
set_location_assignment PIN_AG28 -to GPIO_1_D5M_D_11
set_location_assignment PIN_AD19 -to GPIO_1_D5M_FVAL
set_location_assignment PIN_AF18 -to GPIO_1_D5M_LVAL
set_location_assignment PIN_Y15  -to GPIO_1_D5M_PIXCLK
set_location_assignment PIN_AF25 -to GPIO_1_D5M_RESET_N
set_location_assignment PIN_AE24 -to GPIO_1_D5M_SCLK
set_location_assignment PIN_AE20 -to GPIO_1_D5M_SDATA
set_location_assignment PIN_AE19 -to GPIO_1_D5M_STROBE
set_location_assignment PIN_AG23 -to GPIO_1_D5M_TRIGGER
set_location_assignment PIN_AG24 -to GPIO_1_D5M_XCLKIN

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_8
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_9
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_10
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_D_11
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_FVAL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_LVAL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_PIXCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_RESET_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_SCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_SDATA
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_STROBE
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_TRIGGER
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5M_XCLKIN
