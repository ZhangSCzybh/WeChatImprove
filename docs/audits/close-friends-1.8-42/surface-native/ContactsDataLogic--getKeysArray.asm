
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010a64c4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1010a64c8: a9014ff4    	stp	x20, x19, [sp, #0x10]
1010a64cc: a9027bfd    	stp	x29, x30, [sp, #0x20]
1010a64d0: 910083fd    	add	x29, sp, #0x20
1010a64d4: aa0003f3    	mov	x19, x0
1010a64d8: d00fdc48    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
1010a64dc: 52800029    	mov	w9, #0x1                ; =1
1010a64e0: 393d0509    	strb	w9, [x8, #0xf41]
1010a64e4: 900f6d28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1010a64e8: f9413d14    	ldr	x20, [x8, #0x278] ; m_uiScene
1010a64ec: aa1403e1    	mov	x1, x20
1010a64f0: 95ae0313    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a64f4: 7100341f    	cmp	w0, #0xd
1010a64f8: 540001e1    	b.ne	0x1010a6534 <__text+0x109e534>
1010a64fc: d00f86a8    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
1010a6500: f940f500    	ldr	x0, [x8, #0x1e8] ; @U,
1010a6504: 900f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a6508: f9425d01    	ldr	x1, [x8, #0x4b8] ; GetRecentVideoContact
1010a650c: 95ae030c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a6510: aa1d03fd    	mov	x29, x29
1010a6514: 95ae030d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a6518: aa0003f5    	mov	x21, x0
1010a651c: d00f82c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010a6520: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1010a6524: 95ae0306    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a6528: b5000280    	cbnz	x0, 0x1010a6578 <__text+0x109e578>
1010a652c: aa1503e0    	mov	x0, x21
1010a6530: 95ae0309    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a6534: aa1303e0    	mov	x0, x19
1010a6538: aa1403e1    	mov	x1, x20
1010a653c: 95ae0300    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a6540: 7100381f    	cmp	w0, #0xe
1010a6544: 540004c1    	b.ne	0x1010a65dc <__text+0x109e5dc>
1010a6548: d00f86a8    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
1010a654c: f940f500    	ldr	x0, [x8, #0x1e8] ; @U,
1010a6550: 900f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a6554: f9426101    	ldr	x1, [x8, #0x4c0] ; GetRecentVoiceContact
1010a6558: 95ae02f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a655c: aa1d03fd    	mov	x29, x29
1010a6560: 95ae02fa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a6564: aa0003f5    	mov	x21, x0
1010a6568: d00f82c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010a656c: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1010a6570: 95ae02f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a6574: b4000300    	cbz	x0, 0x1010a65d4 <__text+0x109e5d4>
1010a6578: b00f8668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010a657c: f9455500    	ldr	x0, [x8, #0xaa8]
1010a6580: b00f82c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1010a6584: f941a101    	ldr	x1, [x8, #0x340] ; array
1010a6588: 95ae02ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a658c: aa1d03fd    	mov	x29, x29
1010a6590: 95ae02ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010a6594: aa0003f4    	mov	x20, x0
1010a6598: 900f6ca8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1010a659c: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1010a65a0: b00e9fa2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1010a65a4: 91032042    	add	x2, x2, #0xc8
1010a65a8: 95ae02e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a65ac: 900f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a65b0: b9862108    	ldrsw	x8, [x8, #0x620] ; ivar ContactsDataLogic.m_arrAllKey
1010a65b4: f8686a62    	ldr	x2, [x19, x8]
1010a65b8: 900f82c8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1010a65bc: f946f901    	ldr	x1, [x8, #0xdf0] ; addObjectsFromArray:
1010a65c0: aa1403e0    	mov	x0, x20
1010a65c4: 95ae02de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a65c8: aa1503e0    	mov	x0, x21
1010a65cc: 95ae02e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a65d0: 14000008    	b	0x1010a65f0 <__text+0x109e5f0>
1010a65d4: aa1503e0    	mov	x0, x21
1010a65d8: 95ae02df    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010a65dc: 900f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a65e0: b9862108    	ldrsw	x8, [x8, #0x620] ; ivar ContactsDataLogic.m_arrAllKey
1010a65e4: f8686a74    	ldr	x20, [x19, x8]
1010a65e8: aa1403e0    	mov	x0, x20
1010a65ec: 95ae02d3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010a65f0: aa1403e0    	mov	x0, x20
1010a65f4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1010a65f8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1010a65fc: a8c357f6    	ldp	x22, x21, [sp], #0x30
1010a6600: 15ae02dc    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
