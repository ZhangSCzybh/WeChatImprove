
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105182a38: d100c3ff    	sub	sp, sp, #0x30
105182a3c: a9014ff4    	stp	x20, x19, [sp, #0x10]
105182a40: a9027bfd    	stp	x29, x30, [sp, #0x20]
105182a44: 910083fd    	add	x29, sp, #0x20
105182a48: aa0203f3    	mov	x19, x2
105182a4c: aa0003f4    	mov	x20, x0
105182a50: 94aa91ba    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105182a54: 94aa91da    	bl	0x107c271bc <_Flutter_MMFoundation_BindContext+0x4102da0>
105182a58: d00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105182a5c: b9892508    	ldrsw	x8, [x8, #0x924] ; ivar NewSyncService.m_uiSelector offset=12 type=I
105182a60: b8286a93    	str	w19, [x20, x8]
105182a64: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105182a68: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
105182a6c: f00d65a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105182a70: f942a901    	ldr	x1, [x8, #0x550] ; selector/string logWithLevel:module:errorCode:file:line:func:format:
105182a74: b00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105182a78: 913ea108    	add	x8, x8, #0xfa8 ; CFString 'new selector %x'
105182a7c: a9004fe8    	stp	x8, x19, [sp]
105182a80: d00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105182a84: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
105182a88: 900b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182a8c: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm'
105182a90: 900b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182a94: 913b90e7    	add	x7, x7, #0xee4 ; string '-[NewSyncService SetSelector:]'
105182a98: 52800042    	mov	w2, #0x2                ; =2
105182a9c: 52800004    	mov	w4, #0x0                ; =0
105182aa0: 52803ec6    	mov	w6, #0x1f6              ; =502
105182aa4: 94aa91a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182aa8: aa1403e0    	mov	x0, x20
105182aac: 94aa91d2    	bl	0x107c271f4 <_Flutter_MMFoundation_BindContext+0x4102dd8>
105182ab0: aa1403e0    	mov	x0, x20
105182ab4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105182ab8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105182abc: 9100c3ff    	add	sp, sp, #0x30
105182ac0: 14aa91a5    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
