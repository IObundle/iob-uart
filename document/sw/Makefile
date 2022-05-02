UART_DIR:=../..
include $(UART_DIR)/config.mk

SW_PDF=IOb_UART_SW_Drivers.pdf
DOXYGEN_CFG=Doxyfile
LATEX_DIR=latex
LATEX_MAKE=$(LATEX_DIR)/Makefile

all: clean $(SW_PDF)

$(SW_PDF): $(LATEX_MAKE)
	make -C  $(LATEX_DIR) all
	cp $(LATEX_DIR)/refman.pdf $(SW_PDF)

$(LATEX_MAKE): $(DOXYGEN_CFG)
	doxygen $(DOXYGEN_CFG)

$(DOXYGEN_CFG):
	@echo "Doxygen configuration file $(DOXYGEN_CFG) not found."
	@echo "Generating new doxygen configuration template..."
	@doxygen -g $(DOXYGEN_CFG)
	@make error

error:
	@$(error Edit $(DOXYGEN_CFG) and rerun make.)

clean:
	@rm -rf $(LATEX_DIR)

.PHONY: clean
