
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029becb8: d101c3ff    	sub	sp, sp, #0x70
1029becbc: 6d0123e9    	stp	d9, d8, [sp, #0x10]
1029becc0: a90267fa    	stp	x26, x25, [sp, #0x20]
1029becc4: a9035ff8    	stp	x24, x23, [sp, #0x30]
1029becc8: a90457f6    	stp	x22, x21, [sp, #0x40]
1029beccc: a9054ff4    	stp	x20, x19, [sp, #0x50]
1029becd0: a9067bfd    	stp	x29, x30, [sp, #0x60]
1029becd4: 910183fd    	add	x29, sp, #0x60
1029becd8: aa0303f4    	mov	x20, x3
1029becdc: aa0203f5    	mov	x21, x2
1029bece0: aa0003f3    	mov	x19, x0
1029bece4: 900f13c8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029bece8: 52800029    	mov	w9, #0x1                ; =1
1029becec: 3934d509    	strb	w9, [x8, #0xd35]
1029becf0: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029becf4: f9477116    	ldr	x22, [x8, #0xee0] ; mergeFolderStat:intoScanStat:
1029becf8: aa0303e0    	mov	x0, x3
1029becfc: 9549a10f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029bed00: aa1303e0    	mov	x0, x19
1029bed04: aa1603e1    	mov	x1, x22
1029bed08: aa1503e2    	mov	x2, x21
1029bed0c: aa1403e3    	mov	x3, x20
1029bed10: 9549a10b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bed14: d00ea608    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
1029bed18: f9469501    	ldr	x1, [x8, #0xd28] ; markLock
1029bed1c: aa1403e0    	mov	x0, x20
1029bed20: 9549a107    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bed24: aa1d03fd    	mov	x29, x29
1029bed28: 9549a108    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bed2c: aa0003f5    	mov	x21, x0
1029bed30: 910003e0    	mov	x0, sp
1029bed34: aa1503e1    	mov	x1, x21
1029bed38: 9549397e    	bl	0x107c0d330 <_Flutter_MMFoundation_BindContext+0x40e8f14>
1029bed3c: aa1503e0    	mov	x0, x21
1029bed40: 9549a105    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bed44: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bed48: f9468916    	ldr	x22, [x8, #0xd10] ; m_totalFolderNum
1029bed4c: aa1403e0    	mov	x0, x20
1029bed50: aa1603e1    	mov	x1, x22
1029bed54: 9549a0fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bed58: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bed5c: f9477501    	ldr	x1, [x8, #0xee8] ; setM_totalFolderNum:
1029bed60: 11000402    	add	w2, w0, #0x1
1029bed64: aa1403e0    	mov	x0, x20
1029bed68: 9549a0f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bed6c: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bed70: f9477901    	ldr	x1, [x8, #0xef0] ; m_curScannedFolderNum
1029bed74: aa1403e0    	mov	x0, x20
1029bed78: 9549a0f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bed7c: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bed80: f9477d01    	ldr	x1, [x8, #0xef8] ; setM_curScannedFolderNum:
1029bed84: 11000402    	add	w2, w0, #0x1
1029bed88: aa1403e0    	mov	x0, x20
1029bed8c: 9549a0ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bed90: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bed94: f9468d01    	ldr	x1, [x8, #0xd18] ; wrapCacheData
1029bed98: aa1303e0    	mov	x0, x19
1029bed9c: 9549a0e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029beda0: aa1d03fd    	mov	x29, x29
1029beda4: 9549a0e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029beda8: aa0003f7    	mov	x23, x0
1029bedac: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bedb0: f9478101    	ldr	x1, [x8, #0xf00] ; totalProgress
1029bedb4: 9549a0e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bedb8: aa0003f5    	mov	x21, x0
1029bedbc: aa1703e0    	mov	x0, x23
1029bedc0: 9549a0e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bedc4: aa1403e0    	mov	x0, x20
1029bedc8: aa1603e1    	mov	x1, x22
1029bedcc: 9549a0dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bedd0: aa0003f6    	mov	x22, x0
1029bedd4: aa1403e0    	mov	x0, x20
1029bedd8: 9549a0df    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029beddc: 34000195    	cbz	w21, 0x1029bee0c <_Flutter_Image_provideRelativePathByUrl+0xdcbcbc>
1029bede0: 1e2302a0    	ucvtf	s0, w21
1029bede4: 1e2302c1    	ucvtf	s1, w22
1029bede8: 1e201820    	fdiv	s0, s1, s0
1029bedec: 1e22c001    	fcvt	d1, s0
1029bedf0: f00b1e08    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1029bedf4: fd476902    	ldr	d2, [x8, #0xed0]
1029bedf8: 1e622020    	fcmp	d1, d2
1029bedfc: f00b1e48    	adrp	x8, 0x118d89000 <dyld_stub_binder+0x118d89000>
1029bee00: bd4fa101    	ldr	s1, [x8, #0xfa0]
1029bee04: 1e20cc28    	fcsel	s8, s1, s0, gt
1029bee08: 14000002    	b	0x1029bee10 <_Flutter_Image_provideRelativePathByUrl+0xdcbcc0>
1029bee0c: 1e2703e8    	fmov	s8, wzr
1029bee10: d00eba08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029bee14: f946f114    	ldr	x20, [x8, #0xde0] ; delegate
1029bee18: aa1303e0    	mov	x0, x19
1029bee1c: aa1403e1    	mov	x1, x20
1029bee20: 9549a0c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bee24: aa1d03fd    	mov	x29, x29
1029bee28: 9549a0c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bee2c: b4000440    	cbz	x0, 0x1029beeb4 <_Flutter_Image_provideRelativePathByUrl+0xdcbd64>
1029bee30: aa0003f7    	mov	x23, x0
1029bee34: aa1303e0    	mov	x0, x19
1029bee38: aa1403e1    	mov	x1, x20
1029bee3c: 9549a0c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bee40: aa1d03fd    	mov	x29, x29
1029bee44: 9549a0c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bee48: aa0003f8    	mov	x24, x0
1029bee4c: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bee50: f9478516    	ldr	x22, [x8, #0xf08] ; onDiskUsageScanProgress:isAvailabled:
1029bee54: 900eba48    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1029bee58: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
1029bee5c: aa1603e2    	mov	x2, x22
1029bee60: 9549a0b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bee64: aa0003f9    	mov	x25, x0
1029bee68: aa1803e0    	mov	x0, x24
1029bee6c: 9549a0ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bee70: aa1703e0    	mov	x0, x23
1029bee74: 9549a0b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bee78: 340001f9    	cbz	w25, 0x1029beeb4 <_Flutter_Image_provideRelativePathByUrl+0xdcbd64>
1029bee7c: 710002bf    	cmp	w21, #0x0
1029bee80: 1a9f07f5    	cset	w21, ne
1029bee84: aa1303e0    	mov	x0, x19
1029bee88: aa1403e1    	mov	x1, x20
1029bee8c: 9549a0ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bee90: aa1d03fd    	mov	x29, x29
1029bee94: 9549a0ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bee98: aa0003f3    	mov	x19, x0
1029bee9c: aa1603e1    	mov	x1, x22
1029beea0: 1e204100    	fmov	s0, s8
1029beea4: aa1503e2    	mov	x2, x21
1029beea8: 9549a0a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029beeac: aa1303e0    	mov	x0, x19
1029beeb0: 9549a0a9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029beeb4: 910003e0    	mov	x0, sp
1029beeb8: 9549391f    	bl	0x107c0d334 <_Flutter_MMFoundation_BindContext+0x40e8f18>
1029beebc: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1029beec0: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1029beec4: a94457f6    	ldp	x22, x21, [sp, #0x40]
1029beec8: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1029beecc: a94267fa    	ldp	x26, x25, [sp, #0x20]
1029beed0: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
1029beed4: 9101c3ff    	add	sp, sp, #0x70
1029beed8: d65f03c0    	ret
