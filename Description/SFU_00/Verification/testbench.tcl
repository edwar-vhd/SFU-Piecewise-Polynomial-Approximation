# stop any simulation that is currently running
quit -sim

vlib work

#RRO compile files
vcom -93 ./../SFU/RRO/Components/fp_leading_zeros_and_shift.vhd
vcom -93 ./../SFU/RRO/Components/right_shifter.vhd
vcom -93 ./../SFU/RRO/Components/add_sub.vhd
vcom -93 ./../SFU/RRO/Components/multFP.vhd
vcom -93 ./../SFU/RRO/RRO_trig.vhd
vcom -93 ./../SFU/RRO/RRO.vhd

#SFU compile files
vcom -93 ./../SFU/Components/CLZ.vhd
vcom -93 ./../SFU/Components/SFU_Exceptions.vhd
vcom -93 ./../SFU/fused_accm_tree/Booth_PP.vhd
vcom -93 ./../SFU/fused_accm_tree/CSA_4_2.vhd
vcom -93 ./../SFU/fused_accm_tree/fused_accum_tree.vhd

vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C0_cos.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C0_exp.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C0_ln2.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C0_ln2e0.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C0_reci.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C0_reci_sqrt_1_2.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C0_reci_sqrt_2_4.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C0_sin.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C0_sqrt_1_2.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C0_sqrt_2_4.vhd

vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C1_cos.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C1_exp.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C1_ln2.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C1_ln2e0.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C1_reci.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C1_reci_sqrt_1_2.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C1_reci_sqrt_2_4.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C1_sin.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C1_sqrt_1_2.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C1_sqrt_2_4.vhd

vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C2_cos.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C2_exp.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C2_ln2.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C2_ln2e0.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C2_reci.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C2_reci_sqrt_1_2.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C2_reci_sqrt_2_4.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C2_sin.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C2_sqrt_1_2.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Single_LUTS/LUT_C2_sqrt_2_4.vhd

vcom -93 ./../SFU/Quadratic_Interpolator/squaring.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/ROM.vhd
vcom -93 ./../SFU/Quadratic_Interpolator/Quadratic_Interpolator.vhd

vcom -93 ./../SFU/sfu.vhd
vcom -93 ./../SFU/sfu_tb.vhd

# start the Simulator, including some libraries that may be needed
vsim work.sfu_tb
# show waveforms specified in wave.do

do wave.do
# advance the simulation the desired amount of time
run 15 ms

quit -sim

quit