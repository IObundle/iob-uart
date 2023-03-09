#!/usr/bin/env python3

import os, sys
sys.path.insert(0, os.getcwd()+'/submodules/LIB/scripts')
import setup

name='iob_uart'
version='V0.10'
flows='sim emb'
if setup.is_top_module(sys.modules[__name__]):
    setup_dir=os.path.dirname(__file__)
    build_dir=f"../{name}_{version}"
submodules = {
    'hw_setup': {
        'headers' : [ 'iob_s_port', 'iob_s_portmap' ],
        'modules': [ 'iob_reg.v', 'iob_reg_e.v' ]
    },
}

confs = \
[
    # Macros

    # Parameters
    {'name':'DATA_W',      'type':'P', 'val':'32', 'min':'NA', 'max':'NA', 'descr':"Data bus width"},
    {'name':'ADDR_W',      'type':'P', 'val':'`IOB_UART_SWREG_ADDR_W', 'min':'NA', 'max':'NA', 'descr':"Address bus width"},
    {'name':'UART_DATA_W', 'type':'P', 'val':'8', 'min':'NA', 'max':'8', 'descr':""}
]

ios = \
[
    {'name': 'iob_s_port', 'descr':'CPU native interface', 'ports': [
    ]},
    {'name': 'general', 'descr':'GENERAL INTERFACE SIGNALS', 'ports': [
        {'name':"clk_i" , 'type':"I", 'n_bits':'1', 'descr':"System clock input"},
        {'name':"arst_i", 'type':"I", 'n_bits':'1', 'descr':"System reset, asynchronous and active high"},
        {'name':"cke_i" , 'type':"I", 'n_bits':'1', 'descr':"System reset, asynchronous and active high"}
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
        {'name':"SOFTRESET", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':-1, 'log2n_items':0, 'autologic':True, 'descr':"Soft reset."},
        {'name':"DIV", 'type':"W", 'n_bits':16, 'rst_val':0, 'addr':-1, 'log2n_items':0, 'autologic':True, 'descr':"Bit duration in system clock cycles."},
        {'name':"TXDATA", 'type':"W", 'n_bits':'UART_DATA_W', 'rst_val':0, 'addr':-1, 'log2n_items':0, 'autologic':False, 'descr':"TX data."},
        {'name':"TXEN", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':-1, 'log2n_items':0, 'autologic':True, 'descr':"TX enable."},
        {'name':"RXEN", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':6, 'log2n_items':0, 'autologic':True, 'descr':"RX enable."},
        {'name':"TXREADY", 'type':"R", 'n_bits':1, 'rst_val':0, 'addr':-1, 'log2n_items':0, 'autologic':True, 'descr':"TX ready to receive data."},
        {'name':"RXREADY", 'type':"R", 'n_bits':1, 'rst_val':0, 'addr':-1, 'log2n_items':0, 'autologic':True, 'descr':"RX data is ready to be read."},
        {'name':"RXDATA", 'type':"R", 'n_bits':'UART_DATA_W', 'rst_val':0, 'addr':4, 'log2n_items':0, 'autologic':False, 'descr':"RX data."},
    ]}
]

blocks = []

# Main function to setup this core and its components
def main():
    setup.setup(sys.modules[__name__])

if __name__ == "__main__":
    main()
