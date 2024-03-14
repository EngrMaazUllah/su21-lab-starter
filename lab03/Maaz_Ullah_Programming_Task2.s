
.data
# Initialize array with specific values
array:  .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  
        .text
        .globl start
        

start:
        lui sp, 0x1         # Defining sp
        addi sp, sp, -100   # defining the positions of stack pointer 


        li a0, 3            
        jal ra, dataArray   

        # Print array elements
        li s0, 0            # Initialize loop counter i (s0) to 0
        
loop1:
        li t0, 10           # Load immediate value 10 to t0
        bge s0, t0, end_loop1 # Exit if 1>=10

        mv t1, s0          
        slli t1, t1, 2      # Calculate the offset (i * 4) 
        la t2, array        # Load the address of array into t2
        add t1, t2, t1      # Add the offset to the start of the array
        lw a0, 0(t1)        # Load array[i] into a0
        
        add a1, x0, a0
        li a0, 1            # Load system call number for print integer
        ecall               # Perform system call to print integer

        addi s0, s0, 1      # Increment i by 1
        j loop1        # Jump back to loop

end_loop1:
        # Exit program
        li a0, 10           # Load exit code 10 (success)
        ecall               # Perform system call to exit program

# Define functions
        .globl dataArray
dataArray:
        # Function prologue
        addi sp, sp, -8     # Adjust stack pointer to save ra and fp
        sw ra, 0(sp)        # Save return address (ra) on the stack

        li s0, 0            # Initialize loop counter i (s0) to 0

loop:
        li t0, 10           # Load immediate value 10 into temporary register t0
        bge s0, t0, end_loop # Exit loop if i >= 10

        mv a0, s0           # Move value of i to a0 
        li a1, 3            # Load the value to compare with into a1
        jal ra, compare     

        mv t1, s0           # Move value of i to temporary register t1 
        slli t1, t1, 2      # Calculate the offset (i * 4) for array[i]
        la t2, array        # Load the address of array into t2
        add t1, t2, t1      # Add the offset to the start of the array
        sw a0, 0(t1)        # Store the result of compare function in array[i]

        addi s0, s0, 1      # Increment i by 1
        j loop              # Jump back to loop

end_loop:
        # Function epilogue
        lw ra, 0(sp)        # Restore return address (ra) from the stack
        addi sp, sp, 8      # Adjust stack pointer to remove saved ra and fp
        jr ra               # Jump back to the return address

        .globl compare
compare:
        
        addi sp, sp, -8     # Adjust stack pointer to save ra and fp
        sw ra, 0(sp)        # Save return address (ra) on the stack

        sub a0, a0, a1      # Subtract b from a
        blt a0, zero, greater_equal    # Branch if result is less than zero (i.e., a - b >= 0)

        li a0, 0            # Load immediate value 0 into return register
        j end_compare       # Jump to end of function

greater_equal:
        li a0, 1            # Load immediate value 1 into return register

end_compare:
       
        lw ra, 0(sp)        # Restore return address (ra) from the stack
        addi sp, sp, 8      # Adjust stack pointer to remove saved ra and fp
        jr ra               # Jump back to the return address