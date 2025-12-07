class test_store extends test_top;
    `uvm_component_utils(test_store);
    function new( string name = "", uvm_component parent = null );
   		super.new( name, parent );
  	endfunction
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
        
        lc3_bench_sequence_base::type_id::set_type_override(lc3_store_bench_sequence::type_id::get());
        
        inst_mem_responder_sequence::type_id::set_type_override(inst_mem_store_sequence::get_type());

	endfunction

    //virtual function void start_of_simulation_phase(uvm_phase phase);
    //    super.start_of_simulation_phase(phase);
	//    set_cycles_count(12300);
    //endfunction

endclass