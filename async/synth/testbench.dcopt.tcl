### This is the script for optimizing the verilog


#----------------------------------------------------------------------#
#                        DESIGN DEFINITION                             #
#----------------------------------------------------------------------#


set design_name  testbench
set design_dir   "."


### EDIT $design_name.cstr.tcl for timing and other constraints!



############## technology files #########################
### can include multiple .db files in string.

### IBM 7rf 180nm:
set lib_name    "PnomV180T025_STD_CELL_7RF"
set lib_db      "PnomV180T025_STD_CELL_7RF.db"
set lib_dir     "/uusoc/facility/cad_tools/Async/lib/IBM/7RF/synopsys/"
#set lib_pdb   
set driving_cell   "INVERT_N"
set load_pin       "A"
set operating_cond "PnomV180T025_STD_CELL_7RF"
set wire_load_mod  "ZERO_WLM_4MZWB"



################################################
#            DC configuration variables
# Milkyway related variables
set mw_design_library $design_name.mw
#set mw_power_net   VDD
#set mw_ground_net  VSS
set mw_logic1_net  VDD
set mw_logic0_net  VSS
set mw_power_port  VDD
set mw_ground_port VSS

# db and cache configuration
set cache_read  {}
set cache_write {}
set allow_newer_db_files       true
set write_compressed_db_files  true
set sh_source_uses_search_path true
#################################################


# Define checkpoint function
proc checkpoint {name} {
  echo "CPU-$name: [cputime -self -child]"
  echo "MEM-$name: [mem]"
  echo "CLK-$name: [clock seconds]"
}

#----------------------------------------------------------------------#
#                             DESIGN SETUP                             #
#----------------------------------------------------------------------#

set search_path [concat  . $design_dir $lib_dir $search_path]
set search_path "$search_path ${synopsys_root}/libraries/syn"
set search_path "$search_path ${synopsys_root}/dw/sim_ver"


################################################################
# DC library definitions
set local_link_library [list ]
set target_library $lib_db
#set target_library $lib_dir/$lib_db

set synthetic_library "dw_foundation.sldb"
set link_library [concat * $lib_db $synthetic_library]
#set link_library [concat * $lib_dir/$lib_db $synthetic_library]
if [info exists lib_pdb] {
    set physical_library $lib_pdb
} else {
    set physical_library [list ]
}

set symbol_library [list ]
################################################################


### LINT-28: unconnected ports
### LINT-29: feedthroughs
### LINT-31: shorted outputs
### LINT-52: constant outputs
if [info exists dc_shell_mode] {
    set suppress_errors "$suppress_errors TRANS-1 TIM-111 TIM-164 TIM-175 OPT-109 UID-101 TIM-134 DDB-74 LINT-29 LINT-31 LINT-32 LINT-33 LINT-52"
}

checkpoint setup

#----------------------------------------------------------------------#
#                        READ DB FROM RTLOPT                           #
#----------------------------------------------------------------------#
read_file -format ddc $design_name.rtlopt.ddc
checkpoint read

current_design $design_name
link
checkpoint link



#----------------------------------------------------------------------#
#                           READ CONSTRAINTS                           #
#----------------------------------------------------------------------#
current_design $design_name
#set formality_link_debug true
set svf_file_records_change_names_changes true
set enable_dw_datapath_in_svf true
#set enable_ununiquify_in_svf true
set hlo_write_svf_info true
set synlib_fmlink_output_verilog true
set enable_constant_propagation_in_svf true
set_svf $design_name.dcopt.svf
set_vsdc $design_name.dcopt.vsdc
current_design  $design_name
source $design_name.cstr.tcl
checkpoint cstr



#----------------------------------------------------------------------#
#                                COMPILE                               #
#----------------------------------------------------------------------#
#current_design $design_name
#set ungroup_record_report_info true

list_designs -show_file
current_design $design_name
echo "Start: [cputime -self -child]"

## Do retiming:
#set_balance_registers true
#set_optimize_registers true
check_design

## clock gate design
#insert_clock_gating

#set_flatten -phase true -effort medium

