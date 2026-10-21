
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1060fbf54: 6db923e9    	stp	d9, d8, [sp, #-0x70]!
1060fbf58: a9016ffc    	stp	x28, x27, [sp, #0x10]
1060fbf5c: a90267fa    	stp	x26, x25, [sp, #0x20]
1060fbf60: a9035ff8    	stp	x24, x23, [sp, #0x30]
1060fbf64: a90457f6    	stp	x22, x21, [sp, #0x40]
1060fbf68: a9054ff4    	stp	x20, x19, [sp, #0x50]
1060fbf6c: a9067bfd    	stp	x29, x30, [sp, #0x60]
1060fbf70: 910183fd    	add	x29, sp, #0x60
1060fbf74: d10e43ff    	sub	sp, sp, #0x390
1060fbf78: aa0003f7    	mov	x23, x0
1060fbf7c: 900ba7a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1060fbf80: f9405908    	ldr	x8, [x8, #0xb0]
1060fbf84: f9400108    	ldr	x8, [x8]
1060fbf88: f81903a8    	stur	x8, [x29, #-0x70]
1060fbf8c: 91012000    	add	x0, x0, #0x48
1060fbf90: 946cac7f    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060fbf94: aa0003fc    	mov	x28, x0
1060fbf98: b4008a60    	cbz	x0, 0x1060fd0e4 <_Flutter_MMFoundation_BindContext+0x25d8cc8>
1060fbf9c: f94012e2    	ldr	x2, [x23, #0x20]
1060fbfa0: b4008a22    	cbz	x2, 0x1060fd0e4 <_Flutter_MMFoundation_BindContext+0x25d8cc8>
1060fbfa4: 900d0468    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1060fbfa8: f9442900    	ldr	x0, [x8, #0x850]
1060fbfac: d00cea08    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1060fbfb0: f9435101    	ldr	x1, [x8, #0x6a0] ; parseFromData:
1060fbfb4: 946cac62    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fbfb8: aa1d03fd    	mov	x29, x29
1060fbfbc: 946cac63    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fbfc0: aa0003fa    	mov	x26, x0
1060fbfc4: 900d03c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fbfc8: f9453513    	ldr	x19, [x8, #0xa68]
1060fbfcc: f00cea88    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1060fbfd0: f945051b    	ldr	x27, [x8, #0xa08] ; roomid
1060fbfd4: aa1b03e1    	mov	x1, x27
1060fbfd8: 946cac59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fbfdc: aa0003f4    	mov	x20, x0
1060fbfe0: f9402af6    	ldr	x22, [x23, #0x50]
1060fbfe4: b00cee88    	adrp	x8, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
1060fbfe8: f945b101    	ldr	x1, [x8, #0xb60] ; callerOpenid
1060fbfec: aa1a03e0    	mov	x0, x26
1060fbff0: f9004be1    	str	x1, [sp, #0x90]
1060fbff4: 946cac52    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fbff8: aa1d03fd    	mov	x29, x29
1060fbffc: 946cac53    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc000: aa0003f5    	mov	x21, x0
1060fc004: b00cebc8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
1060fc008: f9429101    	ldr	x1, [x8, #0x520] ; roomType
1060fc00c: aa1a03e0    	mov	x0, x26
1060fc010: f90053e1    	str	x1, [sp, #0xa0]
1060fc014: 946cac4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc018: aa0003f9    	mov	x25, x0
1060fc01c: b00cea08    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1060fc020: f947a501    	ldr	x1, [x8, #0xf48] ; debugDescription
1060fc024: aa1a03e0    	mov	x0, x26
1060fc028: 946cac45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc02c: aa1d03fd    	mov	x29, x29
1060fc030: 946cac46    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc034: aa0003f8    	mov	x24, x0
1060fc038: f9004ff7    	str	x23, [sp, #0x98]
1060fc03c: f94016e8    	ldr	x8, [x23, #0x28]
1060fc040: b00ce9e9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1060fc044: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1060fc048: a902a3e0    	stp	x0, x8, [sp, #0x28]
1060fc04c: f00c3b88    	adrp	x8, 0x11e86f000 <dyld_stub_binder+0x11e86f000>
1060fc050: 91042108    	add	x8, x8, #0x108
1060fc054: a901e7f5    	stp	x21, x25, [sp, #0x18]
1060fc058: b00a9c23    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1060fc05c: 91056463    	add	x3, x3, #0x159
1060fc060: 900ac445    	adrp	x5, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060fc064: 912838a5    	add	x5, x5, #0xa0e
1060fc068: a900dbf4    	stp	x20, x22, [sp, #0x8]
1060fc06c: aa1a03f6    	mov	x22, x26
1060fc070: f00ac447    	adrp	x7, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060fc074: 913604e7    	add	x7, x7, #0xd81
1060fc078: f90003e8    	str	x8, [sp]
1060fc07c: aa1303e0    	mov	x0, x19
1060fc080: f9003fe1    	str	x1, [sp, #0x78]
1060fc084: 52800042    	mov	w2, #0x2                ; =2
1060fc088: 52800004    	mov	w4, #0x0                ; =0
1060fc08c: 528235e6    	mov	w6, #0x11af             ; =4527
1060fc090: 946cac2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc094: aa1803e0    	mov	x0, x24
1060fc098: 946cac2f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc09c: aa1503e0    	mov	x0, x21
1060fc0a0: 946cac2d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc0a4: d00cefc8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060fc0a8: f942a101    	ldr	x1, [x8, #0x540] ; subCall
1060fc0ac: aa1a03e0    	mov	x0, x26
1060fc0b0: 946cac23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc0b4: 37008140    	tbnz	w0, #0x0, 0x1060fd0dc <_Flutter_MMFoundation_BindContext+0x25d8cc0>
1060fc0b8: f00ceb48    	adrp	x8, 0x11fe67000 <dyld_stub_binder+0x11fe67000>
1060fc0bc: f9438517    	ldr	x23, [x8, #0x708] ; usernameList
1060fc0c0: aa1603e0    	mov	x0, x22
1060fc0c4: aa1703e1    	mov	x1, x23
1060fc0c8: 946cac1d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc0cc: aa1d03fd    	mov	x29, x29
1060fc0d0: 946cac1e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc0d4: aa0003f3    	mov	x19, x0
1060fc0d8: 900d0028    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1060fc0dc: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1060fc0e0: 946cac17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc0e4: aa0003f9    	mov	x25, x0
1060fc0e8: aa1303e0    	mov	x0, x19
1060fc0ec: 946cac1a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc0f0: b40004b9    	cbz	x25, 0x1060fc184 <_Flutter_MMFoundation_BindContext+0x25d7d68>
1060fc0f4: f00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc0f8: f9453500    	ldr	x0, [x8, #0xa68]
1060fc0fc: d00c3b88    	adrp	x8, 0x11e86e000 <dyld_stub_binder+0x11e86e000>
1060fc100: 913a2108    	add	x8, x8, #0xe88
1060fc104: f90003e8    	str	x8, [sp]
1060fc108: b00a9c23    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1060fc10c: 91056463    	add	x3, x3, #0x159
1060fc110: 900ac445    	adrp	x5, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060fc114: 912838a5    	add	x5, x5, #0xa0e
1060fc118: f00ac447    	adrp	x7, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060fc11c: 913604e7    	add	x7, x7, #0xd81
1060fc120: f9403fe1    	ldr	x1, [sp, #0x78]
1060fc124: 52800042    	mov	w2, #0x2                ; =2
1060fc128: 52800004    	mov	w4, #0x0                ; =0
1060fc12c: 52823746    	mov	w6, #0x11ba             ; =4538
1060fc130: 946cac03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc134: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fc138: b98a3908    	ldrsw	x8, [x8, #0xa38]
1060fc13c: 8b080380    	add	x0, x28, x8
1060fc140: 946cac13    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060fc144: aa0003f3    	mov	x19, x0
1060fc148: aa1603e0    	mov	x0, x22
1060fc14c: f94053e1    	ldr	x1, [sp, #0xa0]
1060fc150: 946cabfb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc154: aa0003f4    	mov	x20, x0
1060fc158: aa1603e0    	mov	x0, x22
1060fc15c: aa1b03e1    	mov	x1, x27
1060fc160: 946cabf7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc164: aa0003e3    	mov	x3, x0
1060fc168: f00cf688    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1060fc16c: f9417901    	ldr	x1, [x8, #0x2f0] ; readyJoinRoomForIlink:roomID:
1060fc170: aa1303e0    	mov	x0, x19
1060fc174: aa1403e2    	mov	x2, x20
1060fc178: 946cabf1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc17c: aa1303e0    	mov	x0, x19
1060fc180: 946cabf5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc184: aa1603e0    	mov	x0, x22
1060fc188: aa1b03e1    	mov	x1, x27
1060fc18c: 946cabec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc190: aa0003e2    	mov	x2, x0
1060fc194: f00cf688    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1060fc198: f9405501    	ldr	x1, [x8, #0xa8] ; setUpLongTermCallbackAfterJoin:
1060fc19c: aa1c03e0    	mov	x0, x28
1060fc1a0: 946cabe7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc1a4: f00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc1a8: f945e900    	ldr	x0, [x8, #0xbd0]
1060fc1ac: 900d0028    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1060fc1b0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1060fc1b4: f90043e1    	str	x1, [sp, #0x80]
1060fc1b8: 946cabe1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc1bc: aa1d03fd    	mov	x29, x29
1060fc1c0: 946cabe2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc1c4: aa0003f3    	mov	x19, x0
1060fc1c8: f00d0448    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1060fc1cc: f943a500    	ldr	x0, [x8, #0x748]
1060fc1d0: f00d0008    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1060fc1d4: f947ad1a    	ldr	x26, [x8, #0xf58] ; class
1060fc1d8: aa1a03e1    	mov	x1, x26
1060fc1dc: 946cabd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc1e0: aa0003e2    	mov	x2, x0
1060fc1e4: b00ce9e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1060fc1e8: f9464115    	ldr	x21, [x8, #0xc80] ; getService:
1060fc1ec: aa1303e0    	mov	x0, x19
1060fc1f0: aa1503e1    	mov	x1, x21
1060fc1f4: 946cabd2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc1f8: aa1d03fd    	mov	x29, x29
1060fc1fc: 946cabd3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc200: aa0003f4    	mov	x20, x0
1060fc204: b00cefc8    	adrp	x8, 0x11fef5000 <dyld_stub_binder+0x11fef5000>
1060fc208: f9472901    	ldr	x1, [x8, #0xe50] ; isPhoneCalling
1060fc20c: 946cabcc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc210: f90057fc    	str	x28, [sp, #0xa8]
1060fc214: f90047f5    	str	x21, [sp, #0x88]
1060fc218: 36000f00    	tbz	w0, #0x0, 0x1060fc3f8 <_Flutter_MMFoundation_BindContext+0x25d7fdc>
1060fc21c: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fc220: b98a3908    	ldrsw	x8, [x8, #0xa38]
1060fc224: 8b080380    	add	x0, x28, x8
1060fc228: 946cabd9    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060fc22c: aa0003f5    	mov	x21, x0
1060fc230: d00cefc8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060fc234: f9438d01    	ldr	x1, [x8, #0x718] ; getIfCallKitStatus
1060fc238: 946cabc1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc23c: aa0003fc    	mov	x28, x0
1060fc240: aa1503e0    	mov	x0, x21
1060fc244: f94047f5    	ldr	x21, [sp, #0x88]
1060fc248: 946cabc3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc24c: aa1403e0    	mov	x0, x20
1060fc250: 946cabc1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc254: aa1303e0    	mov	x0, x19
1060fc258: 946cabbf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc25c: f00d03b4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc260: 37000d7c    	tbnz	w28, #0x0, 0x1060fc40c <_Flutter_MMFoundation_BindContext+0x25d7ff0>
1060fc264: 52800040    	mov	w0, #0x2                ; =2
1060fc268: 946c43f6    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1060fc26c: 340005a0    	cbz	w0, 0x1060fc320 <_Flutter_MMFoundation_BindContext+0x25d7f04>
1060fc270: 946cabcc    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1060fc274: aa0003f3    	mov	x19, x0
1060fc278: f00d03b5    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc27c: f94546a0    	ldr	x0, [x21, #0xa88]
1060fc280: 946cabb8    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1060fc284: aa0003f4    	mov	x20, x0
1060fc288: f94546a0    	ldr	x0, [x21, #0xa88]
1060fc28c: d00d0068    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1060fc290: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1060fc294: f90003ff    	str	xzr, [sp]
1060fc298: f00c3b82    	adrp	x2, 0x11e86f000 <dyld_stub_binder+0x11e86f000>
1060fc29c: 9104a042    	add	x2, x2, #0x128
1060fc2a0: 946caba7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc2a4: aa1d03fd    	mov	x29, x29
1060fc2a8: 946caba8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc2ac: aa0003f5    	mov	x21, x0
1060fc2b0: d00d0028    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1060fc2b4: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
1060fc2b8: f00c1ce8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1060fc2bc: 91352108    	add	x8, x8, #0xd48
1060fc2c0: a90003e8    	stp	x8, x0, [sp]
1060fc2c4: f00c1ce2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1060fc2c8: 9134a042    	add	x2, x2, #0xd28
1060fc2cc: aa1403e0    	mov	x0, x20
1060fc2d0: 946cab9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc2d4: aa0003f4    	mov	x20, x0
1060fc2d8: aa1503e0    	mov	x0, x21
1060fc2dc: f94047f5    	ldr	x21, [sp, #0x88]
1060fc2e0: 946cab9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc2e4: 900a88c1    	adrp	x1, 0x11b214000 <dyld_stub_binder+0x11b214000>
1060fc2e8: 913d9021    	add	x1, x1, #0xf64
1060fc2ec: 900ac442    	adrp	x2, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060fc2f0: 91283842    	add	x2, x2, #0xa0e
1060fc2f4: f00ac444    	adrp	x4, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060fc2f8: 91360484    	add	x4, x4, #0xd81
1060fc2fc: 52800040    	mov	w0, #0x2                ; =2
1060fc300: 52823843    	mov	w3, #0x11c2             ; =4546
1060fc304: aa1403e5    	mov	x5, x20
1060fc308: 946c43cf    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
1060fc30c: aa1403e0    	mov	x0, x20
1060fc310: f00d03b4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc314: 946cab90    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc318: aa1303e0    	mov	x0, x19
1060fc31c: 946caba4    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1060fc320: f00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc324: f9469900    	ldr	x0, [x8, #0xd30]
1060fc328: d00ce9e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1060fc32c: f9421101    	ldr	x1, [x8, #0x420] ; isEnable
1060fc330: 946cab83    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc334: 34006820    	cbz	w0, 0x1060fd038 <_Flutter_MMFoundation_BindContext+0x25d8c1c>
1060fc338: 52800040    	mov	w0, #0x2                ; =2
1060fc33c: 946c43c1    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1060fc340: 34000660    	cbz	w0, 0x1060fc40c <_Flutter_MMFoundation_BindContext+0x25d7ff0>
1060fc344: 946cab97    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1060fc348: aa0003f3    	mov	x19, x0
1060fc34c: f00d03b5    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc350: f94546a0    	ldr	x0, [x21, #0xa88]
1060fc354: 946cab83    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1060fc358: aa0003f4    	mov	x20, x0
1060fc35c: f94546a0    	ldr	x0, [x21, #0xa88]
1060fc360: d00d0068    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1060fc364: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1060fc368: f90003ff    	str	xzr, [sp]
1060fc36c: f00c2b42    	adrp	x2, 0x11e667000 <dyld_stub_binder+0x11e667000>
1060fc370: 9107a042    	add	x2, x2, #0x1e8
1060fc374: 946cab72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc378: aa1d03fd    	mov	x29, x29
1060fc37c: 946cab73    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc380: aa0003f5    	mov	x21, x0
1060fc384: d00d0028    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1060fc388: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
1060fc38c: f00c1ce8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1060fc390: 91352108    	add	x8, x8, #0xd48
1060fc394: a90003e8    	stp	x8, x0, [sp]
1060fc398: f00c1ce2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1060fc39c: 9134a042    	add	x2, x2, #0xd28
1060fc3a0: aa1403e0    	mov	x0, x20
1060fc3a4: 946cab66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc3a8: aa0003f4    	mov	x20, x0
1060fc3ac: aa1503e0    	mov	x0, x21
1060fc3b0: f94047f5    	ldr	x21, [sp, #0x88]
1060fc3b4: 946cab68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc3b8: 900a88c1    	adrp	x1, 0x11b214000 <dyld_stub_binder+0x11b214000>
1060fc3bc: 913d9021    	add	x1, x1, #0xf64
1060fc3c0: 900ac442    	adrp	x2, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060fc3c4: 91283842    	add	x2, x2, #0xa0e
1060fc3c8: f00ac444    	adrp	x4, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060fc3cc: 91360484    	add	x4, x4, #0xd81
1060fc3d0: 52800040    	mov	w0, #0x2                ; =2
1060fc3d4: 528238a3    	mov	w3, #0x11c5             ; =4549
1060fc3d8: aa1403e5    	mov	x5, x20
1060fc3dc: 946c439a    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
1060fc3e0: aa1403e0    	mov	x0, x20
1060fc3e4: f00d03b4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc3e8: 946cab5b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc3ec: aa1303e0    	mov	x0, x19
1060fc3f0: 946cab6f    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1060fc3f4: 14000006    	b	0x1060fc40c <_Flutter_MMFoundation_BindContext+0x25d7ff0>
1060fc3f8: aa1403e0    	mov	x0, x20
1060fc3fc: 946cab56    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc400: aa1303e0    	mov	x0, x19
1060fc404: 946cab54    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc408: f00d03b4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc40c: f90037f9    	str	x25, [sp, #0x68]
1060fc410: aa1703f9    	mov	x25, x23
1060fc414: f00cf688    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1060fc418: f9405901    	ldr	x1, [x8, #0xb0] ; ilinkApiDelegate
1060fc41c: f94057fc    	ldr	x28, [sp, #0xa8]
1060fc420: aa1c03e0    	mov	x0, x28
1060fc424: 946cab46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc428: aa1d03fd    	mov	x29, x29
1060fc42c: 946cab47    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc430: aa0003f3    	mov	x19, x0
1060fc434: aa1603e0    	mov	x0, x22
1060fc438: aa1b03e1    	mov	x1, x27
1060fc43c: 946cab40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc440: aa0003e2    	mov	x2, x0
1060fc444: d00cefc8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060fc448: f9439501    	ldr	x1, [x8, #0x728] ; getIfCallkitWithRoom:
1060fc44c: aa1303e0    	mov	x0, x19
1060fc450: 946cab3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc454: 34001da0    	cbz	w0, 0x1060fc808 <_Flutter_MMFoundation_BindContext+0x25d83ec>
1060fc458: f90033fa    	str	x26, [sp, #0x60]
1060fc45c: aa1303e0    	mov	x0, x19
1060fc460: 946cab3d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc464: f9002ff9    	str	x25, [sp, #0x58]
1060fc468: aa1603e0    	mov	x0, x22
1060fc46c: aa1b03e1    	mov	x1, x27
1060fc470: 946cab33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc474: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fc478: b98a1508    	ldrsw	x8, [x8, #0xa14]
1060fc47c: f8286b80    	str	x0, [x28, x8]
1060fc480: f9404ff7    	ldr	x23, [sp, #0x98]
1060fc484: f94016e1    	ldr	x1, [x23, #0x28]
1060fc488: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fc48c: b98a1913    	ldrsw	x19, [x8, #0xa18]
1060fc490: 8b130380    	add	x0, x28, x19
1060fc494: 946cab2b    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1060fc498: f9401ae1    	ldr	x1, [x23, #0x30]
1060fc49c: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fc4a0: b98a1d14    	ldrsw	x20, [x8, #0xa1c]
1060fc4a4: 8b140380    	add	x0, x28, x20
1060fc4a8: 946cab26    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1060fc4ac: f9401ee1    	ldr	x1, [x23, #0x38]
1060fc4b0: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fc4b4: b98b591a    	ldrsw	x26, [x8, #0xb58]
1060fc4b8: 8b1a0380    	add	x0, x28, x26
1060fc4bc: 946cab21    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1060fc4c0: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fc4c4: b989fd15    	ldrsw	x21, [x8, #0x9fc]
1060fc4c8: f8756b80    	ldr	x0, [x28, x21]
1060fc4cc: d00d0028    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1060fc4d0: f9468101    	ldr	x1, [x8, #0xd00] ; initData
1060fc4d4: 946cab1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc4d8: f8756b80    	ldr	x0, [x28, x21]
1060fc4dc: f8746b82    	ldr	x2, [x28, x20]
1060fc4e0: d00cea88    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1060fc4e4: f9450101    	ldr	x1, [x8, #0xa00] ; setMSdkGroupId:
1060fc4e8: 946cab15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc4ec: f8756b80    	ldr	x0, [x28, x21]
1060fc4f0: f8736b82    	ldr	x2, [x28, x19]
1060fc4f4: d00cea88    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1060fc4f8: f944f501    	ldr	x1, [x8, #0x9e8] ; setMMultiTalkGroupId:
1060fc4fc: 946cab10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc500: f8756b80    	ldr	x0, [x28, x21]
1060fc504: f8736b82    	ldr	x2, [x28, x19]
1060fc508: d00cea88    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1060fc50c: f944f901    	ldr	x1, [x8, #0x9f0] ; setMWxGroupId:
1060fc510: 946cab0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc514: f8756b93    	ldr	x19, [x28, x21]
1060fc518: aa1603e0    	mov	x0, x22
1060fc51c: aa1b03e1    	mov	x1, x27
1060fc520: 946cab07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc524: aa0003e2    	mov	x2, x0
1060fc528: 900cee88    	adrp	x8, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
1060fc52c: f947c101    	ldr	x1, [x8, #0xf80] ; setMroomid:
1060fc530: aa1303e0    	mov	x0, x19
1060fc534: 946cab02    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc538: f90023f5    	str	x21, [sp, #0x40]
1060fc53c: f8756b80    	ldr	x0, [x28, x21]
1060fc540: 394172e2    	ldrb	w2, [x23, #0x5c]
1060fc544: d00cefc8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060fc548: f9439901    	ldr	x1, [x8, #0x730] ; setMMuteNotification:
1060fc54c: 946caafc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc550: aa1603e0    	mov	x0, x22
1060fc554: f94053e1    	ldr	x1, [sp, #0xa0]
1060fc558: 946caaf9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc55c: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fc560: b98a8508    	ldrsw	x8, [x8, #0xa84]
1060fc564: b8286b80    	str	w0, [x28, x8]
1060fc568: 7100041f    	cmp	w0, #0x1
1060fc56c: 540000a1    	b.ne	0x1060fc580 <_Flutter_MMFoundation_BindContext+0x25d8164>
1060fc570: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fc574: b98a6908    	ldrsw	x8, [x8, #0xa68]
1060fc578: 52800029    	mov	w9, #0x1                ; =1
1060fc57c: 38286b89    	strb	w9, [x28, x8]
1060fc580: b00cebd3    	adrp	x19, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
1060fc584: 900d003b    	adrp	x27, 0x120100000 <dyld_stub_binder+0x120100000>
1060fc588: f94037f4    	ldr	x20, [sp, #0x68]
1060fc58c: f9003bf6    	str	x22, [sp, #0x70]
1060fc590: b40020b4    	cbz	x20, 0x1060fc9a4 <_Flutter_MMFoundation_BindContext+0x25d8588>
1060fc594: aa1603f5    	mov	x21, x22
1060fc598: f00d0456    	adrp	x22, 0x120187000 <dyld_stub_binder+0x120187000>
1060fc59c: f943c6c0    	ldr	x0, [x22, #0x788]
1060fc5a0: 946caaee    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1060fc5a4: aa0003fb    	mov	x27, x0
1060fc5a8: f9430e61    	ldr	x1, [x19, #0x618] ; callerUsername
1060fc5ac: aa1503e0    	mov	x0, x21
1060fc5b0: 946caae3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc5b4: aa1d03fd    	mov	x29, x29
1060fc5b8: 946caae4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc5bc: aa0003f4    	mov	x20, x0
1060fc5c0: b00cea08    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1060fc5c4: f9436513    	ldr	x19, [x8, #0x6c8] ; setUsername:
1060fc5c8: aa1b03e0    	mov	x0, x27
1060fc5cc: aa1303e1    	mov	x1, x19
1060fc5d0: aa1403e2    	mov	x2, x20
1060fc5d4: 946caada    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc5d8: aa1403e0    	mov	x0, x20
1060fc5dc: 946caade    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc5e0: aa1503e0    	mov	x0, x21
1060fc5e4: f9404be1    	ldr	x1, [sp, #0x90]
1060fc5e8: 946caad5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc5ec: aa1d03fd    	mov	x29, x29
1060fc5f0: 946caad6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc5f4: aa0003f4    	mov	x20, x0
1060fc5f8: d00cefc8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060fc5fc: f9413901    	ldr	x1, [x8, #0x270] ; setVoipsdkUsername:
1060fc600: aa1b03e0    	mov	x0, x27
1060fc604: aa1403e2    	mov	x2, x20
1060fc608: 946caacd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc60c: aa1403e0    	mov	x0, x20
1060fc610: 946caad1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc614: f943c6c0    	ldr	x0, [x22, #0x788]
1060fc618: 946caad0    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1060fc61c: aa0003f4    	mov	x20, x0
1060fc620: f00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc624: f945e900    	ldr	x0, [x8, #0xbd0]
1060fc628: f94043e1    	ldr	x1, [sp, #0x80]
1060fc62c: 946caac4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc630: aa1d03fd    	mov	x29, x29
1060fc634: 946caac5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc638: aa0003f5    	mov	x21, x0
1060fc63c: 900d03c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1060fc640: f9401500    	ldr	x0, [x8, #0x28] ; P;,
1060fc644: f94033e1    	ldr	x1, [sp, #0x60]
1060fc648: 946caabd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc64c: aa0003e2    	mov	x2, x0
1060fc650: aa1503e0    	mov	x0, x21
1060fc654: f94047e1    	ldr	x1, [sp, #0x88]
1060fc658: 946caab9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc65c: aa1d03fd    	mov	x29, x29
1060fc660: 946caaba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc664: aa0003f7    	mov	x23, x0
1060fc668: f00ce9e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1060fc66c: f9470d01    	ldr	x1, [x8, #0xe18] ; getSelfContact
1060fc670: 946caab3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc674: aa1d03fd    	mov	x29, x29
1060fc678: 946caab4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc67c: aa0003f8    	mov	x24, x0
1060fc680: f00ce9e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1060fc684: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
1060fc688: 946caaad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc68c: aa1d03fd    	mov	x29, x29
1060fc690: 946caaae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc694: aa0003f9    	mov	x25, x0
1060fc698: aa1403e0    	mov	x0, x20
1060fc69c: aa1303e1    	mov	x1, x19
1060fc6a0: aa1903e2    	mov	x2, x25
1060fc6a4: 946caaa6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc6a8: aa1903e0    	mov	x0, x25
1060fc6ac: 946caaaa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc6b0: aa1803e0    	mov	x0, x24
1060fc6b4: 946caaa8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc6b8: aa1703e0    	mov	x0, x23
1060fc6bc: 946caaa6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc6c0: aa1503e0    	mov	x0, x21
1060fc6c4: 946caaa4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc6c8: f00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc6cc: f9455500    	ldr	x0, [x8, #0xaa8]
1060fc6d0: f00d0008    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1060fc6d4: f941c101    	ldr	x1, [x8, #0x380] ; arrayWithObjects:
1060fc6d8: a9007ff4    	stp	x20, xzr, [sp]
1060fc6dc: a908eff4    	stp	x20, x27, [sp, #0x88]
1060fc6e0: aa1b03e2    	mov	x2, x27
1060fc6e4: 946caa96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc6e8: aa1d03fd    	mov	x29, x29
1060fc6ec: 946caa97    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc6f0: f87a6b88    	ldr	x8, [x28, x26]
1060fc6f4: f83a6b80    	str	x0, [x28, x26]
1060fc6f8: aa0803e0    	mov	x0, x8
1060fc6fc: 946caa96    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc700: 4f00e400    	movi.16b	v0, #0x0
1060fc704: ad1003e0    	stp	q0, q0, [sp, #0x200]
1060fc708: ad0f03e0    	stp	q0, q0, [sp, #0x1e0]
1060fc70c: f9403be0    	ldr	x0, [sp, #0x70]
1060fc710: f9402fe1    	ldr	x1, [sp, #0x58]
1060fc714: 946caa8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc718: aa1d03fd    	mov	x29, x29
1060fc71c: 946caa8b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc720: aa0003f5    	mov	x21, x0
1060fc724: 900d0028    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1060fc728: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1060fc72c: 910783e2    	add	x2, sp, #0x1e0
1060fc730: d103c3a3    	sub	x3, x29, #0xf0
1060fc734: f90053e1    	str	x1, [sp, #0xa0]
1060fc738: 52800204    	mov	w4, #0x10               ; =16
1060fc73c: 946caa80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc740: b40004e0    	cbz	x0, 0x1060fc7dc <_Flutter_MMFoundation_BindContext+0x25d83c0>
1060fc744: aa0003f8    	mov	x24, x0
1060fc748: f940fbe8    	ldr	x8, [sp, #0x1f0]
1060fc74c: f9400114    	ldr	x20, [x8]
1060fc750: d2800017    	mov	x23, #0x0               ; =0
1060fc754: d00ce9e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1060fc758: f943c519    	ldr	x25, [x8, #0x788] ; safeAddObject:
1060fc75c: f940fbe8    	ldr	x8, [sp, #0x1f0]
1060fc760: f9400108    	ldr	x8, [x8]
1060fc764: eb14011f    	cmp	x8, x20
1060fc768: 54000060    	b.eq	0x1060fc774 <_Flutter_MMFoundation_BindContext+0x25d8358>
1060fc76c: aa1503e0    	mov	x0, x21
1060fc770: 946caa78    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1060fc774: f940f7e8    	ldr	x8, [sp, #0x1e8]
1060fc778: f877791b    	ldr	x27, [x8, x23, lsl #3]
1060fc77c: f943c6c0    	ldr	x0, [x22, #0x788]
1060fc780: 946caa76    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1060fc784: aa0003fc    	mov	x28, x0
1060fc788: aa1303e1    	mov	x1, x19
1060fc78c: aa1b03e2    	mov	x2, x27
1060fc790: 946caa6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc794: f94057e8    	ldr	x8, [sp, #0xa8]
1060fc798: f87a6900    	ldr	x0, [x8, x26]
1060fc79c: aa1903e1    	mov	x1, x25
1060fc7a0: aa1c03e2    	mov	x2, x28
1060fc7a4: 946caa66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc7a8: aa1c03e0    	mov	x0, x28
1060fc7ac: 946caa6a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc7b0: 910006f7    	add	x23, x23, #0x1
1060fc7b4: eb17031f    	cmp	x24, x23
1060fc7b8: 54fffd21    	b.ne	0x1060fc75c <_Flutter_MMFoundation_BindContext+0x25d8340>
1060fc7bc: 910783e2    	add	x2, sp, #0x1e0
1060fc7c0: d103c3a3    	sub	x3, x29, #0xf0
1060fc7c4: aa1503e0    	mov	x0, x21
1060fc7c8: f94053e1    	ldr	x1, [sp, #0xa0]
1060fc7cc: 52800204    	mov	w4, #0x10               ; =16
1060fc7d0: 946caa5b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc7d4: aa0003f8    	mov	x24, x0
1060fc7d8: b5fffbc0    	cbnz	x0, 0x1060fc750 <_Flutter_MMFoundation_BindContext+0x25d8334>
1060fc7dc: aa1503e0    	mov	x0, x21
1060fc7e0: 946caa5d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc7e4: f94047e0    	ldr	x0, [sp, #0x88]
1060fc7e8: 946caa5b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc7ec: f9404be0    	ldr	x0, [sp, #0x90]
1060fc7f0: 946caa59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc7f4: f94057fc    	ldr	x28, [sp, #0xa8]
1060fc7f8: a946dbf4    	ldp	x20, x22, [sp, #0x68]
1060fc7fc: f9404ff7    	ldr	x23, [sp, #0x98]
1060fc800: 900d003b    	adrp	x27, 0x120100000 <dyld_stub_binder+0x120100000>
1060fc804: 14000074    	b	0x1060fc9d4 <_Flutter_MMFoundation_BindContext+0x25d85b8>
1060fc808: f945ea80    	ldr	x0, [x20, #0xbd0]
1060fc80c: f94043e1    	ldr	x1, [sp, #0x80]
1060fc810: 946caa4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc814: aa1d03fd    	mov	x29, x29
1060fc818: 946caa4c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc81c: aa1403f8    	mov	x24, x20
1060fc820: aa0003f4    	mov	x20, x0
1060fc824: f00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc828: f9467d00    	ldr	x0, [x8, #0xcf8]
1060fc82c: aa1a03e1    	mov	x1, x26
1060fc830: 946caa43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc834: aa0003e2    	mov	x2, x0
1060fc838: aa1403e0    	mov	x0, x20
1060fc83c: aa1503e1    	mov	x1, x21
1060fc840: 946caa3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc844: aa1d03fd    	mov	x29, x29
1060fc848: 946caa40    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc84c: aa1503f7    	mov	x23, x21
1060fc850: aa0003f5    	mov	x21, x0
1060fc854: d00cea88    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1060fc858: f944c901    	ldr	x1, [x8, #0x990] ; isVoipWorking
1060fc85c: 946caa38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc860: 34000100    	cbz	w0, 0x1060fc880 <_Flutter_MMFoundation_BindContext+0x25d8464>
1060fc864: aa1503e0    	mov	x0, x21
1060fc868: 946caa3b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc86c: aa1403e0    	mov	x0, x20
1060fc870: 946caa39    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc874: aa1303e0    	mov	x0, x19
1060fc878: 946caa37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc87c: 14000023    	b	0x1060fc908 <_Flutter_MMFoundation_BindContext+0x25d84ec>
1060fc880: f945eb00    	ldr	x0, [x24, #0xbd0]
1060fc884: f94043e1    	ldr	x1, [sp, #0x80]
1060fc888: 946caa2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc88c: aa1d03fd    	mov	x29, x29
1060fc890: 946caa2e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc894: aa0003fc    	mov	x28, x0
1060fc898: f00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc89c: f9468100    	ldr	x0, [x8, #0xd00]
1060fc8a0: f90033fa    	str	x26, [sp, #0x60]
1060fc8a4: aa1a03e1    	mov	x1, x26
1060fc8a8: 946caa25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc8ac: aa0003e2    	mov	x2, x0
1060fc8b0: aa1c03e0    	mov	x0, x28
1060fc8b4: aa1703e1    	mov	x1, x23
1060fc8b8: 946caa21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc8bc: aa1d03fd    	mov	x29, x29
1060fc8c0: 946caa22    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fc8c4: aa0003f8    	mov	x24, x0
1060fc8c8: d00cea88    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1060fc8cc: f944cd01    	ldr	x1, [x8, #0x998] ; isMultiTalkActive
1060fc8d0: 946caa1b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc8d4: aa0003f7    	mov	x23, x0
1060fc8d8: aa1803e0    	mov	x0, x24
1060fc8dc: 946caa1e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc8e0: aa1c03e0    	mov	x0, x28
1060fc8e4: f94057fc    	ldr	x28, [sp, #0xa8]
1060fc8e8: 946caa1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc8ec: aa1503e0    	mov	x0, x21
1060fc8f0: 946caa19    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc8f4: aa1403e0    	mov	x0, x20
1060fc8f8: 946caa17    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc8fc: aa1303e0    	mov	x0, x19
1060fc900: 946caa15    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc904: 34ffdb17    	cbz	w23, 0x1060fc464 <_Flutter_MMFoundation_BindContext+0x25d8048>
1060fc908: f00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fc90c: f9453500    	ldr	x0, [x8, #0xa68]
1060fc910: f00c3b88    	adrp	x8, 0x11e86f000 <dyld_stub_binder+0x11e86f000>
1060fc914: 91052108    	add	x8, x8, #0x148
1060fc918: f90003e8    	str	x8, [sp]
1060fc91c: b00a9c23    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1060fc920: 91056463    	add	x3, x3, #0x159
1060fc924: 900ac445    	adrp	x5, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060fc928: 912838a5    	add	x5, x5, #0xa0e
1060fc92c: f00ac447    	adrp	x7, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060fc930: 913604e7    	add	x7, x7, #0xd81
1060fc934: f9403fe1    	ldr	x1, [sp, #0x78]
1060fc938: 52800042    	mov	w2, #0x2                ; =2
1060fc93c: 52800004    	mov	w4, #0x0                ; =0
1060fc940: 52823aa6    	mov	w6, #0x11d5             ; =4565
1060fc944: 946ca9fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc948: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fc94c: b98a0908    	ldrsw	x8, [x8, #0xa08]
1060fc950: f8686b93    	ldr	x19, [x28, x8]
1060fc954: d00ba788    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1060fc958: f947e108    	ldr	x8, [x8, #0xfc0]
1060fc95c: f90117e8    	str	x8, [sp, #0x228]
1060fc960: b0096428    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1060fc964: fd41c100    	ldr	d0, [x8, #0x380]
1060fc968: fd011be0    	str	d0, [sp, #0x230]
1060fc96c: b0000008    	adrp	x8, 0x1060fd000 <_Flutter_MMFoundation_BindContext+0x25d8be4>
1060fc970: 91070108    	add	x8, x8, #0x1c0
1060fc974: d00ba7c9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1060fc978: 9115c129    	add	x9, x9, #0x570
1060fc97c: f9011fe8    	str	x8, [sp, #0x238]
1060fc980: f90123e9    	str	x9, [sp, #0x240]
1060fc984: aa1603e0    	mov	x0, x22
1060fc988: 946ca9ec    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060fc98c: f90127f6    	str	x22, [sp, #0x248]
1060fc990: 9108a3e1    	add	x1, sp, #0x228
1060fc994: aa1303e0    	mov	x0, x19
1060fc998: 946c4222    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
1060fc99c: f94127e0    	ldr	x0, [sp, #0x248]
1060fc9a0: 140001ce    	b	0x1060fd0d8 <_Flutter_MMFoundation_BindContext+0x25d8cbc>
1060fc9a4: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fc9a8: b98a3908    	ldrsw	x8, [x8, #0xa38]
1060fc9ac: 8b080380    	add	x0, x28, x8
1060fc9b0: 946ca9f7    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060fc9b4: aa0003f3    	mov	x19, x0
1060fc9b8: 394172e3    	ldrb	w3, [x23, #0x5c]
1060fc9bc: f00cf688    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1060fc9c0: f941b901    	ldr	x1, [x8, #0x370] ; onStartRecvInvite:muteNotification:
1060fc9c4: aa1603e2    	mov	x2, x22
1060fc9c8: 946ca9dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fc9cc: aa1303e0    	mov	x0, x19
1060fc9d0: 946ca9e1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fc9d4: f100029f    	cmp	x20, #0x0
1060fc9d8: 1a9f07f3    	cset	w19, ne
1060fc9dc: 910763e0    	add	x0, sp, #0x1d8
1060fc9e0: aa1c03e1    	mov	x1, x28
1060fc9e4: 946ca9e2    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
1060fc9e8: f00d0435    	adrp	x21, 0x120183000 <dyld_stub_binder+0x120183000>
1060fc9ec: f94096a0    	ldr	x0, [x21, #0x128]
1060fc9f0: 946ca9dc    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1060fc9f4: aa0003f4    	mov	x20, x0
1060fc9f8: d00ba799    	adrp	x25, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1060fc9fc: f947e339    	ldr	x25, [x25, #0xfc0]
1060fca00: f900cff9    	str	x25, [sp, #0x198]
1060fca04: b0096428    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1060fca08: fd41c108    	ldr	d8, [x8, #0x380]
1060fca0c: b0000008    	adrp	x8, 0x1060fd000 <_Flutter_MMFoundation_BindContext+0x25d8be4>
1060fca10: 91081108    	add	x8, x8, #0x204
1060fca14: fd00d3e8    	str	d8, [sp, #0x1a0]
1060fca18: d00bac29    	adrp	x9, 0x11d682000 <dyld_stub_binder+0x11d682000>
1060fca1c: 911a0129    	add	x9, x9, #0x680
1060fca20: a91aa7e8    	stp	x8, x9, [sp, #0x1a8]
1060fca24: 910663f8    	add	x24, sp, #0x198
1060fca28: 9100c300    	add	x0, x24, #0x30
1060fca2c: 910763e1    	add	x1, sp, #0x1d8
1060fca30: 946ca9d2    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1060fca34: 390753f3    	strb	w19, [sp, #0x1d4]
1060fca38: f94022e0    	ldr	x0, [x23, #0x40]
1060fca3c: 946ca9bf    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060fca40: f900dfe0    	str	x0, [sp, #0x1b8]
1060fca44: aa1603e0    	mov	x0, x22
1060fca48: 946ca9bc    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060fca4c: f900e3f6    	str	x22, [sp, #0x1c0]
1060fca50: b9405ae8    	ldr	w8, [x23, #0x58]
1060fca54: b901d3e8    	str	w8, [sp, #0x1d0]
1060fca58: 900cee88    	adrp	x8, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
1060fca5c: f9461113    	ldr	x19, [x8, #0xc20] ; initWithCallback:isContinuous:
1060fca60: 910663e2    	add	x2, sp, #0x198
1060fca64: aa1403e0    	mov	x0, x20
1060fca68: aa1303e1    	mov	x1, x19
1060fca6c: 52800003    	mov	w3, #0x0                ; =0
1060fca70: 946ca9b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fca74: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fca78: b98b7109    	ldrsw	x9, [x8, #0xb70]
1060fca7c: f8696b88    	ldr	x8, [x28, x9]
1060fca80: f8296b80    	str	x0, [x28, x9]
1060fca84: aa0803e0    	mov	x0, x8
1060fca88: 946ca9b3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fca8c: f94096a0    	ldr	x0, [x21, #0x128]
1060fca90: 946ca9b4    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1060fca94: aa0003f4    	mov	x20, x0
1060fca98: f900b3f9    	str	x25, [sp, #0x160]
1060fca9c: b0000008    	adrp	x8, 0x1060fd000 <_Flutter_MMFoundation_BindContext+0x25d8be4>
1060fcaa0: 9116a108    	add	x8, x8, #0x5a8
1060fcaa4: fd00b7e8    	str	d8, [sp, #0x168]
1060fcaa8: d00bac29    	adrp	x9, 0x11d682000 <dyld_stub_binder+0x11d682000>
1060fcaac: 911ac129    	add	x9, x9, #0x6b0
1060fcab0: a91727e8    	stp	x8, x9, [sp, #0x170]
1060fcab4: 910583e8    	add	x8, sp, #0x160
1060fcab8: 9100a100    	add	x0, x8, #0x28
1060fcabc: 910763e1    	add	x1, sp, #0x1d8
1060fcac0: 946ca9ae    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1060fcac4: f9402ae8    	ldr	x8, [x23, #0x50]
1060fcac8: f900cbe8    	str	x8, [sp, #0x190]
1060fcacc: f94022e0    	ldr	x0, [x23, #0x40]
1060fcad0: 946ca99a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060fcad4: f900c3e0    	str	x0, [sp, #0x180]
1060fcad8: 910583e2    	add	x2, sp, #0x160
1060fcadc: aa1403e0    	mov	x0, x20
1060fcae0: aa1303e1    	mov	x1, x19
1060fcae4: 52800003    	mov	w3, #0x0                ; =0
1060fcae8: 946ca995    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcaec: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fcaf0: b98b7509    	ldrsw	x9, [x8, #0xb74]
1060fcaf4: f8696b88    	ldr	x8, [x28, x9]
1060fcaf8: f8296b80    	str	x0, [x28, x9]
1060fcafc: aa0803e0    	mov	x0, x8
1060fcb00: 946ca995    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcb04: f94096a0    	ldr	x0, [x21, #0x128]
1060fcb08: 946ca996    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1060fcb0c: aa0003f4    	mov	x20, x0
1060fcb10: f90093f9    	str	x25, [sp, #0x120]
1060fcb14: b0000008    	adrp	x8, 0x1060fd000 <_Flutter_MMFoundation_BindContext+0x25d8be4>
1060fcb18: 911cb108    	add	x8, x8, #0x72c
1060fcb1c: fd0097e8    	str	d8, [sp, #0x128]
1060fcb20: d00bac29    	adrp	x9, 0x11d682000 <dyld_stub_binder+0x11d682000>
1060fcb24: 911b8129    	add	x9, x9, #0x6e0
1060fcb28: a91327e8    	stp	x8, x9, [sp, #0x130]
1060fcb2c: 910483e8    	add	x8, sp, #0x120
1060fcb30: 9100c100    	add	x0, x8, #0x30
1060fcb34: 910763e1    	add	x1, sp, #0x1d8
1060fcb38: 946ca990    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1060fcb3c: aa1603e0    	mov	x0, x22
1060fcb40: 946ca97e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060fcb44: f900a3f6    	str	x22, [sp, #0x140]
1060fcb48: f94022e0    	ldr	x0, [x23, #0x40]
1060fcb4c: 946ca97b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060fcb50: f900a7e0    	str	x0, [sp, #0x148]
1060fcb54: b9405ae8    	ldr	w8, [x23, #0x58]
1060fcb58: b9015be8    	str	w8, [sp, #0x158]
1060fcb5c: 910483e2    	add	x2, sp, #0x120
1060fcb60: aa1403e0    	mov	x0, x20
1060fcb64: aa1303e1    	mov	x1, x19
1060fcb68: 52800003    	mov	w3, #0x0                ; =0
1060fcb6c: 946ca974    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcb70: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fcb74: b98b7909    	ldrsw	x9, [x8, #0xb78]
1060fcb78: f8696b88    	ldr	x8, [x28, x9]
1060fcb7c: f8296b80    	str	x0, [x28, x9]
1060fcb80: aa0803e0    	mov	x0, x8
1060fcb84: 946ca974    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcb88: f00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fcb8c: f9455500    	ldr	x0, [x8, #0xaa8]
1060fcb90: 946ca972    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1060fcb94: f90037e0    	str	x0, [sp, #0x68]
1060fcb98: 4f00e400    	movi.16b	v0, #0x0
1060fcb9c: ad0703e0    	stp	q0, q0, [sp, #0xe0]
1060fcba0: ad0803e0    	stp	q0, q0, [sp, #0x100]
1060fcba4: f87a6b93    	ldr	x19, [x28, x26]
1060fcba8: aa1303e0    	mov	x0, x19
1060fcbac: 946ca963    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060fcbb0: f9435761    	ldr	x1, [x27, #0x6a8] ; countByEnumeratingWithState:objects:count:
1060fcbb4: 910383e2    	add	x2, sp, #0xe0
1060fcbb8: 910a03e3    	add	x3, sp, #0x280
1060fcbbc: f9001fe1    	str	x1, [sp, #0x38]
1060fcbc0: 52800204    	mov	w4, #0x10               ; =16
1060fcbc4: 946ca95e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcbc8: f90053e0    	str	x0, [sp, #0xa0]
1060fcbcc: b4001c80    	cbz	x0, 0x1060fcf5c <_Flutter_MMFoundation_BindContext+0x25d8b40>
1060fcbd0: f9407be8    	ldr	x8, [sp, #0xf0]
1060fcbd4: f9400108    	ldr	x8, [x8]
1060fcbd8: a905ffe8    	stp	x8, xzr, [sp, #0x58]
1060fcbdc: f9002bf3    	str	x19, [sp, #0x50]
1060fcbe0: d2800013    	mov	x19, #0x0               ; =0
1060fcbe4: d00cefc8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060fcbe8: f9419914    	ldr	x20, [x8, #0x330] ; voipsdkUsername
1060fcbec: b00cede8    	adrp	x8, 0x11feb9000 <dyld_stub_binder+0x11feb9000>
1060fcbf0: f9428909    	ldr	x9, [x8, #0x510] ; setOpenId:
1060fcbf4: 900cea08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1060fcbf8: f9471118    	ldr	x24, [x8, #0xe20] ; username
1060fcbfc: d00cefc8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060fcc00: f9418908    	ldr	x8, [x8, #0x310] ; setMUserName:
1060fcc04: a90927e8    	stp	x8, x9, [sp, #0x90]
1060fcc08: b00cebc8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
1060fcc0c: f9430d09    	ldr	x9, [x8, #0x618] ; callerUsername
1060fcc10: f00d0028    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1060fcc14: f943c919    	ldr	x25, [x8, #0x790] ; isEqualToString:
1060fcc18: d00cefc8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060fcc1c: f9418508    	ldr	x8, [x8, #0x308] ; setMStatus:
1060fcc20: a90827e8    	stp	x8, x9, [sp, #0x80]
1060fcc24: 900cee88    	adrp	x8, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
1060fcc28: f947c508    	ldr	x8, [x8, #0xf88] ; setMCreatedUserName:
1060fcc2c: f90027e8    	str	x8, [sp, #0x48]
1060fcc30: d00d0008    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1060fcc34: f946f516    	ldr	x22, [x8, #0xde8] ; addObject:
1060fcc38: f9407be8    	ldr	x8, [sp, #0xf0]
1060fcc3c: f9400108    	ldr	x8, [x8]
1060fcc40: f9402fe9    	ldr	x9, [sp, #0x58]
1060fcc44: eb09011f    	cmp	x8, x9
1060fcc48: 54000060    	b.eq	0x1060fcc54 <_Flutter_MMFoundation_BindContext+0x25d8838>
1060fcc4c: f9402be0    	ldr	x0, [sp, #0x50]
1060fcc50: 946ca940    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1060fcc54: f94077e8    	ldr	x8, [sp, #0xe8]
1060fcc58: f873791a    	ldr	x26, [x8, x19, lsl #3]
1060fcc5c: f00d0448    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1060fcc60: f943d500    	ldr	x0, [x8, #0x7a8]
1060fcc64: 946ca93d    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1060fcc68: aa0003f7    	mov	x23, x0
1060fcc6c: aa1a03e0    	mov	x0, x26
1060fcc70: aa1403e1    	mov	x1, x20
1060fcc74: 946ca932    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcc78: aa1d03fd    	mov	x29, x29
1060fcc7c: 946ca933    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fcc80: aa0003f5    	mov	x21, x0
1060fcc84: aa1703e0    	mov	x0, x23
1060fcc88: f9404fe1    	ldr	x1, [sp, #0x98]
1060fcc8c: aa1503e2    	mov	x2, x21
1060fcc90: 946ca92b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcc94: aa1503e0    	mov	x0, x21
1060fcc98: 946ca92f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcc9c: aa1a03e0    	mov	x0, x26
1060fcca0: aa1803e1    	mov	x1, x24
1060fcca4: 946ca926    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcca8: aa1d03fd    	mov	x29, x29
1060fccac: 946ca927    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fccb0: aa0003f5    	mov	x21, x0
1060fccb4: aa1703e0    	mov	x0, x23
1060fccb8: f9404be1    	ldr	x1, [sp, #0x90]
1060fccbc: aa1503e2    	mov	x2, x21
1060fccc0: 946ca91f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fccc4: aa1503e0    	mov	x0, x21
1060fccc8: 946ca923    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcccc: f00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fccd0: f9453515    	ldr	x21, [x8, #0xa68]
1060fccd4: aa1a03e0    	mov	x0, x26
1060fccd8: aa1803e1    	mov	x1, x24
1060fccdc: 946ca918    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcce0: aa1d03fd    	mov	x29, x29
1060fcce4: 946ca919    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fcce8: aa0003fb    	mov	x27, x0
1060fccec: aa1a03e0    	mov	x0, x26
1060fccf0: aa1403e1    	mov	x1, x20
1060fccf4: 946ca912    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fccf8: aa1d03fd    	mov	x29, x29
1060fccfc: 946ca913    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fcd00: aa0003fc    	mov	x28, x0
1060fcd04: a90083fb    	stp	x27, x0, [sp, #0x8]
1060fcd08: d00c3b88    	adrp	x8, 0x11e86e000 <dyld_stub_binder+0x11e86e000>
1060fcd0c: 913b2108    	add	x8, x8, #0xec8
1060fcd10: f90003e8    	str	x8, [sp]
1060fcd14: aa1503e0    	mov	x0, x21
1060fcd18: f9403fe1    	ldr	x1, [sp, #0x78]
1060fcd1c: 52800042    	mov	w2, #0x2                ; =2
1060fcd20: b00a9c23    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1060fcd24: 91056463    	add	x3, x3, #0x159
1060fcd28: 52800004    	mov	w4, #0x0                ; =0
1060fcd2c: 900ac445    	adrp	x5, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060fcd30: 912838a5    	add	x5, x5, #0xa0e
1060fcd34: 52824746    	mov	w6, #0x123a             ; =4666
1060fcd38: 900ac467    	adrp	x7, 0x11b988000 <dyld_stub_binder+0x11b988000>
1060fcd3c: 9101d4e7    	add	x7, x7, #0x75
1060fcd40: 946ca8ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcd44: aa1c03e0    	mov	x0, x28
1060fcd48: 946ca903    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcd4c: aa1b03e0    	mov	x0, x27
1060fcd50: 946ca901    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcd54: f9403be0    	ldr	x0, [sp, #0x70]
1060fcd58: f94047e1    	ldr	x1, [sp, #0x88]
1060fcd5c: 946ca8f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcd60: aa1d03fd    	mov	x29, x29
1060fcd64: 946ca8f9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fcd68: aa0003f5    	mov	x21, x0
1060fcd6c: aa1a03e0    	mov	x0, x26
1060fcd70: aa1803e1    	mov	x1, x24
1060fcd74: 946ca8f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcd78: aa1d03fd    	mov	x29, x29
1060fcd7c: 946ca8f3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fcd80: aa0003fb    	mov	x27, x0
1060fcd84: aa1503e0    	mov	x0, x21
1060fcd88: aa1903e1    	mov	x1, x25
1060fcd8c: aa1b03e2    	mov	x2, x27
1060fcd90: 946ca8eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcd94: aa0003fc    	mov	x28, x0
1060fcd98: aa1b03e0    	mov	x0, x27
1060fcd9c: 946ca8ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcda0: aa1503e0    	mov	x0, x21
1060fcda4: 946ca8ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcda8: aa1703e0    	mov	x0, x23
1060fcdac: 340003fc    	cbz	w28, 0x1060fce28 <_Flutter_MMFoundation_BindContext+0x25d8a0c>
1060fcdb0: f94043e1    	ldr	x1, [sp, #0x80]
1060fcdb4: 52800022    	mov	w2, #0x1                ; =1
1060fcdb8: 946ca8e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcdbc: aa1a03e0    	mov	x0, x26
1060fcdc0: aa1803e1    	mov	x1, x24
1060fcdc4: 946ca8de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcdc8: aa1d03fd    	mov	x29, x29
1060fcdcc: 946ca8df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fcdd0: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fcdd4: b98a4509    	ldrsw	x9, [x8, #0xa44]
1060fcdd8: f94057fc    	ldr	x28, [sp, #0xa8]
1060fcddc: f8696b88    	ldr	x8, [x28, x9]
1060fcde0: f8296b80    	str	x0, [x28, x9]
1060fcde4: aa0803e0    	mov	x0, x8
1060fcde8: 946ca8db    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcdec: f94023e8    	ldr	x8, [sp, #0x40]
1060fcdf0: f8686b95    	ldr	x21, [x28, x8]
1060fcdf4: aa1a03e0    	mov	x0, x26
1060fcdf8: aa1803e1    	mov	x1, x24
1060fcdfc: 946ca8d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fce00: aa1d03fd    	mov	x29, x29
1060fce04: 946ca8d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fce08: aa0003fb    	mov	x27, x0
1060fce0c: aa1503e0    	mov	x0, x21
1060fce10: f94027e1    	ldr	x1, [sp, #0x48]
1060fce14: aa1b03e2    	mov	x2, x27
1060fce18: 946ca8c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fce1c: aa1b03e0    	mov	x0, x27
1060fce20: 946ca8cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fce24: 14000005    	b	0x1060fce38 <_Flutter_MMFoundation_BindContext+0x25d8a1c>
1060fce28: f94043e1    	ldr	x1, [sp, #0x80]
1060fce2c: 52800042    	mov	w2, #0x2                ; =2
1060fce30: 946ca8c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fce34: f94057fc    	ldr	x28, [sp, #0xa8]
1060fce38: aa1a03e0    	mov	x0, x26
1060fce3c: aa1803e1    	mov	x1, x24
1060fce40: 946ca8bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fce44: aa1d03fd    	mov	x29, x29
1060fce48: 946ca8c0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fce4c: aa0003f5    	mov	x21, x0
1060fce50: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fce54: b98a0108    	ldrsw	x8, [x8, #0xa00]
1060fce58: f8686b82    	ldr	x2, [x28, x8]
1060fce5c: aa1903e1    	mov	x1, x25
1060fce60: 946ca8b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fce64: aa0003fa    	mov	x26, x0
1060fce68: aa1503e0    	mov	x0, x21
1060fce6c: 946ca8ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fce70: 340000da    	cbz	w26, 0x1060fce88 <_Flutter_MMFoundation_BindContext+0x25d8a6c>
1060fce74: aa1703e0    	mov	x0, x23
1060fce78: 946ca8b0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060fce7c: f94033e0    	ldr	x0, [sp, #0x60]
1060fce80: 946ca8b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fce84: f90033f7    	str	x23, [sp, #0x60]
1060fce88: f94037e0    	ldr	x0, [sp, #0x68]
1060fce8c: aa1603e1    	mov	x1, x22
1060fce90: aa1703e2    	mov	x2, x23
1060fce94: 946ca8aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fce98: aa1703e0    	mov	x0, x23
1060fce9c: 946ca8ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcea0: 91000673    	add	x19, x19, #0x1
1060fcea4: f94053e8    	ldr	x8, [sp, #0xa0]
1060fcea8: eb13011f    	cmp	x8, x19
1060fceac: 54ffec61    	b.ne	0x1060fcc38 <_Flutter_MMFoundation_BindContext+0x25d881c>
1060fceb0: 910383e2    	add	x2, sp, #0xe0
1060fceb4: 910a03e3    	add	x3, sp, #0x280
1060fceb8: f9402bf3    	ldr	x19, [sp, #0x50]
1060fcebc: aa1303e0    	mov	x0, x19
1060fcec0: f9401fe1    	ldr	x1, [sp, #0x38]
1060fcec4: 52800204    	mov	w4, #0x10               ; =16
1060fcec8: 946ca89d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcecc: f90053e0    	str	x0, [sp, #0xa0]
1060fced0: b5ffe880    	cbnz	x0, 0x1060fcbe0 <_Flutter_MMFoundation_BindContext+0x25d87c4>
1060fced4: aa1303e0    	mov	x0, x19
1060fced8: 946ca89f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcedc: f94033f4    	ldr	x20, [sp, #0x60]
1060fcee0: b4000474    	cbz	x20, 0x1060fcf6c <_Flutter_MMFoundation_BindContext+0x25d8b50>
1060fcee4: f00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fcee8: b98a4513    	ldrsw	x19, [x8, #0xa44]
1060fceec: f8736b82    	ldr	x2, [x28, x19]
1060fcef0: 910663f8    	add	x24, sp, #0x198
1060fcef4: d00ba799    	adrp	x25, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1060fcef8: f947e339    	ldr	x25, [x25, #0xfc0]
1060fcefc: b40002c2    	cbz	x2, 0x1060fcf54 <_Flutter_MMFoundation_BindContext+0x25d8b38>
1060fcf00: d00cefc8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060fcf04: f9419501    	ldr	x1, [x8, #0x328] ; setMInviteUserName:
1060fcf08: aa1403e0    	mov	x0, x20
1060fcf0c: 946ca88c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcf10: f00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fcf14: f9453500    	ldr	x0, [x8, #0xa68]
1060fcf18: f8736b88    	ldr	x8, [x28, x19]
1060fcf1c: f00c3b89    	adrp	x9, 0x11e86f000 <dyld_stub_binder+0x11e86f000>
1060fcf20: 9107a129    	add	x9, x9, #0x1e8
1060fcf24: a90023e9    	stp	x9, x8, [sp]
1060fcf28: b00a9c23    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1060fcf2c: 91056463    	add	x3, x3, #0x159
1060fcf30: 900ac445    	adrp	x5, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060fcf34: 912838a5    	add	x5, x5, #0xa0e
1060fcf38: 900ac467    	adrp	x7, 0x11b988000 <dyld_stub_binder+0x11b988000>
1060fcf3c: 9101d4e7    	add	x7, x7, #0x75
1060fcf40: f9403fe1    	ldr	x1, [sp, #0x78]
1060fcf44: 52800042    	mov	w2, #0x2                ; =2
1060fcf48: 52800004    	mov	w4, #0x0                ; =0
1060fcf4c: 52824926    	mov	w6, #0x1249             ; =4681
1060fcf50: 946ca87b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcf54: f9403bf6    	ldr	x22, [sp, #0x70]
1060fcf58: 14000009    	b	0x1060fcf7c <_Flutter_MMFoundation_BindContext+0x25d8b60>
1060fcf5c: aa1303e0    	mov	x0, x19
1060fcf60: 946ca87d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcf64: d2800014    	mov	x20, #0x0               ; =0
1060fcf68: 14000005    	b	0x1060fcf7c <_Flutter_MMFoundation_BindContext+0x25d8b60>
1060fcf6c: f9403bf6    	ldr	x22, [sp, #0x70]
1060fcf70: 910663f8    	add	x24, sp, #0x198
1060fcf74: d00ba799    	adrp	x25, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1060fcf78: f947e339    	ldr	x25, [x25, #0xfc0]
1060fcf7c: f9005bf9    	str	x25, [sp, #0xb0]
1060fcf80: fd005fe8    	str	d8, [sp, #0xb8]
1060fcf84: b0000008    	adrp	x8, 0x1060fd000 <_Flutter_MMFoundation_BindContext+0x25d8be4>
1060fcf88: 91231108    	add	x8, x8, #0x8c4
1060fcf8c: f00ba7c9    	adrp	x9, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
1060fcf90: 91044129    	add	x9, x9, #0x110
1060fcf94: a90c27e8    	stp	x8, x9, [sp, #0xc0]
1060fcf98: f94037f3    	ldr	x19, [sp, #0x68]
1060fcf9c: a90d4ffc    	stp	x28, x19, [sp, #0xd0]
1060fcfa0: aa1303e0    	mov	x0, x19
1060fcfa4: 946ca865    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060fcfa8: f00ba780    	adrp	x0, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1060fcfac: f9408c00    	ldr	x0, [x0, #0x118]
1060fcfb0: 9102c3e1    	add	x1, sp, #0xb0
1060fcfb4: 946c409b    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
1060fcfb8: f00d03e8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1060fcfbc: f9413500    	ldr	x0, [x8, #0x268]
1060fcfc0: d00cefc8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1060fcfc4: f943a101    	ldr	x1, [x8, #0x740] ; ack
1060fcfc8: 946ca85d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fcfcc: f9406fe0    	ldr	x0, [sp, #0xd8]
1060fcfd0: 946ca861    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcfd4: aa1303e0    	mov	x0, x19
1060fcfd8: 946ca85f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcfdc: aa1403e0    	mov	x0, x20
1060fcfe0: 946ca85d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcfe4: f940a7e0    	ldr	x0, [sp, #0x148]
1060fcfe8: 946ca85b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcfec: f940a3e0    	ldr	x0, [sp, #0x140]
1060fcff0: 946ca859    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fcff4: 910483e8    	add	x8, sp, #0x120
1060fcff8: 9100c100    	add	x0, x8, #0x30
1060fcffc: 946ca865    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1060fd000: f940c3e0    	ldr	x0, [sp, #0x180]
1060fd004: 946ca854    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fd008: 910583e8    	add	x8, sp, #0x160
1060fd00c: 9100a100    	add	x0, x8, #0x28
1060fd010: 946ca860    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1060fd014: f940e3e0    	ldr	x0, [sp, #0x1c0]
1060fd018: 946ca84f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fd01c: f940dfe0    	ldr	x0, [sp, #0x1b8]
1060fd020: 946ca84d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fd024: 9100c300    	add	x0, x24, #0x30
1060fd028: 946ca85a    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1060fd02c: 910763e0    	add	x0, sp, #0x1d8
1060fd030: 946ca858    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1060fd034: 1400002a    	b	0x1060fd0dc <_Flutter_MMFoundation_BindContext+0x25d8cc0>
1060fd038: d00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fd03c: f9453500    	ldr	x0, [x8, #0xa68]
1060fd040: d00c2b48    	adrp	x8, 0x11e667000 <dyld_stub_binder+0x11e667000>
1060fd044: 9125a108    	add	x8, x8, #0x968
1060fd048: f90003e8    	str	x8, [sp]
1060fd04c: 900a9c23    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1060fd050: 91056463    	add	x3, x3, #0x159
1060fd054: f00ac425    	adrp	x5, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060fd058: 912838a5    	add	x5, x5, #0xa0e
1060fd05c: d00ac447    	adrp	x7, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060fd060: 913604e7    	add	x7, x7, #0xd81
1060fd064: f9403fe1    	ldr	x1, [sp, #0x78]
1060fd068: 52800042    	mov	w2, #0x2                ; =2
1060fd06c: 52800004    	mov	w4, #0x0                ; =0
1060fd070: 528238e6    	mov	w6, #0x11c7             ; =4551
1060fd074: 946ca832    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fd078: d00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fd07c: b98a0908    	ldrsw	x8, [x8, #0xa08]
1060fd080: f94057fc    	ldr	x28, [sp, #0xa8]
1060fd084: f8686b93    	ldr	x19, [x28, x8]
1060fd088: b00ba788    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1060fd08c: f947e108    	ldr	x8, [x8, #0xfc0]
1060fd090: f9012be8    	str	x8, [sp, #0x250]
1060fd094: 90096428    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1060fd098: fd41c100    	ldr	d0, [x8, #0x380]
1060fd09c: 90000008    	adrp	x8, 0x1060fd000 <_Flutter_MMFoundation_BindContext+0x25d8be4>
1060fd0a0: 9104b108    	add	x8, x8, #0x12c
1060fd0a4: fd012fe0    	str	d0, [sp, #0x258]
1060fd0a8: d00ba7c9    	adrp	x9, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
1060fd0ac: 91044129    	add	x9, x9, #0x110
1060fd0b0: f90133e8    	str	x8, [sp, #0x260]
1060fd0b4: f90137e9    	str	x9, [sp, #0x268]
1060fd0b8: f9013bfc    	str	x28, [sp, #0x270]
1060fd0bc: aa1603e0    	mov	x0, x22
1060fd0c0: 946ca81e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060fd0c4: f9013ff6    	str	x22, [sp, #0x278]
1060fd0c8: 910943e1    	add	x1, sp, #0x250
1060fd0cc: aa1303e0    	mov	x0, x19
1060fd0d0: 946c4054    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
1060fd0d4: f9413fe0    	ldr	x0, [sp, #0x278]
1060fd0d8: 946ca81f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fd0dc: aa1603e0    	mov	x0, x22
1060fd0e0: 946ca81d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fd0e4: aa1c03e0    	mov	x0, x28
1060fd0e8: 946ca81b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fd0ec: f85903a8    	ldur	x8, [x29, #-0x70]
1060fd0f0: d00ba789    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1060fd0f4: f9405929    	ldr	x9, [x9, #0xb0]
1060fd0f8: f9400129    	ldr	x9, [x9]
1060fd0fc: eb08013f    	cmp	x9, x8
1060fd100: 54000141    	b.ne	0x1060fd128 <_Flutter_MMFoundation_BindContext+0x25d8d0c>
1060fd104: 910e43ff    	add	sp, sp, #0x390
1060fd108: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1060fd10c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1060fd110: a94457f6    	ldp	x22, x21, [sp, #0x40]
1060fd114: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1060fd118: a94267fa    	ldp	x26, x25, [sp, #0x20]
1060fd11c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
1060fd120: 6cc723e9    	ldp	d9, d8, [sp], #0x70
1060fd124: d65f03c0    	ret
1060fd128: 946ca813    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
