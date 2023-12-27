set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports hsync]
set_property IOSTANDARD LVCMOS33 [get_ports vsync]
set_property IOSTANDARD LVCMOS33 [get_ports vga_r]
set_property IOSTANDARD LVCMOS33 [get_ports vga_g]
set_property IOSTANDARD LVCMOS33 [get_ports vga_b]


set_property PACKAGE_PIN P17 [get_ports clk]


set_property PACKAGE_PIN P15 [get_ports rst_n]

set_property PACKAGE_PIN D7 [get_ports hsync]
set_property PACKAGE_PIN C4 [get_ports vsync]

set_property PACKAGE_PIN F5 [get_ports {vga_r[0]}]
set_property PACKAGE_PIN C6 [get_ports {vga_r[1]}]
set_property PACKAGE_PIN C5 [get_ports {vga_r[2]}]
set_property PACKAGE_PIN B7 [get_ports {vga_r[3]}]

set_property PACKAGE_PIN B6 [get_ports  {vga_g[0]}]
set_property PACKAGE_PIN A6 [get_ports  {vga_g[1]}]
set_property PACKAGE_PIN A5 [get_ports  {vga_g[2]}]
set_property PACKAGE_PIN D8 [get_ports  {vga_g[3]}]


set_property PACKAGE_PIN C7 [get_ports {vga_b[0]}]
set_property PACKAGE_PIN E6 [get_ports {vga_b[1]}]
set_property PACKAGE_PIN E5 [get_ports {vga_b[2]}]
set_property PACKAGE_PIN E7 [get_ports {vga_b[3]}]


// #vga的颜色rgb
// set_property -dict {PACKAGE_PIN F5 IOSTANDARD LVCMOS33} [get_ports {vga_r[0]}]
// set_property -dict {PACKAGE_PIN C6 IOSTANDARD LVCMOS33} [get_ports {vga_r[1]}]
// set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports {vga_r[2]}]
// set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {vga_r[3]}]

// set_property -dict {PACKAGE_PIN B6 IOSTANDARD LVCMOS33} [get_ports {vga_g[0]}]
// set_property -dict {PACKAGE_PIN A6 IOSTANDARD LVCMOS33} [get_ports {vga_g[1]}]
// set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports {vga_g[2]}]
// set_property -dict {PACKAGE_PIN D8 IOSTANDARD LVCMOS33} [get_ports {vga_g[3]}]

// set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports {vga_b[0]}]
// set_property -dict {PACKAGE_PIN E6 IOSTANDARD LVCMOS33} [get_ports {vga_b[1]}]
// set_property -dict {PACKAGE_PIN E5 IOSTANDARD LVCMOS33} [get_ports {vga_b[2]}]
// set_property -dict {PACKAGE_PIN E7 IOSTANDARD LVCMOS33} [get_ports {vga_b[3]}]