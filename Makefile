#Makefile for cral

FILES = $(wildcard src/*.c)
INCLUDE = -Iinclude/
LIBRARIES = 
GCC_OPTIONS = -fPIC -shared -Wpedantic -Wall -Wl,--no-undefined

CLIENT_LIBRARIES = -lcral -lssh
SERVER_LIBRARIES = -lcral -lpthread -lssh

ifeq ($(shell getconf LONG_BIT), 64)
ARCHPREFIX = lib64
else
ARCHPREFIX = lib
endif

COMMAND = 

ifndef NO_LDCONFIG
COMMAND = ldconfig --verbose
endif

ifndef DESTDIR_LIBRARY
DESTDIR_LIBRARY = /usr/local/$(ARCHPREFIX)/
endif

ifndef DESTDIR_SERVER
DESTDIR_SERVER = /usr/local/bin/
endif

ifndef DESTDIR_CLIENT
DESTDIR_CLIENT = /usr/local/bin/
endif

COPYPATH = /usr/local/$(ARCHPREFIX)/libcral.so

all: library server client
.PHONY: all

library: 
	mkdir -p build/ 
	cc $(GCC_OPTIONS) $(INCLUDE) $(FILES) $(LIBRARIES) -o build/libcral.so

server: library
	mkdir -p build/server/
	$(MAKE) -C wrapper/server/

client: library
	mkdir -p build/client/
	$(MAKE) -C wrapper/client/

install-client: client
	cp -v build/client/cral $(DESTDIR_CLIENT)

install-server: server
	cp -v build/server/cralserver $(DESTDIR_SERVER)

install-library: library
	cp -v build/libcral.so $(DESTDIR_LIBRARY)
	$(COMMAND)

clean:
	rm -rf build/

install: install-client install-server install-library
.PHONY: install
