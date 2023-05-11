# HPC_week_5
## Homework for the 5th week

### 6. Assembly Building Blocks
#### 6.2 Small GEMM: ASIMD

##### 6.2.1 Implementation and verification
The verification of a working Kernel is implemented in `test.cpp`

##### 6.2.2 Optimization
In advance much thought was put into the implementation to realize good performance from the very beginning. The result was a peak performance of more than 26 GFLOPs which is already >40% of the theoretical peak performance. This may mostly be accredited to the fact that all computations where performed utilizing full vector registers and vector operations to accomplishing 8 (4 x addition, 4 x multiplication) operations in a single cycle for all operations. 
One optimization that happend later on was to use only non-callee safed registers that don't have to be saved before productive operations can take place. That way it was possible to squeeze out 31.1 GFLOPs which is almost 50% of the maximum peak performance. This also emphasizes that loads and stores to memory are expensive operations that should be avoided if possible.