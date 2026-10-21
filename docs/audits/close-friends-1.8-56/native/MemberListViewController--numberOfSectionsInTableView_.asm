
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adc438: f00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adc43c: b9869508    	ldrsw	x8, [x8, #0x694]
104adc440: f8686800    	ldr	x0, [x0, x8]
104adc444: b00d9c68    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104adc448: f9406101    	ldr	x1, [x8, #0xc0] ; getSectionCount
104adc44c: 14c52b3c    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
