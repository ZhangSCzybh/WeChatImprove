
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109b31b84: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
109b31b88: a90157f6    	stp	x22, x21, [sp, #0x10]
109b31b8c: a9024ff4    	stp	x20, x19, [sp, #0x20]
109b31b90: a9037bfd    	stp	x29, x30, [sp, #0x30]
109b31b94: 9100c3fd    	add	x29, sp, #0x30
109b31b98: aa0003f3    	mov	x19, x0
109b31b9c: f00b88e8    	adrp	x8, 0x120c50000 <dyld_stub_binder+0x120c50000>
109b31ba0: 52800029    	mov	w9, #0x1                ; =1
109b31ba4: 39089d09    	strb	w9, [x8, #0x227]
109b31ba8: f00b3208    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
109b31bac: f940b900    	ldr	x0, [x8, #0x170]
109b31bb0: 9574a62e    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
109b31bb4: aa0003f5    	mov	x21, x0
109b31bb8: d00b3208    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109b31bbc: f945e900    	ldr	x0, [x8, #0xbd0]
109b31bc0: f00b2e68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109b31bc4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
109b31bc8: 9574a61f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31bcc: aa1d03fd    	mov	x29, x29
109b31bd0: 9574a620    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31bd4: aa0003f4    	mov	x20, x0
109b31bd8: f00b3208    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
109b31bdc: f9404100    	ldr	x0, [x8, #0x80]
109b31be0: d00b2e68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109b31be4: f947ad01    	ldr	x1, [x8, #0xf58] ; class
109b31be8: 9574a617    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31bec: aa0003e2    	mov	x2, x0
109b31bf0: 900b1848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109b31bf4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
109b31bf8: aa1403e0    	mov	x0, x20
109b31bfc: 9574a612    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31c00: aa1d03fd    	mov	x29, x29
109b31c04: 9574a613    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31c08: aa0003f6    	mov	x22, x0
109b31c0c: d00b3208    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109b31c10: f9462d00    	ldr	x0, [x8, #0xc58]
109b31c14: d00b1868    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
109b31c18: f941d101    	ldr	x1, [x8, #0x3a0] ; White
109b31c1c: 9574a60a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31c20: aa1d03fd    	mov	x29, x29
109b31c24: 9574a60b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31c28: aa0003f7    	mov	x23, x0
109b31c2c: f00b1848    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109b31c30: f9437901    	ldr	x1, [x8, #0x6f0] ; svgImageNamed:size:color:
109b31c34: f00a5462    	adrp	x2, 0x11e5c0000 <dyld_stub_binder+0x11e5c0000>
109b31c38: 9104a042    	add	x2, x2, #0x128
109b31c3c: 1e66d000    	fmov	d0, #22.00000000
109b31c40: 1e66d001    	fmov	d1, #22.00000000
109b31c44: aa1603e0    	mov	x0, x22
109b31c48: aa1703e3    	mov	x3, x23
109b31c4c: 9574a5fe    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31c50: aa1d03fd    	mov	x29, x29
109b31c54: 9574a5ff    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31c58: aa0003f8    	mov	x24, x0
109b31c5c: d00b2e88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
109b31c60: f9400101    	ldr	x1, [x8]
109b31c64: aa1503e0    	mov	x0, x21
109b31c68: aa1803e2    	mov	x2, x24
109b31c6c: 9574a5f6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31c70: d00b39e8    	adrp	x8, 0x12026f000 <dyld_stub_binder+0x12026f000>
109b31c74: b985dd15    	ldrsw	x21, [x8, #0x5dc]
109b31c78: f8756a68    	ldr	x8, [x19, x21]
109b31c7c: f8356a60    	str	x0, [x19, x21]
109b31c80: aa0803e0    	mov	x0, x8
109b31c84: 9574a5f6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31c88: aa1803e0    	mov	x0, x24
109b31c8c: 9574a5f4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31c90: aa1703e0    	mov	x0, x23
109b31c94: 9574a5f2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31c98: aa1603e0    	mov	x0, x22
109b31c9c: 9574a5f0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31ca0: aa1403e0    	mov	x0, x20
109b31ca4: 9574a5ee    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31ca8: d00b39e8    	adrp	x8, 0x12026f000 <dyld_stub_binder+0x12026f000>
109b31cac: b985d108    	ldrsw	x8, [x8, #0x5d0]
109b31cb0: f8686a60    	ldr	x0, [x19, x8]
109b31cb4: d00b1c48    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
109b31cb8: f9467101    	ldr	x1, [x8, #0xce0] ; isPrivate
109b31cbc: 9574a5e2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31cc0: f8756a68    	ldr	x8, [x19, x21]
109b31cc4: f00b2ea9    	adrp	x9, 0x120108000 <dyld_stub_binder+0x120108000>
109b31cc8: f9411121    	ldr	x1, [x9, #0x220] ; setHidden:
109b31ccc: 52000002    	eor	w2, w0, #0x1
109b31cd0: aa0803e0    	mov	x0, x8
109b31cd4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
109b31cd8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
109b31cdc: a94157f6    	ldp	x22, x21, [sp, #0x10]
109b31ce0: a8c45ff8    	ldp	x24, x23, [sp], #0x40
109b31ce4: 1574a5d8    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
