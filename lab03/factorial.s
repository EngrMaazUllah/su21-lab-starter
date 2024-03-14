.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    add t1, a0, x0  #initilizing the value of t1 to zero 
    addi t2, x0, 1  # its for the iteration if loop
    addi a0, x0, 1 
    loop:
    bge t2, t1 , exit # if 1>=n so the goto exit  
    mul a0, a0, t1   # 
    addi t1, t1, -1
    j loop
    
exit:
    ret
