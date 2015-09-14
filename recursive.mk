# Simple recursive Makefile
#
# This builds every direct subdirectory in the tree with a Makefile
#

MAKEABLE_DIRS := $(dir $(wildcard */Makefile))

.PHONY: all
all: $(MAKEABLE_DIRS)
	@echo > /dev/null

%/: force
	$(info Looking into $@)
	$(MAKE) -C $@

# A dummy rule to always build targets that depends on them
.PHONY: force
force:
	@true

