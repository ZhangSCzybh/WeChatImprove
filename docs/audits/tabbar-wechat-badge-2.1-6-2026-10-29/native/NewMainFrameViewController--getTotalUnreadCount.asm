
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10512416c: 900d8828    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105124170: b9831508    	ldrsw	x8, [x8, #0x314]
105124174: f8686800    	ldr	x0, [x0, x8]
105124178: 900d6908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10512417c: f945dd01    	ldr	x1, [x8, #0xbb8] ; selector getTotalUnreadCount
105124180: 14ac0bef    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
