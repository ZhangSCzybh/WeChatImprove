
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106277d54: d10343ff    	sub	sp, sp, #0xd0
106277d58: 6d0623e9    	stp	d9, d8, [sp, #0x60]
106277d5c: a9076ffc    	stp	x28, x27, [sp, #0x70]
106277d60: a90867fa    	stp	x26, x25, [sp, #0x80]
106277d64: a9095ff8    	stp	x24, x23, [sp, #0x90]
106277d68: a90a57f6    	stp	x22, x21, [sp, #0xa0]
106277d6c: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
106277d70: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
106277d74: 910303fd    	add	x29, sp, #0xc0
106277d78: aa0003f3    	mov	x19, x0
106277d7c: 900d4e68    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106277d80: 52800029    	mov	w9, #0x1                ; =1
106277d84: 3927b109    	strb	w9, [x8, #0x9ec]
106277d88: 900cf7fb    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
106277d8c: f9462f60    	ldr	x0, [x27, #0xc58]
106277d90: b00cde28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106277d94: f9431116    	ldr	x22, [x8, #0x620] ; Glyph_0
106277d98: aa1603e1    	mov	x1, x22
106277d9c: 9466bce8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277da0: aa1d03fd    	mov	x29, x29
106277da4: 9466bce9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106277da8: aa0003f4    	mov	x20, x0
106277dac: b00b9ba8    	adrp	x8, 0x11d5ec000 <dyld_stub_binder+0x11d5ec000>
106277db0: f945e508    	ldr	x8, [x8, #0xbc8]
106277db4: ad400500    	ldp	q0, q1, [x8]
106277db8: ad0187e0    	stp	q0, q1, [sp, #0x30]
106277dbc: 3dc00900    	ldr	q0, [x8, #0x20]
106277dc0: 3d8017e0    	str	q0, [sp, #0x50]
106277dc4: f00cde28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
106277dc8: f9410915    	ldr	x21, [x8, #0x210] ; viewModel
106277dcc: aa1303e0    	mov	x0, x19
106277dd0: aa1503e1    	mov	x1, x21
106277dd4: 9466bcda    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277dd8: aa1d03fd    	mov	x29, x29
106277ddc: 9466bcdb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106277de0: aa0003f7    	mov	x23, x0
106277de4: 900cde48    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106277de8: f940d501    	ldr	x1, [x8, #0x1a8] ; isSender
106277dec: 9466bcd4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277df0: aa0003f8    	mov	x24, x0
106277df4: aa1703e0    	mov	x0, x23
106277df8: 9466bcd7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106277dfc: 900cf7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106277e00: b00cf449    	adrp	x9, 0x120100000 <dyld_stub_binder+0x120100000>
106277e04: 900cf45a    	adrp	x26, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106277e08: d00cde19    	adrp	x25, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106277e0c: 340006d8    	cbz	w24, 0x106277ee4 <_Flutter_MMFoundation_BindContext+0x2753ac8>
106277e10: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
106277e14: f944e921    	ldr	x1, [x9, #0x9d0] ; currentContext
106277e18: 9466bcc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277e1c: aa1d03fd    	mov	x29, x29
106277e20: 9466bcca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106277e24: aa0003f7    	mov	x23, x0
106277e28: b00cf7e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106277e2c: f947b100    	ldr	x0, [x8, #0xf60] ; hd, 
106277e30: aa1a03fc    	mov	x28, x26
106277e34: f947af41    	ldr	x1, [x26, #0xf58] ; class
106277e38: 9466bcc1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277e3c: aa0003e2    	mov	x2, x0
106277e40: aa1903fa    	mov	x26, x25
106277e44: f9464321    	ldr	x1, [x25, #0xc80] ; getService:
106277e48: aa1703e0    	mov	x0, x23
106277e4c: 9466bcbc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277e50: aa1d03fd    	mov	x29, x29
106277e54: 9466bcbd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106277e58: aa0003f8    	mov	x24, x0
106277e5c: d00cde48    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
106277e60: f9431901    	ldr	x1, [x8, #0x630] ; isEnabled
106277e64: 9466bcb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277e68: aa0003f9    	mov	x25, x0
106277e6c: aa1803e0    	mov	x0, x24
106277e70: 9466bcb9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106277e74: aa1703e0    	mov	x0, x23
106277e78: 9466bcb7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106277e7c: f9462f60    	ldr	x0, [x27, #0xc58]
106277e80: aa1603e1    	mov	x1, x22
106277e84: 9466bcae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277e88: aa1d03fd    	mov	x29, x29
106277e8c: 9466bcaf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106277e90: aa0003f6    	mov	x22, x0
106277e94: 37000199    	tbnz	w25, #0x0, 0x106277ec4 <_Flutter_MMFoundation_BindContext+0x2753aa8>
106277e98: b00cde48    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
106277e9c: f9472d01    	ldr	x1, [x8, #0xe58] ; colorInLightMode
106277ea0: aa1603e0    	mov	x0, x22
106277ea4: 9466bca6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277ea8: aa1d03fd    	mov	x29, x29
106277eac: 9466bca7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106277eb0: aa0003f7    	mov	x23, x0
106277eb4: aa1403e0    	mov	x0, x20
106277eb8: 9466bca7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106277ebc: aa1603f4    	mov	x20, x22
106277ec0: aa1703f6    	mov	x22, x23
106277ec4: aa1403e0    	mov	x0, x20
106277ec8: 9466bca3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106277ecc: 9100c3e8    	add	x8, sp, #0x30
106277ed0: 1e7e1000    	fmov	d0, #-1.00000000
106277ed4: 1e6e1001    	fmov	d1, #1.00000000
106277ed8: 9466bcf7    	bl	0x107c272b4 <_Flutter_MMFoundation_BindContext+0x4102e98>
106277edc: aa1603f4    	mov	x20, x22
106277ee0: 14000003    	b	0x106277eec <_Flutter_MMFoundation_BindContext+0x2753ad0>
106277ee4: aa1a03fc    	mov	x28, x26
106277ee8: aa1903fa    	mov	x26, x25
106277eec: 900cf8e8    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
106277ef0: f9420500    	ldr	x0, [x8, #0x408] ; �>; 
106277ef4: 9466bc9b    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106277ef8: aa0003f6    	mov	x22, x0
106277efc: 900cf7f8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
106277f00: f9461b00    	ldr	x0, [x24, #0xc30]
106277f04: d00cde08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106277f08: f9463117    	ldr	x23, [x8, #0xc60] ; dynamicLength:
106277f0c: 1e671000    	fmov	d0, #24.00000000
106277f10: aa1703e1    	mov	x1, x23
106277f14: 9466bc8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277f18: 1e604008    	fmov	d8, d0
106277f1c: f9461b00    	ldr	x0, [x24, #0xc30]
106277f20: 1e671000    	fmov	d0, #24.00000000
106277f24: aa1703e1    	mov	x1, x23
106277f28: 9466bc85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277f2c: 1e604003    	fmov	d3, d0
106277f30: f00cdec8    	adrp	x8, 0x11fe52000 <dyld_stub_binder+0x11fe52000>
106277f34: f945bd01    	ldr	x1, [x8, #0xb78] ; initWithFrame:color:
106277f38: 9e6703e0    	fmov	d0, xzr
106277f3c: 9e6703e1    	fmov	d1, xzr
106277f40: aa1603e0    	mov	x0, x22
106277f44: 1e604102    	fmov	d2, d8
106277f48: aa1403e2    	mov	x2, x20
106277f4c: 9466bc7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277f50: b00cfe08    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
106277f54: b98d5119    	ldrsw	x25, [x8, #0xd50]
106277f58: f8796a68    	ldr	x8, [x19, x25]
106277f5c: f8396a60    	str	x0, [x19, x25]
106277f60: aa0803e0    	mov	x0, x8
106277f64: 9466bc7c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106277f68: aa1303e0    	mov	x0, x19
106277f6c: aa1503e1    	mov	x1, x21
106277f70: 9466bc73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277f74: aa1d03fd    	mov	x29, x29
106277f78: 9466bc74    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106277f7c: aa0003f6    	mov	x22, x0
106277f80: f00cde28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
106277f84: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
106277f88: 9466bc6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277f8c: aa1d03fd    	mov	x29, x29
106277f90: 9466bc6e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106277f94: aa0003f7    	mov	x23, x0
106277f98: 900cde48    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106277f9c: f9411101    	ldr	x1, [x8, #0x220] ; m_uiDownloadStatus
106277fa0: 9466bc67    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277fa4: 7200001f    	tst	w0, #0x1
106277fa8: 1a9f17e2    	cset	w2, eq
106277fac: f8796a60    	ldr	x0, [x19, x25]
106277fb0: b00cf488    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106277fb4: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
106277fb8: 9466bc61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277fbc: aa1703e0    	mov	x0, x23
106277fc0: 9466bc65    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106277fc4: aa1603e0    	mov	x0, x22
106277fc8: 9466bc63    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106277fcc: ad4187e0    	ldp	q0, q1, [sp, #0x30]
106277fd0: ad0007e0    	stp	q0, q1, [sp]
106277fd4: 3dc017e0    	ldr	q0, [sp, #0x50]
106277fd8: 3d800be0    	str	q0, [sp, #0x20]
106277fdc: f8796a60    	ldr	x0, [x19, x25]
106277fe0: d00cf488    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
106277fe4: f9479901    	ldr	x1, [x8, #0xf30] ; setTransform:
106277fe8: 910003e2    	mov	x2, sp
106277fec: 9466bc54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277ff0: f8796a60    	ldr	x0, [x19, x25]
106277ff4: f00cf468    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106277ff8: f947a501    	ldr	x1, [x8, #0xf48] ; setAnimationDuration:
106277ffc: 1e6e1000    	fmov	d0, #1.00000000
106278000: 9466bc4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106278004: aa1303e0    	mov	x0, x19
106278008: aa1503e1    	mov	x1, x21
10627800c: 9466bc4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106278010: aa1d03fd    	mov	x29, x29
106278014: 9466bc4d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106278018: aa0003f5    	mov	x21, x0
10627801c: b00cde08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106278020: f9447101    	ldr	x1, [x8, #0x8e0] ; isPlaying
106278024: 9466bc46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106278028: 36000480    	tbz	w0, #0x0, 0x1062780b8 <_Flutter_MMFoundation_BindContext+0x2753c9c>
10627802c: f00cf7c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106278030: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
106278034: 900cf448    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106278038: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10627803c: 9466bc40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106278040: aa1d03fd    	mov	x29, x29
106278044: 9466bc41    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106278048: aa0003f6    	mov	x22, x0
10627804c: d00cf7e8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
106278050: f9428500    	ldr	x0, [x8, #0x508]
106278054: f947af81    	ldr	x1, [x28, #0xf58]
106278058: 9466bc39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627805c: aa0003e2    	mov	x2, x0
106278060: f9464341    	ldr	x1, [x26, #0xc80] ; cancelRequestTask
106278064: aa1603e0    	mov	x0, x22
106278068: 9466bc35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627806c: aa1d03fd    	mov	x29, x29
106278070: 9466bc36    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106278074: aa0003f7    	mov	x23, x0
106278078: f00ce8a8    	adrp	x8, 0x11ff8f000 <dyld_stub_binder+0x11ff8f000>
10627807c: f9468101    	ldr	x1, [x8, #0xd00] ; isShowingMinimizeView
106278080: 9466bc2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106278084: aa0003f8    	mov	x24, x0
106278088: aa1703e0    	mov	x0, x23
10627808c: 9466bc32    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106278090: aa1603e0    	mov	x0, x22
106278094: 9466bc30    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106278098: aa1503e0    	mov	x0, x21
10627809c: 9466bc2e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062780a0: 37000118    	tbnz	w24, #0x0, 0x1062780c0 <_Flutter_MMFoundation_BindContext+0x2753ca4>
1062780a4: f8796a60    	ldr	x0, [x19, x25]
1062780a8: d00cf488    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1062780ac: f944e101    	ldr	x1, [x8, #0x9c0] ; startAnimating
1062780b0: 9466bc23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062780b4: 14000003    	b	0x1062780c0 <_Flutter_MMFoundation_BindContext+0x2753ca4>
1062780b8: aa1503e0    	mov	x0, x21
1062780bc: 9466bc26    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062780c0: aa1403e0    	mov	x0, x20
1062780c4: 9466bc24    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062780c8: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
1062780cc: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
1062780d0: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
1062780d4: a9495ff8    	ldp	x24, x23, [sp, #0x90]
1062780d8: a94867fa    	ldp	x26, x25, [sp, #0x80]
1062780dc: a9476ffc    	ldp	x28, x27, [sp, #0x70]
1062780e0: 6d4623e9    	ldp	d9, d8, [sp, #0x60]
1062780e4: 910343ff    	add	sp, sp, #0xd0
1062780e8: d65f03c0    	ret