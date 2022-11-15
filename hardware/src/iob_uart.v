`timescale 1ns/1ps
`include "iob_lib.vh"
`include "iob_uart_swreg_def.vh"

module iob_uart 
  # (
     parameter DATA_W = 32, //PARAM & 32 & 64 & CPU data width
     parameter ADDR_W = `IOB_UART_SWREG_ADDR_W //CPU address section width
     )

  (

   //CPU native interface
   //START_IO_TABLE iob_s
   `IOB_INPUT(iob_valid, 1),        //Native CPU interface valid signal.
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
      .clk(clk_i),
      .rst(rst_i),
      .rst_soft(UART_SOFTRESET),
      .tx_en(UART_TXEN),
      .rx_en(UART_RXEN),
      .tx_ready(UART_TXREADY),
      .rx_ready(UART_RXREADY),
      .tx_data(UART_TXDATA),
      .rx_data(UART_RXDATA),
      .data_write_en(iob_valid & (| iob_wstrb) & (iob_addr == (`IOB_UART_UART_RXDATA_ADDR >> 2))),
      .data_read_en(iob_valid & !iob_wstrb & (iob_addr == (`IOB_UART_UART_RXDATA_ADDR >> 2))),
      .bit_duration(UART_DIV),
      .rxd(rxd),
      .txd(txd),
      .cts(cts),
      .rts(rts)
      );
   
endmodule


