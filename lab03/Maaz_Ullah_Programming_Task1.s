.data
b:
    .word 0, 0, 0    # Reserve space for b array (3 integers)

.text
.align 2
.globl main

main:
    # Initialize variables
    li  s0, 0      # s0 = i = 0
    li  s1, 7      # s1 = a = 7
    la  s2, b      # Loading address of b into s2
    addi t3, x0, 3

loop:
    bge s0, t3, end_loop  # Check loop condition (i < 3)
    
    # Calculate b[i] = a + (i * a)
    slli t0, s0, 2      # Calculate offset (i * 4)
    mul  t4, s0, s1 
    add  t1, s1, t4     # Calculate a + (i * a)
    sw   t1, 0(s2)      # Store result in b[i]
    # Update loop counter
    addi s0, s0, 1      
    j loop   # Continue looping
    
end_loop:
    # Retrun the value 
    ret
