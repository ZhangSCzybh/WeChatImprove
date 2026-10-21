
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106ea1ee0: 6dba23e9    	stp	d9, d8, [sp, #-0x60]!
106ea1ee4: a90167fa    	stp	x26, x25, [sp, #0x10]
106ea1ee8: a9025ff8    	stp	x24, x23, [sp, #0x20]
106ea1eec: a90357f6    	stp	x22, x21, [sp, #0x30]
106ea1ef0: a9044ff4    	stp	x20, x19, [sp, #0x40]
106ea1ef4: a9057bfd    	stp	x29, x30, [sp, #0x50]
106ea1ef8: 910143fd    	add	x29, sp, #0x50
106ea1efc: aa0203f3    	mov	x19, x2
106ea1f00: aa0003f4    	mov	x20, x0
106ea1f04: b00ced28    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106ea1f08: 52800036    	mov	w22, #0x1               ; =1
106ea1f0c: 391be916    	strb	w22, [x8, #0x6fa]
106ea1f10: aa0203e0    	mov	x0, x2
106ea1f14: 94361489    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106ea1f18: b00c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea1f1c: f9464501    	ldr	x1, [x8, #0xc88] ; shouldForbidCommentDataItem:
106ea1f20: aa1403e0    	mov	x0, x20
106ea1f24: aa1303e2    	mov	x2, x19
106ea1f28: 94361485    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea1f2c: aa0003f5    	mov	x21, x0
106ea1f30: 900c97e8    	adrp	x8, 0x12019d000 <dyld_stub_binder+0x12019d000>
106ea1f34: f944bd00    	ldr	x0, [x8, #0x978]
106ea1f38: 900c9d28    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ea1f3c: b9844d1a    	ldrsw	x26, [x8, #0x44c]
106ea1f40: f87a6a82    	ldr	x2, [x20, x26]
106ea1f44: b00c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea1f48: f9464901    	ldr	x1, [x8, #0xc90] ; equalTogetherUsersWithDataItem1:dataItem2:
106ea1f4c: aa1303e3    	mov	x3, x19
106ea1f50: 9436147b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea1f54: 900c9d39    	adrp	x25, 0x120245000 <dyld_stub_binder+0x120245000>
106ea1f58: 34000a00    	cbz	w0, 0x106ea2098 <_Flutter_MMFoundation_BindContext+0x337dc7c>
106ea1f5c: b9845b28    	ldrsw	x8, [x25, #0x458]
106ea1f60: 38686a88    	ldrb	w8, [x20, x8]
106ea1f64: 6b15011f    	cmp	w8, w21
106ea1f68: 54000981    	b.ne	0x106ea2098 <_Flutter_MMFoundation_BindContext+0x337dc7c>
106ea1f6c: f87a6a80    	ldr	x0, [x20, x26]
106ea1f70: d00c80c8    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
106ea1f74: f9467116    	ldr	x22, [x8, #0xce0] ; isPrivate
106ea1f78: aa1603e1    	mov	x1, x22
106ea1f7c: 94361470    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea1f80: aa0003f7    	mov	x23, x0
106ea1f84: aa1303e0    	mov	x0, x19
106ea1f88: aa1603e1    	mov	x1, x22
106ea1f8c: 9436146c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea1f90: 6b0002ff    	cmp	w23, w0
106ea1f94: 54000801    	b.ne	0x106ea2094 <_Flutter_MMFoundation_BindContext+0x337dc78>
106ea1f98: f87a6a80    	ldr	x0, [x20, x26]
106ea1f9c: 900c8a28    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
106ea1fa0: f942cd16    	ldr	x22, [x8, #0x598] ; hasSharedGroup
106ea1fa4: aa1603e1    	mov	x1, x22
106ea1fa8: 94361465    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea1fac: aa0003f7    	mov	x23, x0
106ea1fb0: aa1303e0    	mov	x0, x19
106ea1fb4: aa1603e1    	mov	x1, x22
106ea1fb8: 94361461    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea1fbc: 6b0002ff    	cmp	w23, w0
106ea1fc0: 540006a1    	b.ne	0x106ea2094 <_Flutter_MMFoundation_BindContext+0x337dc78>
106ea1fc4: f87a6a80    	ldr	x0, [x20, x26]
106ea1fc8: b00c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea1fcc: f9464d16    	ldr	x22, [x8, #0xc98] ; finderSharingFlags
106ea1fd0: aa1603e1    	mov	x1, x22
106ea1fd4: 9436145a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea1fd8: aa0003f7    	mov	x23, x0
106ea1fdc: aa1303e0    	mov	x0, x19
106ea1fe0: aa1603e1    	mov	x1, x22
106ea1fe4: 94361456    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea1fe8: 6b0002ff    	cmp	w23, w0
106ea1fec: 54000541    	b.ne	0x106ea2094 <_Flutter_MMFoundation_BindContext+0x337dc78>
106ea1ff0: f87a6a80    	ldr	x0, [x20, x26]
106ea1ff4: b00c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea1ff8: f9465116    	ldr	x22, [x8, #0xca0] ; newlifeSharingFlags
106ea1ffc: aa1603e1    	mov	x1, x22
106ea2000: 9436144f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2004: aa0003f7    	mov	x23, x0
106ea2008: aa1303e0    	mov	x0, x19
106ea200c: aa1603e1    	mov	x1, x22
106ea2010: 9436144b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2014: 6b0002ff    	cmp	w23, w0
106ea2018: 540003e1    	b.ne	0x106ea2094 <_Flutter_MMFoundation_BindContext+0x337dc78>
106ea201c: f87a6a80    	ldr	x0, [x20, x26]
106ea2020: 900c7f68    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
106ea2024: f942ad01    	ldr	x1, [x8, #0x558] ; isAd
106ea2028: 94361445    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea202c: 340022c0    	cbz	w0, 0x106ea2484 <_Flutter_MMFoundation_BindContext+0x337e068>
106ea2030: f87a6a80    	ldr	x0, [x20, x26]
106ea2034: 900c80a8    	adrp	x8, 0x11feb6000 <dyld_stub_binder+0x11feb6000>
106ea2038: f9403d16    	ldr	x22, [x8, #0x78] ; advertiseInfo
106ea203c: aa1603e1    	mov	x1, x22
106ea2040: 9436143f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2044: aa1d03fd    	mov	x29, x29
106ea2048: 94361440    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ea204c: aa0003f7    	mov	x23, x0
106ea2050: aa1303e0    	mov	x0, x19
106ea2054: aa1603e1    	mov	x1, x22
106ea2058: 94361439    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea205c: aa1d03fd    	mov	x29, x29
106ea2060: 9436143a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ea2064: aa0003f8    	mov	x24, x0
106ea2068: 900c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea206c: f9465501    	ldr	x1, [x8, #0xca8] ; shouldReloadFeedWithAdInfo:
106ea2070: aa1703e0    	mov	x0, x23
106ea2074: aa1803e2    	mov	x2, x24
106ea2078: 94361431    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea207c: aa0003f6    	mov	x22, x0
106ea2080: aa1803e0    	mov	x0, x24
106ea2084: 94361434    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ea2088: aa1703e0    	mov	x0, x23
106ea208c: 94361432    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ea2090: 14000002    	b	0x106ea2098 <_Flutter_MMFoundation_BindContext+0x337dc7c>
106ea2094: 52800036    	mov	w22, #0x1               ; =1
106ea2098: 900c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea209c: f9465901    	ldr	x1, [x8, #0xcb0] ; isModifyingStarStatus
106ea20a0: aa1403e0    	mov	x0, x20
106ea20a4: 94361426    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea20a8: 37000180    	tbnz	w0, #0x0, 0x106ea20d8 <_Flutter_MMFoundation_BindContext+0x337dcbc>
106ea20ac: f87a6a80    	ldr	x0, [x20, x26]
106ea20b0: f00c8a08    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
106ea20b4: f942b917    	ldr	x23, [x8, #0x570] ; isStarred
106ea20b8: aa1703e1    	mov	x1, x23
106ea20bc: 94361420    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea20c0: aa0003f8    	mov	x24, x0
106ea20c4: aa1303e0    	mov	x0, x19
106ea20c8: aa1703e1    	mov	x1, x23
106ea20cc: 9436141c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea20d0: 6b00031f    	cmp	w24, w0
106ea20d4: 54000060    	b.eq	0x106ea20e0 <_Flutter_MMFoundation_BindContext+0x337dcc4>
106ea20d8: 52800037    	mov	w23, #0x1               ; =1
106ea20dc: 1400000d    	b	0x106ea2110 <_Flutter_MMFoundation_BindContext+0x337dcf4>
106ea20e0: f87a6a82    	ldr	x2, [x20, x26]
106ea20e4: f00c8ac8    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
106ea20e8: f9478117    	ldr	x23, [x8, #0xf00] ; isSpringStyleForDataItem:
106ea20ec: aa1403e0    	mov	x0, x20
106ea20f0: aa1703e1    	mov	x1, x23
106ea20f4: 94361412    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea20f8: aa0003f8    	mov	x24, x0
106ea20fc: aa1403e0    	mov	x0, x20
106ea2100: aa1703e1    	mov	x1, x23
106ea2104: aa1303e2    	mov	x2, x19
106ea2108: 9436140d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea210c: 4a000317    	eor	w23, w24, w0
106ea2110: b9845b28    	ldrsw	x8, [x25, #0x458]
106ea2114: 38286a95    	strb	w21, [x20, x8]
106ea2118: b00c7d28    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
106ea211c: f9449d01    	ldr	x1, [x8, #0x938] ; setDataItem:
106ea2120: aa1403e0    	mov	x0, x20
106ea2124: aa1303e2    	mov	x2, x19
106ea2128: 94361405    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea212c: 900c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea2130: f9463501    	ldr	x1, [x8, #0xc68] ; updateInputView
106ea2134: aa1403e0    	mov	x0, x20
106ea2138: 94361401    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea213c: 34000416    	cbz	w22, 0x106ea21bc <_Flutter_MMFoundation_BindContext+0x337dda0>
106ea2140: b00c80c8    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
106ea2144: f9467101    	ldr	x1, [x8, #0xce0] ; isPrivate
106ea2148: aa1303e0    	mov	x0, x19
106ea214c: 943613fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2150: 340007a0    	cbz	w0, 0x106ea2244 <_Flutter_MMFoundation_BindContext+0x337de28>
106ea2154: b00c9688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106ea2158: f9471100    	ldr	x0, [x8, #0xe20]
106ea215c: f00c7cc8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
106ea2160: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
106ea2164: 943613f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2168: aa1d03fd    	mov	x29, x29
106ea216c: 943613f7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ea2170: aa0003f5    	mov	x21, x0
106ea2174: d00c7cc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106ea2178: f9471101    	ldr	x1, [x8, #0xe20] ; username
106ea217c: aa1303e0    	mov	x0, x19
106ea2180: 943613ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2184: aa1d03fd    	mov	x29, x29
106ea2188: 943613f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ea218c: aa0003f6    	mov	x22, x0
106ea2190: b00c9308    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106ea2194: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
106ea2198: aa1503e0    	mov	x0, x21
106ea219c: aa1603e2    	mov	x2, x22
106ea21a0: 943613e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea21a4: 52000017    	eor	w23, w0, #0x1
106ea21a8: aa1603e0    	mov	x0, x22
106ea21ac: 943613ea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ea21b0: aa1503e0    	mov	x0, x21
106ea21b4: 943613e8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ea21b8: 14000024    	b	0x106ea2248 <_Flutter_MMFoundation_BindContext+0x337de2c>
106ea21bc: 340000b7    	cbz	w23, 0x106ea21d0 <_Flutter_MMFoundation_BindContext+0x337ddb4>
106ea21c0: 900c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea21c4: f9465d01    	ldr	x1, [x8, #0xcb8] ; initExtensionViewsInTableHeader
106ea21c8: aa1403e0    	mov	x0, x20
106ea21cc: 943613dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea21d0: b00c9688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106ea21d4: f9471100    	ldr	x0, [x8, #0xe20]
106ea21d8: f00c7cc8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
106ea21dc: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
106ea21e0: 943613d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea21e4: aa1d03fd    	mov	x29, x29
106ea21e8: 943613d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ea21ec: aa0003f5    	mov	x21, x0
106ea21f0: d00c7cc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106ea21f4: f9471101    	ldr	x1, [x8, #0xe20] ; username
106ea21f8: aa1303e0    	mov	x0, x19
106ea21fc: 943613d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2200: aa1d03fd    	mov	x29, x29
106ea2204: 943613d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ea2208: aa0003f6    	mov	x22, x0
106ea220c: b00c9308    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106ea2210: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
106ea2214: aa1503e0    	mov	x0, x21
106ea2218: aa1603e2    	mov	x2, x22
106ea221c: 943613c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2220: aa0003f7    	mov	x23, x0
106ea2224: aa1603e0    	mov	x0, x22
106ea2228: 943613cb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ea222c: aa1503e0    	mov	x0, x21
106ea2230: 943613c9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ea2234: 34000b57    	cbz	w23, 0x106ea239c <_Flutter_MMFoundation_BindContext+0x337df80>
106ea2238: 900c7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
106ea223c: 912a0108    	add	x8, x8, #0xa80
106ea2240: 14000054    	b	0x106ea2390 <_Flutter_MMFoundation_BindContext+0x337df74>
106ea2244: 52800037    	mov	w23, #0x1               ; =1
106ea2248: f00c8ac8    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
106ea224c: f9475915    	ldr	x21, [x8, #0xeb0] ; bForbideComment
106ea2250: aa1403e0    	mov	x0, x20
106ea2254: aa1503e1    	mov	x1, x21
106ea2258: 943613b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea225c: f00c9d08    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ea2260: b9858108    	ldrsw	x8, [x8, #0x580]
106ea2264: f8686a88    	ldr	x8, [x20, x8]
106ea2268: d00c9329    	adrp	x9, 0x120108000 <dyld_stub_binder+0x120108000>
106ea226c: f9411136    	ldr	x22, [x9, #0x220] ; setHidden:
106ea2270: 0a0002e2    	and	w2, w23, w0
106ea2274: aa0803e0    	mov	x0, x8
106ea2278: aa1603e1    	mov	x1, x22
106ea227c: 943613b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2280: aa1403e0    	mov	x0, x20
106ea2284: aa1503e1    	mov	x1, x21
106ea2288: 943613ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea228c: aa0003e2    	mov	x2, x0
106ea2290: f00c9d08    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ea2294: b985a517    	ldrsw	x23, [x8, #0x5a4]
106ea2298: f8776a80    	ldr	x0, [x20, x23]
106ea229c: aa1603e1    	mov	x1, x22
106ea22a0: 943613a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea22a4: aa1403e0    	mov	x0, x20
106ea22a8: aa1503e1    	mov	x1, x21
106ea22ac: 943613a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea22b0: aa0003f6    	mov	x22, x0
106ea22b4: d00c7cc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106ea22b8: f9419515    	ldr	x21, [x8, #0x328] ; getVisibleHeight
106ea22bc: aa1403e0    	mov	x0, x20
106ea22c0: aa1503e1    	mov	x1, x21
106ea22c4: 9436139e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea22c8: 1e604008    	fmov	d8, d0
106ea22cc: f8776a80    	ldr	x0, [x20, x23]
106ea22d0: 340000b6    	cbz	w22, 0x106ea22e4 <_Flutter_MMFoundation_BindContext+0x337dec8>
106ea22d4: 900c9348    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106ea22d8: f941d901    	ldr	x1, [x8, #0x3b0] ; setY:
106ea22dc: 1e604100    	fmov	d0, d8
106ea22e0: 14000008    	b	0x106ea2300 <_Flutter_MMFoundation_BindContext+0x337dee4>
106ea22e4: 900c9308    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106ea22e8: f9449d01    	ldr	x1, [x8, #0x938] ; height
106ea22ec: 94361394    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea22f0: 1e603900    	fsub	d0, d8, d0
106ea22f4: f8776a80    	ldr	x0, [x20, x23]
106ea22f8: 900c9348    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106ea22fc: f941d901    	ldr	x1, [x8, #0x3b0] ; setY:
106ea2300: 9436138f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2304: b00c9688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106ea2308: f9470100    	ldr	x0, [x8, #0xe00]
106ea230c: d00c7cc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106ea2310: f9419101    	ldr	x1, [x8, #0x320] ; pageScopeWidthFor:
106ea2314: aa1403e2    	mov	x2, x20
106ea2318: 94361389    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea231c: 1e604008    	fmov	d8, d0
106ea2320: aa1403e0    	mov	x0, x20
106ea2324: aa1503e1    	mov	x1, x21
106ea2328: 94361385    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea232c: 1e604009    	fmov	d9, d0
106ea2330: 900c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea2334: f9441d01    	ldr	x1, [x8, #0x838] ; getTableViewMarginToBottom
106ea2338: aa1403e0    	mov	x0, x20
106ea233c: 94361380    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2340: 1e603923    	fsub	d3, d9, d0
106ea2344: f00c9d08    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ea2348: b984dd08    	ldrsw	x8, [x8, #0x4dc]
106ea234c: f8686a80    	ldr	x0, [x20, x8]
106ea2350: d00c9328    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106ea2354: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
106ea2358: 9e6703e0    	fmov	d0, xzr
106ea235c: 9e6703e1    	fmov	d1, xzr
106ea2360: 1e604102    	fmov	d2, d8
106ea2364: 94361376    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2368: b00c7d48    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
106ea236c: f940ad01    	ldr	x1, [x8, #0x158] ; initTableHeaderView
106ea2370: aa1403e0    	mov	x0, x20
106ea2374: 94361372    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2378: 900c7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
106ea237c: f9454101    	ldr	x1, [x8, #0xa80] ; initTableFooterView
106ea2380: aa1403e0    	mov	x0, x20
106ea2384: 9436136e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea2388: 900c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea238c: 911dc108    	add	x8, x8, #0x770
106ea2390: f9400101    	ldr	x1, [x8]
106ea2394: aa1403e0    	mov	x0, x20
106ea2398: 94361369    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea239c: 900c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea23a0: f943b101    	ldr	x1, [x8, #0x760] ; updateHeaderGridView
106ea23a4: aa1403e0    	mov	x0, x20
106ea23a8: 94361365    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea23ac: 900c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea23b0: f942d901    	ldr	x1, [x8, #0x5b0] ; reloadRightBarButtonItems
106ea23b4: aa1403e0    	mov	x0, x20
106ea23b8: 94361361    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea23bc: 900c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea23c0: f9466101    	ldr	x1, [x8, #0xcc0] ; tryUpdateAdContent:
106ea23c4: aa1403e0    	mov	x0, x20
106ea23c8: aa1303e2    	mov	x2, x19
106ea23cc: 9436135c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea23d0: b00c7cc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106ea23d4: f9458901    	ldr	x1, [x8, #0xb10] ; reloadTableView
106ea23d8: aa1403e0    	mov	x0, x20
106ea23dc: 94361358    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea23e0: f00c88c8    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
106ea23e4: f9479d01    	ldr	x1, [x8, #0xf38] ; updateContentOffset
106ea23e8: aa1403e0    	mov	x0, x20
106ea23ec: 94361354    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea23f0: f00c9d08    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ea23f4: b984e119    	ldrsw	x25, [x8, #0x4e0]
106ea23f8: 8b190280    	add	x0, x20, x25
106ea23fc: 94361364    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
106ea2400: b4000320    	cbz	x0, 0x106ea2464 <_Flutter_MMFoundation_BindContext+0x337e048>
106ea2404: aa0003f6    	mov	x22, x0
106ea2408: 8b190280    	add	x0, x20, x25
106ea240c: 94361360    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
106ea2410: aa0003f7    	mov	x23, x0
106ea2414: 900c8ae8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea2418: f9466515    	ldr	x21, [x8, #0xcc8] ; onCommentListViewDataChanged:
106ea241c: 900c9328    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106ea2420: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
106ea2424: aa1503e2    	mov	x2, x21
106ea2428: 94361345    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea242c: aa0003f8    	mov	x24, x0
106ea2430: aa1703e0    	mov	x0, x23
106ea2434: 94361348    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ea2438: aa1603e0    	mov	x0, x22
106ea243c: 94361346    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ea2440: 34000138    	cbz	w24, 0x106ea2464 <_Flutter_MMFoundation_BindContext+0x337e048>
106ea2444: 8b190280    	add	x0, x20, x25
106ea2448: 94361351    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
106ea244c: aa0003f4    	mov	x20, x0
106ea2450: aa1503e1    	mov	x1, x21
106ea2454: aa1303e2    	mov	x2, x19
106ea2458: 94361339    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ea245c: aa1403e0    	mov	x0, x20
106ea2460: 9436133d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ea2464: aa1303e0    	mov	x0, x19
106ea2468: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106ea246c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
106ea2470: a94357f6    	ldp	x22, x21, [sp, #0x30]
106ea2474: a9425ff8    	ldp	x24, x23, [sp, #0x20]
106ea2478: a94167fa    	ldp	x26, x25, [sp, #0x10]
106ea247c: 6cc623e9    	ldp	d9, d8, [sp], #0x60
106ea2480: 14361335    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ea2484: 52800016    	mov	w22, #0x0               ; =0
106ea2488: 17ffff04    	b	0x106ea2098 <_Flutter_MMFoundation_BindContext+0x337dc7c>
