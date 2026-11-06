
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002abed8: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
1002abedc: a90157f6    	stp	x22, x21, [sp, #0x10]
1002abee0: a9024ff4    	stp	x20, x19, [sp, #0x20]
1002abee4: a9037bfd    	stp	x29, x30, [sp, #0x30]
1002abee8: 9100c3fd    	add	x29, sp, #0x30
1002abeec: aa0003f3    	mov	x19, x0
1002abef0: fd400808    	ldr	d8, [x0, #0x10]
1002abef4: f00f5335    	adrp	x21, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002abef8: f944daa0    	ldr	x0, [x21, #0x9b0]
1002abefc: d00f3908    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
1002abf00: f946f514    	ldr	x20, [x8, #0xde8]
1002abf04: aa1403e1    	mov	x1, x20
1002abf08: aa1303e2    	mov	x2, x19
1002abf0c: 95e5ef56    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002abf10: 1e602100    	fcmp	d8, d0
1002abf14: 540002c0    	b.eq	0x1002abf6c <__text+0x2a3f6c>
1002abf18: fd400a60    	ldr	d0, [x19, #0x10]
1002abf1c: 1e602008    	fcmp	d0, #0.0
1002abf20: 540002ad    	b.le	0x1002abf74 <__text+0x2a3f74>
1002abf24: f00f5328    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002abf28: f9446500    	ldr	x0, [x8, #0x8c8]
1002abf2c: f00f38e8    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
1002abf30: f945f501    	ldr	x1, [x8, #0xbe8]
1002abf34: 95e5ef4c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002abf38: 340001e0    	cbz	w0, 0x1002abf74 <__text+0x2a3f74>
1002abf3c: f944daa0    	ldr	x0, [x21, #0x9b0]
1002abf40: aa1403e1    	mov	x1, x20
1002abf44: aa1303e2    	mov	x2, x19
1002abf48: 95e5ef47    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002abf4c: 4ea01c08    	mov.16b	v8, v0
1002abf50: f944daa0    	ldr	x0, [x21, #0x9b0]
1002abf54: d00f3908    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
1002abf58: f946f901    	ldr	x1, [x8, #0xdf0]
1002abf5c: aa1303e2    	mov	x2, x19
1002abf60: 95e5ef41    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002abf64: 1e602100    	fcmp	d8, d0
1002abf68: 5400006d    	b.le	0x1002abf74 <__text+0x2a3f74>
1002abf6c: 52800000    	mov	w0, #0x0                ; =0
1002abf70: 14000002    	b	0x1002abf78 <__text+0x2a3f78>
1002abf74: 52800020    	mov	w0, #0x1                ; =1
1002abf78: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1002abf7c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1002abf80: a94157f6    	ldp	x22, x21, [sp, #0x10]
1002abf84: 6cc423e9    	ldp	d9, d8, [sp], #0x40
1002abf88: d65f03c0    	ret
