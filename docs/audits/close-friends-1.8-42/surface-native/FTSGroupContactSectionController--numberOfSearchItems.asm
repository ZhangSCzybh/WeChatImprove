
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101759df0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101759df4: a9017bfd    	stp	x29, x30, [sp, #0x10]
101759df8: 910043fd    	add	x29, sp, #0x10
101759dfc: aa0003f3    	mov	x19, x0
101759e00: f00f54a8    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
101759e04: b98d9d08    	ldrsw	x8, [x8, #0xd9c] ; ivar FTSGroupContactSectionController._contacts
101759e08: f8686800    	ldr	x0, [x0, x8]
101759e0c: f00f4d28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101759e10: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101759e14: 959334ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759e18: aa0003f4    	mov	x20, x0
101759e1c: f00f3a68    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
101759e20: f9474d01    	ldr	x1, [x8, #0xe98] ; shouldDisplayChatRoomEntry
101759e24: aa1303e0    	mov	x0, x19
101759e28: 959334c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759e2c: 8b204280    	add	x0, x20, w0, uxtw
101759e30: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101759e34: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101759e38: d65f03c0    	ret
