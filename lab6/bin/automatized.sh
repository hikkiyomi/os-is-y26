#!/bin/bash

# UNCOMMENT NEXT 4 RUNNERS IF USING 1 CPU CORES
# OTHERWISE COMMENT IT

# ./runner.sh run_calc_sequentially.sh ../group1/experiment1.log no
# ./runner.sh run_calc_concurrently.sh ../group1/experiment2.log no
# ./runner.sh run_files_sequentially.sh ../group2/experiment1.log yes
./runner.sh run_files_concurrently.sh ../group2/experiment2.log yes

# UNCOMMENT NEXT 4 RUNNERS IF USING 2 CPU CORES
# OTHERWISE COMMENT IT

# ./runner.sh run_calc_sequentially.sh ../group1/experiment3.log no
# ./runner.sh run_calc_concurrently.sh ../group1/experiment4.log no
# ./runner.sh run_files_sequentially.sh ../group2/experiment3.log yes
# ./runner.sh run_files_concurrently.sh ../group2/experiment4.log yes

