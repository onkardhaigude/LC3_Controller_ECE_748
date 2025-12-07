class inst_mem_store_sequence extends inst_mem_responder_sequence;
  `uvm_object_utils(inst_mem_store_sequence)

  function new(string name = "inst_mem_store_sequence");
    super.new(name);
  endfunction

  // Helper: send one item that is already fully assigned
  task automatic send_item();
    start_item(req);
    finish_item(req);
  endtask

  task body();
    // Create extended transaction (constrains opcode to ST/STR/STI if you ever randomize)
    req = inst_mem_store_transaction::type_id::create("req");

    /*
    for (int sr = 0; sr < 8; sr++) begin            // all SR values
      //for (int offs = 192; offs < 256; offs++) begin  // all 2^9 offsets
        req.opcode     = AND;
        req.imm5       = 5'sd0;
        req.sr1        = sr[2:0];
        req.dr         = sr[2:0];
        req.mode       = 1'b1;
        //req.pcoffset9  = offs[8:0];

        // Construct instruction word explicitly
        req.instr_dout = { req.opcode, req.dr, req.sr1, 1'b1, req.imm5};

        // req.instrmem_rd = 1'b1; // if needed

        send_item();
      //end
    end
    */
    for (int dr = 0; dr < 8; dr++) begin
      for (int offs = 0; offs < 2; offs++) begin
        req.opcode     = LEA;
        req.dr         = dr[2:0];
        req.pcoffset9  = offs[8:0];

        req.instr_dout = { req.opcode[3:0],
                       req.dr[2:0],
                       req.pcoffset9[8:0] };

      send_item();
      end
    end

    // ============================================================
    // 1) ST: 0011 SR PCoffset9   (opcode == ST)
    //     instr_dout = { opcode[15:12], sr1[11:9], pcoffset9[8:0] }
    //    → cover ALL sr1 (R0–R7) × ALL pcoffset9 (0–511)
    // ============================================================
    for (int sr = 0; sr < 8; sr++) begin            // all SR values
      for (int offs = 0; offs < 512; offs++) begin  // all 2^9 offsets
        req.opcode     = ST;
        req.sr1        = sr[2:0];
        req.pcoffset9  = offs[8:0];

        // Construct instruction word explicitly
        req.instr_dout = { req.opcode, req.sr1, req.pcoffset9 };

        // req.instrmem_rd = 1'b1; // if needed

        send_item();
      end
    end

    // ============================================================
    // 3) STR: 0111 SR BaseR offset6  (opcode == STR)
    //     instr_dout = { opcode, sr1, baser, pcoffset6 }
    //    → ALL sr1 × ALL baser × ALL pcoffset6
    // ============================================================
    for (int sr = 0; sr < 8; sr++) begin            // all SR values
      for (int br = 0; br < 8; br++) begin          // all BaseR values
        for (int offs = 0; offs < 64; offs++) begin // all 2^6 offsets
          req.opcode     = STR;
          req.sr1        = sr[2:0];
          req.baser      = br[2:0];
          req.pcoffset6  = offs[5:0];

          req.instr_dout = { req.opcode, req.sr1, req.baser, req.pcoffset6 };

          // req.instrmem_rd = 1'b1;

          send_item();
        end
      end
    end

    // ============================================================
    // 2) STI: 1011 SR PCoffset9  (opcode == STI)
    //     instr_dout = { opcode, sr1, pcoffset9 }
    //    → ALL sr1 × ALL pcoffset9
    // ============================================================
    for (int sr = 0; sr < 8; sr++) begin
      for (int offs = 0; offs < 512; offs++) begin
        req.opcode     = STI;
        req.sr1        = sr[2:0];
        req.pcoffset9  = offs[8:0];

        req.instr_dout = { req.opcode, req.sr1, req.pcoffset9 };

        // req.instrmem_rd = 1'b1;

        send_item();
      end
    end
  endtask

endclass : inst_mem_store_sequence
