
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017fb478: d00f4fa8    	adrp	x8, 0x1201f1000 <dyld_stub_binder+0x1201f1000>
1017fb47c: b9877108    	ldrsw	x8, [x8, #0x770] ; ivar FTSTopHitsSectionController._topHitItems
1017fb480: f8686800    	ldr	x0, [x0, x8]
1017fb484: b00f4828    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1017fb488: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1017fb48c: 1590af2c    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
