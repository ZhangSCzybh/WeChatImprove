
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bbdf8: d10143ff    	sub	sp, sp, #0x50
10a9bbdfc: a9034ff4    	stp	x20, x19, [sp, #0x30]
10a9bbe00: a9047bfd    	stp	x29, x30, [sp, #0x40]
10a9bbe04: 910103fd    	add	x29, sp, #0x40
10a9bbe08: aa0003f3    	mov	x19, x0
10a9bbe0c: d00ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bbe10: f945ad01    	ldr	x1, [x8, #0xb58] ; didSetDarkModeObserver
10a9bbe14: 953a7d8c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bbe18: 37000420    	tbnz	w0, #0x0, 0x10a9bbe9c <_Flutter_MMFoundation_BindContext+0x6e97a80>
10a9bbe1c: d00ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bbe20: f945b101    	ldr	x1, [x8, #0xb60] ; setDidSetDarkModeObserver:
10a9bbe24: aa1303e0    	mov	x0, x19
10a9bbe28: 52800022    	mov	w2, #0x1                ; =1
10a9bbe2c: 953a7d86    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bbe30: d10063a0    	sub	x0, x29, #0x18
10a9bbe34: aa1303e1    	mov	x1, x19
10a9bbe38: 953a7d8f    	bl	0x10f85b474 <_UR_96F1_B25D+0x3a640e4>
10a9bbe3c: f0096188    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10a9bbe40: f947e108    	ldr	x8, [x8, #0xfc0]
10a9bbe44: f90003e8    	str	x8, [sp]
10a9bbe48: d0071e28    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10a9bbe4c: fd41c100    	ldr	d0, [x8, #0x380]
10a9bbe50: 90000008    	adrp	x8, 0x10a9bb000 <_Flutter_MMFoundation_BindContext+0x6e96be4>
10a9bbe54: 913ab108    	add	x8, x8, #0xeac
10a9bbe58: fd0007e0    	str	d0, [sp, #0x8]
10a9bbe5c: d00964a9    	adrp	x9, 0x11d651000 <dyld_stub_binder+0x11d651000>
10a9bbe60: 910ac129    	add	x9, x9, #0x2b0
10a9bbe64: a90127e8    	stp	x8, x9, [sp, #0x10]
10a9bbe68: 910003f4    	mov	x20, sp
10a9bbe6c: 91008280    	add	x0, x20, #0x20
10a9bbe70: d10063a1    	sub	x1, x29, #0x18
10a9bbe74: 953a7d83    	bl	0x10f85b480 <_UR_96F1_B25D+0x3a640f0>
10a9bbe78: b00aa4e8    	adrp	x8, 0x11fe58000 <dyld_stub_binder+0x11fe58000>
10a9bbe7c: f9451901    	ldr	x1, [x8, #0xa30] ; addDarkModeObserver:
10a9bbe80: 910003e2    	mov	x2, sp
10a9bbe84: aa1303e0    	mov	x0, x19
10a9bbe88: 953a7d6f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bbe8c: 91008280    	add	x0, x20, #0x20
10a9bbe90: 953a7d82    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
10a9bbe94: d10063a0    	sub	x0, x29, #0x18
10a9bbe98: 953a7d80    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
10a9bbe9c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10a9bbea0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10a9bbea4: 910143ff    	add	sp, sp, #0x50
10a9bbea8: d65f03c0    	ret