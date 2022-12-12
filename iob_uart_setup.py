#!/usr/bin/env python3

import os, sys
sys.path.insert(0, os.getcwd()+'/submodules/LIB/scripts')
from setup import setup

top = 'iob_uart'
version = 'V0.10'

confs = \
[
    # Macros

    # Parameters
    {'name':'DATA_W',      'type':'P', 'val':'32', 'min':'NA', 'max':'NA', 'descr':"Data bus width"},
    {'name':'ADDR_W',      'type':'P', 'val':'`IOB_UART_SWREG_ADDR_W', 'min':'NA', 'max':'NA', 'descr':"Address bus width"},
    {'name':'UART_DATA_W', 'type':'P', 'val':'8', 'min':'NA', 'max':'NA', 'descr':""}
]

ios = \
[
    {'name': 'iob_s', 'descr':'CPU native interface', 'ports': [
        {'name':'iob_avalid', 'type':'I', 'n_bits':'1', 'descr':'CPU interface valid signal.'},
        {'name':'iob_addr', 'type':'I', 'n_bits':'ADDR_W', 'descr':'CPU interface address signal.'},
        {'name':'iob_wdata', 'type':'I', 'n_bits':'DATA_W', 'descr':'CPU interface data write signal.'},
        {'name':'iob_wstrb', 'type':'I', 'n_bits':'DATA_W/8', 'descr':'CPU interface write strobe signal.'},
        {'name':'iob_rvalid', 'type':'O', 'n_bits':'1', 'descr':'CPU interface read data signal.'},
        {'name':'iob_rdata', 'type':'O', 'n_bits':'DATA_W', 'descr':'CPU interface read data signal.'},
        {'name':'iob_ready', 'type':'O', 'n_bits':'1', 'descr':'CPU interface ready signal.'}
    ]},
    {'name': 'general', 'descr':'GENERAL INTERFACE SIGNALS', 'ports': [
        {'name':"clk_i", 'type':"I", 'n_bits':'1', 'descr':"System clock input"},
        {'name':"arst_i", 'type':"I", 'n_bits':'1', 'descr':"System reset, asynchronous and active high"},
        {'name':"en_i", 'type':"I", 'n_bits':'1', 'descr':"System reset, asynchronous and active high"}
    ]},
    {'name': 'rs232', 'descr':'Cache invalidate and write-trough buffer IO chain', 'ports': [
        #{'name':'interrupt', 'type':'O', 'n_bits':'1', 'descr':'be done'},
        {'name':'txd', 'type':'O', 'n_bits':'1', 'descr':'transmit line'},
        {'name':'rxd', 'type':'I', 'n_bits':'1', 'descr':'receive line'},
        {'name':'cts', 'type':'I', 'n_bits':'1', 'descr':'to send; the destination is ready to receive a transmission sent by the UART'},
        {'name':'rts', 'type':'O', 'n_bits':'1', 'descr':'to send; the UART is ready to receive a transmission from the sender.'}
    ]}
]

regs = \
[
    {'name': 'uart', 'descr':'UART software accessible registers.', 'regs': [
        {'name':"SOFTRESET", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':0, 'n_items':1, 'autologic':True, 'descr':"Soft reset."},
        {'name':"DIV", 'type':"W", 'n_bits':16, 'rst_val':0, 'addr':2, 'n_items':1, 'autologic':True, 'descr':"Bit duration in system clock cycles."},
        {'name':"TXDATA", 'type':"W", 'n_bits':'UART_DATA_W', 'rst_val':0, 'addr':4, 'n_items':1, 'autologic':True, 'descr':"TX data."},
        {'name':"TXEN", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':5, 'n_items':1, 'autologic':True, 'descr':"TX enable."},
        {'name':"TXREADY", 'type':"R", 'n_bits':1, 'rst_val':0, 'addr':6, 'n_items':1, 'autologic':True, 'descr':"TX ready to receive data."},
        {'name':"RXDATA", 'type':"R", 'n_bits':'UART_DATA_W', 'rst_val':0, 'addr':8, 'n_items':1, 'autologic':True, 'descr':"RX data."},
        {'name':"RXEN", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':10, 'n_items':1, 'autologic':True, 'descr':"RX enable."},
        {'name':"RXREADY", 'type':"R", 'n_bits':1, 'rst_val':0, 'addr':11, 'n_items':1, 'autologic':True, 'descr':"RX data is ready to be read."}
    ]}
]

blocks = []

if __name__ == "__main__":
    setup(top, version, confs, ios, regs, blocks)
