
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
107140be8: f00c8828    	adrp	x8, 0x120247000 <dyld_stub_binder+0x120247000>
107140bec: b9893108    	ldrsw	x8, [x8, #0x930]
107140bf0: f8686800    	ldr	x0, [x0, x8]
107140bf4: 900c6bc8    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
107140bf8: f9422501    	ldr	x1, [x8, #0x448] ; getUnReadMessageCountReleatedToMe
107140bfc: 142b9950    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
