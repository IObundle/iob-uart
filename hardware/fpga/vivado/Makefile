FPGA_OBJ?=$(FPGA_FAMILY)/uart.edif
CONSTRAINTS:=$(wildcard *.xdc)

include ../fpga.mk
run: $(FPGA_OBJ)

clean: timer_clean_hw
	rm -rf $(FPGA_FAMILY) *.v *.vh

.PHONY: run clean
