rm *.ucdb

make clean
make cli TEST_NAME=test_load TEST_SEED=64234324
make run_cli TEST_NAME=test_store TEST_SEED=64234323
make run_cli TEST_NAME=br_jmp_test TEST_SEED=64234325
make run_cli TEST_NAME=alu_directed_test TEST_SEED=64234310

make merge_test_coverage
make merge_all_coverage
make report_coverage
make view_coverage
