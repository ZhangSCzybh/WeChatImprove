
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10471e9c4: b00dd808    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
10471e9c8: b989d108    	ldrsw	x8, [x8, #0x9d0]
10471e9cc: f8686800    	ldr	x0, [x0, x8]
10471e9d0: d00dcf08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10471e9d4: f9435101    	ldr	x1, [x8, #0x6a0] ; selector count
10471e9d8: 14d421d9    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
