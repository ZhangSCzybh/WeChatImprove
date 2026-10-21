
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0ee27c: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
10a0ee280: a9015ff8    	stp	x24, x23, [sp, #0x10]
10a0ee284: a90257f6    	stp	x22, x21, [sp, #0x20]
10a0ee288: a9034ff4    	stp	x20, x19, [sp, #0x30]
10a0ee28c: a9047bfd    	stp	x29, x30, [sp, #0x40]
10a0ee290: 910103fd    	add	x29, sp, #0x40
10a0ee294: aa0003f3    	mov	x19, x0
10a0ee298: f00b5b08    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0ee29c: 52800029    	mov	w9, #0x1                ; =1
10a0ee2a0: 3914a109    	strb	w9, [x8, #0x528]
10a0ee2a4: d00aeea8    	adrp	x8, 0x11fec4000 <dyld_stub_binder+0x11fec4000>
10a0ee2a8: f945b514    	ldr	x20, [x8, #0xb68] ; inputController
10a0ee2ac: aa1403e1    	mov	x1, x20
10a0ee2b0: 955db465    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ee2b4: aa1d03fd    	mov	x29, x29
10a0ee2b8: 955db466    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0ee2bc: aa0003f5    	mov	x21, x0
10a0ee2c0: d00aeea8    	adrp	x8, 0x11fec4000 <dyld_stub_binder+0x11fec4000>
10a0ee2c4: f945c101    	ldr	x1, [x8, #0xb80] ; eInputMode
10a0ee2c8: 955db45f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ee2cc: b40006e0    	cbz	x0, 0x10a0ee3a8 <_Flutter_MMFoundation_BindContext+0x65c9f8c>
10a0ee2d0: d00af828    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
10a0ee2d4: f9419d16    	ldr	x22, [x8, #0x338] ; inputDataItem
10a0ee2d8: aa1303e0    	mov	x0, x19
10a0ee2dc: aa1603e1    	mov	x1, x22
10a0ee2e0: 955db459    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ee2e4: aa1d03fd    	mov	x29, x29
10a0ee2e8: 955db45a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0ee2ec: aa0003f7    	mov	x23, x0
10a0ee2f0: 955db45b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ee2f4: aa1503e0    	mov	x0, x21
10a0ee2f8: 955db459    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ee2fc: b4000657    	cbz	x23, 0x10a0ee3c4 <_Flutter_MMFoundation_BindContext+0x65c9fa8>
10a0ee300: aa1303e0    	mov	x0, x19
10a0ee304: aa1603e1    	mov	x1, x22
10a0ee308: 955db44f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ee30c: aa1d03fd    	mov	x29, x29
10a0ee310: 955db450    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0ee314: aa0003f6    	mov	x22, x0
10a0ee318: f00aeaa8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
10a0ee31c: f940cd01    	ldr	x1, [x8, #0x198] ; tid
10a0ee320: 955db449    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ee324: aa1d03fd    	mov	x29, x29
10a0ee328: 955db44a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0ee32c: aa0003f7    	mov	x23, x0
10a0ee330: d00af828    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
10a0ee334: f9431501    	ldr	x1, [x8, #0x628] ; sectionIndexForDataItemWithTid:
10a0ee338: aa1303e0    	mov	x0, x19
10a0ee33c: aa1703e2    	mov	x2, x23
10a0ee340: 955db441    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ee344: aa0003f5    	mov	x21, x0
10a0ee348: aa1703e0    	mov	x0, x23
10a0ee34c: 955db444    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ee350: aa1603e0    	mov	x0, x22
10a0ee354: 955db442    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ee358: 9e6703e8    	fmov	d8, xzr
10a0ee35c: 92f00008    	mov	x8, #0x7fffffffffffffff ; =9223372036854775807
10a0ee360: eb0802bf    	cmp	x21, x8
10a0ee364: 540000e0    	b.eq	0x10a0ee380 <_Flutter_MMFoundation_BindContext+0x65c9f64>
10a0ee368: 900afbe8    	adrp	x8, 0x12006a000 <dyld_stub_binder+0x12006a000>
10a0ee36c: f9475d01    	ldr	x1, [x8, #0xeb8] ; totalHeightFromTopToSection:
10a0ee370: 910006a2    	add	x2, x21, #0x1
10a0ee374: aa1303e0    	mov	x0, x19
10a0ee378: 955db433    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ee37c: 1e604008    	fmov	d8, d0
10a0ee380: aa1303e0    	mov	x0, x19
10a0ee384: aa1403e1    	mov	x1, x20
10a0ee388: 955db42f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ee38c: aa1d03fd    	mov	x29, x29
10a0ee390: 955db430    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0ee394: aa0003f5    	mov	x21, x0
10a0ee398: 900af888    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
10a0ee39c: f9464101    	ldr	x1, [x8, #0xc80] ; updateScrollViewY:
10a0ee3a0: 1e604100    	fmov	d0, d8
10a0ee3a4: 955db428    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ee3a8: aa1503e0    	mov	x0, x21
10a0ee3ac: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10a0ee3b0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10a0ee3b4: a94257f6    	ldp	x22, x21, [sp, #0x20]
10a0ee3b8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10a0ee3bc: 6cc523e9    	ldp	d9, d8, [sp], #0x50
10a0ee3c0: 155db427    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ee3c4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10a0ee3c8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10a0ee3cc: a94257f6    	ldp	x22, x21, [sp, #0x20]
10a0ee3d0: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10a0ee3d4: 6cc523e9    	ldp	d9, d8, [sp], #0x50
10a0ee3d8: d65f03c0    	ret
