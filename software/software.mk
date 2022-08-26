# (c) 2022-Present IObundle, Lda, all rights reserved
#
# This makefile segment lists all software header and source files 
#
# It is included in submodules/LIB/Makefile for populating the
# build directory
#

UART_SW_DIR:=$(UART_DIR)/software

#sources
SRC+=$(UART_SW_DIR)/iob-uart.c

HDR1=$(wildcard $(UART_DIR)/software/*.h)
SRC+=$(patsubst $(UART_DIR)/software/%,$(BUILD_SW_SRC_DIR)/%,$(HDR1))
$(BUILD_SW_SRC_DIR)/%.h: $(UART_DIR)/software/%.h
	cp $< $@
#
# Common Headers and Sources
#
#HEADERS
SRC+=$(BUILD_SW_SRC_DIR)/iob_uart_swreg.h
$(BUILD_SW_SRC_DIR)/iob_uart_swreg.h: iob_uart_swreg.h
	cp $< $@

#SOURCES

SRC1=$(wildcard $(UART_DIR)/software/*.c)
SRC+=$(patsubst $(UART_DIR)/software/%,$(BUILD_SW_SRC_DIR)/%,$(SRC1))
$(BUILD_SW_SRC_DIR)/%.c: $(UART_DIR)/software/%.c
	cp $< $@

#
# Embedded Sources
#
SRC+=$(BUILD_SW_SRC_DIR)/iob_uart_swreg_emb.c
SW_EMB_SRC+=$(BUILD_SW_SRC_DIR)/iob_uart_swreg_emb.c
$(BUILD_SW_SRC_DIR)/iob_uart_swreg_emb.c: iob_uart_swreg_emb.c
	cp $< $@

#
# PC Emul Sources
#
SRC+=$(BUILD_SW_SRC_DIR)/iob_uart_swreg_pc_emul.c
SW_PC_SRC+=$(BUILD_SW_SRC_DIR)/iob_uart_swreg_pc_emul.c
$(BUILD_SW_SRC_DIR)/iob_uart_swreg_pc_emul.c: $(UART_DIR)/software/pc-emul/iob_uart_swreg_pc_emul.c
	cp $< $@

#MKREGS
iob_uart_swreg.h iob_uart_swreg_emb.c: $(UART_DIR)/mkregs.conf
	./software/python/mkregs.py $(NAME) $(UART_DIR) SW
