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

   wire [UART_DATA_W-1:0] TXDATA_wdata = iob_wdata[0+:UART_DATA_W];

   // TXDATA Manual logic
   wire [UART_DATA_W-1:0] TXDATA_o;
   iob_reg_e #(UART_DATA_W,0) TXDATA_datareg (clk_i, arst_i, cke_i, TXDATA_wen, TXDATA_wdata, TXDATA_o);
   assign TXDATA_ready = 1'b1;
   // RXDATA Manual logic
   assign RXDATA_ready = 1'b1;
   assign RXDATA_rvalid = 1'b1;

   uart_core uart_core0 
     (
      .clk_i(clk_i),
      .rst_i(arst_i),
      .rst_soft_i(SOFTRESET),
      .tx_en_i(TXEN),
      .rx_en_i(RXEN),
      .tx_ready_o(TXREADY),
      .rx_ready_o(RXREADY),
      .tx_data_i(TXDATA_o),
      .rx_data_o(RXDATA),
      .data_write_en_i(TXDATA_wen),
      .data_read_en_i(RXDATA_ren),
      .bit_duration_i(DIV),
      .rxd_i(rxd),
      .txd_o(txd),
      .cts_i(cts),
      .rts_o(rts)
      );
   
endmodule


