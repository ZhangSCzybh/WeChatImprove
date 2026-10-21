
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101b5f9a8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101b5f9ac: a9014ff4    	stp	x20, x19, [sp, #0x10]
101b5f9b0: a9027bfd    	stp	x29, x30, [sp, #0x20]
101b5f9b4: 910083fd    	add	x29, sp, #0x20
101b5f9b8: aa0003f3    	mov	x19, x0
101b5f9bc: b00f34a8    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101b5f9c0: b9806908    	ldrsw	x8, [x8, #0x68]
101b5f9c4: f8686802    	ldr	x2, [x0, x8]
101b5f9c8: b4000282    	cbz	x2, 0x101b5fa18 <__text+0x1b57a18>
101b5f9cc: b00f34a8    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101b5f9d0: b9802108    	ldrsw	x8, [x8, #0x20]
101b5f9d4: f8686a74    	ldr	x20, [x19, x8]
101b5f9d8: 900f30a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b5f9dc: f9456d00    	ldr	x0, [x8, #0xad8]
101b5f9e0: 900f2d08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101b5f9e4: f941bd01    	ldr	x1, [x8, #0x378] ; arrayWithObject:
101b5f9e8: 95831dd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b5f9ec: aa1d03fd    	mov	x29, x29
101b5f9f0: 95831dd6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b5f9f4: aa0003f5    	mov	x21, x0
101b5f9f8: b00f1768    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
101b5f9fc: f9450901    	ldr	x1, [x8, #0xa10] ; reloadRowsAtIndexPaths:withRowAnimation:
101b5fa00: aa1403e0    	mov	x0, x20
101b5fa04: aa1503e2    	mov	x2, x21
101b5fa08: 528000a3    	mov	w3, #0x5                ; =5
101b5fa0c: 95831dcc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b5fa10: aa1503e0    	mov	x0, x21
101b5fa14: 95831dd0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b5fa18: b00f30a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101b5fa1c: f9408d00    	ldr	x0, [x8, #0x118]
101b5fa20: f00f1708    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
101b5fa24: f942a901    	ldr	x1, [x8, #0x550] ; getTabBarController
101b5fa28: 95831dc5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b5fa2c: aa1d03fd    	mov	x29, x29
101b5fa30: 95831dc6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b5fa34: aa0003f4    	mov	x20, x0
101b5fa38: 900f1ac8    	adrp	x8, 0x11feb7000 <dyld_stub_binder+0x11feb7000>
101b5fa3c: f9434901    	ldr	x1, [x8, #0x690] ; removeRedDotOnTabBarItemAtIndex:
101b5fa40: 52800042    	mov	w2, #0x2                ; =2
101b5fa44: 95831dbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b5fa48: aa1403e0    	mov	x0, x20
101b5fa4c: 95831dc2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b5fa50: 900f1968    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
101b5fa54: f9434901    	ldr	x1, [x8, #0x690] ; updateTabBarBadge
101b5fa58: aa1303e0    	mov	x0, x19
101b5fa5c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101b5fa60: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101b5fa64: a8c357f6    	ldp	x22, x21, [sp], #0x30
101b5fa68: 15831db5    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
