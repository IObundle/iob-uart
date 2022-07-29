include $(UART_DIR)/config.mk

#import lib hardware
include hardware/iob_reg/hardware.mk

#
# Headers
#

#clk/rst interface
VHDR+=$(BUILD_VSRC_DIR)/iob_gen_if.vh
$(BUILD_VSRC_DIR)/iob_gen_if.vh: hardware/include/iob_gen_if.vh
	cp $< $@

#IObundle native slave interface
VHDR+=$(BUILD_VSRC_DIR)/iob_gen_if.vh
$(BUILD_VSRC_DIR)/iob_s_if.vh: hardware/include/iob_s_if.vh
	cp $< $@

VHDR+=$(BUILD_VSRC_DIR)/iob_uart_swreg_gen.vh
$(BUILD_VSRC_DIR)/iob_uart_swreg_gen.vh: iob_uart_swreg_gen.vh
	cp $< $@

VHDR+=$(BUILD_VSRC_DIR)/iob_uart_swreg_def.vh
$(BUILD_VSRC_DIR)/iob_uart_swreg_def.vh: iob_uart_swreg_def.vh
	cp $< $@

#
# Sources
#

VSRC+=$(BUILD_VSRC_DIR)/uart_core.v
$(BUILD_VSRC_DIR)/uart_core.v: $(UART_DIR)/hardware/src/uart_core.v
	cp $< $@

VSRC+=$(BUILD_VSRC_DIR)/iob_uart.v
$(BUILD_VSRC_DIR)/iob_uart.v: $(UART_DIR)/hardware/src/iob_uart.v
	cp $< $@
