
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adcc30: f00db4a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104adcc34: f9461900    	ldr	x0, [x8, #0xc30]
104adcc38: b00d9ae8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104adcc3c: f9463101    	ldr	x1, [x8, #0xc60] ; dynamicLength:
104adcc40: d2e80a08    	mov	x8, #0x4050000000000000 ; =4634204016564240384
104adcc44: 9e670100    	fmov	d0, x8
104adcc48: 14c5293d    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
