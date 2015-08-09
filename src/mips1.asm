    .data
array: .word  0 : 30                 # "array" of 30 words to contain count values
nouse: .word 0
size: .word  12                    # size of "array" 
      
    .text
    addi $t2,$zero,1	# t2 = 1
    
    ori	$t0,$zero,0	# t0 = 0
    addiu $t1,$zero,21	# t1 = 21
    
    addu $t0,$t0,$t2	# t0 = t0 + t2 = t1 + 1
    subu $t1,$t1,$t2	# t1 = t1 - t2 = t1 - 1
    
    sw	$t0,0($a0)	# store start number $t0 into dm0
    sw  $t1,4($a0)	# store end number $t1 into dm1
    
    addu $v0,$t0,$t1	# v0 = t0 + t1
    sw  $v0,8($a0)	# store v0
       
LOOP:
	addiu	$a0,$a0,12	# a0 = a0 + 12
	addi	$t0,$t0,1	# t0 = t0 + 1
	addi	$t1,$t1,-1	# t1 = t1 - 1
	slt	$a1,$t1,$t0	# a1 = 1 if t1 < t0, else a1 = 0
	beq	$a1,$t2,LOOPEND # a1 == t2 == 1, jump to LOOPEND
	sw	$t0,0($a0)	# store  number $t0 
    	sw  	$t1,4($a0)	# store  number $t1
	jal	count		# v0 = v0 + t0 +t1
	j	LOOP		# jump to LOOP
LOOPEND:
	lui	$t3,2		# t3 = 0x20000
	subu	$t3,$t3,$v0	# t3 = t3- v0
	sw	$t3,0($a0)	# store t3
	lw	$t4,0($a0)	# t4 = t3
	
LOOPFOREVER:
	j	LOOPFOREVER	# jump forever
	
count:
	addu	$v0,$v0,$t0	# $v0 = $v0 +$t0
	addu	$v0,$v0,$t1	# $v0 = $v0 +$t1
	sw	$v0,8($a0)	# store $v0
	jr	$ra		# return
	
