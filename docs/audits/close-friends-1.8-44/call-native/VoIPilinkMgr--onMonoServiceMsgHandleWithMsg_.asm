
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106267638: d10103ff    	sub	sp, sp, #0x40
10626763c: a90157f6    	stp	x22, x21, [sp, #0x10]
106267640: a9024ff4    	stp	x20, x19, [sp, #0x20]
106267644: a9037bfd    	stp	x29, x30, [sp, #0x30]
106267648: 9100c3fd    	add	x29, sp, #0x30
10626764c: aa0203f3    	mov	x19, x2
106267650: 900d4ee8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106267654: 52800029    	mov	w9, #0x1                ; =1
106267658: 3926c109    	strb	w9, [x8, #0x9b0]
10626765c: aa0203e0    	mov	x0, x2
106267660: 9466feb6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106267664: aa1303e0    	mov	x0, x19
106267668: 9466feb4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10626766c: f00cf888    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
106267670: f941e500    	ldr	x0, [x8, #0x3c8] ; 0[;
106267674: 900cf4c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106267678: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10626767c: 9466feb0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106267680: aa0003e2    	mov	x2, x0
106267684: 900cf4e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106267688: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
10626768c: aa1303e0    	mov	x0, x19
106267690: 9466feab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106267694: 37000660    	tbnz	w0, #0x0, 0x106267760 <_Flutter_MMFoundation_BindContext+0x2743344>
106267698: b00cf988    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
10626769c: f9463100    	ldr	x0, [x8, #0xc60]
1062676a0: d00ce968    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
1062676a4: f9405101    	ldr	x1, [x8, #0xa0] ; logicStartErrorMsgType
1062676a8: 9466fea5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062676ac: 52800080    	mov	w0, #0x4                ; =4
1062676b0: 946696e4    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1062676b4: 34000560    	cbz	w0, 0x106267760 <_Flutter_MMFoundation_BindContext+0x2743344>
1062676b8: 9466feba    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1062676bc: aa0003f4    	mov	x20, x0
1062676c0: 900cf876    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
1062676c4: f94546c0    	ldr	x0, [x22, #0xa88]
1062676c8: 9466fea6    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1062676cc: aa0003f5    	mov	x21, x0
1062676d0: f94546c0    	ldr	x0, [x22, #0xa88]
1062676d4: f00cf508    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1062676d8: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1062676dc: a9007ff3    	stp	x19, xzr, [sp]
1062676e0: d00c3082    	adrp	x2, 0x11e879000 <dyld_stub_binder+0x11e879000>
1062676e4: 912ea042    	add	x2, x2, #0xba8
1062676e8: 9466fe95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062676ec: aa1d03fd    	mov	x29, x29
1062676f0: 9466fe96    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062676f4: aa0003f6    	mov	x22, x0
1062676f8: f00cf4c8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1062676fc: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106267700: 900c11a8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106267704: 91362108    	add	x8, x8, #0xd88
106267708: a90003e8    	stp	x8, x0, [sp]
10626770c: 900c11a2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106267710: 9134a042    	add	x2, x2, #0xd28
106267714: aa1503e0    	mov	x0, x21
106267718: 9466fe89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10626771c: aa0003f5    	mov	x21, x0
106267720: aa1603e0    	mov	x0, x22
106267724: 9466fe8c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106267728: f00ab7c1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
10626772c: 91373c21    	add	x1, x1, #0xdcf
106267730: f00ab9a2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
106267734: 91112042    	add	x2, x2, #0x448
106267738: d00ab9c4    	adrp	x4, 0x11b9a1000 <dyld_stub_binder+0x11b9a1000>
10626773c: 91136084    	add	x4, x4, #0x4d8
106267740: 52800080    	mov	w0, #0x4                ; =4
106267744: 5281cbe3    	mov	w3, #0xe5f              ; =3679
106267748: aa1503e5    	mov	x5, x21
10626774c: 946696be    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106267750: aa1503e0    	mov	x0, x21
106267754: 9466fe80    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106267758: aa1403e0    	mov	x0, x20
10626775c: 9466fe94    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106267760: aa1303e0    	mov	x0, x19
106267764: 9466fe7c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106267768: aa1303e0    	mov	x0, x19
10626776c: 9466fe7a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106267770: 52800000    	mov	w0, #0x0                ; =0
106267774: a9437bfd    	ldp	x29, x30, [sp, #0x30]
106267778: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10626777c: a94157f6    	ldp	x22, x21, [sp, #0x10]
106267780: 910103ff    	add	sp, sp, #0x40
106267784: d65f03c0    	ret
