//----------------------------------------------------------------------
// alu_directed_test_sequence.svh
//
// ALU Directed Test Sequence for LC-3 Execute Stage Verification
// This sequence uses the inst_mem_alu_directed_sanity_seq to send
// directed ALU instructions (ADD, AND, NOT) for exhaustive testing.
//
// Total: 5192 instructions requiring ~5500 clock cycles
//----------------------------------------------------------------------

class alu_directed_test_sequence extends lc3_bench_sequence_base;

  `uvm_object_utils(alu_directed_test_sequence)

  // ALU directed sanity sequence for instruction memory
  typedef inst_mem_alu_directed_sanity_seq inst_mem_alu_directed_seq_t;
  inst_mem_alu_directed_seq_t inst_mem_alu_directed_seq;

  // Number of clock cycles to run (5192 instructions + pipeline drain + margin)
  int unsigned num_clocks = 5192;

  function new(string name = "alu_directed_test_sequence");
    super.new(name);
  endfunction

  virtual task body();

    `uvm_info("ALU_DIR_SEQ", "Starting EXHAUSTIVE ALU Directed Test Sequence", UVM_LOW)
    `uvm_info("ALU_DIR_SEQ", $sformatf("Running for %0d clock cycles to cover 5192 instructions", num_clocks), UVM_LOW)

    // Construct the ALU directed sequence
    inst_mem_alu_directed_seq = inst_mem_alu_directed_seq_t::type_id::create("inst_mem_alu_directed_seq");
    data_mem_agent_responder_seq = data_mem_agent_responder_seq_t::type_id::create("data_mem_agent_responder_seq");

    // Wait for reset to complete on all interfaces
    fork
      fetch_env_fetch_in_agent_config.wait_for_reset();
      fetch_env_fetch_out_agent_config.wait_for_reset();
      decode_env_decode_in_agent_config.wait_for_reset();
      decode_env_decode_out_agent_config.wait_for_reset();
      writeback_env_writeback_in_agent_config.wait_for_reset();
      writeback_env_writeback_out_agent_config.wait_for_reset();
      memaccess_env_memaccess_in_agent_config.wait_for_reset();
      memaccess_env_memaccess_out_agent_config.wait_for_reset();
      control_env_control_in_agent_config.wait_for_reset();
      control_env_control_out_agent_config.wait_for_reset();
      execute_env_execute_in_agent_config.wait_for_reset();
      execute_env_execute_out_agent_config.wait_for_reset();
      inst_mem_agent_config.wait_for_reset();
      data_mem_agent_config.wait_for_reset();
    join

    `uvm_info("ALU_DIR_SEQ", "Reset complete - Starting exhaustive ALU instruction stream", UVM_LOW)

    // Start responder sequences
    fork
      // ALU directed sequence on instruction memory
      inst_mem_alu_directed_seq.start(inst_mem_agent_sequencer);
      // Data memory responder (needed for any load/store side effects)
      data_mem_agent_responder_seq.start(data_mem_agent_sequencer);
    join_none

    // Wait for all 5192 instructions plus pipeline drain
    fork
      fetch_env_fetch_in_agent_config.wait_for_num_clocks(num_clocks);
      fetch_env_fetch_out_agent_config.wait_for_num_clocks(num_clocks);
      decode_env_decode_in_agent_config.wait_for_num_clocks(num_clocks);
      decode_env_decode_out_agent_config.wait_for_num_clocks(num_clocks);
      writeback_env_writeback_in_agent_config.wait_for_num_clocks(num_clocks);
      writeback_env_writeback_out_agent_config.wait_for_num_clocks(num_clocks);
      memaccess_env_memaccess_in_agent_config.wait_for_num_clocks(num_clocks);
      memaccess_env_memaccess_out_agent_config.wait_for_num_clocks(num_clocks);
      control_env_control_in_agent_config.wait_for_num_clocks(num_clocks);
      control_env_control_out_agent_config.wait_for_num_clocks(num_clocks);
      execute_env_execute_in_agent_config.wait_for_num_clocks(num_clocks);
      execute_env_execute_out_agent_config.wait_for_num_clocks(num_clocks);
      inst_mem_agent_config.wait_for_num_clocks(num_clocks);
      data_mem_agent_config.wait_for_num_clocks(num_clocks);
    join

    `uvm_info("ALU_DIR_SEQ", "EXHAUSTIVE ALU Directed Test Sequence Complete", UVM_LOW)

  endtask

endclass