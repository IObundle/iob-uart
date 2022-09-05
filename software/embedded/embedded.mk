ifeq ($(filter UART, $(SW_MODULES)),)

SW_MODULES+=UART

# add embeded sources
SRC+=iob_uart_swreg_emb.c

iob_uart_swreg_emb.c: iob_uart_swreg.h
	

endif
