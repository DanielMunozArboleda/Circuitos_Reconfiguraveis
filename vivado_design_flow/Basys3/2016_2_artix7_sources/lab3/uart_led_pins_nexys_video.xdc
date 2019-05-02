# Nexys Video xdc
# LED [7:0]
############################
# On-board led             #
############################
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS25 } [get_ports { led_pins[0] }];
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS25 } [get_ports { led_pins[1] }];
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS25 } [get_ports { led_pins[2] }];
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS25 } [get_ports { led_pins[3] }];
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS25 } [get_ports { led_pins[4] }];
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS25 } [get_ports { led_pins[5] }];
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS25 } [get_ports { led_pins[6] }];
set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS25 } [get_ports { led_pins[7] }];

# CLK source 100 MHz
set_property -dict { PACKAGE_PIN R4    IOSTANDARD LVCMOS33 } [get_ports { clk_pin }];

# BTNU
set_property -dict { PACKAGE_PIN F15   IOSTANDARD LVCMOS33 } [get_ports { btn_pin }];

# RXD UART
set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { rxd_pin }];

# Reset - BTNC
set_property -dict { PACKAGE_PIN B22   IOSTANDARD LVCMOS33 } [get_ports { rst_pin }];