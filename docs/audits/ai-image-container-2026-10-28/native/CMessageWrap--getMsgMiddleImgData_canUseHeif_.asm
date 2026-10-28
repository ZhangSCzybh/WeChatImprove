
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104bab064: d10243ff    	sub	sp, sp, #0x90
104bab068: a9036ffc    	stp	x28, x27, [sp, #0x30]
104bab06c: a90467fa    	stp	x26, x25, [sp, #0x40]
104bab070: a9055ff8    	stp	x24, x23, [sp, #0x50]
104bab074: a90657f6    	stp	x22, x21, [sp, #0x60]
104bab078: a9074ff4    	stp	x20, x19, [sp, #0x70]
104bab07c: a9087bfd    	stp	x29, x30, [sp, #0x80]
104bab080: 910203fd    	add	x29, sp, #0x80
104bab084: aa0303f6    	mov	x22, x3
104bab088: aa0203f3    	mov	x19, x2
104bab08c: f00e0488    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104bab090: 52800029    	mov	w9, #0x1                ; =1
104bab094: 391aed09    	strb	w9, [x8, #0x6bb]
104bab098: aa0203e0    	mov	x0, x2
104bab09c: 94c1f027    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bab0a0: b00dae5a    	adrp	x26, 0x120174000 <dyld_stub_binder+0x120174000>
104bab0a4: f9411f40    	ldr	x0, [x26, #0x238] ; CMessageWrap
104bab0a8: f00d94c8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104bab0ac: f942c501    	ldr	x1, [x8, #0x588] ; getUserNameFromMsgWrap:
104bab0b0: aa1303e2    	mov	x2, x19
104bab0b4: 94c1f022    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab0b8: aa1d03fd    	mov	x29, x29
104bab0bc: 94c1f023    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab0c0: aa0003f9    	mov	x25, x0
104bab0c4: b00daaa8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104bab0c8: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
104bab0cc: 900dae54    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
104bab0d0: f00dae7c    	adrp	x28, 0x12017a000 <dyld_stub_binder+0x12017a000>
104bab0d4: 360004b6    	tbz	w22, #0x0, 0x104bab168 <_Flutter_MMFoundation_BindContext+0x1086d4c>
104bab0d8: f945ea80    	ldr	x0, [x20, #0xbd0] ; MMContext
104bab0dc: aa1503e1    	mov	x1, x21
104bab0e0: 94c1f017    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab0e4: aa1d03fd    	mov	x29, x29
104bab0e8: 94c1f018    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab0ec: aa1903fb    	mov	x27, x25
104bab0f0: aa0003f9    	mov	x25, x0
104bab0f4: f9455b80    	ldr	x0, [x28, #0xab0] ; WxamImageManager
104bab0f8: 900daaa8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104bab0fc: f947ad16    	ldr	x22, [x8, #0xf58] ; class
104bab100: aa1603e1    	mov	x1, x22
104bab104: 94c1f00e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab108: aa0003e2    	mov	x2, x0
104bab10c: d00d9468    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104bab110: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
104bab114: aa1903e0    	mov	x0, x25
104bab118: aa1803e1    	mov	x1, x24
104bab11c: 94c1f008    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab120: aa1d03fd    	mov	x29, x29
104bab124: 94c1f009    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab128: aa0003fa    	mov	x26, x0
104bab12c: 900d9ee8    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104bab130: f9472901    	ldr	x1, [x8, #0xe50] ; parseWxamDataToHeif:
104bab134: aa1303e2    	mov	x2, x19
104bab138: 94c1f001    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab13c: aa1d03fd    	mov	x29, x29
104bab140: 94c1f002    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab144: aa0003f7    	mov	x23, x0
104bab148: aa1a03e0    	mov	x0, x26
104bab14c: 94c1f002    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab150: aa1903e0    	mov	x0, x25
104bab154: aa1b03f9    	mov	x25, x27
104bab158: 94c1efff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab15c: b5001ef7    	cbnz	x23, 0x104bab538 <_Flutter_MMFoundation_BindContext+0x108711c>
104bab160: b00dae5a    	adrp	x26, 0x120174000 <dyld_stub_binder+0x120174000>
104bab164: 14000005    	b	0x104bab178 <_Flutter_MMFoundation_BindContext+0x1086d5c>
104bab168: 900daaa8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104bab16c: f947ad16    	ldr	x22, [x8, #0xf58] ; class
104bab170: d00d9468    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104bab174: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
104bab178: f945ea80    	ldr	x0, [x20, #0xbd0] ; MMContext
104bab17c: aa1503e1    	mov	x1, x21
104bab180: 94c1efef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab184: aa1d03fd    	mov	x29, x29
104bab188: 94c1eff0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab18c: aa0003f7    	mov	x23, x0
104bab190: f9455b80    	ldr	x0, [x28, #0xab0] ; WxamImageManager
104bab194: aa1603e1    	mov	x1, x22
104bab198: 94c1efe9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab19c: aa0003e2    	mov	x2, x0
104bab1a0: aa1703e0    	mov	x0, x23
104bab1a4: aa1803e1    	mov	x1, x24
104bab1a8: 94c1efe5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab1ac: aa1d03fd    	mov	x29, x29
104bab1b0: 94c1efe6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab1b4: aa0003f6    	mov	x22, x0
104bab1b8: 900d9ee8    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104bab1bc: f9472d01    	ldr	x1, [x8, #0xe58] ; parseWxamData:
104bab1c0: aa1303e2    	mov	x2, x19
104bab1c4: 94c1efde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab1c8: aa1d03fd    	mov	x29, x29
104bab1cc: 94c1efdf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab1d0: aa0003f5    	mov	x21, x0
104bab1d4: aa1603e0    	mov	x0, x22
104bab1d8: 94c1efdf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab1dc: aa1703e0    	mov	x0, x23
104bab1e0: 94c1efdd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab1e4: b40000b5    	cbz	x21, 0x104bab1f8 <_Flutter_MMFoundation_BindContext+0x1086ddc>
104bab1e8: aa1503e0    	mov	x0, x21
104bab1ec: 94c1efd3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bab1f0: aa1503f7    	mov	x23, x21
104bab1f4: 140000cf    	b	0x104bab530 <_Flutter_MMFoundation_BindContext+0x1087114>
104bab1f8: f9411f40    	ldr	x0, [x26, #0x238] ; CMessageWrap
104bab1fc: d00d9488    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104bab200: f9478d01    	ldr	x1, [x8, #0xf18] ; isSenderFromMsgWrap:
104bab204: aa1303e2    	mov	x2, x19
104bab208: 94c1efcd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab20c: 900dae56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104bab210: 36000400    	tbz	w0, #0x0, 0x104bab290 <_Flutter_MMFoundation_BindContext+0x1086e74>
104bab214: f9411f40    	ldr	x0, [x26, #0x238] ; CMessageWrap
104bab218: f00d9668    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
104bab21c: f944ed01    	ldr	x1, [x8, #0x9d8] ; getPathOfMiddleImgForSender:
104bab220: aa1303e2    	mov	x2, x19
104bab224: 94c1efc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab228: aa1d03fd    	mov	x29, x29
104bab22c: 94c1efc7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab230: aa0003fb    	mov	x27, x0
104bab234: f94636c0    	ldr	x0, [x22, #0xc68] ; CBaseFile
104bab238: d00d9468    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104bab23c: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
104bab240: aa0103f4    	mov	x20, x1
104bab244: aa1b03e2    	mov	x2, x27
104bab248: 94c1efbd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab24c: 340002c0    	cbz	w0, 0x104bab2a4 <_Flutter_MMFoundation_BindContext+0x1086e88>
104bab250: 900dae48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104bab254: f9459500    	ldr	x0, [x8, #0xb28]
104bab258: b00daaa8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104bab25c: f945f501    	ldr	x1, [x8, #0xbe8] ; dataWithContentsOfFile:
104bab260: aa1b03e2    	mov	x2, x27
104bab264: 94c1efb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab268: aa1d03fd    	mov	x29, x29
104bab26c: 94c1efb7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab270: b40001a0    	cbz	x0, 0x104bab2a4 <_Flutter_MMFoundation_BindContext+0x1086e88>
104bab274: aa0003f7    	mov	x23, x0
104bab278: 94c1efb0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bab27c: aa1b03e0    	mov	x0, x27
104bab280: 94c1efb5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab284: aa1703e0    	mov	x0, x23
104bab288: 94c1efb3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab28c: 140000a9    	b	0x104bab530 <_Flutter_MMFoundation_BindContext+0x1087114>
104bab290: f9000ff9    	str	x25, [sp, #0x18]
104bab294: d280001b    	mov	x27, #0x0               ; =0
104bab298: d00d9468    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104bab29c: f9467914    	ldr	x20, [x8, #0xcf0] ; FileExist:
104bab2a0: 14000002    	b	0x104bab2a8 <_Flutter_MMFoundation_BindContext+0x1086e8c>
104bab2a4: f9000ff9    	str	x25, [sp, #0x18]
104bab2a8: 900dae5a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
104bab2ac: f9467b57    	ldr	x23, [x26, #0xcf0] ; CUtility
104bab2b0: b00d9488    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104bab2b4: f947d119    	ldr	x25, [x8, #0xfa0] ; m_uiMesLocalID
104bab2b8: aa1303e0    	mov	x0, x19
104bab2bc: aa1903e1    	mov	x1, x25
104bab2c0: 94c1ef9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab2c4: aa0003f8    	mov	x24, x0
104bab2c8: f9467b40    	ldr	x0, [x26, #0xcf0] ; CUtility
104bab2cc: 900d94c8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104bab2d0: f943a51a    	ldr	x26, [x8, #0x748] ; GetDocPath
104bab2d4: aa1a03e1    	mov	x1, x26
104bab2d8: 94c1ef99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab2dc: aa1d03fd    	mov	x29, x29
104bab2e0: 94c1ef9a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab2e4: aa0003fc    	mov	x28, x0
104bab2e8: d00d96a8    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
104bab2ec: f940a901    	ldr	x1, [x8, #0x150] ; GetPathOfMesImg:LocalID:DocPath:
104bab2f0: aa1703e0    	mov	x0, x23
104bab2f4: f9400fe2    	ldr	x2, [sp, #0x18]
104bab2f8: aa1803e3    	mov	x3, x24
104bab2fc: aa1c03e4    	mov	x4, x28
104bab300: 94c1ef8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab304: aa1d03fd    	mov	x29, x29
104bab308: 94c1ef90    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab30c: aa0003f8    	mov	x24, x0
104bab310: aa1b03e0    	mov	x0, x27
104bab314: 94c1ef90    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab318: aa1c03e0    	mov	x0, x28
104bab31c: 94c1ef8e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab320: aa1603fc    	mov	x28, x22
104bab324: f94636c0    	ldr	x0, [x22, #0xc68] ; CBaseFile
104bab328: aa1403e1    	mov	x1, x20
104bab32c: aa1803e2    	mov	x2, x24
104bab330: 94c1ef83    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab334: 34000520    	cbz	w0, 0x104bab3d8 <_Flutter_MMFoundation_BindContext+0x1086fbc>
104bab338: 900dae48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104bab33c: f9459500    	ldr	x0, [x8, #0xb28]
104bab340: b00daaa8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104bab344: f945f501    	ldr	x1, [x8, #0xbe8] ; dataWithContentsOfFile:
104bab348: aa1803e2    	mov	x2, x24
104bab34c: 94c1ef7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab350: aa1d03fd    	mov	x29, x29
104bab354: 94c1ef7d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab358: aa0003f7    	mov	x23, x0
104bab35c: 900daac8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104bab360: f946e901    	ldr	x1, [x8, #0xdd0] ; length
104bab364: 94c1ef76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab368: b50002e0    	cbnz	x0, 0x104bab3c4 <_Flutter_MMFoundation_BindContext+0x1086fa8>
104bab36c: 900dae48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104bab370: f945351b    	ldr	x27, [x8, #0xa68] ; iConsole
104bab374: f9463780    	ldr	x0, [x28, #0xc68] ; CgiReportItemConfig
104bab378: 900d9488    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104bab37c: f9467101    	ldr	x1, [x8, #0xce0] ; GetFileSize:
104bab380: aa1803e2    	mov	x2, x24
104bab384: 94c1ef6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab388: d00d9468    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104bab38c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104bab390: f00cdfe8    	adrp	x8, 0x11e7aa000 <dyld_stub_binder+0x11e7aa000>
104bab394: 9120a108    	add	x8, x8, #0x828
104bab398: a90003e8    	stp	x8, x0, [sp]
104bab39c: f00b62c5    	adrp	x5, 0x11b806000 <dyld_stub_binder+0x11b806000>
104bab3a0: 9123a0a5    	add	x5, x5, #0x8e8
104bab3a4: 900b62e7    	adrp	x7, 0x11b807000 <dyld_stub_binder+0x11b807000>
104bab3a8: 913468e7    	add	x7, x7, #0xd1a
104bab3ac: aa1b03e0    	mov	x0, x27
104bab3b0: 52800082    	mov	w2, #0x4                ; =4
104bab3b4: d2800003    	mov	x3, #0x0                ; =0
104bab3b8: 52800004    	mov	w4, #0x0                ; =0
104bab3bc: 52818746    	mov	w6, #0xc3a              ; =3130
104bab3c0: 94c1ef5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab3c4: b40000b7    	cbz	x23, 0x104bab3d8 <_Flutter_MMFoundation_BindContext+0x1086fbc>
104bab3c8: aa1703e0    	mov	x0, x23
104bab3cc: 94c1ef5b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bab3d0: aa1803e0    	mov	x0, x24
104bab3d4: 14000053    	b	0x104bab520 <_Flutter_MMFoundation_BindContext+0x1087104>
104bab3d8: 900dae56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104bab3dc: f9467ad7    	ldr	x23, [x22, #0xcf0] ; CUtility
104bab3e0: aa1303e0    	mov	x0, x19
104bab3e4: aa1903e1    	mov	x1, x25
104bab3e8: 94c1ef55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab3ec: aa0003f9    	mov	x25, x0
104bab3f0: f9467ac0    	ldr	x0, [x22, #0xcf0] ; CUtility
104bab3f4: aa1a03e1    	mov	x1, x26
104bab3f8: 94c1ef51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab3fc: aa1d03fd    	mov	x29, x29
104bab400: 94c1ef52    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab404: aa0003fa    	mov	x26, x0
104bab408: d00d96a8    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
104bab40c: f9423101    	ldr	x1, [x8, #0x460] ; getPathOfMsgVcodec2Img:localID:docPath:
104bab410: aa1703e0    	mov	x0, x23
104bab414: f9400fe2    	ldr	x2, [sp, #0x18]
104bab418: aa1903e3    	mov	x3, x25
104bab41c: aa1a03e4    	mov	x4, x26
104bab420: 94c1ef47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab424: aa1d03fd    	mov	x29, x29
104bab428: 94c1ef48    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab42c: aa0003f9    	mov	x25, x0
104bab430: aa1803e0    	mov	x0, x24
104bab434: 94c1ef48    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab438: aa1a03e0    	mov	x0, x26
104bab43c: 94c1ef46    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab440: d00daac8    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
104bab444: f9439101    	ldr	x1, [x8, #0x720] ; pathExtension
104bab448: aa1903e0    	mov	x0, x25
104bab44c: 94c1ef3c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab450: aa1d03fd    	mov	x29, x29
104bab454: 94c1ef3d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab458: aa0003f8    	mov	x24, x0
104bab45c: f00daaa8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104bab460: f9444901    	ldr	x1, [x8, #0x890] ; hasPrefix:
104bab464: f00cdfe2    	adrp	x2, 0x11e7aa000 <dyld_stub_binder+0x11e7aa000>
104bab468: 911da042    	add	x2, x2, #0x768
104bab46c: 94c1ef34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab470: 34000400    	cbz	w0, 0x104bab4f0 <_Flutter_MMFoundation_BindContext+0x10870d4>
104bab474: f9463780    	ldr	x0, [x28, #0xc68] ; CgiReportItemConfig
104bab478: aa1403e1    	mov	x1, x20
104bab47c: aa1903e2    	mov	x2, x25
104bab480: 94c1ef2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab484: 34000360    	cbz	w0, 0x104bab4f0 <_Flutter_MMFoundation_BindContext+0x10870d4>
104bab488: 52800c88    	mov	w8, #0x64               ; =100
104bab48c: b9002fe8    	str	w8, [sp, #0x2c]
104bab490: f00daf28    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
104bab494: f9477900    	ldr	x0, [x8, #0xef0] ; VCODEC2ImageCom
104bab498: f90013ff    	str	xzr, [sp, #0x20]
104bab49c: 900d9ee8    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104bab4a0: f9470501    	ldr	x1, [x8, #0xe08] ; decodeVCODEC2ImageFile:toUIImage:toJPGQuality:
104bab4a4: 910083e3    	add	x3, sp, #0x20
104bab4a8: 9100b3e4    	add	x4, sp, #0x2c
104bab4ac: aa1903e2    	mov	x2, x25
104bab4b0: 94c1ef23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab4b4: f94013f6    	ldr	x22, [sp, #0x20]
104bab4b8: aa1603e0    	mov	x0, x22
104bab4bc: 94c1ef1f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bab4c0: b9402fe8    	ldr	w8, [sp, #0x2c]
104bab4c4: 1e620100    	scvtf	d0, w8
104bab4c8: d2e80b28    	mov	x8, #0x4059000000000000 ; =4636737291354636288
104bab4cc: 9e670101    	fmov	d1, x8
104bab4d0: 1e611800    	fdiv	d0, d0, d1
104bab4d4: 94c1ef38    	bl	0x107c271b4 <_Flutter_MMFoundation_BindContext+0x4102d98>
104bab4d8: aa1d03fd    	mov	x29, x29
104bab4dc: 94c1ef1b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab4e0: aa0003f7    	mov	x23, x0
104bab4e4: aa1603e0    	mov	x0, x22
104bab4e8: 94c1ef1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab4ec: b5000117    	cbnz	x23, 0x104bab50c <_Flutter_MMFoundation_BindContext+0x10870f0>
104bab4f0: 900d9508    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104bab4f4: f941dd01    	ldr	x1, [x8, #0x3b8] ; m_dtImg
104bab4f8: aa1303e0    	mov	x0, x19
104bab4fc: 94c1ef10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bab500: aa1d03fd    	mov	x29, x29
104bab504: 94c1ef11    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bab508: aa0003f7    	mov	x23, x0
104bab50c: aa1703e0    	mov	x0, x23
104bab510: 94c1ef0a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bab514: aa1803e0    	mov	x0, x24
104bab518: 94c1ef0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab51c: aa1903e0    	mov	x0, x25
104bab520: 94c1ef0d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab524: aa1703e0    	mov	x0, x23
104bab528: 94c1ef0b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab52c: f9400ff9    	ldr	x25, [sp, #0x18]
104bab530: aa1503e0    	mov	x0, x21
104bab534: 94c1ef08    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab538: aa1903e0    	mov	x0, x25
104bab53c: 94c1ef06    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab540: aa1303e0    	mov	x0, x19
104bab544: 94c1ef04    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bab548: aa1703e0    	mov	x0, x23
104bab54c: a9487bfd    	ldp	x29, x30, [sp, #0x80]
104bab550: a9474ff4    	ldp	x20, x19, [sp, #0x70]
104bab554: a94657f6    	ldp	x22, x21, [sp, #0x60]
104bab558: a9455ff8    	ldp	x24, x23, [sp, #0x50]
104bab55c: a94467fa    	ldp	x26, x25, [sp, #0x40]
104bab560: a9436ffc    	ldp	x28, x27, [sp, #0x30]
104bab564: 910243ff    	add	sp, sp, #0x90
104bab568: 14c1ef02    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
