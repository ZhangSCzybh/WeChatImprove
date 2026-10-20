
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1071357c0: d00c8888    	adrp	x8, 0x120247000 <dyld_stub_binder+0x120247000>
1071357c4: b989f508    	ldrsw	x8, [x8, #0x9f4]
1071357c8: f8686800    	ldr	x0, [x0, x8]
1071357cc: f00c7e48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1071357d0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1071357d4: 142bc65a    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
