
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106f4398c: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
106f43990: a90167fa    	stp	x26, x25, [sp, #0x10]
106f43994: a9025ff8    	stp	x24, x23, [sp, #0x20]
106f43998: a90357f6    	stp	x22, x21, [sp, #0x30]
106f4399c: a9044ff4    	stp	x20, x19, [sp, #0x40]
106f439a0: a9057bfd    	stp	x29, x30, [sp, #0x50]
106f439a4: 910143fd    	add	x29, sp, #0x50
106f439a8: d10743ff    	sub	sp, sp, #0x1d0
106f439ac: aa0003f3    	mov	x19, x0
106f439b0: 900b3568    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106f439b4: f9405908    	ldr	x8, [x8, #0xb0]
106f439b8: f9400108    	ldr	x8, [x8]
106f439bc: f81a03a8    	stur	x8, [x29, #-0x60]
106f439c0: f00ce808    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106f439c4: 52800029    	mov	w9, #0x1                ; =1
106f439c8: 39259109    	strb	w9, [x8, #0x964]
106f439cc: 900c9188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106f439d0: f9454100    	ldr	x0, [x8, #0xa80]
106f439d4: d00c8de8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
106f439d8: f9400501    	ldr	x1, [x8, #0x8] ; dictionary
106f439dc: f90007e1    	str	x1, [sp, #0x8]
106f439e0: 94338dd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f439e4: aa1d03fd    	mov	x29, x29
106f439e8: 94338dd8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f439ec: f90017e0    	str	x0, [sp, #0x28]
106f439f0: 4f00e400    	movi.16b	v0, #0x0
106f439f4: ad0403e0    	stp	q0, q0, [sp, #0x80]
106f439f8: ad0503e0    	stp	q0, q0, [sp, #0xa0]
106f439fc: d00c9808    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106f43a00: b98d7908    	ldrsw	x8, [x8, #0xd78]
106f43a04: f9000bf3    	str	x19, [sp, #0x10]
106f43a08: f8686a60    	ldr	x0, [x19, x8]
106f43a0c: 94338dcb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106f43a10: b00c8de8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106f43a14: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
106f43a18: 910203e2    	add	x2, sp, #0x80
106f43a1c: d10383a3    	sub	x3, x29, #0xe0
106f43a20: a90183e1    	stp	x1, x0, [sp, #0x18]
106f43a24: 52800204    	mov	w4, #0x10               ; =16
106f43a28: 94338dc5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43a2c: b40009e0    	cbz	x0, 0x106f43b68 <_Flutter_MMFoundation_BindContext+0x341f74c>
106f43a30: aa0003f8    	mov	x24, x0
106f43a34: f9404be8    	ldr	x8, [sp, #0x90]
106f43a38: f9400115    	ldr	x21, [x8]
106f43a3c: d2800014    	mov	x20, #0x0               ; =0
106f43a40: b00c8de8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106f43a44: f944e919    	ldr	x25, [x8, #0x9d0] ; currentContext
106f43a48: 900c8de8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106f43a4c: f947ad1a    	ldr	x26, [x8, #0xf58] ; class
106f43a50: d00c77a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106f43a54: f946411b    	ldr	x27, [x8, #0xc80] ; getService:
106f43a58: b00c77c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106f43a5c: f940c91c    	ldr	x28, [x8, #0x190] ; getContactByName:
106f43a60: 900c77c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106f43a64: f9434d09    	ldr	x9, [x8, #0x698] ; m_nsUsrName
106f43a68: d00c77a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106f43a6c: f942c908    	ldr	x8, [x8, #0x590] ; safeSetObject:forKey:
106f43a70: a90327e8    	stp	x8, x9, [sp, #0x30]
106f43a74: f9404be8    	ldr	x8, [sp, #0x90]
106f43a78: f9400108    	ldr	x8, [x8]
106f43a7c: eb15011f    	cmp	x8, x21
106f43a80: 54000060    	b.eq	0x106f43a8c <_Flutter_MMFoundation_BindContext+0x341f670>
106f43a84: f94013e0    	ldr	x0, [sp, #0x20]
106f43a88: 94338db2    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
106f43a8c: f94047e8    	ldr	x8, [sp, #0x88]
106f43a90: f8747916    	ldr	x22, [x8, x20, lsl #3]
106f43a94: 900c9188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106f43a98: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
106f43a9c: aa1903e1    	mov	x1, x25
106f43aa0: 94338da7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43aa4: aa1d03fd    	mov	x29, x29
106f43aa8: 94338da8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43aac: aa0003f3    	mov	x19, x0
106f43ab0: b00c9188    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106f43ab4: f9401500    	ldr	x0, [x8, #0x28] ; CContactMgr
106f43ab8: aa1a03e1    	mov	x1, x26
106f43abc: 94338da0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43ac0: aa0003e2    	mov	x2, x0
106f43ac4: aa1303e0    	mov	x0, x19
106f43ac8: aa1b03e1    	mov	x1, x27
106f43acc: 94338d9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43ad0: aa1d03fd    	mov	x29, x29
106f43ad4: 94338d9d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43ad8: aa0003f7    	mov	x23, x0
106f43adc: aa1c03e1    	mov	x1, x28
106f43ae0: aa1603e2    	mov	x2, x22
106f43ae4: 94338d96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43ae8: aa1d03fd    	mov	x29, x29
106f43aec: 94338d97    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43af0: aa0003f6    	mov	x22, x0
106f43af4: aa1703e0    	mov	x0, x23
106f43af8: 94338d97    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43afc: aa1303e0    	mov	x0, x19
106f43b00: 94338d95    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43b04: b40001b6    	cbz	x22, 0x106f43b38 <_Flutter_MMFoundation_BindContext+0x341f71c>
106f43b08: aa1603e0    	mov	x0, x22
106f43b0c: f9401fe1    	ldr	x1, [sp, #0x38]
106f43b10: 94338d8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43b14: aa1d03fd    	mov	x29, x29
106f43b18: 94338d8c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43b1c: aa0003f3    	mov	x19, x0
106f43b20: a94287e0    	ldp	x0, x1, [sp, #0x28]
106f43b24: aa1603e2    	mov	x2, x22
106f43b28: aa1303e3    	mov	x3, x19
106f43b2c: 94338d84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43b30: aa1303e0    	mov	x0, x19
106f43b34: 94338d88    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43b38: aa1603e0    	mov	x0, x22
106f43b3c: 94338d86    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43b40: 91000694    	add	x20, x20, #0x1
106f43b44: eb14031f    	cmp	x24, x20
106f43b48: 54fff961    	b.ne	0x106f43a74 <_Flutter_MMFoundation_BindContext+0x341f658>
106f43b4c: 910203e2    	add	x2, sp, #0x80
106f43b50: d10383a3    	sub	x3, x29, #0xe0
106f43b54: a94183e1    	ldp	x1, x0, [sp, #0x18]
106f43b58: 52800204    	mov	w4, #0x10               ; =16
106f43b5c: 94338d78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43b60: aa0003f8    	mov	x24, x0
106f43b64: b5fff6c0    	cbnz	x0, 0x106f43a3c <_Flutter_MMFoundation_BindContext+0x341f620>
106f43b68: f94013e0    	ldr	x0, [sp, #0x20]
106f43b6c: 94338d7a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43b70: 900c9188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106f43b74: f9454100    	ldr	x0, [x8, #0xa80]
106f43b78: f94007e1    	ldr	x1, [sp, #0x8]
106f43b7c: 94338d70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43b80: aa1d03fd    	mov	x29, x29
106f43b84: 94338d71    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43b88: aa0003f5    	mov	x21, x0
106f43b8c: 4f00e400    	movi.16b	v0, #0x0
106f43b90: ad0203e0    	stp	q0, q0, [sp, #0x40]
106f43b94: ad0303e0    	stp	q0, q0, [sp, #0x60]
106f43b98: d00c9808    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106f43b9c: b98d8908    	ldrsw	x8, [x8, #0xd88]
106f43ba0: f9400bfc    	ldr	x28, [sp, #0x10]
106f43ba4: f8686b97    	ldr	x23, [x28, x8]
106f43ba8: aa1703e0    	mov	x0, x23
106f43bac: 94338d63    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106f43bb0: 910103e2    	add	x2, sp, #0x40
106f43bb4: 910303e3    	add	x3, sp, #0xc0
106f43bb8: f9400fe1    	ldr	x1, [sp, #0x18]
106f43bbc: 52800204    	mov	w4, #0x10               ; =16
106f43bc0: 94338d5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43bc4: b4000540    	cbz	x0, 0x106f43c6c <_Flutter_MMFoundation_BindContext+0x341f850>
106f43bc8: aa0003f4    	mov	x20, x0
106f43bcc: f9402be8    	ldr	x8, [sp, #0x50]
106f43bd0: f940011a    	ldr	x26, [x8]
106f43bd4: d280001b    	mov	x27, #0x0               ; =0
106f43bd8: 900c77c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106f43bdc: f9434d18    	ldr	x24, [x8, #0x698] ; m_nsUsrName
106f43be0: d00c77a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106f43be4: f942c919    	ldr	x25, [x8, #0x590] ; safeSetObject:forKey:
106f43be8: f9402be8    	ldr	x8, [sp, #0x50]
106f43bec: f9400108    	ldr	x8, [x8]
106f43bf0: eb1a011f    	cmp	x8, x26
106f43bf4: 54000060    	b.eq	0x106f43c00 <_Flutter_MMFoundation_BindContext+0x341f7e4>
106f43bf8: aa1703e0    	mov	x0, x23
106f43bfc: 94338d55    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
106f43c00: f94027e8    	ldr	x8, [sp, #0x48]
106f43c04: f87b7916    	ldr	x22, [x8, x27, lsl #3]
106f43c08: b40001d6    	cbz	x22, 0x106f43c40 <_Flutter_MMFoundation_BindContext+0x341f824>
106f43c0c: aa1603e0    	mov	x0, x22
106f43c10: aa1803e1    	mov	x1, x24
106f43c14: 94338d4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43c18: aa1d03fd    	mov	x29, x29
106f43c1c: 94338d4b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43c20: aa0003f3    	mov	x19, x0
106f43c24: aa1503e0    	mov	x0, x21
106f43c28: aa1903e1    	mov	x1, x25
106f43c2c: aa1603e2    	mov	x2, x22
106f43c30: aa1303e3    	mov	x3, x19
106f43c34: 94338d42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43c38: aa1303e0    	mov	x0, x19
106f43c3c: 94338d46    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43c40: 9100077b    	add	x27, x27, #0x1
106f43c44: eb1b029f    	cmp	x20, x27
106f43c48: 54fffd01    	b.ne	0x106f43be8 <_Flutter_MMFoundation_BindContext+0x341f7cc>
106f43c4c: 910103e2    	add	x2, sp, #0x40
106f43c50: 910303e3    	add	x3, sp, #0xc0
106f43c54: aa1703e0    	mov	x0, x23
106f43c58: f9400fe1    	ldr	x1, [sp, #0x18]
106f43c5c: 52800204    	mov	w4, #0x10               ; =16
106f43c60: 94338d37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43c64: aa0003f4    	mov	x20, x0
106f43c68: b5fffb60    	cbnz	x0, 0x106f43bd4 <_Flutter_MMFoundation_BindContext+0x341f7b8>
106f43c6c: aa1703e0    	mov	x0, x23
106f43c70: 94338d39    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43c74: f00c9188    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
106f43c78: f9463500    	ldr	x0, [x8, #0xc68] ; MultiSelectContactsViewController
106f43c7c: 94338d37    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
106f43c80: aa0003f6    	mov	x22, x0
106f43c84: d00c77a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106f43c88: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
106f43c8c: aa1c03e2    	mov	x2, x28
106f43c90: 94338d2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43c94: f00c8e28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106f43c98: f9473901    	ldr	x1, [x8, #0xe70] ; subtitle
106f43c9c: aa1c03e0    	mov	x0, x28
106f43ca0: 94338d27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43ca4: aa1d03fd    	mov	x29, x29
106f43ca8: 94338d28    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43cac: aa0003f3    	mov	x19, x0
106f43cb0: d00c7f28    	adrp	x8, 0x11ff29000 <dyld_stub_binder+0x11ff29000>
106f43cb4: f9444501    	ldr	x1, [x8, #0x888] ; setCustomSubTitle:
106f43cb8: aa1603e0    	mov	x0, x22
106f43cbc: aa1303e2    	mov	x2, x19
106f43cc0: 94338d1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43cc4: aa1303e0    	mov	x0, x19
106f43cc8: 94338d23    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43ccc: d00c7f28    	adrp	x8, 0x11ff29000 <dyld_stub_binder+0x11ff29000>
106f43cd0: f9444901    	ldr	x1, [x8, #0x890] ; setM_dicMultiSelect:
106f43cd4: aa1603e0    	mov	x0, x22
106f43cd8: f94017f7    	ldr	x23, [sp, #0x28]
106f43cdc: aa1703e2    	mov	x2, x23
106f43ce0: 94338d17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43ce4: 900c77c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106f43ce8: f9471101    	ldr	x1, [x8, #0xe20] ; setM_dicIgnoreContact:
106f43cec: aa1603e0    	mov	x0, x22
106f43cf0: aa1503e2    	mov	x2, x21
106f43cf4: 94338d12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43cf8: d00c8268    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
106f43cfc: f9473901    	ldr	x1, [x8, #0xe70] ; headerBarText
106f43d00: aa1c03e0    	mov	x0, x28
106f43d04: 94338d0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43d08: aa1d03fd    	mov	x29, x29
106f43d0c: 94338d0f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43d10: aa0003f3    	mov	x19, x0
106f43d14: b00c85e8    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
106f43d18: f9448101    	ldr	x1, [x8, #0x900] ; setHeaderBarText:
106f43d1c: aa1603e0    	mov	x0, x22
106f43d20: aa1303e2    	mov	x2, x19
106f43d24: 94338d06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43d28: aa1303e0    	mov	x0, x19
106f43d2c: 94338d0a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43d30: 900c7a48    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
106f43d34: f9465101    	ldr	x1, [x8, #0xca0] ; setM_rightBarButtonSelectedStyle:
106f43d38: aa1603e0    	mov	x0, x22
106f43d3c: 52800042    	mov	w2, #0x2                ; =2
106f43d40: 94338cff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43d44: d00c8268    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
106f43d48: f947bd01    	ldr	x1, [x8, #0xf78] ; customContactListFooterView
106f43d4c: aa1c03e0    	mov	x0, x28
106f43d50: 94338cfb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43d54: aa1d03fd    	mov	x29, x29
106f43d58: 94338cfc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43d5c: aa0003f3    	mov	x19, x0
106f43d60: b00c85e8    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
106f43d64: f9448501    	ldr	x1, [x8, #0x908] ; setCustomContactListFooterView:
106f43d68: aa1603e0    	mov	x0, x22
106f43d6c: aa1303e2    	mov	x2, x19
106f43d70: 94338cf3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43d74: aa1303e0    	mov	x0, x19
106f43d78: 94338cf7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43d7c: f00c8268    	adrp	x8, 0x11ff92000 <dyld_stub_binder+0x11ff92000>
106f43d80: f940c501    	ldr	x1, [x8, #0x188] ; noResultTipText
106f43d84: aa1c03e0    	mov	x0, x28
106f43d88: 94338ced    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43d8c: aa1d03fd    	mov	x29, x29
106f43d90: 94338cee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43d94: aa0003f3    	mov	x19, x0
106f43d98: b00c85e8    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
106f43d9c: f9448901    	ldr	x1, [x8, #0x910] ; setNoResultTipText:
106f43da0: aa1603e0    	mov	x0, x22
106f43da4: aa1303e2    	mov	x2, x19
106f43da8: 94338ce5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43dac: aa1303e0    	mov	x0, x19
106f43db0: 94338ce9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43db4: f00c7888    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
106f43db8: f9429101    	ldr	x1, [x8, #0x520] ; setReportBizType:
106f43dbc: aa1603e0    	mov	x0, x22
106f43dc0: 52800182    	mov	w2, #0xc                ; =12
106f43dc4: 94338cde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43dc8: b00c85e8    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
106f43dcc: f9448d01    	ldr	x1, [x8, #0x918] ; commonSetupMutiSelectContactViewController:
106f43dd0: aa1c03e0    	mov	x0, x28
106f43dd4: aa1603e2    	mov	x2, x22
106f43dd8: 94338cd9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43ddc: 900c9188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106f43de0: f947d500    	ldr	x0, [x8, #0xfa8] ; MMUINavigationController
106f43de4: 94338cdf    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106f43de8: 900c8e08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106f43dec: f940d901    	ldr	x1, [x8, #0x1b0] ; initWithRootViewController:
106f43df0: aa1603e2    	mov	x2, x22
106f43df4: 94338cd2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43df8: aa0003f3    	mov	x19, x0
106f43dfc: 900c77c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106f43e00: f945d501    	ldr	x1, [x8, #0xba8] ; getViewController
106f43e04: aa1c03e0    	mov	x0, x28
106f43e08: 94338ccd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43e0c: aa1d03fd    	mov	x29, x29
106f43e10: 94338cce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43e14: aa0003f4    	mov	x20, x0
106f43e18: 900c77c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106f43e1c: f945d901    	ldr	x1, [x8, #0xbb0] ; PresentModalViewController:animated:
106f43e20: aa1303e2    	mov	x2, x19
106f43e24: 52800023    	mov	w3, #0x1                ; =1
106f43e28: 94338cc5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43e2c: aa1403e0    	mov	x0, x20
106f43e30: 94338cc9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43e34: aa1303e0    	mov	x0, x19
106f43e38: 94338cc7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43e3c: aa1603e0    	mov	x0, x22
106f43e40: 94338cc5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43e44: aa1503e0    	mov	x0, x21
106f43e48: 94338cc3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43e4c: aa1703e0    	mov	x0, x23
106f43e50: 94338cc1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43e54: f85a03a8    	ldur	x8, [x29, #-0x60]
106f43e58: 900b3569    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106f43e5c: f9405929    	ldr	x9, [x9, #0xb0]
106f43e60: f9400129    	ldr	x9, [x9]
106f43e64: eb08013f    	cmp	x9, x8
106f43e68: 54000121    	b.ne	0x106f43e8c <_Flutter_MMFoundation_BindContext+0x341fa70>
106f43e6c: 910743ff    	add	sp, sp, #0x1d0
106f43e70: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106f43e74: a9444ff4    	ldp	x20, x19, [sp, #0x40]
106f43e78: a94357f6    	ldp	x22, x21, [sp, #0x30]
106f43e7c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
106f43e80: a94167fa    	ldp	x26, x25, [sp, #0x10]
106f43e84: a8c66ffc    	ldp	x28, x27, [sp], #0x60
106f43e88: d65f03c0    	ret
106f43e8c: 94338cba    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
