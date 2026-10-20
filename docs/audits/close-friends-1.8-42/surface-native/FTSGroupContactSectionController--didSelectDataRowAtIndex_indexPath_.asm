
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10175a1c8: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10175a1cc: a90157f6    	stp	x22, x21, [sp, #0x10]
10175a1d0: a9024ff4    	stp	x20, x19, [sp, #0x20]
10175a1d4: a9037bfd    	stp	x29, x30, [sp, #0x30]
10175a1d8: 9100c3fd    	add	x29, sp, #0x30
10175a1dc: aa0303f5    	mov	x21, x3
10175a1e0: aa0203f3    	mov	x19, x2
10175a1e4: aa0003f4    	mov	x20, x0
10175a1e8: 900fa6c8    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
10175a1ec: 52800029    	mov	w9, #0x1                ; =1
10175a1f0: 39220d09    	strb	w9, [x8, #0x883]
10175a1f4: d00f3a68    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
10175a1f8: f9475116    	ldr	x22, [x8, #0xea0] ; isCreateChatRoomCellAtRow:
10175a1fc: aa0303e0    	mov	x0, x3
10175a200: 959333ce    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10175a204: aa1403e0    	mov	x0, x20
10175a208: aa1603e1    	mov	x1, x22
10175a20c: aa1303e2    	mov	x2, x19
10175a210: 959333cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a214: aa0003f6    	mov	x22, x0
10175a218: 900f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10175a21c: f9424901    	ldr	x1, [x8, #0x490] ; tableViewContext
10175a220: aa1403e0    	mov	x0, x20
10175a224: 959333c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a228: aa1d03fd    	mov	x29, x29
10175a22c: 959333c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a230: aa0003f7    	mov	x23, x0
10175a234: 900f4d88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10175a238: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
10175a23c: 959333c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a240: aa1d03fd    	mov	x29, x29
10175a244: 959333c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a248: aa0003f8    	mov	x24, x0
10175a24c: d00f3708    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10175a250: f9416101    	ldr	x1, [x8, #0x2c0] ; cellForRowAtIndexPath:
10175a254: aa1503e2    	mov	x2, x21
10175a258: 959333b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a25c: aa1d03fd    	mov	x29, x29
10175a260: 959333ba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a264: aa0003f3    	mov	x19, x0
10175a268: aa1503e0    	mov	x0, x21
10175a26c: 959333ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a270: aa1803e0    	mov	x0, x24
10175a274: 959333b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a278: aa1703e0    	mov	x0, x23
10175a27c: 959333b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a280: 340003b6    	cbz	w22, 0x10175a2f4 <__text+0x17522f4>
10175a284: f00f37a8    	adrp	x8, 0x11fe51000 <dyld_stub_binder+0x11fe51000>
10175a288: f940d901    	ldr	x1, [x8, #0x1b0] ; router
10175a28c: aa1403e0    	mov	x0, x20
10175a290: 959333ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a294: aa1d03fd    	mov	x29, x29
10175a298: 959333ac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a29c: aa0003f5    	mov	x21, x0
10175a2a0: 900f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10175a2a4: f942b501    	ldr	x1, [x8, #0x568] ; resultPage
10175a2a8: aa1403e0    	mov	x0, x20
10175a2ac: 959333a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a2b0: aa1d03fd    	mov	x29, x29
10175a2b4: 959333a5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a2b8: aa0003f4    	mov	x20, x0
10175a2bc: 900f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10175a2c0: f9436901    	ldr	x1, [x8, #0x6d0] ; searchBarText
10175a2c4: 9593339e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a2c8: aa1d03fd    	mov	x29, x29
10175a2cc: 9593339f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a2d0: aa0003f6    	mov	x22, x0
10175a2d4: d00f3a68    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
10175a2d8: f9475d01    	ldr	x1, [x8, #0xeb8] ; openContactPickerViewWith:
10175a2dc: aa1503e0    	mov	x0, x21
10175a2e0: aa1603e2    	mov	x2, x22
10175a2e4: 95933396    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a2e8: aa1603e0    	mov	x0, x22
10175a2ec: 9593339a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a2f0: 1400001f    	b	0x10175a36c <__text+0x175236c>
10175a2f4: b00f50c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10175a2f8: f9461d00    	ldr	x0, [x8, #0xc38]
10175a2fc: b00f4d28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10175a300: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10175a304: 9593338e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a308: aa0003e2    	mov	x2, x0
10175a30c: b00f4d48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10175a310: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
10175a314: aa1303e0    	mov	x0, x19
10175a318: 95933389    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a31c: 34000300    	cbz	w0, 0x10175a37c <__text+0x175237c>
10175a320: f00f37a8    	adrp	x8, 0x11fe51000 <dyld_stub_binder+0x11fe51000>
10175a324: f940d901    	ldr	x1, [x8, #0x1b0] ; router
10175a328: aa1403e0    	mov	x0, x20
10175a32c: 95933384    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a330: aa1d03fd    	mov	x29, x29
10175a334: 95933385    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a338: aa0003f5    	mov	x21, x0
10175a33c: f00f36e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10175a340: f9463901    	ldr	x1, [x8, #0xc70] ; contact
10175a344: aa1303e0    	mov	x0, x19
10175a348: 9593337d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a34c: aa1d03fd    	mov	x29, x29
10175a350: 9593337e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a354: aa0003f4    	mov	x20, x0
10175a358: b00f3968    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
10175a35c: f943fd01    	ldr	x1, [x8, #0x7f8] ; openMessageContentView:
10175a360: aa1503e0    	mov	x0, x21
10175a364: aa1403e2    	mov	x2, x20
10175a368: 95933375    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a36c: aa1403e0    	mov	x0, x20
10175a370: 95933379    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a374: aa1503e0    	mov	x0, x21
10175a378: 95933377    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a37c: aa1303e0    	mov	x0, x19
10175a380: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10175a384: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10175a388: a94157f6    	ldp	x22, x21, [sp, #0x10]
10175a38c: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10175a390: 15933371    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
