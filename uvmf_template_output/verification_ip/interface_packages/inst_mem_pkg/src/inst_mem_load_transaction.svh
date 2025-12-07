class inst_mem_load_transaction extends inst_mem_transaction;
  `uvm_object_utils(inst_mem_store_transaction)

  // Limit the cyclic rand opcode to store instructions only
  constraint load_opcode_c {
    opcode inside { LD, LDR, LDI };
  }

  // Optional: shape offsets and baser a bit, but keep them free enough
  /*
  constraint store_fields_c {
    if (opcode inside { ST, STI }) {
      // LD/ST/LDI/STI use pcoffset9
      // keep range wide so it’s "random enough" but still legal
      pcoffset9 inside { [9'h000 : 9'h1FF] };
    }
    if (opcode == STR) {
      pcoffset6 inside { [6'h00 : 6'h3F] };
    }
    baser inside { [3'd0 : 3'd7] };  // any base register
  }
  */

  function new(string name = "inst_mem_store_transaction");
    super.new(name);
  endfunction
endclass
