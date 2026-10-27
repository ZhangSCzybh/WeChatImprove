
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a6d778: 6dbb2beb    	stp	d11, d10, [sp, #-0x50]!
104a6d77c: 6d0123e9    	stp	d9, d8, [sp, #0x10]
104a6d780: a90257f6    	stp	x22, x21, [sp, #0x20]
104a6d784: a9034ff4    	stp	x20, x19, [sp, #0x30]
104a6d788: a9047bfd    	stp	x29, x30, [sp, #0x40]
104a6d78c: 910103fd    	add	x29, sp, #0x40
104a6d790: 1e604068    	fmov	d8, d3
104a6d794: 1e604049    	fmov	d9, d2
104a6d798: 1e60402a    	fmov	d10, d1
104a6d79c: 1e60400b    	fmov	d11, d0
104a6d7a0: aa0203f3    	mov	x19, x2
104a6d7a4: aa0003f4    	mov	x20, x0
104a6d7a8: f00da088    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
104a6d7ac: f943f115    	ldr	x21, [x8, #0x7e0] ; updateContentView:tableViewFrame:
104a6d7b0: aa0203e0    	mov	x0, x2
104a6d7b4: 94c6e661    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a6d7b8: aa1403e0    	mov	x0, x20
104a6d7bc: aa1503e1    	mov	x1, x21
104a6d7c0: aa1303e2    	mov	x2, x19
104a6d7c4: 1e604160    	fmov	d0, d11
104a6d7c8: 1e604141    	fmov	d1, d10
104a6d7cc: 1e604122    	fmov	d2, d9
104a6d7d0: 1e604103    	fmov	d3, d8
104a6d7d4: 94c6e65a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6d7d8: b00d9ec8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104a6d7dc: f9438d01    	ldr	x1, [x8, #0x718] ; m_sessionInfo
104a6d7e0: aa1303e0    	mov	x0, x19
104a6d7e4: 94c6e656    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6d7e8: aa1d03fd    	mov	x29, x29
104a6d7ec: 94c6e657    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6d7f0: aa0003f5    	mov	x21, x0
104a6d7f4: aa1303e0    	mov	x0, x19
104a6d7f8: 94c6e657    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6d7fc: f00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6d800: f9403901    	ldr	x1, [x8, #0x70] ; updateCellBackground:
104a6d804: aa1403e0    	mov	x0, x20
104a6d808: aa1503e2    	mov	x2, x21
104a6d80c: 94c6e64c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6d810: aa1503e0    	mov	x0, x21
104a6d814: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104a6d818: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104a6d81c: a94257f6    	ldp	x22, x21, [sp, #0x20]
104a6d820: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
104a6d824: 6cc52beb    	ldp	d11, d10, [sp], #0x50
104a6d828: 14c6e64b    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
