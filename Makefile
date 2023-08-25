CORE := iob_uart
DISABLE_LINT:=1
include submodules/LIB/setup.mk

sim-build: clean
	rm -rf ../$(CORE)_V*
	make setup && make -C ../$(CORE)_V*/ sim-build

sim-run: clean
	rm -rf ../$(CORE)_V*
	make setup && make -C ../$(CORE)_V*/ sim-run

sim-waves:
	make -C ../$(CORE)_V*/ sim-waves

sim-test: clean
	rm -rf ../$(CORE)_V*
	make setup && make -C ../$(CORE)_V*/ sim-test


