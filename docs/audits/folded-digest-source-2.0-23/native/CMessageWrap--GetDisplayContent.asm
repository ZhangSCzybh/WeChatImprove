
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ba5310: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104ba5314: a9014ff4    	stp	x20, x19, [sp, #0x10]
104ba5318: a9027bfd    	stp	x29, x30, [sp, #0x20]
104ba531c: 910083fd    	add	x29, sp, #0x20
104ba5320: aa0003f3    	mov	x19, x0
104ba5324: b00e04c8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104ba5328: 52800029    	mov	w9, #0x1                ; =1
104ba532c: 391a8d09    	strb	w9, [x8, #0x6a3]
104ba5330: f00db3e8    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104ba5334: b982a915    	ldrsw	x21, [x8, #0x2a8]
104ba5338: f8756800    	ldr	x0, [x0, x21]
104ba533c: b00d9888    	adrp	x8, 0x11feb6000 <dyld_stub_binder+0x11feb6000>
104ba5340: f9404d14    	ldr	x20, [x8, #0x98] ; GetDisplayContent
104ba5344: b00dab08    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104ba5348: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
104ba534c: aa1403e2    	mov	x2, x20
104ba5350: 94c2077b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba5354: 34000100    	cbz	w0, 0x104ba5374 <_Flutter_MMFoundation_BindContext+0x1080f58>
104ba5358: f8756a60    	ldr	x0, [x19, x21]
104ba535c: aa1403e1    	mov	x1, x20
104ba5360: 94c20777    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba5364: aa1d03fd    	mov	x29, x29
104ba5368: 94c20778    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba536c: aa0003f4    	mov	x20, x0
104ba5370: 14000002    	b	0x104ba5378 <_Flutter_MMFoundation_BindContext+0x1080f5c>
104ba5374: d2800014    	mov	x20, #0x0               ; =0
104ba5378: d00daae8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104ba537c: f946e901    	ldr	x1, [x8, #0xdd0] ; length
104ba5380: aa1403e0    	mov	x0, x20
104ba5384: 94c2076e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba5388: b5000120    	cbnz	x0, 0x104ba53ac <_Flutter_MMFoundation_BindContext+0x1080f90>
104ba538c: f00db3e8    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104ba5390: b9826508    	ldrsw	x8, [x8, #0x264]
104ba5394: f8686a75    	ldr	x21, [x19, x8]
104ba5398: aa1503e0    	mov	x0, x21
104ba539c: 94c20767    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104ba53a0: aa1403e0    	mov	x0, x20
104ba53a4: 94c2076c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba53a8: aa1503f4    	mov	x20, x21
104ba53ac: d00d94e8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104ba53b0: f941b101    	ldr	x1, [x8, #0x360] ; shouldShowAsSystemMessage
104ba53b4: aa1303e0    	mov	x0, x19
104ba53b8: 94c20761    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba53bc: 34000160    	cbz	w0, 0x104ba53e8 <_Flutter_MMFoundation_BindContext+0x1080fcc>
104ba53c0: d00d9f08    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104ba53c4: f946bd01    	ldr	x1, [x8, #0xd78] ; getContentForShowAsSystemMessage
104ba53c8: aa1303e0    	mov	x0, x19
104ba53cc: 94c2075c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba53d0: aa1d03fd    	mov	x29, x29
104ba53d4: 94c2075d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba53d8: aa0003f3    	mov	x19, x0
104ba53dc: aa1403e0    	mov	x0, x20
104ba53e0: 94c2075d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba53e4: aa1303f4    	mov	x20, x19
104ba53e8: aa1403e0    	mov	x0, x20
104ba53ec: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104ba53f0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104ba53f4: a8c357f6    	ldp	x22, x21, [sp], #0x30
104ba53f8: 14c2075e    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
