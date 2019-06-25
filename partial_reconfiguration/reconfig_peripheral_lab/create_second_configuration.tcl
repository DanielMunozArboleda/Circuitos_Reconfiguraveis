read_checkpoint -cell system_i/math_0/inst/math_v1_0_S_AXI_inst/rp_instance Synth/reconfig_modules/rp_mult/add_mult_synth.dcp
opt_design 
place_design 
route_design
write_checkpoint -force Implement/Config_mult/top_route_design.dcp
write_checkpoint -force -cell system_i/math_0/inst/math_v1_0_S_AXI_inst/rp_instance Checkpoint/rp_instance_mult_route_design.dcp
close_project

