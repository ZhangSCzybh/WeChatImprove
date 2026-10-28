
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105118a04: d10103ff    	sub	sp, sp, #0x40
105118a08: a90157f6    	stp	x22, x21, [sp, #0x10]
105118a0c: a9024ff4    	stp	x20, x19, [sp, #0x20]
105118a10: a9037bfd    	stp	x29, x30, [sp, #0x30]
105118a14: 9100c3fd    	add	x29, sp, #0x30
105118a18: aa0003f3    	mov	x19, x0
105118a1c: f00d82c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105118a20: f9462d00    	ldr	x0, [x8, #0xc58] ; WCColor
105118a24: f00d7f28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105118a28: f942f101    	ldr	x1, [x8, #0x5e0] ; backgroundColor
105118a2c: 94ac39c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118a30: aa1d03fd    	mov	x29, x29
105118a34: 94ac39c5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105118a38: aa0003f4    	mov	x20, x0
105118a3c: f00d7f88    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
105118a40: f946d501    	ldr	x1, [x8, #0xda8] ; view
105118a44: aa1303e0    	mov	x0, x19
105118a48: 94ac39bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118a4c: aa1d03fd    	mov	x29, x29
105118a50: 94ac39be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105118a54: aa0003f5    	mov	x21, x0
105118a58: f00d7f68    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105118a5c: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
105118a60: aa1403e2    	mov	x2, x20
105118a64: 94ac39b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118a68: aa1503e0    	mov	x0, x21
105118a6c: 94ac39ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105118a70: aa1403e0    	mov	x0, x20
105118a74: 94ac39b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105118a78: f00d6908    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105118a7c: f946e101    	ldr	x1, [x8, #0xdc0] ; setHidesBottomBarWhenPushed:
105118a80: aa1303e0    	mov	x0, x19
105118a84: 52800002    	mov	w2, #0x0                ; =0
105118a88: 94ac39ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118a8c: 900d6928    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105118a90: f9443901    	ldr	x1, [x8, #0x870] ; initTitle
105118a94: aa1303e0    	mov	x0, x19
105118a98: 94ac39a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118a9c: 900d6928    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105118aa0: f9443d01    	ldr	x1, [x8, #0x878] ; initTableView
105118aa4: aa1303e0    	mov	x0, x19
105118aa8: 94ac39a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118aac: f00d6988    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
105118ab0: f940ad01    	ldr	x1, [x8, #0x158] ; initTableHeaderView
105118ab4: aa1303e0    	mov	x0, x19
105118ab8: 94ac39a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118abc: f00d82c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105118ac0: f9453513    	ldr	x19, [x8, #0xa68] ; iConsole
105118ac4: f00d82c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105118ac8: f9461900    	ldr	x0, [x8, #0xc30]
105118acc: b00d6ac8    	adrp	x8, 0x11fe71000 <dyld_stub_binder+0x11fe71000>
105118ad0: f9460d01    	ldr	x1, [x8, #0xc18] ; globalFontLevel
105118ad4: 94ac399a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118ad8: b00d6908    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105118adc: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
105118ae0: 900cb5e8    	adrp	x8, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
105118ae4: 91222108    	add	x8, x8, #0x888 ; CFString 'FontLevel:%u'
105118ae8: a90003e8    	stp	x8, x0, [sp]
105118aec: 900b3a05    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
105118af0: 9122e0a5    	add	x5, x5, #0x8b8
105118af4: b00b3a07    	adrp	x7, 0x11b859000 <dyld_stub_binder+0x11b859000>
105118af8: 911628e7    	add	x7, x7, #0x58a
105118afc: aa1303e0    	mov	x0, x19
105118b00: 52800042    	mov	w2, #0x2                ; =2
105118b04: d2800003    	mov	x3, #0x0                ; =0
105118b08: 52800004    	mov	w4, #0x0                ; =0
105118b0c: 5280b886    	mov	w6, #0x5c4              ; =1476
105118b10: 94ac398b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105118b14: a9437bfd    	ldp	x29, x30, [sp, #0x30]
105118b18: a9424ff4    	ldp	x20, x19, [sp, #0x20]
105118b1c: a94157f6    	ldp	x22, x21, [sp, #0x10]
105118b20: 910103ff    	add	sp, sp, #0x40
105118b24: d65f03c0    	ret
