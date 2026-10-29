
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a704d4: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104a704d8: a90157f6    	stp	x22, x21, [sp, #0x10]
104a704dc: a9024ff4    	stp	x20, x19, [sp, #0x20]
104a704e0: a9037bfd    	stp	x29, x30, [sp, #0x30]
104a704e4: 9100c3fd    	add	x29, sp, #0x30
104a704e8: aa0003f3    	mov	x19, x0
104a704ec: 900db488    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a704f0: f946f114    	ldr	x20, [x8, #0xde0] ; selector delegate
104a704f4: aa1403e1    	mov	x1, x20
104a704f8: 94c6db11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a704fc: aa1d03fd    	mov	x29, x29
104a70500: 94c6db12    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a70504: b4000440    	cbz	x0, 0x104a7058c <_Flutter_MMFoundation_BindContext+0xf4c170>
104a70508: aa0003f6    	mov	x22, x0
104a7050c: aa1303e0    	mov	x0, x19
104a70510: aa1403e1    	mov	x1, x20
104a70514: 94c6db0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70518: aa1d03fd    	mov	x29, x29
104a7051c: 94c6db0b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a70520: aa0003f7    	mov	x23, x0
104a70524: 900da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a70528: f9409515    	ldr	x21, [x8, #0x128] ; selector onSessionUnreadChange
104a7052c: d00db4a8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104a70530: f9436101    	ldr	x1, [x8, #0x6c0] ; selector respondsToSelector:
104a70534: aa1503e2    	mov	x2, x21
104a70538: 94c6db01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7053c: aa0003f8    	mov	x24, x0
104a70540: aa1703e0    	mov	x0, x23
104a70544: 94c6db04    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a70548: aa1603e0    	mov	x0, x22
104a7054c: 94c6db02    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a70550: 340001f8    	cbz	w24, 0x104a7058c <_Flutter_MMFoundation_BindContext+0xf4c170>
104a70554: aa1303e0    	mov	x0, x19
104a70558: aa1403e1    	mov	x1, x20
104a7055c: 94c6daf8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70560: aa1d03fd    	mov	x29, x29
104a70564: 94c6daf9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a70568: aa0003f3    	mov	x19, x0
104a7056c: aa1503e1    	mov	x1, x21
104a70570: 94c6daf3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70574: aa1303e0    	mov	x0, x19
104a70578: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104a7057c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104a70580: a94157f6    	ldp	x22, x21, [sp, #0x10]
104a70584: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104a70588: 14c6daf3    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7058c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104a70590: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104a70594: a94157f6    	ldp	x22, x21, [sp, #0x10]
104a70598: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104a7059c: d65f03c0    	ret
