UART_DIR:=../..
CORE_DIR:=$(UART_DIR)

DOXYGEN_CFG=Doxyfile
LATEX_DIR=latex
LATEX_MAKE=$(LATEX_DIR)/Makefile

LATEX_SRC=version.tex shortHash.tex

sw.pdf: clean-sw $(LATEX_MAKE) $(LATEX_SRC) figures
	make -C  $(LATEX_DIR) all
	cp $(LATEX_DIR)/refman.pdf $@
	cp $(LATEX_DIR)/refman.aux sw.aux
	make test.expected

test.expected: $(LATEX_DIR)/refman.aux
	cp $< $@

$(LATEX_MAKE): $(DOXYGEN_CFG)
	doxygen $(DOXYGEN_CFG)

$(DOXYGEN_CFG):
	@echo "Doxygen configuration file $(DOXYGEN_CFG) not found."
	@echo "Generating new doxygen configuration template..."
	@doxygen -g $(DOXYGEN_CFG)
	@make error

error:
	@$(error Edit $(DOXYGEN_CFG) and rerun make.)

clean-sw:
	@rm -rf $(LATEX_DIR)

NOCLEAN+=-name "Makefile" -o -name "test.expected" -o -name "sw.pdf" \
		 -o -name "Doxyfile" -o -name "iob_uart_footer.tex" \
		 -o -name "iob_uart_header.tex" -o -name "iob_uart_doxygen.sty" \
		 -o -name "sw.cls" -o -name "iob_uart_Layout.xml" \
		 -o -path "*examples/*"

figures:
	@cp $(LIB_DIR)/document/figures/Logo.png .

include $(UART_DIR)/document/document.mk

version.tex:
	echo $(VERSION) > $@

shortHash.tex:
	git rev-parse --short HEAD > $@

