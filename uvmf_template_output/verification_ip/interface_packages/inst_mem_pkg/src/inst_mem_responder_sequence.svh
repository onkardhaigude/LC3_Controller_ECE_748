//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class can be used to provide stimulus when an interface
//              has been configured to run in a responder mode. It
//              will never finish by default, always going back to the driver
//              and driver BFM for the next transaction with which to respond.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class inst_mem_responder_sequence 
  extends inst_mem_sequence_base ;

  `uvm_object_utils( inst_mem_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "inst_mem_responder_sequence");
    super.new(name);
  endfunction

  task body();
    int unsigned instr_count = 0;
    // Desired fixed opcode sequence
    req=inst_mem_transaction::type_id::create("req");
    forever begin
      start_item(req);
      if (instr_count < 8) begin
      // LD into DR = instr_count (R0..R7)
      assert(req.randomize() with {
        opcode == LD;
        dr     == instr_count[2:0];   // 0..7
      }) else
        `uvm_error("IMEM_SEQ",
                   $sformatf("Randomize failed in init LD phase, instr_count=%0d",
                             instr_count))
      end
      //Stores
      //else if (instr_count >= 8 && instr_count <=11) begin
      //  assert(req.randomize() with {
      //    opcode == ST;
      //    sr1     == instr_count[2:0];   // 0..6
      //  }) else
      //    `uvm_error("IMEM_SEQ",
      //              "Randomize failed for BR at instr_count 7")
      //end
      else if (instr_count >= 8 && instr_count < 16) begin
        int unsigned tgt_reg = instr_count - 8;
        assert(req.randomize() with {
          opcode == AND;
          mode   == 1'b1;              // immediate
          dr     == tgt_reg[2:0];      // dest register
          sr1    == tgt_reg[2:0];      // same source
          imm5   == 5'sd0;             // AND with #0
        }) else
          `uvm_error("IMEM_SEQ",
               $sformatf("Randomize failed in ANDI-zero phase, instr_count=%0d",
                         instr_count))
      end
      else if (instr_count >= 16 && instr_count < 24) begin
        int unsigned tgt_reg = instr_count - 16;
        assert(req.randomize() with {
          opcode == ADD;
          mode   == 1'b1;              // immediate
          dr     == tgt_reg[2:0];      // dest register
          sr1    == tgt_reg[2:0];      // same source
          imm5   == 5'sd0;             // AND with #0
        }) else
          `uvm_error("IMEM_SEQ",
               $sformatf("Randomize failed in ANDI-zero phase, instr_count=%0d",
                         instr_count))
      end
      // 7 : Branch with nzp set (not zero)
      /*else if (instr_count == 7) begin
        assert(req.randomize() with {
          opcode == BR;
          // hard constraint: nzp must have at least one bit set
          nzp != 3'b000;
        }) else
          `uvm_error("IMEM_SEQ",
                    "Randomize failed for BR at instr_count 7")
      end
      */
      // 8–20 : ALU phase – ADD/AND/NOT using only initialized regs R0..R6
      else if (instr_count >= 12 && instr_count < 20) begin
        assert(req.randomize() with {
          opcode inside {ADD, AND };
          dr  < 3'd7; 
          sr1 < 3'd7;
          sr2 < 3'd7;
        }) else
          `uvm_error("IMEM_SEQ",
                    $sformatf("Randomize failed in ALU phase, instr_count=%0d",
                              instr_count))
      end

      // After 20 : normal constrained random (class constraints only)
      else begin
        if (!req.randomize()) begin
          `uvm_error("IMEM_SEQ",
                    "Randomize failed in free phase")
        end
      end


      finish_item(req);
      instr_count++;
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      // pragma uvmf custom body end
    end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

