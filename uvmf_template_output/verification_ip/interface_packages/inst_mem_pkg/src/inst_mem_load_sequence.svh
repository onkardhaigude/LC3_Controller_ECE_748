class inst_mem_load_sequence extends inst_mem_responder_sequence;
  `uvm_object_utils(inst_mem_load_sequence)

  // Choose source register once for all loads
  //bit [2:0] src_reg;

  function new(string name = "inst_mem_load_sequence");
    super.new(name);
    //src_reg = 3'd1; // R1, for example
  endfunction

  // Helper: send one item that is already fully assigned
  task automatic send_item();
    start_item(req);
    finish_item(req);
  endtask

  task body();
    // Use the same REQ type as base (inst_mem_transaction)
    //req = inst_mem_transaction::type_id::create("req");
    req = inst_mem_load_transaction::type_id::create("req");
    // ============================================================
    // 1) ST: 0011 SR PCoffset9   (opcode == ST)
    //     instr_dout = { opcode[15:12], sr1[11:9], pcoffset9[8:0] }
    // ============================================================
   for (int dr = 0; dr < 8; dr++) begin
    for (int offs = 0; offs < 512; offs++) begin  // all 2^9 combinations
      req.opcode     = LD;
      req.dr        = dr[2:0];
      req.pcoffset9  = offs[8:0];

      // Construct instruction word explicitly
        req.instr_dout = { req.opcode[3:0],
                           req.dr[2:0],
                           req.pcoffset9[8:0] };
      // optional: drive instrmem_rd if your driver uses it
      // req.instrmem_rd = 1'b1;

      send_item();
    end
   end

    // ============================================================
    // 2) STI: 1011 SR PCoffset9  (opcode == STI)
    //     instr_dout = { opcode, sr1, pcoffset9 }
    // ============================================================
    for (int dr = 0; dr < 8; dr++) begin
      for (int offs = 0; offs < 512; offs++) begin
        req.opcode     = LDI;
        req.dr        = dr[2:0];
        req.pcoffset9  = offs[8:0];

        req.instr_dout = { req.opcode[3:0],
                           req.dr[2:0],
                           req.pcoffset9[8:0] };
        // req.instrmem_rd = 1'b1;

        send_item();
      end
    end
    // ============================================================
    // 3) STR: 0111 SR BaseR offset6  (opcode == STR)
    //     instr_dout = { opcode, sr1, baser, pcoffset6 }
    // ============================================================
    for (int dr = 0; dr < 8; dr++) begin
      for (int br = 0; br < 8; br++) begin        // all BaseR values
        for (int offs = 0; offs < 64; offs++) begin // all 2^6 offsets
          req.opcode     = LDR;
          req.dr        = dr[2:0];
          req.baser      = br[2:0];
          req.pcoffset6  = offs[5:0];

          req.instr_dout = { req.opcode[3:0],
                             req.dr[2:0],
                             req.baser[2:0],
                             req.pcoffset6[5:0] };
          // req.instrmem_rd = 1'b1;

          send_item();
        end
      end
    end
    for (int dr = 0; dr < 8; dr++) begin
      for (int offs = 0; offs < 512; offs++) begin
        req.opcode     = LEA;
        req.dr         = dr[2:0];
        req.pcoffset9  = offs[8:0];

        req.instr_dout = { req.opcode[3:0],
                       req.dr[2:0],
                       req.pcoffset9[8:0] };

      send_item();
      end
    end
  endtask

endclass : inst_mem_load_sequence
