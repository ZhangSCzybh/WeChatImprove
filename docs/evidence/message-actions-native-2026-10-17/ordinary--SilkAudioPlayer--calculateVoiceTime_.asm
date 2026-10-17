
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1059f7988: d10143ff    	sub	sp, sp, #0x50
1059f798c: a9015ff8    	stp	x24, x23, [sp, #0x10]
1059f7990: a90257f6    	stp	x22, x21, [sp, #0x20]
1059f7994: a9034ff4    	stp	x20, x19, [sp, #0x30]
1059f7998: a9047bfd    	stp	x29, x30, [sp, #0x40]
1059f799c: 910103fd    	add	x29, sp, #0x40
1059f79a0: aa0203f3    	mov	x19, x2
1059f79a4: d00d9248    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
1059f79a8: 52800029    	mov	w9, #0x1                ; =1
1059f79ac: 3930ad09    	strb	w9, [x8, #0xc2b]
1059f79b0: aa0203e0    	mov	x0, x2
1059f79b4: 9488bde1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1059f79b8: aa1303e0    	mov	x0, x19
1059f79bc: 9488bdfb    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
1059f79c0: 900d3848    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1059f79c4: f9447516    	ldr	x22, [x8, #0x8e8] ; bytes
1059f79c8: aa1603e1    	mov	x1, x22
1059f79cc: 9488bddc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1059f79d0: 94885326    	bl	0x107c0c668 <_Flutter_MMFoundation_BindContext+0x40e824c>
1059f79d4: aa0003f5    	mov	x21, x0
1059f79d8: 340006c0    	cbz	w0, 0x1059f7ab0 <_Flutter_MMFoundation_BindContext+0x1ed3694>
1059f79dc: 52801000    	mov	w0, #0x80               ; =128
1059f79e0: 9488bde7    	bl	0x107c2717c <_Flutter_MMFoundation_BindContext+0x4102d60>
1059f79e4: aa0003f4    	mov	x20, x0
1059f79e8: 9488531e    	bl	0x107c0c660 <_Flutter_MMFoundation_BindContext+0x40e8244>
1059f79ec: aa1303e0    	mov	x0, x19
1059f79f0: 9488bdee    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
1059f79f4: aa1603e1    	mov	x1, x22
1059f79f8: 9488bdd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1059f79fc: aa0003f6    	mov	x22, x0
1059f7a00: 900d3868    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1059f7a04: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1059f7a08: aa1303e0    	mov	x0, x19
1059f7a0c: 9488bdcc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1059f7a10: aa0003e3    	mov	x3, x0
1059f7a14: aa1403e0    	mov	x0, x20
1059f7a18: aa1503e1    	mov	x1, x21
1059f7a1c: aa1603e2    	mov	x2, x22
1059f7a20: 94885313    	bl	0x107c0c66c <_Flutter_MMFoundation_BindContext+0x40e8250>
1059f7a24: 1e6202a0    	scvtf	d0, w21
1059f7a28: d0099c48    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1059f7a2c: fd45a101    	ldr	d1, [x8, #0xb40]
1059f7a30: 1e610800    	fmul	d0, d0, d1
1059f7a34: 1e780016    	fcvtzs	w22, d0
1059f7a38: 528bb808    	mov	w8, #0x5dc0             ; =24000
1059f7a3c: 6b0802bf    	cmp	w21, w8
1059f7a40: 1a88c2a8    	csel	w8, w21, w8, gt
1059f7a44: 1e630100    	ucvtf	d0, w8
1059f7a48: d0099c48    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1059f7a4c: fd42d101    	ldr	d1, [x8, #0x5a0]
1059f7a50: 1e610800    	fmul	d0, d0, d1
1059f7a54: 1e780008    	fcvtzs	w8, d0
1059f7a58: 937f7d09    	sbfiz	x9, x8, #1, #32
1059f7a5c: 7100011f    	cmp	w8, #0x0
1059f7a60: da9fa120    	csinv	x0, x9, xzr, ge
1059f7a64: 9488be6b    	bl	0x107c27410 <_Flutter_MMFoundation_BindContext+0x4102ff4>
1059f7a68: aa0003f7    	mov	x23, x0
1059f7a6c: 52800015    	mov	w21, #0x0               ; =0
1059f7a70: aa1403e0    	mov	x0, x20
1059f7a74: aa1703e1    	mov	x1, x23
1059f7a78: aa1603e2    	mov	x2, x22
1059f7a7c: 948852fe    	bl	0x107c0c674 <_Flutter_MMFoundation_BindContext+0x40e8258>
1059f7a80: 110052b5    	add	w21, w21, #0x14
1059f7a84: 7100041f    	cmp	w0, #0x1
1059f7a88: 54ffff40    	b.eq	0x1059f7a70 <_Flutter_MMFoundation_BindContext+0x1ed3654>
1059f7a8c: aa1703e0    	mov	x0, x23
1059f7a90: 9488be53    	bl	0x107c273dc <_Flutter_MMFoundation_BindContext+0x4102fc0>
1059f7a94: aa1403e0    	mov	x0, x20
1059f7a98: 948852f6    	bl	0x107c0c670 <_Flutter_MMFoundation_BindContext+0x40e8254>
1059f7a9c: aa1403e0    	mov	x0, x20
1059f7aa0: 948852f1    	bl	0x107c0c664 <_Flutter_MMFoundation_BindContext+0x40e8248>
1059f7aa4: 52801001    	mov	w1, #0x80               ; =128
1059f7aa8: 9488bdc9    	bl	0x107c271cc <_Flutter_MMFoundation_BindContext+0x4102db0>
1059f7aac: 14000011    	b	0x1059f7af0 <_Flutter_MMFoundation_BindContext+0x1ed36d4>
1059f7ab0: 900d3be8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1059f7ab4: f9453500    	ldr	x0, [x8, #0xa68]
1059f7ab8: d00d2208    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1059f7abc: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1059f7ac0: 900c7188    	adrp	x8, 0x11e827000 <dyld_stub_binder+0x11e827000>
1059f7ac4: 913aa108    	add	x8, x8, #0xea8
1059f7ac8: f90003e8    	str	x8, [sp]
1059f7acc: d00af865    	adrp	x5, 0x11b905000 <dyld_stub_binder+0x11b905000>
1059f7ad0: 912458a5    	add	x5, x5, #0x916
1059f7ad4: d00af867    	adrp	x7, 0x11b905000 <dyld_stub_binder+0x11b905000>
1059f7ad8: 913668e7    	add	x7, x7, #0xd9a
1059f7adc: 52800082    	mov	w2, #0x4                ; =4
1059f7ae0: d2800003    	mov	x3, #0x0                ; =0
1059f7ae4: 52800004    	mov	w4, #0x0                ; =0
1059f7ae8: 52805306    	mov	w6, #0x298              ; =664
1059f7aec: 9488bd94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1059f7af0: aa1303e0    	mov	x0, x19
1059f7af4: 9488bd98    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1059f7af8: aa1503e0    	mov	x0, x21
1059f7afc: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1059f7b00: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1059f7b04: a94257f6    	ldp	x22, x21, [sp, #0x20]
1059f7b08: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1059f7b0c: 910143ff    	add	sp, sp, #0x50
1059f7b10: d65f03c0    	ret