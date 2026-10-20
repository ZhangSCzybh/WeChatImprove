
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104aeda58: d10383ff    	sub	sp, sp, #0xe0
104aeda5c: 6d062beb    	stp	d11, d10, [sp, #0x60]
104aeda60: 6d0723e9    	stp	d9, d8, [sp, #0x70]
104aeda64: a9086ffc    	stp	x28, x27, [sp, #0x80]
104aeda68: a90967fa    	stp	x26, x25, [sp, #0x90]
104aeda6c: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
104aeda70: a90b57f6    	stp	x22, x21, [sp, #0xb0]
104aeda74: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
104aeda78: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
104aeda7c: 910343fd    	add	x29, sp, #0xd0
104aeda80: aa0403f5    	mov	x21, x4
104aeda84: aa0303f6    	mov	x22, x3
104aeda88: aa0203f7    	mov	x23, x2
104aeda8c: aa0003f3    	mov	x19, x0
104aeda90: b00e0a88    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104aeda94: 52800029    	mov	w9, #0x1                ; =1
104aeda98: 3911d909    	strb	w9, [x8, #0x476]
104aeda9c: f9400401    	ldr	x1, [x0, #0x8]
104aedaa0: 910143e0    	add	x0, sp, #0x50
104aedaa4: 94c47e23    	bl	0x107c0d330 <_Flutter_MMFoundation_BindContext+0x40e8f14>
104aedaa8: d00db428    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aedaac: f9454514    	ldr	x20, [x8, #0xa88]
104aedab0: d00db43b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
104aedab4: f9458b60    	ldr	x0, [x27, #0xb10]
104aedab8: f00db0a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104aedabc: f9479518    	ldr	x24, [x8, #0xf28] ; numberWithBool:
104aedac0: aa1803e1    	mov	x1, x24
104aedac4: aa1703e2    	mov	x2, x23
104aedac8: 94c4e59d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedacc: aa1d03fd    	mov	x29, x29
104aedad0: 94c4e59e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedad4: aa0003f9    	mov	x25, x0
104aedad8: f9458b60    	ldr	x0, [x27, #0xb10]
104aedadc: aa1803e1    	mov	x1, x24
104aedae0: aa1603e2    	mov	x2, x22
104aedae4: 94c4e596    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedae8: aa1d03fd    	mov	x29, x29
104aedaec: 94c4e597    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedaf0: aa0003fa    	mov	x26, x0
104aedaf4: f9458b7b    	ldr	x27, [x27, #0xb10]
104aedaf8: b00db448    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104aedafc: f9409900    	ldr	x0, [x8, #0x130] ; �!- 
104aedb00: f00d9ce8    	adrp	x8, 0x11fe8c000 <dyld_stub_binder+0x11fe8c000>
104aedb04: f944fd01    	ldr	x1, [x8, #0x9f8] ; isElderModeOn
104aedb08: 94c4e58d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedb0c: aa0003e2    	mov	x2, x0
104aedb10: aa1b03e0    	mov	x0, x27
104aedb14: aa1803e1    	mov	x1, x24
104aedb18: 94c4e589    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedb1c: aa1d03fd    	mov	x29, x29
104aedb20: 94c4e58a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedb24: aa0003f8    	mov	x24, x0
104aedb28: b00db0e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104aedb2c: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104aedb30: a90083fa    	stp	x26, x0, [sp, #0x8]
104aedb34: f90003f9    	str	x25, [sp]
104aedb38: d00cce22    	adrp	x2, 0x11e4b3000 <dyld_stub_binder+0x11e4b3000>
104aedb3c: 911aa042    	add	x2, x2, #0x6a8
104aedb40: aa1403e0    	mov	x0, x20
104aedb44: 94c4e57e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedb48: aa1d03fd    	mov	x29, x29
104aedb4c: 94c4e57f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedb50: aa0003f4    	mov	x20, x0
104aedb54: aa1803e0    	mov	x0, x24
104aedb58: 94c4e57f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aedb5c: aa1a03e0    	mov	x0, x26
104aedb60: 94c4e57d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aedb64: aa1903e0    	mov	x0, x25
104aedb68: 94c4e57b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aedb6c: 34000735    	cbz	w21, 0x104aedc50 <_Flutter_MMFoundation_BindContext+0xfc9834>
104aedb70: f9400a60    	ldr	x0, [x19, #0x10]
104aedb74: f00db0a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104aedb78: f947f918    	ldr	x24, [x8, #0xff0] ; objectForKeyedSubscript:
104aedb7c: aa1803e1    	mov	x1, x24
104aedb80: aa1403e2    	mov	x2, x20
104aedb84: 94c4e56e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedb88: aa1d03fd    	mov	x29, x29
104aedb8c: 94c4e56f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedb90: aa0003f9    	mov	x25, x0
104aedb94: 94c4e570    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aedb98: b40005d9    	cbz	x25, 0x104aedc50 <_Flutter_MMFoundation_BindContext+0xfc9834>
104aedb9c: d00db428    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aedba0: f9453515    	ldr	x21, [x8, #0xa68] ; �gH 
104aedba4: 900da4c8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104aedba8: f947b901    	ldr	x1, [x8, #0xf70] ; bubbleName
104aedbac: aa1303e0    	mov	x0, x19
104aedbb0: 94c4e563    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedbb4: aa1d03fd    	mov	x29, x29
104aedbb8: 94c4e564    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedbbc: aa0003f6    	mov	x22, x0
104aedbc0: d00db0e8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104aedbc4: f941c901    	ldr	x1, [x8, #0x390] ; type
104aedbc8: aa1303e0    	mov	x0, x19
104aedbcc: 94c4e55c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedbd0: aa0003f7    	mov	x23, x0
104aedbd4: 900db0c8    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
104aedbd8: f944cd01    	ldr	x1, [x8, #0x998] ; position
104aedbdc: aa1303e0    	mov	x0, x19
104aedbe0: 94c4e557    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedbe4: 900d9a68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104aedbe8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104aedbec: a901d3e0    	stp	x0, x20, [sp, #0x18]
104aedbf0: a900dff6    	stp	x22, x23, [sp, #0x8]
104aedbf4: 900ce5a8    	adrp	x8, 0x11e7a1000 <dyld_stub_binder+0x11e7a1000>
104aedbf8: 9126a108    	add	x8, x8, #0x9a8
104aedbfc: f90003e8    	str	x8, [sp]
104aedc00: d00b6845    	adrp	x5, 0x11b7f7000 <dyld_stub_binder+0x11b7f7000>
104aedc04: 9108e0a5    	add	x5, x5, #0x238
104aedc08: d00b6847    	adrp	x7, 0x11b7f7000 <dyld_stub_binder+0x11b7f7000>
104aedc0c: 91093ce7    	add	x7, x7, #0x24f
104aedc10: aa1503e0    	mov	x0, x21
104aedc14: 52800022    	mov	w2, #0x1                ; =1
104aedc18: d2800003    	mov	x3, #0x0                ; =0
104aedc1c: 52800004    	mov	w4, #0x0                ; =0
104aedc20: 52800866    	mov	w6, #0x43               ; =67
104aedc24: 94c4e546    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedc28: aa1603e0    	mov	x0, x22
104aedc2c: 94c4e54a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aedc30: f9400a60    	ldr	x0, [x19, #0x10]
104aedc34: aa1803e1    	mov	x1, x24
104aedc38: aa1403e2    	mov	x2, x20
104aedc3c: 94c4e540    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedc40: aa1d03fd    	mov	x29, x29
104aedc44: 94c4e541    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedc48: aa0003fa    	mov	x26, x0
104aedc4c: 1400011d    	b	0x104aee0c0 <_Flutter_MMFoundation_BindContext+0xfc9ca4>
104aedc50: 900da4c8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104aedc54: f947bd01    	ldr	x1, [x8, #0xf78] ; resolvedBubbleImage:isDarkMode:
104aedc58: aa1303e0    	mov	x0, x19
104aedc5c: aa1703e2    	mov	x2, x23
104aedc60: aa1603e3    	mov	x3, x22
104aedc64: 94c4e536    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedc68: aa1d03fd    	mov	x29, x29
104aedc6c: 94c4e537    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedc70: b4000840    	cbz	x0, 0x104aedd78 <_Flutter_MMFoundation_BindContext+0xfc995c>
104aedc74: aa0003f9    	mov	x25, x0
104aedc78: f9001bf4    	str	x20, [sp, #0x30]
104aedc7c: b9003ff5    	str	w21, [sp, #0x3c]
104aedc80: f00db448    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
104aedc84: f9452516    	ldr	x22, [x8, #0xa48]
104aedc88: d00db428    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aedc8c: f9470100    	ldr	x0, [x8, #0xe00] ; �*c 
104aedc90: f00d9ce8    	adrp	x8, 0x11fe8c000 <dyld_stub_binder+0x11fe8c000>
104aedc94: f9422d01    	ldr	x1, [x8, #0x458] ; currentInterfaceStyle
104aedc98: 94c4e529    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedc9c: aa0003e2    	mov	x2, x0
104aedca0: 900d9da8    	adrp	x8, 0x11fea1000 <dyld_stub_binder+0x11fea1000>
104aedca4: f9446501    	ldr	x1, [x8, #0x8c8] ; traitCollectionWithUserInterfaceStyle:
104aedca8: aa1603e0    	mov	x0, x22
104aedcac: 94c4e524    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedcb0: aa1d03fd    	mov	x29, x29
104aedcb4: 94c4e525    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedcb8: aa0003f6    	mov	x22, x0
104aedcbc: b00db528    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
104aedcc0: f945c900    	ldr	x0, [x8, #0xb90]
104aedcc4: 94c4e527    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104aedcc8: aa0003f8    	mov	x24, x0
104aedccc: 900da4c8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104aedcd0: f947c101    	ldr	x1, [x8, #0xf80] ; configurationWithTraitCollection:
104aedcd4: f90027f6    	str	x22, [sp, #0x48]
104aedcd8: aa1603e2    	mov	x2, x22
104aedcdc: 94c4e518    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedce0: aa1d03fd    	mov	x29, x29
104aedce4: 94c4e519    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedce8: aa0003f6    	mov	x22, x0
104aedcec: aa1803e0    	mov	x0, x24
104aedcf0: 94c4e519    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aedcf4: 900da4c8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104aedcf8: f947c501    	ldr	x1, [x8, #0xf88] ; imageAsset
104aedcfc: aa1903e0    	mov	x0, x25
104aedd00: 94c4e50f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedd04: aa1d03fd    	mov	x29, x29
104aedd08: 94c4e510    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedd0c: aa0003fa    	mov	x26, x0
104aedd10: f00d9bc8    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
104aedd14: f9422d01    	ldr	x1, [x8, #0x458] ; imageWithConfiguration:
104aedd18: f90023f6    	str	x22, [sp, #0x40]
104aedd1c: aa1603e2    	mov	x2, x22
104aedd20: 94c4e507    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedd24: aa1d03fd    	mov	x29, x29
104aedd28: 94c4e508    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedd2c: aa0003f8    	mov	x24, x0
104aedd30: aa1903e0    	mov	x0, x25
104aedd34: 94c4e508    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aedd38: aa1a03e0    	mov	x0, x26
104aedd3c: 94c4e506    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aedd40: 900db0c8    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
104aedd44: f944cd19    	ldr	x25, [x8, #0x998] ; position
104aedd48: aa1303e0    	mov	x0, x19
104aedd4c: aa1903e1    	mov	x1, x25
104aedd50: 94c4e4fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedd54: b00db0fc    	adrp	x28, 0x12010a000 <dyld_stub_binder+0x12010a000>
104aedd58: f00d9a97    	adrp	x23, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104aedd5c: f00d9d35    	adrp	x21, 0x11fe94000 <dyld_stub_binder+0x11fe94000>
104aedd60: 900d9eb6    	adrp	x22, 0x11fec1000 <dyld_stub_binder+0x11fec1000>
104aedd64: b40000e0    	cbz	x0, 0x104aedd80 <_Flutter_MMFoundation_BindContext+0xfc9964>
104aedd68: aa1703f4    	mov	x20, x23
104aedd6c: aa1503f7    	mov	x23, x21
104aedd70: d280001a    	mov	x26, #0x0               ; =0
104aedd74: 14000023    	b	0x104aede00 <_Flutter_MMFoundation_BindContext+0xfc99e4>
104aedd78: d280001a    	mov	x26, #0x0               ; =0
104aedd7c: 140000d1    	b	0x104aee0c0 <_Flutter_MMFoundation_BindContext+0xfc9ca4>
104aedd80: f944279a    	ldr	x26, [x28, #0x848] ; size
104aedd84: aa1803e0    	mov	x0, x24
104aedd88: aa1a03e1    	mov	x1, x26
104aedd8c: 94c4e4ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedd90: 1e604008    	fmov	d8, d0
104aedd94: aa1803e0    	mov	x0, x24
104aedd98: aa1a03e1    	mov	x1, x26
104aedd9c: 94c4e4e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedda0: 1e604023    	fmov	d3, d1
104aedda4: aa1703f4    	mov	x20, x23
104aedda8: f94552e1    	ldr	x1, [x23, #0xaa0] ; croppedImage:
104aeddac: 9e6703e0    	fmov	d0, xzr
104aeddb0: 9e6703e1    	fmov	d1, xzr
104aeddb4: aa1803e0    	mov	x0, x24
104aeddb8: 1e604102    	fmov	d2, d8
104aeddbc: 94c4e4e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aeddc0: aa1d03fd    	mov	x29, x29
104aeddc4: 94c4e4e1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aeddc8: aa0003fb    	mov	x27, x0
104aeddcc: aa1503f7    	mov	x23, x21
104aeddd0: f94396a1    	ldr	x1, [x21, #0x728] ; edgeInsets
104aeddd4: aa1303e0    	mov	x0, x19
104aeddd8: 94c4e4d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedddc: f940a6c1    	ldr	x1, [x22, #0x148] ; resizableImageWithCapInsets:resizingMode:
104aedde0: aa1b03e0    	mov	x0, x27
104aedde4: 52800022    	mov	w2, #0x1                ; =1
104aedde8: 94c4e4d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aeddec: aa1d03fd    	mov	x29, x29
104aeddf0: 94c4e4d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aeddf4: aa0003fa    	mov	x26, x0
104aeddf8: aa1b03e0    	mov	x0, x27
104aeddfc: 94c4e4d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aede00: aa1303e0    	mov	x0, x19
104aede04: aa1903e1    	mov	x1, x25
104aede08: 94c4e4cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aede0c: f100041f    	cmp	x0, #0x1
104aede10: 54000581    	b.ne	0x104aedec0 <_Flutter_MMFoundation_BindContext+0xfc9aa4>
104aede14: f9442781    	ldr	x1, [x28, #0x848] ; size
104aede18: aa1803e0    	mov	x0, x24
104aede1c: 94c4e4c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aede20: 1e604008    	fmov	d8, d0
104aede24: f94396fb    	ldr	x27, [x23, #0x728] ; setAppMsgContent:
104aede28: aa1303e0    	mov	x0, x19
104aede2c: aa1b03e1    	mov	x1, x27
104aede30: 94c4e4c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aede34: 1e604003    	fmov	d3, d0
104aede38: f9455281    	ldr	x1, [x20, #0xaa0]
104aede3c: 9e6703e0    	fmov	d0, xzr
104aede40: 9e6703e1    	fmov	d1, xzr
104aede44: aa1803e0    	mov	x0, x24
104aede48: 1e604102    	fmov	d2, d8
104aede4c: 94c4e4bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aede50: aa1d03fd    	mov	x29, x29
104aede54: 94c4e4bd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aede58: aa0003fc    	mov	x28, x0
104aede5c: aa1a03e0    	mov	x0, x26
104aede60: 94c4e4bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aede64: aa1303e0    	mov	x0, x19
104aede68: aa1b03e1    	mov	x1, x27
104aede6c: 94c4e4b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aede70: 1e604008    	fmov	d8, d0
104aede74: aa1303e0    	mov	x0, x19
104aede78: aa1b03e1    	mov	x1, x27
104aede7c: 94c4e4b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aede80: 1e604029    	fmov	d9, d1
104aede84: aa1303e0    	mov	x0, x19
104aede88: aa1b03e1    	mov	x1, x27
104aede8c: 94c4e4ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aede90: f940a6c1    	ldr	x1, [x22, #0x148] ; resizableImageWithCapInsets:resizingMode:
104aede94: 9e6703e2    	fmov	d2, xzr
104aede98: aa1c03e0    	mov	x0, x28
104aede9c: 1e604100    	fmov	d0, d8
104aedea0: 1e604121    	fmov	d1, d9
104aedea4: 52800022    	mov	w2, #0x1                ; =1
104aedea8: 94c4e4a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedeac: aa1d03fd    	mov	x29, x29
104aedeb0: 94c4e4a6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedeb4: aa0003fa    	mov	x26, x0
104aedeb8: aa1c03e0    	mov	x0, x28
104aedebc: 94c4e4a6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aedec0: f9401bf4    	ldr	x20, [sp, #0x30]
104aedec4: aa1303e0    	mov	x0, x19
104aedec8: aa1903e1    	mov	x1, x25
104aedecc: 94c4e49c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aeded0: f100081f    	cmp	x0, #0x2
104aeded4: 54000561    	b.ne	0x104aedf80 <_Flutter_MMFoundation_BindContext+0xfc9b64>
104aeded8: f94396fb    	ldr	x27, [x23, #0x728] ; setAppMsgContent:
104aededc: aa1303e0    	mov	x0, x19
104aedee0: aa1b03e1    	mov	x1, x27
104aedee4: 94c4e496    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedee8: 1e604008    	fmov	d8, d0
104aedeec: b00db0e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104aedef0: f9442501    	ldr	x1, [x8, #0x848] ; size
104aedef4: aa1803e0    	mov	x0, x24
104aedef8: 94c4e491    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedefc: 1e604002    	fmov	d2, d0
104aedf00: f00d9a88    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104aedf04: f9455101    	ldr	x1, [x8, #0xaa0] ; croppedImage:
104aedf08: 9e6703e0    	fmov	d0, xzr
104aedf0c: 1e601003    	fmov	d3, #2.00000000
104aedf10: aa1803e0    	mov	x0, x24
104aedf14: 1e604101    	fmov	d1, d8
104aedf18: 94c4e489    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedf1c: aa1d03fd    	mov	x29, x29
104aedf20: 94c4e48a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedf24: aa0003fc    	mov	x28, x0
104aedf28: aa1a03e0    	mov	x0, x26
104aedf2c: 94c4e48a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aedf30: aa1303e0    	mov	x0, x19
104aedf34: aa1b03e1    	mov	x1, x27
104aedf38: 94c4e481    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedf3c: 1e604028    	fmov	d8, d1
104aedf40: aa1303e0    	mov	x0, x19
104aedf44: aa1b03e1    	mov	x1, x27
104aedf48: 94c4e47d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedf4c: 900d9ea8    	adrp	x8, 0x11fec1000 <dyld_stub_binder+0x11fec1000>
104aedf50: f940a501    	ldr	x1, [x8, #0x148] ; resizableImageWithCapInsets:resizingMode:
104aedf54: 9e6703e0    	fmov	d0, xzr
104aedf58: 9e6703e2    	fmov	d2, xzr
104aedf5c: aa1c03e0    	mov	x0, x28
104aedf60: 1e604101    	fmov	d1, d8
104aedf64: 52800022    	mov	w2, #0x1                ; =1
104aedf68: 94c4e475    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedf6c: aa1d03fd    	mov	x29, x29
104aedf70: 94c4e476    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aedf74: aa0003fa    	mov	x26, x0
104aedf78: aa1c03e0    	mov	x0, x28
104aedf7c: 94c4e476    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aedf80: aa1303e0    	mov	x0, x19
104aedf84: aa1903e1    	mov	x1, x25
104aedf88: 94c4e46d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedf8c: f1000c1f    	cmp	x0, #0x3
104aedf90: 54000741    	b.ne	0x104aee078 <_Flutter_MMFoundation_BindContext+0xfc9c5c>
104aedf94: f94396f9    	ldr	x25, [x23, #0x728] ; setAppMsgContent:
104aedf98: aa1303e0    	mov	x0, x19
104aedf9c: aa1903e1    	mov	x1, x25
104aedfa0: 94c4e467    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedfa4: 1e60100b    	fmov	d11, #2.00000000
104aedfa8: 1e6b2808    	fadd	d8, d0, d11
104aedfac: b00db0e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104aedfb0: f944251b    	ldr	x27, [x8, #0x848] ; size
104aedfb4: aa1803e0    	mov	x0, x24
104aedfb8: aa1b03e1    	mov	x1, x27
104aedfbc: 94c4e460    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedfc0: 1e604009    	fmov	d9, d0
104aedfc4: aa1803e0    	mov	x0, x24
104aedfc8: aa1b03e1    	mov	x1, x27
104aedfcc: 94c4e45c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedfd0: 1e60402a    	fmov	d10, d1
104aedfd4: aa1303e0    	mov	x0, x19
104aedfd8: aa1903e1    	mov	x1, x25
104aedfdc: 94c4e458    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aedfe0: 1e6b2800    	fadd	d0, d0, d11
104aedfe4: 1e603943    	fsub	d3, d10, d0
104aedfe8: f00d9a88    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104aedfec: f9455101    	ldr	x1, [x8, #0xaa0] ; croppedImage:
104aedff0: 9e6703e0    	fmov	d0, xzr
104aedff4: aa1803e0    	mov	x0, x24
104aedff8: 1e604101    	fmov	d1, d8
104aedffc: 1e604122    	fmov	d2, d9
104aee000: 94c4e44f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee004: aa1d03fd    	mov	x29, x29
104aee008: 94c4e450    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee00c: aa0003fb    	mov	x27, x0
104aee010: aa1a03e0    	mov	x0, x26
104aee014: 94c4e450    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee018: aa1303e0    	mov	x0, x19
104aee01c: aa1903e1    	mov	x1, x25
104aee020: 94c4e447    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee024: 1e604028    	fmov	d8, d1
104aee028: aa1303e0    	mov	x0, x19
104aee02c: aa1903e1    	mov	x1, x25
104aee030: 94c4e443    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee034: 1e604049    	fmov	d9, d2
104aee038: aa1303e0    	mov	x0, x19
104aee03c: aa1903e1    	mov	x1, x25
104aee040: 94c4e43f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee044: f00d9e88    	adrp	x8, 0x11fec1000 <dyld_stub_binder+0x11fec1000>
104aee048: f940a501    	ldr	x1, [x8, #0x148] ; resizableImageWithCapInsets:resizingMode:
104aee04c: 9e6703e0    	fmov	d0, xzr
104aee050: aa1b03e0    	mov	x0, x27
104aee054: 1e604101    	fmov	d1, d8
104aee058: 1e604122    	fmov	d2, d9
104aee05c: 52800022    	mov	w2, #0x1                ; =1
104aee060: 94c4e437    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee064: aa1d03fd    	mov	x29, x29
104aee068: 94c4e438    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee06c: aa0003fa    	mov	x26, x0
104aee070: aa1b03e0    	mov	x0, x27
104aee074: 94c4e438    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee078: b9403fe8    	ldr	w8, [sp, #0x3c]
104aee07c: 340000e8    	cbz	w8, 0x104aee098 <_Flutter_MMFoundation_BindContext+0xfc9c7c>
104aee080: f9400a60    	ldr	x0, [x19, #0x10]
104aee084: f00d9a48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104aee088: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
104aee08c: aa1a03e2    	mov	x2, x26
104aee090: aa1403e3    	mov	x3, x20
104aee094: 94c4e42a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee098: aa1a03e0    	mov	x0, x26
104aee09c: 94c4e427    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104aee0a0: f94023e0    	ldr	x0, [sp, #0x40]
104aee0a4: 94c4e42c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee0a8: f94027e0    	ldr	x0, [sp, #0x48]
104aee0ac: 94c4e42a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee0b0: aa1803e0    	mov	x0, x24
104aee0b4: 94c4e428    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee0b8: aa1a03e0    	mov	x0, x26
104aee0bc: 94c4e426    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee0c0: aa1403e0    	mov	x0, x20
104aee0c4: 94c4e424    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee0c8: 910143e0    	add	x0, sp, #0x50
104aee0cc: 94c47c9a    	bl	0x107c0d334 <_Flutter_MMFoundation_BindContext+0x40e8f18>
104aee0d0: aa1a03e0    	mov	x0, x26
104aee0d4: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
104aee0d8: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
104aee0dc: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
104aee0e0: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
104aee0e4: a94967fa    	ldp	x26, x25, [sp, #0x90]
104aee0e8: a9486ffc    	ldp	x28, x27, [sp, #0x80]
104aee0ec: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
104aee0f0: 6d462beb    	ldp	d11, d10, [sp, #0x60]
104aee0f4: 910383ff    	add	sp, sp, #0xe0
104aee0f8: 14c4e41e    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>