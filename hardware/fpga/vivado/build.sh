#!/usr/bin/bash
TOP_MODULE="iob_uart"

export XILINXPATH=/opt/Xilinx
export LM_LICENSE_FILE=$LM_LICENSE_FILE:$XILINXPATH/Xilinx.lic
source /opt/Xilinx/Vivado/settings64.sh
#/Vivado/2020.2/settings64.sh

vivado -nojournal -log vivado.log -mode batch -source ../uart.tcl -tclargs "$TOP_MODULE" "$1" "$2" "$3" "$4"
