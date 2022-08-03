UART_DIR:=.
include config.mk

#
# SIMULATE
#
VCD ?=0

sim:
	make -C $(SIM_DIR) run

sim-test:
	make -C $(SIM_DIR) test

sim-clean:
	make -C $(SIM_DIR) clean-all


#
# TEST ON SIMULATORS AND BOARDS
#

test-sim:
	make sim-test

test-sim-clean:
	make sim-clean

test: test-clean test-sim

test-clean: test-sim-clean

#
# CLEAN ALL
# 

clean-all: uart-gen-clean sim-clean


debug:
	@echo $(SIM_DIR)

.PHONY: sim sim-test sim-clean \
	test-sim test-sim-clean \
	test test-clean \
	clean-all debug


