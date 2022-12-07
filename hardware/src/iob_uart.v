`timescale 1ns/1ps
`include "iob_lib.vh"
`include "iob_uart_conf.vh"
`include "iob_uart_swreg_def.vh"

module iob_uart 
  # (
     `include "iob_uart_params.vh"
     )

  (

   //CPU native interface
   //START_IO_TABLE iob_s
   `IOB_INPUT(iob_avalid, 1),        //Native CPU interface valid signal.
   `IOB_INPUT(iob_addr, ADDR_W),      //Native CPU interface address signal.
   `IOB_INPUT(iob_wdata, DATA_W),   //Native CPU interface data write signal.
   `IOB_INPUT(iob_wstrb, DATA_W/8), //Native CPU interface write strobe signal.
   `IOB_OUTPUT(iob_rvalid, 1),   //Native CPU interface read data signal.
   `IOB_OUTPUT(iob_rdata, DATA_W),   //Native CPU interface read data signal.
   `IOB_OUTPUT(iob_ready, 1),        //Native CPU interface ready signal.

   //additional inputs and outputs

   //START_IO_TABLE rs232
   //`IOB_OUTPUT(interrupt, 1), //to be done
   `IOB_OUTPUT(txd, 1), //Serial transmit line
   `IOB_INPUT(rxd, 1), //Serial receive line
   `IOB_INPUT(cts, 1), //Clear to send; the destination is ready to receive a transmission sent by the UART
   `IOB_OUTPUT(rts, 1), //Ready to send; the UART is ready to receive a transmission from the sender.
`include "iob_clkrst_port.vh"
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
      .data_write_en_i(iob_avalid & (| iob_wstrb) & (iob_addr == (`IOB_UART_RXDATA_ADDR >> 2))),
      .data_read_en_i(iob_avalid & !iob_wstrb & (iob_addr == (`IOB_UART_RXDATA_ADDR >> 2))),
      .bit_duration_i(DIV),
      .rxd_i(rxd),
      .txd_o(txd),
      .cts_i(cts),
      .rts_o(rts)
      );
   
endmodule


