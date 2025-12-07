 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { fetch_env_fetch_in_agent }
wave add uvm_test_top.environment.fetch_env.fetch_in_agent.fetch_in_agent_monitor.txn_stream -radix string -tag F0
wave group fetch_env_fetch_in_agent_bus
wave add -group fetch_env_fetch_in_agent_bus hdl_top.fetch_env_fetch_in_agent_bus.* -radix hexadecimal -tag F0
wave group fetch_env_fetch_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { fetch_env_fetch_out_agent }
wave add uvm_test_top.environment.fetch_env.fetch_out_agent.fetch_out_agent_monitor.txn_stream -radix string -tag F0
wave group fetch_env_fetch_out_agent_bus
wave add -group fetch_env_fetch_out_agent_bus hdl_top.fetch_env_fetch_out_agent_bus.* -radix hexadecimal -tag F0
wave group fetch_env_fetch_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_env_decode_in_agent }
wave add uvm_test_top.environment.decode_env.decode_in_agent.decode_in_agent_monitor.txn_stream -radix string -tag F0
wave group decode_env_decode_in_agent_bus
wave add -group decode_env_decode_in_agent_bus hdl_top.decode_env_decode_in_agent_bus.* -radix hexadecimal -tag F0
wave group decode_env_decode_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_env_decode_out_agent }
wave add uvm_test_top.environment.decode_env.decode_out_agent.decode_out_agent_monitor.txn_stream -radix string -tag F0
wave group decode_env_decode_out_agent_bus
wave add -group decode_env_decode_out_agent_bus hdl_top.decode_env_decode_out_agent_bus.* -radix hexadecimal -tag F0
wave group decode_env_decode_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_writeback_in_agent }
wave add uvm_test_top.environment.writeback_env.writeback_in_agent.writeback_in_agent_monitor.txn_stream -radix string -tag F0
wave group writeback_env_writeback_in_agent_bus
wave add -group writeback_env_writeback_in_agent_bus hdl_top.writeback_env_writeback_in_agent_bus.* -radix hexadecimal -tag F0
wave group writeback_env_writeback_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_writeback_out_agent }
wave add uvm_test_top.environment.writeback_env.writeback_out_agent.writeback_out_agent_monitor.txn_stream -radix string -tag F0
wave group writeback_env_writeback_out_agent_bus
wave add -group writeback_env_writeback_out_agent_bus hdl_top.writeback_env_writeback_out_agent_bus.* -radix hexadecimal -tag F0
wave group writeback_env_writeback_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_env_memaccess_in_agent }
wave add uvm_test_top.environment.memaccess_env.memaccess_in_agent.memaccess_in_agent_monitor.txn_stream -radix string -tag F0
wave group memaccess_env_memaccess_in_agent_bus
wave add -group memaccess_env_memaccess_in_agent_bus hdl_top.memaccess_env_memaccess_in_agent_bus.* -radix hexadecimal -tag F0
wave group memaccess_env_memaccess_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_env_memaccess_out_agent }
wave add uvm_test_top.environment.memaccess_env.memaccess_out_agent.memaccess_out_agent_monitor.txn_stream -radix string -tag F0
wave group memaccess_env_memaccess_out_agent_bus
wave add -group memaccess_env_memaccess_out_agent_bus hdl_top.memaccess_env_memaccess_out_agent_bus.* -radix hexadecimal -tag F0
wave group memaccess_env_memaccess_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { control_env_control_in_agent }
wave add uvm_test_top.environment.control_env.control_in_agent.control_in_agent_monitor.txn_stream -radix string -tag F0
wave group control_env_control_in_agent_bus
wave add -group control_env_control_in_agent_bus hdl_top.control_env_control_in_agent_bus.* -radix hexadecimal -tag F0
wave group control_env_control_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { control_env_control_out_agent }
wave add uvm_test_top.environment.control_env.control_out_agent.control_out_agent_monitor.txn_stream -radix string -tag F0
wave group control_env_control_out_agent_bus
wave add -group control_env_control_out_agent_bus hdl_top.control_env_control_out_agent_bus.* -radix hexadecimal -tag F0
wave group control_env_control_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_execute_in_agent }
wave add uvm_test_top.environment.execute_env.execute_in_agent.execute_in_agent_monitor.txn_stream -radix string -tag F0
wave group execute_env_execute_in_agent_bus
wave add -group execute_env_execute_in_agent_bus hdl_top.execute_env_execute_in_agent_bus.* -radix hexadecimal -tag F0
wave group execute_env_execute_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_execute_out_agent }
wave add uvm_test_top.environment.execute_env.execute_out_agent.execute_out_agent_monitor.txn_stream -radix string -tag F0
wave group execute_env_execute_out_agent_bus
wave add -group execute_env_execute_out_agent_bus hdl_top.execute_env_execute_out_agent_bus.* -radix hexadecimal -tag F0
wave group execute_env_execute_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { inst_mem_agent }
wave add uvm_test_top.environment.inst_mem_agent.inst_mem_agent_monitor.txn_stream -radix string -tag F0
wave group inst_mem_agent_bus
wave add -group inst_mem_agent_bus hdl_top.inst_mem_agent_bus.* -radix hexadecimal -tag F0
wave group inst_mem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { data_mem_agent }
wave add uvm_test_top.environment.data_mem_agent.data_mem_agent_monitor.txn_stream -radix string -tag F0
wave group data_mem_agent_bus
wave add -group data_mem_agent_bus hdl_top.data_mem_agent_bus.* -radix hexadecimal -tag F0
wave group data_mem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]



wave update on
WaveSetStreamView

