//----------------------------------------------------------------------
// alu_directed_test.svh
//
// ALU Directed Test for LC-3 Execute Stage Verification
// This test uses the alu_directed_test_sequence to send directed
// ALU instructions (ADD, AND, NOT) for sanity testing.
//----------------------------------------------------------------------

class alu_directed_test extends test_top;

  `uvm_component_utils(alu_directed_test)

  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    // Override the base sequence with our ALU directed test sequence
    lc3_bench_sequence_base::type_id::set_type_override(alu_directed_test_sequence::get_type());

    // Execute the build_phase of test_top AFTER all factory overrides have been created
    super.build_phase(phase);

    `uvm_info("ALU_DIR_TEST", "ALU Directed Test - build_phase complete", UVM_MEDIUM)
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("ALU_DIR_TEST", "ALU Directed Test - Running directed ALU sanity checks", UVM_LOW)
    `uvm_info("ALU_DIR_TEST", "Instructions: ADD reg-reg, ADD reg-imm, AND reg-reg, AND reg-imm, NOT", UVM_LOW)
  endfunction

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("ALU_DIR_TEST", "ALU Directed Test Complete", UVM_LOW)
  endfunction

endclass