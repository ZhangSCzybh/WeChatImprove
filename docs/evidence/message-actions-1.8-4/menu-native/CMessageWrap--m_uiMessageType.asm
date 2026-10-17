
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104bb4040: 900db388    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104bb4044: b982a108    	ldrsw	x8, [x8, #0x2a0]
104bb4048: b8686800    	ldr	w0, [x0, x8]
104bb404c: d65f03c0    	ret