
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002ab850: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1002ab854: a90157f6    	stp	x22, x21, [sp, #0x10]
1002ab858: a9024ff4    	stp	x20, x19, [sp, #0x20]
1002ab85c: a9037bfd    	stp	x29, x30, [sp, #0x30]
1002ab860: 9100c3fd    	add	x29, sp, #0x30
1002ab864: aa0003f3    	mov	x19, x0
1002ab868: b00fa4a8    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002ab86c: 52800029    	mov	w9, #0x1                ; =1
1002ab870: 3923f509    	strb	w9, [x8, #0x8fd]
1002ab874: d00f5008    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1002ab878: f947d501    	ldr	x1, [x8, #0xfa8]
1002ab87c: 95e5f0fa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ab880: 1e602008    	fcmp	d0, #0.0
1002ab884: 540000e0    	b.eq	0x1002ab8a0 <__text+0x2a38a0>
1002ab888: 900f4fe8    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
1002ab88c: f9478101    	ldr	x1, [x8, #0xf00]
1002ab890: aa1303e0    	mov	x0, x19
1002ab894: 95e5f0f4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ab898: 1e602008    	fcmp	d0, #0.0
1002ab89c: 540000c1    	b.ne	0x1002ab8b4 <__text+0x2a38b4>
1002ab8a0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1002ab8a4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1002ab8a8: a94157f6    	ldp	x22, x21, [sp, #0x10]
1002ab8ac: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1002ab8b0: d65f03c0    	ret
1002ab8b4: f00f5688    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1002ab8b8: b98ad908    	ldrsw	x8, [x8, #0xad8]
1002ab8bc: f8686a60    	ldr	x0, [x19, x8]
1002ab8c0: b4ffff00    	cbz	x0, 0x1002ab8a0 <__text+0x2a38a0>
1002ab8c4: d00f3928    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1002ab8c8: f9409d15    	ldr	x21, [x8, #0x138]
1002ab8cc: aa1503e1    	mov	x1, x21
1002ab8d0: 95e5f0e5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ab8d4: 3707fe60    	tbnz	w0, #0x0, 0x1002ab8a0 <__text+0x2a38a0>
1002ab8d8: f00f5688    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1002ab8dc: b98ae116    	ldrsw	x22, [x8, #0xae0]
1002ab8e0: 52800028    	mov	w8, #0x1                ; =1
1002ab8e4: 38366a68    	strb	w8, [x19, x22]
1002ab8e8: f00f3968    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
1002ab8ec: f9459901    	ldr	x1, [x8, #0xb30]
1002ab8f0: aa1303e0    	mov	x0, x19
1002ab8f4: 95e5f0dc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ab8f8: aa0003f4    	mov	x20, x0
1002ab8fc: b00f5357    	adrp	x23, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
1002ab900: 34000140    	cbz	w0, 0x1002ab928 <__text+0x2a3928>
1002ab904: f944b6e0    	ldr	x0, [x23, #0x968]
1002ab908: b00f3968    	adrp	x8, 0x11e9d8000 <dyld_stub_binder+0x11e9d8000>
1002ab90c: f9424d01    	ldr	x1, [x8, #0x498]
1002ab910: 95e5f0d5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ab914: f944b6e0    	ldr	x0, [x23, #0x968]
1002ab918: b00f3968    	adrp	x8, 0x11e9d8000 <dyld_stub_binder+0x11e9d8000>
1002ab91c: f9425101    	ldr	x1, [x8, #0x4a0]
1002ab920: 52800022    	mov	w2, #0x1                ; =1
1002ab924: 95e5f0d0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ab928: aa1303e0    	mov	x0, x19
1002ab92c: aa1503e1    	mov	x1, x21
1002ab930: 95e5f0cd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ab934: 340001a0    	cbz	w0, 0x1002ab968 <__text+0x2a3968>
1002ab938: d00f5008    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1002ab93c: f9407501    	ldr	x1, [x8, #0xe8]
1002ab940: aa1303e0    	mov	x0, x19
1002ab944: 95e5f0c8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ab948: f00f5688    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1002ab94c: b98add08    	ldrsw	x8, [x8, #0xadc]
1002ab950: 8b080268    	add	x8, x19, x8
1002ab954: 6d000500    	stp	d0, d1, [x8]
1002ab958: f00f3968    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
1002ab95c: f9459d01    	ldr	x1, [x8, #0xb38]
1002ab960: aa1303e0    	mov	x0, x19
1002ab964: 95e5f0c0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ab968: f00f3968    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
1002ab96c: f945a101    	ldr	x1, [x8, #0xb40]
1002ab970: aa1303e0    	mov	x0, x19
1002ab974: 95e5f0bc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ab978: 340000b4    	cbz	w20, 0x1002ab98c <__text+0x2a398c>
1002ab97c: f944b6e0    	ldr	x0, [x23, #0x968]
1002ab980: f00f4fc8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002ab984: f9431101    	ldr	x1, [x8, #0x620]
1002ab988: 95e5f0b7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ab98c: 38366a7f    	strb	wzr, [x19, x22]
1002ab990: 17ffffc4    	b	0x1002ab8a0 <__text+0x2a38a0>
