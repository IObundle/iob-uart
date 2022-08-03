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
include hardware/iob_reg/hardware.mk

UART_INC_DIR:=$(UART_DIR)/hardware/include
UART_SRC_DIR:=$(UART_DIR)/hardware/src

#HEADERS
VHDR+=$(subst $(UART_INC_DIR), $(BUILD_VSRC_DIR), $(wildcard $(UART_INC_DIR)/*.vh))
$(BUILD_VSRC_DIR)/%.vh: $(UART_INC_DIR)/%.vh
	cp $< $(BUILD_VSRC_DIR)

VHDR+=$(BUILD_VSRC_DIR)/iob_uart_swreg_gen.vh $(BUILD_VSRC_DIR)/iob_uart_swreg_def.vh
$(BUILD_VSRC_DIR)/iob_uart_swreg_gen.vh: iob_uart_swreg_gen.vh 
	cp $< $(BUILD_VSRC_DIR)

$(BUILD_VSRC_DIR)/iob_uart_swreg_def.vh: iob_uart_swreg_def.vh
	cp $< $(BUILD_VSRC_DIR)

iob_uart_swreg_def.vh iob_uart_swreg_gen.vh: $(UART_DIR)/mkregs.conf
	$(MKREGS) iob_uart $(UART_DIR) HW

VHDR+=$(BUILD_VSRC_DIR)/iob_lib.vh
VHDR+=$(BUILD_VSRC_DIR)/iob_s_if.vh
VHDR+=$(BUILD_VSRC_DIR)/iob_gen_if.vh
$(BUILD_VSRC_DIR)/%.vh: hardware/include/%.vh
	cp $< $(BUILD_VSRC_DIR)

#SOURCES
VSRC+=$(subst $(UART_SRC_DIR), $(BUILD_VSRC_DIR), $(wildcard $(UART_SRC_DIR)/*.v))
$(BUILD_VSRC_DIR)/%.v: $(UART_SRC_DIR)/%.v
	cp $< $(BUILD_VSRC_DIR)

endif
