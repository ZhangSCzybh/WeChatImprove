
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104abdc70: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104abdc74: a90157f6    	stp	x22, x21, [sp, #0x10]
104abdc78: a9024ff4    	stp	x20, x19, [sp, #0x20]
104abdc7c: a9037bfd    	stp	x29, x30, [sp, #0x30]
104abdc80: 9100c3fd    	add	x29, sp, #0x30
104abdc84: aa0203f4    	mov	x20, x2
104abdc88: aa0003f3    	mov	x19, x0
104abdc8c: b00e0c08    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104abdc90: 52800029    	mov	w9, #0x1                ; =1
104abdc94: 390edd09    	strb	w9, [x8, #0x3b7]
104abdc98: d00dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abdc9c: b9848915    	ldrsw	x21, [x8, #0x488]
104abdca0: f8756800    	ldr	x0, [x0, x21]
104abdca4: f00db208    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104abdca8: f9435101    	ldr	x1, [x8, #0x6a0] ; selector count
104abdcac: 94c5a524    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abdcb0: eb14001f    	cmp	x0, x20
104abdcb4: 54000209    	b.ls	0x104abdcf4 <_Flutter_MMFoundation_BindContext+0xf998d8>
104abdcb8: d00dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abdcbc: b9848516    	ldrsw	x22, [x8, #0x484]
104abdcc0: b8766a77    	ldr	w23, [x19, x22]
104abdcc4: f1000e9f    	cmp	x20, #0x3
104abdcc8: 540001a8    	b.hi	0x104abdcfc <_Flutter_MMFoundation_BindContext+0xf998e0>
104abdccc: 900c5d48    	adrp	x8, 0x11d665000 <dyld_stub_binder+0x11d665000>
104abdcd0: 912de108    	add	x8, x8, #0xb78
104abdcd4: f8747908    	ldr	x8, [x8, x20, lsl #3]
104abdcd8: f9400101    	ldr	x1, [x8]
104abdcdc: aa1303e0    	mov	x0, x19
104abdce0: 94c5a517    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abdce4: aa1d03fd    	mov	x29, x29
104abdce8: 94c5a518    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abdcec: aa0003f4    	mov	x20, x0
104abdcf0: 14000004    	b	0x104abdd00 <_Flutter_MMFoundation_BindContext+0xf998e4>
104abdcf4: d2800014    	mov	x20, #0x0               ; =0
104abdcf8: 1400000a    	b	0x104abdd20 <_Flutter_MMFoundation_BindContext+0xf99904>
104abdcfc: d2800014    	mov	x20, #0x0               ; =0
104abdd00: b8766a68    	ldr	w8, [x19, x22]
104abdd04: 6b17011f    	cmp	w8, w23
104abdd08: 540000c0    	b.eq	0x104abdd20 <_Flutter_MMFoundation_BindContext+0xf99904>
104abdd0c: f8756a62    	ldr	x2, [x19, x21]
104abdd10: f00d9d88    	adrp	x8, 0x11fe70000 <dyld_stub_binder+0x11fe70000>
104abdd14: f9410101    	ldr	x1, [x8, #0x200] ; selector setViewControllers:
104abdd18: aa1303e0    	mov	x0, x19
104abdd1c: 94c5a508    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abdd20: aa1403e0    	mov	x0, x20
104abdd24: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104abdd28: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104abdd2c: a94157f6    	ldp	x22, x21, [sp, #0x10]
104abdd30: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104abdd34: 14c5a50f    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
