### Tcl test bench for traditional "data valid on rising req" protocols
###
### This relies on LHS and RHS agents to control the circuit.
###
### 1. Find the forward latency (input to output)
### 2. Find the backward bubble latency (output to input)
### 3. Find the cycle time


### Notes:  $Now is the current time


### Initialize some variables, the wave viewer, etc.
### These get echoed to the output for some bogus reason
### Putting in an if statement removes the echo

if { 1 } {

    # Reset time
    set reset_time 20ns
    set break_time 150ns
    set break_time2 1500ns
    set zero_buf_cycle_break  70

    # initial left rise time and right rise time for forward latency
    set forward_latency 0
    set lr_up 0
    set rr_up 0
    set lhs_delay 0

    # initial right rise time for backward latency
    set backward_latency 0
    set ra_up 0
    set la_up 0
    set bl_go 1

    # cycle time calculations
    set cycle_time 0
    set last_lr_val 0
    set last_lr_up_time 0
    set last_la_val 0
    set last_la_dn_time 0

    # size of the buffer
    set tokens 0
    set all_tokens 0

    ### Set up wave viewer:
    destroy .wave
    view wave
    add wave rst lr la rr ra -divider "control signals"
    add wave go_l go_r
}


### Initialize the pipeline values with a reset
force go_l 0
force go_r 0
run $reset_time

# Make loop start time relative to Now!
set sim_start $Now


# Run test.  First see forward latency and count number of tokens

# start left handshaking
force go_l 1

# loop until buffer is full, setting max cycle time
while { 1 } {
    # Initialize previous state variables
    set last_lr_val [exa lr]
    set last_la_val [exa la]

    # run for one step
    run 5ps


    ## do tests and collect data values

    ### forward latency values
    # set lr_up to time of first rising lr
    # this should be the forward latency
    if { $lr_up == 0 && [exa lr] == "St1" } {
	set lr_up $Now;
	# set sim start.  Delete the extra 10ns
	set lhs_delay [subTime $Now $sim_start]
    }
    # set rr_up to time of first rising rr
    if { $rr_up == 0 && [exa rr] == "St1" } {
	set rr_up $Now;
	set forward_latency "[subTime $rr_up $lr_up]"
    }

    ### Cycle time values and Token Counting
    # set time of last rising lr
    if { $last_lr_val == "St0" && [exa lr] == "St1" } {
	set last_lr_up_time $Now
    }
    if { $last_la_val == "St1" && [exa la] == "St0" } {
	set last_la_dn_time $Now
	if { $cycle_time == 0
	     || [ltTime $cycle_time [subTime $last_la_dn_time $last_lr_up_time]] } {
	    set cycle_time [subTime $last_la_dn_time $last_lr_up_time]
	    ## don't do here or we need to compare as well..
	    ##set cycle_time [addTime $lhs_delay $cycle_time]
	    #echo "cycle time set to $cycle_time"
	}
	# add number of buffers used
	set tokens [expr 1 + $tokens]
    }

    ### Break condition
    if { $cycle_time != 0 } {
	if { [gtTime $Now [addTime $last_lr_up_time [mulTime $cycle_time 3]]] } {
	    #echo "Breaking loop - three times max cycle without another req"
	    #echo "$Now > [addTime $last_lr_up_time [mulTime $cycle_time 3]]"
	    break
	}
    }
    if { [gtTime $now [addTime $break_time $sim_start]] } {
	if { $tokens != 0 } {
	    echo "***Error: - needed to break out of loop"
	}
	break
    }
}



echo 
echo "Buffering depth:          $tokens"
echo "Forward Latency Delay:    $forward_latency"
echo "Backward Latency Delay:   $backward_latency"
echo "Max Cycle Time:           [addTime $cycle_time $lhs_delay]"
echo 
#echo "Run Time:                 $Now"


### Calculate backward latency

# Enable right interface
force go_r 1

set sim_start $Now

### check for funny condition where la is asserted in protocol when full
if { [exa la] == "St1" } {
    set bl_go 0
}

if { $tokens == 0 } {
    ## don't make cycle time be basd on long break time.
    set last_lr_up_time $Now
}



while { 1 } {
    # Initialize previous state variables
    set last_lr_val [exa lr]
    set last_la_val [exa la]

    # run for one step
    run 5ps

    ## do tests and collect data values

    ### forward latency values
    # set ra_up to time of first rising ra
    if { $ra_up == 0 && [exa ra] == "St1" } {
	set ra_up $Now;
    }
    # set bl_go when la goes low.
    if { $bl_go == 0 && [exa la] == "St0" } {
	set bl_go 1
    }
    # set la_up to time of first rising rr
    if { $la_up == 0 && [exa la] == "St1" && $bl_go == 1} {
	set la_up $Now;
	set backward_latency "[subTime $la_up $ra_up]"
    }

    ### Cycle time values and Token Counting
    # set time of last rising lr
    if { $last_lr_val == "St0" && [exa lr] == "St1" } {
	set last_lr_up_time $Now
    }
    if { $last_la_val == "St1" && [exa la] == "St0" } {
	set last_la_dn_time $Now
	if { $all_tokens >= $tokens &&
	     [ltTime $cycle_time [subTime $last_la_dn_time $last_lr_up_time]] } {
	    set cycle_time [subTime $last_la_dn_time $last_lr_up_time]
	    ## don't do here or we need to compare as well
	    ##set cycle_time [addTime $lhs_delay $cycle_time]
	    #echo "cycle time set to $cycle_time"
	}
	# add number of buffers used
	set all_tokens [expr 1 + $all_tokens]
    }

    ### Break condition
    if { $all_tokens > [expr 2.5 * $tokens ] } {
	if { $tokens == 0 } {
	    ## set second break level based on function
	    if { $all_tokens >= $zero_buf_cycle_break } {
		break
	    }
	} else {
	    break
	}
    }
    if { [gtTime $Now [addTime $break_time2 $sim_start]] } {
	echo "***Error - needed to break out of loop"
	echo "tokens: $all_tokens : $tokens"
	break
    }
}



### Print results


echo 
echo "Buffering depth:          $tokens"
echo "Forward Latency Delay:    $forward_latency"
echo "Backward Latency Delay:   $backward_latency"
echo "Max Cycle Time:           [addTime $cycle_time $lhs_delay]"
echo 
echo "Run Time:                 $Now"

# echo "lr_up: $lr_up\nrr_up: $rr_up\ntokens: $tokens\ntime: $Now"


