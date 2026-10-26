
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
10299fe78: f9400c40    	ldr	x0, [x2, #0x18]
10299fe7c: d1000408    	sub	x8, x0, #0x1
10299fe80: f100251f    	cmp	x8, #0x9
10299fe84: 540004a3    	b.lo	0x10299ff18 <_Flutter_Image_provideRelativePathByUrl+0xdacdc8>
10299fe88: d100c3ff    	sub	sp, sp, #0x30
10299fe8c: a9014ff4    	stp	x20, x19, [sp, #0x10]
10299fe90: a9027bfd    	stp	x29, x30, [sp, #0x20]
10299fe94: 910083fd    	add	x29, sp, #0x20
10299fe98: 900ebea8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10299fe9c: f9453513    	ldr	x19, [x8, #0xa68]
10299fea0: b00ebee8    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
10299fea4: f943c500    	ldr	x0, [x8, #0x788]
10299fea8: b00eaac8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
10299feac: f941bd01    	ldr	x1, [x8, #0x378] ; ruleDescription:
10299feb0: 954a1ca3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299feb4: aa1d03fd    	mov	x29, x29
10299feb8: 954a1ca4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10299febc: aa0003f4    	mov	x20, x0
10299fec0: d00ea4c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10299fec4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10299fec8: d00de668    	adrp	x8, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
10299fecc: 912ea108    	add	x8, x8, #0xba8
10299fed0: a90003e8    	stp	x8, x0, [sp]
10299fed4: b00c5ee3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
10299fed8: 9125d063    	add	x3, x3, #0x974
10299fedc: b00c5ee5    	adrp	x5, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
10299fee0: 91200ca5    	add	x5, x5, #0x803
10299fee4: b00c5ee7    	adrp	x7, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
10299fee8: 912d28e7    	add	x7, x7, #0xb4a
10299feec: aa1303e0    	mov	x0, x19
10299fef0: 52800082    	mov	w2, #0x4                ; =4
10299fef4: 52800004    	mov	w4, #0x0                ; =0
10299fef8: 52804146    	mov	w6, #0x20a              ; =522
10299fefc: 954a1c90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299ff00: aa1403e0    	mov	x0, x20
10299ff04: 954a1c94    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10299ff08: 52800020    	mov	w0, #0x1                ; =1
10299ff0c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10299ff10: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10299ff14: 9100c3ff    	add	sp, sp, #0x30
10299ff18: d65f03c0    	ret
