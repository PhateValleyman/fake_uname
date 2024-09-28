# Makefile for fake_uname project

# Compiler
CC = gcc

# Source and target
SRC = fake_uname.c
TARGET = fake_uname.so

# Default prefix paths based on architecture
PREFIX_AARCH64 = /data/data/com.termux/files/usr
PREFIX_ARM = /ffp

# Default install path (to be set dynamically)
PREFIX = $(PREFIX_AARCH64)

# Check the architecture and set the correct prefix
ARCH := $(shell uname -m)
ifeq ($(ARCH), aarch64)
    PREFIX = $(PREFIX_AARCH64)
else ifeq ($(ARCH), armv5te)
    PREFIX = $(PREFIX_ARM)
else ifeq ($(ARCH), arm)
    PREFIX = $(PREFIX_ARM)
endif

# Compiler flags for building shared library
CFLAGS = -shared -fPIC -ldl

# Install path for the shared object
INSTALL_PATH = $(PREFIX)/lib

# Default action: show help if no target is selected
.PHONY: default
default: help

# Help target: displays usage instructions
.PHONY: help
help:
	@echo "Usage: make [OPTION]"
	@echo ""
	@echo "Options:"
	@echo "  build      Build the shared library"
	@echo "  install    Build and install the library to the appropriate path"
	@echo "  clean      Remove the compiled files"
	@echo "  help       Show this help message"

# Build the shared library (compilation only)
.PHONY: build
build: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC)
	@echo "Build complete: $(TARGET)"

# Install the shared library to the appropriate prefix
.PHONY: install
install: build
	mkdir -p $(INSTALL_PATH)
	cp $(TARGET) $(INSTALL_PATH)
	@echo "Successfully installed to $(INSTALL_PATH)/$(TARGET)"
	@echo "To use the library, run:"
	@echo "export LD_PRELOAD=$(INSTALL_PATH)/$(TARGET)"

# Clean up
.PHONY: clean
clean:
	rm -f $(TARGET)
	@echo "Cleaned up: $(TARGET)"
