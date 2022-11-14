#include "solve.h"

#define H 8192
#define WO 8192
#define WI 8194

void solve(float *input, float *output) 
{
    float *dev_input = NULL;
    cudaMalloc((void**)&dev_input, WI*H*sizeof(float));
    cudaMemcpy(dev_input, input, WI*H*sizeof(float),cudaMemcpyHostToDevice);
    int idx = 8190, j = 0;
    printf("origin=\n");
    for(int ki=0; ki<3; ++ki){
        for(int kj=0; kj<3; ++kj){
            printf("%.2lf  ",input[(idx+ki)*WI+j+kj]);
        }
        printf("\n");
    }

    float *dev_output = NULL;
    cudaMalloc((void**)&dev_output, WO*H*sizeof(float));
    kernel<<<128,64>>>(dev_input, dev_output);

    cudaMemcpy(output, dev_output, WO*H*sizeof(float),cudaMemcpyDeviceToHost);


}

__global__ void kernel(float* input, float* output){
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    for(int j=0; j<WO; ++j){
        float tmp = 0;
        for(int ki=0; ki<3; ++ki){
            for(int kj=0; kj<3; ++kj){
                tmp += input[(idx+ki)*WI+j+kj];
            }
        }
        if(idx*WO+j == 67092480){
            for(int ki=0; ki<3; ++ki){
                for(int kj=0; kj<3; ++kj){
                    printf("%.2lf  ",input[(idx+ki)*WI+j+kj]);
                }
                printf("\n");
            }
            printf("idx = [%d,%d]=%d tmp = %.2lf\n", idx, j, idx*WO+j, tmp);
        }
        output[idx*WO+j] = tmp / 9;
    }
}