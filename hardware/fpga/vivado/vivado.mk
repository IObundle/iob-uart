FPGA_OBJ=iob_uart.edif
FPGA_LOG=vivado.log

CLKBUF_WRAPPER:=xilinx
CONSTRAINTS:=$(wildcard *.xdc)

FPGA_SERVER=$(VIVADO_SERVER)
FPGA_USER=$(VIVADO_USER)

include ../../fpga.mk

ENV:= $(VIVADOPATH)/settings64.sh

$(FPGA_OBJ): $(VSRC) $(VHDR)
	$(ENV); vivado -nojournal -log vivado.log -mode batch -source ../uart.tcl -tclargs $(TOP_MODULE) "$(VSRC)" "$(INCLUDE)" "$(DEFINE)" $(FPGA_PART)
