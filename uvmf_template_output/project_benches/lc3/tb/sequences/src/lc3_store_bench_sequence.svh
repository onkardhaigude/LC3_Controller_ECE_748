class lc3_store_bench_sequence extends lc3_bench_sequence_base;
  `uvm_object_utils(lc3_store_bench_sequence)

  function new(string name = "lc3_store_bench_sequence");
    super.new(name);
    // pick a num_clocks that safely covers *your* store sequence length
    num_clocks = 25000; // example, adjust later
  endfunction
endclass
