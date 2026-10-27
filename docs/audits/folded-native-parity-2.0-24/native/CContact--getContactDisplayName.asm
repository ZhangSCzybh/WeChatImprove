
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f88f20: d10103ff    	sub	sp, sp, #0x40
100f88f24: a90157f6    	stp	x22, x21, [sp, #0x10]
100f88f28: a9024ff4    	stp	x20, x19, [sp, #0x20]
100f88f2c: a9037bfd    	stp	x29, x30, [sp, #0x30]
100f88f30: 9100c3fd    	add	x29, sp, #0x30
100f88f34: aa0003f4    	mov	x20, x0
100f88f38: 900fe548    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f88f3c: 52800029    	mov	w9, #0x1                ; =1
100f88f40: 392b8509    	strb	w9, [x8, #0xae1]
100f88f44: b9000fff    	str	wzr, [sp, #0xc]
100f88f48: d00f75c8    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
100f88f4c: f947b901    	ldr	x1, [x8, #0xf70] ; getContactDisplayName:
100f88f50: 910033e2    	add	x2, sp, #0xc
100f88f54: 95b2787a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f88f58: aa1d03fd    	mov	x29, x29
100f88f5c: 95b2787b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f88f60: aa0003f3    	mov	x19, x0
100f88f64: b9400fe8    	ldr	w8, [sp, #0xc]
100f88f68: 34000688    	cbz	w8, 0x100f89038 <__text+0xf81038>
100f88f6c: f00f7588    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f88f70: f947b501    	ldr	x1, [x8, #0xf68] ; isBrandContact
100f88f74: aa1403e0    	mov	x0, x20
100f88f78: 95b27871    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f88f7c: 370005e0    	tbnz	w0, #0x0, 0x100f89038 <__text+0xf81038>
100f88f80: 900f7768    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
100f88f84: f941e501    	ldr	x1, [x8, #0x3c8] ; isWeAppContact
100f88f88: aa1403e0    	mov	x0, x20
100f88f8c: 95b2786c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f88f90: 37000540    	tbnz	w0, #0x0, 0x100f89038 <__text+0xf81038>
100f88f94: f00f7588    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f88f98: f947bd01    	ldr	x1, [x8, #0xf78] ; m_isPlugin
100f88f9c: aa1403e0    	mov	x0, x20
100f88fa0: 95b27867    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f88fa4: 370004a0    	tbnz	w0, #0x0, 0x100f89038 <__text+0xf81038>
100f88fa8: f00f8f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f88fac: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
100f88fb0: 900f8bc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f88fb4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100f88fb8: 95b27861    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f88fbc: aa1d03fd    	mov	x29, x29
100f88fc0: 95b27862    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f88fc4: aa0003f4    	mov	x20, x0
100f88fc8: f00f8f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f88fcc: f9462900    	ldr	x0, [x8, #0xc50] ; MMLanguageMgr
100f88fd0: f00f8ba8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f88fd4: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f88fd8: 95b27859    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f88fdc: aa0003e2    	mov	x2, x0
100f88fe0: b00f7588    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f88fe4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100f88fe8: aa1403e0    	mov	x0, x20
100f88fec: 95b27854    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f88ff0: aa1d03fd    	mov	x29, x29
100f88ff4: 95b27855    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f88ff8: aa0003f5    	mov	x21, x0
100f88ffc: b00f7588    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f89000: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
100f89004: b00eaa82    	adrp	x2, 0x11e4da000 <dyld_stub_binder+0x11e4da000>
100f89008: 91102042    	add	x2, x2, #0x408 ; CFString 'Contacts_Protected_WordingForNickname'
100f8900c: 95b2784c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f89010: aa1d03fd    	mov	x29, x29
100f89014: 95b2784d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f89018: aa0003f6    	mov	x22, x0
100f8901c: aa1303e0    	mov	x0, x19
100f89020: 95b2784d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f89024: aa1503e0    	mov	x0, x21
100f89028: 95b2784b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f8902c: aa1403e0    	mov	x0, x20
100f89030: 95b27849    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f89034: aa1603f3    	mov	x19, x22
100f89038: aa1303e0    	mov	x0, x19
100f8903c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100f89040: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100f89044: a94157f6    	ldp	x22, x21, [sp, #0x10]
100f89048: 910103ff    	add	sp, sp, #0x40
100f8904c: 15b27849    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
