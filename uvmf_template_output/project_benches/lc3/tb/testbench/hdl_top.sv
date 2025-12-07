//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------                     
//               
// Description: This top level module instantiates all synthesizable
//    static content.  This and tb_top.sv are the two top level modules
//    of the simulation.  
//
//    This module instantiates the following:
//        DUT: The Design Under Test
//        Interfaces:  Signal bundles that contain signals connected to DUT
//        Driver BFM's: BFM's that actively drive interface signals
//        Monitor BFM's: BFM's that passively monitor interface signals
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//

module hdl_top;

import lc3_parameters_pkg::*;
import uvmf_base_pkg_hdl::*;

  // pragma attribute hdl_top partition_module_xrtl                                            
// pragma uvmf custom clock_generator begin
  bit clk;
  // Instantiate a clk driver 
  // tbx clkgen
  initial begin
    clk = 0;
    #5ns;
    forever begin
      clk = ~clk;
      #5ns;
    end
  end
// pragma uvmf custom clock_generator end

// pragma uvmf custom reset_generator begin
  bit rst;
  // Instantiate a rst driver
  // tbx clkgen
  initial begin
    rst = 1; 
    #100ns;
    rst =  0; 
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.
  fetch_in_if  fetch_env_fetch_in_agent_bus(
     // pragma uvmf custom fetch_env_fetch_in_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom fetch_env_fetch_in_agent_bus_connections end
     );
  fetch_out_if  fetch_env_fetch_out_agent_bus(
     // pragma uvmf custom fetch_env_fetch_out_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom fetch_env_fetch_out_agent_bus_connections end
     );
  decode_in_if  decode_env_decode_in_agent_bus(
     // pragma uvmf custom decode_env_decode_in_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom decode_env_decode_in_agent_bus_connections end
     );
  decode_out_if  decode_env_decode_out_agent_bus(
     // pragma uvmf custom decode_env_decode_out_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom decode_env_decode_out_agent_bus_connections end
     );
  writeback_in_if  writeback_env_writeback_in_agent_bus(
     // pragma uvmf custom writeback_env_writeback_in_agent_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom writeback_env_writeback_in_agent_bus_connections end
     );
  writeback_out_if  writeback_env_writeback_out_agent_bus(
     // pragma uvmf custom writeback_env_writeback_out_agent_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom writeback_env_writeback_out_agent_bus_connections end
     );
  memaccess_in_if  memaccess_env_memaccess_in_agent_bus(
     // pragma uvmf custom memaccess_env_memaccess_in_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom memaccess_env_memaccess_in_agent_bus_connections end
     );
  memaccess_out_if  memaccess_env_memaccess_out_agent_bus(
     // pragma uvmf custom memaccess_env_memaccess_out_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom memaccess_env_memaccess_out_agent_bus_connections end
     );
  control_in_if  control_env_control_in_agent_bus(
     // pragma uvmf custom control_env_control_in_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom control_env_control_in_agent_bus_connections end
     );
  control_out_if  control_env_control_out_agent_bus(
     // pragma uvmf custom control_env_control_out_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom control_env_control_out_agent_bus_connections end
     );
  execute_in_if  execute_env_execute_in_agent_bus(
     // pragma uvmf custom execute_env_execute_in_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom execute_env_execute_in_agent_bus_connections end
     );
  execute_out_if  execute_env_execute_out_agent_bus(
     // pragma uvmf custom execute_env_execute_out_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom execute_env_execute_out_agent_bus_connections end
     );
  inst_mem_if  inst_mem_agent_bus(
     // pragma uvmf custom inst_mem_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom inst_mem_agent_bus_connections end
     );
  data_mem_if  data_mem_agent_bus(
     // pragma uvmf custom data_mem_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom data_mem_agent_bus_connections end
     );
  fetch_in_monitor_bfm  fetch_env_fetch_in_agent_mon_bfm(fetch_env_fetch_in_agent_bus);
  fetch_out_monitor_bfm  fetch_env_fetch_out_agent_mon_bfm(fetch_env_fetch_out_agent_bus);
  decode_in_monitor_bfm  decode_env_decode_in_agent_mon_bfm(decode_env_decode_in_agent_bus);
  decode_out_monitor_bfm  decode_env_decode_out_agent_mon_bfm(decode_env_decode_out_agent_bus);
  writeback_in_monitor_bfm  writeback_env_writeback_in_agent_mon_bfm(writeback_env_writeback_in_agent_bus);
  writeback_out_monitor_bfm  writeback_env_writeback_out_agent_mon_bfm(writeback_env_writeback_out_agent_bus);
  memaccess_in_monitor_bfm  memaccess_env_memaccess_in_agent_mon_bfm(memaccess_env_memaccess_in_agent_bus);
  memaccess_out_monitor_bfm  memaccess_env_memaccess_out_agent_mon_bfm(memaccess_env_memaccess_out_agent_bus);
  control_in_monitor_bfm  control_env_control_in_agent_mon_bfm(control_env_control_in_agent_bus);
  control_out_monitor_bfm  control_env_control_out_agent_mon_bfm(control_env_control_out_agent_bus);
  execute_in_monitor_bfm  execute_env_execute_in_agent_mon_bfm(execute_env_execute_in_agent_bus);
  execute_out_monitor_bfm  execute_env_execute_out_agent_mon_bfm(execute_env_execute_out_agent_bus);
  inst_mem_monitor_bfm  inst_mem_agent_mon_bfm(inst_mem_agent_bus);
  data_mem_monitor_bfm  data_mem_agent_mon_bfm(data_mem_agent_bus);
  inst_mem_driver_bfm  inst_mem_agent_drv_bfm(inst_mem_agent_bus);
  data_mem_driver_bfm  data_mem_agent_drv_bfm(data_mem_agent_bus);

  // pragma uvmf custom dut_instantiation begin
  // UVMF_CHANGE_ME : Add DUT and connect to signals in _bus interfaces listed above
  // Instantiate your DUT here
  // These DUT's instantiated to show verilog and vhdl instantiation
 
