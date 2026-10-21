
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057d7234: 900d52c8    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057d7238: b9824108    	ldrsw	x8, [x8, #0x240]
1057d723c: 3828681f    	strb	wzr, [x0, x8]
1057d7240: d00d3548    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
1057d7244: f9476d01    	ldr	x1, [x8, #0xed8] ; animateUpdateView
1057d7248: 14913fbd    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
