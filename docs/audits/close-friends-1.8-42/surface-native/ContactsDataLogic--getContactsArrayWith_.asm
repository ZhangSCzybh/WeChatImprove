
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010a6618: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1010a661c: a9014ff4    	stp	x20, x19, [sp, #0x10]
1010a6620: a9027bfd    	stp	x29, x30, [sp, #0x20]
1010a6624: 910083fd    	add	x29, sp, #0x20
1010a6628: aa0203f3    	mov	x19, x2
1010a662c: aa0003f4    	mov	x20, x0
1010a6630: d00fdc48    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
1010a6634: 52800029    	mov	w9, #0x1                ; =1
1010a6638: 393d0909    	strb	w9, [x8, #0xf42]
1010a663c: aa0203e0    	mov	x0, x2
1010a6640: 95ae02be    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010a6644: b00f82e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1010a6648: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
1010a664c: b00e9fa2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1010a6650: 91032042    	add	x2, x2, #0xc8
1010a6654: aa1303e0    	mov	x0, x19
1010a6658: 95ae02b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a665c: 34000340    	cbz	w0, 0x1010a66c4 <__text+0x109e6c4>
1010a6660: 900f6d28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1010a6664: f9413d15    	ldr	x21, [x8, #0x278] ; m_uiScene
1010a6668: aa1403e0    	mov	x0, x20
1010a666c: aa1503e1    	mov	x1, x21
1010a6670: 95ae02b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a6674: 7100341f    	cmp	w0, #0xd
1010a6678: 540000c1    	b.ne	0x1010a6690 <__text+0x109e690>
1010a667c: d00f86a8    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
1010a6680: f940f500    	ldr	x0, [x8, #0x1e8] ; @U,
1010a6684: 900f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a6688: f9425d01    	ldr	x1, [x8, #0x4b8] ; GetRecentVideoContact
1010a668c: 1400000a    	b	0x1010a66b4 <__text+0x109e6b4>
1010a6690: aa1403e0    	mov	x0, x20
1010a6694: aa1503e1    	mov	x1, x21
1010a6698: 95ae02a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a669c: 7100381f    	cmp	w0, #0xe
1010a66a0: 54000121    	b.ne	0x1010a66c4 <__text+0x109e6c4>
1010a66a4: d00f86a8    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
1010a66a8: f940f500    	ldr	x0, [x8, #0x1e8] ; @U,
1010a66ac: 900f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a66b0: f9426101    	ldr	x1, [x8, #0x4c0] ; GetRecentVoiceContact
1010a66b4: 95ae02a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a66b8: aa1d03fd    	mov	x29, x29
1010a66bc: 95ae02a3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a66c0: 1400000a    	b	0x1010a66e8 <__text+0x109e6e8>
1010a66c4: 900f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a66c8: b9860d08    	ldrsw	x8, [x8, #0x60c] ; ivar ContactsDataLogic.m_dicAllContacts
1010a66cc: f8686a80    	ldr	x0, [x20, x8]
1010a66d0: d00f82e8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1010a66d4: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
1010a66d8: aa1303e2    	mov	x2, x19
1010a66dc: 95ae0298    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a66e0: aa1d03fd    	mov	x29, x29
1010a66e4: 95ae0299    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a66e8: aa0003f4    	mov	x20, x0
1010a66ec: aa1303e0    	mov	x0, x19
1010a66f0: 95ae0299    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a66f4: aa1403e0    	mov	x0, x20
1010a66f8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1010a66fc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1010a6700: a8c357f6    	ldp	x22, x21, [sp], #0x30
1010a6704: 15ae029b    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
