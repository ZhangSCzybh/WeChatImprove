
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
107140bd0: f00c8828    	adrp	x8, 0x120247000 <dyld_stub_binder+0x120247000>
107140bd4: b9893108    	ldrsw	x8, [x8, #0x930]
107140bd8: f8686800    	ldr	x0, [x0, x8]
107140bdc: d00c7628    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
107140be0: f942ad01    	ldr	x1, [x8, #0x558] ; getUnReadMessageCountForMutualFriends
107140be4: 142b9956    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
