
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
10292f134: 900ec268    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
10292f138: f9413508    	ldr	x8, [x8, #0x268] ; class=MMConfSDKNativeEngine
10292f13c: b9402002    	ldr	w2, [x0, #0x20]
10292f140: 39409003    	ldrb	w3, [x0, #0x24]
10292f144: f00eae29    	adrp	x9, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
10292f148: f941c121    	ldr	x1, [x9, #0x380] ; selector=hangup:isSubCall:
10292f14c: aa0803e0    	mov	x0, x8
10292f150: 154bdffb    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
