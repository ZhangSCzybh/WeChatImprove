
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010e83dc: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1010e83e0: a9014ff4    	stp	x20, x19, [sp, #0x10]
1010e83e4: a9027bfd    	stp	x29, x30, [sp, #0x20]
1010e83e8: 910083fd    	add	x29, sp, #0x20
1010e83ec: aa0303f4    	mov	x20, x3
1010e83f0: aa0003f3    	mov	x19, x0
1010e83f4: b00fda48    	adrp	x8, 0x120c31000 <dyld_stub_binder+0x120c31000>
1010e83f8: 52800029    	mov	w9, #0x1                ; =1
1010e83fc: 39013909    	strb	w9, [x8, #0x4e]
1010e8400: d00f6ce8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
1010e8404: f9418501    	ldr	x1, [x8, #0x308] ; getSectionType:
1010e8408: aa0303e2    	mov	x2, x3
1010e840c: 95acfb4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e8410: aa0003e8    	mov	x8, x0
1010e8414: d2800000    	mov	x0, #0x0                ; =0
1010e8418: 7100091f    	cmp	w8, #0x2
1010e841c: 540000ec    	b.gt	0x1010e8438 <__text+0x10e0438>
1010e8420: 34000248    	cbz	w8, 0x1010e8468 <__text+0x10e0468>
1010e8424: 7100051f    	cmp	w8, #0x1
1010e8428: 54000740    	b.eq	0x1010e8510 <__text+0x10e0510>
1010e842c: 7100091f    	cmp	w8, #0x2
1010e8430: 54000160    	b.eq	0x1010e845c <__text+0x10e045c>
1010e8434: 1400003d    	b	0x1010e8528 <__text+0x10e0528>
1010e8438: 71000d1f    	cmp	w8, #0x3
1010e843c: 54000100    	b.eq	0x1010e845c <__text+0x10e045c>
1010e8440: 7100111f    	cmp	w8, #0x4
1010e8444: 540007a0    	b.eq	0x1010e8538 <__text+0x10e0538>
1010e8448: 7100151f    	cmp	w8, #0x5
1010e844c: 540006e1    	b.ne	0x1010e8528 <__text+0x10e0528>
1010e8450: f00f6d08    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010e8454: f9443101    	ldr	x1, [x8, #0x860] ; numberOfCellForOpenIM
1010e8458: 1400003a    	b	0x1010e8540 <__text+0x10e0540>
1010e845c: f00f6d08    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010e8460: f9443901    	ldr	x1, [x8, #0x870] ; numberOfCellForBrandGroup
1010e8464: 14000037    	b	0x1010e8540 <__text+0x10e0540>
1010e8468: f00f6d08    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010e846c: f9443501    	ldr	x1, [x8, #0x868] ; ConvertToNormalContactSection:
1010e8470: aa1303e0    	mov	x0, x19
1010e8474: aa1403e2    	mov	x2, x20
1010e8478: 95acfb31    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e847c: aa0003f4    	mov	x20, x0
1010e8480: d00f8808    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010e8484: b98a6d16    	ldrsw	x22, [x8, #0xa6c] ; ivar ContactsViewController.m_contactsDataLogic
1010e8488: f8766a60    	ldr	x0, [x19, x22]
1010e848c: d00f6b68    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1010e8490: f942d901    	ldr	x1, [x8, #0x5b0] ; getKeysArray
1010e8494: 95acfb2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e8498: aa1d03fd    	mov	x29, x29
1010e849c: 95acfb2b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010e84a0: aa0003f5    	mov	x21, x0
1010e84a4: d00f6a88    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1010e84a8: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
1010e84ac: aa1403e2    	mov	x2, x20
1010e84b0: 95acfb23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e84b4: aa1d03fd    	mov	x29, x29
1010e84b8: 95acfb24    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010e84bc: aa0003f4    	mov	x20, x0
1010e84c0: aa1503e0    	mov	x0, x21
1010e84c4: 95acfb24    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010e84c8: f8766a60    	ldr	x0, [x19, x22]
1010e84cc: d00f6b68    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1010e84d0: f9430901    	ldr	x1, [x8, #0x610] ; getContactsArrayWith:
1010e84d4: aa1403e2    	mov	x2, x20
1010e84d8: 95acfb19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e84dc: aa1d03fd    	mov	x29, x29
1010e84e0: 95acfb1a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010e84e4: aa0003f3    	mov	x19, x0
1010e84e8: 900f80c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010e84ec: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1010e84f0: 95acfb13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e84f4: aa0003f5    	mov	x21, x0
1010e84f8: aa1303e0    	mov	x0, x19
1010e84fc: 95acfb16    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010e8500: aa1403e0    	mov	x0, x20
1010e8504: 95acfb14    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010e8508: aa1503e0    	mov	x0, x21
1010e850c: 14000007    	b	0x1010e8528 <__text+0x10e0528>
1010e8510: d00f8808    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010e8514: b98a8108    	ldrsw	x8, [x8, #0xa80] ; ivar ContactsViewController.m_hadSectionSocialBlackRowInHelloSection
1010e8518: 38686a68    	ldrb	w8, [x19, x8]
1010e851c: 7100011f    	cmp	w8, #0x0
1010e8520: 52800068    	mov	w8, #0x3                ; =3
1010e8524: 9a880500    	cinc	x0, x8, ne
1010e8528: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1010e852c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1010e8530: a8c357f6    	ldp	x22, x21, [sp], #0x30
1010e8534: d65f03c0    	ret
1010e8538: f00f6d08    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010e853c: f9442d01    	ldr	x1, [x8, #0x858] ; numberOfCellForEnterpriseBrandGroup
1010e8540: aa1303e0    	mov	x0, x19
1010e8544: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1010e8548: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1010e854c: a8c357f6    	ldp	x22, x21, [sp], #0x30
1010e8550: 15acfafb    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