// These DUT's instantiated to show verilog and vhdl instantiation
LC3         dut_verilog( .clock(clk), .reset(rst), .pc(inst_mem_agent_bus.PC), .instrmem_rd(inst_mem_agent_bus.instrmem_rd), .Instr_dout(inst_mem_agent_bus.instr_dout), .Data_addr(data_mem_agent_bus.Data_addr), .complete_instr(inst_mem_agent_bus.complete_instr), .complete_data(data_mem_agent_bus.complete_data), .Data_din(data_mem_agent_bus.Data_din), .Data_dout(data_mem_agent_bus.Data_dout), .Data_rd(data_mem_agent_bus.Data_rd));  
//vhdl_dut            dut_vhdl   (   .clk(clk), .rst(rst), .in_signal(verilog_to_vhdl_signal), .out_signal(vhdl_to_verilog_signal));
// Decode Block Connections
  assign decode_env_decode_in_agent_bus.enable_decode = dut_verilog.enable_decode;
  assign decode_env_decode_in_agent_bus.dout = dut_verilog.Instr_dout;
  assign decode_env_decode_in_agent_bus.npc_in = dut_verilog.npc_out_fetch;
  //assign decode_env_decode_in_agent_bus.psr = dut_verilog.psr;  // NOTE: commented out signal in TopLevelLC3.v
  assign decode_env_decode_out_agent_bus.Mem_Control = dut_verilog.Mem_Control;
  assign decode_env_decode_out_agent_bus.E_Control = dut_verilog.E_Control;
  assign decode_env_decode_out_agent_bus.W_Control = dut_verilog.W_Control;
  assign decode_env_decode_out_agent_bus.IR = dut_verilog.IR;
  assign decode_env_decode_out_agent_bus.npc_out = dut_verilog.npc_out_dec;

