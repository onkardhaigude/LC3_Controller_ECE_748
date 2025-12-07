//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//
// DESCRIPTION: This analysis component contains analysis_exports for receiving
//   data and analysis_ports for sending data.
// 
//   This analysis component has the following analysis_exports that receive the 
//   listed transaction type.
//   
//   decode_in_agent_ae receives transactions of type  decode_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  decode_scb_ap broadcasts transactions of type decode_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class decode_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  )
 extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( decode_predictor #(
                              CONFIG_T,
                              BASE_T
                              )
)


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_decode_in_agent_ae #(decode_in_transaction, decode_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )
) decode_in_agent_ae;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(decode_out_transaction) decode_scb_ap;


  // Transaction variable for predicted values to be sent out decode_scb_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef decode_out_transaction decode_scb_ap_output_transaction_t;
  decode_scb_ap_output_transaction_t decode_scb_ap_output_transaction;
  // Code for sending output transaction out through decode_scb_ap
  // decode_scb_ap.write(decode_scb_ap_output_transaction);

  // Define transaction handles for debug visibility 
  decode_in_transaction decode_in_agent_ae_debug;


  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
    `uvm_warning("PREDICTOR_REVIEW", "This predictor has been created either through generation or re-generation with merging.  Remove this warning after the predictor has been reviewed.")
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);

    decode_in_agent_ae = new("decode_in_agent_ae", this);
    decode_scb_ap =new("decode_scb_ap", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  bit decode_model_output;
  // FUNCTION: write_decode_in_agent_ae
  // Transactions received through decode_in_agent_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_decode_in_agent_ae(decode_in_transaction t);
    // pragma uvmf custom decode_in_agent_ae_predictor begin
    decode_in_agent_ae_debug = t;
    //`uvm_info("PRED", "Transaction Received through decode_in_agent_ae", UVM_MEDIUM)
    //`uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    decode_scb_ap_output_transaction = decode_scb_ap_output_transaction_t::type_id::create("decode_scb_ap_output_transaction");
    //  UVMF_CHANGE_ME: Implement predictor model here.  
    //`uvm_info("UNIMPLEMENTED_PREDICTOR_MODEL", "******************************************************************************************************",UVM_NONE)
    //`uvm_info("UNIMPLEMENTED_PREDICTOR_MODEL", "UVMF_CHANGE_ME: The decode_predictor::write_decode_in_agent_ae function needs to be completed with DUT prediction model",UVM_NONE)
    //`uvm_info("UNIMPLEMENTED_PREDICTOR_MODEL", "******************************************************************************************************",UVM_NONE)
    decode_model_output = decode_model(.instr_dout(t.instruction), .npc_in(t.npc_in), .ir(decode_scb_ap_output_transaction.instruction), .npc_out(decode_scb_ap_output_transaction.npc_out), .e_control(decode_scb_ap_output_transaction.E_Control), .w_control(decode_scb_ap_output_transaction.W_Control), .mem_control(decode_scb_ap_output_transaction.Mem_Control));
    // Code for sending output transaction out through decode_scb_ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    if (decode_model_output == 0)
      decode_scb_ap.write(decode_scb_ap_output_transaction);
    // pragma uvmf custom decode_in_agent_ae_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

