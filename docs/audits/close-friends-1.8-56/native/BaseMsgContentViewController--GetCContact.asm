
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100335768: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10033576c: a9017bfd    	stp	x29, x30, [sp, #0x10]
100335770: 910043fd    	add	x29, sp, #0x10
100335774: f00fd868    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
100335778: f944fd01    	ldr	x1, [x8, #0x9f8] ; GetContact
10033577c: 95e3c670    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100335780: aa1d03fd    	mov	x29, x29
100335784: 95e3c671    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100335788: aa0003f3    	mov	x19, x0
10033578c: d00ff1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100335790: f9478100    	ldr	x0, [x8, #0xf00] ;  /,
100335794: d00fee48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100335798: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10033579c: 95e3c668    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1003357a0: aa0003e2    	mov	x2, x0
1003357a4: d00fee68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1003357a8: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
1003357ac: aa1303e0    	mov	x0, x19
1003357b0: 95e3c663    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1003357b4: 340000a0    	cbz	w0, 0x1003357c8 <__text+0x32d7c8>
1003357b8: aa1303e0    	mov	x0, x19
1003357bc: 95e3c65f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1003357c0: aa1303f4    	mov	x20, x19
1003357c4: 14000002    	b	0x1003357cc <__text+0x32d7cc>
1003357c8: d2800014    	mov	x20, #0x0               ; =0
1003357cc: aa1303e0    	mov	x0, x19
1003357d0: 95e3c661    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1003357d4: aa1403e0    	mov	x0, x20
1003357d8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1003357dc: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1003357e0: 15e3c664    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