//Control Connections
  assign control_env_control_in_agent_bus.complete_data = dut_verilog.complete_data;
  assign control_env_control_in_agent_bus.complete_instr = dut_verilog.complete_instr;
  assign control_env_control_in_agent_bus.IR = dut_verilog.IR;
  assign control_env_control_in_agent_bus.psr = dut_verilog.psr;
  assign control_env_control_in_agent_bus.IR_Exec = dut_verilog.IR_Exec;
  assign control_env_control_in_agent_bus.IMem_dout = dut_verilog.Instr_dout;
  assign control_env_control_in_agent_bus.NZP = dut_verilog.NZP;
  assign control_env_control_out_agent_bus.enable_updatePC = dut_verilog.enable_updatePC;
  assign control_env_control_out_agent_bus.enable_fetch = dut_verilog.enable_fetch;
  assign control_env_control_out_agent_bus.enable_decode = dut_verilog.enable_decode;
  assign control_env_control_out_agent_bus.enable_execute = dut_verilog.enable_execute;
  assign control_env_control_out_agent_bus.enable_writeback = dut_verilog.enable_writeback;
  assign control_env_control_out_agent_bus.bypass_alu_1 = dut_verilog.bypass_alu_1;
  assign control_env_control_out_agent_bus.bypass_alu_2 = dut_verilog.bypass_alu_2;
  assign control_env_control_out_agent_bus.bypass_mem_1 = dut_verilog.bypass_mem_1;
  assign control_env_control_out_agent_bus.bypass_mem_2 = dut_verilog.bypass_mem_2;
  assign control_env_control_out_agent_bus.mem_state = dut_verilog.mem_state;
  assign control_env_control_out_agent_bus.br_taken = dut_verilog.br_taken;

//Mem access Connections
  assign memaccess_env_memaccess_in_agent_bus.mem_state = dut_verilog.mem_state;
  assign memaccess_env_memaccess_in_agent_bus.M_Control = dut_verilog.Mem_Control_out;
  assign memaccess_env_memaccess_in_agent_bus.M_Data = dut_verilog.M_Data;
  assign memaccess_env_memaccess_in_agent_bus.M_Addr = dut_verilog.pcout;
  assign memaccess_env_memaccess_in_agent_bus.DMem_dout = dut_verilog.Data_dout;
  assign memaccess_env_memaccess_out_agent_bus.DMem_addr = dut_verilog.Data_addr;
  assign memaccess_env_memaccess_out_agent_bus.DMem_din = dut_verilog.Data_din;
  assign memaccess_env_memaccess_out_agent_bus.DMem_rd = dut_verilog.Data_rd;
  assign memaccess_env_memaccess_out_agent_bus.memout = dut_verilog.memout;
  //Execute Connections
  assign execute_env_execute_in_agent_bus.E_Control = dut_verilog.E_Control;
  assign execute_env_execute_in_agent_bus.IR = dut_verilog.IR;
  assign execute_env_execute_in_agent_bus.npc_in = dut_verilog.npc_out_dec;
  assign execute_env_execute_in_agent_bus.bypass_alu_1 = dut_verilog.bypass_alu_1;
  assign execute_env_execute_in_agent_bus.bypass_alu_2 = dut_verilog.bypass_alu_2;
  assign execute_env_execute_in_agent_bus.bypass_mem_1 = dut_verilog.bypass_mem_1;
  assign execute_env_execute_in_agent_bus.bypass_mem_2 = dut_verilog.bypass_mem_2;
  assign execute_env_execute_in_agent_bus.VSR1 = dut_verilog.VSR1;
  assign execute_env_execute_in_agent_bus.VSR2 = dut_verilog.VSR2;
  assign execute_env_execute_in_agent_bus.W_Control_in = dut_verilog.W_Control;
  assign execute_env_execute_in_agent_bus.Mem_Control_in = dut_verilog.Mem_Control;
  assign execute_env_execute_in_agent_bus.enable_execute = dut_verilog.enable_execute;
  assign execute_env_execute_in_agent_bus.Mem_Bypass_Val = dut_verilog.memout;
  assign execute_env_execute_out_agent_bus.W_Control_out = dut_verilog.W_Control_out;
  assign execute_env_execute_out_agent_bus.Mem_Control_out = dut_verilog.Mem_Control_out;
  assign execute_env_execute_out_agent_bus.aluout = dut_verilog.aluout;
  assign execute_env_execute_out_agent_bus.pcout = dut_verilog.pcout;
  assign execute_env_execute_out_agent_bus.dr = dut_verilog.dr;
  assign execute_env_execute_out_agent_bus.sr1 = dut_verilog.sr1;
  assign execute_env_execute_out_agent_bus.sr2 = dut_verilog.sr2;
  assign execute_env_execute_out_agent_bus.IR_Exec = dut_verilog.IR_Exec;
  assign execute_env_execute_out_agent_bus.NZP = dut_verilog.NZP;
  assign execute_env_execute_out_agent_bus.M_Data = dut_verilog.M_Data;
  assign execute_env_execute_out_agent_bus.enable_execute_out = dut_verilog.enable_execute;

