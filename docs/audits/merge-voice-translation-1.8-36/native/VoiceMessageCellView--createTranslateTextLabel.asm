
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10627c0f4: d10203ff    	sub	sp, sp, #0x80
10627c0f8: 6d0123e9    	stp	d9, d8, [sp, #0x10]
10627c0fc: a9026ffc    	stp	x28, x27, [sp, #0x20]
10627c100: a90367fa    	stp	x26, x25, [sp, #0x30]
10627c104: a9045ff8    	stp	x24, x23, [sp, #0x40]
10627c108: a90557f6    	stp	x22, x21, [sp, #0x50]
10627c10c: a9064ff4    	stp	x20, x19, [sp, #0x60]
10627c110: a9077bfd    	stp	x29, x30, [sp, #0x70]
10627c114: 9101c3fd    	add	x29, sp, #0x70
10627c118: f90007e0    	str	x0, [sp, #0x8]
10627c11c: f00d4e28    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10627c120: 52800029    	mov	w9, #0x1                ; =1
10627c124: 3927ed09    	strb	w9, [x8, #0x9fb]
10627c128: b00cf7c8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10627c12c: f9411d00    	ldr	x0, [x8, #0x238] ;  �+ 
10627c130: 9466ac0a    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10627c134: aa0003f3    	mov	x19, x0
10627c138: f00cf7a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10627c13c: f9461900    	ldr	x0, [x8, #0xc30]
10627c140: b00cde08    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10627c144: f9473101    	ldr	x1, [x8, #0xe60] ; systemFont
10627c148: 9466abfd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c14c: aa1d03fd    	mov	x29, x29
10627c150: 9466abfe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c154: aa0003f5    	mov	x21, x0
10627c158: 900cf468    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10627c15c: f9400501    	ldr	x1, [x8, #0x8] ; setFont:
10627c160: aa1303e0    	mov	x0, x19
10627c164: aa1503e2    	mov	x2, x21
10627c168: 9466abf5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c16c: aa1503e0    	mov	x0, x21
10627c170: 9466abf9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c174: 900cde28    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10627c178: f946e501    	ldr	x1, [x8, #0xdc8] ; setParserType:
10627c17c: aa1303e0    	mov	x0, x19
10627c180: 52800202    	mov	w2, #0x10               ; =16
10627c184: 9466abee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c188: 900cf7c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10627c18c: f9403d18    	ldr	x24, [x8, #0x78] ; 8�6 
10627c190: f00cf7a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10627c194: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10627c198: 900cf428    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10627c19c: f944e919    	ldr	x25, [x8, #0x9d0] ; currentContext
10627c1a0: aa1903e1    	mov	x1, x25
10627c1a4: 9466abe6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c1a8: aa1d03fd    	mov	x29, x29
10627c1ac: 9466abe7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c1b0: aa0003f5    	mov	x21, x0
10627c1b4: 900cf7c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10627c1b8: f9404100    	ldr	x0, [x8, #0x80]
10627c1bc: f00cf408    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10627c1c0: f947ad1a    	ldr	x26, [x8, #0xf58] ; class
10627c1c4: aa1a03e1    	mov	x1, x26
10627c1c8: 9466abdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c1cc: aa0003e2    	mov	x2, x0
10627c1d0: b00cdde8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10627c1d4: f946411b    	ldr	x27, [x8, #0xc80] ; getService:
10627c1d8: aa1503e0    	mov	x0, x21
10627c1dc: aa1b03e1    	mov	x1, x27
10627c1e0: 9466abd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c1e4: aa1d03fd    	mov	x29, x29
10627c1e8: 9466abd8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c1ec: aa0003f6    	mov	x22, x0
10627c1f0: f00cdde8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10627c1f4: f947fd1c    	ldr	x28, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
10627c1f8: d00c1142    	adrp	x2, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10627c1fc: 91242042    	add	x2, x2, #0x908
10627c200: d00c1143    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10627c204: 9124a063    	add	x3, x3, #0x928
10627c208: aa1c03e1    	mov	x1, x28
10627c20c: 9466abcc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c210: aa1d03fd    	mov	x29, x29
10627c214: 9466abcd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c218: aa0003f7    	mov	x23, x0
10627c21c: 900cde08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10627c220: f9400114    	ldr	x20, [x8]
10627c224: aa1803e0    	mov	x0, x24
10627c228: aa1403e1    	mov	x1, x20
10627c22c: aa1703e2    	mov	x2, x23
10627c230: 9466abc3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c234: 1e604008    	fmov	d8, d0
10627c238: 900cf7c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10627c23c: f9403d18    	ldr	x24, [x8, #0x78] ; 8�6 
10627c240: f00cf7a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10627c244: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10627c248: aa1903e1    	mov	x1, x25
10627c24c: 9466abbc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c250: aa1d03fd    	mov	x29, x29
10627c254: 9466abbd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c258: aa0003f9    	mov	x25, x0
10627c25c: 900cf7c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10627c260: f9404100    	ldr	x0, [x8, #0x80]
10627c264: aa1a03e1    	mov	x1, x26
10627c268: 9466abb5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c26c: aa0003e2    	mov	x2, x0
10627c270: aa1903e0    	mov	x0, x25
10627c274: aa1b03e1    	mov	x1, x27
10627c278: 9466abb1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c27c: aa1d03fd    	mov	x29, x29
10627c280: 9466abb2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c284: aa0003fa    	mov	x26, x0
10627c288: b00c1162    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
10627c28c: 912ca042    	add	x2, x2, #0xb28
10627c290: aa1c03e1    	mov	x1, x28
10627c294: d00c1143    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10627c298: 9124a063    	add	x3, x3, #0x928
10627c29c: 9466aba8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c2a0: aa1d03fd    	mov	x29, x29
10627c2a4: 9466aba9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c2a8: aa0003fb    	mov	x27, x0
10627c2ac: aa1803e0    	mov	x0, x24
10627c2b0: aa1403e1    	mov	x1, x20
10627c2b4: aa1b03e2    	mov	x2, x27
10627c2b8: 9466aba1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c2bc: 1e604001    	fmov	d1, d0
10627c2c0: b00cdde8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10627c2c4: f9465501    	ldr	x1, [x8, #0xca8] ; setWcOrigin:
10627c2c8: aa1303e0    	mov	x0, x19
10627c2cc: 1e604100    	fmov	d0, d8
10627c2d0: 9466ab9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c2d4: aa1b03e0    	mov	x0, x27
10627c2d8: 9466ab9f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c2dc: aa1a03e0    	mov	x0, x26
10627c2e0: 9466ab9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c2e4: aa1903e0    	mov	x0, x25
10627c2e8: 9466ab9b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c2ec: aa1703e0    	mov	x0, x23
10627c2f0: 9466ab99    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c2f4: aa1603e0    	mov	x0, x22
10627c2f8: 9466ab97    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c2fc: aa1503e0    	mov	x0, x21
10627c300: 9466ab95    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c304: f00cf7a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10627c308: f9462d00    	ldr	x0, [x8, #0xc58]
10627c30c: f00cde08    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10627c310: f947c901    	ldr	x1, [x8, #0xf90] ; FG_0
10627c314: 9466ab8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c318: aa1d03fd    	mov	x29, x29
10627c31c: 9466ab8b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c320: aa0003f4    	mov	x20, x0
10627c324: b00cf468    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10627c328: f9469501    	ldr	x1, [x8, #0xd28] ; setTextColor:
10627c32c: aa1303e0    	mov	x0, x19
10627c330: aa1403e2    	mov	x2, x20
10627c334: 9466ab82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c338: aa1403e0    	mov	x0, x20
10627c33c: 9466ab86    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c340: d00cde08    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10627c344: f9410901    	ldr	x1, [x8, #0x210] ; viewModel
10627c348: f94007f6    	ldr	x22, [sp, #0x8]
10627c34c: aa1603e0    	mov	x0, x22
10627c350: 9466ab7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c354: aa1d03fd    	mov	x29, x29
10627c358: 9466ab7c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627c35c: aa0003f4    	mov	x20, x0
10627c360: f00ceaa8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10627c364: f9465d01    	ldr	x1, [x8, #0xcb8] ; dialectFeedbackShowing
10627c368: 9466ab75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c36c: aa0003f5    	mov	x21, x0
10627c370: aa1403e0    	mov	x0, x20
10627c374: 9466ab78    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627c378: 900cf7c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10627c37c: f9450100    	ldr	x0, [x8, #0xa00] ; 0�7 
10627c380: 900ce048    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
10627c384: f946c901    	ldr	x1, [x8, #0xd90] ; getTextMessageNodeWidth:
10627c388: aa1603e2    	mov	x2, x22
10627c38c: 9466ab6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c390: 1e773001    	fmov	d1, #-25.00000000
10627c394: 1e612801    	fadd	d1, d0, d1
10627c398: 710002bf    	cmp	w21, #0x0
10627c39c: 1e601c20    	fcsel	d0, d1, d0, ne
10627c3a0: 900cde28    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10627c3a4: f9472901    	ldr	x1, [x8, #0xe50] ; setFWidth:
10627c3a8: aa1303e0    	mov	x0, x19
10627c3ac: 9466ab64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627c3b0: aa1303e0    	mov	x0, x19
10627c3b4: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10627c3b8: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10627c3bc: a94557f6    	ldp	x22, x21, [sp, #0x50]
10627c3c0: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10627c3c4: a94367fa    	ldp	x26, x25, [sp, #0x30]
10627c3c8: a9426ffc    	ldp	x28, x27, [sp, #0x20]
10627c3cc: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
10627c3d0: 910203ff    	add	sp, sp, #0x80
10627c3d4: 1466ab67    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>