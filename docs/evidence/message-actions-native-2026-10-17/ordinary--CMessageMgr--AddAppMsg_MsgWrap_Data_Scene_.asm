
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b3aa84: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
104b3aa88: a90167fa    	stp	x26, x25, [sp, #0x10]
104b3aa8c: a9025ff8    	stp	x24, x23, [sp, #0x20]
104b3aa90: a90357f6    	stp	x22, x21, [sp, #0x30]
104b3aa94: a9044ff4    	stp	x20, x19, [sp, #0x40]
104b3aa98: a9057bfd    	stp	x29, x30, [sp, #0x50]
104b3aa9c: 910143fd    	add	x29, sp, #0x50
104b3aaa0: d10883ff    	sub	sp, sp, #0x220
104b3aaa4: aa0503fc    	mov	x28, x5
104b3aaa8: aa0403f5    	mov	x21, x4
104b3aaac: aa0303f4    	mov	x20, x3
104b3aab0: aa0203f3    	mov	x19, x2
104b3aab4: aa0003f7    	mov	x23, x0
104b3aab8: b00c55a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104b3aabc: f9405908    	ldr	x8, [x8, #0xb0]
104b3aac0: f9400108    	ldr	x8, [x8]
104b3aac4: f81a03a8    	stur	x8, [x29, #-0x60]
104b3aac8: 900e0828    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b3aacc: 52800029    	mov	w9, #0x1                ; =1
104b3aad0: 3915cd09    	strb	w9, [x8, #0x573]
104b3aad4: aa0203e0    	mov	x0, x2
104b3aad8: 94c3b198    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3aadc: aa1403e0    	mov	x0, x20
104b3aae0: 94c3b196    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3aae4: aa1503e0    	mov	x0, x21
104b3aae8: 94c3b194    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3aaec: b4001494    	cbz	x20, 0x104b3ad7c <_Flutter_MMFoundation_BindContext+0x1016960>
104b3aaf0: b00dae48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104b3aaf4: f946e918    	ldr	x24, [x8, #0xdd0] ; length
104b3aaf8: aa1503e0    	mov	x0, x21
104b3aafc: aa1803e1    	mov	x1, x24
104b3ab00: 94c3b18f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ab04: b4000120    	cbz	x0, 0x104b3ab28 <_Flutter_MMFoundation_BindContext+0x101670c>
104b3ab08: aa1503e0    	mov	x0, x21
104b3ab0c: aa1803e1    	mov	x1, x24
104b3ab10: 94c3b18b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ab14: aa0003e2    	mov	x2, x0
104b3ab18: b00d9888    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b3ab1c: f9405901    	ldr	x1, [x8, #0xb0] ; setM_uiAppDataSize:
104b3ab20: aa1403e0    	mov	x0, x20
104b3ab24: 94c3b186    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ab28: 900d9828    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b3ab2c: f941411b    	ldr	x27, [x8, #0x280] ; m_uiAppMsgInnerType
104b3ab30: aa1403e0    	mov	x0, x20
104b3ab34: aa1b03e1    	mov	x1, x27
104b3ab38: 94c3b181    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ab3c: 7100201f    	cmp	w0, #0x8
104b3ab40: 540007a1    	b.ne	0x104b3ac34 <_Flutter_MMFoundation_BindContext+0x1016818>
104b3ab44: b00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3ab48: f940b101    	ldr	x1, [x8, #0x160] ; m_nsEmoticonMD5
104b3ab4c: aa1403e0    	mov	x0, x20
104b3ab50: 94c3b17b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ab54: aa1d03fd    	mov	x29, x29
104b3ab58: 94c3b17c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3ab5c: aa0003f9    	mov	x25, x0
104b3ab60: aa1803e1    	mov	x1, x24
104b3ab64: 94c3b176    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ab68: aa0003fa    	mov	x26, x0
104b3ab6c: aa1903e0    	mov	x0, x25
104b3ab70: 94c3b179    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3ab74: b500061a    	cbnz	x26, 0x104b3ac34 <_Flutter_MMFoundation_BindContext+0x1016818>
104b3ab78: a938ffbf    	stp	xzr, xzr, [x29, #-0x78]
104b3ab7c: f81983bf    	stur	xzr, [x29, #-0x68]
104b3ab80: aa1503e0    	mov	x0, x21
104b3ab84: 94c3b189    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
104b3ab88: b00dae28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b3ab8c: f9447501    	ldr	x1, [x8, #0x8e8] ; bytes
104b3ab90: 94c3b16b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ab94: aa0003f9    	mov	x25, x0
104b3ab98: aa1503e0    	mov	x0, x21
104b3ab9c: aa1803e1    	mov	x1, x24
104b3aba0: 94c3b167    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3aba4: aa0003e2    	mov	x2, x0
104b3aba8: d101e3a0    	sub	x0, x29, #0x78
104b3abac: aa1903e1    	mov	x1, x25
104b3abb0: 94c349ed    	bl	0x107c0d364 <_Flutter_MMFoundation_BindContext+0x40e8f48>
104b3abb4: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3abb8: f9454519    	ldr	x25, [x8, #0xa88]
104b3abbc: 910383f6    	add	x22, sp, #0xe0
104b3abc0: 910383e8    	add	x8, sp, #0xe0
104b3abc4: d101e3a0    	sub	x0, x29, #0x78
104b3abc8: 94c349e5    	bl	0x107c0d35c <_Flutter_MMFoundation_BindContext+0x40e8f40>
104b3abcc: 39c3dfe8    	ldrsb	w8, [sp, #0xf7]
104b3abd0: f94073e9    	ldr	x9, [sp, #0xe0]
104b3abd4: 7100011f    	cmp	w8, #0x0
104b3abd8: 9a96b122    	csel	x2, x9, x22, lt
104b3abdc: 900dae88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104b3abe0: f946ad01    	ldr	x1, [x8, #0xd58] ; stringWithUTF8String:
104b3abe4: aa1903e0    	mov	x0, x25
104b3abe8: 94c3b155    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3abec: aa1d03fd    	mov	x29, x29
104b3abf0: 94c3b156    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3abf4: aa0003f9    	mov	x25, x0
104b3abf8: d00d9b28    	adrp	x8, 0x11fea0000 <dyld_stub_binder+0x11fea0000>
104b3abfc: f945ed01    	ldr	x1, [x8, #0xbd8] ; setM_nsEmoticonMD5:
104b3ac00: aa1403e0    	mov	x0, x20
104b3ac04: aa1903e2    	mov	x2, x25
104b3ac08: 94c3b14d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ac0c: aa1903e0    	mov	x0, x25
104b3ac10: 94c3b151    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3ac14: 39c3dfe8    	ldrsb	w8, [sp, #0xf7]
104b3ac18: 36f800a8    	tbz	w8, #0x1f, 0x104b3ac2c <_Flutter_MMFoundation_BindContext+0x1016810>
104b3ac1c: f94073e0    	ldr	x0, [sp, #0xe0]
104b3ac20: f9407be8    	ldr	x8, [sp, #0xf0]
104b3ac24: 9240f901    	and	x1, x8, #0x7fffffffffffffff
104b3ac28: 94c3b169    	bl	0x107c271cc <_Flutter_MMFoundation_BindContext+0x4102db0>
104b3ac2c: d101e3a0    	sub	x0, x29, #0x78
104b3ac30: 94c349ca    	bl	0x107c0d358 <_Flutter_MMFoundation_BindContext+0x40e8f3c>
104b3ac34: f00db228    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
104b3ac38: f9426900    	ldr	x0, [x8, #0x4d0]
104b3ac3c: 900da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b3ac40: f9456101    	ldr	x1, [x8, #0xac0] ; checkConvertToLargeFileMsg:
104b3ac44: aa1403e2    	mov	x2, x20
104b3ac48: 94c3b13d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ac4c: b00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3ac50: f9467101    	ldr	x1, [x8, #0xce0] ; UpdateContent:
104b3ac54: aa1403e0    	mov	x0, x20
104b3ac58: d2800002    	mov	x2, #0x0                ; =0
104b3ac5c: 94c3b138    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ac60: 900d98a8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
104b3ac64: f9401501    	ldr	x1, [x8, #0x28] ; isReferMsgType
104b3ac68: aa1403e0    	mov	x0, x20
104b3ac6c: 94c3b134    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ac70: b00db1d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104b3ac74: b90047fc    	str	w28, [sp, #0x44]
104b3ac78: 36000be0    	tbz	w0, #0x0, 0x104b3adf4 <_Flutter_MMFoundation_BindContext+0x10169d8>
104b3ac7c: b00d9848    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b3ac80: f9464501    	ldr	x1, [x8, #0xc88] ; referingMessageWrap
104b3ac84: aa1403e0    	mov	x0, x20
104b3ac88: 94c3b12d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ac8c: aa1d03fd    	mov	x29, x29
104b3ac90: 94c3b12e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3ac94: aa0003fa    	mov	x26, x0
104b3ac98: b00d9888    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b3ac9c: f9423101    	ldr	x1, [x8, #0x460] ; referPartialInfo
104b3aca0: 94c3b127    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3aca4: aa1d03fd    	mov	x29, x29
104b3aca8: 94c3b128    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3acac: aa0003f9    	mov	x25, x0
104b3acb0: b00d9888    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b3acb4: f9423501    	ldr	x1, [x8, #0x468] ; generatePartialtextXML
104b3acb8: 94c3b121    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3acbc: aa1d03fd    	mov	x29, x29
104b3acc0: 94c3b122    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3acc4: aa0003fc    	mov	x28, x0
104b3acc8: aa1903e0    	mov	x0, x25
104b3accc: 94c3b122    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3acd0: f94536c8    	ldr	x8, [x22, #0xa68]
104b3acd4: f9001fe8    	str	x8, [sp, #0x38]
104b3acd8: d00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b3acdc: f947d119    	ldr	x25, [x8, #0xfa0] ; m_uiMesLocalID
104b3ace0: aa1403e0    	mov	x0, x20
104b3ace4: aa1903e1    	mov	x1, x25
104b3ace8: 94c3b115    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3acec: aa1803f6    	mov	x22, x24
104b3acf0: aa1503f8    	mov	x24, x21
104b3acf4: aa1303f5    	mov	x21, x19
104b3acf8: aa1b03f3    	mov	x19, x27
104b3acfc: aa1703fb    	mov	x27, x23
104b3ad00: aa0003f7    	mov	x23, x0
104b3ad04: d00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b3ad08: f947d501    	ldr	x1, [x8, #0xfa8] ; m_n64MesSvrID
104b3ad0c: aa1a03e0    	mov	x0, x26
104b3ad10: 94c3b10b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ad14: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3ad18: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3ad1c: a90173e0    	stp	x0, x28, [sp, #0x10]
104b3ad20: d00ce348    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b3ad24: 913ca108    	add	x8, x8, #0xf28
104b3ad28: a9005fe8    	stp	x8, x23, [sp]
104b3ad2c: aa1b03f7    	mov	x23, x27
104b3ad30: aa1303fb    	mov	x27, x19
104b3ad34: aa1503f3    	mov	x19, x21
104b3ad38: aa1803f5    	mov	x21, x24
104b3ad3c: aa1603f8    	mov	x24, x22
104b3ad40: d00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3ad44: 910cb4a5    	add	x5, x5, #0x32d
104b3ad48: 900b6627    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b3ad4c: 9101c8e7    	add	x7, x7, #0x72
104b3ad50: f9401fe0    	ldr	x0, [sp, #0x38]
104b3ad54: 52800042    	mov	w2, #0x2                ; =2
104b3ad58: d2800003    	mov	x3, #0x0                ; =0
104b3ad5c: 52800004    	mov	w4, #0x0                ; =0
104b3ad60: 5281b1e6    	mov	w6, #0xd8f              ; =3471
104b3ad64: 94c3b0f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ad68: aa1c03e0    	mov	x0, x28
104b3ad6c: 94c3b0fa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3ad70: aa1a03e0    	mov	x0, x26
104b3ad74: 94c3b0f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3ad78: 14000021    	b	0x104b3adfc <_Flutter_MMFoundation_BindContext+0x10169e0>
104b3ad7c: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3ad80: f9453516    	ldr	x22, [x8, #0xa68]
104b3ad84: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3ad88: f9454500    	ldr	x0, [x8, #0xa88]
104b3ad8c: d00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b3ad90: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104b3ad94: aa1303e2    	mov	x2, x19
104b3ad98: 94c3b0e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ad9c: aa1d03fd    	mov	x29, x29
104b3ada0: 94c3b0ea    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3ada4: aa0003f7    	mov	x23, x0
104b3ada8: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3adac: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3adb0: d00ce348    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b3adb4: 913aa108    	add	x8, x8, #0xea8
104b3adb8: a90003e8    	stp	x8, x0, [sp]
104b3adbc: f00b3743    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3adc0: 9107f063    	add	x3, x3, #0x1fc
104b3adc4: d00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3adc8: 910cb4a5    	add	x5, x5, #0x32d
104b3adcc: 900b6627    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b3add0: 9101c8e7    	add	x7, x7, #0x72
104b3add4: aa1603e0    	mov	x0, x22
104b3add8: 52800082    	mov	w2, #0x4                ; =4
104b3addc: 52800004    	mov	w4, #0x0                ; =0
104b3ade0: 5281af86    	mov	w6, #0xd7c              ; =3452
104b3ade4: 94c3b0d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ade8: aa1703e0    	mov	x0, x23
104b3adec: 94c3b0da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3adf0: 14000185    	b	0x104b3b404 <_Flutter_MMFoundation_BindContext+0x1016fe8>
104b3adf4: d00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b3adf8: f947d119    	ldr	x25, [x8, #0xfa0] ; m_uiMesLocalID
104b3adfc: d00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b3ae00: f9454d01    	ldr	x1, [x8, #0xa98] ; AddLocalMsg:MsgWrap:
104b3ae04: aa1703e0    	mov	x0, x23
104b3ae08: aa1303e2    	mov	x2, x19
104b3ae0c: aa1403e3    	mov	x3, x20
104b3ae10: 94c3b0cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ae14: aa1403e0    	mov	x0, x20
104b3ae18: aa1903e1    	mov	x1, x25
104b3ae1c: 94c3b0c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ae20: 34001200    	cbz	w0, 0x104b3b060 <_Flutter_MMFoundation_BindContext+0x1016c44>
104b3ae24: f9001bf7    	str	x23, [sp, #0x30]
104b3ae28: b00d9888    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b3ae2c: f940691a    	ldr	x26, [x8, #0xd0] ; revokeBatchId
104b3ae30: aa1403e0    	mov	x0, x20
104b3ae34: aa1a03e1    	mov	x1, x26
104b3ae38: 94c3b0c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ae3c: aa1d03fd    	mov	x29, x29
104b3ae40: 94c3b0c2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3ae44: aa0003f6    	mov	x22, x0
104b3ae48: aa1803e1    	mov	x1, x24
104b3ae4c: 94c3b0bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ae50: aa0003f7    	mov	x23, x0
104b3ae54: aa1603e0    	mov	x0, x22
104b3ae58: 94c3b0bf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3ae5c: b4000537    	cbz	x23, 0x104b3af00 <_Flutter_MMFoundation_BindContext+0x1016ae4>
104b3ae60: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3ae64: f945e900    	ldr	x0, [x8, #0xbd0]
104b3ae68: d00dae28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b3ae6c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104b3ae70: 94c3b0b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ae74: aa1d03fd    	mov	x29, x29
104b3ae78: 94c3b0b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3ae7c: aa0003f6    	mov	x22, x0
104b3ae80: 900db1e8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104b3ae84: f940f500    	ldr	x0, [x8, #0x1e8] ; ا7 
104b3ae88: b00dae28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b3ae8c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104b3ae90: 94c3b0ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ae94: aa0003e2    	mov	x2, x0
104b3ae98: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3ae9c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104b3aea0: aa1603e0    	mov	x0, x22
104b3aea4: 94c3b0a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3aea8: aa1d03fd    	mov	x29, x29
104b3aeac: 94c3b0a7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3aeb0: aa0003f7    	mov	x23, x0
104b3aeb4: aa1403e0    	mov	x0, x20
104b3aeb8: aa1a03e1    	mov	x1, x26
104b3aebc: 94c3b0a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3aec0: aa1d03fd    	mov	x29, x29
104b3aec4: 94c3b0a1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3aec8: aa0003fa    	mov	x26, x0
104b3aecc: 900da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b3aed0: f943dd01    	ldr	x1, [x8, #0x7b8] ; addBatchSendForUser:record:identifier:
104b3aed4: aa1703e0    	mov	x0, x23
104b3aed8: aa1303e2    	mov	x2, x19
104b3aedc: aa1403e3    	mov	x3, x20
104b3aee0: aa1a03e4    	mov	x4, x26
104b3aee4: 94c3b096    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3aee8: aa1a03e0    	mov	x0, x26
104b3aeec: 94c3b09a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3aef0: aa1703e0    	mov	x0, x23
104b3aef4: 94c3b098    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3aef8: aa1603e0    	mov	x0, x22
104b3aefc: 94c3b096    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3af00: f9001ff3    	str	x19, [sp, #0x38]
104b3af04: d00db1c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3af08: f9411d00    	ldr	x0, [x8, #0x238]
104b3af0c: d00d9b48    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104b3af10: f9423d01    	ldr	x1, [x8, #0x478] ; clearLocalImage:
104b3af14: aa1403e2    	mov	x2, x20
104b3af18: 94c3b089    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3af1c: b00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3af20: f9453516    	ldr	x22, [x8, #0xa68]
104b3af24: aa1403e0    	mov	x0, x20
104b3af28: f90017f9    	str	x25, [sp, #0x28]
104b3af2c: aa1903e1    	mov	x1, x25
104b3af30: 94c3b083    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3af34: aa0003f7    	mov	x23, x0
104b3af38: aa1403e0    	mov	x0, x20
104b3af3c: aa1b03e1    	mov	x1, x27
104b3af40: 94c3b07f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3af44: aa0003fc    	mov	x28, x0
104b3af48: 900d9828    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b3af4c: f9415d01    	ldr	x1, [x8, #0x2b8] ; m_nsTitle
104b3af50: aa1403e0    	mov	x0, x20
104b3af54: 94c3b07a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3af58: aa1d03fd    	mov	x29, x29
104b3af5c: 94c3b07b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3af60: aa0003fa    	mov	x26, x0
104b3af64: aa1803e1    	mov	x1, x24
104b3af68: 94c3b075    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3af6c: aa0003f9    	mov	x25, x0
104b3af70: 900d9828    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b3af74: f9417101    	ldr	x1, [x8, #0x2e0] ; m_nsContent
104b3af78: aa1403e0    	mov	x0, x20
104b3af7c: 94c3b070    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3af80: aa1d03fd    	mov	x29, x29
104b3af84: 94c3b071    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3af88: aa1b03f3    	mov	x19, x27
104b3af8c: aa0003fb    	mov	x27, x0
104b3af90: aa1803e1    	mov	x1, x24
104b3af94: 94c3b06a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3af98: f00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3af9c: f942a908    	ldr	x8, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3afa0: a90183f9    	stp	x25, x0, [sp, #0x18]
104b3afa4: aa0803f9    	mov	x25, x8
104b3afa8: a900f3f7    	stp	x23, x28, [sp, #0x8]
104b3afac: d00ce348    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b3afb0: 913d2108    	add	x8, x8, #0xf48
104b3afb4: f90003e8    	str	x8, [sp]
104b3afb8: f00b3743    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3afbc: 9107f063    	add	x3, x3, #0x1fc
104b3afc0: d00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3afc4: 910cb4a5    	add	x5, x5, #0x32d
104b3afc8: 900b6627    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b3afcc: 9101c8e7    	add	x7, x7, #0x72
104b3afd0: aa1603e0    	mov	x0, x22
104b3afd4: aa1903e1    	mov	x1, x25
104b3afd8: 52800042    	mov	w2, #0x2                ; =2
104b3afdc: 52800004    	mov	w4, #0x0                ; =0
104b3afe0: 5281b446    	mov	w6, #0xda2              ; =3490
104b3afe4: 94c3b056    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3afe8: aa1b03e0    	mov	x0, x27
104b3afec: 94c3b05a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3aff0: aa1a03e0    	mov	x0, x26
104b3aff4: 94c3b058    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3aff8: aa1503e0    	mov	x0, x21
104b3affc: aa1803e1    	mov	x1, x24
104b3b000: 94c3b04f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b004: b4000f80    	cbz	x0, 0x104b3b1f4 <_Flutter_MMFoundation_BindContext+0x1016dd8>
104b3b008: aa1403e0    	mov	x0, x20
104b3b00c: aa1303e1    	mov	x1, x19
104b3b010: 94c3b04b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b014: 7100201f    	cmp	w0, #0x8
104b3b018: 54000481    	b.ne	0x104b3b0a8 <_Flutter_MMFoundation_BindContext+0x1016c8c>
104b3b01c: b00db1c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3b020: f9452d16    	ldr	x22, [x8, #0xa58]
104b3b024: 900d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3b028: f940b101    	ldr	x1, [x8, #0x160] ; m_nsEmoticonMD5
104b3b02c: aa1403e0    	mov	x0, x20
104b3b030: 94c3b043    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b034: aa1d03fd    	mov	x29, x29
104b3b038: 94c3b044    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3b03c: aa0003fb    	mov	x27, x0
104b3b040: f00d9948    	adrp	x8, 0x11fe66000 <dyld_stub_binder+0x11fe66000>
104b3b044: f9461501    	ldr	x1, [x8, #0xc28] ; saveEmoticonToEmoticonDirForMd5:data:isCleanable:
104b3b048: aa1603e0    	mov	x0, x22
104b3b04c: aa1b03e2    	mov	x2, x27
104b3b050: aa1503e3    	mov	x3, x21
104b3b054: 52800024    	mov	w4, #0x1                ; =1
104b3b058: 94c3b039    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b05c: 14000064    	b	0x104b3b1ec <_Flutter_MMFoundation_BindContext+0x1016dd0>
104b3b060: 900db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3b064: f9453500    	ldr	x0, [x8, #0xa68]
104b3b068: d00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3b06c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3b070: b00ce348    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b3b074: 913b2108    	add	x8, x8, #0xec8
104b3b078: a90053e8    	stp	x8, x20, [sp]
104b3b07c: d00b3743    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3b080: 9107f063    	add	x3, x3, #0x1fc
104b3b084: b00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3b088: 910cb4a5    	add	x5, x5, #0x32d
104b3b08c: f00b6607    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b3b090: 9101c8e7    	add	x7, x7, #0x72
104b3b094: 52800082    	mov	w2, #0x4                ; =4
104b3b098: 52800004    	mov	w4, #0x0                ; =0
104b3b09c: 5281b286    	mov	w6, #0xd94              ; =3476
104b3b0a0: 94c3b027    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b0a4: 140000d8    	b	0x104b3b404 <_Flutter_MMFoundation_BindContext+0x1016fe8>
104b3b0a8: b00db1c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3b0ac: f9451500    	ldr	x0, [x8, #0xa28]
104b3b0b0: f00dae68    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104b3b0b4: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
104b3b0b8: 94c3b021    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b0bc: aa1d03fd    	mov	x29, x29
104b3b0c0: 94c3b022    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3b0c4: aa0003f6    	mov	x22, x0
104b3b0c8: b00db1a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104b3b0cc: f9456902    	ldr	x2, [x8, #0xad0]
104b3b0d0: 900d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3b0d4: f944c91b    	ldr	x27, [x8, #0x990] ; GetPathOfAppDataByUserName:andMessageWrap:retStrPath:
104b3b0d8: 900d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3b0dc: f9403101    	ldr	x1, [x8, #0x60] ; getClsMethodObservers:selector:
104b3b0e0: aa1b03e3    	mov	x3, x27
104b3b0e4: 94c3b016    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b0e8: aa1d03fd    	mov	x29, x29
104b3b0ec: 94c3b017    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3b0f0: aa0003fc    	mov	x28, x0
104b3b0f4: aa1603e0    	mov	x0, x22
104b3b0f8: 94c3b017    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3b0fc: 4f00e400    	movi.16b	v0, #0x0
104b3b100: ad0603e0    	stp	q0, q0, [sp, #0xc0]
104b3b104: ad0503e0    	stp	q0, q0, [sp, #0xa0]
104b3b108: b00dae28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b3b10c: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104b3b110: 910283e2    	add	x2, sp, #0xa0
104b3b114: d103e3a3    	sub	x3, x29, #0xf8
104b3b118: aa1c03e0    	mov	x0, x28
104b3b11c: 52800204    	mov	w4, #0x10               ; =16
104b3b120: 94c3b007    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b124: b40001a0    	cbz	x0, 0x104b3b158 <_Flutter_MMFoundation_BindContext+0x1016d3c>
104b3b128: f94057e8    	ldr	x8, [sp, #0xa8]
104b3b12c: f9400100    	ldr	x0, [x8]
104b3b130: f9004fff    	str	xzr, [sp, #0x98]
104b3b134: 910263e4    	add	x4, sp, #0x98
104b3b138: aa1b03e1    	mov	x1, x27
104b3b13c: f9401fe2    	ldr	x2, [sp, #0x38]
104b3b140: aa1403e3    	mov	x3, x20
104b3b144: 94c3affe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b148: f9404ffb    	ldr	x27, [sp, #0x98]
104b3b14c: aa1b03e0    	mov	x0, x27
104b3b150: 94c3affa    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3b154: 14000002    	b	0x104b3b15c <_Flutter_MMFoundation_BindContext+0x1016d40>
104b3b158: d280001b    	mov	x27, #0x0               ; =0
104b3b15c: aa1c03e0    	mov	x0, x28
104b3b160: 94c3affd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3b164: 900db1d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104b3b168: f94636c0    	ldr	x0, [x22, #0xc68]
104b3b16c: d00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3b170: f946f101    	ldr	x1, [x8, #0xde0] ; RemoveFile:
104b3b174: aa1b03e2    	mov	x2, x27
104b3b178: 94c3aff1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b17c: f94636c0    	ldr	x0, [x22, #0xc68]
104b3b180: f00d9808    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b3b184: f9409101    	ldr	x1, [x8, #0x120] ; CreateFile:
104b3b188: aa1b03e2    	mov	x2, x27
104b3b18c: 94c3afec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b190: b00dae88    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
104b3b194: f9401501    	ldr	x1, [x8, #0x28] ; writeToFile:atomically:
104b3b198: aa1503e0    	mov	x0, x21
104b3b19c: aa1b03e2    	mov	x2, x27
104b3b1a0: 52800003    	mov	w3, #0x0                ; =0
104b3b1a4: 94c3afe6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b1a8: 37000220    	tbnz	w0, #0x0, 0x104b3b1ec <_Flutter_MMFoundation_BindContext+0x1016dd0>
104b3b1ac: 900db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3b1b0: f9453500    	ldr	x0, [x8, #0xa68]
104b3b1b4: b00cd228    	adrp	x8, 0x11e580000 <dyld_stub_binder+0x11e580000>
104b3b1b8: 910fa108    	add	x8, x8, #0x3e8
104b3b1bc: a9006fe8    	stp	x8, x27, [sp]
104b3b1c0: d00b3743    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3b1c4: 9107f063    	add	x3, x3, #0x1fc
104b3b1c8: b00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3b1cc: 910cb4a5    	add	x5, x5, #0x32d
104b3b1d0: f00b6607    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b3b1d4: 9101c8e7    	add	x7, x7, #0x72
104b3b1d8: aa1903e1    	mov	x1, x25
104b3b1dc: 52800062    	mov	w2, #0x3                ; =3
104b3b1e0: 52800004    	mov	w4, #0x0                ; =0
104b3b1e4: 5281b606    	mov	w6, #0xdb0              ; =3504
104b3b1e8: 94c3afd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b1ec: aa1b03e0    	mov	x0, x27
104b3b1f0: 94c3afd9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3b1f4: 900d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3b1f8: f940291b    	ldr	x27, [x8, #0x50] ; m_dtThumbnail
104b3b1fc: aa1403e0    	mov	x0, x20
104b3b200: aa1b03e1    	mov	x1, x27
104b3b204: 94c3afce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b208: aa1d03fd    	mov	x29, x29
104b3b20c: 94c3afcf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3b210: aa0003f6    	mov	x22, x0
104b3b214: aa1803e1    	mov	x1, x24
104b3b218: 94c3afc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b21c: aa0003f7    	mov	x23, x0
104b3b220: aa1603e0    	mov	x0, x22
104b3b224: 94c3afcc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3b228: f9401ff3    	ldr	x19, [sp, #0x38]
104b3b22c: b4000df7    	cbz	x23, 0x104b3b3e8 <_Flutter_MMFoundation_BindContext+0x1016fcc>
104b3b230: f00d9868    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104b3b234: f9433501    	ldr	x1, [x8, #0x668] ; IsBrandMPVideo
104b3b238: aa1403e0    	mov	x0, x20
104b3b23c: 94c3afc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b240: 34000160    	cbz	w0, 0x104b3b26c <_Flutter_MMFoundation_BindContext+0x1016e50>
104b3b244: b00db1c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3b248: f9411d00    	ldr	x0, [x8, #0x238]
104b3b24c: d00d9a28    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
104b3b250: f9428101    	ldr	x1, [x8, #0x500] ; getPathOfVideoMsgImgThumb:
104b3b254: aa1403e2    	mov	x2, x20
104b3b258: 94c3afb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b25c: aa1d03fd    	mov	x29, x29
104b3b260: 94c3afba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3b264: aa0003f8    	mov	x24, x0
104b3b268: 14000034    	b	0x104b3b338 <_Flutter_MMFoundation_BindContext+0x1016f1c>
104b3b26c: b00db1c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3b270: f9451500    	ldr	x0, [x8, #0xa28]
104b3b274: f00dae68    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104b3b278: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
104b3b27c: 94c3afb0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b280: aa1d03fd    	mov	x29, x29
104b3b284: 94c3afb1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3b288: aa0003f6    	mov	x22, x0
104b3b28c: b00db1a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104b3b290: f9456902    	ldr	x2, [x8, #0xad0]
104b3b294: 900d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3b298: f9402d18    	ldr	x24, [x8, #0x58] ; GetPathOfAppThumb:LocalID:retStrPath:
104b3b29c: 900d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b3b2a0: f9403101    	ldr	x1, [x8, #0x60] ; getClsMethodObservers:selector:
104b3b2a4: aa1803e3    	mov	x3, x24
104b3b2a8: 94c3afa5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b2ac: aa1d03fd    	mov	x29, x29
104b3b2b0: 94c3afa6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3b2b4: aa0003fc    	mov	x28, x0
104b3b2b8: aa1603e0    	mov	x0, x22
104b3b2bc: 94c3afa6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3b2c0: 4f00e400    	movi.16b	v0, #0x0
104b3b2c4: ad0383e0    	stp	q0, q0, [sp, #0x70]
104b3b2c8: ad0283e0    	stp	q0, q0, [sp, #0x50]
104b3b2cc: b00dae28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b3b2d0: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104b3b2d4: 910143e2    	add	x2, sp, #0x50
104b3b2d8: 9103e3e3    	add	x3, sp, #0xf8
104b3b2dc: aa1c03e0    	mov	x0, x28
104b3b2e0: 52800204    	mov	w4, #0x10               ; =16
104b3b2e4: 94c3af96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b2e8: b4000220    	cbz	x0, 0x104b3b32c <_Flutter_MMFoundation_BindContext+0x1016f10>
104b3b2ec: f9402fe8    	ldr	x8, [sp, #0x58]
104b3b2f0: f9400116    	ldr	x22, [x8]
104b3b2f4: aa1403e0    	mov	x0, x20
104b3b2f8: f94017e1    	ldr	x1, [sp, #0x28]
104b3b2fc: 94c3af90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b300: aa0003e3    	mov	x3, x0
104b3b304: f90027ff    	str	xzr, [sp, #0x48]
104b3b308: 910123e4    	add	x4, sp, #0x48
104b3b30c: aa1603e0    	mov	x0, x22
104b3b310: aa1803e1    	mov	x1, x24
104b3b314: aa1303e2    	mov	x2, x19
104b3b318: 94c3af89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b31c: f94027f8    	ldr	x24, [sp, #0x48]
104b3b320: aa1803e0    	mov	x0, x24
104b3b324: 94c3af85    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3b328: 14000002    	b	0x104b3b330 <_Flutter_MMFoundation_BindContext+0x1016f14>
104b3b32c: d2800018    	mov	x24, #0x0               ; =0
104b3b330: aa1c03e0    	mov	x0, x28
104b3b334: 94c3af88    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3b338: 900db1d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104b3b33c: f94636c0    	ldr	x0, [x22, #0xc68]
104b3b340: d00d97e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3b344: f946f101    	ldr	x1, [x8, #0xde0] ; RemoveFile:
104b3b348: aa1803e2    	mov	x2, x24
104b3b34c: 94c3af7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b350: f94636c0    	ldr	x0, [x22, #0xc68]
104b3b354: f00d9808    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b3b358: f9409101    	ldr	x1, [x8, #0x120] ; CreateFile:
104b3b35c: aa1803e2    	mov	x2, x24
104b3b360: 94c3af77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b364: aa1403e0    	mov	x0, x20
104b3b368: aa1b03e1    	mov	x1, x27
104b3b36c: 94c3af74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b370: aa1d03fd    	mov	x29, x29
104b3b374: 94c3af75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3b378: aa0003f6    	mov	x22, x0
104b3b37c: b00dae88    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
104b3b380: f9401501    	ldr	x1, [x8, #0x28] ; writeToFile:atomically:
104b3b384: aa1803e2    	mov	x2, x24
104b3b388: 52800003    	mov	w3, #0x0                ; =0
104b3b38c: 94c3af6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b390: aa0003f7    	mov	x23, x0
104b3b394: aa1603e0    	mov	x0, x22
104b3b398: 94c3af6f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3b39c: 37000237    	tbnz	w23, #0x0, 0x104b3b3e0 <_Flutter_MMFoundation_BindContext+0x1016fc4>
104b3b3a0: 900db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3b3a4: f9453500    	ldr	x0, [x8, #0xa68]
104b3b3a8: b00cd228    	adrp	x8, 0x11e580000 <dyld_stub_binder+0x11e580000>
104b3b3ac: 910ea108    	add	x8, x8, #0x3a8
104b3b3b0: a90063e8    	stp	x8, x24, [sp]
104b3b3b4: d00b3743    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3b3b8: 9107f063    	add	x3, x3, #0x1fc
104b3b3bc: b00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3b3c0: 910cb4a5    	add	x5, x5, #0x32d
104b3b3c4: f00b6607    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b3b3c8: 9101c8e7    	add	x7, x7, #0x72
104b3b3cc: aa1903e1    	mov	x1, x25
104b3b3d0: 52800062    	mov	w2, #0x3                ; =3
104b3b3d4: 52800004    	mov	w4, #0x0                ; =0
104b3b3d8: 5281b826    	mov	w6, #0xdc1              ; =3521
104b3b3dc: 94c3af58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b3e0: aa1803e0    	mov	x0, x24
104b3b3e4: 94c3af5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3b3e8: d00d9888    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b3b3ec: f9448901    	ldr	x1, [x8, #0x910] ; StartUploadAppMsg:MsgWrap:Scene:
104b3b3f0: f9401be0    	ldr	x0, [sp, #0x30]
104b3b3f4: aa1303e2    	mov	x2, x19
104b3b3f8: aa1403e3    	mov	x3, x20
104b3b3fc: b94047e4    	ldr	w4, [sp, #0x44]
104b3b400: 94c3af4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3b404: aa1503e0    	mov	x0, x21
104b3b408: 94c3af53    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3b40c: aa1403e0    	mov	x0, x20
104b3b410: 94c3af51    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3b414: aa1303e0    	mov	x0, x19
104b3b418: 94c3af4f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3b41c: f85a03a8    	ldur	x8, [x29, #-0x60]
104b3b420: 900c55a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104b3b424: f9405929    	ldr	x9, [x9, #0xb0]
104b3b428: f9400129    	ldr	x9, [x9]
104b3b42c: eb08013f    	cmp	x9, x8
104b3b430: 54000121    	b.ne	0x104b3b454 <_Flutter_MMFoundation_BindContext+0x1017038>
104b3b434: 910883ff    	add	sp, sp, #0x220
104b3b438: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104b3b43c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104b3b440: a94357f6    	ldp	x22, x21, [sp, #0x30]
104b3b444: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104b3b448: a94167fa    	ldp	x26, x25, [sp, #0x10]
104b3b44c: a8c66ffc    	ldp	x28, x27, [sp], #0x60
104b3b450: d65f03c0    	ret
104b3b454: 94c3af48    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>