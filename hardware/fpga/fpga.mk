include $(UART_DIR)/hardware/hardware.mk

#this dummy define is necessary to prevent passing empty arguments to tcl script
DEFINE+=$(defmacro)DUMMY

TOOL=$(shell find $(UART_HW_DIR)/fpga -name $(FPGA_FAMILY) | cut -d"/" -f7)

build: $(FPGA_OBJ)

$(FPGA_OBJ): $(CONSTRAINTS) $(VSRC) $(VHDR)
ifeq ($(FPGA_SERVER),)
	../build.sh "$(TOP_MODULE)" "$(VSRC)" "$(INCLUDE)" "$(DEFINE)" "$(FPGA_PART)"
	make post-build
else 
	ssh $(FPGA_USER)@$(FPGA_SERVER) "if [ ! -d $(REMOTE_ROOT_DIR) ]; then mkdir -p $(REMOTE_ROOT_DIR); fi"
	rsync -avz --delete --exclude .git $(UART_DIR) $(FPGA_USER)@$(FPGA_SERVER):$(REMOTE_ROOT_DIR)
	ssh $(FPGA_USER)@$(FPGA_SERVER) 'cd $(REMOTE_ROOT_DIR); make fpga-build FPGA_FAMILY=$(FPGA_FAMILY)'
	scp $(FPGA_USER)@$(FPGA_SERVER):$(REMOTE_ROOT_DIR)/hardware/fpga/$(TOOL)/$(FPGA_FAMILY)/$(FPGA_OBJ) $(FPGA_DIR)
	scp $(FPGA_USER)@$(FPGA_SERVER):$(REMOTE_ROOT_DIR)/hardware/fpga/$(TOOL)/$(FPGA_FAMILY)/$(FPGA_LOG) $(FPGA_DIR)

endif


clean:
	find . -type f -not -name 'Makefile' -delete
ifneq ($(FPGA_SERVER),)
	rsync -avz --delete --exclude .git $(UART_DIR) $(FPGA_USER)@$(FPGA_SERVER):$(REMOTE_ROOT_DIR)
	ssh $(FPGA_USER)@$(FPGA_SERVER) 'cd $(REMOTE_ROOT_DIR); make fpga-clean FPGA_FAMILY=$(FPGA_FAMILY)'
endif


.PHONY: build clean
