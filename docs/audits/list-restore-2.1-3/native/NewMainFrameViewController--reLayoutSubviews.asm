
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105112d88: 6db82beb    	stp	d11, d10, [sp, #-0x80]!
105112d8c: 6d0123e9    	stp	d9, d8, [sp, #0x10]
105112d90: a9026ffc    	stp	x28, x27, [sp, #0x20]
105112d94: a90367fa    	stp	x26, x25, [sp, #0x30]
105112d98: a9045ff8    	stp	x24, x23, [sp, #0x40]
105112d9c: a90557f6    	stp	x22, x21, [sp, #0x50]
105112da0: a9064ff4    	stp	x20, x19, [sp, #0x60]
105112da4: a9077bfd    	stp	x29, x30, [sp, #0x70]
105112da8: 9101c3fd    	add	x29, sp, #0x70
105112dac: aa0003f3    	mov	x19, x0
105112db0: b00dd968    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105112db4: 52800029    	mov	w9, #0x1                ; =1
105112db8: 392d5509    	strb	w9, [x8, #0xb55]
105112dbc: b00d7fc8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
105112dc0: f946d514    	ldr	x20, [x8, #0xda8] ; view
105112dc4: aa1403e1    	mov	x1, x20
105112dc8: 94ac50dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112dcc: aa1d03fd    	mov	x29, x29
105112dd0: 94ac50de    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112dd4: aa0003f5    	mov	x21, x0
105112dd8: b00d7fc8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
105112ddc: f947a501    	ldr	x1, [x8, #0xf48] ; width
105112de0: 94ac50d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112de4: 1e604008    	fmov	d8, d0
105112de8: d00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105112dec: b983311b    	ldrsw	x27, [x8, #0x330]
105112df0: f87b6a60    	ldr	x0, [x19, x27]
105112df4: f00d7f68    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
105112df8: f945a116    	ldr	x22, [x8, #0xb40] ; frame
105112dfc: aa1603e1    	mov	x1, x22
105112e00: 94ac50cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112e04: 1e623900    	fsub	d0, d8, d2
105112e08: 1e6c1001    	fmov	d1, #0.50000000
105112e0c: 1e610808    	fmul	d8, d0, d1
105112e10: d00d8308    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105112e14: f9403d19    	ldr	x25, [x8, #0x78] ; MMThemeUtil
105112e18: b00d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105112e1c: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
105112e20: d00d7f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105112e24: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105112e28: 94ac50c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112e2c: aa1d03fd    	mov	x29, x29
105112e30: 94ac50c6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112e34: aa0003f7    	mov	x23, x0
105112e38: d00d8308    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105112e3c: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
105112e40: b00d7f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105112e44: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105112e48: 94ac50bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112e4c: aa0003e2    	mov	x2, x0
105112e50: f00d6928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105112e54: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
105112e58: aa1703e0    	mov	x0, x23
105112e5c: 94ac50b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112e60: aa1d03fd    	mov	x29, x29
105112e64: 94ac50b9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112e68: aa0003f8    	mov	x24, x0
105112e6c: b00d6948    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105112e70: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
105112e74: d00ca3a2    	adrp	x2, 0x11e588000 <dyld_stub_binder+0x11e588000>
105112e78: 912c2042    	add	x2, x2, #0xb08 ; CFString 'wechatlogo_bottom_margin'
105112e7c: d00ca3a3    	adrp	x3, 0x11e588000 <dyld_stub_binder+0x11e588000>
105112e80: 912ca063    	add	x3, x3, #0xb28 ; CFString '#mainframe_dropdown'
105112e84: 94ac50ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112e88: aa1d03fd    	mov	x29, x29
105112e8c: 94ac50af    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112e90: aa0003fa    	mov	x26, x0
105112e94: d00d6948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105112e98: f9400101    	ldr	x1, [x8]
105112e9c: aa1903e0    	mov	x0, x25
105112ea0: aa1a03e2    	mov	x2, x26
105112ea4: 94ac50a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112ea8: 1e604009    	fmov	d9, d0
105112eac: f87b6a60    	ldr	x0, [x19, x27]
105112eb0: 900d7fc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105112eb4: f9442501    	ldr	x1, [x8, #0x848] ; size
105112eb8: 94ac50a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112ebc: 1e612920    	fadd	d0, d9, d1
105112ec0: 1e614009    	fneg	d9, d0
105112ec4: f87b6a60    	ldr	x0, [x19, x27]
105112ec8: aa1603e1    	mov	x1, x22
105112ecc: 94ac509c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112ed0: 1e60404a    	fmov	d10, d2
105112ed4: f87b6a60    	ldr	x0, [x19, x27]
105112ed8: aa1603e1    	mov	x1, x22
105112edc: 94ac5098    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112ee0: f87b6a60    	ldr	x0, [x19, x27]
105112ee4: d00d7fa8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
105112ee8: f9403516    	ldr	x22, [x8, #0x68] ; setFrame:
105112eec: aa1603e1    	mov	x1, x22
105112ef0: 1e604100    	fmov	d0, d8
105112ef4: 1e604121    	fmov	d1, d9
105112ef8: 1e604142    	fmov	d2, d10
105112efc: 94ac5090    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112f00: aa1a03e0    	mov	x0, x26
105112f04: 94ac5094    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112f08: aa1803e0    	mov	x0, x24
105112f0c: 94ac5092    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112f10: aa1703e0    	mov	x0, x23
105112f14: 94ac5090    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112f18: aa1503e0    	mov	x0, x21
105112f1c: 94ac508e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112f20: aa1303e0    	mov	x0, x19
105112f24: aa1403e1    	mov	x1, x20
105112f28: 94ac5085    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112f2c: aa1d03fd    	mov	x29, x29
105112f30: 94ac5086    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112f34: aa0003f5    	mov	x21, x0
105112f38: b00d7f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105112f3c: f943d514    	ldr	x20, [x8, #0x7a8] ; bounds
105112f40: aa1403e1    	mov	x1, x20
105112f44: 94ac507e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112f48: d00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105112f4c: b9831908    	ldrsw	x8, [x8, #0x318]
105112f50: f8686a60    	ldr	x0, [x19, x8]
105112f54: aa1603e1    	mov	x1, x22
105112f58: 94ac5079    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112f5c: aa1503e0    	mov	x0, x21
105112f60: 94ac507d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112f64: d00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105112f68: b9833518    	ldrsw	x24, [x8, #0x334]
105112f6c: f8786a68    	ldr	x8, [x19, x24]
105112f70: b40003e8    	cbz	x8, 0x105112fec <_Flutter_MMFoundation_BindContext+0x15eebd0>
105112f74: d00d7f88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
105112f78: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
105112f7c: aa1303e0    	mov	x0, x19
105112f80: 94ac506f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112f84: aa1d03fd    	mov	x29, x29
105112f88: 94ac5070    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112f8c: aa0003f5    	mov	x21, x0
105112f90: d00d7f88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
105112f94: f945d901    	ldr	x1, [x8, #0xbb0] ; navigationBar
105112f98: 94ac5069    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112f9c: aa1d03fd    	mov	x29, x29
105112fa0: 94ac506a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105112fa4: aa0003f7    	mov	x23, x0
105112fa8: aa1403e1    	mov	x1, x20
105112fac: 94ac5064    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112fb0: f8786a60    	ldr	x0, [x19, x24]
105112fb4: aa1603e1    	mov	x1, x22
105112fb8: 94ac5061    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105112fbc: aa1703e0    	mov	x0, x23
105112fc0: 94ac5065    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112fc4: aa1503e0    	mov	x0, x21
105112fc8: a9477bfd    	ldp	x29, x30, [sp, #0x70]
105112fcc: a9464ff4    	ldp	x20, x19, [sp, #0x60]
105112fd0: a94557f6    	ldp	x22, x21, [sp, #0x50]
105112fd4: a9445ff8    	ldp	x24, x23, [sp, #0x40]
105112fd8: a94367fa    	ldp	x26, x25, [sp, #0x30]
105112fdc: a9426ffc    	ldp	x28, x27, [sp, #0x20]
105112fe0: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
105112fe4: 6cc82beb    	ldp	d11, d10, [sp], #0x80
105112fe8: 14ac505b    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105112fec: a9477bfd    	ldp	x29, x30, [sp, #0x70]
105112ff0: a9464ff4    	ldp	x20, x19, [sp, #0x60]
105112ff4: a94557f6    	ldp	x22, x21, [sp, #0x50]
105112ff8: a9445ff8    	ldp	x24, x23, [sp, #0x40]
105112ffc: a94367fa    	ldp	x26, x25, [sp, #0x30]
105113000: a9426ffc    	ldp	x28, x27, [sp, #0x20]
105113004: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
105113008: 6cc82beb    	ldp	d11, d10, [sp], #0x80
10511300c: d65f03c0    	ret
