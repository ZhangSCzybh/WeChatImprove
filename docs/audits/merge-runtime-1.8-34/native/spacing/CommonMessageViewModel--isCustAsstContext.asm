
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f6c454: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
100f6c458: a90157f6    	stp	x22, x21, [sp, #0x10]
100f6c45c: a9024ff4    	stp	x20, x19, [sp, #0x20]
100f6c460: a9037bfd    	stp	x29, x30, [sp, #0x30]
100f6c464: 9100c3fd    	add	x29, sp, #0x30
100f6c468: 900fe628    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f6c46c: 52800029    	mov	w9, #0x1                ; =1
100f6c470: 39299509    	strb	w9, [x8, #0xa65]
100f6c474: d00f7688    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f6c478: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
100f6c47c: 95b2eb30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6c480: aa1d03fd    	mov	x29, x29
100f6c484: 95b2eb31    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6c488: aa0003f3    	mov	x19, x0
100f6c48c: b4000380    	cbz	x0, 0x100f6c4fc <__text+0xf644fc>
100f6c490: b00f7688    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100f6c494: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
100f6c498: aa1303e0    	mov	x0, x19
100f6c49c: 95b2eb28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6c4a0: aa1d03fd    	mov	x29, x29
100f6c4a4: 95b2eb29    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6c4a8: aa0003f4    	mov	x20, x0
100f6c4ac: 900f9058    	adrp	x24, 0x120174000 <dyld_stub_binder+0x120174000>
100f6c4b0: f9400300    	ldr	x0, [x24]
100f6c4b4: 900f76a8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
100f6c4b8: f946c901    	ldr	x1, [x8, #0xd90] ; IsChatRoom:
100f6c4bc: aa1403e2    	mov	x2, x20
100f6c4c0: 95b2eb1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6c4c4: f9400316    	ldr	x22, [x24]
100f6c4c8: 340001e0    	cbz	w0, 0x100f6c504 <__text+0xf64504>
100f6c4cc: f00f7688    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f6c4d0: f941e901    	ldr	x1, [x8, #0x3d0] ; m_nsRealChatUsr
100f6c4d4: aa1303e0    	mov	x0, x19
100f6c4d8: 95b2eb19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6c4dc: aa1d03fd    	mov	x29, x29
100f6c4e0: 95b2eb1a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6c4e4: aa0003f5    	mov	x21, x0
100f6c4e8: 900f7708    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
100f6c4ec: f945e501    	ldr	x1, [x8, #0xbc8] ; IsCustAsst:
100f6c4f0: aa1603e0    	mov	x0, x22
100f6c4f4: aa1503e2    	mov	x2, x21
100f6c4f8: 14000016    	b	0x100f6c550 <__text+0xf64550>
100f6c4fc: 52800016    	mov	w22, #0x0               ; =0
100f6c500: 1400001a    	b	0x100f6c568 <__text+0xf64568>
100f6c504: b00f7688    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100f6c508: f9429d01    	ldr	x1, [x8, #0x538] ; m_nsFromUsr
100f6c50c: aa1303e0    	mov	x0, x19
100f6c510: 95b2eb0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6c514: aa1d03fd    	mov	x29, x29
100f6c518: 95b2eb0c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6c51c: aa0003f5    	mov	x21, x0
100f6c520: 900f7708    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
100f6c524: f945e517    	ldr	x23, [x8, #0xbc8] ; IsCustAsst:
100f6c528: aa1603e0    	mov	x0, x22
100f6c52c: aa1703e1    	mov	x1, x23
100f6c530: aa1503e2    	mov	x2, x21
100f6c534: 95b2eb02    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6c538: 36000060    	tbz	w0, #0x0, 0x100f6c544 <__text+0xf64544>
100f6c53c: 52800036    	mov	w22, #0x1               ; =1
100f6c540: 14000006    	b	0x100f6c558 <__text+0xf64558>
100f6c544: f9400300    	ldr	x0, [x24]
100f6c548: aa1703e1    	mov	x1, x23
100f6c54c: aa1403e2    	mov	x2, x20
100f6c550: 95b2eafb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6c554: aa0003f6    	mov	x22, x0
100f6c558: aa1503e0    	mov	x0, x21
100f6c55c: 95b2eafe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6c560: aa1403e0    	mov	x0, x20
100f6c564: 95b2eafc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6c568: aa1303e0    	mov	x0, x19
100f6c56c: 95b2eafa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6c570: aa1603e0    	mov	x0, x22
100f6c574: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100f6c578: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100f6c57c: a94157f6    	ldp	x22, x21, [sp, #0x10]
100f6c580: a8c45ff8    	ldp	x24, x23, [sp], #0x40
100f6c584: d65f03c0    	ret