
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104add2a4: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104add2a8: a9017bfd    	stp	x29, x30, [sp, #0x10]
104add2ac: 910043fd    	add	x29, sp, #0x10
104add2b0: d00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104add2b4: b9869108    	ldrsw	x8, [x8, #0x690]
104add2b8: f8686800    	ldr	x0, [x0, x8]
104add2bc: 900d9be8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
104add2c0: f942e101    	ldr	x1, [x8, #0x5c0] ; arrResult
104add2c4: 94c5279e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104add2c8: aa1d03fd    	mov	x29, x29
104add2cc: 94c5279f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104add2d0: aa0003f3    	mov	x19, x0
104add2d4: f00db108    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104add2d8: f9435101    	ldr	x1, [x8, #0x6a0] ; count
104add2dc: 94c52798    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104add2e0: f100001f    	cmp	x0, #0x0
104add2e4: 1a9f17f4    	cset	w20, eq
104add2e8: aa1303e0    	mov	x0, x19
104add2ec: 94c5279a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104add2f0: aa1403e0    	mov	x0, x20
104add2f4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104add2f8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104add2fc: d65f03c0    	ret
