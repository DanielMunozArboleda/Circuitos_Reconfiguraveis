# Nexys Video Pin Assignments
############################
# On-board Slide Switches  #
############################
set_property -dict { PACKAGE_PIN E22   IOSTANDARD LVCMOS12 } [get_ports { swt[0] }];
set_property -dict { PACKAGE_PIN F21   IOSTANDARD LVCMOS12 } [get_ports { swt[1] }];
set_property -dict { PACKAGE_PIN G21   IOSTANDARD LVCMOS12 } [get_ports { swt[2] }];
set_property -dict { PACKAGE_PIN G22   IOSTANDARD LVCMOS12 } [get_ports { swt[3] }];
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS12 } [get_ports { swt[4] }];
set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS12 } [get_ports { swt[5] }];
set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS12 } [get_ports { swt[6] }];
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS12 } [get_ports { swt[7] }];

############################
# On-board led             #
############################
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS25 } [get_ports { led[0] }];
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS25 } [get_ports { led[1] }];
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS25 } [get_ports { led[2] }];
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS25 } [get_ports { led[3] }];
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS25 } [get_ports { led[4] }]; 
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS25 } [get_ports { led[5] }]; 
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS25 } [get_ports { led[6] }]; 
set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS25 } [get_ports { led[7] }];