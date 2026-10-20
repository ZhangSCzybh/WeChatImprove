
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a09a2a0: d10503ff    	sub	sp, sp, #0x140
10a09a2a4: 6d0d23e9    	stp	d9, d8, [sp, #0xd0]
10a09a2a8: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
10a09a2ac: a90f67fa    	stp	x26, x25, [sp, #0xf0]
10a09a2b0: a9105ff8    	stp	x24, x23, [sp, #0x100]
10a09a2b4: a91157f6    	stp	x22, x21, [sp, #0x110]
10a09a2b8: a9124ff4    	stp	x20, x19, [sp, #0x120]
10a09a2bc: a9137bfd    	stp	x29, x30, [sp, #0x130]
10a09a2c0: 9104c3fd    	add	x29, sp, #0x130
10a09a2c4: aa0403fb    	mov	x27, x4
10a09a2c8: aa0303f4    	mov	x20, x3
10a09a2cc: aa0203f3    	mov	x19, x2
10a09a2d0: f00b5da8    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a09a2d4: 52800029    	mov	w9, #0x1                ; =1
10a09a2d8: 39102909    	strb	w9, [x8, #0x40a]
10a09a2dc: aa0203e0    	mov	x0, x2
10a09a2e0: 955f0458    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a09a2e4: aa1b03e0    	mov	x0, x27
10a09a2e8: 955f0456    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a09a2ec: 900afb28    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
10a09a2f0: f9430101    	ldr	x1, [x8, #0x600] ; supportCommentEmoticonOrImageBrowse
10a09a2f4: 955f0454    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a2f8: aa0003f8    	mov	x24, x0
10a09a2fc: b00b0808    	adrp	x8, 0x12019b000 <dyld_stub_binder+0x12019b000>
10a09a300: f940dd00    	ldr	x0, [x8, #0x1b8] ; 0r=
10a09a304: 900afb28    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
10a09a308: f9460901    	ldr	x1, [x8, #0xc10] ; isAdFireworkCheerCommentStyle:
10a09a30c: aa1303e2    	mov	x2, x19
10a09a310: 955f044d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a314: aa0003fc    	mov	x28, x0
10a09a318: f100069f    	cmp	x20, #0x1
10a09a31c: 54003101    	b.ne	0x10a09a93c <_Flutter_MMFoundation_BindContext+0x6576520>
10a09a320: 900aede8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
10a09a324: f9447501    	ldr	x1, [x8, #0x8e8] ; likeCount
10a09a328: aa1303e0    	mov	x0, x19
10a09a32c: 955f0446    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a330: 7100041f    	cmp	w0, #0x1
10a09a334: 5400304b    	b.lt	0x10a09a93c <_Flutter_MMFoundation_BindContext+0x6576520>
10a09a338: b90087f8    	str	w24, [sp, #0x84]
10a09a33c: b90057fc    	str	w28, [sp, #0x54]
10a09a340: f9002ffb    	str	x27, [sp, #0x58]
10a09a344: f00b0808    	adrp	x8, 0x12019d000 <dyld_stub_binder+0x12019d000>
10a09a348: f943c100    	ldr	x0, [x8, #0x780]
10a09a34c: f00afb08    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
10a09a350: f9478501    	ldr	x1, [x8, #0xf08] ; canDisplaySpringStyleForDataItem:
10a09a354: aa1303e2    	mov	x2, x19
10a09a358: 955f043b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a35c: b90077e0    	str	w0, [sp, #0x74]
10a09a360: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a364: f9403d14    	ldr	x20, [x8, #0x78]
10a09a368: b00b06c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a09a36c: f945e900    	ldr	x0, [x8, #0xbd0]
10a09a370: d00b0328    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a09a374: f944e918    	ldr	x24, [x8, #0x9d0] ; currentContext
10a09a378: aa1803e1    	mov	x1, x24
10a09a37c: 955f0432    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a380: aa1d03fd    	mov	x29, x29
10a09a384: 955f0433    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a388: aa0003f5    	mov	x21, x0
10a09a38c: f90027e0    	str	x0, [sp, #0x48]
10a09a390: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a394: f9404100    	ldr	x0, [x8, #0x80]
10a09a398: b00b0328    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a09a39c: f947ad17    	ldr	x23, [x8, #0xf58] ; class
10a09a3a0: aa1703e1    	mov	x1, x23
10a09a3a4: 955f0428    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a3a8: aa0003e2    	mov	x2, x0
10a09a3ac: f00aece8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a09a3b0: f946411b    	ldr	x27, [x8, #0xc80] ; getService:
10a09a3b4: aa1503e0    	mov	x0, x21
10a09a3b8: aa1b03e1    	mov	x1, x27
10a09a3bc: 955f0422    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a3c0: aa1d03fd    	mov	x29, x29
10a09a3c4: 955f0423    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a3c8: f90023e0    	str	x0, [sp, #0x40]
10a09a3cc: b00aed08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a09a3d0: f947fd1c    	ldr	x28, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
10a09a3d4: 900a4122    	adrp	x2, 0x11e8be000 <dyld_stub_binder+0x11e8be000>
10a09a3d8: 91032042    	add	x2, x2, #0xc8
10a09a3dc: 900a4139    	adrp	x25, 0x11e8be000 <dyld_stub_binder+0x11e8be000>
10a09a3e0: 9103a339    	add	x25, x25, #0xe8
10a09a3e4: aa1c03e1    	mov	x1, x28
10a09a3e8: aa1903e3    	mov	x3, x25
10a09a3ec: 955f0416    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a3f0: aa1d03fd    	mov	x29, x29
10a09a3f4: 955f0417    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a3f8: aa0003e2    	mov	x2, x0
10a09a3fc: f9001fe0    	str	x0, [sp, #0x38]
10a09a400: d00aed08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a09a404: f9400115    	ldr	x21, [x8]
10a09a408: aa1403e0    	mov	x0, x20
10a09a40c: aa1503e1    	mov	x1, x21
10a09a410: 955f040d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a414: 1e604008    	fmov	d8, d0
10a09a418: b00b06c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a09a41c: f946191a    	ldr	x26, [x8, #0xc30]
10a09a420: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a424: f9403d16    	ldr	x22, [x8, #0x78]
10a09a428: b00b06c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a09a42c: f945e900    	ldr	x0, [x8, #0xbd0]
10a09a430: f90013f8    	str	x24, [sp, #0x20]
10a09a434: aa1803e1    	mov	x1, x24
10a09a438: 955f0403    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a43c: aa1d03fd    	mov	x29, x29
10a09a440: 955f0404    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a444: aa0003f4    	mov	x20, x0
10a09a448: f9001be0    	str	x0, [sp, #0x30]
10a09a44c: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a450: f9404100    	ldr	x0, [x8, #0x80]
10a09a454: aa1703e1    	mov	x1, x23
10a09a458: 955f03fb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a45c: aa0003e2    	mov	x2, x0
10a09a460: aa1403e0    	mov	x0, x20
10a09a464: aa1b03e1    	mov	x1, x27
10a09a468: 955f03f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a46c: aa1d03fd    	mov	x29, x29
10a09a470: 955f03f8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a474: f90017e0    	str	x0, [sp, #0x28]
10a09a478: b00a4982    	adrp	x2, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10a09a47c: 91002042    	add	x2, x2, #0x8
10a09a480: aa1c03e1    	mov	x1, x28
10a09a484: aa1903e3    	mov	x3, x25
10a09a488: 955f03ef    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a48c: aa1d03fd    	mov	x29, x29
10a09a490: 955f03f0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a494: aa0003f9    	mov	x25, x0
10a09a498: aa1603e0    	mov	x0, x22
10a09a49c: aa1503e1    	mov	x1, x21
10a09a4a0: aa1903e2    	mov	x2, x25
10a09a4a4: 955f03e8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a4a8: f00aece8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a09a4ac: f9463114    	ldr	x20, [x8, #0xc60] ; dynamicLength:
10a09a4b0: aa1a03e0    	mov	x0, x26
10a09a4b4: aa1403e1    	mov	x1, x20
10a09a4b8: 955f03e3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a4bc: 1e603908    	fsub	d8, d8, d0
10a09a4c0: b00b06c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a09a4c4: f946191a    	ldr	x26, [x8, #0xc30]
10a09a4c8: f9003ff3    	str	x19, [sp, #0x78]
10a09a4cc: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a4d0: f9403d13    	ldr	x19, [x8, #0x78]
10a09a4d4: b00b06c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a09a4d8: f945e900    	ldr	x0, [x8, #0xbd0]
10a09a4dc: aa1803e1    	mov	x1, x24
10a09a4e0: 955f03d9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a4e4: aa1d03fd    	mov	x29, x29
10a09a4e8: 955f03da    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a4ec: aa0003f6    	mov	x22, x0
10a09a4f0: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a4f4: f9404100    	ldr	x0, [x8, #0x80]
10a09a4f8: aa1703e1    	mov	x1, x23
10a09a4fc: 955f03d2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a500: aa0003e2    	mov	x2, x0
10a09a504: aa1603e0    	mov	x0, x22
10a09a508: aa1b03e1    	mov	x1, x27
10a09a50c: 955f03ce    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a510: aa1d03fd    	mov	x29, x29
10a09a514: 955f03cf    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a518: aa0003f8    	mov	x24, x0
10a09a51c: f00a4cc2    	adrp	x2, 0x11ea35000 <dyld_stub_binder+0x11ea35000>
10a09a520: 9103a042    	add	x2, x2, #0xe8
10a09a524: f90033fc    	str	x28, [sp, #0x60]
10a09a528: aa1c03e1    	mov	x1, x28
10a09a52c: 900a4123    	adrp	x3, 0x11e8be000 <dyld_stub_binder+0x11e8be000>
10a09a530: 9103a063    	add	x3, x3, #0xe8
10a09a534: 955f03c4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a538: aa1d03fd    	mov	x29, x29
10a09a53c: 955f03c5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a540: aa0003fc    	mov	x28, x0
10a09a544: aa1303e0    	mov	x0, x19
10a09a548: f9403ff3    	ldr	x19, [sp, #0x78]
10a09a54c: f90037f5    	str	x21, [sp, #0x68]
10a09a550: aa1503e1    	mov	x1, x21
10a09a554: aa1c03e2    	mov	x2, x28
10a09a558: 955f03bb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a55c: aa1a03e0    	mov	x0, x26
10a09a560: f9000bf4    	str	x20, [sp, #0x10]
10a09a564: aa1403e1    	mov	x1, x20
10a09a568: 955f03b7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a56c: 1e603908    	fsub	d8, d8, d0
10a09a570: aa1c03e0    	mov	x0, x28
10a09a574: aa1703fc    	mov	x28, x23
10a09a578: 955f03b9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a57c: aa1803e0    	mov	x0, x24
10a09a580: f94013f8    	ldr	x24, [sp, #0x20]
10a09a584: 955f03b6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a588: aa1603e0    	mov	x0, x22
10a09a58c: 955f03b4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a590: aa1903e0    	mov	x0, x25
10a09a594: 955f03b2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a598: f94017e0    	ldr	x0, [sp, #0x28]
10a09a59c: 955f03b0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a5a0: f9401be0    	ldr	x0, [sp, #0x30]
10a09a5a4: b00b06d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10a09a5a8: 955f03ad    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a5ac: f9401fe0    	ldr	x0, [sp, #0x38]
10a09a5b0: 955f03ab    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a5b4: f94023e0    	ldr	x0, [sp, #0x40]
10a09a5b8: 955f03a9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a5bc: f94027e0    	ldr	x0, [sp, #0x48]
10a09a5c0: 955f03a7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a5c4: f945eac0    	ldr	x0, [x22, #0xbd0]
10a09a5c8: aa1803e1    	mov	x1, x24
10a09a5cc: 955f039e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a5d0: aa1d03fd    	mov	x29, x29
10a09a5d4: 955f039f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a5d8: aa0003f4    	mov	x20, x0
10a09a5dc: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a5e0: f9428500    	ldr	x0, [x8, #0x508]
10a09a5e4: aa1703e1    	mov	x1, x23
10a09a5e8: 955f0397    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a5ec: aa0003e2    	mov	x2, x0
10a09a5f0: aa1403e0    	mov	x0, x20
10a09a5f4: aa1b03e1    	mov	x1, x27
10a09a5f8: 955f0393    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a5fc: aa1d03fd    	mov	x29, x29
10a09a600: 955f0394    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a604: aa0003f5    	mov	x21, x0
10a09a608: d00affe8    	adrp	x8, 0x120098000 <dyld_stub_binder+0x120098000>
10a09a60c: f946f101    	ldr	x1, [x8, #0xde0] ; likeUserHeightForWidth:withDataItem:isSpringStyle:
10a09a610: 1e604100    	fmov	d0, d8
10a09a614: aa1303e2    	mov	x2, x19
10a09a618: b94077e3    	ldr	w3, [sp, #0x74]
10a09a61c: 955f038a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a620: 1e604009    	fmov	d9, d0
10a09a624: aa1503e0    	mov	x0, x21
10a09a628: 955f038d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a62c: aa1403e0    	mov	x0, x20
10a09a630: 955f038b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a634: 1e602128    	fcmp	d9, #0.0
10a09a638: f9000ffb    	str	x27, [sp, #0x18]
10a09a63c: 54002de1    	b.ne	0x10a09abf8 <_Flutter_MMFoundation_BindContext+0x65767dc>
10a09a640: b00b0808    	adrp	x8, 0x12019b000 <dyld_stub_binder+0x12019b000>
10a09a644: f9467900    	ldr	x0, [x8, #0xcf0]
10a09a648: b00affc8    	adrp	x8, 0x120093000 <dyld_stub_binder+0x120093000>
10a09a64c: f9464501    	ldr	x1, [x8, #0xc88] ; getNickNameForDataItem:
10a09a650: aa1303e2    	mov	x2, x19
10a09a654: 955f037c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a658: aa1d03fd    	mov	x29, x29
10a09a65c: 955f037d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a660: f90027e0    	str	x0, [sp, #0x48]
10a09a664: b00affc8    	adrp	x8, 0x120093000 <dyld_stub_binder+0x120093000>
10a09a668: f9464101    	ldr	x1, [x8, #0xc80] ; cpKeyForLikeUsers
10a09a66c: aa1303e0    	mov	x0, x19
10a09a670: 955f0375    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a674: aa1d03fd    	mov	x29, x29
10a09a678: 955f0376    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a67c: aa0003f4    	mov	x20, x0
10a09a680: d101c3a0    	sub	x0, x29, #0x70
10a09a684: aa1403e1    	mov	x1, x20
10a09a688: 955e63d3    	bl	0x10f8335d4 <_UR_96F1_B25D+0x3a3c244>
10a09a68c: aa1403e0    	mov	x0, x20
10a09a690: 955f0373    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a694: d008e341    	adrp	x1, 0x11bd04000 <dyld_stub_binder+0x11bd04000>
10a09a698: 91383421    	add	x1, x1, #0xe0d
10a09a69c: d008e342    	adrp	x2, 0x11bd04000 <dyld_stub_binder+0x11bd04000>
10a09a6a0: 91396442    	add	x2, x2, #0xe59
10a09a6a4: 910243e0    	add	x0, sp, #0x90
10a09a6a8: d2800003    	mov	x3, #0x0                ; =0
10a09a6ac: 955e6481    	bl	0x10f8338b0 <_UR_96F1_B25D+0x3a3c520>
10a09a6b0: 900af0e8    	adrp	x8, 0x11feb6000 <dyld_stub_binder+0x11feb6000>
10a09a6b4: f9403d01    	ldr	x1, [x8, #0x78] ; advertiseInfo
10a09a6b8: aa1303e0    	mov	x0, x19
10a09a6bc: 955f0362    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a6c0: aa1d03fd    	mov	x29, x29
10a09a6c4: 955f0363    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a6c8: aa0003f4    	mov	x20, x0
10a09a6cc: f00afa68    	adrp	x8, 0x11ffe9000 <dyld_stub_binder+0x11ffe9000>
10a09a6d0: f9431901    	ldr	x1, [x8, #0x630] ; isFireworkCheerAd
10a09a6d4: 955f035c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a6d8: aa0003f5    	mov	x21, x0
10a09a6dc: aa1403e0    	mov	x0, x20
10a09a6e0: 955f035f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a6e4: 710002bf    	cmp	w21, #0x0
10a09a6e8: 52803008    	mov	w8, #0x180              ; =384
10a09a6ec: 52803049    	mov	w9, #0x182              ; =386
10a09a6f0: 9a881128    	csel	x8, x9, x8, ne
10a09a6f4: f90023e8    	str	x8, [sp, #0x40]
10a09a6f8: b94087e8    	ldr	w8, [sp, #0x84]
10a09a6fc: 7100011f    	cmp	w8, #0x0
10a09a700: 9e6703e0    	fmov	d0, xzr
10a09a704: 1e611001    	fmov	d1, #3.00000000
10a09a708: 1e601c29    	fcsel	d9, d1, d0, ne
10a09a70c: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a710: f9463d15    	ldr	x21, [x8, #0xc78]
10a09a714: b00b06c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a09a718: f9461919    	ldr	x25, [x8, #0xc30]
10a09a71c: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a720: f9403d1a    	ldr	x26, [x8, #0x78]
10a09a724: f945eac0    	ldr	x0, [x22, #0xbd0]
10a09a728: aa1803e1    	mov	x1, x24
10a09a72c: 955f0346    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a730: aa1d03fd    	mov	x29, x29
10a09a734: 955f0347    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a738: aa0003f4    	mov	x20, x0
10a09a73c: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a740: f9404100    	ldr	x0, [x8, #0x80]
10a09a744: aa1c03e1    	mov	x1, x28
10a09a748: 955f033f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a74c: aa0003e2    	mov	x2, x0
10a09a750: aa1403e0    	mov	x0, x20
10a09a754: aa1b03e1    	mov	x1, x27
10a09a758: 955f033b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a75c: aa1d03fd    	mov	x29, x29
10a09a760: 955f033c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a764: aa0003f7    	mov	x23, x0
10a09a768: f00a3902    	adrp	x2, 0x11e7bd000 <dyld_stub_binder+0x11e7bd000>
10a09a76c: 9132a042    	add	x2, x2, #0xca8
10a09a770: 900a4123    	adrp	x3, 0x11e8be000 <dyld_stub_binder+0x11e8be000>
10a09a774: 9103a063    	add	x3, x3, #0xe8
10a09a778: f94033e1    	ldr	x1, [sp, #0x60]
10a09a77c: 955f0332    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a780: aa1d03fd    	mov	x29, x29
10a09a784: 955f0333    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a788: aa1b03f6    	mov	x22, x27
10a09a78c: aa0003fb    	mov	x27, x0
10a09a790: aa1a03e0    	mov	x0, x26
10a09a794: f94037e1    	ldr	x1, [sp, #0x68]
10a09a798: aa1b03e2    	mov	x2, x27
10a09a79c: 955f032a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a7a0: b00aee68    	adrp	x8, 0x11fe67000 <dyld_stub_binder+0x11fe67000>
10a09a7a4: f9400901    	ldr	x1, [x8, #0x10] ; dynamicSystemFontOfSize:forModule:
10a09a7a8: aa1903e0    	mov	x0, x25
10a09a7ac: 52800022    	mov	w2, #0x1                ; =1
10a09a7b0: 955f0325    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a7b4: aa1d03fd    	mov	x29, x29
10a09a7b8: 955f0326    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a7bc: aa0003f9    	mov	x25, x0
10a09a7c0: f90047ff    	str	xzr, [sp, #0x88]
10a09a7c4: 900aed68    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
10a09a7c8: f9470101    	ldr	x1, [x8, #0xe00] ; sizeForContent:font:width:lineSpacing:lineNumber:parserType:delegate:outArrStyles:
10a09a7cc: 910223e7    	add	x7, sp, #0x88
10a09a7d0: aa1503e0    	mov	x0, x21
10a09a7d4: a9440be5    	ldp	x5, x2, [sp, #0x40]
10a09a7d8: aa1903e3    	mov	x3, x25
10a09a7dc: 1e604100    	fmov	d0, d8
10a09a7e0: 1e604121    	fmov	d1, d9
10a09a7e4: d2800004    	mov	x4, #0x0                ; =0
10a09a7e8: d2800006    	mov	x6, #0x0                ; =0
10a09a7ec: 955f0316    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a7f0: 1e604029    	fmov	d9, d1
10a09a7f4: f94047f5    	ldr	x21, [sp, #0x88]
10a09a7f8: aa1503e0    	mov	x0, x21
10a09a7fc: 955f0311    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a09a800: aa1903e0    	mov	x0, x25
10a09a804: 955f0316    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a808: aa1b03e0    	mov	x0, x27
10a09a80c: 955f0314    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a810: aa1703e0    	mov	x0, x23
10a09a814: 955f0312    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a818: aa1403e0    	mov	x0, x20
10a09a81c: 955f0310    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a820: 910243e0    	add	x0, sp, #0x90
10a09a824: 955e6424    	bl	0x10f8338b4 <_UR_96F1_B25D+0x3a3c524>
10a09a828: b00b06db    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
10a09a82c: f945eb60    	ldr	x0, [x27, #0xbd0]
10a09a830: aa1803e1    	mov	x1, x24
10a09a834: 955f0304    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a838: aa1d03fd    	mov	x29, x29
10a09a83c: 955f0305    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a840: aa0003f4    	mov	x20, x0
10a09a844: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a848: f9428500    	ldr	x0, [x8, #0x508]
10a09a84c: aa1c03e1    	mov	x1, x28
10a09a850: 955f02fd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a854: aa0003e2    	mov	x2, x0
10a09a858: aa1403e0    	mov	x0, x20
10a09a85c: aa1603e1    	mov	x1, x22
10a09a860: 955f02f9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a864: aa1d03fd    	mov	x29, x29
10a09a868: 955f02fa    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a86c: aa0003f7    	mov	x23, x0
10a09a870: d00affe8    	adrp	x8, 0x120098000 <dyld_stub_binder+0x120098000>
10a09a874: f946f501    	ldr	x1, [x8, #0xde8] ; setlikeUserHeight:forWidth:withDataItem:isSpringStyle:
10a09a878: 1e604120    	fmov	d0, d9
10a09a87c: 1e604101    	fmov	d1, d8
10a09a880: aa1303e2    	mov	x2, x19
10a09a884: b94077fa    	ldr	w26, [sp, #0x74]
10a09a888: aa1a03e3    	mov	x3, x26
10a09a88c: 955f02ee    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a890: aa1703e0    	mov	x0, x23
10a09a894: 955f02f2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a898: aa1403e0    	mov	x0, x20
10a09a89c: 955f02f0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a8a0: aa1303f9    	mov	x25, x19
10a09a8a4: aa1b03f3    	mov	x19, x27
10a09a8a8: f945eb60    	ldr	x0, [x27, #0xbd0]
10a09a8ac: aa1803e1    	mov	x1, x24
10a09a8b0: 955f02e5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a8b4: aa1d03fd    	mov	x29, x29
10a09a8b8: 955f02e6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a8bc: aa0003f4    	mov	x20, x0
10a09a8c0: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09a8c4: f9428500    	ldr	x0, [x8, #0x508]
10a09a8c8: aa1c03e1    	mov	x1, x28
10a09a8cc: 955f02de    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a8d0: aa0003e2    	mov	x2, x0
10a09a8d4: aa1403e0    	mov	x0, x20
10a09a8d8: aa1603e1    	mov	x1, x22
10a09a8dc: 955f02da    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a8e0: aa1d03fd    	mov	x29, x29
10a09a8e4: 955f02db    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a8e8: aa0003f7    	mov	x23, x0
10a09a8ec: d00affe8    	adrp	x8, 0x120098000 <dyld_stub_binder+0x120098000>
10a09a8f0: f946f901    	ldr	x1, [x8, #0xdf0] ; setLayoutStylesOfLikeUser:withDataItem:width:isSpringStyle:
10a09a8f4: aa1503e2    	mov	x2, x21
10a09a8f8: aa1903e3    	mov	x3, x25
10a09a8fc: 1e604100    	fmov	d0, d8
10a09a900: aa1a03e4    	mov	x4, x26
10a09a904: 955f02d0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a908: aa1503e0    	mov	x0, x21
10a09a90c: 955f02d4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a910: aa1703e0    	mov	x0, x23
10a09a914: 955f02d2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a918: aa1403e0    	mov	x0, x20
10a09a91c: 955f02d0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a920: 910243e0    	add	x0, sp, #0x90
10a09a924: 955e63e5    	bl	0x10f8338b8 <_UR_96F1_B25D+0x3a3c528>
10a09a928: d101c3a0    	sub	x0, x29, #0x70
10a09a92c: 955e632b    	bl	0x10f8335d8 <_UR_96F1_B25D+0x3a3c248>
10a09a930: f94027e0    	ldr	x0, [sp, #0x48]
10a09a934: 955f02ca    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a938: 140000b1    	b	0x10a09abfc <_Flutter_MMFoundation_BindContext+0x65767e0>
10a09a93c: b00b0808    	adrp	x8, 0x12019b000 <dyld_stub_binder+0x12019b000>
10a09a940: f9467900    	ldr	x0, [x8, #0xcf0]
10a09a944: d00affe8    	adrp	x8, 0x120098000 <dyld_stub_binder+0x120098000>
10a09a948: f946fd01    	ldr	x1, [x8, #0xdf8] ; getCommentIndexForDataItem:RowIndex:
10a09a94c: aa1303e2    	mov	x2, x19
10a09a950: aa1403e3    	mov	x3, x20
10a09a954: 955f02bc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a958: 9e6703e8    	fmov	d8, xzr
10a09a95c: 92f00008    	mov	x8, #0x7fffffffffffffff ; =9223372036854775807
10a09a960: eb08001f    	cmp	x0, x8
10a09a964: 54001fc0    	b.eq	0x10a09ad5c <_Flutter_MMFoundation_BindContext+0x6576940>
10a09a968: aa0003f7    	mov	x23, x0
10a09a96c: b00af108    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
10a09a970: f9475101    	ldr	x1, [x8, #0xea0] ; commentUsers
10a09a974: aa1303e0    	mov	x0, x19
10a09a978: 955f02b3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a97c: aa1d03fd    	mov	x29, x29
10a09a980: 955f02b4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a984: aa0003f4    	mov	x20, x0
10a09a988: 900aed08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10a09a98c: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
10a09a990: aa1703e2    	mov	x2, x23
10a09a994: 955f02ac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a998: aa1d03fd    	mov	x29, x29
10a09a99c: 955f02ad    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a9a0: aa0003f6    	mov	x22, x0
10a09a9a4: aa1403e0    	mov	x0, x20
10a09a9a8: 955f02ad    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a9ac: d00aed08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a09a9b0: f9471101    	ldr	x1, [x8, #0xe20] ; username
10a09a9b4: aa1603e0    	mov	x0, x22
10a09a9b8: 955f02a3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a9bc: aa1d03fd    	mov	x29, x29
10a09a9c0: 955f02a4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a9c4: aa0003f4    	mov	x20, x0
10a09a9c8: b00b0348    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a09a9cc: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10a09a9d0: 955f029d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a9d4: aa0003f5    	mov	x21, x0
10a09a9d8: aa1403e0    	mov	x0, x20
10a09a9dc: 955f02a0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09a9e0: b4000e75    	cbz	x21, 0x10a09abac <_Flutter_MMFoundation_BindContext+0x6576790>
10a09a9e4: d00aee08    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
10a09a9e8: f9439d01    	ldr	x1, [x8, #0x738] ; contentObj
10a09a9ec: aa1303e0    	mov	x0, x19
10a09a9f0: 955f0295    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09a9f4: aa1d03fd    	mov	x29, x29
10a09a9f8: 955f0296    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09a9fc: aa0003f4    	mov	x20, x0
10a09aa00: b00b0388    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a09aa04: f941c901    	ldr	x1, [x8, #0x390] ; type
10a09aa08: 955f028f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09aa0c: 7100541f    	cmp	w0, #0x15
10a09aa10: 1a9f17e2    	cset	w2, eq
10a09aa14: 900afb28    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
10a09aa18: f9438101    	ldr	x1, [x8, #0x700] ; setIsHBComment:
10a09aa1c: aa1603e0    	mov	x0, x22
10a09aa20: 955f0289    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09aa24: aa1403e0    	mov	x0, x20
10a09aa28: 955f028d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09aa2c: d00b0808    	adrp	x8, 0x12019c000 <dyld_stub_binder+0x12019c000>
10a09aa30: f9455915    	ldr	x21, [x8, #0xab0]
10a09aa34: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09aa38: b90087f8    	str	w24, [sp, #0x84]
10a09aa3c: f9403d18    	ldr	x24, [x8, #0x78]
10a09aa40: b00b06c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a09aa44: f945e900    	ldr	x0, [x8, #0xbd0]
10a09aa48: d00b0328    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a09aa4c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a09aa50: 955f027d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09aa54: aa1d03fd    	mov	x29, x29
10a09aa58: 955f027e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09aa5c: aa0003f4    	mov	x20, x0
10a09aa60: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09aa64: f9404100    	ldr	x0, [x8, #0x80]
10a09aa68: b00b0328    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a09aa6c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a09aa70: 955f0275    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09aa74: aa0003e2    	mov	x2, x0
10a09aa78: f00aece8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a09aa7c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a09aa80: aa1403e0    	mov	x0, x20
10a09aa84: 955f0270    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09aa88: aa1d03fd    	mov	x29, x29
10a09aa8c: 955f0271    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09aa90: aa0003f9    	mov	x25, x0
10a09aa94: b00aed08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a09aa98: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
10a09aa9c: 900a4122    	adrp	x2, 0x11e8be000 <dyld_stub_binder+0x11e8be000>
10a09aaa0: 91032042    	add	x2, x2, #0xc8
10a09aaa4: 900a4123    	adrp	x3, 0x11e8be000 <dyld_stub_binder+0x11e8be000>
10a09aaa8: 9103a063    	add	x3, x3, #0xe8
10a09aaac: 955f0266    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09aab0: aa1d03fd    	mov	x29, x29
10a09aab4: 955f0267    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09aab8: aa0003fa    	mov	x26, x0
10a09aabc: d00aed08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a09aac0: f9400101    	ldr	x1, [x8]
10a09aac4: aa1803e0    	mov	x0, x24
10a09aac8: aa1a03e2    	mov	x2, x26
10a09aacc: 955f025e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09aad0: d00affe8    	adrp	x8, 0x120098000 <dyld_stub_binder+0x120098000>
10a09aad4: f9470101    	ldr	x1, [x8, #0xe00] ; getVisibleHeightWithCommentInfo:withMaxWidth:fromDataItem:pageContext:
10a09aad8: aa1503e0    	mov	x0, x21
10a09aadc: aa1603e2    	mov	x2, x22
10a09aae0: aa1303e3    	mov	x3, x19
10a09aae4: aa1b03e4    	mov	x4, x27
10a09aae8: 955f0257    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09aaec: 9e6703e1    	fmov	d1, xzr
10a09aaf0: 1e612808    	fadd	d8, d0, d1
10a09aaf4: aa1a03e0    	mov	x0, x26
10a09aaf8: 955f0259    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09aafc: aa1903e0    	mov	x0, x25
10a09ab00: 955f0257    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09ab04: aa1403e0    	mov	x0, x20
10a09ab08: 955f0255    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09ab0c: 900aee14    	adrp	x20, 0x11fe5a000 <dyld_stub_binder+0x11fe5a000>
10a09ab10: b94087e8    	ldr	w8, [sp, #0x84]
10a09ab14: 34000188    	cbz	w8, 0x10a09ab44 <_Flutter_MMFoundation_BindContext+0x6576728>
10a09ab18: 1e629009    	fmov	d9, #5.00000000
10a09ab1c: 1e692900    	fadd	d0, d8, d9
10a09ab20: f10002ff    	cmp	x23, #0x0
10a09ab24: 1e680c08    	fcsel	d8, d0, d8, eq
10a09ab28: f9465681    	ldr	x1, [x20, #0xca8] ; commentCount
10a09ab2c: aa1303e0    	mov	x0, x19
10a09ab30: 955f0245    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ab34: 51000408    	sub	w8, w0, #0x1
10a09ab38: 1e692900    	fadd	d0, d8, d9
10a09ab3c: eb28c2ff    	cmp	x23, w8, sxtw
10a09ab40: 1e680c08    	fcsel	d8, d0, d8, eq
10a09ab44: f10002ff    	cmp	x23, #0x0
10a09ab48: 52000388    	eor	w8, w28, #0x1
10a09ab4c: 1a9f0508    	csinc	w8, w8, wzr, eq
10a09ab50: b00b06d5    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
10a09ab54: b00af238    	adrp	x24, 0x11fedf000 <dyld_stub_binder+0x11fedf000>
10a09ab58: 370000e8    	tbnz	w8, #0x0, 0x10a09ab74 <_Flutter_MMFoundation_BindContext+0x6576758>
10a09ab5c: f9461aa0    	ldr	x0, [x21, #0xc30]
10a09ab60: f944cf01    	ldr	x1, [x24, #0x998] ; dynamicLength:forModule:
10a09ab64: 1e621000    	fmov	d0, #4.00000000
10a09ab68: 52800022    	mov	w2, #0x1                ; =1
10a09ab6c: 955f0236    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ab70: 1e602908    	fadd	d8, d8, d0
10a09ab74: f9465681    	ldr	x1, [x20, #0xca8] ; commentCount
10a09ab78: aa1303e0    	mov	x0, x19
10a09ab7c: 955f0232    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ab80: 51000408    	sub	w8, w0, #0x1
10a09ab84: eb28c2ff    	cmp	x23, w8, sxtw
10a09ab88: 1a9f0788    	csinc	w8, w28, wzr, eq
10a09ab8c: 37000308    	tbnz	w8, #0x0, 0x10a09abec <_Flutter_MMFoundation_BindContext+0x65767d0>
10a09ab90: f9461aa0    	ldr	x0, [x21, #0xc30]
10a09ab94: f944cf01    	ldr	x1, [x24, #0x998] ; dynamicLength:forModule:
10a09ab98: 1e649000    	fmov	d0, #10.00000000
10a09ab9c: 52800022    	mov	w2, #0x1                ; =1
10a09aba0: 955f0229    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09aba4: 1e602908    	fadd	d8, d8, d0
10a09aba8: 14000011    	b	0x10a09abec <_Flutter_MMFoundation_BindContext+0x65767d0>
10a09abac: b00b06c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a09abb0: f9453500    	ldr	x0, [x8, #0xa68]
10a09abb4: f00aece8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a09abb8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a09abbc: b00a4d28    	adrp	x8, 0x11ea3f000 <dyld_stub_binder+0x11ea3f000>
10a09abc0: 91202108    	add	x8, x8, #0x808
10a09abc4: f90003e8    	str	x8, [sp]
10a09abc8: d008e345    	adrp	x5, 0x11bd04000 <dyld_stub_binder+0x11bd04000>
10a09abcc: 913a70a5    	add	x5, x5, #0xe9c
10a09abd0: d008e347    	adrp	x7, 0x11bd04000 <dyld_stub_binder+0x11bd04000>
10a09abd4: 913834e7    	add	x7, x7, #0xe0d
10a09abd8: 52800082    	mov	w2, #0x4                ; =4
10a09abdc: d2800003    	mov	x3, #0x0                ; =0
10a09abe0: 52800004    	mov	w4, #0x0                ; =0
10a09abe4: 52802446    	mov	w6, #0x122              ; =290
10a09abe8: 955f0217    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09abec: aa1603e0    	mov	x0, x22
10a09abf0: 955f021b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09abf4: 1400005a    	b	0x10a09ad5c <_Flutter_MMFoundation_BindContext+0x6576940>
10a09abf8: aa1603f3    	mov	x19, x22
10a09abfc: f94037fa    	ldr	x26, [sp, #0x68]
10a09ac00: f9402ffb    	ldr	x27, [sp, #0x58]
10a09ac04: b94057f9    	ldr	w25, [sp, #0x54]
10a09ac08: 34000219    	cbz	w25, 0x10a09ac48 <_Flutter_MMFoundation_BindContext+0x657682c>
10a09ac0c: f00b0808    	adrp	x8, 0x12019d000 <dyld_stub_binder+0x12019d000>
10a09ac10: f9449500    	ldr	x0, [x8, #0x928]
10a09ac14: 900afa28    	adrp	x8, 0x11ffde000 <dyld_stub_binder+0x11ffde000>
10a09ac18: f9421901    	ldr	x1, [x8, #0x430] ; topAreaHeight
10a09ac1c: 955f020a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ac20: 1e602928    	fadd	d8, d9, d0
10a09ac24: b00b06dc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10a09ac28: f9461b80    	ldr	x0, [x28, #0xc30]
10a09ac2c: b00af228    	adrp	x8, 0x11fedf000 <dyld_stub_binder+0x11fedf000>
10a09ac30: f944cd01    	ldr	x1, [x8, #0x998] ; dynamicLength:forModule:
10a09ac34: 1e641000    	fmov	d0, #8.00000000
10a09ac38: 52800022    	mov	w2, #0x1                ; =1
10a09ac3c: 955f0202    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ac40: 1e602908    	fadd	d8, d8, d0
10a09ac44: 14000035    	b	0x10a09ad18 <_Flutter_MMFoundation_BindContext+0x65768fc>
10a09ac48: aa1c03f4    	mov	x20, x28
10a09ac4c: b00b06dc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10a09ac50: f9461b96    	ldr	x22, [x28, #0xc30]
10a09ac54: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09ac58: f9403d17    	ldr	x23, [x8, #0x78]
10a09ac5c: f945ea60    	ldr	x0, [x19, #0xbd0]
10a09ac60: aa1803e1    	mov	x1, x24
10a09ac64: 955f01f8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ac68: aa1d03fd    	mov	x29, x29
10a09ac6c: 955f01f9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09ac70: aa0003f5    	mov	x21, x0
10a09ac74: d00b06c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a09ac78: f9404100    	ldr	x0, [x8, #0x80]
10a09ac7c: aa1403e1    	mov	x1, x20
10a09ac80: 955f01f1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ac84: aa0003e2    	mov	x2, x0
10a09ac88: aa1503e0    	mov	x0, x21
10a09ac8c: f9400fe1    	ldr	x1, [sp, #0x18]
10a09ac90: 955f01ed    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ac94: aa1d03fd    	mov	x29, x29
10a09ac98: 955f01ee    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09ac9c: aa0003f4    	mov	x20, x0
10a09aca0: b94087e8    	ldr	w8, [sp, #0x84]
10a09aca4: 36000088    	tbz	w8, #0x0, 0x10a09acb4 <_Flutter_MMFoundation_BindContext+0x6576898>
10a09aca8: b00a4d22    	adrp	x2, 0x11ea3f000 <dyld_stub_binder+0x11ea3f000>
10a09acac: 911fa042    	add	x2, x2, #0x7e8
10a09acb0: 14000003    	b	0x10a09acbc <_Flutter_MMFoundation_BindContext+0x65768a0>
10a09acb4: b00a4982    	adrp	x2, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10a09acb8: 9100a042    	add	x2, x2, #0x28
10a09acbc: 900a4123    	adrp	x3, 0x11e8be000 <dyld_stub_binder+0x11e8be000>
10a09acc0: 9103a063    	add	x3, x3, #0xe8
10a09acc4: aa1403e0    	mov	x0, x20
10a09acc8: f94033e1    	ldr	x1, [sp, #0x60]
10a09accc: 955f01de    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09acd0: aa1d03fd    	mov	x29, x29
10a09acd4: 955f01df    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09acd8: aa0003f8    	mov	x24, x0
10a09acdc: aa1703e0    	mov	x0, x23
10a09ace0: aa1a03e1    	mov	x1, x26
10a09ace4: aa1803e2    	mov	x2, x24
10a09ace8: 955f01d7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09acec: aa1603e0    	mov	x0, x22
10a09acf0: f9400be1    	ldr	x1, [sp, #0x10]
10a09acf4: 955f01d4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09acf8: 1e601001    	fmov	d1, #2.00000000
10a09acfc: 1f412408    	fmadd	d8, d0, d1, d9
10a09ad00: aa1803e0    	mov	x0, x24
10a09ad04: 955f01d6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09ad08: aa1403e0    	mov	x0, x20
10a09ad0c: 955f01d4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09ad10: aa1503e0    	mov	x0, x21
10a09ad14: 955f01d2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09ad18: f9403ff3    	ldr	x19, [sp, #0x78]
10a09ad1c: 9e6703e0    	fmov	d0, xzr
10a09ad20: 1e602908    	fadd	d8, d8, d0
10a09ad24: 900aee08    	adrp	x8, 0x11fe5a000 <dyld_stub_binder+0x11fe5a000>
10a09ad28: f9465501    	ldr	x1, [x8, #0xca8] ; commentCount
10a09ad2c: aa1303e0    	mov	x0, x19
10a09ad30: 955f01c5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ad34: 7100001f    	cmp	w0, #0x0
10a09ad38: 1a9fd728    	csinc	w8, w25, wzr, le
10a09ad3c: 37000108    	tbnz	w8, #0x0, 0x10a09ad5c <_Flutter_MMFoundation_BindContext+0x6576940>
10a09ad40: f9461b80    	ldr	x0, [x28, #0xc30]
10a09ad44: b00af228    	adrp	x8, 0x11fedf000 <dyld_stub_binder+0x11fedf000>
10a09ad48: f944cd01    	ldr	x1, [x8, #0x998] ; dynamicLength:forModule:
10a09ad4c: 1e649000    	fmov	d0, #10.00000000
10a09ad50: 52800022    	mov	w2, #0x1                ; =1
10a09ad54: 955f01bc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ad58: 1e602908    	fadd	d8, d8, d0
10a09ad5c: aa1b03e0    	mov	x0, x27
10a09ad60: 955f01bf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09ad64: aa1303e0    	mov	x0, x19
10a09ad68: 955f01bd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09ad6c: 1e604100    	fmov	d0, d8
10a09ad70: a9537bfd    	ldp	x29, x30, [sp, #0x130]
10a09ad74: a9524ff4    	ldp	x20, x19, [sp, #0x120]
10a09ad78: a95157f6    	ldp	x22, x21, [sp, #0x110]
10a09ad7c: a9505ff8    	ldp	x24, x23, [sp, #0x100]
10a09ad80: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
10a09ad84: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
10a09ad88: 6d4d23e9    	ldp	d9, d8, [sp, #0xd0]
10a09ad8c: 910503ff    	add	sp, sp, #0x140
10a09ad90: d65f03c0    	ret
