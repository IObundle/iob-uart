# (c) 2022-Present IObundle, Lda, all rights reserved
#
# This make segment is used at setup-time by ./Makefile
# and at build-time by iob_cache_<version>/Makefile
#

# core name
NAME=iob_uart

# core version 
VERSION=0010

# top-level module for IOB backend interface
TOP_MODULE?=iob_uart

# root directory
UART_DIR ?= .

# supported simulator 
SIMULATOR ?= icarus

# supported FPGA board (compiles for the device therein)
# this component needs to be integrated in a system to actually run
BOARD ?= CYCLONEV-GT-DK
