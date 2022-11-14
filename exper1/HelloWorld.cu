#include <stdio.h>
#include <cuda_runtime.h>

__global__ void kernel(void){

}

int main(){

    kernel<<<1,32>>>();
    return 0;
}