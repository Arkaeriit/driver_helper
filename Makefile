
all: driver-helper

INSTALL_DIR := /usr/local/bin

driver-helper: objsrc/driver_helper.c
	gcc $< -Os -fdata-sections -fdata-sections -Wl,--gc-sections -o $@

objsrc/driver_helper.c: | driver_helper.nelua
	mkdir -p objsrc
	nelua --generate-code -o $@ driver_helper.nelua

clean:
	rm -f driver-helper

purge: clean
	rm -f objsrc/driver_helper.c

full_compilation: purge
	$(MAKE) driver-helper

install: | driver-helper
	cp -f driver-helper $(INSTALL_DIR)/driver-helper

uninstall:
	rm -f $(INSTALL_DIR)/driver-helper

