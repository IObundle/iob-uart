# (c) 2022-Present IObundle, Lda, all rights reserved
#
# This makefile segment lists all software header and source files 
#
# It is included in submodules/LIB/Makefile for populating the
# build directory
#


#pc-emul generated sources
SRC+=$(BUILD_PSRC_DIR)/iob_uart_swreg.h
$(BUILD_PSRC_DIR)/iob_uart_swreg.h: iob_uart_swreg.h
	cp $< $@

#sw accessible register headers
SRC+=$(BUILD_ESRC_DIR)/iob_uart_swreg.h $(BUILD_ESRC_DIR)/iob_uart_swreg_emb.c

$(BUILD_ESRC_DIR)/iob_uart_swreg%: iob_uart_swreg%
	mv $< $@

iob_uart_swreg.h iob_uart_swreg_emb.c: $(UART_DIR)/mkregs.conf
	$(LIB_DIR)/scripts/mkregs.py iob_uart $(UART_DIR) SW
