#
# This file is included in BUILD_DIR/sim/Makefile
#

#tests
TEST_LIST+=test1
test1:
	make run SIMULATOR=icarus 

NOCLEAN+=-o -name "iob_uart_tb.v"
