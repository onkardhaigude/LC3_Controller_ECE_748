//----------------------------------------------------------------------
// inst_mem_alu_directed_sanity_seq.svh
//
// Exhaustive ALU Test Sequence for LC-3 Execute Stage Verification
// Covers ALL possible combinations of DR, SR1, SR2, and imm5 for
// ADD, AND, and NOT instructions.
//
// Total Instructions:
//   - LEA init: 8
//   - ADD reg-reg: 8 x 8 x 8 = 512
//   - ADD immediate: 8 x 8 x 32 = 2048
//   - AND reg-reg: 8 x 8 x 8 = 512
//   - AND immediate: 8 x 8 x 32 = 2048
//   - NOT: 8 x 8 = 64
//   Total: 5192 instructions
//----------------------------------------------------------------------

class inst_mem_alu_directed_sanity_seq extends inst_mem_responder_sequence;

  `uvm_object_utils(inst_mem_alu_directed_sanity_seq)

  // Instruction memory model: key=PC address, value=16-bit instruction
  bit [15:0] inst_mem [bit [15:0]];

  // Track last valid address
  bit [15:0] last_addr;

  function new(string name = "inst_mem_alu_directed_sanity_seq");
    super.new(name);
  endfunction

  //----------------------------------------------------------------------
  // load() - Pre-load instruction memory with ALL ALU combinations
  //----------------------------------------------------------------------
  virtual function void pre_initialize();
    bit [15:0] addr;
    int dr, sr1, sr2, imm;

    addr = 16'h3000;

    `uvm_info("ALU_SEQ", "Loading EXHAUSTIVE ALU instruction set into memory", UVM_LOW)

    //------------------------------------------------------------------
    // Phase 0: Initialize R0-R7 using LEA (8 instructions)
    // LEA format: [15:12]=1110, [11:9]=DR, [8:0]=PCoffset9
    //------------------------------------------------------------------
    //`uvm_info("ALU_SEQ", "Phase 0: LEA R0-R7 initialization (8 instructions)", UVM_MEDIUM)
    //for (dr = 0; dr < 8; dr++) begin
    //  inst_mem[addr] = {4'b1110, dr[2:0], 9'(dr + 1)};
    //  addr++;
    //end

    //------------------------------------------------------------------
    // Optional Phase 0b: AND immediate init for R0-R7
    // AND format: [15:12]=0101, [11:9]=DR, [8:6]=SR1, [5]=1, [4:0]=imm5
    // Here: AND Rn, Rn, #0  → clears each register to 0
    //------------------------------------------------------------------
    `uvm_info("ALU_SEQ", "Phase 0: AND immediate R0-R7 initialization (8 instructions)", UVM_MEDIUM)
    for (dr = 0; dr < 8; dr++) begin
      inst_mem[addr] = {4'b0101, dr[2:0], dr[2:0], 1'b1, 5'b00000};
      addr++;
    end

    //------------------------------------------------------------------
    // Phase 1: ADD Register Mode - ALL combinations
    // ADD format: [15:12]=0001, [11:9]=DR, [8:6]=SR1, [5]=0, [4:3]=00, [2:0]=SR2
    // Total: 8 x 8 x 8 = 512 instructions
    //------------------------------------------------------------------
    `uvm_info("ALU_SEQ", "Phase 1: ADD reg-reg - ALL 512 combinations (DR x SR1 x SR2)", UVM_MEDIUM)
    for (dr = 0; dr < 8; dr++) begin
      for (sr1 = 0; sr1 < 8; sr1++) begin
        for (sr2 = 0; sr2 < 8; sr2++) begin
          inst_mem[addr] = {4'b0001, dr[2:0], sr1[2:0], 3'b000, sr2[2:0]};
          addr++;
        end
      end
    end

    //------------------------------------------------------------------
    // Phase 2: ADD Immediate Mode - ALL combinations
    // ADD format: [15:12]=0001, [11:9]=DR, [8:6]=SR1, [5]=1, [4:0]=imm5
    // Total: 8 x 8 x 32 = 2048 instructions
    //------------------------------------------------------------------
    `uvm_info("ALU_SEQ", "Phase 2: ADD immediate - ALL 2048 combinations (DR x SR1 x imm5)", UVM_MEDIUM)
    for (dr = 0; dr < 8; dr++) begin
      for (sr1 = 0; sr1 < 8; sr1++) begin
        for (imm = 0; imm < 32; imm++) begin
          inst_mem[addr] = {4'b0001, dr[2:0], sr1[2:0], 1'b1, imm[4:0]};
          addr++;
        end
      end
    end

    //------------------------------------------------------------------
    // Phase 3: AND Register Mode - ALL combinations
    // AND format: [15:12]=0101, [11:9]=DR, [8:6]=SR1, [5]=0, [4:3]=00, [2:0]=SR2
    // Total: 8 x 8 x 8 = 512 instructions
    //------------------------------------------------------------------
    `uvm_info("ALU_SEQ", "Phase 3: AND reg-reg - ALL 512 combinations (DR x SR1 x SR2)", UVM_MEDIUM)
    for (dr = 0; dr < 8; dr++) begin
      for (sr1 = 0; sr1 < 8; sr1++) begin
        for (sr2 = 0; sr2 < 8; sr2++) begin
          inst_mem[addr] = {4'b0101, dr[2:0], sr1[2:0], 3'b000, sr2[2:0]};
          addr++;
        end
      end
    end

    //------------------------------------------------------------------
    // Phase 4: AND Immediate Mode - ALL combinations
    // AND format: [15:12]=0101, [11:9]=DR, [8:6]=SR1, [5]=1, [4:0]=imm5
    // Total: 8 x 8 x 32 = 2048 instructions
    //------------------------------------------------------------------
    `uvm_info("ALU_SEQ", "Phase 4: AND immediate - ALL 2048 combinations (DR x SR1 x imm5)", UVM_MEDIUM)
    for (dr = 0; dr < 8; dr++) begin
      for (sr1 = 0; sr1 < 8; sr1++) begin
        for (imm = 0; imm < 32; imm++) begin
          inst_mem[addr] = {4'b0101, dr[2:0], sr1[2:0], 1'b1, imm[4:0]};
          addr++;
        end
      end
    end

    //------------------------------------------------------------------
    // Phase 5: NOT Instructions - ALL combinations
    // NOT format: [15:12]=1001, [11:9]=DR, [8:6]=SR, [5:0]=111111
    // Total: 8 x 8 = 64 instructions
    //------------------------------------------------------------------
    `uvm_info("ALU_SEQ", "Phase 5: NOT - ALL 64 combinations (DR x SR)", UVM_MEDIUM)
    for (dr = 0; dr < 8; dr++) begin
      for (sr1 = 0; sr1 < 8; sr1++) begin
        inst_mem[addr] = {4'b1001, dr[2:0], sr1[2:0], 6'b111111};
        addr++;
      end
    end

    // Store last valid address
    last_addr = addr - 1;

    `uvm_info("ALU_SEQ", $sformatf("Loaded %0d instructions (0x3000 to 0x%04h)", 
              last_addr - 16'h3000 + 1, last_addr), UVM_LOW)
    `uvm_info("ALU_SEQ", "Breakdown:", UVM_LOW)
    `uvm_info("ALU_SEQ", "  LEA init:      8", UVM_LOW)
    `uvm_info("ALU_SEQ", "  ADD reg-reg:   512", UVM_LOW)
    `uvm_info("ALU_SEQ", "  ADD immediate: 2048", UVM_LOW)
    `uvm_info("ALU_SEQ", "  AND reg-reg:   512", UVM_LOW)
    `uvm_info("ALU_SEQ", "  AND immediate: 2048", UVM_LOW)
    `uvm_info("ALU_SEQ", "  NOT:           64", UVM_LOW)
    `uvm_info("ALU_SEQ", $sformatf("  TOTAL:         %0d", last_addr - 16'h3000 + 1), UVM_LOW)

  endfunction

  //----------------------------------------------------------------------
  // body() - Main sequence task
  //----------------------------------------------------------------------
  virtual task body();
    bit [15:0] curr_addr;

    req = inst_mem_transaction::type_id::create("req");

    // Load instruction memory once
    pre_initialize();

    curr_addr = 16'h3000;

    `uvm_info("ALU_SEQ", "Starting EXHAUSTIVE ALU directed sequence", UVM_LOW)

    forever begin
      start_item(req);

      // Set instruction from pre-loaded memory
      if (inst_mem.exists(curr_addr)) begin
        req.instr_dout = inst_mem[curr_addr];

        // Log progress every 500 instructions
        if ((curr_addr - 16'h3000) % 500 == 0) begin
          `uvm_info("ALU_SEQ", $sformatf("Progress: %0d / %0d instructions", 
                    curr_addr - 16'h3000, last_addr - 16'h3000 + 1), UVM_MEDIUM)
        end

        curr_addr++;
      end 
      else begin
        // After all directed instructions, send NOPs to drain pipeline
        req.instr_dout = 16'h0000;  // NOP (BR with nzp=000)

        // Log completion once
        if (curr_addr == last_addr + 1) begin
          `uvm_info("ALU_SEQ", "All directed instructions sent - sending NOPs to drain pipeline", UVM_LOW)
        end
        curr_addr++;
      end

      finish_item(req);
    end

  endtask : body

endclass : inst_mem_alu_directed_sanity_seq

//----------------------------------------------------------------------
// EXHAUSTIVE COVERAGE SUMMARY:
//
// This sequence tests ALL possible ALU instruction combinations:
//
// 1. ADD Register Mode (512 instructions):
//    - All 8 DR values (R0-R7)
//    - All 8 SR1 values (R0-R7)
//    - All 8 SR2 values (R0-R7)
//    - Total: 8 x 8 x 8 = 512
//
// 2. ADD Immediate Mode (2048 instructions):
//    - All 8 DR values (R0-R7)
//    - All 8 SR1 values (R0-R7)
//    - All 32 imm5 values (0 to 31, including negative via sign extension)
//    - Total: 8 x 8 x 32 = 2048
//
// 3. AND Register Mode (512 instructions):
//    - All 8 DR values (R0-R7)
//    - All 8 SR1 values (R0-R7)
//    - All 8 SR2 values (R0-R7)
//    - Total: 8 x 8 x 8 = 512
//
// 4. AND Immediate Mode (2048 instructions):
//    - All 8 DR values (R0-R7)
//    - All 8 SR1 values (R0-R7)
//    - All 32 imm5 values (0 to 31, including negative via sign extension)
//    - Total: 8 x 8 x 32 = 2048
//
// 5. NOT (64 instructions):
//    - All 8 DR values (R0-R7)
//    - All 8 SR values (R0-R7)
//    - Total: 8 x 8 = 64
//
// GRAND TOTAL: 8 + 512 + 2048 + 512 + 2048 + 64 = 5192 instructions
//
// Estimated simulation time: ~52,000 clock cycles (at 10ns clock = ~520us)
//----------------------------------------------------------------------