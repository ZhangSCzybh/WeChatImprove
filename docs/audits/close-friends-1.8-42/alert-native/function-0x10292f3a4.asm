
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
10292f3a4: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10292f3a8: a9017bfd    	stp	x29, x30, [sp, #0x10]
10292f3ac: 910043fd    	add	x29, sp, #0x10
10292f3b0: aa0003f4    	mov	x20, x0
10292f3b4: 91008000    	add	x0, x0, #0x20
10292f3b8: 954bdf75    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10292f3bc: aa0003f3    	mov	x19, x0
10292f3c0: b4000140    	cbz	x0, 0x10292f3e8 <_Flutter_Image_provideRelativePathByUrl+0xd3c298>
10292f3c4: b9403282    	ldr	w2, [x20, #0x30]
10292f3c8: 7100285f    	cmp	w2, #0xa
10292f3cc: 540000e0    	b.eq	0x10292f3e8 <_Flutter_Image_provideRelativePathByUrl+0xd3c298>
10292f3d0: 900ec268    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
10292f3d4: f9413500    	ldr	x0, [x8, #0x268] ; class=MMConfSDKNativeEngine
10292f3d8: f9401683    	ldr	x3, [x20, #0x28]
10292f3dc: f00eae28    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
10292f3e0: f9431d01    	ldr	x1, [x8, #0x638] ; selector=hangup:roomID:
10292f3e4: 954bdf56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10292f3e8: aa1303e0    	mov	x0, x19
10292f3ec: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10292f3f0: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10292f3f4: 154bdf58    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
