current_design $design_name

#######################################################################
# Define operational modes

set_operating_conditions $operating_cond -library $lib_name
set_wire_load_model -name $wire_load_mod
#set_wire_load_mode "segmented"

set_max_fanout 64 $design_name



#######################################################################
### size_only constraints on async controller templates


set_size_only -all_instances [find -hier cell c_elem*]


