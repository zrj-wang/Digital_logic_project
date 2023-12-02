set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports keys]
set_property IOSTANDARD LVCMOS33 [get_ports speaker]
set_property IOSTANDARD LVCMOS33 [get_ports Led]



set_property PACKAGE_PIN P5 [get_ports keys[1]]
set_property PACKAGE_PIN P4 [get_ports keys[2]]
set_property PACKAGE_PIN P3 [get_ports keys[3]]
set_property PACKAGE_PIN P2 [get_ports keys[4]]
set_property PACKAGE_PIN R2 [get_ports keys[5]]
set_property PACKAGE_PIN M4 [get_ports keys[6]]
set_property PACKAGE_PIN N4 [get_ports keys[7]]

set_property PACKAGE_PIN P17 [get_ports clk]

set_property PACKAGE_PIN F6 [get_ports Led[1]]
set_property PACKAGE_PIN G4 [get_ports Led[2]]
set_property PACKAGE_PIN G3 [get_ports Led[3]]
set_property PACKAGE_PIN J4 [get_ports Led[4]]
set_property PACKAGE_PIN H4 [get_ports Led[5]]
set_property PACKAGE_PIN J3 [get_ports Led[6]]
set_property PACKAGE_PIN J2 [get_ports Led[7]]


set_property PACKAGE_PIN F1 [get_ports speaker]
