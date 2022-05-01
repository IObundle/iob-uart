include $(UART_DIR)/hardware/hardware.mk

#this dummy define is necessary to prevent passing empty arguments to tcl script
DEFINE+=$(defmacro)DUMMY

TOOL=$(shell find $(UART_HW_DIR)/fpga -name $(FPGA_FAMILY) | cut -d"/" -f7)

build: 
ifeq ($(FPGA_SERVER),)
	make $(FPGA_OBJ)
else 
	ssh $(FPGA_USER)@$(FPGA_SERVER) "if [ ! -d $(REMOTE_ROOT_DIR) ]; then mkdir -p $(REMOTE_ROOT_DIR); fi"
	rsync -avz --delete --exclude .git $(UART_DIR) $(FPGA_USER)@$(FPGA_SERVER):$(REMOTE_ROOT_DIR)
	ssh $(FPGA_USER)@$(FPGA_SERVER) 'cd $(REMOTE_ROOT_DIR); make fpga-build FPGA_FAMILY=$(FPGA_FAMILY)'
	scp $(FPGA_USER)@$(FPGA_SERVER):$(REMOTE_ROOT_DIR)/hardware/fpga/$(TOOL)/$(FPGA_FAMILY)/$(FPGA_OBJ) .
	scp $(FPGA_USER)@$(FPGA_SERVER):$(REMOTE_ROOT_DIR)/hardware/fpga/$(TOOL)/$(FPGA_FAMILY)/$(FPGA_LOG) .
endif

test: clean-all
	make build TEST_LOG=">> test.log"

#clean test log only when board testing begins
clean-testlog:
	@rm -f test.log

clean: uart-hw-clean
	find . -type f -not  \( -name 'Makefile' -o -name 'test.expected' -o -name 'test.log' \) -delete
ifneq ($(FPGA_SERVER),)
	rsync -avz --delete --exclude .git $(UART_DIR) $(FPGA_USER)@$(FPGA_SERVER):$(REMOTE_ROOT_DIR)
	ssh $(FPGA_USER)@$(FPGA_SERVER) 'cd $(REMOTE_ROOT_DIR); make fpga-clean FPGA_FAMILY=$(FPGA_FAMILY)'
endif

clean-all: clean-testlog clean

.PHONY: build test clean-testlog clean clean-all
