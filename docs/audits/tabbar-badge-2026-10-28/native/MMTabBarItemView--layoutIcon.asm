
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10472884c: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
104728850: a9015ff8    	stp	x24, x23, [sp, #0x10]
104728854: a90257f6    	stp	x22, x21, [sp, #0x20]
104728858: a9034ff4    	stp	x20, x19, [sp, #0x30]
10472885c: a9047bfd    	stp	x29, x30, [sp, #0x40]
104728860: 910103fd    	add	x29, sp, #0x40
104728864: aa0003f3    	mov	x19, x0
104728868: b00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
10472886c: 52800029    	mov	w9, #0x1                ; =1
104728870: 391a3109    	strb	w9, [x8, #0x68c]
104728874: b00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104728878: f9469914    	ldr	x20, [x8, #0xd30] ; selector customIconView
10472887c: aa1403e1    	mov	x1, x20
104728880: 94d3fa2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728884: aa1d03fd    	mov	x29, x29
104728888: 94d3fa30    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10472888c: aa0003f6    	mov	x22, x0
104728890: 94d3fa31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728894: aa1303e0    	mov	x0, x19
104728898: aa1403e1    	mov	x1, x20
10472889c: 94d3fa28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047288a0: aa1d03fd    	mov	x29, x29
1047288a4: 94d3fa29    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047288a8: aa0003f5    	mov	x21, x0
1047288ac: b40007b6    	cbz	x22, 0x1047289a0 <_Flutter_MMFoundation_BindContext+0xc04584>
1047288b0: d00dcf08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1047288b4: f9475d01    	ldr	x1, [x8, #0xeb8] ; selector superview
1047288b8: aa1503e0    	mov	x0, x21
1047288bc: 94d3fa20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047288c0: aa1d03fd    	mov	x29, x29
1047288c4: 94d3fa21    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047288c8: aa0003f6    	mov	x22, x0
1047288cc: 94d3fa22    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047288d0: aa1503e0    	mov	x0, x21
1047288d4: 94d3fa20    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047288d8: b5000376    	cbnz	x22, 0x104728944 <_Flutter_MMFoundation_BindContext+0xc04528>
1047288dc: aa1303e0    	mov	x0, x19
1047288e0: aa1403e1    	mov	x1, x20
1047288e4: 94d3fa16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047288e8: aa1d03fd    	mov	x29, x29
1047288ec: 94d3fa17    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047288f0: aa0003f5    	mov	x21, x0
1047288f4: d00dcea8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1047288f8: f9476d01    	ldr	x1, [x8, #0xed8] ; selector addSubview:
1047288fc: aa1303e0    	mov	x0, x19
104728900: aa1503e2    	mov	x2, x21
104728904: 94d3fa0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728908: aa1503e0    	mov	x0, x21
10472890c: 94d3fa12    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728910: aa1303e0    	mov	x0, x19
104728914: aa1403e1    	mov	x1, x20
104728918: 94d3fa09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472891c: aa1d03fd    	mov	x29, x29
104728920: 94d3fa0a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728924: aa0003f5    	mov	x21, x0
104728928: f00db8e8    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
10472892c: f946e101    	ldr	x1, [x8, #0xdc0] ; selector sendSubviewToBack:
104728930: aa1303e0    	mov	x0, x19
104728934: aa1503e2    	mov	x2, x21
104728938: 94d3fa01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472893c: aa1503e0    	mov	x0, x21
104728940: 94d3fa05    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728944: aa1303e0    	mov	x0, x19
104728948: aa1403e1    	mov	x1, x20
10472894c: 94d3f9fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728950: aa1d03fd    	mov	x29, x29
104728954: 94d3f9fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728958: aa0003f5    	mov	x21, x0
10472895c: 900dcf08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104728960: f9411116    	ldr	x22, [x8, #0x220] ; selector setHidden:
104728964: aa1603e1    	mov	x1, x22
104728968: 52800002    	mov	w2, #0x0                ; =0
10472896c: 94d3f9f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728970: aa1503e0    	mov	x0, x21
104728974: 94d3f9f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728978: d00dcec8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10472897c: f9458501    	ldr	x1, [x8, #0xb08] ; selector imageView
104728980: aa1303e0    	mov	x0, x19
104728984: 94d3f9ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728988: aa1d03fd    	mov	x29, x29
10472898c: 94d3f9ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728990: aa0003f5    	mov	x21, x0
104728994: aa1603e1    	mov	x1, x22
104728998: 52800022    	mov	w2, #0x1                ; =1
10472899c: 14000013    	b	0x1047289e8 <_Flutter_MMFoundation_BindContext+0xc045cc>
1047289a0: 900dcf08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1047289a4: f9411116    	ldr	x22, [x8, #0x220] ; selector setHidden:
1047289a8: aa1503e0    	mov	x0, x21
1047289ac: aa1603e1    	mov	x1, x22
1047289b0: 52800022    	mov	w2, #0x1                ; =1
1047289b4: 94d3f9e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047289b8: aa1503e0    	mov	x0, x21
1047289bc: 94d3f9e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047289c0: d00dcec8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1047289c4: f9458514    	ldr	x20, [x8, #0xb08] ; selector imageView
1047289c8: aa1303e0    	mov	x0, x19
1047289cc: aa1403e1    	mov	x1, x20
1047289d0: 94d3f9db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047289d4: aa1d03fd    	mov	x29, x29
1047289d8: 94d3f9dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047289dc: aa0003f5    	mov	x21, x0
1047289e0: aa1603e1    	mov	x1, x22
1047289e4: 52800002    	mov	w2, #0x0                ; =0
1047289e8: 94d3f9d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047289ec: aa1503e0    	mov	x0, x21
1047289f0: 94d3f9d9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047289f4: aa1303e0    	mov	x0, x19
1047289f8: aa1403e1    	mov	x1, x20
1047289fc: 94d3f9d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728a00: aa1d03fd    	mov	x29, x29
104728a04: 94d3f9d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728a08: aa0003f4    	mov	x20, x0
104728a0c: f00dcec8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104728a10: f9458d15    	ldr	x21, [x8, #0xb18] ; selector item
104728a14: aa1303e0    	mov	x0, x19
104728a18: aa1503e1    	mov	x1, x21
104728a1c: 94d3f9c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728a20: aa1d03fd    	mov	x29, x29
104728a24: 94d3f9c9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728a28: aa0003f7    	mov	x23, x0
104728a2c: 900dc188    	adrp	x8, 0x11ff58000 <dyld_stub_binder+0x11ff58000>
104728a30: f940b516    	ldr	x22, [x8, #0x168] ; selector customSize
104728a34: aa1603e1    	mov	x1, x22
104728a38: 94d3f9c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728a3c: aa1d03fd    	mov	x29, x29
104728a40: 94d3f9c2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728a44: aa0003f8    	mov	x24, x0
104728a48: 94d3f9c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728a4c: aa1703e0    	mov	x0, x23
104728a50: 94d3f9c1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728a54: b4000458    	cbz	x24, 0x104728adc <_Flutter_MMFoundation_BindContext+0xc046c0>
104728a58: aa1303e0    	mov	x0, x19
104728a5c: aa1503e1    	mov	x1, x21
104728a60: 94d3f9b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728a64: aa1d03fd    	mov	x29, x29
104728a68: 94d3f9b8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728a6c: aa0003f5    	mov	x21, x0
104728a70: aa1603e1    	mov	x1, x22
104728a74: 94d3f9b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728a78: aa1d03fd    	mov	x29, x29
104728a7c: 94d3f9b3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728a80: aa0003f6    	mov	x22, x0
104728a84: d00dcea8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104728a88: f9430d01    	ldr	x1, [x8, #0x618] ; selector CGSizeValue
104728a8c: 94d3f9ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728a90: b00dcf08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104728a94: f9453d01    	ldr	x1, [x8, #0xa78] ; selector setSize:
104728a98: aa1403e0    	mov	x0, x20
104728a9c: 94d3f9a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728aa0: aa1603e0    	mov	x0, x22
104728aa4: 94d3f9ac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728aa8: aa1503e0    	mov	x0, x21
104728aac: 94d3f9aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728ab0: f00dd248    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104728ab4: f9461900    	ldr	x0, [x8, #0xc30] ; class UIFont
104728ab8: b00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104728abc: f9463101    	ldr	x1, [x8, #0xc60] ; selector dynamicLength:
104728ac0: 1e679000    	fmov	d0, #28.00000000
104728ac4: 94d3f99e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728ac8: 1e641001    	fmov	d1, #8.00000000
104728acc: 1e612800    	fadd	d0, d0, d1
104728ad0: b00db8c8    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
104728ad4: 910f4108    	add	x8, x8, #0x3d0 ; selector setBottom:
104728ad8: 14000016    	b	0x104728b30 <_Flutter_MMFoundation_BindContext+0xc04714>
104728adc: f00dd256    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104728ae0: f9461ac0    	ldr	x0, [x22, #0xc30] ; class UIFont
104728ae4: b00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104728ae8: f9463115    	ldr	x21, [x8, #0xc60] ; selector dynamicLength:
104728aec: 1e679000    	fmov	d0, #28.00000000
104728af0: aa1503e1    	mov	x1, x21
104728af4: 94d3f992    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728af8: 1e604008    	fmov	d8, d0
104728afc: f9461ac0    	ldr	x0, [x22, #0xc30] ; class UIFont
104728b00: 1e679000    	fmov	d0, #28.00000000
104728b04: aa1503e1    	mov	x1, x21
104728b08: 94d3f98d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728b0c: 1e604001    	fmov	d1, d0
104728b10: b00dcf08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104728b14: f9453d01    	ldr	x1, [x8, #0xa78] ; selector setSize:
104728b18: aa1403e0    	mov	x0, x20
104728b1c: 1e604100    	fmov	d0, d8
104728b20: 94d3f987    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728b24: 1e641000    	fmov	d0, #8.00000000
104728b28: 900db8a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104728b2c: 9101e108    	add	x8, x8, #0x78 ; selector setTop:
104728b30: f9400101    	ldr	x1, [x8]
104728b34: aa1403e0    	mov	x0, x20
104728b38: 94d3f981    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728b3c: f00dcf08    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104728b40: f947a501    	ldr	x1, [x8, #0xf48] ; selector width
104728b44: aa1303e0    	mov	x0, x19
104728b48: 94d3f97d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728b4c: 1e6c1001    	fmov	d1, #0.50000000
104728b50: 1e610800    	fmul	d0, d0, d1
104728b54: 900db8a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104728b58: f942dd01    	ldr	x1, [x8, #0x5b8] ; selector setCenterX:
104728b5c: aa1403e0    	mov	x0, x20
104728b60: 94d3f977    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728b64: f00dcee8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104728b68: f9406501    	ldr	x1, [x8, #0xc8] ; selector setAutoresizingMask:
104728b6c: aa1403e0    	mov	x0, x20
104728b70: 52800022    	mov	w2, #0x1                ; =1
104728b74: 94d3f972    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728b78: aa1403e0    	mov	x0, x20
104728b7c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104728b80: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104728b84: a94257f6    	ldp	x22, x21, [sp, #0x20]
104728b88: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104728b8c: 6cc523e9    	ldp	d9, d8, [sp], #0x50
104728b90: 14d3f971    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
