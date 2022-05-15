onerror {resume}
quietly WaveActivateNextPane {} 0

radix define iee754s_fp -float -fraction 23 -base decimal -precision 10

set SFUS 1

add wave -noupdate -label CLK /sfu_tb/s_clk_i
add wave -noupdate -label DATA_IN -radix hexadecimal /sfu_tb/s_src1_i
add wave -noupdate -label DATA_RRO -radix hexadecimal /sfu_tb/s_sfu_input
add wave -noupdate -label OPER /sfu_tb/s_selop_i
add wave -noupdate -label RESULT -radix hexadecimal /sfu_tb/s_Result_o
add wave -noupdate -label ErrTMR /sfu_tb/s_Result_o_err

add wave -noupdate -group SFU_PROC /sfu_tb/DUT/DUT01/*
add wave -noupdate -group SFU_PROC /sfu_tb/DUT/DUT02/*
add wave -noupdate -group SFU_PROC /sfu_tb/DUT/DUT03/*

add wave -noupdate -group uQuadraticInterpol /sfu_tb/DUT/DUT01/uQuadraticInterpol/*
add wave -noupdate -group u_SpecialSquaringUnit /sfu_tb/DUT/DUT01/uQuadraticInterpol/u_SpecialSquaringUnit/*
add wave -noupdate -group uFusedAccTree /sfu_tb/DUT/DUT01/uQuadraticInterpol/uFusedAccTree/*

add wave -noupdate -group uQuadraticInterpol /sfu_tb/DUT/DUT02/uQuadraticInterpol/*
add wave -noupdate -group u_SpecialSquaringUnit /sfu_tb/DUT/DUT02/uQuadraticInterpol/u_SpecialSquaringUnit/*
add wave -noupdate -group uFusedAccTree /sfu_tb/DUT/DUT02/uQuadraticInterpol/uFusedAccTree/*

add wave -noupdate -group uQuadraticInterpol /sfu_tb/DUT/DUT03/uQuadraticInterpol/*
add wave -noupdate -group u_SpecialSquaringUnit /sfu_tb/DUT/DUT03/uQuadraticInterpol/u_SpecialSquaringUnit/*
add wave -noupdate -group uFusedAccTree /sfu_tb/DUT/DUT03/uQuadraticInterpol/uFusedAccTree/*

add wave -noupdate -group Test_Bench_Signals /sfu_tb/*

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {80000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 76
configure wave -valuecolwidth 49
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {180 ns}
