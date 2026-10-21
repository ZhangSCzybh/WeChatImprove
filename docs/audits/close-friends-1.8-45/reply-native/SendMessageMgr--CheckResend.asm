
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10577b1d8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10577b1dc: a9014ff4    	stp	x20, x19, [sp, #0x10]
10577b1e0: a9027bfd    	stp	x29, x30, [sp, #0x20]
10577b1e4: 910083fd    	add	x29, sp, #0x20
10577b1e8: aa0003f3    	mov	x19, x0
10577b1ec: d00da628    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
10577b1f0: 52800029    	mov	w9, #0x1                ; =1
10577b1f4: 390c6509    	strb	w9, [x8, #0x319]
10577b1f8: 900d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577b1fc: f9464900    	ldr	x0, [x8, #0xc90]
10577b200: f00d3608    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10577b204: f9405101    	ldr	x1, [x8, #0xa0] ; isLogin
10577b208: 9492afcd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b20c: 340000a0    	cbz	w0, 0x10577b220 <_Flutter_MMFoundation_BindContext+0x1c56e04>
10577b210: f00d5588    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10577b214: b98cfd08    	ldrsw	x8, [x8, #0xcfc]
10577b218: 38686a68    	ldrb	w8, [x19, x8]
10577b21c: 360000a8    	tbz	w8, #0x0, 0x10577b230 <_Flutter_MMFoundation_BindContext+0x1c56e14>
10577b220: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10577b224: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10577b228: a8c357f6    	ldp	x22, x21, [sp], #0x30
10577b22c: d65f03c0    	ret
10577b230: 900d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577b234: f9457100    	ldr	x0, [x8, #0xae0]
10577b238: b00d4c28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10577b23c: f9460d01    	ldr	x1, [x8, #0xc18] ; date
10577b240: 9492afbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b244: aa1d03fd    	mov	x29, x29
10577b248: 9492afc0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577b24c: aa0003f4    	mov	x20, x0
10577b250: f00d5588    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10577b254: b98ced15    	ldrsw	x21, [x8, #0xcec]
10577b258: f8756a62    	ldr	x2, [x19, x21]
10577b25c: 900d4c88    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10577b260: f940ad01    	ldr	x1, [x8, #0x158] ; timeIntervalSinceDate:
10577b264: 9492afb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b268: f00d5588    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10577b26c: b98d0116    	ldrsw	x22, [x8, #0xd00]
10577b270: d009b028    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10577b274: fd42f501    	ldr	d1, [x8, #0x5e8]
10577b278: 1e612000    	fcmp	d0, d1
10577b27c: 5400006d    	b.le	0x10577b288 <_Flutter_MMFoundation_BindContext+0x1c56e6c>
10577b280: b8366a7f    	str	wzr, [x19, x22]
10577b284: 14000004    	b	0x10577b294 <_Flutter_MMFoundation_BindContext+0x1c56e78>
10577b288: b8766a68    	ldr	w8, [x19, x22]
10577b28c: 7100111f    	cmp	w8, #0x4
10577b290: 54000248    	b.hi	0x10577b2d8 <_Flutter_MMFoundation_BindContext+0x1c56ebc>
10577b294: b00d41a8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
10577b298: f9421501    	ldr	x1, [x8, #0x428] ; GetCountOfSendMessage
10577b29c: aa1303e0    	mov	x0, x19
10577b2a0: 9492afa7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b2a4: b4000260    	cbz	x0, 0x10577b2f0 <_Flutter_MMFoundation_BindContext+0x1c56ed4>
10577b2a8: f00d4048    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
10577b2ac: f943f501    	ldr	x1, [x8, #0x7e8] ; SendMsg
10577b2b0: aa1303e0    	mov	x0, x19
10577b2b4: 9492afa2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b2b8: b8766a68    	ldr	w8, [x19, x22]
10577b2bc: 11000508    	add	w8, w8, #0x1
10577b2c0: b8366a68    	str	w8, [x19, x22]
10577b2c4: 8b150260    	add	x0, x19, x21
10577b2c8: aa1403e1    	mov	x1, x20
10577b2cc: 9492af9d    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
10577b2d0: 528001e1    	mov	w1, #0xf                ; =15
10577b2d4: 14000002    	b	0x10577b2dc <_Flutter_MMFoundation_BindContext+0x1c56ec0>
10577b2d8: 52800201    	mov	w1, #0x10               ; =16
10577b2dc: 52803420    	mov	w0, #0x1a1              ; =417
10577b2e0: 52800022    	mov	w2, #0x1                ; =1
10577b2e4: 52800003    	mov	w3, #0x0                ; =0
10577b2e8: 52800004    	mov	w4, #0x0                ; =0
10577b2ec: 971f53a4    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10577b2f0: aa1403e0    	mov	x0, x20
10577b2f4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10577b2f8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10577b2fc: a8c357f6    	ldp	x22, x21, [sp], #0x30
10577b300: 1492af95    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
