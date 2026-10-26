
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029ad254: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1029ad258: a9017bfd    	stp	x29, x30, [sp, #0x10]
1029ad25c: 910043fd    	add	x29, sp, #0x10
1029ad260: aa0003f3    	mov	x19, x0
1029ad264: 900ea708    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029ad268: f947a901    	ldr	x1, [x8, #0xf50] ; m_onlyBizType
1029ad26c: 9549e7b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ad270: f1000c1f    	cmp	x0, #0x3
1029ad274: 5400020b    	b.lt	0x1029ad2b4 <_Flutter_Image_provideRelativePathByUrl+0xdba164>
1029ad278: 900ea708    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029ad27c: f947ad01    	ldr	x1, [x8, #0xf58] ; m_onlyFileTypeInUse
1029ad280: aa1303e0    	mov	x0, x19
1029ad284: 9549e7ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ad288: 321f77e8    	mov	w8, #0x7ffffffe         ; =2147483646
1029ad28c: 6b08001f    	cmp	w0, w8
1029ad290: 54000120    	b.eq	0x1029ad2b4 <_Flutter_Image_provideRelativePathByUrl+0xdba164>
1029ad294: 900ea708    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029ad298: f947b101    	ldr	x1, [x8, #0xf60] ; m_onlyWeChatFileClass
1029ad29c: aa1303e0    	mov	x0, x19
1029ad2a0: 9549e7a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ad2a4: 7100001f    	cmp	w0, #0x0
1029ad2a8: 5400006d    	b.le	0x1029ad2b4 <_Flutter_Image_provideRelativePathByUrl+0xdba164>
1029ad2ac: 52800020    	mov	w0, #0x1                ; =1
1029ad2b0: 14000002    	b	0x1029ad2b8 <_Flutter_Image_provideRelativePathByUrl+0xdba168>
1029ad2b4: 52800000    	mov	w0, #0x0                ; =0
1029ad2b8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1029ad2bc: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1029ad2c0: d65f03c0    	ret
