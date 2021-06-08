//START_TABLE sw_reg
`SWREG_W(UART_SOFTRESET, 1, 0) //Bit duration in system clock cycles.
`SWREG_W(UART_DIV, 16, 0) //Bit duration in system clock cycles.
`SWREG_W(UART_TXDATA, 8, 0) //TX data
`SWREG_W(UART_TXEN, 1, 0) //TX enable.
`SWREG_R(UART_TXREADY, 1, 0) //TX ready to receive data
`SWREG_R(UART_RXDATA, 8, 0) //RX data
`SWREG_W(UART_RXEN, 1, 0) //RX enable.
`SWREG_R(UART_RXREADY, 1, 0) //RX data is ready to be read.
