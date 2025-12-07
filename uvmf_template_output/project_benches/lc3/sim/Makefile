#
#----------------------------------------------------------------------
#                                          
# DESCRIPTION: This makefile includes the shared makefile and contains
#   bench level make targets.
#
#----------------------------------------------------------------------


# pragma uvmf custom additional begin
# pragma uvmf custom additional end

# *********************************************************************************************
# UVMF library directory:
# This variable points to the UVMF release where uvmf_base_pkg directory resides.
# This variable points to release code that is not user modified.
# This variable allows for UVMF release directories to reside independent of project related verification IP and project bench directories.
# This code below looks "upward" for directory starting with UVMF_* and returns first match for use with the release examples.
export UVMF_HOME ?= /mnt/apps/public/COE/mg_apps/questa2025.1_1/questasim/examples/UVM_Framework/UVMF_2023.4_2/

# pragma uvmf custom exports begin
#
# Project(s) specific verification IP library:
# Directory where reusable verification packages for interfaces, environments, utilities, etc. reside.
# This variable allows for your verification IP to reside independent of project bench and UVMF release directories.
# For examples deployed with UVMF this will be $(UVMF_HOME)/<example_group>/verification_ip
export UVMF_VIP_LIBRARY_HOME = $(PWD)/../../../verification_ip
#
# Project specific bench:
# Directory where bench specific code is located.
# This variable allows for project_benches to reside independent of verification IP and UVMF release directories.
# For examples deployed with UVMF this will be $(UVMF_HOME)/<example_group>/project_benches/<example_bench>
export UVMF_PROJECT_DIR ?= $(PWD)/..
#
#
# pragma uvmf custom exports end
# *********************************************************************************************
export PYTHON ?= /usr/bin/python3.11
## Check PATH for required vinfo scripts
PVAL := $(shell command -v make_filelist.py 2> /dev/null)
ifndef PVAL
  MFLIST = $(UVMF_HOME)/scripts/make_filelist.py
else
  MFLIST = make_filelist.py
endif


# Set test case specific Variables
TEST_NAME            = alu_directed_test

TEST_SEED            = random
UVM_CLI_ARGS         = 

# Usage of Veloce, etc. to be input by the user (subject to defaults)
USE_VELOCE          ?= 0

# Usage of vinfo flow for generating file list
USE_VINFO           ?= 0

# Usage of Veloce and Questa profilers
USE_VELOCE_PROFILER ?= 0
USE_QUESTA_PROFILER ?= 0


# Set project Variables
TEST_PLAN_NAME       = lc3_TestPlan
REPORTING_DO_FILE    = lc3_reports_script


# Include makefile that includes targets for UVM_VIP_Library packages
include $(UVMF_HOME)/scripts/Makefile


# Include all requisite interface package targets for this bench
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/fetch_in_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/fetch_out_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/decode_in_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/decode_out_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/writeback_in_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/writeback_out_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/memaccess_in_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/memaccess_out_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/control_in_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/control_out_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/execute_in_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/execute_out_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/inst_mem_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/data_mem_pkg/Makefile

# Include all requisite environment package targets for this bench
include $(UVMF_VIP_LIBRARY_HOME)/environment_packages/lc3_env_pkg/Makefile



# Add to default compile/load/run arguments
VCOM_ARGS             += 

# Note: vsim-3009 error can be eliminated by adding -timescale 1ps/1ps to VLOG_ARGS

VLOG_ARGS             += $(UVM_DISABLE_FILE_LINE_CMD) +cover

VELANALYZE_ARGS       +=
VELANALYZE_HVL_ARGS   +=

BATCH_VOPT_ARGS       +=
DEBUG_VOPT_ARGS       +=
EXTRA_VOPT_TOPS       += 
COMMON_VSIM_ARGS      +=  
COMMON_VSIM_ARGS      += -coverage
COMMON_VSIM_ARGS      +=  


BATCH_VSIM_ARGS       += -do "set NoQuitOnFinish 1; run -all; coverage attribute -name TESTNAME -value $(TEST_NAME).$(TEST_SEED); coverage save $(TEST_NAME).$(TEST_SEED).ucdb; quit -f"
DEBUG_VSIM_ARGS       += 
EXTRA_VSIM_TOPS       += 

# pragma uvmf custom additional_args begin
# pragma uvmf custom additional_args end


# Project bench package source
lc3_PARAMETERS_PKG ?=\
$(UVMF_PROJECT_DIR)/tb/parameters/lc3_parameters_pkg.sv


lc3_SEQUENCES_PKG ?=\
$(UVMF_PROJECT_DIR)/tb/sequences/lc3_sequences_pkg.sv


lc3_TEST_PKG ?=\
$(UVMF_PROJECT_DIR)/tb/tests/lc3_tests_pkg.sv

