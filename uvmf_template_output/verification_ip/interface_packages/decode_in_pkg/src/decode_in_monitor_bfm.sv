//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the decode_in signal monitoring.
//      It is accessed by the uvm decode_in monitor through a virtual
//      interface handle in the decode_in configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type decode_in_if.
//
//     Input signals from the decode_in_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//      Interface functions and tasks used by UVM components:
//             monitor(inout TRANS_T txn);
//                   This task receives the transaction, txn, from the
//                   UVM monitor and then populates variables in txn
//                   from values observed on bus activity.  This task
//                   blocks until an operation on the decode_in bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import decode_in_pkg_hdl::*;
`include "src/decode_in_macros.svh"


interface decode_in_monitor_bfm 
  ( decode_in_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute decode_in_monitor_bfm partition_interface_xif                                  

`ifndef XRTL
// This code is to aid in debugging parameter mismatches between the BFM and its corresponding agent.
// Enable this debug by setting UVM_VERBOSITY to UVM_DEBUG
// Setting UVM_VERBOSITY to UVM_DEBUG causes all BFM's and all agents to display their parameter settings.
// All of the messages from this feature have a UVM messaging id value of "CFG"
// The transcript or run.log can be parsed to ensure BFM parameter settings match its corresponding agents parameter settings.
import uvm_pkg::*;
`include "uvm_macros.svh"
initial begin : bfm_vs_agent_parameter_debug
  `uvm_info("CFG", 
      $psprintf("The BFM at '%m' has the following parameters: ", ),
      UVM_DEBUG)
end
`endif


  // Structure used to pass transaction data from monitor BFM to monitor class in agent.
`decode_in_MONITOR_STRUCT
  decode_in_monitor_s decode_in_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `decode_in_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;
  tri  enable_decode_i;
  tri [15:0] dout_i;
  tri [15:0] npc_in_i;
  tri [2:0] psr_i;
  assign clock_i = bus.clock;
  assign reset_i = bus.reset;
  assign enable_decode_i = bus.enable_decode;
  assign dout_i = bus.dout;
  assign npc_in_i = bus.npc_in;
  assign psr_i = bus.psr;

  // Proxy handle to UVM monitor
  decode_in_pkg::decode_in_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end
  
  //******************************************************************                         
  task wait_for_reset();// pragma tbx xtf  
    @(posedge clock_i) ;                                                                    
    do_wait_for_reset();                                                                   
  endtask                                                                                   

  // ****************************************************************************              
  task do_wait_for_reset(); 
  // pragma uvmf custom reset_condition begin
    wait ( reset_i === 0 ) ;                                                              
    @(posedge clock_i) ;                                                                    
  // pragma uvmf custom reset_condition end                                                                
  endtask    

  //******************************************************************                         
 
  task wait_for_num_clocks(input int unsigned count); // pragma tbx xtf 
    @(posedge clock_i);  
                                                                   
    repeat (count-1) @(posedge clock_i);                                                    
  endtask      

  //******************************************************************                         
  event go;                                                                                 
  function void start_monitoring();// pragma tbx xtf    
    -> go;
  endfunction                                                                               
  
  // ****************************************************************************              
  initial begin                                                                             
    @go;                                                                                   
    forever begin                                                                        
      @(posedge clock_i);
      //if (enable_decode_i == 1) begin  
        do_monitor( decode_in_monitor_struct );                                                                
        proxy.notify_transaction( decode_in_monitor_struct );
      //end
 
    end                                                                                    
  end                                                                                       

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the monitor BFM.  It is called by the monitor within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the monitor BFM needs to be aware of the new configuration 
  // variables.
  //
    function void configure(decode_in_configuration_s decode_in_configuration_arg); // pragma tbx xtf  
    initiator_responder = decode_in_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output decode_in_monitor_s decode_in_monitor_struct);
    // pragma uvmf custom do_monitor begin
    while(reset_i) @(posedge clock_i);
    if (enable_decode_i == 1) 
    begin
      // Capture the raw instruction and NPC
      decode_in_monitor_struct.instruction = dout_i;
      decode_in_monitor_struct.npc_in = npc_in_i;
      
      // Decode the instruction into individual fields
      decode_in_monitor_struct.opcode = dout_i[15:12];  // Bits [15:12] = opcode

      // Capture PSR fields
      decode_in_monitor_struct.n = psr_i[2];
      decode_in_monitor_struct.z = psr_i[1];
      decode_in_monitor_struct.p = psr_i[0];
      
      // Decode based on opcode
      case (dout_i[15:12])
        4'b0001, 4'b0101: begin  // ADD, AND
          decode_in_monitor_struct.dr = dout_i[11:9];
          decode_in_monitor_struct.sr1 = dout_i[8:6];
          decode_in_monitor_struct.mode = dout_i[5];
          if (dout_i[5] == 1'b0) begin  // Register mode
            decode_in_monitor_struct.sr2 = dout_i[2:0];
            decode_in_monitor_struct.imm5 = 5'b0;
          end else begin  // Immediate mode
            decode_in_monitor_struct.imm5 = dout_i[4:0];
            decode_in_monitor_struct.sr2 = 3'b0;
          end
        end
        
        4'b1001: begin  // NOT
          decode_in_monitor_struct.dr = dout_i[11:9];
          decode_in_monitor_struct.sr1 = dout_i[8:6];
        end
        
        4'b0010, 4'b1010, 4'b1110: begin  // LD, LDI, LEA
          decode_in_monitor_struct.dr = dout_i[11:9];
          decode_in_monitor_struct.pcoffset9 = dout_i[8:0];
        end
        
       4'b0110: begin  // LDR
      decode_in_monitor_struct.dr        = dout_i[11:9];
      decode_in_monitor_struct.baser     = dout_i[8:6];
      decode_in_monitor_struct.pcoffset6 = dout_i[5:0];
       end

       4'b0111: begin  // STR
         decode_in_monitor_struct.sr1       = dout_i[11:9]; // source register
        decode_in_monitor_struct.baser     = dout_i[8:6];
        decode_in_monitor_struct.pcoffset6 = dout_i[5:0];
         end
        
        4'b0011, 4'b1011: begin  // ST, STI
          decode_in_monitor_struct.sr1 = dout_i[11:9];
          decode_in_monitor_struct.pcoffset9 = dout_i[8:0];
        end
        
        4'b0000: begin  // BR
          decode_in_monitor_struct.n = dout_i[11];
          decode_in_monitor_struct.z = dout_i[10];
          decode_in_monitor_struct.p = dout_i[9];
          decode_in_monitor_struct.pcoffset9 = dout_i[8:0];
        end
        
        4'b1100: begin  // JMP/RET
          decode_in_monitor_struct.baser = dout_i[8:6];
        end
        
        default: begin
          // Handle other opcodes if needed
        end
      endcase
      
      
    end
    #1;
    // pragma uvmf custom do_monitor end
  endtask         
  
 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

