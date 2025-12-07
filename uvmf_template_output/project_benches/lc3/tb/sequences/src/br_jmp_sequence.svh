class br_jmp_sequence extends lc3_bench_sequence_base;
    `uvm_object_utils(br_jmp_sequence);

    function new( string name = "");
        super.new();
    endfunction

    virtual task body();
        inst_mem_agent_responder_seq = inst_mem_br_jmp_seq::type_id::create("inst_mem_br_jmp_seq");
        data_mem_agent_responder_seq = data_mem_agent_responder_seq_t::type_id::create("data_mem_resp_seq");

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

        `uvm_info("BR_JMP_SEQ", "OUT_OF_RESET::Starting LC3 BR JMP Sequencs", UVM_NONE)
        // Start RESPONDER sequences here

        fork
            inst_mem_agent_responder_seq.start(inst_mem_agent_sequencer);
            data_mem_agent_responder_seq.start(data_mem_agent_sequencer);
        join_none

        execute_env_execute_in_agent_config.wait_for_num_clocks(14400);
    endtask


endclass