//Fetch Connections
  assign fetch_env_fetch_in_agent_bus.enable_updatePC = dut_verilog.enable_updatePC;
  assign fetch_env_fetch_in_agent_bus.enable_fetch = dut_verilog.enable_fetch;
  assign fetch_env_fetch_in_agent_bus.taddr = dut_verilog.pcout;
  assign fetch_env_fetch_in_agent_bus.br_taken = dut_verilog.br_taken;
  assign fetch_env_fetch_out_agent_bus.npc = dut_verilog.npc_out_fetch;
  assign fetch_env_fetch_out_agent_bus.pc = dut_verilog.pc;
  assign fetch_env_fetch_out_agent_bus.instrmem_rd = dut_verilog.instrmem_rd;
  
  // Writeback Input Connections
assign writeback_env_writeback_in_agent_bus.enable_writeback 
       = dut_verilog.enable_writeback;

assign writeback_env_writeback_in_agent_bus.w_control_in     
       = dut_verilog.W_Control_out;

assign writeback_env_writeback_in_agent_bus.aluout           
       = dut_verilog.aluout;

assign writeback_env_writeback_in_agent_bus.memout           
       = dut_verilog.memout;

assign writeback_env_writeback_in_agent_bus.pcout            
       = dut_verilog.pcout;

assign writeback_env_writeback_in_agent_bus.npc              
       = dut_verilog.npc_out_dec;

assign writeback_env_writeback_in_agent_bus.sr1              
       = dut_verilog.sr1;

assign writeback_env_writeback_in_agent_bus.sr2              
       = dut_verilog.sr2;

assign writeback_env_writeback_in_agent_bus.dr               
       = dut_verilog.dr;


// Writeback Output Connections
assign writeback_env_writeback_out_agent_bus.VSR1 
       = dut_verilog.VSR1;

assign writeback_env_writeback_out_agent_bus.VSR2 
       = dut_verilog.VSR2;

assign writeback_env_writeback_out_agent_bus.psr  
       = dut_verilog.psr;
assign writeback_env_writeback_out_agent_bus.enable_writeback 
       = dut_verilog.enable_writeback;

  initial begin      // tbx vif_binding_block 
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.
    uvm_config_db #( virtual fetch_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fetch_in_agent_BFM , fetch_env_fetch_in_agent_mon_bfm ); 
    uvm_config_db #( virtual fetch_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fetch_out_agent_BFM , fetch_env_fetch_out_agent_mon_bfm ); 
    uvm_config_db #( virtual decode_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_decode_in_agent_BFM , decode_env_decode_in_agent_mon_bfm ); 
    uvm_config_db #( virtual decode_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_decode_out_agent_BFM , decode_env_decode_out_agent_mon_bfm ); 
    uvm_config_db #( virtual writeback_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_writeback_in_agent_BFM , writeback_env_writeback_in_agent_mon_bfm ); 
    uvm_config_db #( virtual writeback_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_writeback_out_agent_BFM , writeback_env_writeback_out_agent_mon_bfm ); 
    uvm_config_db #( virtual memaccess_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_memaccess_in_agent_BFM , memaccess_env_memaccess_in_agent_mon_bfm ); 
    uvm_config_db #( virtual memaccess_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_memaccess_out_agent_BFM , memaccess_env_memaccess_out_agent_mon_bfm ); 
    uvm_config_db #( virtual control_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , control_env_control_in_agent_BFM , control_env_control_in_agent_mon_bfm ); 
    uvm_config_db #( virtual control_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , control_env_control_out_agent_BFM , control_env_control_out_agent_mon_bfm ); 
    uvm_config_db #( virtual execute_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_in_agent_BFM , execute_env_execute_in_agent_mon_bfm ); 
    uvm_config_db #( virtual execute_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_out_agent_BFM , execute_env_execute_out_agent_mon_bfm ); 
    uvm_config_db #( virtual inst_mem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , inst_mem_agent_BFM , inst_mem_agent_mon_bfm ); 
    uvm_config_db #( virtual data_mem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , data_mem_agent_BFM , data_mem_agent_mon_bfm ); 
    uvm_config_db #( virtual inst_mem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , inst_mem_agent_BFM , inst_mem_agent_drv_bfm  );
    uvm_config_db #( virtual data_mem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , data_mem_agent_BFM , data_mem_agent_drv_bfm  );
  end

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end