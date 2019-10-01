SRCDIR=$(abspath ${HOME}/Movies)

SHELL:=/bin/bash -O globstar
# Find is not compatible with patsubst
#SOURCE=$(shell find ${SRCDIR} -type f -name '*.mkv' -print)
SOURCE=$(shell ls ${SRCDIR}/raw/**/*.mkv)

TARGETS=$(subst /raw/,/output/,${SOURCE})

default: $(TARGETS)

$(TARGETS): SRC=$(subst /output/,/raw/,$@)
$(TARGETS): $(subst /output/,/raw/,$@)
	mkdir -p $(shell dirname $@)
	nice -n 19 HandBrakeCLI --preset-import-file dvd-ac3.json \
		-Z "dvd-ac3" \
		-i ${SRC} -o $@
