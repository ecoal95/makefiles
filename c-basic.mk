# Simple makefile for a generic C project
#
# This expects a src/main.c file as executable,
# and autodetects any other file under $(SRC_DIR).
#
# It expects those files to have a corresponding `.h` file
#
# Configure:
#  * OVERRIDE_CC: I prefer clang
#  * CC_FLAGS: Flags passed to the c compiler
#  * CC_LINKFLAGS: Flags passed to the linker
#  * EXECUTABLE_NAME: The name of the executable,
#	   which will go inside $(TARGET_DIR)
#  * {TARGET,BUILD,SRC}_DIR: Self-descriptive names

OVERRIDE_CC ?= clang
CC := $(OVERRIDE_CC)
CC_FLAGS := $(CC_FLAGS) -Wall -std=c99
CC_LINKFLAGS :=

EXECUTABLE_NAME := basic

TARGET_DIR := target
BUILD_DIR := build
SRC_DIR := src

SOURCES := $(wildcard $(SRC_DIR)/*.c) $(wildcard $(SRC_DIR)/**/*.c)
OBJECTS := $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SOURCES))

EXECUTABLE := $(TARGET_DIR)/$(EXECUTABLE_NAME)
EXECUTABLE_SOURCE := $(SRC_DIR)/main.c
EXECUTABLE_OBJ := $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(EXECUTABLE_SOURCE))

$(EXECUTABLE): $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) $(CC_FLAGS) $^ -o $@ $(CC_LINKFLAGS)

$(EXECUTABLE_OBJ): $(EXECUTABLE_SOURCE)
	@mkdir -p $(dir $@)
	$(CC) $(CC_FLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: src/%.c src/%.h
	@mkdir -p $(dir $@)
	$(CC) $(CC_FLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -r $(BUILD_DIR) $(TARGET_DIR)
