
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a8f280: d100c3ff    	sub	sp, sp, #0x30
104a8f284: a9014ff4    	stp	x20, x19, [sp, #0x10]
104a8f288: a9027bfd    	stp	x29, x30, [sp, #0x20]
104a8f28c: 910083fd    	add	x29, sp, #0x20
104a8f290: aa0003f3    	mov	x19, x0
104a8f294: d00db9a8    	adrp	x8, 0x1201c5000 <dyld_stub_binder+0x1201c5000>
104a8f298: f942bd08    	ldr	x8, [x8, #0x578] ; MainFrameItemView
104a8f29c: a90023e0    	stp	x0, x8, [sp]
104a8f2a0: f00d9d68    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104a8f2a4: f940a901    	ldr	x1, [x8, #0x150] ; layoutSubviews
104a8f2a8: 910003e0    	mov	x0, sp
104a8f2ac: 94c65fa6    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104a8f2b0: f00da0e8    	adrp	x8, 0x11feae000 <dyld_stub_binder+0x11feae000>
104a8f2b4: f941c901    	ldr	x1, [x8, #0x390] ; updateHeadView
104a8f2b8: aa1303e0    	mov	x0, x19
104a8f2bc: 94c65fa0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f2c0: b00da7a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a8f2c4: f9440901    	ldr	x1, [x8, #0x810] ; updateUnreadCountView
104a8f2c8: aa1303e0    	mov	x0, x19
104a8f2cc: 94c65f9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f2d0: b00d9dc8    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
104a8f2d4: f9418101    	ldr	x1, [x8, #0x300] ; updateTimeLabel
104a8f2d8: aa1303e0    	mov	x0, x19
104a8f2dc: 94c65f98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f2e0: b00d9dc8    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
104a8f2e4: f9417901    	ldr	x1, [x8, #0x2f0] ; updateNameLabel
104a8f2e8: aa1303e0    	mov	x0, x19
104a8f2ec: 94c65f94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f2f0: b00da7a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a8f2f4: f9440d01    	ldr	x1, [x8, #0x818] ; updateStatusView
104a8f2f8: aa1303e0    	mov	x0, x19
104a8f2fc: 94c65f90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f300: 900d9fa8    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
104a8f304: f9404d01    	ldr	x1, [x8, #0x98] ; updateMessageLabel
104a8f308: aa1303e0    	mov	x0, x19
104a8f30c: 94c65f8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f310: b00da7a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a8f314: f9441101    	ldr	x1, [x8, #0x820] ; updateGroupView:
104a8f318: aa1303e0    	mov	x0, x19
104a8f31c: 52800002    	mov	w2, #0x0                ; =0
104a8f320: 94c65f87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f324: b00d9dc8    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
104a8f328: f9417d01    	ldr	x1, [x8, #0x2f8] ; updateStarView
104a8f32c: aa1303e0    	mov	x0, x19
104a8f330: 94c65f83    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f334: 900d9e68    	adrp	x8, 0x11fe5b000 <dyld_stub_binder+0x11fe5b000>
104a8f338: f9443d01    	ldr	x1, [x8, #0x878] ; updateLiveStatusView
104a8f33c: aa1303e0    	mov	x0, x19
104a8f340: 94c65f7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8f344: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104a8f348: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104a8f34c: 9100c3ff    	add	sp, sp, #0x30
104a8f350: d65f03c0    	ret
