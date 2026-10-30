
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1051809a0: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051809a4: b9894d08    	ldrsw	x8, [x8, #0x94c] ; ivar NewSyncService.m_isGettingData offset=85 type=B
1051809a8: 38686800    	ldrb	w0, [x0, x8]
1051809ac: d65f03c0    	ret
