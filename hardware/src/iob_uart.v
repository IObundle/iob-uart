`timescale 1ns/1ps
`include "iob_lib.vh"
`include "iob_uart_swreg_def.vh"

module iob_uart 
  # (
     parameter DATA_W = 32, //PARAM & 32 & 64 & CPU data width
     parameter ADDR_W = `iob_uart_swreg_ADDR_W //CPU address section width
     )

  (

   //CPU interface
`include "iob_s_if.vh"

   //additional inputs and outputs

   //START_IO_TABLE rs232
   //`IOB_OUTPUT(interrupt, 1), //to be done
   `IOB_OUTPUT(txd, 1), //Serial transmit line
   `IOB_INPUT(rxd, 1), //Serial receive line
   `IOB_INPUT(cts, 1), //Clear to send; the destination is ready to receive a transmission sent by the UART
   `IOB_OUTPUT(rts, 1), //Ready to send; the UART is ready to receive a transmission from the sender.
`include "iob_gen_if.vh"
   );

//BLOCK Register File & Configuration control and status register file.
`include "iob_uart_swreg_gen.vh"

// SWRegs

    `IOB_WIRE(UART_SOFTRESET, 1)
    iob_reg #(.DATA_W(1))
    uart_softreset (
        .clk        (clk),
        .arst       (rst),
        .arst_val   (1'b0),
        .rst        (rst),
        .rst_val    (1'b0),
        .en         (UART_SOFTRESET_en),
        .data_in    (UART_SOFTRESET_wdata[0]),
        .data_out   (UART_SOFTRESET)
    );

    `IOB_WIRE(UART_DIV, 16)
    iob_reg #(.DATA_W(16))
    uart_div (
        .clk        (clk),
        .arst       (rst),
        .arst_val   (16'b0),
        .rst        (rst),
        .rst_val    (16'b0),
        .en         (UART_DIV_en),
        .data_in    (UART_DIV_wdata),
        .data_out   (UART_DIV)
    );
   
    `IOB_WIRE(UART_TXDATA, 8)
    iob_reg #(.DATA_W(8))
    uart_txdata (
        .clk        (clk),
        .arst       (rst),
        .arst_val   (8'b0),
        .rst        (rst),
        .rst_val    (8'b0),
        .en         (UART_TXDATA_en),
        .data_in    (UART_TXDATA_wdata),
        .data_out   (UART_TXDATA)
    );
   
    `IOB_WIRE(UART_TXEN, 1)
    iob_reg #(.DATA_W(1))
    uart_txen (
        .clk        (clk),
        .arst       (rst),
        .arst_val   (1'b0),
        .rst        (rst),
        .rst_val    (1'b0),
        .en         (UART_TXEN_en),
        .data_in    (UART_TXEN_wdata[0]),
        .data_out   (UART_TXEN)
    );
   
    `IOB_WIRE(UART_RXEN, 1)
    iob_reg #(.DATA_W(1))
    uart_rxen (
        .clk        (clk),
        .arst       (rst),
        .arst_val   (1'b0),
        .rst        (rst),
        .rst_val    (1'b0),
        .en         (UART_RXEN_en),
        .data_in    (UART_RXEN_wdata[0]),
        .data_out   (UART_RXEN)
    );

    `IOB_WIRE2WIRE({(`UART_TXREADY_W-1){1'b0}}, UART_TXREADY_rdata[`UART_TXREADY_W-1:1])
    `IOB_WIRE2WIRE({(`UART_RXREADY_W-1){1'b0}}, UART_RXREADY_rdata[`UART_RXREADY_W-1:1])

   uart_core uart_core0 
     (
      .clk(clk),
      .rst(rst),
      .rst_soft(UART_SOFTRESET),
      .tx_en(UART_TXEN),
      .rx_en(UART_RXEN),
      .tx_ready(UART_TXREADY_rdata[0]),
      .rx_ready(UART_RXREADY_rdata[0]),
      .tx_data(UART_TXDATA),
      .rx_data(UART_RXDATA_rdata),
      .data_write_en(UART_TXDATA_en),
      .data_read_en(valid & !wstrb & (address == (`UART_RXDATA_ADDR >> 2))),
      .bit_duration(UART_DIV),
      .rxd(rxd),
      .txd(txd),
      .cts(cts),
      .rts(rts)
      );
   
endmodule


