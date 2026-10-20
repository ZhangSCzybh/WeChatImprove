
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106287d48: d10203ff    	sub	sp, sp, #0x80
106287d4c: a90367fa    	stp	x26, x25, [sp, #0x30]
106287d50: a9045ff8    	stp	x24, x23, [sp, #0x40]
106287d54: a90557f6    	stp	x22, x21, [sp, #0x50]
106287d58: a9064ff4    	stp	x20, x19, [sp, #0x60]
106287d5c: a9077bfd    	stp	x29, x30, [sp, #0x70]
106287d60: 9101c3fd    	add	x29, sp, #0x70
106287d64: aa0003f4    	mov	x20, x0
106287d68: 900b9b48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106287d6c: f9405908    	ldr	x8, [x8, #0xb0]
106287d70: f9400108    	ldr	x8, [x8]
106287d74: f90017e8    	str	x8, [sp, #0x28]
106287d78: 900d4de8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106287d7c: 52800029    	mov	w9, #0x1                ; =1
106287d80: 39288d09    	strb	w9, [x8, #0xa23]
106287d84: f00cf768    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
106287d88: f940d500    	ldr	x0, [x8, #0x1a8]
106287d8c: f00cf408    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106287d90: f9438501    	ldr	x1, [x8, #0x708] ; sharedMenuController
106287d94: 94667cea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287d98: aa1d03fd    	mov	x29, x29
106287d9c: 94667ceb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106287da0: aa0003f3    	mov	x19, x0
106287da4: f00cde28    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
106287da8: f9403901    	ldr	x1, [x8, #0x70] ; isMenuVisible
106287dac: 94667ce4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287db0: 34000240    	cbz	w0, 0x106287df8 <_Flutter_MMFoundation_BindContext+0x27639dc>
106287db4: 900cf768    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106287db8: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
106287dbc: d00cdd88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106287dc0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
106287dc4: f00c2f88    	adrp	x8, 0x11e87a000 <dyld_stub_binder+0x11e87a000>
106287dc8: 912f2108    	add	x8, x8, #0xbc8
106287dcc: f90003e8    	str	x8, [sp]
106287dd0: f00ab8c5    	adrp	x5, 0x11b9a2000 <dyld_stub_binder+0x11b9a2000>
106287dd4: 9107f8a5    	add	x5, x5, #0x1fe
106287dd8: f00ab8c7    	adrp	x7, 0x11b9a2000 <dyld_stub_binder+0x11b9a2000>
106287ddc: 912fa0e7    	add	x7, x7, #0xbe8
106287de0: 52800042    	mov	w2, #0x2                ; =2
106287de4: d2800003    	mov	x3, #0x0                ; =0
106287de8: 52800004    	mov	w4, #0x0                ; =0
106287dec: 52810226    	mov	w6, #0x811              ; =2065
106287df0: 94667cd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287df4: 1400007e    	b	0x106287fec <_Flutter_MMFoundation_BindContext+0x2763bd0>
106287df8: f00cdda8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
106287dfc: f9410916    	ldr	x22, [x8, #0x210] ; viewModel
106287e00: aa1403e0    	mov	x0, x20
106287e04: aa1603e1    	mov	x1, x22
106287e08: 94667ccd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287e0c: aa1d03fd    	mov	x29, x29
106287e10: 94667cce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106287e14: aa0003f5    	mov	x21, x0
106287e18: 94667ccf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106287e1c: b40007f5    	cbz	x21, 0x106287f18 <_Flutter_MMFoundation_BindContext+0x2763afc>
106287e20: aa1403e0    	mov	x0, x20
106287e24: aa1603e1    	mov	x1, x22
106287e28: 94667cc5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287e2c: aa1d03fd    	mov	x29, x29
106287e30: 94667cc6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106287e34: aa0003f8    	mov	x24, x0
106287e38: d00ce028    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
106287e3c: f944a117    	ldr	x23, [x8, #0x940] ; voiceTranslateInfo
106287e40: aa1703e1    	mov	x1, x23
106287e44: 94667cbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287e48: aa1d03fd    	mov	x29, x29
106287e4c: 94667cbf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106287e50: aa0003f9    	mov	x25, x0
106287e54: b00cdde8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
106287e58: f942b101    	ldr	x1, [x8, #0x560] ; translatedText
106287e5c: 94667cb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287e60: aa1d03fd    	mov	x29, x29
106287e64: 94667cb9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106287e68: aa0003f5    	mov	x21, x0
106287e6c: aa1903e0    	mov	x0, x25
106287e70: 94667cb9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106287e74: aa1803e0    	mov	x0, x24
106287e78: 94667cb7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106287e7c: 900cf3e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106287e80: f946e901    	ldr	x1, [x8, #0xdd0] ; length
106287e84: aa1503e0    	mov	x0, x21
106287e88: 94667cad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287e8c: b4000500    	cbz	x0, 0x106287f2c <_Flutter_MMFoundation_BindContext+0x2763b10>
106287e90: 900cea68    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106287e94: f9478d01    	ldr	x1, [x8, #0xf18] ; stopTextAnimation
106287e98: aa1403e0    	mov	x0, x20
106287e9c: 94667ca8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287ea0: aa1403e0    	mov	x0, x20
106287ea4: aa1603e1    	mov	x1, x22
106287ea8: 94667ca5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287eac: aa1d03fd    	mov	x29, x29
106287eb0: 94667ca6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106287eb4: aa0003f6    	mov	x22, x0
106287eb8: aa1703e1    	mov	x1, x23
106287ebc: 94667ca0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287ec0: aa1d03fd    	mov	x29, x29
106287ec4: 94667ca1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106287ec8: aa0003f7    	mov	x23, x0
106287ecc: 900cdf08    	adrp	x8, 0x11fe67000 <dyld_stub_binder+0x11fe67000>
106287ed0: f9461501    	ldr	x1, [x8, #0xc28] ; setDisplayText:
106287ed4: aa1503e2    	mov	x2, x21
106287ed8: 94667c99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287edc: aa1703e0    	mov	x0, x23
106287ee0: 94667c9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106287ee4: aa1603e0    	mov	x0, x22
106287ee8: 94667c9b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106287eec: 900cea68    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106287ef0: f9479501    	ldr	x1, [x8, #0xf28] ; animateSetTranslateText:
106287ef4: aa1403e0    	mov	x0, x20
106287ef8: aa1503e2    	mov	x2, x21
106287efc: 94667c90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287f00: f00ce9a8    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
106287f04: f9401901    	ldr	x1, [x8, #0x30] ; setShouldAutoScrollUp:
106287f08: aa1403e0    	mov	x0, x20
106287f0c: 52800002    	mov	w2, #0x0                ; =0
106287f10: 94667c8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287f14: 14000034    	b	0x106287fe4 <_Flutter_MMFoundation_BindContext+0x2763bc8>
106287f18: 900cea68    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106287f1c: f9478d01    	ldr	x1, [x8, #0xf18] ; stopTextAnimation
106287f20: aa1403e0    	mov	x0, x20
106287f24: 94667c86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287f28: 14000031    	b	0x106287fec <_Flutter_MMFoundation_BindContext+0x2763bd0>
106287f2c: f00c2288    	adrp	x8, 0x11e6da000 <dyld_stub_binder+0x11e6da000>
106287f30: 913ca108    	add	x8, x8, #0xf28
106287f34: f00c2f89    	adrp	x9, 0x11e87a000 <dyld_stub_binder+0x11e87a000>
106287f38: 912fa129    	add	x9, x9, #0xbe8
106287f3c: a900a7e8    	stp	x8, x9, [sp, #0x8]
106287f40: f00c2f88    	adrp	x8, 0x11e87a000 <dyld_stub_binder+0x11e87a000>
106287f44: 91302108    	add	x8, x8, #0xc08
106287f48: 900c2a29    	adrp	x9, 0x11e7cb000 <dyld_stub_binder+0x11e7cb000>
106287f4c: 9126a129    	add	x9, x9, #0x9a8
106287f50: a901a7e8    	stp	x8, x9, [sp, #0x18]
106287f54: 900cf768    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106287f58: f9456d00    	ldr	x0, [x8, #0xad8]
106287f5c: 900cf3c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106287f60: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
106287f64: 910023e2    	add	x2, sp, #0x8
106287f68: 52800083    	mov	w3, #0x4                ; =4
106287f6c: 94667c74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287f70: aa1d03fd    	mov	x29, x29
106287f74: 94667c75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106287f78: aa0003f6    	mov	x22, x0
106287f7c: f00d5037    	adrp	x23, 0x120c8e000 <dyld_stub_binder+0x120c8e000>
106287f80: b98e72e8    	ldrsw	x8, [x23, #0xe70]
106287f84: 91000518    	add	x24, x8, #0x1
106287f88: b00cf3c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106287f8c: f9435101    	ldr	x1, [x8, #0x6a0] ; count
106287f90: 94667c6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287f94: 9ac00b08    	udiv	x8, x24, x0
106287f98: 9b00e108    	msub	x8, x8, x0, x24
106287f9c: b90e72e8    	str	w8, [x23, #0xe70]
106287fa0: 93407d02    	sxtw	x2, w8
106287fa4: b00cf3e8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106287fa8: f947e101    	ldr	x1, [x8, #0xfc0] ; objectAtIndexedSubscript:
106287fac: aa1603e0    	mov	x0, x22
106287fb0: 94667c63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287fb4: aa1d03fd    	mov	x29, x29
106287fb8: 94667c64    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106287fbc: aa0003f7    	mov	x23, x0
106287fc0: 900cea68    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106287fc4: f9479101    	ldr	x1, [x8, #0xf20] ; setTranslatingText:
106287fc8: aa1403e0    	mov	x0, x20
106287fcc: aa1703e2    	mov	x2, x23
106287fd0: 94667c5b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106287fd4: aa1703e0    	mov	x0, x23
106287fd8: 94667c5f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106287fdc: aa1603e0    	mov	x0, x22
106287fe0: 94667c5d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106287fe4: aa1503e0    	mov	x0, x21
106287fe8: 94667c5b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106287fec: aa1303e0    	mov	x0, x19
106287ff0: 94667c59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106287ff4: f94017e8    	ldr	x8, [sp, #0x28]
106287ff8: 900b9b49    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106287ffc: f9405929    	ldr	x9, [x9, #0xb0]
106288000: f9400129    	ldr	x9, [x9]
106288004: eb08013f    	cmp	x9, x8
106288008: 54000101    	b.ne	0x106288028 <_Flutter_MMFoundation_BindContext+0x2763c0c>
10628800c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
106288010: a9464ff4    	ldp	x20, x19, [sp, #0x60]
106288014: a94557f6    	ldp	x22, x21, [sp, #0x50]
106288018: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10628801c: a94367fa    	ldp	x26, x25, [sp, #0x30]
106288020: 910203ff    	add	sp, sp, #0x80
106288024: d65f03c0    	ret
106288028: 94667c53    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>