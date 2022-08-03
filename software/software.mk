UART_SW_DIR:=$(UART_DIR)/software

#include
INCLUDE+=-I$(UART_SW_DIR)

#headers
HDR+=$(UART_SW_DIR)/*.h iob_uart_swreg.h

#sources
SRC+=$(UART_SW_DIR)/iob-uart.c

iob_uart_swreg.h: 
	$(MKREGS) iob_uart $(UART_DIR) SW 
