
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ecc958: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101ecc95c: a9017bfd    	stp	x29, x30, [sp, #0x10]
101ecc960: 910043fd    	add	x29, sp, #0x10
101ecc964: aa0003f3    	mov	x19, x0
101ecc968: 900f6b48    	adrp	x8, 0x120c34000 <dyld_stub_binder+0x120c34000>
101ecc96c: 52800029    	mov	w9, #0x1                ; =1
101ecc970: 390e9909    	strb	w9, [x8, #0x3a6]
101ecc974: f00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecc978: b987ad14    	ldrsw	x20, [x8, #0x7ac]
101ecc97c: b8746808    	ldr	w8, [x0, x20]
101ecc980: 7100851f    	cmp	w8, #0x21
101ecc984: 52800029    	mov	w9, #0x1                ; =1
101ecc988: 9ac82128    	lsl	x8, x9, x8
101ecc98c: d2901409    	mov	x9, #0x80a0             ; =32928
101ecc990: f2a12009    	movk	x9, #0x900, lsl #16
101ecc994: f2c00069    	movk	x9, #0x3, lsl #32
101ecc998: 8a090108    	and	x8, x8, x9
101ecc99c: fa409904    	ccmp	x8, #0x0, #0x4, ls
101ecc9a0: 54000360    	b.eq	0x101ecca0c <_Flutter_Image_provideRelativePathByUrl+0x2d98bc>
101ecc9a4: f00f1548    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
101ecc9a8: f9446900    	ldr	x0, [x8, #0x8d0]
101ecc9ac: 957569ed    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
101ecc9b0: b8746a62    	ldr	w2, [x19, x20]
101ecc9b4: b00efda8    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
101ecc9b8: f9459901    	ldr	x1, [x8, #0xb30] ; initWithScene:delegate:sort:
101ecc9bc: aa1303e3    	mov	x3, x19
101ecc9c0: 52800004    	mov	w4, #0x0                ; =0
101ecc9c4: 957569de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecc9c8: f00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecc9cc: b987b109    	ldrsw	x9, [x8, #0x7b0]
101ecc9d0: f8696a68    	ldr	x8, [x19, x9]
101ecc9d4: f8296a60    	str	x0, [x19, x9]
101ecc9d8: aa0803e0    	mov	x0, x8
101ecc9dc: 957569de    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecc9e0: f00f1528    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101ecc9e4: f9454100    	ldr	x0, [x8, #0xa80]
101ecc9e8: 957569dc    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
101ecc9ec: f00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecc9f0: b987b509    	ldrsw	x9, [x8, #0x7b4]
101ecc9f4: f8696a68    	ldr	x8, [x19, x9]
101ecc9f8: f8296a60    	str	x0, [x19, x9]
101ecc9fc: aa0803e0    	mov	x0, x8
101ecca00: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101ecca04: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101ecca08: 157569d3    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecca0c: f00f1548    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
101ecca10: f9446900    	ldr	x0, [x8, #0x8d0]
101ecca14: 957569d3    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
101ecca18: b8746a62    	ldr	w2, [x19, x20]
101ecca1c: d00efc48    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
101ecca20: f942d501    	ldr	x1, [x8, #0x5a8] ; initWithScene:delegate:
101ecca24: aa1303e3    	mov	x3, x19
101ecca28: 957569c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecca2c: 17ffffe7    	b	0x101ecc9c8 <_Flutter_Image_provideRelativePathByUrl+0x2d9878>
