# TCL File Generated by Component Editor 16.0
# Fri Nov 04 11:21:17 CET 2016
# DO NOT MODIFY


# 
# rtc_module "rtc_module" v1.0
#  2016.11.04.11:21:17
# 
# 

# 
# request TCL package from ACDS 16.0
# 
package require -exact qsys 16.0


# 
# module rtc_module
# 
set_module_property DESCRIPTION ""
set_module_property NAME rtc_module
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME rtc_module
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL rtc
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file rtcmodule.vhd VHDL PATH rtcmodule.vhd TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset reset_sink
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 Address address Input 3
add_interface_port avalon_slave_0 ChipSelect chipselect Input 1
add_interface_port avalon_slave_0 Read read Input 1
add_interface_port avalon_slave_0 Write write Input 1
add_interface_port avalon_slave_0 ReadData readdata Output 8
add_interface_port avalon_slave_0 WriteData writedata Input 8
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink nReset reset_n Input 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock
set_interface_property conduit_end associatedReset ""
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end LedButton export Output 4


# 
# connection point conduit_end_1
# 
add_interface conduit_end_1 conduit end
set_interface_property conduit_end_1 associatedClock clock
set_interface_property conduit_end_1 associatedReset ""
set_interface_property conduit_end_1 ENABLED true
set_interface_property conduit_end_1 EXPORT_OF ""
set_interface_property conduit_end_1 PORT_NAME_MAP ""
set_interface_property conduit_end_1 CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end_1 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_1 Reset_Led export Output 1


# 
# connection point conduit_end_2
# 
add_interface conduit_end_2 conduit end
set_interface_property conduit_end_2 associatedClock clock
set_interface_property conduit_end_2 associatedReset ""
set_interface_property conduit_end_2 ENABLED true
set_interface_property conduit_end_2 EXPORT_OF ""
set_interface_property conduit_end_2 PORT_NAME_MAP ""
set_interface_property conduit_end_2 CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end_2 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_2 SelSeg export Output 8


# 
# connection point conduit_end_3
# 
add_interface conduit_end_3 conduit end
set_interface_property conduit_end_3 associatedClock clock
set_interface_property conduit_end_3 associatedReset ""
set_interface_property conduit_end_3 ENABLED true
set_interface_property conduit_end_3 EXPORT_OF ""
set_interface_property conduit_end_3 PORT_NAME_MAP ""
set_interface_property conduit_end_3 CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end_3 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_3 SwLed export Input 8


# 
# connection point conduit_end_4
# 
add_interface conduit_end_4 conduit end
set_interface_property conduit_end_4 associatedClock clock
set_interface_property conduit_end_4 associatedReset ""
set_interface_property conduit_end_4 ENABLED true
set_interface_property conduit_end_4 EXPORT_OF ""
set_interface_property conduit_end_4 PORT_NAME_MAP ""
set_interface_property conduit_end_4 CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end_4 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_4 nButton export Input 4


# 
# connection point conduit_end_5
# 
add_interface conduit_end_5 conduit end
set_interface_property conduit_end_5 associatedClock clock
set_interface_property conduit_end_5 associatedReset ""
set_interface_property conduit_end_5 ENABLED true
set_interface_property conduit_end_5 EXPORT_OF ""
set_interface_property conduit_end_5 PORT_NAME_MAP ""
set_interface_property conduit_end_5 CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end_5 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_5 nSelDig export Output 6

