set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports keys]
set_property IOSTANDARD LVCMOS33 [get_ports speaker]
set_property IOSTANDARD LVCMOS33 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports song_select]
set_property IOSTANDARD LVCMOS33 [get_ports mode]
set_property IOSTANDARD LVCMOS33 [get_ports reset]


set_property PACKAGE_PIN U4 [get_ports song_select[0]]
set_property PACKAGE_PIN R17 [get_ports song_select[1]]

set_property PACKAGE_PIN R3 [get_ports mode[0]]
set_property PACKAGE_PIN T3 [get_ports mode[1]]
set_property PACKAGE_PIN T5 [get_ports mode[2]]


set_property PACKAGE_PIN P5 [get_ports keys[0]]
set_property PACKAGE_PIN P4 [get_ports keys[1]]
set_property PACKAGE_PIN P3 [get_ports keys[2]]
set_property PACKAGE_PIN P2 [get_ports keys[3]]
set_property PACKAGE_PIN R2 [get_ports keys[4]]
set_property PACKAGE_PIN M4 [get_ports keys[5]]
set_property PACKAGE_PIN N4 [get_ports keys[6]]

set_property PACKAGE_PIN R1 [get_ports reset]

set_property PACKAGE_PIN P17 [get_ports clk]

set_property PACKAGE_PIN F6 [get_ports led[0]]
set_property PACKAGE_PIN G4 [get_ports led[1]]
set_property PACKAGE_PIN G3 [get_ports led[2]]
set_property PACKAGE_PIN J4 [get_ports led[3]]
set_property PACKAGE_PIN H4 [get_ports led[4]]
set_property PACKAGE_PIN J3 [get_ports led[5]]
set_property PACKAGE_PIN J2 [get_ports led[6]]


set_property PACKAGE_PIN T1 [get_ports speaker]