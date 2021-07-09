############### merge (in, out, start, mid, end)  ################
########    merge the two sorted arrays in[start:mid-1] and in[mid:end-1] 
############   and write the sorted output array to out[start:end-1] 
#################################################################

### Question: what should the value of mid parameter be to express empty arrays?  #######

.data
# statically defined input strings
      .asciiz "\n"

.align 2
  in:
      .word -56, -50, 0,12, 23, 100, 110, 10001, -100, 13, 111, 2000
  out:
      .space 400
      
  start:
      .word 0  
  mid:
      .word 8
  end:
      .word 12
      
#################################################

# Implement the merge function in MIPS assembly 
.text
.globl main            		# label "main" must be global

.macro print_array_int(%x, %y)   #macro to print an array of %y integers. Array starts at %x
print_loop:
  beqz %y, end_of_macro
  li $v0, 1
  lw $a0, 0(%x)
  syscall
  li $v0, 11
  li $a0, ','
  syscall
  li $a0, ' '
  syscall
  addi %y, %y, -1
  addi %x, %x, 4
  j print_loop
end_of_macro:
.end_macro

###################  main #####################
main:  
  la $a0, in       # address of in array
  la $a1, out      # address of out array
  la $a2, start    # start of in[start:mid-1] array
  lw $a2, 0($a2)
  la $a3, mid      # start of in[mid:end-1] array
  lw $a3, 0($a3)   
  la $t0, end      # the fifth parameter is the end of the in[] array. Main() puts it in the stack before calling merge
  lw $t0, 0($t0)
  addi $sp, $sp, -4
  sw $t0, 0($sp)  
  jal merge        # call the function 
  
  addi $sp, $sp, 4    # upon return, empty the stack 
   
  la $s0, out         # and print out the array
  li $s1, 12
  print_array_int($s0, $s1)
    
# Exit progem
  li $v0, 10
  syscall

##############################  merge function  ################################################
# merge (in, out, start, mid, end)
merge:
    addi $sp, $sp, -8
    sw $s0, 4($sp)
    sw $s1, 0($sp)
    lw $t0, 8($sp)    # end

    sll  $s0, $a2, 2
    add  $s0, $a0, $s0  # $s0 is the running pointer of array in[start:mid-1]
    sll  $s1, $a3, 2
    add  $s1, $a0, $s1  # $s1 is the running pointer of array in[mid:end-1]	
    move $t5, $s1       # $t5 points at mid 
    sll $t6, $t0, 2
    add $t6, $a0, $t6   # $t6 points at end

    sll  $s2, $a2, 2
    add $s2, $a1, $s2
    move $v0, $s2
    li $t8, 0    
    sub $t7, $t0, $a2   # $t7 is the sum of the sizes of the two array 

loop:
	bge $t8, $t7, Exit
	li $t3, 0x7FFFFFFF
	li $t4, 0x7FFFFFFF
	bge $s0, $t5, Lb1
	lw $t3, 0($s0)
Lb1:	bge $s1, $t6, Lb2 
	lw $t4, 0($s1)
Lb2:	ble $t3, $t4, L1
	sw $t4, 0($s2)
	addi $s1, $s1, 4
        j L2		
L1:	
        sw $t3, 0($s2)
        addi $s0, $s0, 4
L2:
	addi $s2, $s2, 4
	addi $t8, $t8, 1
	j loop	
	
Exit:				
	lw $s0, 4($sp)
	lw $s1, 0($sp)
	addi $sp, $sp, 8
	jr $ra
