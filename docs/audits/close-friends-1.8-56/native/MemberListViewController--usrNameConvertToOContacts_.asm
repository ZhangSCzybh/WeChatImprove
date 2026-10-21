
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104add3c4: b40001a2    	cbz	x2, 0x104add3f8 <_Flutter_MMFoundation_BindContext+0xfb8fdc>
104add3c8: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
104add3cc: 910003fd    	mov	x29, sp
104add3d0: d00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104add3d4: b9869508    	ldrsw	x8, [x8, #0x694]
104add3d8: f8686800    	ldr	x0, [x0, x8]
104add3dc: 900da548    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104add3e0: f9452101    	ldr	x1, [x8, #0xa40] ; filtContactsByName:
104add3e4: 94c52756    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104add3e8: aa1d03fd    	mov	x29, x29
104add3ec: 94c52757    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104add3f0: a8c17bfd    	ldp	x29, x30, [sp], #0x10
104add3f4: 14c5275f    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104add3f8: d2800000    	mov	x0, #0x0                ; =0
104add3fc: 14c5275d    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
