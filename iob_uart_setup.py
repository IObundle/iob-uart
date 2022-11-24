#!/usr/bin/env python3

import os, sys
sys.path.insert(0, os.getcwd()+'/submodules/LIB/scripts')
from setup import setup

top = 'iob_uart'
version = 'V0.10'

confs = \
[
    {'name':'DATA_W', 'type':'P', 'val':'32', 'min':'1', 'max':'NA'},
    {'name':'ADDR_W', 'type':'P', 'val':'`IOB_UART_SWREG_ADDR_W', 'min':'1', 'max':'NA'},
    {'name':'UART_DATA_W', 'type':'P', 'val':'8', 'min':'1', 'max':'NA'}
]

ios = \
[]

regs = \
[
    {'name': 'uart', 'descr':'UART software accessible registers.', 'regs': [
        {'name':"SOFTRESET", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':-1, 'n_items':1, 'autologic':True, 'descr':"Soft reset."},
        {'name':"DIV", 'type':"W", 'n_bits':16, 'rst_val':0, 'addr':-1, 'n_items':1, 'autologic':True, 'descr':"Bit duration in system clock cycles."},
        {'name':"TXDATA", 'type':"W", 'n_bits':'UART_DATA_W', 'rst_val':0, 'addr':-1, 'n_items':1, 'autologic':True, 'descr':"TX data."},
        {'name':"TXEN", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':-1, 'n_items':1, 'autologic':True, 'descr':"TX enable."},
        {'name':"TXREADY", 'type':"R", 'n_bits':1, 'rst_val':0, 'addr':-1, 'n_items':1, 'autologic':True, 'descr':"TX ready to receive data."},
        {'name':"RXDATA", 'type':"R", 'n_bits':'UART_DATA_W', 'rst_val':0, 'addr':-1, 'n_items':1, 'autologic':True, 'descr':"RX data."},
        {'name':"RXEN", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':-1, 'n_items':1, 'autologic':True, 'descr':"RX enable."},
        {'name':"RXREADY", 'type':"R", 'n_bits':1, 'rst_val':0, 'addr':-1, 'n_items':1, 'autologic':True, 'descr':"RX data is ready to be read."}
    ]}
]

blocks = []

setup(top, version, confs, ios, regs, blocks)