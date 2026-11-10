
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100177bb4: b00fae48    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
100177bb8: 52800029    	mov	w9, #0x1                ; =1
100177bbc: 39118d09    	strb	w9, [x8, #0x463]
100177bc0: d00f6028    	adrp	x8, 0x11ed7d000 <dyld_stub_binder+0x11ed7d000>
100177bc4: b98b0108    	ldrsw	x8, [x8, #0xb00] ; ivar: AudioReceiver.m_audioPlayer offset=8
100177bc8: f8686800    	ldr	x0, [x0, x8]
100177bcc: eb02001f    	cmp	x0, x2
100177bd0: 54000040    	b.eq	0x100177bd8 <__text+0x16fbd8>
100177bd4: d65f03c0    	ret
100177bd8: d101c3ff    	sub	sp, sp, #0x70
100177bdc: a9035ff8    	stp	x24, x23, [sp, #0x30]
100177be0: a90457f6    	stp	x22, x21, [sp, #0x40]
100177be4: a9054ff4    	stp	x20, x19, [sp, #0x50]
100177be8: a9067bfd    	stp	x29, x30, [sp, #0x60]
100177bec: 910183fd    	add	x29, sp, #0x60
100177bf0: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177bf4: f9455d01    	ldr	x1, [x8, #0xab8] ; selector: getUserData
100177bf8: 95eac01b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177bfc: aa1d03fd    	mov	x29, x29
100177c00: 95eac020    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100177c04: aa0003f3    	mov	x19, x0
100177c08: f00f5cc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100177c0c: f943c100    	ldr	x0, [x8, #0x780]
100177c10: d00f4288    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100177c14: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
100177c18: 95eac013    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177c1c: aa1d03fd    	mov	x29, x29
100177c20: 95eac018    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100177c24: aa0003f4    	mov	x20, x0
100177c28: 900f5cc8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
100177c2c: f9432d15    	ldr	x21, [x8, #0x658]
100177c30: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177c34: f9456116    	ldr	x22, [x8, #0xac0] ; selector: OnPausePlaying:
100177c38: b00eaea8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100177c3c: f9449908    	ldr	x8, [x8, #0x930]
100177c40: f90007e8    	str	x8, [sp, #0x8]
100177c44: 900bba88    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
100177c48: fd434100    	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
100177c4c: 90000008    	adrp	x8, 0x100177000 <__text+0x16f000>
100177c50: 91330108    	add	x8, x8, #0xcc0
100177c54: b00e0849    	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
100177c58: 911f8129    	add	x9, x9, #0x7e0
100177c5c: fd000be0    	str	d0, [sp, #0x10]
100177c60: a901a7e8    	stp	x8, x9, [sp, #0x18]
100177c64: f90017f3    	str	x19, [sp, #0x28]
100177c68: d00f4288    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100177c6c: f9472d17    	ldr	x23, [x8, #0xe58] ; selector: callExtension:selector:block:
100177c70: aa1303e0    	mov	x0, x19
100177c74: 95eac000    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100177c78: 910023e4    	add	x4, sp, #0x8
100177c7c: aa1403e0    	mov	x0, x20
100177c80: aa1703e1    	mov	x1, x23
100177c84: aa1503e2    	mov	x2, x21
100177c88: aa1603e3    	mov	x3, x22
100177c8c: 95eabff6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177c90: aa1403e0    	mov	x0, x20
100177c94: 95eabff7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177c98: f94017e0    	ldr	x0, [sp, #0x28]
100177c9c: 95eabff5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177ca0: aa1303e0    	mov	x0, x19
100177ca4: 95eabff3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177ca8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
100177cac: a9454ff4    	ldp	x20, x19, [sp, #0x50]
100177cb0: a94457f6    	ldp	x22, x21, [sp, #0x40]
100177cb4: a9435ff8    	ldp	x24, x23, [sp, #0x30]
100177cb8: 9101c3ff    	add	sp, sp, #0x70
100177cbc: d65f03c0    	ret
100177cc0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100177cc4: a9014ff4    	stp	x20, x19, [sp, #0x10]
100177cc8: a9027bfd    	stp	x29, x30, [sp, #0x20]
100177ccc: 910083fd    	add	x29, sp, #0x20
100177cd0: aa0103f3    	mov	x19, x1
100177cd4: f9401014    	ldr	x20, [x0, #0x20]
100177cd8: b00f42c8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
100177cdc: f9433115    	ldr	x21, [x8, #0x660] ; selector: msgWrap
100177ce0: aa0103e0    	mov	x0, x1
100177ce4: 95eabfe4    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100177ce8: aa1403e0    	mov	x0, x20
100177cec: aa1503e1    	mov	x1, x21
100177cf0: 95eabfdd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177cf4: aa1d03fd    	mov	x29, x29
100177cf8: 95eabfe2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100177cfc: aa0003f4    	mov	x20, x0
100177d00: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177d04: f9456101    	ldr	x1, [x8, #0xac0] ; selector: OnPausePlaying:
100177d08: aa1303e0    	mov	x0, x19
100177d0c: aa1403e2    	mov	x2, x20
100177d10: 95eabfd5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177d14: aa1303e0    	mov	x0, x19
100177d18: 95eabfd6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177d1c: aa1403e0    	mov	x0, x20
100177d20: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100177d24: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100177d28: a8c357f6    	ldp	x22, x21, [sp], #0x30
100177d2c: 15eabfd1    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