# pragma uvmf custom dut_files begin
# UVMF_CHANGE_ME : Reference Verilog DUT source.
lc3_VERILOG_DUT ?=\
$(UVMF_PROJECT_DIR)/rtl/verilog/*.v

# UVMF_CHANGE_ME : Reference VHDL DUT source.
lc3_VHDL_DUT ?=\
$(UVMF_PROJECT_DIR)/rtl/vhdl/vhdl_dut.vhd
# pragma uvmf custom dut_files end


# Project bench package targets
COMP_lc3_PARAMETERS_PKG_TGT_0 = q_comp_lc3_parameters_pkg
COMP_lc3_PARAMETERS_PKG_TGT_1 = v_comp_lc3_parameters_pkg
COMP_lc3_PARAMETERS_PKG_TGT = $(COMP_lc3_PARAMETERS_PKG_TGT_$(USE_VELOCE))

comp_lc3_parameters_pkg: $(COMP_lc3_PARAMETERS_PKG_TGT)

q_comp_lc3_parameters_pkg:
	        $(HVL_COMP_CMD) +incdir+$(UVMF_PROJECT_DIR)/tb/parameters $(lc3_PARAMETERS_PKG)

v_comp_lc3_parameters_pkg: q_comp_lc3_parameters_pkg
	$(HDL_COMP_CMD) +incdir+$(UVMF_PROJECT_DIR)/tb/parameters $(lc3_PARAMETERS_PKG)
 

comp_lc3_sequence_pkg:
	$(HVL_COMP_CMD) +incdir+$(UVMF_PROJECT_DIR)/tb/sequences $(lc3_SEQUENCES_PKG)

comp_lc3_tests_pkg:
	$(HVL_COMP_CMD) +incdir+$(UVMF_PROJECT_DIR)/tb/tests $(lc3_TEST_PKG)

# pragma uvmf custom dut_compile_make_target begin
comp_lc3_prediction_pkg:
	vlog -sv +incdir+../../../verification_ip/environment_packages/lc3_prediction_pkg \
	../../../verification_ip/environment_packages/lc3_prediction_pkg/lc3_prediction_pkg.sv

# UVMF_CHANGE_ME : Add make target to compile your verilog dut here
comp_lc3_verilog_dut: 
	echo "Compile your verilog DUT here"
	$(HDL_COMP_CMD) $(lc3_VERILOG_DUT)

# UVMF_CHANGE_ME : Add make target to compile your vhdl dut here
comp_lc3_vhdl_dut: 
	echo "Compile your vhdl DUT here"
	$(HDL_COMP_CMD_VHDL) $(lc3_VHDL_DUT)

# UVMF_CHANGE_ME : Add make target to compile your dut here
comp_lc3_dut: comp_lc3_vhdl_dut comp_lc3_verilog_dut 
# pragma uvmf custom dut_compile_make_target end


comp_icvip_sim:
ifeq ($(USE_VTL), 1)
else

endif

comp_icvip_emu:


BUILD_TGT_0 = make_build
BUILD_TGT_1 = vinfo_build
BUILD_TGT = $(BUILD_TGT_$(USE_VINFO))


comp_hvl : comp_hvl_core


comp_hvl_core :   \
	 comp_fetch_in_pkg  comp_fetch_out_pkg  comp_decode_in_pkg  comp_decode_out_pkg  comp_writeback_in_pkg  comp_writeback_out_pkg  comp_memaccess_in_pkg  comp_memaccess_out_pkg  comp_control_in_pkg  comp_control_out_pkg  comp_execute_in_pkg  comp_execute_out_pkg  comp_inst_mem_pkg  comp_data_mem_pkg  \
	comp_lc3_prediction_pkg comp_lc3_env_pkg \
	comp_lc3_parameters_pkg comp_lc3_sequence_pkg comp_lc3_tests_pkg 

comp_uvmf_core : comp_uvm_pkg comp_uvmf_base_pkg 

make_build: comp_lc3_dut comp_uvmf_core comp_hvl comp_test_bench  

hvl_build:  q_comp_fetch_in_pkg  q_comp_fetch_out_pkg  q_comp_decode_in_pkg  q_comp_decode_out_pkg  q_comp_writeback_in_pkg  q_comp_writeback_out_pkg  q_comp_memaccess_in_pkg  q_comp_memaccess_out_pkg  q_comp_control_in_pkg  q_comp_control_out_pkg  q_comp_execute_in_pkg  q_comp_execute_out_pkg  q_comp_inst_mem_pkg  q_comp_data_mem_pkg  comp_lc3_env_pkg comp_lc3_sequence_pkg comp_lc3_tests_pkg hvl_comp_testbench link optimize


vinfo_build: comp_lc3_vhdl_dut  build_hdl_vinfo build_hvl_vinfo $(VINFO_TGT)

	$(HDL_COMP_CMD) -F hdl.vf
	$(VEL_COMP)

build: $(BUILD_TGT)

emu_build: libs build link optimize

bcr: 
	ml questa && \
	make clean && \
	$(PYTHON) $(UVMF_HOME)/scripts/uvmf_bcr.py questa \
  	test:test_load \
  	live:True use_vis_uvm:True enable_trlog:True
# pragma uvmf custom additional_targets begin
convert_testplan:
	xml2ucdb -format Excel ./lc3_test_plan.xml ./test_plan.ucdb

merge_test_coverage:
	vcover merge -stats=none -strip 0 -totals merged_tests.ucdb ./*.ucdb
	vcover merge -stats=none -strip 0 -totals regress.ucdb ./merged_tests.ucdb ./test_plan.ucdb

merge_all_coverage:
	vcover merge -stats=none -strip 0 -totals merged_tests.ucdb $(shell ls *.ucdb 2>/dev/null | grep -v test_plan.ucdb | grep -v merged_tests.ucdb | grep -v regress.ucdb)
	vcover merge -stats=none -strip 0 -totals regress.ucdb ./merged_tests.ucdb ./test_plan.ucdb

report_coverage:
	vcover report -details -html -output covhtmlreport -assert -directive -cvg -code bcefst -threshL 50 -threshH 90 ./regress.ucdb

view_coverage:
	visualizer -viewcov ./regress.ucdb

visualize:
	qrun -64 -gui -visualizer \
	     -onfinish stop -classdebug -uvmcontrol=all -msgmode both \
	     -l run.log \
	     -do "compile.do; run.do" \
	     -debug,livesim \
	     -qwavedb=+signal+memory=1024+report+parameter+class+assertion+uvm_schematic+msg+classmemory=1024+statictaskfunc
# pragma uvmf custom additional_targets end
