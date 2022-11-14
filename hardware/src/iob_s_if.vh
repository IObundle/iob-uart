           //CPU native interface
           //START_IO_TABLE iob_s
           `IOB_INPUT(iob_valid, 1),        //Native CPU interface valid signal.
           `IOB_INPUT(iob_addr, ADDR_W),      //Native CPU interface address signal.
           `IOB_INPUT(iob_wdata, DATA_W),   //Native CPU interface data write signal.
           `IOB_INPUT(iob_wstrb, DATA_W/8), //Native CPU interface write strobe signal.
           `IOB_OUTPUT(iob_rvalid, 1),   //Native CPU interface read data signal.
           `IOB_OUTPUT(iob_rdata, DATA_W),   //Native CPU interface read data signal.
           `IOB_OUTPUT(iob_ready, 1),        //Native CPU interface ready signal.
