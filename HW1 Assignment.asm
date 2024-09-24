.data
A:      .space 60  
B:      .space 60  
C:      .space 60  
countA: .word 0
countB: .word 0
countC: .word 0
sumA:   .word 0
prompt: .asciiz "please write an integer between -99 and 99: "
invalidInput: .asciiz "Invalid input.\n"
avgMsg: .asciiz "\nAverage of A: "
msgB:   .asciiz "\nContents of B:\n"
countBmsg: .asciiz "\nCount of B: "
largestBMsg: .asciiz "\nLargest in B: "
msgC:   .asciiz "\nContents of C:\n"
countCmsg: .asciiz "\nCount of C: "
smallestCMsg: .asciiz "\nSmallest in C: "
name:   .asciiz "\nWala' Essam - Good Bye!!\n"

.text
.globl main

main:
    li $t0, 0  
    li $t1, 15 

read_loop:
    beq $t0, $t1, processArrays 

    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    li $t2, -99
    li $t3, 99
    blt $v0, $t2, invalid
    bgt $v0, $t3, invalid

    sll $t4, $t0, 2  
    la $t5, A
    add $t5, $t5, $t4
    sw $v0, 0($t5)
    lw $t6, sumA
    add $t6, $t6, $v0
    sw $t6, sumA

    addi $t0, $t0, 1  
    j read_loop

invalid:
    li $v0, 4
    la $a0, invalidInput
    syscall
    j read_loop

processArrays:
    li $t0, 0  
    li $t7, 0  
    li $t8, 0  
    sw $zero, countB
    sw $zero, countC

process_loop:
    beq $t0, $t1, afterProcess  

    sll $t4, $t0, 2  
    la $t5, A
    add $t5, $t5, $t4
    lw $t9, 0($t5)  

  
    bltz $t9, storeInC
    sll $t4, $t7, 2  
    la $t5, B
    add $t5, $t5, $t4
    sw $t9, 0($t5)
    addi $t7, $t7, 1  
    j incIndexA

storeInC:
  
    sll $t4, $t8, 2  
    la $t5, C
    add $t5, $t5, $t4
    sw $t9, 0($t5)
    addi $t8, $t8, 1  

incIndexA:
    addi $t0, $t0, 1  
    j process_loop

afterProcess:
  
    sw $t7, countB
    sw $t8, countC
    j printAvgA

printAvgA:
    li $v0, 4
    la $a0, avgMsg
    syscall

    lw $a0, sumA
    li $a1, 15
    div $a0, $a1
    mflo $a0
    li $v0, 1
    syscall

    j printB

printB:
    li $v0, 4
    la $a0, msgB
    syscall

    li $t0, 0 
    lw $t1, countB  

printB_loop:
    beq $t0, $t1, printCountB  

    sll $t4, $t0, 2  
    la $t5, B
    add $t5, $t5, $t4
    lw $a0, 0($t5)
    li $v0, 1
    syscall

    li $v0, 11
    li $a0, ' '
    syscall

    addi $t0, $t0, 1  
    j printB_loop

printCountB:
    li $v0, 4
    la $a0, countBmsg
    syscall

    li $v0, 1
    lw $a0, countB
    syscall
    
    

li $t0, 0  
la $t2, B 
lw $t3, 0($t2)  
li $t4, 1 

largestB_loop:
    bge $t4, $t7, printLargestB  
    sll $t5, $t4, 2
    add $t6, $t2, $t5
    lw $t5, 0($t6)
    
    slt $t6, $t3, $t5  
    beqz $t6, continueB 
    move $t3, $t5  

continueB:
    addi $t4, $t4, 1
    j largestB_loop

printLargestB:
    li $v0, 4
    la $a0, largestBMsg
    syscall

    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall

    j printC

printC:
    li $v0, 4
    la $a0, msgC
    syscall

    li $t0, 0 
    lw $t1, countC  

printC_loop:
    beq $t0, $t1, printCountC  

    sll $t4, $t0, 2  
    la $t5, C
    add $t5, $t5, $t4
    lw $a0, 0($t5)
    li $v0, 1
    syscall
    
    li $v0, 11
    li $a0, ' '
    syscall

    addi $t0, $t0, 1
    j printC_loop

printCountC:
    li $v0, 4
    la $a0, countCmsg
    syscall

    li $v0, 1
    lw $a0, countC
    syscall
    

li $t0, 0  
la $t2, C  
lw $t3, 0($t2)  
li $t4, 1  

smallestC_loop:
    bge $t4, $t8, printSmallestC  
    sll $t5, $t4, 2
    add $t6, $t2, $t5
    lw $t5, 0($t6)
    
    slt $t6, $t5, $t3  
    beqz $t6, continueC  
    move $t3, $t5 
continueC:
    addi $t4, $t4, 1
    j smallestC_loop

printSmallestC:
    li $v0, 4
    la $a0, smallestCMsg
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall
    j end

end:
    li $v0, 4
    la $a0, name
    syscall
    li $v0, 10
    syscall
    li $v0, 4
    la $a0, name
    syscall
    li $v0, 10
    syscall
