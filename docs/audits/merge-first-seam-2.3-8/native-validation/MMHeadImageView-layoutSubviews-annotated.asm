
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
103dd6dd8: d101c3ff    	sub	sp, sp, #0x70
103dd6ddc: 6d0223e9    	stp	d9, d8, [sp, #0x20]
103dd6de0: a9035ff8    	stp	x24, x23, [sp, #0x30]
103dd6de4: a90457f6    	stp	x22, x21, [sp, #0x40]
103dd6de8: a9054ff4    	stp	x20, x19, [sp, #0x50]
103dd6dec: a9067bfd    	stp	x29, x30, [sp, #0x60]
103dd6df0: 910183fd    	add	x29, sp, #0x60
103dd6df4: aa0003f3    	mov	x19, x0
103dd6df8: 900dcbc8    	adrp	x8, 0x11f74e000 <dyld_stub_binder+0x11f74e000>
103dd6dfc: 52800029    	mov	w9, #0x1                ; =1
103dd6e00: 3904b909    	strb	w9, [x8, #0x12e]
103dd6e04: 900d7c68    	adrp	x8, 0x11ed62000 <dyld_stub_binder+0x11ed62000>
103dd6e08: f943b908    	ldr	x8, [x8, #0x770]
103dd6e0c: a90123e0    	stp	x0, x8, [sp, #0x10]
103dd6e10: 900d5fc8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
103dd6e14: f9415901    	ldr	x1, [x8, #0x2b0] ; selector: layoutSubviews
103dd6e18: 910043e0    	add	x0, sp, #0x10
103dd6e1c: 94f94393    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
103dd6e20: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6e24: b98f8517    	ldrsw	x23, [x8, #0xf84] ; ivar: MMHeadImageView._headImageView offset=144
103dd6e28: f8776a60    	ldr	x0, [x19, x23]
103dd6e2c: b00d7688    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
103dd6e30: f947ed15    	ldr	x21, [x8, #0xfd8] ; selector: image
103dd6e34: aa1503e1    	mov	x1, x21
103dd6e38: 94f9438b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6e3c: aa1d03fd    	mov	x29, x29
103dd6e40: 94f94390    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
103dd6e44: b4000240    	cbz	x0, 0x103dd6e8c <_Flutter_MMFoundation_BindContext+0x5db58>
103dd6e48: aa0003f4    	mov	x20, x0
103dd6e4c: f8776a60    	ldr	x0, [x19, x23]
103dd6e50: aa1503e1    	mov	x1, x21
103dd6e54: 94f94384    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6e58: aa1d03fd    	mov	x29, x29
103dd6e5c: 94f94389    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
103dd6e60: aa0003f5    	mov	x21, x0
103dd6e64: 94f94385    	bl	0x107c27c78 <_Flutter_MMFoundation_BindContext+0x3eae944>
103dd6e68: f00d7668    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
103dd6e6c: f941ed01    	ldr	x1, [x8, #0x3d8] ; selector: CGImage
103dd6e70: 94f9437d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6e74: aa0003f6    	mov	x22, x0
103dd6e78: aa1503e0    	mov	x0, x21
103dd6e7c: 94f9437d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd6e80: aa1403e0    	mov	x0, x20
103dd6e84: 94f9437b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd6e88: b5000536    	cbnz	x22, 0x103dd6f2c <_Flutter_MMFoundation_BindContext+0x5dbf8>
103dd6e8c: 900d79e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
103dd6e90: f9430d14    	ldr	x20, [x8, #0x618]
103dd6e94: 900d79e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
103dd6e98: f9431d00    	ldr	x0, [x8, #0x638]
103dd6e9c: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6ea0: b98f9916    	ldrsw	x22, [x8, #0xf98] ; ivar: MMHeadImageView._nsUsrName offset=24
103dd6ea4: f8766a62    	ldr	x2, [x19, x22]
103dd6ea8: d00d5fa8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
103dd6eac: f947dd01    	ldr	x1, [x8, #0xfb8] ; selector: generatePrivacyString:
103dd6eb0: 94f9436d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6eb4: aa1d03fd    	mov	x29, x29
103dd6eb8: 94f94372    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
103dd6ebc: aa0003f5    	mov	x21, x0
103dd6ec0: f00d5f88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
103dd6ec4: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
103dd6ec8: f00ca208    	adrp	x8, 0x11d219000 <dyld_stub_binder+0x11d219000>
103dd6ecc: 910d6108    	add	x8, x8, #0x358 ; CFString: layoutSubViews-->nsUsrName:%@
103dd6ed0: a90003e8    	stp	x8, x0, [sp]
103dd6ed4: 900b14e3    	adrp	x3, 0x11a072000 <dyld_stub_binder+0x11a072000>
103dd6ed8: 913b4463    	add	x3, x3, #0xed1
103dd6edc: f00b14e5    	adrp	x5, 0x11a075000 <dyld_stub_binder+0x11a075000>
103dd6ee0: 912fcca5    	add	x5, x5, #0xbf3
103dd6ee4: f00b14e7    	adrp	x7, 0x11a075000 <dyld_stub_binder+0x11a075000>
103dd6ee8: 913018e7    	add	x7, x7, #0xc06
103dd6eec: aa1403e0    	mov	x0, x20
103dd6ef0: 52800022    	mov	w2, #0x1                ; =1
103dd6ef4: 52800004    	mov	w4, #0x0                ; =0
103dd6ef8: 52801046    	mov	w6, #0x82               ; =130
103dd6efc: 94f9435a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6f00: aa1503e0    	mov	x0, x21
103dd6f04: 94f9435b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd6f08: f8766a62    	ldr	x2, [x19, x22]
103dd6f0c: f00d6868    	adrp	x8, 0x11eae5000 <dyld_stub_binder+0x11eae5000>
103dd6f10: f943cd01    	ldr	x1, [x8, #0x798] ; selector: setHeadImageByName:
103dd6f14: aa1303e0    	mov	x0, x19
103dd6f18: 94f94353    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6f1c: f00d6868    	adrp	x8, 0x11eae5000 <dyld_stub_binder+0x11eae5000>
103dd6f20: f943d101    	ldr	x1, [x8, #0x7a0] ; selector: checkAndUpdateImage
103dd6f24: aa1303e0    	mov	x0, x19
103dd6f28: 94f9434f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6f2c: f00d76a8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
103dd6f30: f947d514    	ldr	x20, [x8, #0xfa8] ; selector: width
103dd6f34: aa1303e0    	mov	x0, x19
103dd6f38: aa1403e1    	mov	x1, x20
103dd6f3c: 94f9434a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6f40: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6f44: b98f7508    	ldrsw	x8, [x8, #0xf74] ; ivar: MMHeadImageView._imageSize offset=160
103dd6f48: 8b080276    	add	x22, x19, x8
103dd6f4c: fd4002c1    	ldr	d1, [x22]
103dd6f50: 1e613800    	fsub	d0, d0, d1
103dd6f54: 1e6c1009    	fmov	d9, #0.50000000
103dd6f58: 1e690808    	fmul	d8, d0, d9
103dd6f5c: b00d7688    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
103dd6f60: f9478115    	ldr	x21, [x8, #0xf00] ; selector: height
103dd6f64: aa1303e0    	mov	x0, x19
103dd6f68: aa1503e1    	mov	x1, x21
103dd6f6c: 94f9433e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6f70: 6d400ec2    	ldp	d2, d3, [x22]
103dd6f74: 1e633800    	fsub	d0, d0, d3
103dd6f78: 1e690801    	fmul	d1, d0, d9
103dd6f7c: f8776a60    	ldr	x0, [x19, x23]
103dd6f80: b00d76a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
103dd6f84: f9453116    	ldr	x22, [x8, #0xa60] ; selector: setFrame:
103dd6f88: aa1603e1    	mov	x1, x22
103dd6f8c: 4ea81d00    	mov.16b	v0, v8
103dd6f90: 94f94335    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6f94: aa1303e0    	mov	x0, x19
103dd6f98: aa1403e1    	mov	x1, x20
103dd6f9c: 94f94332    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6fa0: 4ea01c08    	mov.16b	v8, v0
103dd6fa4: aa1303e0    	mov	x0, x19
103dd6fa8: aa1503e1    	mov	x1, x21
103dd6fac: 94f9432e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6fb0: 4ea01c03    	mov.16b	v3, v0
103dd6fb4: d00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd6fb8: b98f8908    	ldrsw	x8, [x8, #0xf88] ; ivar: MMHeadImageView._borderImageView offset=8
103dd6fbc: f8686a60    	ldr	x0, [x19, x8]
103dd6fc0: 9e6703e0    	fmov	d0, xzr
103dd6fc4: 9e6703e1    	fmov	d1, xzr
103dd6fc8: aa1603e1    	mov	x1, x22
103dd6fcc: 4ea81d02    	mov.16b	v2, v8
103dd6fd0: 94f94325    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd6fd4: a9467bfd    	ldp	x29, x30, [sp, #0x60]
103dd6fd8: a9454ff4    	ldp	x20, x19, [sp, #0x50]
103dd6fdc: a94457f6    	ldp	x22, x21, [sp, #0x40]
103dd6fe0: a9435ff8    	ldp	x24, x23, [sp, #0x30]
103dd6fe4: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
103dd6fe8: 9101c3ff    	add	sp, sp, #0x70
103dd6fec: d65f03c0    	ret
