//Author: Spence Johnston
//Project: additive multiplication
//Purpose: Create a multiplication function through additive multiplication.

#include <xc.h>
//Using PIC32MX460F512L
    
.global main

.data
// data segment for READ/WRITE data follows here
// stored in volatile RAM memory
X:	    .word   2, 3, 5
Y:	    .word   1, 2, 3
n:	    .word   3	    // needs to equal array size
MAC_ACC:    .word   0
    
   
.text
.set noreorder
// text segment for instructions and CONSTANT READ-ONLY data follows here
// stored in non-volatile flash memory

.ent main
main:
    //load address of x into s0
    la s0, X
    //load address of y into s1
    la s1, Y
    la s2, MAC_ACC
    
    //setup loop
    la t0, X
    la t1, Y
    la t2, n
    lw t2, 0(t2)
    
array_loop:
    beqz t2, end_array_loop
    addi t2, t2, -1
    
    jal multiply
    nop
    
    addi t0, t0, 4
    addi t1, t1, 4
    
    j array_loop
    nop

//uses t3 and t4 as arguments 
multiply:
    move t6, $0
    lw t3, 0(t0)
    lw t4, 0(t1)
//if t3 or t4 are zero, quit multiplication
    beqz t3, end_mult_loop
mult_loop:
    beqz t4, end_mult_loop
    addi t4, t4, -1
   
    add t6, t6, t3
    
    j mult_loop
    nop
    
end_mult_loop:
    lw t7, 0(s2)
    add t6, t6, t7
    sw t6, 0(s2)
    jr ra
    nop
    
end_array_loop:
    nop   
    
    //endless loop
endless:
    j endless
    nop
.end main

	// constants go here
	