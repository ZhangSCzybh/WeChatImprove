
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10511eafc: d10603ff    	sub	sp, sp, #0x180
10511eb00: 6d1123e9    	stp	d9, d8, [sp, #0x110]
10511eb04: a9126ffc    	stp	x28, x27, [sp, #0x120]
10511eb08: a91367fa    	stp	x26, x25, [sp, #0x130]
10511eb0c: a9145ff8    	stp	x24, x23, [sp, #0x140]
10511eb10: a91557f6    	stp	x22, x21, [sp, #0x150]
10511eb14: a9164ff4    	stp	x20, x19, [sp, #0x160]
10511eb18: a9177bfd    	stp	x29, x30, [sp, #0x170]
10511eb1c: 9105c3fd    	add	x29, sp, #0x170
10511eb20: aa0303f6    	mov	x22, x3
10511eb24: aa0203f4    	mov	x20, x2
10511eb28: aa0003fa    	mov	x26, x0
10511eb2c: b00c2688    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10511eb30: f9405908    	ldr	x8, [x8, #0xb0]
10511eb34: f9400108    	ldr	x8, [x8]
10511eb38: f81903a8    	stur	x8, [x29, #-0x70]
10511eb3c: b00dd908    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
10511eb40: 52800029    	mov	w9, #0x1                ; =1
10511eb44: 392e0509    	strb	w9, [x8, #0xb81]
10511eb48: aa0203e0    	mov	x0, x2
10511eb4c: 94ac217b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511eb50: aa1603e0    	mov	x0, x22
10511eb54: 94ac2179    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511eb58: d00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511eb5c: b9831517    	ldrsw	x23, [x8, #0x314]
10511eb60: f8776b40    	ldr	x0, [x26, x23]
10511eb64: 900d73e8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10511eb68: f9437501    	ldr	x1, [x8, #0x6e8] ; m_bReadyToLoadData
10511eb6c: 94ac2174    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511eb70: 360011e0    	tbz	w0, #0x0, 0x10511edac <_Flutter_MMFoundation_BindContext+0x15fa990>
10511eb74: d00d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511eb78: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
10511eb7c: aa1603e0    	mov	x0, x22
10511eb80: 94ac216f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511eb84: a902ebf6    	stp	x22, x26, [sp, #0x28]
10511eb88: b50000c0    	cbnz	x0, 0x10511eba0 <_Flutter_MMFoundation_BindContext+0x15fa784>
10511eb8c: d00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511eb90: b9831908    	ldrsw	x8, [x8, #0x318]
10511eb94: f8686b48    	ldr	x8, [x26, x8]
10511eb98: eb14011f    	cmp	x8, x20
10511eb9c: 54003ce0    	b.eq	0x10511f338 <_Flutter_MMFoundation_BindContext+0x15faf1c>
10511eba0: 900d7f48    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10511eba4: f9440901    	ldr	x1, [x8, #0x810] ; row
10511eba8: aa1603e0    	mov	x0, x22
10511ebac: 94ac2164    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ebb0: aa0003f8    	mov	x24, x0
10511ebb4: f8776b40    	ldr	x0, [x26, x23]
10511ebb8: d00d7328    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
10511ebbc: f945e101    	ldr	x1, [x8, #0xbc0] ; getCellDataAtIndexPath:
10511ebc0: aa1603e2    	mov	x2, x22
10511ebc4: 94ac215e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ebc8: aa1d03fd    	mov	x29, x29
10511ebcc: 94ac215f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511ebd0: aa0003fc    	mov	x28, x0
10511ebd4: b00d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511ebd8: f9403901    	ldr	x1, [x8, #0x70] ; setCurrIndexPath:
10511ebdc: aa1603e2    	mov	x2, x22
10511ebe0: 94ac2157    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ebe4: b00d6b28    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
10511ebe8: f9404101    	ldr	x1, [x8, #0x80] ; m_textForNameLabel
10511ebec: aa1c03e0    	mov	x0, x28
10511ebf0: 94ac2153    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ebf4: aa1d03fd    	mov	x29, x29
10511ebf8: 94ac2154    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511ebfc: aa0003f3    	mov	x19, x0
10511ec00: b00d7f28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10511ec04: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10511ec08: 94ac214d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ec0c: aa0003f5    	mov	x21, x0
10511ec10: aa1303e0    	mov	x0, x19
10511ec14: 94ac2150    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511ec18: b50000f5    	cbnz	x21, 0x10511ec34 <_Flutter_MMFoundation_BindContext+0x15fa818>
10511ec1c: 52800720    	mov	w0, #0x39               ; =57
10511ec20: 52800001    	mov	w1, #0x0                ; =0
10511ec24: 52800022    	mov	w2, #0x1                ; =1
10511ec28: 52800003    	mov	w3, #0x0                ; =0
10511ec2c: 52800004    	mov	w4, #0x0                ; =0
10511ec30: 9738c553    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10511ec34: d00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511ec38: f9477501    	ldr	x1, [x8, #0xee8] ; dequeueReusableCellWithIdentifier:
10511ec3c: d00cb5a2    	adrp	x2, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
10511ec40: 9126a042    	add	x2, x2, #0x9a8 ; CFString 'kMainFrameCellIdentifier'
10511ec44: aa1403e0    	mov	x0, x20
10511ec48: 94ac213d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ec4c: aa1d03fd    	mov	x29, x29
10511ec50: 94ac213e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511ec54: d00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511ec58: f9001ffc    	str	x28, [sp, #0x38]
10511ec5c: f90013f4    	str	x20, [sp, #0x20]
10511ec60: b4001060    	cbz	x0, 0x10511ee6c <_Flutter_MMFoundation_BindContext+0x15faa50>
10511ec64: a900dff8    	stp	x24, x23, [sp, #0x8]
10511ec68: 4f00e400    	movi.16b	v0, #0x0
10511ec6c: ad0303e0    	stp	q0, q0, [sp, #0x60]
10511ec70: ad0203e0    	stp	q0, q0, [sp, #0x40]
10511ec74: f9427501    	ldr	x1, [x8, #0x4e8] ; contentView
10511ec78: f9000fe0    	str	x0, [sp, #0x18]
10511ec7c: 94ac2130    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ec80: aa1d03fd    	mov	x29, x29
10511ec84: 94ac2131    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511ec88: aa0003f3    	mov	x19, x0
10511ec8c: 900d7f68    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10511ec90: f9474901    	ldr	x1, [x8, #0xe90] ; subviews
10511ec94: 94ac212a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ec98: aa1d03fd    	mov	x29, x29
10511ec9c: 94ac212b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511eca0: aa0003f9    	mov	x25, x0
10511eca4: aa1303e0    	mov	x0, x19
10511eca8: 94ac212b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511ecac: d00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511ecb0: f943551a    	ldr	x26, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
10511ecb4: 910103e2    	add	x2, sp, #0x40
10511ecb8: 910203e3    	add	x3, sp, #0x80
10511ecbc: aa1903e0    	mov	x0, x25
10511ecc0: aa1a03e1    	mov	x1, x26
10511ecc4: 52800204    	mov	w4, #0x10               ; =16
10511ecc8: 94ac211d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511eccc: b4000480    	cbz	x0, 0x10511ed5c <_Flutter_MMFoundation_BindContext+0x15fa940>
10511ecd0: aa0003fb    	mov	x27, x0
10511ecd4: f9402be8    	ldr	x8, [sp, #0x50]
10511ecd8: f9400114    	ldr	x20, [x8]
10511ecdc: 900d7f76    	adrp	x22, 0x12010a000 <dyld_stub_binder+0x12010a000>
10511ece0: 900d7f55    	adrp	x21, 0x120106000 <dyld_stub_binder+0x120106000>
10511ece4: d2800017    	mov	x23, #0x0               ; =0
10511ece8: f947c2dc    	ldr	x28, [x22, #0xf80] ; tag
10511ecec: f940fab8    	ldr	x24, [x21, #0x1f0] ; removeFromSuperview
10511ecf0: f9402be8    	ldr	x8, [sp, #0x50]
10511ecf4: f9400108    	ldr	x8, [x8]
10511ecf8: eb14011f    	cmp	x8, x20
10511ecfc: 54000060    	b.eq	0x10511ed08 <_Flutter_MMFoundation_BindContext+0x15fa8ec>
10511ed00: aa1903e0    	mov	x0, x25
10511ed04: 94ac2113    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
10511ed08: f94027e8    	ldr	x8, [sp, #0x48]
10511ed0c: f8777913    	ldr	x19, [x8, x23, lsl #3]
10511ed10: aa1303e0    	mov	x0, x19
10511ed14: aa1c03e1    	mov	x1, x28
10511ed18: 94ac2109    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ed1c: f10fa41f    	cmp	x0, #0x3e9
10511ed20: 54000080    	b.eq	0x10511ed30 <_Flutter_MMFoundation_BindContext+0x15fa914>
10511ed24: aa1303e0    	mov	x0, x19
10511ed28: aa1803e1    	mov	x1, x24
10511ed2c: 94ac2104    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ed30: 910006f7    	add	x23, x23, #0x1
10511ed34: eb17037f    	cmp	x27, x23
10511ed38: 54fffdc1    	b.ne	0x10511ecf0 <_Flutter_MMFoundation_BindContext+0x15fa8d4>
10511ed3c: 910103e2    	add	x2, sp, #0x40
10511ed40: 910203e3    	add	x3, sp, #0x80
10511ed44: aa1903e0    	mov	x0, x25
10511ed48: aa1a03e1    	mov	x1, x26
10511ed4c: 52800204    	mov	w4, #0x10               ; =16
10511ed50: 94ac20fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ed54: aa0003fb    	mov	x27, x0
10511ed58: b5fffc60    	cbnz	x0, 0x10511ece4 <_Flutter_MMFoundation_BindContext+0x15fa8c8>
10511ed5c: aa1903e0    	mov	x0, x25
10511ed60: 94ac20fd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511ed64: f00d68e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10511ed68: f9400d01    	ldr	x1, [x8, #0x18] ; textLabel
10511ed6c: f9400ff9    	ldr	x25, [sp, #0x18]
10511ed70: aa1903e0    	mov	x0, x25
10511ed74: 94ac20f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ed78: aa1d03fd    	mov	x29, x29
10511ed7c: 94ac20f3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511ed80: aa0003f3    	mov	x19, x0
10511ed84: f00d7f48    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10511ed88: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
10511ed8c: d2800002    	mov	x2, #0x0                ; =0
10511ed90: 94ac20eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ed94: aa1303e0    	mov	x0, x19
10511ed98: 94ac20ef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511ed9c: a9425bf4    	ldp	x20, x22, [sp, #0x20]
10511eda0: a94373fa    	ldp	x26, x28, [sp, #0x30]
10511eda4: a940dff8    	ldp	x24, x23, [sp, #0x8]
10511eda8: 1400003b    	b	0x10511ee94 <_Flutter_MMFoundation_BindContext+0x15faa78>
10511edac: 900d7f48    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10511edb0: f9440901    	ldr	x1, [x8, #0x810] ; row
10511edb4: aa1603e0    	mov	x0, x22
10511edb8: 94ac20e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511edbc: aa0003e2    	mov	x2, x0
10511edc0: f8776b40    	ldr	x0, [x26, x23]
10511edc4: b00d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511edc8: f9403101    	ldr	x1, [x8, #0x60] ; getFakeCellData:
10511edcc: 94ac20dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511edd0: aa1d03fd    	mov	x29, x29
10511edd4: 94ac20dd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511edd8: aa0003f7    	mov	x23, x0
10511eddc: d00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511ede0: f9477501    	ldr	x1, [x8, #0xee8] ; dequeueReusableCellWithIdentifier:
10511ede4: d00cb5a2    	adrp	x2, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
10511ede8: 91272042    	add	x2, x2, #0x9c8 ; CFString 'kFakeMainFrameCellIdentifier'
10511edec: aa1403e0    	mov	x0, x20
10511edf0: 94ac20d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511edf4: aa1d03fd    	mov	x29, x29
10511edf8: 94ac20d4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511edfc: aa0003f9    	mov	x25, x0
10511ee00: b5000160    	cbnz	x0, 0x10511ee2c <_Flutter_MMFoundation_BindContext+0x15faa10>
10511ee04: d00d83a8    	adrp	x8, 0x120194000 <dyld_stub_binder+0x120194000>
10511ee08: f9434900    	ldr	x0, [x8, #0x690] ; FakeMainFrameCell
10511ee0c: 94ac20d5    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10511ee10: f00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511ee14: f9463501    	ldr	x1, [x8, #0xc68] ; initWithStyle:reuseIdentifier:
10511ee18: d00cb5a3    	adrp	x3, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
10511ee1c: 91272063    	add	x3, x3, #0x9c8 ; CFString 'kFakeMainFrameCellIdentifier'
10511ee20: d2800002    	mov	x2, #0x0                ; =0
10511ee24: 94ac20c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ee28: aa0003f9    	mov	x25, x0
10511ee2c: aa1903e0    	mov	x0, x25
10511ee30: 94ac20c2    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511ee34: d00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511ee38: b9831908    	ldrsw	x8, [x8, #0x318]
10511ee3c: f8686b40    	ldr	x0, [x26, x8]
10511ee40: f00d7f08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10511ee44: f945a101    	ldr	x1, [x8, #0xb40] ; frame
10511ee48: 94ac20bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ee4c: d00d6b08    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
10511ee50: f943f101    	ldr	x1, [x8, #0x7e0] ; updateContentView:tableViewFrame:
10511ee54: aa1903e0    	mov	x0, x25
10511ee58: aa1703e2    	mov	x2, x23
10511ee5c: 94ac20b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ee60: aa1703e0    	mov	x0, x23
10511ee64: 94ac20bc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511ee68: 1400011e    	b	0x10511f2e0 <_Flutter_MMFoundation_BindContext+0x15faec4>
10511ee6c: b00d82e8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
10511ee70: f9421100    	ldr	x0, [x8, #0x420] ; NewMainFrameCell
10511ee74: 94ac20bb    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10511ee78: f00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511ee7c: f9463501    	ldr	x1, [x8, #0xc68] ; initWithStyle:reuseIdentifier:
10511ee80: d00cb5a3    	adrp	x3, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
10511ee84: 9126a063    	add	x3, x3, #0x9a8 ; CFString 'kMainFrameCellIdentifier'
10511ee88: d2800002    	mov	x2, #0x0                ; =0
10511ee8c: 94ac20ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ee90: aa0003f9    	mov	x25, x0
10511ee94: aa1903e0    	mov	x0, x25
10511ee98: 94ac20a8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511ee9c: b00d6c88    	adrp	x8, 0x11feaf000 <dyld_stub_binder+0x11feaf000>
10511eea0: f944ed01    	ldr	x1, [x8, #0x9d8] ; setIndexPath:
10511eea4: aa1603e2    	mov	x2, x22
10511eea8: 94ac20a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511eeac: d00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511eeb0: b983191b    	ldrsw	x27, [x8, #0x318]
10511eeb4: f87b6b40    	ldr	x0, [x26, x27]
10511eeb8: f00d7f08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10511eebc: f945a101    	ldr	x1, [x8, #0xb40] ; frame
10511eec0: 94ac209f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511eec4: d00d6b08    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
10511eec8: f943f101    	ldr	x1, [x8, #0x7e0] ; updateContentView:tableViewFrame:
10511eecc: aa1903e0    	mov	x0, x25
10511eed0: aa1c03e2    	mov	x2, x28
10511eed4: 94ac209a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511eed8: f8776b40    	ldr	x0, [x26, x23]
10511eedc: b00d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511eee0: f9403d01    	ldr	x1, [x8, #0x78] ; cleanupPreLoadCacheIfNeed:
10511eee4: aa1803e2    	mov	x2, x24
10511eee8: 94ac2095    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511eeec: f87b6b48    	ldr	x8, [x26, x27]
10511eef0: eb14011f    	cmp	x8, x20
10511eef4: 1a9f17e2    	cset	w2, eq
10511eef8: f00d69c8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
10511eefc: f9428901    	ldr	x1, [x8, #0x510] ; setContextMenuEnabled:
10511ef00: aa1903e0    	mov	x0, x25
10511ef04: 94ac208e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ef08: d00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511ef0c: b9838114    	ldrsw	x20, [x8, #0x380]
10511ef10: f8746b48    	ldr	x8, [x26, x20]
10511ef14: b00d7f37    	adrp	x23, 0x120103000 <dyld_stub_binder+0x120103000>
10511ef18: aa1903f5    	mov	x21, x25
10511ef1c: b4000708    	cbz	x8, 0x10511effc <_Flutter_MMFoundation_BindContext+0x15fabe0>
10511ef20: 900d6948    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
10511ef24: f9438d01    	ldr	x1, [x8, #0x718] ; m_sessionInfo
10511ef28: aa1c03e0    	mov	x0, x28
10511ef2c: 94ac2084    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ef30: aa1d03fd    	mov	x29, x29
10511ef34: 94ac2085    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511ef38: aa0003f8    	mov	x24, x0
10511ef3c: d00d6928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10511ef40: f947d913    	ldr	x19, [x8, #0xfb0] ; m_nsUserName
10511ef44: aa1303e1    	mov	x1, x19
10511ef48: 94ac207d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ef4c: aa1d03fd    	mov	x29, x29
10511ef50: 94ac207e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511ef54: aa0003f9    	mov	x25, x0
10511ef58: f8746b40    	ldr	x0, [x26, x20]
10511ef5c: aa1303e1    	mov	x1, x19
10511ef60: 94ac2077    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ef64: aa1d03fd    	mov	x29, x29
10511ef68: 94ac2078    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511ef6c: aa0003fa    	mov	x26, x0
10511ef70: f943cae1    	ldr	x1, [x23, #0x790] ; isEqualToString:
10511ef74: aa1903e0    	mov	x0, x25
10511ef78: aa1a03e2    	mov	x2, x26
10511ef7c: 94ac2070    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ef80: 360002e0    	tbz	w0, #0x0, 0x10511efdc <_Flutter_MMFoundation_BindContext+0x15fabc0>
10511ef84: b00d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511ef88: f9404101    	ldr	x1, [x8, #0x80] ; isPositionChanged
10511ef8c: aa1c03e0    	mov	x0, x28
10511ef90: 94ac206b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ef94: aa0003f3    	mov	x19, x0
10511ef98: aa1a03e0    	mov	x0, x26
10511ef9c: 94ac206e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511efa0: aa1903e0    	mov	x0, x25
10511efa4: 94ac206c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511efa8: aa1803e0    	mov	x0, x24
10511efac: 94ac206a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511efb0: aa1503f9    	mov	x25, x21
10511efb4: f9401bfa    	ldr	x26, [sp, #0x30]
10511efb8: 37000233    	tbnz	w19, #0x0, 0x10511effc <_Flutter_MMFoundation_BindContext+0x15fabe0>
10511efbc: f00d69c8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
10511efc0: f942c101    	ldr	x1, [x8, #0x580] ; setMenuOptionsViewHidden:animated:completionHandler:
10511efc4: aa1903e0    	mov	x0, x25
10511efc8: 52800002    	mov	w2, #0x0                ; =0
10511efcc: 52800003    	mov	w3, #0x0                ; =0
10511efd0: d2800004    	mov	x4, #0x0                ; =0
10511efd4: 94ac205a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511efd8: 1400000e    	b	0x10511f010 <_Flutter_MMFoundation_BindContext+0x15fabf4>
10511efdc: aa1a03e0    	mov	x0, x26
10511efe0: 94ac205d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511efe4: aa1903e0    	mov	x0, x25
10511efe8: 94ac205b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511efec: aa1803e0    	mov	x0, x24
10511eff0: 94ac2059    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511eff4: aa1503f9    	mov	x25, x21
10511eff8: f9401bfa    	ldr	x26, [sp, #0x30]
10511effc: d00d7328    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
10511f000: f947d101    	ldr	x1, [x8, #0xfa0] ; forceHideMenuOptionsAnimated:
10511f004: aa1903e0    	mov	x0, x25
10511f008: 52800002    	mov	w2, #0x0                ; =0
10511f00c: 94ac204c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f010: b00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511f014: b9836914    	ldrsw	x20, [x8, #0x368]
10511f018: f8746b48    	ldr	x8, [x26, x20]
10511f01c: b4000568    	cbz	x8, 0x10511f0c8 <_Flutter_MMFoundation_BindContext+0x15facac>
10511f020: aa1a03fc    	mov	x28, x26
10511f024: f00d6928    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
10511f028: f9438d01    	ldr	x1, [x8, #0x718] ; m_sessionInfo
10511f02c: f9401fe0    	ldr	x0, [sp, #0x38]
10511f030: 94ac2043    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f034: aa1d03fd    	mov	x29, x29
10511f038: 94ac2044    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f03c: aa0003f3    	mov	x19, x0
10511f040: b00d6928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10511f044: f947d918    	ldr	x24, [x8, #0xfb0] ; m_nsUserName
10511f048: aa1803e1    	mov	x1, x24
10511f04c: 94ac203c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f050: aa1d03fd    	mov	x29, x29
10511f054: 94ac203d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f058: aa0003f9    	mov	x25, x0
10511f05c: f8746b40    	ldr	x0, [x26, x20]
10511f060: aa1803e1    	mov	x1, x24
10511f064: 94ac2036    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f068: aa1d03fd    	mov	x29, x29
10511f06c: 94ac2037    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f070: aa0003f8    	mov	x24, x0
10511f074: f943cae1    	ldr	x1, [x23, #0x790] ; isEqualToString:
10511f078: aa1903e0    	mov	x0, x25
10511f07c: aa1803e2    	mov	x2, x24
10511f080: 94ac202f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f084: aa0003fa    	mov	x26, x0
10511f088: aa1803e0    	mov	x0, x24
10511f08c: 94ac2032    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f090: aa1903e0    	mov	x0, x25
10511f094: aa1503f9    	mov	x25, x21
10511f098: 94ac202f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f09c: aa1303e0    	mov	x0, x19
10511f0a0: 94ac202d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f0a4: 3400013a    	cbz	w26, 0x10511f0c8 <_Flutter_MMFoundation_BindContext+0x15facac>
10511f0a8: f87b6b80    	ldr	x0, [x28, x27]
10511f0ac: b00d7328    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
10511f0b0: f946e901    	ldr	x1, [x8, #0xdd0] ; selectRowAtIndexPath:cell:animated:scrollPosition:
10511f0b4: aa1603e2    	mov	x2, x22
10511f0b8: aa1903e3    	mov	x3, x25
10511f0bc: 52800004    	mov	w4, #0x0                ; =0
10511f0c0: d2800005    	mov	x5, #0x0                ; =0
10511f0c4: 94ac201e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f0c8: b00d82a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10511f0cc: f9408d00    	ldr	x0, [x8, #0x118] ; CAppViewControllerManager
10511f0d0: b00d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511f0d4: f9423901    	ldr	x1, [x8, #0x470] ; getAppViewControllerManager
10511f0d8: 94ac2019    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f0dc: aa1d03fd    	mov	x29, x29
10511f0e0: 94ac201a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f0e4: aa0003f3    	mov	x19, x0
10511f0e8: f00d6908    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
10511f0ec: f941bd01    	ldr	x1, [x8, #0x378] ; isUsingSplitView
10511f0f0: 94ac2013    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f0f4: aa0003f8    	mov	x24, x0
10511f0f8: aa1303e0    	mov	x0, x19
10511f0fc: 94ac2016    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f100: f9401ff7    	ldr	x23, [sp, #0x38]
10511f104: 34000338    	cbz	w24, 0x10511f168 <_Flutter_MMFoundation_BindContext+0x15fad4c>
10511f108: f00d6928    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
10511f10c: f9438d01    	ldr	x1, [x8, #0x718] ; m_sessionInfo
10511f110: aa1703e0    	mov	x0, x23
10511f114: 94ac200a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f118: aa1d03fd    	mov	x29, x29
10511f11c: 94ac200b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f120: aa0003f3    	mov	x19, x0
10511f124: b00d6928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10511f128: f947d901    	ldr	x1, [x8, #0xfb0] ; m_nsUserName
10511f12c: 94ac2004    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f130: aa1d03fd    	mov	x29, x29
10511f134: 94ac2005    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f138: aa0003f8    	mov	x24, x0
10511f13c: f00d73c8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10511f140: f947e101    	ldr	x1, [x8, #0xfc0] ; updateSelectCellByUsername:indexPath:cell:
10511f144: f9401be0    	ldr	x0, [sp, #0x30]
10511f148: aa1803e2    	mov	x2, x24
10511f14c: aa1603e3    	mov	x3, x22
10511f150: aa1903e4    	mov	x4, x25
10511f154: 94ac1ffa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f158: aa1803e0    	mov	x0, x24
10511f15c: 94ac1ffe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f160: aa1303e0    	mov	x0, x19
10511f164: 94ac1ffc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f168: b00d82a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10511f16c: f9410500    	ldr	x0, [x8, #0x208] ; WCDBManager
10511f170: b00d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511f174: f9448d01    	ldr	x1, [x8, #0x918] ; shared
10511f178: 94ac1ff1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f17c: aa1d03fd    	mov	x29, x29
10511f180: 94ac1ff2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f184: aa0003f3    	mov	x19, x0
10511f188: b00d69e8    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
10511f18c: f9463d01    	ldr	x1, [x8, #0xc78] ; showWhereDatabase
10511f190: 94ac1feb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f194: aa0003f6    	mov	x22, x0
10511f198: aa1303e0    	mov	x0, x19
10511f19c: 94ac1fee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f1a0: f94013f4    	ldr	x20, [sp, #0x20]
10511f1a4: 34000996    	cbz	w22, 0x10511f2d4 <_Flutter_MMFoundation_BindContext+0x15faeb8>
10511f1a8: 900d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511f1ac: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
10511f1b0: b00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511f1b4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10511f1b8: 94ac1fe1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f1bc: aa1d03fd    	mov	x29, x29
10511f1c0: 94ac1fe2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f1c4: aa0003f6    	mov	x22, x0
10511f1c8: b00d82a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10511f1cc: f9403100    	ldr	x0, [x8, #0x60] ; CMessageMgr
10511f1d0: 900d7f08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10511f1d4: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10511f1d8: 94ac1fd9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f1dc: aa0003e2    	mov	x2, x0
10511f1e0: d00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511f1e4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10511f1e8: aa1603e0    	mov	x0, x22
10511f1ec: 94ac1fd4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f1f0: aa1d03fd    	mov	x29, x29
10511f1f4: 94ac1fd5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f1f8: aa0003f8    	mov	x24, x0
10511f1fc: f00d6928    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
10511f200: f9438d01    	ldr	x1, [x8, #0x718] ; m_sessionInfo
10511f204: aa1703e0    	mov	x0, x23
10511f208: 94ac1fcd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f20c: aa1d03fd    	mov	x29, x29
10511f210: 94ac1fce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f214: aa0003f3    	mov	x19, x0
10511f218: 900d68e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10511f21c: f947d901    	ldr	x1, [x8, #0xfb0] ; m_contact
10511f220: 94ac1fc7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f224: aa1d03fd    	mov	x29, x29
10511f228: 94ac1fc8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f22c: aa0003f9    	mov	x25, x0
10511f230: 900d68e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10511f234: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
10511f238: 94ac1fc1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f23c: aa1d03fd    	mov	x29, x29
10511f240: 94ac1fc2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f244: aa0003fa    	mov	x26, x0
10511f248: b00d69e8    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
10511f24c: f9464101    	ldr	x1, [x8, #0xc80] ; getMarkColorForTableLocation:
10511f250: aa1803e0    	mov	x0, x24
10511f254: aa1a03e2    	mov	x2, x26
10511f258: 94ac1fb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f25c: aa1d03fd    	mov	x29, x29
10511f260: 94ac1fba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f264: aa0003fb    	mov	x27, x0
10511f268: b00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511f26c: f9427501    	ldr	x1, [x8, #0x4e8] ; contentView
10511f270: aa1503e0    	mov	x0, x21
10511f274: 94ac1fb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f278: aa1d03fd    	mov	x29, x29
10511f27c: 94ac1fb3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f280: aa0003fc    	mov	x28, x0
10511f284: 900d7f48    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10511f288: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
10511f28c: aa1b03e2    	mov	x2, x27
10511f290: 94ac1fab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f294: aa1c03e0    	mov	x0, x28
10511f298: f9401ff7    	ldr	x23, [sp, #0x38]
10511f29c: 94ac1fae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f2a0: aa1b03e0    	mov	x0, x27
10511f2a4: 94ac1fac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f2a8: aa1a03e0    	mov	x0, x26
10511f2ac: 94ac1faa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f2b0: aa1903e0    	mov	x0, x25
10511f2b4: aa1503f9    	mov	x25, x21
10511f2b8: 94ac1fa7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f2bc: aa1303e0    	mov	x0, x19
10511f2c0: 94ac1fa5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f2c4: aa1803e0    	mov	x0, x24
10511f2c8: 94ac1fa3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f2cc: aa1603e0    	mov	x0, x22
10511f2d0: 94ac1fa1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f2d4: aa1703e0    	mov	x0, x23
10511f2d8: 94ac1f9f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f2dc: f94017f6    	ldr	x22, [sp, #0x28]
10511f2e0: aa1903e0    	mov	x0, x25
10511f2e4: 94ac1f9c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f2e8: aa1603e0    	mov	x0, x22
10511f2ec: 94ac1f9a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f2f0: aa1403e0    	mov	x0, x20
10511f2f4: 94ac1f98    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f2f8: f85903a8    	ldur	x8, [x29, #-0x70]
10511f2fc: 900c2689    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10511f300: f9405929    	ldr	x9, [x9, #0xb0]
10511f304: f9400129    	ldr	x9, [x9]
10511f308: eb08013f    	cmp	x9, x8
10511f30c: 540019e1    	b.ne	0x10511f648 <_Flutter_MMFoundation_BindContext+0x15fb22c>
10511f310: aa1903e0    	mov	x0, x25
10511f314: a9577bfd    	ldp	x29, x30, [sp, #0x170]
10511f318: a9564ff4    	ldp	x20, x19, [sp, #0x160]
10511f31c: a95557f6    	ldp	x22, x21, [sp, #0x150]
10511f320: a9545ff8    	ldp	x24, x23, [sp, #0x140]
10511f324: a95367fa    	ldp	x26, x25, [sp, #0x130]
10511f328: a9526ffc    	ldp	x28, x27, [sp, #0x120]
10511f32c: 6d5123e9    	ldp	d9, d8, [sp, #0x110]
10511f330: 910603ff    	add	sp, sp, #0x180
10511f334: 14ac1f8f    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
10511f338: b00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511f33c: f9477501    	ldr	x1, [x8, #0xee8] ; dequeueReusableCellWithIdentifier:
10511f340: b00cb5a2    	adrp	x2, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
10511f344: 9127a042    	add	x2, x2, #0x9e8 ; CFString 'Header'
10511f348: aa1403e0    	mov	x0, x20
10511f34c: 94ac1f7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f350: aa1d03fd    	mov	x29, x29
10511f354: 94ac1f7d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f358: b40001c0    	cbz	x0, 0x10511f390 <_Flutter_MMFoundation_BindContext+0x15faf74>
10511f35c: aa0003f5    	mov	x21, x0
10511f360: b00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511f364: f9427501    	ldr	x1, [x8, #0x4e8] ; contentView
10511f368: 94ac1f75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f36c: aa1d03fd    	mov	x29, x29
10511f370: 94ac1f76    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f374: aa0003f3    	mov	x19, x0
10511f378: 900d68e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10511f37c: f947f901    	ldr	x1, [x8, #0xff0] ; removeAllSubViews
10511f380: 94ac1f6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f384: aa1303e0    	mov	x0, x19
10511f388: 94ac1f73    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f38c: 1400000b    	b	0x10511f3b8 <_Flutter_MMFoundation_BindContext+0x15faf9c>
10511f390: 900d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511f394: f9462100    	ldr	x0, [x8, #0xc40] ; MMTableViewCell
10511f398: 94ac1f72    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10511f39c: d00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511f3a0: f9463501    	ldr	x1, [x8, #0xc68] ; initWithStyle:reuseIdentifier:
10511f3a4: b00cb5a3    	adrp	x3, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
10511f3a8: 9127a063    	add	x3, x3, #0x9e8 ; CFString 'Header'
10511f3ac: d2800002    	mov	x2, #0x0                ; =0
10511f3b0: 94ac1f63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f3b4: aa0003f5    	mov	x21, x0
10511f3b8: 900d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511f3bc: f9474d00    	ldr	x0, [x8, #0xe98]
10511f3c0: 94ac1f68    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10511f3c4: aa0003f3    	mov	x19, x0
10511f3c8: 900d7f68    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10511f3cc: f947a501    	ldr	x1, [x8, #0xf48] ; width
10511f3d0: aa1403e0    	mov	x0, x20
10511f3d4: f9001fe1    	str	x1, [sp, #0x38]
10511f3d8: 94ac1f59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f3dc: 1e604008    	fmov	d8, d0
10511f3e0: f00d7f08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10511f3e4: f9449d01    	ldr	x1, [x8, #0x938] ; height
10511f3e8: f9000ff5    	str	x21, [sp, #0x18]
10511f3ec: aa1503e0    	mov	x0, x21
10511f3f0: 94ac1f53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f3f4: 1e604003    	fmov	d3, d0
10511f3f8: f00d7f08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10511f3fc: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
10511f400: 9e6703e0    	fmov	d0, xzr
10511f404: 9e6703e1    	fmov	d1, xzr
10511f408: aa1303e0    	mov	x0, x19
10511f40c: 1e604102    	fmov	d2, d8
10511f410: 94ac1f4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f414: aa0003f7    	mov	x23, x0
10511f418: 900d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511f41c: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
10511f420: b00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511f424: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10511f428: 94ac1f45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f42c: aa1d03fd    	mov	x29, x29
10511f430: 94ac1f46    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f434: aa0003f9    	mov	x25, x0
10511f438: b00d82a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10511f43c: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
10511f440: 900d7f08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10511f444: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10511f448: 94ac1f3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f44c: aa0003e2    	mov	x2, x0
10511f450: d00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511f454: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10511f458: aa1903e0    	mov	x0, x25
10511f45c: 94ac1f38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f460: aa1d03fd    	mov	x29, x29
10511f464: 94ac1f39    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f468: aa0003fa    	mov	x26, x0
10511f46c: b00d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511f470: f9400501    	ldr	x1, [x8, #0x8] ; colorList
10511f474: 94ac1f32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f478: aa1d03fd    	mov	x29, x29
10511f47c: 94ac1f33    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f480: aa0003fb    	mov	x27, x0
10511f484: b00d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511f488: f9400901    	ldr	x1, [x8, #0x10] ; getColorByName:
10511f48c: b00cb5a2    	adrp	x2, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
10511f490: 91282042    	add	x2, x2, #0xa08 ; CFString '#EFEFF4'
10511f494: 94ac1f2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f498: aa1d03fd    	mov	x29, x29
10511f49c: 94ac1f2b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f4a0: aa0003fc    	mov	x28, x0
10511f4a4: 94ac1f25    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511f4a8: b40000a0    	cbz	x0, 0x10511f4bc <_Flutter_MMFoundation_BindContext+0x15fb0a0>
10511f4ac: aa1c03e0    	mov	x0, x28
10511f4b0: 94ac1f22    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511f4b4: aa1c03f8    	mov	x24, x28
10511f4b8: 14000009    	b	0x10511f4dc <_Flutter_MMFoundation_BindContext+0x15fb0c0>
10511f4bc: 900d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511f4c0: f9463100    	ldr	x0, [x8, #0xc60]
10511f4c4: 900d7f08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10511f4c8: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
10511f4cc: 94ac1f1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f4d0: aa1d03fd    	mov	x29, x29
10511f4d4: 94ac1f1d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f4d8: aa0003f8    	mov	x24, x0
10511f4dc: aa1c03e0    	mov	x0, x28
10511f4e0: 94ac1f1d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f4e4: 900d7f48    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10511f4e8: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
10511f4ec: aa1703e0    	mov	x0, x23
10511f4f0: aa1803e2    	mov	x2, x24
10511f4f4: 94ac1f12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f4f8: aa1803e0    	mov	x0, x24
10511f4fc: 94ac1f16    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f500: aa1c03e0    	mov	x0, x28
10511f504: 94ac1f14    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f508: aa1b03e0    	mov	x0, x27
10511f50c: 94ac1f12    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f510: aa1a03e0    	mov	x0, x26
10511f514: 94ac1f10    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f518: aa1903e0    	mov	x0, x25
10511f51c: 94ac1f0e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f520: 900d6a68    	adrp	x8, 0x11fe6b000 <dyld_stub_binder+0x11fe6b000>
10511f524: f9457d01    	ldr	x1, [x8, #0xaf8] ; setBackgroundView:
10511f528: f9400ff9    	ldr	x25, [sp, #0x18]
10511f52c: aa1903e0    	mov	x0, x25
10511f530: aa1703e2    	mov	x2, x23
10511f534: 94ac1f02    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f538: b00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511f53c: b9835108    	ldrsw	x8, [x8, #0x350]
10511f540: f9401be9    	ldr	x9, [sp, #0x30]
10511f544: f8686933    	ldr	x19, [x9, x8]
10511f548: f00d7f28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10511f54c: f9440901    	ldr	x1, [x8, #0x810] ; row
10511f550: aa1603e0    	mov	x0, x22
10511f554: 94ac1efa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f558: 2a0003e2    	mov	w2, w0
10511f55c: 900d73e8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
10511f560: f9403501    	ldr	x1, [x8, #0x68] ; getBanner:
10511f564: aa1303e0    	mov	x0, x19
10511f568: 94ac1ef5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f56c: aa1d03fd    	mov	x29, x29
10511f570: 94ac1ef6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f574: aa0003f6    	mov	x22, x0
10511f578: b00d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511f57c: f9427513    	ldr	x19, [x8, #0x4e8] ; contentView
10511f580: aa1903e0    	mov	x0, x25
10511f584: aa1303e1    	mov	x1, x19
10511f588: 94ac1eed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f58c: aa1d03fd    	mov	x29, x29
10511f590: 94ac1eee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f594: aa0003f8    	mov	x24, x0
10511f598: f9401fe1    	ldr	x1, [sp, #0x38]
10511f59c: 94ac1ee8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f5a0: f00d7f48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10511f5a4: f9418d01    	ldr	x1, [x8, #0x318] ; setWidth:
10511f5a8: aa1603e0    	mov	x0, x22
10511f5ac: 94ac1ee4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f5b0: aa1803e0    	mov	x0, x24
10511f5b4: 94ac1ee8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f5b8: 900d7f48    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10511f5bc: f9406501    	ldr	x1, [x8, #0xc8] ; setAutoresizingMask:
10511f5c0: aa1603e0    	mov	x0, x22
10511f5c4: 52800042    	mov	w2, #0x2                ; =2
10511f5c8: 94ac1edd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f5cc: aa1903e0    	mov	x0, x25
10511f5d0: aa1303e1    	mov	x1, x19
10511f5d4: 94ac1eda    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f5d8: aa1d03fd    	mov	x29, x29
10511f5dc: 94ac1edb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511f5e0: aa0003f3    	mov	x19, x0
10511f5e4: f00d7ee8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10511f5e8: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
10511f5ec: aa1603e2    	mov	x2, x22
10511f5f0: 94ac1ed3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f5f4: aa1303e0    	mov	x0, x19
10511f5f8: 94ac1ed7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f5fc: b00d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511f600: f9436501    	ldr	x1, [x8, #0x6c8] ; setSelectionStyle:
10511f604: aa1903e0    	mov	x0, x25
10511f608: d2800002    	mov	x2, #0x0                ; =0
10511f60c: 94ac1ecc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f610: b00c2668    	adrp	x8, 0x11d5ec000 <dyld_stub_binder+0x11d5ec000>
10511f614: f940fd08    	ldr	x8, [x8, #0x1f8]
10511f618: 6d400500    	ldp	d0, d1, [x8]
10511f61c: 6d410d02    	ldp	d2, d3, [x8, #0x10]
10511f620: f00d69a8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
10511f624: f9431901    	ldr	x1, [x8, #0x630] ; setSeparatorInset:
10511f628: aa1903e0    	mov	x0, x25
10511f62c: 94ac1ec4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511f630: aa1903e0    	mov	x0, x25
10511f634: 94ac1ec1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511f638: aa1603e0    	mov	x0, x22
10511f63c: f94017f6    	ldr	x22, [sp, #0x28]
10511f640: 94ac1ec5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511f644: 17fffe07    	b	0x10511ee60 <_Flutter_MMFoundation_BindContext+0x15faa44>
10511f648: 94ac1ecb    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
