
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105f8a588: d10183ff    	sub	sp, sp, #0x60
105f8a58c: a90167fa    	stp	x26, x25, [sp, #0x10]
105f8a590: a9025ff8    	stp	x24, x23, [sp, #0x20]
105f8a594: a90357f6    	stp	x22, x21, [sp, #0x30]
105f8a598: a9044ff4    	stp	x20, x19, [sp, #0x40]
105f8a59c: a9057bfd    	stp	x29, x30, [sp, #0x50]
105f8a5a0: 910143fd    	add	x29, sp, #0x50
105f8a5a4: aa0403f4    	mov	x20, x4
105f8a5a8: aa0303f5    	mov	x21, x3
105f8a5ac: aa0203f3    	mov	x19, x2
105f8a5b0: b00d65c8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
105f8a5b4: 52800029    	mov	w9, #0x1                ; =1
105f8a5b8: 39053909    	strb	w9, [x8, #0x14e]
105f8a5bc: aa0203e0    	mov	x0, x2
105f8a5c0: 947272de    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105f8a5c4: 34000ed5    	cbz	w21, 0x105f8a79c <_Flutter_MMFoundation_BindContext+0x2466380>
105f8a5c8: b00d0fe8    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
105f8a5cc: f943a915    	ldr	x21, [x8, #0x750]
105f8a5d0: d00d0008    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
105f8a5d4: f944c901    	ldr	x1, [x8, #0x990] ; m_mode
105f8a5d8: aa1303e0    	mov	x0, x19
105f8a5dc: 947272d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a5e0: 7100001f    	cmp	w0, #0x0
105f8a5e4: 1a9f17e2    	cset	w2, eq
105f8a5e8: f00d0048    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
105f8a5ec: f9407901    	ldr	x1, [x8, #0xf0] ; getIfCanUseCX:isMultiTalk:
105f8a5f0: aa1503e0    	mov	x0, x21
105f8a5f4: 52800003    	mov	w3, #0x0                ; =0
105f8a5f8: 947272d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a5fc: 34000d00    	cbz	w0, 0x105f8a79c <_Flutter_MMFoundation_BindContext+0x2466380>
105f8a600: 52800040    	mov	w0, #0x2                ; =2
105f8a604: 94720b0f    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f8a608: 34000560    	cbz	w0, 0x105f8a6b4 <_Flutter_MMFoundation_BindContext+0x2466298>
105f8a60c: 947272e5    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f8a610: aa0003f5    	mov	x21, x0
105f8a614: b00d0f57    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
105f8a618: f94546e0    	ldr	x0, [x23, #0xa88]
105f8a61c: 947272d1    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f8a620: aa0003f6    	mov	x22, x0
105f8a624: f94546e0    	ldr	x0, [x23, #0xa88]
105f8a628: 900d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f8a62c: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f8a630: f90003ff    	str	xzr, [sp]
105f8a634: b00c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f8a638: 911f2042    	add	x2, x2, #0x7c8
105f8a63c: 947272c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a640: aa1d03fd    	mov	x29, x29
105f8a644: 947272c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a648: aa0003f7    	mov	x23, x0
105f8a64c: 900d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f8a650: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f8a654: b00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f8a658: 91352108    	add	x8, x8, #0xd48
105f8a65c: a90003e8    	stp	x8, x0, [sp]
105f8a660: b00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f8a664: 9134a042    	add	x2, x2, #0xd28
105f8a668: aa1603e0    	mov	x0, x22
105f8a66c: 947272b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a670: aa0003f6    	mov	x22, x0
105f8a674: aa1703e0    	mov	x0, x23
105f8a678: 947272b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a67c: 900acec1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f8a680: 9135a821    	add	x1, x1, #0xd6a
105f8a684: 900acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f8a688: 9135dc42    	add	x2, x2, #0xd77
105f8a68c: d00acec4    	adrp	x4, 0x11b964000 <dyld_stub_binder+0x11b964000>
105f8a690: 9104ac84    	add	x4, x4, #0x12b
105f8a694: 52800040    	mov	w0, #0x2                ; =2
105f8a698: 5280c0a3    	mov	w3, #0x605              ; =1541
105f8a69c: aa1603e5    	mov	x5, x22
105f8a6a0: 94720ae9    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f8a6a4: aa1603e0    	mov	x0, x22
105f8a6a8: 947272ab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a6ac: aa1503e0    	mov	x0, x21
105f8a6b0: 947272bf    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f8a6b4: b00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f8a6b8: f945e900    	ldr	x0, [x8, #0xbd0]
105f8a6bc: d00d0ba8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105f8a6c0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105f8a6c4: 9472729e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a6c8: aa1d03fd    	mov	x29, x29
105f8a6cc: 9472729f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a6d0: aa0003f5    	mov	x21, x0
105f8a6d4: b00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f8a6d8: f9467d00    	ldr	x0, [x8, #0xcf8]
105f8a6dc: b00d0ba8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105f8a6e0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105f8a6e4: 94727296    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a6e8: aa0003e2    	mov	x2, x0
105f8a6ec: f00cf568    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105f8a6f0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
105f8a6f4: aa1503e0    	mov	x0, x21
105f8a6f8: 94727291    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a6fc: aa1d03fd    	mov	x29, x29
105f8a700: 94727292    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a704: aa0003f6    	mov	x22, x0
105f8a708: d00d0008    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
105f8a70c: f9450d01    	ldr	x1, [x8, #0xa18] ; m_roomId
105f8a710: aa1303e0    	mov	x0, x19
105f8a714: 9472728a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a718: aa0003f7    	mov	x23, x0
105f8a71c: d00d0008    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
105f8a720: f9451101    	ldr	x1, [x8, #0xa20] ; m_roomKey
105f8a724: aa1303e0    	mov	x0, x19
105f8a728: 94727285    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a72c: aa0003f8    	mov	x24, x0
105f8a730: b00cf5a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105f8a734: f9464d01    	ldr	x1, [x8, #0xc98] ; isVideo
105f8a738: aa1303e0    	mov	x0, x19
105f8a73c: 94727280    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a740: aa0003f9    	mov	x25, x0
105f8a744: d00d0008    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
105f8a748: f9450901    	ldr	x1, [x8, #0xa10] ; m_fromUser
105f8a74c: aa1303e0    	mov	x0, x19
105f8a750: 9472727b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a754: aa1d03fd    	mov	x29, x29
105f8a758: 9472727c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a75c: aa0003fa    	mov	x26, x0
105f8a760: 900d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8a764: f9426501    	ldr	x1, [x8, #0x4c8] ; acceptCallUseCallkit:roomKey:isVideo:userName:isilink:
105f8a768: aa1603e0    	mov	x0, x22
105f8a76c: aa1703e2    	mov	x2, x23
105f8a770: aa1803e3    	mov	x3, x24
105f8a774: aa1903e4    	mov	x4, x25
105f8a778: aa1a03e5    	mov	x5, x26
105f8a77c: aa1403e6    	mov	x6, x20
105f8a780: 9472726f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a784: aa1a03e0    	mov	x0, x26
105f8a788: 94727273    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a78c: aa1603e0    	mov	x0, x22
105f8a790: 94727271    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a794: aa1503e0    	mov	x0, x21
105f8a798: 9472726f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a79c: aa1303e0    	mov	x0, x19
105f8a7a0: 9472726d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a7a4: 52800020    	mov	w0, #0x1                ; =1
105f8a7a8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
105f8a7ac: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105f8a7b0: a94357f6    	ldp	x22, x21, [sp, #0x30]
105f8a7b4: a9425ff8    	ldp	x24, x23, [sp, #0x20]
105f8a7b8: a94167fa    	ldp	x26, x25, [sp, #0x10]
105f8a7bc: 910183ff    	add	sp, sp, #0x60
105f8a7c0: d65f03c0    	ret
