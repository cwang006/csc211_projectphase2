.data
    prompt: .asciiz "Enter your current balance: "
    balance: .asciiz "Balance: $"
    options: .asciiz "Select the following: (1) for Water, (2) for Snacks, (3) for Sandwiches, (4) for Meals, and (-1) to EXIT " 
    selection: .asciiz "Selected: "
    invalid: .asciiz "Invalid Selection. "
    insufficient: .asciiz "Insufficient balance. Please select another option or -1 to EXIT."
    newline: .asciiz "\n"
.text
main:
	li $v0, 4
	la $a0, prompt			# Prints the prompt for inputting balance
	syscall
	li $v0, 5			# User enters balance
	syscall 
	add $t0, $zero, $v0		# Stores balance into t0

current_balance:
	li $v0, 4
	la $a0, balance
	syscall
	li $v0, 1
	add $a0, $zero, $t0		# Load balance from $t0 into a0
	syscall
	
	la $a0, newline
	li $v0, 4
	syscall
    
select_option: 
	li $v0, 4
	la $a0, options			# Prints the options text
	syscall
	
	la $a0, newline
	li $v0, 4
	syscall
	
	li $v0, 4			
	la $a0, selection		# Prints the selection text
	syscall
	
	li $v0, 5
	syscall
	add $t1, $zero, $v0		# Store user selection in $t1
	beq $t1, -1, exit
	beq $t1, 1, water
	beq $t1, 2, snacks
	beq $t1, 3, sandwich
	beq $t1, 4, meal
	
	addi $t3, $zero, -1		# Store -1 into t3
	slt $at, $t1, $t3		# Checks if user selection is less than -1
	bne $at, $zero, invalid_option
	
	addi $t4, $zero, 4		# Store 4 into t4
	slt $at, $t1, $t4		# Checks if user selection is greater than 4
	bne $at, $zero, invalid_option

invalid_option:
	li $v0, 4
	la $a0, invalid			# Prints the options text
	syscall
	j select_option
	
exit:
	li $v0, 4			# Print remaining balance before exiting
	la $a0, balance
	syscall
	add $a0, $zero, $t0		# Load balance from $t1
	li $v0, 1
	syscall
	
	li $v0, 10			# Exit program
	syscall

water: 
	li $t2, 1			# Loads t2 with water cost
	j new_balance

snacks: 
	li $t2, 2			# Loads t2 with snack cost
	j new_balance

sandwich: 
	li $t2, 3			# Loads t2 with sandwich cost
	j new_balance

meal: 
	li $t2, 4			# Loads t2 with meal cost
	j new_balance

new_balance: 
	slt $at, $t0, $t2
	bne $at, $zero, insufficient_bal	# Check if balance in t1 is greater than cost in t3
	
	sub $t0, $t0, $t2
	li $v0, 4
	la $a0, balance
	syscall
	
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
	la $a0, newline
	li $v0, 4
	syscall
	
	j select_option

insufficient_bal: 
	li $v0, 4
	la $a0, insufficient
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	
	j select_option
