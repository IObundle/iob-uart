`timescale 1ns/1ps
`include "iob_lib.vh"
`include "iob_uart_conf.vh"
`include "iob_uart_swreg_def.vh"

module iob_uart # (
     `include "iob_uart_params.vh"
   ) (
     `include "iob_uart_io.vh"
   );
   
   //BLOCK Register File & Configuration control and status register file.
   `include "iob_uart_swreg_inst.vh"

   uart_core uart_core0 
     (
      .clk_i(clk_i),
      .rst_i(arst_i),
      .rst_soft_i(SOFTRESET),
      .tx_en_i(TXEN),
      .rx_en_i(RXEN),
      .tx_ready_o(TXREADY),
      .rx_ready_o(RXREADY),
      .tx_data_i(TXDATA),
      .rx_data_o(RXDATA),
      .data_write_en_i(iob_avalid & (| iob_wstrb) & (iob_addr == (`IOB_UART_TXDATA_ADDR))),
      .data_read_en_i(iob_avalid & !iob_wstrb & (iob_addr == (`IOB_UART_RXDATA_ADDR))),
      .bit_duration_i(DIV),
      .rxd_i(rxd),
      .txd_o(txd),
      .cts_i(cts),
      .rts_o(rts)
      );
   
endmodule


