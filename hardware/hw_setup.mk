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
include $(LIB_DIR)/hardware/iob_reg/hw_setup.mk
include $(LIB_DIR)/hardware/iob2axil/hw_setup.mk
include $(LIB_DIR)/hardware/axil2iob/hw_setup.mk

#generate software accessible register defines
SRC+=$(BUILD_VSRC_DIR)/iob_uart_swreg_inst.vh $(BUILD_VSRC_DIR)/iob_uart_swreg_def.vh
$(BUILD_VSRC_DIR)/iob_uart_swreg_%.vh: $(UART_DIR)/mkregs.toml
	$(LIB_DIR)/scripts/mkregs.py iob_uart $(UART_DIR) HW --out_dir $(BUILD_VSRC_DIR)
	

endif
