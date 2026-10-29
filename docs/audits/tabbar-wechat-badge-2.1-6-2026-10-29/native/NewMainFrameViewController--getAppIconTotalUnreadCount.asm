
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105124184: 900d8828    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105124188: b9831508    	ldrsw	x8, [x8, #0x314]
10512418c: f8686800    	ldr	x0, [x0, x8]
105124190: f00d73a8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
105124194: f940b901    	ldr	x1, [x8, #0x170] ; selector getTotalUnreadCountForAppIcon
105124198: 14ac0be9    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
