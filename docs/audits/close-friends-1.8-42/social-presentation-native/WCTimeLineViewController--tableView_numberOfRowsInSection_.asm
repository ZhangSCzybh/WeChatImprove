
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0bfaac: d10143ff    	sub	sp, sp, #0x50
10a0bfab0: a90257f6    	stp	x22, x21, [sp, #0x20]
10a0bfab4: a9034ff4    	stp	x20, x19, [sp, #0x30]
10a0bfab8: a9047bfd    	stp	x29, x30, [sp, #0x40]
10a0bfabc: 910103fd    	add	x29, sp, #0x40
10a0bfac0: aa0203f4    	mov	x20, x2
10a0bfac4: aa0003f3    	mov	x19, x0
10a0bfac8: d00b5c88    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0bfacc: 52800029    	mov	w9, #0x1                ; =1
10a0bfad0: 39123109    	strb	w9, [x8, #0x48c]
10a0bfad4: f90007e3    	str	x3, [sp, #0x8]
10a0bfad8: b00b0da8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0bfadc: b9827915    	ldrsw	x21, [x8, #0x278]
10a0bfae0: 910023e8    	add	x8, sp, #0x8
10a0bfae4: f9000fe8    	str	x8, [sp, #0x18]
10a0bfae8: aa0203e0    	mov	x0, x2
10a0bfaec: 955e6e55    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a0bfaf0: b0080d62    	adrp	x2, 0x11a26c000 <dyld_stub_binder+0x11a26c000>
10a0bfaf4: 91282842    	add	x2, x2, #0xa0a
10a0bfaf8: 8b150260    	add	x0, x19, x21
10a0bfafc: 910023e1    	add	x1, sp, #0x8
10a0bfb00: 910063e3    	add	x3, sp, #0x18
10a0bfb04: 91005fe4    	add	x4, sp, #0x17
10a0bfb08: 97323a1d    	bl	0x106d4e37c <_Flutter_MMFoundation_BindContext+0x3229f60>
10a0bfb0c: b9402815    	ldr	w21, [x0, #0x28]
10a0bfb10: aa1403e0    	mov	x0, x20
10a0bfb14: 955e6e52    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bfb18: 510006a8    	sub	w8, w21, #0x1
10a0bfb1c: 7100191f    	cmp	w8, #0x6
10a0bfb20: 540000c2    	b.hs	0x10a0bfb38 <_Flutter_MMFoundation_BindContext+0x659b71c>
10a0bfb24: 528006e9    	mov	w9, #0x37               ; =55
10a0bfb28: 1ac82528    	lsr	w8, w9, w8
10a0bfb2c: 36000068    	tbz	w8, #0x0, 0x10a0bfb38 <_Flutter_MMFoundation_BindContext+0x659b71c>
10a0bfb30: 52800033    	mov	w19, #0x1               ; =1
10a0bfb34: 1400003b    	b	0x10a0bfc20 <_Flutter_MMFoundation_BindContext+0x659b804>
10a0bfb38: f94007e2    	ldr	x2, [sp, #0x8]
10a0bfb3c: f00afea8    	adrp	x8, 0x120096000 <dyld_stub_binder+0x120096000>
10a0bfb40: f944e501    	ldr	x1, [x8, #0x9c8] ; calcDataItemIndex:
10a0bfb44: aa1303e0    	mov	x0, x19
10a0bfb48: 955e6e3f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfb4c: aa0003f3    	mov	x19, x0
10a0bfb50: 900b05a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0bfb54: f945e900    	ldr	x0, [x8, #0xbd0]
10a0bfb58: b00b0208    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0bfb5c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a0bfb60: 955e6e39    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfb64: aa1d03fd    	mov	x29, x29
10a0bfb68: 955e6e3a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bfb6c: aa0003f4    	mov	x20, x0
10a0bfb70: b00b05a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0bfb74: f9428500    	ldr	x0, [x8, #0x508]
10a0bfb78: 900b0208    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a0bfb7c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a0bfb80: 955e6e31    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfb84: aa0003e2    	mov	x2, x0
10a0bfb88: d00aebc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0bfb8c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a0bfb90: aa1403e0    	mov	x0, x20
10a0bfb94: 955e6e2c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfb98: aa1d03fd    	mov	x29, x29
10a0bfb9c: 955e6e2d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bfba0: aa0003f5    	mov	x21, x0
10a0bfba4: d00afa28    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
10a0bfba8: f944c501    	ldr	x1, [x8, #0x988] ; getTimelineDataItemOfIndex:
10a0bfbac: aa1303e2    	mov	x2, x19
10a0bfbb0: 955e6e25    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfbb4: aa1d03fd    	mov	x29, x29
10a0bfbb8: 955e6e26    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bfbbc: aa0003f6    	mov	x22, x0
10a0bfbc0: aa1503e0    	mov	x0, x21
10a0bfbc4: 955e6e26    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bfbc8: aa1403e0    	mov	x0, x20
10a0bfbcc: 955e6e24    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bfbd0: 900b06e8    	adrp	x8, 0x12019b000 <dyld_stub_binder+0x12019b000>
10a0bfbd4: f9467900    	ldr	x0, [x8, #0xcf0]
10a0bfbd8: d00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0bfbdc: f942a901    	ldr	x1, [x8, #0x550] ; getCommentViewCountForDataItem:
10a0bfbe0: aa1603e2    	mov	x2, x22
10a0bfbe4: 955e6e18    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfbe8: aa0003f3    	mov	x19, x0
10a0bfbec: 900b06e8    	adrp	x8, 0x12019b000 <dyld_stub_binder+0x12019b000>
10a0bfbf0: f940dd00    	ldr	x0, [x8, #0x1b8] ; 0r=
10a0bfbf4: f00af9e8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
10a0bfbf8: f9460901    	ldr	x1, [x8, #0xc10] ; isAdFireworkCheerCommentStyle:
10a0bfbfc: aa1603e2    	mov	x2, x22
10a0bfc00: 955e6e11    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfc04: 7100001f    	cmp	w0, #0x0
10a0bfc08: 52800028    	mov	w8, #0x1                ; =1
10a0bfc0c: 9a880508    	cinc	x8, x8, ne
10a0bfc10: 8b080268    	add	x8, x19, x8
10a0bfc14: 91000513    	add	x19, x8, #0x1
10a0bfc18: aa1603e0    	mov	x0, x22
10a0bfc1c: 955e6e10    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bfc20: aa1303e0    	mov	x0, x19
10a0bfc24: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10a0bfc28: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10a0bfc2c: a94257f6    	ldp	x22, x21, [sp, #0x20]
10a0bfc30: 910143ff    	add	sp, sp, #0x50
10a0bfc34: d65f03c0    	ret
