
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10517dbe0: d10183ff    	sub	sp, sp, #0x60
10517dbe4: a90167fa    	stp	x26, x25, [sp, #0x10]
10517dbe8: a9025ff8    	stp	x24, x23, [sp, #0x20]
10517dbec: a90357f6    	stp	x22, x21, [sp, #0x30]
10517dbf0: a9044ff4    	stp	x20, x19, [sp, #0x40]
10517dbf4: a9057bfd    	stp	x29, x30, [sp, #0x50]
10517dbf8: 910143fd    	add	x29, sp, #0x50
10517dbfc: aa0003f3    	mov	x19, x0
10517dc00: b9403008    	ldr	w8, [x0, #0x30]
10517dc04: d00d7fb9    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
10517dc08: 900d7fda    	adrp	x26, 0x120175000 <dyld_stub_binder+0x120175000>
10517dc0c: 311f591f    	cmn	w8, #0x7d6
10517dc10: 540006e1    	b.ne	0x10517dcec <_Flutter_MMFoundation_BindContext+0x16598d0>
10517dc14: d00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517dc18: f9453514    	ldr	x20, [x8, #0xa68]
10517dc1c: d00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517dc20: f9467900    	ldr	x0, [x8, #0xcf0]
10517dc24: f9401262    	ldr	x2, [x19, #0x20]
10517dc28: 900d6608    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10517dc2c: f945d101    	ldr	x1, [x8, #0xba0]
10517dc30: 94aaa543    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dc34: aa1d03fd    	mov	x29, x29
10517dc38: 94aaa544    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517dc3c: aa0003f5    	mov	x21, x0
10517dc40: 900d65e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10517dc44: f942a901    	ldr	x1, [x8, #0x550]
10517dc48: d00cb2c8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
10517dc4c: 912da108    	add	x8, x8, #0xb68
10517dc50: a90003e8    	stp	x8, x0, [sp]
10517dc54: f00b0f03    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
10517dc58: 91270063    	add	x3, x3, #0x9c0
10517dc5c: b00b3705    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10517dc60: 911d1ca5    	add	x5, x5, #0x747
10517dc64: b00b3707    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10517dc68: 9120c0e7    	add	x7, x7, #0x830
10517dc6c: aa1403e0    	mov	x0, x20
10517dc70: 52800062    	mov	w2, #0x3                ; =3
10517dc74: 52800004    	mov	w4, #0x0                ; =0
10517dc78: 52801486    	mov	w6, #0xa4               ; =164
10517dc7c: 94aaa530    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dc80: aa1503e0    	mov	x0, x21
10517dc84: 94aaa534    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517dc88: f945eb20    	ldr	x0, [x25, #0xbd0]
10517dc8c: f00d7c08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10517dc90: f944e914    	ldr	x20, [x8, #0x9d0]
10517dc94: aa1403e1    	mov	x1, x20
10517dc98: 94aaa529    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dc9c: aa1d03fd    	mov	x29, x29
10517dca0: 94aaa52a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517dca4: aa0003f6    	mov	x22, x0
10517dca8: f9414f40    	ldr	x0, [x26, #0x298]
10517dcac: d00d7c08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10517dcb0: f947ad15    	ldr	x21, [x8, #0xf58]
10517dcb4: aa1503e1    	mov	x1, x21
10517dcb8: 94aaa521    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dcbc: aa0003e2    	mov	x2, x0
10517dcc0: 900d65e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10517dcc4: f9464117    	ldr	x23, [x8, #0xc80]
10517dcc8: aa1603e0    	mov	x0, x22
10517dccc: aa1703e1    	mov	x1, x23
10517dcd0: 94aaa51b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dcd4: aa1d03fd    	mov	x29, x29
10517dcd8: 94aaa51c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517dcdc: aa0003f8    	mov	x24, x0
10517dce0: f00d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517dce4: 91112108    	add	x8, x8, #0x448
10517dce8: 14000019    	b	0x10517dd4c <_Flutter_MMFoundation_BindContext+0x1659930>
10517dcec: f945eb20    	ldr	x0, [x25, #0xbd0]
10517dcf0: f00d7c08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10517dcf4: f944e914    	ldr	x20, [x8, #0x9d0]
10517dcf8: aa1403e1    	mov	x1, x20
10517dcfc: 94aaa510    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dd00: aa1d03fd    	mov	x29, x29
10517dd04: 94aaa511    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517dd08: aa0003f6    	mov	x22, x0
10517dd0c: f9414f40    	ldr	x0, [x26, #0x298]
10517dd10: d00d7c08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10517dd14: f947ad15    	ldr	x21, [x8, #0xf58]
10517dd18: aa1503e1    	mov	x1, x21
10517dd1c: 94aaa508    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dd20: aa0003e2    	mov	x2, x0
10517dd24: 900d65e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10517dd28: f9464117    	ldr	x23, [x8, #0xc80]
10517dd2c: aa1603e0    	mov	x0, x22
10517dd30: aa1703e1    	mov	x1, x23
10517dd34: 94aaa502    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dd38: aa1d03fd    	mov	x29, x29
10517dd3c: 94aaa503    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517dd40: aa0003f8    	mov	x24, x0
10517dd44: 900d70e8    	adrp	x8, 0x11ff99000 <dyld_stub_binder+0x11ff99000>
10517dd48: 91272108    	add	x8, x8, #0x9c8
10517dd4c: f9401262    	ldr	x2, [x19, #0x20]
10517dd50: f9400101    	ldr	x1, [x8]
10517dd54: aa1803e0    	mov	x0, x24
10517dd58: 94aaa4f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dd5c: aa1803e0    	mov	x0, x24
10517dd60: 94aaa4fd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517dd64: aa1603e0    	mov	x0, x22
10517dd68: 94aaa4fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517dd6c: f945eb20    	ldr	x0, [x25, #0xbd0]
10517dd70: aa1403e1    	mov	x1, x20
10517dd74: 94aaa4f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dd78: aa1d03fd    	mov	x29, x29
10517dd7c: 94aaa4f3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517dd80: aa0003f6    	mov	x22, x0
10517dd84: f9414f40    	ldr	x0, [x26, #0x298]
10517dd88: aa1503e1    	mov	x1, x21
10517dd8c: 94aaa4ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dd90: aa0003e2    	mov	x2, x0
10517dd94: aa1603e0    	mov	x0, x22
10517dd98: aa1703e1    	mov	x1, x23
10517dd9c: 94aaa4e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dda0: aa1d03fd    	mov	x29, x29
10517dda4: 94aaa4e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517dda8: aa0003f5    	mov	x21, x0
10517ddac: f9401660    	ldr	x0, [x19, #0x28]
10517ddb0: 900d70e8    	adrp	x8, 0x11ff99000 <dyld_stub_binder+0x11ff99000>
10517ddb4: f944d501    	ldr	x1, [x8, #0x9a8]
10517ddb8: 94aaa4e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517ddbc: aa1d03fd    	mov	x29, x29
10517ddc0: 94aaa4e2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517ddc4: aa0003f3    	mov	x19, x0
10517ddc8: 900d6608    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10517ddcc: f941a901    	ldr	x1, [x8, #0x350]
10517ddd0: 94aaa4db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517ddd4: aa1d03fd    	mov	x29, x29
10517ddd8: 94aaa4dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517dddc: aa0003f7    	mov	x23, x0
10517dde0: 900d70e8    	adrp	x8, 0x11ff99000 <dyld_stub_binder+0x11ff99000>
10517dde4: f944d901    	ldr	x1, [x8, #0x9b0]
10517dde8: aa1503e0    	mov	x0, x21
10517ddec: aa1703e2    	mov	x2, x23
10517ddf0: 94aaa4d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517ddf4: aa1703e0    	mov	x0, x23
10517ddf8: 94aaa4d7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517ddfc: aa1303e0    	mov	x0, x19
10517de00: 94aaa4d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517de04: aa1503e0    	mov	x0, x21
10517de08: 94aaa4d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517de0c: aa1603e0    	mov	x0, x22
10517de10: 94aaa4d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517de14: f945eb20    	ldr	x0, [x25, #0xbd0]
10517de18: aa1403e1    	mov	x1, x20
10517de1c: 94aaa4c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517de20: aa1d03fd    	mov	x29, x29
10517de24: 94aaa4c9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517de28: aa0003f3    	mov	x19, x0
10517de2c: f00d7f88    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10517de30: f9462502    	ldr	x2, [x8, #0xc48]
10517de34: f00d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517de38: f9422903    	ldr	x3, [x8, #0x450]
10517de3c: b00d65e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10517de40: f940d501    	ldr	x1, [x8, #0x1a8]
10517de44: b00c2785    	adrp	x5, 0x11d66e000 <dyld_stub_binder+0x11d66e000>
10517de48: 911680a5    	add	x5, x5, #0x5a0
10517de4c: 52800004    	mov	w4, #0x0                ; =0
10517de50: 94aaa4bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517de54: aa1303e0    	mov	x0, x19
10517de58: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10517de5c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10517de60: a94357f6    	ldp	x22, x21, [sp, #0x30]
10517de64: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10517de68: a94167fa    	ldp	x26, x25, [sp, #0x10]
10517de6c: 910183ff    	add	sp, sp, #0x60
10517de70: 14aaa4b9    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
