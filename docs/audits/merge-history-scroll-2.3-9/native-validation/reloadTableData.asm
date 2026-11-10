
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10033f184: d100c3ff    	sub	sp, sp, #0x30
10033f188: a9014ff4    	stp	x20, x19, [sp, #0x10]
10033f18c: a9027bfd    	stp	x29, x30, [sp, #0x20]
10033f190: 910083fd    	add	x29, sp, #0x20
10033f194: aa0003f3    	mov	x19, x0
10033f198: f00f4e88    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10033f19c: f9430d00    	ldr	x0, [x8, #0x618]
10033f1a0: d00f3448    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10033f1a4: f9418901    	ldr	x1, [x8, #0x310]
10033f1a8: b00e6428    	adrp	x8, 0x11cfc4000 <dyld_stub_binder+0x11cfc4000>
10033f1ac: 91036108    	add	x8, x8, #0xd8
10033f1b0: f90003e8    	str	x8, [sp]
10033f1b4: b00cc445    	adrp	x5, 0x119bc8000 <dyld_stub_binder+0x119bc8000>
10033f1b8: 9100f4a5    	add	x5, x5, #0x3d
10033f1bc: 900cc467    	adrp	x7, 0x119bcb000 <dyld_stub_binder+0x119bcb000>
10033f1c0: 9110b0e7    	add	x7, x7, #0x42c
10033f1c4: 52800042    	mov	w2, #0x2                ; =2
10033f1c8: d2800003    	mov	x3, #0x0                ; =0
10033f1cc: 52800004    	mov	w4, #0x0                ; =0
10033f1d0: 5284b5c6    	mov	w6, #0x25ae             ; =9646
10033f1d4: 95e3a2a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10033f1d8: f00f51e8    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10033f1dc: b98cfd08    	ldrsw	x8, [x8, #0xcfc]
10033f1e0: f8686a60    	ldr	x0, [x19, x8]
10033f1e4: b00f3468    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10033f1e8: f9414901    	ldr	x1, [x8, #0x290]
10033f1ec: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10033f1f0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10033f1f4: 9100c3ff    	add	sp, sp, #0x30
10033f1f8: 15e3a29b    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
