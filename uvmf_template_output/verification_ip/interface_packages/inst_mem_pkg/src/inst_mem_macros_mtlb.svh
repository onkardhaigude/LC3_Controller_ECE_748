//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the inst_mem package.
//   These macros include packed struct definitions.  These structs are
//   used to pass data between classes, hvl, and BFM's, hdl.  Use of 
//   structs are more efficient and simpler to modify.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_struct
//      and from_struct methods defined in the macros below that are used in  
//      the inst_mem_configuration class.
//
  `define inst_mem_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } inst_mem_configuration_s;

  `define inst_mem_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function inst_mem_configuration_s to_struct();\
    inst_mem_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( inst_mem_configuration_struct );\
  endfunction

  `define inst_mem_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(inst_mem_configuration_s inst_mem_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = inst_mem_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the inst_mem_transaction class.
//
  `define inst_mem_MONITOR_STRUCT typedef struct packed  { \
  opcode_t _opcode ; \
  bit [2:0] _sr1 ; \
  bit [2:0] _sr2 ; \
  bit [2:0] _dr ; \
  bit _mode ; \
  bit [2:0] _baser ; \
  bit [8:0] _pcoffset9 ; \
  bit [5:0] _pcoffset6 ; \
  bit [4:0] _imm5 ; \
  bit [2:0] _nzp ; \
  len16_t _PC ; \
  bit _instrmem_rd ; \
  len16_t _instr_dout ; \
  bit _complete_instr ; \
     } inst_mem_monitor_s;

  `define inst_mem_TO_MONITOR_STRUCT_FUNCTION \
  virtual function inst_mem_monitor_s to_monitor_struct();\
    inst_mem_monitor_struct = \
            { \
            this._opcode , \
            this._sr1 , \
            this._sr2 , \
            this._dr , \
            this._mode , \
            this._baser , \
            this._pcoffset9 , \
            this._pcoffset6 , \
            this._imm5 , \
            this._nzp , \
            this._PC , \
            this._instrmem_rd , \
            this._instr_dout , \
            this._complete_instr  \
            };\
    return ( inst_mem_monitor_struct);\
  endfunction\

  `define inst_mem_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(inst_mem_monitor_s inst_mem_monitor_struct);\
            {\
            this._opcode , \
            this._sr1 , \
            this._sr2 , \
            this._dr , \
            this._mode , \
            this._baser , \
            this._pcoffset9 , \
            this._pcoffset6 , \
            this._imm5 , \
            this._nzp , \
            this._PC , \
            this._instrmem_rd , \
            this._instr_dout , \
            this._complete_instr  \
            } = inst_mem_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the inst_mem_transaction class.
//      Also update the comments in the driver BFM.
//
  `define inst_mem_INITIATOR_STRUCT typedef struct packed  { \
  opcode_t _opcode ; \
  bit [2:0] _sr1 ; \
  bit [2:0] _sr2 ; \
  bit [2:0] _dr ; \
  bit _mode ; \
  bit [2:0] _baser ; \
  bit [8:0] _pcoffset9 ; \
  bit [5:0] _pcoffset6 ; \
  bit [4:0] _imm5 ; \
  bit [2:0] _nzp ; \
  len16_t _PC ; \
  bit _instrmem_rd ; \
  len16_t _instr_dout ; \
  bit _complete_instr ; \
     } inst_mem_initiator_s;

  `define inst_mem_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function inst_mem_initiator_s to_initiator_struct();\
    inst_mem_initiator_struct = \
           {\
           this._opcode , \
           this._sr1 , \
           this._sr2 , \
           this._dr , \
           this._mode , \
           this._baser , \
           this._pcoffset9 , \
           this._pcoffset6 , \
           this._imm5 , \
           this._nzp , \
           this._PC , \
           this._instrmem_rd , \
           this._instr_dout , \
           this._complete_instr  \
           };\
    return ( inst_mem_initiator_struct);\
  endfunction

  `define inst_mem_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(inst_mem_initiator_s inst_mem_initiator_struct);\
           {\
           this._opcode , \
           this._sr1 , \
           this._sr2 , \
           this._dr , \
           this._mode , \
           this._baser , \
           this._pcoffset9 , \
           this._pcoffset6 , \
           this._imm5 , \
           this._nzp , \
           this._PC , \
           this._instrmem_rd , \
           this._instr_dout , \
           this._complete_instr  \
           } = inst_mem_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the inst_mem_transaction class.
//      Also update the comments in the driver BFM.
//
  `define inst_mem_RESPONDER_STRUCT typedef struct packed  { \
  opcode_t _opcode ; \
  bit [2:0] _sr1 ; \
  bit [2:0] _sr2 ; \
  bit [2:0] _dr ; \
  bit _mode ; \
  bit [2:0] _baser ; \
  bit [8:0] _pcoffset9 ; \
  bit [5:0] _pcoffset6 ; \
  bit [4:0] _imm5 ; \
  bit [2:0] _nzp ; \
  len16_t _PC ; \
  bit _instrmem_rd ; \
  len16_t _instr_dout ; \
  bit _complete_instr ; \
     } inst_mem_responder_s;

  `define inst_mem_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function inst_mem_responder_s to_responder_struct();\
    inst_mem_responder_struct = \
           {\
           this._opcode , \
           this._sr1 , \
           this._sr2 , \
           this._dr , \
           this._mode , \
           this._baser , \
           this._pcoffset9 , \
           this._pcoffset6 , \
           this._imm5 , \
           this._nzp , \
           this._PC , \
           this._instrmem_rd , \
           this._instr_dout , \
           this._complete_instr  \
           };\
    return ( inst_mem_responder_struct);\
  endfunction

  `define inst_mem_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(inst_mem_responder_s inst_mem_responder_struct);\
           {\
           this._opcode , \
           this._sr1 , \
           this._sr2 , \
           this._dr , \
           this._mode , \
           this._baser , \
           this._pcoffset9 , \
           this._pcoffset6 , \
           this._imm5 , \
           this._nzp , \
           this._PC , \
           this._instrmem_rd , \
           this._instr_dout , \
           this._complete_instr  \
           } = inst_mem_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
