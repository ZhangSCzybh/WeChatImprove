
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ba6634: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104ba6638: a9014ff4    	stp	x20, x19, [sp, #0x10]
104ba663c: a9027bfd    	stp	x29, x30, [sp, #0x20]
104ba6640: 910083fd    	add	x29, sp, #0x20
104ba6644: aa0003f4    	mov	x20, x0
104ba6648: 900e04c8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104ba664c: 52800029    	mov	w9, #0x1                ; =1
104ba6650: 391a9d09    	strb	w9, [x8, #0x6a7]
104ba6654: d00d94a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104ba6658: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
104ba665c: 94c202b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba6660: aa0003f3    	mov	x19, x0
104ba6664: 900d94c8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104ba6668: f9413d01    	ldr	x1, [x8, #0x278] ; m_uiMessageType
104ba666c: aa1403e0    	mov	x0, x20
104ba6670: 94c202b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba6674: 7100c41f    	cmp	w0, #0x31
104ba6678: 54000581    	b.ne	0x104ba6728 <_Flutter_MMFoundation_BindContext+0x108230c>
104ba667c: 900d94c8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104ba6680: f9414101    	ldr	x1, [x8, #0x280] ; m_uiAppMsgInnerType
104ba6684: aa1403e0    	mov	x0, x20
104ba6688: 94c202ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba668c: 7100f81f    	cmp	w0, #0x3e
104ba6690: 540004c1    	b.ne	0x104ba6728 <_Flutter_MMFoundation_BindContext+0x108230c>
104ba6694: d00d94c8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104ba6698: f945d501    	ldr	x1, [x8, #0xba8] ; patMessageWrap
104ba669c: aa1403e0    	mov	x0, x20
104ba66a0: 94c202a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba66a4: aa1d03fd    	mov	x29, x29
104ba66a8: 94c202a8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba66ac: aa0003f4    	mov	x20, x0
104ba66b0: d00d94c8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104ba66b4: f945d901    	ldr	x1, [x8, #0xbb0] ; patWraps
104ba66b8: 94c202a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba66bc: aa1d03fd    	mov	x29, x29
104ba66c0: 94c202a2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba66c4: aa0003f6    	mov	x22, x0
104ba66c8: b00daae8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104ba66cc: f9466101    	ldr	x1, [x8, #0xcc0] ; lastObject
104ba66d0: 94c2029b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba66d4: aa1d03fd    	mov	x29, x29
104ba66d8: 94c2029c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba66dc: aa0003f5    	mov	x21, x0
104ba66e0: aa1603e0    	mov	x0, x22
104ba66e4: 94c2029c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba66e8: b4000195    	cbz	x21, 0x104ba6718 <_Flutter_MMFoundation_BindContext+0x10822fc>
104ba66ec: d00d94c8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104ba66f0: f9438101    	ldr	x1, [x8, #0x700] ; createTime
104ba66f4: aa1503e0    	mov	x0, x21
104ba66f8: 94c20291    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba66fc: d343fc08    	lsr	x8, x0, #3
104ba6700: d29ef9e9    	mov	x9, #0xf7cf             ; =63439
104ba6704: f2bc6a69    	movk	x9, #0xe353, lsl #16
104ba6708: f2d374a9    	movk	x9, #0x9ba5, lsl #32
104ba670c: f2e41889    	movk	x9, #0x20c4, lsl #48
104ba6710: 9bc97d08    	umulh	x8, x8, x9
104ba6714: d344fd13    	lsr	x19, x8, #4
104ba6718: aa1503e0    	mov	x0, x21
104ba671c: 94c2028e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba6720: aa1403e0    	mov	x0, x20
104ba6724: 94c2028c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba6728: aa1303e0    	mov	x0, x19
104ba672c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104ba6730: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104ba6734: a8c357f6    	ldp	x22, x21, [sp], #0x30
104ba6738: d65f03c0    	ret
