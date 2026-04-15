# Load Quartus II Tcl Project package
package require ::quartus::project

# Add the next line to get the execute_flow command
package require ::quartus::flow

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
    if {[string compare $quartus(project) microprocessor]} {
        puts "Project microprocessor is not open"
        set make_assignments 0
    }
} else {
    # Only open if not already open
    if {[project_exists microprocessor]} {
        project_open -revision microprocessor microprocessor
    } else {
        project_new -revision microprocessor microprocessor
    }
    set need_to_close_project 1
}
# Make assignments
if {$make_assignments} {
    set_global_assignment -name FAMILY "MAX 10"
    set_global_assignment -name DEVICE 10M50DAF484C7G
	set_global_assignment -name TOP_LEVEL_ENTITY microprocessor
    set_global_assignment -name DEVICE_FILTER_PACKAGE FBGA
    set_global_assignment -name DEVICE_FILTER_PIN_COUNT 484
    set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
    set_global_assignment -name FMAX_REQUIREMENT "50 MHz "
    set_global_assignment -name RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
    set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
	set_global_assignment -name NUM_PARALLEL_PROCESSORS ALL
  
	# Include all entities and gates
    set_global_assignment -name VERILOG_FILE microprocessor.v
	
    # Map fpga_clk and ionets to fpga pins
	set_location_assignment PIN_B8 -to clk
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to clk
	set_location_assignment PIN_A7 -to reset
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to reset
	set_location_assignment PIN_C10 -to data_in[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to data_in[0]
	set_location_assignment PIN_C11 -to data_in[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to data_in[1]
	set_location_assignment PIN_D12 -to data_in[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to data_in[2]
	set_location_assignment PIN_C12 -to data_in[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to data_in[3]
	set_location_assignment PIN_J20 -to accum[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accum[0]
	set_location_assignment PIN_K20 -to accum[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accum[1]
	set_location_assignment PIN_L18 -to accum[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accum[2]
	set_location_assignment PIN_N18 -to accum[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accum[3]
	set_location_assignment PIN_M20 -to accum[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accum[4]
	set_location_assignment PIN_N19 -to accum[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accum[5]
	set_location_assignment PIN_N20 -to accum[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accum[6]
	set_location_assignment PIN_C18 -to addr_bus[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to addr_bus[0]
	set_location_assignment PIN_D18 -to addr_bus[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to addr_bus[1]
	set_location_assignment PIN_E18 -to addr_bus[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to addr_bus[2]
	set_location_assignment PIN_B16 -to addr_bus[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to addr_bus[3]
	set_location_assignment PIN_A17 -to addr_bus[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to addr_bus[4]
	set_location_assignment PIN_A18 -to addr_bus[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to addr_bus[5]
	set_location_assignment PIN_B17 -to addr_bus[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to addr_bus[6]
	set_location_assignment PIN_C14 -to data_bus[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to data_bus[0]
	set_location_assignment PIN_E15 -to data_bus[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to data_bus[1]
	set_location_assignment PIN_C15 -to data_bus[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to data_bus[2]
	set_location_assignment PIN_C16 -to data_bus[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to data_bus[3]
	set_location_assignment PIN_E16 -to data_bus[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to data_bus[4]
	set_location_assignment PIN_D17 -to data_bus[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to data_bus[5]
	set_location_assignment PIN_C17 -to data_bus[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to data_bus[6]
	set_location_assignment PIN_B20 -to instr_reg[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to instr_reg[0]
	set_location_assignment PIN_A20 -to instr_reg[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to instr_reg[1]
	set_location_assignment PIN_B19 -to instr_reg[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to instr_reg[2]
	set_location_assignment PIN_A21 -to instr_reg[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to instr_reg[3]
	set_location_assignment PIN_B21 -to instr_reg[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to instr_reg[4]
	set_location_assignment PIN_C22 -to instr_reg[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to instr_reg[5]
	set_location_assignment PIN_B22 -to instr_reg[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to instr_reg[6]
	
    # Commit assignments
    export_assignments
	
	# Run Analysis and Synthesis, Fitter and Program File Generator
	execute_flow -compile
	
	# To determine if compilation was successful or not
	# and print out a personalized message.
	# If successful, generate SVF file for OpenOCD or urJTAG programming.
	#if {[catch {execute_flow -compile} result]} {
	#	puts "\nResult: $result\n"
	#	puts "ERROR: Compilation failed. See report files.\n"
	#} else {
	#	puts "\nINFO: Compilation was successful.\n"
	#	qexec "quartus_cpf -c -q 10Mhz -g 3.3 -n p microprocessor.sof microprocessor.svf"
	#}
	
	# Generate SVF file for OpenOCD or urJTAG programming.
	qexec "quartus_cpf -c -q 10MHz -g 3.3 -n p microprocessor.sof microprocessor.svf"
	
    # Close project
    if {$need_to_close_project} {
        project_close
    }
}
		