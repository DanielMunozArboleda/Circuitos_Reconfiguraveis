
# User Generated physical constraints 

create_pblock pblock_rp_instance
add_cells_to_pblock [get_pblocks pblock_rp_instance] [get_cells -quiet [list system_i/math_0/inst/math_v1_0_S_AXI_inst/rp_instance]]
resize_pblock [get_pblocks pblock_rp_instance] -add {SLICE_X8Y50:SLICE_X13Y64}
resize_pblock [get_pblocks pblock_rp_instance] -add {DSP48_X0Y20:DSP48_X0Y25}
