
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c2d230: f00f2e28    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c2d234: b988f908    	ldrsw	x8, [x8, #0x8f8]
101c2d238: f8686800    	ldr	x0, [x0, x8]
101c2d23c: 157fe7c4    	b	0x107c2714c <_Flutter_MMFoundation_BindContext+0x4102d30>