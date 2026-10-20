
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bba50: d10283ff    	sub	sp, sp, #0xa0
10a9bba54: a9084ff4    	stp	x20, x19, [sp, #0x80]
10a9bba58: a9097bfd    	stp	x29, x30, [sp, #0x90]
10a9bba5c: 910243fd    	add	x29, sp, #0x90
10a9bba60: aa0003f4    	mov	x20, x0
10a9bba64: 900b14c8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a9bba68: 52800029    	mov	w9, #0x1                ; =1
10a9bba6c: 3913d109    	strb	w9, [x8, #0x4f4]
10a9bba70: 900abec8    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a9bba74: f9446500    	ldr	x0, [x8, #0x8c8]
10a9bba78: b00aba48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a9bba7c: f9461d01    	ldr	x1, [x8, #0xc38] ; new
10a9bba80: 953a7e71    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bba84: aa0003f3    	mov	x19, x0
10a9bba88: 900ac608    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bba8c: b98e6d08    	ldrsw	x8, [x8, #0xe6c]
10a9bba90: f8686a81    	ldr	x1, [x20, x8]
10a9bba94: d10063a0    	sub	x0, x29, #0x18
10a9bba98: 953a7e77    	bl	0x10f85b474 <_UR_96F1_B25D+0x3a640e4>
10a9bba9c: 900ac608    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bbaa0: b98e7108    	ldrsw	x8, [x8, #0xe70]
10a9bbaa4: f8686a81    	ldr	x1, [x20, x8]
10a9bbaa8: d10083a0    	sub	x0, x29, #0x20
10a9bbaac: 953a7e72    	bl	0x10f85b474 <_UR_96F1_B25D+0x3a640e4>
10a9bbab0: 900ac608    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bbab4: b98e7908    	ldrsw	x8, [x8, #0xe78]
10a9bbab8: f8686a81    	ldr	x1, [x20, x8]
10a9bbabc: d100a3a0    	sub	x0, x29, #0x28
10a9bbac0: 953a7e6d    	bl	0x10f85b474 <_UR_96F1_B25D+0x3a640e4>
10a9bbac4: 910123e8    	add	x8, sp, #0x48
10a9bbac8: a904a3ff    	stp	xzr, x8, [sp, #0x48]
10a9bbacc: d0071e29    	adrp	x9, 0x118d81000 <dyld_stub_binder+0x118d81000>
10a9bbad0: fd427d20    	ldr	d0, [x9, #0x4f8]
10a9bbad4: fd002fe0    	str	d0, [sp, #0x58]
10a9bbad8: 900ac609    	adrp	x9, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bbadc: b98e7529    	ldrsw	x9, [x9, #0xe74]
10a9bbae0: 38696a89    	ldrb	w9, [x20, x9]
10a9bbae4: 390183e9    	strb	w9, [sp, #0x60]
10a9bbae8: f0096189    	adrp	x9, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10a9bbaec: f947e129    	ldr	x9, [x9, #0xfc0]
10a9bbaf0: f90007e9    	str	x9, [sp, #0x8]
10a9bbaf4: d0071e29    	adrp	x9, 0x118d81000 <dyld_stub_binder+0x118d81000>
10a9bbaf8: fd41c120    	ldr	d0, [x9, #0x380]
10a9bbafc: fd000be0    	str	d0, [sp, #0x10]
10a9bbb00: 90000009    	adrp	x9, 0x10a9bb000 <_Flutter_MMFoundation_BindContext+0x6e96be4>
10a9bbb04: 912e9129    	add	x9, x9, #0xba4
10a9bbb08: f00968ca    	adrp	x10, 0x11d6d6000 <dyld_stub_binder+0x11d6d6000>
10a9bbb0c: 910ca14a    	add	x10, x10, #0x328
10a9bbb10: a901abe9    	stp	x9, x10, [sp, #0x18]
10a9bbb14: f90017e8    	str	x8, [sp, #0x28]
10a9bbb18: 910023f4    	add	x20, sp, #0x8
10a9bbb1c: 9100a280    	add	x0, x20, #0x28
10a9bbb20: d10083a1    	sub	x1, x29, #0x20
10a9bbb24: 953a7e57    	bl	0x10f85b480 <_UR_96F1_B25D+0x3a640f0>
10a9bbb28: 9100c280    	add	x0, x20, #0x30
10a9bbb2c: d10063a1    	sub	x1, x29, #0x18
10a9bbb30: 953a7e54    	bl	0x10f85b480 <_UR_96F1_B25D+0x3a640f0>
10a9bbb34: 9100e280    	add	x0, x20, #0x38
10a9bbb38: d100a3a1    	sub	x1, x29, #0x28
10a9bbb3c: 953a7e51    	bl	0x10f85b480 <_UR_96F1_B25D+0x3a640f0>
10a9bbb40: f00aae88    	adrp	x8, 0x11ff8e000 <dyld_stub_binder+0x11ff8e000>
10a9bbb44: f9440501    	ldr	x1, [x8, #0x808] ; setDisplayContentsForLayer:
10a9bbb48: 910023e2    	add	x2, sp, #0x8
10a9bbb4c: aa1303e0    	mov	x0, x19
10a9bbb50: 953a7e3d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bbb54: 9100e280    	add	x0, x20, #0x38
10a9bbb58: 953a7e50    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
10a9bbb5c: 9100c280    	add	x0, x20, #0x30
10a9bbb60: 953a7e4e    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
10a9bbb64: 9100a280    	add	x0, x20, #0x28
10a9bbb68: 953a7e4c    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
10a9bbb6c: 910123e0    	add	x0, sp, #0x48
10a9bbb70: 52800101    	mov	w1, #0x8                ; =8
10a9bbb74: 953a7e71    	bl	0x10f85b538 <_UR_96F1_B25D+0x3a641a8>
10a9bbb78: d100a3a0    	sub	x0, x29, #0x28
10a9bbb7c: 953a7e47    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
10a9bbb80: d10083a0    	sub	x0, x29, #0x20
10a9bbb84: 953a7e45    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
10a9bbb88: d10063a0    	sub	x0, x29, #0x18
10a9bbb8c: 953a7e43    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
10a9bbb90: aa1303e0    	mov	x0, x19
10a9bbb94: a9497bfd    	ldp	x29, x30, [sp, #0x90]
10a9bbb98: a9484ff4    	ldp	x20, x19, [sp, #0x80]
10a9bbb9c: 910283ff    	add	sp, sp, #0xa0
10a9bbba0: d65f03c0    	ret