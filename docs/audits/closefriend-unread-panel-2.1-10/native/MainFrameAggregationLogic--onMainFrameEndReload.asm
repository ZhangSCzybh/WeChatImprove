
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a7039c: d10143ff    	sub	sp, sp, #0x50
104a703a0: a9015ff8    	stp	x24, x23, [sp, #0x10]
104a703a4: a90257f6    	stp	x22, x21, [sp, #0x20]
104a703a8: a9034ff4    	stp	x20, x19, [sp, #0x30]
104a703ac: a9047bfd    	stp	x29, x30, [sp, #0x40]
104a703b0: 910103fd    	add	x29, sp, #0x40
104a703b4: aa0003f3    	mov	x19, x0
104a703b8: f9401000    	ldr	x0, [x0, #0x20]
104a703bc: 900da068    	adrp	x8, 0x11fe7c000 <dyld_stub_binder+0x11fe7c000>
104a703c0: f9415901    	ldr	x1, [x8, #0x2b0] ; selector sortUsingFunction:context:
104a703c4: f0ffffe2    	adrp	x2, 0x104a6f000 <_Flutter_MMFoundation_BindContext+0xf4abe4>
104a703c8: 91177042    	add	x2, x2, #0x5dc
104a703cc: d2800003    	mov	x3, #0x0                ; =0
104a703d0: 94c6db5b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a703d4: f00db808    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a703d8: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104a703dc: b00d9e48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a703e0: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104a703e4: 900ce968    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a703e8: 91262108    	add	x8, x8, #0x988 ; CFString 'on finish reload'
104a703ec: f90003e8    	str	x8, [sp]
104a703f0: f00b6be5    	adrp	x5, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a703f4: 910ec8a5    	add	x5, x5, #0x3b2 ; string 'MainFrameAggregationLogic.mm'
104a703f8: f00b6be7    	adrp	x7, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a703fc: 91134ce7    	add	x7, x7, #0x4d3 ; string '-[MainFrameAggregationLogic onMainFrameEndReload]'
104a70400: 52800042    	mov	w2, #0x2                ; =2
104a70404: d2800003    	mov	x3, #0x0                ; =0
104a70408: 52800004    	mov	w4, #0x0                ; =0
104a7040c: 52802026    	mov	w6, #0x101              ; =257
104a70410: 94c6db4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70414: 900db488    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a70418: f946f114    	ldr	x20, [x8, #0xde0] ; selector delegate
104a7041c: aa1303e0    	mov	x0, x19
104a70420: aa1403e1    	mov	x1, x20
104a70424: 94c6db46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70428: aa1d03fd    	mov	x29, x29
104a7042c: 94c6db47    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a70430: b4000460    	cbz	x0, 0x104a704bc <_Flutter_MMFoundation_BindContext+0xf4c0a0>
104a70434: aa0003f6    	mov	x22, x0
104a70438: aa1303e0    	mov	x0, x19
104a7043c: aa1403e1    	mov	x1, x20
104a70440: 94c6db3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70444: aa1d03fd    	mov	x29, x29
104a70448: 94c6db40    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7044c: aa0003f7    	mov	x23, x0
104a70450: 900da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a70454: f9409115    	ldr	x21, [x8, #0x120] ; selector onSessionListChange
104a70458: d00db4a8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104a7045c: f9436101    	ldr	x1, [x8, #0x6c0] ; selector respondsToSelector:
104a70460: aa1503e2    	mov	x2, x21
104a70464: 94c6db36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70468: aa0003f8    	mov	x24, x0
104a7046c: aa1703e0    	mov	x0, x23
104a70470: 94c6db39    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a70474: aa1603e0    	mov	x0, x22
104a70478: 94c6db37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7047c: 34000218    	cbz	w24, 0x104a704bc <_Flutter_MMFoundation_BindContext+0xf4c0a0>
104a70480: aa1303e0    	mov	x0, x19
104a70484: aa1403e1    	mov	x1, x20
104a70488: 94c6db2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7048c: aa1d03fd    	mov	x29, x29
104a70490: 94c6db2e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a70494: aa0003f3    	mov	x19, x0
104a70498: aa1503e1    	mov	x1, x21
104a7049c: 94c6db28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a704a0: aa1303e0    	mov	x0, x19
104a704a4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104a704a8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104a704ac: a94257f6    	ldp	x22, x21, [sp, #0x20]
104a704b0: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104a704b4: 910143ff    	add	sp, sp, #0x50
104a704b8: 14c6db27    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a704bc: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104a704c0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104a704c4: a94257f6    	ldp	x22, x21, [sp, #0x20]
104a704c8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104a704cc: 910143ff    	add	sp, sp, #0x50
104a704d0: d65f03c0    	ret
