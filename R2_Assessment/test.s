
.data
# for factorial an its results
num: 
    .word 7
result: 
    .word 0
    
.align 12

.section ".tohost","aw",@progbits;                            

.align 4; .global tohost; tohost: .dword 0;                     

.align 4; .global fromhost; fromhost: .dword 0; 


.globl _start

.text
_start:
    # get the values of the num and results
    la t0, num
    la t1, result
    lw a0, 0(t0)
    lw a1, 0(t1)
    jal factorial
    
    sw a0 ,0(t1)    # storing the value in reult
    jal display
    
    j exit
    
factorial:
    # Save return address and argument on the stack
    addi sp, sp, -8
    sw ra, 4(sp)
    sw a0, 0(sp)
    bgt a0, x0, else
    addi a0, zero, 1
    j if
else:
    lw a0, 0(sp)
    addi a0, a0, -1
    jal ra, factorial
    lw a1, 0(sp)
    
    mul a0, a0, a1
if:
    lw ra, 4(sp)
    addi sp, sp, 8
    jr ra

display:
    lw a1, 0(t1)
    li a0, 1
    ecall

exit:

    li a0, 10
    ecall
