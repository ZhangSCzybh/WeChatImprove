
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0bea20: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10a0bea24: a9014ff4    	stp	x20, x19, [sp, #0x10]
10a0bea28: a9027bfd    	stp	x29, x30, [sp, #0x20]
10a0bea2c: 910083fd    	add	x29, sp, #0x20
10a0bea30: 900afec8    	adrp	x8, 0x120096000 <dyld_stub_binder+0x120096000>
10a0bea34: f944e501    	ldr	x1, [x8, #0x9c8] ; calcDataItemIndex:
10a0bea38: 955e7283    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bea3c: aa0003f3    	mov	x19, x0
10a0bea40: b00b05a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0bea44: f945e900    	ldr	x0, [x8, #0xbd0]
10a0bea48: d00b0208    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0bea4c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a0bea50: 955e727d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bea54: aa1d03fd    	mov	x29, x29
10a0bea58: 955e727e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bea5c: aa0003f4    	mov	x20, x0
10a0bea60: d00b05a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0bea64: f9428500    	ldr	x0, [x8, #0x508]
10a0bea68: b00b0208    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a0bea6c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a0bea70: 955e7275    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bea74: aa0003e2    	mov	x2, x0
10a0bea78: f00aebc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0bea7c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a0bea80: aa1403e0    	mov	x0, x20
10a0bea84: 955e7270    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bea88: aa1d03fd    	mov	x29, x29
10a0bea8c: 955e7271    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bea90: aa0003f5    	mov	x21, x0
10a0bea94: f00afa28    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
10a0bea98: f944c501    	ldr	x1, [x8, #0x988] ; getTimelineDataItemOfIndex:
10a0bea9c: 91000662    	add	x2, x19, #0x1
10a0beaa0: 955e7269    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0beaa4: aa1d03fd    	mov	x29, x29
10a0beaa8: 955e726a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0beaac: aa0003f3    	mov	x19, x0
10a0beab0: aa1503e0    	mov	x0, x21
10a0beab4: 955e726a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0beab8: aa1403e0    	mov	x0, x20
10a0beabc: 955e7268    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0beac0: aa1303e0    	mov	x0, x19
10a0beac4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10a0beac8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10a0beacc: a8c357f6    	ldp	x22, x21, [sp], #0x30
10a0bead0: 155e726a    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>
