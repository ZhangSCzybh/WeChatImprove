
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
10292f248: d10283ff    	sub	sp, sp, #0xa0
10292f24c: a9065ff8    	stp	x24, x23, [sp, #0x60]
10292f250: a90757f6    	stp	x22, x21, [sp, #0x70]
10292f254: a9084ff4    	stp	x20, x19, [sp, #0x80]
10292f258: a9097bfd    	stp	x29, x30, [sp, #0x90]
10292f25c: 910243fd    	add	x29, sp, #0x90
10292f260: aa0303f3    	mov	x19, x3
10292f264: aa0203f4    	mov	x20, x2
10292f268: aa0003f5    	mov	x21, x0
10292f26c: f00f1828    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
10292f270: 52800029    	mov	w9, #0x1                ; =1
10292f274: 392b8909    	strb	w9, [x8, #0xae2]
10292f278: 900ec228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10292f27c: f9453516    	ldr	x22, [x8, #0xa68] ; class=iConsole
10292f280: 900ec238    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
10292f284: f9458b00    	ldr	x0, [x24, #0xb10]
10292f288: b00ebea8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10292f28c: f947bd01    	ldr	x1, [x8, #0xf78] ; selector=numberWithUnsignedInt:
10292f290: 954bdfab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10292f294: aa1d03fd    	mov	x29, x29
10292f298: 954bdfac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10292f29c: aa0003f7    	mov	x23, x0
10292f2a0: f9458b00    	ldr	x0, [x24, #0xb10]
10292f2a4: b00ebea8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10292f2a8: f947c901    	ldr	x1, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
10292f2ac: aa1303e2    	mov	x2, x19
10292f2b0: 954bdfa3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10292f2b4: aa1d03fd    	mov	x29, x29
10292f2b8: 954bdfa4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10292f2bc: aa0003f8    	mov	x24, x0
10292f2c0: d00ea848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10292f2c4: f942a901    	ldr	x1, [x8, #0x550] ; selector=logWithLevel:module:errorCode:file:line:func:format:
10292f2c8: a90083f7    	stp	x23, x0, [sp, #0x8]
10292f2cc: 900de9c8    	adrp	x8, 0x11e667000 <dyld_stub_binder+0x11e667000>
10292f2d0: 911a2108    	add	x8, x8, #0x688 ; cfstring='Prepare to hangup ... (%@, %@)'
10292f2d4: f90003e8    	str	x8, [sp]
10292f2d8: d00c5a83    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
10292f2dc: 91056463    	add	x3, x3, #0x159 ; cstring='MMConfSDK'
10292f2e0: d00c6205    	adrp	x5, 0x11b571000 <dyld_stub_binder+0x11b571000>
10292f2e4: 9139e8a5    	add	x5, x5, #0xe7a ; cstring='MMConfSDKService.mm'
10292f2e8: 900c6227    	adrp	x7, 0x11b573000 <dyld_stub_binder+0x11b573000>
10292f2ec: 91020ce7    	add	x7, x7, #0x83 ; cstring='-[MMConfSDKService hangup:roomID:]'
10292f2f0: aa1603e0    	mov	x0, x22
10292f2f4: 52800042    	mov	w2, #0x2                ; =2
10292f2f8: 52800004    	mov	w4, #0x0                ; =0
10292f2fc: 52815266    	mov	w6, #0xa93              ; =2707
10292f300: 954bdf8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10292f304: aa1803e0    	mov	x0, x24
10292f308: 954bdf93    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10292f30c: aa1703e0    	mov	x0, x23
10292f310: 954bdf91    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10292f314: d100e3a0    	sub	x0, x29, #0x38
10292f318: aa1503e1    	mov	x1, x21
10292f31c: 954bdf94    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
10292f320: d00ec688    	adrp	x8, 0x120201000 <dyld_stub_binder+0x120201000>
10292f324: b98d0108    	ldrsw	x8, [x8, #0xd00]
10292f328: f8686ab5    	ldr	x21, [x21, x8]
10292f32c: f00d65e8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10292f330: f947e108    	ldr	x8, [x8, #0xfc0]
10292f334: f90013e8    	str	x8, [sp, #0x20]
10292f338: d00b2288    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10292f33c: fd41c100    	ldr	d0, [x8, #0x380]
10292f340: 90000008    	adrp	x8, 0x10292f000 <_Flutter_Image_provideRelativePathByUrl+0xd3beb0>
10292f344: 910e9108    	add	x8, x8, #0x3a4
10292f348: fd0017e0    	str	d0, [sp, #0x28]
10292f34c: f00d67a9    	adrp	x9, 0x11d626000 <dyld_stub_binder+0x11d626000>
10292f350: 913f0129    	add	x9, x9, #0xfc0
10292f354: a90327e8    	stp	x8, x9, [sp, #0x30]
10292f358: 910083f6    	add	x22, sp, #0x20
10292f35c: 910082c0    	add	x0, x22, #0x20
10292f360: d100e3a1    	sub	x1, x29, #0x38
10292f364: 954bdf85    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
10292f368: b90053f4    	str	w20, [sp, #0x50]
10292f36c: f90027f3    	str	x19, [sp, #0x48]
10292f370: 910083e1    	add	x1, sp, #0x20
10292f374: aa1503e0    	mov	x0, x21
10292f378: 954b77aa    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
10292f37c: 910082c0    	add	x0, x22, #0x20
10292f380: 954bdf84    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
10292f384: d100e3a0    	sub	x0, x29, #0x38
10292f388: 954bdf82    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
10292f38c: a9497bfd    	ldp	x29, x30, [sp, #0x90]
10292f390: a9484ff4    	ldp	x20, x19, [sp, #0x80]
10292f394: a94757f6    	ldp	x22, x21, [sp, #0x70]
10292f398: a9465ff8    	ldp	x24, x23, [sp, #0x60]
10292f39c: 910283ff    	add	sp, sp, #0xa0
10292f3a0: d65f03c0    	ret
