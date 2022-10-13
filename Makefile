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
	if [ "$(id -u") != "0" ]; then $(error Must be root to install!); fi
	cp -v build/client/cral /usr/local/bin/cral

install-server: server
	if [ "$(id -u)" != "0" ]; then $(error Must be root to install!); fi
	cp -v build/server/cralserver /usr/local/bin/cralserver

install-library: library
	if [ "$(id -u)" != "0" ]; then $(error Must be root to install!); fi
	cp -v build/libcral.so $(COPYPATH)
	ldconfig

clean:
	rm -rf build/

install: install-client install-server install-library
.PHONY: install
