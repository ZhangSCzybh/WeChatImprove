
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a99c6e4: d10183ff    	sub	sp, sp, #0x60
10a99c6e8: a90167fa    	stp	x26, x25, [sp, #0x10]
10a99c6ec: a9025ff8    	stp	x24, x23, [sp, #0x20]
10a99c6f0: a90357f6    	stp	x22, x21, [sp, #0x30]
10a99c6f4: a9044ff4    	stp	x20, x19, [sp, #0x40]
10a99c6f8: a9057bfd    	stp	x29, x30, [sp, #0x50]
10a99c6fc: 910143fd    	add	x29, sp, #0x50
10a99c700: aa0203f3    	mov	x19, x2
10a99c704: aa0003f5    	mov	x21, x0
10a99c708: f00b15a8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a99c70c: 52800029    	mov	w9, #0x1                ; =1
10a99c710: 39115109    	strb	w9, [x8, #0x454]
10a99c714: aa0203e0    	mov	x0, x2
10a99c718: 953afb4a    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a99c71c: f00ab828    	adrp	x8, 0x1200a3000 <dyld_stub_binder+0x1200a3000>
10a99c720: f942f101    	ldr	x1, [x8, #0x5e0] ; getPermanentWxamPathByMsg:
10a99c724: aa1503e0    	mov	x0, x21
10a99c728: aa1303e2    	mov	x2, x19
10a99c72c: 953afb46    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99c730: aa1d03fd    	mov	x29, x29
10a99c734: 953afb47    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a99c738: aa0003f4    	mov	x20, x0
10a99c73c: f00abeb8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
10a99c740: f9463700    	ldr	x0, [x24, #0xc68] ; CBaseFile
10a99c744: f00aa4e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a99c748: f9467101    	ldr	x1, [x8, #0xce0] ; GetFileSize:
10a99c74c: aa1403e2    	mov	x2, x20
10a99c750: 953afb3d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99c754: f100041f    	cmp	x0, #0x1
10a99c758: 5400066b    	b.lt	0x10a99c824 <_Flutter_MMFoundation_BindContext+0x6e78408>
10a99c75c: d00aa788    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
10a99c760: f9420d01    	ldr	x1, [x8, #0x418] ; tempPathForWxamDecode:
10a99c764: aa1503e0    	mov	x0, x21
10a99c768: aa1303e2    	mov	x2, x19
10a99c76c: 953afb36    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99c770: aa1d03fd    	mov	x29, x29
10a99c774: 953afb37    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a99c778: aa0003f5    	mov	x21, x0
10a99c77c: f9463700    	ldr	x0, [x24, #0xc68] ; CBaseFile
10a99c780: b00aa4e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a99c784: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
10a99c788: aa1503e2    	mov	x2, x21
10a99c78c: 953afb2e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99c790: 900abb28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a99c794: f945f517    	ldr	x23, [x8, #0xbe8] ; dataWithContentsOfFile:
10a99c798: f00abeb9    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
10a99c79c: 34000120    	cbz	w0, 0x10a99c7c0 <_Flutter_MMFoundation_BindContext+0x6e783a4>
10a99c7a0: f9459720    	ldr	x0, [x25, #0xb28]
10a99c7a4: aa1703e1    	mov	x1, x23
10a99c7a8: aa1503e2    	mov	x2, x21
10a99c7ac: 953afb26    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99c7b0: aa1d03fd    	mov	x29, x29
10a99c7b4: 953afb27    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a99c7b8: aa0003f6    	mov	x22, x0
10a99c7bc: b5000680    	cbnz	x0, 0x10a99c88c <_Flutter_MMFoundation_BindContext+0x6e78470>
10a99c7c0: f9459720    	ldr	x0, [x25, #0xb28]
10a99c7c4: aa1703e1    	mov	x1, x23
10a99c7c8: aa1403e2    	mov	x2, x20
10a99c7cc: 953afb1e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99c7d0: aa1d03fd    	mov	x29, x29
10a99c7d4: 953afb1f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a99c7d8: aa0003f7    	mov	x23, x0
10a99c7dc: d00abee8    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
10a99c7e0: f9439d00    	ldr	x0, [x8, #0x738] ; WxamImageConvert
10a99c7e4: f00aa748    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
10a99c7e8: f9460d01    	ldr	x1, [x8, #0xc18] ; decodeWxAMToJpg:scene:
10a99c7ec: aa1703e2    	mov	x2, x23
10a99c7f0: 52800023    	mov	w3, #0x1                ; =1
10a99c7f4: 953afb14    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99c7f8: aa1d03fd    	mov	x29, x29
10a99c7fc: 953afb15    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a99c800: aa0003f6    	mov	x22, x0
10a99c804: b4000140    	cbz	x0, 0x10a99c82c <_Flutter_MMFoundation_BindContext+0x6e78410>
10a99c808: f9463700    	ldr	x0, [x24, #0xc68] ; CBaseFile
10a99c80c: 900aa528    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10a99c810: f9443501    	ldr	x1, [x8, #0x868] ; OverWriteDataToPath:Data:
10a99c814: aa1503e2    	mov	x2, x21
10a99c818: aa1603e3    	mov	x3, x22
10a99c81c: 953afb0a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99c820: 14000019    	b	0x10a99c884 <_Flutter_MMFoundation_BindContext+0x6e78468>
10a99c824: d2800016    	mov	x22, #0x0               ; =0
10a99c828: 1400001b    	b	0x10a99c894 <_Flutter_MMFoundation_BindContext+0x6e78478>
10a99c82c: 52800420    	mov	w0, #0x21               ; =33
10a99c830: 528004a1    	mov	w1, #0x25               ; =37
10a99c834: 52800022    	mov	w2, #0x1                ; =1
10a99c838: 52800003    	mov	w3, #0x0                ; =0
10a99c83c: 52800004    	mov	w4, #0x0                ; =0
10a99c840: 9749b358    	bl	0x107c095a0 <_Flutter_MMFoundation_BindContext+0x40e5184>
10a99c844: f00abea8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a99c848: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
10a99c84c: b00aa4e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a99c850: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a99c854: 900a0868    	adrp	x8, 0x11eaa8000 <dyld_stub_binder+0x11eaa8000>
10a99c858: 91322108    	add	x8, x8, #0xc88
10a99c85c: f90003e8    	str	x8, [sp]
10a99c860: d008a0e5    	adrp	x5, 0x11bdba000 <dyld_stub_binder+0x11bdba000>
10a99c864: 9112cca5    	add	x5, x5, #0x4b3
10a99c868: d008a0e7    	adrp	x7, 0x11bdba000 <dyld_stub_binder+0x11bdba000>
10a99c86c: 9113f8e7    	add	x7, x7, #0x4fe
10a99c870: 52800082    	mov	w2, #0x4                ; =4
10a99c874: d2800003    	mov	x3, #0x0                ; =0
10a99c878: 52800004    	mov	w4, #0x0                ; =0
10a99c87c: 528008e6    	mov	w6, #0x47               ; =71
10a99c880: 953afaf1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99c884: aa1703e0    	mov	x0, x23
10a99c888: 953afaf5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a99c88c: aa1503e0    	mov	x0, x21
10a99c890: 953afaf3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a99c894: aa1403e0    	mov	x0, x20
10a99c898: 953afaf1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a99c89c: aa1303e0    	mov	x0, x19
10a99c8a0: 953afaef    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a99c8a4: aa1603e0    	mov	x0, x22
10a99c8a8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10a99c8ac: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10a99c8b0: a94357f6    	ldp	x22, x21, [sp, #0x30]
10a99c8b4: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10a99c8b8: a94167fa    	ldp	x26, x25, [sp, #0x10]
10a99c8bc: 910183ff    	add	sp, sp, #0x60
10a99c8c0: 153afaee    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>
