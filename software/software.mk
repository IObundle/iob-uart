# (c) 2022-Present IObundle, Lda, all rights reserved
#
# This makefile segment lists all software header and source files 
#
# It is included in submodules/LIB/Makefile for populating the
# build directory
#

#sources
SRC+=$(subst $(UART_DIR)/software, $(BUILD_SW_SRC_DIR), $(wildcard $(UART_DIR)/software/*.c))
$(BUILD_SW_SRC_DIR)/%.c: $(UART_DIR)/software/%.c
	cp $< $@

SRC+=$(subst $(UART_DIR)/software, $(BUILD_SW_SRC_DIR), $(wildcard $(UART_DIR)/software/*.h))
$(BUILD_SW_SRC_DIR)/%.h: $(UART_DIR)/software/%.h
	cp $< $@

#sw accessible register headers
SRC+=$(BUILD_SW_SRC_DIR)/iob_uart_swreg.h $(BUILD_SW_SRC_DIR)/iob_uart_swreg_emb.c
$(BUILD_SW_SRC_DIR)/iob_uart_swreg.h: iob_uart_swreg.h
	cp $< $@

$(BUILD_SW_SRC_DIR)/iob_uart_swreg_emb.c: iob_uart_swreg_emb.c
	cp $< $@

iob_uart_swreg.h iob_uart_swreg_emb.c: $(UART_DIR)/mkregs.conf
	./software/python/mkregs.py $(NAME) $(UART_DIR) SW

# PC emul sources
SRC+=$(BUILD_SW_SRC_DIR)/iob_uart_swreg_pc_emul.c
SW_PC_SRC+=$(BUILD_SW_SRC_DIR)/iob_uart_swreg_pc_emul.c
$(BUILD_SW_SRC_DIR)/iob_uart_swreg_pc_emul.c: $(UART_DIR)/software/pc-emul/iob_uart_swreg_pc_emul.c
	cp $< $@
