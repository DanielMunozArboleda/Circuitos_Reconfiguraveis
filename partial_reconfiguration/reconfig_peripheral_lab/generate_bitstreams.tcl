open_checkpoint Implement/Config_add/top_route_design.dcp
write_bitstream -file Bitstreams/Config_add.bit 
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/Config_add_pblock_rp_instance_partial.bit" Bitstreams/add.bin
close_project 
open_checkpoint Implement/Config_mult/top_route_design.dcp 
write_bitstream -file Bitstreams/Config_mult.bit 
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/Config_mult_pblock_rp_instance_partial.bit" Bitstreams/mult.bin
close_project 
open_checkpoint Implement/Config_blank/top_route_design.dcp 
write_bitstream -file Bitstreams/blanking.bit 
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/blanking_pblock_rp_instance_partial.bit" Bitstreams/blank.bin
close_project 
