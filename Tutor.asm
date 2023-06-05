# ACyLab
# Demo for lab
# File handling in MARS
# Not the smartest program but very illustrative

.data
file_in:	.asciiz "input.txt"
file_out:	.asciiz "output.txt"
sentence:	.byte 0x0D, 0x0A #, 0x0D, 0x0A
sentence_cont:	.asciiz "// This is the new ending line"
cont_fila:         .word 0

.align 3
palabra_buffer:	.space 16	# Maximum input file size in Bytes
		.align 1

input_buffer:	.space 10200	# Maximum input file size in Bytes
		.align 1
.text
                   li $s3, 0 # contador filas
                   li $s3, 0 # contador columna
                   li $s4, 101 # limite

# Open (for reading) a file
	li $v0, 13		# System call for open file
	la $a0, file_in	                    # Input file name
	li $a1, 0		# Open for reading (flag = 0)
	li $a2, 0		# Mode is ignored
	syscall			# Open a file (file descriptor returned in $v0)
	move $s0, $v0		# Copy file descriptor

# Open (for writing) a file that does not exist
	li $v0, 13		# System call for open file
	la $a0, file_out	# Input file name
	li $a1, 1		# Open for overwriting (flag = 1)
	#li $a1, 9		# Open for appending (flag = 9)
	li $a2, 0		# Mode is ignored
	syscall			# Open a file (file descriptor returned in $v0)
	move $s1, $v0		# Copy file descriptor

# Read from previously opened file
	li $v0, 14		# System call for reading from file
	move $a0, $s0		# File descriptor
	
	la $a1, input_buffer	# Address of input buffer
	li $a2, 5120		# Maximum number of characters to read
	syscall			# Read from file
	move $t1, $v0		# Copy number of characters read
	
# Process file loaded in memory

	li $v0, 15		# System call for write to a file
	move $a0, $s1		# Restore file descriptor (open for writing)
	la $a1, input_buffer	# Address of buffer from which to write
	move $a2, $t1		# Number of characters to write
	syscall
	
# Append a sentence to a file

	li $v0, 15		# System call for write to a file
	move $a0, $s1		# Restore file descriptor (open for writing)
	la $a1, sentence	# Address of buffer from which to write
	li $a2, 2		# Number of characters to write
	syscall
	
	li $v0, 15		# System call for write to a file
	move $a0, $s1		# Restore file descriptor (open for writing)
	la $a1, sentence_cont	# Address of buffer from which to write
	li $a2, 30		# Number of characters to write
	syscall
	
# Close the files
 
	li   $v0, 16       # system call for close file
	move $a0, $s0      # file descriptor to close
	syscall            # close file
	
	li   $v0, 16       # system call for close file
	move $a0, $s1      # file descriptor to close
	syscall            # close file
			
Exit:	li   $v0, 10		# System call for exit
	syscall
