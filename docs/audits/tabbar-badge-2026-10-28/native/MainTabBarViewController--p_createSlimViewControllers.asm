
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104abf754: d101c3ff    	sub	sp, sp, #0x70
104abf758: a9016ffc    	stp	x28, x27, [sp, #0x10]
104abf75c: a90267fa    	stp	x26, x25, [sp, #0x20]
104abf760: a9035ff8    	stp	x24, x23, [sp, #0x30]
104abf764: a90457f6    	stp	x22, x21, [sp, #0x40]
104abf768: a9054ff4    	stp	x20, x19, [sp, #0x50]
104abf76c: a9067bfd    	stp	x29, x30, [sp, #0x60]
104abf770: 910183fd    	add	x29, sp, #0x60
104abf774: aa0003f3    	mov	x19, x0
104abf778: f00e0be8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104abf77c: 52800029    	mov	w9, #0x1                ; =1
104abf780: 390efd09    	strb	w9, [x8, #0x3bf]
104abf784: 900db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abf788: f9455500    	ldr	x0, [x8, #0xaa8] ; class NSMutableArray
104abf78c: 94c59e73    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104abf790: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abf794: b984891c    	ldrsw	x28, [x8, #0x488]
104abf798: f87c6a68    	ldr	x8, [x19, x28]
104abf79c: f83c6a60    	str	x0, [x19, x28]
104abf7a0: aa0803e0    	mov	x0, x8
104abf7a4: 94c59e6c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf7a8: d00db5a8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104abf7ac: f940fd00    	ldr	x0, [x8, #0x1f8] ; class UIViewController
104abf7b0: aa0803fa    	mov	x26, x8
104abf7b4: 94c59e69    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104abf7b8: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abf7bc: b9849116    	ldrsw	x22, [x8, #0x490]
104abf7c0: f8766a62    	ldr	x2, [x19, x22]
104abf7c4: d00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abf7c8: f9417915    	ldr	x21, [x8, #0x2f0] ; selector setTabBarItem:
104abf7cc: aa0003f4    	mov	x20, x0
104abf7d0: f90007e0    	str	x0, [sp, #0x8]
104abf7d4: aa1503e1    	mov	x1, x21
104abf7d8: 94c59e59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf7dc: f8766a60    	ldr	x0, [x19, x22]
104abf7e0: f00da548    	adrp	x8, 0x11ff6a000 <dyld_stub_binder+0x11ff6a000>
104abf7e4: f947dd16    	ldr	x22, [x8, #0xfb8] ; selector normalTitle
104abf7e8: aa1603e1    	mov	x1, x22
104abf7ec: 94c59e54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf7f0: aa1d03fd    	mov	x29, x29
104abf7f4: 94c59e55    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf7f8: aa0003f8    	mov	x24, x0
104abf7fc: d00db248    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104abf800: f9472117    	ldr	x23, [x8, #0xe40] ; selector setTitle:
104abf804: aa1403e0    	mov	x0, x20
104abf808: aa1703e1    	mov	x1, x23
104abf80c: aa1803e2    	mov	x2, x24
104abf810: 94c59e4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf814: aa1803e0    	mov	x0, x24
104abf818: 94c59e4f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf81c: f87c6a60    	ldr	x0, [x19, x28]
104abf820: f00d9bc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104abf824: f943c519    	ldr	x25, [x8, #0x788] ; selector safeAddObject:
104abf828: aa1903e1    	mov	x1, x25
104abf82c: aa1403e2    	mov	x2, x20
104abf830: 94c59e43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf834: aa1a03f4    	mov	x20, x26
104abf838: f940ff40    	ldr	x0, [x26, #0x1f8]
104abf83c: 94c59e47    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104abf840: aa0003f8    	mov	x24, x0
104abf844: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abf848: b984951a    	ldrsw	x26, [x8, #0x494]
104abf84c: f87a6a62    	ldr	x2, [x19, x26]
104abf850: aa1503e1    	mov	x1, x21
104abf854: 94c59e3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf858: f87a6a60    	ldr	x0, [x19, x26]
104abf85c: aa1603e1    	mov	x1, x22
104abf860: 94c59e37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf864: aa1d03fd    	mov	x29, x29
104abf868: 94c59e38    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf86c: aa0003fa    	mov	x26, x0
104abf870: aa1803e0    	mov	x0, x24
104abf874: aa1703e1    	mov	x1, x23
104abf878: aa1a03e2    	mov	x2, x26
104abf87c: 94c59e30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf880: aa1a03e0    	mov	x0, x26
104abf884: 94c59e34    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf888: f87c6a60    	ldr	x0, [x19, x28]
104abf88c: aa1903e1    	mov	x1, x25
104abf890: aa1803e2    	mov	x2, x24
104abf894: 94c59e2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf898: f940fe80    	ldr	x0, [x20, #0x1f8]
104abf89c: 94c59e2f    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104abf8a0: aa0003fa    	mov	x26, x0
104abf8a4: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abf8a8: b984991b    	ldrsw	x27, [x8, #0x498]
104abf8ac: f87b6a62    	ldr	x2, [x19, x27]
104abf8b0: aa1503e1    	mov	x1, x21
104abf8b4: 94c59e22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf8b8: f87b6a60    	ldr	x0, [x19, x27]
104abf8bc: aa1603e1    	mov	x1, x22
104abf8c0: 94c59e1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf8c4: aa1d03fd    	mov	x29, x29
104abf8c8: 94c59e20    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf8cc: aa0003fb    	mov	x27, x0
104abf8d0: aa1a03e0    	mov	x0, x26
104abf8d4: aa1703e1    	mov	x1, x23
104abf8d8: aa1b03e2    	mov	x2, x27
104abf8dc: 94c59e18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf8e0: aa1b03e0    	mov	x0, x27
104abf8e4: 94c59e1c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf8e8: f87c6a60    	ldr	x0, [x19, x28]
104abf8ec: aa1903e1    	mov	x1, x25
104abf8f0: aa1a03e2    	mov	x2, x26
104abf8f4: 94c59e12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf8f8: f940fe80    	ldr	x0, [x20, #0x1f8]
104abf8fc: 94c59e17    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104abf900: aa0003fb    	mov	x27, x0
104abf904: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abf908: b9849d14    	ldrsw	x20, [x8, #0x49c]
104abf90c: f8746a62    	ldr	x2, [x19, x20]
104abf910: aa1503e1    	mov	x1, x21
104abf914: 94c59e0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf918: f8746a60    	ldr	x0, [x19, x20]
104abf91c: aa1603e1    	mov	x1, x22
104abf920: 94c59e07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf924: aa1d03fd    	mov	x29, x29
104abf928: 94c59e08    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf92c: aa0003f5    	mov	x21, x0
104abf930: aa1b03e0    	mov	x0, x27
104abf934: aa1703e1    	mov	x1, x23
104abf938: aa1503e2    	mov	x2, x21
104abf93c: 94c59e00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf940: aa1503e0    	mov	x0, x21
104abf944: 94c59e04    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf948: f87c6a60    	ldr	x0, [x19, x28]
104abf94c: aa1903e1    	mov	x1, x25
104abf950: aa1b03e2    	mov	x2, x27
104abf954: 94c59dfa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf958: aa1b03e0    	mov	x0, x27
104abf95c: 94c59dfe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf960: aa1a03e0    	mov	x0, x26
104abf964: 94c59dfc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf968: aa1803e0    	mov	x0, x24
104abf96c: 94c59dfa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf970: f94007e0    	ldr	x0, [sp, #0x8]
104abf974: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104abf978: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104abf97c: a94457f6    	ldp	x22, x21, [sp, #0x40]
104abf980: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104abf984: a94267fa    	ldp	x26, x25, [sp, #0x20]
104abf988: a9416ffc    	ldp	x28, x27, [sp, #0x10]
104abf98c: 9101c3ff    	add	sp, sp, #0x70
104abf990: 14c59df1    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
