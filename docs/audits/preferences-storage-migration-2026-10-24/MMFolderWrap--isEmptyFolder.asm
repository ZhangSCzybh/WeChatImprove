
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029ad8e0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1029ad8e4: a9014ff4    	stp	x20, x19, [sp, #0x10]
1029ad8e8: a9027bfd    	stp	x29, x30, [sp, #0x20]
1029ad8ec: 910083fd    	add	x29, sp, #0x20
1029ad8f0: aa0003f4    	mov	x20, x0
1029ad8f4: f00eaa48    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029ad8f8: f942f901    	ldr	x1, [x8, #0x5f0] ; bStatOK
1029ad8fc: 9549e610    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ad900: 340001e0    	cbz	w0, 0x1029ad93c <_Flutter_Image_provideRelativePathByUrl+0xdba7ec>
1029ad904: f00eaa48    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029ad908: f942f501    	ldr	x1, [x8, #0x5e8] ; m_arrChildFolder
1029ad90c: aa1403e0    	mov	x0, x20
1029ad910: 9549e60b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ad914: aa1d03fd    	mov	x29, x29
1029ad918: 9549e60c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029ad91c: aa0003f3    	mov	x19, x0
1029ad920: f00eba88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029ad924: f9435115    	ldr	x21, [x8, #0x6a0] ; count
1029ad928: aa1503e1    	mov	x1, x21
1029ad92c: 9549e604    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ad930: b40000a0    	cbz	x0, 0x1029ad944 <_Flutter_Image_provideRelativePathByUrl+0xdba7f4>
1029ad934: 52800014    	mov	w20, #0x0               ; =0
1029ad938: 14000010    	b	0x1029ad978 <_Flutter_Image_provideRelativePathByUrl+0xdba828>
1029ad93c: 52800014    	mov	w20, #0x0               ; =0
1029ad940: 14000010    	b	0x1029ad980 <_Flutter_Image_provideRelativePathByUrl+0xdba830>
1029ad944: f00eaa48    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029ad948: f942fd01    	ldr	x1, [x8, #0x5f8] ; m_arrNotScanFileName
1029ad94c: aa1403e0    	mov	x0, x20
1029ad950: 9549e5fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ad954: aa1d03fd    	mov	x29, x29
1029ad958: 9549e5fc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029ad95c: aa0003f6    	mov	x22, x0
1029ad960: aa1503e1    	mov	x1, x21
1029ad964: 9549e5f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ad968: f100001f    	cmp	x0, #0x0
1029ad96c: 1a9f17f4    	cset	w20, eq
1029ad970: aa1603e0    	mov	x0, x22
1029ad974: 9549e5f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ad978: aa1303e0    	mov	x0, x19
1029ad97c: 9549e5f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ad980: aa1403e0    	mov	x0, x20
1029ad984: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1029ad988: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1029ad98c: a8c357f6    	ldp	x22, x21, [sp], #0x30
1029ad990: d65f03c0    	ret
