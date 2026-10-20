
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10101a550: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10101a554: a90157f6    	stp	x22, x21, [sp, #0x10]
10101a558: a9024ff4    	stp	x20, x19, [sp, #0x20]
10101a55c: a9037bfd    	stp	x29, x30, [sp, #0x30]
10101a560: 9100c3fd    	add	x29, sp, #0x30
10101a564: aa0203f3    	mov	x19, x2
10101a568: aa0003f6    	mov	x22, x0
10101a56c: aa0203e0    	mov	x0, x2
10101a570: 95b032f2    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10101a574: f00f8e68    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
10101a578: b98fb918    	ldrsw	x24, [x8, #0xfb8] ; ivar ContactSelectView.m_delegate
10101a57c: 8b1802c0    	add	x0, x22, x24
10101a580: 95b03303    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10101a584: aa0003f4    	mov	x20, x0
10101a588: b40002a0    	cbz	x0, 0x10101a5dc <__text+0x10125dc>
10101a58c: 8b1802c0    	add	x0, x22, x24
10101a590: 95b032ff    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10101a594: aa0003f5    	mov	x21, x0
10101a598: d00f7368    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10101a59c: f942dd17    	ldr	x23, [x8, #0x5b8] ; onFilterContactCandidate:
10101a5a0: 900f8768    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10101a5a4: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10101a5a8: aa1703e2    	mov	x2, x23
10101a5ac: 95b032e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10101a5b0: 340001a0    	cbz	w0, 0x10101a5e4 <__text+0x10125e4>
10101a5b4: 8b1802c0    	add	x0, x22, x24
10101a5b8: 95b032f5    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10101a5bc: aa0003f8    	mov	x24, x0
10101a5c0: aa1703e1    	mov	x1, x23
10101a5c4: aa1303e2    	mov	x2, x19
10101a5c8: 95b032dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10101a5cc: aa0003f6    	mov	x22, x0
10101a5d0: aa1803e0    	mov	x0, x24
10101a5d4: 95b032e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10101a5d8: 14000004    	b	0x10101a5e8 <__text+0x10125e8>
10101a5dc: 52800036    	mov	w22, #0x1               ; =1
10101a5e0: 14000004    	b	0x10101a5f0 <__text+0x10125f0>
10101a5e4: 52800036    	mov	w22, #0x1               ; =1
10101a5e8: aa1503e0    	mov	x0, x21
10101a5ec: 95b032da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10101a5f0: aa1403e0    	mov	x0, x20
10101a5f4: 95b032d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10101a5f8: aa1303e0    	mov	x0, x19
10101a5fc: 95b032d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10101a600: aa1603e0    	mov	x0, x22
10101a604: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10101a608: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10101a60c: a94157f6    	ldp	x22, x21, [sp, #0x10]
10101a610: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10101a614: d65f03c0    	ret
