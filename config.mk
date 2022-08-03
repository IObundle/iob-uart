SHELL:=/bin/bash

TOP_MODULE=iob_uart

#PATHS
REMOTE_ROOT_DIR ?=sandbox/iob-uart

UART_HW_DIR:=$(UART_DIR)/hardware
SIM_DIR ?=$(UART_HW_DIR)/simulation
LIB_DIR ?=$(UART_DIR)/submodules/LIB

#MAKE SW ACCESSIBLE REGISTER
MKREGS:=$(shell find $(LIB_DIR) -name mkregs.py)

# default target
default: sim

# VERSION
VERSION ?=V0.1
$(TOP_MODULE)_version.txt:
	echo $(VERSION) > version.txt

#cpu accessible registers
iob_uart_swreg_def.vh iob_uart_swreg_gen.vh: $(UART_DIR)/mkregs.conf
	$(MKREGS) iob_uart $(UART_DIR) HW

uart-gen-clean:
	@rm -rf *# *~ version.txt

.PHONY: default uart-gen-clean
