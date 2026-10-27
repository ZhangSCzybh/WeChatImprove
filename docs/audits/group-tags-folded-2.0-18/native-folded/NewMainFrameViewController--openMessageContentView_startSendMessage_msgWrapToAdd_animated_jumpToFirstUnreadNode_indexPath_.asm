
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10511cddc: d10083ff    	sub	sp, sp, #0x20
10511cde0: a9017bfd    	stp	x29, x30, [sp, #0x10]
10511cde4: 910043fd    	add	x29, sp, #0x10
10511cde8: d00d73e8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10511cdec: f947dd01    	ldr	x1, [x8, #0xfb8] ; openMessageContentView:startSendMessage:msgWrapToAdd:animated:jumpToFirstUnreadNode:indexPath:reuse:extraInfo:
10511cdf0: f90007ff    	str	xzr, [sp, #0x8]
10511cdf4: 52800028    	mov	w8, #0x1                ; =1
10511cdf8: 390003e8    	strb	w8, [sp]
10511cdfc: 94ac28d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ce00: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10511ce04: 910083ff    	add	sp, sp, #0x20
10511ce08: d65f03c0    	ret
