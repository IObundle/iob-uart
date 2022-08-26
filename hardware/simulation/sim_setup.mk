#
# This file segment is included in LIB_DIR/Makefile
#

# copy simulation wrapper
SRC+=$(BUILD_SIM_DIR)/uart_tb.v
$(BUILD_SIM_DIR)/uart_tb.v: $(CORE_SIM_DIR)/uart_tb.v
	cp $< $(BUILD_SIM_DIR)
