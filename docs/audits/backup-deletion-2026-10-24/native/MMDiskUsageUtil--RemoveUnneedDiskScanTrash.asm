
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029caf84: d107c3ff    	sub	sp, sp, #0x1f0
1029caf88: 6d1823e9    	stp	d9, d8, [sp, #0x180]
1029caf8c: a9196ffc    	stp	x28, x27, [sp, #0x190]
1029caf90: a91a67fa    	stp	x26, x25, [sp, #0x1a0]
1029caf94: a91b5ff8    	stp	x24, x23, [sp, #0x1b0]
1029caf98: a91c57f6    	stp	x22, x21, [sp, #0x1c0]
1029caf9c: a91d4ff4    	stp	x20, x19, [sp, #0x1d0]
1029cafa0: a91e7bfd    	stp	x29, x30, [sp, #0x1e0]
1029cafa4: 910783fd    	add	x29, sp, #0x1e0
1029cafa8: b00d6128    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1029cafac: f9405908    	ldr	x8, [x8, #0xb0]
1029cafb0: f9400108    	ldr	x8, [x8]
1029cafb4: f81903a8    	stur	x8, [x29, #-0x70]
1029cafb8: 900f1368    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029cafbc: 52800029    	mov	w9, #0x1                ; =1
1029cafc0: 39353509    	strb	w9, [x8, #0xd4d]
1029cafc4: 95497150    	bl	0x107c27504 <_Flutter_MMFoundation_BindContext+0x41030e8>
1029cafc8: aa1d03fd    	mov	x29, x29
1029cafcc: 9549705f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029cafd0: aa0003f3    	mov	x19, x0
1029cafd4: 900eba08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029cafd8: f9465117    	ldr	x23, [x8, #0xca0] ; stringByAppendingPathComponent:
1029cafdc: f00de562    	adrp	x2, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029cafe0: 91082042    	add	x2, x2, #0x208
1029cafe4: aa1703e1    	mov	x1, x23
1029cafe8: 95497055    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cafec: aa1d03fd    	mov	x29, x29
1029caff0: 95497056    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029caff4: aa0003f4    	mov	x20, x0
1029caff8: aa1303e0    	mov	x0, x19
1029caffc: 95497056    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029cb000: d00ebd48    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1029cb004: f9420900    	ldr	x0, [x8, #0x410]
1029cb008: b00eb9a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029cb00c: f946dd01    	ldr	x1, [x8, #0xdb8] ; defaultManager
1029cb010: 9549704b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb014: aa1d03fd    	mov	x29, x29
1029cb018: 9549704c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029cb01c: aa0003f5    	mov	x21, x0
1029cb020: f90077ff    	str	xzr, [sp, #0xe8]
1029cb024: b00eb9a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029cb028: f9428501    	ldr	x1, [x8, #0x508] ; contentsOfDirectoryAtPath:error:
1029cb02c: 9103a3e3    	add	x3, sp, #0xe8
1029cb030: f90037f4    	str	x20, [sp, #0x68]
1029cb034: aa1403e2    	mov	x2, x20
1029cb038: 95497041    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb03c: aa1d03fd    	mov	x29, x29
1029cb040: 95497042    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029cb044: aa0003f6    	mov	x22, x0
1029cb048: f94077f4    	ldr	x20, [sp, #0xe8]
1029cb04c: aa1403e0    	mov	x0, x20
1029cb050: 9549703a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029cb054: 900ebd53    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
1029cb058: f9453660    	ldr	x0, [x19, #0xa68]
1029cb05c: d00ea368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029cb060: f942a91a    	ldr	x26, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029cb064: d00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029cb068: 910ea108    	add	x8, x8, #0x3a8
1029cb06c: f90003e8    	str	x8, [sp]
1029cb070: b00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029cb074: 9125d063    	add	x3, x3, #0x974
1029cb078: 900c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029cb07c: 911554a5    	add	x5, x5, #0x555
1029cb080: 900c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029cb084: 9136f8e7    	add	x7, x7, #0xdbe
1029cb088: aa1a03e1    	mov	x1, x26
1029cb08c: 52800042    	mov	w2, #0x2                ; =2
1029cb090: 52800004    	mov	w4, #0x0                ; =0
1029cb094: 52804246    	mov	w6, #0x212              ; =530
1029cb098: 95497029    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb09c: b4000314    	cbz	x20, 0x1029cb0fc <_Flutter_Image_provideRelativePathByUrl+0xdd7fac>
1029cb0a0: f9453660    	ldr	x0, [x19, #0xa68]
1029cb0a4: d00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029cb0a8: 9110a108    	add	x8, x8, #0x428
1029cb0ac: a90053e8    	stp	x8, x20, [sp]
1029cb0b0: b00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029cb0b4: 9125d063    	add	x3, x3, #0x974
1029cb0b8: 900c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029cb0bc: 911554a5    	add	x5, x5, #0x555
1029cb0c0: 900c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029cb0c4: 9136f8e7    	add	x7, x7, #0xdbe
1029cb0c8: aa1a03e1    	mov	x1, x26
1029cb0cc: 52800082    	mov	w2, #0x4                ; =4
1029cb0d0: 52800004    	mov	w4, #0x0                ; =0
1029cb0d4: 528046c6    	mov	w6, #0x236              ; =566
1029cb0d8: 95497019    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb0dc: 52807c60    	mov	w0, #0x3e3              ; =995
1029cb0e0: 528005c1    	mov	w1, #0x2e               ; =46
1029cb0e4: 52800022    	mov	w2, #0x1                ; =1
1029cb0e8: 52800003    	mov	w3, #0x0                ; =0
1029cb0ec: 52800004    	mov	w4, #0x0                ; =0
1029cb0f0: 97d61423    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
1029cb0f4: 52800013    	mov	w19, #0x0               ; =0
1029cb0f8: 140000e5    	b	0x1029cb48c <_Flutter_Image_provideRelativePathByUrl+0xdd833c>
1029cb0fc: a903d7f4    	stp	x20, x21, [sp, #0x38]
1029cb100: 900ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029cb104: f9457100    	ldr	x0, [x8, #0xae0]
1029cb108: b00eb9a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029cb10c: f9460d01    	ldr	x1, [x8, #0xc18] ; date
1029cb110: f90017e1    	str	x1, [sp, #0x28]
1029cb114: 9549700a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb118: aa1d03fd    	mov	x29, x29
1029cb11c: 9549700b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029cb120: aa0003f3    	mov	x19, x0
1029cb124: 900eba08    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1029cb128: f940a901    	ldr	x1, [x8, #0x150] ; timeIntervalSince1970
1029cb12c: f90013e1    	str	x1, [sp, #0x20]
1029cb130: 95497003    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb134: 1e604008    	fmov	d8, d0
1029cb138: aa1303e0    	mov	x0, x19
1029cb13c: 95497006    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029cb140: 4f00e400    	movi.16b	v0, #0x0
1029cb144: ad0603e0    	stp	q0, q0, [sp, #0xc0]
1029cb148: ad0503e0    	stp	q0, q0, [sp, #0xa0]
1029cb14c: aa1603e0    	mov	x0, x22
1029cb150: 95496ffa    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029cb154: b00eb9a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029cb158: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1029cb15c: 910283e2    	add	x2, sp, #0xa0
1029cb160: 9103c3e3    	add	x3, sp, #0xf0
1029cb164: f9001be1    	str	x1, [sp, #0x30]
1029cb168: 52800204    	mov	w4, #0x10               ; =16
1029cb16c: 95496ff4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb170: f90033e0    	str	x0, [sp, #0x60]
1029cb174: b4000fa0    	cbz	x0, 0x1029cb368 <_Flutter_Image_provideRelativePathByUrl+0xdd8218>
1029cb178: d280001b    	mov	x27, #0x0               ; =0
1029cb17c: f9405be8    	ldr	x8, [sp, #0xb0]
1029cb180: f00eb989    	adrp	x9, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1029cb184: d00ea5ea    	adrp	x10, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1029cb188: d00ea36b    	adrp	x11, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029cb18c: f9400108    	ldr	x8, [x8]
1029cb190: a9055fe8    	stp	x8, x23, [sp, #0x50]
1029cb194: d2e7ea08    	mov	x8, #0x3f50000000000000 ; =4562146422526312448
1029cb198: 9e670109    	fmov	d9, x8
1029cb19c: f90027f6    	str	x22, [sp, #0x48]
1029cb1a0: 900ebd5c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
1029cb1a4: d2800018    	mov	x24, #0x0               ; =0
1029cb1a8: f944d934    	ldr	x20, [x9, #0x9b0] ; UTF8String
1029cb1ac: f945e155    	ldr	x21, [x10, #0xbc0] ; FolderSizeAtPath:
1029cb1b0: f946f173    	ldr	x19, [x11, #0xde0] ; RemoveFile:
1029cb1b4: aa1a03f7    	mov	x23, x26
1029cb1b8: f9405be8    	ldr	x8, [sp, #0xb0]
1029cb1bc: f9400108    	ldr	x8, [x8]
1029cb1c0: f9402be9    	ldr	x9, [sp, #0x50]
1029cb1c4: eb09011f    	cmp	x8, x9
1029cb1c8: 54000060    	b.eq	0x1029cb1d4 <_Flutter_Image_provideRelativePathByUrl+0xdd8084>
1029cb1cc: f94027e0    	ldr	x0, [sp, #0x48]
1029cb1d0: 95496fe0    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1029cb1d4: f94057e8    	ldr	x8, [sp, #0xa8]
1029cb1d8: f8787919    	ldr	x25, [x8, x24, lsl #3]
1029cb1dc: 95496ff1    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1029cb1e0: aa0003f6    	mov	x22, x0
1029cb1e4: f94037e0    	ldr	x0, [sp, #0x68]
1029cb1e8: f9402fe1    	ldr	x1, [sp, #0x58]
1029cb1ec: aa1903e2    	mov	x2, x25
1029cb1f0: 95496fd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb1f4: aa1d03fd    	mov	x29, x29
1029cb1f8: 95496fd4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029cb1fc: aa0003f9    	mov	x25, x0
1029cb200: f946379a    	ldr	x26, [x28, #0xc68]
1029cb204: 95496fe9    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
1029cb208: aa1403e1    	mov	x1, x20
1029cb20c: 95496fcc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb210: aa0003e2    	mov	x2, x0
1029cb214: aa1a03e0    	mov	x0, x26
1029cb218: aa1503e1    	mov	x1, x21
1029cb21c: 95496fc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb220: 9e230000    	ucvtf	s0, x0
1029cb224: 1e22c000    	fcvt	d0, s0
1029cb228: 1e690800    	fmul	d0, d0, d9
1029cb22c: 1e690800    	fmul	d0, d0, d9
1029cb230: 9e79001a    	fcvtzu	x26, d0
1029cb234: f9463780    	ldr	x0, [x28, #0xc68]
1029cb238: aa1303e1    	mov	x1, x19
1029cb23c: aa1903e2    	mov	x2, x25
1029cb240: 95496fbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb244: 34000520    	cbz	w0, 0x1029cb2e8 <_Flutter_Image_provideRelativePathByUrl+0xdd8198>
1029cb248: 8b1a037b    	add	x27, x27, x26
1029cb24c: 900ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029cb250: f9453500    	ldr	x0, [x8, #0xa68]
1029cb254: a900ebf9    	stp	x25, x26, [sp, #0x8]
1029cb258: d00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029cb25c: 910f2108    	add	x8, x8, #0x3c8
1029cb260: f90003e8    	str	x8, [sp]
1029cb264: aa1703fa    	mov	x26, x23
1029cb268: aa1703e1    	mov	x1, x23
1029cb26c: 52800042    	mov	w2, #0x2                ; =2
1029cb270: b00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029cb274: 9125d063    	add	x3, x3, #0x974
1029cb278: 52800004    	mov	w4, #0x0                ; =0
1029cb27c: 900c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029cb280: 911554a5    	add	x5, x5, #0x555
1029cb284: 52804406    	mov	w6, #0x220              ; =544
1029cb288: 900c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029cb28c: 9136f8e7    	add	x7, x7, #0xdbe
1029cb290: 95496fab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb294: aa1903e0    	mov	x0, x25
1029cb298: 95496faf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029cb29c: aa1603e0    	mov	x0, x22
1029cb2a0: 95496fc3    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1029cb2a4: 91000718    	add	x24, x24, #0x1
1029cb2a8: f94033e8    	ldr	x8, [sp, #0x60]
1029cb2ac: eb18011f    	cmp	x8, x24
1029cb2b0: 54fff821    	b.ne	0x1029cb1b4 <_Flutter_Image_provideRelativePathByUrl+0xdd8064>
1029cb2b4: 910283e2    	add	x2, sp, #0xa0
1029cb2b8: 9103c3e3    	add	x3, sp, #0xf0
1029cb2bc: f94027f6    	ldr	x22, [sp, #0x48]
1029cb2c0: aa1603e0    	mov	x0, x22
1029cb2c4: f9401be1    	ldr	x1, [sp, #0x30]
1029cb2c8: 52800204    	mov	w4, #0x10               ; =16
1029cb2cc: 95496f9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb2d0: f00eb989    	adrp	x9, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1029cb2d4: d00ea5ea    	adrp	x10, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1029cb2d8: d00ea36b    	adrp	x11, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029cb2dc: f90033e0    	str	x0, [sp, #0x60]
1029cb2e0: b5fff620    	cbnz	x0, 0x1029cb1a4 <_Flutter_Image_provideRelativePathByUrl+0xdd8054>
1029cb2e4: 14000022    	b	0x1029cb36c <_Flutter_Image_provideRelativePathByUrl+0xdd821c>
1029cb2e8: 900ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029cb2ec: f9453500    	ldr	x0, [x8, #0xa68]
1029cb2f0: a900ebf9    	stp	x25, x26, [sp, #0x8]
1029cb2f4: d00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029cb2f8: 910fa108    	add	x8, x8, #0x3e8
1029cb2fc: f90003e8    	str	x8, [sp]
1029cb300: b00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029cb304: 9125d063    	add	x3, x3, #0x974
1029cb308: 900c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029cb30c: 911554a5    	add	x5, x5, #0x555
1029cb310: 900c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029cb314: 9136f8e7    	add	x7, x7, #0xdbe
1029cb318: aa1703e1    	mov	x1, x23
1029cb31c: 52800082    	mov	w2, #0x4                ; =4
1029cb320: 52800004    	mov	w4, #0x0                ; =0
1029cb324: 52804446    	mov	w6, #0x222              ; =546
1029cb328: 95496f85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb32c: 52807c60    	mov	w0, #0x3e3              ; =995
1029cb330: 528005a1    	mov	w1, #0x2d               ; =45
1029cb334: 52800022    	mov	w2, #0x1                ; =1
1029cb338: 52800003    	mov	w3, #0x0                ; =0
1029cb33c: 52800004    	mov	w4, #0x0                ; =0
1029cb340: 97d6138f    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
1029cb344: aa1903e0    	mov	x0, x25
1029cb348: 95496f83    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029cb34c: aa1603e0    	mov	x0, x22
1029cb350: 95496f97    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1029cb354: f94027f6    	ldr	x22, [sp, #0x48]
1029cb358: aa1603e0    	mov	x0, x22
1029cb35c: 95496f7e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029cb360: 52800013    	mov	w19, #0x0               ; =0
1029cb364: 14000049    	b	0x1029cb488 <_Flutter_Image_provideRelativePathByUrl+0xdd8338>
1029cb368: d280001b    	mov	x27, #0x0               ; =0
1029cb36c: aa1603e0    	mov	x0, x22
1029cb370: 95496f79    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029cb374: 900ebd88    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1029cb378: f9425500    	ldr	x0, [x8, #0x4a8]
1029cb37c: b00ea968    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029cb380: f9464101    	ldr	x1, [x8, #0xc80] ; recreatePathOfTrash
1029cb384: 95496f6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb388: 900ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029cb38c: f9457100    	ldr	x0, [x8, #0xae0]
1029cb390: f94017e1    	ldr	x1, [sp, #0x28]
1029cb394: 95496f6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb398: aa1d03fd    	mov	x29, x29
1029cb39c: 95496f6b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029cb3a0: aa0003f3    	mov	x19, x0
1029cb3a4: f94013e1    	ldr	x1, [sp, #0x20]
1029cb3a8: 95496f65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb3ac: 1e604009    	fmov	d9, d0
1029cb3b0: aa1303e0    	mov	x0, x19
1029cb3b4: 95496f68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029cb3b8: 1e683928    	fsub	d8, d9, d8
1029cb3bc: a908ffff    	stp	xzr, xzr, [sp, #0x88]
1029cb3c0: f9004fff    	str	xzr, [sp, #0x98]
1029cb3c4: d00b1de8    	adrp	x8, 0x118d89000 <dyld_stub_binder+0x118d89000>
1029cb3c8: 3dc3f100    	ldr	q0, [x8, #0xfc0]
1029cb3cc: 3d801fe0    	str	q0, [sp, #0x70]
1029cb3d0: 910223e0    	add	x0, sp, #0x88
1029cb3d4: 9101c3e1    	add	x1, sp, #0x70
1029cb3d8: 975b5314    	bl	0x1000a0028 <__text+0x98028>
1029cb3dc: d00b1de8    	adrp	x8, 0x118d89000 <dyld_stub_binder+0x118d89000>
1029cb3e0: fd47d500    	ldr	d0, [x8, #0xfa8]
1029cb3e4: fd003be0    	str	d0, [sp, #0x70]
1029cb3e8: 52800033    	mov	w19, #0x1               ; =1
1029cb3ec: 290f4ffb    	stp	w27, w19, [sp, #0x78]
1029cb3f0: 910223e0    	add	x0, sp, #0x88
1029cb3f4: 9101c3e1    	add	x1, sp, #0x70
1029cb3f8: 975b530c    	bl	0x1000a0028 <__text+0x98028>
1029cb3fc: 1e790108    	fcvtzu	w8, d8
1029cb400: d00b1de9    	adrp	x9, 0x118d89000 <dyld_stub_binder+0x118d89000>
1029cb404: fd47d920    	ldr	d0, [x9, #0xfb0]
1029cb408: fd003be0    	str	d0, [sp, #0x70]
1029cb40c: 290f4fe8    	stp	w8, w19, [sp, #0x78]
1029cb410: 910223e0    	add	x0, sp, #0x88
1029cb414: 9101c3e1    	add	x1, sp, #0x70
1029cb418: 975b5304    	bl	0x1000a0028 <__text+0x98028>
1029cb41c: 910223e0    	add	x0, sp, #0x88
1029cb420: 52800021    	mov	w1, #0x1                ; =1
1029cb424: 97d6137a    	bl	0x101f5020c <_Flutter_Image_provideRelativePathByUrl+0x35d0bc>
1029cb428: 900ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029cb42c: f9453500    	ldr	x0, [x8, #0xa68]
1029cb430: f9000bfb    	str	x27, [sp, #0x10]
1029cb434: fd0007e8    	str	d8, [sp, #0x8]
1029cb438: d00de568    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029cb43c: 91102108    	add	x8, x8, #0x408
1029cb440: f90003e8    	str	x8, [sp]
1029cb444: b00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029cb448: 9125d063    	add	x3, x3, #0x974
1029cb44c: 900c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029cb450: 911554a5    	add	x5, x5, #0x555
1029cb454: 900c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029cb458: 9136f8e7    	add	x7, x7, #0xdbe
1029cb45c: aa1a03e1    	mov	x1, x26
1029cb460: 52800042    	mov	w2, #0x2                ; =2
1029cb464: 52800004    	mov	w4, #0x0                ; =0
1029cb468: 52804686    	mov	w6, #0x234              ; =564
1029cb46c: 95496f34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029cb470: f94047e0    	ldr	x0, [sp, #0x88]
1029cb474: b40000a0    	cbz	x0, 0x1029cb488 <_Flutter_Image_provideRelativePathByUrl+0xdd8338>
1029cb478: f9004be0    	str	x0, [sp, #0x90]
1029cb47c: f9404fe8    	ldr	x8, [sp, #0x98]
1029cb480: cb000101    	sub	x1, x8, x0
1029cb484: 95496f52    	bl	0x107c271cc <_Flutter_MMFoundation_BindContext+0x4102db0>
1029cb488: a943d7f4    	ldp	x20, x21, [sp, #0x38]
1029cb48c: aa1603e0    	mov	x0, x22
1029cb490: 95496f31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029cb494: aa1403e0    	mov	x0, x20
1029cb498: 95496f2f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029cb49c: aa1503e0    	mov	x0, x21
1029cb4a0: 95496f2d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029cb4a4: f94037e0    	ldr	x0, [sp, #0x68]
1029cb4a8: 95496f2b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029cb4ac: f85903a8    	ldur	x8, [x29, #-0x70]
1029cb4b0: 900d6129    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1029cb4b4: f9405929    	ldr	x9, [x9, #0xb0]
1029cb4b8: f9400129    	ldr	x9, [x9]
1029cb4bc: eb08013f    	cmp	x9, x8
1029cb4c0: 54000161    	b.ne	0x1029cb4ec <_Flutter_Image_provideRelativePathByUrl+0xdd839c>
1029cb4c4: aa1303e0    	mov	x0, x19
1029cb4c8: a95e7bfd    	ldp	x29, x30, [sp, #0x1e0]
1029cb4cc: a95d4ff4    	ldp	x20, x19, [sp, #0x1d0]
1029cb4d0: a95c57f6    	ldp	x22, x21, [sp, #0x1c0]
1029cb4d4: a95b5ff8    	ldp	x24, x23, [sp, #0x1b0]
1029cb4d8: a95a67fa    	ldp	x26, x25, [sp, #0x1a0]
1029cb4dc: a9596ffc    	ldp	x28, x27, [sp, #0x190]
1029cb4e0: 6d5823e9    	ldp	d9, d8, [sp, #0x180]
1029cb4e4: 9107c3ff    	add	sp, sp, #0x1f0
1029cb4e8: d65f03c0    	ret
1029cb4ec: 95496f22    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
