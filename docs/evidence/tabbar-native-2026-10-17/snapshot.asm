
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10471fc70: d105c3ff    	sub	sp, sp, #0x170
10471fc74: 6d1023e9    	stp	d9, d8, [sp, #0x100]
10471fc78: a9116ffc    	stp	x28, x27, [sp, #0x110]
10471fc7c: a91267fa    	stp	x26, x25, [sp, #0x120]
10471fc80: a9135ff8    	stp	x24, x23, [sp, #0x130]
10471fc84: a91457f6    	stp	x22, x21, [sp, #0x140]
10471fc88: a9154ff4    	stp	x20, x19, [sp, #0x150]
10471fc8c: a9167bfd    	stp	x29, x30, [sp, #0x160]
10471fc90: 910583fd    	add	x29, sp, #0x160
10471fc94: aa0003f7    	mov	x23, x0
10471fc98: 900c7688    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10471fc9c: f9405908    	ldr	x8, [x8, #0xb0]
10471fca0: f9400108    	ldr	x8, [x8]
10471fca4: f81903a8    	stur	x8, [x29, #-0x70]
10471fca8: d00e28e8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
10471fcac: 52800029    	mov	w9, #0x1                ; =1
10471fcb0: 39197509    	strb	w9, [x8, #0x65d]
10471fcb4: 900dd2a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10471fcb8: f9474d00    	ldr	x0, [x8, #0xe98]
10471fcbc: 94d41d27    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10471fcc0: aa0003f4    	mov	x20, x0
10471fcc4: 900dd2a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10471fcc8: f9463100    	ldr	x0, [x8, #0xc60]
10471fccc: 900dcf08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10471fcd0: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
10471fcd4: 94d41d1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fcd8: aa1d03fd    	mov	x29, x29
10471fcdc: 94d41d1b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471fce0: aa0003f5    	mov	x21, x0
10471fce4: 900dcf48    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10471fce8: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
10471fcec: aa1403e0    	mov	x0, x20
10471fcf0: f90007e1    	str	x1, [sp, #0x8]
10471fcf4: aa1503e2    	mov	x2, x21
10471fcf8: 94d41d11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fcfc: aa1503e0    	mov	x0, x21
10471fd00: 94d41d15    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471fd04: d00dcf08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10471fd08: f945a101    	ldr	x1, [x8, #0xb40] ; frame
10471fd0c: aa1703e0    	mov	x0, x23
10471fd10: f90013e1    	str	x1, [sp, #0x20]
10471fd14: 94d41d0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fd18: b00dcf48    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10471fd1c: f9403516    	ldr	x22, [x8, #0x68] ; setFrame:
10471fd20: aa1403e0    	mov	x0, x20
10471fd24: aa1603e1    	mov	x1, x22
10471fd28: 94d41d05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fd2c: 900dd2a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10471fd30: f9462d00    	ldr	x0, [x8, #0xc58]
10471fd34: d00dba48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
10471fd38: f9412901    	ldr	x1, [x8, #0x250] ; attachBarBlur
10471fd3c: 94d41d00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fd40: aa1d03fd    	mov	x29, x29
10471fd44: 94d41d01    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471fd48: aa0003f8    	mov	x24, x0
10471fd4c: 900db948    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
10471fd50: f9452501    	ldr	x1, [x8, #0xa48] ; addBlurEffectWithColor:
10471fd54: aa1403e0    	mov	x0, x20
10471fd58: aa1803e2    	mov	x2, x24
10471fd5c: 94d41cf8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fd60: aa1803e0    	mov	x0, x24
10471fd64: 94d41cfc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471fd68: 4f00e400    	movi.16b	v0, #0x0
10471fd6c: ad0283e0    	stp	q0, q0, [sp, #0x50]
10471fd70: ad0183e0    	stp	q0, q0, [sp, #0x30]
10471fd74: 900dd808    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
10471fd78: b989d108    	ldrsw	x8, [x8, #0x9d0]
10471fd7c: f8686ae0    	ldr	x0, [x23, x8]
10471fd80: 94d41cee    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10471fd84: b00dcf08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10471fd88: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
10471fd8c: 9100c3e2    	add	x2, sp, #0x30
10471fd90: 9101c3e3    	add	x3, sp, #0x70
10471fd94: a90103e1    	stp	x1, x0, [sp, #0x10]
10471fd98: 52800204    	mov	w4, #0x10               ; =16
10471fd9c: 94d41ce8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fda0: f90017f4    	str	x20, [sp, #0x28]
10471fda4: b4000820    	cbz	x0, 0x10471fea8 <_Flutter_MMFoundation_BindContext+0xbfba8c>
10471fda8: aa0003fa    	mov	x26, x0
10471fdac: f94023e8    	ldr	x8, [sp, #0x40]
10471fdb0: f9400118    	ldr	x24, [x8]
10471fdb4: d2800015    	mov	x21, #0x0               ; =0
10471fdb8: f00db948    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
10471fdbc: f944191b    	ldr	x27, [x8, #0x830] ; snapshotForUIView:opaque:checkCustomImpl:renderWithLayer:
10471fdc0: 900dcf28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10471fdc4: f940011c    	ldr	x28, [x8]
10471fdc8: f00dcee8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10471fdcc: f9476d17    	ldr	x23, [x8, #0xed8] ; addSubview:
10471fdd0: f94023e8    	ldr	x8, [sp, #0x40]
10471fdd4: f9400108    	ldr	x8, [x8]
10471fdd8: eb18011f    	cmp	x8, x24
10471fddc: 54000060    	b.eq	0x10471fde8 <_Flutter_MMFoundation_BindContext+0xbfb9cc>
10471fde0: f9400fe0    	ldr	x0, [sp, #0x18]
10471fde4: 94d41cdb    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
10471fde8: f9401fe8    	ldr	x8, [sp, #0x38]
10471fdec: f8757914    	ldr	x20, [x8, x21, lsl #3]
10471fdf0: b00dd2a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10471fdf4: f940b900    	ldr	x0, [x8, #0x170]
10471fdf8: 94d41cda    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10471fdfc: aa0003f9    	mov	x25, x0
10471fe00: 900dd2a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10471fe04: f9467900    	ldr	x0, [x8, #0xcf0] ; ��b
10471fe08: aa1b03e1    	mov	x1, x27
10471fe0c: aa1403e2    	mov	x2, x20
10471fe10: 52800003    	mov	w3, #0x0                ; =0
10471fe14: 52800004    	mov	w4, #0x0                ; =0
10471fe18: 52800005    	mov	w5, #0x0                ; =0
10471fe1c: 94d41cc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fe20: aa1d03fd    	mov	x29, x29
10471fe24: 94d41cc9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471fe28: aa0003f3    	mov	x19, x0
10471fe2c: aa1903e0    	mov	x0, x25
10471fe30: aa1c03e1    	mov	x1, x28
10471fe34: aa1303e2    	mov	x2, x19
10471fe38: 94d41cc1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fe3c: aa0003f9    	mov	x25, x0
10471fe40: aa1303e0    	mov	x0, x19
10471fe44: 94d41cc4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471fe48: aa1403e0    	mov	x0, x20
10471fe4c: f94013e1    	ldr	x1, [sp, #0x20]
10471fe50: 94d41cbb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fe54: aa1903e0    	mov	x0, x25
10471fe58: aa1603e1    	mov	x1, x22
10471fe5c: 94d41cb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fe60: f94017f4    	ldr	x20, [sp, #0x28]
10471fe64: aa1403e0    	mov	x0, x20
10471fe68: aa1703e1    	mov	x1, x23
10471fe6c: aa1903e2    	mov	x2, x25
10471fe70: 94d41cb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fe74: aa1903e0    	mov	x0, x25
10471fe78: 94d41cb7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471fe7c: 910006b5    	add	x21, x21, #0x1
10471fe80: eb15035f    	cmp	x26, x21
10471fe84: 54fffa61    	b.ne	0x10471fdd0 <_Flutter_MMFoundation_BindContext+0xbfb9b4>
10471fe88: 9100c3e2    	add	x2, sp, #0x30
10471fe8c: 9101c3e3    	add	x3, sp, #0x70
10471fe90: a94103e1    	ldp	x1, x0, [sp, #0x10]
10471fe94: 52800204    	mov	w4, #0x10               ; =16
10471fe98: 94d41ca9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fe9c: aa0003fa    	mov	x26, x0
10471fea0: b5fff8a0    	cbnz	x0, 0x10471fdb4 <_Flutter_MMFoundation_BindContext+0xbfb998>
10471fea4: 14000003    	b	0x10471feb0 <_Flutter_MMFoundation_BindContext+0xbfba94>
10471fea8: f00dcee8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10471feac: f9476d17    	ldr	x23, [x8, #0xed8] ; addSubview:
10471feb0: f9400fe0    	ldr	x0, [sp, #0x18]
10471feb4: 94d41ca8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471feb8: 900dd2a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10471febc: f9474d00    	ldr	x0, [x8, #0xe98]
10471fec0: 94d41ca8    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10471fec4: aa0003f3    	mov	x19, x0
10471fec8: 900dcf68    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10471fecc: f947a501    	ldr	x1, [x8, #0xf48] ; width
10471fed0: aa1403e0    	mov	x0, x20
10471fed4: 94d41c9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fed8: 1e604008    	fmov	d8, d0
10471fedc: b00dd2a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10471fee0: f9406100    	ldr	x0, [x8, #0xc0]
10471fee4: b00dcf28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10471fee8: f9413101    	ldr	x1, [x8, #0x260] ; mainScreen
10471feec: 94d41c94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471fef0: aa1d03fd    	mov	x29, x29
10471fef4: 94d41c95    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471fef8: aa0003f4    	mov	x20, x0
10471fefc: f00dcf28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10471ff00: f944d901    	ldr	x1, [x8, #0x9b0] ; scale
10471ff04: 94d41c8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471ff08: 1e6e1001    	fmov	d1, #1.00000000
10471ff0c: f00dcf08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10471ff10: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
10471ff14: 1e601823    	fdiv	d3, d1, d0
10471ff18: 9e6703e0    	fmov	d0, xzr
10471ff1c: 9e6703e1    	fmov	d1, xzr
10471ff20: aa1303e0    	mov	x0, x19
10471ff24: 1e604102    	fmov	d2, d8
10471ff28: 94d41c85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471ff2c: aa0003f3    	mov	x19, x0
10471ff30: aa1403e0    	mov	x0, x20
10471ff34: 94d41c88    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471ff38: 900dd2a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10471ff3c: f9462d00    	ldr	x0, [x8, #0xc58]
10471ff40: b00db8e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10471ff44: f940a501    	ldr	x1, [x8, #0x148] ; seperatorColor
10471ff48: 94d41c7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471ff4c: aa1d03fd    	mov	x29, x29
10471ff50: 94d41c7e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471ff54: aa0003f4    	mov	x20, x0
10471ff58: aa1303e0    	mov	x0, x19
10471ff5c: f94007e1    	ldr	x1, [sp, #0x8]
10471ff60: aa1403e2    	mov	x2, x20
10471ff64: 94d41c76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471ff68: aa1403e0    	mov	x0, x20
10471ff6c: f94017f4    	ldr	x20, [sp, #0x28]
10471ff70: 94d41c79    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471ff74: aa1403e0    	mov	x0, x20
10471ff78: aa1703e1    	mov	x1, x23
10471ff7c: aa1303e2    	mov	x2, x19
10471ff80: 94d41c6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471ff84: aa1303e0    	mov	x0, x19
10471ff88: 94d41c73    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471ff8c: f85903a8    	ldur	x8, [x29, #-0x70]
10471ff90: 900c7689    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10471ff94: f9405929    	ldr	x9, [x9, #0xb0]
10471ff98: f9400129    	ldr	x9, [x9]
10471ff9c: eb08013f    	cmp	x9, x8
10471ffa0: 54000161    	b.ne	0x10471ffcc <_Flutter_MMFoundation_BindContext+0xbfbbb0>
10471ffa4: aa1403e0    	mov	x0, x20
10471ffa8: a9567bfd    	ldp	x29, x30, [sp, #0x160]
10471ffac: a9554ff4    	ldp	x20, x19, [sp, #0x150]
10471ffb0: a95457f6    	ldp	x22, x21, [sp, #0x140]
10471ffb4: a9535ff8    	ldp	x24, x23, [sp, #0x130]
10471ffb8: a95267fa    	ldp	x26, x25, [sp, #0x120]
10471ffbc: a9516ffc    	ldp	x28, x27, [sp, #0x110]
10471ffc0: 6d5023e9    	ldp	d9, d8, [sp, #0x100]
10471ffc4: 9105c3ff    	add	sp, sp, #0x170
10471ffc8: 14d41c6a    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
10471ffcc: 94d41c6a    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
