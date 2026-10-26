
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029b3f10: d10543ff    	sub	sp, sp, #0x150
1029b3f14: 6d0e23e9    	stp	d9, d8, [sp, #0xe0]
1029b3f18: a90f6ffc    	stp	x28, x27, [sp, #0xf0]
1029b3f1c: a91067fa    	stp	x26, x25, [sp, #0x100]
1029b3f20: a9115ff8    	stp	x24, x23, [sp, #0x110]
1029b3f24: a91257f6    	stp	x22, x21, [sp, #0x120]
1029b3f28: a9134ff4    	stp	x20, x19, [sp, #0x130]
1029b3f2c: a9147bfd    	stp	x29, x30, [sp, #0x140]
1029b3f30: 910503fd    	add	x29, sp, #0x140
1029b3f34: aa0203f3    	mov	x19, x2
1029b3f38: aa0003f5    	mov	x21, x0
1029b3f3c: 900d61e8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1029b3f40: f9405908    	ldr	x8, [x8, #0xb0]
1029b3f44: f9400108    	ldr	x8, [x8]
1029b3f48: f81903a8    	stur	x8, [x29, #-0x70]
1029b3f4c: f00f1408    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029b3f50: 52800029    	mov	w9, #0x1                ; =1
1029b3f54: 39347509    	strb	w9, [x8, #0xd1d]
1029b3f58: 900ebe1a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
1029b3f5c: f9453740    	ldr	x0, [x26, #0xa68]
1029b3f60: d00ea428    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b3f64: f942a914    	ldr	x20, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029b3f68: f00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b3f6c: 9113a108    	add	x8, x8, #0x4e8
1029b3f70: f90003e8    	str	x8, [sp]
1029b3f74: b00c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b3f78: 9125d063    	add	x3, x3, #0x974
1029b3f7c: 900c5e85    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b3f80: 9134f8a5    	add	x5, x5, #0xd3e
1029b3f84: b00c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b3f88: 910894e7    	add	x7, x7, #0x225
1029b3f8c: aa1403e1    	mov	x1, x20
1029b3f90: 52800042    	mov	w2, #0x2                ; =2
1029b3f94: 52800004    	mov	w4, #0x0                ; =0
1029b3f98: 52803b06    	mov	w6, #0x1d8              ; =472
1029b3f9c: 9549cc68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3fa0: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3fa4: f943ed17    	ldr	x23, [x8, #0x7d8] ; scanner
1029b3fa8: aa1503e0    	mov	x0, x21
1029b3fac: aa1703e1    	mov	x1, x23
1029b3fb0: 9549cc63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3fb4: aa1d03fd    	mov	x29, x29
1029b3fb8: 9549cc64    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b3fbc: aa0003f6    	mov	x22, x0
1029b3fc0: 9549cc65    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b3fc4: b5000196    	cbnz	x22, 0x1029b3ff4 <_Flutter_Image_provideRelativePathByUrl+0xdc0ea4>
1029b3fc8: 900ebe48    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1029b3fcc: f9427d00    	ldr	x0, [x8, #0x4f8]
1029b3fd0: 9549cc62    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1029b3fd4: aa0003f6    	mov	x22, x0
1029b3fd8: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3fdc: f9444d01    	ldr	x1, [x8, #0x898] ; setScanner:
1029b3fe0: aa1503e0    	mov	x0, x21
1029b3fe4: aa1603e2    	mov	x2, x22
1029b3fe8: 9549cc55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3fec: aa1603e0    	mov	x0, x22
1029b3ff0: 9549cc59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b3ff4: aa1503e0    	mov	x0, x21
1029b3ff8: aa1703e1    	mov	x1, x23
1029b3ffc: 9549cc50    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4000: aa1d03fd    	mov	x29, x29
1029b4004: 9549cc51    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4008: aa0003f8    	mov	x24, x0
1029b400c: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4010: f9448501    	ldr	x1, [x8, #0x908] ; getLastWholeWechatScanTime
1029b4014: 9549cc4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4018: aa0003f6    	mov	x22, x0
1029b401c: aa1803e0    	mov	x0, x24
1029b4020: 9549cc4d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4024: f9453740    	ldr	x0, [x26, #0xa68]
1029b4028: d00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b402c: 91142108    	add	x8, x8, #0x508
1029b4030: a9005be8    	stp	x8, x22, [sp]
1029b4034: 900c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b4038: 9125d063    	add	x3, x3, #0x974
1029b403c: f00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b4040: 9134f8a5    	add	x5, x5, #0xd3e
1029b4044: 900c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b4048: 910894e7    	add	x7, x7, #0x225
1029b404c: aa1403e1    	mov	x1, x20
1029b4050: 52800042    	mov	w2, #0x2                ; =2
1029b4054: 52800004    	mov	w4, #0x0                ; =0
1029b4058: 52803be6    	mov	w6, #0x1df              ; =479
1029b405c: 9549cc38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4060: f00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b4064: f9457100    	ldr	x0, [x8, #0xae0]
1029b4068: 900eba68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029b406c: f9460d01    	ldr	x1, [x8, #0xc18] ; date
1029b4070: 9549cc33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4074: aa1d03fd    	mov	x29, x29
1029b4078: 9549cc34    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b407c: aa0003f8    	mov	x24, x0
1029b4080: f00ebaa8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1029b4084: f940a901    	ldr	x1, [x8, #0x150] ; timeIntervalSince1970
1029b4088: 9549cc2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b408c: 1e604008    	fmov	d8, d0
1029b4090: aa1803e0    	mov	x0, x24
1029b4094: 9549cc30    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4098: aa1503e0    	mov	x0, x21
1029b409c: aa1703e1    	mov	x1, x23
1029b40a0: 9549cc27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b40a4: aa1d03fd    	mov	x29, x29
1029b40a8: 9549cc28    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b40ac: b4000400    	cbz	x0, 0x1029b412c <_Flutter_Image_provideRelativePathByUrl+0xdc0fdc>
1029b40b0: aa0003f8    	mov	x24, x0
1029b40b4: aa1503e0    	mov	x0, x21
1029b40b8: aa1703e1    	mov	x1, x23
1029b40bc: 9549cc20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b40c0: aa1d03fd    	mov	x29, x29
1029b40c4: 9549cc21    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b40c8: aa0003f7    	mov	x23, x0
1029b40cc: f00eba68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029b40d0: f944ed01    	ldr	x1, [x8, #0x9d8] ; isRunning
1029b40d4: 9549cc1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b40d8: aa0003f9    	mov	x25, x0
1029b40dc: aa1703e0    	mov	x0, x23
1029b40e0: 9549cc1d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b40e4: aa1803e0    	mov	x0, x24
1029b40e8: 9549cc1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b40ec: 34000219    	cbz	w25, 0x1029b412c <_Flutter_Image_provideRelativePathByUrl+0xdc0fdc>
1029b40f0: f9453740    	ldr	x0, [x26, #0xa68]
1029b40f4: d00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b40f8: 9114a108    	add	x8, x8, #0x528
1029b40fc: f90003e8    	str	x8, [sp]
1029b4100: 900c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b4104: 9125d063    	add	x3, x3, #0x974
1029b4108: f00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b410c: 9134f8a5    	add	x5, x5, #0xd3e
1029b4110: 900c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b4114: 910894e7    	add	x7, x7, #0x225
1029b4118: aa1403e1    	mov	x1, x20
1029b411c: 52800042    	mov	w2, #0x2                ; =2
1029b4120: 52800004    	mov	w4, #0x0                ; =0
1029b4124: 52803c66    	mov	w6, #0x1e3              ; =483
1029b4128: 140000c0    	b	0x1029b4428 <_Flutter_Image_provideRelativePathByUrl+0xdc12d8>
1029b412c: b90017f3    	str	w19, [sp, #0x14]
1029b4130: 9e790108    	fcvtzu	x8, d8
1029b4134: cb160113    	sub	x19, x8, x22
1029b4138: f9453740    	ldr	x0, [x26, #0xa68]
1029b413c: d00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b4140: 91152108    	add	x8, x8, #0x548
1029b4144: a9004fe8    	stp	x8, x19, [sp]
1029b4148: 900c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b414c: 9125d063    	add	x3, x3, #0x974
1029b4150: f00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b4154: 9134f8a5    	add	x5, x5, #0xd3e
1029b4158: 900c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b415c: 910894e7    	add	x7, x7, #0x225
1029b4160: aa1403e1    	mov	x1, x20
1029b4164: 52800042    	mov	w2, #0x2                ; =2
1029b4168: 52800004    	mov	w4, #0x0                ; =0
1029b416c: 52803d06    	mov	w6, #0x1e8              ; =488
1029b4170: 9549cbf3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4174: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4178: f9444101    	ldr	x1, [x8, #0x880] ; configHandler
1029b417c: aa1503e0    	mov	x0, x21
1029b4180: 9549cbef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4184: aa1d03fd    	mov	x29, x29
1029b4188: 9549cbf0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b418c: aa0003f8    	mov	x24, x0
1029b4190: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4194: f9448901    	ldr	x1, [x8, #0x910] ; m_timeIntervalWholeScan
1029b4198: 9549cbe9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b419c: aa0003f7    	mov	x23, x0
1029b41a0: aa1803e0    	mov	x0, x24
1029b41a4: 9549cbec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b41a8: f00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b41ac: f945e900    	ldr	x0, [x8, #0xbd0]
1029b41b0: 900eba68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029b41b4: f944e918    	ldr	x24, [x8, #0x9d0] ; currentContext
1029b41b8: aa1803e1    	mov	x1, x24
1029b41bc: 9549cbe0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b41c0: aa1d03fd    	mov	x29, x29
1029b41c4: 9549cbe1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b41c8: aa0003fb    	mov	x27, x0
1029b41cc: f00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b41d0: f9467100    	ldr	x0, [x8, #0xce0]
1029b41d4: f00eba48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1029b41d8: f947ad19    	ldr	x25, [x8, #0xf58] ; class
1029b41dc: aa1903e1    	mov	x1, x25
1029b41e0: 9549cbd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b41e4: aa0003e2    	mov	x2, x0
1029b41e8: b00ea428    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b41ec: f946411a    	ldr	x26, [x8, #0xc80] ; getService:
1029b41f0: aa1b03e0    	mov	x0, x27
1029b41f4: aa1a03e1    	mov	x1, x26
1029b41f8: 9549cbd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b41fc: aa1d03fd    	mov	x29, x29
1029b4200: 9549cbd2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4204: aa0003fc    	mov	x28, x0
1029b4208: d00ea428    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1029b420c: f9404101    	ldr	x1, [x8, #0x80] ; getExpt:withBoolDef:
1029b4210: d00de602    	adrp	x2, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b4214: 9115a042    	add	x2, x2, #0x568
1029b4218: 52800003    	mov	w3, #0x0                ; =0
1029b421c: 9549cbc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4220: f9000ff4    	str	x20, [sp, #0x18]
1029b4224: aa0003f4    	mov	x20, x0
1029b4228: aa1c03e0    	mov	x0, x28
1029b422c: 9549cbca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4230: aa1b03e0    	mov	x0, x27
1029b4234: 9549cbc8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4238: 34000cf4    	cbz	w20, 0x1029b43d4 <_Flutter_Image_provideRelativePathByUrl+0xdc1284>
1029b423c: d2800000    	mov	x0, #0x0                ; =0
1029b4240: 9549cc49    	bl	0x107c27364 <_Flutter_MMFoundation_BindContext+0x4102f48>
1029b4244: aa0003f5    	mov	x21, x0
1029b4248: d00d61d3    	adrp	x19, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1029b424c: f947e273    	ldr	x19, [x19, #0xfc0]
1029b4250: f90047f3    	str	x19, [sp, #0x88]
1029b4254: b00b1e68    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1029b4258: fd41c108    	ldr	d8, [x8, #0x380]
1029b425c: 90000008    	adrp	x8, 0x1029b4000 <_Flutter_Image_provideRelativePathByUrl+0xdc0eb0>
1029b4260: 91155108    	add	x8, x8, #0x554
1029b4264: fd004be8    	str	d8, [sp, #0x90]
1029b4268: 900d6429    	adrp	x9, 0x11d638000 <dyld_stub_binder+0x11d638000>
1029b426c: 91002129    	add	x9, x9, #0x8
1029b4270: a909a7e8    	stp	x8, x9, [sp, #0x98]
1029b4274: b94017e8    	ldr	w8, [sp, #0x14]
1029b4278: 3902d3e8    	strb	w8, [sp, #0xb4]
1029b427c: 9549cbaf    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029b4280: f90057e0    	str	x0, [sp, #0xa8]
1029b4284: b900b3f7    	str	w23, [sp, #0xb0]
1029b4288: 910223e0    	add	x0, sp, #0x88
1029b428c: 9549cbc6    	bl	0x107c271a4 <_Flutter_MMFoundation_BindContext+0x4102d88>
1029b4290: aa0003f4    	mov	x20, x0
1029b4294: 8b3742d6    	add	x22, x22, w23, uxtw
1029b4298: f90043f6    	str	x22, [sp, #0x80]
1029b429c: f00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b42a0: f945e900    	ldr	x0, [x8, #0xbd0]
1029b42a4: aa1803e1    	mov	x1, x24
1029b42a8: 9549cba5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b42ac: aa1d03fd    	mov	x29, x29
1029b42b0: 9549cba6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b42b4: aa0003f7    	mov	x23, x0
1029b42b8: f00ebe88    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1029b42bc: f9458900    	ldr	x0, [x8, #0xb10]
1029b42c0: aa1903e1    	mov	x1, x25
1029b42c4: 9549cb9e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b42c8: aa0003e2    	mov	x2, x0
1029b42cc: aa1703e0    	mov	x0, x23
1029b42d0: aa1a03e1    	mov	x1, x26
1029b42d4: 9549cb9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b42d8: aa1d03fd    	mov	x29, x29
1029b42dc: 9549cb9b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b42e0: aa0003f8    	mov	x24, x0
1029b42e4: f9002ff3    	str	x19, [sp, #0x58]
1029b42e8: 90000008    	adrp	x8, 0x1029b4000 <_Flutter_Image_provideRelativePathByUrl+0xdc0eb0>
1029b42ec: 911bd108    	add	x8, x8, #0x6f4
1029b42f0: d00d6209    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1029b42f4: 9115c129    	add	x9, x9, #0x570
1029b42f8: fd0033e8    	str	d8, [sp, #0x60]
1029b42fc: a906a7e8    	stp	x8, x9, [sp, #0x68]
1029b4300: f9003ff5    	str	x21, [sp, #0x78]
1029b4304: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4308: f9449119    	ldr	x25, [x8, #0x920] ; registerTaskWithName:priority:earliestStart:launchBlock:cancelBlock:
1029b430c: aa1503e0    	mov	x0, x21
1029b4310: 9549cb8a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029b4314: d00de602    	adrp	x2, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b4318: 91162042    	add	x2, x2, #0x588
1029b431c: 910163e6    	add	x6, sp, #0x58
1029b4320: aa1803e0    	mov	x0, x24
1029b4324: aa1903e1    	mov	x1, x25
1029b4328: 52800023    	mov	w3, #0x1                ; =1
1029b432c: aa1603e4    	mov	x4, x22
1029b4330: aa1403e5    	mov	x5, x20
1029b4334: 9549cb82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4338: aa1803e0    	mov	x0, x24
1029b433c: 9549cb86    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4340: aa1703e0    	mov	x0, x23
1029b4344: 9549cb84    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4348: 910203e0    	add	x0, sp, #0x80
1029b434c: 910083e1    	add	x1, sp, #0x20
1029b4350: 9549ce84    	bl	0x107c27d60 <_Flutter_MMFoundation_BindContext+0x4103944>
1029b4354: 900c5e82    	adrp	x2, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b4358: 910ccc42    	add	x2, x2, #0x333
1029b435c: d10223b3    	sub	x19, x29, #0x88
1029b4360: d10223a0    	sub	x0, x29, #0x88
1029b4364: 910083e3    	add	x3, sp, #0x20
1029b4368: 52800301    	mov	w1, #0x18               ; =24
1029b436c: 9549ce7e    	bl	0x107c27d64 <_Flutter_MMFoundation_BindContext+0x4103948>
1029b4370: f00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b4374: f9453500    	ldr	x0, [x8, #0xa68]
1029b4378: d00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b437c: 9116a108    	add	x8, x8, #0x5a8
1029b4380: a9004fe8    	stp	x8, x19, [sp]
1029b4384: 900c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b4388: 9125d063    	add	x3, x3, #0x974
1029b438c: f00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b4390: 9134f8a5    	add	x5, x5, #0xd3e
1029b4394: 900c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b4398: 910894e7    	add	x7, x7, #0x225
1029b439c: f9400fe1    	ldr	x1, [sp, #0x18]
1029b43a0: 52800042    	mov	w2, #0x2                ; =2
1029b43a4: 52800004    	mov	w4, #0x0                ; =0
1029b43a8: 52804186    	mov	w6, #0x20c              ; =524
1029b43ac: 9549cb64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b43b0: f9403fe0    	ldr	x0, [sp, #0x78]
1029b43b4: 9549cb68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b43b8: aa1403e0    	mov	x0, x20
1029b43bc: 9549cb66    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b43c0: f94057e0    	ldr	x0, [sp, #0xa8]
1029b43c4: 9549cb64    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b43c8: aa1503e0    	mov	x0, x21
1029b43cc: 9549cb62    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b43d0: 14000017    	b	0x1029b442c <_Flutter_Image_provideRelativePathByUrl+0xdc12dc>
1029b43d4: f00ebdf6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
1029b43d8: f9400ff4    	ldr	x20, [sp, #0x18]
1029b43dc: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b43e0: f9449501    	ldr	x1, [x8, #0x928] ; rejectScan
1029b43e4: aa1503e0    	mov	x0, x21
1029b43e8: 9549cb55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b43ec: 340003e0    	cbz	w0, 0x1029b4468 <_Flutter_Image_provideRelativePathByUrl+0xdc1318>
1029b43f0: f94536c0    	ldr	x0, [x22, #0xa68]
1029b43f4: d00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b43f8: 91172108    	add	x8, x8, #0x5c8
1029b43fc: f90003e8    	str	x8, [sp]
1029b4400: 900c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b4404: 9125d063    	add	x3, x3, #0x974
1029b4408: f00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b440c: 9134f8a5    	add	x5, x5, #0xd3e
1029b4410: 900c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b4414: 910894e7    	add	x7, x7, #0x225
1029b4418: aa1403e1    	mov	x1, x20
1029b441c: 52800042    	mov	w2, #0x2                ; =2
1029b4420: 52800004    	mov	w4, #0x0                ; =0
1029b4424: 528041e6    	mov	w6, #0x20f              ; =527
1029b4428: 9549cb45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b442c: f85903a8    	ldur	x8, [x29, #-0x70]
1029b4430: f00d61c9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1029b4434: f9405929    	ldr	x9, [x9, #0xb0]
1029b4438: f9400129    	ldr	x9, [x9]
1029b443c: eb08013f    	cmp	x9, x8
1029b4440: 54000881    	b.ne	0x1029b4550 <_Flutter_Image_provideRelativePathByUrl+0xdc1400>
1029b4444: a9547bfd    	ldp	x29, x30, [sp, #0x140]
1029b4448: a9534ff4    	ldp	x20, x19, [sp, #0x130]
1029b444c: a95257f6    	ldp	x22, x21, [sp, #0x120]
1029b4450: a9515ff8    	ldp	x24, x23, [sp, #0x110]
1029b4454: a95067fa    	ldp	x26, x25, [sp, #0x100]
1029b4458: a94f6ffc    	ldp	x28, x27, [sp, #0xf0]
1029b445c: 6d4e23e9    	ldp	d9, d8, [sp, #0xe0]
1029b4460: 910543ff    	add	sp, sp, #0x150
1029b4464: d65f03c0    	ret
1029b4468: eb37427f    	cmp	x19, w23, uxtw
1029b446c: 540002c2    	b.hs	0x1029b44c4 <_Flutter_Image_provideRelativePathByUrl+0xdc1374>
1029b4470: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4474: f9441101    	ldr	x1, [x8, #0x820] ; ifForceWholeWechatScanForDebug
1029b4478: aa1503e0    	mov	x0, x21
1029b447c: 9549cb30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4480: aa0003e8    	mov	x8, x0
1029b4484: f94536c0    	ldr	x0, [x22, #0xa68]
1029b4488: 34000488    	cbz	w8, 0x1029b4518 <_Flutter_Image_provideRelativePathByUrl+0xdc13c8>
1029b448c: d00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b4490: 9117a108    	add	x8, x8, #0x5e8
1029b4494: f90003e8    	str	x8, [sp]
1029b4498: 900c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b449c: 9125d063    	add	x3, x3, #0x974
1029b44a0: f00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b44a4: 9134f8a5    	add	x5, x5, #0xd3e
1029b44a8: 900c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b44ac: 910894e7    	add	x7, x7, #0x225
1029b44b0: aa1403e1    	mov	x1, x20
1029b44b4: 52800042    	mov	w2, #0x2                ; =2
1029b44b8: 52800004    	mov	w4, #0x0                ; =0
1029b44bc: 528042c6    	mov	w6, #0x216              ; =534
1029b44c0: 9549cb1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b44c4: f85903a8    	ldur	x8, [x29, #-0x70]
1029b44c8: f00d61c9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1029b44cc: f9405929    	ldr	x9, [x9, #0xb0]
1029b44d0: f9400129    	ldr	x9, [x9]
1029b44d4: eb08013f    	cmp	x9, x8
1029b44d8: 540003c1    	b.ne	0x1029b4550 <_Flutter_Image_provideRelativePathByUrl+0xdc1400>
1029b44dc: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b44e0: f9448d01    	ldr	x1, [x8, #0x918] ; startWholeScan:quickScan:completion:
1029b44e4: aa1503e0    	mov	x0, x21
1029b44e8: b94017e2    	ldr	w2, [sp, #0x14]
1029b44ec: 52800003    	mov	w3, #0x0                ; =0
1029b44f0: d2800004    	mov	x4, #0x0                ; =0
1029b44f4: a9547bfd    	ldp	x29, x30, [sp, #0x140]
1029b44f8: a9534ff4    	ldp	x20, x19, [sp, #0x130]
1029b44fc: a95257f6    	ldp	x22, x21, [sp, #0x120]
1029b4500: a9515ff8    	ldp	x24, x23, [sp, #0x110]
1029b4504: a95067fa    	ldp	x26, x25, [sp, #0x100]
1029b4508: a94f6ffc    	ldp	x28, x27, [sp, #0xf0]
1029b450c: 6d4e23e9    	ldp	d9, d8, [sp, #0xe0]
1029b4510: 910543ff    	add	sp, sp, #0x150
1029b4514: 1549cb0a    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4518: d00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b451c: 91182108    	add	x8, x8, #0x608
1029b4520: f90003e8    	str	x8, [sp]
1029b4524: 900c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b4528: 9125d063    	add	x3, x3, #0x974
1029b452c: f00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b4530: 9134f8a5    	add	x5, x5, #0xd3e
1029b4534: 900c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b4538: 910894e7    	add	x7, x7, #0x225
1029b453c: aa1403e1    	mov	x1, x20
1029b4540: 52800042    	mov	w2, #0x2                ; =2
1029b4544: 52800004    	mov	w4, #0x0                ; =0
1029b4548: 52804306    	mov	w6, #0x218              ; =536
1029b454c: 17ffffb7    	b	0x1029b4428 <_Flutter_Image_provideRelativePathByUrl+0xdc12d8>
1029b4550: 9549cb09    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
