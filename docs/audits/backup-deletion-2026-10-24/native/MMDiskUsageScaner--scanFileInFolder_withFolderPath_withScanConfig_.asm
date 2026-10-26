
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029beedc: 6db923e9    	stp	d9, d8, [sp, #-0x70]!
1029beee0: a9016ffc    	stp	x28, x27, [sp, #0x10]
1029beee4: a90267fa    	stp	x26, x25, [sp, #0x20]
1029beee8: a9035ff8    	stp	x24, x23, [sp, #0x30]
1029beeec: a90457f6    	stp	x22, x21, [sp, #0x40]
1029beef0: a9054ff4    	stp	x20, x19, [sp, #0x50]
1029beef4: a9067bfd    	stp	x29, x30, [sp, #0x60]
1029beef8: 910183fd    	add	x29, sp, #0x60
1029beefc: d11703ff    	sub	sp, sp, #0x5c0
1029bef00: aa0403fa    	mov	x26, x4
1029bef04: aa0303f4    	mov	x20, x3
1029bef08: aa0203f3    	mov	x19, x2
1029bef0c: aa0003f7    	mov	x23, x0
1029bef10: b00d6188    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1029bef14: f9405908    	ldr	x8, [x8, #0xb0]
1029bef18: f9400108    	ldr	x8, [x8]
1029bef1c: f81903a8    	stur	x8, [x29, #-0x70]
1029bef20: 900f13c8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029bef24: 52800029    	mov	w9, #0x1                ; =1
1029bef28: 3934d909    	strb	w9, [x8, #0xd36]
1029bef2c: aa0203e0    	mov	x0, x2
1029bef30: 9549a082    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029bef34: f9016ff4    	str	x20, [sp, #0x2d8]
1029bef38: aa1403e0    	mov	x0, x20
1029bef3c: 9549a07f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029bef40: aa1a03e0    	mov	x0, x26
1029bef44: 9549a07d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029bef48: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bef4c: f945b501    	ldr	x1, [x8, #0xb68] ; m_dicBizStat
1029bef50: aa1303e0    	mov	x0, x19
1029bef54: f90157e1    	str	x1, [sp, #0x2a8]
1029bef58: 9549a079    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bef5c: aa1d03fd    	mov	x29, x29
1029bef60: 9549a07a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bef64: aa0003f4    	mov	x20, x0
1029bef68: 9549a07b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bef6c: b5000214    	cbnz	x20, 0x1029befac <_Flutter_Image_provideRelativePathByUrl+0xdcbe5c>
1029bef70: b00ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029bef74: f9454100    	ldr	x0, [x8, #0xa80]
1029bef78: f00eba08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1029bef7c: f9400501    	ldr	x1, [x8, #0x8] ; dictionary
1029bef80: 9549a06f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bef84: aa1d03fd    	mov	x29, x29
1029bef88: 9549a070    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bef8c: aa0003f4    	mov	x20, x0
1029bef90: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bef94: f943c101    	ldr	x1, [x8, #0x780] ; setM_dicBizStat:
1029bef98: aa1303e0    	mov	x0, x19
1029bef9c: aa1403e2    	mov	x2, x20
1029befa0: 9549a067    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029befa4: aa1403e0    	mov	x0, x20
1029befa8: 9549a06b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029befac: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029befb0: f945ad01    	ldr	x1, [x8, #0xb58] ; m_dicFileTypeInUseStat
1029befb4: aa1303e0    	mov	x0, x19
1029befb8: f900f3e1    	str	x1, [sp, #0x1e0]
1029befbc: 9549a060    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029befc0: aa1d03fd    	mov	x29, x29
1029befc4: 9549a061    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029befc8: aa0003f4    	mov	x20, x0
1029befcc: 9549a062    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029befd0: b5000214    	cbnz	x20, 0x1029bf010 <_Flutter_Image_provideRelativePathByUrl+0xdcbec0>
1029befd4: b00ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029befd8: f9454100    	ldr	x0, [x8, #0xa80]
1029befdc: f00eba08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1029befe0: f9400501    	ldr	x1, [x8, #0x8] ; dictionary
1029befe4: 9549a056    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029befe8: aa1d03fd    	mov	x29, x29
1029befec: 9549a057    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029beff0: aa0003f4    	mov	x20, x0
1029beff4: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029beff8: f943c901    	ldr	x1, [x8, #0x790] ; setM_dicFileTypeInUseStat:
1029beffc: aa1303e0    	mov	x0, x19
1029bf000: aa1403e2    	mov	x2, x20
1029bf004: 9549a04e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf008: aa1403e0    	mov	x0, x20
1029bf00c: 9549a052    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf010: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf014: f9478901    	ldr	x1, [x8, #0xf10] ; m_dicWechatFileClassStat
1029bf018: aa1303e0    	mov	x0, x19
1029bf01c: f900efe1    	str	x1, [sp, #0x1d8]
1029bf020: 9549a047    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf024: aa1d03fd    	mov	x29, x29
1029bf028: 9549a048    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf02c: aa0003f4    	mov	x20, x0
1029bf030: 9549a049    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf034: b5000214    	cbnz	x20, 0x1029bf074 <_Flutter_Image_provideRelativePathByUrl+0xdcbf24>
1029bf038: 900ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029bf03c: f9454100    	ldr	x0, [x8, #0xa80]
1029bf040: d00eba08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1029bf044: f9400501    	ldr	x1, [x8, #0x8] ; dictionary
1029bf048: 9549a03d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf04c: aa1d03fd    	mov	x29, x29
1029bf050: 9549a03e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf054: aa0003f4    	mov	x20, x0
1029bf058: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf05c: f9478d01    	ldr	x1, [x8, #0xf18] ; setM_dicWechatFileClassStat:
1029bf060: aa1303e0    	mov	x0, x19
1029bf064: aa1403e2    	mov	x2, x20
1029bf068: 9549a035    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf06c: aa1403e0    	mov	x0, x20
1029bf070: 9549a039    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf074: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf078: f946dd01    	ldr	x1, [x8, #0xdb8] ; m_dictOtherDataFileStat
1029bf07c: aa1303e0    	mov	x0, x19
1029bf080: f9007fe1    	str	x1, [sp, #0xf8]
1029bf084: 9549a02e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf088: aa1d03fd    	mov	x29, x29
1029bf08c: 9549a02f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf090: aa0003f4    	mov	x20, x0
1029bf094: 9549a030    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf098: b5000214    	cbnz	x20, 0x1029bf0d8 <_Flutter_Image_provideRelativePathByUrl+0xdcbf88>
1029bf09c: 900ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029bf0a0: f9454100    	ldr	x0, [x8, #0xa80]
1029bf0a4: d00eba08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1029bf0a8: f9400501    	ldr	x1, [x8, #0x8] ; dictionary
1029bf0ac: 9549a024    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf0b0: aa1d03fd    	mov	x29, x29
1029bf0b4: 9549a025    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf0b8: aa0003f4    	mov	x20, x0
1029bf0bc: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf0c0: f9437101    	ldr	x1, [x8, #0x6e0] ; setM_dictOtherDataFileStat:
1029bf0c4: aa1303e0    	mov	x0, x19
1029bf0c8: aa1403e2    	mov	x2, x20
1029bf0cc: 9549a01c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf0d0: aa1403e0    	mov	x0, x20
1029bf0d4: 9549a020    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf0d8: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf0dc: f946e901    	ldr	x1, [x8, #0xdd0] ; m_dictCacheDataFileStat
1029bf0e0: aa1303e0    	mov	x0, x19
1029bf0e4: f9003fe1    	str	x1, [sp, #0x78]
1029bf0e8: 9549a015    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf0ec: aa1d03fd    	mov	x29, x29
1029bf0f0: 9549a016    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf0f4: aa0003f4    	mov	x20, x0
1029bf0f8: 9549a017    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf0fc: b5000214    	cbnz	x20, 0x1029bf13c <_Flutter_Image_provideRelativePathByUrl+0xdcbfec>
1029bf100: 900ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029bf104: f9454100    	ldr	x0, [x8, #0xa80]
1029bf108: d00eba08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1029bf10c: f9400501    	ldr	x1, [x8, #0x8] ; dictionary
1029bf110: 9549a00b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf114: aa1d03fd    	mov	x29, x29
1029bf118: 9549a00c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf11c: aa0003f4    	mov	x20, x0
1029bf120: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf124: f9437501    	ldr	x1, [x8, #0x6e8] ; setM_dictCacheDataFileStat:
1029bf128: aa1303e0    	mov	x0, x19
1029bf12c: aa1403e2    	mov	x2, x20
1029bf130: 9549a003    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf134: aa1403e0    	mov	x0, x20
1029bf138: 9549a007    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf13c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf140: f942fd01    	ldr	x1, [x8, #0x5f8] ; m_arrNotScanFileName
1029bf144: aa1303e0    	mov	x0, x19
1029bf148: f9003be1    	str	x1, [sp, #0x70]
1029bf14c: 95499ffc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf150: aa1d03fd    	mov	x29, x29
1029bf154: 95499ffd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf158: aa0003f4    	mov	x20, x0
1029bf15c: b00eba08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029bf160: f9435115    	ldr	x21, [x8, #0x6a0] ; count
1029bf164: aa1503e1    	mov	x1, x21
1029bf168: 95499ff5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf16c: aa0003f6    	mov	x22, x0
1029bf170: aa1403e0    	mov	x0, x20
1029bf174: 95499ff8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf178: b40018d6    	cbz	x22, 0x1029bf490 <_Flutter_Image_provideRelativePathByUrl+0xdcc340>
1029bf17c: f9001bf5    	str	x21, [sp, #0x30]
1029bf180: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf184: f945f101    	ldr	x1, [x8, #0xbe0] ; useFolderCache
1029bf188: aa1a03e0    	mov	x0, x26
1029bf18c: 95499fec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf190: b902ebe0    	str	w0, [sp, #0x2e8]
1029bf194: b00ebde8    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
1029bf198: f943d500    	ldr	x0, [x8, #0x7a8]
1029bf19c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf1a0: f9432101    	ldr	x1, [x8, #0x640] ; getShortPathFromFullPath:
1029bf1a4: f90153e1    	str	x1, [sp, #0x2a0]
1029bf1a8: f9416fe2    	ldr	x2, [sp, #0x2d8]
1029bf1ac: 95499fe4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf1b0: aa1d03fd    	mov	x29, x29
1029bf1b4: 95499fe5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf1b8: f9015be0    	str	x0, [sp, #0x2b0]
1029bf1bc: 4f00e400    	movi.16b	v0, #0x0
1029bf1c0: ad1f83e0    	stp	q0, q0, [sp, #0x3f0]
1029bf1c4: 3d8107e0    	str	q0, [sp, #0x410]
1029bf1c8: 3d810be0    	str	q0, [sp, #0x420]
1029bf1cc: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf1d0: f944c501    	ldr	x1, [x8, #0x988] ; regularExpressionsThatLogFilesToKV
1029bf1d4: f90163fa    	str	x26, [sp, #0x2c0]
1029bf1d8: aa1a03e0    	mov	x0, x26
1029bf1dc: 95499fd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf1e0: aa1d03fd    	mov	x29, x29
1029bf1e4: 95499fd9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf1e8: aa0003f6    	mov	x22, x0
1029bf1ec: b00eba08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029bf1f0: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1029bf1f4: 910fc3e2    	add	x2, sp, #0x3f0
1029bf1f8: d103c3a3    	sub	x3, x29, #0xf0
1029bf1fc: f90033e1    	str	x1, [sp, #0x60]
1029bf200: 52800204    	mov	w4, #0x10               ; =16
1029bf204: 95499fce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf208: b4000540    	cbz	x0, 0x1029bf2b0 <_Flutter_Image_provideRelativePathByUrl+0xdcc160>
1029bf20c: aa0003f9    	mov	x25, x0
1029bf210: f94203e8    	ldr	x8, [sp, #0x400]
1029bf214: f9400115    	ldr	x21, [x8]
1029bf218: 900eba28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029bf21c: f00ea6a9    	adrp	x9, 0x11fe96000 <dyld_stub_binder+0x11fe96000>
1029bf220: d280001c    	mov	x28, #0x0               ; =0
1029bf224: f946e914    	ldr	x20, [x8, #0xdd0] ; length
1029bf228: f944613a    	ldr	x26, [x9, #0x8c0] ; numberOfMatchesInString:options:range:
1029bf22c: f94203e8    	ldr	x8, [sp, #0x400]
1029bf230: f9400108    	ldr	x8, [x8]
1029bf234: eb15011f    	cmp	x8, x21
1029bf238: 54000060    	b.eq	0x1029bf244 <_Flutter_Image_provideRelativePathByUrl+0xdcc0f4>
1029bf23c: aa1603e0    	mov	x0, x22
1029bf240: 95499fc4    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1029bf244: f941ffe8    	ldr	x8, [sp, #0x3f8]
1029bf248: f87c791b    	ldr	x27, [x8, x28, lsl #3]
1029bf24c: f9415bf8    	ldr	x24, [sp, #0x2b0]
1029bf250: aa1803e0    	mov	x0, x24
1029bf254: aa1403e1    	mov	x1, x20
1029bf258: 95499fb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf25c: aa0003e5    	mov	x5, x0
1029bf260: aa1b03e0    	mov	x0, x27
1029bf264: aa1a03e1    	mov	x1, x26
1029bf268: aa1803e2    	mov	x2, x24
1029bf26c: d2800003    	mov	x3, #0x0                ; =0
1029bf270: d2800004    	mov	x4, #0x0                ; =0
1029bf274: 95499fb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf278: b5000d80    	cbnz	x0, 0x1029bf428 <_Flutter_Image_provideRelativePathByUrl+0xdcc2d8>
1029bf27c: 9100079c    	add	x28, x28, #0x1
1029bf280: eb1c033f    	cmp	x25, x28
1029bf284: 54fffd41    	b.ne	0x1029bf22c <_Flutter_Image_provideRelativePathByUrl+0xdcc0dc>
1029bf288: 910fc3e2    	add	x2, sp, #0x3f0
1029bf28c: d103c3a3    	sub	x3, x29, #0xf0
1029bf290: aa1603e0    	mov	x0, x22
1029bf294: f94033e1    	ldr	x1, [sp, #0x60]
1029bf298: 52800204    	mov	w4, #0x10               ; =16
1029bf29c: 95499fa8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf2a0: aa0003f9    	mov	x25, x0
1029bf2a4: 900eba28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029bf2a8: f00ea6a9    	adrp	x9, 0x11fe96000 <dyld_stub_binder+0x11fe96000>
1029bf2ac: b5fffba0    	cbnz	x0, 0x1029bf220 <_Flutter_Image_provideRelativePathByUrl+0xdcc0d0>
1029bf2b0: aa1603e0    	mov	x0, x22
1029bf2b4: 95499fa8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf2b8: b942ebe8    	ldr	w8, [sp, #0x2e8]
1029bf2bc: 34006568    	cbz	w8, 0x1029bff68 <_Flutter_Image_provideRelativePathByUrl+0xdcce18>
1029bf2c0: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf2c4: f9468d15    	ldr	x21, [x8, #0xd18] ; wrapCacheData
1029bf2c8: aa1703e0    	mov	x0, x23
1029bf2cc: aa1503e1    	mov	x1, x21
1029bf2d0: 95499f9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf2d4: aa1d03fd    	mov	x29, x29
1029bf2d8: 95499f9c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf2dc: aa0003f4    	mov	x20, x0
1029bf2e0: f00ea668    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
1029bf2e4: f9400501    	ldr	x1, [x8, #0x8] ; getWrapCacheByFullPath:
1029bf2e8: f9416fe2    	ldr	x2, [sp, #0x2d8]
1029bf2ec: 95499f94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf2f0: aa1d03fd    	mov	x29, x29
1029bf2f4: 95499f95    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf2f8: aa0003fb    	mov	x27, x0
1029bf2fc: aa1403e0    	mov	x0, x20
1029bf300: 95499f95    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf304: b00ea9d8    	adrp	x24, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf308: b400173b    	cbz	x27, 0x1029bf5ec <_Flutter_Image_provideRelativePathByUrl+0xdcc49c>
1029bf30c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf310: f9460114    	ldr	x20, [x8, #0xc00] ; isIgnoreCowFile
1029bf314: f94163fa    	ldr	x26, [sp, #0x2c0]
1029bf318: aa1a03e0    	mov	x0, x26
1029bf31c: aa1403e1    	mov	x1, x20
1029bf320: 95499f87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf324: 370000a0    	tbnz	w0, #0x0, 0x1029bf338 <_Flutter_Image_provideRelativePathByUrl+0xdcc1e8>
1029bf328: aa1b03e0    	mov	x0, x27
1029bf32c: aa1403e1    	mov	x1, x20
1029bf330: 95499f83    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf334: 370015c0    	tbnz	w0, #0x0, 0x1029bf5ec <_Flutter_Image_provideRelativePathByUrl+0xdcc49c>
1029bf338: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf33c: f9462501    	ldr	x1, [x8, #0xc48] ; willScanWholeWechat
1029bf340: aa1a03e0    	mov	x0, x26
1029bf344: 95499f7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf348: 340001a0    	cbz	w0, 0x1029bf37c <_Flutter_Image_provideRelativePathByUrl+0xdcc22c>
1029bf34c: d00ea668    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029bf350: f947a914    	ldr	x20, [x8, #0xf50] ; m_onlyBizType
1029bf354: aa1303e0    	mov	x0, x19
1029bf358: aa1403e1    	mov	x1, x20
1029bf35c: 95499f78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf360: f100201f    	cmp	x0, #0x8
1029bf364: 54001440    	b.eq	0x1029bf5ec <_Flutter_Image_provideRelativePathByUrl+0xdcc49c>
1029bf368: aa1303e0    	mov	x0, x19
1029bf36c: aa1403e1    	mov	x1, x20
1029bf370: 95499f73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf374: f1001c1f    	cmp	x0, #0x7
1029bf378: 540013a0    	b.eq	0x1029bf5ec <_Flutter_Image_provideRelativePathByUrl+0xdcc49c>
1029bf37c: 900ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029bf380: f9463500    	ldr	x0, [x8, #0xc68]
1029bf384: f00ea988    	adrp	x8, 0x11fef2000 <dyld_stub_binder+0x11fef2000>
1029bf388: f9452901    	ldr	x1, [x8, #0xa50] ; GetFileLastTimeOfAccessModifyChangeBirth:
1029bf38c: f9416fe2    	ldr	x2, [sp, #0x2d8]
1029bf390: 95499f6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf394: f100041f    	cmp	x0, #0x1
1029bf398: 5400080b    	b.lt	0x1029bf498 <_Flutter_Image_provideRelativePathByUrl+0xdcc348>
1029bf39c: aa0003f6    	mov	x22, x0
1029bf3a0: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf3a4: f9479514    	ldr	x20, [x8, #0xf28] ; lastScanTime
1029bf3a8: aa1b03e0    	mov	x0, x27
1029bf3ac: aa1403e1    	mov	x1, x20
1029bf3b0: 95499f63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf3b4: eb0002df    	cmp	x22, x0
1029bf3b8: 5400070a    	b.ge	0x1029bf498 <_Flutter_Image_provideRelativePathByUrl+0xdcc348>
1029bf3bc: f9474301    	ldr	x1, [x24, #0xe80] ; m_curStartTime
1029bf3c0: aa1303e0    	mov	x0, x19
1029bf3c4: 95499f5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf3c8: 2a0003f5    	mov	w21, w0
1029bf3cc: aa1b03e0    	mov	x0, x27
1029bf3d0: aa1403e1    	mov	x1, x20
1029bf3d4: 95499f5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf3d8: cb0002b4    	sub	x20, x21, x0
1029bf3dc: b00ea668    	adrp	x8, 0x11fe8c000 <dyld_stub_binder+0x11fe8c000>
1029bf3e0: f945d501    	ldr	x1, [x8, #0xba8] ; cacheTime
1029bf3e4: aa1b03e0    	mov	x0, x27
1029bf3e8: 95499f55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf3ec: eb00029f    	cmp	x20, x0
1029bf3f0: 540010cd    	b.le	0x1029bf608 <_Flutter_Image_provideRelativePathByUrl+0xdcc4b8>
1029bf3f4: aa1b03e0    	mov	x0, x27
1029bf3f8: 95499f50    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029bf3fc: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf400: f9479901    	ldr	x1, [x8, #0xf30] ; m_timeOutCacheCount
1029bf404: aa1303e0    	mov	x0, x19
1029bf408: 95499f4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf40c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf410: f9479d01    	ldr	x1, [x8, #0xf38] ; setM_timeOutCacheCount:
1029bf414: 11000402    	add	w2, w0, #0x1
1029bf418: aa1303e0    	mov	x0, x19
1029bf41c: 95499f48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf420: aa1b03f5    	mov	x21, x27
1029bf424: 14000073    	b	0x1029bf5f0 <_Flutter_Image_provideRelativePathByUrl+0xdcc4a0>
1029bf428: 900ebe48    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1029bf42c: f945b100    	ldr	x0, [x8, #0xb60] ; H.y
1029bf430: 95499f4c    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1029bf434: aa0003f4    	mov	x20, x0
1029bf438: d00ea668    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029bf43c: f947bd01    	ldr	x1, [x8, #0xf78] ; m_bizMatchNode
1029bf440: aa1303e0    	mov	x0, x19
1029bf444: 95499f3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf448: aa1d03fd    	mov	x29, x29
1029bf44c: 95499f3f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf450: aa0003f8    	mov	x24, x0
1029bf454: d00ea668    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029bf458: f947d101    	ldr	x1, [x8, #0xfa0] ; m_bizType
1029bf45c: 95499f38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf460: aa0003e2    	mov	x2, x0
1029bf464: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf468: f9479101    	ldr	x1, [x8, #0xf20] ; initWithBiz:folder:
1029bf46c: aa1403e0    	mov	x0, x20
1029bf470: f9415be3    	ldr	x3, [sp, #0x2b0]
1029bf474: 95499f32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf478: f9015fe0    	str	x0, [sp, #0x2b8]
1029bf47c: aa1803e0    	mov	x0, x24
1029bf480: 95499f35    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf484: aa1603e0    	mov	x0, x22
1029bf488: 95499f33    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf48c: 140002b8    	b	0x1029bff6c <_Flutter_Image_provideRelativePathByUrl+0xdcce1c>
1029bf490: 52800034    	mov	w20, #0x1               ; =1
1029bf494: 140007db    	b	0x1029c1400 <_Flutter_Image_provideRelativePathByUrl+0xdce2b0>
1029bf498: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf49c: f947e501    	ldr	x1, [x8, #0xfc8] ; isFileCanNotChangeSize:
1029bf4a0: aa1703e0    	mov	x0, x23
1029bf4a4: aa1303e2    	mov	x2, x19
1029bf4a8: 95499f25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf4ac: 34000520    	cbz	w0, 0x1029bf550 <_Flutter_Image_provideRelativePathByUrl+0xdcc400>
1029bf4b0: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf4b4: f947e919    	ldr	x25, [x8, #0xfd0] ; fileNameSet
1029bf4b8: aa1b03e0    	mov	x0, x27
1029bf4bc: aa1903e1    	mov	x1, x25
1029bf4c0: 95499f1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf4c4: aa1d03fd    	mov	x29, x29
1029bf4c8: 95499f20    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf4cc: b4000420    	cbz	x0, 0x1029bf550 <_Flutter_Image_provideRelativePathByUrl+0xdcc400>
1029bf4d0: aa0003f4    	mov	x20, x0
1029bf4d4: aa1b03e0    	mov	x0, x27
1029bf4d8: aa1903e1    	mov	x1, x25
1029bf4dc: 95499f18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf4e0: aa1d03fd    	mov	x29, x29
1029bf4e4: 95499f19    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf4e8: aa0003f6    	mov	x22, x0
1029bf4ec: f9015ff5    	str	x21, [sp, #0x2b8]
1029bf4f0: f9401bf5    	ldr	x21, [sp, #0x30]
1029bf4f4: aa1503e1    	mov	x1, x21
1029bf4f8: 95499f11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf4fc: f90177e0    	str	x0, [sp, #0x2e8]
1029bf500: aa1303e0    	mov	x0, x19
1029bf504: f9403be1    	ldr	x1, [sp, #0x70]
1029bf508: 95499f0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf50c: aa1d03fd    	mov	x29, x29
1029bf510: 95499f0e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf514: aa0003fa    	mov	x26, x0
1029bf518: aa1503e1    	mov	x1, x21
1029bf51c: f9415ff5    	ldr	x21, [sp, #0x2b8]
1029bf520: 95499f07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf524: aa0003fc    	mov	x28, x0
1029bf528: aa1a03e0    	mov	x0, x26
1029bf52c: aa1903fa    	mov	x26, x25
1029bf530: 95499f09    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf534: aa1603e0    	mov	x0, x22
1029bf538: 95499f07    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf53c: aa1403e0    	mov	x0, x20
1029bf540: 95499f05    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf544: f94177e8    	ldr	x8, [sp, #0x2e8]
1029bf548: eb1c011f    	cmp	x8, x28
1029bf54c: 54002029    	b.ls	0x1029bf950 <_Flutter_Image_provideRelativePathByUrl+0xdcc800>
1029bf550: aa1703e0    	mov	x0, x23
1029bf554: aa1503e1    	mov	x1, x21
1029bf558: 95499ef9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf55c: aa1d03fd    	mov	x29, x29
1029bf560: 95499efa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf564: aa0003f4    	mov	x20, x0
1029bf568: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf56c: f9474501    	ldr	x1, [x8, #0xe88] ; deleteCacheByFullPath:
1029bf570: f9416ff5    	ldr	x21, [sp, #0x2d8]
1029bf574: aa1503e2    	mov	x2, x21
1029bf578: 95499ef1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf57c: aa1403e0    	mov	x0, x20
1029bf580: 95499ef5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf584: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf588: f947ed01    	ldr	x1, [x8, #0xfd8] ; m_fileModifyCacheCount
1029bf58c: aa1303e0    	mov	x0, x19
1029bf590: 95499eeb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf594: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf598: f947f101    	ldr	x1, [x8, #0xfe0] ; setM_fileModifyCacheCount:
1029bf59c: 11000402    	add	w2, w0, #0x1
1029bf5a0: aa1303e0    	mov	x0, x19
1029bf5a4: 95499ee6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf5a8: 900ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029bf5ac: f9453500    	ldr	x0, [x8, #0xa68]
1029bf5b0: d00ea3c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029bf5b4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029bf5b8: 900de5c8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029bf5bc: 9129a108    	add	x8, x8, #0xa68
1029bf5c0: a90057e8    	stp	x8, x21, [sp]
1029bf5c4: b00c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029bf5c8: 9125d063    	add	x3, x3, #0x974
1029bf5cc: d00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029bf5d0: 9112f8a5    	add	x5, x5, #0x4be
1029bf5d4: d00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029bf5d8: 913c94e7    	add	x7, x7, #0xf25
1029bf5dc: 52800022    	mov	w2, #0x1                ; =1
1029bf5e0: 52800004    	mov	w4, #0x0                ; =0
1029bf5e4: 528078c6    	mov	w6, #0x3c6              ; =966
1029bf5e8: 95499ed5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf5ec: d2800015    	mov	x21, #0x0               ; =0
1029bf5f0: aa1b03e0    	mov	x0, x27
1029bf5f4: 95499ed8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf5f8: f9015fff    	str	xzr, [sp, #0x2b8]
1029bf5fc: b00ebdf4    	adrp	x20, 0x12017c000 <dyld_stub_binder+0x12017c000>
1029bf600: f94153f6    	ldr	x22, [sp, #0x2a0]
1029bf604: 1400025e    	b	0x1029bff7c <_Flutter_Image_provideRelativePathByUrl+0xdcce2c>
1029bf608: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf60c: f942d501    	ldr	x1, [x8, #0x5a8] ; fileNum
1029bf610: aa1b03e0    	mov	x0, x27
1029bf614: 95499eca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf618: aa0003e2    	mov	x2, x0
1029bf61c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf620: f942ad01    	ldr	x1, [x8, #0x558] ; setM_fileNum:
1029bf624: aa1303e0    	mov	x0, x19
1029bf628: 95499ec5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf62c: d00eba08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1029bf630: f944c101    	ldr	x1, [x8, #0x980] ; fileSize
1029bf634: aa1b03e0    	mov	x0, x27
1029bf638: 95499ec1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf63c: aa0003e2    	mov	x2, x0
1029bf640: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf644: f942b501    	ldr	x1, [x8, #0x568] ; setM_fileSize:
1029bf648: aa1303e0    	mov	x0, x19
1029bf64c: 95499ebc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf650: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf654: f947a101    	ldr	x1, [x8, #0xf40] ; dicBizStat
1029bf658: aa1b03e0    	mov	x0, x27
1029bf65c: 95499eb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf660: aa1d03fd    	mov	x29, x29
1029bf664: 95499eb9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf668: aa0003f4    	mov	x20, x0
1029bf66c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf670: f943c101    	ldr	x1, [x8, #0x780] ; setM_dicBizStat:
1029bf674: aa1303e0    	mov	x0, x19
1029bf678: aa1403e2    	mov	x2, x20
1029bf67c: 95499eb0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf680: aa1403e0    	mov	x0, x20
1029bf684: 95499eb4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf688: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf68c: f947a501    	ldr	x1, [x8, #0xf48] ; dicFileTypeInUseStat
1029bf690: aa1b03e0    	mov	x0, x27
1029bf694: 95499eaa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf698: aa1d03fd    	mov	x29, x29
1029bf69c: 95499eab    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf6a0: aa0003f4    	mov	x20, x0
1029bf6a4: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf6a8: f943c901    	ldr	x1, [x8, #0x790] ; setM_dicFileTypeInUseStat:
1029bf6ac: aa1303e0    	mov	x0, x19
1029bf6b0: aa1403e2    	mov	x2, x20
1029bf6b4: 95499ea2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf6b8: aa1403e0    	mov	x0, x20
1029bf6bc: 95499ea6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf6c0: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf6c4: f947a901    	ldr	x1, [x8, #0xf50] ; dicWechatFileClassStat
1029bf6c8: aa1b03e0    	mov	x0, x27
1029bf6cc: 95499e9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf6d0: aa1d03fd    	mov	x29, x29
1029bf6d4: 95499e9d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf6d8: aa0003f4    	mov	x20, x0
1029bf6dc: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf6e0: f9478d01    	ldr	x1, [x8, #0xf18] ; setM_dicWechatFileClassStat:
1029bf6e4: aa1303e0    	mov	x0, x19
1029bf6e8: aa1403e2    	mov	x2, x20
1029bf6ec: 95499e94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf6f0: aa1403e0    	mov	x0, x20
1029bf6f4: 95499e98    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf6f8: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf6fc: f947ad01    	ldr	x1, [x8, #0xf58] ; logicFileSize
1029bf700: aa1b03e0    	mov	x0, x27
1029bf704: 95499e8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf708: aa0003e2    	mov	x2, x0
1029bf70c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf710: f947b101    	ldr	x1, [x8, #0xf60] ; setM_logicFileSize:
1029bf714: aa1303e0    	mov	x0, x19
1029bf718: 95499e89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf71c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf720: f947b501    	ldr	x1, [x8, #0xf68] ; puffyFileNum
1029bf724: aa1b03e0    	mov	x0, x27
1029bf728: 95499e85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf72c: aa0003e2    	mov	x2, x0
1029bf730: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf734: f947b901    	ldr	x1, [x8, #0xf70] ; setM_puffyFileNum:
1029bf738: aa1303e0    	mov	x0, x19
1029bf73c: 95499e80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf740: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf744: f947bd01    	ldr	x1, [x8, #0xf78] ; puffyFileSize
1029bf748: aa1b03e0    	mov	x0, x27
1029bf74c: 95499e7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf750: aa0003e2    	mov	x2, x0
1029bf754: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf758: f947c101    	ldr	x1, [x8, #0xf80] ; setM_puffyFileSize:
1029bf75c: aa1303e0    	mov	x0, x19
1029bf760: 95499e77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf764: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf768: f947c501    	ldr	x1, [x8, #0xf88] ; puffyLogicFileSize
1029bf76c: aa1b03e0    	mov	x0, x27
1029bf770: 95499e73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf774: aa0003e2    	mov	x2, x0
1029bf778: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf77c: f947c901    	ldr	x1, [x8, #0xf90] ; setM_puffyLogicFileSize:
1029bf780: aa1303e0    	mov	x0, x19
1029bf784: 95499e6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf788: aa1303e0    	mov	x0, x19
1029bf78c: f9403bf5    	ldr	x21, [sp, #0x70]
1029bf790: aa1503e1    	mov	x1, x21
1029bf794: 95499e6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf798: aa1d03fd    	mov	x29, x29
1029bf79c: 95499e6b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf7a0: aa0003f4    	mov	x20, x0
1029bf7a4: f00eba28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1029bf7a8: f9408101    	ldr	x1, [x8, #0x100] ; removeAllObjects
1029bf7ac: 95499e64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf7b0: aa1403e0    	mov	x0, x20
1029bf7b4: 95499e68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf7b8: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf7bc: f947cd01    	ldr	x1, [x8, #0xf98] ; m_hitCacheCount
1029bf7c0: aa1303e0    	mov	x0, x19
1029bf7c4: 95499e5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf7c8: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf7cc: f947d101    	ldr	x1, [x8, #0xfa0] ; setM_hitCacheCount:
1029bf7d0: 11000402    	add	w2, w0, #0x1
1029bf7d4: aa1303e0    	mov	x0, x19
1029bf7d8: 95499e59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf7dc: aa1303e0    	mov	x0, x19
1029bf7e0: aa1503e1    	mov	x1, x21
1029bf7e4: 95499e56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf7e8: aa1d03fd    	mov	x29, x29
1029bf7ec: 95499e57    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf7f0: aa0003f4    	mov	x20, x0
1029bf7f4: f9401be1    	ldr	x1, [sp, #0x30]
1029bf7f8: 95499e51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf7fc: aa0003f6    	mov	x22, x0
1029bf800: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf804: f947d501    	ldr	x1, [x8, #0xfa8] ; m_curScannedFileNum
1029bf808: aa1303e0    	mov	x0, x19
1029bf80c: 95499e4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf810: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf814: f947d901    	ldr	x1, [x8, #0xfb0] ; setM_curScannedFileNum:
1029bf818: 0b160002    	add	w2, w0, w22
1029bf81c: aa1303e0    	mov	x0, x19
1029bf820: 95499e47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf824: aa1403e0    	mov	x0, x20
1029bf828: 95499e4b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf82c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf830: f947dd14    	ldr	x20, [x8, #0xfb8] ; dictOtherDataFileStat
1029bf834: aa1b03e0    	mov	x0, x27
1029bf838: aa1403e1    	mov	x1, x20
1029bf83c: 95499e40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf840: aa1d03fd    	mov	x29, x29
1029bf844: 95499e41    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf848: aa0003f6    	mov	x22, x0
1029bf84c: 95499e42    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf850: b40001d6    	cbz	x22, 0x1029bf888 <_Flutter_Image_provideRelativePathByUrl+0xdcc738>
1029bf854: aa1b03e0    	mov	x0, x27
1029bf858: aa1403e1    	mov	x1, x20
1029bf85c: 95499e38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf860: aa1d03fd    	mov	x29, x29
1029bf864: 95499e39    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf868: aa0003f4    	mov	x20, x0
1029bf86c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf870: f9437101    	ldr	x1, [x8, #0x6e0] ; setM_dictOtherDataFileStat:
1029bf874: aa1303e0    	mov	x0, x19
1029bf878: aa1403e2    	mov	x2, x20
1029bf87c: 95499e30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf880: aa1403e0    	mov	x0, x20
1029bf884: 95499e34    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf888: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf88c: f947e114    	ldr	x20, [x8, #0xfc0] ; dictCacheDataFileStat
1029bf890: aa1b03e0    	mov	x0, x27
1029bf894: aa1403e1    	mov	x1, x20
1029bf898: 95499e29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf89c: aa1d03fd    	mov	x29, x29
1029bf8a0: 95499e2a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf8a4: aa0003f6    	mov	x22, x0
1029bf8a8: 95499e2b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf8ac: b40001d6    	cbz	x22, 0x1029bf8e4 <_Flutter_Image_provideRelativePathByUrl+0xdcc794>
1029bf8b0: aa1b03e0    	mov	x0, x27
1029bf8b4: aa1403e1    	mov	x1, x20
1029bf8b8: 95499e21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf8bc: aa1d03fd    	mov	x29, x29
1029bf8c0: 95499e22    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf8c4: aa0003f4    	mov	x20, x0
1029bf8c8: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf8cc: f9437501    	ldr	x1, [x8, #0x6e8] ; setM_dictCacheDataFileStat:
1029bf8d0: aa1303e0    	mov	x0, x19
1029bf8d4: aa1403e2    	mov	x2, x20
1029bf8d8: 95499e19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf8dc: aa1403e0    	mov	x0, x20
1029bf8e0: 95499e1d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf8e4: aa1b03e0    	mov	x0, x27
1029bf8e8: 95499e1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bf8ec: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf8f0: f9441101    	ldr	x1, [x8, #0x820] ; ifForceWholeWechatScanForDebug
1029bf8f4: aa1703e0    	mov	x0, x23
1029bf8f8: 95499e11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf8fc: 34002dc0    	cbz	w0, 0x1029bfeb4 <_Flutter_Image_provideRelativePathByUrl+0xdccd64>
1029bf900: 900ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029bf904: f9453500    	ldr	x0, [x8, #0xa68]
1029bf908: d00ea3c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029bf90c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029bf910: 900de5c8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029bf914: 912b2108    	add	x8, x8, #0xac8
1029bf918: f90003e8    	str	x8, [sp]
1029bf91c: b00c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029bf920: 9125d063    	add	x3, x3, #0x974
1029bf924: d00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029bf928: 9112f8a5    	add	x5, x5, #0x4be
1029bf92c: d00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029bf930: 913c94e7    	add	x7, x7, #0xf25
1029bf934: 52800022    	mov	w2, #0x1                ; =1
1029bf938: 52800004    	mov	w4, #0x0                ; =0
1029bf93c: 52807e86    	mov	w6, #0x3f4              ; =1012
1029bf940: 95499dff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf944: f9015fff    	str	xzr, [sp, #0x2b8]
1029bf948: d2800015    	mov	x21, #0x0               ; =0
1029bf94c: 17ffff2c    	b	0x1029bf5fc <_Flutter_Image_provideRelativePathByUrl+0xdcc4ac>
1029bf950: 900ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029bf954: f9455500    	ldr	x0, [x8, #0xaa8]
1029bf958: 95499e00    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1029bf95c: f90167e0    	str	x0, [sp, #0x2c8]
1029bf960: 4f00e400    	movi.16b	v0, #0x0
1029bf964: ad1d83e0    	stp	q0, q0, [sp, #0x3b0]
1029bf968: ad1e83e0    	stp	q0, q0, [sp, #0x3d0]
1029bf96c: aa1303e0    	mov	x0, x19
1029bf970: f9403be1    	ldr	x1, [sp, #0x70]
1029bf974: 95499df2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf978: aa1d03fd    	mov	x29, x29
1029bf97c: 95499df3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bf980: 910ec3e2    	add	x2, sp, #0x3b0
1029bf984: 9112c3e3    	add	x3, sp, #0x4b0
1029bf988: f90173e0    	str	x0, [sp, #0x2e0]
1029bf98c: f94033e1    	ldr	x1, [sp, #0x60]
1029bf990: 52800204    	mov	w4, #0x10               ; =16
1029bf994: 95499dea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bf998: b4000680    	cbz	x0, 0x1029bfa68 <_Flutter_Image_provideRelativePathByUrl+0xdcc918>
1029bf99c: aa0003fc    	mov	x28, x0
1029bf9a0: f941e3e8    	ldr	x8, [sp, #0x3c0]
1029bf9a4: f9400108    	ldr	x8, [x8]
1029bf9a8: f90177e8    	str	x8, [sp, #0x2e8]
1029bf9ac: d2800014    	mov	x20, #0x0               ; =0
1029bf9b0: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bf9b4: f947e91a    	ldr	x26, [x8, #0xfd0] ; fileNameSet
1029bf9b8: b00eba08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029bf9bc: f9424d19    	ldr	x25, [x8, #0x498] ; containsObject:
1029bf9c0: f00eb9e8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1029bf9c4: f946f508    	ldr	x8, [x8, #0xde8] ; addObject:
1029bf9c8: f9016be8    	str	x8, [sp, #0x2d0]
1029bf9cc: f941e3e8    	ldr	x8, [sp, #0x3c0]
1029bf9d0: f9400108    	ldr	x8, [x8]
1029bf9d4: f94177e9    	ldr	x9, [sp, #0x2e8]
1029bf9d8: eb09011f    	cmp	x8, x9
1029bf9dc: 54000060    	b.eq	0x1029bf9e8 <_Flutter_Image_provideRelativePathByUrl+0xdcc898>
1029bf9e0: f94173e0    	ldr	x0, [sp, #0x2e0]
1029bf9e4: 95499ddb    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1029bf9e8: f941dfe8    	ldr	x8, [sp, #0x3b8]
1029bf9ec: f8747916    	ldr	x22, [x8, x20, lsl #3]
1029bf9f0: aa1b03e0    	mov	x0, x27
1029bf9f4: aa1a03f5    	mov	x21, x26
1029bf9f8: aa1a03e1    	mov	x1, x26
1029bf9fc: 95499dd0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfa00: aa1d03fd    	mov	x29, x29
1029bfa04: 95499dd1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfa08: aa0003f8    	mov	x24, x0
1029bfa0c: aa1903e1    	mov	x1, x25
1029bfa10: aa1603e2    	mov	x2, x22
1029bfa14: 95499dca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfa18: aa0003fa    	mov	x26, x0
1029bfa1c: aa1803e0    	mov	x0, x24
1029bfa20: 95499dcd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfa24: 340000ba    	cbz	w26, 0x1029bfa38 <_Flutter_Image_provideRelativePathByUrl+0xdcc8e8>
1029bfa28: f94167e0    	ldr	x0, [sp, #0x2c8]
1029bfa2c: f9416be1    	ldr	x1, [sp, #0x2d0]
1029bfa30: aa1603e2    	mov	x2, x22
1029bfa34: 95499dc2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfa38: 91000694    	add	x20, x20, #0x1
1029bfa3c: eb14039f    	cmp	x28, x20
1029bfa40: aa1503fa    	mov	x26, x21
1029bfa44: 54fffc41    	b.ne	0x1029bf9cc <_Flutter_Image_provideRelativePathByUrl+0xdcc87c>
1029bfa48: 910ec3e2    	add	x2, sp, #0x3b0
1029bfa4c: 9112c3e3    	add	x3, sp, #0x4b0
1029bfa50: f94173e0    	ldr	x0, [sp, #0x2e0]
1029bfa54: f94033e1    	ldr	x1, [sp, #0x60]
1029bfa58: 52800204    	mov	w4, #0x10               ; =16
1029bfa5c: 95499db8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfa60: aa0003fc    	mov	x28, x0
1029bfa64: b5fffa40    	cbnz	x0, 0x1029bf9ac <_Flutter_Image_provideRelativePathByUrl+0xdcc85c>
1029bfa68: f94173e0    	ldr	x0, [sp, #0x2e0]
1029bfa6c: 95499dba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfa70: f94167fc    	ldr	x28, [sp, #0x2c8]
1029bfa74: aa1c03e0    	mov	x0, x28
1029bfa78: f9401bf5    	ldr	x21, [sp, #0x30]
1029bfa7c: aa1503e1    	mov	x1, x21
1029bfa80: 95499daf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfa84: aa0003f4    	mov	x20, x0
1029bfa88: aa1b03e0    	mov	x0, x27
1029bfa8c: aa1a03e1    	mov	x1, x26
1029bfa90: 95499dab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfa94: aa1d03fd    	mov	x29, x29
1029bfa98: 95499dac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfa9c: aa0003f6    	mov	x22, x0
1029bfaa0: aa1503e1    	mov	x1, x21
1029bfaa4: 95499da6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfaa8: aa0003f8    	mov	x24, x0
1029bfaac: aa1603e0    	mov	x0, x22
1029bfab0: 95499da9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfab4: eb18029f    	cmp	x20, x24
1029bfab8: 54002021    	b.ne	0x1029bfebc <_Flutter_Image_provideRelativePathByUrl+0xdccd6c>
1029bfabc: 900ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029bfac0: f9453514    	ldr	x20, [x8, #0xa68]
1029bfac4: aa1b03e0    	mov	x0, x27
1029bfac8: f90177fa    	str	x26, [sp, #0x2e8]
1029bfacc: aa1a03e1    	mov	x1, x26
1029bfad0: 95499d9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfad4: aa1d03fd    	mov	x29, x29
1029bfad8: 95499d9c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfadc: aa0003f6    	mov	x22, x0
1029bfae0: aa1503e1    	mov	x1, x21
1029bfae4: 95499d96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfae8: aa0003f8    	mov	x24, x0
1029bfaec: aa1303e0    	mov	x0, x19
1029bfaf0: f9403bfa    	ldr	x26, [sp, #0x70]
1029bfaf4: aa1a03e1    	mov	x1, x26
1029bfaf8: 95499d91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfafc: aa1d03fd    	mov	x29, x29
1029bfb00: 95499d92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfb04: aa0003f9    	mov	x25, x0
1029bfb08: aa1503e1    	mov	x1, x21
1029bfb0c: 95499d8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfb10: d00ea3c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029bfb14: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029bfb18: a90103f8    	stp	x24, x0, [sp, #0x10]
1029bfb1c: 900de5c8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029bfb20: 912aa108    	add	x8, x8, #0xaa8
1029bfb24: f9416fe9    	ldr	x9, [sp, #0x2d8]
1029bfb28: a90027e8    	stp	x8, x9, [sp]
1029bfb2c: b00c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029bfb30: 9125d063    	add	x3, x3, #0x974
1029bfb34: d00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029bfb38: 9112f8a5    	add	x5, x5, #0x4be
1029bfb3c: d00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029bfb40: 913c94e7    	add	x7, x7, #0xf25
1029bfb44: aa1403e0    	mov	x0, x20
1029bfb48: 52800022    	mov	w2, #0x1                ; =1
1029bfb4c: 52800004    	mov	w4, #0x0                ; =0
1029bfb50: 52807ac6    	mov	w6, #0x3d6              ; =982
1029bfb54: 95499d7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfb58: aa1903e0    	mov	x0, x25
1029bfb5c: 95499d7e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfb60: aa1603e0    	mov	x0, x22
1029bfb64: 95499d7c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfb68: aa1303e0    	mov	x0, x19
1029bfb6c: aa1a03e1    	mov	x1, x26
1029bfb70: 95499d73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfb74: aa1d03fd    	mov	x29, x29
1029bfb78: 95499d74    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfb7c: aa0003f4    	mov	x20, x0
1029bfb80: f00eba28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1029bfb84: f9415101    	ldr	x1, [x8, #0x2a0] ; removeObjectsInArray:
1029bfb88: aa1c03e2    	mov	x2, x28
1029bfb8c: 95499d6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfb90: aa1403e0    	mov	x0, x20
1029bfb94: 95499d70    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfb98: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfb9c: f942d501    	ldr	x1, [x8, #0x5a8] ; fileNum
1029bfba0: aa1b03e0    	mov	x0, x27
1029bfba4: 95499d66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfba8: aa0003e2    	mov	x2, x0
1029bfbac: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfbb0: f942ad01    	ldr	x1, [x8, #0x558] ; setM_fileNum:
1029bfbb4: aa1303e0    	mov	x0, x19
1029bfbb8: 95499d61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfbbc: d00eba08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1029bfbc0: f944c101    	ldr	x1, [x8, #0x980] ; fileSize
1029bfbc4: aa1b03e0    	mov	x0, x27
1029bfbc8: 95499d5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfbcc: aa0003e2    	mov	x2, x0
1029bfbd0: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfbd4: f942b501    	ldr	x1, [x8, #0x568] ; setM_fileSize:
1029bfbd8: aa1303e0    	mov	x0, x19
1029bfbdc: 95499d58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfbe0: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfbe4: f947a101    	ldr	x1, [x8, #0xf40] ; dicBizStat
1029bfbe8: aa1b03e0    	mov	x0, x27
1029bfbec: 95499d54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfbf0: aa1d03fd    	mov	x29, x29
1029bfbf4: 95499d55    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfbf8: aa0003f4    	mov	x20, x0
1029bfbfc: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfc00: f943c101    	ldr	x1, [x8, #0x780] ; setM_dicBizStat:
1029bfc04: aa1303e0    	mov	x0, x19
1029bfc08: aa1403e2    	mov	x2, x20
1029bfc0c: 95499d4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfc10: aa1403e0    	mov	x0, x20
1029bfc14: 95499d50    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfc18: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfc1c: f947a501    	ldr	x1, [x8, #0xf48] ; dicFileTypeInUseStat
1029bfc20: aa1b03e0    	mov	x0, x27
1029bfc24: 95499d46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfc28: aa1d03fd    	mov	x29, x29
1029bfc2c: 95499d47    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfc30: aa0003f4    	mov	x20, x0
1029bfc34: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfc38: f943c901    	ldr	x1, [x8, #0x790] ; setM_dicFileTypeInUseStat:
1029bfc3c: aa1303e0    	mov	x0, x19
1029bfc40: aa1403e2    	mov	x2, x20
1029bfc44: 95499d3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfc48: aa1403e0    	mov	x0, x20
1029bfc4c: 95499d42    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfc50: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfc54: f947a901    	ldr	x1, [x8, #0xf50] ; dicWechatFileClassStat
1029bfc58: aa1b03e0    	mov	x0, x27
1029bfc5c: 95499d38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfc60: aa1d03fd    	mov	x29, x29
1029bfc64: 95499d39    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfc68: aa0003f4    	mov	x20, x0
1029bfc6c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfc70: f9478d01    	ldr	x1, [x8, #0xf18] ; setM_dicWechatFileClassStat:
1029bfc74: aa1303e0    	mov	x0, x19
1029bfc78: aa1403e2    	mov	x2, x20
1029bfc7c: 95499d30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfc80: aa1403e0    	mov	x0, x20
1029bfc84: 95499d34    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfc88: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfc8c: f947dd14    	ldr	x20, [x8, #0xfb8] ; dictOtherDataFileStat
1029bfc90: aa1b03e0    	mov	x0, x27
1029bfc94: aa1403e1    	mov	x1, x20
1029bfc98: 95499d29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfc9c: aa1d03fd    	mov	x29, x29
1029bfca0: 95499d2a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfca4: aa0003f6    	mov	x22, x0
1029bfca8: 95499d2b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfcac: b40001d6    	cbz	x22, 0x1029bfce4 <_Flutter_Image_provideRelativePathByUrl+0xdccb94>
1029bfcb0: aa1b03e0    	mov	x0, x27
1029bfcb4: aa1403e1    	mov	x1, x20
1029bfcb8: 95499d21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfcbc: aa1d03fd    	mov	x29, x29
1029bfcc0: 95499d22    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfcc4: aa0003f4    	mov	x20, x0
1029bfcc8: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfccc: f9437101    	ldr	x1, [x8, #0x6e0] ; setM_dictOtherDataFileStat:
1029bfcd0: aa1303e0    	mov	x0, x19
1029bfcd4: aa1403e2    	mov	x2, x20
1029bfcd8: 95499d19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfcdc: aa1403e0    	mov	x0, x20
1029bfce0: 95499d1d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfce4: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfce8: f947e114    	ldr	x20, [x8, #0xfc0] ; dictCacheDataFileStat
1029bfcec: aa1b03e0    	mov	x0, x27
1029bfcf0: aa1403e1    	mov	x1, x20
1029bfcf4: 95499d12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfcf8: aa1d03fd    	mov	x29, x29
1029bfcfc: 95499d13    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfd00: aa0003f6    	mov	x22, x0
1029bfd04: 95499d14    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfd08: f94163fa    	ldr	x26, [sp, #0x2c0]
1029bfd0c: b40001d6    	cbz	x22, 0x1029bfd44 <_Flutter_Image_provideRelativePathByUrl+0xdccbf4>
1029bfd10: aa1b03e0    	mov	x0, x27
1029bfd14: aa1403e1    	mov	x1, x20
1029bfd18: 95499d09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfd1c: aa1d03fd    	mov	x29, x29
1029bfd20: 95499d0a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfd24: aa0003f4    	mov	x20, x0
1029bfd28: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfd2c: f9437501    	ldr	x1, [x8, #0x6e8] ; setM_dictCacheDataFileStat:
1029bfd30: aa1303e0    	mov	x0, x19
1029bfd34: aa1403e2    	mov	x2, x20
1029bfd38: 95499d01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfd3c: aa1403e0    	mov	x0, x20
1029bfd40: 95499d05    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfd44: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfd48: f947ad01    	ldr	x1, [x8, #0xf58] ; logicFileSize
1029bfd4c: aa1b03e0    	mov	x0, x27
1029bfd50: 95499cfb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfd54: aa0003e2    	mov	x2, x0
1029bfd58: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfd5c: f947b101    	ldr	x1, [x8, #0xf60] ; setM_logicFileSize:
1029bfd60: aa1303e0    	mov	x0, x19
1029bfd64: 95499cf6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfd68: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfd6c: f947b501    	ldr	x1, [x8, #0xf68] ; puffyFileNum
1029bfd70: aa1b03e0    	mov	x0, x27
1029bfd74: 95499cf2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfd78: aa0003e2    	mov	x2, x0
1029bfd7c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfd80: f947b901    	ldr	x1, [x8, #0xf70] ; setM_puffyFileNum:
1029bfd84: aa1303e0    	mov	x0, x19
1029bfd88: 95499ced    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfd8c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfd90: f947bd01    	ldr	x1, [x8, #0xf78] ; puffyFileSize
1029bfd94: aa1b03e0    	mov	x0, x27
1029bfd98: 95499ce9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfd9c: aa0003e2    	mov	x2, x0
1029bfda0: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfda4: f947c101    	ldr	x1, [x8, #0xf80] ; setM_puffyFileSize:
1029bfda8: aa1303e0    	mov	x0, x19
1029bfdac: 95499ce4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfdb0: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfdb4: f947c501    	ldr	x1, [x8, #0xf88] ; puffyLogicFileSize
1029bfdb8: aa1b03e0    	mov	x0, x27
1029bfdbc: 95499ce0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfdc0: aa0003e2    	mov	x2, x0
1029bfdc4: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfdc8: f947c901    	ldr	x1, [x8, #0xf90] ; setM_puffyLogicFileSize:
1029bfdcc: aa1303e0    	mov	x0, x19
1029bfdd0: 95499cdb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfdd4: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfdd8: f947f501    	ldr	x1, [x8, #0xfe8] ; m_changeCacheCount
1029bfddc: aa1303e0    	mov	x0, x19
1029bfde0: 95499cd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfde4: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfde8: f947f901    	ldr	x1, [x8, #0xff0] ; setM_changeCacheCount:
1029bfdec: 11000402    	add	w2, w0, #0x1
1029bfdf0: aa1303e0    	mov	x0, x19
1029bfdf4: 95499cd2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfdf8: aa1303e0    	mov	x0, x19
1029bfdfc: f9403be1    	ldr	x1, [sp, #0x70]
1029bfe00: 95499ccf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfe04: aa1d03fd    	mov	x29, x29
1029bfe08: 95499cd0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfe0c: aa0003f4    	mov	x20, x0
1029bfe10: f9401be1    	ldr	x1, [sp, #0x30]
1029bfe14: 95499cca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfe18: aa0003f6    	mov	x22, x0
1029bfe1c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfe20: f947d501    	ldr	x1, [x8, #0xfa8] ; m_curScannedFileNum
1029bfe24: aa1303e0    	mov	x0, x19
1029bfe28: 95499cc5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfe2c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfe30: f947d901    	ldr	x1, [x8, #0xfb0] ; setM_curScannedFileNum:
1029bfe34: 0b160002    	add	w2, w0, w22
1029bfe38: aa1303e0    	mov	x0, x19
1029bfe3c: 95499cc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfe40: aa1403e0    	mov	x0, x20
1029bfe44: 95499cc4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfe48: aa1b03e0    	mov	x0, x27
1029bfe4c: 95499cbb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029bfe50: f94177e1    	ldr	x1, [sp, #0x2e8]
1029bfe54: 95499cba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfe58: aa1d03fd    	mov	x29, x29
1029bfe5c: 95499cbb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfe60: aa0003f4    	mov	x20, x0
1029bfe64: 95499cbc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfe68: b5000194    	cbnz	x20, 0x1029bfe98 <_Flutter_Image_provideRelativePathByUrl+0xdccd48>
1029bfe6c: b00ebda8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1029bfe70: f9434100    	ldr	x0, [x8, #0x680]
1029bfe74: 95499cb9    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1029bfe78: aa0003f4    	mov	x20, x0
1029bfe7c: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfe80: f947fd01    	ldr	x1, [x8, #0xff8] ; setFileNameSet:
1029bfe84: aa1b03e0    	mov	x0, x27
1029bfe88: aa1403e2    	mov	x2, x20
1029bfe8c: 95499cac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfe90: aa1403e0    	mov	x0, x20
1029bfe94: 95499cb0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfe98: aa1c03e0    	mov	x0, x28
1029bfe9c: 95499cae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfea0: aa1b03e0    	mov	x0, x27
1029bfea4: 95499cac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfea8: f9015fff    	str	xzr, [sp, #0x2b8]
1029bfeac: d2800015    	mov	x21, #0x0               ; =0
1029bfeb0: 1400005c    	b	0x1029c0020 <_Flutter_Image_provideRelativePathByUrl+0xdcced0>
1029bfeb4: 52800034    	mov	w20, #0x1               ; =1
1029bfeb8: 14000550    	b	0x1029c13f8 <_Flutter_Image_provideRelativePathByUrl+0xdce2a8>
1029bfebc: aa1703e0    	mov	x0, x23
1029bfec0: f9415fe1    	ldr	x1, [sp, #0x2b8]
1029bfec4: 95499c9e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfec8: aa1d03fd    	mov	x29, x29
1029bfecc: 95499c9f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bfed0: aa0003f4    	mov	x20, x0
1029bfed4: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfed8: f9474501    	ldr	x1, [x8, #0xe88] ; deleteCacheByFullPath:
1029bfedc: f9416ff5    	ldr	x21, [sp, #0x2d8]
1029bfee0: aa1503e2    	mov	x2, x21
1029bfee4: 95499c96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfee8: aa1403e0    	mov	x0, x20
1029bfeec: 95499c9a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bfef0: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bfef4: f947ed01    	ldr	x1, [x8, #0xfd8] ; m_fileModifyCacheCount
1029bfef8: aa1303e0    	mov	x0, x19
1029bfefc: 95499c90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bff00: b00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bff04: f947f101    	ldr	x1, [x8, #0xfe0] ; setM_fileModifyCacheCount:
1029bff08: 11000402    	add	w2, w0, #0x1
1029bff0c: aa1303e0    	mov	x0, x19
1029bff10: 95499c8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bff14: 900ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029bff18: f9453500    	ldr	x0, [x8, #0xa68]
1029bff1c: d00ea3c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029bff20: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029bff24: 900de5c8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029bff28: 912a2108    	add	x8, x8, #0xa88
1029bff2c: a90057e8    	stp	x8, x21, [sp]
1029bff30: b00c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029bff34: 9125d063    	add	x3, x3, #0x974
1029bff38: d00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029bff3c: 9112f8a5    	add	x5, x5, #0x4be
1029bff40: d00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029bff44: 913c94e7    	add	x7, x7, #0xf25
1029bff48: 52800022    	mov	w2, #0x1                ; =1
1029bff4c: 52800004    	mov	w4, #0x0                ; =0
1029bff50: 52807a26    	mov	w6, #0x3d1              ; =977
1029bff54: 95499c7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bff58: aa1c03e0    	mov	x0, x28
1029bff5c: 95499c7e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bff60: aa1b03e0    	mov	x0, x27
1029bff64: 95499c7c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bff68: f9015fff    	str	xzr, [sp, #0x2b8]
1029bff6c: d2800015    	mov	x21, #0x0               ; =0
1029bff70: b00ebdf4    	adrp	x20, 0x12017c000 <dyld_stub_binder+0x12017c000>
1029bff74: f94153f6    	ldr	x22, [sp, #0x2a0]
1029bff78: b00ea9d8    	adrp	x24, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bff7c: 900ebe48    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1029bff80: f9454500    	ldr	x0, [x8, #0xa88]
1029bff84: 95499c75    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1029bff88: aa0003fb    	mov	x27, x0
1029bff8c: f943d680    	ldr	x0, [x20, #0x7a8]
1029bff90: aa1603e1    	mov	x1, x22
1029bff94: f9416fe2    	ldr	x2, [sp, #0x2d8]
1029bff98: 95499c69    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bff9c: aa1d03fd    	mov	x29, x29
1029bffa0: 95499c6a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bffa4: aa0003f4    	mov	x20, x0
1029bffa8: d00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029bffac: f9400101    	ldr	x1, [x8]
1029bffb0: aa1b03e0    	mov	x0, x27
1029bffb4: aa1403e2    	mov	x2, x20
1029bffb8: 95499c61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bffbc: aa1403e0    	mov	x0, x20
1029bffc0: 95499c65    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bffc4: f9474301    	ldr	x1, [x24, #0xe80] ; m_curStartTime
1029bffc8: aa1303e0    	mov	x0, x19
1029bffcc: 95499c5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bffd0: 2a0003e2    	mov	w2, w0
1029bffd4: d00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029bffd8: f9400501    	ldr	x1, [x8, #0x8] ; setLastScanTime:
1029bffdc: aa1b03e0    	mov	x0, x27
1029bffe0: 95499c57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bffe4: d00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029bffe8: f9400901    	ldr	x1, [x8, #0x10] ; isFolderMayHaveDB
1029bffec: aa1303e0    	mov	x0, x19
1029bfff0: 95499c53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bfff4: b00ea668    	adrp	x8, 0x11fe8c000 <dyld_stub_binder+0x11fe8c000>
1029bfff8: f945bd01    	ldr	x1, [x8, #0xb78] ; setCacheTime:
1029bfffc: 34000080    	cbz	w0, 0x1029c000c <_Flutter_Image_provideRelativePathByUrl+0xdccebc>
1029c0000: aa1b03e0    	mov	x0, x27
1029c0004: 5281c202    	mov	w2, #0xe10              ; =3600
1029c0008: 14000004    	b	0x1029c0018 <_Flutter_Image_provideRelativePathByUrl+0xdccec8>
1029c000c: aa1b03e0    	mov	x0, x27
1029c0010: 528a3002    	mov	w2, #0x5180             ; =20864
1029c0014: 72a00022    	movk	w2, #0x1, lsl #16
1029c0018: 95499c49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c001c: f94163fa    	ldr	x26, [sp, #0x2c0]
1029c0020: f90023f5    	str	x21, [sp, #0x40]
1029c0024: 95499c58    	bl	0x107c27184 <_Flutter_MMFoundation_BindContext+0x4102d68>
1029c0028: 1e604008    	fmov	d8, d0
1029c002c: d00d6168    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1029c0030: f947e108    	ldr	x8, [x8, #0xfc0]
1029c0034: f901c7e8    	str	x8, [sp, #0x388]
1029c0038: b00b1e08    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1029c003c: fd41c100    	ldr	d0, [x8, #0x380]
1029c0040: fd01cbe0    	str	d0, [sp, #0x390]
1029c0044: b0000008    	adrp	x8, 0x1029c1000 <_Flutter_Image_provideRelativePathByUrl+0xdcdeb0>
1029c0048: 91117108    	add	x8, x8, #0x45c
1029c004c: d00d62a9    	adrp	x9, 0x11d616000 <dyld_stub_binder+0x11d616000>
1029c0050: 91272129    	add	x9, x9, #0x9c8
1029c0054: f901cfe8    	str	x8, [sp, #0x398]
1029c0058: f901d3e9    	str	x9, [sp, #0x3a0]
1029c005c: aa1303e0    	mov	x0, x19
1029c0060: 95499c36    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c0064: f901d7f3    	str	x19, [sp, #0x3a8]
1029c0068: 910e23e0    	add	x0, sp, #0x388
1029c006c: 95499c4e    	bl	0x107c271a4 <_Flutter_MMFoundation_BindContext+0x4102d88>
1029c0070: f900ffe0    	str	x0, [sp, #0x1f8]
1029c0074: 4f00e400    	movi.16b	v0, #0x0
1029c0078: ad1a03e0    	stp	q0, q0, [sp, #0x340]
1029c007c: ad1b03e0    	stp	q0, q0, [sp, #0x360]
1029c0080: aa1303e0    	mov	x0, x19
1029c0084: f9403be1    	ldr	x1, [sp, #0x70]
1029c0088: 95499c2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c008c: aa1d03fd    	mov	x29, x29
1029c0090: 95499c2e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0094: 910d03e2    	add	x2, sp, #0x340
1029c0098: 9110c3e3    	add	x3, sp, #0x430
1029c009c: f900f7e0    	str	x0, [sp, #0x1e8]
1029c00a0: f94033e1    	ldr	x1, [sp, #0x60]
1029c00a4: 52800204    	mov	w4, #0x10               ; =16
1029c00a8: 95499c25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c00ac: b40078e0    	cbz	x0, 0x1029c0fc8 <_Flutter_Image_provideRelativePathByUrl+0xdcde78>
1029c00b0: b90087ff    	str	wzr, [sp, #0x84]
1029c00b4: 900ea9c9    	adrp	x9, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c00b8: f941abe8    	ldr	x8, [sp, #0x350]
1029c00bc: 900ea9ca    	adrp	x10, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c00c0: b00ea9cb    	adrp	x11, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c00c4: f9400108    	ldr	x8, [x8]
1029c00c8: f9010be8    	str	x8, [sp, #0x210]
1029c00cc: d00eba4c    	adrp	x12, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029c00d0: b00ea3cd    	adrp	x13, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c00d4: 900eba0e    	adrp	x14, 0x120100000 <dyld_stub_binder+0x120100000>
1029c00d8: d00eb9ef    	adrp	x15, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1029c00dc: b00ea3d0    	adrp	x16, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c00e0: f00eba11    	adrp	x17, 0x120103000 <dyld_stub_binder+0x120103000>
1029c00e4: d00ea401    	adrp	x1, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
1029c00e8: 900ea9c2    	adrp	x2, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c00ec: b00ea663    	adrp	x3, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029c00f0: b00ea9c4    	adrp	x4, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c00f4: b00ea9c5    	adrp	x5, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c00f8: b00ea9c6    	adrp	x6, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c00fc: b00ea9c7    	adrp	x7, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0100: d00eba5c    	adrp	x28, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029c0104: 900ea9d6    	adrp	x22, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0108: 900ea9d8    	adrp	x24, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c010c: b00eba19    	adrp	x25, 0x120101000 <dyld_stub_binder+0x120101000>
1029c0110: 900ea9de    	adrp	x30, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0114: 900ea9d4    	adrp	x20, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0118: b00b1e08    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1029c011c: fd43c109    	ldr	d9, [x8, #0x780]
1029c0120: f9002bfb    	str	x27, [sp, #0x50]
1029c0124: aa1403f5    	mov	x21, x20
1029c0128: d2800014    	mov	x20, #0x0               ; =0
1029c012c: f9470128    	ldr	x8, [x9, #0xe00] ; willStoreToFileIndex
1029c0130: f90153e8    	str	x8, [sp, #0x2a0]
1029c0134: b94087e8    	ldr	w8, [sp, #0x84]
1029c0138: f9473549    	ldr	x9, [x10, #0xe68] ; flattFilePaths
1029c013c: f9014fe9    	str	x9, [sp, #0x298]
1029c0140: f9400d6a    	ldr	x10, [x11, #0x18] ; storeOnlyChatLogFilesToFileIndexService
1029c0144: f9465189    	ldr	x9, [x12, #0xca0] ; stringByAppendingPathComponent:
1029c0148: f90167e9    	str	x9, [sp, #0x2c8]
1029c014c: f94679a9    	ldr	x9, [x13, #0xcf0] ; FileExist:
1029c0150: f9004be9    	str	x9, [sp, #0x90]
1029c0154: f9424dc9    	ldr	x9, [x14, #0x498] ; containsObject:
1029c0158: f90037e9    	str	x9, [sp, #0x68]
1029c015c: f946f5e9    	ldr	x9, [x15, #0xde8] ; addObject:
1029c0160: a90eabe9    	stp	x9, x10, [sp, #0xe8]
1029c0164: f942aa09    	ldr	x9, [x16, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c0168: f90173e9    	str	x9, [sp, #0x2e0]
1029c016c: f9434e29    	ldr	x9, [x17, #0x698] ; isBeingDebugged
1029c0170: f90027e9    	str	x9, [sp, #0x48]
1029c0174: f943a029    	ldr	x9, [x1, #0x740] ; logWithLevel:module:file:line:func:printXLog:format:
1029c0178: f90017e9    	str	x9, [sp, #0x28]
1029c017c: f9463849    	ldr	x9, [x2, #0xc70] ; willReportExistC2CFile
1029c0180: f9014be9    	str	x9, [sp, #0x290]
1029c0184: f947a86a    	ldr	x10, [x3, #0xf50] ; m_onlyBizType
1029c0188: f9401089    	ldr	x9, [x4, #0x20] ; analyseC2CFile:FolderPath:FileName:BizType:
1029c018c: a90d2be9    	stp	x9, x10, [sp, #0xd0]
1029c0190: f94014a9    	ldr	x9, [x5, #0x28] ; fileMatchedBizType:inFolder:
1029c0194: f90147e9    	str	x9, [sp, #0x288]
1029c0198: f94018c9    	ldr	x9, [x6, #0x30] ; deleteFile:matchInfo:inFolder:withScanConfig:fileSize:logicFileSize:latestTimeInterval:
1029c019c: f90143e9    	str	x9, [sp, #0x280]
1029c01a0: f9401ce9    	ldr	x9, [x7, #0x38] ; addIfNeededWithName:size:latestTimeInterval:
1029c01a4: f9013fe9    	str	x9, [sp, #0x278]
1029c01a8: f946a789    	ldr	x9, [x28, #0xd48] ; stringWithFormat:
1029c01ac: f900fbe9    	str	x9, [sp, #0x1f0]
1029c01b0: f942d6ca    	ldr	x10, [x22, #0x5a8] ; fileNum
1029c01b4: f942db09    	ldr	x9, [x24, #0x5b0] ; setFileNum:
1029c01b8: a91cabe9    	stp	x9, x10, [sp, #0x1c8]
1029c01bc: f944c32a    	ldr	x10, [x25, #0x980] ; fileSize
1029c01c0: 900ea409    	adrp	x9, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1029c01c4: f9425929    	ldr	x9, [x9, #0x4b0] ; setFileSize:
1029c01c8: a91babe9    	stp	x9, x10, [sp, #0x1b8]
1029c01cc: f947afca    	ldr	x10, [x30, #0xf58] ; logicFileSize
1029c01d0: b00ea9c9    	adrp	x9, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c01d4: f9402129    	ldr	x9, [x9, #0x40] ; setLogicFileSize:
1029c01d8: a91aabe9    	stp	x9, x10, [sp, #0x1a8]
1029c01dc: 900ea9c9    	adrp	x9, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c01e0: f947e529    	ldr	x9, [x9, #0xfc8] ; isFileCanNotChangeSize:
1029c01e4: f900d3e9    	str	x9, [sp, #0x1a0]
1029c01e8: f947eaaa    	ldr	x10, [x21, #0xfd0]
1029c01ec: 900ea9c9    	adrp	x9, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c01f0: f947b529    	ldr	x9, [x9, #0xf68] ; puffyFileNum
1029c01f4: a90c2be9    	stp	x9, x10, [sp, #0xc0]
1029c01f8: b00ea9c9    	adrp	x9, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c01fc: f940252a    	ldr	x10, [x9, #0x48] ; setPuffyFileNum:
1029c0200: 900ea9c9    	adrp	x9, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0204: f947bd29    	ldr	x9, [x9, #0xf78] ; puffyFileSize
1029c0208: a90b2be9    	stp	x9, x10, [sp, #0xb0]
1029c020c: 11000518    	add	w24, w8, #0x1
1029c0210: 0b000108    	add	w8, w8, w0
1029c0214: b90087e8    	str	w8, [sp, #0x84]
1029c0218: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c021c: f9402909    	ldr	x9, [x8, #0x50] ; setPuffyFileSize:
1029c0220: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0224: f947c508    	ldr	x8, [x8, #0xf88] ; puffyLogicFileSize
1029c0228: a90a27e8    	stp	x8, x9, [sp, #0xa0]
1029c022c: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0230: f9402d08    	ldr	x8, [x8, #0x58] ; setPuffyLogicFileSize:
1029c0234: f9004fe8    	str	x8, [sp, #0x98]
1029c0238: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c023c: f947a109    	ldr	x9, [x8, #0xf40] ; dicBizStat
1029c0240: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0244: f9403108    	ldr	x8, [x8, #0x60] ; addBizFileStat:bizType:fileSize:fileInterval:
1029c0248: f9013be8    	str	x8, [sp, #0x270]
1029c024c: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0250: f947a508    	ldr	x8, [x8, #0xf48] ; dicFileTypeInUseStat
1029c0254: a91927e8    	stp	x8, x9, [sp, #0x190]
1029c0258: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c025c: f9403508    	ldr	x8, [x8, #0x68] ; addFileTypeInUseStat:fileTypeInUse:fileSize:
1029c0260: f90137e8    	str	x8, [sp, #0x268]
1029c0264: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0268: f947a908    	ldr	x8, [x8, #0xf50] ; dicWechatFileClassStat
1029c026c: f900c7e8    	str	x8, [sp, #0x188]
1029c0270: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0274: f9403908    	ldr	x8, [x8, #0x70] ; addFileClassStat:fileClassType:fileSize:
1029c0278: f90133e8    	str	x8, [sp, #0x260]
1029c027c: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0280: f942a908    	ldr	x8, [x8, #0x550] ; m_fileNum
1029c0284: f9012fe8    	str	x8, [sp, #0x258]
1029c0288: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c028c: f942ad08    	ldr	x8, [x8, #0x558] ; setM_fileNum:
1029c0290: f9012be8    	str	x8, [sp, #0x250]
1029c0294: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0298: f942b108    	ldr	x8, [x8, #0x560] ; m_fileSize
1029c029c: f90127e8    	str	x8, [sp, #0x248]
1029c02a0: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c02a4: f942b508    	ldr	x8, [x8, #0x568] ; setM_fileSize:
1029c02a8: f90123e8    	str	x8, [sp, #0x240]
1029c02ac: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c02b0: f9403d08    	ldr	x8, [x8, #0x78] ; m_logicFileSize
1029c02b4: f9011fe8    	str	x8, [sp, #0x238]
1029c02b8: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c02bc: f947b108    	ldr	x8, [x8, #0xf60] ; setM_logicFileSize:
1029c02c0: f9011be8    	str	x8, [sp, #0x230]
1029c02c4: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c02c8: f9404109    	ldr	x9, [x8, #0x80] ; m_puffyFileNum
1029c02cc: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c02d0: f947b908    	ldr	x8, [x8, #0xf70] ; setM_puffyFileNum:
1029c02d4: a917a7e8    	stp	x8, x9, [sp, #0x178]
1029c02d8: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c02dc: f9404509    	ldr	x9, [x8, #0x88] ; m_puffyFileSize
1029c02e0: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c02e4: f947c108    	ldr	x8, [x8, #0xf80] ; setM_puffyFileSize:
1029c02e8: a916a7e8    	stp	x8, x9, [sp, #0x168]
1029c02ec: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c02f0: f9404909    	ldr	x9, [x8, #0x90] ; m_puffyLogicFileSize
1029c02f4: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c02f8: f947c908    	ldr	x8, [x8, #0xf90] ; setM_puffyLogicFileSize:
1029c02fc: a915a7e8    	stp	x8, x9, [sp, #0x158]
1029c0300: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0304: f947d508    	ldr	x8, [x8, #0xfa8] ; m_curScannedFileNum
1029c0308: f90117e8    	str	x8, [sp, #0x228]
1029c030c: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0310: f947d908    	ldr	x8, [x8, #0xfb0] ; setM_curScannedFileNum:
1029c0314: f90113e8    	str	x8, [sp, #0x220]
1029c0318: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c031c: f9406508    	ldr	x8, [x8, #0xc8] ; addFileCacheDataBizStat:bizType:fileSize:
1029c0320: f9002fe8    	str	x8, [sp, #0x58]
1029c0324: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0328: f9406108    	ldr	x8, [x8, #0xc0] ; addFileOtherDataBizStat:bizType:fileSize:
1029c032c: f90073e8    	str	x8, [sp, #0xe0]
1029c0330: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0334: f9404d09    	ldr	x9, [x8, #0x98] ; addBizDelFileStat:bizType:delFileSize:
1029c0338: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c033c: f942b908    	ldr	x8, [x8, #0x570] ; m_delFileNum
1029c0340: a914a7e8    	stp	x8, x9, [sp, #0x148]
1029c0344: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0348: f942bd09    	ldr	x9, [x8, #0x578] ; setM_delFileNum:
1029c034c: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0350: f942c108    	ldr	x8, [x8, #0x580] ; m_delFileSize
1029c0354: a913a7e8    	stp	x8, x9, [sp, #0x138]
1029c0358: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c035c: f942c509    	ldr	x9, [x8, #0x588] ; setM_delFileSize:
1029c0360: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0364: f9405108    	ldr	x8, [x8, #0xa0] ; m_curDelFileNum
1029c0368: a912a7e8    	stp	x8, x9, [sp, #0x128]
1029c036c: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0370: f9405509    	ldr	x9, [x8, #0xa8] ; setM_curDelFileNum:
1029c0374: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0378: f9405908    	ldr	x8, [x8, #0xb0] ; m_curDelFileSize
1029c037c: a911a7e8    	stp	x8, x9, [sp, #0x118]
1029c0380: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0384: f9405d09    	ldr	x9, [x8, #0xb8] ; setM_curDelFileSize:
1029c0388: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c038c: f9461508    	ldr	x8, [x8, #0xc28] ; scannerStatus
1029c0390: f9010fe8    	str	x8, [sp, #0x218]
1029c0394: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0398: f9406908    	ldr	x8, [x8, #0xd0] ; slowDownCheckSubFileNum
1029c039c: f9016be8    	str	x8, [sp, #0x2d0]
1029c03a0: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c03a4: f9406d08    	ldr	x8, [x8, #0xd8] ; slowDownSleepMillisecond
1029c03a8: f90047e8    	str	x8, [sp, #0x88]
1029c03ac: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c03b0: f9462508    	ldr	x8, [x8, #0xc48] ; willScanWholeWechat
1029c03b4: f90103e8    	str	x8, [sp, #0x200]
1029c03b8: b00ea5c8    	adrp	x8, 0x11fe79000 <dyld_stub_binder+0x11fe79000>
1029c03bc: f9477d08    	ldr	x8, [x8, #0xef8] ; isInBackground
1029c03c0: a910a7e8    	stp	x8, x9, [sp, #0x108]
1029c03c4: 900ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c03c8: f9462d08    	ldr	x8, [x8, #0xc58] ; suspensionCheckFileCount
1029c03cc: f90083e8    	str	x8, [sp, #0x100]
1029c03d0: 900ea9a8    	adrp	x8, 0x11fef4000 <dyld_stub_binder+0x11fef4000>
1029c03d4: f945b908    	ldr	x8, [x8, #0xb70] ; workQueue
1029c03d8: f9001fe8    	str	x8, [sp, #0x38]
1029c03dc: f90107e0    	str	x0, [sp, #0x208]
1029c03e0: f941abe8    	ldr	x8, [sp, #0x350]
1029c03e4: f9400108    	ldr	x8, [x8]
1029c03e8: f9410be9    	ldr	x9, [sp, #0x210]
1029c03ec: eb09011f    	cmp	x8, x9
1029c03f0: 54000060    	b.eq	0x1029c03fc <_Flutter_Image_provideRelativePathByUrl+0xdcd2ac>
1029c03f4: f940f7e0    	ldr	x0, [sp, #0x1e8]
1029c03f8: 95499b56    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1029c03fc: f941a7e8    	ldr	x8, [sp, #0x348]
1029c0400: f8747916    	ldr	x22, [x8, x20, lsl #3]
1029c0404: 95499b67    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1029c0408: f90177e0    	str	x0, [sp, #0x2e8]
1029c040c: aa1a03e0    	mov	x0, x26
1029c0410: f94153e1    	ldr	x1, [sp, #0x2a0]
1029c0414: 95499b4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0418: f9414ffc    	ldr	x28, [sp, #0x298]
1029c041c: 34000d80    	cbz	w0, 0x1029c05cc <_Flutter_Image_provideRelativePathByUrl+0xdcd47c>
1029c0420: aa1703e0    	mov	x0, x23
1029c0424: aa1c03e1    	mov	x1, x28
1029c0428: 95499b45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c042c: aa1d03fd    	mov	x29, x29
1029c0430: 95499b46    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0434: aa0003f9    	mov	x25, x0
1029c0438: 95499b47    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c043c: b4000c99    	cbz	x25, 0x1029c05cc <_Flutter_Image_provideRelativePathByUrl+0xdcd47c>
1029c0440: aa1703e0    	mov	x0, x23
1029c0444: f9407be1    	ldr	x1, [sp, #0xf0]
1029c0448: 95499b3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c044c: 340000a0    	cbz	w0, 0x1029c0460 <_Flutter_Image_provideRelativePathByUrl+0xdcd310>
1029c0450: f940ffe0    	ldr	x0, [sp, #0x1f8]
1029c0454: f9400808    	ldr	x8, [x0, #0x10]
1029c0458: d63f0100    	blr	x8
1029c045c: 34000b80    	cbz	w0, 0x1029c05cc <_Flutter_Image_provideRelativePathByUrl+0xdcd47c>
1029c0460: f9416fe0    	ldr	x0, [sp, #0x2d8]
1029c0464: f94167e1    	ldr	x1, [sp, #0x2c8]
1029c0468: aa1603e2    	mov	x2, x22
1029c046c: 95499b34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0470: aa1d03fd    	mov	x29, x29
1029c0474: 95499b35    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0478: aa0003f9    	mov	x25, x0
1029c047c: f00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c0480: f9463500    	ldr	x0, [x8, #0xc68]
1029c0484: f9404be1    	ldr	x1, [sp, #0x90]
1029c0488: aa1903e2    	mov	x2, x25
1029c048c: 95499b2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0490: 340009a0    	cbz	w0, 0x1029c05c4 <_Flutter_Image_provideRelativePathByUrl+0xdcd474>
1029c0494: aa1703e0    	mov	x0, x23
1029c0498: aa1c03e1    	mov	x1, x28
1029c049c: 95499b28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c04a0: aa1d03fd    	mov	x29, x29
1029c04a4: 95499b29    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c04a8: aa0003fb    	mov	x27, x0
1029c04ac: 95499b44    	bl	0x107c271bc <_Flutter_MMFoundation_BindContext+0x4102da0>
1029c04b0: aa1703e0    	mov	x0, x23
1029c04b4: aa1c03e1    	mov	x1, x28
1029c04b8: 95499b21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c04bc: aa1d03fd    	mov	x29, x29
1029c04c0: 95499b22    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c04c4: aa0003f5    	mov	x21, x0
1029c04c8: f94037e1    	ldr	x1, [sp, #0x68]
1029c04cc: aa1903e2    	mov	x2, x25
1029c04d0: 95499b1b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c04d4: aa0003fa    	mov	x26, x0
1029c04d8: aa1503e0    	mov	x0, x21
1029c04dc: 95499b1e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c04e0: 340004fa    	cbz	w26, 0x1029c057c <_Flutter_Image_provideRelativePathByUrl+0xdcd42c>
1029c04e4: f00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c04e8: f9453500    	ldr	x0, [x8, #0xa68]
1029c04ec: f00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c04f0: 912ba108    	add	x8, x8, #0xae8
1029c04f4: a90067e8    	stp	x8, x25, [sp]
1029c04f8: f94173e1    	ldr	x1, [sp, #0x2e0]
1029c04fc: 52800082    	mov	w2, #0x4                ; =4
1029c0500: 900c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c0504: 9125d063    	add	x3, x3, #0x974
1029c0508: 52800004    	mov	w4, #0x0                ; =0
1029c050c: b00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0510: 9112f8a5    	add	x5, x5, #0x4be
1029c0514: 52808346    	mov	w6, #0x41a              ; =1050
1029c0518: b00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c051c: 913c94e7    	add	x7, x7, #0xf25
1029c0520: 95499b07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0524: f00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c0528: f9467900    	ldr	x0, [x8, #0xcf0]
1029c052c: f94027e1    	ldr	x1, [sp, #0x48]
1029c0530: 95499b03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0534: 340003a0    	cbz	w0, 0x1029c05a8 <_Flutter_Image_provideRelativePathByUrl+0xdcd458>
1029c0538: b00ebda8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1029c053c: f940e900    	ldr	x0, [x8, #0x1d0]
1029c0540: f00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c0544: 912c2108    	add	x8, x8, #0xb08
1029c0548: f90003e8    	str	x8, [sp]
1029c054c: f94017e1    	ldr	x1, [sp, #0x28]
1029c0550: 528000e2    	mov	w2, #0x7                ; =7
1029c0554: b00cff83    	adrp	x3, 0x11c9b1000 <dyld_stub_binder+0x11c9b1000>
1029c0558: 91355063    	add	x3, x3, #0xd54
1029c055c: b00c5e24    	adrp	x4, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0560: 9112f884    	add	x4, x4, #0x4be
1029c0564: 52808385    	mov	w5, #0x41c              ; =1052
1029c0568: b00c5e26    	adrp	x6, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c056c: 913c94c6    	add	x6, x6, #0xf25
1029c0570: 52800027    	mov	w7, #0x1                ; =1
1029c0574: 95499af2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0578: 1400000c    	b	0x1029c05a8 <_Flutter_Image_provideRelativePathByUrl+0xdcd458>
1029c057c: aa1703e0    	mov	x0, x23
1029c0580: aa1c03e1    	mov	x1, x28
1029c0584: 95499aee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0588: aa1d03fd    	mov	x29, x29
1029c058c: 95499aef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0590: aa0003f5    	mov	x21, x0
1029c0594: f94077e1    	ldr	x1, [sp, #0xe8]
1029c0598: aa1903e2    	mov	x2, x25
1029c059c: 95499ae8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c05a0: aa1503e0    	mov	x0, x21
1029c05a4: 95499aec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c05a8: aa1b03e0    	mov	x0, x27
1029c05ac: 95499b12    	bl	0x107c271f4 <_Flutter_MMFoundation_BindContext+0x4102dd8>
1029c05b0: aa1b03e0    	mov	x0, x27
1029c05b4: 95499ae8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c05b8: f94163fa    	ldr	x26, [sp, #0x2c0]
1029c05bc: 900ea9d5    	adrp	x21, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c05c0: f9402bfb    	ldr	x27, [sp, #0x50]
1029c05c4: aa1903e0    	mov	x0, x25
1029c05c8: 95499ae3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c05cc: aa1a03e0    	mov	x0, x26
1029c05d0: f9414be1    	ldr	x1, [sp, #0x290]
1029c05d4: 95499ada    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c05d8: 340001e0    	cbz	w0, 0x1029c0614 <_Flutter_Image_provideRelativePathByUrl+0xdcd4c4>
1029c05dc: f940ffe0    	ldr	x0, [sp, #0x1f8]
1029c05e0: f9400808    	ldr	x8, [x0, #0x10]
1029c05e4: d63f0100    	blr	x8
1029c05e8: 34000160    	cbz	w0, 0x1029c0614 <_Flutter_Image_provideRelativePathByUrl+0xdcd4c4>
1029c05ec: aa1303e0    	mov	x0, x19
1029c05f0: f9406fe1    	ldr	x1, [sp, #0xd8]
1029c05f4: 95499ad2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c05f8: aa0003e5    	mov	x5, x0
1029c05fc: aa1703e0    	mov	x0, x23
1029c0600: f9406be1    	ldr	x1, [sp, #0xd0]
1029c0604: aa1303e2    	mov	x2, x19
1029c0608: f9416fe3    	ldr	x3, [sp, #0x2d8]
1029c060c: aa1603e4    	mov	x4, x22
1029c0610: 95499acb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0614: f9416fe0    	ldr	x0, [sp, #0x2d8]
1029c0618: f94167e1    	ldr	x1, [sp, #0x2c8]
1029c061c: aa1603e2    	mov	x2, x22
1029c0620: 95499ac7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0624: aa1d03fd    	mov	x29, x29
1029c0628: 95499ac8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c062c: aa0003f9    	mov	x25, x0
1029c0630: 900ebde8    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
1029c0634: f943c500    	ldr	x0, [x8, #0x788]
1029c0638: 910ca3e8    	add	x8, sp, #0x328
1029c063c: f94147e1    	ldr	x1, [sp, #0x288]
1029c0640: aa1603e2    	mov	x2, x22
1029c0644: aa1303e3    	mov	x3, x19
1029c0648: 95499abd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c064c: f90193ff    	str	xzr, [sp, #0x320]
1029c0650: f9018fff    	str	xzr, [sp, #0x318]
1029c0654: f9018bff    	str	xzr, [sp, #0x310]
1029c0658: 9108a7e8    	add	x8, sp, #0x229
1029c065c: 3ccff100    	ldur	q0, [x8, #0xff]
1029c0660: 3d80bfe0    	str	q0, [sp, #0x2f0]
1029c0664: f9419fe8    	ldr	x8, [sp, #0x338]
1029c0668: f90183e8    	str	x8, [sp, #0x300]
1029c066c: 910c43e8    	add	x8, sp, #0x310
1029c0670: f90003e8    	str	x8, [sp]
1029c0674: 910bc3e3    	add	x3, sp, #0x2f0
1029c0678: 910c83e6    	add	x6, sp, #0x320
1029c067c: 910c63e7    	add	x7, sp, #0x318
1029c0680: aa1703e0    	mov	x0, x23
1029c0684: f94143e1    	ldr	x1, [sp, #0x280]
1029c0688: aa1903e2    	mov	x2, x25
1029c068c: aa1303e4    	mov	x4, x19
1029c0690: aa1a03e5    	mov	x5, x26
1029c0694: 95499aaa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0698: aa0003fc    	mov	x28, x0
1029c069c: f94193e3    	ldr	x3, [sp, #0x320]
1029c06a0: fd418be0    	ldr	d0, [sp, #0x310]
1029c06a4: 5e61d800    	scvtf	d0, d0
1029c06a8: f9415fe0    	ldr	x0, [sp, #0x2b8]
1029c06ac: f9413fe1    	ldr	x1, [sp, #0x278]
1029c06b0: aa1603e2    	mov	x2, x22
1029c06b4: 95499aa2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c06b8: f9418fe8    	ldr	x8, [sp, #0x318]
1029c06bc: 52928029    	mov	w9, #0x9401             ; =37889
1029c06c0: 72aee6a9    	movk	w9, #0x7735, lsl #16
1029c06c4: eb09011f    	cmp	x8, x9
1029c06c8: 54000503    	b.lo	0x1029c0768 <_Flutter_Image_provideRelativePathByUrl+0xdcd618>
1029c06cc: f00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c06d0: f9453500    	ldr	x0, [x8, #0xa68]
1029c06d4: f94193e8    	ldr	x8, [sp, #0x320]
1029c06d8: a900a3f9    	stp	x25, x8, [sp, #0x8]
1029c06dc: f00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c06e0: 912ca108    	add	x8, x8, #0xb28
1029c06e4: f90003e8    	str	x8, [sp]
1029c06e8: f94173e1    	ldr	x1, [sp, #0x2e0]
1029c06ec: 52800082    	mov	w2, #0x4                ; =4
1029c06f0: 900c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c06f4: 9125d063    	add	x3, x3, #0x974
1029c06f8: 52800004    	mov	w4, #0x0                ; =0
1029c06fc: b00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0700: 9112f8a5    	add	x5, x5, #0x4be
1029c0704: 528087c6    	mov	w6, #0x43e              ; =1086
1029c0708: b00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c070c: 913c94e7    	add	x7, x7, #0xf25
1029c0710: 95499a8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0714: f00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c0718: f9454500    	ldr	x0, [x8, #0xa88]
1029c071c: f94193e8    	ldr	x8, [sp, #0x320]
1029c0720: f9418fe9    	ldr	x9, [sp, #0x318]
1029c0724: a90027e8    	stp	x8, x9, [sp]
1029c0728: f940fbe1    	ldr	x1, [sp, #0x1f0]
1029c072c: f00de5a2    	adrp	x2, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c0730: 912d2042    	add	x2, x2, #0xb48
1029c0734: 95499a82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0738: aa1d03fd    	mov	x29, x29
1029c073c: 95499a83    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0740: aa0003f5    	mov	x21, x0
1029c0744: 528caf60    	mov	w0, #0x657b             ; =25979
1029c0748: aa1503e1    	mov	x1, x21
1029c074c: 52800002    	mov	w2, #0x0                ; =0
1029c0750: 52800003    	mov	w3, #0x0                ; =0
1029c0754: 97e2b163    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
1029c0758: aa1503e0    	mov	x0, x21
1029c075c: 900ea9d5    	adrp	x21, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0760: 95499a7d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0764: f9418fe8    	ldr	x8, [sp, #0x318]
1029c0768: 52986a29    	mov	w9, #0xc351             ; =50001
1029c076c: eb09011f    	cmp	x8, x9
1029c0770: 54000643    	b.lo	0x1029c0838 <_Flutter_Image_provideRelativePathByUrl+0xdcd6e8>
1029c0774: f94193e9    	ldr	x9, [sp, #0x320]
1029c0778: 9e630120    	ucvtf	d0, x9
1029c077c: 9e630101    	ucvtf	d1, x8
1029c0780: 1e690821    	fmul	d1, d1, d9
1029c0784: 1e602020    	fcmp	d1, d0
1029c0788: 5400058d    	b.le	0x1029c0838 <_Flutter_Image_provideRelativePathByUrl+0xdcd6e8>
1029c078c: f00ebd8a    	adrp	x10, 0x120173000 <dyld_stub_binder+0x120173000>
1029c0790: f9453540    	ldr	x0, [x10, #0xa68]
1029c0794: a90127e8    	stp	x8, x9, [sp, #0x10]
1029c0798: f00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c079c: 912da108    	add	x8, x8, #0xb68
1029c07a0: a90067e8    	stp	x8, x25, [sp]
1029c07a4: f94173e1    	ldr	x1, [sp, #0x2e0]
1029c07a8: 52800062    	mov	w2, #0x3                ; =3
1029c07ac: 900c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c07b0: 9125d063    	add	x3, x3, #0x974
1029c07b4: 52800004    	mov	w4, #0x0                ; =0
1029c07b8: b00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c07bc: 9112f8a5    	add	x5, x5, #0x4be
1029c07c0: 528088a6    	mov	w6, #0x445              ; =1093
1029c07c4: b00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c07c8: 913c94e7    	add	x7, x7, #0xf25
1029c07cc: 95499a5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c07d0: f9418fe8    	ldr	x8, [sp, #0x318]
1029c07d4: 52994029    	mov	w9, #0xca01             ; =51713
1029c07d8: 72a77349    	movk	w9, #0x3b9a, lsl #16
1029c07dc: eb09011f    	cmp	x8, x9
1029c07e0: 54000283    	b.lo	0x1029c0830 <_Flutter_Image_provideRelativePathByUrl+0xdcd6e0>
1029c07e4: f00ebd89    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
1029c07e8: f9454520    	ldr	x0, [x9, #0xa88]
1029c07ec: f94193e9    	ldr	x9, [sp, #0x320]
1029c07f0: a90023e9    	stp	x9, x8, [sp]
1029c07f4: f940fbe1    	ldr	x1, [sp, #0x1f0]
1029c07f8: f00de5a2    	adrp	x2, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c07fc: 912e2042    	add	x2, x2, #0xb88
1029c0800: 95499a4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0804: aa1d03fd    	mov	x29, x29
1029c0808: 95499a50    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c080c: aa0003f5    	mov	x21, x0
1029c0810: 528caf60    	mov	w0, #0x657b             ; =25979
1029c0814: aa1503e1    	mov	x1, x21
1029c0818: 52800002    	mov	w2, #0x0                ; =0
1029c081c: 52800003    	mov	w3, #0x0                ; =0
1029c0820: 97e2b130    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
1029c0824: aa1503e0    	mov	x0, x21
1029c0828: 900ea9d5    	adrp	x21, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c082c: 95499a4a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0830: 5280003a    	mov	w26, #0x1               ; =1
1029c0834: 14000002    	b	0x1029c083c <_Flutter_Image_provideRelativePathByUrl+0xdcd6ec>
1029c0838: 5280001a    	mov	w26, #0x0               ; =0
1029c083c: f100037f    	cmp	x27, #0x0
1029c0840: 1a9f1788    	csinc	w8, w28, wzr, ne
1029c0844: 37000d88    	tbnz	w8, #0x0, 0x1029c09f4 <_Flutter_Image_provideRelativePathByUrl+0xdcd8a4>
1029c0848: aa1b03e0    	mov	x0, x27
1029c084c: f940ebe1    	ldr	x1, [sp, #0x1d0]
1029c0850: 95499a3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0854: 11000402    	add	w2, w0, #0x1
1029c0858: aa1b03e0    	mov	x0, x27
1029c085c: f940e7e1    	ldr	x1, [sp, #0x1c8]
1029c0860: 95499a37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0864: aa1b03e0    	mov	x0, x27
1029c0868: f940e3e1    	ldr	x1, [sp, #0x1c0]
1029c086c: 95499a34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0870: f94193e8    	ldr	x8, [sp, #0x320]
1029c0874: 8b000102    	add	x2, x8, x0
1029c0878: aa1b03e0    	mov	x0, x27
1029c087c: f940dfe1    	ldr	x1, [sp, #0x1b8]
1029c0880: 95499a2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0884: aa1b03e0    	mov	x0, x27
1029c0888: f940dbe1    	ldr	x1, [sp, #0x1b0]
1029c088c: 95499a2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0890: f9418fe8    	ldr	x8, [sp, #0x318]
1029c0894: 8b000102    	add	x2, x8, x0
1029c0898: aa1b03e0    	mov	x0, x27
1029c089c: f940d7e1    	ldr	x1, [sp, #0x1a8]
1029c08a0: 95499a27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c08a4: aa1703e0    	mov	x0, x23
1029c08a8: f940d3e1    	ldr	x1, [sp, #0x1a0]
1029c08ac: aa1303e2    	mov	x2, x19
1029c08b0: 95499a23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c08b4: 34000180    	cbz	w0, 0x1029c08e4 <_Flutter_Image_provideRelativePathByUrl+0xdcd794>
1029c08b8: aa1b03e0    	mov	x0, x27
1029c08bc: f94067e1    	ldr	x1, [sp, #0xc8]
1029c08c0: 95499a1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c08c4: aa1d03fd    	mov	x29, x29
1029c08c8: 95499a20    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c08cc: aa0003f5    	mov	x21, x0
1029c08d0: f94077e1    	ldr	x1, [sp, #0xe8]
1029c08d4: aa1603e2    	mov	x2, x22
1029c08d8: 95499a19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c08dc: aa1503e0    	mov	x0, x21
1029c08e0: 95499a1d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c08e4: 3400031a    	cbz	w26, 0x1029c0944 <_Flutter_Image_provideRelativePathByUrl+0xdcd7f4>
1029c08e8: aa1b03e0    	mov	x0, x27
1029c08ec: f94063e1    	ldr	x1, [sp, #0xc0]
1029c08f0: 95499a13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c08f4: 11000402    	add	w2, w0, #0x1
1029c08f8: aa1b03e0    	mov	x0, x27
1029c08fc: f9405fe1    	ldr	x1, [sp, #0xb8]
1029c0900: 95499a0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0904: aa1b03e0    	mov	x0, x27
1029c0908: f9405be1    	ldr	x1, [sp, #0xb0]
1029c090c: 95499a0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0910: f94193e8    	ldr	x8, [sp, #0x320]
1029c0914: 8b000102    	add	x2, x8, x0
1029c0918: aa1b03e0    	mov	x0, x27
1029c091c: f94057e1    	ldr	x1, [sp, #0xa8]
1029c0920: 95499a07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0924: aa1b03e0    	mov	x0, x27
1029c0928: f94053e1    	ldr	x1, [sp, #0xa0]
1029c092c: 95499a04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0930: f9418fe8    	ldr	x8, [sp, #0x318]
1029c0934: 8b000102    	add	x2, x8, x0
1029c0938: aa1b03e0    	mov	x0, x27
1029c093c: f9404fe1    	ldr	x1, [sp, #0x98]
1029c0940: 954999ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0944: aa1b03e0    	mov	x0, x27
1029c0948: f940cfe1    	ldr	x1, [sp, #0x198]
1029c094c: 954999fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0950: aa1d03fd    	mov	x29, x29
1029c0954: 954999fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0958: aa0003f5    	mov	x21, x0
1029c095c: f94197e3    	ldr	x3, [sp, #0x328]
1029c0960: f94193e4    	ldr	x4, [sp, #0x320]
1029c0964: f9418be5    	ldr	x5, [sp, #0x310]
1029c0968: aa1703e0    	mov	x0, x23
1029c096c: f9413be1    	ldr	x1, [sp, #0x270]
1029c0970: aa1503e2    	mov	x2, x21
1029c0974: 954999f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0978: aa1503e0    	mov	x0, x21
1029c097c: 954999f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0980: aa1b03e0    	mov	x0, x27
1029c0984: f940cbe1    	ldr	x1, [sp, #0x190]
1029c0988: 954999ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c098c: aa1d03fd    	mov	x29, x29
1029c0990: 954999ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0994: aa0003f5    	mov	x21, x0
1029c0998: b9433be3    	ldr	w3, [sp, #0x338]
1029c099c: f94193e4    	ldr	x4, [sp, #0x320]
1029c09a0: aa1703e0    	mov	x0, x23
1029c09a4: f94137e1    	ldr	x1, [sp, #0x268]
1029c09a8: aa1503e2    	mov	x2, x21
1029c09ac: 954999e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c09b0: aa1503e0    	mov	x0, x21
1029c09b4: 954999e8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c09b8: aa1b03e0    	mov	x0, x27
1029c09bc: f940c7e1    	ldr	x1, [sp, #0x188]
1029c09c0: 954999df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c09c4: aa1d03fd    	mov	x29, x29
1029c09c8: 954999e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c09cc: aa0003f5    	mov	x21, x0
1029c09d0: b9433fe3    	ldr	w3, [sp, #0x33c]
1029c09d4: f94193e4    	ldr	x4, [sp, #0x320]
1029c09d8: aa1703e0    	mov	x0, x23
1029c09dc: f94133e1    	ldr	x1, [sp, #0x260]
1029c09e0: aa1503e2    	mov	x2, x21
1029c09e4: 954999d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c09e8: aa1503e0    	mov	x0, x21
1029c09ec: 954999da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c09f0: 900ea9d5    	adrp	x21, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c09f4: aa1303e0    	mov	x0, x19
1029c09f8: f9412fe1    	ldr	x1, [sp, #0x258]
1029c09fc: 954999d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0a00: 11000402    	add	w2, w0, #0x1
1029c0a04: aa1303e0    	mov	x0, x19
1029c0a08: f9412be1    	ldr	x1, [sp, #0x250]
1029c0a0c: 954999cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0a10: aa1303e0    	mov	x0, x19
1029c0a14: f94127e1    	ldr	x1, [sp, #0x248]
1029c0a18: 954999c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0a1c: f94193e8    	ldr	x8, [sp, #0x320]
1029c0a20: 8b000102    	add	x2, x8, x0
1029c0a24: aa1303e0    	mov	x0, x19
1029c0a28: f94123e1    	ldr	x1, [sp, #0x240]
1029c0a2c: 954999c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0a30: aa1303e0    	mov	x0, x19
1029c0a34: f9411fe1    	ldr	x1, [sp, #0x238]
1029c0a38: 954999c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0a3c: f9418fe8    	ldr	x8, [sp, #0x318]
1029c0a40: 8b000102    	add	x2, x8, x0
1029c0a44: aa1303e0    	mov	x0, x19
1029c0a48: f9411be1    	ldr	x1, [sp, #0x230]
1029c0a4c: 954999bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0a50: 52000348    	eor	w8, w26, #0x1
1029c0a54: 2a080388    	orr	w8, w28, w8
1029c0a58: 37000308    	tbnz	w8, #0x0, 0x1029c0ab8 <_Flutter_Image_provideRelativePathByUrl+0xdcd968>
1029c0a5c: aa1303e0    	mov	x0, x19
1029c0a60: f940c3e1    	ldr	x1, [sp, #0x180]
1029c0a64: 954999b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0a68: 11000402    	add	w2, w0, #0x1
1029c0a6c: aa1303e0    	mov	x0, x19
1029c0a70: f940bfe1    	ldr	x1, [sp, #0x178]
1029c0a74: 954999b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0a78: aa1303e0    	mov	x0, x19
1029c0a7c: f940bbe1    	ldr	x1, [sp, #0x170]
1029c0a80: 954999af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0a84: f94193e8    	ldr	x8, [sp, #0x320]
1029c0a88: 8b000102    	add	x2, x8, x0
1029c0a8c: aa1303e0    	mov	x0, x19
1029c0a90: f940b7e1    	ldr	x1, [sp, #0x168]
1029c0a94: 954999aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0a98: aa1303e0    	mov	x0, x19
1029c0a9c: f940b3e1    	ldr	x1, [sp, #0x160]
1029c0aa0: 954999a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0aa4: f9418fe8    	ldr	x8, [sp, #0x318]
1029c0aa8: 8b000102    	add	x2, x8, x0
1029c0aac: aa1303e0    	mov	x0, x19
1029c0ab0: f940afe1    	ldr	x1, [sp, #0x158]
1029c0ab4: 954999a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0ab8: aa1303e0    	mov	x0, x19
1029c0abc: f94117e1    	ldr	x1, [sp, #0x228]
1029c0ac0: 9549999f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0ac4: 11000402    	add	w2, w0, #0x1
1029c0ac8: aa1303e0    	mov	x0, x19
1029c0acc: f94113e1    	ldr	x1, [sp, #0x220]
1029c0ad0: 9549999b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0ad4: aa1303e0    	mov	x0, x19
1029c0ad8: f94157e1    	ldr	x1, [sp, #0x2a8]
1029c0adc: 95499998    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0ae0: aa1d03fd    	mov	x29, x29
1029c0ae4: 95499999    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0ae8: aa0003f6    	mov	x22, x0
1029c0aec: f94197e3    	ldr	x3, [sp, #0x328]
1029c0af0: f94193e4    	ldr	x4, [sp, #0x320]
1029c0af4: f94163fa    	ldr	x26, [sp, #0x2c0]
1029c0af8: 340004dc    	cbz	w28, 0x1029c0b90 <_Flutter_Image_provideRelativePathByUrl+0xdcda40>
1029c0afc: aa1703e0    	mov	x0, x23
1029c0b00: f940abe1    	ldr	x1, [sp, #0x150]
1029c0b04: aa1603e2    	mov	x2, x22
1029c0b08: 9549998d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0b0c: aa1603e0    	mov	x0, x22
1029c0b10: 95499991    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0b14: aa1303e0    	mov	x0, x19
1029c0b18: f940a7e1    	ldr	x1, [sp, #0x148]
1029c0b1c: 95499988    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0b20: 11000402    	add	w2, w0, #0x1
1029c0b24: aa1303e0    	mov	x0, x19
1029c0b28: f940a3e1    	ldr	x1, [sp, #0x140]
1029c0b2c: 95499984    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0b30: aa1303e0    	mov	x0, x19
1029c0b34: f9409fe1    	ldr	x1, [sp, #0x138]
1029c0b38: 95499981    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0b3c: f94193e8    	ldr	x8, [sp, #0x320]
1029c0b40: 8b000102    	add	x2, x8, x0
1029c0b44: aa1303e0    	mov	x0, x19
1029c0b48: f9409be1    	ldr	x1, [sp, #0x130]
1029c0b4c: 9549997c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0b50: aa1303e0    	mov	x0, x19
1029c0b54: f94097e1    	ldr	x1, [sp, #0x128]
1029c0b58: 95499979    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0b5c: 11000402    	add	w2, w0, #0x1
1029c0b60: aa1303e0    	mov	x0, x19
1029c0b64: f94093e1    	ldr	x1, [sp, #0x120]
1029c0b68: 95499975    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0b6c: aa1303e0    	mov	x0, x19
1029c0b70: f9408fe1    	ldr	x1, [sp, #0x118]
1029c0b74: 95499972    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0b78: f94193e8    	ldr	x8, [sp, #0x320]
1029c0b7c: 8b000102    	add	x2, x8, x0
1029c0b80: aa1303e0    	mov	x0, x19
1029c0b84: f9408be1    	ldr	x1, [sp, #0x110]
1029c0b88: 9549996d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0b8c: 14000074    	b	0x1029c0d5c <_Flutter_Image_provideRelativePathByUrl+0xdcdc0c>
1029c0b90: f9418be5    	ldr	x5, [sp, #0x310]
1029c0b94: aa1703e0    	mov	x0, x23
1029c0b98: f9413be1    	ldr	x1, [sp, #0x270]
1029c0b9c: aa1603e2    	mov	x2, x22
1029c0ba0: 95499967    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0ba4: aa1603e0    	mov	x0, x22
1029c0ba8: 9549996b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0bac: aa1303e0    	mov	x0, x19
1029c0bb0: f940f3e1    	ldr	x1, [sp, #0x1e0]
1029c0bb4: 95499962    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0bb8: aa1d03fd    	mov	x29, x29
1029c0bbc: 95499963    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0bc0: aa0003f5    	mov	x21, x0
1029c0bc4: b9433be3    	ldr	w3, [sp, #0x338]
1029c0bc8: f94193e4    	ldr	x4, [sp, #0x320]
1029c0bcc: aa1703e0    	mov	x0, x23
1029c0bd0: f94137e1    	ldr	x1, [sp, #0x268]
1029c0bd4: aa1503e2    	mov	x2, x21
1029c0bd8: 95499959    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0bdc: aa1503e0    	mov	x0, x21
1029c0be0: 9549995d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0be4: aa1303e0    	mov	x0, x19
1029c0be8: f940efe1    	ldr	x1, [sp, #0x1d8]
1029c0bec: 95499954    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0bf0: aa1d03fd    	mov	x29, x29
1029c0bf4: 95499955    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0bf8: aa0003f5    	mov	x21, x0
1029c0bfc: b9433fe3    	ldr	w3, [sp, #0x33c]
1029c0c00: f94193e4    	ldr	x4, [sp, #0x320]
1029c0c04: aa1703e0    	mov	x0, x23
1029c0c08: f94133e1    	ldr	x1, [sp, #0x260]
1029c0c0c: aa1503e2    	mov	x2, x21
1029c0c10: 9549994b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0c14: aa1503e0    	mov	x0, x21
1029c0c18: 900ea9d5    	adrp	x21, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0c1c: 9549994e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0c20: b9433fe8    	ldr	w8, [sp, #0x33c]
1029c0c24: 7100091f    	cmp	w8, #0x2
1029c0c28: 540000a3    	b.lo	0x1029c0c3c <_Flutter_Image_provideRelativePathByUrl+0xdcdaec>
1029c0c2c: 71000d1f    	cmp	w8, #0x3
1029c0c30: 540004a0    	b.eq	0x1029c0cc4 <_Flutter_Image_provideRelativePathByUrl+0xdcdb74>
1029c0c34: 7100111f    	cmp	w8, #0x4
1029c0c38: 54000921    	b.ne	0x1029c0d5c <_Flutter_Image_provideRelativePathByUrl+0xdcdc0c>
1029c0c3c: f94193e8    	ldr	x8, [sp, #0x320]
1029c0c40: 5290d429    	mov	w9, #0x86a1             ; =34465
1029c0c44: 72a00029    	movk	w9, #0x1, lsl #16
1029c0c48: eb09011f    	cmp	x8, x9
1029c0c4c: 54000263    	b.lo	0x1029c0c98 <_Flutter_Image_provideRelativePathByUrl+0xdcdb48>
1029c0c50: f00ebd89    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
1029c0c54: f9453520    	ldr	x0, [x9, #0xa68]
1029c0c58: f94197e9    	ldr	x9, [sp, #0x328]
1029c0c5c: a90123e9    	stp	x9, x8, [sp, #0x10]
1029c0c60: f00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c0c64: 912ea108    	add	x8, x8, #0xba8
1029c0c68: a90067e8    	stp	x8, x25, [sp]
1029c0c6c: f94173e1    	ldr	x1, [sp, #0x2e0]
1029c0c70: 52800042    	mov	w2, #0x2                ; =2
1029c0c74: 900c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c0c78: 9125d063    	add	x3, x3, #0x974
1029c0c7c: 52800004    	mov	w4, #0x0                ; =0
1029c0c80: b00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0c84: 9112f8a5    	add	x5, x5, #0x4be
1029c0c88: 52808f26    	mov	w6, #0x479              ; =1145
1029c0c8c: b00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0c90: 913c94e7    	add	x7, x7, #0xf25
1029c0c94: 9549992a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0c98: aa1303e0    	mov	x0, x19
1029c0c9c: f9407fe1    	ldr	x1, [sp, #0xf8]
1029c0ca0: 95499927    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0ca4: aa1d03fd    	mov	x29, x29
1029c0ca8: 95499928    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0cac: aa0003f5    	mov	x21, x0
1029c0cb0: f94197e3    	ldr	x3, [sp, #0x328]
1029c0cb4: f94193e4    	ldr	x4, [sp, #0x320]
1029c0cb8: aa1703e0    	mov	x0, x23
1029c0cbc: f94073e1    	ldr	x1, [sp, #0xe0]
1029c0cc0: 14000022    	b	0x1029c0d48 <_Flutter_Image_provideRelativePathByUrl+0xdcdbf8>
1029c0cc4: f94193e8    	ldr	x8, [sp, #0x320]
1029c0cc8: 52884829    	mov	w9, #0x4241             ; =16961
1029c0ccc: 72a001e9    	movk	w9, #0xf, lsl #16
1029c0cd0: eb09011f    	cmp	x8, x9
1029c0cd4: 54000263    	b.lo	0x1029c0d20 <_Flutter_Image_provideRelativePathByUrl+0xdcdbd0>
1029c0cd8: f00ebd89    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
1029c0cdc: f9453520    	ldr	x0, [x9, #0xa68]
1029c0ce0: f94197e9    	ldr	x9, [sp, #0x328]
1029c0ce4: a90123e9    	stp	x9, x8, [sp, #0x10]
1029c0ce8: f00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c0cec: 912f2108    	add	x8, x8, #0xbc8
1029c0cf0: a90067e8    	stp	x8, x25, [sp]
1029c0cf4: f94173e1    	ldr	x1, [sp, #0x2e0]
1029c0cf8: 52800042    	mov	w2, #0x2                ; =2
1029c0cfc: 900c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c0d00: 9125d063    	add	x3, x3, #0x974
1029c0d04: 52800004    	mov	w4, #0x0                ; =0
1029c0d08: b00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0d0c: 9112f8a5    	add	x5, x5, #0x4be
1029c0d10: 52808fc6    	mov	w6, #0x47e              ; =1150
1029c0d14: b00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0d18: 913c94e7    	add	x7, x7, #0xf25
1029c0d1c: 95499908    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0d20: aa1303e0    	mov	x0, x19
1029c0d24: f9403fe1    	ldr	x1, [sp, #0x78]
1029c0d28: 95499905    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0d2c: aa1d03fd    	mov	x29, x29
1029c0d30: 95499906    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0d34: aa0003f5    	mov	x21, x0
1029c0d38: f94197e3    	ldr	x3, [sp, #0x328]
1029c0d3c: f94193e4    	ldr	x4, [sp, #0x320]
1029c0d40: aa1703e0    	mov	x0, x23
1029c0d44: f9402fe1    	ldr	x1, [sp, #0x58]
1029c0d48: aa1503e2    	mov	x2, x21
1029c0d4c: 954998fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0d50: aa1503e0    	mov	x0, x21
1029c0d54: 95499900    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0d58: 900ea9d5    	adrp	x21, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0d5c: f94197e8    	ldr	x8, [sp, #0x328]
1029c0d60: f100091f    	cmp	x8, #0x2
1029c0d64: 540004c1    	b.ne	0x1029c0dfc <_Flutter_Image_provideRelativePathByUrl+0xdcdcac>
1029c0d68: f00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c0d6c: f9453500    	ldr	x0, [x8, #0xa68]
1029c0d70: f00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c0d74: 912fa108    	add	x8, x8, #0xbe8
1029c0d78: a90067e8    	stp	x8, x25, [sp]
1029c0d7c: f94173e1    	ldr	x1, [sp, #0x2e0]
1029c0d80: 52800022    	mov	w2, #0x1                ; =1
1029c0d84: 900c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c0d88: 9125d063    	add	x3, x3, #0x974
1029c0d8c: 52800004    	mov	w4, #0x0                ; =0
1029c0d90: b00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0d94: 9112f8a5    	add	x5, x5, #0x4be
1029c0d98: 528090a6    	mov	w6, #0x485              ; =1157
1029c0d9c: b00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0da0: 913c94e7    	add	x7, x7, #0xf25
1029c0da4: 954998e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0da8: f94193e8    	ldr	x8, [sp, #0x320]
1029c0dac: f154011f    	cmp	x8, #0x500, lsl #12     ; =0x500000
1029c0db0: 54000269    	b.ls	0x1029c0dfc <_Flutter_Image_provideRelativePathByUrl+0xdcdcac>
1029c0db4: f00ebd89    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
1029c0db8: f9453520    	ldr	x0, [x9, #0xa68]
1029c0dbc: d354fd08    	lsr	x8, x8, #20
1029c0dc0: a900e7e8    	stp	x8, x25, [sp, #0x8]
1029c0dc4: f00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c0dc8: 91302108    	add	x8, x8, #0xc08
1029c0dcc: f90003e8    	str	x8, [sp]
1029c0dd0: f94173e1    	ldr	x1, [sp, #0x2e0]
1029c0dd4: 52800062    	mov	w2, #0x3                ; =3
1029c0dd8: 900c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c0ddc: 9125d063    	add	x3, x3, #0x974
1029c0de0: 52800004    	mov	w4, #0x0                ; =0
1029c0de4: b00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0de8: 9112f8a5    	add	x5, x5, #0x4be
1029c0dec: 528090e6    	mov	w6, #0x487              ; =1159
1029c0df0: b00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0df4: 913c94e7    	add	x7, x7, #0xf25
1029c0df8: 954998d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0dfc: aa1703e0    	mov	x0, x23
1029c0e00: f9410fe1    	ldr	x1, [sp, #0x218]
1029c0e04: 954998ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0e08: 7100081f    	cmp	w0, #0x2
1029c0e0c: 54000d20    	b.eq	0x1029c0fb0 <_Flutter_Image_provideRelativePathByUrl+0xdcde60>
1029c0e10: aa1703e0    	mov	x0, x23
1029c0e14: f9416be1    	ldr	x1, [sp, #0x2d0]
1029c0e18: 954998c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0e1c: 340001a0    	cbz	w0, 0x1029c0e50 <_Flutter_Image_provideRelativePathByUrl+0xdcdd00>
1029c0e20: aa1703e0    	mov	x0, x23
1029c0e24: f9416be1    	ldr	x1, [sp, #0x2d0]
1029c0e28: 954998c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0e2c: 1ac00b08    	udiv	w8, w24, w0
1029c0e30: 1b00e108    	msub	w8, w8, w0, w24
1029c0e34: 350000e8    	cbnz	w8, 0x1029c0e50 <_Flutter_Image_provideRelativePathByUrl+0xdcdd00>
1029c0e38: aa1703e0    	mov	x0, x23
1029c0e3c: f94047e1    	ldr	x1, [sp, #0x88]
1029c0e40: 954998bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0e44: 52807d08    	mov	w8, #0x3e8              ; =1000
1029c0e48: 1b087c00    	mul	w0, w0, w8
1029c0e4c: 95499aad    	bl	0x107c27900 <_Flutter_MMFoundation_BindContext+0x41034e4>
1029c0e50: aa1a03e0    	mov	x0, x26
1029c0e54: f94103e1    	ldr	x1, [sp, #0x200]
1029c0e58: 954998b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0e5c: 340005c0    	cbz	w0, 0x1029c0f14 <_Flutter_Image_provideRelativePathByUrl+0xdcddc4>
1029c0e60: aa1703e0    	mov	x0, x23
1029c0e64: f94087e1    	ldr	x1, [sp, #0x108]
1029c0e68: 954998b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0e6c: 34000540    	cbz	w0, 0x1029c0f14 <_Flutter_Image_provideRelativePathByUrl+0xdcddc4>
1029c0e70: aa1703e0    	mov	x0, x23
1029c0e74: f94083e1    	ldr	x1, [sp, #0x100]
1029c0e78: 954998b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0e7c: f100041f    	cmp	x0, #0x1
1029c0e80: 540004ab    	b.lt	0x1029c0f14 <_Flutter_Image_provideRelativePathByUrl+0xdcddc4>
1029c0e84: 2a1803f5    	mov	w21, w24
1029c0e88: aa1703e0    	mov	x0, x23
1029c0e8c: f94083e1    	ldr	x1, [sp, #0x100]
1029c0e90: 954998ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0e94: 9ac00ea8    	sdiv	x8, x21, x0
1029c0e98: 9b00d508    	msub	x8, x8, x0, x21
1029c0e9c: 900ea9d5    	adrp	x21, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0ea0: b50003a8    	cbnz	x8, 0x1029c0f14 <_Flutter_Image_provideRelativePathByUrl+0xdcddc4>
1029c0ea4: f00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c0ea8: f9453500    	ldr	x0, [x8, #0xa68]
1029c0eac: f00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c0eb0: 9130a108    	add	x8, x8, #0xc28
1029c0eb4: f90003e8    	str	x8, [sp]
1029c0eb8: f94173e1    	ldr	x1, [sp, #0x2e0]
1029c0ebc: 52800042    	mov	w2, #0x2                ; =2
1029c0ec0: 900c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c0ec4: 9125d063    	add	x3, x3, #0x974
1029c0ec8: 52800004    	mov	w4, #0x0                ; =0
1029c0ecc: b00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0ed0: 9112f8a5    	add	x5, x5, #0x4be
1029c0ed4: 52809366    	mov	w6, #0x49b              ; =1179
1029c0ed8: b00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c0edc: 913c94e7    	add	x7, x7, #0xf25
1029c0ee0: 95499897    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0ee4: aa1703e0    	mov	x0, x23
1029c0ee8: f9401fe1    	ldr	x1, [sp, #0x38]
1029c0eec: 95499894    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0ef0: aa1d03fd    	mov	x29, x29
1029c0ef4: 95499895    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0ef8: aa0003f5    	mov	x21, x0
1029c0efc: 900d63c1    	adrp	x1, 0x11d638000 <dyld_stub_binder+0x11d638000>
1029c0f00: 91022021    	add	x1, x1, #0x88
1029c0f04: 954998b6    	bl	0x107c271dc <_Flutter_MMFoundation_BindContext+0x4102dc0>
1029c0f08: aa1503e0    	mov	x0, x21
1029c0f0c: 900ea9d5    	adrp	x21, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0f10: 95499891    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0f14: aa1903e0    	mov	x0, x25
1029c0f18: 9549988f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0f1c: f94177e0    	ldr	x0, [sp, #0x2e8]
1029c0f20: 954998a3    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1029c0f24: 91000694    	add	x20, x20, #0x1
1029c0f28: 11000718    	add	w24, w24, #0x1
1029c0f2c: f94107e0    	ldr	x0, [sp, #0x208]
1029c0f30: eb14001f    	cmp	x0, x20
1029c0f34: 54ffa561    	b.ne	0x1029c03e0 <_Flutter_Image_provideRelativePathByUrl+0xdcd290>
1029c0f38: 910d03e2    	add	x2, sp, #0x340
1029c0f3c: 9110c3e3    	add	x3, sp, #0x430
1029c0f40: f940f7e0    	ldr	x0, [sp, #0x1e8]
1029c0f44: f94033e1    	ldr	x1, [sp, #0x60]
1029c0f48: 52800204    	mov	w4, #0x10               ; =16
1029c0f4c: 9549987c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0f50: 900ea9c9    	adrp	x9, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0f54: 900ea9ca    	adrp	x10, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0f58: b00ea9cb    	adrp	x11, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0f5c: d00eba4c    	adrp	x12, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029c0f60: b00ea3cd    	adrp	x13, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c0f64: 900eba0e    	adrp	x14, 0x120100000 <dyld_stub_binder+0x120100000>
1029c0f68: d00eb9ef    	adrp	x15, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1029c0f6c: b00ea3d0    	adrp	x16, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c0f70: f00eba11    	adrp	x17, 0x120103000 <dyld_stub_binder+0x120103000>
1029c0f74: d00ea401    	adrp	x1, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
1029c0f78: 900ea9c2    	adrp	x2, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0f7c: b00ea663    	adrp	x3, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029c0f80: b00ea9c4    	adrp	x4, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0f84: b00ea9c5    	adrp	x5, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0f88: b00ea9c6    	adrp	x6, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0f8c: b00ea9c7    	adrp	x7, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0f90: aa1503f4    	mov	x20, x21
1029c0f94: d00eba5c    	adrp	x28, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029c0f98: 900ea9d6    	adrp	x22, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0f9c: 900ea9d8    	adrp	x24, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0fa0: b00eba19    	adrp	x25, 0x120101000 <dyld_stub_binder+0x120101000>
1029c0fa4: 900ea9de    	adrp	x30, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c0fa8: b5ff8be0    	cbnz	x0, 0x1029c0124 <_Flutter_Image_provideRelativePathByUrl+0xdccfd4>
1029c0fac: 14000008    	b	0x1029c0fcc <_Flutter_Image_provideRelativePathByUrl+0xdcde7c>
1029c0fb0: aa1903e0    	mov	x0, x25
1029c0fb4: 95499868    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0fb8: f94177e0    	ldr	x0, [sp, #0x2e8]
1029c0fbc: 9549987c    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1029c0fc0: b90087f8    	str	w24, [sp, #0x84]
1029c0fc4: 14000002    	b	0x1029c0fcc <_Flutter_Image_provideRelativePathByUrl+0xdcde7c>
1029c0fc8: b90087ff    	str	wzr, [sp, #0x84]
1029c0fcc: f940f7e0    	ldr	x0, [sp, #0x1e8]
1029c0fd0: 95499861    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c0fd4: aa1303e0    	mov	x0, x19
1029c0fd8: f9407fe1    	ldr	x1, [sp, #0xf8]
1029c0fdc: 95499858    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c0fe0: aa1d03fd    	mov	x29, x29
1029c0fe4: 95499859    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c0fe8: aa0003f4    	mov	x20, x0
1029c0fec: b00ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c0ff0: f9407101    	ldr	x1, [x8, #0xe0] ; setDictOtherDataFileStat:
1029c0ff4: aa1b03e0    	mov	x0, x27
1029c0ff8: aa1403e2    	mov	x2, x20
1029c0ffc: 95499850    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1000: aa1403e0    	mov	x0, x20
1029c1004: 95499854    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c1008: aa1303e0    	mov	x0, x19
1029c100c: f9403fe1    	ldr	x1, [sp, #0x78]
1029c1010: 9549984b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1014: aa1d03fd    	mov	x29, x29
1029c1018: 9549984c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c101c: aa0003f4    	mov	x20, x0
1029c1020: 900ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c1024: f9407501    	ldr	x1, [x8, #0xe8] ; setDictCacheDataFileStat:
1029c1028: aa1b03e0    	mov	x0, x27
1029c102c: aa1403e2    	mov	x2, x20
1029c1030: 95499843    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1034: aa1403e0    	mov	x0, x20
1029c1038: 95499847    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c103c: d00ea448    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1029c1040: f9420101    	ldr	x1, [x8, #0x400] ; report
1029c1044: f9415fe0    	ldr	x0, [sp, #0x2b8]
1029c1048: 9549983d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c104c: aa1303e0    	mov	x0, x19
1029c1050: f9403be1    	ldr	x1, [sp, #0x70]
1029c1054: 9549983a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1058: aa1d03fd    	mov	x29, x29
1029c105c: 9549983b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c1060: aa0003f4    	mov	x20, x0
1029c1064: f9401be1    	ldr	x1, [sp, #0x30]
1029c1068: 95499835    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c106c: aa0003f5    	mov	x21, x0
1029c1070: aa1403e0    	mov	x0, x20
1029c1074: 95499838    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c1078: b94087e8    	ldr	w8, [sp, #0x84]
1029c107c: eb2842bf    	cmp	x21, w8, uxtw
1029c1080: 1a9f87f4    	cset	w20, ls
1029c1084: f94023f9    	ldr	x25, [sp, #0x40]
1029c1088: 54001a48    	b.hi	0x1029c13d0 <_Flutter_Image_provideRelativePathByUrl+0xdce280>
1029c108c: f00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c1090: f942f101    	ldr	x1, [x8, #0x5e0] ; setM_arrNotScanFileName:
1029c1094: aa1303e0    	mov	x0, x19
1029c1098: d2800002    	mov	x2, #0x0                ; =0
1029c109c: 95499828    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c10a0: b4000979    	cbz	x25, 0x1029c11cc <_Flutter_Image_provideRelativePathByUrl+0xdce07c>
1029c10a4: f00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c10a8: f942d515    	ldr	x21, [x8, #0x5a8] ; fileNum
1029c10ac: aa1903e0    	mov	x0, x25
1029c10b0: aa1503e1    	mov	x1, x21
1029c10b4: 95499822    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c10b8: aa0003f6    	mov	x22, x0
1029c10bc: aa1b03e0    	mov	x0, x27
1029c10c0: aa1503e1    	mov	x1, x21
1029c10c4: 9549981e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c10c8: 6b0002df    	cmp	w22, w0
1029c10cc: 54000801    	b.ne	0x1029c11cc <_Flutter_Image_provideRelativePathByUrl+0xdce07c>
1029c10d0: 900eba08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1029c10d4: f944c115    	ldr	x21, [x8, #0x980] ; fileSize
1029c10d8: aa1903e0    	mov	x0, x25
1029c10dc: aa1503e1    	mov	x1, x21
1029c10e0: 95499817    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c10e4: aa0003f6    	mov	x22, x0
1029c10e8: aa1b03e0    	mov	x0, x27
1029c10ec: aa1503e1    	mov	x1, x21
1029c10f0: 95499813    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c10f4: eb0002df    	cmp	x22, x0
1029c10f8: 540006a1    	b.ne	0x1029c11cc <_Flutter_Image_provideRelativePathByUrl+0xdce07c>
1029c10fc: 528a3016    	mov	w22, #0x5180            ; =20864
1029c1100: 72a00036    	movk	w22, #0x1, lsl #16
1029c1104: 900ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c1108: f9400901    	ldr	x1, [x8, #0x10] ; isFolderMayHaveDB
1029c110c: aa1303e0    	mov	x0, x19
1029c1110: 9549980b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1114: aa0003f5    	mov	x21, x0
1029c1118: f00ea648    	adrp	x8, 0x11fe8c000 <dyld_stub_binder+0x11fe8c000>
1029c111c: aa1903e0    	mov	x0, x25
1029c1120: f945d519    	ldr	x25, [x8, #0xba8] ; cacheTime
1029c1124: aa1903e1    	mov	x1, x25
1029c1128: 95499805    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c112c: f00ea648    	adrp	x8, 0x11fe8c000 <dyld_stub_binder+0x11fe8c000>
1029c1130: f945bd18    	ldr	x24, [x8, #0xb78] ; setCacheTime:
1029c1134: 34000175    	cbz	w21, 0x1029c1160 <_Flutter_Image_provideRelativePathByUrl+0xdce010>
1029c1138: 91384002    	add	x2, x0, #0xe10
1029c113c: aa1b03e0    	mov	x0, x27
1029c1140: aa1803e1    	mov	x1, x24
1029c1144: 954997fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1148: aa1b03e0    	mov	x0, x27
1029c114c: aa1903e1    	mov	x1, x25
1029c1150: 954997fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1154: eb16001f    	cmp	x0, x22
1029c1158: 540001ec    	b.gt	0x1029c1194 <_Flutter_Image_provideRelativePathByUrl+0xdce044>
1029c115c: 14000012    	b	0x1029c11a4 <_Flutter_Image_provideRelativePathByUrl+0xdce054>
1029c1160: 52875015    	mov	w21, #0x3a80            ; =14976
1029c1164: 72a00135    	movk	w21, #0x9, lsl #16
1029c1168: 8b160002    	add	x2, x0, x22
1029c116c: aa1b03e0    	mov	x0, x27
1029c1170: aa1803e1    	mov	x1, x24
1029c1174: 954997f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1178: aa1b03e0    	mov	x0, x27
1029c117c: aa1903e1    	mov	x1, x25
1029c1180: 954997ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1184: 52875016    	mov	w22, #0x3a80            ; =14976
1029c1188: 72a00136    	movk	w22, #0x9, lsl #16
1029c118c: eb15001f    	cmp	x0, x21
1029c1190: 540000ad    	b.le	0x1029c11a4 <_Flutter_Image_provideRelativePathByUrl+0xdce054>
1029c1194: aa1b03e0    	mov	x0, x27
1029c1198: aa1803e1    	mov	x1, x24
1029c119c: aa1603e2    	mov	x2, x22
1029c11a0: 954997e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c11a4: 900ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c11a8: f9407901    	ldr	x1, [x8, #0xf0] ; m_refreshCacheTimeCount
1029c11ac: aa1303e0    	mov	x0, x19
1029c11b0: 954997e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c11b4: 900ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c11b8: f9407d01    	ldr	x1, [x8, #0xf8] ; setM_refreshCacheTimeCount:
1029c11bc: 11000402    	add	w2, w0, #0x1
1029c11c0: aa1303e0    	mov	x0, x19
1029c11c4: 954997de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c11c8: f94023f9    	ldr	x25, [sp, #0x40]
1029c11cc: f00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c11d0: f9468d01    	ldr	x1, [x8, #0xd18] ; wrapCacheData
1029c11d4: aa1703e0    	mov	x0, x23
1029c11d8: 954997d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c11dc: aa1d03fd    	mov	x29, x29
1029c11e0: 954997da    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c11e4: aa0003f5    	mov	x21, x0
1029c11e8: 900ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c11ec: f9408101    	ldr	x1, [x8, #0x100] ; setWrapCache:withFullPath:
1029c11f0: aa1b03e2    	mov	x2, x27
1029c11f4: f9416fe3    	ldr	x3, [sp, #0x2d8]
1029c11f8: 954997d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c11fc: aa1503e0    	mov	x0, x21
1029c1200: 954997d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c1204: 900ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c1208: f9408501    	ldr	x1, [x8, #0x108] ; m_setCacheCount
1029c120c: aa1303e0    	mov	x0, x19
1029c1210: 954997cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1214: 900ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c1218: f9408901    	ldr	x1, [x8, #0x110] ; setM_setCacheCount:
1029c121c: 11000402    	add	w2, w0, #0x1
1029c1220: aa1303e0    	mov	x0, x19
1029c1224: 954997c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1228: f00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c122c: f942a916    	ldr	x22, [x8, #0x550] ; m_fileNum
1029c1230: aa1303e0    	mov	x0, x19
1029c1234: aa1603e1    	mov	x1, x22
1029c1238: 954997c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c123c: 712ee01f    	cmp	w0, #0xbb8
1029c1240: 54000523    	b.lo	0x1029c12e4 <_Flutter_Image_provideRelativePathByUrl+0xdce194>
1029c1244: d00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c1248: f9453515    	ldr	x21, [x8, #0xa68]
1029c124c: f00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c1250: f942f501    	ldr	x1, [x8, #0x5e8] ; m_arrChildFolder
1029c1254: aa1303e0    	mov	x0, x19
1029c1258: 954997b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c125c: aa1d03fd    	mov	x29, x29
1029c1260: 954997ba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c1264: aa0003f7    	mov	x23, x0
1029c1268: f9401be1    	ldr	x1, [sp, #0x30]
1029c126c: 954997b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1270: aa0003f8    	mov	x24, x0
1029c1274: aa1303e0    	mov	x0, x19
1029c1278: aa1603e1    	mov	x1, x22
1029c127c: 954997b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1280: aa0003f9    	mov	x25, x0
1029c1284: 954997c0    	bl	0x107c27184 <_Flutter_MMFoundation_BindContext+0x4102d68>
1029c1288: 1e683800    	fsub	d0, d0, d8
1029c128c: 900ea3c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c1290: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c1294: fd0013e0    	str	d0, [sp, #0x20]
1029c1298: a90167f8    	stp	x24, x25, [sp, #0x10]
1029c129c: f94023f9    	ldr	x25, [sp, #0x40]
1029c12a0: d00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c12a4: 91312108    	add	x8, x8, #0xc48
1029c12a8: f9416fe9    	ldr	x9, [sp, #0x2d8]
1029c12ac: a90027e8    	stp	x8, x9, [sp]
1029c12b0: f00c5dc3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c12b4: 9125d063    	add	x3, x3, #0x974
1029c12b8: 900c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c12bc: 9112f8a5    	add	x5, x5, #0x4be
1029c12c0: 900c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c12c4: 913c94e7    	add	x7, x7, #0xf25
1029c12c8: aa1503e0    	mov	x0, x21
1029c12cc: 52800042    	mov	w2, #0x2                ; =2
1029c12d0: 52800004    	mov	w4, #0x0                ; =0
1029c12d4: 52809946    	mov	w6, #0x4ca              ; =1226
1029c12d8: 95499799    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c12dc: aa1703e0    	mov	x0, x23
1029c12e0: 9549979d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c12e4: d00ebe28    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1029c12e8: f9453115    	ldr	x21, [x8, #0xa60]
1029c12ec: aa1303e0    	mov	x0, x19
1029c12f0: f94157e1    	ldr	x1, [sp, #0x2a8]
1029c12f4: 95499792    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c12f8: aa1d03fd    	mov	x29, x29
1029c12fc: 95499793    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c1300: aa0003f8    	mov	x24, x0
1029c1304: 900ea9c8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c1308: f9408d01    	ldr	x1, [x8, #0x118] ; getFileStatFormDic:withType:
1029c130c: aa1503e0    	mov	x0, x21
1029c1310: aa1803e2    	mov	x2, x24
1029c1314: 52800043    	mov	w3, #0x2                ; =2
1029c1318: 95499789    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c131c: aa1d03fd    	mov	x29, x29
1029c1320: 9549978a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c1324: aa0003f7    	mov	x23, x0
1029c1328: aa1803e0    	mov	x0, x24
1029c132c: 9549978a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c1330: f00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c1334: f942b118    	ldr	x24, [x8, #0x560] ; m_fileSize
1029c1338: aa1703e0    	mov	x0, x23
1029c133c: aa1803e1    	mov	x1, x24
1029c1340: 9549977f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1344: f154001f    	cmp	x0, #0x500, lsl #12     ; =0x500000
1029c1348: 54000409    	b.ls	0x1029c13c8 <_Flutter_Image_provideRelativePathByUrl+0xdce278>
1029c134c: aa1703e0    	mov	x0, x23
1029c1350: aa1603e1    	mov	x1, x22
1029c1354: 9549977a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1358: 34000380    	cbz	w0, 0x1029c13c8 <_Flutter_Image_provideRelativePathByUrl+0xdce278>
1029c135c: d00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c1360: f9453515    	ldr	x21, [x8, #0xa68]
1029c1364: aa1703e0    	mov	x0, x23
1029c1368: aa1803e1    	mov	x1, x24
1029c136c: 95499774    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1370: d354fc18    	lsr	x24, x0, #20
1029c1374: aa1703e0    	mov	x0, x23
1029c1378: aa1603e1    	mov	x1, x22
1029c137c: 95499770    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c1380: 900ea3c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c1384: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c1388: f9416fe8    	ldr	x8, [sp, #0x2d8]
1029c138c: a90123e0    	stp	x0, x8, [sp, #0x10]
1029c1390: d00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c1394: 9131a108    	add	x8, x8, #0xc68
1029c1398: a90063e8    	stp	x8, x24, [sp]
1029c139c: f00c5dc3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c13a0: 9125d063    	add	x3, x3, #0x974
1029c13a4: 900c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c13a8: 9112f8a5    	add	x5, x5, #0x4be
1029c13ac: 900c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c13b0: 913c94e7    	add	x7, x7, #0xf25
1029c13b4: aa1503e0    	mov	x0, x21
1029c13b8: 52800062    	mov	w2, #0x3                ; =3
1029c13bc: 52800004    	mov	w4, #0x0                ; =0
1029c13c0: 52809a66    	mov	w6, #0x4d3              ; =1235
1029c13c4: 9549975e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c13c8: aa1703e0    	mov	x0, x23
1029c13cc: 95499762    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c13d0: f940ffe0    	ldr	x0, [sp, #0x1f8]
1029c13d4: 95499760    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c13d8: f941d7e0    	ldr	x0, [sp, #0x3a8]
1029c13dc: 9549975e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c13e0: aa1b03e0    	mov	x0, x27
1029c13e4: 9549975c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c13e8: aa1903e0    	mov	x0, x25
1029c13ec: 9549975a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c13f0: f9415fe0    	ldr	x0, [sp, #0x2b8]
1029c13f4: 95499758    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c13f8: f9415be0    	ldr	x0, [sp, #0x2b0]
1029c13fc: 95499756    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c1400: aa1a03e0    	mov	x0, x26
1029c1404: 95499754    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c1408: f9416fe0    	ldr	x0, [sp, #0x2d8]
1029c140c: 95499752    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c1410: aa1303e0    	mov	x0, x19
1029c1414: 95499750    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c1418: f85903a8    	ldur	x8, [x29, #-0x70]
1029c141c: d00d6169    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1029c1420: f9405929    	ldr	x9, [x9, #0xb0]
1029c1424: f9400129    	ldr	x9, [x9]
1029c1428: eb08013f    	cmp	x9, x8
1029c142c: 54000161    	b.ne	0x1029c1458 <_Flutter_Image_provideRelativePathByUrl+0xdce308>
1029c1430: aa1403e0    	mov	x0, x20
1029c1434: 911703ff    	add	sp, sp, #0x5c0
1029c1438: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1029c143c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1029c1440: a94457f6    	ldp	x22, x21, [sp, #0x40]
1029c1444: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1029c1448: a94267fa    	ldp	x26, x25, [sp, #0x20]
1029c144c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
1029c1450: 6cc723e9    	ldp	d9, d8, [sp], #0x70
1029c1454: d65f03c0    	ret
1029c1458: 95499747    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
