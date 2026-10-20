
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106ee738c: d00c9ae8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ee7390: b9897908    	ldrsw	x8, [x8, #0x978]
106ee7394: f8686800    	ldr	x0, [x0, x8]
106ee7398: b00c90c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106ee739c: f9435101    	ldr	x1, [x8, #0x6a0] ; count
106ee73a0: 1434ff67    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
