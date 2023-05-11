BUILD_DIR = ./build

$(shell mkdir -p $(BUILD_DIR))

KERNELS = ./kernels/gemm_asm_asimd_16_6_1.s
OBJ_FILES = $(patsubst kernels/%.s, $(BUILD_DIR)/%.o, $(KERNELS))

test: $(OBJ_FILES) driver.cpp
	g++ -g -pedantic -Wall -Wextra -Werror -O2 -fopenmp $^ -o $(BUILD_DIR)/driver