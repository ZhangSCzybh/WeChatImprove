
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101b4849c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101b484a0: a9014ff4    	stp	x20, x19, [sp, #0x10]
101b484a4: a9027bfd    	stp	x29, x30, [sp, #0x20]
101b484a8: 910083fd    	add	x29, sp, #0x20
101b484ac: 900f31c8    	adrp	x8, 0x120180000 <dyld_stub_binder+0x120180000>
101b484b0: f9450d00    	ldr	x0, [x8, #0xa18]
101b484b4: 900f1b88    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b484b8: f9422101    	ldr	x1, [x8, #0x440] ; isMutualFriendsInteractionReminderEnabled
101b484bc: 95837b20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b484c0: aa0003f3    	mov	x19, x0
101b484c4: f00f3148    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b484c8: f945e900    	ldr	x0, [x8, #0xbd0]
101b484cc: 900f2dc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101b484d0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101b484d4: 95837b1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b484d8: aa1d03fd    	mov	x29, x29
101b484dc: 95837b1b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b484e0: aa0003f4    	mov	x20, x0
101b484e4: 900f3168    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101b484e8: f9428500    	ldr	x0, [x8, #0x508]
101b484ec: f00f2da8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101b484f0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101b484f4: 95837b12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b484f8: aa0003e2    	mov	x2, x0
101b484fc: b00f1788    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101b48500: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101b48504: aa1403e0    	mov	x0, x20
101b48508: 95837b0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4850c: aa1d03fd    	mov	x29, x29
101b48510: 95837b0e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b48514: aa0003f5    	mov	x21, x0
101b48518: 900f1b28    	adrp	x8, 0x11feac000 <dyld_stub_binder+0x11feac000>
101b4851c: 910fc108    	add	x8, x8, #0x3f0
101b48520: 900f1b89    	adrp	x9, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b48524: 91112129    	add	x9, x9, #0x448
101b48528: 7100027f    	cmp	w19, #0x0
101b4852c: 9a891108    	csel	x8, x8, x9, ne
101b48530: f9400101    	ldr	x1, [x8]
101b48534: 95837b02    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b48538: aa0003f3    	mov	x19, x0
101b4853c: aa1503e0    	mov	x0, x21
101b48540: 95837b05    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b48544: aa1403e0    	mov	x0, x20
101b48548: 95837b03    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4854c: 2a1303e0    	mov	w0, w19
101b48550: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101b48554: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101b48558: a8c357f6    	ldp	x22, x21, [sp], #0x30
101b4855c: d65f03c0    	ret
