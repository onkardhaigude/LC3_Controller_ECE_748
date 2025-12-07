//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records decode_in transaction information using
//       a covergroup named decode_in_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class decode_in_transaction_coverage  extends uvm_subscriber #(.T(decode_in_transaction ));

  `uvm_component_utils( decode_in_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
  covergroup decode_in_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    option.auto_bin_max=1024;
    option.per_instance=1;
    cp_opcode: coverpoint coverage_trans.opcode {
      bins AND_op = {4'b0101};  // Use actual bit values instead of enum names
      bins ADD_op = {4'b0001};
      bins NOT_op = {4'b1001};
      bins LD_op  = {4'b0010};     
      bins LDR_op = {4'b0110};
      bins LDI_op = {4'b1010};
      bins LEA_op = {4'b1110};
      bins ST_op  = {4'b0011};
      bins STR_op = {4'b0111};   
      bins STI_op = {4'b1011};
      bins BR_op  = {4'b0000};
      bins JMP_op = {4'b1100};
    }
    cp_mode: coverpoint coverage_trans.mode {
      bins mode_0 = {1'b0};  // Use explicit bit values
      bins mode_1 = {1'b1};
    }
    cp_opcodeXmode: cross cp_opcode, cp_mode {
      bins ADD_mode_0 = binsof(cp_opcode.ADD_op) && binsof(cp_mode.mode_0);
      bins ADD_mode_1 = binsof(cp_opcode.ADD_op) && binsof(cp_mode.mode_1);
      bins AND_mode_0 = binsof(cp_opcode.AND_op) && binsof(cp_mode.mode_0);
      bins AND_mode_1 = binsof(cp_opcode.AND_op) && binsof(cp_mode.mode_1);
      ignore_bins NOT_modes = binsof(cp_opcode.NOT_op) && binsof(cp_mode);
      ignore_bins LD_modes  = binsof(cp_opcode.LD_op)  && binsof(cp_mode);
      ignore_bins LDR_modes = binsof(cp_opcode.LDR_op) && binsof(cp_mode);
      ignore_bins LDI_modes = binsof(cp_opcode.LDI_op) && binsof(cp_mode);
      ignore_bins LEA_modes = binsof(cp_opcode.LEA_op) && binsof(cp_mode);
      ignore_bins ST_modes  = binsof(cp_opcode.ST_op)  && binsof(cp_mode);
      ignore_bins STR_modes = binsof(cp_opcode.STR_op) && binsof(cp_mode);
      ignore_bins STI_modes = binsof(cp_opcode.STI_op) && binsof(cp_mode);
      ignore_bins BR_modes  = binsof(cp_opcode.BR_op)  && binsof(cp_mode);
      ignore_bins JMP_modes = binsof(cp_opcode.JMP_op) && binsof(cp_mode);

      //ignore_bins remaining = default;
    }
    cp_npc_in: coverpoint coverage_trans.npc_in{
      bins npc_in_0 = {0};
      //bins npc_in_1 = {1};
      bins npc_in_others = {[2:65535]};
    }
    cp_sr1: coverpoint coverage_trans.sr1{
      bins sr1_R0 = {3'b000};  // Use bit values instead of enum R0
      bins sr1_R1 = {3'b001};
      bins sr1_R2 = {3'b010}; 
      bins sr1_R3 = {3'b011};
      bins sr1_R4 = {3'b100};
      bins sr1_R5 = {3'b101};
      bins sr1_R6 = {3'b110};
      bins sr1_R7 = {3'b111};
    }
    cp_sr2: coverpoint coverage_trans.sr2{
      bins sr2_R0 = {3'b000};  // Use bit values instead of enum R0
      bins sr2_R1 = {3'b001};
      bins sr2_R2 = {3'b010}; 
      bins sr2_R3 = {3'b011};
      bins sr2_R4 = {3'b100};
      bins sr2_R5 = {3'b101};
      bins sr2_R6 = {3'b110};
      bins sr2_R7 = {3'b111};
    }

    cp_sr1Xsr2: cross cp_sr1, cp_sr2 {
      bins sr1R0_sr2 = binsof(cp_sr1.sr1_R0) && binsof(cp_sr2);
      bins sr1R1_sr2 = binsof(cp_sr1.sr1_R1) && binsof(cp_sr2);
      bins sr1R2_sr2 = binsof(cp_sr1.sr1_R2) && binsof(cp_sr2);
      bins sr1R3_sr2 = binsof(cp_sr1.sr1_R3) && binsof(cp_sr2);
      bins sr1R4_sr2 = binsof(cp_sr1.sr1_R4) && binsof(cp_sr2);
      bins sr1R5_sr2 = binsof(cp_sr1.sr1_R5) && binsof(cp_sr2);
      bins sr1R6_sr2 = binsof(cp_sr1.sr1_R6) && binsof(cp_sr2);
      bins sr1R7_sr2 = binsof(cp_sr1.sr1_R7) && binsof(cp_sr2);
      // pragma uvmf custom sr1Xsr2_bins begin
    }

    dr: coverpoint coverage_trans.dr{
      bins dr_R0 = {3'b000};  // Use bit values instead of enum R0
      bins dr_R1 = {3'b001};
      bins dr_R2 = {3'b010}; 
      bins dr_R3 = {3'b011};
      bins dr_R4 = {3'b100};
      bins dr_R5 = {3'b101};
      bins dr_R6 = {3'b110};
      bins dr_R7 = {3'b111};  
    }
    //baser: coverpoint coverage_trans.baser iff (coverage_trans.opcode == 4'b1100);  // JMP opcode
    //pcoffset9: coverpoint coverage_trans.pcoffset9 iff (coverage_trans.opcode == 4'b0000);  // BR opco
    baser: coverpoint coverage_trans.baser;
    pcoffset9: coverpoint coverage_trans.pcoffset9;
    pcoffset6: coverpoint coverage_trans.pcoffset6 iff (coverage_trans.opcode != 4'b0000 || coverage_trans.opcode != 4'b1100);  // Not BR or JMP opcode

    //pcoffset9: coverpoint coverage_trans.pcoffset9 {
    //  bins pc_offset9_neg = { -256  : -1 };
    //  bins pc_offset9_zero = { 0 };
    //  bins pc_offset9_pos = { 1 : 255 };
    //}
    //cp_br_X_pcoffset9: coverpoint coverage_trans.pcoffset9 iff (coverage_trans.opcode == 4'b0000); // BR opcode
    imm5: coverpoint coverage_trans.imm5;
    nzp: coverpoint {coverage_trans.n, coverage_trans.z, coverage_trans.p} iff (coverage_trans.opcode == 4'b0000); // BR opcode

    cp_opcodeXpc9: cross cp_opcode, pcoffset9 {
      option.cross_auto_bin_max = 0;
    // These bins say: for each opcode bin, cross with *all* bins of pcoffset9
    bins LD_pc9   = binsof(cp_opcode.LD_op)  && binsof(pcoffset9);
    bins LDI_pc9  = binsof(cp_opcode.LDI_op) && binsof(pcoffset9);
    bins ST_pc9   = binsof(cp_opcode.ST_op)  && binsof(pcoffset9);
    bins STI_pc9  = binsof(cp_opcode.STI_op) && binsof(pcoffset9);
    //ignore_bins others = default;
  }

  // Cross for LDR with baser and pcoffset6 (all combinations)
  cp_LDR_baser_pc6: cross cp_opcode, baser, pcoffset6 {
    option.cross_auto_bin_max = 0;
    bins LDR_all = binsof(cp_opcode.LDR_op) && binsof(baser) && binsof(pcoffset6);
    //ignore_bins others = default;
  }

  // Cross for STR with baser and pcoffset6 (all combinations)
  cp_STR_baser_pc6: cross cp_opcode, baser, pcoffset6 {
    option.cross_auto_bin_max = 0;
    bins STR_all = binsof(cp_opcode.STR_op) && binsof(baser) && binsof(pcoffset6);
    //ignore_bins others = default;
  }
    
    // pragma uvmf custom covergroup end
  endgroup

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    decode_in_transaction_cg=new;
    `uvm_warning("COVERAGE_MODEL_REVIEW", "A covergroup has been constructed which may need review because of either generation or re-generation with merging.  Please note that transaction variables added as a result of re-generation and merging are not automatically added to the covergroup.  Remove this warning after the covergroup has been reviewed.")
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    decode_in_transaction_cg.set_inst_name($sformatf("decode_in_transaction_cg_%s",get_full_name()));
  endfunction

  // ****************************************************************************
  // FUNCTION: write (T t)
  // This function is automatically executed when a transaction arrives on the
  // analysis_export.  It copies values from the variables in the transaction 
  // to local variables used to collect functional coverage.  
  //
  virtual function void write (T t);
    `uvm_info("COV","Received transaction",UVM_HIGH);
    coverage_trans = t;
    decode_in_transaction_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

