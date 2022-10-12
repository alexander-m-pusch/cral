#Makefile for cral

FILES = $(wildcard src/*.c)
INCLUDE = -Iinclude/
LIBRARIES = 
GCC_OPTIONS = -fPIC -shared -Wpedantic -Wall -Wl,--no-undefined

all: 
	cc $(GCC_OPTIONS) $(INCLUDE) $(FILES) $(LIBRARIES) -o libcral.so

install: all
	cp
