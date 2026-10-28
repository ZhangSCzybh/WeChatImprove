
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10510fbe8: 6dbd23e9    	stp	d9, d8, [sp, #-0x30]!
10510fbec: a9014ff4    	stp	x20, x19, [sp, #0x10]
10510fbf0: a9027bfd    	stp	x29, x30, [sp, #0x20]
10510fbf4: 910083fd    	add	x29, sp, #0x20
10510fbf8: aa0003f3    	mov	x19, x0
10510fbfc: 900dd988    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
10510fc00: 52800029    	mov	w9, #0x1                ; =1
10510fc04: b00d88ca    	adrp	x10, 0x120228000 <dyld_stub_binder+0x120228000>
10510fc08: 910cf14a    	add	x10, x10, #0x33c
10510fc0c: 392d1509    	strb	w9, [x8, #0xb45]
10510fc10: b9800148    	ldrsw	x8, [x10]
10510fc14: f8686800    	ldr	x0, [x0, x8]
10510fc18: f00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10510fc1c: f9433d01    	ldr	x1, [x8, #0x678] ; isSpread
10510fc20: 94ac5d47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510fc24: 34000120    	cbz	w0, 0x10510fc48 <_Flutter_MMFoundation_BindContext+0x15eb82c>
10510fc28: b00d88c8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10510fc2c: 91108108    	add	x8, x8, #0x420
10510fc30: b9800108    	ldrsw	x8, [x8]
10510fc34: f8686a60    	ldr	x0, [x19, x8]
10510fc38: f00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10510fc3c: f9455101    	ldr	x1, [x8, #0xaa0] ; checkLiveItemUpdateIfNeeded:
10510fc40: 52800062    	mov	w2, #0x3                ; =3
10510fc44: 94ac5d3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510fc48: 900d8328    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10510fc4c: f9468d00    	ldr	x0, [x8, #0xd18] ; DeviceInfo
10510fc50: 900d7fa8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10510fc54: f9457d01    	ldr	x1, [x8, #0xaf8] ; isiPad
10510fc58: 94ac5d39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510fc5c: 340004a0    	cbz	w0, 0x10510fcf0 <_Flutter_MMFoundation_BindContext+0x15eb8d4>
10510fc60: b00d88c8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10510fc64: 910d0108    	add	x8, x8, #0x340
10510fc68: b9800108    	ldrsw	x8, [x8]
10510fc6c: 38686a68    	ldrb	w8, [x19, x8]
10510fc70: 7100051f    	cmp	w8, #0x1
10510fc74: 540003e1    	b.ne	0x10510fcf0 <_Flutter_MMFoundation_BindContext+0x15eb8d4>
10510fc78: b00d6968    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10510fc7c: f9416501    	ldr	x1, [x8, #0x2c8] ; getContentViewY
10510fc80: aa1303e0    	mov	x0, x19
10510fc84: 94ac5d2e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510fc88: 1e604008    	fmov	d8, d0
10510fc8c: b00d88c8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10510fc90: 910d1108    	add	x8, x8, #0x344
10510fc94: b9800114    	ldrsw	x20, [x8]
10510fc98: f8746a60    	ldr	x0, [x19, x20]
10510fc9c: f00d7f88    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10510fca0: f9449d01    	ldr	x1, [x8, #0x938] ; height
10510fca4: 94ac5d26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510fca8: 1e602900    	fadd	d0, d8, d0
10510fcac: 1e614001    	fneg	d1, d0
10510fcb0: f00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10510fcb4: f943d901    	ldr	x1, [x8, #0x7b0] ; mainTableViewOffsetDidChangeTo:
10510fcb8: 9e6703e0    	fmov	d0, xzr
10510fcbc: aa1303e0    	mov	x0, x19
10510fcc0: 94ac5d1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510fcc4: b00d88c8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10510fcc8: 910c6108    	add	x8, x8, #0x318
10510fccc: b9800108    	ldrsw	x8, [x8]
10510fcd0: f8686a60    	ldr	x0, [x19, x8]
10510fcd4: f8746a62    	ldr	x2, [x19, x20]
10510fcd8: 900d7f88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10510fcdc: f9440501    	ldr	x1, [x8, #0x808] ; bringSubviewToFront:
10510fce0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10510fce4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10510fce8: 6cc323e9    	ldp	d9, d8, [sp], #0x30
10510fcec: 14ac5d14    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10510fcf0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10510fcf4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10510fcf8: 6cc323e9    	ldp	d9, d8, [sp], #0x30
10510fcfc: d65f03c0    	ret
