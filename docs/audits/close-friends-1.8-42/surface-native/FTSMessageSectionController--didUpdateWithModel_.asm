
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101795410: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101795414: a90157f6    	stp	x22, x21, [sp, #0x10]
101795418: a9024ff4    	stp	x20, x19, [sp, #0x20]
10179541c: a9037bfd    	stp	x29, x30, [sp, #0x30]
101795420: 9100c3fd    	add	x29, sp, #0x30
101795424: aa0003f3    	mov	x19, x0
101795428: b00fa4e8    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
10179542c: 52800029    	mov	w9, #0x1                ; =1
101795430: 39259109    	strb	w9, [x8, #0x964]
101795434: b00f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101795438: f9406d01    	ldr	x1, [x8, #0xd8] ; isTalkerEntryEnabled
10179543c: 95924740    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795440: 36000820    	tbz	w0, #0x0, 0x101795544 <__text+0x178d544>
101795444: d00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101795448: f945e900    	ldr	x0, [x8, #0xbd0]
10179544c: f00f4b48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101795450: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101795454: 9592473a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795458: aa1d03fd    	mov	x29, x29
10179545c: 9592473b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795460: aa0003f4    	mov	x20, x0
101795464: d00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101795468: f9477100    	ldr	x0, [x8, #0xee0]
10179546c: d00f4b48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101795470: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101795474: 95924732    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795478: aa0003e2    	mov	x2, x0
10179547c: 900f3528    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101795480: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101795484: aa1403e0    	mov	x0, x20
101795488: 9592472d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10179548c: aa1d03fd    	mov	x29, x29
101795490: 9592472e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795494: aa0003f5    	mov	x21, x0
101795498: 900f35c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
10179549c: f9472d01    	ldr	x1, [x8, #0xe58] ; ftsMessageMgr
1017954a0: 95924727    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017954a4: aa1d03fd    	mov	x29, x29
1017954a8: 95924728    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017954ac: aa0003f6    	mov	x22, x0
1017954b0: b00f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017954b4: f9431901    	ldr	x1, [x8, #0x630] ; curSearchText
1017954b8: aa1303e0    	mov	x0, x19
1017954bc: 95924720    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017954c0: aa1d03fd    	mov	x29, x29
1017954c4: 95924721    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017954c8: aa0003f7    	mov	x23, x0
1017954cc: b00f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017954d0: f943a101    	ldr	x1, [x8, #0x740] ; ftsTaskKey
1017954d4: aa1303e0    	mov	x0, x19
1017954d8: 95924719    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017954dc: aa1d03fd    	mov	x29, x29
1017954e0: 9592471a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017954e4: aa0003f8    	mov	x24, x0
1017954e8: b00f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
1017954ec: f9407101    	ldr	x1, [x8, #0xe0] ; isLikelyTalkerSearch:taskKey:
1017954f0: aa1603e0    	mov	x0, x22
1017954f4: aa1703e2    	mov	x2, x23
1017954f8: aa1803e3    	mov	x3, x24
1017954fc: 95924710    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795500: 900f52e8    	adrp	x8, 0x1201f1000 <dyld_stub_binder+0x1201f1000>
101795504: b980b908    	ldrsw	x8, [x8, #0xb8] ; ivar FTSMessageSectionController.isTalkerEntry
101795508: 38286a60    	strb	w0, [x19, x8]
10179550c: aa1803e0    	mov	x0, x24
101795510: 95924711    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795514: aa1703e0    	mov	x0, x23
101795518: 9592470f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179551c: aa1603e0    	mov	x0, x22
101795520: 9592470d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795524: aa1503e0    	mov	x0, x21
101795528: 9592470b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179552c: aa1403e0    	mov	x0, x20
101795530: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101795534: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101795538: a94157f6    	ldp	x22, x21, [sp, #0x10]
10179553c: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101795540: 15924705    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795544: 900f52e8    	adrp	x8, 0x1201f1000 <dyld_stub_binder+0x1201f1000>
101795548: b980b908    	ldrsw	x8, [x8, #0xb8] ; ivar FTSMessageSectionController.isTalkerEntry
10179554c: 38286a7f    	strb	wzr, [x19, x8]
101795550: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101795554: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101795558: a94157f6    	ldp	x22, x21, [sp, #0x10]
10179555c: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101795560: d65f03c0    	ret
