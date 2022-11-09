.data
array1:	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
array2:	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
array3:	.word 
entery1:	.asciiz "Please enter your array first size(less than or equal 30): "
entery2:	.asciiz "Please enter your array second size(less than or equal 30): "
msg1:	.asciiz "Please enter the ["
msg2:	.asciiz "] number of array: "
msg3:	.asciiz "Your enter number is not correct.\n"
msg4:	.asciiz "Array: ["
msg5:	.asciiz ", "
msg6:	.asciiz "]\n"
msg7:	.asciiz "First "	
msg8:	.asciiz "Second "
msg9:	.asciiz "Result: ["		
.text
	li	$v0, 4		# print entery1 
	la	$a0, entery1
	syscall
	li 	$v0, 5		# Read Integer n
	syscall
	sle	$s0, $v0, 30	# if n <= 30 $s0 = 1 else $s0 = 0
	beq	$s0, $zero, Error
	add	$t0, $zero, $v0	# size of first array1
	addi	$t1, $zero, 0	# i = 0
	la	$t2, array1	# address of first array in $t2
Loop:	
	beq	$t0, $t1, Loop2	# if ( n == i ) go to Loop2
	li	$v0, 4		# print msg1 
	la	$a0, msg1
	syscall
	li	$v0, 1		# print i
	add	$a0, $t1, $zero
	syscall
	li	$v0, 4		# print msg2 
	la	$a0, msg2
	syscall
	li	$v0, 5		# Read Integer
	syscall
	move	$t3, $v0	
	sw	$t3, 0($t2)	# Save in Memory
	addi	$t2, $t2, 4	# Adress of array1 += 4
	addi 	$t1, $t1, 1	# i++
	j	Loop
Loop2:
	li	$v0, 4		# print entery2
	la	$a0, entery2
	syscall
	li 	$v0, 5		# Read Integer n
	syscall
	sle	$s0, $v0, 30	# if n <= 30 $s0 = 1 else $s0 = 0
	beq	$s0, $zero, Error
	add	$t4, $zero, $v0	# size of second array in $t4
	addi	$t1, $zero, 0	# i = 0
	la	$t5, array2	# address of second array in $t5
Loop2_1:
	beq	$t4, $t1, Intialize1	# if ( n == i ) go to else
	li	$v0, 4		# print msg1 
	la	$a0, msg1
	syscall
	li	$v0, 1		# print i
	add	$a0, $t1, $zero
	syscall
	li	$v0, 4		# print msg2 
	la	$a0, msg2
	syscall
	li	$v0, 5		# Read Integer
	syscall
	move	$t3, $v0	
	sw	$t3, 0($t5)	# Save in Memory
	addi	$t5, $t5, 4	# Adress of array2 += 4
	addi 	$t1, $t1, 1	# i++
	j	Loop2_1	
Intialize1:
	la	$t2, array1	# address of first array in $t2
	la	$t5, array2	# address of second array in $t5
	la	$t7, array3	# address of third array in $t7
	addi	$t1, $zero, 0	# i = 0
	addi	$t3, $zero, 0	# j = 0
	addi	$t6, $zero, 0	# k = 0
While1:
	beq	$t1, $t0, While2	# i == size of array1 go to while2
	beq	$t3, $t4, While2	# j == size of array2 go to while2
	lw	$s0, 0($t2)
	lw	$s1, 0($t5)
	slt	$s2, $s0, $s1	# if a[i] < b[j] $s2 = 1 else $s2 = 0
	beq	$s2, 1, If1	# if $s2 == 1 go to If1
	sw	$s1, 0($t7)	# result[k] = b[k]
	addi	$t5, $t5, 4	# Adress of array2 += 4
	addi	$t7, $t7, 4	# Adress of array3 += 4
	addi 	$t6, $t6, 1	# k++
	addi 	$t3, $t3, 1	# j++
	j	While1
