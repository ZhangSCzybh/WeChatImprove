
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f6a1cc: d101c3ff    	sub	sp, sp, #0x70
100f6a1d0: a9016ffc    	stp	x28, x27, [sp, #0x10]
100f6a1d4: a90267fa    	stp	x26, x25, [sp, #0x20]
100f6a1d8: a9035ff8    	stp	x24, x23, [sp, #0x30]
100f6a1dc: a90457f6    	stp	x22, x21, [sp, #0x40]
100f6a1e0: a9054ff4    	stp	x20, x19, [sp, #0x50]
100f6a1e4: a9067bfd    	stp	x29, x30, [sp, #0x60]
100f6a1e8: 910183fd    	add	x29, sp, #0x60
100f6a1ec: aa0003f3    	mov	x19, x0
100f6a1f0: d00fe628    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f6a1f4: 52800034    	mov	w20, #0x1               ; =1
100f6a1f8: 39297114    	strb	w20, [x8, #0xa5c]
100f6a1fc: 900f7728    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100f6a200: f9471901    	ldr	x1, [x8, #0xe30] ; shouldShowRoomTodoView
100f6a204: 95b2f3ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a208: 37000fc0    	tbnz	w0, #0x0, 0x100f6a400 <__text+0xf62400>
100f6a20c: b00f93a8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100f6a210: 910b0108    	add	x8, x8, #0x2c0
100f6a214: b9800114    	ldrsw	x20, [x8]
100f6a218: f8746a60    	ldr	x0, [x19, x20]
100f6a21c: 900f76a8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f6a220: f9459901    	ldr	x1, [x8, #0xb30] ; m_nsAppID
100f6a224: f90007e1    	str	x1, [sp, #0x8]
100f6a228: 95b2f3c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a22c: aa1d03fd    	mov	x29, x29
100f6a230: 95b2f3c6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6a234: aa0003f8    	mov	x24, x0
100f6a238: b00f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6a23c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6a240: d00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f6a244: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
100f6a248: aa1503e1    	mov	x1, x21
100f6a24c: 95b2f3bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a250: aa1d03fd    	mov	x29, x29
100f6a254: 95b2f3bd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6a258: aa0003f9    	mov	x25, x0
100f6a25c: d00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6a260: f943b500    	ldr	x0, [x8, #0x768] ; �r8 
100f6a264: b00f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6a268: f947ad16    	ldr	x22, [x8, #0xf58] ; class
100f6a26c: aa1603e1    	mov	x1, x22
100f6a270: 95b2f3b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a274: aa0003e2    	mov	x2, x0
100f6a278: f00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6a27c: f9464117    	ldr	x23, [x8, #0xc80] ; getService:
100f6a280: aa1903e0    	mov	x0, x25
100f6a284: aa1703e1    	mov	x1, x23
100f6a288: 95b2f3ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a28c: aa1d03fd    	mov	x29, x29
100f6a290: 95b2f3ae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6a294: aa0003fa    	mov	x26, x0
100f6a298: f00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6a29c: f9413101    	ldr	x1, [x8, #0x260] ; getAppIdByFunctionType:
100f6a2a0: 52800042    	mov	w2, #0x2                ; =2
100f6a2a4: 95b2f3a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a2a8: aa1d03fd    	mov	x29, x29
100f6a2ac: 95b2f3a7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6a2b0: aa0003fb    	mov	x27, x0
100f6a2b4: b00f8cc8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f6a2b8: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
100f6a2bc: aa1803e0    	mov	x0, x24
100f6a2c0: aa1b03e2    	mov	x2, x27
100f6a2c4: 95b2f39e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a2c8: aa0003fc    	mov	x28, x0
100f6a2cc: aa1b03e0    	mov	x0, x27
100f6a2d0: 95b2f3a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6a2d4: aa1a03e0    	mov	x0, x26
100f6a2d8: 95b2f39f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6a2dc: aa1903e0    	mov	x0, x25
100f6a2e0: 95b2f39d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6a2e4: aa1803e0    	mov	x0, x24
100f6a2e8: 95b2f39b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6a2ec: 3400025c    	cbz	w28, 0x100f6a334 <__text+0xf62334>
100f6a2f0: b00f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6a2f4: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
100f6a2f8: f00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6a2fc: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
100f6a300: f00eaea8    	adrp	x8, 0x11e541000 <dyld_stub_binder+0x11e541000>
100f6a304: 910ca108    	add	x8, x8, #0x328
100f6a308: f90003e8    	str	x8, [sp]
100f6a30c: d00d1fa5    	adrp	x5, 0x11b360000 <dyld_stub_binder+0x11b360000>
100f6a310: 910db4a5    	add	x5, x5, #0x36d
100f6a314: d00d1fa7    	adrp	x7, 0x11b360000 <dyld_stub_binder+0x11b360000>
100f6a318: 910ff4e7    	add	x7, x7, #0x3fd
100f6a31c: 52800042    	mov	w2, #0x2                ; =2
100f6a320: d2800003    	mov	x3, #0x0                ; =0
100f6a324: 52800004    	mov	w4, #0x0                ; =0
100f6a328: 528029a6    	mov	w6, #0x14d              ; =333
100f6a32c: 95b2f384    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a330: 1400000f    	b	0x100f6a36c <__text+0xf6236c>
100f6a334: f8746a60    	ldr	x0, [x19, x20]
100f6a338: f00f76a8    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100f6a33c: f9465501    	ldr	x1, [x8, #0xca8] ; m_oMsgExpItem
100f6a340: 95b2f37f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a344: aa1d03fd    	mov	x29, x29
100f6a348: 95b2f380    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6a34c: aa0003f8    	mov	x24, x0
100f6a350: f00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6a354: f9413501    	ldr	x1, [x8, #0x268] ; bNeedHiddenAppTail
100f6a358: 95b2f379    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a35c: aa0003f9    	mov	x25, x0
100f6a360: aa1803e0    	mov	x0, x24
100f6a364: 95b2f37c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6a368: 36000079    	tbz	w25, #0x0, 0x100f6a374 <__text+0xf62374>
100f6a36c: 52800014    	mov	w20, #0x0               ; =0
100f6a370: 14000024    	b	0x100f6a400 <__text+0xf62400>
100f6a374: d00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6a378: f947b501    	ldr	x1, [x8, #0xf68] ; hasCommonTail
100f6a37c: aa1303e0    	mov	x0, x19
100f6a380: 95b2f36f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a384: 370003c0    	tbnz	w0, #0x0, 0x100f6a3fc <__text+0xf623fc>
100f6a388: f8746a60    	ldr	x0, [x19, x20]
100f6a38c: f00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6a390: f9413901    	ldr	x1, [x8, #0x270] ; withLiteAppSource
100f6a394: 95b2f36a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a398: 37000320    	tbnz	w0, #0x0, 0x100f6a3fc <__text+0xf623fc>
100f6a39c: d00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6a3a0: f947a119    	ldr	x25, [x8, #0xf40] ; sourceInfoHandler
100f6a3a4: aa1303e0    	mov	x0, x19
100f6a3a8: aa1903e1    	mov	x1, x25
100f6a3ac: 95b2f364    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a3b0: aa1d03fd    	mov	x29, x29
100f6a3b4: 95b2f365    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6a3b8: b4000360    	cbz	x0, 0x100f6a424 <__text+0xf62424>
100f6a3bc: aa0003f8    	mov	x24, x0
100f6a3c0: aa1303e0    	mov	x0, x19
100f6a3c4: aa1903e1    	mov	x1, x25
100f6a3c8: 95b2f35d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a3cc: aa1d03fd    	mov	x29, x29
100f6a3d0: 95b2f35e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6a3d4: aa0003f9    	mov	x25, x0
100f6a3d8: f00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6a3dc: f9413d01    	ldr	x1, [x8, #0x278] ; canShow
100f6a3e0: 95b2f357    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a3e4: aa0003fa    	mov	x26, x0
100f6a3e8: aa1903e0    	mov	x0, x25
100f6a3ec: 95b2f35a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6a3f0: aa1803e0    	mov	x0, x24
100f6a3f4: 95b2f358    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6a3f8: 3600017a    	tbz	w26, #0x0, 0x100f6a424 <__text+0xf62424>
100f6a3fc: 52800034    	mov	w20, #0x1               ; =1
100f6a400: aa1403e0    	mov	x0, x20
100f6a404: a9467bfd    	ldp	x29, x30, [sp, #0x60]
100f6a408: a9454ff4    	ldp	x20, x19, [sp, #0x50]
100f6a40c: a94457f6    	ldp	x22, x21, [sp, #0x40]
100f6a410: a9435ff8    	ldp	x24, x23, [sp, #0x30]
100f6a414: a94267fa    	ldp	x26, x25, [sp, #0x20]
100f6a418: a9416ffc    	ldp	x28, x27, [sp, #0x10]
100f6a41c: 9101c3ff    	add	sp, sp, #0x70
100f6a420: d65f03c0    	ret
100f6a424: f8746a60    	ldr	x0, [x19, x20]
100f6a428: f00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6a42c: f9414101    	ldr	x1, [x8, #0x280] ; isShowAppBottomButton
100f6a430: 95b2f343    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a434: 34000420    	cbz	w0, 0x100f6a4b8 <__text+0xf624b8>
100f6a438: b00f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6a43c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6a440: aa1503e1    	mov	x1, x21
100f6a444: 95b2f33e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a448: aa1d03fd    	mov	x29, x29
100f6a44c: 95b2f33f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6a450: aa0003f5    	mov	x21, x0
100f6a454: d00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6a458: f943b500    	ldr	x0, [x8, #0x768] ; �r8 
100f6a45c: aa1603e1    	mov	x1, x22
100f6a460: 95b2f337    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a464: aa0003e2    	mov	x2, x0
100f6a468: aa1503e0    	mov	x0, x21
100f6a46c: aa1703e1    	mov	x1, x23
100f6a470: 95b2f333    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a474: aa1d03fd    	mov	x29, x29
100f6a478: 95b2f334    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6a47c: aa0003f6    	mov	x22, x0
100f6a480: f8746a60    	ldr	x0, [x19, x20]
100f6a484: f94007e1    	ldr	x1, [sp, #0x8]
100f6a488: 95b2f32d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a48c: aa1d03fd    	mov	x29, x29
100f6a490: 95b2f32e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6a494: aa0003f7    	mov	x23, x0
100f6a498: 900f7728    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100f6a49c: f9465d01    	ldr	x1, [x8, #0xcb8] ; isShowAppMessageBottom:
100f6a4a0: aa1603e0    	mov	x0, x22
100f6a4a4: aa1703e2    	mov	x2, x23
100f6a4a8: 95b2f325    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a4ac: 360001c0    	tbz	w0, #0x0, 0x100f6a4e4 <__text+0xf624e4>
100f6a4b0: 52800034    	mov	w20, #0x1               ; =1
100f6a4b4: 14000011    	b	0x100f6a4f8 <__text+0xf624f8>
100f6a4b8: f8746a60    	ldr	x0, [x19, x20]
100f6a4bc: f00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6a4c0: f9414501    	ldr	x1, [x8, #0x288] ; m_isDirectSend
100f6a4c4: a9467bfd    	ldp	x29, x30, [sp, #0x60]
100f6a4c8: a9454ff4    	ldp	x20, x19, [sp, #0x50]
100f6a4cc: a94457f6    	ldp	x22, x21, [sp, #0x40]
100f6a4d0: a9435ff8    	ldp	x24, x23, [sp, #0x30]
100f6a4d4: a94267fa    	ldp	x26, x25, [sp, #0x20]
100f6a4d8: a9416ffc    	ldp	x28, x27, [sp, #0x10]
100f6a4dc: 9101c3ff    	add	sp, sp, #0x70
100f6a4e0: 15b2f317    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a4e4: f8746a60    	ldr	x0, [x19, x20]
100f6a4e8: f00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6a4ec: f9414501    	ldr	x1, [x8, #0x288] ; m_isDirectSend
100f6a4f0: 95b2f313    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6a4f4: aa0003f4    	mov	x20, x0
100f6a4f8: aa1703e0    	mov	x0, x23
100f6a4fc: 95b2f316    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6a500: aa1603e0    	mov	x0, x22
100f6a504: 95b2f314    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6a508: aa1503e0    	mov	x0, x21
100f6a50c: 95b2f312    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6a510: 17ffffbc    	b	0x100f6a400 <__text+0xf62400>