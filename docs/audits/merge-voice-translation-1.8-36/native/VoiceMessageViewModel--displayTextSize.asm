
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10628e8a0: d10143ff    	sub	sp, sp, #0x50
10628e8a4: 6d0123e9    	stp	d9, d8, [sp, #0x10]
10628e8a8: a90257f6    	stp	x22, x21, [sp, #0x20]
10628e8ac: a9034ff4    	stp	x20, x19, [sp, #0x30]
10628e8b0: a9047bfd    	stp	x29, x30, [sp, #0x40]
10628e8b4: 910103fd    	add	x29, sp, #0x40
10628e8b8: aa0003f3    	mov	x19, x0
10628e8bc: b00d4da8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10628e8c0: 52800029    	mov	w9, #0x1                ; =1
10628e8c4: 3928f909    	strb	w9, [x8, #0xa3e]
10628e8c8: f00cdfe8    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
10628e8cc: f944a101    	ldr	x1, [x8, #0x940] ; voiceTranslateInfo
10628e8d0: 9466621b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e8d4: aa1d03fd    	mov	x29, x29
10628e8d8: 9466621c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e8dc: aa0003f5    	mov	x21, x0
10628e8e0: b00cde48    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
10628e8e4: f940e101    	ldr	x1, [x8, #0x1c0] ; displayText
10628e8e8: 94666215    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e8ec: aa1d03fd    	mov	x29, x29
10628e8f0: 94666216    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e8f4: aa0003f4    	mov	x20, x0
10628e8f8: aa1503e0    	mov	x0, x21
10628e8fc: 94666216    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e900: b00cf3a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10628e904: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10628e908: aa1403e0    	mov	x0, x20
10628e90c: 9466620c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e910: b4000560    	cbz	x0, 0x10628e9bc <_Flutter_MMFoundation_BindContext+0x276a5a0>
10628e914: b00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628e918: f9454500    	ldr	x0, [x8, #0xa88]
10628e91c: 900cf3e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10628e920: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
10628e924: f90003f4    	str	x20, [sp]
10628e928: 900c2f62    	adrp	x2, 0x11e87a000 <dyld_stub_binder+0x11e87a000>
10628e92c: 913e2042    	add	x2, x2, #0xf88
10628e930: 94666203    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e934: aa1d03fd    	mov	x29, x29
10628e938: 94666204    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e93c: aa0003f5    	mov	x21, x0
10628e940: aa1403e0    	mov	x0, x20
10628e944: 94666204    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e948: b00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628e94c: f947f914    	ldr	x20, [x8, #0xff0] ; richTextViewForCalcu
10628e950: aa1303e0    	mov	x0, x19
10628e954: aa1403e1    	mov	x1, x20
10628e958: 946661f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e95c: aa1d03fd    	mov	x29, x29
10628e960: 946661fa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e964: aa0003f6    	mov	x22, x0
10628e968: d00cdd88    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10628e96c: f9417101    	ldr	x1, [x8, #0x2e0] ; setContent:
10628e970: aa1503e2    	mov	x2, x21
10628e974: 946661f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e978: aa1603e0    	mov	x0, x22
10628e97c: 946661f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e980: aa1303e0    	mov	x0, x19
10628e984: aa1403e1    	mov	x1, x20
10628e988: 946661ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e98c: aa1d03fd    	mov	x29, x29
10628e990: 946661ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e994: aa0003f3    	mov	x19, x0
10628e998: 900cf3e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10628e99c: f9442501    	ldr	x1, [x8, #0x848] ; size
10628e9a0: 946661e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e9a4: 1e604008    	fmov	d8, d0
10628e9a8: 1e604029    	fmov	d9, d1
10628e9ac: aa1303e0    	mov	x0, x19
10628e9b0: 946661e9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e9b4: aa1503f4    	mov	x20, x21
10628e9b8: 14000003    	b	0x10628e9c4 <_Flutter_MMFoundation_BindContext+0x276a5a8>
10628e9bc: 9e6703e8    	fmov	d8, xzr
10628e9c0: 9e6703e9    	fmov	d9, xzr
10628e9c4: aa1403e0    	mov	x0, x20
10628e9c8: 946661e3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e9cc: 1e604100    	fmov	d0, d8
10628e9d0: 1e604121    	fmov	d1, d9
10628e9d4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10628e9d8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10628e9dc: a94257f6    	ldp	x22, x21, [sp, #0x20]
10628e9e0: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
10628e9e4: 910143ff    	add	sp, sp, #0x50
10628e9e8: d65f03c0    	ret