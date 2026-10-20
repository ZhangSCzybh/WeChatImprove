
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f5b698: d10383ff    	sub	sp, sp, #0xe0
100f5b69c: 6d0723e9    	stp	d9, d8, [sp, #0x70]
100f5b6a0: a9086ffc    	stp	x28, x27, [sp, #0x80]
100f5b6a4: a90967fa    	stp	x26, x25, [sp, #0x90]
100f5b6a8: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
100f5b6ac: a90b57f6    	stp	x22, x21, [sp, #0xb0]
100f5b6b0: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
100f5b6b4: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
100f5b6b8: 910343fd    	add	x29, sp, #0xd0
100f5b6bc: aa0003f3    	mov	x19, x0
100f5b6c0: b00fe6a8    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f5b6c4: 52800029    	mov	w9, #0x1                ; =1
100f5b6c8: 3928a109    	strb	w9, [x8, #0xa28]
100f5b6cc: d00f9468    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f5b6d0: b9849517    	ldrsw	x23, [x8, #0x494]
100f5b6d4: f8776808    	ldr	x8, [x0, x23]
100f5b6d8: b50001a8    	cbnz	x8, 0x100f5b70c <__text+0xf5370c>
100f5b6dc: b00f90c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f5b6e0: f9450900    	ldr	x0, [x8, #0xa10]
100f5b6e4: 95b32e9d    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
100f5b6e8: f8776a68    	ldr	x8, [x19, x23]
100f5b6ec: f8376a60    	str	x0, [x19, x23]
100f5b6f0: aa0803e0    	mov	x0, x8
100f5b6f4: 95b32e98    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f5b6f8: f8776a60    	ldr	x0, [x19, x23]
100f5b6fc: f00f8d68    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100f5b700: f9406901    	ldr	x1, [x8, #0xd0] ; setUserInteractionEnabled:
100f5b704: 52800022    	mov	w2, #0x1                ; =1
100f5b708: 95b32e8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b70c: f00f7708    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f5b710: f9410915    	ldr	x21, [x8, #0x210] ; viewModel
100f5b714: aa1303e0    	mov	x0, x19
100f5b718: aa1503e1    	mov	x1, x21
100f5b71c: 95b32e88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b720: aa1d03fd    	mov	x29, x29
100f5b724: 95b32e89    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f5b728: aa0003f4    	mov	x20, x0
100f5b72c: d00f7728    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100f5b730: f9454901    	ldr	x1, [x8, #0xa90] ; isRecordDetail
100f5b734: 95b32e82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b738: 34000160    	cbz	w0, 0x100f5b764 <__text+0xf53764>
100f5b73c: aa1403e0    	mov	x0, x20
100f5b740: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
100f5b744: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
100f5b748: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
100f5b74c: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
100f5b750: a94967fa    	ldp	x26, x25, [sp, #0x90]
100f5b754: a9486ffc    	ldp	x28, x27, [sp, #0x80]
100f5b758: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
100f5b75c: 910383ff    	add	sp, sp, #0xe0
100f5b760: 15b32e7d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f5b764: aa1303e0    	mov	x0, x19
100f5b768: aa1503e1    	mov	x1, x21
100f5b76c: 95b32e74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b770: aa1d03fd    	mov	x29, x29
100f5b774: 95b32e75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f5b778: aa0003f5    	mov	x21, x0
100f5b77c: b00f7948    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f5b780: f9461901    	ldr	x1, [x8, #0xc30] ; isShareConfirm
100f5b784: 95b32e6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b788: aa0003f6    	mov	x22, x0
100f5b78c: aa1503e0    	mov	x0, x21
100f5b790: 95b32e71    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f5b794: aa1403e0    	mov	x0, x20
100f5b798: 95b32e6f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f5b79c: 37000c36    	tbnz	w22, #0x0, 0x100f5b920 <__text+0xf53920>
100f5b7a0: b00f7948    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f5b7a4: f9460501    	ldr	x1, [x8, #0xc08] ; isCustAsstContext
100f5b7a8: aa1303e0    	mov	x0, x19
100f5b7ac: 95b32e64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b7b0: 34000240    	cbz	w0, 0x100f5b7f8 <__text+0xf537f8>
100f5b7b4: b00f7948    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f5b7b8: f9474101    	ldr	x1, [x8, #0xe80] ; initPlainBgView
100f5b7bc: aa1303e0    	mov	x0, x19
100f5b7c0: 95b32e5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b7c4: f8776a60    	ldr	x0, [x19, x23]
100f5b7c8: b00f8d68    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
100f5b7cc: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
100f5b7d0: 52800022    	mov	w2, #0x1                ; =1
100f5b7d4: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
100f5b7d8: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
100f5b7dc: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
100f5b7e0: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
100f5b7e4: a94967fa    	ldp	x26, x25, [sp, #0x90]
100f5b7e8: a9486ffc    	ldp	x28, x27, [sp, #0x80]
100f5b7ec: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
100f5b7f0: 910383ff    	add	sp, sp, #0xe0
100f5b7f4: 15b32e52    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b7f8: 900f90c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f5b7fc: f9470100    	ldr	x0, [x8, #0xe00] ; �*c 
100f5b800: 900f8d48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f5b804: f9438501    	ldr	x1, [x8, #0x708] ; isDarkMode
100f5b808: 95b32e4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b80c: aa0003f4    	mov	x20, x0
100f5b810: 9101a3e0    	add	x0, sp, #0x68
100f5b814: aa1303e1    	mov	x1, x19
100f5b818: 95b32e55    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
100f5b81c: b00f90d9    	adrp	x25, 0x120174000 <dyld_stub_binder+0x120174000>
100f5b820: f00e349a    	adrp	x26, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
100f5b824: f947e35a    	ldr	x26, [x26, #0xfc0]
100f5b828: f9450f35    	ldr	x21, [x25, #0xa18]
100f5b82c: f9001ffa    	str	x26, [sp, #0x38]
100f5b830: d00bf128    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
100f5b834: fd41c108    	ldr	d8, [x8, #0x380]
100f5b838: 90000008    	adrp	x8, 0x100f5b000 <__text+0xf53000>
100f5b83c: 91251108    	add	x8, x8, #0x944
100f5b840: fd0023e8    	str	d8, [sp, #0x40]
100f5b844: d00e359b    	adrp	x27, 0x11d60d000 <dyld_stub_binder+0x11d60d000>
100f5b848: 9123037b    	add	x27, x27, #0x8c0
100f5b84c: a904efe8    	stp	x8, x27, [sp, #0x48]
100f5b850: 9100e3f8    	add	x24, sp, #0x38
100f5b854: 91008300    	add	x0, x24, #0x20
100f5b858: 9101a3e1    	add	x1, sp, #0x68
100f5b85c: 95b32e47    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
100f5b860: 390183f4    	strb	w20, [sp, #0x60]
100f5b864: 900f7728    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f5b868: f9400d16    	ldr	x22, [x8, #0x18] ; imageWithBlock:
100f5b86c: 9100e3e2    	add	x2, sp, #0x38
100f5b870: aa1503e0    	mov	x0, x21
100f5b874: aa1603e1    	mov	x1, x22
100f5b878: 95b32e31    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b87c: aa1d03fd    	mov	x29, x29
100f5b880: 95b32e32    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f5b884: aa0003f5    	mov	x21, x0
100f5b888: f8776a60    	ldr	x0, [x19, x23]
100f5b88c: b00f8d68    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
100f5b890: f9417901    	ldr	x1, [x8, #0x2f0] ; setImage:
100f5b894: aa1503e2    	mov	x2, x21
100f5b898: 95b32e29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b89c: aa1503e0    	mov	x0, x21
100f5b8a0: 95b32e2d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f5b8a4: f9450f35    	ldr	x21, [x25, #0xa18]
100f5b8a8: f90007fa    	str	x26, [sp, #0x8]
100f5b8ac: fd000be8    	str	d8, [sp, #0x10]
100f5b8b0: 90000008    	adrp	x8, 0x100f5b000 <__text+0xf53000>
100f5b8b4: 91278108    	add	x8, x8, #0x9e0
100f5b8b8: a901efe8    	stp	x8, x27, [sp, #0x18]
100f5b8bc: 910023f9    	add	x25, sp, #0x8
100f5b8c0: 91008320    	add	x0, x25, #0x20
100f5b8c4: 9101a3e1    	add	x1, sp, #0x68
100f5b8c8: 95b32e2c    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
100f5b8cc: 3900c3f4    	strb	w20, [sp, #0x30]
100f5b8d0: 910023e2    	add	x2, sp, #0x8
100f5b8d4: aa1503e0    	mov	x0, x21
100f5b8d8: aa1603e1    	mov	x1, x22
100f5b8dc: 95b32e18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b8e0: aa1d03fd    	mov	x29, x29
100f5b8e4: 95b32e19    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f5b8e8: aa0003f4    	mov	x20, x0
100f5b8ec: f8776a60    	ldr	x0, [x19, x23]
100f5b8f0: b00f8d68    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
100f5b8f4: f9411d01    	ldr	x1, [x8, #0x238] ; setHighlightedImage:
100f5b8f8: aa1403e2    	mov	x2, x20
100f5b8fc: 95b32e10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5b900: aa1403e0    	mov	x0, x20
100f5b904: 95b32e14    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f5b908: 91008320    	add	x0, x25, #0x20
100f5b90c: 95b32e21    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
100f5b910: 91008300    	add	x0, x24, #0x20
100f5b914: 95b32e1f    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
100f5b918: 9101a3e0    	add	x0, sp, #0x68
100f5b91c: 95b32e1d    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
100f5b920: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
100f5b924: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
100f5b928: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
100f5b92c: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
100f5b930: a94967fa    	ldp	x26, x25, [sp, #0x90]
100f5b934: a9486ffc    	ldp	x28, x27, [sp, #0x80]
100f5b938: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
100f5b93c: 910383ff    	add	sp, sp, #0xe0
100f5b940: d65f03c0    	ret