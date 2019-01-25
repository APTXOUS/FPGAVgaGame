proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.cache/wt [current_project]
  set_property parent.project_path C:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.xpr [current_project]
  set_property ip_repo_paths c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.cache/ip [current_project]
  set_property ip_output_repo c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.cache/ip [current_project]
  set_property XPM_LIBRARIES XPM_MEMORY [current_project]
  add_files -quiet C:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.runs/synth_1/game_main.dcp
  add_files -quiet c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/blk_mem_gen_0_1/blk_mem_gen_0.dcp
  set_property netlist_only true [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/blk_mem_gen_0_1/blk_mem_gen_0.dcp]
  add_files -quiet c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/rock_pic/rock_pic.dcp
  set_property netlist_only true [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/rock_pic/rock_pic.dcp]
  add_files -quiet c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_right/boat_right.dcp
  set_property netlist_only true [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_right/boat_right.dcp]
  add_files -quiet c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_up/boat_up.dcp
  set_property netlist_only true [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_up/boat_up.dcp]
  add_files -quiet c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_left/boat_left.dcp
  set_property netlist_only true [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_left/boat_left.dcp]
  add_files -quiet c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_down/boat_down.dcp
  set_property netlist_only true [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_down/boat_down.dcp]
  add_files -quiet c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_down/boom_down.dcp
  set_property netlist_only true [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_down/boom_down.dcp]
  add_files -quiet c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_up/boom_up.dcp
  set_property netlist_only true [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_up/boom_up.dcp]
  add_files -quiet c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_left/boom_left.dcp
  set_property netlist_only true [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_left/boom_left.dcp]
  add_files -quiet c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_right/boom_right.dcp
  set_property netlist_only true [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_right/boom_right.dcp]
  read_xdc -mode out_of_context -ref blk_mem_gen_0 -cells U0 c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/blk_mem_gen_0_1/blk_mem_gen_0_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/blk_mem_gen_0_1/blk_mem_gen_0_ooc.xdc]
  read_xdc -mode out_of_context -ref rock_pic -cells U0 c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/rock_pic/rock_pic_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/rock_pic/rock_pic_ooc.xdc]
  read_xdc -mode out_of_context -ref boat_right -cells U0 c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_right/boat_right_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_right/boat_right_ooc.xdc]
  read_xdc -mode out_of_context -ref boat_up -cells U0 c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_up/boat_up_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_up/boat_up_ooc.xdc]
  read_xdc -mode out_of_context -ref boat_left -cells U0 c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_left/boat_left_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_left/boat_left_ooc.xdc]
  read_xdc -mode out_of_context -ref boat_down -cells U0 c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_down/boat_down_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boat_down/boat_down_ooc.xdc]
  read_xdc -mode out_of_context -ref boom_down -cells U0 c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_down/boom_down_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_down/boom_down_ooc.xdc]
  read_xdc -mode out_of_context -ref boom_up -cells U0 c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_up/boom_up_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_up/boom_up_ooc.xdc]
  read_xdc -mode out_of_context -ref boom_left -cells U0 c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_left/boom_left_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_left/boom_left_ooc.xdc]
  read_xdc -mode out_of_context -ref boom_right -cells U0 c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_right/boom_right_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_right/boom_right_ooc.xdc]
  read_xdc C:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/constrs_1/new/vga.xdc
  link_design -top game_main -part xc7a100tcsg324-3
  write_hwdef -file game_main.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design -directive RuntimeOptimized
  write_checkpoint -force game_main_opt.dcp
  report_drc -file game_main_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design -directive Quick
  write_checkpoint -force game_main_placed.dcp
  report_io -file game_main_io_placed.rpt
  report_utilization -file game_main_utilization_placed.rpt -pb game_main_utilization_placed.pb
  report_control_sets -verbose -file game_main_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design -directive Quick
  write_checkpoint -force game_main_routed.dcp
  report_drc -file game_main_drc_routed.rpt -pb game_main_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file game_main_timing_summary_routed.rpt -rpx game_main_timing_summary_routed.rpx
  report_power -file game_main_power_routed.rpt -pb game_main_power_summary_routed.pb -rpx game_main_power_routed.rpx
  report_route_status -file game_main_route_status.rpt -pb game_main_route_status.pb
  report_clock_utilization -file game_main_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force game_main.mmi }
  write_bitstream -force game_main.bit 
  catch { write_sysdef -hwdef game_main.hwdef -bitfile game_main.bit -meminfo game_main.mmi -file game_main.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

