
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10639dfcc: d10203ff    	sub	sp, sp, #0x80
10639dfd0: a9026ffc    	stp	x28, x27, [sp, #0x20]
10639dfd4: a90367fa    	stp	x26, x25, [sp, #0x30]
10639dfd8: a9045ff8    	stp	x24, x23, [sp, #0x40]
10639dfdc: a90557f6    	stp	x22, x21, [sp, #0x50]
10639dfe0: a9064ff4    	stp	x20, x19, [sp, #0x60]
10639dfe4: a9077bfd    	stp	x29, x30, [sp, #0x70]
10639dfe8: 9101c3fd    	add	x29, sp, #0x70
10639dfec: aa0303f7    	mov	x23, x3
10639dff0: aa0203f3    	mov	x19, x2
10639dff4: d00d4528    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10639dff8: 52800029    	mov	w9, #0x1                ; =1
10639dffc: 39373d09    	strb	w9, [x8, #0xdcf]
10639e000: b00ceebc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10639e004: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
10639e008: d00ceb08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10639e00c: f944e916    	ldr	x22, [x8, #0x9d0] ; selector=currentContext
10639e010: aa1603e1    	mov	x1, x22
10639e014: 9462244a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e018: aa1d03fd    	mov	x29, x29
10639e01c: 9462244b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e020: aa0003f8    	mov	x24, x0
10639e024: b00ceefb    	adrp	x27, 0x12017b000 <dyld_stub_binder+0x12017b000>
10639e028: f940ff60    	ldr	x0, [x27, #0x1f8] ; class=VoIPilinkMgr
10639e02c: b00ceb08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10639e030: f947ad15    	ldr	x21, [x8, #0xf58] ; selector=class
10639e034: aa1503e1    	mov	x1, x21
10639e038: 94622441    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e03c: aa0003e2    	mov	x2, x0
10639e040: f00cd4c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10639e044: f9464114    	ldr	x20, [x8, #0xc80] ; selector=getService:
10639e048: aa1803e0    	mov	x0, x24
10639e04c: aa1403e1    	mov	x1, x20
10639e050: 9462243b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e054: aa1d03fd    	mov	x29, x29
10639e058: 9462243c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e05c: aa0003f9    	mov	x25, x0
10639e060: f00cd728    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
10639e064: f9458501    	ldr	x1, [x8, #0xb08] ; selector=getIfThisTalkIlink
10639e068: 94622435    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e06c: aa0003fa    	mov	x26, x0
10639e070: aa1903e0    	mov	x0, x25
10639e074: 94622438    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e078: aa1803e0    	mov	x0, x24
10639e07c: 94622436    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e080: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
10639e084: aa1603e1    	mov	x1, x22
10639e088: 9462242d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e08c: aa1d03fd    	mov	x29, x29
10639e090: 9462242e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e094: aa0003f9    	mov	x25, x0
10639e098: 340005da    	cbz	w26, 0x10639e150 <_Flutter_MMFoundation_BindContext+0x2879d34>
10639e09c: f940ff60    	ldr	x0, [x27, #0x1f8] ; class=VoIPilinkMgr
10639e0a0: aa1503e1    	mov	x1, x21
10639e0a4: 94622426    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e0a8: aa0003e2    	mov	x2, x0
10639e0ac: aa1903e0    	mov	x0, x25
10639e0b0: aa1403e1    	mov	x1, x20
10639e0b4: 94622422    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e0b8: aa1d03fd    	mov	x29, x29
10639e0bc: 94622423    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e0c0: aa0003f7    	mov	x23, x0
10639e0c4: 900cdac8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
10639e0c8: f9402918    	ldr	x24, [x8, #0x50] ; selector=mRoomId
10639e0cc: aa1803e1    	mov	x1, x24
10639e0d0: 9462241b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e0d4: aa0003fa    	mov	x26, x0
10639e0d8: aa1703e0    	mov	x0, x23
10639e0dc: 9462241e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e0e0: aa1903e0    	mov	x0, x25
10639e0e4: 9462241c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e0e8: eb13035f    	cmp	x26, x19
10639e0ec: 540009e1    	b.ne	0x10639e228 <_Flutter_MMFoundation_BindContext+0x2879e0c>
10639e0f0: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
10639e0f4: aa1603e1    	mov	x1, x22
10639e0f8: 94622411    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e0fc: aa1d03fd    	mov	x29, x29
10639e100: 94622412    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e104: aa0003f6    	mov	x22, x0
10639e108: f940ff60    	ldr	x0, [x27, #0x1f8] ; class=VoIPilinkMgr
10639e10c: aa1503e1    	mov	x1, x21
10639e110: 9462240b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e114: aa0003e2    	mov	x2, x0
10639e118: aa1603e0    	mov	x0, x22
10639e11c: aa1403e1    	mov	x1, x20
10639e120: 94622407    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e124: aa1d03fd    	mov	x29, x29
10639e128: 94622408    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e12c: aa0003f4    	mov	x20, x0
10639e130: f00cdfa8    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
10639e134: f9419d01    	ldr	x1, [x8, #0x338] ; selector=hangupWithRoomID:
10639e138: aa1303e2    	mov	x2, x19
10639e13c: 94622400    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e140: aa1403e0    	mov	x0, x20
10639e144: 94622404    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e148: aa1603e0    	mov	x0, x22
10639e14c: 1400002f    	b	0x10639e208 <_Flutter_MMFoundation_BindContext+0x2879dec>
10639e150: f9000ff7    	str	x23, [sp, #0x18]
10639e154: b00ceeb7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10639e158: f9472ee0    	ldr	x0, [x23, #0xe58] ; class=VOIPMgr
10639e15c: aa1503e1    	mov	x1, x21
10639e160: 946223f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e164: aa0003e2    	mov	x2, x0
10639e168: aa1903e0    	mov	x0, x25
10639e16c: aa1403e1    	mov	x1, x20
10639e170: 946223f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e174: aa1d03fd    	mov	x29, x29
10639e178: 946223f4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e17c: aa0003fa    	mov	x26, x0
10639e180: d00ce008    	adrp	x8, 0x11ffa0000 <dyld_stub_binder+0x11ffa0000>
10639e184: f945e918    	ldr	x24, [x8, #0xbd0] ; selector=getRoomId
10639e188: aa1803e1    	mov	x1, x24
10639e18c: 946223ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e190: aa0003fb    	mov	x27, x0
10639e194: aa1a03e0    	mov	x0, x26
10639e198: 946223ef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e19c: aa1903e0    	mov	x0, x25
10639e1a0: 946223ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e1a4: eb13037f    	cmp	x27, x19
10639e1a8: 54000c01    	b.ne	0x10639e328 <_Flutter_MMFoundation_BindContext+0x2879f0c>
10639e1ac: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
10639e1b0: aa1603e1    	mov	x1, x22
10639e1b4: 946223e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e1b8: aa1d03fd    	mov	x29, x29
10639e1bc: 946223e3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e1c0: aa0003f3    	mov	x19, x0
10639e1c4: f9472ee0    	ldr	x0, [x23, #0xe58] ; class=VOIPMgr
10639e1c8: aa1503e1    	mov	x1, x21
10639e1cc: 946223dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e1d0: aa0003e2    	mov	x2, x0
10639e1d4: aa1303e0    	mov	x0, x19
10639e1d8: aa1403e1    	mov	x1, x20
10639e1dc: 946223d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e1e0: aa1d03fd    	mov	x29, x29
10639e1e4: 946223d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e1e8: aa0003f4    	mov	x20, x0
10639e1ec: 900ce168    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
10639e1f0: f9439d01    	ldr	x1, [x8, #0x738] ; selector=HangupWithReason:
10639e1f4: f9400fe2    	ldr	x2, [sp, #0x18]
10639e1f8: 946223d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e1fc: aa1403e0    	mov	x0, x20
10639e200: 946223d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e204: aa1303e0    	mov	x0, x19
10639e208: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10639e20c: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10639e210: a94557f6    	ldp	x22, x21, [sp, #0x50]
10639e214: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10639e218: a94367fa    	ldp	x26, x25, [sp, #0x30]
10639e21c: a9426ffc    	ldp	x28, x27, [sp, #0x20]
10639e220: 910203ff    	add	sp, sp, #0x80
10639e224: 146223cc    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e228: 52800060    	mov	w0, #0x3                ; =3
10639e22c: 9461bc05    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10639e230: 34001160    	cbz	w0, 0x10639e45c <_Flutter_MMFoundation_BindContext+0x287a040>
10639e234: 946223db    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10639e238: aa0003f7    	mov	x23, x0
10639e23c: b00ceeba    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
10639e240: f9454740    	ldr	x0, [x26, #0xa88]
10639e244: 946223c7    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10639e248: aa0003f9    	mov	x25, x0
10639e24c: f945475a    	ldr	x26, [x26, #0xa88]
10639e250: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
10639e254: aa1603e1    	mov	x1, x22
10639e258: 946223b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e25c: aa1d03fd    	mov	x29, x29
10639e260: 946223ba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e264: aa0003f6    	mov	x22, x0
10639e268: f940ff60    	ldr	x0, [x27, #0x1f8] ; class=VoIPilinkMgr
10639e26c: aa1503e1    	mov	x1, x21
10639e270: 946223b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e274: aa0003e2    	mov	x2, x0
10639e278: aa1603e0    	mov	x0, x22
10639e27c: aa1403e1    	mov	x1, x20
10639e280: 946223af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e284: aa1d03fd    	mov	x29, x29
10639e288: 946223b0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e28c: aa0003f4    	mov	x20, x0
10639e290: aa1803e1    	mov	x1, x24
10639e294: 946223aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e298: 900ceb68    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10639e29c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10639e2a0: a900fff3    	stp	x19, xzr, [sp, #0x8]
10639e2a4: f90003e0    	str	x0, [sp]
10639e2a8: b00c2722    	adrp	x2, 0x11e883000 <dyld_stub_binder+0x11e883000>
10639e2ac: 910e2042    	add	x2, x2, #0x388 ; cfstring='HangupWithRoomID mismatch, ilink current:%llu, target:%llu'
10639e2b0: aa1a03e0    	mov	x0, x26
10639e2b4: 946223a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e2b8: aa1d03fd    	mov	x29, x29
10639e2bc: 946223a3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e2c0: aa0003f3    	mov	x19, x0
10639e2c4: 900ceb28    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10639e2c8: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10639e2cc: d00c1ea8    	adrp	x8, 0x11e774000 <dyld_stub_binder+0x11e774000>
10639e2d0: 910ba108    	add	x8, x8, #0x2e8 ; cfstring='WARNING: '
10639e2d4: a90003e8    	stp	x8, x0, [sp]
10639e2d8: b00c07e2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10639e2dc: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10639e2e0: aa1903e0    	mov	x0, x25
10639e2e4: 94622396    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e2e8: aa0003f5    	mov	x21, x0
10639e2ec: aa1303e0    	mov	x0, x19
10639e2f0: 94622399    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e2f4: aa1403e0    	mov	x0, x20
10639e2f8: 94622397    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e2fc: aa1603e0    	mov	x0, x22
10639e300: 94622395    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e304: f00a73a1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
10639e308: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
10639e30c: d00ab082    	adrp	x2, 0x11b9b0000 <dyld_stub_binder+0x11b9b0000>
10639e310: 91370042    	add	x2, x2, #0xdc0 ; cstring='VoipUIManager.mm'
10639e314: f00ab084    	adrp	x4, 0x11b9b1000 <dyld_stub_binder+0x11b9b1000>
10639e318: 912cdc84    	add	x4, x4, #0xb37 ; cstring='-[VoipUIManager HangupWithRoomID:reason:]'
10639e31c: 52800060    	mov	w0, #0x3                ; =3
10639e320: 5280e3a3    	mov	w3, #0x71d              ; =1821
10639e324: 14000041    	b	0x10639e428 <_Flutter_MMFoundation_BindContext+0x287a00c>
10639e328: aa1703fb    	mov	x27, x23
10639e32c: 52800060    	mov	w0, #0x3                ; =3
10639e330: 9461bbc4    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10639e334: 34000940    	cbz	w0, 0x10639e45c <_Flutter_MMFoundation_BindContext+0x287a040>
10639e338: 9462239a    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10639e33c: aa0003f7    	mov	x23, x0
10639e340: b00ceeba    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
10639e344: f9454740    	ldr	x0, [x26, #0xa88]
10639e348: 94622386    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10639e34c: aa0003f9    	mov	x25, x0
10639e350: f945475a    	ldr	x26, [x26, #0xa88]
10639e354: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
10639e358: aa1603e1    	mov	x1, x22
10639e35c: 94622378    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e360: aa1d03fd    	mov	x29, x29
10639e364: 94622379    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e368: aa0003f6    	mov	x22, x0
10639e36c: f9472f60    	ldr	x0, [x27, #0xe58] ; class=RegularUtil
10639e370: aa1503e1    	mov	x1, x21
10639e374: 94622372    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e378: aa0003e2    	mov	x2, x0
10639e37c: aa1603e0    	mov	x0, x22
10639e380: aa1403e1    	mov	x1, x20
10639e384: 9462236e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e388: aa1d03fd    	mov	x29, x29
10639e38c: 9462236f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e390: aa0003f4    	mov	x20, x0
10639e394: aa1803e1    	mov	x1, x24
10639e398: 94622369    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e39c: 900ceb68    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10639e3a0: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10639e3a4: a900fff3    	stp	x19, xzr, [sp, #0x8]
10639e3a8: f90003e0    	str	x0, [sp]
10639e3ac: b00c2722    	adrp	x2, 0x11e883000 <dyld_stub_binder+0x11e883000>
10639e3b0: 910ea042    	add	x2, x2, #0x3a8 ; cfstring='HangupWithRoomID mismatch, voip current:%llu, target:%llu'
10639e3b4: aa1a03e0    	mov	x0, x26
10639e3b8: 94622361    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e3bc: aa1d03fd    	mov	x29, x29
10639e3c0: 94622362    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639e3c4: aa0003f3    	mov	x19, x0
10639e3c8: 900ceb28    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10639e3cc: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10639e3d0: d00c1ea8    	adrp	x8, 0x11e774000 <dyld_stub_binder+0x11e774000>
10639e3d4: 910ba108    	add	x8, x8, #0x2e8 ; cfstring='WARNING: '
10639e3d8: a90003e8    	stp	x8, x0, [sp]
10639e3dc: b00c07e2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10639e3e0: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10639e3e4: aa1903e0    	mov	x0, x25
10639e3e8: 94622355    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639e3ec: aa0003f5    	mov	x21, x0
10639e3f0: aa1303e0    	mov	x0, x19
10639e3f4: 94622358    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e3f8: aa1403e0    	mov	x0, x20
10639e3fc: 94622356    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e400: aa1603e0    	mov	x0, x22
10639e404: 94622354    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e408: f00a73a1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
10639e40c: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
10639e410: d00ab082    	adrp	x2, 0x11b9b0000 <dyld_stub_binder+0x11b9b0000>
10639e414: 91370042    	add	x2, x2, #0xdc0 ; cstring='VoipUIManager.mm'
10639e418: f00ab084    	adrp	x4, 0x11b9b1000 <dyld_stub_binder+0x11b9b1000>
10639e41c: 912cdc84    	add	x4, x4, #0xb37 ; cstring='-[VoipUIManager HangupWithRoomID:reason:]'
10639e420: 52800060    	mov	w0, #0x3                ; =3
10639e424: 5280e463    	mov	w3, #0x723              ; =1827
10639e428: aa1503e5    	mov	x5, x21
10639e42c: 9461bb86    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10639e430: aa1503e0    	mov	x0, x21
10639e434: 94622348    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639e438: aa1703e0    	mov	x0, x23
10639e43c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10639e440: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10639e444: a94557f6    	ldp	x22, x21, [sp, #0x50]
10639e448: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10639e44c: a94367fa    	ldp	x26, x25, [sp, #0x30]
10639e450: a9426ffc    	ldp	x28, x27, [sp, #0x20]
10639e454: 910203ff    	add	sp, sp, #0x80
10639e458: 14622355    	b	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10639e45c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10639e460: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10639e464: a94557f6    	ldp	x22, x21, [sp, #0x50]
10639e468: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10639e46c: a94367fa    	ldp	x26, x25, [sp, #0x30]
10639e470: a9426ffc    	ldp	x28, x27, [sp, #0x20]
10639e474: 910203ff    	add	sp, sp, #0x80
10639e478: d65f03c0    	ret
