
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1092bf844: 900b7d48    	adrp	x8, 0x120267000 <dyld_stub_binder+0x120267000>
1092bf848: b9811d08    	ldrsw	x8, [x8, #0x11c]
1092bf84c: f8686800    	ldr	x0, [x0, x8]
1092bf850: b00b5fc8    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
1092bf854: f9422501    	ldr	x1, [x8, #0x448] ; getUnReadMessageCountReleatedToMe
1092bf858: 15966efb    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
