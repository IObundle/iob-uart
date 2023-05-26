#!/usr/bin/env python3

import os
import sys

from iob_module import iob_module
from setup import setup

class iob_uart(iob_module):
    def __init__(self, **kwargs):
        super().__init__(
                name='iob_uart',
                version="V0.10",
                flows="sim emb doc",
                setup_dir=os.path.dirname(__file__),
                **kwargs
                )

    def setup(self, **kwargs):
        super().setup(**kwargs)

        self.setup_submodules()
        self.setup_confs()
        self.setup_ios()
        self.setup_regs()
        self.setup_block_groups()

        # Setup core using LIB function
        setup(self)


    def setup_submodules(self):
        submodules = {
            'hw_setup': {
                'headers' : [ 'iob_s_port', 'iob_s_portmap' ],
                'modules': [ 'iob_reg.v', 'iob_reg_e.v' ]
            },
        }

    def setup_confs(self):
        super().setup_confs([
            # Macros

            # Parameters
            {'name':'DATA_W',      'type':'P', 'val':'32', 'min':'NA', 'max':'NA', 'descr':"Data bus width"},
            {'name':'ADDR_W',      'type':'P', 'val':'`IOB_UART_SWREG_ADDR_W', 'min':'NA', 'max':'NA', 'descr':"Address bus width"},
            {'name':'UART_DATA_W', 'type':'P', 'val':'8', 'min':'NA', 'max':'8', 'descr':""}
        ])

    def setup_ios(self):
        self.ios += [
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

    def setup_regs(self):
        self.regs += [
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

    def setup_block_groups(self):
        self.block_groups += []
