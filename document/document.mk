include $(UART_DIR)/config.mk
TOP_MODULE:=iob_uart

RESULTS=1

#results for intel fpga
INT_FAMILY ?=CYCLONEV-GT
#results for xilinx fpga
XIL_FAMILY ?=XCKU


#PREPARE TO INCLUDE TEX SUBMODULE MAKEFILE SEGMENT
#root directory
CORE_DIR:=$(UART_DIR)

#export definitions
export DEFINE

VHDR+=$(LIB_DIR)/hardware/include/iob_gen_if.vh
VHDR+=$(LIB_DIR)/hardware/include/iob_s_if.vh

#INCLUDE TEX SUBMODULE MAKEFILE SEGMENT
include $(LIB_DIR)/document/document.mk

test: clean $(DOC).pdf
	diff -q $(DOC).aux test.expected

debug:
	echo $(TOP_MODULE) $(VHDR)

NOCLEAN+=-o -name "test.expected" -o -name "Makefile"
.PHONY: test debug
