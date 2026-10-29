
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104727bb4: d103c3ff    	sub	sp, sp, #0xf0
104727bb8: 6d0923e9    	stp	d9, d8, [sp, #0x90]
104727bbc: a90a67fa    	stp	x26, x25, [sp, #0xa0]
104727bc0: a90b5ff8    	stp	x24, x23, [sp, #0xb0]
104727bc4: a90c57f6    	stp	x22, x21, [sp, #0xc0]
104727bc8: a90d4ff4    	stp	x20, x19, [sp, #0xd0]
104727bcc: a90e7bfd    	stp	x29, x30, [sp, #0xe0]
104727bd0: 910383fd    	add	x29, sp, #0xe0
104727bd4: aa0003f3    	mov	x19, x0
104727bd8: d00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
104727bdc: 52800029    	mov	w9, #0x1                ; =1
104727be0: 391a2909    	strb	w9, [x8, #0x68a]
104727be4: f00dcf08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104727be8: f9406901    	ldr	x1, [x8, #0xd0] ; selector setUserInteractionEnabled:
104727bec: 52800002    	mov	w2, #0x0                ; =0
104727bf0: 94d3fd53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727bf4: b00dd268    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104727bf8: f9450500    	ldr	x0, [x8, #0xa08] ; class MMWebImageView
104727bfc: 94d3fd57    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104727c00: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104727c04: b98a2514    	ldrsw	x20, [x8, #0xa24]
104727c08: f8746a68    	ldr	x8, [x19, x20]
104727c0c: f8346a60    	str	x0, [x19, x20]
104727c10: aa0803e0    	mov	x0, x8
104727c14: 94d3fd50    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727c18: f8746a60    	ldr	x0, [x19, x20]
104727c1c: b00db8c8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104727c20: f9453d01    	ldr	x1, [x8, #0xa78] ; selector setIsImageStatic:
104727c24: 52800022    	mov	w2, #0x1                ; =1
104727c28: 94d3fd45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727c2c: f8746a60    	ldr	x0, [x19, x20]
104727c30: d00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104727c34: f9465101    	ldr	x1, [x8, #0xca0] ; selector sizeToFit
104727c38: 94d3fd41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727c3c: 900dcf28    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104727c40: f947a501    	ldr	x1, [x8, #0xf48] ; selector width
104727c44: aa1303e0    	mov	x0, x19
104727c48: 94d3fd3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727c4c: 1e6c1001    	fmov	d1, #0.50000000
104727c50: 1e610800    	fmul	d0, d0, d1
104727c54: f8746a60    	ldr	x0, [x19, x20]
104727c58: b00db8a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104727c5c: f942dd01    	ldr	x1, [x8, #0x5b8] ; selector setCenterX:
104727c60: 94d3fd37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727c64: f8746a60    	ldr	x0, [x19, x20]
104727c68: 900dcf08    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104727c6c: f9406501    	ldr	x1, [x8, #0xc8] ; selector setAutoresizingMask:
104727c70: 52800022    	mov	w2, #0x1                ; =1
104727c74: 94d3fd32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727c78: f8746a60    	ldr	x0, [x19, x20]
104727c7c: b00db8a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104727c80: f9403d01    	ldr	x1, [x8, #0x78] ; selector setTop:
104727c84: 1e641000    	fmov	d0, #8.00000000
104727c88: 94d3fd2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727c8c: f8746a62    	ldr	x2, [x19, x20]
104727c90: f00dcea8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104727c94: f9476d14    	ldr	x20, [x8, #0xed8] ; selector addSubview:
104727c98: aa1303e0    	mov	x0, x19
104727c9c: aa1403e1    	mov	x1, x20
104727ca0: 94d3fd27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727ca4: b00dd268    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104727ca8: f9435d00    	ldr	x0, [x8, #0x6b8] ; class UILabel
104727cac: 94d3fd2b    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104727cb0: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104727cb4: b98a0d17    	ldrsw	x23, [x8, #0xa0c]
104727cb8: f8776a68    	ldr	x8, [x19, x23]
104727cbc: f8376a60    	str	x0, [x19, x23]
104727cc0: aa0803e0    	mov	x0, x8
104727cc4: 94d3fd24    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727cc8: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104727ccc: b98a0918    	ldrsw	x24, [x8, #0xa08]
104727cd0: f8786a60    	ldr	x0, [x19, x24]
104727cd4: f00dc208    	adrp	x8, 0x11ff6a000 <dyld_stub_binder+0x11ff6a000>
104727cd8: f947dd01    	ldr	x1, [x8, #0xfb8] ; selector normalTitle
104727cdc: 94d3fd18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727ce0: aa1d03fd    	mov	x29, x29
104727ce4: 94d3fd19    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727ce8: aa0003f5    	mov	x21, x0
104727cec: f8776a60    	ldr	x0, [x19, x23]
104727cf0: d00dcf08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104727cf4: f9468d01    	ldr	x1, [x8, #0xd18] ; selector setText:
104727cf8: aa1503e2    	mov	x2, x21
104727cfc: 94d3fd10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727d00: aa1503e0    	mov	x0, x21
104727d04: 94d3fd14    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727d08: 900dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104727d0c: f9461900    	ldr	x0, [x8, #0xc30] ; class UIFont
104727d10: d00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104727d14: f9464d01    	ldr	x1, [x8, #0xc98] ; selector dynamicSystemFontOfSize:
104727d18: 1e649000    	fmov	d0, #10.00000000
104727d1c: 94d3fd08    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727d20: aa1d03fd    	mov	x29, x29
104727d24: 94d3fd09    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727d28: aa0003f5    	mov	x21, x0
104727d2c: f8776a60    	ldr	x0, [x19, x23]
104727d30: b00dcf08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104727d34: f9400501    	ldr	x1, [x8, #0x8] ; selector setFont:
104727d38: aa1503e2    	mov	x2, x21
104727d3c: 94d3fd00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727d40: aa1503e0    	mov	x0, x21
104727d44: 94d3fd04    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727d48: f8786a60    	ldr	x0, [x19, x24]
104727d4c: f00dc208    	adrp	x8, 0x11ff6a000 <dyld_stub_binder+0x11ff6a000>
104727d50: f947ed16    	ldr	x22, [x8, #0xfd8] ; selector normalTitleColor
104727d54: aa1603e1    	mov	x1, x22
104727d58: 94d3fcf9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727d5c: aa1d03fd    	mov	x29, x29
104727d60: 94d3fcfa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727d64: aa0003f5    	mov	x21, x0
104727d68: b4000080    	cbz	x0, 0x104727d78 <_Flutter_MMFoundation_BindContext+0xc0395c>
104727d6c: f8786a60    	ldr	x0, [x19, x24]
104727d70: aa1603e1    	mov	x1, x22
104727d74: 14000005    	b	0x104727d88 <_Flutter_MMFoundation_BindContext+0xc0396c>
104727d78: 900dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104727d7c: f9462d00    	ldr	x0, [x8, #0xc58] ; class WCColor
104727d80: 900dcee8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104727d84: f9462901    	ldr	x1, [x8, #0xc50] ; selector labelColor
104727d88: 94d3fced    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727d8c: aa1d03fd    	mov	x29, x29
104727d90: 94d3fcee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727d94: aa0003f6    	mov	x22, x0
104727d98: f8776a60    	ldr	x0, [x19, x23]
104727d9c: d00dcf08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104727da0: f9469501    	ldr	x1, [x8, #0xd28] ; selector setTextColor:
104727da4: aa1603e2    	mov	x2, x22
104727da8: 94d3fce5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727dac: aa1603e0    	mov	x0, x22
104727db0: 94d3fce9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727db4: aa1503e0    	mov	x0, x21
104727db8: 94d3fce7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727dbc: f8776a60    	ldr	x0, [x19, x23]
104727dc0: d00dcf08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104727dc4: f9469101    	ldr	x1, [x8, #0xd20] ; selector setTextAlignment:
104727dc8: 52800022    	mov	w2, #0x1                ; =1
104727dcc: 94d3fcdc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727dd0: f8776a62    	ldr	x2, [x19, x23]
104727dd4: aa1303e0    	mov	x0, x19
104727dd8: aa1403e1    	mov	x1, x20
104727ddc: 94d3fcd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727de0: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104727de4: b98a1119    	ldrsw	x25, [x8, #0xa10]
104727de8: f8796a62    	ldr	x2, [x19, x25]
104727dec: b5001b62    	cbnz	x2, 0x104728158 <_Flutter_MMFoundation_BindContext+0xc03d3c>
104727df0: f00dd288    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
104727df4: f9408500    	ldr	x0, [x8, #0x108] ; class MMBadgeView
104727df8: f00dbaa8    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
104727dfc: f9456d01    	ldr	x1, [x8, #0xad8] ; selector smallRedDot
104727e00: 94d3fccf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727e04: aa1d03fd    	mov	x29, x29
104727e08: 94d3fcd0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727e0c: f8796a68    	ldr	x8, [x19, x25]
104727e10: f8396a60    	str	x0, [x19, x25]
104727e14: aa0803e0    	mov	x0, x8
104727e18: 94d3fccf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727e1c: f8796a60    	ldr	x0, [x19, x25]
104727e20: b00dcf08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104727e24: f9411101    	ldr	x1, [x8, #0x220] ; selector setHidden:
104727e28: 52800022    	mov	w2, #0x1                ; =1
104727e2c: 94d3fcc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727e30: f8796a60    	ldr	x0, [x19, x25]
104727e34: f00dcee8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104727e38: f946b501    	ldr	x1, [x8, #0xd68] ; selector setAccessibilityElementsHidden:
104727e3c: 52800022    	mov	w2, #0x1                ; =1
104727e40: 94d3fcbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727e44: 900dd27a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
104727e48: f9454756    	ldr	x22, [x26, #0xa88] ; class NSString
104727e4c: f8786a60    	ldr	x0, [x19, x24]
104727e50: d00dbc88    	adrp	x8, 0x11feb9000 <dyld_stub_binder+0x11feb9000>
104727e54: f947a515    	ldr	x21, [x8, #0xf48] ; selector tabIndex
104727e58: aa1503e1    	mov	x1, x21
104727e5c: 94d3fcb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727e60: f00dcf08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104727e64: f946a517    	ldr	x23, [x8, #0xd48] ; selector stringWithFormat:
104727e68: f90003e0    	str	x0, [sp]
104727e6c: 900d0222    	adrp	x2, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104727e70: 91132042    	add	x2, x2, #0x4c8 ; CFString 'tab_red_dot_%ld'
104727e74: aa1603e0    	mov	x0, x22
104727e78: aa1703e1    	mov	x1, x23
104727e7c: 94d3fcb0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727e80: aa1d03fd    	mov	x29, x29
104727e84: 94d3fcb1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727e88: aa0003f6    	mov	x22, x0
104727e8c: f8796a60    	ldr	x0, [x19, x25]
104727e90: b00db8a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104727e94: f9413d01    	ldr	x1, [x8, #0x278] ; selector setDr_viewId:
104727e98: aa1603e2    	mov	x2, x22
104727e9c: 94d3fca8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727ea0: aa1603e0    	mov	x0, x22
104727ea4: 94d3fcac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727ea8: f9454756    	ldr	x22, [x26, #0xa88] ; class NSString
104727eac: f00e2b08    	adrp	x8, 0x120c8a000 <dyld_stub_binder+0x120c8a000>
104727eb0: f944a91a    	ldr	x26, [x8, #0x950]
104727eb4: f8786a60    	ldr	x0, [x19, x24]
104727eb8: aa1503e1    	mov	x1, x21
104727ebc: 94d3fca0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727ec0: a90003fa    	stp	x26, x0, [sp]
104727ec4: 900d0222    	adrp	x2, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104727ec8: 9113a042    	add	x2, x2, #0x4e8 ; CFString '%@_tab_red_dot_%ld'
104727ecc: aa1603e0    	mov	x0, x22
104727ed0: aa1703e1    	mov	x1, x23
104727ed4: 94d3fc9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727ed8: aa1d03fd    	mov	x29, x29
104727edc: 94d3fc9b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727ee0: aa0003f6    	mov	x22, x0
104727ee4: f8796a60    	ldr	x0, [x19, x25]
104727ee8: 900dbb48    	adrp	x8, 0x11fe8f000 <dyld_stub_binder+0x11fe8f000>
104727eec: f9477d01    	ldr	x1, [x8, #0xef8] ; selector setDr_viewUniqueId:
104727ef0: aa1603e2    	mov	x2, x22
104727ef4: 94d3fc92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727ef8: aa1603e0    	mov	x0, x22
104727efc: 94d3fc96    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727f00: f8796a60    	ldr	x0, [x19, x25]
104727f04: d00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104727f08: f9468101    	ldr	x1, [x8, #0xd00] ; selector dr_link4TabPage
104727f0c: 94d3fc8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727f10: aa1d03fd    	mov	x29, x29
104727f14: 94d3fc8d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727f18: aa0003f6    	mov	x22, x0
104727f1c: f9400808    	ldr	x8, [x0, #0x10]
104727f20: d63f0100    	blr	x8
104727f24: aa1d03fd    	mov	x29, x29
104727f28: 94d3fc8f    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
104727f2c: aa1603e0    	mov	x0, x22
104727f30: 94d3fc89    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727f34: f8796a60    	ldr	x0, [x19, x25]
104727f38: 900db9e8    	adrp	x8, 0x11fe63000 <dyld_stub_binder+0x11fe63000>
104727f3c: f940dd01    	ldr	x1, [x8, #0x1b8] ; selector dr_setViewParam
104727f40: 94d3fc7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727f44: aa1d03fd    	mov	x29, x29
104727f48: 94d3fc80    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727f4c: aa0003f6    	mov	x22, x0
104727f50: 900dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104727f54: f9458917    	ldr	x23, [x8, #0xb10] ; class NSNumber
104727f58: f8796a60    	ldr	x0, [x19, x25]
104727f5c: b00dc008    	adrp	x8, 0x11ff28000 <dyld_stub_binder+0x11ff28000>
104727f60: f9417101    	ldr	x1, [x8, #0x2e0] ; selector shape
104727f64: 94d3fc76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727f68: aa0003e2    	mov	x2, x0
104727f6c: b00dcee8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104727f70: f947c101    	ldr	x1, [x8, #0xf80] ; selector numberWithUnsignedInteger:
104727f74: aa1703e0    	mov	x0, x23
104727f78: 94d3fc71    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727f7c: aa1d03fd    	mov	x29, x29
104727f80: 94d3fc72    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727f84: aa0003f7    	mov	x23, x0
104727f88: f9400ac8    	ldr	x8, [x22, #0x10]
104727f8c: 900d0221    	adrp	x1, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104727f90: 91142021    	add	x1, x1, #0x508 ; CFString 'red_dot_shape'
104727f94: aa1603e0    	mov	x0, x22
104727f98: aa1703e2    	mov	x2, x23
104727f9c: d63f0100    	blr	x8
104727fa0: aa1d03fd    	mov	x29, x29
104727fa4: 94d3fc70    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
104727fa8: aa1703e0    	mov	x0, x23
104727fac: 94d3fc6a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727fb0: aa1603e0    	mov	x0, x22
104727fb4: 94d3fc68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727fb8: d10163a0    	sub	x0, x29, #0x58
104727fbc: aa1303e1    	mov	x1, x19
104727fc0: 94d3fc6b    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
104727fc4: f8796a61    	ldr	x1, [x19, x25]
104727fc8: d10183a0    	sub	x0, x29, #0x60
104727fcc: 94d3fc68    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
104727fd0: f8786a61    	ldr	x1, [x19, x24]
104727fd4: d101a3a0    	sub	x0, x29, #0x68
104727fd8: 94d3fc65    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
104727fdc: f8796a60    	ldr	x0, [x19, x25]
104727fe0: d00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104727fe4: f9468501    	ldr	x1, [x8, #0xd08] ; selector amb_addReportBreakerBlock
104727fe8: 94d3fc55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727fec: aa1d03fd    	mov	x29, x29
104727ff0: 94d3fc56    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727ff4: aa0003f6    	mov	x22, x0
104727ff8: f00c763a    	adrp	x26, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
104727ffc: f947e35a    	ldr	x26, [x26, #0xfc0]
104728000: f90027fa    	str	x26, [sp, #0x48]
104728004: b00a32c8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
104728008: fd41c108    	ldr	d8, [x8, #0x380]
10472800c: 90000008    	adrp	x8, 0x104728000 <_Flutter_MMFoundation_BindContext+0xc03be4>
104728010: 91065108    	add	x8, x8, #0x194
104728014: fd002be8    	str	d8, [sp, #0x50]
104728018: f00c79a9    	adrp	x9, 0x11d65f000 <dyld_stub_binder+0x11d65f000>
10472801c: 9126e129    	add	x9, x9, #0x9b8
104728020: a905a7e8    	stp	x8, x9, [sp, #0x58]
104728024: 910123f7    	add	x23, sp, #0x48
104728028: 910082e0    	add	x0, x23, #0x20
10472802c: d10163a1    	sub	x1, x29, #0x58
104728030: 94d3fc52    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
104728034: 9100a2e0    	add	x0, x23, #0x28
104728038: d10183a1    	sub	x1, x29, #0x60
10472803c: 94d3fc4f    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
104728040: f9400ac8    	ldr	x8, [x22, #0x10]
104728044: f00d0202    	adrp	x2, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104728048: 9114a042    	add	x2, x2, #0x528 ; CFString 'MMTabBarItemView'
10472804c: 910123e1    	add	x1, sp, #0x48
104728050: aa1603e0    	mov	x0, x22
104728054: d63f0100    	blr	x8
104728058: aa1d03fd    	mov	x29, x29
10472805c: 94d3fc42    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
104728060: aa1603e0    	mov	x0, x22
104728064: 94d3fc3c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728068: f9000ffa    	str	x26, [sp, #0x18]
10472806c: 90000008    	adrp	x8, 0x104728000 <_Flutter_MMFoundation_BindContext+0xc03be4>
104728070: 91097108    	add	x8, x8, #0x25c
104728074: fd0013e8    	str	d8, [sp, #0x20]
104728078: f00c79a9    	adrp	x9, 0x11d65f000 <dyld_stub_binder+0x11d65f000>
10472807c: 9127a129    	add	x9, x9, #0x9e8
104728080: a902a7e8    	stp	x8, x9, [sp, #0x28]
104728084: 910063fa    	add	x26, sp, #0x18
104728088: 91008340    	add	x0, x26, #0x20
10472808c: d10183a1    	sub	x1, x29, #0x60
104728090: 94d3fc3a    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
104728094: 9100a340    	add	x0, x26, #0x28
104728098: d101a3a1    	sub	x1, x29, #0x68
10472809c: 94d3fc37    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1047280a0: f8796a60    	ldr	x0, [x19, x25]
1047280a4: b00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
1047280a8: f9468d01    	ldr	x1, [x8, #0xd18] ; selector setShapeChangeBlock:
1047280ac: 910063e2    	add	x2, sp, #0x18
1047280b0: 94d3fc23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047280b4: f8796a60    	ldr	x0, [x19, x25]
1047280b8: 900db8a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1047280bc: f9414101    	ldr	x1, [x8, #0x280] ; selector dr_setViewReportPolicy
1047280c0: 94d3fc1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047280c4: aa1d03fd    	mov	x29, x29
1047280c8: 94d3fc20    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047280cc: aa0003f6    	mov	x22, x0
1047280d0: f9400808    	ldr	x8, [x0, #0x10]
1047280d4: 52801001    	mov	w1, #0x80               ; =128
1047280d8: d2800002    	mov	x2, #0x0                ; =0
1047280dc: 52800003    	mov	w3, #0x0                ; =0
1047280e0: d63f0100    	blr	x8
1047280e4: aa1d03fd    	mov	x29, x29
1047280e8: 94d3fc1f    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
1047280ec: aa1603e0    	mov	x0, x22
1047280f0: 94d3fc19    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047280f4: f8796a76    	ldr	x22, [x19, x25]
1047280f8: f8786a60    	ldr	x0, [x19, x24]
1047280fc: aa1503e1    	mov	x1, x21
104728100: 94d3fc0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728104: aa0003e3    	mov	x3, x0
104728108: b00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10472810c: f9469101    	ldr	x1, [x8, #0xd20] ; selector bindRedDotExposeEventCallback:tabIndex:
104728110: aa1303e0    	mov	x0, x19
104728114: aa1603e2    	mov	x2, x22
104728118: 94d3fc09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472811c: 9100a340    	add	x0, x26, #0x28
104728120: 94d3fc1c    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
104728124: 91008340    	add	x0, x26, #0x20
104728128: 94d3fc1a    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
10472812c: 9100a2e0    	add	x0, x23, #0x28
104728130: 94d3fc18    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
104728134: 910082e0    	add	x0, x23, #0x20
104728138: 94d3fc16    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
10472813c: d101a3a0    	sub	x0, x29, #0x68
104728140: 94d3fc14    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
104728144: d10183a0    	sub	x0, x29, #0x60
104728148: 94d3fc12    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
10472814c: d10163a0    	sub	x0, x29, #0x58
104728150: 94d3fc10    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
104728154: f8796a62    	ldr	x2, [x19, x25]
104728158: aa1303e0    	mov	x0, x19
10472815c: aa1403e1    	mov	x1, x20
104728160: 94d3fbf7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728164: b00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104728168: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector relayoutIconAndBadge
10472816c: aa1303e0    	mov	x0, x19
104728170: 94d3fbf3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728174: a94e7bfd    	ldp	x29, x30, [sp, #0xe0]
104728178: a94d4ff4    	ldp	x20, x19, [sp, #0xd0]
10472817c: a94c57f6    	ldp	x22, x21, [sp, #0xc0]
104728180: a94b5ff8    	ldp	x24, x23, [sp, #0xb0]
104728184: a94a67fa    	ldp	x26, x25, [sp, #0xa0]
104728188: 6d4923e9    	ldp	d9, d8, [sp, #0x90]
10472818c: 9103c3ff    	add	sp, sp, #0xf0
104728190: d65f03c0    	ret
