//instantiate core in system

   //
   // UART
   //

   iob_uart uart
     (
      //RS232 interface
      .txd       (uart_txd),
      .rxd       (uart_rxd),
      .rts       (uart_rts),
      .cts       (uart_cts),
      
      //CPU interface
      .clk       (clk),
      .rst       (reset),
      .valid(slaves_req[`valid(`UART)]),
      .address(slaves_req[`address(`UART,`iob_uart_swreg_ADDR_W)]),
      .wdata(slaves_req[`wdata(`UART)]),
      .wstrb(slaves_req[`wstrb(`UART)]),
      .rdata(slaves_resp[`rdata(`UART)]),
      .ready(slaves_resp[`ready(`UART)])
      );
