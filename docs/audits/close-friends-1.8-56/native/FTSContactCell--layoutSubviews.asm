
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1016a66dc: d10383ff    	sub	sp, sp, #0xe0
1016a66e0: 6d062beb    	stp	d11, d10, [sp, #0x60]
1016a66e4: 6d0723e9    	stp	d9, d8, [sp, #0x70]
1016a66e8: a9086ffc    	stp	x28, x27, [sp, #0x80]
1016a66ec: a90967fa    	stp	x26, x25, [sp, #0x90]
1016a66f0: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
1016a66f4: a90b57f6    	stp	x22, x21, [sp, #0xb0]
1016a66f8: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
1016a66fc: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
1016a6700: 910343fd    	add	x29, sp, #0xd0
1016a6704: aa0003f3    	mov	x19, x0
1016a6708: 900fac68    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
1016a670c: 52800029    	mov	w9, #0x1                ; =1
1016a6710: 39181109    	strb	w9, [x8, #0x604]
1016a6714: b00f58a8    	adrp	x8, 0x1201bb000 <dyld_stub_binder+0x1201bb000>
1016a6718: f945b908    	ldr	x8, [x8, #0xb70]
1016a671c: a90523e0    	stp	x0, x8, [sp, #0x50]
1016a6720: 900f3cc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1016a6724: f940a901    	ldr	x1, [x8, #0x150] ; layoutSubviews
1016a6728: 910143e0    	add	x0, sp, #0x50
1016a672c: 95960286    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1016a6730: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a6734: b9839d14    	ldrsw	x20, [x8, #0x39c]
1016a6738: fc746a68    	ldr	d8, [x19, x20]
1016a673c: 1e602108    	fcmp	d8, #0.0
1016a6740: d00f5668    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1016a6744: b00f567a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
1016a6748: d00f5676    	adrp	x22, 0x120174000 <dyld_stub_binder+0x120174000>
1016a674c: 5400076d    	b.le	0x1016a6838 <__text+0x169e838>
1016a6750: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a6754: b983691c    	ldrsw	x28, [x8, #0x368]
1016a6758: f87c6a60    	ldr	x0, [x19, x28]
1016a675c: f00f5308    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1016a6760: f9453d15    	ldr	x21, [x8, #0xa78] ; setSize:
1016a6764: aa1503e1    	mov	x1, x21
1016a6768: 1e604100    	fmov	d0, d8
1016a676c: 1e604101    	fmov	d1, d8
1016a6770: 95960273    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6774: f87c6a60    	ldr	x0, [x19, x28]
1016a6778: b00f3cc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1016a677c: f9472501    	ldr	x1, [x8, #0xe48] ; setImageSize:
1016a6780: 1e604100    	fmov	d0, d8
1016a6784: 1e604101    	fmov	d1, d8
1016a6788: 9596026d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a678c: fc746a68    	ldr	d8, [x19, x20]
1016a6790: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a6794: b9836d19    	ldrsw	x25, [x8, #0x36c]
1016a6798: f8796a60    	ldr	x0, [x19, x25]
1016a679c: f00f3da8    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
1016a67a0: f946ad14    	ldr	x20, [x8, #0xd58] ; m_headView
1016a67a4: aa1403e1    	mov	x1, x20
1016a67a8: 95960265    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a67ac: aa1d03fd    	mov	x29, x29
1016a67b0: 95960266    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a67b4: aa1a03fb    	mov	x27, x26
1016a67b8: aa0003f6    	mov	x22, x0
1016a67bc: aa1503e1    	mov	x1, x21
1016a67c0: 1e604100    	fmov	d0, d8
1016a67c4: 1e604101    	fmov	d1, d8
1016a67c8: 9596025d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a67cc: f8796a60    	ldr	x0, [x19, x25]
1016a67d0: b00f3ce8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1016a67d4: f9407d01    	ldr	x1, [x8, #0xf8] ; setM_headSize:
1016a67d8: 1e604100    	fmov	d0, d8
1016a67dc: 1e604101    	fmov	d1, d8
1016a67e0: 95960257    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a67e4: f8796a60    	ldr	x0, [x19, x25]
1016a67e8: aa1503e1    	mov	x1, x21
1016a67ec: 1e604100    	fmov	d0, d8
1016a67f0: 1e604101    	fmov	d1, d8
1016a67f4: 95960252    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a67f8: aa1603e0    	mov	x0, x22
1016a67fc: 95960256    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6800: d00f52c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1016a6804: f944e909    	ldr	x9, [x8, #0x9d0] ; currentContext
1016a6808: b00f52c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1016a680c: f947ad08    	ldr	x8, [x8, #0xf58] ; class
1016a6810: a902a7e8    	stp	x8, x9, [sp, #0x28]
1016a6814: f00f3c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1016a6818: f9464109    	ldr	x9, [x8, #0xc80] ; getService:
1016a681c: b00f3ca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1016a6820: f947fd08    	ldr	x8, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
1016a6824: a901a7e8    	stp	x8, x9, [sp, #0x18]
1016a6828: d00f3ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1016a682c: f9400108    	ldr	x8, [x8]
1016a6830: f9000be8    	str	x8, [sp, #0x10]
1016a6834: 1400009f    	b	0x1016a6ab0 <__text+0x169eab0>
1016a6838: f9403d15    	ldr	x21, [x8, #0x78] ; setTop:
1016a683c: f945eb40    	ldr	x0, [x26, #0xbd0]
1016a6840: d00f52c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1016a6844: f944e91c    	ldr	x28, [x8, #0x9d0] ; currentContext
1016a6848: aa1c03e1    	mov	x1, x28
1016a684c: 9596023c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6850: aa1d03fd    	mov	x29, x29
1016a6854: 9596023d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6858: aa0003f4    	mov	x20, x0
1016a685c: f90027e0    	str	x0, [sp, #0x48]
1016a6860: f94042c0    	ldr	x0, [x22, #0x80]
1016a6864: b00f52c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1016a6868: f947ad16    	ldr	x22, [x8, #0xf58] ; class
1016a686c: aa1603e1    	mov	x1, x22
1016a6870: 95960233    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6874: aa0003e2    	mov	x2, x0
1016a6878: f00f3c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1016a687c: f946411b    	ldr	x27, [x8, #0xc80] ; getService:
1016a6880: aa1403e0    	mov	x0, x20
1016a6884: aa1b03e1    	mov	x1, x27
1016a6888: 9596022d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a688c: aa1d03fd    	mov	x29, x29
1016a6890: 9596022e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6894: f90023e0    	str	x0, [sp, #0x40]
1016a6898: b00f3ca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1016a689c: f947fd14    	ldr	x20, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
1016a68a0: b00e74e2    	adrp	x2, 0x11e543000 <dyld_stub_binder+0x11e543000>
1016a68a4: 912fa042    	add	x2, x2, #0xbe8
1016a68a8: b00e7199    	adrp	x25, 0x11e4d7000 <dyld_stub_binder+0x11e4d7000>
1016a68ac: 91212339    	add	x25, x25, #0x848
1016a68b0: aa1403e1    	mov	x1, x20
1016a68b4: aa1903e3    	mov	x3, x25
1016a68b8: 95960221    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a68bc: aa1d03fd    	mov	x29, x29
1016a68c0: 95960222    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a68c4: aa0003f8    	mov	x24, x0
1016a68c8: d00f3ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1016a68cc: f9400117    	ldr	x23, [x8]
1016a68d0: aa1503e0    	mov	x0, x21
1016a68d4: aa1703e1    	mov	x1, x23
1016a68d8: aa1803e2    	mov	x2, x24
1016a68dc: 95960218    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a68e0: 1e604008    	fmov	d8, d0
1016a68e4: d00f5668    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1016a68e8: f9403d15    	ldr	x21, [x8, #0x78]
1016a68ec: f945eb40    	ldr	x0, [x26, #0xbd0]
1016a68f0: f9001bfc    	str	x28, [sp, #0x30]
1016a68f4: aa1c03e1    	mov	x1, x28
1016a68f8: 95960211    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a68fc: aa1d03fd    	mov	x29, x29
1016a6900: 95960212    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6904: aa0003fa    	mov	x26, x0
1016a6908: d00f5668    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1016a690c: f9404100    	ldr	x0, [x8, #0x80]
1016a6910: f90017f6    	str	x22, [sp, #0x28]
1016a6914: aa1603e1    	mov	x1, x22
1016a6918: 95960209    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a691c: aa0003e2    	mov	x2, x0
1016a6920: aa1a03e0    	mov	x0, x26
1016a6924: f90013fb    	str	x27, [sp, #0x20]
1016a6928: aa1b03e1    	mov	x1, x27
1016a692c: 95960204    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6930: aa1d03fd    	mov	x29, x29
1016a6934: 95960205    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6938: aa0003fb    	mov	x27, x0
1016a693c: d00e76c2    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
1016a6940: 911ca042    	add	x2, x2, #0x728
1016a6944: f9000ff4    	str	x20, [sp, #0x18]
1016a6948: aa1403e1    	mov	x1, x20
1016a694c: aa1903e3    	mov	x3, x25
1016a6950: 959601fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6954: aa1d03fd    	mov	x29, x29
1016a6958: 959601fc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a695c: aa0003f9    	mov	x25, x0
1016a6960: aa1503e0    	mov	x0, x21
1016a6964: f9000bf7    	str	x23, [sp, #0x10]
1016a6968: aa1703e1    	mov	x1, x23
1016a696c: aa1903e2    	mov	x2, x25
1016a6970: 959601f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6974: 1e604001    	fmov	d1, d0
1016a6978: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a697c: b983691c    	ldrsw	x28, [x8, #0x368]
1016a6980: f87c6a60    	ldr	x0, [x19, x28]
1016a6984: f00f5308    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1016a6988: f9453d15    	ldr	x21, [x8, #0xa78] ; setSize:
1016a698c: aa1503e1    	mov	x1, x21
1016a6990: 1e604100    	fmov	d0, d8
1016a6994: 959601ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6998: aa1903e0    	mov	x0, x25
1016a699c: 959601ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a69a0: aa1b03e0    	mov	x0, x27
1016a69a4: 959601ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a69a8: aa1a03e0    	mov	x0, x26
1016a69ac: 959601ea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a69b0: aa1803e0    	mov	x0, x24
1016a69b4: 959601e8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a69b8: f94023e0    	ldr	x0, [sp, #0x40]
1016a69bc: 959601e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a69c0: f94027e0    	ldr	x0, [sp, #0x48]
1016a69c4: 959601e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a69c8: b00f5677    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1016a69cc: f9461ae0    	ldr	x0, [x23, #0xc30]
1016a69d0: f00f3c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1016a69d4: f9463114    	ldr	x20, [x8, #0xc60] ; dynamicLength:
1016a69d8: d2e80888    	mov	x8, #0x4044000000000000 ; =4630826316843712512
1016a69dc: 9e670108    	fmov	d8, x8
1016a69e0: aa1403e1    	mov	x1, x20
1016a69e4: 1e604100    	fmov	d0, d8
1016a69e8: 959601d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a69ec: 1e604009    	fmov	d9, d0
1016a69f0: f9461ae0    	ldr	x0, [x23, #0xc30]
1016a69f4: aa1403e1    	mov	x1, x20
1016a69f8: 1e604100    	fmov	d0, d8
1016a69fc: 959601d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6a00: 1e604001    	fmov	d1, d0
1016a6a04: f87c6a60    	ldr	x0, [x19, x28]
1016a6a08: b00f3cc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1016a6a0c: f9472501    	ldr	x1, [x8, #0xe48] ; setImageSize:
1016a6a10: 1e604120    	fmov	d0, d9
1016a6a14: 959601ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6a18: f9461ae0    	ldr	x0, [x23, #0xc30]
1016a6a1c: aa1403e1    	mov	x1, x20
1016a6a20: 1e604100    	fmov	d0, d8
1016a6a24: 959601c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6a28: 1e604009    	fmov	d9, d0
1016a6a2c: f9461ae0    	ldr	x0, [x23, #0xc30]
1016a6a30: aa1403e1    	mov	x1, x20
1016a6a34: 1e604100    	fmov	d0, d8
1016a6a38: 959601c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6a3c: 1e604008    	fmov	d8, d0
1016a6a40: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a6a44: b9836d19    	ldrsw	x25, [x8, #0x36c]
1016a6a48: f8796a60    	ldr	x0, [x19, x25]
1016a6a4c: f00f3da8    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
1016a6a50: f946ad14    	ldr	x20, [x8, #0xd58] ; m_headView
1016a6a54: aa1403e1    	mov	x1, x20
1016a6a58: 959601b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6a5c: aa1d03fd    	mov	x29, x29
1016a6a60: 959601ba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6a64: aa0003f7    	mov	x23, x0
1016a6a68: aa1503e1    	mov	x1, x21
1016a6a6c: 1e604120    	fmov	d0, d9
1016a6a70: 1e604101    	fmov	d1, d8
1016a6a74: 959601b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6a78: f8796a60    	ldr	x0, [x19, x25]
1016a6a7c: b00f3ce8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1016a6a80: f9407d01    	ldr	x1, [x8, #0xf8] ; setM_headSize:
1016a6a84: 1e604120    	fmov	d0, d9
1016a6a88: 1e604101    	fmov	d1, d8
1016a6a8c: 959601ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6a90: f8796a60    	ldr	x0, [x19, x25]
1016a6a94: aa1503e1    	mov	x1, x21
1016a6a98: 1e604120    	fmov	d0, d9
1016a6a9c: 1e604101    	fmov	d1, d8
1016a6aa0: 959601a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6aa4: aa1703e0    	mov	x0, x23
1016a6aa8: 959601ab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6aac: b00f567b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
1016a6ab0: f8796a60    	ldr	x0, [x19, x25]
1016a6ab4: aa1403e1    	mov	x1, x20
1016a6ab8: 959601a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6abc: aa1d03fd    	mov	x29, x29
1016a6ac0: 959601a2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6ac4: aa0003f5    	mov	x21, x0
1016a6ac8: b00f5328    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1016a6acc: f947a517    	ldr	x23, [x8, #0xf48] ; width
1016a6ad0: aa1703e1    	mov	x1, x23
1016a6ad4: 9596019a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6ad8: 1e6c1009    	fmov	d9, #0.50000000
1016a6adc: 1e690808    	fmul	d8, d0, d9
1016a6ae0: f8796a60    	ldr	x0, [x19, x25]
1016a6ae4: aa1403e1    	mov	x1, x20
1016a6ae8: 95960195    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6aec: aa1d03fd    	mov	x29, x29
1016a6af0: 95960196    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6af4: aa0003f4    	mov	x20, x0
1016a6af8: b00f52e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1016a6afc: f9469501    	ldr	x1, [x8, #0xd28] ; layer
1016a6b00: 9596018f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6b04: aa1d03fd    	mov	x29, x29
1016a6b08: 95960190    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6b0c: aa0003f8    	mov	x24, x0
1016a6b10: b00f5308    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1016a6b14: f943e901    	ldr	x1, [x8, #0x7d0] ; setCornerRadius:
1016a6b18: 1e604100    	fmov	d0, d8
1016a6b1c: 95960188    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6b20: aa1803e0    	mov	x0, x24
1016a6b24: 9596018c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6b28: aa1403e0    	mov	x0, x20
1016a6b2c: 9596018a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6b30: aa1503e0    	mov	x0, x21
1016a6b34: 95960188    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6b38: d00f52c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1016a6b3c: f942751a    	ldr	x26, [x8, #0x4e8] ; contentView
1016a6b40: aa1303e0    	mov	x0, x19
1016a6b44: aa1a03e1    	mov	x1, x26
1016a6b48: 9596017d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6b4c: aa1d03fd    	mov	x29, x29
1016a6b50: 9596017e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6b54: aa0003f4    	mov	x20, x0
1016a6b58: 900f52e8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1016a6b5c: f9449d15    	ldr	x21, [x8, #0x938] ; height
1016a6b60: aa1503e1    	mov	x1, x21
1016a6b64: 95960176    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6b68: 1e690800    	fmul	d0, d0, d9
1016a6b6c: f8796a60    	ldr	x0, [x19, x25]
1016a6b70: d00f3ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1016a6b74: f9401918    	ldr	x24, [x8, #0x30] ; setCenterY:
1016a6b78: aa1803e1    	mov	x1, x24
1016a6b7c: 95960170    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6b80: aa1403e0    	mov	x0, x20
1016a6b84: 95960174    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6b88: aa1303e0    	mov	x0, x19
1016a6b8c: aa1a03e1    	mov	x1, x26
1016a6b90: 9596016b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6b94: aa1d03fd    	mov	x29, x29
1016a6b98: 9596016c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6b9c: aa0003f4    	mov	x20, x0
1016a6ba0: f90003f5    	str	x21, [sp]
1016a6ba4: aa1503e1    	mov	x1, x21
1016a6ba8: 95960165    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6bac: 1e690800    	fmul	d0, d0, d9
1016a6bb0: f87c6a60    	ldr	x0, [x19, x28]
1016a6bb4: f90007f8    	str	x24, [sp, #0x8]
1016a6bb8: aa1803e1    	mov	x1, x24
1016a6bbc: 95960160    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6bc0: aa1403e0    	mov	x0, x20
1016a6bc4: 95960164    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6bc8: f87c6a60    	ldr	x0, [x19, x28]
1016a6bcc: d00f3ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1016a6bd0: f9431d01    	ldr	x1, [x8, #0x638] ; right
1016a6bd4: f9001fe1    	str	x1, [sp, #0x38]
1016a6bd8: 95960159    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6bdc: 1e651001    	fmov	d1, #12.00000000
1016a6be0: 1e612800    	fadd	d0, d0, d1
1016a6be4: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a6be8: b983711c    	ldrsw	x28, [x8, #0x370]
1016a6bec: f87c6a60    	ldr	x0, [x19, x28]
1016a6bf0: 900f5328    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1016a6bf4: f941cd01    	ldr	x1, [x8, #0x398] ; setX:
1016a6bf8: f90023e1    	str	x1, [sp, #0x40]
1016a6bfc: 95960150    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6c00: f87c6a60    	ldr	x0, [x19, x28]
1016a6c04: d00f5328    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
1016a6c08: f9402101    	ldr	x1, [x8, #0x40] ; x
1016a6c0c: 9596014c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6c10: 1e604008    	fmov	d8, d0
1016a6c14: aa1303e0    	mov	x0, x19
1016a6c18: f90027fa    	str	x26, [sp, #0x48]
1016a6c1c: aa1a03e1    	mov	x1, x26
1016a6c20: 95960147    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6c24: aa1d03fd    	mov	x29, x29
1016a6c28: 95960148    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6c2c: aa0003f4    	mov	x20, x0
1016a6c30: aa1703e1    	mov	x1, x23
1016a6c34: 95960142    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6c38: 1e604009    	fmov	d9, d0
1016a6c3c: aa1403e0    	mov	x0, x20
1016a6c40: 95960145    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6c44: f87c6a60    	ldr	x0, [x19, x28]
1016a6c48: f00f3c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1016a6c4c: f9465101    	ldr	x1, [x8, #0xca0] ; sizeToFit
1016a6c50: 9596013b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6c54: d00f5668    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1016a6c58: aa0803f6    	mov	x22, x8
1016a6c5c: f9403d14    	ldr	x20, [x8, #0x78]
1016a6c60: aa1b03f5    	mov	x21, x27
1016a6c64: f945eb60    	ldr	x0, [x27, #0xbd0]
1016a6c68: f9401be1    	ldr	x1, [sp, #0x30]
1016a6c6c: 95960134    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6c70: aa1d03fd    	mov	x29, x29
1016a6c74: 95960135    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6c78: aa0003f9    	mov	x25, x0
1016a6c7c: d00f5668    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1016a6c80: f9404100    	ldr	x0, [x8, #0x80]
1016a6c84: f94017e1    	ldr	x1, [sp, #0x28]
1016a6c88: 9596012d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6c8c: aa0003e2    	mov	x2, x0
1016a6c90: aa1903e0    	mov	x0, x25
1016a6c94: f94013e1    	ldr	x1, [sp, #0x20]
1016a6c98: 95960129    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6c9c: aa1d03fd    	mov	x29, x29
1016a6ca0: 9596012a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6ca4: aa0003fa    	mov	x26, x0
1016a6ca8: b00e74e2    	adrp	x2, 0x11e543000 <dyld_stub_binder+0x11e543000>
1016a6cac: 9133a042    	add	x2, x2, #0xce8
1016a6cb0: b00e7183    	adrp	x3, 0x11e4d7000 <dyld_stub_binder+0x11e4d7000>
1016a6cb4: 91212063    	add	x3, x3, #0x848
1016a6cb8: f9400fe1    	ldr	x1, [sp, #0x18]
1016a6cbc: 95960120    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6cc0: aa1d03fd    	mov	x29, x29
1016a6cc4: 95960121    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6cc8: aa0003fb    	mov	x27, x0
1016a6ccc: aa1403e0    	mov	x0, x20
1016a6cd0: f9400be1    	ldr	x1, [sp, #0x10]
1016a6cd4: aa1b03e2    	mov	x2, x27
1016a6cd8: 95960119    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6cdc: f87c6a60    	ldr	x0, [x19, x28]
1016a6ce0: d00f5308    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1016a6ce4: f9410901    	ldr	x1, [x8, #0x210] ; setHeight:
1016a6ce8: 95960115    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6cec: aa1b03e0    	mov	x0, x27
1016a6cf0: 95960119    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6cf4: aa1a03e0    	mov	x0, x26
1016a6cf8: 95960117    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6cfc: aa1903e0    	mov	x0, x25
1016a6d00: 95960115    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6d04: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a6d08: b9838118    	ldrsw	x24, [x8, #0x380]
1016a6d0c: f8786a60    	ldr	x0, [x19, x24]
1016a6d10: b00f5328    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1016a6d14: f9401501    	ldr	x1, [x8, #0x28] ; text
1016a6d18: 95960109    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6d1c: aa1d03fd    	mov	x29, x29
1016a6d20: 9596010a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6d24: aa0003f4    	mov	x20, x0
1016a6d28: b00f52e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1016a6d2c: f946e919    	ldr	x25, [x8, #0xdd0] ; length
1016a6d30: aa1903e1    	mov	x1, x25
1016a6d34: 95960102    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6d38: b4000080    	cbz	x0, 0x1016a6d48 <__text+0x169ed48>
1016a6d3c: aa1403e0    	mov	x0, x20
1016a6d40: 95960105    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6d44: 14000010    	b	0x1016a6d84 <__text+0x169ed84>
1016a6d48: f8786a60    	ldr	x0, [x19, x24]
1016a6d4c: 900f3ce8    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
1016a6d50: f9444101    	ldr	x1, [x8, #0x880] ; attributedText
1016a6d54: 959600fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6d58: aa1d03fd    	mov	x29, x29
1016a6d5c: 959600fb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6d60: aa0003fa    	mov	x26, x0
1016a6d64: aa1903e1    	mov	x1, x25
1016a6d68: 959600f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6d6c: aa0003f9    	mov	x25, x0
1016a6d70: aa1a03e0    	mov	x0, x26
1016a6d74: 959600f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6d78: aa1403e0    	mov	x0, x20
1016a6d7c: 959600f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6d80: b4002e59    	cbz	x25, 0x1016a7348 <__text+0x169f348>
1016a6d84: f9403ed4    	ldr	x20, [x22, #0x78]
1016a6d88: f945eaa0    	ldr	x0, [x21, #0xbd0]
1016a6d8c: f9401be1    	ldr	x1, [sp, #0x30]
1016a6d90: 959600eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6d94: aa1d03fd    	mov	x29, x29
1016a6d98: 959600ec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6d9c: aa0003f9    	mov	x25, x0
1016a6da0: d00f5668    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1016a6da4: f9404100    	ldr	x0, [x8, #0x80]
1016a6da8: f94017e1    	ldr	x1, [sp, #0x28]
1016a6dac: 959600e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6db0: aa0003e2    	mov	x2, x0
1016a6db4: aa1903e0    	mov	x0, x25
1016a6db8: f94013e1    	ldr	x1, [sp, #0x20]
1016a6dbc: 959600e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6dc0: aa1d03fd    	mov	x29, x29
1016a6dc4: 959600e1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6dc8: aa0003fa    	mov	x26, x0
1016a6dcc: d00e7202    	adrp	x2, 0x11e4e8000 <dyld_stub_binder+0x11e4e8000>
1016a6dd0: 9108a042    	add	x2, x2, #0x228
1016a6dd4: b00e7183    	adrp	x3, 0x11e4d7000 <dyld_stub_binder+0x11e4d7000>
1016a6dd8: 91212063    	add	x3, x3, #0x848
1016a6ddc: f9400fe1    	ldr	x1, [sp, #0x18]
1016a6de0: 959600d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6de4: aa1d03fd    	mov	x29, x29
1016a6de8: 959600d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6dec: aa0003fb    	mov	x27, x0
1016a6df0: aa1403e0    	mov	x0, x20
1016a6df4: f9400be1    	ldr	x1, [sp, #0x10]
1016a6df8: aa1b03e2    	mov	x2, x27
1016a6dfc: 959600d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6e00: f87c6a60    	ldr	x0, [x19, x28]
1016a6e04: d00f3ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1016a6e08: f9403d16    	ldr	x22, [x8, #0x78] ; setTop:
1016a6e0c: aa1603e1    	mov	x1, x22
1016a6e10: 959600cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6e14: aa1b03e0    	mov	x0, x27
1016a6e18: 959600cf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6e1c: aa1a03e0    	mov	x0, x26
1016a6e20: 959600cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6e24: aa1903e0    	mov	x0, x25
1016a6e28: 959600cb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6e2c: 900f4008    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1016a6e30: f9445501    	ldr	x1, [x8, #0x8a8] ; bIsDisplayCenter
1016a6e34: aa1303e0    	mov	x0, x19
1016a6e38: 959600c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6e3c: 34000340    	cbz	w0, 0x1016a6ea4 <__text+0x169eea4>
1016a6e40: aa1303e0    	mov	x0, x19
1016a6e44: f94027e1    	ldr	x1, [sp, #0x48]
1016a6e48: 959600bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6e4c: aa1d03fd    	mov	x29, x29
1016a6e50: 959600be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6e54: aa0003f4    	mov	x20, x0
1016a6e58: f94003f5    	ldr	x21, [sp]
1016a6e5c: aa1503e1    	mov	x1, x21
1016a6e60: 959600b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6e64: 1e60400a    	fmov	d10, d0
1016a6e68: f87c6a60    	ldr	x0, [x19, x28]
1016a6e6c: aa1503e1    	mov	x1, x21
1016a6e70: 959600b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6e74: 1e60394a    	fsub	d10, d10, d0
1016a6e78: f8786a60    	ldr	x0, [x19, x24]
1016a6e7c: aa1503e1    	mov	x1, x21
1016a6e80: 959600af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6e84: 1e603940    	fsub	d0, d10, d0
1016a6e88: 1e6c1001    	fmov	d1, #0.50000000
1016a6e8c: 1e610800    	fmul	d0, d0, d1
1016a6e90: f87c6a60    	ldr	x0, [x19, x28]
1016a6e94: aa1603e1    	mov	x1, x22
1016a6e98: 959600a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6e9c: aa1403e0    	mov	x0, x20
1016a6ea0: 959600ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6ea4: f87c6a60    	ldr	x0, [x19, x28]
1016a6ea8: d00f3ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1016a6eac: f9432901    	ldr	x1, [x8, #0x650] ; bottom
1016a6eb0: 959600a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6eb4: 9e6703e1    	fmov	d1, xzr
1016a6eb8: 1e612800    	fadd	d0, d0, d1
1016a6ebc: f8786a60    	ldr	x0, [x19, x24]
1016a6ec0: aa1603e1    	mov	x1, x22
1016a6ec4: 9596009e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6ec8: f8786a60    	ldr	x0, [x19, x24]
1016a6ecc: aa1703e1    	mov	x1, x23
1016a6ed0: 9596009b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6ed4: 1e60400a    	fmov	d10, d0
1016a6ed8: aa1303e0    	mov	x0, x19
1016a6edc: f94027e1    	ldr	x1, [sp, #0x48]
1016a6ee0: 95960097    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6ee4: aa1d03fd    	mov	x29, x29
1016a6ee8: 95960098    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6eec: aa0003f4    	mov	x20, x0
1016a6ef0: aa1703e1    	mov	x1, x23
1016a6ef4: 95960092    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6ef8: 1e68380b    	fsub	d11, d0, d8
1016a6efc: aa1403e0    	mov	x0, x20
1016a6f00: 95960095    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6f04: 1e6b2140    	fcmp	d10, d11
1016a6f08: 900f5328    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1016a6f0c: 540000ed    	b.le	0x1016a6f28 <__text+0x169ef28>
1016a6f10: 1e683920    	fsub	d0, d9, d8
1016a6f14: 9e6703e1    	fmov	d1, xzr
1016a6f18: 1e616800    	fmaxnm	d0, d0, d1
1016a6f1c: f8786a60    	ldr	x0, [x19, x24]
1016a6f20: f9418d01    	ldr	x1, [x8, #0x318] ; setWidth:
1016a6f24: 95960086    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6f28: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a6f2c: b983751b    	ldrsw	x27, [x8, #0x374]
1016a6f30: f87b6a60    	ldr	x0, [x19, x27]
1016a6f34: b00f52e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1016a6f38: f943f916    	ldr	x22, [x8, #0x7f0] ; isHidden
1016a6f3c: aa1603e1    	mov	x1, x22
1016a6f40: 9596007f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6f44: 9e6703ea    	fmov	d10, xzr
1016a6f48: 370000c0    	tbnz	w0, #0x0, 0x1016a6f60 <__text+0x169ef60>
1016a6f4c: f87b6a60    	ldr	x0, [x19, x27]
1016a6f50: aa1703e1    	mov	x1, x23
1016a6f54: 9596007a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6f58: 1e621001    	fmov	d1, #4.00000000
1016a6f5c: 1e61280a    	fadd	d10, d0, d1
1016a6f60: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a6f64: b9837d18    	ldrsw	x24, [x8, #0x37c]
1016a6f68: f8786a60    	ldr	x0, [x19, x24]
1016a6f6c: aa1603e1    	mov	x1, x22
1016a6f70: 95960073    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6f74: 370000e0    	tbnz	w0, #0x0, 0x1016a6f90 <__text+0x169ef90>
1016a6f78: f8786a60    	ldr	x0, [x19, x24]
1016a6f7c: aa1703e1    	mov	x1, x23
1016a6f80: 9596006f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6f84: 1e621001    	fmov	d1, #4.00000000
1016a6f88: 1e612800    	fadd	d0, d0, d1
1016a6f8c: 1e60294a    	fadd	d10, d10, d0
1016a6f90: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a6f94: b9839519    	ldrsw	x25, [x8, #0x394]
1016a6f98: f8796a60    	ldr	x0, [x19, x25]
1016a6f9c: 900f5328    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1016a6fa0: f9475d01    	ldr	x1, [x8, #0xeb8] ; superview
1016a6fa4: f90017e1    	str	x1, [sp, #0x28]
1016a6fa8: 95960065    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6fac: aa1d03fd    	mov	x29, x29
1016a6fb0: 95960066    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a6fb4: aa0003f4    	mov	x20, x0
1016a6fb8: 95960067    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a6fbc: b40000f4    	cbz	x20, 0x1016a6fd8 <__text+0x169efd8>
1016a6fc0: f8796a60    	ldr	x0, [x19, x25]
1016a6fc4: aa1703e1    	mov	x1, x23
1016a6fc8: 9596005d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6fcc: 1e631001    	fmov	d1, #6.00000000
1016a6fd0: 1e612800    	fadd	d0, d0, d1
1016a6fd4: 1e60294a    	fadd	d10, d10, d0
1016a6fd8: d00f5a48    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a6fdc: b9838514    	ldrsw	x20, [x8, #0x384]
1016a6fe0: f8746a60    	ldr	x0, [x19, x20]
1016a6fe4: aa1603e1    	mov	x1, x22
1016a6fe8: 95960055    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a6fec: f9001bf4    	str	x20, [sp, #0x30]
1016a6ff0: 370000e0    	tbnz	w0, #0x0, 0x1016a700c <__text+0x169f00c>
1016a6ff4: f8746a60    	ldr	x0, [x19, x20]
1016a6ff8: aa1703e1    	mov	x1, x23
1016a6ffc: 95960050    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7000: 1e621001    	fmov	d1, #4.00000000
1016a7004: 1e612800    	fadd	d0, d0, d1
1016a7008: 1e60294a    	fadd	d10, d10, d0
1016a700c: f00f3fe8    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1016a7010: f9443d15    	ldr	x21, [x8, #0x878] ; textStateView
1016a7014: aa1303e0    	mov	x0, x19
1016a7018: aa1503e1    	mov	x1, x21
1016a701c: 95960048    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7020: aa1d03fd    	mov	x29, x29
1016a7024: 95960049    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a7028: aa0003f4    	mov	x20, x0
1016a702c: aa1603e1    	mov	x1, x22
1016a7030: 95960043    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7034: aa0003fa    	mov	x26, x0
1016a7038: aa1403e0    	mov	x0, x20
1016a703c: 95960046    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a7040: 370001da    	tbnz	w26, #0x0, 0x1016a7078 <__text+0x169f078>
1016a7044: aa1303e0    	mov	x0, x19
1016a7048: aa1503e1    	mov	x1, x21
1016a704c: 9596003c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7050: aa1d03fd    	mov	x29, x29
1016a7054: 9596003d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a7058: aa0003f4    	mov	x20, x0
1016a705c: aa1703e1    	mov	x1, x23
1016a7060: 95960037    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7064: 1e601001    	fmov	d1, #2.00000000
1016a7068: 1e612800    	fadd	d0, d0, d1
1016a706c: 1e60294a    	fadd	d10, d10, d0
1016a7070: aa1403e0    	mov	x0, x20
1016a7074: 95960038    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a7078: f87c6a60    	ldr	x0, [x19, x28]
1016a707c: aa1703e1    	mov	x1, x23
1016a7080: 9596002f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7084: 1e604008    	fmov	d8, d0
1016a7088: aa1303e0    	mov	x0, x19
1016a708c: f94027e1    	ldr	x1, [sp, #0x48]
1016a7090: 9596002b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7094: aa1d03fd    	mov	x29, x29
1016a7098: 9596002c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a709c: aa0003f4    	mov	x20, x0
1016a70a0: aa1703e1    	mov	x1, x23
1016a70a4: 95960026    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a70a8: 1e604009    	fmov	d9, d0
1016a70ac: f87c6a60    	ldr	x0, [x19, x28]
1016a70b0: b00f3ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1016a70b4: f9404501    	ldr	x1, [x8, #0x88] ; left
1016a70b8: 95960021    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a70bc: 1e603920    	fsub	d0, d9, d0
1016a70c0: 1e6a3800    	fsub	d0, d0, d10
1016a70c4: 1e761001    	fmov	d1, #-16.00000000
1016a70c8: 1e612809    	fadd	d9, d0, d1
1016a70cc: aa1403e0    	mov	x0, x20
1016a70d0: 95960021    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a70d4: 1e692100    	fcmp	d8, d9
1016a70d8: 1e694d00    	fcsel	d0, d8, d9, mi
1016a70dc: f87c6a60    	ldr	x0, [x19, x28]
1016a70e0: f00f5308    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1016a70e4: f9418d01    	ldr	x1, [x8, #0x318] ; setWidth:
1016a70e8: 95960015    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a70ec: f87c6a60    	ldr	x0, [x19, x28]
1016a70f0: f9401ff4    	ldr	x20, [sp, #0x38]
1016a70f4: aa1403e1    	mov	x1, x20
1016a70f8: 95960011    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a70fc: 1e604008    	fmov	d8, d0
1016a7100: f87b6a60    	ldr	x0, [x19, x27]
1016a7104: aa1603e1    	mov	x1, x22
1016a7108: 9596000d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a710c: b00f3cba    	adrp	x26, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1016a7110: 37000200    	tbnz	w0, #0x0, 0x1016a7150 <__text+0x169f150>
1016a7114: 1e621000    	fmov	d0, #4.00000000
1016a7118: 1e602900    	fadd	d0, d8, d0
1016a711c: f87b6a60    	ldr	x0, [x19, x27]
1016a7120: f94023e1    	ldr	x1, [sp, #0x40]
1016a7124: 95960006    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7128: f87c6a60    	ldr	x0, [x19, x28]
1016a712c: f9432741    	ldr	x1, [x26, #0x648] ; centerY
1016a7130: 95960003    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7134: f87b6a60    	ldr	x0, [x19, x27]
1016a7138: f94007e1    	ldr	x1, [sp, #0x8]
1016a713c: 95960000    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7140: f87b6a60    	ldr	x0, [x19, x27]
1016a7144: aa1403e1    	mov	x1, x20
1016a7148: 9595fffd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a714c: 1e604008    	fmov	d8, d0
1016a7150: f8786a60    	ldr	x0, [x19, x24]
1016a7154: aa1603e1    	mov	x1, x22
1016a7158: 9595fff9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a715c: 36000060    	tbz	w0, #0x0, 0x1016a7168 <__text+0x169f168>
1016a7160: f94007fb    	ldr	x27, [sp, #0x8]
1016a7164: 14000011    	b	0x1016a71a8 <__text+0x169f1a8>
1016a7168: 1e621000    	fmov	d0, #4.00000000
1016a716c: 1e602900    	fadd	d0, d8, d0
1016a7170: f8786a60    	ldr	x0, [x19, x24]
1016a7174: f94023e1    	ldr	x1, [sp, #0x40]
1016a7178: 9595fff1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a717c: f87c6a60    	ldr	x0, [x19, x28]
1016a7180: f9432741    	ldr	x1, [x26, #0x648] ; centerY
1016a7184: 9595ffee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7188: f8786a60    	ldr	x0, [x19, x24]
1016a718c: f94007fb    	ldr	x27, [sp, #0x8]
1016a7190: aa1b03e1    	mov	x1, x27
1016a7194: 9595ffea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7198: f8786a60    	ldr	x0, [x19, x24]
1016a719c: aa1403e1    	mov	x1, x20
1016a71a0: 9595ffe7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a71a4: 1e604008    	fmov	d8, d0
1016a71a8: aa1303e0    	mov	x0, x19
1016a71ac: aa1503e1    	mov	x1, x21
1016a71b0: 9595ffe3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a71b4: aa1d03fd    	mov	x29, x29
1016a71b8: 9595ffe4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a71bc: aa0003f4    	mov	x20, x0
1016a71c0: aa1603e1    	mov	x1, x22
1016a71c4: 9595ffde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a71c8: aa0003f7    	mov	x23, x0
1016a71cc: aa1403e0    	mov	x0, x20
1016a71d0: 9595ffe1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a71d4: 36000077    	tbz	w23, #0x0, 0x1016a71e0 <__text+0x169f1e0>
1016a71d8: f9401ff5    	ldr	x21, [sp, #0x38]
1016a71dc: 14000029    	b	0x1016a7280 <__text+0x169f280>
1016a71e0: f87c6a60    	ldr	x0, [x19, x28]
1016a71e4: f9432741    	ldr	x1, [x26, #0x648] ; centerY
1016a71e8: 9595ffd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a71ec: 1e604009    	fmov	d9, d0
1016a71f0: aa1303e0    	mov	x0, x19
1016a71f4: aa1503e1    	mov	x1, x21
1016a71f8: 9595ffd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a71fc: aa1d03fd    	mov	x29, x29
1016a7200: 9595ffd2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a7204: aa0003f4    	mov	x20, x0
1016a7208: aa1b03e1    	mov	x1, x27
1016a720c: 1e604120    	fmov	d0, d9
1016a7210: 9595ffcb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7214: aa1403e0    	mov	x0, x20
1016a7218: 9595ffcf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a721c: 1e601000    	fmov	d0, #2.00000000
1016a7220: 1e602908    	fadd	d8, d8, d0
1016a7224: aa1303e0    	mov	x0, x19
1016a7228: aa1503e1    	mov	x1, x21
1016a722c: 9595ffc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7230: aa1d03fd    	mov	x29, x29
1016a7234: 9595ffc5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a7238: aa0003f4    	mov	x20, x0
1016a723c: f94023e1    	ldr	x1, [sp, #0x40]
1016a7240: 1e604100    	fmov	d0, d8
1016a7244: 9595ffbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7248: aa1403e0    	mov	x0, x20
1016a724c: 9595ffc2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a7250: aa1303e0    	mov	x0, x19
1016a7254: aa1503e1    	mov	x1, x21
1016a7258: 9595ffb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a725c: aa1d03fd    	mov	x29, x29
1016a7260: 9595ffba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a7264: aa0003f4    	mov	x20, x0
1016a7268: f9401ff5    	ldr	x21, [sp, #0x38]
1016a726c: aa1503e1    	mov	x1, x21
1016a7270: 9595ffb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7274: 1e604008    	fmov	d8, d0
1016a7278: aa1403e0    	mov	x0, x20
1016a727c: 9595ffb6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a7280: f8796a60    	ldr	x0, [x19, x25]
1016a7284: f94017e1    	ldr	x1, [sp, #0x28]
1016a7288: 9595ffad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a728c: aa1d03fd    	mov	x29, x29
1016a7290: 9595ffae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a7294: aa0003f4    	mov	x20, x0
1016a7298: 9595ffaf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a729c: b4000214    	cbz	x20, 0x1016a72dc <__text+0x169f2dc>
1016a72a0: 1e631000    	fmov	d0, #6.00000000
1016a72a4: 1e602900    	fadd	d0, d8, d0
1016a72a8: f8796a60    	ldr	x0, [x19, x25]
1016a72ac: f94023e1    	ldr	x1, [sp, #0x40]
1016a72b0: 9595ffa3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a72b4: f87c6a60    	ldr	x0, [x19, x28]
1016a72b8: f9432741    	ldr	x1, [x26, #0x648] ; centerY
1016a72bc: 9595ffa0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a72c0: f8796a60    	ldr	x0, [x19, x25]
1016a72c4: aa1b03e1    	mov	x1, x27
1016a72c8: 9595ff9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a72cc: f8796a60    	ldr	x0, [x19, x25]
1016a72d0: aa1503e1    	mov	x1, x21
1016a72d4: 9595ff9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a72d8: 1e604008    	fmov	d8, d0
1016a72dc: f9401bf4    	ldr	x20, [sp, #0x30]
1016a72e0: f8746a60    	ldr	x0, [x19, x20]
1016a72e4: aa1603e1    	mov	x1, x22
1016a72e8: 9595ff95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a72ec: 370001a0    	tbnz	w0, #0x0, 0x1016a7320 <__text+0x169f320>
1016a72f0: 1e621000    	fmov	d0, #4.00000000
1016a72f4: 1e602900    	fadd	d0, d8, d0
1016a72f8: f8746a60    	ldr	x0, [x19, x20]
1016a72fc: b00f3ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1016a7300: f9432101    	ldr	x1, [x8, #0x640] ; setLeft:
1016a7304: 9595ff8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7308: f87c6a60    	ldr	x0, [x19, x28]
1016a730c: f9432741    	ldr	x1, [x26, #0x648] ; centerY
1016a7310: 9595ff8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7314: f8746a60    	ldr	x0, [x19, x20]
1016a7318: aa1b03e1    	mov	x1, x27
1016a731c: 9595ff88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7320: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
1016a7324: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
1016a7328: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
1016a732c: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
1016a7330: a94967fa    	ldp	x26, x25, [sp, #0x90]
1016a7334: a9486ffc    	ldp	x28, x27, [sp, #0x80]
1016a7338: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
1016a733c: 6d462beb    	ldp	d11, d10, [sp, #0x60]
1016a7340: 910383ff    	add	sp, sp, #0xe0
1016a7344: d65f03c0    	ret
1016a7348: aa1303e0    	mov	x0, x19
1016a734c: f94027e1    	ldr	x1, [sp, #0x48]
1016a7350: 9595ff7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7354: aa1d03fd    	mov	x29, x29
1016a7358: 9595ff7c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1016a735c: aa0003f4    	mov	x20, x0
1016a7360: f94003f5    	ldr	x21, [sp]
1016a7364: aa1503e1    	mov	x1, x21
1016a7368: 9595ff75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a736c: 1e60400a    	fmov	d10, d0
1016a7370: f87c6a60    	ldr	x0, [x19, x28]
1016a7374: aa1503e1    	mov	x1, x21
1016a7378: 9595ff71    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a737c: 1e603940    	fsub	d0, d10, d0
1016a7380: 1e6c1001    	fmov	d1, #0.50000000
1016a7384: 1e610800    	fmul	d0, d0, d1
1016a7388: f87c6a60    	ldr	x0, [x19, x28]
1016a738c: b00f3ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1016a7390: f9403d01    	ldr	x1, [x8, #0x78] ; setTop:
1016a7394: 9595ff6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a7398: aa1403e0    	mov	x0, x20
1016a739c: 9595ff6e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1016a73a0: 17fffeca    	b	0x1016a6ec8 <__text+0x169eec8>
