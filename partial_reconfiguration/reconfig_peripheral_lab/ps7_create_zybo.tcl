start_gui
create_project reconfig_peripheral_zybo_lab ./reconfig_peripheral_zybo_lab -part xc7z010clg400-1
set_property board_part digilentinc.com:zybo:part0:1.0 [current_project]
set_property ip_repo_paths ./Sources/ip_repo [current_project]
update_ip_catalog
create_bd_design "system"
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
startgroup
set_property -dict [list CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {0} CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {0} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0} CONFIG.PCW_USB0_PERIPHERAL_ENABLE {0} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {0}] [get_bd_cells processing_system7_0]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:XUP:math:1.0 math_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins math_0/S_AXI]
validate_bd_design
regenerate_bd_layout
make_wrapper -files [get_files ./reconfig_peripheral_zybo_lab/reconfig_peripheral_zybo_lab.srcs/sources_1/bd/system/system.bd] -top
add_files -norecurse ./reconfig_peripheral_zybo_lab/reconfig_peripheral_zybo_lab.srcs/sources_1/bd/system/hdl/system_wrapper.v
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
save_bd_design
# set_property generate_synth_checkpoint true [get_files  ./reconfig_peripheral_zybo_lab/reconfig_peripheral_zybo_lab.srcs/sources_1/bd/system/system.bd]
# launch_runs synth_1 -jobs 4
# wait_on_run synth_1
# close_project
