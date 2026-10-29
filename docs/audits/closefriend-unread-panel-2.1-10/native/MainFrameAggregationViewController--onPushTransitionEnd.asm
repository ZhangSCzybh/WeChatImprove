
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a7455c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104a74560: a9017bfd    	stp	x29, x30, [sp, #0x10]
104a74564: 910043fd    	add	x29, sp, #0x10
104a74568: aa0003f3    	mov	x19, x0
104a7456c: 900da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a74570: f9413901    	ldr	x1, [x8, #0x270] ; selector setIsTransitioning:
104a74574: 52800002    	mov	w2, #0x0                ; =0
104a74578: 94c6caf1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7457c: 900da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a74580: f9413d01    	ldr	x1, [x8, #0x278] ; selector needReloadAfterTransition
104a74584: aa1303e0    	mov	x0, x19
104a74588: 94c6caed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7458c: 34000220    	cbz	w0, 0x104a745d0 <_Flutter_MMFoundation_BindContext+0xf501b4>
104a74590: b00da3e8    	adrp	x8, 0x11fef1000 <dyld_stub_binder+0x11fef1000>
104a74594: f9406502    	ldr	x2, [x8, #0xc8] ; selector updateContent
104a74598: d00d9e28    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104a7459c: f9408101    	ldr	x1, [x8, #0x100] ; selector safePerformSelector:withObject:afterDelay:
104a745a0: b00a1868    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
104a745a4: fd429900    	ldr	d0, [x8, #0x530]
104a745a8: aa1303e0    	mov	x0, x19
104a745ac: d2800003    	mov	x3, #0x0                ; =0
104a745b0: 94c6cae3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a745b4: 900da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a745b8: f9414101    	ldr	x1, [x8, #0x280] ; selector setNeedReloadAfterTransition:
104a745bc: aa1303e0    	mov	x0, x19
104a745c0: 52800002    	mov	w2, #0x0                ; =0
104a745c4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104a745c8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104a745cc: 14c6cadc    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a745d0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104a745d4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104a745d8: d65f03c0    	ret
