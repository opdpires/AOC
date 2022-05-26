	.file	1 "fibonacci.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.abicalls
	.text
	.align	2
	.globl	fib
	.set	nomips16
	.set	nomicromips
	.ent	fib
	.type	fib, @function
fib:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 16, gp= 8
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	slt	$2,$4,2
	bne	$2,$0,$L10
	nop

	addiu	$sp,$sp,-48
	li	$2,-2			# 0xfffffffffffffffe
	sw	$19,40($sp)
	addiu	$19,$4,-2
	sw	$18,36($sp)
	and	$2,$19,$2
	addiu	$18,$4,-3
	sw	$17,32($sp)
	sw	$16,28($sp)
	sw	$31,44($sp)
	addiu	$17,$4,-1
	subu	$18,$18,$2
	move	$16,$0
$L3:
	.option	pic0
	jal	fib
	.option	pic2
	move	$4,$17

	addiu	$17,$17,-2
	bne	$17,$18,$L3
	addu	$16,$16,$2

	lw	$31,44($sp)
	andi	$2,$19,0x1
	lw	$18,36($sp)
	lw	$19,40($sp)
	lw	$17,32($sp)
	addu	$2,$2,$16
	lw	$16,28($sp)
	jr	$31
	addiu	$sp,$sp,48

$L10:
	jr	$31
	move	$2,$4

	.set	macro
	.set	reorder
	.end	fib
	.size	fib, .-fib
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"Digite um numero natural para obter o termo corresponden"
	.ascii	"te na serie de Fibonacci: \000"
	.align	2
$LC1:
	.ascii	"%d\000"
	.align	2
$LC2:
	.ascii	"Resultado: %d\000"
	.align	2
$LC3:
	.ascii	"\012Aperte uma tecla para sair\000"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,40,$31		# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-40
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$16,32($sp)
	lw	$16,%got(__stack_chk_guard)($28)
	lw	$25,%call16(__printf_chk)($28)
	lw	$2,0($16)
	lui	$5,%hi($LC0)
	sw	$31,36($sp)
	.cprestore	16
	addiu	$5,$5,%lo($LC0)
	li	$4,1			# 0x1
	sw	$2,28($sp)
	.reloc	1f,R_MIPS_JALR,__printf_chk
1:	jalr	$25
	sw	$0,24($sp)

	lw	$28,16($sp)
	lui	$4,%hi($LC1)
	lw	$25,%call16(__isoc99_scanf)($28)
	addiu	$5,$sp,24
	.reloc	1f,R_MIPS_JALR,__isoc99_scanf
1:	jalr	$25
	addiu	$4,$4,%lo($LC1)

	lw	$3,24($sp)
	lw	$28,16($sp)
	slt	$2,$3,2
	bne	$2,$0,$L23
	addiu	$13,$3,-2

	li	$2,-2			# 0xfffffffffffffffe
	addiu	$10,$3,-5
	and	$2,$13,$2
	addiu	$9,$3,-1
	subu	$10,$10,$2
	addiu	$3,$3,-3
	move	$6,$0
	li	$11,1			# 0x1
	li	$12,-2			# 0xfffffffffffffffe
$L14:
	beq	$9,$11,$L24
	addiu	$2,$3,-1

	and	$7,$3,$12
	addiu	$5,$3,1
	subu	$7,$2,$7
	move	$8,$0
$L16:
	.option	pic0
	jal	fib
	.option	pic2
	move	$4,$5

	addiu	$5,$5,-2
	lw	$28,16($sp)
	bne	$5,$7,$L16
	addu	$8,$8,$2

	andi	$2,$3,0x1
	addu	$8,$2,$8
$L17:
	addiu	$3,$3,-2
	addu	$6,$6,$8
	bne	$3,$10,$L14
	addiu	$9,$9,-2

	andi	$3,$13,0x1
$L15:
	lw	$25,%call16(__printf_chk)($28)
	lui	$5,%hi($LC2)
	addu	$6,$6,$3
	addiu	$5,$5,%lo($LC2)
	.reloc	1f,R_MIPS_JALR,__printf_chk
1:	jalr	$25
	li	$4,1			# 0x1

	lw	$28,16($sp)
	lui	$5,%hi($LC3)
	lw	$25,%call16(__printf_chk)($28)
	addiu	$5,$5,%lo($LC3)
	.reloc	1f,R_MIPS_JALR,__printf_chk
1:	jalr	$25
	li	$4,1			# 0x1

	lw	$28,16($sp)
	nop
	lw	$2,%got(stdin)($28)
	lw	$25,%call16(getc)($28)
	lw	$4,0($2)
	.reloc	1f,R_MIPS_JALR,getc
1:	jalr	$25
	nop

	lw	$3,28($sp)
	lw	$2,0($16)
	lw	$28,16($sp)
	bne	$3,$2,$L25
	move	$2,$0

	lw	$31,36($sp)
	lw	$16,32($sp)
	jr	$31
	addiu	$sp,$sp,40

$L24:
	.option	pic0
	b	$L17
	.option	pic2
	li	$8,1			# 0x1

$L23:
	.option	pic0
	b	$L15
	.option	pic2
	move	$6,$0

$L25:
	lw	$25,%call16(__stack_chk_fail)($28)
	nop
	.reloc	1f,R_MIPS_JALR,__stack_chk_fail
1:	jalr	$25
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0"
