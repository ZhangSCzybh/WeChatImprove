
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10175acac: d10143ff    	sub	sp, sp, #0x50
10175acb0: a9015ff8    	stp	x24, x23, [sp, #0x10]
10175acb4: a90257f6    	stp	x22, x21, [sp, #0x20]
10175acb8: a9034ff4    	stp	x20, x19, [sp, #0x30]
10175acbc: a9047bfd    	stp	x29, x30, [sp, #0x40]
10175acc0: 910103fd    	add	x29, sp, #0x40
10175acc4: aa0203f5    	mov	x21, x2
10175acc8: aa0003f3    	mov	x19, x0
10175accc: b00df4a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10175acd0: f9405908    	ldr	x8, [x8, #0xb0]
10175acd4: f9400108    	ldr	x8, [x8]
10175acd8: f90007e8    	str	x8, [sp, #0x8]
10175acdc: 900fa6c8    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
10175ace0: 52800029    	mov	w9, #0x1                ; =1
10175ace4: 39222109    	strb	w9, [x8, #0x888]
10175ace8: 900f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10175acec: f943a114    	ldr	x20, [x8, #0x740] ; ftsTaskKey
10175acf0: aa0203e0    	mov	x0, x2
10175acf4: 95933111    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10175acf8: aa1303e0    	mov	x0, x19
10175acfc: aa1403e1    	mov	x1, x20
10175ad00: 9593310f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175ad04: aa1d03fd    	mov	x29, x29
10175ad08: 95933110    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175ad0c: aa0003f6    	mov	x22, x0
10175ad10: b00f4d48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10175ad14: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
10175ad18: aa1503e0    	mov	x0, x21
10175ad1c: aa1603e2    	mov	x2, x22
10175ad20: 95933107    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175ad24: aa0003f7    	mov	x23, x0
10175ad28: aa1503e0    	mov	x0, x21
10175ad2c: 9593310a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175ad30: aa1603e0    	mov	x0, x22
10175ad34: 95933108    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175ad38: 34000cf7    	cbz	w23, 0x10175aed4 <__text+0x1752ed4>
10175ad3c: b00f50c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10175ad40: f945e900    	ldr	x0, [x8, #0xbd0]
10175ad44: d00f4d28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10175ad48: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10175ad4c: 959330fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175ad50: aa1d03fd    	mov	x29, x29
10175ad54: 959330fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175ad58: aa0003f5    	mov	x21, x0
10175ad5c: b00f50c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10175ad60: f9477100    	ldr	x0, [x8, #0xee0]
10175ad64: b00f4d28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10175ad68: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10175ad6c: 959330f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175ad70: aa0003e2    	mov	x2, x0
10175ad74: f00f36e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10175ad78: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10175ad7c: aa1503e0    	mov	x0, x21
10175ad80: 959330ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175ad84: aa1d03fd    	mov	x29, x29
10175ad88: 959330f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175ad8c: aa0003f6    	mov	x22, x0
10175ad90: b00f3708    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10175ad94: f9430d01    	ldr	x1, [x8, #0x618] ; ftsContactMgr
10175ad98: 959330e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175ad9c: aa1d03fd    	mov	x29, x29
10175ada0: 959330ea    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175ada4: aa0003f7    	mov	x23, x0
10175ada8: aa1303e0    	mov	x0, x19
10175adac: aa1403e1    	mov	x1, x20
10175adb0: 959330e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175adb4: aa1d03fd    	mov	x29, x29
10175adb8: 959330e4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175adbc: aa0003f8    	mov	x24, x0
10175adc0: 900f3988    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
10175adc4: f9429d01    	ldr	x1, [x8, #0x538] ; getGroupContactsWithTaskKey:
10175adc8: aa1703e0    	mov	x0, x23
10175adcc: aa1803e2    	mov	x2, x24
10175add0: 959330db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175add4: aa1d03fd    	mov	x29, x29
10175add8: 959330dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175addc: aa0003f4    	mov	x20, x0
10175ade0: aa1803e0    	mov	x0, x24
10175ade4: 959330dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175ade8: aa1703e0    	mov	x0, x23
10175adec: 959330da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175adf0: aa1603e0    	mov	x0, x22
10175adf4: 959330d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175adf8: aa1503e0    	mov	x0, x21
10175adfc: 959330d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175ae00: 900f5128    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
10175ae04: f947f900    	ldr	x0, [x8, #0xff0]
10175ae08: 959330d6    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10175ae0c: aa0003f5    	mov	x21, x0
10175ae10: 900f3a08    	adrp	x8, 0x11fe9a000 <dyld_stub_binder+0x11fe9a000>
10175ae14: f943ad01    	ldr	x1, [x8, #0x758] ; sectionType
10175ae18: aa1303e0    	mov	x0, x19
10175ae1c: 959330c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175ae20: aa0003f6    	mov	x22, x0
10175ae24: d00f4d48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10175ae28: f9447901    	ldr	x1, [x8, #0x8f0] ; mode
10175ae2c: aa1303e0    	mov	x0, x19
10175ae30: 959330c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175ae34: f100041f    	cmp	x0, #0x1
10175ae38: 1a9f17e4    	cset	w4, eq
10175ae3c: 900f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10175ae40: f943e101    	ldr	x1, [x8, #0x7c0] ; initWithType:contacts:isDetailSearch:
10175ae44: aa1503e0    	mov	x0, x21
10175ae48: aa1603e2    	mov	x2, x22
10175ae4c: aa1403e3    	mov	x3, x20
10175ae50: 959330bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175ae54: aa0003f5    	mov	x21, x0
10175ae58: 900f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10175ae5c: f942b501    	ldr	x1, [x8, #0x568] ; resultPage
10175ae60: aa1303e0    	mov	x0, x19
10175ae64: 959330b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175ae68: aa1d03fd    	mov	x29, x29
10175ae6c: 959330b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175ae70: aa0003f3    	mov	x19, x0
10175ae74: f90003f5    	str	x21, [sp]
10175ae78: b00f50c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10175ae7c: f9456d00    	ldr	x0, [x8, #0xad8]
10175ae80: b00f4d28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10175ae84: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
10175ae88: 910003e2    	mov	x2, sp
10175ae8c: 52800023    	mov	w3, #0x1                ; =1
10175ae90: 959330ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175ae94: aa1d03fd    	mov	x29, x29
10175ae98: 959330ac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175ae9c: aa0003f6    	mov	x22, x0
10175aea0: 900f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10175aea4: f942b901    	ldr	x1, [x8, #0x570] ; reloadListWithDataUpdate:
10175aea8: aa1303e0    	mov	x0, x19
10175aeac: aa1603e2    	mov	x2, x22
10175aeb0: 959330a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175aeb4: aa1603e0    	mov	x0, x22
10175aeb8: 959330a7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175aebc: aa1303e0    	mov	x0, x19
10175aec0: 959330a5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175aec4: aa1503e0    	mov	x0, x21
10175aec8: 959330a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175aecc: aa1403e0    	mov	x0, x20
10175aed0: 959330a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175aed4: f94007e8    	ldr	x8, [sp, #0x8]
10175aed8: b00df4a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10175aedc: f9405929    	ldr	x9, [x9, #0xb0]
10175aee0: f9400129    	ldr	x9, [x9]
10175aee4: eb08013f    	cmp	x9, x8
10175aee8: 540000e1    	b.ne	0x10175af04 <__text+0x1752f04>
10175aeec: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10175aef0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10175aef4: a94257f6    	ldp	x22, x21, [sp, #0x20]
10175aef8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10175aefc: 910143ff    	add	sp, sp, #0x50
10175af00: d65f03c0    	ret
10175af04: 9593309c    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
