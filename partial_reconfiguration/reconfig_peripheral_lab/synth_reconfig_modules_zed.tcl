read_verilog Sources/reconfig_modules/rp_add/rp_add.v
synth_design -mode out_of_context -flatten_hierarchy rebuilt -top rp -part xc7z020clg484-1
write_checkpoint Synth/reconfig_modules/rp_add/add_mult_synth.dcp
close_design
read_verilog Sources/reconfig_modules/rp_mult/rp_mult.v
synth_design -mode out_of_context -flatten_hierarchy rebuilt -top rp -part xc7z020clg484-1
write_checkpoint Synth/reconfig_modules/rp_mult/add_mult_synth.dcp
close_design
close_project

