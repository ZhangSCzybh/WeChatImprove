
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4c0cc: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100e4c0d0: a9014ff4    	stp	x20, x19, [sp, #0x10]
100e4c0d4: a9027bfd    	stp	x29, x30, [sp, #0x20]
100e4c0d8: 910083fd    	add	x29, sp, #0x20
100e4c0dc: aa0003f3    	mov	x19, x0
100e4c0e0: d00f95e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100e4c0e4: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
100e4c0e8: 95b76c15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4c0ec: aa1d03fd    	mov	x29, x29
100e4c0f0: 95b76c16    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4c0f4: aa0003f4    	mov	x20, x0
100e4c0f8: d00f95c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
100e4c0fc: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
100e4c100: 95b76c0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4c104: aa1403e0    	mov	x0, x20
100e4c108: 95b76c13    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4c10c: f00f9928    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4c110: f945e900    	ldr	x0, [x8, #0xbd0]
100e4c114: 900f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4c118: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100e4c11c: 95b76c08    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4c120: aa1d03fd    	mov	x29, x29
100e4c124: 95b76c09    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4c128: aa0003f4    	mov	x20, x0
100e4c12c: f00f9968    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100e4c130: f9420500    	ldr	x0, [x8, #0x408]
100e4c134: f00f9588    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e4c138: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100e4c13c: 95b76c00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4c140: aa0003e2    	mov	x2, x0
100e4c144: b00f7f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e4c148: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100e4c14c: aa1403e0    	mov	x0, x20
100e4c150: 95b76bfb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4c154: aa1d03fd    	mov	x29, x29
100e4c158: 95b76bfc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4c15c: aa0003f5    	mov	x21, x0
100e4c160: 900f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4c164: f943dd01    	ldr	x1, [x8, #0x7b8] ; chatBoxSessionCount
100e4c168: 95b76bf5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4c16c: f100001f    	cmp	x0, #0x0
100e4c170: 1a9f07e2    	cset	w2, ne
100e4c174: 900f9ce8    	adrp	x8, 0x1201e8000 <dyld_stub_binder+0x1201e8000>
100e4c178: b9857508    	ldrsw	x8, [x8, #0x574]
100e4c17c: f8686a60    	ldr	x0, [x19, x8]
100e4c180: 900f95e8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
100e4c184: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
100e4c188: 95b76bed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4c18c: aa1503e0    	mov	x0, x21
100e4c190: 95b76bf1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4c194: aa1403e0    	mov	x0, x20
100e4c198: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100e4c19c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100e4c1a0: a8c357f6    	ldp	x22, x21, [sp], #0x30
100e4c1a4: 15b76bec    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
