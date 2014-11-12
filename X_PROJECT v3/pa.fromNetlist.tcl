
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name X_PROJECT -dir "C:/Users/Edward/Desktop/FPGA-Musician--master/X_PROJECT v2/planAhead_run_1" -part xc6slx16csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Edward/Desktop/FPGA-Musician--master/X_PROJECT v2/TOP.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Edward/Desktop/FPGA-Musician--master/X_PROJECT v2} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "TOP.ucf" [current_fileset -constrset]
add_files [list {TOP.ucf}] -fileset [get_property constrset [current_run]]
link_design
