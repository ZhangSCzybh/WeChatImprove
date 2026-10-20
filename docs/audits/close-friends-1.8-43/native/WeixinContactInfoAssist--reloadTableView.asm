
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a94cd4c: d10243ff    	sub	sp, sp, #0x90
10a94cd50: a9036ffc    	stp	x28, x27, [sp, #0x30]
10a94cd54: a90467fa    	stp	x26, x25, [sp, #0x40]
10a94cd58: a9055ff8    	stp	x24, x23, [sp, #0x50]
10a94cd5c: a90657f6    	stp	x22, x21, [sp, #0x60]
10a94cd60: a9074ff4    	stp	x20, x19, [sp, #0x70]
10a94cd64: a9087bfd    	stp	x29, x30, [sp, #0x80]
10a94cd68: 910203fd    	add	x29, sp, #0x80
10a94cd6c: aa0003f3    	mov	x19, x0
10a94cd70: f00b1828    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a94cd74: 52800029    	mov	w9, #0x1                ; =1
10a94cd78: 390bbd09    	strb	w9, [x8, #0x2ef]
10a94cd7c: f00ac488    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a94cd80: 91093108    	add	x8, x8, #0x24c
10a94cd84: b9800117    	ldrsw	x23, [x8]
10a94cd88: f8776814    	ldr	x20, [x0, x23]
10a94cd8c: 900ac148    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a94cd90: f9416d00    	ldr	x0, [x8, #0x2d8]
10a94cd94: f00abd88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a94cd98: f947ad19    	ldr	x25, [x8, #0xf58] ; class
10a94cd9c: aa1903e1    	mov	x1, x25
10a94cda0: 953c39a9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cda4: aa0003e2    	mov	x2, x0
10a94cda8: f00abda8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a94cdac: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
10a94cdb0: aa1403e0    	mov	x0, x20
10a94cdb4: 953c39a4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cdb8: 34001c80    	cbz	w0, 0x10a94d148 <_Flutter_MMFoundation_BindContext+0x6e28d2c>
10a94cdbc: f90017f7    	str	x23, [sp, #0x28]
10a94cdc0: f8776a76    	ldr	x22, [x19, x23]
10a94cdc4: aa1603e0    	mov	x0, x22
10a94cdc8: 953c399e    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a94cdcc: d00ac168    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
10a94cdd0: f942a915    	ldr	x21, [x8, #0x550]
10a94cdd4: f00ac128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a94cdd8: f945e900    	ldr	x0, [x8, #0xbd0]
10a94cddc: 900abda8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a94cde0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a94cde4: f9000fe1    	str	x1, [sp, #0x18]
10a94cde8: 953c3997    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cdec: aa1d03fd    	mov	x29, x29
10a94cdf0: 953c3998    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94cdf4: aa0003fb    	mov	x27, x0
10a94cdf8: 900ac148    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a94cdfc: f9416900    	ldr	x0, [x8, #0x2d0]
10a94ce00: aa1903e1    	mov	x1, x25
10a94ce04: 953c3990    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ce08: aa0003e2    	mov	x2, x0
10a94ce0c: b00aa768    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a94ce10: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a94ce14: f9000be1    	str	x1, [sp, #0x10]
10a94ce18: aa1b03e0    	mov	x0, x27
10a94ce1c: 953c398a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ce20: aa1d03fd    	mov	x29, x29
10a94ce24: 953c398b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94ce28: aa0003f8    	mov	x24, x0
10a94ce2c: d00aa9c8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10a94ce30: f9411501    	ldr	x1, [x8, #0x228] ; m_oMessage
10a94ce34: f90007e1    	str	x1, [sp, #0x8]
10a94ce38: aa1603e0    	mov	x0, x22
10a94ce3c: 953c3982    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ce40: aa1d03fd    	mov	x29, x29
10a94ce44: 953c3983    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94ce48: aa0003f7    	mov	x23, x0
10a94ce4c: b00aa788    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a94ce50: f9479d1c    	ldr	x28, [x8, #0xf38] ; GetChatName
10a94ce54: aa1c03e1    	mov	x1, x28
10a94ce58: 953c397b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ce5c: aa1d03fd    	mov	x29, x29
10a94ce60: 953c397c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94ce64: aa0003f4    	mov	x20, x0
10a94ce68: b00aab88    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
10a94ce6c: f9459901    	ldr	x1, [x8, #0xb30] ; getEncodeUserName
10a94ce70: f90013f6    	str	x22, [sp, #0x20]
10a94ce74: aa1603e0    	mov	x0, x22
10a94ce78: f90003e1    	str	x1, [sp]
10a94ce7c: 953c3972    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ce80: aa1d03fd    	mov	x29, x29
10a94ce84: 953c3973    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94ce88: aa0003f6    	mov	x22, x0
10a94ce8c: 900aa788    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a94ce90: f947bd01    	ldr	x1, [x8, #0xf78] ; GetLastMessage:HelloUser:OnlyTo:
10a94ce94: aa1803e0    	mov	x0, x24
10a94ce98: aa1403e2    	mov	x2, x20
10a94ce9c: aa1603e3    	mov	x3, x22
10a94cea0: 52800004    	mov	w4, #0x0                ; =0
10a94cea4: 953c3968    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cea8: aa1d03fd    	mov	x29, x29
10a94ceac: 953c3969    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94ceb0: aa0003fa    	mov	x26, x0
10a94ceb4: d00aa948    	adrp	x8, 0x11fe76000 <dyld_stub_binder+0x11fe76000>
10a94ceb8: f942ed01    	ldr	x1, [x8, #0x5d8] ; getContactFrom:
10a94cebc: aa1503e0    	mov	x0, x21
10a94cec0: aa1a03e2    	mov	x2, x26
10a94cec4: 953c3960    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cec8: aa1d03fd    	mov	x29, x29
10a94cecc: 953c3961    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94ced0: aa0003f5    	mov	x21, x0
10a94ced4: aa1a03e0    	mov	x0, x26
10a94ced8: 953c3961    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94cedc: aa1603e0    	mov	x0, x22
10a94cee0: 953c395f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94cee4: aa1403e0    	mov	x0, x20
10a94cee8: 953c395d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94ceec: aa1703e0    	mov	x0, x23
10a94cef0: 953c395b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94cef4: aa1803e0    	mov	x0, x24
10a94cef8: 953c3959    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94cefc: aa1b03e0    	mov	x0, x27
10a94cf00: 953c3957    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94cf04: f00ac128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a94cf08: f945e900    	ldr	x0, [x8, #0xbd0]
10a94cf0c: f9400fe1    	ldr	x1, [sp, #0x18]
10a94cf10: 953c394d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cf14: aa1d03fd    	mov	x29, x29
10a94cf18: 953c394e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94cf1c: aa0003fa    	mov	x26, x0
10a94cf20: 900ac148    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a94cf24: f9416900    	ldr	x0, [x8, #0x2d0]
10a94cf28: aa1903e1    	mov	x1, x25
10a94cf2c: 953c3946    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cf30: aa0003e2    	mov	x2, x0
10a94cf34: aa1a03e0    	mov	x0, x26
10a94cf38: a94087fb    	ldp	x27, x1, [sp, #0x8]
10a94cf3c: 953c3942    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cf40: aa1d03fd    	mov	x29, x29
10a94cf44: 953c3943    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94cf48: aa0003f4    	mov	x20, x0
10a94cf4c: aa1503e0    	mov	x0, x21
10a94cf50: aa1b03e1    	mov	x1, x27
10a94cf54: 953c393c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cf58: aa1d03fd    	mov	x29, x29
10a94cf5c: 953c393d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94cf60: aa0003f6    	mov	x22, x0
10a94cf64: aa1c03e1    	mov	x1, x28
10a94cf68: 953c3937    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cf6c: aa1d03fd    	mov	x29, x29
10a94cf70: 953c3938    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94cf74: aa0003f7    	mov	x23, x0
10a94cf78: aa1503e0    	mov	x0, x21
10a94cf7c: aa1b03e1    	mov	x1, x27
10a94cf80: 953c3931    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cf84: aa1d03fd    	mov	x29, x29
10a94cf88: 953c3932    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94cf8c: aa0003f8    	mov	x24, x0
10a94cf90: 900aa788    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a94cf94: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
10a94cf98: 953c392b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cf9c: aa0003e3    	mov	x3, x0
10a94cfa0: b00aab88    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
10a94cfa4: f945a101    	ldr	x1, [x8, #0xb40] ; GetSayHelloStatus:LocalID:
10a94cfa8: aa1403e0    	mov	x0, x20
10a94cfac: aa1703e2    	mov	x2, x23
10a94cfb0: 953c3925    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cfb4: aa0003e2    	mov	x2, x0
10a94cfb8: 900aa788    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a94cfbc: f9454101    	ldr	x1, [x8, #0xa80] ; setM_uiStatus:
10a94cfc0: aa1503e0    	mov	x0, x21
10a94cfc4: 953c3920    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94cfc8: aa1803e0    	mov	x0, x24
10a94cfcc: 953c3924    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94cfd0: aa1703e0    	mov	x0, x23
10a94cfd4: 953c3922    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94cfd8: aa1603e0    	mov	x0, x22
10a94cfdc: 953c3920    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94cfe0: aa1403e0    	mov	x0, x20
10a94cfe4: 953c391e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94cfe8: aa1a03e0    	mov	x0, x26
10a94cfec: 953c391c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94cff0: 900ac148    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a94cff4: f9401100    	ldr	x0, [x8, #0x20]
10a94cff8: 900aa788    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a94cffc: f947c101    	ldr	x1, [x8, #0xf80] ; getAddFriendRecordCloudSyncOpenSwitch
10a94d000: 953c3911    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d004: 34000800    	cbz	w0, 0x10a94d104 <_Flutter_MMFoundation_BindContext+0x6e28ce8>
10a94d008: f94013f9    	ldr	x25, [sp, #0x20]
10a94d00c: aa1903e0    	mov	x0, x25
10a94d010: aa1b03e1    	mov	x1, x27
10a94d014: 953c390c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d018: aa1d03fd    	mov	x29, x29
10a94d01c: 953c390d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94d020: aa0003f4    	mov	x20, x0
10a94d024: aa1c03e1    	mov	x1, x28
10a94d028: 953c3907    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d02c: aa1d03fd    	mov	x29, x29
10a94d030: 953c3908    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94d034: aa0003f6    	mov	x22, x0
10a94d038: d00abda8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a94d03c: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
10a94d040: 9009daa2    	adrp	x2, 0x11e4a1000 <dyld_stub_binder+0x11e4a1000>
10a94d044: 912da042    	add	x2, x2, #0xb68
10a94d048: 953c38ff    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d04c: aa0003f7    	mov	x23, x0
10a94d050: aa1603e0    	mov	x0, x22
10a94d054: 953c3902    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94d058: aa1403e0    	mov	x0, x20
10a94d05c: 953c3900    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94d060: 340004d7    	cbz	w23, 0x10a94d0f8 <_Flutter_MMFoundation_BindContext+0x6e28cdc>
10a94d064: 900ac1a8    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
10a94d068: f942d914    	ldr	x20, [x8, #0x5b0]
10a94d06c: aa1903e0    	mov	x0, x25
10a94d070: aa1b03e1    	mov	x1, x27
10a94d074: 953c38f4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d078: aa1d03fd    	mov	x29, x29
10a94d07c: 953c38f5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94d080: aa0003f6    	mov	x22, x0
10a94d084: aa1c03e1    	mov	x1, x28
10a94d088: 953c38ef    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d08c: aa1d03fd    	mov	x29, x29
10a94d090: 953c38f0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94d094: aa0003f7    	mov	x23, x0
10a94d098: aa1903e0    	mov	x0, x25
10a94d09c: f94003e1    	ldr	x1, [sp]
10a94d0a0: 953c38e9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d0a4: aa1d03fd    	mov	x29, x29
10a94d0a8: 953c38ea    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94d0ac: aa0003f8    	mov	x24, x0
10a94d0b0: d00ab288    	adrp	x8, 0x11ff9f000 <dyld_stub_binder+0x11ff9f000>
10a94d0b4: f9400101    	ldr	x1, [x8]
10a94d0b8: aa1403e0    	mov	x0, x20
10a94d0bc: aa1703e2    	mov	x2, x23
10a94d0c0: aa1803e3    	mov	x3, x24
10a94d0c4: 953c38e0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d0c8: aa1d03fd    	mov	x29, x29
10a94d0cc: 953c38e1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94d0d0: aa0003f4    	mov	x20, x0
10a94d0d4: aa1503e0    	mov	x0, x21
10a94d0d8: 953c38e1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94d0dc: aa1803e0    	mov	x0, x24
10a94d0e0: 953c38df    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94d0e4: aa1703e0    	mov	x0, x23
10a94d0e8: 953c38dd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94d0ec: aa1603e0    	mov	x0, x22
10a94d0f0: 953c38db    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94d0f4: aa1403f5    	mov	x21, x20
10a94d0f8: f94017f7    	ldr	x23, [sp, #0x28]
10a94d0fc: b5000095    	cbnz	x21, 0x10a94d10c <_Flutter_MMFoundation_BindContext+0x6e28cf0>
10a94d100: 1400000e    	b	0x10a94d138 <_Flutter_MMFoundation_BindContext+0x6e28d1c>
10a94d104: a9425ff9    	ldp	x25, x23, [sp, #0x20]
10a94d108: b4000195    	cbz	x21, 0x10a94d138 <_Flutter_MMFoundation_BindContext+0x6e28d1c>
10a94d10c: 8b170260    	add	x0, x19, x23
10a94d110: aa1503e1    	mov	x1, x21
10a94d114: 953c38cd    	bl	0x10f85b448 <_UR_96F1_B25D+0x3a640b8>
10a94d118: f00aa768    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a94d11c: f947e101    	ldr	x1, [x8, #0xfc0] ; isVerifyRequestFromMe
10a94d120: aa1503e0    	mov	x0, x21
10a94d124: 953c38c8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d128: 52000008    	eor	w8, w0, #0x1
10a94d12c: d00ac969    	adrp	x9, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a94d130: b986d929    	ldrsw	x9, [x9, #0x6d8]
10a94d134: b8296a68    	str	w8, [x19, x9]
10a94d138: aa1503e0    	mov	x0, x21
10a94d13c: 953c38c8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94d140: aa1903e0    	mov	x0, x25
10a94d144: 953c38c6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94d148: b00ab288    	adrp	x8, 0x11ff9e000 <dyld_stub_binder+0x11ff9e000>
10a94d14c: f946cd01    	ldr	x1, [x8, #0xd98] ; loadLocalContactData
10a94d150: aa1303e0    	mov	x0, x19
10a94d154: 953c38bc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d158: 900aa8e8    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
10a94d15c: f9402501    	ldr	x1, [x8, #0x48] ; reloadNavigationBarItem
10a94d160: aa1303e0    	mov	x0, x19
10a94d164: 953c38b8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d168: d00ac968    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a94d16c: b986f108    	ldrsw	x8, [x8, #0x6f0]
10a94d170: f8686a60    	ldr	x0, [x19, x8]
10a94d174: f00aa768    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a94d178: f940d501    	ldr	x1, [x8, #0x1a8] ; getTableView
10a94d17c: 953c38b2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d180: aa1d03fd    	mov	x29, x29
10a94d184: 953c38b3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94d188: aa0003f4    	mov	x20, x0
10a94d18c: d00ac128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a94d190: f9463100    	ldr	x0, [x8, #0xc60]
10a94d194: d00abd88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a94d198: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
10a94d19c: 953c38aa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d1a0: aa1d03fd    	mov	x29, x29
10a94d1a4: 953c38ab    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94d1a8: aa0003f5    	mov	x21, x0
10a94d1ac: d00abdc8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a94d1b0: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
10a94d1b4: aa1403e0    	mov	x0, x20
10a94d1b8: aa1503e2    	mov	x2, x21
10a94d1bc: 953c38a2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d1c0: aa1503e0    	mov	x0, x21
10a94d1c4: 953c38a6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94d1c8: b00abda8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10a94d1cc: f9468101    	ldr	x1, [x8, #0xd00] ; initData
10a94d1d0: aa1303e0    	mov	x0, x19
10a94d1d4: 953c389c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d1d8: b00abdc8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a94d1dc: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
10a94d1e0: aa1403e0    	mov	x0, x20
10a94d1e4: 953c3898    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d1e8: f00aa868    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
10a94d1ec: f946e101    	ldr	x1, [x8, #0xdc0] ; initFooterView
10a94d1f0: aa1303e0    	mov	x0, x19
10a94d1f4: 953c3894    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d1f8: d00ac488    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a94d1fc: 91096108    	add	x8, x8, #0x258
10a94d200: b9800108    	ldrsw	x8, [x8]
10a94d204: 8b080260    	add	x0, x19, x8
10a94d208: 953c38a3    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a94d20c: aa0003f5    	mov	x21, x0
10a94d210: 900aa8e8    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
10a94d214: f9402901    	ldr	x1, [x8, #0x50] ; onTableViewReload
10a94d218: 953c388b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d21c: aa1503e0    	mov	x0, x21
10a94d220: 953c388f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94d224: d00ac968    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a94d228: b986f916    	ldrsw	x22, [x8, #0x6f8]
10a94d22c: f8766a60    	ldr	x0, [x19, x22]
10a94d230: b4000220    	cbz	x0, 0x10a94d274 <_Flutter_MMFoundation_BindContext+0x6e28e58>
10a94d234: d00aa768    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a94d238: f947d901    	ldr	x1, [x8, #0xfb0] ; m_contact
10a94d23c: 953c3882    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d240: aa1d03fd    	mov	x29, x29
10a94d244: 953c3883    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94d248: aa0003f5    	mov	x21, x0
10a94d24c: f8776a62    	ldr	x2, [x19, x23]
10a94d250: 900aa868    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
10a94d254: f9455901    	ldr	x1, [x8, #0xab0] ; copyPatialFieldFromContact:
10a94d258: 953c387b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d25c: aa1503e0    	mov	x0, x21
10a94d260: 953c387f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94d264: f8766a60    	ldr	x0, [x19, x22]
10a94d268: d00aa768    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a94d26c: f9458901    	ldr	x1, [x8, #0xb10] ; reloadTableView
10a94d270: 953c3875    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d274: d00ac968    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a94d278: b986f508    	ldrsw	x8, [x8, #0x6f4]
10a94d27c: f8686a60    	ldr	x0, [x19, x8]
10a94d280: b4000080    	cbz	x0, 0x10a94d290 <_Flutter_MMFoundation_BindContext+0x6e28e74>
10a94d284: d00ab288    	adrp	x8, 0x11ff9f000 <dyld_stub_binder+0x11ff9f000>
10a94d288: f9400901    	ldr	x1, [x8, #0x10] ; reloadSocialInfoController
10a94d28c: 953c386e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94d290: aa1403e0    	mov	x0, x20
10a94d294: a9487bfd    	ldp	x29, x30, [sp, #0x80]
10a94d298: a9474ff4    	ldp	x20, x19, [sp, #0x70]
10a94d29c: a94657f6    	ldp	x22, x21, [sp, #0x60]
10a94d2a0: a9455ff8    	ldp	x24, x23, [sp, #0x50]
10a94d2a4: a94467fa    	ldp	x26, x25, [sp, #0x40]
10a94d2a8: a9436ffc    	ldp	x28, x27, [sp, #0x30]
10a94d2ac: 910243ff    	add	sp, sp, #0x90
10a94d2b0: 153c386b    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
