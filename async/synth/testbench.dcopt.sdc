###################################################################

# Created by write_sdc on Fri May  9 22:54:32 2014

###################################################################
set sdc_version 1.9

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions PnomV180T025_STD_CELL_7RF -library                    \
PnomV180T025_STD_CELL_7RF
set_wire_load_model -name ZERO_WLM_4MZWB -library PnomV180T025_STD_CELL_7RF
set_max_fanout 64 [current_design]
