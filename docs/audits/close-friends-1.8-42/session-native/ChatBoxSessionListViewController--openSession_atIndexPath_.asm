
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4ba20: d10203ff    	sub	sp, sp, #0x80
100e4ba24: a9026ffc    	stp	x28, x27, [sp, #0x20]
100e4ba28: a90367fa    	stp	x26, x25, [sp, #0x30]
100e4ba2c: a9045ff8    	stp	x24, x23, [sp, #0x40]
100e4ba30: a90557f6    	stp	x22, x21, [sp, #0x50]
100e4ba34: a9064ff4    	stp	x20, x19, [sp, #0x60]
100e4ba38: a9077bfd    	stp	x29, x30, [sp, #0x70]
100e4ba3c: 9101c3fd    	add	x29, sp, #0x70
100e4ba40: aa0303f4    	mov	x20, x3
100e4ba44: aa0203f6    	mov	x22, x2
100e4ba48: aa0003f3    	mov	x19, x0
100e4ba4c: b00fef28    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100e4ba50: 52800029    	mov	w9, #0x1                ; =1
100e4ba54: 3918b909    	strb	w9, [x8, #0x62e]
100e4ba58: aa0203e0    	mov	x0, x2
100e4ba5c: 95b76db7    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e4ba60: aa1403e0    	mov	x0, x20
100e4ba64: 95b76db5    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e4ba68: 900f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4ba6c: f9454100    	ldr	x0, [x8, #0xa80]
100e4ba70: d00f95a8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
100e4ba74: f9400501    	ldr	x1, [x8, #0x8] ; dictionary
100e4ba78: 95b76db1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4ba7c: aa1d03fd    	mov	x29, x29
100e4ba80: 95b76db2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4ba84: aa0003f5    	mov	x21, x0
100e4ba88: 900f9958    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
100e4ba8c: f9458b17    	ldr	x23, [x24, #0xb10]
100e4ba90: d00f7f88    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100e4ba94: f942e501    	ldr	x1, [x8, #0x5c8] ; m_uUnReadCount
100e4ba98: f9000ff6    	str	x22, [sp, #0x18]
100e4ba9c: aa1603e0    	mov	x0, x22
100e4baa0: 95b76da7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4baa4: aa0003e2    	mov	x2, x0
100e4baa8: b00f95c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100e4baac: f947bd01    	ldr	x1, [x8, #0xf78] ; numberWithUnsignedInt:
100e4bab0: aa1703e0    	mov	x0, x23
100e4bab4: 95b76da2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bab8: aa1d03fd    	mov	x29, x29
100e4babc: 95b76da3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bac0: aa0003f7    	mov	x23, x0
100e4bac4: d00f7f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e4bac8: f942c91a    	ldr	x26, [x8, #0x590] ; safeSetObject:forKey:
100e4bacc: d00eb323    	adrp	x3, 0x11e4b1000 <dyld_stub_binder+0x11e4b1000>
100e4bad0: 912ca063    	add	x3, x3, #0xb28
100e4bad4: aa1503e0    	mov	x0, x21
100e4bad8: aa1a03e1    	mov	x1, x26
100e4badc: aa1703e2    	mov	x2, x23
100e4bae0: 95b76d97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bae4: aa1703e0    	mov	x0, x23
100e4bae8: 95b76d9b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4baec: f9458b17    	ldr	x23, [x24, #0xb10]
100e4baf0: 900f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4baf4: f9467900    	ldr	x0, [x8, #0xcf0]
100e4baf8: b00f7fa8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
100e4bafc: f942c501    	ldr	x1, [x8, #0x588] ; genCurrentTimeInMsFrom1970
100e4bb00: 95b76d8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bb04: aa0003e2    	mov	x2, x0
100e4bb08: b00f95c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100e4bb0c: f947c901    	ldr	x1, [x8, #0xf90] ; numberWithUnsignedLongLong:
100e4bb10: aa1703e0    	mov	x0, x23
100e4bb14: 95b76d8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bb18: aa1d03fd    	mov	x29, x29
100e4bb1c: 95b76d8b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bb20: aa0003f7    	mov	x23, x0
100e4bb24: d00eb383    	adrp	x3, 0x11e4bd000 <dyld_stub_binder+0x11e4bd000>
100e4bb28: 91392063    	add	x3, x3, #0xe48
100e4bb2c: aa1503e0    	mov	x0, x21
100e4bb30: aa1a03e1    	mov	x1, x26
100e4bb34: aa1703e2    	mov	x2, x23
100e4bb38: 95b76d81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bb3c: aa1703e0    	mov	x0, x23
100e4bb40: 95b76d85    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bb44: f9458b1b    	ldr	x27, [x24, #0xb10]
100e4bb48: 900f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4bb4c: f945e900    	ldr	x0, [x8, #0xbd0]
100e4bb50: b00f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4bb54: f944e917    	ldr	x23, [x8, #0x9d0] ; currentContext
100e4bb58: aa1703e1    	mov	x1, x23
100e4bb5c: 95b76d78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bb60: aa1d03fd    	mov	x29, x29
100e4bb64: 95b76d79    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bb68: aa0003fc    	mov	x28, x0
100e4bb6c: 900f9988    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100e4bb70: f9420500    	ldr	x0, [x8, #0x408]
100e4bb74: 900f95a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e4bb78: f947ad18    	ldr	x24, [x8, #0xf58] ; class
100e4bb7c: aa1803e1    	mov	x1, x24
100e4bb80: 95b76d6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bb84: aa0003e2    	mov	x2, x0
100e4bb88: d00f7f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e4bb8c: f9464119    	ldr	x25, [x8, #0xc80] ; getService:
100e4bb90: aa1c03e0    	mov	x0, x28
100e4bb94: aa1903e1    	mov	x1, x25
100e4bb98: 95b76d69    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bb9c: aa1d03fd    	mov	x29, x29
100e4bba0: 95b76d6a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bba4: aa0003f6    	mov	x22, x0
100e4bba8: b00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4bbac: f9440901    	ldr	x1, [x8, #0x810] ; indexOfChatBoxSession
100e4bbb0: 95b76d63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bbb4: aa0003e2    	mov	x2, x0
100e4bbb8: b00f95c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100e4bbbc: f947a901    	ldr	x1, [x8, #0xf50] ; numberWithInteger:
100e4bbc0: aa1b03e0    	mov	x0, x27
100e4bbc4: 95b76d5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bbc8: aa1d03fd    	mov	x29, x29
100e4bbcc: 95b76d5f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bbd0: aa0003fb    	mov	x27, x0
100e4bbd4: d00eb383    	adrp	x3, 0x11e4bd000 <dyld_stub_binder+0x11e4bd000>
100e4bbd8: 913a2063    	add	x3, x3, #0xe88
100e4bbdc: aa1503e0    	mov	x0, x21
100e4bbe0: aa1a03e1    	mov	x1, x26
100e4bbe4: aa1b03e2    	mov	x2, x27
100e4bbe8: 95b76d55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bbec: aa1b03e0    	mov	x0, x27
100e4bbf0: 95b76d59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bbf4: aa1603e0    	mov	x0, x22
100e4bbf8: 95b76d57    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bbfc: aa1c03e0    	mov	x0, x28
100e4bc00: 95b76d55    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bc04: f9000bf4    	str	x20, [sp, #0x10]
100e4bc08: b4000594    	cbz	x20, 0x100e4bcb8 <__text+0xe43cb8>
100e4bc0c: f00f95e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100e4bc10: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
100e4bc14: aa1303e0    	mov	x0, x19
100e4bc18: 95b76d49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bc1c: aa1d03fd    	mov	x29, x29
100e4bc20: 95b76d4a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bc24: aa0003f6    	mov	x22, x0
100e4bc28: b00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e4bc2c: f9416101    	ldr	x1, [x8, #0x2c0] ; cellForRowAtIndexPath:
100e4bc30: f9400be2    	ldr	x2, [sp, #0x10]
100e4bc34: 95b76d42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bc38: aa1d03fd    	mov	x29, x29
100e4bc3c: 95b76d43    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bc40: aa0003fb    	mov	x27, x0
100e4bc44: aa1603e0    	mov	x0, x22
100e4bc48: 95b76d43    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bc4c: 900f9988    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100e4bc50: f9421100    	ldr	x0, [x8, #0x420] ; PR8
100e4bc54: aa1803e1    	mov	x1, x24
100e4bc58: 95b76d39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bc5c: aa0003e2    	mov	x2, x0
100e4bc60: 900f95c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100e4bc64: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
100e4bc68: aa1b03e0    	mov	x0, x27
100e4bc6c: 95b76d34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bc70: 34000200    	cbz	w0, 0x100e4bcb0 <__text+0xe43cb0>
100e4bc74: b00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4bc78: f9440d01    	ldr	x1, [x8, #0x818] ; getGreenLabelText
100e4bc7c: aa1b03e0    	mov	x0, x27
100e4bc80: 95b76d2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bc84: aa1d03fd    	mov	x29, x29
100e4bc88: 95b76d30    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bc8c: aa0003f6    	mov	x22, x0
100e4bc90: f00eb723    	adrp	x3, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e4bc94: 912aa063    	add	x3, x3, #0xaa8
100e4bc98: aa1503e0    	mov	x0, x21
100e4bc9c: aa1a03e1    	mov	x1, x26
100e4bca0: aa1603e2    	mov	x2, x22
100e4bca4: 95b76d26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bca8: aa1603e0    	mov	x0, x22
100e4bcac: 95b76d2a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bcb0: aa1b03e0    	mov	x0, x27
100e4bcb4: 95b76d28    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bcb8: 900f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4bcbc: f9458900    	ldr	x0, [x8, #0xb10]
100e4bcc0: b00f95c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100e4bcc4: f9479501    	ldr	x1, [x8, #0xf28] ; numberWithBool:
100e4bcc8: 52800022    	mov	w2, #0x1                ; =1
100e4bccc: 95b76d1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bcd0: aa1d03fd    	mov	x29, x29
100e4bcd4: 95b76d1d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bcd8: aa0003f6    	mov	x22, x0
100e4bcdc: f00eb723    	adrp	x3, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e4bce0: 912b2063    	add	x3, x3, #0xac8
100e4bce4: aa1503e0    	mov	x0, x21
100e4bce8: aa1a03e1    	mov	x1, x26
100e4bcec: aa1603e2    	mov	x2, x22
100e4bcf0: 95b76d13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bcf4: aa1603e0    	mov	x0, x22
100e4bcf8: 95b76d17    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bcfc: 900f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4bd00: f945e900    	ldr	x0, [x8, #0xbd0]
100e4bd04: aa1703e1    	mov	x1, x23
100e4bd08: 95b76d0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bd0c: aa1d03fd    	mov	x29, x29
100e4bd10: 95b76d0e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bd14: aa0003f6    	mov	x22, x0
100e4bd18: b00f9948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e4bd1c: f941bd00    	ldr	x0, [x8, #0x378]
100e4bd20: aa1803e1    	mov	x1, x24
100e4bd24: 95b76d06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bd28: aa0003e2    	mov	x2, x0
100e4bd2c: aa1603e0    	mov	x0, x22
100e4bd30: aa1903e1    	mov	x1, x25
100e4bd34: 95b76d02    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bd38: aa1d03fd    	mov	x29, x29
100e4bd3c: 95b76d03    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bd40: aa0003fa    	mov	x26, x0
100e4bd44: b00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4bd48: f9441101    	ldr	x1, [x8, #0x820] ; commitDelayDelete
100e4bd4c: 95b76cfc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bd50: aa1a03e0    	mov	x0, x26
100e4bd54: 95b76d00    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bd58: aa1603e0    	mov	x0, x22
100e4bd5c: 95b76cfe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bd60: b00f9948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e4bd64: f9408d00    	ldr	x0, [x8, #0x118]
100e4bd68: b00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e4bd6c: f9423901    	ldr	x1, [x8, #0x470] ; getAppViewControllerManager
100e4bd70: 95b76cf3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bd74: aa1d03fd    	mov	x29, x29
100e4bd78: 95b76cf4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bd7c: aa0003fa    	mov	x26, x0
100e4bd80: b00f95c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100e4bd84: f945dd1b    	ldr	x27, [x8, #0xbb8] ; navigationController
100e4bd88: aa1303e0    	mov	x0, x19
100e4bd8c: aa1b03e1    	mov	x1, x27
100e4bd90: 95b76ceb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bd94: aa1d03fd    	mov	x29, x29
100e4bd98: 95b76cec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bd9c: aa0003fc    	mov	x28, x0
100e4bda0: d00f7f88    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100e4bda4: f9412101    	ldr	x1, [x8, #0x240] ; getNewMainFrameViewController
100e4bda8: aa1a03e0    	mov	x0, x26
100e4bdac: 95b76ce4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bdb0: aa1d03fd    	mov	x29, x29
100e4bdb4: 95b76ce5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bdb8: aa0003f6    	mov	x22, x0
100e4bdbc: aa1b03e1    	mov	x1, x27
100e4bdc0: 95b76cdf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bdc4: aa1d03fd    	mov	x29, x29
100e4bdc8: 95b76ce0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bdcc: aa0003f4    	mov	x20, x0
100e4bdd0: 95b76ce1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bdd4: aa1603e0    	mov	x0, x22
100e4bdd8: 95b76cdf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bddc: aa1c03e0    	mov	x0, x28
100e4bde0: 95b76cdd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bde4: 900f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4bde8: f945e900    	ldr	x0, [x8, #0xbd0]
100e4bdec: aa1703e1    	mov	x1, x23
100e4bdf0: 95b76cd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4bdf4: aa1d03fd    	mov	x29, x29
100e4bdf8: 95b76cd4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4bdfc: aa0003f7    	mov	x23, x0
100e4be00: b00f9948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e4be04: f940a100    	ldr	x0, [x8, #0x140]
100e4be08: aa1803e1    	mov	x1, x24
100e4be0c: 95b76ccc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4be10: aa0003e2    	mov	x2, x0
100e4be14: aa1703e0    	mov	x0, x23
100e4be18: aa1903e1    	mov	x1, x25
100e4be1c: 95b76cc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4be20: aa1d03fd    	mov	x29, x29
100e4be24: 95b76cc9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4be28: aa0003f8    	mov	x24, x0
100e4be2c: 900f7f88    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100e4be30: f947d901    	ldr	x1, [x8, #0xfb0] ; m_contact
100e4be34: f9400fe0    	ldr	x0, [sp, #0x18]
100e4be38: 95b76cc1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4be3c: aa1d03fd    	mov	x29, x29
100e4be40: 95b76cc2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4be44: aa0003f9    	mov	x25, x0
100e4be48: aa1303e0    	mov	x0, x19
100e4be4c: aa1b03e1    	mov	x1, x27
100e4be50: 95b76cbb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4be54: aa1d03fd    	mov	x29, x29
100e4be58: 95b76cbc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4be5c: aa0003f6    	mov	x22, x0
100e4be60: eb14039f    	cmp	x28, x20
100e4be64: 54000140    	b.eq	0x100e4be8c <__text+0xe43e8c>
100e4be68: d00f7fc8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
100e4be6c: f9456901    	ldr	x1, [x8, #0xad0] ; PushOtherBaseMsgControllerByContact:navigationController:animated:extraInfo:
100e4be70: aa1803e0    	mov	x0, x24
100e4be74: aa1903e2    	mov	x2, x25
100e4be78: aa1603e3    	mov	x3, x22
100e4be7c: 52800024    	mov	w4, #0x1                ; =1
100e4be80: aa1503e5    	mov	x5, x21
100e4be84: 95b76cae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4be88: 1400000c    	b	0x100e4beb8 <__text+0xe43eb8>
100e4be8c: b00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4be90: f9441501    	ldr	x1, [x8, #0x828] ; PushLogicControllerByContact:navigationController:animated:jumpToLocationNode:reuse:extraInfo:completion:
100e4be94: f90003ff    	str	xzr, [sp]
100e4be98: aa1803e0    	mov	x0, x24
100e4be9c: aa1903e2    	mov	x2, x25
100e4bea0: aa1603e3    	mov	x3, x22
100e4bea4: 52800024    	mov	w4, #0x1                ; =1
100e4bea8: d2800005    	mov	x5, #0x0                ; =0
100e4beac: 52800026    	mov	w6, #0x1                ; =1
100e4beb0: aa1503e7    	mov	x7, x21
100e4beb4: 95b76ca2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4beb8: aa1603e0    	mov	x0, x22
100e4bebc: 95b76ca6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bec0: aa1903e0    	mov	x0, x25
100e4bec4: 95b76ca4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bec8: aa1803e0    	mov	x0, x24
100e4becc: 95b76ca2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bed0: aa1703e0    	mov	x0, x23
100e4bed4: 95b76ca0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bed8: aa1a03e0    	mov	x0, x26
100e4bedc: 95b76c9e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bee0: aa1503e0    	mov	x0, x21
100e4bee4: 95b76c9c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bee8: f9400be0    	ldr	x0, [sp, #0x10]
100e4beec: 95b76c9a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4bef0: f9400fe0    	ldr	x0, [sp, #0x18]
100e4bef4: a9477bfd    	ldp	x29, x30, [sp, #0x70]
100e4bef8: a9464ff4    	ldp	x20, x19, [sp, #0x60]
100e4befc: a94557f6    	ldp	x22, x21, [sp, #0x50]
100e4bf00: a9445ff8    	ldp	x24, x23, [sp, #0x40]
100e4bf04: a94367fa    	ldp	x26, x25, [sp, #0x30]
100e4bf08: a9426ffc    	ldp	x28, x27, [sp, #0x20]
100e4bf0c: 910203ff    	add	sp, sp, #0x80
100e4bf10: 15b76c91    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