### fix crashes during min-delay calculation?
#set_cost_priority -min_delay

## compile design
compile -area_effort medium
#compile -area_effort medium -power_effort high
#compile -area_effort medium -boundary_optimization
#compile -area_effort medium -ungroup_all
#compile -area_effort high -power_effort high -map_effort medium -ungroup_all
#compile -area_effort high -power_effort high -map_effort high -ungroup_all -verify_effort high
#compile_ultra
#compile_ultra -timing_high_effort_script
check_design

## guarantee naming consistency
#source namingrules.dc

echo "End: [cputime -self -child]"
checkpoint compile


#----------------------------------------------------------------------#
#                           FINAL QOR REPORT                           #
#----------------------------------------------------------------------#
current_design $design_name
file delete $design_name.profile_post.out
report_qor
report_area
report_timing -attributes
report_constraints


#  report_timing -from din -to i0/msched/lout/qreg*/D -delay max -max_paths 1
#  report_timing -from din -to i1/msched/lout/qreg*/D -delay max -max_paths 1
#  report_timing -from din -to i2/msched/lout/qreg*/D -delay max -max_paths 1
#  report_timing -from din -to i3/msched/lout/qreg*/D -delay max -max_paths 1
#report_timing -from hsh/lc/C4R2200r0/A0 -to hsh/lc0/C4R22000/A0 -delay min
#report_timing -from hsh/lc0/C4R22000/A0 -to hsh/lc/C4R2200r0/A0 -delay min

##report_timing -from hsh/constblk/\sel_reg[0]/CK -to hsh/latt1/d -delay max -max_paths 1

#report_timing -from lc0/C4R2200r0/A0 -to lc15/C4R2200r0/A0 -delay min -max_paths 10
#report_timing -from { tk0/lr tk10/lr tk11/lr } -to { tk10/lr tk11/lr tk2/lr } -delay min -max_paths 20
#report_timing -from { tk10/ra tk11/ra tk2/ra } -to { tk0/ra tk10/ra tk10/ra } -delay min -max_paths 20
#report_timing -from R0_reg/q -to { R10_reg/d R11_reg/d } -max_paths 20
#report_timing -from R10_reg/q -to R2_reg/d -max_paths 20
#report_timing -from R11_reg/q -to R2_reg/d -max_paths 20
#report_timing -from { tk0/lr tk0/ra}  -to  R0_reg/clk -max_paths 20
#report_timing -from { tk10/lr tk10/ra } -to  R10_reg/clk -max_paths 20
#report_timing -from { tk11/lr tk11/ra } -to  R11_reg/clk -max_paths 20
#report_timing -from { tk2/lr tk2/ra } -to  R2_reg/clk -max_paths 20
checkpoint report

#----------------------------------------------------------------------#
#                                 WRITE                                #
#----------------------------------------------------------------------#
current_design $design_name
write -format ddc -hierarchy -output $design_name.dcopt.ddc
write -format verilog -hierarchy -output $design_name.dcopt.v
#write -format verilog -output $design_name.dcopt.v
write_sdc $design_name.dcopt.sdc
write_sdf -context verilog $design_name.dcopt.sdf
redirect $design_name.dcopt.constraints { report_constraints -all_violators -verbose -significant_digits 3 }
redirect $design_name.dcopt.paths { report_timing -path end -delay max -max_paths 1000 -nworst 1000 -significant_digits 3 }
redirect $design_name.dcopt.paths.min { report_timing -path end -delay min -max_paths 1000 -nworst 1000 -significant_digits 3 }
redirect $design_name.dcopt.fullpaths { report_timing -path full -delay max -max_paths 1000 -nworst 1000 -significant_digits 3 }
redirect $design_name.dcopt.fullpaths.min { report_timing -path full -delay min -max_paths 1000 -nworst 1500 -significant_digits 3 }
## Area of 65nm NAND2X1A12TR is 1.8
redirect $design_name.dcopt.area { report_area }
redirect $design_name.dcopt.power { report_power }

# write_mw_verilog -design $design_name $design_name.mw.v

checkpoint write

exit
