
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104723f00: 6db82beb    	stp	d11, d10, [sp, #-0x80]!
104723f04: 6d0123e9    	stp	d9, d8, [sp, #0x10]
104723f08: a9026ffc    	stp	x28, x27, [sp, #0x20]
104723f0c: a90367fa    	stp	x26, x25, [sp, #0x30]
104723f10: a9045ff8    	stp	x24, x23, [sp, #0x40]
104723f14: a90557f6    	stp	x22, x21, [sp, #0x50]
104723f18: a9064ff4    	stp	x20, x19, [sp, #0x60]
104723f1c: a9077bfd    	stp	x29, x30, [sp, #0x70]
104723f20: 9101c3fd    	add	x29, sp, #0x70
104723f24: d10a43ff    	sub	sp, sp, #0x290
104723f28: aa0203fb    	mov	x27, x2
104723f2c: aa0003fc    	mov	x28, x0
104723f30: 900c7668    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104723f34: f9405908    	ldr	x8, [x8, #0xb0]
104723f38: f9400108    	ldr	x8, [x8]
104723f3c: f81803a8    	stur	x8, [x29, #-0x80]
104723f40: d00e28c8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
104723f44: 52800029    	mov	w9, #0x1                ; =1
104723f48: 3919d109    	strb	w9, [x8, #0x674]
104723f4c: aa0203e0    	mov	x0, x2
104723f50: 94d40c7a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104723f54: 4f00e400    	movi.16b	v0, #0x0
104723f58: ad0703e0    	stp	q0, q0, [sp, #0xe0]
104723f5c: ad0603e0    	stp	q0, q0, [sp, #0xc0]
104723f60: f00dcf28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104723f64: f9474913    	ldr	x19, [x8, #0xe90] ; selector subviews
104723f68: aa1b03e0    	mov	x0, x27
104723f6c: aa1303e1    	mov	x1, x19
104723f70: 94d40c73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104723f74: aa1d03fd    	mov	x29, x29
104723f78: 94d40c74    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104723f7c: aa0003f9    	mov	x25, x0
104723f80: b00dcee8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104723f84: f9435501    	ldr	x1, [x8, #0x6a8] ; selector countByEnumeratingWithState:objects:count:
104723f88: 910303e2    	add	x2, sp, #0xc0
104723f8c: d10403a3    	sub	x3, x29, #0x100
104723f90: f9001be1    	str	x1, [sp, #0x30]
104723f94: 52800204    	mov	w4, #0x10               ; =16
104723f98: 94d40c69    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104723f9c: aa0003fa    	mov	x26, x0
104723fa0: b4000d20    	cbz	x0, 0x104724144 <_Flutter_MMFoundation_BindContext+0xbffd28>
104723fa4: a901eff3    	stp	x19, x27, [sp, #0x18]
104723fa8: f90017fc    	str	x28, [sp, #0x28]
104723fac: d2800016    	mov	x22, #0x0               ; =0
104723fb0: f9001fff    	str	xzr, [sp, #0x38]
104723fb4: f9406be8    	ldr	x8, [sp, #0xd0]
104723fb8: f9400118    	ldr	x24, [x8]
104723fbc: b00dd294    	adrp	x20, 0x120174000 <dyld_stub_binder+0x120174000>
104723fc0: d2800017    	mov	x23, #0x0               ; =0
104723fc4: 900dcee8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104723fc8: f947ad1b    	ldr	x27, [x8, #0xf58] ; selector class
104723fcc: 900dcf08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104723fd0: f9442d1c    	ldr	x28, [x8, #0x858] ; selector isKindOfClass:
104723fd4: f9406be8    	ldr	x8, [sp, #0xd0]
104723fd8: f9400108    	ldr	x8, [x8]
104723fdc: eb18011f    	cmp	x8, x24
104723fe0: 54000060    	b.eq	0x104723fec <_Flutter_MMFoundation_BindContext+0xbffbd0>
104723fe4: aa1903e0    	mov	x0, x25
104723fe8: 94d40c5a    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
104723fec: f94067e8    	ldr	x8, [sp, #0xc8]
104723ff0: f8777913    	ldr	x19, [x8, x23, lsl #3]
104723ff4: f9435e80    	ldr	x0, [x20, #0x6b8] ; class UILabel
104723ff8: aa1b03e1    	mov	x1, x27
104723ffc: 94d40c50    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724000: aa0003e2    	mov	x2, x0
104724004: aa1303e0    	mov	x0, x19
104724008: aa1c03e1    	mov	x1, x28
10472400c: 94d40c4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724010: 36000080    	tbz	w0, #0x0, 0x104724020 <_Flutter_MMFoundation_BindContext+0xbffc04>
104724014: f9401ff5    	ldr	x21, [sp, #0x38]
104724018: f9001ff3    	str	x19, [sp, #0x38]
10472401c: 1400000d    	b	0x104724050 <_Flutter_MMFoundation_BindContext+0xbffc34>
104724020: 900dd288    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104724024: f940b900    	ldr	x0, [x8, #0x170] ; class UIImageView
104724028: aa1b03e1    	mov	x1, x27
10472402c: 94d40c44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724030: aa0003e2    	mov	x2, x0
104724034: aa1303e0    	mov	x0, x19
104724038: aa1c03e1    	mov	x1, x28
10472403c: 94d40c40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724040: aa1603e8    	mov	x8, x22
104724044: aa1603f5    	mov	x21, x22
104724048: aa1303f6    	mov	x22, x19
10472404c: 340000c0    	cbz	w0, 0x104724064 <_Flutter_MMFoundation_BindContext+0xbffc48>
104724050: aa1303e0    	mov	x0, x19
104724054: 94d40c39    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104724058: aa1503e0    	mov	x0, x21
10472405c: 94d40c3e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104724060: aa1603e8    	mov	x8, x22
104724064: aa0803f6    	mov	x22, x8
104724068: 910006f7    	add	x23, x23, #0x1
10472406c: eb17035f    	cmp	x26, x23
104724070: 54fffb21    	b.ne	0x104723fd4 <_Flutter_MMFoundation_BindContext+0xbffbb8>
104724074: 910303e2    	add	x2, sp, #0xc0
104724078: d10403a3    	sub	x3, x29, #0x100
10472407c: aa1903e0    	mov	x0, x25
104724080: f9401be1    	ldr	x1, [sp, #0x30]
104724084: 52800204    	mov	w4, #0x10               ; =16
104724088: 94d40c2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472408c: aa0003fa    	mov	x26, x0
104724090: b5fff980    	cbnz	x0, 0x104723fc0 <_Flutter_MMFoundation_BindContext+0xbffba4>
104724094: aa1903e0    	mov	x0, x25
104724098: 94d40c2f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10472409c: f9401ffa    	ldr	x26, [sp, #0x38]
1047240a0: b40005ba    	cbz	x26, 0x104724154 <_Flutter_MMFoundation_BindContext+0xbffd38>
1047240a4: a94273fb    	ldp	x27, x28, [sp, #0x20]
1047240a8: b4000596    	cbz	x22, 0x104724158 <_Flutter_MMFoundation_BindContext+0xbffd3c>
1047240ac: aa1603e0    	mov	x0, x22
1047240b0: 900db8c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1047240b4: f9432913    	ldr	x19, [x8, #0x650] ; selector bottom
1047240b8: aa1303e1    	mov	x1, x19
1047240bc: 94d40c20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047240c0: 1e602008    	fcmp	d0, #0.0
1047240c4: 540004ad    	b.le	0x104724158 <_Flutter_MMFoundation_BindContext+0xbffd3c>
1047240c8: 900dcf48    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
1047240cc: f9402915    	ldr	x21, [x8, #0x50] ; selector y
1047240d0: aa1a03e0    	mov	x0, x26
1047240d4: aa1503e1    	mov	x1, x21
1047240d8: 94d40c19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047240dc: 1e602008    	fcmp	d0, #0.0
1047240e0: 540003cd    	b.le	0x104724158 <_Flutter_MMFoundation_BindContext+0xbffd3c>
1047240e4: aa1603f4    	mov	x20, x22
1047240e8: aa1603e0    	mov	x0, x22
1047240ec: aa1303e1    	mov	x1, x19
1047240f0: 94d40c13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047240f4: 1e604008    	fmov	d8, d0
1047240f8: aa1a03e0    	mov	x0, x26
1047240fc: aa1503e1    	mov	x1, x21
104724100: 94d40c0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724104: 1e604009    	fmov	d9, d0
104724108: 900dcf48    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
10472410c: f9402101    	ldr	x1, [x8, #0x40] ; selector x
104724110: aa1a03e0    	mov	x0, x26
104724114: 94d40c0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724118: 1e60400a    	fmov	d10, d0
10472411c: 900db8c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104724120: f9431d01    	ldr	x1, [x8, #0x638] ; selector right
104724124: aa1603e0    	mov	x0, x22
104724128: 94d40c05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472412c: 1e602140    	fcmp	d10, d0
104724130: 540009ca    	b.ge	0x104724268 <_Flutter_MMFoundation_BindContext+0xbffe4c>
104724134: 1e601000    	fmov	d0, #2.00000000
104724138: 1e602900    	fadd	d0, d8, d0
10472413c: 1e693808    	fsub	d8, d0, d9
104724140: 14000054    	b	0x104724290 <_Flutter_MMFoundation_BindContext+0xbffe74>
104724144: aa1903e0    	mov	x0, x25
104724148: 94d40c03    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10472414c: d2800016    	mov	x22, #0x0               ; =0
104724150: 14000003    	b	0x10472415c <_Flutter_MMFoundation_BindContext+0xbffd40>
104724154: a94273fb    	ldp	x27, x28, [sp, #0x20]
104724158: f9400ff3    	ldr	x19, [sp, #0x18]
10472415c: 4f00e400    	movi.16b	v0, #0x0
104724160: ad0303e0    	stp	q0, q0, [sp, #0x60]
104724164: ad0203e0    	stp	q0, q0, [sp, #0x40]
104724168: aa1b03e0    	mov	x0, x27
10472416c: aa1303e1    	mov	x1, x19
104724170: 94d40bf3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724174: aa1d03fd    	mov	x29, x29
104724178: 94d40bf4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10472417c: aa0003f8    	mov	x24, x0
104724180: 910103e2    	add	x2, sp, #0x40
104724184: 910403e3    	add	x3, sp, #0x100
104724188: f9401be1    	ldr	x1, [sp, #0x30]
10472418c: 52800204    	mov	w4, #0x10               ; =16
104724190: 94d40beb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724194: b40003a0    	cbz	x0, 0x104724208 <_Flutter_MMFoundation_BindContext+0xbffdec>
104724198: aa0003f3    	mov	x19, x0
10472419c: f9402be8    	ldr	x8, [sp, #0x50]
1047241a0: f9400114    	ldr	x20, [x8]
1047241a4: b00dc297    	adrp	x23, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
1047241a8: d2800019    	mov	x25, #0x0               ; =0
1047241ac: f94606f5    	ldr	x21, [x23, #0xc08] ; selector relayoutButtons:
1047241b0: f9402be8    	ldr	x8, [sp, #0x50]
1047241b4: f9400108    	ldr	x8, [x8]
1047241b8: eb14011f    	cmp	x8, x20
1047241bc: 54000060    	b.eq	0x1047241c8 <_Flutter_MMFoundation_BindContext+0xbffdac>
1047241c0: aa1803e0    	mov	x0, x24
1047241c4: 94d40be3    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1047241c8: f94027e8    	ldr	x8, [sp, #0x48]
1047241cc: f8797902    	ldr	x2, [x8, x25, lsl #3]
1047241d0: aa1c03e0    	mov	x0, x28
1047241d4: aa1503e1    	mov	x1, x21
1047241d8: 94d40bd9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047241dc: 91000739    	add	x25, x25, #0x1
1047241e0: eb19027f    	cmp	x19, x25
1047241e4: 54fffe61    	b.ne	0x1047241b0 <_Flutter_MMFoundation_BindContext+0xbffd94>
1047241e8: 910103e2    	add	x2, sp, #0x40
1047241ec: 910403e3    	add	x3, sp, #0x100
1047241f0: aa1803e0    	mov	x0, x24
1047241f4: f9401be1    	ldr	x1, [sp, #0x30]
1047241f8: 52800204    	mov	w4, #0x10               ; =16
1047241fc: 94d40bd0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724200: aa0003f3    	mov	x19, x0
104724204: b5fffd20    	cbnz	x0, 0x1047241a8 <_Flutter_MMFoundation_BindContext+0xbffd8c>
104724208: aa1803e0    	mov	x0, x24
10472420c: 94d40bd2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104724210: aa1603e0    	mov	x0, x22
104724214: 94d40bd0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104724218: aa1a03e0    	mov	x0, x26
10472421c: 94d40bce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104724220: aa1b03e0    	mov	x0, x27
104724224: 94d40bcc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104724228: f85803a8    	ldur	x8, [x29, #-0x80]
10472422c: f00c7649    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104724230: f9405929    	ldr	x9, [x9, #0xb0]
104724234: f9400129    	ldr	x9, [x9]
104724238: eb08013f    	cmp	x9, x8
10472423c: 54000e21    	b.ne	0x104724400 <_Flutter_MMFoundation_BindContext+0xbfffe4>
104724240: 910a43ff    	add	sp, sp, #0x290
104724244: a9477bfd    	ldp	x29, x30, [sp, #0x70]
104724248: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10472424c: a94557f6    	ldp	x22, x21, [sp, #0x50]
104724250: a9445ff8    	ldp	x24, x23, [sp, #0x40]
104724254: a94367fa    	ldp	x26, x25, [sp, #0x30]
104724258: a9426ffc    	ldp	x28, x27, [sp, #0x20]
10472425c: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
104724260: 6cc82beb    	ldp	d11, d10, [sp], #0x80
104724264: d65f03c0    	ret
104724268: 900db8c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10472426c: f9432513    	ldr	x19, [x8, #0x648] ; selector centerY
104724270: aa1403e0    	mov	x0, x20
104724274: aa1303e1    	mov	x1, x19
104724278: 94d40bb1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472427c: 1e604008    	fmov	d8, d0
104724280: aa1a03e0    	mov	x0, x26
104724284: aa1303e1    	mov	x1, x19
104724288: 94d40bad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472428c: 1e603908    	fsub	d8, d8, d0
104724290: 4f00e400    	movi.16b	v0, #0x0
104724294: ad0503e0    	stp	q0, q0, [sp, #0xa0]
104724298: ad0403e0    	stp	q0, q0, [sp, #0x80]
10472429c: f00dcf28    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1047242a0: f946e501    	ldr	x1, [x8, #0xdc8] ; selector viewControllers
1047242a4: aa1c03e0    	mov	x0, x28
1047242a8: 94d40ba5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047242ac: aa1d03fd    	mov	x29, x29
1047242b0: 94d40ba6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047242b4: aa0003f8    	mov	x24, x0
1047242b8: 910203e2    	add	x2, sp, #0x80
1047242bc: 910603e3    	add	x3, sp, #0x180
1047242c0: f9401be1    	ldr	x1, [sp, #0x30]
1047242c4: 52800204    	mov	w4, #0x10               ; =16
1047242c8: 94d40b9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047242cc: b4fff9e0    	cbz	x0, 0x104724208 <_Flutter_MMFoundation_BindContext+0xbffdec>
1047242d0: aa0003f7    	mov	x23, x0
1047242d4: f9404be8    	ldr	x8, [sp, #0x90]
1047242d8: f9400114    	ldr	x20, [x8]
1047242dc: d2800013    	mov	x19, #0x0               ; =0
1047242e0: 900dbca8    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
1047242e4: f944151b    	ldr	x27, [x8, #0x828] ; selector tabBarItem
1047242e8: b00dc288    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
1047242ec: f946091c    	ldr	x28, [x8, #0xc10] ; selector titlePositionAdjustment
1047242f0: b00dc288    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
1047242f4: f9460d08    	ldr	x8, [x8, #0xc18] ; selector setTitlePositionAdjustment:
1047242f8: f90017e8    	str	x8, [sp, #0x28]
1047242fc: b00db8a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104724300: f942a915    	ldr	x21, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104724304: f9404be8    	ldr	x8, [sp, #0x90]
104724308: f9400108    	ldr	x8, [x8]
10472430c: eb14011f    	cmp	x8, x20
104724310: 54000060    	b.eq	0x10472431c <_Flutter_MMFoundation_BindContext+0xbfff00>
104724314: aa1803e0    	mov	x0, x24
104724318: 94d40b8e    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
10472431c: f94047e8    	ldr	x8, [sp, #0x88]
104724320: f8737919    	ldr	x25, [x8, x19, lsl #3]
104724324: aa1903e0    	mov	x0, x25
104724328: aa1b03e1    	mov	x1, x27
10472432c: 94d40b84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724330: aa1d03fd    	mov	x29, x29
104724334: 94d40b85    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104724338: aa0003fa    	mov	x26, x0
10472433c: aa1c03e1    	mov	x1, x28
104724340: 94d40b7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724344: 1e604029    	fmov	d9, d1
104724348: aa1a03e0    	mov	x0, x26
10472434c: 94d40b82    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104724350: 1e602128    	fcmp	d9, #0.0
104724354: 540003a1    	b.ne	0x1047243c8 <_Flutter_MMFoundation_BindContext+0xbfffac>
104724358: aa1903e0    	mov	x0, x25
10472435c: aa1b03e1    	mov	x1, x27
104724360: 94d40b77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724364: aa1d03fd    	mov	x29, x29
104724368: 94d40b78    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10472436c: aa0003f9    	mov	x25, x0
104724370: 9e6703e0    	fmov	d0, xzr
104724374: f94017e1    	ldr	x1, [sp, #0x28]
104724378: 1e604101    	fmov	d1, d8
10472437c: 94d40b70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724380: aa1903e0    	mov	x0, x25
104724384: 94d40b74    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104724388: f00dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10472438c: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104724390: fd0007e8    	str	d8, [sp, #0x8]
104724394: f00d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104724398: 9106a108    	add	x8, x8, #0x1a8 ; CFString 'adjustment:%f'
10472439c: f90003e8    	str	x8, [sp]
1047243a0: aa1503e1    	mov	x1, x21
1047243a4: 52800042    	mov	w2, #0x2                ; =2
1047243a8: d2800003    	mov	x3, #0x0                ; =0
1047243ac: 52800004    	mov	w4, #0x0                ; =0
1047243b0: 900b83a5    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
1047243b4: 912d64a5    	add	x5, x5, #0xb59 ; string 'MMTabBarController.mm'
1047243b8: 52801266    	mov	w6, #0x93               ; =147
1047243bc: 900b83a7    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
1047243c0: 913038e7    	add	x7, x7, #0xc0e ; string '-[MMTabBarController relayoutButtons:]'
1047243c4: 94d40b5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047243c8: 91000673    	add	x19, x19, #0x1
1047243cc: eb1302ff    	cmp	x23, x19
1047243d0: 54fff9a1    	b.ne	0x104724304 <_Flutter_MMFoundation_BindContext+0xbffee8>
1047243d4: 910203e2    	add	x2, sp, #0x80
1047243d8: 910603e3    	add	x3, sp, #0x180
1047243dc: aa1803e0    	mov	x0, x24
1047243e0: f9401be1    	ldr	x1, [sp, #0x30]
1047243e4: 52800204    	mov	w4, #0x10               ; =16
1047243e8: 94d40b55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047243ec: aa0003f7    	mov	x23, x0
1047243f0: b5fff760    	cbnz	x0, 0x1047242dc <_Flutter_MMFoundation_BindContext+0xbffec0>
1047243f4: f94013fb    	ldr	x27, [sp, #0x20]
1047243f8: f9401ffa    	ldr	x26, [sp, #0x38]
1047243fc: 17ffff83    	b	0x104724208 <_Flutter_MMFoundation_BindContext+0xbffdec>
104724400: 94d40b5d    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
