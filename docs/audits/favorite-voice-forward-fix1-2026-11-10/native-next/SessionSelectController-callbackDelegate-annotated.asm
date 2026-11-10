
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae6718: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
105ae671c: a90157f6    	stp	x22, x21, [sp, #0x10]
105ae6720: a9024ff4    	stp	x20, x19, [sp, #0x20]
105ae6724: a9037bfd    	stp	x29, x30, [sp, #0x30]
105ae6728: 9100c3fd    	add	x29, sp, #0x30
105ae672c: aa0003f3    	mov	x19, x0
105ae6730: d00ce368    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
105ae6734: 52800029    	mov	w9, #0x1                ; =1
105ae6738: 39330909    	strb	w9, [x8, #0xcc2]
105ae673c: d00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae6740: f944cd01    	ldr	x1, [x8, #0x998] ; selector: m_bShowMultiSelectRightBtn
105ae6744: 94850548    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae6748: 370000e0    	tbnz	w0, #0x0, 0x105ae6764 <_Flutter_MMFoundation_BindContext+0x1d6d430>
105ae674c: 52801920    	mov	w0, #0xc9               ; =201
105ae6750: 52800421    	mov	w1, #0x21               ; =33
105ae6754: 52800022    	mov	w2, #0x1                ; =1
105ae6758: 52800003    	mov	w3, #0x0                ; =0
105ae675c: 52800004    	mov	w4, #0x0                ; =0
105ae6760: 97180eab    	bl	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
105ae6764: f00c9748    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae6768: b984b917    	ldrsw	x23, [x8, #0x4b8] ; ivar: SessionSelectController.m_delegate offset=120
105ae676c: 8b170260    	add	x0, x19, x23
105ae6770: 9485053b    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
105ae6774: aa0003f4    	mov	x20, x0
105ae6778: d00c7f48    	adrp	x8, 0x11ead0000 <dyld_stub_binder+0x11ead0000>
105ae677c: f941d915    	ldr	x21, [x8, #0x3b0] ; selector: OnSelectSessions:SessionSelectController:
105ae6780: 900c8e28    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
105ae6784: f9440501    	ldr	x1, [x8, #0x808] ; selector: respondsToSelector:
105ae6788: aa1503e2    	mov	x2, x21
105ae678c: 94850536    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae6790: aa0003f6    	mov	x22, x0
105ae6794: aa1403e0    	mov	x0, x20
105ae6798: 94850536    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae679c: 34000256    	cbz	w22, 0x105ae67e4 <_Flutter_MMFoundation_BindContext+0x1d6d4b0>
105ae67a0: 900c9168    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105ae67a4: f9434500    	ldr	x0, [x8, #0x688]
105ae67a8: f00c9748    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae67ac: b984a908    	ldrsw	x8, [x8, #0x4a8] ; ivar: SessionSelectController.m_selectedContacts offset=128
105ae67b0: f8686a62    	ldr	x2, [x19, x8]
105ae67b4: f00c8de8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
105ae67b8: f946d101    	ldr	x1, [x8, #0xda0] ; selector: arrayWithArray:
105ae67bc: 9485052a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae67c0: aa1d03fd    	mov	x29, x29
105ae67c4: 9485052f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae67c8: aa0003f4    	mov	x20, x0
105ae67cc: 8b170260    	add	x0, x19, x23
105ae67d0: 94850523    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
105ae67d4: aa0003f6    	mov	x22, x0
105ae67d8: aa1503e1    	mov	x1, x21
105ae67dc: aa1403e2    	mov	x2, x20
105ae67e0: 14000012    	b	0x105ae6828 <_Flutter_MMFoundation_BindContext+0x1d6d4f4>
105ae67e4: 8b170260    	add	x0, x19, x23
105ae67e8: 9485051d    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
105ae67ec: aa0003f4    	mov	x20, x0
105ae67f0: f00c9748    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae67f4: b984a908    	ldrsw	x8, [x8, #0x4a8] ; ivar: SessionSelectController.m_selectedContacts offset=128
105ae67f8: f8686a60    	ldr	x0, [x19, x8]
105ae67fc: 900c7728    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
105ae6800: f941b101    	ldr	x1, [x8, #0x360] ; selector: safeObjectAtIndex:
105ae6804: d2800002    	mov	x2, #0x0                ; =0
105ae6808: 94850517    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae680c: aa1d03fd    	mov	x29, x29
105ae6810: 9485051c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae6814: aa0003f6    	mov	x22, x0
105ae6818: d00c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae681c: f944e101    	ldr	x1, [x8, #0x9c0] ; selector: OnSelectSession:SessionSelectController:
105ae6820: aa1403e0    	mov	x0, x20
105ae6824: aa1603e2    	mov	x2, x22
105ae6828: aa1303e3    	mov	x3, x19
105ae682c: 9485050e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae6830: aa1603e0    	mov	x0, x22
105ae6834: 9485050f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae6838: aa1403e0    	mov	x0, x20
105ae683c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
105ae6840: a9424ff4    	ldp	x20, x19, [sp, #0x20]
105ae6844: a94157f6    	ldp	x22, x21, [sp, #0x10]
105ae6848: a8c45ff8    	ldp	x24, x23, [sp], #0x40
105ae684c: 14850509    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
