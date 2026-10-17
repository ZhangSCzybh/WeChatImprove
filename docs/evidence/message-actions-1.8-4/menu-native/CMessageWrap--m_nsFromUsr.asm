
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104bb400c: 900db388    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104bb4010: b9825d08    	ldrsw	x8, [x8, #0x25c]
104bb4014: f8686800    	ldr	x0, [x0, x8]
104bb4018: d65f03c0    	ret