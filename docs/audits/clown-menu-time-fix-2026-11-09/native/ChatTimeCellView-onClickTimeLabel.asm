
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fdf9b0: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
100fdf9b4: a9015ff8    	stp	x24, x23, [sp, #0x10]
100fdf9b8: a90257f6    	stp	x22, x21, [sp, #0x20]
100fdf9bc: a9034ff4    	stp	x20, x19, [sp, #0x30]
100fdf9c0: a9047bfd    	stp	x29, x30, [sp, #0x40]
100fdf9c4: 910103fd    	add	x29, sp, #0x40
100fdf9c8: aa0003f3    	mov	x19, x0
100fdf9cc: 900f3b28    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100fdf9d0: 52800029    	mov	w9, #0x1                ; =1
100fdf9d4: 3922c509    	strb	w9, [x8, #0x8b1]
100fdf9d8: f00ecf68    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
100fdf9dc: f941c114    	ldr	x20, [x8, #0x380]
100fdf9e0: aa1403e1    	mov	x1, x20
100fdf9e4: 95b120a0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdf9e8: aa1d03fd    	mov	x29, x29
100fdf9ec: 95b120a5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdf9f0: aa0003f5    	mov	x21, x0
100fdf9f4: b00ed1c8    	adrp	x8, 0x11ea18000 <dyld_stub_binder+0x11ea18000>
100fdf9f8: f9438116    	ldr	x22, [x8, #0x700]
100fdf9fc: aa1603e1    	mov	x1, x22
100fdfa00: 95b12099    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfa04: 4ea01c08    	mov.16b	v8, v0
100fdfa08: aa1303e0    	mov	x0, x19
100fdfa0c: aa1403e1    	mov	x1, x20
100fdfa10: 95b12095    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfa14: aa1d03fd    	mov	x29, x29
100fdfa18: 95b1209a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdfa1c: aa0003f4    	mov	x20, x0
100fdfa20: b00ecf88    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
100fdfa24: f943e908    	ldr	x8, [x8, #0x7d0]
100fdfa28: 1e602108    	fcmp	d8, #0.0
100fdfa2c: 9a96d101    	csel	x1, x8, x22, le
100fdfa30: 95b1208d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfa34: 4ea01c08    	mov.16b	v8, v0
100fdfa38: aa1403e0    	mov	x0, x20
100fdfa3c: 95b1208d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdfa40: aa1503e0    	mov	x0, x21
100fdfa44: 95b1208b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdfa48: f00ee628    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100fdfa4c: f9469d14    	ldr	x20, [x8, #0xd38]
100fdfa50: aa1303e0    	mov	x0, x19
100fdfa54: aa1403e1    	mov	x1, x20
100fdfa58: 95b12083    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfa5c: aa1d03fd    	mov	x29, x29
100fdfa60: 95b12088    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdfa64: b4000480    	cbz	x0, 0x100fdfaf4 <__text+0xfd7af4>
100fdfa68: aa0003f6    	mov	x22, x0
100fdfa6c: aa1303e0    	mov	x0, x19
100fdfa70: aa1403e1    	mov	x1, x20
100fdfa74: 95b1207c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfa78: aa1d03fd    	mov	x29, x29
100fdfa7c: 95b12081    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdfa80: aa0003f7    	mov	x23, x0
100fdfa84: b00ed1c8    	adrp	x8, 0x11ea18000 <dyld_stub_binder+0x11ea18000>
100fdfa88: f9438515    	ldr	x21, [x8, #0x708]
100fdfa8c: f00ee648    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
100fdfa90: f9440501    	ldr	x1, [x8, #0x808]
100fdfa94: aa1503e2    	mov	x2, x21
100fdfa98: 95b12073    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfa9c: aa0003f8    	mov	x24, x0
100fdfaa0: aa1703e0    	mov	x0, x23
100fdfaa4: 95b12073    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdfaa8: aa1603e0    	mov	x0, x22
100fdfaac: 95b12071    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdfab0: 34000238    	cbz	w24, 0x100fdfaf4 <__text+0xfd7af4>
100fdfab4: aa1303e0    	mov	x0, x19
100fdfab8: aa1403e1    	mov	x1, x20
100fdfabc: 95b1206a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfac0: aa1d03fd    	mov	x29, x29
100fdfac4: 95b1206f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdfac8: aa0003f3    	mov	x19, x0
100fdfacc: aa1503e1    	mov	x1, x21
100fdfad0: 4ea81d00    	mov.16b	v0, v8
100fdfad4: 95b12064    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfad8: aa1303e0    	mov	x0, x19
100fdfadc: a9447bfd    	ldp	x29, x30, [sp, #0x40]
100fdfae0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
100fdfae4: a94257f6    	ldp	x22, x21, [sp, #0x20]
100fdfae8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
100fdfaec: 6cc523e9    	ldp	d9, d8, [sp], #0x50
100fdfaf0: 15b12060    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdfaf4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
100fdfaf8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
100fdfafc: a94257f6    	ldp	x22, x21, [sp, #0x20]
100fdfb00: a9415ff8    	ldp	x24, x23, [sp, #0x10]
100fdfb04: 6cc523e9    	ldp	d9, d8, [sp], #0x50
100fdfb08: d65f03c0    	ret
