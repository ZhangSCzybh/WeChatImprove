
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101b4f1d8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101b4f1dc: a9014ff4    	stp	x20, x19, [sp, #0x10]
101b4f1e0: a9027bfd    	stp	x29, x30, [sp, #0x20]
101b4f1e4: 910083fd    	add	x29, sp, #0x20
101b4f1e8: d00f3128    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
101b4f1ec: f940d500    	ldr	x0, [x8, #0x1a8]
101b4f1f0: f00f1788    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
101b4f1f4: f9430101    	ldr	x1, [x8, #0x600] ; isPluginInstalled:
101b4f1f8: 52800182    	mov	w2, #0xc                ; =12
101b4f1fc: 95835fd0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4f200: 34000560    	cbz	w0, 0x101b4f2ac <__text+0x1b472ac>
101b4f204: b00f3188    	adrp	x8, 0x120180000 <dyld_stub_binder+0x120180000>
101b4f208: f9450d00    	ldr	x0, [x8, #0xa18]
101b4f20c: b00f1b48    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b4f210: f9422101    	ldr	x1, [x8, #0x440] ; isMutualFriendsInteractionReminderEnabled
101b4f214: 95835fca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4f218: aa0003f3    	mov	x19, x0
101b4f21c: 900f3128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b4f220: f945e900    	ldr	x0, [x8, #0xbd0]
101b4f224: b00f2d88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101b4f228: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101b4f22c: 95835fc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4f230: aa1d03fd    	mov	x29, x29
101b4f234: 95835fc5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4f238: aa0003f4    	mov	x20, x0
101b4f23c: b00f3128    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101b4f240: f9428500    	ldr	x0, [x8, #0x508]
101b4f244: 900f2d88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101b4f248: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101b4f24c: 95835fbc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4f250: aa0003e2    	mov	x2, x0
101b4f254: d00f1748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101b4f258: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101b4f25c: aa1403e0    	mov	x0, x20
101b4f260: 95835fb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4f264: aa1d03fd    	mov	x29, x29
101b4f268: 95835fb8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4f26c: aa0003f5    	mov	x21, x0
101b4f270: b00f1ae8    	adrp	x8, 0x11feac000 <dyld_stub_binder+0x11feac000>
101b4f274: 910fc108    	add	x8, x8, #0x3f0
101b4f278: b00f1b49    	adrp	x9, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b4f27c: 91112129    	add	x9, x9, #0x448
101b4f280: 7100027f    	cmp	w19, #0x0
101b4f284: 9a891108    	csel	x8, x8, x9, ne
101b4f288: f9400101    	ldr	x1, [x8]
101b4f28c: 95835fac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4f290: aa0003f3    	mov	x19, x0
101b4f294: aa1503e0    	mov	x0, x21
101b4f298: 95835faf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4f29c: aa1403e0    	mov	x0, x20
101b4f2a0: 95835fad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4f2a4: 2a1303e0    	mov	w0, w19
101b4f2a8: 14000002    	b	0x101b4f2b0 <__text+0x1b472b0>
101b4f2ac: d2800000    	mov	x0, #0x0                ; =0
101b4f2b0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101b4f2b4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101b4f2b8: a8c357f6    	ldp	x22, x21, [sp], #0x30
101b4f2bc: d65f03c0    	ret
