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
//   control_in_ae receives transactions of type  control_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  control_out_sb_ap broadcasts transactions of type control_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class control_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  )
 extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( control_predictor #(
                              CONFIG_T,
                              BASE_T
                              )
)


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_control_in_ae #(control_in_transaction, control_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )
) control_in_ae;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(control_out_transaction) control_out_sb_ap;


  // Transaction variable for predicted values to be sent out control_out_sb_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef control_out_transaction control_out_sb_ap_output_transaction_t;
  control_out_sb_ap_output_transaction_t control_out_sb_ap_output_transaction;
  // Code for sending output transaction out through control_out_sb_ap
  // control_out_sb_ap.write(control_out_sb_ap_output_transaction);

  // Define transaction handles for debug visibility 
  control_in_transaction control_in_ae_debug;


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

    control_in_ae = new("control_in_ae", this);
    control_out_sb_ap =new("control_out_sb_ap", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  bit control_model_output;
  // FUNCTION: write_control_in_ae
  // Transactions received through control_in_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_control_in_ae(control_in_transaction t);
    // pragma uvmf custom control_in_ae_predictor begin
    control_in_ae_debug = t;
    //`uvm_info("PRED", "Transaction Received through control_in_ae", UVM_MEDIUM)
    //`uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    control_out_sb_ap_output_transaction = control_out_sb_ap_output_transaction_t::type_id::create("control_out_sb_ap_output_transaction");
    control_model_output = controller_model( .complete_data( t.complete_data ), .complete_instr( t.complete_instr ), .IR( t.IR ), .psr( t.psr ), .IR_Exec( t.IR_Exec ), .IMem_dout( t.IMem_dout ), .NZP ( t.NZP ), .enable_updatePC( control_out_sb_ap_output_transaction.enable_updatePC ), .enable_fetch( control_out_sb_ap_output_transaction.enable_fetch ), .enable_decode( control_out_sb_ap_output_transaction.enable_decode ), .enable_execute( control_out_sb_ap_output_transaction.enable_execute ), .enable_writeback( control_out_sb_ap_output_transaction.enable_writeback ), .bypass_alu_1( control_out_sb_ap_output_transaction.bypass_alu_1 ), .bypass_alu_2( control_out_sb_ap_output_transaction.bypass_alu_2 ), .bypass_mem_1( control_out_sb_ap_output_transaction.bypass_mem_1 ), .bypass_mem_2( control_out_sb_ap_output_transaction.bypass_mem_2 ), .mem_state( control_out_sb_ap_output_transaction.mem_state ), .br_taken( control_out_sb_ap_output_transaction.br_taken )); 
    //  UVMF_CHANGE_ME: Implement predictor model here.  
    //`uvm_info("UNIMPLEMENTED_PREDICTOR_MODEL", "******************************************************************************************************",UVM_NONE)
    //`uvm_info("UNIMPLEMENTED_PREDICTOR_MODEL", "UVMF_CHANGE_ME: The control_predictor::write_control_in_ae function needs to be completed with DUT prediction model",UVM_NONE)
    //`uvm_info("UNIMPLEMENTED_PREDICTOR_MODEL", "******************************************************************************************************",UVM_NONE)
 
    // Code for sending output transaction out through control_out_sb_ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    if (control_model_output == 0)
      control_out_sb_ap.write(control_out_sb_ap_output_transaction);
    // pragma uvmf custom control_in_ae_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

