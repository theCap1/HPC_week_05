        .text
        .type gemm_asm_asimd_16_6_1, %function
        .global gemm_asm_asimd_16_6_1
        /*
         * Performs the matrix-multiplication C+=A*B
         * with the shapes (16x6) = (16x1) * (1x6).
         * The input-data is of type float.
         *
         * @param x0 pointer to A.
         * @param x1 pointer to B.
         * @param x2 pointer to C.
         */ 
gemm_asm_asimd_16_6_1:
        // store
        // SIMD callee registers
        stp x19, x20, [sp, #-16]!       // Save X19 and X20 on the stack
        stp x21, x22, [sp, #-16]!       // Save X21 and X22 on the stack
        stp x23, x24, [sp, #-16]!       // Save X23 and X24 on the stack
        stp x25, x26, [sp, #-16]!       // Save X25 and X26 on the stack
        stp x27, x28, [sp, #-16]!       // Save X27 and X28 on the stack
        stp x29, x30, [sp, #-16]!       // Save X29 and X30 on the stack

        // ASIMD callee saved registers
        stp  d8,  d9, [sp, #-16]!       // Save D8 and D9 on the stack
        stp d10, d11, [sp, #-16]!       // Save D10 and D11 on the stack
        stp d12, d13, [sp, #-16]!       // Save D12 and D13 on the stack
        stp d14, d15, [sp, #-16]!       // Save D14 and D15 on the stack

        // we will always have matrix B in the registers.
        // elements of A will be overwritten after every row of C
        // the result of the FMA will be directly written to memory of C
        // the matrix C is assumed to be stored in transposed version for more efficient memory loads and stores in this column major memory implementation.

        // load first values of A and all of B into registers
        ldp s3, s4, [x0], #8    // load first two values of A
        // load B
        ldp s5, s6, [x1], #8
        ldp s7, s8, [x1], #8
        ldp s9, s10, [x1], #-24
        //load first two rows of C (here columns because C is transposed!)
        ldp s11, s12, [x2], #8
        ldp s13, s14, [x2], #8
        ldp s15, s16, [x2], #8
        ldp s17, s18, [x2], #8
        ldp s19, s20, [x2], #8
        ldp s21, s22, [x2], #8

        // do FMA C+=A*B for first two rows of C
        MADD x11, x3, x5, x11
        MADD x12, x3, x6, x12
        MADD x13, x3, x7, x13
        MADD x14, x3, x8, x14
        MADD x15, x3, x9, x15
        MADD x16, x3, x10, x16

        MADD x17, x4, x5, x17
        MADD x18, x4, x6, x18
        MADD x19, x4, x7, x19
        MADD x20, x4, x8, x20
        MADD x21, x4, x9, x21
        MADD x22, x4, x10, x22

        // store first two rows of C to memory
        stp x11, x12, [x2, #-48]
        stp x13, x14, [x2, #-40]
        stp x15, x16, [x2, #-32]
        stp x17, x18, [x2, #-24]
        stp x19, x20, [x2, #-16]
        stp x21, x22, [x2, #-8]

        // Repeat for next two rows of C
        ldp x3, x4, [x0], #8    // load values three and four of A
        //load rows three and four of C (here columns because C is transposed!)
        ldp x11, x12, [x2], #8
        ldp x13, x14, [x2], #8
        ldp x15, x16, [x2], #8
        ldp x17, x18, [x2], #8
        ldp x19, x20, [x2], #8
        ldp x21, x22, [x2], #8

        // do MADD C+=A*B for rows three and four of C
        MADD x11, x3, x5, x11
        MADD x12, x3, x6, x12
        MADD x13, x3, x7, x13
        MADD x14, x3, x8, x14
        MADD x15, x3, x9, x15
        MADD x16, x3, x10, x16

        MADD x17, x4, x5, x17
        MADD x18, x4, x6, x18
        MADD x19, x4, x7, x19
        MADD x20, x4, x8, x20
        MADD x21, x4, x9, x21
        MADD x22, x4, x10, x22

        // store rows three and four of C to memory
        stp x11, x12, [x2, #-48]
        stp x13, x14, [x2, #-40]
        stp x15, x16, [x2, #-32]
        stp x17, x18, [x2, #-24]
        stp x19, x20, [x2, #-16]
        stp x21, x22, [x2, #-8]

        // Repeat for next two rows of C
        ldp x3, x4, [x0], #8    // load values 5 and 6 of A
        //load rows 5 and 6 of C (here columns because C is transposed!)
        ldp x11, x12, [x2], #8
        ldp x13, x14, [x2], #8
        ldp x15, x16, [x2], #8
        ldp x17, x18, [x2], #8
        ldp x19, x20, [x2], #8
        ldp x21, x22, [x2], #8

        // do MADD C+=A*B for rows 5 and 6 of C
        MADD x11, x3, x5, x11
        MADD x12, x3, x6, x12
        MADD x13, x3, x7, x13
        MADD x14, x3, x8, x14
        MADD x15, x3, x9, x15
        MADD x16, x3, x10, x16

        MADD x17, x4, x5, x17
        MADD x18, x4, x6, x18
        MADD x19, x4, x7, x19
        MADD x20, x4, x8, x20
        MADD x21, x4, x9, x21
        MADD x22, x4, x10, x22

        // store rows 5 and 6 of C to memory
        stp x11, x12, [x2, #-48]
        stp x13, x14, [x2, #-40]
        stp x15, x16, [x2, #-32]
        stp x17, x18, [x2, #-24]
        stp x19, x20, [x2, #-16]
        stp x21, x22, [x2, #-8]

        // Repeat for next two rows of C
        ldp x3, x4, [x0], #8    // load values 5 and 6 of A
        //load rows 7 and 8 of C (here columns because C is transposed!)
        ldp x11, x12, [x2], #8
        ldp x13, x14, [x2], #8
        ldp x15, x16, [x2], #8
        ldp x17, x18, [x2], #8
        ldp x19, x20, [x2], #8
        ldp x21, x22, [x2], #8

        // do MADD C+=A*B for rows 7 and 8 of C
        MADD x11, x3, x5, x11
        MADD x12, x3, x6, x12
        MADD x13, x3, x7, x13
        MADD x14, x3, x8, x14
        MADD x15, x3, x9, x15
        MADD x16, x3, x10, x16

        MADD x17, x4, x5, x17
        MADD x18, x4, x6, x18
        MADD x19, x4, x7, x19
        MADD x20, x4, x8, x20
        MADD x21, x4, x9, x21
        MADD x22, x4, x10, x22

        // store rows 7 and 8 of C to memory
        stp x11, x12, [x2, #-48]
        stp x13, x14, [x2, #-40]
        stp x15, x16, [x2, #-32]
        stp x17, x18, [x2, #-24]
        stp x19, x20, [x2, #-16]
        stp x21, x22, [x2, #-8]

        // Repeat for next two rows of C
        ldp x3, x4, [x0], #8    // load values 5 and 6 of A
        //load rows 9 and 10 of C (here columns because C is transposed!)
        ldp x11, x12, [x2], #8
        ldp x13, x14, [x2], #8
        ldp x15, x16, [x2], #8
        ldp x17, x18, [x2], #8
        ldp x19, x20, [x2], #8
        ldp x21, x22, [x2], #8

        // do MADD C+=A*B for rows 9 and 10 of C
        MADD x11, x3, x5, x11
        MADD x12, x3, x6, x12
        MADD x13, x3, x7, x13
        MADD x14, x3, x8, x14
        MADD x15, x3, x9, x15
        MADD x16, x3, x10, x16

        MADD x17, x4, x5, x17
        MADD x18, x4, x6, x18
        MADD x19, x4, x7, x19
        MADD x20, x4, x8, x20
        MADD x21, x4, x9, x21
        MADD x22, x4, x10, x22

        // store rows 9 and 10 of C to memory
        stp x11, x12, [x2, #-48]
        stp x13, x14, [x2, #-40]
        stp x15, x16, [x2, #-32]
        stp x17, x18, [x2, #-24]
        stp x19, x20, [x2, #-16]
        stp x21, x22, [x2, #-8]

        // Repeat for next two rows of C
        ldp x3, x4, [x0], #8    // load values 5 and 6 of A
        //load rows 11 and 12 of C (here columns because C is transposed!)
        ldp x11, x12, [x2], #8
        ldp x13, x14, [x2], #8
        ldp x15, x16, [x2], #8
        ldp x17, x18, [x2], #8
        ldp x19, x20, [x2], #8
        ldp x21, x22, [x2], #8

        // do MADD C+=A*B for rows 11 and 12 of C
        MADD x11, x3, x5, x11
        MADD x12, x3, x6, x12
        MADD x13, x3, x7, x13
        MADD x14, x3, x8, x14
        MADD x15, x3, x9, x15
        MADD x16, x3, x10, x16

        MADD x17, x4, x5, x17
        MADD x18, x4, x6, x18
        MADD x19, x4, x7, x19
        MADD x20, x4, x8, x20
        MADD x21, x4, x9, x21
        MADD x22, x4, x10, x22

        // store rows 11 and 12 of C to memory
        stp x11, x12, [x2, #-48]
        stp x13, x14, [x2, #-40]
        stp x15, x16, [x2, #-32]
        stp x17, x18, [x2, #-24]
        stp x19, x20, [x2, #-16]
        stp x21, x22, [x2, #-8]

        // Repeat for next two rows of C
        ldp x3, x4, [x0], #8    // load values 5 and 6 of A
        //load rows 13 and 14 of C (here columns because C is transposed!)
        ldp x11, x12, [x2], #8
        ldp x13, x14, [x2], #8
        ldp x15, x16, [x2], #8
        ldp x17, x18, [x2], #8
        ldp x19, x20, [x2], #8
        ldp x21, x22, [x2], #8

        // do MADD C+=A*B for rows 13 and 14 of C
        MADD x11, x3, x5, x11
        MADD x12, x3, x6, x12
        MADD x13, x3, x7, x13
        MADD x14, x3, x8, x14
        MADD x15, x3, x9, x15
        MADD x16, x3, x10, x16

        MADD x17, x4, x5, x17
        MADD x18, x4, x6, x18
        MADD x19, x4, x7, x19
        MADD x20, x4, x8, x20
        MADD x21, x4, x9, x21
        MADD x22, x4, x10, x22

        // store rows 13 and 14 of C to memory
        stp x11, x12, [x2, #-48]
        stp x13, x14, [x2, #-40]
        stp x15, x16, [x2, #-32]
        stp x17, x18, [x2, #-24]
        stp x19, x20, [x2, #-16]
        stp x21, x22, [x2, #-8]

        // Repeat for next two rows of C
        ldp x3, x4, [x0], #8    // load values 5 and 6 of A
        //load rows 15 and 16 of C (here columns because C is transposed!)
        ldp x11, x12, [x2], #8
        ldp x13, x14, [x2], #8
        ldp x15, x16, [x2], #8
        ldp x17, x18, [x2], #8
        ldp x19, x20, [x2], #8
        ldp x21, x22, [x2], #8

        // do MADD C+=A*B for rows 15 and 16 of C
        MADD x11, x3, x5, x11
        MADD x12, x3, x6, x12
        MADD x13, x3, x7, x13
        MADD x14, x3, x8, x14
        MADD x15, x3, x9, x15
        MADD x16, x3, x10, x16

        MADD x17, x4, x5, x17
        MADD x18, x4, x6, x18
        MADD x19, x4, x7, x19
        MADD x20, x4, x8, x20
        MADD x21, x4, x9, x21
        MADD x22, x4, x10, x22

        // store rows 15 and 16 of C to memory
        stp x11, x12, [x2, #-48]
        stp x13, x14, [x2, #-40]
        stp x15, x16, [x2, #-32]
        stp x17, x18, [x2, #-24]
        stp x19, x20, [x2, #-16]
        stp x21, x22, [x2, #-8]

        // restore
        // ASIMD callee saved registers
        ldp d14, d15, [sp], #16         // Restore D14 and D15 from the stack
        ldp d12, d13, [sp], #16         // Restore D12 and D13 from the stack
        ldp d10, d11, [sp], #16         // Restore D10 and D11 from the stack
        ldp  d8,  d9, [sp], #16         // Restore D8 and D9 from the stack

        // SIMD callee registers
        ldp x29, x30, [sp], #16         // Restore X29 and X30 from the stack
        ldp x27, x28, [sp], #16         // Restore X27 and X28 from the stack
        ldp x25, x26, [sp], #16         // Restore X25 and X26 from the stack
        ldp x23, x24, [sp], #16         // Restore X23 and X24 from the stack
        ldp x21, x22, [sp], #16         // Restore X21 and X22 from the stack
        ldp x19, x20, [sp], #16         // Restore X19 and X20 from the stack

        ret
        .size gemm_asm_asimd_16_6_1, (. - gemm_asm_asimd_16_6_1)