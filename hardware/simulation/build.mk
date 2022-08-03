#
# This file segment is included in LIB_DIR/Makefile
#

# copy simulation wrapper
VSRC+=$(BUILD_VSRC_DIR)/uart_tb.v
$(BUILD_VSRC_DIR)/uart_tb.v: $(CORE_SIM_DIR)/uart_tb.v
	cp $< $(BUILD_VSRC_DIR)
