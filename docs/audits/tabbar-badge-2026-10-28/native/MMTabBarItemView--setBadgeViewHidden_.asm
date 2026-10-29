
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104727298: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
10472729c: b98a1108    	ldrsw	x8, [x8, #0xa10]
1047272a0: f8686800    	ldr	x0, [x0, x8]
1047272a4: b00dcf08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1047272a8: f9411101    	ldr	x1, [x8, #0x220] ; selector setHidden:
1047272ac: 14d3ffa4    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
