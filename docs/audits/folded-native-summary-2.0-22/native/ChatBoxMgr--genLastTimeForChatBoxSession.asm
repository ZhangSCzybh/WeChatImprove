
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4935c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100e49360: a9014ff4    	stp	x20, x19, [sp, #0x10]
100e49364: a9027bfd    	stp	x29, x30, [sp, #0x20]
100e49368: 910083fd    	add	x29, sp, #0x20
100e4936c: aa0003f3    	mov	x19, x0
100e49370: f00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e49374: f9433914    	ldr	x20, [x8, #0x670] ; chatBoxSessions
100e49378: aa1403e1    	mov	x1, x20
100e4937c: 95b77770    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49380: aa1d03fd    	mov	x29, x29
100e49384: 95b77771    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49388: aa0003f5    	mov	x21, x0
100e4938c: f00f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e49390: f9435101    	ldr	x1, [x8, #0x6a0] ; count
100e49394: 95b7776a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49398: aa0003f6    	mov	x22, x0
100e4939c: aa1503e0    	mov	x0, x21
100e493a0: 95b7776d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e493a4: b4000356    	cbz	x22, 0x100e4940c <__text+0xe4140c>
100e493a8: aa1303e0    	mov	x0, x19
100e493ac: aa1403e1    	mov	x1, x20
100e493b0: 95b77763    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e493b4: aa1d03fd    	mov	x29, x29
100e493b8: 95b77764    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e493bc: aa0003f3    	mov	x19, x0
100e493c0: 900f95c8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
100e493c4: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
100e493c8: 95b7775d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e493cc: aa1d03fd    	mov	x29, x29
100e493d0: 95b7775e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e493d4: aa0003f4    	mov	x20, x0
100e493d8: 900f7fa8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100e493dc: f9413501    	ldr	x1, [x8, #0x268] ; m_uLastTime
100e493e0: 95b77757    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e493e4: aa0003f5    	mov	x21, x0
100e493e8: aa1403e0    	mov	x0, x20
100e493ec: 95b7775a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e493f0: aa1303e0    	mov	x0, x19
100e493f4: 95b77758    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e493f8: aa1503e0    	mov	x0, x21
100e493fc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100e49400: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100e49404: a8c357f6    	ldp	x22, x21, [sp], #0x30
100e49408: d65f03c0    	ret
100e4940c: d00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e49410: f9467900    	ldr	x0, [x8, #0xcf0] ; CUtility
100e49414: f00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e49418: f9403501    	ldr	x1, [x8, #0x68] ; genServerCurrentTime
100e4941c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100e49420: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100e49424: a8c357f6    	ldp	x22, x21, [sp], #0x30
100e49428: 15b77745    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
