
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ecc8c4: d10083ff    	sub	sp, sp, #0x20
101ecc8c8: a9017bfd    	stp	x29, x30, [sp, #0x10]
101ecc8cc: 910043fd    	add	x29, sp, #0x10
101ecc8d0: b00f1788    	adrp	x8, 0x1201bd000 <dyld_stub_binder+0x1201bd000>
101ecc8d4: f9402508    	ldr	x8, [x8, #0x48] ;  "/
101ecc8d8: a90023e0    	stp	x0, x8, [sp]
101ecc8dc: d00f11a8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
101ecc8e0: f9466901    	ldr	x1, [x8, #0xcd0] ; init
101ecc8e4: 910003e0    	mov	x0, sp
101ecc8e8: 95756a17    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
101ecc8ec: b40000a0    	cbz	x0, 0x101ecc900 <_Flutter_Image_provideRelativePathByUrl+0x2d97b0>
101ecc8f0: f00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecc8f4: b987a908    	ldrsw	x8, [x8, #0x7a8]
101ecc8f8: 52800029    	mov	w9, #0x1                ; =1
101ecc8fc: 38286809    	strb	w9, [x0, x8]
101ecc900: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101ecc904: 910083ff    	add	sp, sp, #0x20
101ecc908: d65f03c0    	ret
