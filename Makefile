#Makefile for cral

FILES = $(wildcard src/*.c)
INCLUDE = -Iinclude/
LIBRARIES = 
GCC_OPTIONS = -fPIC -shared -Wpedantic -Wall -Wl,--no-undefined

ifeq ($(shell getconf LONG_BIT), 64)
ARCHPREFIX = lib64
else
ARCHPREFIX = lib
endif

COPYPATH = /usr/$(ARCHPREFIX)/libcral.so

wrapper:

server:

client:

all: 
	mkdir -p build/ 
	cc $(GCC_OPTIONS) $(INCLUDE) $(FILES) $(LIBRARIES) -o build/libcral.so

install: all
	if [ "$(id -u)" != "0" ]; then $(error Must be root to install!); fi
	cp -v build/libcral.so $(COPYPATH)
