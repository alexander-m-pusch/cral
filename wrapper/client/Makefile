GCC_FLAGS = -Wall -Wpedantic
LINKER_FLAGS = -L../../build/ -lcral
FILES = $(wildcard src/*)
OUTFILE = ../../build/client/cral

all:
	gcc $(GCC_FLAGS) $(DEFINE_FLAGS) $(LINKER_FLAGS) $(FILES) -o $(OUTFILE)
	chmod +x $(OUTFILE)

install:
	cp -v $(OUTFILE) /usr/local/bin/cral
