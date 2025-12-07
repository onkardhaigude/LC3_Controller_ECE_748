//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class passes transactions between the sequencer
//        and the BFM driver interface.  It accesses the driver BFM 
//        through the bfm handle. This driver
//        passes transactions to the driver BFM through the access
//        task.  
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class writeback_in_ibs_driver  extends writeback_in_driver ;

  `uvm_component_utils( writeback_in_ibs_driver )

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent=null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
  virtual function void configure(input CONFIG_T cfg);
    bfm.configure(
      cfg.active_passive,
      cfg.initiator_responder
);                    
  endfunction

// ****************************************************************************
  virtual function void set_bfm_proxy_handle();
    bfm.proxy = this;  endfunction

// ****************************************************************************              
  virtual task access( inout REQ txn );
    if (configuration.initiator_responder==RESPONDER) begin
      if (1'b1) begin
        bfm.do_response_ready(
        );
      end
      bfm.response(
        txn.w_control_in,
        txn.pcout,
        txn.memout,
        txn.aluout,
        txn.npc,
        txn.enable_writeback,
        txn.dr,
        txn.sr1,
        txn.sr2        
      );
    end else begin    
      bfm.access(
        txn.w_control_in,
        txn.pcout,
        txn.memout,
        txn.aluout,
        txn.npc,
        txn.enable_writeback,
        txn.dr,
        txn.sr1,
        txn.sr2    );
    end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

