
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10104e014: d10283ff    	sub	sp, sp, #0xa0
10104e018: 6d022beb    	stp	d11, d10, [sp, #0x20]
10104e01c: 6d0323e9    	stp	d9, d8, [sp, #0x30]
10104e020: a9046ffc    	stp	x28, x27, [sp, #0x40]
10104e024: a90567fa    	stp	x26, x25, [sp, #0x50]
10104e028: a9065ff8    	stp	x24, x23, [sp, #0x60]
10104e02c: a90757f6    	stp	x22, x21, [sp, #0x70]
10104e030: a9084ff4    	stp	x20, x19, [sp, #0x80]
10104e034: a9097bfd    	stp	x29, x30, [sp, #0x90]
10104e038: 910243fd    	add	x29, sp, #0x90
10104e03c: 4ea11c28    	mov.16b	v8, v1
10104e040: 4ea01c09    	mov.16b	v9, v0
10104e044: aa0003f3    	mov	x19, x0
10104e048: b00f37a8    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
10104e04c: 52800029    	mov	w9, #0x1                ; =1
10104e050: 3928d509    	strb	w9, [x8, #0xa35]
10104e054: 900ee988    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10104e058: 912ea108    	add	x8, x8, #0xba8
10104e05c: b9800108    	ldrsw	x8, [x8] ; ivar: BaseMessageViewModel.m_contentViewSize offset=56
10104e060: 8b080017    	add	x23, x0, x8
10104e064: 6d4006e0    	ldp	d0, d1, [x23]
10104e068: 900e37e8    	adrp	x8, 0x11d74a000 <dyld_stub_binder+0x11d74a000>
10104e06c: f9466108    	ldr	x8, [x8, #0xcc0]
10104e070: 6d400d02    	ldp	d2, d3, [x8]
10104e074: 1e622000    	fcmp	d0, d2
10104e078: 1e630420    	fccmp	d1, d3, #0x0, eq
10104e07c: b00ecc14    	adrp	x20, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10104e080: b00ecc19    	adrp	x25, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10104e084: 540018a1    	b.ne	0x10104e398 <__text+0x1046398>
10104e088: 900ee988    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10104e08c: 912e7108    	add	x8, x8, #0xb9c
10104e090: b9800108    	ldrsw	x8, [x8] ; ivar: BaseMessageViewModel.m_isChatRoomMessageUnsafe offset=88
10104e094: 38686a68    	ldrb	w8, [x19, x8]
10104e098: 7100051f    	cmp	w8, #0x1
10104e09c: 54001381    	b.ne	0x10104e30c <__text+0x104630c>
10104e0a0: b00ee628    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10104e0a4: f9442918    	ldr	x24, [x8, #0x850]
10104e0a8: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e0ac: f943c100    	ldr	x0, [x8, #0x780]
10104e0b0: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e0b4: f9440114    	ldr	x20, [x8, #0x800] ; selector: currentContext
10104e0b8: aa1403e1    	mov	x1, x20
10104e0bc: 95af66ea    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e0c0: aa1d03fd    	mov	x29, x29
10104e0c4: 95af66ef    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e0c8: aa0003fc    	mov	x28, x0
10104e0cc: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e0d0: f9440100    	ldr	x0, [x8, #0x800]
10104e0d4: 900ee2c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10104e0d8: f9428515    	ldr	x21, [x8, #0x508] ; selector: class
10104e0dc: aa1503e1    	mov	x1, x21
10104e0e0: 95af66e1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e0e4: aa0003e2    	mov	x2, x0
10104e0e8: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e0ec: f9452116    	ldr	x22, [x8, #0xa40] ; selector: getService:
10104e0f0: aa1c03e0    	mov	x0, x28
10104e0f4: aa1603e1    	mov	x1, x22
10104e0f8: 95af66db    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e0fc: aa1d03fd    	mov	x29, x29
10104e100: 95af66e0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e104: aa0003f9    	mov	x25, x0
10104e108: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e10c: f9452501    	ldr	x1, [x8, #0xa48] ; selector: getStringForCurLanguage:
10104e110: d00dffa2    	adrp	x2, 0x11d044000 <dyld_stub_binder+0x11d044000>
10104e114: 913de042    	add	x2, x2, #0xf78 ; CFString: CrashProtected_WordingForMessageWrap
10104e118: 95af66d3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e11c: aa1d03fd    	mov	x29, x29
10104e120: 95af66d8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e124: aa0003fa    	mov	x26, x0
10104e128: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e12c: f943f100    	ldr	x0, [x8, #0x7e0]
10104e130: f00ecbe8    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
10104e134: f9478901    	ldr	x1, [x8, #0xf10] ; selector: systemFont
10104e138: 95af66cb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e13c: aa1d03fd    	mov	x29, x29
10104e140: 95af66d0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e144: aa0003fb    	mov	x27, x0
10104e148: b00ee628    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10104e14c: f942f500    	ldr	x0, [x8, #0x5e8]
10104e150: f00ece48    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
10104e154: f9475d01    	ldr	x1, [x8, #0xeb8] ; selector: getTextMessageNodeWidth:
10104e158: aa1303e2    	mov	x2, x19
10104e15c: 95af66c2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e160: 900ece68    	adrp	x8, 0x11ea1a000 <dyld_stub_binder+0x11ea1a000>
10104e164: f941ed01    	ldr	x1, [x8, #0x3d8] ; selector: sizeForContent:font:width:parserType:delegate:
10104e168: aa1803e0    	mov	x0, x24
10104e16c: aa1a03e2    	mov	x2, x26
10104e170: aa1b03e3    	mov	x3, x27
10104e174: 52800024    	mov	w4, #0x1                ; =1
10104e178: d2800005    	mov	x5, #0x0                ; =0
10104e17c: 95af66ba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e180: 4ea01c08    	mov.16b	v8, v0
10104e184: 4ea11c29    	mov.16b	v9, v1
10104e188: aa1b03e0    	mov	x0, x27
10104e18c: 95af66b9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e190: aa1a03e0    	mov	x0, x26
10104e194: 95af66b7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e198: aa1903e0    	mov	x0, x25
10104e19c: 95af66b5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e1a0: aa1c03e0    	mov	x0, x28
10104e1a4: 95af66b3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e1a8: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e1ac: f9461d1a    	ldr	x26, [x8, #0xc38]
10104e1b0: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e1b4: f943c100    	ldr	x0, [x8, #0x780]
10104e1b8: aa1403e1    	mov	x1, x20
10104e1bc: 95af66aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e1c0: aa1d03fd    	mov	x29, x29
10104e1c4: 95af66af    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e1c8: aa0003f8    	mov	x24, x0
10104e1cc: f9000be0    	str	x0, [sp, #0x10]
10104e1d0: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e1d4: f9462100    	ldr	x0, [x8, #0xc40]
10104e1d8: aa1503e1    	mov	x1, x21
10104e1dc: 95af66a2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e1e0: aa0003e2    	mov	x2, x0
10104e1e4: aa1803e0    	mov	x0, x24
10104e1e8: aa1603e1    	mov	x1, x22
10104e1ec: 95af669e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e1f0: aa1d03fd    	mov	x29, x29
10104e1f4: 95af66a3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e1f8: aa0003f8    	mov	x24, x0
10104e1fc: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e200: f947751b    	ldr	x27, [x8, #0xee8] ; selector: getValueOfProperty:inRuleSet:
10104e204: b00dfae2    	adrp	x2, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
10104e208: 9107e042    	add	x2, x2, #0x1f8 ; CFString: text_message_margin_top
10104e20c: b00dfac3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
10104e210: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
10104e214: aa1b03e1    	mov	x1, x27
10104e218: 95af6693    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e21c: aa1d03fd    	mov	x29, x29
10104e220: 95af6698    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e224: aa0003f9    	mov	x25, x0
10104e228: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e22c: f947791c    	ldr	x28, [x8, #0xef0] ; selector: parseFloatFromValues:
10104e230: aa1a03e0    	mov	x0, x26
10104e234: aa1c03e1    	mov	x1, x28
10104e238: aa1903e2    	mov	x2, x25
10104e23c: 95af668a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e240: 1e602929    	fadd	d9, d9, d0
10104e244: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e248: f9461d1a    	ldr	x26, [x8, #0xc38]
10104e24c: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e250: f943c100    	ldr	x0, [x8, #0x780]
10104e254: aa1403e1    	mov	x1, x20
10104e258: 95af6683    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e25c: aa1d03fd    	mov	x29, x29
10104e260: 95af6688    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e264: aa0003f4    	mov	x20, x0
10104e268: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e26c: f9462100    	ldr	x0, [x8, #0xc40]
10104e270: aa1503e1    	mov	x1, x21
10104e274: 95af667c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e278: aa0003e2    	mov	x2, x0
10104e27c: aa1403e0    	mov	x0, x20
10104e280: aa1603e1    	mov	x1, x22
10104e284: 95af6678    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e288: aa1d03fd    	mov	x29, x29
10104e28c: 95af667d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e290: aa0003f5    	mov	x21, x0
10104e294: aa1b03e1    	mov	x1, x27
10104e298: b00dfae2    	adrp	x2, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
10104e29c: 9107e042    	add	x2, x2, #0x1f8 ; CFString: text_message_margin_top
10104e2a0: b00dfac3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
10104e2a4: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
10104e2a8: 95af666f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e2ac: aa1d03fd    	mov	x29, x29
10104e2b0: 95af6674    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e2b4: aa0003f6    	mov	x22, x0
10104e2b8: aa1a03e0    	mov	x0, x26
10104e2bc: aa1c03e1    	mov	x1, x28
10104e2c0: aa1603e2    	mov	x2, x22
10104e2c4: 95af6668    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e2c8: 1e602920    	fadd	d0, d9, d0
10104e2cc: 6d0002e8    	stp	d8, d0, [x23]
10104e2d0: aa1603e0    	mov	x0, x22
10104e2d4: 95af6667    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e2d8: aa1503e0    	mov	x0, x21
10104e2dc: 95af6665    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e2e0: aa1403e0    	mov	x0, x20
10104e2e4: b00ecc14    	adrp	x20, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10104e2e8: 95af6662    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e2ec: aa1903e0    	mov	x0, x25
10104e2f0: b00ecc19    	adrp	x25, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10104e2f4: 95af665f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e2f8: aa1803e0    	mov	x0, x24
10104e2fc: 95af665d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e300: f9400be0    	ldr	x0, [sp, #0x10]
10104e304: 95af665b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e308: 14000010    	b	0x10104e348 <__text+0x1046348>
10104e30c: 900ee988    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10104e310: 912e6108    	add	x8, x8, #0xb98
10104e314: b9800108    	ldrsw	x8, [x8] ; ivar: BaseMessageViewModel.m_cpKeyForChatRoomMessage offset=72
10104e318: f8686a61    	ldr	x1, [x19, x8]
10104e31c: 910063e0    	add	x0, sp, #0x18
10104e320: 95aef9e1    	bl	0x107c0caa4 <_Flutter_MMFoundation_BindContext+0x3e93770>
10104e324: 900ecc08    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10104e328: f9422501    	ldr	x1, [x8, #0x448] ; selector: measureContentViewSize:
10104e32c: aa1303e0    	mov	x0, x19
10104e330: 4ea91d20    	mov.16b	v0, v9
10104e334: 4ea81d01    	mov.16b	v1, v8
10104e338: 95af664b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e33c: 6d0006e0    	stp	d0, d1, [x23]
10104e340: 910063e0    	add	x0, sp, #0x18
10104e344: 95aef9d9    	bl	0x107c0caa8 <_Flutter_MMFoundation_BindContext+0x3e93774>
10104e348: f9423681    	ldr	x1, [x20, #0x468] ; selector: isShowSourceView
10104e34c: aa1303e0    	mov	x0, x19
10104e350: 95af6645    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e354: 34000220    	cbz	w0, 0x10104e398 <__text+0x1046398>
10104e358: f9423f21    	ldr	x1, [x25, #0x478] ; selector: isTailPart
10104e35c: aa1303e0    	mov	x0, x19
10104e360: 95af6641    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e364: 340001a0    	cbz	w0, 0x10104e398 <__text+0x1046398>
10104e368: b00ecc08    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10104e36c: f9423101    	ldr	x1, [x8, #0x460] ; selector: shouldShowSourceViewInContent
10104e370: aa1303e0    	mov	x0, x19
10104e374: 95af663c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e378: 34000100    	cbz	w0, 0x10104e398 <__text+0x1046398>
10104e37c: f00ece48    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
10104e380: f946a901    	ldr	x1, [x8, #0xd50] ; selector: sourceViewInsideHeight
10104e384: aa1303e0    	mov	x0, x19
10104e388: 95af6637    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e38c: fd4006e1    	ldr	d1, [x23, #0x8]
10104e390: 1e612800    	fadd	d0, d0, d1
10104e394: fd0006e0    	str	d0, [x23, #0x8]
10104e398: 6d4026e8    	ldp	d8, d9, [x23]
10104e39c: d00ecc88    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
10104e3a0: f944091b    	ldr	x27, [x8, #0x810] ; selector: isHeadPart
10104e3a4: aa1303e0    	mov	x0, x19
10104e3a8: aa1b03e1    	mov	x1, x27
10104e3ac: 95af662e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e3b0: f00ecc1a    	adrp	x26, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
10104e3b4: 34000d60    	cbz	w0, 0x10104e560 <__text+0x1046560>
10104e3b8: f9464741    	ldr	x1, [x26, #0xc88] ; selector: isRecordDetail
10104e3bc: aa1303e0    	mov	x0, x19
10104e3c0: 95af6629    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e3c4: 37000ce0    	tbnz	w0, #0x0, 0x10104e560 <__text+0x1046560>
10104e3c8: f00ecc08    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
10104e3cc: f9458101    	ldr	x1, [x8, #0xb00] ; selector: isShareConfirm
10104e3d0: aa1303e0    	mov	x0, x19
10104e3d4: 95af6624    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e3d8: 37000c40    	tbnz	w0, #0x0, 0x10104e560 <__text+0x1046560>
10104e3dc: f00ece08    	adrp	x8, 0x11ea11000 <dyld_stub_binder+0x11ea11000>
10104e3e0: f946e501    	ldr	x1, [x8, #0xdc8] ; selector: isShowChatRoomDisplayName
10104e3e4: aa1303e0    	mov	x0, x19
10104e3e8: 95af661f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e3ec: 34000600    	cbz	w0, 0x10104e4ac <__text+0x10464ac>
10104e3f0: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e3f4: f943f100    	ldr	x0, [x8, #0x7e0]
10104e3f8: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e3fc: f9451101    	ldr	x1, [x8, #0xa20] ; selector: dynamicLength:
10104e400: 1e661000    	fmov	d0, #16.00000000
10104e404: 95af6618    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e408: 4ea01c0a    	mov.16b	v10, v0
10104e40c: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e410: f9461d18    	ldr	x24, [x8, #0xc38]
10104e414: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e418: f943c100    	ldr	x0, [x8, #0x780]
10104e41c: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e420: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10104e424: 95af6610    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e428: aa1d03fd    	mov	x29, x29
10104e42c: 95af6615    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e430: aa0003f5    	mov	x21, x0
10104e434: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e438: f9462100    	ldr	x0, [x8, #0xc40]
10104e43c: 900ee2c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10104e440: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10104e444: 95af6608    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e448: aa0003e2    	mov	x2, x0
10104e44c: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e450: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10104e454: aa1503e0    	mov	x0, x21
10104e458: 95af6603    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e45c: aa1d03fd    	mov	x29, x29
10104e460: 95af6608    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e464: aa0003f6    	mov	x22, x0
10104e468: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e46c: f9477501    	ldr	x1, [x8, #0xee8] ; selector: getValueOfProperty:inRuleSet:
10104e470: f00dffe2    	adrp	x2, 0x11d04d000 <dyld_stub_binder+0x11d04d000>
10104e474: 911de042    	add	x2, x2, #0x778 ; CFString: message_node_bkg_margin_top
10104e478: b00dfac3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
10104e47c: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
10104e480: 95af65f9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e484: aa1d03fd    	mov	x29, x29
10104e488: 95af65fe    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e48c: aa0003f7    	mov	x23, x0
10104e490: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e494: f9477901    	ldr	x1, [x8, #0xef0] ; selector: parseFloatFromValues:
10104e498: aa1803e0    	mov	x0, x24
10104e49c: aa1703e2    	mov	x2, x23
10104e4a0: 95af65f1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e4a4: 1e602940    	fadd	d0, d10, d0
10104e4a8: 14000027    	b	0x10104e544 <__text+0x1046544>
10104e4ac: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e4b0: f9461d18    	ldr	x24, [x8, #0xc38]
10104e4b4: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e4b8: f943c100    	ldr	x0, [x8, #0x780]
10104e4bc: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e4c0: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10104e4c4: 95af65e8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e4c8: aa1d03fd    	mov	x29, x29
10104e4cc: 95af65ed    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e4d0: aa0003f5    	mov	x21, x0
10104e4d4: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e4d8: f9462100    	ldr	x0, [x8, #0xc40]
10104e4dc: 900ee2c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10104e4e0: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10104e4e4: 95af65e0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e4e8: aa0003e2    	mov	x2, x0
10104e4ec: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e4f0: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10104e4f4: aa1503e0    	mov	x0, x21
10104e4f8: 95af65db    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e4fc: aa1d03fd    	mov	x29, x29
10104e500: 95af65e0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e504: aa0003f6    	mov	x22, x0
10104e508: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e50c: f9477501    	ldr	x1, [x8, #0xee8] ; selector: getValueOfProperty:inRuleSet:
10104e510: f00dffe2    	adrp	x2, 0x11d04d000 <dyld_stub_binder+0x11d04d000>
10104e514: 911de042    	add	x2, x2, #0x778 ; CFString: message_node_bkg_margin_top
10104e518: b00dfac3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
10104e51c: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
10104e520: 95af65d1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e524: aa1d03fd    	mov	x29, x29
10104e528: 95af65d6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e52c: aa0003f7    	mov	x23, x0
10104e530: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e534: f9477901    	ldr	x1, [x8, #0xef0] ; selector: parseFloatFromValues:
10104e538: aa1803e0    	mov	x0, x24
10104e53c: aa1703e2    	mov	x2, x23
10104e540: 95af65c9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e544: 1e602929    	fadd	d9, d9, d0
10104e548: aa1703e0    	mov	x0, x23
10104e54c: 95af65c9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e550: aa1603e0    	mov	x0, x22
10104e554: 95af65c7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e558: aa1503e0    	mov	x0, x21
10104e55c: 95af65c5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e560: f00ece48    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
10104e564: f9471115    	ldr	x21, [x8, #0xe20] ; selector: replyTextSize
10104e568: aa1303e0    	mov	x0, x19
10104e56c: aa1503e1    	mov	x1, x21
10104e570: 95af65bd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e574: b00b43c8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
10104e578: fd445d00    	ldr	d0, [x8, #0x8b8] ; constant double=0.1
10104e57c: 1e602020    	fcmp	d1, d0
10104e580: 5400024d    	b.le	0x10104e5c8 <__text+0x10465c8>
10104e584: aa1303e0    	mov	x0, x19
10104e588: aa1503e1    	mov	x1, x21
10104e58c: 95af65b6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e590: 4ea11c2a    	mov.16b	v10, v1
10104e594: f00ece48    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
10104e598: f9470915    	ldr	x21, [x8, #0xe10] ; selector: replyTextInset
10104e59c: aa1303e0    	mov	x0, x19
10104e5a0: aa1503e1    	mov	x1, x21
10104e5a4: 95af65b0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e5a8: 1e60294a    	fadd	d10, d10, d0
10104e5ac: aa1303e0    	mov	x0, x19
10104e5b0: aa1503e1    	mov	x1, x21
10104e5b4: 95af65ac    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e5b8: 1e622940    	fadd	d0, d10, d2
10104e5bc: 1e621001    	fmov	d1, #4.00000000
10104e5c0: 1e612800    	fadd	d0, d0, d1
10104e5c4: 1e602929    	fadd	d9, d9, d0
10104e5c8: b00ecc88    	adrp	x8, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
10104e5cc: f9457d01    	ldr	x1, [x8, #0xaf8] ; selector: shouldShowRoomTodoView
10104e5d0: aa1303e0    	mov	x0, x19
10104e5d4: 95af65a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e5d8: 36000660    	tbz	w0, #0x0, 0x10104e6a4 <__text+0x10466a4>
10104e5dc: 900ece68    	adrp	x8, 0x11ea1a000 <dyld_stub_binder+0x11ea1a000>
10104e5e0: f9404101    	ldr	x1, [x8, #0x80] ; selector: hasCommonTail
10104e5e4: aa1303e0    	mov	x0, x19
10104e5e8: 95af659f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e5ec: 34000820    	cbz	w0, 0x10104e6f0 <__text+0x10466f0>
10104e5f0: 900ece68    	adrp	x8, 0x11ea1a000 <dyld_stub_binder+0x11ea1a000>
10104e5f4: f941f101    	ldr	x1, [x8, #0x3e0] ; selector: commonTailSize
10104e5f8: aa1303e0    	mov	x0, x19
10104e5fc: 95af659a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e600: 4ea11c2a    	mov.16b	v10, v1
10104e604: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e608: f9461d18    	ldr	x24, [x8, #0xc38]
10104e60c: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e610: f943c100    	ldr	x0, [x8, #0x780]
10104e614: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e618: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10104e61c: 95af6592    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e620: aa1d03fd    	mov	x29, x29
10104e624: 95af6597    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e628: aa0003f5    	mov	x21, x0
10104e62c: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e630: f9462100    	ldr	x0, [x8, #0xc40]
10104e634: 900ee2c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10104e638: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10104e63c: 95af658a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e640: aa0003e2    	mov	x2, x0
10104e644: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e648: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10104e64c: aa1503e0    	mov	x0, x21
10104e650: 95af6585    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e654: aa1d03fd    	mov	x29, x29
10104e658: 95af658a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e65c: aa0003f6    	mov	x22, x0
10104e660: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e664: f9477501    	ldr	x1, [x8, #0xee8] ; selector: getValueOfProperty:inRuleSet:
10104e668: 900e0002    	adrp	x2, 0x11d04e000 <dyld_stub_binder+0x11d04e000>
10104e66c: 91046042    	add	x2, x2, #0x118 ; CFString: message_node_bottom_sourceView_offset
10104e670: b00dfac3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
10104e674: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
10104e678: 95af657b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e67c: aa1d03fd    	mov	x29, x29
10104e680: 95af6580    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e684: aa0003f7    	mov	x23, x0
10104e688: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e68c: f9477901    	ldr	x1, [x8, #0xef0] ; selector: parseFloatFromValues:
10104e690: aa1803e0    	mov	x0, x24
10104e694: aa1703e2    	mov	x2, x23
10104e698: 95af6573    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e69c: 1e60294a    	fadd	d10, d10, d0
10104e6a0: 14000074    	b	0x10104e870 <__text+0x1046870>
10104e6a4: f9423681    	ldr	x1, [x20, #0x468] ; selector: isShowSourceView
10104e6a8: aa1303e0    	mov	x0, x19
10104e6ac: 95af656e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e6b0: 34000ee0    	cbz	w0, 0x10104e88c <__text+0x104688c>
10104e6b4: f9423f21    	ldr	x1, [x25, #0x478] ; selector: isTailPart
10104e6b8: aa1303e0    	mov	x0, x19
10104e6bc: 95af656a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e6c0: 34000e60    	cbz	w0, 0x10104e88c <__text+0x104688c>
10104e6c4: b00ecc08    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10104e6c8: f9423101    	ldr	x1, [x8, #0x460] ; selector: shouldShowSourceViewInContent
10104e6cc: aa1303e0    	mov	x0, x19
10104e6d0: 95af6565    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e6d4: 37000dc0    	tbnz	w0, #0x0, 0x10104e88c <__text+0x104688c>
10104e6d8: f00ecc08    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
10104e6dc: f9458101    	ldr	x1, [x8, #0xb00] ; selector: isShareConfirm
10104e6e0: aa1303e0    	mov	x0, x19
10104e6e4: 95af6560    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e6e8: 3607f7a0    	tbz	w0, #0x0, 0x10104e5dc <__text+0x10465dc>
10104e6ec: 14000068    	b	0x10104e88c <__text+0x104688c>
10104e6f0: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e6f4: f943f108    	ldr	x8, [x8, #0x7e0]
10104e6f8: f90007e8    	str	x8, [sp, #0x8]
10104e6fc: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e700: f9461d1c    	ldr	x28, [x8, #0xc38]
10104e704: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e708: f943c100    	ldr	x0, [x8, #0x780]
10104e70c: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e710: f9440118    	ldr	x24, [x8, #0x800] ; selector: currentContext
10104e714: aa1803e1    	mov	x1, x24
10104e718: 95af6553    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e71c: aa1d03fd    	mov	x29, x29
10104e720: 95af6558    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e724: aa0003f5    	mov	x21, x0
10104e728: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e72c: f9462100    	ldr	x0, [x8, #0xc40]
10104e730: 900ee2c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10104e734: f9428519    	ldr	x25, [x8, #0x508] ; selector: class
10104e738: aa1903e1    	mov	x1, x25
10104e73c: 95af654a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e740: aa0003e2    	mov	x2, x0
10104e744: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e748: f9000bfb    	str	x27, [sp, #0x10]
10104e74c: f945211b    	ldr	x27, [x8, #0xa40] ; selector: getService:
10104e750: aa1503e0    	mov	x0, x21
10104e754: aa1b03e1    	mov	x1, x27
10104e758: 95af6543    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e75c: aa1d03fd    	mov	x29, x29
10104e760: 95af6548    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e764: aa0003f6    	mov	x22, x0
10104e768: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e76c: f9477514    	ldr	x20, [x8, #0xee8] ; selector: getValueOfProperty:inRuleSet:
10104e770: b00dfbc2    	adrp	x2, 0x11cfc7000 <dyld_stub_binder+0x11cfc7000>
10104e774: 91296042    	add	x2, x2, #0xa58 ; CFString: appinfo_icon_width
10104e778: b00dfac3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
10104e77c: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
10104e780: aa1403e1    	mov	x1, x20
10104e784: 95af6538    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e788: aa1d03fd    	mov	x29, x29
10104e78c: 95af653d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e790: aa0003f7    	mov	x23, x0
10104e794: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e798: f947791a    	ldr	x26, [x8, #0xef0] ; selector: parseFloatFromValues:
10104e79c: aa1c03e0    	mov	x0, x28
10104e7a0: aa1a03e1    	mov	x1, x26
10104e7a4: aa1703e2    	mov	x2, x23
10104e7a8: 95af652f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e7ac: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e7b0: f9451101    	ldr	x1, [x8, #0xa20] ; selector: dynamicLength:
10104e7b4: f94007e0    	ldr	x0, [sp, #0x8]
10104e7b8: 95af652b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e7bc: 1e631001    	fmov	d1, #6.00000000
10104e7c0: 1e61280a    	fadd	d10, d0, d1
10104e7c4: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e7c8: f9461d1c    	ldr	x28, [x8, #0xc38]
10104e7cc: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e7d0: f943c100    	ldr	x0, [x8, #0x780]
10104e7d4: aa1803e1    	mov	x1, x24
10104e7d8: 95af6523    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e7dc: aa1d03fd    	mov	x29, x29
10104e7e0: 95af6528    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e7e4: aa0003f8    	mov	x24, x0
10104e7e8: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e7ec: f9462100    	ldr	x0, [x8, #0xc40]
10104e7f0: aa1903e1    	mov	x1, x25
10104e7f4: 95af651c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e7f8: aa0003e2    	mov	x2, x0
10104e7fc: aa1803e0    	mov	x0, x24
10104e800: aa1b03e1    	mov	x1, x27
10104e804: f9400bfb    	ldr	x27, [sp, #0x10]
10104e808: 95af6517    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e80c: aa1d03fd    	mov	x29, x29
10104e810: 95af651c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e814: aa0003f9    	mov	x25, x0
10104e818: 900e0002    	adrp	x2, 0x11d04e000 <dyld_stub_binder+0x11d04e000>
10104e81c: 91046042    	add	x2, x2, #0x118 ; CFString: message_node_bottom_sourceView_offset
10104e820: aa1403e1    	mov	x1, x20
10104e824: b00dfac3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
10104e828: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
10104e82c: 95af650e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e830: aa1d03fd    	mov	x29, x29
10104e834: 95af6513    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e838: aa0003f4    	mov	x20, x0
10104e83c: aa1c03e0    	mov	x0, x28
10104e840: aa1a03e1    	mov	x1, x26
10104e844: f00ecc1a    	adrp	x26, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
10104e848: aa1403e2    	mov	x2, x20
10104e84c: 95af6506    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e850: 1e60294a    	fadd	d10, d10, d0
10104e854: aa1403e0    	mov	x0, x20
10104e858: 95af6506    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e85c: aa1903e0    	mov	x0, x25
10104e860: b00ecc19    	adrp	x25, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10104e864: 95af6503    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e868: aa1803e0    	mov	x0, x24
10104e86c: 95af6501    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e870: 1e6a2929    	fadd	d9, d9, d10
10104e874: aa1703e0    	mov	x0, x23
10104e878: 95af64fe    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e87c: aa1603e0    	mov	x0, x22
10104e880: 95af64fc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e884: aa1503e0    	mov	x0, x21
10104e888: 95af64fa    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e88c: f00ece48    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
10104e890: f9467501    	ldr	x1, [x8, #0xce8] ; selector: isShowHeadImage
10104e894: aa1303e0    	mov	x0, x19
10104e898: 95af64f3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e89c: 34000980    	cbz	w0, 0x10104e9cc <__text+0x10469cc>
10104e8a0: aa1303e0    	mov	x0, x19
10104e8a4: aa1b03e1    	mov	x1, x27
10104e8a8: 95af64ef    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e8ac: 34000900    	cbz	w0, 0x10104e9cc <__text+0x10469cc>
10104e8b0: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e8b4: f9461d15    	ldr	x21, [x8, #0xc38]
10104e8b8: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e8bc: f943c100    	ldr	x0, [x8, #0x780]
10104e8c0: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e8c4: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10104e8c8: 95af64e7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e8cc: aa1d03fd    	mov	x29, x29
10104e8d0: 95af64ec    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e8d4: aa0003f4    	mov	x20, x0
10104e8d8: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e8dc: f9462100    	ldr	x0, [x8, #0xc40]
10104e8e0: 900ee2c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10104e8e4: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10104e8e8: 95af64df    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e8ec: aa0003e2    	mov	x2, x0
10104e8f0: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104e8f4: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10104e8f8: aa1403e0    	mov	x0, x20
10104e8fc: 95af64da    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e900: aa1d03fd    	mov	x29, x29
10104e904: 95af64df    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e908: aa0003f6    	mov	x22, x0
10104e90c: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e910: f9477501    	ldr	x1, [x8, #0xee8] ; selector: getValueOfProperty:inRuleSet:
10104e914: b00dfae2    	adrp	x2, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
10104e918: 9107e042    	add	x2, x2, #0x1f8 ; CFString: text_message_margin_top
10104e91c: b00dfac3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
10104e920: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
10104e924: 95af64d0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e928: aa1d03fd    	mov	x29, x29
10104e92c: 95af64d5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e930: aa0003f7    	mov	x23, x0
10104e934: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e938: f9477901    	ldr	x1, [x8, #0xef0] ; selector: parseFloatFromValues:
10104e93c: aa1503e0    	mov	x0, x21
10104e940: aa1703e2    	mov	x2, x23
10104e944: 95af64c8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e948: 4ea01c0a    	mov.16b	v10, v0
10104e94c: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104e950: f943f100    	ldr	x0, [x8, #0x7e0]
10104e954: f00ecbe8    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
10104e958: f9478901    	ldr	x1, [x8, #0xf10] ; selector: systemFont
10104e95c: 95af64c2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e960: aa1d03fd    	mov	x29, x29
10104e964: 95af64c7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104e968: aa0003f5    	mov	x21, x0
10104e96c: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104e970: f947ed01    	ldr	x1, [x8, #0xfd8] ; selector: lineHeight
10104e974: 95af64bc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e978: 1e64c000    	frintp	d0, d0
10104e97c: 1e601001    	fmov	d1, #2.00000000
10104e980: 1f41014a    	fmadd	d10, d10, d1, d0
10104e984: aa1503e0    	mov	x0, x21
10104e988: 95af64ba    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e98c: aa1703e0    	mov	x0, x23
10104e990: 95af64b8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e994: aa1603e0    	mov	x0, x22
10104e998: 95af64b6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e99c: aa1403e0    	mov	x0, x20
10104e9a0: 95af64b4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104e9a4: 1e6a2120    	fcmp	d9, d10
10104e9a8: 1e694d49    	fcsel	d9, d10, d9, mi
10104e9ac: f00ece08    	adrp	x8, 0x11ea11000 <dyld_stub_binder+0x11ea11000>
10104e9b0: f946e501    	ldr	x1, [x8, #0xdc8] ; selector: isShowChatRoomDisplayName
10104e9b4: aa1303e0    	mov	x0, x19
10104e9b8: 95af64ab    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e9bc: 1e611000    	fmov	d0, #3.00000000
10104e9c0: 1e602920    	fadd	d0, d9, d0
10104e9c4: 7100001f    	cmp	w0, #0x0
10104e9c8: 1e601d29    	fcsel	d9, d9, d0, ne
10104e9cc: f9423f21    	ldr	x1, [x25, #0x478] ; selector: isTailPart
10104e9d0: aa1303e0    	mov	x0, x19
10104e9d4: 95af64a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e9d8: 340006e0    	cbz	w0, 0x10104eab4 <__text+0x1046ab4>
10104e9dc: f9464741    	ldr	x1, [x26, #0xc88] ; selector: isRecordDetail
10104e9e0: aa1303e0    	mov	x0, x19
10104e9e4: 95af64a0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e9e8: 37000660    	tbnz	w0, #0x0, 0x10104eab4 <__text+0x1046ab4>
10104e9ec: f00ecc08    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
10104e9f0: f9458101    	ldr	x1, [x8, #0xb00] ; selector: isShareConfirm
10104e9f4: aa1303e0    	mov	x0, x19
10104e9f8: 95af649b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104e9fc: 370005c0    	tbnz	w0, #0x0, 0x10104eab4 <__text+0x1046ab4>
10104ea00: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104ea04: f9461d13    	ldr	x19, [x8, #0xc38]
10104ea08: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104ea0c: f943c100    	ldr	x0, [x8, #0x780]
10104ea10: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104ea14: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10104ea18: 95af6493    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104ea1c: aa1d03fd    	mov	x29, x29
10104ea20: 95af6498    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104ea24: aa0003f4    	mov	x20, x0
10104ea28: 900ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104ea2c: f9462100    	ldr	x0, [x8, #0xc40]
10104ea30: 900ee2c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10104ea34: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10104ea38: 95af648b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104ea3c: aa0003e2    	mov	x2, x0
10104ea40: f00ecbc8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104ea44: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10104ea48: aa1403e0    	mov	x0, x20
10104ea4c: 95af6486    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104ea50: aa1d03fd    	mov	x29, x29
10104ea54: 95af648b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104ea58: aa0003f5    	mov	x21, x0
10104ea5c: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104ea60: f9477501    	ldr	x1, [x8, #0xee8] ; selector: getValueOfProperty:inRuleSet:
10104ea64: 900dfae2    	adrp	x2, 0x11cfaa000 <dyld_stub_binder+0x11cfaa000>
10104ea68: 912e6042    	add	x2, x2, #0xb98 ; CFString: content_sepm_margin
10104ea6c: 900dfae3    	adrp	x3, 0x11cfaa000 <dyld_stub_binder+0x11cfaa000>
10104ea70: 912ee063    	add	x3, x3, #0xbb8 ; CFString: #message_content_viewController
10104ea74: 95af647c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104ea78: aa1d03fd    	mov	x29, x29
10104ea7c: 95af6481    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104ea80: aa0003f6    	mov	x22, x0
10104ea84: b00ecbe8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10104ea88: f9477901    	ldr	x1, [x8, #0xef0] ; selector: parseFloatFromValues:
10104ea8c: aa1303e0    	mov	x0, x19
10104ea90: aa1603e2    	mov	x2, x22
10104ea94: 95af6474    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104ea98: 1e602929    	fadd	d9, d9, d0
10104ea9c: aa1603e0    	mov	x0, x22
10104eaa0: 95af6474    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104eaa4: aa1503e0    	mov	x0, x21
10104eaa8: 95af6472    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104eaac: aa1403e0    	mov	x0, x20
10104eab0: 95af6470    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104eab4: 4ea81d00    	mov.16b	v0, v8
10104eab8: 4ea91d21    	mov.16b	v1, v9
10104eabc: a9497bfd    	ldp	x29, x30, [sp, #0x90]
10104eac0: a9484ff4    	ldp	x20, x19, [sp, #0x80]
10104eac4: a94757f6    	ldp	x22, x21, [sp, #0x70]
10104eac8: a9465ff8    	ldp	x24, x23, [sp, #0x60]
10104eacc: a94567fa    	ldp	x26, x25, [sp, #0x50]
10104ead0: a9446ffc    	ldp	x28, x27, [sp, #0x40]
10104ead4: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
10104ead8: 6d422beb    	ldp	d11, d10, [sp, #0x20]
10104eadc: 910283ff    	add	sp, sp, #0xa0
10104eae0: d65f03c0    	ret
