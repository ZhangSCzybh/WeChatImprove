
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100ed8110: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
100ed8114: a90157f6    	stp	x22, x21, [sp, #0x10]
100ed8118: a9024ff4    	stp	x20, x19, [sp, #0x20]
100ed811c: a9037bfd    	stp	x29, x30, [sp, #0x30]
100ed8120: 9100c3fd    	add	x29, sp, #0x30
100ed8124: aa0303f4    	mov	x20, x3
100ed8128: aa0003f3    	mov	x19, x0
100ed812c: f00f9a48    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
100ed8130: 911a7108    	add	x8, x8, #0x69c
100ed8134: b9800108    	ldrsw	x8, [x8]
100ed8138: f8686815    	ldr	x21, [x0, x8]
100ed813c: 900f7b28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100ed8140: f947f916    	ldr	x22, [x8, #0xff0] ; deselectRowAtIndexPath:animated:
100ed8144: aa0303e0    	mov	x0, x3
100ed8148: 95b53bfc    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100ed814c: aa1503e0    	mov	x0, x21
100ed8150: aa1603e1    	mov	x1, x22
100ed8154: aa1403e2    	mov	x2, x20
100ed8158: 52800023    	mov	w3, #0x1                ; =1
100ed815c: 95b53bf8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed8160: f00f9a48    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
100ed8164: 911a5108    	add	x8, x8, #0x694
100ed8168: b9800108    	ldrsw	x8, [x8]
100ed816c: f8686a75    	ldr	x21, [x19, x8]
100ed8170: 900f7b28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100ed8174: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
100ed8178: aa1403e0    	mov	x0, x20
100ed817c: 95b53bf0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed8180: aa0003f6    	mov	x22, x0
100ed8184: d00f9168    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
100ed8188: f9440901    	ldr	x1, [x8, #0x810] ; row
100ed818c: aa1403e0    	mov	x0, x20
100ed8190: 95b53beb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed8194: aa0003f7    	mov	x23, x0
100ed8198: aa1403e0    	mov	x0, x20
100ed819c: 95b53bee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100ed81a0: d00f7d48    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
100ed81a4: f9479501    	ldr	x1, [x8, #0xf28] ; getItemInSection:atRow:
100ed81a8: aa1503e0    	mov	x0, x21
100ed81ac: aa1603e2    	mov	x2, x22
100ed81b0: aa1703e3    	mov	x3, x23
100ed81b4: 95b53be2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed81b8: aa1d03fd    	mov	x29, x29
100ed81bc: 95b53be3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100ed81c0: aa0003f4    	mov	x20, x0
100ed81c4: b40000c0    	cbz	x0, 0x100ed81dc <__text+0xed01dc>
100ed81c8: d00f7d48    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
100ed81cc: f9478101    	ldr	x1, [x8, #0xf00] ; JumpToChatRoom:
100ed81d0: aa1303e0    	mov	x0, x19
100ed81d4: aa1403e2    	mov	x2, x20
100ed81d8: 95b53bd9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100ed81dc: aa1403e0    	mov	x0, x20
100ed81e0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100ed81e4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100ed81e8: a94157f6    	ldp	x22, x21, [sp, #0x10]
100ed81ec: a8c45ff8    	ldp	x24, x23, [sp], #0x40
100ed81f0: 15b53bd9    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
