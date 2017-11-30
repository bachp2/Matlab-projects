#include <stdio.h>
#include "mex.h"
int hello_world()
{
    printf("Hello World\n");
    return 0;
}
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    hello_world();
}
