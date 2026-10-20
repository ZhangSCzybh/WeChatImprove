
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101797fec: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101797ff0: a90157f6    	stp	x22, x21, [sp, #0x10]
101797ff4: a9024ff4    	stp	x20, x19, [sp, #0x20]
101797ff8: a9037bfd    	stp	x29, x30, [sp, #0x30]
101797ffc: 9100c3fd    	add	x29, sp, #0x30
101798000: aa0003f4    	mov	x20, x0
101798004: d00fa4c8    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
101798008: 52800029    	mov	w9, #0x1                ; =1
10179800c: 3925d109    	strb	w9, [x8, #0x974]
101798010: d00f3888    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101798014: f940c101    	ldr	x1, [x8, #0x180] ; mgrSessionIndexForDisplayedItemRow:
101798018: 95923c49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10179801c: aa0003f5    	mov	x21, x0
101798020: f00f4ec8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101798024: f945e900    	ldr	x0, [x8, #0xbd0]
101798028: 900f4b48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10179802c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101798030: 95923c43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101798034: aa1d03fd    	mov	x29, x29
101798038: 95923c44    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10179803c: aa0003f3    	mov	x19, x0
101798040: f00f4ec8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101798044: f9477100    	ldr	x0, [x8, #0xee0]
101798048: f00f4b28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10179804c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101798050: 95923c3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101798054: aa0003e2    	mov	x2, x0
101798058: b00f3508    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10179805c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101798060: aa1303e0    	mov	x0, x19
101798064: 95923c36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101798068: aa1d03fd    	mov	x29, x29
10179806c: 95923c37    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101798070: aa0003f6    	mov	x22, x0
101798074: b00f35a8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
101798078: f9472d01    	ldr	x1, [x8, #0xe58] ; ftsMessageMgr
10179807c: 95923c30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101798080: aa1d03fd    	mov	x29, x29
101798084: 95923c31    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101798088: aa0003f7    	mov	x23, x0
10179808c: d00f3868    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101798090: f9431901    	ldr	x1, [x8, #0x630] ; curSearchText
101798094: aa1403e0    	mov	x0, x20
101798098: 95923c29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10179809c: aa1d03fd    	mov	x29, x29
1017980a0: 95923c2a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017980a4: aa0003f8    	mov	x24, x0
1017980a8: d00f3868    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017980ac: f943a101    	ldr	x1, [x8, #0x740] ; ftsTaskKey
1017980b0: aa1403e0    	mov	x0, x20
1017980b4: 95923c22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017980b8: aa1d03fd    	mov	x29, x29
1017980bc: 95923c23    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017980c0: aa0003f4    	mov	x20, x0
1017980c4: d00f3788    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1017980c8: f9437101    	ldr	x1, [x8, #0x6e0] ; getSessionMsgItemsForQuery:atIndex:taskKey:
1017980cc: aa1703e0    	mov	x0, x23
1017980d0: aa1803e2    	mov	x2, x24
1017980d4: aa1503e3    	mov	x3, x21
1017980d8: aa1403e4    	mov	x4, x20
1017980dc: 95923c18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017980e0: aa1d03fd    	mov	x29, x29
1017980e4: 95923c19    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017980e8: aa0003f5    	mov	x21, x0
1017980ec: aa1403e0    	mov	x0, x20
1017980f0: 95923c19    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017980f4: aa1803e0    	mov	x0, x24
1017980f8: 95923c17    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017980fc: aa1703e0    	mov	x0, x23
101798100: 95923c15    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101798104: aa1603e0    	mov	x0, x22
101798108: 95923c13    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10179810c: aa1303e0    	mov	x0, x19
101798110: 95923c11    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101798114: aa1503e0    	mov	x0, x21
101798118: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10179811c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101798120: a94157f6    	ldp	x22, x21, [sp, #0x10]
101798124: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101798128: 15923c12    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
