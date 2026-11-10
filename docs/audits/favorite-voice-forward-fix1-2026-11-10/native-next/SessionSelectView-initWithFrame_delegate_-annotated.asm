
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105af97f8: d101c3ff    	sub	sp, sp, #0x70
105af97fc: 6d012beb    	stp	d11, d10, [sp, #0x10]
105af9800: 6d0223e9    	stp	d9, d8, [sp, #0x20]
105af9804: a9035ff8    	stp	x24, x23, [sp, #0x30]
105af9808: a90457f6    	stp	x22, x21, [sp, #0x40]
105af980c: a9054ff4    	stp	x20, x19, [sp, #0x50]
105af9810: a9067bfd    	stp	x29, x30, [sp, #0x60]
105af9814: 910183fd    	add	x29, sp, #0x60
105af9818: aa0203f3    	mov	x19, x2
105af981c: 4ea31c68    	mov.16b	v8, v3
105af9820: 4ea21c49    	mov.16b	v9, v2
105af9824: 4ea11c2a    	mov.16b	v10, v1
105af9828: 4ea01c0b    	mov.16b	v11, v0
105af982c: aa0003f4    	mov	x20, x0
105af9830: f00ce2c8    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
105af9834: 52800029    	mov	w9, #0x1                ; =1
105af9838: 39345509    	strb	w9, [x8, #0xd15]
105af983c: aa0203e0    	mov	x0, x2
105af9840: 9484b90d    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105af9844: d00c9368    	adrp	x8, 0x11ed67000 <dyld_stub_binder+0x11ed67000>
105af9848: f940f508    	ldr	x8, [x8, #0x1e8]
105af984c: a90023f4    	stp	x20, x8, [sp]
105af9850: f00c8d68    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
105af9854: f9418501    	ldr	x1, [x8, #0x308] ; selector: initWithFrame:
105af9858: 910003e0    	mov	x0, sp
105af985c: 4eab1d60    	mov.16b	v0, v11
105af9860: 4eaa1d41    	mov.16b	v1, v10
105af9864: 4ea91d22    	mov.16b	v2, v9
105af9868: 4ea81d03    	mov.16b	v3, v8
105af986c: 9484b8ff    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
105af9870: aa0003f4    	mov	x20, x0
105af9874: b4000a80    	cbz	x0, 0x105af99c4 <_Flutter_MMFoundation_BindContext+0x1d80690>
105af9878: 900c96c8    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105af987c: b9862d18    	ldrsw	x24, [x8, #0x62c] ; ivar: SessionSelectView.m_delegate offset=16
105af9880: 8b180280    	add	x0, x20, x24
105af9884: aa1303e1    	mov	x1, x19
105af9888: 9484b906    	bl	0x107c27ca0 <_Flutter_MMFoundation_BindContext+0x3eae96c>
105af988c: b00c90c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105af9890: f943c100    	ldr	x0, [x8, #0x780]
105af9894: 900c7688    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105af9898: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
105af989c: 9484b8f2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105af98a0: aa1d03fd    	mov	x29, x29
105af98a4: 9484b8f7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105af98a8: aa0003f5    	mov	x21, x0
105af98ac: d00c90a8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
105af98b0: f9467102    	ldr	x2, [x8, #0xce0]
105af98b4: 900c7688    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105af98b8: f9478501    	ldr	x1, [x8, #0xf08] ; selector: registerExtension:withTarget:
105af98bc: aa1403e3    	mov	x3, x20
105af98c0: 9484b8e9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105af98c4: aa1503e0    	mov	x0, x21
105af98c8: 9484b8ea    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105af98cc: 900c96c8    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105af98d0: b9862908    	ldrsw	x8, [x8, #0x628] ; ivar: SessionSelectView.m_bShowEnterpriseChat offset=152
105af98d4: 38286a9f    	strb	wzr, [x20, x8]
105af98d8: 900c96c8    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105af98dc: b9864108    	ldrsw	x8, [x8, #0x640] ; ivar: SessionSelectView.m_bShowNewSession offset=153
105af98e0: 38286a9f    	strb	wzr, [x20, x8]
105af98e4: 900c96c8    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105af98e8: b9863108    	ldrsw	x8, [x8, #0x630] ; ivar: SessionSelectView.m_bFilterMyContact offset=155
105af98ec: 38286a9f    	strb	wzr, [x20, x8]
105af98f0: 900c96c8    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105af98f4: b9861108    	ldrsw	x8, [x8, #0x610] ; ivar: SessionSelectView.m_bMultiSelect offset=156
105af98f8: 38286a9f    	strb	wzr, [x20, x8]
105af98fc: 900c96c8    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105af9900: b9864508    	ldrsw	x8, [x8, #0x644] ; ivar: SessionSelectView.nsCurrentSearchText offset=80
105af9904: f8686a80    	ldr	x0, [x20, x8]
105af9908: f8286a9f    	str	xzr, [x20, x8]
105af990c: 9484b8d9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105af9910: 900c96c8    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105af9914: b9864908    	ldrsw	x8, [x8, #0x648] ; ivar: SessionSelectView.arrSearchResultOfContacts offset=88
105af9918: f8686a80    	ldr	x0, [x20, x8]
105af991c: f8286a9f    	str	xzr, [x20, x8]
105af9920: 9484b8d4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105af9924: 900c96c8    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105af9928: b9864d08    	ldrsw	x8, [x8, #0x64c] ; ivar: SessionSelectView.arrSearchResultOfGroup offset=96
105af992c: f8686a80    	ldr	x0, [x20, x8]
105af9930: f8286a9f    	str	xzr, [x20, x8]
105af9934: 9484b8cf    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105af9938: 900c96c8    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105af993c: b9865108    	ldrsw	x8, [x8, #0x650] ; ivar: SessionSelectView._expandBitSet offset=136
105af9940: b8286a9f    	str	wzr, [x20, x8]
105af9944: 900c96c8    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105af9948: b9865508    	ldrsw	x8, [x8, #0x654] ; ivar: SessionSelectView._forwardOtherAppEntry offset=180
105af994c: 12800009    	mov	w9, #-0x1               ; =-1
105af9950: b8286a89    	str	w9, [x20, x8]
105af9954: f00c82a8    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105af9958: f9462901    	ldr	x1, [x8, #0xc50] ; selector: setHasAnyForwardToOtherAppEntryState:
105af995c: aa1403e0    	mov	x0, x20
105af9960: 12800002    	mov	w2, #-0x1               ; =-1
105af9964: 9484b8c0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105af9968: 8b180280    	add	x0, x20, x24
105af996c: 9484b8bc    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
105af9970: aa0003f6    	mov	x22, x0
105af9974: f00c82a8    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105af9978: f9469d15    	ldr	x21, [x8, #0xd38] ; selector: showChatRoomOnly
105af997c: b00c8d88    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
105af9980: f9440501    	ldr	x1, [x8, #0x808] ; selector: respondsToSelector:
105af9984: aa1503e2    	mov	x2, x21
105af9988: 9484b8b7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105af998c: aa0003f7    	mov	x23, x0
105af9990: aa1603e0    	mov	x0, x22
105af9994: 9484b8b7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105af9998: 34000177    	cbz	w23, 0x105af99c4 <_Flutter_MMFoundation_BindContext+0x1d80690>
105af999c: 8b180280    	add	x0, x20, x24
105af99a0: 9484b8af    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
105af99a4: aa0003f6    	mov	x22, x0
105af99a8: aa1503e1    	mov	x1, x21
105af99ac: 9484b8ae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105af99b0: 900c96c8    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105af99b4: b9863908    	ldrsw	x8, [x8, #0x638] ; ivar: SessionSelectView._chatRoomOnly offset=140
105af99b8: 38286a80    	strb	w0, [x20, x8]
105af99bc: aa1603e0    	mov	x0, x22
105af99c0: 9484b8ac    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105af99c4: aa1303e0    	mov	x0, x19
105af99c8: 9484b8aa    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105af99cc: aa1403e0    	mov	x0, x20
105af99d0: a9467bfd    	ldp	x29, x30, [sp, #0x60]
105af99d4: a9454ff4    	ldp	x20, x19, [sp, #0x50]
105af99d8: a94457f6    	ldp	x22, x21, [sp, #0x40]
105af99dc: a9435ff8    	ldp	x24, x23, [sp, #0x30]
105af99e0: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
105af99e4: 6d412beb    	ldp	d11, d10, [sp, #0x10]
105af99e8: 9101c3ff    	add	sp, sp, #0x70
105af99ec: d65f03c0    	ret
