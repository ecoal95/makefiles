# Simple makefile for a generic C++ project
#
# This expects a src/main.cpp file as executable,
# and autodetects any other files under $(SRC_DIR).
#
# It expects those files to have a corresponding `.h` file
#
# Configure:
#  * OVERRIDE_CXX: I prefer clang++
#  * CXX_FLAGS: Flags passed to the c compiler
#  * CXX_LINKFLAGS: Flags passed to the linker
#  * EXECUTABLE_NAME: The name of the executable,
#	   which will go inside $(TARGET_DIR)
#  * {TARGET,BUILD,SRC}_DIR: Self-descriptive names

OVERRIDE_CXX ?= clang++
CXX := $(OVERRIDE_CXX)
CXX_FLAGS := $(CXX_FLAGS) -Wall -std=c++11
CXX_LINKFLAGS :=

EXECUTABLE_NAME := basic

TARGET_DIR := target
BUILD_DIR := build
SRC_DIR := src

SOURCES := $(wildcard $(SRC_DIR)/*.cpp) $(wildcard $(SRC_DIR)/**/*.cpp)
OBJECTS := $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SOURCES))

EXECUTABLE := $(TARGET_DIR)/$(EXECUTABLE_NAME)
EXECUTABLE_SOURCE := $(SRC_DIR)/main.cpp
EXECUTABLE_OBJ := $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(EXECUTABLE_SOURCE))

$(EXECUTABLE): $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CXX) $(CXX_FLAGS) $^ -o $@ $(CXX_LINKFLAGS)

$(EXECUTABLE_OBJ): $(EXECUTABLE_SOURCE)
	@mkdir -p $(dir $@)
	$(CXX) $(CXX_FLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: src/%.cpp src/%.h
	@mkdir -p $(dir $@)
	$(CXX) $(CXX_FLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -r $(BUILD_DIR) $(TARGET_DIR)
