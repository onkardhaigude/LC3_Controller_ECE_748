//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
//    This interface performs the writeback_in signal driving.  It is
//     accessed by the uvm writeback_in driver through a virtual interface
//     handle in the writeback_in configuration.  It drives the singals passed
//     in through the port connection named bus of type writeback_in_if.
//
//     Input signals from the writeback_in_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//     This bfm drives signals with a _o suffix.  These signals
//     are driven onto signals within writeback_in_if based on INITIATOR/RESPONDER and/or
//     ARBITRATION/GRANT status.  
//
//     The output signal connections are as follows:
//        signal_o -> bus.signal
//
//                                                                                           
//      Interface functions and tasks used by UVM components:                                
//             configure(uvmf_initiator_responder_t mst_slv);                                       
//                   This function gets configuration attributes from the                    
//                   UVM driver to set any required BFM configuration                        
//                   variables such as 'initiator_responder'.                                       
//                                                                                           
//             access(
//       writeback_in_control_t w_control_in ,
//       bit [15:0] pcout ,
//       bit [15:0] memout ,
//       bit [15:0] aluout ,
//       bit [15:0] npc ,
//       bit enable_writeback ,
//       bit dr ,
//       bit sr1 ,
//       bit sr2  );//                   );
//                   This task receives transaction attributes from the                      
//                   UVM driver and then executes the corresponding                          
//                   bus operation on the bus. 
//
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
/*
import uvmf_base_pkg_hdl::*;
import writeback_in_pkg_hdl::*;

interface writeback_in_ibs_driver_bfm 
  (writeback_in_if bus);
  // The following pragma and additional ones in-lined further below are for running this BFM on Veloce
  // pragma attribute writeback_in_driver_bfm partition_interface_xif
  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clk_i;
  tri rst_i;

  // Signal list (all signals are capable of being inputs and outputs for the sake
  // of supporting both INITIATOR and RESPONDER mode operation. Expectation is that 
  // directionality in the config file was from the point-of-view of the INITIATOR

  // INITIATOR mode input signals

  // INITIATOR mode output signals
  tri [15:0] npc_i;
  reg [15:0] npc_o = 'bz;
  tri [15:0] aluout_i;
  reg [15:0] aluout_o = 'bz;
  tri [15:0] pcout_i;
  reg [15:0] pcout_o = 'bz;
  tri [15:0] memout_i;
  reg [15:0] memout_o = 'bz;
  tri [1:0] w_control_in_i;
  reg [1:0] w_control_in_o = 'bz;
  tri  enable_writeback_i;
  reg  enable_writeback_o = 'bz;
  tri [2:0] sr1_i;
  reg [2:0] sr1_o = 'bz;
  tri [2:0] sr2_i;
  reg [2:0] sr2_o = 'bz;
  tri [2:0] dr_i;
  reg [2:0] dr_o = 'bz;

  // Bi-directional signals
  

  assign clk_i = bus.clk;
  assign rst_i = bus.rst;

  // These are signals marked as 'input' by the config file, but the signals will be
  // driven by this BFM if put into RESPONDER mode (flipping all signal directions around)


  // These are signals marked as 'output' by the config file, but the outputs will
  // not be driven by this BFM unless placed in INITIATOR mode.
  assign bus.npc = (initiator_responder == INITIATOR) ? npc_o : 'bz;
  assign npc_i = bus.npc;
  assign bus.aluout = (initiator_responder == INITIATOR) ? aluout_o : 'bz;
  assign aluout_i = bus.aluout;
  assign bus.pcout = (initiator_responder == INITIATOR) ? pcout_o : 'bz;
  assign pcout_i = bus.pcout;
  assign bus.memout = (initiator_responder == INITIATOR) ? memout_o : 'bz;
  assign memout_i = bus.memout;
  assign bus.w_control_in = (initiator_responder == INITIATOR) ? w_control_in_o : 'bz;
  assign w_control_in_i = bus.w_control_in;
  assign bus.enable_writeback = (initiator_responder == INITIATOR) ? enable_writeback_o : 'bz;
  assign enable_writeback_i = bus.enable_writeback;
  assign bus.sr1 = (initiator_responder == INITIATOR) ? sr1_o : 'bz;
  assign sr1_i = bus.sr1;
  assign bus.sr2 = (initiator_responder == INITIATOR) ? sr2_o : 'bz;
  assign sr2_i = bus.sr2;
  assign bus.dr = (initiator_responder == INITIATOR) ? dr_o : 'bz;
  assign dr_i = bus.dr;

  // Proxy handle to UVM driver
  writeback_in_pkg::writeback_in_driver  proxy;
  // pragma tbx oneway proxy.my_function_name_in_uvm_driver                 

  // ****************************************************************************              
  // Always block used to return signals to reset value upon assertion of reset
  always @( posedge rst_i )
     begin
       // RESPONDER mode output signals
       // INITIATOR mode output signals
       npc_o = 'bz;
       aluout_o = 'bz;
       pcout_o = 'bz;
       memout_o = 'bz;
       w_control_in_o = 'bz;
       enable_writeback_o = 'bz;
       sr1_o = 'bz;
       sr2_o = 'bz;
       dr_o = 'bz;
       // Bi-directional signals
 
     end    

//******************************************************************  


  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the driver BFM.  It is called by the driver within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the driver BFM needs to be aware of the new configuration 
  // variables.
  //
  function void configure(
    uvmf_active_passive_t active_passive,
    uvmf_initiator_responder_t init_resp
    
    ); // pragma tbx xtf                   
    initiator_responder = init_resp;
 
  endfunction                                                                               


// ****************************************************************************
  task do_transfer(
     //input writeback_in_control_t w_control_in ,
     input bit [15:0] pcout ,
     input bit [15:0] memout ,
     input bit [15:0] aluout ,
     input bit [15:0] npc ,
     input bit enable_writeback ,
     input bit dr ,
     input bit sr1 ,
     input bit sr2 );                                                  

    // The do_transfer task is called by initiator agents.  The signaling implemented
    // in this task initiates a transfer and, if appropriate, waits for the response
    // from the responder.  Values captured in the transfer can be returned to the 
    // sequence item within the sequence by changing the do_transfer argument direction 
    // of the variable to be returned to the sequence from input to output.  The direction
    // of the same argument must be changed in the access task definition.
    // 
    // UVMF_CHANGE_ME : 
    // 1) Implement protocol signaling.
    //    Transfers are protocol specific and therefore not generated by the templates.
    //    Use the following as examples of transferring data between a sequence and the bus
    //    In the writeback_in_pkg - writeback_in_master_access_sequence.svh, writeback_in_driver_bfm.sv
    // 2) To return the value of a variable from this protocol operation to the sequence, 
    //    change the direction of the variable from input to output in the list of arguments
    //    in the above do_transfer task declaration.  Also change the direction from input 
    //    to output in the declaration of the access task within this BFM.
    // 
    // Reference code;
    //    while (control_signal == 1'b1) @(posedge clk_i);
    //    INITIATOR mode input signals
    //    INITIATOR mode output signals
    //    npc_i;        //   [15:0]  
    //    npc_o <= xyz; //   [15:0]  
    //    aluout_i;        //   [15:0]  
    //    aluout_o <= xyz; //   [15:0]  
    //    pcout_i;        //   [15:0]  
    //    pcout_o <= xyz; //   [15:0]  
    //    memout_i;        //   [15:0]  
    //    memout_o <= xyz; //   [15:0]  
    //    w_control_in_i;        //   [1:0]  
    //    w_control_in_o <= xyz; //   [1:0]  
    //    enable_writeback_i;        //     
    //    enable_writeback_o <= xyz; //     
    //    sr1_i;        //   [2:0]  
    //    sr1_o <= xyz; //   [2:0]  
    //    sr2_i;        //   [2:0]  
    //    sr2_o <= xyz; //   [2:0]  
    //    dr_i;        //   [2:0]  
    //    dr_o <= xyz; //   [2:0]  
    //    Bi-directional signals
 
    @(posedge clk_i);
    @(posedge clk_i);
    @(posedge clk_i);
    @(posedge clk_i);
    @(posedge clk_i);
    $display("writeback_in_driver_bfm: Inside do_transfer()");
  endtask        

// ****************************************************************************
  // UVMF_CHANGE_ME : Implement the first part of response protocol signaling.
  // Response handling is done in two parts.  The first is handled by do_transfer().
  // The second is handled by do_response_ready().
  // This task is executed by an agent configured as a RESPONDER.  In this
  // task the driver BFM waits for the beginning of a transfer initiated by the
  // initiator.  The arguments in this task are outputs because this task 
  // captures the information provided by the initiator about the transfer.  This
  // information is sent to the sequence when this task completes.  The sequence
  // then determines what response to provide and sends the response to the driver
  // BFM through the do_response_ready() function.  The do_response_ready function
  // then completes the current transfer.  When do_response_ready completes, the 
  // do_response task is immediately called to wait for the beginning of a transfer
  // and capture the information about the new transfer.  The flow is as follows:
  //    1) do_response() captures information from the first part of the transfer.
  //    2) do_response() completes, which sends information about the first part 
  //           of the transfer to the sequence.
  //    3) The sequence determines how to respond to the transfer in progress based
  //           on information from do_transfer()
  //    4) The sequence sends the response to do_response_ready().
  //    5) do_response_ready() completes the transfer.
  //
  task do_response(
    //output writeback_in_control_t w_control_in ,
    output bit [15:0] pcout ,
    output bit [15:0] memout ,
    output bit [15:0] aluout ,
    output bit [15:0] npc ,
    output bit enable_writeback ,
    output bit dr ,
    output bit sr1 ,
    output bit sr2 );
    @(posedge clk_i);
    @(posedge clk_i);
    @(posedge clk_i);
    @(posedge clk_i);
    @(posedge clk_i);
  endtask

  // ****************************************************************************
  // The resp_ready bit is intended to act as a simple event scheduler and does
  // not have anything to do with the protocol. It is intended to be set by
  // a proxy call to do_response_ready() and ultimately cleared somewhere within the always
  // block below.  In this simple situation, resp_ready will be cleared on the
  // clock cycle immediately following it being set.  In a more complex protocol,
  // the resp_ready signal could be an input to an explicit FSM to properly
  // time the responses to transactions.  This mechanism is designed to support 
  // protocols with single clock transfers that can occur back to back.
  bit resp_ready;
  always @(posedge clk_i) begin
    if (resp_ready) begin
      resp_ready <= 1'b0;
    end
  end

  // ****************************************************************************
  // UVMF_CHANGE_ME : Implement the second part of response protocol signaling.
  // Response handling is done in two parts.  The first is handled by do_transfer().
  // The second is handled by do_response_ready().  This function receives information
  // on how to complete the current transfer.  do_response_ready is a function to allow
  // the immediate execution of do_response to capture the next transfer while the above 
  // always block completes the current transfer.  This is to support protocols with 
  // single clock transfers that can occur back to back.
  //
  function void do_response_ready(    );  // pragma tbx xtf
    // UVMF_CHANGE_ME : Implement response - drive BFM outputs based on the arguments
    // passed into this function.  IMPORTANT - Must not consume time (it must remain
    // a function).  See notes above about the always block associated with the 
    // resp_ready flag.
    resp_ready <= 1'b1;
  endfunction

  // ****************************************************************************              
  // UVMF_CHANGE_ME : Note that all transaction variables are passed into the access
  //   task as inputs.  Some of these may need to be changed to outputs based on
  //   protocol needs.  To return the value of a variable from this protocol operation to the sequence, 
  //   change the direction of the variable from input to output in the list of arguments
  //   in the access task declaration.  Also change the direction from input 
  //   to output in the declaration of the do_transfer task within this BFM.
  //

  task access(
     //input writeback_in_control_t w_control_in ,
     input bit [15:0] pcout ,
     input bit [15:0] memout ,
     input bit [15:0] aluout ,
     input bit [15:0] npc ,
     input bit enable_writeback ,
     input bit dr ,
     input bit sr1 ,
     input bit sr2  ); // pragma tbx xtf                    
    @(posedge clk_i);                                                                     
    $display("writeback_in_driver_bfm: Inside access()");
    do_transfer(
      w_control_in,
      pcout,
      memout,
      aluout,
      npc,
      enable_writeback,
      dr,
      sr1,
      sr2    );                                                  
  endtask      

  // ****************************************************************************              
  // UVMF_CHANGE_ME : Note that all transaction variables are passed into the response
  //   task as outputs.  Some of these may need to be changed to inputs based on
  //   protocol needs.  

  task response(
    output writeback_in_control_t w_control_in ,
    output bit [15:0] pcout ,
    output bit [15:0] memout ,
    output bit [15:0] aluout ,
    output bit [15:0] npc ,
    output bit enable_writeback ,
    output bit dr ,
    output bit sr1 ,
    output bit sr2   ); // pragma tbx xtf
    @(posedge clk_i);
    $display("writeback_in_driver_bfm: Inside response()");
    do_response(
      w_control_in,
      pcout,
      memout,
      aluout,
      npc,
      enable_writeback,
      dr,
      sr1,
      sr2    );
  endtask             
 
endinterface
*/
// pragma uvmf custom external begin
// pragma uvmf custom external end

