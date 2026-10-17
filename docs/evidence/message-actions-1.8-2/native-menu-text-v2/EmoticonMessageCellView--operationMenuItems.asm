
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10152e064: d101c3ff    	sub	sp, sp, #0x70
10152e068: a9016ffc    	stp	x28, x27, [sp, #0x10]
10152e06c: a90267fa    	stp	x26, x25, [sp, #0x20]
10152e070: a9035ff8    	stp	x24, x23, [sp, #0x30]
10152e074: a90457f6    	stp	x22, x21, [sp, #0x40]
10152e078: a9054ff4    	stp	x20, x19, [sp, #0x50]
10152e07c: a9067bfd    	stp	x29, x30, [sp, #0x60]
10152e080: 910183fd    	add	x29, sp, #0x60
10152e084: aa0003f5    	mov	x21, x0
10152e088: f00fb808    	adrp	x8, 0x120c31000 <dyld_stub_binder+0x120c31000>
10152e08c: 52800029    	mov	w9, #0x1                ; =1
10152e090: 393f8109    	strb	w9, [x8, #0xfe0]
10152e094: d00f6228    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10152e098: f9452113    	ldr	x19, [x8, #0xa40] ; �o- 
10152e09c: 900f4888    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10152e0a0: f9410916    	ldr	x22, [x8, #0x210] ; viewModel
10152e0a4: aa1603e1    	mov	x1, x22
10152e0a8: 959be425    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e0ac: aa1d03fd    	mov	x29, x29
10152e0b0: 959be426    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e0b4: aa0003f4    	mov	x20, x0
10152e0b8: 900f4888    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10152e0bc: f9410518    	ldr	x24, [x8, #0x208] ; messageWrap
10152e0c0: aa1803e1    	mov	x1, x24
10152e0c4: 959be41e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e0c8: aa1d03fd    	mov	x29, x29
10152e0cc: 959be41f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e0d0: aa0003f7    	mov	x23, x0
10152e0d4: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e0d8: f940ad01    	ldr	x1, [x8, #0x158] ; ReportEmoticonAction:scene:messageWrap:
10152e0dc: aa1303e0    	mov	x0, x19
10152e0e0: d2800002    	mov	x2, #0x0                ; =0
10152e0e4: d2800003    	mov	x3, #0x0                ; =0
10152e0e8: aa1703e4    	mov	x4, x23
10152e0ec: 959be414    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e0f0: aa1703e0    	mov	x0, x23
10152e0f4: 959be418    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e0f8: aa1403e0    	mov	x0, x20
10152e0fc: 959be416    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e100: b00f6228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10152e104: f9455500    	ldr	x0, [x8, #0xaa8]
10152e108: b00f5e88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10152e10c: f941a101    	ldr	x1, [x8, #0x340] ; array
10152e110: 959be40b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e114: aa1d03fd    	mov	x29, x29
10152e118: 959be40c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e11c: aa0003f3    	mov	x19, x0
10152e120: aa1503e0    	mov	x0, x21
10152e124: aa1603e1    	mov	x1, x22
10152e128: 959be405    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e12c: aa1d03fd    	mov	x29, x29
10152e130: 959be406    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e134: aa0003f7    	mov	x23, x0
10152e138: aa1803e1    	mov	x1, x24
10152e13c: 959be400    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e140: aa1d03fd    	mov	x29, x29
10152e144: 959be401    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e148: aa0003f9    	mov	x25, x0
10152e14c: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e150: f940b501    	ldr	x1, [x8, #0x168] ; m_nsEmoticonBelongToProductID
10152e154: 959be3fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e158: aa1d03fd    	mov	x29, x29
10152e15c: 959be3fb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e160: f90007e0    	str	x0, [sp, #0x8]
10152e164: aa1903e0    	mov	x0, x25
10152e168: 959be3fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e16c: aa1703e0    	mov	x0, x23
10152e170: 959be3f9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e174: aa1503e0    	mov	x0, x21
10152e178: aa1603e1    	mov	x1, x22
10152e17c: 959be3f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e180: aa1d03fd    	mov	x29, x29
10152e184: 959be3f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e188: aa0003f9    	mov	x25, x0
10152e18c: d00f4b88    	adrp	x8, 0x11fea0000 <dyld_stub_binder+0x11fea0000>
10152e190: f9449917    	ldr	x23, [x8, #0x930] ; msgDownloadStatus
10152e194: aa1703e1    	mov	x1, x23
10152e198: 959be3e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e19c: aa0003fa    	mov	x26, x0
10152e1a0: aa1903e0    	mov	x0, x25
10152e1a4: 959be3ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e1a8: 900f4879    	adrp	x25, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10152e1ac: f1000b5f    	cmp	x26, #0x2
10152e1b0: 54000961    	b.ne	0x10152e2dc <__text+0x15262dc>
10152e1b4: b00f6228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10152e1b8: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10152e1bc: d00f5e88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10152e1c0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10152e1c4: 959be3de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e1c8: aa1d03fd    	mov	x29, x29
10152e1cc: 959be3df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e1d0: aa0003f9    	mov	x25, x0
10152e1d4: d00f6228    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10152e1d8: f9452500    	ldr	x0, [x8, #0xa48] ; �d- 
10152e1dc: b00f5e88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10152e1e0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10152e1e4: 959be3d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e1e8: aa0003e2    	mov	x2, x0
10152e1ec: f00f4848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10152e1f0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10152e1f4: aa1903e0    	mov	x0, x25
10152e1f8: 959be3d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e1fc: aa1d03fd    	mov	x29, x29
10152e200: 959be3d2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e204: aa0003fa    	mov	x26, x0
10152e208: aa1503e0    	mov	x0, x21
10152e20c: aa1603e1    	mov	x1, x22
10152e210: 959be3cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e214: aa1d03fd    	mov	x29, x29
10152e218: 959be3cc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e21c: aa0003fb    	mov	x27, x0
10152e220: aa1803e1    	mov	x1, x24
10152e224: 959be3c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e228: aa1d03fd    	mov	x29, x29
10152e22c: 959be3c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e230: aa0003f8    	mov	x24, x0
10152e234: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e238: f940b101    	ldr	x1, [x8, #0x160] ; m_nsEmoticonMD5
10152e23c: 959be3c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e240: aa1d03fd    	mov	x29, x29
10152e244: 959be3c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e248: aa0003fc    	mov	x28, x0
10152e24c: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e250: f940b901    	ldr	x1, [x8, #0x170] ; checkEmoticonCanAddStrictWay:Md5:pid:
10152e254: aa1a03e0    	mov	x0, x26
10152e258: 52800002    	mov	w2, #0x0                ; =0
10152e25c: aa1c03e3    	mov	x3, x28
10152e260: f94007e4    	ldr	x4, [sp, #0x8]
10152e264: 959be3b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e268: aa0003f4    	mov	x20, x0
10152e26c: aa1c03e0    	mov	x0, x28
10152e270: 959be3b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e274: aa1803e0    	mov	x0, x24
10152e278: 959be3b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e27c: aa1b03e0    	mov	x0, x27
10152e280: 959be3b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e284: aa1a03e0    	mov	x0, x26
10152e288: 959be3b3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e28c: aa1903e0    	mov	x0, x25
10152e290: 900f4879    	adrp	x25, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10152e294: 959be3b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e298: 34000234    	cbz	w20, 0x10152e2dc <__text+0x15262dc>
10152e29c: d00f6228    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10152e2a0: f9452900    	ldr	x0, [x8, #0xa50]
10152e2a4: 959be3af    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10152e2a8: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e2ac: f940bd03    	ldr	x3, [x8, #0x178] ; onSaveEmoticon:
10152e2b0: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e2b4: f940c101    	ldr	x1, [x8, #0x180] ; initWithType:action:
10152e2b8: 52800162    	mov	w2, #0xb                ; =11
10152e2bc: 959be3a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e2c0: aa0003f4    	mov	x20, x0
10152e2c4: f943c721    	ldr	x1, [x25, #0x788] ; safeAddObject:
10152e2c8: aa1303e0    	mov	x0, x19
10152e2cc: aa1403e2    	mov	x2, x20
10152e2d0: 959be39b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e2d4: aa1403e0    	mov	x0, x20
10152e2d8: 959be39f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e2dc: 900f4888    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10152e2e0: f9415101    	ldr	x1, [x8, #0x2a0] ; forwardMenuItem
10152e2e4: aa1503e0    	mov	x0, x21
10152e2e8: 959be395    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e2ec: aa1d03fd    	mov	x29, x29
10152e2f0: 959be396    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e2f4: aa0003f8    	mov	x24, x0
10152e2f8: f943c739    	ldr	x25, [x25, #0x788] ; safeAddObject:
10152e2fc: aa1303e0    	mov	x0, x19
10152e300: aa1903e1    	mov	x1, x25
10152e304: aa1803e2    	mov	x2, x24
10152e308: 959be38d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e30c: aa1503e0    	mov	x0, x21
10152e310: aa1603e1    	mov	x1, x22
10152e314: 959be38a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e318: aa1d03fd    	mov	x29, x29
10152e31c: 959be38b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e320: aa0003fa    	mov	x26, x0
10152e324: aa1703e1    	mov	x1, x23
10152e328: 959be385    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e32c: d00f623b    	adrp	x27, 0x120174000 <dyld_stub_binder+0x120174000>
10152e330: b00f489c    	adrp	x28, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e334: f100081f    	cmp	x0, #0x2
10152e338: 540002c1    	b.ne	0x10152e390 <__text+0x1526390>
10152e33c: f9452f60    	ldr	x0, [x27, #0xa58] ; ��- 
10152e340: f940c781    	ldr	x1, [x28, #0x188] ; isEmoticonAllow
10152e344: 959be37e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e348: aa0003f4    	mov	x20, x0
10152e34c: aa1a03e0    	mov	x0, x26
10152e350: 959be381    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e354: 34000234    	cbz	w20, 0x10152e398 <__text+0x1526398>
10152e358: d00f6228    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10152e35c: f9452900    	ldr	x0, [x8, #0xa50]
10152e360: 959be380    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10152e364: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e368: f940c903    	ldr	x3, [x8, #0x190] ; onShowRelatedEmoticon:
10152e36c: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e370: f940c101    	ldr	x1, [x8, #0x180] ; initWithType:action:
10152e374: 52800182    	mov	w2, #0xc                ; =12
10152e378: 959be371    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e37c: aa0003fa    	mov	x26, x0
10152e380: aa1303e0    	mov	x0, x19
10152e384: aa1903e1    	mov	x1, x25
10152e388: aa1a03e2    	mov	x2, x26
10152e38c: 959be36c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e390: aa1a03e0    	mov	x0, x26
10152e394: 959be370    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e398: 900f4888    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10152e39c: f9415501    	ldr	x1, [x8, #0x2a8] ; addRevokeOrDeleteMenuItem:
10152e3a0: aa1503e0    	mov	x0, x21
10152e3a4: aa1303e2    	mov	x2, x19
10152e3a8: 959be365    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e3ac: aa1503e0    	mov	x0, x21
10152e3b0: aa1603e1    	mov	x1, x22
10152e3b4: 959be362    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e3b8: aa1d03fd    	mov	x29, x29
10152e3bc: 959be363    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152e3c0: aa0003f4    	mov	x20, x0
10152e3c4: aa1703e1    	mov	x1, x23
10152e3c8: 959be35d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e3cc: aa0003f5    	mov	x21, x0
10152e3d0: aa1403e0    	mov	x0, x20
10152e3d4: 959be360    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e3d8: f1000abf    	cmp	x21, #0x2
10152e3dc: 540002e1    	b.ne	0x10152e438 <__text+0x1526438>
10152e3e0: d00f6228    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10152e3e4: f9451900    	ldr	x0, [x8, #0xa30] ; �;- 
10152e3e8: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e3ec: f940cd01    	ldr	x1, [x8, #0x198] ; shouldShowEmoticonCameraFollow
10152e3f0: 959be353    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e3f4: 34000220    	cbz	w0, 0x10152e438 <__text+0x1526438>
10152e3f8: d00f6228    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10152e3fc: f9452900    	ldr	x0, [x8, #0xa50]
10152e400: 959be358    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10152e404: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e408: f940d103    	ldr	x3, [x8, #0x1a0] ; onTakeCameraFollow:
10152e40c: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e410: f940c101    	ldr	x1, [x8, #0x180] ; initWithType:action:
10152e414: 528001a2    	mov	w2, #0xd                ; =13
10152e418: 959be349    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e41c: aa0003f4    	mov	x20, x0
10152e420: aa1303e0    	mov	x0, x19
10152e424: aa1903e1    	mov	x1, x25
10152e428: aa1403e2    	mov	x2, x20
10152e42c: 959be344    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e430: aa1403e0    	mov	x0, x20
10152e434: 959be348    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e438: f9452f60    	ldr	x0, [x27, #0xa58] ; ��- 
10152e43c: f940c781    	ldr	x1, [x28, #0x188] ; isEmoticonAllow
10152e440: 959be33f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e444: f94007f5    	ldr	x21, [sp, #0x8]
10152e448: 36000060    	tbz	w0, #0x0, 0x10152e454 <__text+0x1526454>
10152e44c: 52800014    	mov	w20, #0x0               ; =0
10152e450: 14000006    	b	0x10152e468 <__text+0x1526468>
10152e454: f9452f60    	ldr	x0, [x27, #0xa58] ; ��- 
10152e458: d00f4b88    	adrp	x8, 0x11fea0000 <dyld_stub_binder+0x11fea0000>
10152e45c: f944b501    	ldr	x1, [x8, #0x968] ; isEmoticonLimited
10152e460: 959be337    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e464: 52000014    	eor	w20, w0, #0x1
10152e468: f9452f60    	ldr	x0, [x27, #0xa58] ; ��- 
10152e46c: d00f4b88    	adrp	x8, 0x11fea0000 <dyld_stub_binder+0x11fea0000>
10152e470: f944b901    	ldr	x1, [x8, #0x970] ; isInGetDetailBlockListForProductId:
10152e474: aa1503e2    	mov	x2, x21
10152e478: 959be331    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e47c: 37000254    	tbnz	w20, #0x0, 0x10152e4c4 <__text+0x15264c4>
10152e480: 37000220    	tbnz	w0, #0x0, 0x10152e4c4 <__text+0x15264c4>
10152e484: d00f6228    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10152e488: f9452900    	ldr	x0, [x8, #0xa50]
10152e48c: 959be335    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10152e490: d00f4b88    	adrp	x8, 0x11fea0000 <dyld_stub_binder+0x11fea0000>
10152e494: f944bd03    	ldr	x3, [x8, #0x978] ; onShowDetailPage:
10152e498: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152e49c: f940c101    	ldr	x1, [x8, #0x180] ; initWithType:action:
10152e4a0: 528001c2    	mov	w2, #0xe                ; =14
10152e4a4: 959be326    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e4a8: aa0003f4    	mov	x20, x0
10152e4ac: aa1303e0    	mov	x0, x19
10152e4b0: aa1903e1    	mov	x1, x25
10152e4b4: aa1403e2    	mov	x2, x20
10152e4b8: 959be321    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152e4bc: aa1403e0    	mov	x0, x20
10152e4c0: 959be325    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e4c4: aa1803e0    	mov	x0, x24
10152e4c8: 959be323    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e4cc: aa1503e0    	mov	x0, x21
10152e4d0: 959be321    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152e4d4: aa1303e0    	mov	x0, x19
10152e4d8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10152e4dc: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10152e4e0: a94457f6    	ldp	x22, x21, [sp, #0x40]
10152e4e4: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10152e4e8: a94267fa    	ldp	x26, x25, [sp, #0x20]
10152e4ec: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10152e4f0: 9101c3ff    	add	sp, sp, #0x70
10152e4f4: 159be31f    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>