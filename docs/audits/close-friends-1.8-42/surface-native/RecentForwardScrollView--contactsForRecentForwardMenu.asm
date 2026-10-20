
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105513c08: d10543ff    	sub	sp, sp, #0x150
105513c0c: a90f6ffc    	stp	x28, x27, [sp, #0xf0]
105513c10: a91067fa    	stp	x26, x25, [sp, #0x100]
105513c14: a9115ff8    	stp	x24, x23, [sp, #0x110]
105513c18: a91257f6    	stp	x22, x21, [sp, #0x120]
105513c1c: a9134ff4    	stp	x20, x19, [sp, #0x130]
105513c20: a9147bfd    	stp	x29, x30, [sp, #0x140]
105513c24: 910503fd    	add	x29, sp, #0x140
105513c28: aa0003f3    	mov	x19, x0
105513c2c: 900c06e8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
105513c30: f9405908    	ldr	x8, [x8, #0xb0]
105513c34: f9400108    	ldr	x8, [x8]
105513c38: f81a03a8    	stur	x8, [x29, #-0x60]
105513c3c: b00db968    	adrp	x8, 0x120c40000 <dyld_stub_binder+0x120c40000>
105513c40: 52800029    	mov	w9, #0x1                ; =1
105513c44: 39289109    	strb	w9, [x8, #0xa24]
105513c48: 900d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105513c4c: f9455500    	ldr	x0, [x8, #0xaa8]
105513c50: 900d5f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105513c54: f941a101    	ldr	x1, [x8, #0x340] ; array
105513c58: 949c4d39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513c5c: aa1d03fd    	mov	x29, x29
105513c60: 949c4d3a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105513c64: f90007e0    	str	x0, [sp, #0x8]
105513c68: 4f00e400    	movi.16b	v0, #0x0
105513c6c: ad0103e0    	stp	q0, q0, [sp, #0x20]
105513c70: ad0203e0    	stp	q0, q0, [sp, #0x40]
105513c74: 900d6308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105513c78: f945e900    	ldr	x0, [x8, #0xbd0]
105513c7c: b00d5f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105513c80: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105513c84: 949c4d2e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513c88: aa1d03fd    	mov	x29, x29
105513c8c: 949c4d2f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105513c90: aa0003f6    	mov	x22, x0
105513c94: b00d6308    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105513c98: f9401d00    	ldr	x0, [x8, #0x38]
105513c9c: 900d5f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105513ca0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105513ca4: 949c4d26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513ca8: aa0003e2    	mov	x2, x0
105513cac: d00d4928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105513cb0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
105513cb4: aa1603e0    	mov	x0, x22
105513cb8: 949c4d21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513cbc: aa1d03fd    	mov	x29, x29
105513cc0: 949c4d22    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105513cc4: aa0003f7    	mov	x23, x0
105513cc8: f00d4d28    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
105513ccc: f944e501    	ldr	x1, [x8, #0x9c8] ; recentForwardSessions
105513cd0: 949c4d1b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513cd4: aa1d03fd    	mov	x29, x29
105513cd8: 949c4d1c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105513cdc: aa0003f5    	mov	x21, x0
105513ce0: aa1703e0    	mov	x0, x23
105513ce4: 949c4d1c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105513ce8: aa1603e0    	mov	x0, x22
105513cec: 949c4d1a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105513cf0: b00d5f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105513cf4: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
105513cf8: 910083e2    	add	x2, sp, #0x20
105513cfc: 910183e3    	add	x3, sp, #0x60
105513d00: aa1503e0    	mov	x0, x21
105513d04: f90003e1    	str	x1, [sp]
105513d08: 52800204    	mov	w4, #0x10               ; =16
105513d0c: 949c4d0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513d10: b40008e0    	cbz	x0, 0x105513e2c <_Flutter_MMFoundation_BindContext+0x19efa10>
105513d14: aa0003f7    	mov	x23, x0
105513d18: f9401be8    	ldr	x8, [sp, #0x30]
105513d1c: f9400114    	ldr	x20, [x8]
105513d20: b00d68dc    	adrp	x28, 0x12022c000 <dyld_stub_binder+0x12022c000>
105513d24: d280001b    	mov	x27, #0x0               ; =0
105513d28: 900d4948    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105513d2c: f947d918    	ldr	x24, [x8, #0xfb0] ; m_contact
105513d30: 900d4948    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105513d34: f947d119    	ldr	x25, [x8, #0xfa0] ; isChatroom
105513d38: f00d4a08    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
105513d3c: f942c51a    	ldr	x26, [x8, #0x588] ; isAccountDeleted
105513d40: b00d4ae8    	adrp	x8, 0x11fe70000 <dyld_stub_binder+0x11fe70000>
105513d44: f9420509    	ldr	x9, [x8, #0x408] ; isCustAsst
105513d48: f00d4928    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105513d4c: f943c508    	ldr	x8, [x8, #0x788] ; safeAddObject:
105513d50: a90127e8    	stp	x8, x9, [sp, #0x10]
105513d54: f9401be8    	ldr	x8, [sp, #0x30]
105513d58: f9400108    	ldr	x8, [x8]
105513d5c: eb14011f    	cmp	x8, x20
105513d60: 54000060    	b.eq	0x105513d6c <_Flutter_MMFoundation_BindContext+0x19ef950>
105513d64: aa1503e0    	mov	x0, x21
105513d68: 949c4cfa    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
105513d6c: f94017e8    	ldr	x8, [sp, #0x28]
105513d70: f87b7900    	ldr	x0, [x8, x27, lsl #3]
105513d74: aa1803e1    	mov	x1, x24
105513d78: 949c4cf1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513d7c: aa1d03fd    	mov	x29, x29
105513d80: 949c4cf2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105513d84: aa0003f6    	mov	x22, x0
105513d88: b9851388    	ldrsw	x8, [x28, #0x510] ; ivar RecentForwardScrollView.m_bIgnoreChatRoom
105513d8c: 38686a68    	ldrb	w8, [x19, x8]
105513d90: 7100051f    	cmp	w8, #0x1
105513d94: 540000a1    	b.ne	0x105513da8 <_Flutter_MMFoundation_BindContext+0x19ef98c>
105513d98: aa1603e0    	mov	x0, x22
105513d9c: aa1903e1    	mov	x1, x25
105513da0: 949c4ce7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513da4: 370002a0    	tbnz	w0, #0x0, 0x105513df8 <_Flutter_MMFoundation_BindContext+0x19ef9dc>
105513da8: b00d68c8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105513dac: b9851908    	ldrsw	x8, [x8, #0x518] ; ivar RecentForwardScrollView.m_onlyChatRoom
105513db0: 38686a68    	ldrb	w8, [x19, x8]
105513db4: 7100051f    	cmp	w8, #0x1
105513db8: 540000a1    	b.ne	0x105513dcc <_Flutter_MMFoundation_BindContext+0x19ef9b0>
105513dbc: aa1603e0    	mov	x0, x22
105513dc0: aa1903e1    	mov	x1, x25
105513dc4: 949c4cde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513dc8: 34000180    	cbz	w0, 0x105513df8 <_Flutter_MMFoundation_BindContext+0x19ef9dc>
105513dcc: aa1603e0    	mov	x0, x22
105513dd0: aa1a03e1    	mov	x1, x26
105513dd4: 949c4cda    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513dd8: 37000100    	tbnz	w0, #0x0, 0x105513df8 <_Flutter_MMFoundation_BindContext+0x19ef9dc>
105513ddc: aa1603e0    	mov	x0, x22
105513de0: f9400fe1    	ldr	x1, [sp, #0x18]
105513de4: 949c4cd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513de8: 37000080    	tbnz	w0, #0x0, 0x105513df8 <_Flutter_MMFoundation_BindContext+0x19ef9dc>
105513dec: a94087e0    	ldp	x0, x1, [sp, #0x8]
105513df0: aa1603e2    	mov	x2, x22
105513df4: 949c4cd2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513df8: aa1603e0    	mov	x0, x22
105513dfc: 949c4cd6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105513e00: 9100077b    	add	x27, x27, #0x1
105513e04: eb1b02ff    	cmp	x23, x27
105513e08: 54fffa61    	b.ne	0x105513d54 <_Flutter_MMFoundation_BindContext+0x19ef938>
105513e0c: 910083e2    	add	x2, sp, #0x20
105513e10: 910183e3    	add	x3, sp, #0x60
105513e14: aa1503e0    	mov	x0, x21
105513e18: f94003e1    	ldr	x1, [sp]
105513e1c: 52800204    	mov	w4, #0x10               ; =16
105513e20: 949c4cc7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105513e24: aa0003f7    	mov	x23, x0
105513e28: b5fff7e0    	cbnz	x0, 0x105513d24 <_Flutter_MMFoundation_BindContext+0x19ef908>
105513e2c: aa1503e0    	mov	x0, x21
105513e30: 949c4cc9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105513e34: f85a03a8    	ldur	x8, [x29, #-0x60]
105513e38: 900c06e9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
105513e3c: f9405929    	ldr	x9, [x9, #0xb0]
105513e40: f9400129    	ldr	x9, [x9]
105513e44: eb08013f    	cmp	x9, x8
105513e48: 54000141    	b.ne	0x105513e70 <_Flutter_MMFoundation_BindContext+0x19efa54>
105513e4c: f94007e0    	ldr	x0, [sp, #0x8]
105513e50: a9547bfd    	ldp	x29, x30, [sp, #0x140]
105513e54: a9534ff4    	ldp	x20, x19, [sp, #0x130]
105513e58: a95257f6    	ldp	x22, x21, [sp, #0x120]
105513e5c: a9515ff8    	ldp	x24, x23, [sp, #0x110]
105513e60: a95067fa    	ldp	x26, x25, [sp, #0x100]
105513e64: a94f6ffc    	ldp	x28, x27, [sp, #0xf0]
105513e68: 910543ff    	add	sp, sp, #0x150
105513e6c: 149c4cc1    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
105513e70: 949c4cc1    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
