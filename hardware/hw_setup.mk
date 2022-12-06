# (c) 2022-Present IObundle, Lda, all rights reserved
#
# This makefile segment lists all hardware header and source files 
#
# It is always included in submodules/LIB/Makefile for populating the
# build directory
#
ifeq ($(filter UART, $(HW_MODULES)),)

#add itself to HW_MODULES list
HW_MODULES+=UART

#import lib hardware
include $(LIB_DIR)/hardware/include/hw_setup.mk
include $(LIB_DIR)/hardware/reg/iob_reg_a/hw_setup.mk
include $(LIB_DIR)/hardware/iob2axil/hw_setup.mk
include $(LIB_DIR)/hardware/axil2iob/hw_setup.mk
include $(LIB_DIR)/hardware/iob_wstrb2byte_offset/hw_setup.mk

# copy verilog sources
SRC+=$(patsubst $(UART_DIR)/hardware/src/%, $(BUILD_VSRC_DIR)/%, $(wildcard $(UART_DIR)/hardware/src/*))
$(BUILD_VSRC_DIR)/%: $(UART_DIR)/hardware/src/%
	cp $< $@

endif
