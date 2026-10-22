
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108fe775c: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
108fe7760: a9015ff8    	stp	x24, x23, [sp, #0x10]
108fe7764: a90257f6    	stp	x22, x21, [sp, #0x20]
108fe7768: a9034ff4    	stp	x20, x19, [sp, #0x30]
108fe776c: a9047bfd    	stp	x29, x30, [sp, #0x40]
108fe7770: 910103fd    	add	x29, sp, #0x40
108fe7774: aa0003f3    	mov	x19, x0
108fe7778: d00be328    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108fe777c: 52800029    	mov	w9, #0x1                ; =1
108fe7780: 3938b509    	strb	w9, [x8, #0xe2d]
108fe7784: b00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe7788: b9845d15    	ldrsw	x21, [x8, #0x45c]
108fe778c: f8756800    	ldr	x0, [x0, x21]
108fe7790: 900b8928    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
108fe7794: f947a514    	ldr	x20, [x8, #0xf48] ; width
108fe7798: aa1403e1    	mov	x1, x20
108fe779c: 95a1cf2a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe77a0: 1e741001    	fmov	d1, #-8.00000000
108fe77a4: 1e612808    	fadd	d8, d0, d1
108fe77a8: f8756a60    	ldr	x0, [x19, x21]
108fe77ac: f00b88c8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
108fe77b0: f9449d01    	ldr	x1, [x8, #0x938] ; height
108fe77b4: 95a1cf24    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe77b8: 1e6c1001    	fmov	d1, #0.50000000
108fe77bc: 1e610809    	fmul	d9, d0, d1
108fe77c0: b00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe77c4: b9849118    	ldrsw	x24, [x8, #0x490]
108fe77c8: f8786a60    	ldr	x0, [x19, x24]
108fe77cc: f00b8917    	adrp	x23, 0x12010a000 <dyld_stub_binder+0x12010a000>
108fe77d0: b40003e0    	cbz	x0, 0x108fe784c <_Flutter_MMFoundation_BindContext+0x54c3430>
108fe77d4: f9475ee1    	ldr	x1, [x23, #0xeb8] ; superview
108fe77d8: 95a1cf1b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe77dc: aa1d03fd    	mov	x29, x29
108fe77e0: 95a1cf1c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe77e4: b4000340    	cbz	x0, 0x108fe784c <_Flutter_MMFoundation_BindContext+0x54c3430>
108fe77e8: aa0003f5    	mov	x21, x0
108fe77ec: f8786a60    	ldr	x0, [x19, x24]
108fe77f0: 900b88e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
108fe77f4: f943f901    	ldr	x1, [x8, #0x7f0] ; isHidden
108fe77f8: 95a1cf13    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe77fc: aa0003f6    	mov	x22, x0
108fe7800: aa1503e0    	mov	x0, x21
108fe7804: 95a1cf16    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe7808: 37000236    	tbnz	w22, #0x0, 0x108fe784c <_Flutter_MMFoundation_BindContext+0x54c3430>
108fe780c: f8786a60    	ldr	x0, [x19, x24]
108fe7810: b00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe7814: f9401501    	ldr	x1, [x8, #0x28] ; setRight:
108fe7818: 1e604100    	fmov	d0, d8
108fe781c: 95a1cf0a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7820: f8786a60    	ldr	x0, [x19, x24]
108fe7824: b00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe7828: f9401901    	ldr	x1, [x8, #0x30] ; setCenterY:
108fe782c: 1e604120    	fmov	d0, d9
108fe7830: 95a1cf05    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7834: f8786a60    	ldr	x0, [x19, x24]
108fe7838: aa1403e1    	mov	x1, x20
108fe783c: 95a1cf02    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7840: 1e621001    	fmov	d1, #4.00000000
108fe7844: 1e612800    	fadd	d0, d0, d1
108fe7848: 1e603908    	fsub	d8, d8, d0
108fe784c: b00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe7850: b9849918    	ldrsw	x24, [x8, #0x498]
108fe7854: f8786a60    	ldr	x0, [x19, x24]
108fe7858: b40003e0    	cbz	x0, 0x108fe78d4 <_Flutter_MMFoundation_BindContext+0x54c34b8>
108fe785c: f9475ee1    	ldr	x1, [x23, #0xeb8] ; superview
108fe7860: 95a1cef9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7864: aa1d03fd    	mov	x29, x29
108fe7868: 95a1cefa    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe786c: b4000340    	cbz	x0, 0x108fe78d4 <_Flutter_MMFoundation_BindContext+0x54c34b8>
108fe7870: aa0003f5    	mov	x21, x0
108fe7874: f8786a60    	ldr	x0, [x19, x24]
108fe7878: 900b88e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
108fe787c: f943f901    	ldr	x1, [x8, #0x7f0] ; isHidden
108fe7880: 95a1cef1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7884: aa0003f6    	mov	x22, x0
108fe7888: aa1503e0    	mov	x0, x21
108fe788c: 95a1cef4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe7890: 37000236    	tbnz	w22, #0x0, 0x108fe78d4 <_Flutter_MMFoundation_BindContext+0x54c34b8>
108fe7894: f8786a60    	ldr	x0, [x19, x24]
108fe7898: b00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe789c: f9401501    	ldr	x1, [x8, #0x28] ; setRight:
108fe78a0: 1e604100    	fmov	d0, d8
108fe78a4: 95a1cee8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe78a8: f8786a60    	ldr	x0, [x19, x24]
108fe78ac: b00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe78b0: f9401901    	ldr	x1, [x8, #0x30] ; setCenterY:
108fe78b4: 1e604120    	fmov	d0, d9
108fe78b8: 95a1cee3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe78bc: f8786a60    	ldr	x0, [x19, x24]
108fe78c0: aa1403e1    	mov	x1, x20
108fe78c4: 95a1cee0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe78c8: 1e621001    	fmov	d1, #4.00000000
108fe78cc: 1e612800    	fadd	d0, d0, d1
108fe78d0: 1e603908    	fsub	d8, d8, d0
108fe78d4: b00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe78d8: b9849518    	ldrsw	x24, [x8, #0x494]
108fe78dc: f8786a60    	ldr	x0, [x19, x24]
108fe78e0: b40003e0    	cbz	x0, 0x108fe795c <_Flutter_MMFoundation_BindContext+0x54c3540>
108fe78e4: f9475ee1    	ldr	x1, [x23, #0xeb8] ; superview
108fe78e8: 95a1ced7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe78ec: aa1d03fd    	mov	x29, x29
108fe78f0: 95a1ced8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe78f4: b4000340    	cbz	x0, 0x108fe795c <_Flutter_MMFoundation_BindContext+0x54c3540>
108fe78f8: aa0003f5    	mov	x21, x0
108fe78fc: f8786a60    	ldr	x0, [x19, x24]
108fe7900: 900b88e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
108fe7904: f943f901    	ldr	x1, [x8, #0x7f0] ; isHidden
108fe7908: 95a1cecf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe790c: aa0003f6    	mov	x22, x0
108fe7910: aa1503e0    	mov	x0, x21
108fe7914: 95a1ced2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe7918: 37000236    	tbnz	w22, #0x0, 0x108fe795c <_Flutter_MMFoundation_BindContext+0x54c3540>
108fe791c: f8786a60    	ldr	x0, [x19, x24]
108fe7920: b00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe7924: f9401501    	ldr	x1, [x8, #0x28] ; setRight:
108fe7928: 1e604100    	fmov	d0, d8
108fe792c: 95a1cec6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7930: f8786a60    	ldr	x0, [x19, x24]
108fe7934: b00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe7938: f9401901    	ldr	x1, [x8, #0x30] ; setCenterY:
108fe793c: 1e604120    	fmov	d0, d9
108fe7940: 95a1cec1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7944: f8786a60    	ldr	x0, [x19, x24]
108fe7948: aa1403e1    	mov	x1, x20
108fe794c: 95a1cebe    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7950: 1e621001    	fmov	d1, #4.00000000
108fe7954: 1e612800    	fadd	d0, d0, d1
108fe7958: 1e603908    	fsub	d8, d8, d0
108fe795c: b00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe7960: b9848d18    	ldrsw	x24, [x8, #0x48c]
108fe7964: f8786a60    	ldr	x0, [x19, x24]
108fe7968: b40001e0    	cbz	x0, 0x108fe79a4 <_Flutter_MMFoundation_BindContext+0x54c3588>
108fe796c: f9475ee1    	ldr	x1, [x23, #0xeb8] ; superview
108fe7970: 95a1ceb5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7974: aa1d03fd    	mov	x29, x29
108fe7978: 95a1ceb6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe797c: b4000140    	cbz	x0, 0x108fe79a4 <_Flutter_MMFoundation_BindContext+0x54c3588>
108fe7980: aa0003f5    	mov	x21, x0
108fe7984: f8786a60    	ldr	x0, [x19, x24]
108fe7988: 900b88e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
108fe798c: f943f901    	ldr	x1, [x8, #0x7f0] ; isHidden
108fe7990: 95a1cead    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7994: aa0003f6    	mov	x22, x0
108fe7998: aa1503e0    	mov	x0, x21
108fe799c: 95a1ceb0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe79a0: 360000f6    	tbz	w22, #0x0, 0x108fe79bc <_Flutter_MMFoundation_BindContext+0x54c35a0>
108fe79a4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
108fe79a8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
108fe79ac: a94257f6    	ldp	x22, x21, [sp, #0x20]
108fe79b0: a9415ff8    	ldp	x24, x23, [sp, #0x10]
108fe79b4: 6cc523e9    	ldp	d9, d8, [sp], #0x50
108fe79b8: d65f03c0    	ret
108fe79bc: f8786a60    	ldr	x0, [x19, x24]
108fe79c0: b00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe79c4: f9401501    	ldr	x1, [x8, #0x28] ; setRight:
108fe79c8: 1e604100    	fmov	d0, d8
108fe79cc: 95a1ce9e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe79d0: f8786a60    	ldr	x0, [x19, x24]
108fe79d4: b00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe79d8: f9401901    	ldr	x1, [x8, #0x30] ; setCenterY:
108fe79dc: 1e604120    	fmov	d0, d9
108fe79e0: 95a1ce99    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe79e4: f8786a60    	ldr	x0, [x19, x24]
108fe79e8: aa1403e1    	mov	x1, x20
108fe79ec: a9447bfd    	ldp	x29, x30, [sp, #0x40]
108fe79f0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
108fe79f4: a94257f6    	ldp	x22, x21, [sp, #0x20]
108fe79f8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
108fe79fc: 6cc523e9    	ldp	d9, d8, [sp], #0x50
108fe7a00: 15a1ce91    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
