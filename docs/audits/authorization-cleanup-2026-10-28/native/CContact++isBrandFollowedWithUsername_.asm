
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100bb11cc: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100bb11d0: a9014ff4    	stp	x20, x19, [sp, #0x10]
100bb11d4: a9027bfd    	stp	x29, x30, [sp, #0x20]
100bb11d8: 910083fd    	add	x29, sp, #0x20
100bb11dc: aa0203f4    	mov	x20, x2
100bb11e0: d01003e8    	adrp	x8, 0x120c2f000 <dyld_stub_binder+0x120c2f000>
100bb11e4: 52800029    	mov	w9, #0x1                ; =1
100bb11e8: 39353d09    	strb	w9, [x8, #0xd4f]
100bb11ec: d00fae08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100bb11f0: f945e913    	ldr	x19, [x8, #0xbd0] ; class MMContext
100bb11f4: f00faa68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100bb11f8: f944e915    	ldr	x21, [x8, #0x9d0] ; selector currentContext
100bb11fc: aa0203e0    	mov	x0, x2
100bb1200: 95c1d7ce    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100bb1204: aa1303e0    	mov	x0, x19
100bb1208: aa1503e1    	mov	x1, x21
100bb120c: 95c1d7cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bb1210: aa1d03fd    	mov	x29, x29
100bb1214: 95c1d7cd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100bb1218: aa0003f5    	mov	x21, x0
100bb121c: f00fae08    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100bb1220: f9401500    	ldr	x0, [x8, #0x28] ; class CContactMgr
100bb1224: d00faa68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100bb1228: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
100bb122c: 95c1d7c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bb1230: aa0003e2    	mov	x2, x0
100bb1234: 900f9448    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100bb1238: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
100bb123c: aa1503e0    	mov	x0, x21
100bb1240: 95c1d7bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bb1244: aa1d03fd    	mov	x29, x29
100bb1248: 95c1d7c0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100bb124c: aa0003f6    	mov	x22, x0
100bb1250: f00f9448    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100bb1254: f940c901    	ldr	x1, [x8, #0x190] ; selector getContactByName:
100bb1258: aa1403e2    	mov	x2, x20
100bb125c: 95c1d7b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bb1260: aa1d03fd    	mov	x29, x29
100bb1264: 95c1d7b9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100bb1268: aa0003f3    	mov	x19, x0
100bb126c: aa1403e0    	mov	x0, x20
100bb1270: 95c1d7b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100bb1274: aa1603e0    	mov	x0, x22
100bb1278: 95c1d7b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100bb127c: aa1503e0    	mov	x0, x21
100bb1280: 95c1d7b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100bb1284: b4000173    	cbz	x19, 0x100bb12b0 <__text+0xba92b0>
100bb1288: d00f9448    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100bb128c: f947b501    	ldr	x1, [x8, #0xf68] ; selector isBrandContact
100bb1290: aa1303e0    	mov	x0, x19
100bb1294: 95c1d7aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bb1298: 340000c0    	cbz	w0, 0x100bb12b0 <__text+0xba92b0>
100bb129c: f00f9608    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
100bb12a0: f941e501    	ldr	x1, [x8, #0x3c8] ; selector isWeAppContact
100bb12a4: aa1303e0    	mov	x0, x19
100bb12a8: 95c1d7a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bb12ac: 36000120    	tbz	w0, #0x0, 0x100bb12d0 <__text+0xba92d0>
100bb12b0: 52800014    	mov	w20, #0x0               ; =0
100bb12b4: aa1303e0    	mov	x0, x19
100bb12b8: 95c1d7a7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100bb12bc: aa1403e0    	mov	x0, x20
100bb12c0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100bb12c4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100bb12c8: a8c357f6    	ldp	x22, x21, [sp], #0x30
100bb12cc: d65f03c0    	ret
100bb12d0: f00f9448    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100bb12d4: f940cd01    	ldr	x1, [x8, #0x198] ; selector isMMContact
100bb12d8: aa1303e0    	mov	x0, x19
100bb12dc: 95c1d798    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bb12e0: aa0003f4    	mov	x20, x0
100bb12e4: 17fffff4    	b	0x100bb12b4 <__text+0xba92b4>
