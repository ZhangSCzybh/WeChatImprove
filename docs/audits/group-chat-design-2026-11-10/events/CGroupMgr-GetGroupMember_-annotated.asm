
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
102039898: d10603ff    	sub	sp, sp, #0x180
10203989c: a9126ffc    	stp	x28, x27, [sp, #0x120]
1020398a0: a91367fa    	stp	x26, x25, [sp, #0x130]
1020398a4: a9145ff8    	stp	x24, x23, [sp, #0x140]
1020398a8: a91557f6    	stp	x22, x21, [sp, #0x150]
1020398ac: a9164ff4    	stp	x20, x19, [sp, #0x160]
1020398b0: a9177bfd    	stp	x29, x30, [sp, #0x170]
1020398b4: 9105c3fd    	add	x29, sp, #0x170
1020398b8: aa0203f4    	mov	x20, x2
1020398bc: f00db888    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1020398c0: f9451908    	ldr	x8, [x8, #0xa30]
1020398c4: f9400108    	ldr	x8, [x8]
1020398c8: f81a03a8    	stur	x8, [x29, #-0x60]
1020398cc: d00eb868    	adrp	x8, 0x11f747000 <dyld_stub_binder+0x11f747000>
1020398d0: 52800029    	mov	w9, #0x1                ; =1
1020398d4: 39163109    	strb	w9, [x8, #0x58c]
1020398d8: aa0203e0    	mov	x0, x2
1020398dc: 956fb8e6    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1020398e0: b00e66c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1020398e4: f943c100    	ldr	x0, [x8, #0x780]
1020398e8: 900e4c88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1020398ec: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1020398f0: 956fb8dd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020398f4: aa1d03fd    	mov	x29, x29
1020398f8: 956fb8e2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020398fc: aa0003f3    	mov	x19, x0
102039900: b00e66c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102039904: f945f500    	ldr	x0, [x8, #0xbe8]
102039908: b00e6368    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10203990c: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
102039910: 956fb8d5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039914: aa0003e2    	mov	x2, x0
102039918: 900e4c88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203991c: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
102039920: aa1303e0    	mov	x0, x19
102039924: 956fb8d0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039928: aa1d03fd    	mov	x29, x29
10203992c: 956fb8d5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102039930: aa0003f8    	mov	x24, x0
102039934: aa1303e0    	mov	x0, x19
102039938: 956fb8ce    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203993c: f00e4c88    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
102039940: f940a916    	ldr	x22, [x8, #0x150] ; selector: getContactByName:
102039944: aa1803e0    	mov	x0, x24
102039948: aa1603e1    	mov	x1, x22
10203994c: aa1403e2    	mov	x2, x20
102039950: 956fb8c5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039954: aa1d03fd    	mov	x29, x29
102039958: 956fb8ca    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203995c: aa0003f5    	mov	x21, x0
102039960: b4001160    	cbz	x0, 0x102039b8c <_Flutter_Image_provideRelativePathByUrl+0x2c2018>
102039964: b00e4dc8    	adrp	x8, 0x11e9f2000 <dyld_stub_binder+0x11e9f2000>
102039968: f9460d01    	ldr	x1, [x8, #0xc18] ; selector: tryLoadExtInfoForContact:
10203996c: aa1803e0    	mov	x0, x24
102039970: aa1503e2    	mov	x2, x21
102039974: 956fb8bc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039978: d00e4c88    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10203997c: f947d501    	ldr	x1, [x8, #0xfa8] ; selector: isChatroom
102039980: aa1503e0    	mov	x0, x21
102039984: 956fb8b8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039988: 36001240    	tbz	w0, #0x0, 0x102039bd0 <_Flutter_Image_provideRelativePathByUrl+0x2c205c>
10203998c: f00e4e68    	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
102039990: f943e901    	ldr	x1, [x8, #0x7d0] ; selector: m_nsChatRoomMemList
102039994: aa1503e0    	mov	x0, x21
102039998: 956fb8b3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203999c: aa1d03fd    	mov	x29, x29
1020399a0: 956fb8b8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020399a4: aa0003f3    	mov	x19, x0
1020399a8: b00e6368    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1020399ac: f9433d01    	ldr	x1, [x8, #0x678] ; selector: componentsSeparatedByString:
1020399b0: d00d7b42    	adrp	x2, 0x11cfa3000 <dyld_stub_binder+0x11cfa3000>
1020399b4: 913be042    	add	x2, x2, #0xef8 ; CFString: ;
1020399b8: 956fb8ab    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020399bc: aa1d03fd    	mov	x29, x29
1020399c0: 956fb8b0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020399c4: aa0003f9    	mov	x25, x0
1020399c8: aa1303e0    	mov	x0, x19
1020399cc: 956fb8a9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020399d0: b4001279    	cbz	x25, 0x102039c1c <_Flutter_Image_provideRelativePathByUrl+0x2c20a8>
1020399d4: b00e6368    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1020399d8: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
1020399dc: aa1903e0    	mov	x0, x25
1020399e0: 956fb8a1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020399e4: b40011c0    	cbz	x0, 0x102039c1c <_Flutter_Image_provideRelativePathByUrl+0x2c20a8>
1020399e8: a901d3f5    	stp	x21, x20, [sp, #0x18]
1020399ec: b00e66c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1020399f0: f9432d00    	ldr	x0, [x8, #0x658]
1020399f4: 956fb886    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
1020399f8: f90023e0    	str	x0, [sp, #0x40]
1020399fc: 4f00e400    	movi.16b	v0, #0x0
102039a00: ad0283e0    	stp	q0, q0, [sp, #0x50]
102039a04: ad0383e0    	stp	q0, q0, [sp, #0x70]
102039a08: aa1903e0    	mov	x0, x25
102039a0c: 956fb89a    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102039a10: b00e6368    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
102039a14: f9442d01    	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
102039a18: 910143e2    	add	x2, sp, #0x50
102039a1c: 910243e3    	add	x3, sp, #0x90
102039a20: f90017e1    	str	x1, [sp, #0x28]
102039a24: 52800204    	mov	w4, #0x10               ; =16
102039a28: 956fb88f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039a2c: b4000a80    	cbz	x0, 0x102039b7c <_Flutter_Image_provideRelativePathByUrl+0x2c2008>
102039a30: aa0003fa    	mov	x26, x0
102039a34: f94033e8    	ldr	x8, [sp, #0x60]
102039a38: f940011b    	ldr	x27, [x8]
102039a3c: d280001c    	mov	x28, #0x0               ; =0
102039a40: f00e6368    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
102039a44: f9467515    	ldr	x21, [x8, #0xce8] ; selector: length
102039a48: b00e4c88    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
102039a4c: f942c108    	ldr	x8, [x8, #0x580] ; selector: safeAddObject:
102039a50: f90027e8    	str	x8, [sp, #0x48]
102039a54: f00e4c88    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
102039a58: f947dd09    	ldr	x9, [x8, #0xfb8] ; selector: generatePrivacyString:
102039a5c: 900e4c88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102039a60: f9418908    	ldr	x8, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
102039a64: a90327e8    	stp	x8, x9, [sp, #0x30]
102039a68: f94033e8    	ldr	x8, [sp, #0x60]
102039a6c: f9400108    	ldr	x8, [x8]
102039a70: eb1b011f    	cmp	x8, x27
102039a74: 54000060    	b.eq	0x102039a80 <_Flutter_Image_provideRelativePathByUrl+0x2c1f0c>
102039a78: aa1903e0    	mov	x0, x25
102039a7c: 956fb870    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
102039a80: f9402fe8    	ldr	x8, [sp, #0x58]
102039a84: f87c7914    	ldr	x20, [x8, x28, lsl #3]
102039a88: b4000654    	cbz	x20, 0x102039b50 <_Flutter_Image_provideRelativePathByUrl+0x2c1fdc>
102039a8c: aa1403e0    	mov	x0, x20
102039a90: aa1503e1    	mov	x1, x21
102039a94: 956fb874    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039a98: b40005c0    	cbz	x0, 0x102039b50 <_Flutter_Image_provideRelativePathByUrl+0x2c1fdc>
102039a9c: aa1803e0    	mov	x0, x24
102039aa0: aa1603e1    	mov	x1, x22
102039aa4: aa1403e2    	mov	x2, x20
102039aa8: 956fb86f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039aac: aa1d03fd    	mov	x29, x29
102039ab0: 956fb874    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102039ab4: aa0003f3    	mov	x19, x0
102039ab8: b40000a0    	cbz	x0, 0x102039acc <_Flutter_Image_provideRelativePathByUrl+0x2c1f58>
102039abc: a94407e0    	ldp	x0, x1, [sp, #0x40]
102039ac0: aa1303e2    	mov	x2, x19
102039ac4: 956fb868    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039ac8: 14000020    	b	0x102039b48 <_Flutter_Image_provideRelativePathByUrl+0x2c1fd4>
102039acc: aa1603f7    	mov	x23, x22
102039ad0: aa1803f6    	mov	x22, x24
102039ad4: b00e66c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102039ad8: f9430d18    	ldr	x24, [x8, #0x618]
102039adc: b00e66c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102039ae0: f9431d00    	ldr	x0, [x8, #0x638]
102039ae4: f9401fe1    	ldr	x1, [sp, #0x38]
102039ae8: aa1403e2    	mov	x2, x20
102039aec: 956fb85e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039af0: aa1d03fd    	mov	x29, x29
102039af4: 956fb863    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102039af8: aa0003f4    	mov	x20, x0
102039afc: b00d8608    	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
102039b00: 9120e108    	add	x8, x8, #0x838 ; CFString: member %@ not in db
102039b04: a90003e8    	stp	x8, x0, [sp]
102039b08: aa1803e0    	mov	x0, x24
102039b0c: aa1603f8    	mov	x24, x22
102039b10: aa1703f6    	mov	x22, x23
102039b14: f9401be1    	ldr	x1, [sp, #0x30]
102039b18: 52800042    	mov	w2, #0x2                ; =2
102039b1c: d00be2c3    	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
102039b20: 91160863    	add	x3, x3, #0x582
102039b24: 52800004    	mov	w4, #0x0                ; =0
102039b28: 900bef05    	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
102039b2c: 910928a5    	add	x5, x5, #0x24a
102039b30: 52804806    	mov	w6, #0x240              ; =576
102039b34: 900bef07    	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
102039b38: 911730e7    	add	x7, x7, #0x5cc
102039b3c: 956fb84a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039b40: aa1403e0    	mov	x0, x20
102039b44: 956fb84b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039b48: aa1303e0    	mov	x0, x19
102039b4c: 956fb849    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039b50: 9100079c    	add	x28, x28, #0x1
102039b54: eb1c035f    	cmp	x26, x28
102039b58: 54fff881    	b.ne	0x102039a68 <_Flutter_Image_provideRelativePathByUrl+0x2c1ef4>
102039b5c: 910143e2    	add	x2, sp, #0x50
102039b60: 910243e3    	add	x3, sp, #0x90
102039b64: aa1903e0    	mov	x0, x25
102039b68: f94017e1    	ldr	x1, [sp, #0x28]
102039b6c: 52800204    	mov	w4, #0x10               ; =16
102039b70: 956fb83d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039b74: aa0003fa    	mov	x26, x0
102039b78: b5fff620    	cbnz	x0, 0x102039a3c <_Flutter_Image_provideRelativePathByUrl+0x2c1ec8>
102039b7c: aa1903e0    	mov	x0, x25
102039b80: 956fb83c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039b84: a941d3f5    	ldp	x21, x20, [sp, #0x18]
102039b88: 14000037    	b	0x102039c64 <_Flutter_Image_provideRelativePathByUrl+0x2c20f0>
102039b8c: b00e66c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102039b90: f9430d00    	ldr	x0, [x8, #0x618]
102039b94: 900e4c88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102039b98: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
102039b9c: d00d80a8    	adrp	x8, 0x11d04f000 <dyld_stub_binder+0x11d04f000>
102039ba0: 913f6108    	add	x8, x8, #0xfd8 ; CFString: get chat room contact nil %@
102039ba4: a90053e8    	stp	x8, x20, [sp]
102039ba8: d00be2c3    	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
102039bac: 91160863    	add	x3, x3, #0x582
102039bb0: 900bef05    	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
102039bb4: 910928a5    	add	x5, x5, #0x24a
102039bb8: 900bef07    	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
102039bbc: 911730e7    	add	x7, x7, #0x5cc
102039bc0: 52800042    	mov	w2, #0x2                ; =2
102039bc4: 52800004    	mov	w4, #0x0                ; =0
102039bc8: 52804466    	mov	w6, #0x223              ; =547
102039bcc: 14000011    	b	0x102039c10 <_Flutter_Image_provideRelativePathByUrl+0x2c209c>
102039bd0: b00e66c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102039bd4: f9430d00    	ldr	x0, [x8, #0x618]
102039bd8: 900e4c88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102039bdc: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
102039be0: b00d8608    	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
102039be4: 911ee108    	add	x8, x8, #0x7b8 ; CFString: return nil because [oGroupContact isChatroom] == NO, groupName: %@
102039be8: a90053e8    	stp	x8, x20, [sp]
102039bec: d00be2c3    	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
102039bf0: 91160863    	add	x3, x3, #0x582
102039bf4: 900bef05    	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
102039bf8: 910928a5    	add	x5, x5, #0x24a
102039bfc: 900bef07    	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
102039c00: 911730e7    	add	x7, x7, #0x5cc
102039c04: 52800042    	mov	w2, #0x2                ; =2
102039c08: 52800004    	mov	w4, #0x0                ; =0
102039c0c: 52804546    	mov	w6, #0x22a              ; =554
102039c10: 956fb815    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039c14: f90023ff    	str	xzr, [sp, #0x40]
102039c18: 14000015    	b	0x102039c6c <_Flutter_Image_provideRelativePathByUrl+0x2c20f8>
102039c1c: b00e66c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102039c20: f9430d00    	ldr	x0, [x8, #0x618]
102039c24: 900e4c88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102039c28: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
102039c2c: d00d80a8    	adrp	x8, 0x11d04f000 <dyld_stub_binder+0x11d04f000>
102039c30: 913fe108    	add	x8, x8, #0xff8 ; CFString: memlist is nil %@
102039c34: a90053e8    	stp	x8, x20, [sp]
102039c38: d00be2c3    	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
102039c3c: 91160863    	add	x3, x3, #0x582
102039c40: 900bef05    	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
102039c44: 910928a5    	add	x5, x5, #0x24a
102039c48: 900bef07    	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
102039c4c: 911730e7    	add	x7, x7, #0x5cc
102039c50: 52800042    	mov	w2, #0x2                ; =2
102039c54: 52800004    	mov	w4, #0x0                ; =0
102039c58: 52804606    	mov	w6, #0x230              ; =560
102039c5c: 956fb802    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039c60: f90023ff    	str	xzr, [sp, #0x40]
102039c64: aa1903e0    	mov	x0, x25
102039c68: 956fb802    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039c6c: aa1503e0    	mov	x0, x21
102039c70: 956fb800    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039c74: aa1803e0    	mov	x0, x24
102039c78: 956fb7fe    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039c7c: aa1403e0    	mov	x0, x20
102039c80: 956fb7fc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039c84: f85a03a8    	ldur	x8, [x29, #-0x60]
102039c88: f00db889    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
102039c8c: f9451929    	ldr	x9, [x9, #0xa30]
102039c90: f9400129    	ldr	x9, [x9]
102039c94: eb08013f    	cmp	x9, x8
102039c98: 54000141    	b.ne	0x102039cc0 <_Flutter_Image_provideRelativePathByUrl+0x2c214c>
102039c9c: f94023e0    	ldr	x0, [sp, #0x40]
102039ca0: a9577bfd    	ldp	x29, x30, [sp, #0x170]
102039ca4: a9564ff4    	ldp	x20, x19, [sp, #0x160]
102039ca8: a95557f6    	ldp	x22, x21, [sp, #0x150]
102039cac: a9545ff8    	ldp	x24, x23, [sp, #0x140]
102039cb0: a95367fa    	ldp	x26, x25, [sp, #0x130]
102039cb4: a9526ffc    	ldp	x28, x27, [sp, #0x120]
102039cb8: 910603ff    	add	sp, sp, #0x180
102039cbc: 156fb7d9    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
102039cc0: 956fb69c    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
