
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104abec50: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104abec54: a9014ff4    	stp	x20, x19, [sp, #0x10]
104abec58: a9027bfd    	stp	x29, x30, [sp, #0x20]
104abec5c: 910083fd    	add	x29, sp, #0x20
104abec60: aa0003f3    	mov	x19, x0
104abec64: b00dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abec68: b9848514    	ldrsw	x20, [x8, #0x484]
104abec6c: b8746815    	ldr	w21, [x0, x20]
104abec70: f00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abec74: f9414101    	ldr	x1, [x8, #0x280] ; selector p_createNewMainFrameViewController
104abec78: 94c5a131    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abec7c: f00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abec80: f9414501    	ldr	x1, [x8, #0x288] ; selector p_createContactsViewController
104abec84: aa1303e0    	mov	x0, x19
104abec88: 94c5a12d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abec8c: f00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abec90: f9414901    	ldr	x1, [x8, #0x290] ; selector p_createFindFriendViewController
104abec94: aa1303e0    	mov	x0, x19
104abec98: 94c5a129    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abec9c: f00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abeca0: f9414d01    	ldr	x1, [x8, #0x298] ; selector p_createMoreViewController
104abeca4: aa1303e0    	mov	x0, x19
104abeca8: 94c5a125    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abecac: b8746a68    	ldr	w8, [x19, x20]
104abecb0: 6b15011f    	cmp	w8, w21
104abecb4: 540000a1    	b.ne	0x104abecc8 <_Flutter_MMFoundation_BindContext+0xf9a8ac>
104abecb8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104abecbc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104abecc0: a8c357f6    	ldp	x22, x21, [sp], #0x30
104abecc4: d65f03c0    	ret
104abecc8: b00dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abeccc: b9848908    	ldrsw	x8, [x8, #0x488]
104abecd0: f8686a62    	ldr	x2, [x19, x8]
104abecd4: d00d9d88    	adrp	x8, 0x11fe70000 <dyld_stub_binder+0x11fe70000>
104abecd8: f9410101    	ldr	x1, [x8, #0x200] ; selector setViewControllers:
104abecdc: aa1303e0    	mov	x0, x19
104abece0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104abece4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104abece8: a8c357f6    	ldp	x22, x21, [sp], #0x30
104abecec: 14c5a114    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
