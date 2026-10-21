
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
107140bb8: f00c8828    	adrp	x8, 0x120247000 <dyld_stub_binder+0x120247000>
107140bbc: b9893108    	ldrsw	x8, [x8, #0x930]
107140bc0: f8686800    	ldr	x0, [x0, x8]
107140bc4: 900c6b68    	adrp	x8, 0x11feac000 <dyld_stub_binder+0x11feac000>
107140bc8: f941f901    	ldr	x1, [x8, #0x3f0] ; getUnReadMessageCount
107140bcc: 142b995c    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