While2:
	beq	$t1, $t0, While3	# i == size of array1 go to while3
	lw	$s0, 0($t2)
	sw	$s0, 0($t7)	# result[k] = a[i]
	addi	$t2, $t2, 4	# Adress of array1 += 4
	addi	$t7, $t7, 4	# Adress of array3 += 4
	addi 	$t6, $t6, 1	# k++
	addi 	$t1, $t1, 1	# i++
	j	While2
While3:
	beq	$t3, $t4, Intialize2	# j == size of array2 go to Intialize2
	lw	$s1, 0($t5)	
	sw	$s1, 0($t7)	# result[k] = b[k]
	addi	$t5, $t5, 4	# Adress of array2 += 4
	addi	$t7, $t7, 4	# Adress of array3 += 4
	addi 	$t6, $t6, 1	# k++
	addi 	$t3, $t3, 1	# j++
	j	While3		
If1:
	sw	$s0, 0($t7)	# result[k] = a[i]
	addi	$t2, $t2, 4	# Adress of array1 += 4
	addi	$t7, $t7, 4	# Adress of array3 += 4
	addi 	$t6, $t6, 1	# k++
	addi 	$t1, $t1, 1	# i++
	j	While1
Intialize2:
	la	$t2, array1	# address of first array in $t2
	la	$t5, array2	# address of second array in $t5
	la	$t7, array3	# address of third array in $t7
	add	$s1, $t0, $t4	# size of array3 in $s1
	addi	$t1, $zero, 0	# i = 0
	addi	$t3, $zero, 0	# j = 0
	addi	$t6, $zero, 0	# k = 0
	addi	$t0, $t0, -1	# size-- of array1
	addi	$t4, $t4, -1	# size-- of array2
	addi	$s1, $s1, -1	# size-- of array3
	li	$v0, 4		# Print String
	la	$a0, msg7
	syscall
	li	$v0, 4		# Print String
	la	$a0, msg4
	syscall
Print1:
	beq	$t1, $t0, Print2
	lw	$s0, 0($t2)
	li	$v0, 1		# print a[i]
	add	$a0, $s0, $zero
	syscall
	li	$v0, 4		# Print String
	la	$a0, msg5
	syscall
	addi 	$t1, $t1, 1	# i++
	addi	$t2, $t2, 4	# Adress of array1 += 4
	j	Print1
Print2:
	lw	$s0, 0($t2)
	li	$v0, 1		# print a[last]
	add	$a0, $s0, $zero
	syscall
	li	$v0, 4		# Print String
	la	$a0, msg6
	syscall
	li	$v0, 4		# Print String
	la	$a0, msg8
	syscall
	li	$v0, 4		# Print String
	la	$a0, msg4
	syscall
Print2_1:
	beq	$t3, $t4, Print3
	lw	$s0, 0($t5)
	li	$v0, 1		# print b[j]
	add	$a0, $s0, $zero
	syscall
	li	$v0, 4		# Print String
	la	$a0, msg5
	syscall
	addi 	$t3, $t3, 1	# j++
	addi	$t5, $t5, 4	# Adress of array2 += 4
	j	Print2_1
Print3:
	lw	$s0, 0($t5)
	li	$v0, 1		# print b[last]
	add	$a0, $s0, $zero
	syscall
	li	$v0, 4		# Print String
	la	$a0, msg6
	syscall
	li	$v0, 4		# Print String
	la	$a0, msg9
	syscall
Print3_1:
	beq	$t6, $s1, Exit1
	lw	$s0, 0($t7)
	li	$v0, 1		# print b[j]
	add	$a0, $s0, $zero
	syscall
	li	$v0, 4		# Print String
	la	$a0, msg5
	syscall
	addi 	$t6, $t6, 1	# k++
	addi	$t7, $t7, 4	# Adress of array3 += 4
	j	Print3_1
Exit1:
	lw	$s0, 0($t7)
	li	$v0, 1		# print result[last]
	add	$a0, $s0, $zero
	syscall
	li	$v0, 4		# Print String
	la	$a0, msg6
	syscall
	j	Exit
Error:	# Print Error
	li	$v0, 4
	la	$a0, msg3
	syscall	
Exit:	# Normal Exit	
	li	$v0, 10
	syscall