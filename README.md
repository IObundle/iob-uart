# README #

## What is this repository for? ##

The IObundle UART is a RISC-V-based Peripheral written in Verilog, which users
can download for free, modify, simulate and implement in FPGA or ASIC. It is
written in Verilog and includes a C software driver.  The IObundle UART is a
very compact IP that works at high clock rates if needed. It supports
full-duplex operation and a configurable baud rate. The IObundle UART has a
fixed configuration for the Start and Stop bits. More flexible licensable
commercial versions are available upon request.

## Simulate

Install the latest stable version of the open-source Verilog simulator Icarus Verilog.

To simulate type:
```
make setup
make -C iob_uart_V0.10/ sim-run
```

To clean the simulation generated files:
```
make -C iob_uart_V0.10/ sim-clean
```

## Testing

### Simulation test

To run a series of simulation tests, type:

```
make setup
make -C iob_uart_V0.10/ sim-test
```

The above command produces a test log file called `test.log` in the simulator's
directory. The `test.log` file is compared with the `test.expected` file, which
resides in the same directory; if they differ, the test fails; otherwise, it
passes.

To clean the files produced when testing all simulators, type:

```
make -C iob_uart_V0.10/ sim-clean
```

## Integrate in SoC ##

* Check out [IOb-SoC](https://github.com/IObundle/iob-soc)

## Clean all generated files ##
To clean all generated files, the command is simply
```
make clean
```
