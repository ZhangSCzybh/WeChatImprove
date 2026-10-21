
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1092bf85c: 900b7d48    	adrp	x8, 0x120267000 <dyld_stub_binder+0x120267000>
1092bf860: b9811d08    	ldrsw	x8, [x8, #0x11c]
1092bf864: f8686800    	ldr	x0, [x0, x8]
1092bf868: f00b6a28    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
1092bf86c: f942ad01    	ldr	x1, [x8, #0x558] ; getUnReadMessageCountForMutualFriends
1092bf870: 15966ef5    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
