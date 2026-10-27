
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a9bed0: 6dba2beb    	stp	d11, d10, [sp, #-0x60]!
104a9bed4: 6d0123e9    	stp	d9, d8, [sp, #0x10]
104a9bed8: a9025ff8    	stp	x24, x23, [sp, #0x20]
104a9bedc: a90357f6    	stp	x22, x21, [sp, #0x30]
104a9bee0: a9044ff4    	stp	x20, x19, [sp, #0x40]
104a9bee4: a9057bfd    	stp	x29, x30, [sp, #0x50]
104a9bee8: 910143fd    	add	x29, sp, #0x50
104a9beec: aa0003f4    	mov	x20, x0
104a9bef0: f00e0d08    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a9bef4: 52800029    	mov	w9, #0x1                ; =1
104a9bef8: 390cd909    	strb	w9, [x8, #0x336]
104a9befc: 900dbc48    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a9bf00: b9829108    	ldrsw	x8, [x8, #0x290]
104a9bf04: f8686800    	ldr	x0, [x0, x8]
104a9bf08: f00d9d48    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104a9bf0c: f9438d01    	ldr	x1, [x8, #0x718] ; m_sessionInfo
104a9bf10: 94c62c8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9bf14: aa1d03fd    	mov	x29, x29
104a9bf18: 94c62c8c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a9bf1c: aa0003f3    	mov	x19, x0
104a9bf20: 900dbc48    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a9bf24: b9829917    	ldrsw	x23, [x8, #0x298]
104a9bf28: f8776a80    	ldr	x0, [x20, x23]
104a9bf2c: b00db368    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a9bf30: f9411116    	ldr	x22, [x8, #0x220] ; setHidden:
104a9bf34: aa1603e1    	mov	x1, x22
104a9bf38: 52800002    	mov	w2, #0x0                ; =0
104a9bf3c: 94c62c80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9bf40: d00d9d08    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a9bf44: f942e515    	ldr	x21, [x8, #0x5c8] ; m_uUnReadCount
104a9bf48: aa1303e0    	mov	x0, x19
104a9bf4c: aa1503e1    	mov	x1, x21
104a9bf50: 94c62c7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9bf54: 340006a0    	cbz	w0, 0x104a9c028 <_Flutter_MMFoundation_BindContext+0xf77c0c>
104a9bf58: d00d9d48    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104a9bf5c: f9413501    	ldr	x1, [x8, #0x268] ; m_bShowUnReadAsRedDot
104a9bf60: aa1303e0    	mov	x0, x19
104a9bf64: 94c62c76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9bf68: f8776a96    	ldr	x22, [x20, x23]
104a9bf6c: 34000680    	cbz	w0, 0x104a9c03c <_Flutter_MMFoundation_BindContext+0xf77c20>
104a9bf70: b00da048    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104a9bf74: f9453101    	ldr	x1, [x8, #0xa60] ; setAsSmallDotForChatSession
104a9bf78: aa1603e0    	mov	x0, x22
104a9bf7c: 94c62c70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9bf80: 900dbc48    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a9bf84: b9826916    	ldrsw	x22, [x8, #0x268]
104a9bf88: f8766a80    	ldr	x0, [x20, x22]
104a9bf8c: b00d9d08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a9bf90: f9431d01    	ldr	x1, [x8, #0x638] ; right
104a9bf94: 94c62c6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9bf98: 1e604008    	fmov	d8, d0
104a9bf9c: f8776a80    	ldr	x0, [x20, x23]
104a9bfa0: 900db388    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104a9bfa4: f947a501    	ldr	x1, [x8, #0xf48] ; width
104a9bfa8: 94c62c65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9bfac: 1e6c100a    	fmov	d10, #0.50000000
104a9bfb0: 1e6a0800    	fmul	d0, d0, d10
104a9bfb4: 1e603908    	fsub	d8, d8, d0
104a9bfb8: 900db6d8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104a9bfbc: f9461b00    	ldr	x0, [x24, #0xc30]
104a9bfc0: d00d9ce8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a9bfc4: f9463115    	ldr	x21, [x8, #0xc60] ; dynamicLength:
104a9bfc8: 1e601000    	fmov	d0, #2.00000000
104a9bfcc: aa1503e1    	mov	x1, x21
104a9bfd0: 94c62c5b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9bfd4: 1e603908    	fsub	d8, d8, d0
104a9bfd8: f8766a80    	ldr	x0, [x20, x22]
104a9bfdc: 900d9d28    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104a9bfe0: f946a501    	ldr	x1, [x8, #0xd48] ; top
104a9bfe4: 94c62c56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9bfe8: 1e604009    	fmov	d9, d0
104a9bfec: f8776a80    	ldr	x0, [x20, x23]
104a9bff0: f00db328    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104a9bff4: f9449d01    	ldr	x1, [x8, #0x938] ; height
104a9bff8: 94c62c51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9bffc: 1e6a0800    	fmul	d0, d0, d10
104a9c000: 1e603929    	fsub	d9, d9, d0
104a9c004: f9461b00    	ldr	x0, [x24, #0xc30]
104a9c008: 1e601000    	fmov	d0, #2.00000000
104a9c00c: aa1503e1    	mov	x1, x21
104a9c010: 94c62c4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c014: 1e602921    	fadd	d1, d9, d0
104a9c018: f8776a80    	ldr	x0, [x20, x23]
104a9c01c: b00d9ce8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a9c020: f9465501    	ldr	x1, [x8, #0xca8] ; setWcOrigin:
104a9c024: 1400002d    	b	0x104a9c0d8 <_Flutter_MMFoundation_BindContext+0xf77cbc>
104a9c028: f8776a80    	ldr	x0, [x20, x23]
104a9c02c: aa1603e1    	mov	x1, x22
104a9c030: 52800022    	mov	w2, #0x1                ; =1
104a9c034: 94c62c42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c038: 1400002a    	b	0x104a9c0e0 <_Flutter_MMFoundation_BindContext+0xf77cc4>
104a9c03c: aa1303e0    	mov	x0, x19
104a9c040: aa1503e1    	mov	x1, x21
104a9c044: 94c62c3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c048: 2a0003e2    	mov	w2, w0
104a9c04c: d00db368    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a9c050: f940bd01    	ldr	x1, [x8, #0x178] ; setValue:
104a9c054: aa1603e0    	mov	x0, x22
104a9c058: 94c62c39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c05c: f00dbc28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a9c060: b9826915    	ldrsw	x21, [x8, #0x268]
104a9c064: f8756a80    	ldr	x0, [x20, x21]
104a9c068: 900d9d08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a9c06c: f9431d01    	ldr	x1, [x8, #0x638] ; right
104a9c070: 94c62c33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c074: 1e604008    	fmov	d8, d0
104a9c078: f8776a80    	ldr	x0, [x20, x23]
104a9c07c: f00db368    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104a9c080: f947a501    	ldr	x1, [x8, #0xf48] ; width
104a9c084: 94c62c2e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c088: 1e604009    	fmov	d9, d0
104a9c08c: f8776a80    	ldr	x0, [x20, x23]
104a9c090: d00db328    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104a9c094: f9449d01    	ldr	x1, [x8, #0x938] ; height
104a9c098: 94c62c29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c09c: 1e603920    	fsub	d0, d9, d0
104a9c0a0: 1e7c1001    	fmov	d1, #-0.50000000
104a9c0a4: 1e610800    	fmul	d0, d0, d1
104a9c0a8: 1e602900    	fadd	d0, d8, d0
104a9c0ac: 1e701001    	fmov	d1, #-2.00000000
104a9c0b0: 1e612808    	fadd	d8, d0, d1
104a9c0b4: f8756a80    	ldr	x0, [x20, x21]
104a9c0b8: f00d9d08    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104a9c0bc: f946a501    	ldr	x1, [x8, #0xd48] ; top
104a9c0c0: 94c62c1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c0c4: 1e601001    	fmov	d1, #2.00000000
104a9c0c8: 1e612801    	fadd	d1, d0, d1
104a9c0cc: f8776a80    	ldr	x0, [x20, x23]
104a9c0d0: f00db348    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104a9c0d4: f9425101    	ldr	x1, [x8, #0x4a0] ; setCenter:
104a9c0d8: 1e604100    	fmov	d0, d8
104a9c0dc: 94c62c18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9c0e0: aa1303e0    	mov	x0, x19
104a9c0e4: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104a9c0e8: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104a9c0ec: a94357f6    	ldp	x22, x21, [sp, #0x30]
104a9c0f0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104a9c0f4: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
104a9c0f8: 6cc62beb    	ldp	d11, d10, [sp], #0x60
104a9c0fc: 14c62c16    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
