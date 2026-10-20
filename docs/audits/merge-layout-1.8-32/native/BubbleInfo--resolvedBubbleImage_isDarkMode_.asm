
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104aee148: d101c3ff    	sub	sp, sp, #0x70
104aee14c: a9016ffc    	stp	x28, x27, [sp, #0x10]
104aee150: a90267fa    	stp	x26, x25, [sp, #0x20]
104aee154: a9035ff8    	stp	x24, x23, [sp, #0x30]
104aee158: a90457f6    	stp	x22, x21, [sp, #0x40]
104aee15c: a9054ff4    	stp	x20, x19, [sp, #0x50]
104aee160: a9067bfd    	stp	x29, x30, [sp, #0x60]
104aee164: 910183fd    	add	x29, sp, #0x60
104aee168: aa0303f3    	mov	x19, x3
104aee16c: aa0203f7    	mov	x23, x2
104aee170: aa0003f8    	mov	x24, x0
104aee174: 900e0a88    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104aee178: 52800029    	mov	w9, #0x1                ; =1
104aee17c: 3911dd09    	strb	w9, [x8, #0x477]
104aee180: 900db0e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104aee184: f946d901    	ldr	x1, [x8, #0xdb0] ; style
104aee188: 94c4e3ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee18c: f100041f    	cmp	x0, #0x1
104aee190: 54000b01    	b.ne	0x104aee2f0 <_Flutter_MMFoundation_BindContext+0xfc9ed4>
104aee194: b00db0e8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104aee198: f941c914    	ldr	x20, [x8, #0x390] ; type
104aee19c: aa1803e0    	mov	x0, x24
104aee1a0: aa1403e1    	mov	x1, x20
104aee1a4: 94c4e3e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee1a8: b40000c0    	cbz	x0, 0x104aee1c0 <_Flutter_MMFoundation_BindContext+0xfc9da4>
104aee1ac: aa1803e0    	mov	x0, x24
104aee1b0: aa1403e1    	mov	x1, x20
104aee1b4: 94c4e3e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee1b8: f100301f    	cmp	x0, #0xc
104aee1bc: 54000621    	b.ne	0x104aee280 <_Flutter_MMFoundation_BindContext+0xfc9e64>
104aee1c0: b00d9a88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104aee1c4: f940d501    	ldr	x1, [x8, #0x1a8] ; isSender
104aee1c8: aa1803e0    	mov	x0, x24
104aee1cc: 94c4e3dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee1d0: b00db428    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aee1d4: f946d514    	ldr	x20, [x8, #0xda8]
104aee1d8: 34000620    	cbz	w0, 0x104aee29c <_Flutter_MMFoundation_BindContext+0xfc9e80>
104aee1dc: b00db428    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aee1e0: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
104aee1e4: d00db088    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104aee1e8: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104aee1ec: 94c4e3d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee1f0: aa1d03fd    	mov	x29, x29
104aee1f4: 94c4e3d5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee1f8: aa0003f3    	mov	x19, x0
104aee1fc: d00db428    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104aee200: f9404100    	ldr	x0, [x8, #0x80]
104aee204: b00db088    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104aee208: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104aee20c: 94c4e3cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee210: aa0003e2    	mov	x2, x0
104aee214: f00d9a48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104aee218: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104aee21c: aa1303e0    	mov	x0, x19
104aee220: 94c4e3c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee224: aa1d03fd    	mov	x29, x29
104aee228: 94c4e3c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee22c: aa0003f5    	mov	x21, x0
104aee230: d00d9a68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104aee234: f9400501    	ldr	x1, [x8, #0x8] ; colorList
104aee238: 94c4e3c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee23c: aa1d03fd    	mov	x29, x29
104aee240: 94c4e3c2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee244: aa0003f6    	mov	x22, x0
104aee248: d00d9a68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104aee24c: f9400901    	ldr	x1, [x8, #0x10] ; getColorByName:
104aee250: f00ce582    	adrp	x2, 0x11e7a1000 <dyld_stub_binder+0x11e7a1000>
104aee254: 91272042    	add	x2, x2, #0x9c8
104aee258: 94c4e3b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee25c: aa1d03fd    	mov	x29, x29
104aee260: 94c4e3ba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee264: aa0003f7    	mov	x23, x0
104aee268: 94c4e3b4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104aee26c: b40015e0    	cbz	x0, 0x104aee528 <_Flutter_MMFoundation_BindContext+0xfca10c>
104aee270: aa1703e0    	mov	x0, x23
104aee274: 94c4e3b1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104aee278: aa1703f8    	mov	x24, x23
104aee27c: 140000b3    	b	0x104aee548 <_Flutter_MMFoundation_BindContext+0xfca12c>
104aee280: aa1803e0    	mov	x0, x24
104aee284: aa1403e1    	mov	x1, x20
104aee288: 94c4e3ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee28c: f100041f    	cmp	x0, #0x1
104aee290: 54000301    	b.ne	0x104aee2f0 <_Flutter_MMFoundation_BindContext+0xfc9ed4>
104aee294: b00db428    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aee298: f946d514    	ldr	x20, [x8, #0xda8]
104aee29c: b00db428    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aee2a0: f9462d00    	ldr	x0, [x8, #0xc58]
104aee2a4: d00d9ca8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
104aee2a8: f9461d01    	ldr	x1, [x8, #0xc38] ; chatBubbleOther
104aee2ac: 94c4e3a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee2b0: aa1d03fd    	mov	x29, x29
104aee2b4: 94c4e3a5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee2b8: aa0003f3    	mov	x19, x0
104aee2bc: d00d9a68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104aee2c0: f942c501    	ldr	x1, [x8, #0x588] ; imageWithColor:size:cornerRadius:
104aee2c4: d2e80928    	mov	x8, #0x4049000000000000 ; =4632233691727265792
104aee2c8: 9e670100    	fmov	d0, x8
104aee2cc: 1e641002    	fmov	d2, #8.00000000
104aee2d0: aa1403e0    	mov	x0, x20
104aee2d4: aa1303e2    	mov	x2, x19
104aee2d8: 1e604001    	fmov	d1, d0
104aee2dc: 94c4e398    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee2e0: aa1d03fd    	mov	x29, x29
104aee2e4: 94c4e399    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee2e8: aa0003f4    	mov	x20, x0
104aee2ec: 140000e8    	b	0x104aee68c <_Flutter_MMFoundation_BindContext+0xfca270>
104aee2f0: b00db43c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
104aee2f4: f945eb80    	ldr	x0, [x28, #0xbd0] ; ��d 
104aee2f8: d00db088    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104aee2fc: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
104aee300: aa1603e1    	mov	x1, x22
104aee304: 94c4e38e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee308: aa1d03fd    	mov	x29, x29
104aee30c: 94c4e38f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee310: aa0003f9    	mov	x25, x0
104aee314: d00db428    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104aee318: f947b100    	ldr	x0, [x8, #0xf60] ; hd, 
104aee31c: b00db088    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104aee320: f947ad15    	ldr	x21, [x8, #0xf58] ; class
104aee324: aa1503e1    	mov	x1, x21
104aee328: 94c4e385    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee32c: aa0003e2    	mov	x2, x0
104aee330: f00d9a48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104aee334: f9464114    	ldr	x20, [x8, #0xc80] ; getService:
104aee338: aa1903e0    	mov	x0, x25
104aee33c: aa1403e1    	mov	x1, x20
104aee340: 94c4e37f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee344: aa1d03fd    	mov	x29, x29
104aee348: 94c4e380    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee34c: aa0003fa    	mov	x26, x0
104aee350: f00d9a88    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
104aee354: f9431901    	ldr	x1, [x8, #0x630] ; isEnabled
104aee358: 94c4e379    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee35c: aa0003fb    	mov	x27, x0
104aee360: aa1a03e0    	mov	x0, x26
104aee364: 94c4e37c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee368: aa1903e0    	mov	x0, x25
104aee36c: 94c4e37a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee370: 340007bb    	cbz	w27, 0x104aee464 <_Flutter_MMFoundation_BindContext+0xfca048>
104aee374: b00db0e8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104aee378: f941c91b    	ldr	x27, [x8, #0x390] ; type
104aee37c: aa1803e0    	mov	x0, x24
104aee380: aa1b03e1    	mov	x1, x27
104aee384: 94c4e36e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee388: b4000200    	cbz	x0, 0x104aee3c8 <_Flutter_MMFoundation_BindContext+0xfc9fac>
104aee38c: aa1803e0    	mov	x0, x24
104aee390: aa1b03e1    	mov	x1, x27
104aee394: 94c4e36a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee398: f100301f    	cmp	x0, #0xc
104aee39c: 54000160    	b.eq	0x104aee3c8 <_Flutter_MMFoundation_BindContext+0xfc9fac>
104aee3a0: aa1803e0    	mov	x0, x24
104aee3a4: aa1b03e1    	mov	x1, x27
104aee3a8: 94c4e365    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee3ac: f100041f    	cmp	x0, #0x1
104aee3b0: 540000c0    	b.eq	0x104aee3c8 <_Flutter_MMFoundation_BindContext+0xfc9fac>
104aee3b4: aa1803e0    	mov	x0, x24
104aee3b8: aa1b03e1    	mov	x1, x27
104aee3bc: 94c4e360    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee3c0: f100341f    	cmp	x0, #0xd
104aee3c4: 54000501    	b.ne	0x104aee464 <_Flutter_MMFoundation_BindContext+0xfca048>
104aee3c8: b9000ff3    	str	w19, [sp, #0xc]
104aee3cc: b00d9a88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104aee3d0: f940d51c    	ldr	x28, [x8, #0x1a8] ; isSender
104aee3d4: aa1803e0    	mov	x0, x24
104aee3d8: aa1c03e1    	mov	x1, x28
104aee3dc: 94c4e358    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee3e0: 7100001f    	cmp	w0, #0x0
104aee3e4: 52801688    	mov	w8, #0xb4               ; =180
104aee3e8: 1a9f1108    	csel	w8, w8, wzr, ne
104aee3ec: b9000be8    	str	w8, [sp, #0x8]
104aee3f0: b00db433    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
104aee3f4: f9462e60    	ldr	x0, [x19, #0xc58]
104aee3f8: d00d9ca8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
104aee3fc: f9461d19    	ldr	x25, [x8, #0xc38] ; chatBubbleOther
104aee400: aa1903e1    	mov	x1, x25
104aee404: 94c4e34e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee408: aa1d03fd    	mov	x29, x29
104aee40c: 94c4e34f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee410: aa0003fa    	mov	x26, x0
104aee414: aa1803e0    	mov	x0, x24
104aee418: aa1b03e1    	mov	x1, x27
104aee41c: 94c4e348    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee420: b40000c0    	cbz	x0, 0x104aee438 <_Flutter_MMFoundation_BindContext+0xfca01c>
104aee424: aa1803e0    	mov	x0, x24
104aee428: aa1b03e1    	mov	x1, x27
104aee42c: 94c4e344    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee430: f100301f    	cmp	x0, #0xc
104aee434: 54000741    	b.ne	0x104aee51c <_Flutter_MMFoundation_BindContext+0xfca100>
104aee438: aa1803e0    	mov	x0, x24
104aee43c: aa1c03e1    	mov	x1, x28
104aee440: 94c4e33f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee444: aa0003e8    	mov	x8, x0
104aee448: f9462e60    	ldr	x0, [x19, #0xc58]
104aee44c: 340005a8    	cbz	w8, 0x104aee500 <_Flutter_MMFoundation_BindContext+0xfca0e4>
104aee450: b00db438    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104aee454: 36000a77    	tbz	w23, #0x0, 0x104aee5a0 <_Flutter_MMFoundation_BindContext+0xfca184>
104aee458: f00da4a8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104aee45c: f947c901    	ldr	x1, [x8, #0xf90] ; chatBubbleGreenHL
104aee460: 14000052    	b	0x104aee5a8 <_Flutter_MMFoundation_BindContext+0xfca18c>
104aee464: f00da4a8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104aee468: 913e8108    	add	x8, x8, #0xfa0
104aee46c: f00da4a9    	adrp	x9, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104aee470: 913dc129    	add	x9, x9, #0xf70
104aee474: 710002ff    	cmp	w23, #0x0
104aee478: 9a891108    	csel	x8, x8, x9, ne
104aee47c: f9400101    	ldr	x1, [x8]
104aee480: aa1803e0    	mov	x0, x24
104aee484: 94c4e32e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee488: aa1d03fd    	mov	x29, x29
104aee48c: 94c4e32f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee490: aa0003f3    	mov	x19, x0
104aee494: b4000320    	cbz	x0, 0x104aee4f8 <_Flutter_MMFoundation_BindContext+0xfca0dc>
104aee498: f945eb80    	ldr	x0, [x28, #0xbd0] ; ��d 
104aee49c: aa1603e1    	mov	x1, x22
104aee4a0: 94c4e327    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee4a4: aa1d03fd    	mov	x29, x29
104aee4a8: 94c4e328    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee4ac: aa0003f6    	mov	x22, x0
104aee4b0: d00db428    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104aee4b4: f9404100    	ldr	x0, [x8, #0x80]
104aee4b8: aa1503e1    	mov	x1, x21
104aee4bc: 94c4e320    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee4c0: aa0003e2    	mov	x2, x0
104aee4c4: aa1603e0    	mov	x0, x22
104aee4c8: aa1403e1    	mov	x1, x20
104aee4cc: 94c4e31c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee4d0: aa1d03fd    	mov	x29, x29
104aee4d4: 94c4e31d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee4d8: aa0003f5    	mov	x21, x0
104aee4dc: 900db0a8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104aee4e0: f9455d01    	ldr	x1, [x8, #0xab8] ; imageNamed:
104aee4e4: aa1303e2    	mov	x2, x19
104aee4e8: 94c4e315    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee4ec: aa1d03fd    	mov	x29, x29
104aee4f0: 94c4e316    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee4f4: 14000061    	b	0x104aee678 <_Flutter_MMFoundation_BindContext+0xfca25c>
104aee4f8: d2800014    	mov	x20, #0x0               ; =0
104aee4fc: 14000064    	b	0x104aee68c <_Flutter_MMFoundation_BindContext+0xfca270>
104aee500: b00da488    	adrp	x8, 0x11ff7f000 <dyld_stub_binder+0x11ff7f000>
104aee504: f9473d08    	ldr	x8, [x8, #0xe78] ; chatBubbleOtherHL
104aee508: 710002ff    	cmp	w23, #0x0
104aee50c: 9a991101    	csel	x1, x8, x25, ne
104aee510: b9400ff3    	ldr	w19, [sp, #0xc]
104aee514: b00db438    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104aee518: 14000025    	b	0x104aee5ac <_Flutter_MMFoundation_BindContext+0xfca190>
104aee51c: b9400ff3    	ldr	w19, [sp, #0xc]
104aee520: b00db438    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104aee524: 14000029    	b	0x104aee5c8 <_Flutter_MMFoundation_BindContext+0xfca1ac>
104aee528: b00db428    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aee52c: f9463100    	ldr	x0, [x8, #0xc60]
104aee530: b00db088    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104aee534: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
104aee538: 94c4e301    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee53c: aa1d03fd    	mov	x29, x29
104aee540: 94c4e302    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee544: aa0003f8    	mov	x24, x0
104aee548: aa1703e0    	mov	x0, x23
104aee54c: 94c4e302    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee550: d00d9a68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104aee554: f942c501    	ldr	x1, [x8, #0x588] ; imageWithColor:size:cornerRadius:
104aee558: d2e80928    	mov	x8, #0x4049000000000000 ; =4632233691727265792
104aee55c: 9e670100    	fmov	d0, x8
104aee560: 1e641002    	fmov	d2, #8.00000000
104aee564: aa1403e0    	mov	x0, x20
104aee568: aa1803e2    	mov	x2, x24
104aee56c: 1e604001    	fmov	d1, d0
104aee570: 94c4e2f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee574: aa1d03fd    	mov	x29, x29
104aee578: 94c4e2f4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee57c: aa0003f4    	mov	x20, x0
104aee580: aa1803e0    	mov	x0, x24
104aee584: 94c4e2f4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee588: aa1703e0    	mov	x0, x23
104aee58c: 94c4e2f2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee590: aa1603e0    	mov	x0, x22
104aee594: 94c4e2f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee598: aa1503e0    	mov	x0, x21
104aee59c: 1400003b    	b	0x104aee688 <_Flutter_MMFoundation_BindContext+0xfca26c>
104aee5a0: f00da4a8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104aee5a4: f947cd01    	ldr	x1, [x8, #0xf98] ; chatBubbleGreen
104aee5a8: b9400ff3    	ldr	w19, [sp, #0xc]
104aee5ac: 94c4e2e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee5b0: aa1d03fd    	mov	x29, x29
104aee5b4: 94c4e2e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee5b8: aa0003f7    	mov	x23, x0
104aee5bc: aa1a03e0    	mov	x0, x26
104aee5c0: 94c4e2e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee5c4: aa1703fa    	mov	x26, x23
104aee5c8: d00d9a88    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104aee5cc: 913fa108    	add	x8, x8, #0xfe8
104aee5d0: d00d9a89    	adrp	x9, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104aee5d4: 91396129    	add	x9, x9, #0xe58
104aee5d8: 7100027f    	cmp	w19, #0x0
104aee5dc: 9a891108    	csel	x8, x8, x9, ne
104aee5e0: f9400101    	ldr	x1, [x8]
104aee5e4: aa1a03e0    	mov	x0, x26
104aee5e8: 94c4e2d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee5ec: aa1d03fd    	mov	x29, x29
104aee5f0: 94c4e2d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee5f4: aa0003f3    	mov	x19, x0
104aee5f8: aa1a03e0    	mov	x0, x26
104aee5fc: 94c4e2d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee600: f945eb00    	ldr	x0, [x24, #0xbd0] ; ��d 
104aee604: aa1603e1    	mov	x1, x22
104aee608: 94c4e2cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee60c: aa1d03fd    	mov	x29, x29
104aee610: 94c4e2ce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee614: aa0003f6    	mov	x22, x0
104aee618: d00db428    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104aee61c: f9404100    	ldr	x0, [x8, #0x80]
104aee620: aa1503e1    	mov	x1, x21
104aee624: 94c4e2c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee628: aa0003e2    	mov	x2, x0
104aee62c: aa1603e0    	mov	x0, x22
104aee630: aa1403e1    	mov	x1, x20
104aee634: 94c4e2c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee638: aa1d03fd    	mov	x29, x29
104aee63c: 94c4e2c3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee640: aa0003f5    	mov	x21, x0
104aee644: b00d9a88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104aee648: f9425901    	ldr	x1, [x8, #0x4b0] ; svgImageNamed:size:color:angle:
104aee64c: f00ce582    	adrp	x2, 0x11e7a1000 <dyld_stub_binder+0x11e7a1000>
104aee650: 9127a042    	add	x2, x2, #0x9e8
104aee654: 900a14a8    	adrp	x8, 0x118d82000 <dyld_stub_binder+0x118d82000>
104aee658: fd478900    	ldr	d0, [x8, #0xf10]
104aee65c: d2e80888    	mov	x8, #0x4044000000000000 ; =4630826316843712512
104aee660: 9e670101    	fmov	d1, x8
104aee664: aa1303e3    	mov	x3, x19
104aee668: b9400be4    	ldr	w4, [sp, #0x8]
104aee66c: 94c4e2b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee670: aa1d03fd    	mov	x29, x29
104aee674: 94c4e2b5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aee678: aa0003f4    	mov	x20, x0
104aee67c: aa1503e0    	mov	x0, x21
104aee680: 94c4e2b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee684: aa1603e0    	mov	x0, x22
104aee688: 94c4e2b3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee68c: aa1303e0    	mov	x0, x19
104aee690: 94c4e2b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aee694: aa1403e0    	mov	x0, x20
104aee698: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104aee69c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104aee6a0: a94457f6    	ldp	x22, x21, [sp, #0x40]
104aee6a4: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104aee6a8: a94267fa    	ldp	x26, x25, [sp, #0x20]
104aee6ac: a9416ffc    	ldp	x28, x27, [sp, #0x10]
104aee6b0: 9101c3ff    	add	sp, sp, #0x70
104aee6b4: 14c4e2af    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>