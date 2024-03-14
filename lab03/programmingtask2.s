# Function: dataArray
dataArray:
    # Prologue
    addi    sp, sp, -4          # Adjust stack pointer
    sw      ra, 0(sp)           # Save return address
    sw      s0, 4(sp)           # Save s0 (i) 

    # Initialize loop variable i (s0)
    li      s0, 0               # i = 0

    # Allocate space for the array on the stack
    addi    sp, sp, -40         # Allocate 10 integers (10 * 4 bytes)

dataArray_loop:
    # Check loop condition (i < 10)
    li      t0, 10              # Load array size directly into a register
    bge     s0, t0, dataArray_end  # If i >= 10, exit loop

    # Load i-th array index address
    add     t1, sp, s0          # Calculate address of array[i]

    # Call compare function and store result in array[i]
    mv      a0, a1              # Move num to a0
    mv      a1, s0              # Move i to a1
    jal     ra, compare         # Call compare function
    sw      a0, 0(t1)           # Store result in array[i]

    # Increment loop variable (i++)
    addi    s0, s0, 1           # i = i + 1
    j       dataArray_loop      # Repeat loop

dataArray_end:
    # Epilogue
    lw      ra, 0(sp)           # Restore return address
    lw      s0, 4(sp)           # Restore s0 (i)
    addi    sp, sp, 44          # Deallocate stack space (10 * 4 bytes + 4 bytes for s0 and ra)
    jr      ra                  # Return

# Function: compare
compare:
    # Prologue
    # No need for prologue in this simple function

    # Subtract b from a
    sub     t0, a0, a1          # Calculate a - b

    # Check if result is greater than or equal to 0
    bgez    t0, compare_true    # If result >= 0, branch to compare_true

    # Return 0 (false)
    li      a0, 0
    jr      ra

compare_true:
    # Return 1 (true)
    li      a0, 1
    jr      ra

# Function: sub
sub:
    # Prologue
    # No need for prologue in this simple function

    # Subtract b from a
    sub     a0, a0, a1          # Calculate a - b

    # Return the result
    jr      ra
