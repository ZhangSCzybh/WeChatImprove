
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104abf994: d100c3ff    	sub	sp, sp, #0x30
104abf998: a9014ff4    	stp	x20, x19, [sp, #0x10]
104abf99c: a9027bfd    	stp	x29, x30, [sp, #0x20]
104abf9a0: 910083fd    	add	x29, sp, #0x20
104abf9a4: aa0003f3    	mov	x19, x0
104abf9a8: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abf9ac: b984a114    	ldrsw	x20, [x8, #0x4a0]
104abf9b0: f8746800    	ldr	x0, [x0, x20]
104abf9b4: b50000e0    	cbnz	x0, 0x104abf9d0 <_Flutter_MMFoundation_BindContext+0xf9b5b4>
104abf9b8: d00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abf9bc: f9414101    	ldr	x1, [x8, #0x280] ; selector p_createNewMainFrameViewController
104abf9c0: aa1303e0    	mov	x0, x19
104abf9c4: 94c59dde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf9c8: f8746a60    	ldr	x0, [x19, x20]
104abf9cc: b40000c0    	cbz	x0, 0x104abf9e4 <_Flutter_MMFoundation_BindContext+0xf9b5c8>
104abf9d0: 94c59dda    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104abf9d4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104abf9d8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104abf9dc: 9100c3ff    	add	sp, sp, #0x30
104abf9e0: 14c59de4    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104abf9e4: 900db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abf9e8: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104abf9ec: d00d9bc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104abf9f0: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104abf9f4: 900ce708    	adrp	x8, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
104abf9f8: 910ea108    	add	x8, x8, #0x3a8 ; CFString 'create main frame controller is nil!!'
104abf9fc: f90003e8    	str	x8, [sp]
104abfa00: f00b3b43    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104abfa04: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
104abfa08: 900b69a5    	adrp	x5, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abfa0c: 910370a5    	add	x5, x5, #0xdc ; string 'MainTabBarViewController.mm'
104abfa10: 900b69a7    	adrp	x7, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abfa14: 910c80e7    	add	x7, x7, #0x320 ; string '-[MainTabBarViewController p_getNewMainFrameViewController]'
104abfa18: 52800082    	mov	w2, #0x4                ; =4
104abfa1c: 52800004    	mov	w4, #0x0                ; =0
104abfa20: 52803726    	mov	w6, #0x1b9              ; =441
104abfa24: 94c59dc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abfa28: d2800000    	mov	x0, #0x0                ; =0
104abfa2c: 17ffffea    	b	0x104abf9d4 <_Flutter_MMFoundation_BindContext+0xf9b5b8>
