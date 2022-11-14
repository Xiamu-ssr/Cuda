#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>

void solve(float *input, float *output);

__global__ void kernel(float* input, float* output);

