
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106ad4dc8: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
106ad4dcc: a9015ff8    	stp	x24, x23, [sp, #0x10]
106ad4dd0: a90257f6    	stp	x22, x21, [sp, #0x20]
106ad4dd4: a9034ff4    	stp	x20, x19, [sp, #0x30]
106ad4dd8: a9047bfd    	stp	x29, x30, [sp, #0x40]
106ad4ddc: 910103fd    	add	x29, sp, #0x40
106ad4de0: aa0003f3    	mov	x19, x0
106ad4de4: b00d0b88    	adrp	x8, 0x120c45000 <dyld_stub_binder+0x120c45000>
106ad4de8: 52800029    	mov	w9, #0x1                ; =1
106ad4dec: 3921ed09    	strb	w9, [x8, #0x87b]
106ad4df0: b00cbb68    	adrp	x8, 0x120241000 <dyld_stub_binder+0x120241000>
106ad4df4: b98d3d18    	ldrsw	x24, [x8, #0xd3c]
106ad4df8: f8786800    	ldr	x0, [x0, x24]
106ad4dfc: b5001060    	cbnz	x0, 0x106ad5008 <_Flutter_MMFoundation_BindContext+0x2fb0bec>
106ad4e00: f00cb4e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106ad4e04: f945e900    	ldr	x0, [x8, #0xbd0]
106ad4e08: 900cb168    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106ad4e0c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106ad4e10: 944548cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4e14: aa1d03fd    	mov	x29, x29
106ad4e18: 944548cc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad4e1c: aa0003f5    	mov	x21, x0
106ad4e20: 900cb508    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106ad4e24: f9404100    	ldr	x0, [x8, #0x80]
106ad4e28: f00cb148    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106ad4e2c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
106ad4e30: 944548c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4e34: aa0003e2    	mov	x2, x0
106ad4e38: b00c9b28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106ad4e3c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106ad4e40: aa1503e0    	mov	x0, x21
106ad4e44: 944548be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4e48: aa1d03fd    	mov	x29, x29
106ad4e4c: 944548bf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad4e50: aa0003f6    	mov	x22, x0
106ad4e54: f00cb4e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106ad4e58: f9462d00    	ldr	x0, [x8, #0xc58]
106ad4e5c: f00c9b48    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106ad4e60: f941d101    	ldr	x1, [x8, #0x3a0] ; White
106ad4e64: 944548b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4e68: aa1d03fd    	mov	x29, x29
106ad4e6c: 944548b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad4e70: aa0003f7    	mov	x23, x0
106ad4e74: 900c9b48    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106ad4e78: f9437901    	ldr	x1, [x8, #0x6f0] ; svgImageNamed:size:color:
106ad4e7c: 900bd762    	adrp	x2, 0x11e5c0000 <dyld_stub_binder+0x11e5c0000>
106ad4e80: 9104a042    	add	x2, x2, #0x128
106ad4e84: 1e669000    	fmov	d0, #20.00000000
106ad4e88: 1e669001    	fmov	d1, #20.00000000
106ad4e8c: aa1603e0    	mov	x0, x22
106ad4e90: aa1703e3    	mov	x3, x23
106ad4e94: 944548aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4e98: aa1d03fd    	mov	x29, x29
106ad4e9c: 944548ab    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad4ea0: aa0003f4    	mov	x20, x0
106ad4ea4: aa1703e0    	mov	x0, x23
106ad4ea8: 944548ab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad4eac: aa1603e0    	mov	x0, x22
106ad4eb0: 944548a9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad4eb4: aa1503e0    	mov	x0, x21
106ad4eb8: 944548a7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad4ebc: 900cb508    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106ad4ec0: f940b900    	ldr	x0, [x8, #0x170]
106ad4ec4: 944548a7    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106ad4ec8: f00cb168    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106ad4ecc: f9400101    	ldr	x1, [x8]
106ad4ed0: aa1403e2    	mov	x2, x20
106ad4ed4: 9445489a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4ed8: f8786a68    	ldr	x8, [x19, x24]
106ad4edc: f8386a60    	str	x0, [x19, x24]
106ad4ee0: aa0803e0    	mov	x0, x8
106ad4ee4: 9445489c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad4ee8: f8786a60    	ldr	x0, [x19, x24]
106ad4eec: f00cb168    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106ad4ef0: f9469515    	ldr	x21, [x8, #0xd28] ; layer
106ad4ef4: aa1503e1    	mov	x1, x21
106ad4ef8: 94454891    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4efc: aa1d03fd    	mov	x29, x29
106ad4f00: 94454892    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad4f04: aa0003f6    	mov	x22, x0
106ad4f08: b00cb1a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
106ad4f0c: f944c501    	ldr	x1, [x8, #0x988] ; setShadowOpacity:
106ad4f10: b0091568    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
106ad4f14: bd451500    	ldr	s0, [x8, #0x514]
106ad4f18: 94454889    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4f1c: aa1603e0    	mov	x0, x22
106ad4f20: 9445488d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad4f24: f8786a60    	ldr	x0, [x19, x24]
106ad4f28: aa1503e1    	mov	x1, x21
106ad4f2c: 94454884    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4f30: aa1d03fd    	mov	x29, x29
106ad4f34: 94454885    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad4f38: aa0003f6    	mov	x22, x0
106ad4f3c: b00cb1a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
106ad4f40: f944c901    	ldr	x1, [x8, #0x990] ; setShadowRadius:
106ad4f44: 1e6e1000    	fmov	d0, #1.00000000
106ad4f48: 9445487d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4f4c: aa1603e0    	mov	x0, x22
106ad4f50: 94454881    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad4f54: b00b58c8    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
106ad4f58: f9417908    	ldr	x8, [x8, #0x2f0]
106ad4f5c: 6d402508    	ldp	d8, d9, [x8]
106ad4f60: f8786a60    	ldr	x0, [x19, x24]
106ad4f64: aa1503e1    	mov	x1, x21
106ad4f68: 94454875    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4f6c: aa1d03fd    	mov	x29, x29
106ad4f70: 94454876    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad4f74: aa0003f5    	mov	x21, x0
106ad4f78: b00cb1a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
106ad4f7c: f944c101    	ldr	x1, [x8, #0x980] ; setShadowOffset:
106ad4f80: 1e604100    	fmov	d0, d8
106ad4f84: 1e604121    	fmov	d1, d9
106ad4f88: 9445486d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4f8c: aa1503e0    	mov	x0, x21
106ad4f90: 94454871    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad4f94: f8786a60    	ldr	x0, [x19, x24]
106ad4f98: 900cb1a8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106ad4f9c: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
106ad4fa0: 1e651000    	fmov	d0, #12.00000000
106ad4fa4: 1e651001    	fmov	d1, #12.00000000
106ad4fa8: 1e669002    	fmov	d2, #20.00000000
106ad4fac: 1e669003    	fmov	d3, #20.00000000
106ad4fb0: 94454863    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4fb4: f8786a60    	ldr	x0, [x19, x24]
106ad4fb8: 900cb1a8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106ad4fbc: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
106ad4fc0: 52800022    	mov	w2, #0x1                ; =1
106ad4fc4: 9445485e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4fc8: 900cb168    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106ad4fcc: f9427501    	ldr	x1, [x8, #0x4e8] ; contentView
106ad4fd0: aa1303e0    	mov	x0, x19
106ad4fd4: 9445485a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4fd8: aa1d03fd    	mov	x29, x29
106ad4fdc: 9445485b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad4fe0: aa0003f5    	mov	x21, x0
106ad4fe4: f8786a62    	ldr	x2, [x19, x24]
106ad4fe8: d00cb148    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
106ad4fec: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
106ad4ff0: 94454853    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad4ff4: aa1503e0    	mov	x0, x21
106ad4ff8: 94454857    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad4ffc: aa1403e0    	mov	x0, x20
106ad5000: 94454855    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad5004: f8786a60    	ldr	x0, [x19, x24]
106ad5008: a9447bfd    	ldp	x29, x30, [sp, #0x40]
106ad500c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
106ad5010: a94257f6    	ldp	x22, x21, [sp, #0x20]
106ad5014: a9415ff8    	ldp	x24, x23, [sp, #0x10]
106ad5018: 6cc523e9    	ldp	d9, d8, [sp], #0x50
106ad501c: 1445484c    	b	0x107c2714c <_Flutter_MMFoundation_BindContext+0x4102d30>
