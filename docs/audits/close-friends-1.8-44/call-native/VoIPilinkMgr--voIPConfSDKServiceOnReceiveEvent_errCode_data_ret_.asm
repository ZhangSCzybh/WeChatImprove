
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106269920: d10203ff    	sub	sp, sp, #0x80
106269924: a9026ffc    	stp	x28, x27, [sp, #0x20]
106269928: a90367fa    	stp	x26, x25, [sp, #0x30]
10626992c: a9045ff8    	stp	x24, x23, [sp, #0x40]
106269930: a90557f6    	stp	x22, x21, [sp, #0x50]
106269934: a9064ff4    	stp	x20, x19, [sp, #0x60]
106269938: a9077bfd    	stp	x29, x30, [sp, #0x70]
10626993c: 9101c3fd    	add	x29, sp, #0x70
106269940: aa0503f4    	mov	x20, x5
106269944: aa0403f3    	mov	x19, x4
106269948: aa0303f6    	mov	x22, x3
10626994c: aa0203f7    	mov	x23, x2
106269950: aa0003f5    	mov	x21, x0
106269954: d00d4ec8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106269958: 52800029    	mov	w9, #0x1                ; =1
10626995c: 3926d509    	strb	w9, [x8, #0x9b5]
106269960: aa0403e0    	mov	x0, x4
106269964: 9466f5f5    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106269968: aa1403e0    	mov	x0, x20
10626996c: 9466f5f3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106269970: 52800040    	mov	w0, #0x2                ; =2
106269974: 94668e33    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106269978: 34000840    	cbz	w0, 0x106269a80 <_Flutter_MMFoundation_BindContext+0x2745664>
10626997c: 9466f609    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106269980: aa0003f8    	mov	x24, x0
106269984: d00cf85a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
106269988: f9454740    	ldr	x0, [x26, #0xa88]
10626998c: 9466f5f5    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106269990: aa0003f9    	mov	x25, x0
106269994: f945475a    	ldr	x26, [x26, #0xa88]
106269998: d00cf85c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10626999c: f9458b80    	ldr	x0, [x28, #0xb10]
1062699a0: f00cf4c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1062699a4: f947bd01    	ldr	x1, [x8, #0xf78] ; numberWithUnsignedInt:
1062699a8: aa1703e2    	mov	x2, x23
1062699ac: 9466f5e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062699b0: aa1d03fd    	mov	x29, x29
1062699b4: 9466f5e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062699b8: aa0003fb    	mov	x27, x0
1062699bc: f9458b80    	ldr	x0, [x28, #0xb10]
1062699c0: f00cf4c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1062699c4: f947a501    	ldr	x1, [x8, #0xf48] ; numberWithInt:
1062699c8: aa1603e2    	mov	x2, x22
1062699cc: 9466f5dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062699d0: aa1d03fd    	mov	x29, x29
1062699d4: 9466f5dd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062699d8: aa0003fc    	mov	x28, x0
1062699dc: b00cf508    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1062699e0: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1062699e4: a900ffe0    	stp	x0, xzr, [sp, #0x8]
1062699e8: f90003fb    	str	x27, [sp]
1062699ec: b00c3082    	adrp	x2, 0x11e87a000 <dyld_stub_binder+0x11e87a000>
1062699f0: 9104a042    	add	x2, x2, #0x128
1062699f4: aa1a03e0    	mov	x0, x26
1062699f8: 9466f5d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062699fc: aa1d03fd    	mov	x29, x29
106269a00: 9466f5d2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106269a04: aa0003fa    	mov	x26, x0
106269a08: b00cf4c8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106269a0c: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106269a10: d00c1188    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106269a14: 91352108    	add	x8, x8, #0xd48
106269a18: a90003e8    	stp	x8, x0, [sp]
106269a1c: d00c1182    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106269a20: 9134a042    	add	x2, x2, #0xd28
106269a24: aa1903e0    	mov	x0, x25
106269a28: 9466f5c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106269a2c: aa0003f9    	mov	x25, x0
106269a30: aa1a03e0    	mov	x0, x26
106269a34: 9466f5c8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106269a38: aa1c03e0    	mov	x0, x28
106269a3c: 9466f5c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106269a40: aa1b03e0    	mov	x0, x27
106269a44: 9466f5c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106269a48: 900aae81    	adrp	x1, 0x11b839000 <dyld_stub_binder+0x11b839000>
106269a4c: 9101bc21    	add	x1, x1, #0x6f
106269a50: b00ab9a2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
106269a54: 91112042    	add	x2, x2, #0x448
106269a58: 900ab9c4    	adrp	x4, 0x11b9a1000 <dyld_stub_binder+0x11b9a1000>
106269a5c: 912b0c84    	add	x4, x4, #0xac3
106269a60: 52800040    	mov	w0, #0x2                ; =2
106269a64: 5281ed43    	mov	w3, #0xf6a              ; =3946
106269a68: aa1903e5    	mov	x5, x25
106269a6c: 94668df6    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106269a70: aa1903e0    	mov	x0, x25
106269a74: 9466f5b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106269a78: aa1803e0    	mov	x0, x24
106269a7c: 9466f5cc    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106269a80: d00cf848    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106269a84: f945e900    	ldr	x0, [x8, #0xbd0]
106269a88: f00cf4a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106269a8c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106269a90: 9466f5ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106269a94: aa1d03fd    	mov	x29, x29
106269a98: 9466f5ac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106269a9c: aa0003f8    	mov	x24, x0
106269aa0: d00cf848    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106269aa4: f9467100    	ldr	x0, [x8, #0xce0]
106269aa8: d00cf4a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106269aac: f947ad01    	ldr	x1, [x8, #0xf58] ; class
106269ab0: 9466f5a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106269ab4: aa0003e2    	mov	x2, x0
106269ab8: 900cde88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106269abc: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106269ac0: aa1803e0    	mov	x0, x24
106269ac4: 9466f59e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106269ac8: aa1d03fd    	mov	x29, x29
106269acc: 9466f59f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106269ad0: aa0003f9    	mov	x25, x0
106269ad4: b00cde88    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106269ad8: f9404101    	ldr	x1, [x8, #0x80] ; getExpt:withBoolDef:
106269adc: b00c3082    	adrp	x2, 0x11e87a000 <dyld_stub_binder+0x11e87a000>
106269ae0: 91052042    	add	x2, x2, #0x148
106269ae4: 52800003    	mov	w3, #0x0                ; =0
106269ae8: 9466f595    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106269aec: aa0003fa    	mov	x26, x0
106269af0: aa1903e0    	mov	x0, x25
106269af4: 9466f598    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106269af8: aa1803e0    	mov	x0, x24
106269afc: 9466f596    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106269b00: 7100035f    	cmp	w26, #0x0
106269b04: 7a581ae0    	ccmp	w23, #0x18, #0x0, ne
106269b08: 7a420ac0    	ccmp	w22, #0x2, #0x0, eq
106269b0c: 54000180    	b.eq	0x106269b3c <_Flutter_MMFoundation_BindContext+0x2745720>
106269b10: aa1403e0    	mov	x0, x20
106269b14: 9466f590    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106269b18: aa1303e0    	mov	x0, x19
106269b1c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
106269b20: a9464ff4    	ldp	x20, x19, [sp, #0x60]
106269b24: a94557f6    	ldp	x22, x21, [sp, #0x50]
106269b28: a9445ff8    	ldp	x24, x23, [sp, #0x40]
106269b2c: a94367fa    	ldp	x26, x25, [sp, #0x30]
106269b30: a9426ffc    	ldp	x28, x27, [sp, #0x20]
106269b34: 910203ff    	add	sp, sp, #0x80
106269b38: 1466f587    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106269b3c: d00cf4c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106269b40: f946e901    	ldr	x1, [x8, #0xdd0] ; length
106269b44: aa1303e0    	mov	x0, x19
106269b48: 9466f57d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106269b4c: b4fffe20    	cbz	x0, 0x106269b10 <_Flutter_MMFoundation_BindContext+0x27456f4>
106269b50: aa1303e0    	mov	x0, x19
106269b54: 9466f595    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
106269b58: d00cf4a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106269b5c: f9447501    	ldr	x1, [x8, #0x8e8] ; bytes
106269b60: 9466f577    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106269b64: aa0003f6    	mov	x22, x0
106269b68: 52800040    	mov	w0, #0x2                ; =2
106269b6c: 94668db5    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106269b70: 34000580    	cbz	w0, 0x106269c20 <_Flutter_MMFoundation_BindContext+0x2745804>
106269b74: 9466f58b    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106269b78: aa0003f7    	mov	x23, x0
106269b7c: d00cf859    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
106269b80: f9454720    	ldr	x0, [x25, #0xa88]
106269b84: 9466f577    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106269b88: aa0003f8    	mov	x24, x0
106269b8c: f9454720    	ldr	x0, [x25, #0xa88]
106269b90: 394002c8    	ldrb	w8, [x22]
106269b94: b00cf509    	adrp	x9, 0x12010a000 <dyld_stub_binder+0x12010a000>
106269b98: f946a521    	ldr	x1, [x9, #0xd48] ; stringWithFormat:
106269b9c: a9007fe8    	stp	x8, xzr, [sp]
106269ba0: b00c3082    	adrp	x2, 0x11e87a000 <dyld_stub_binder+0x11e87a000>
106269ba4: 9105a042    	add	x2, x2, #0x168
106269ba8: 9466f565    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106269bac: aa1d03fd    	mov	x29, x29
106269bb0: 9466f566    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106269bb4: aa0003f9    	mov	x25, x0
106269bb8: b00cf4c8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106269bbc: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106269bc0: d00c1188    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106269bc4: 91352108    	add	x8, x8, #0xd48
106269bc8: a90003e8    	stp	x8, x0, [sp]
106269bcc: d00c1182    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106269bd0: 9134a042    	add	x2, x2, #0xd28
106269bd4: aa1803e0    	mov	x0, x24
106269bd8: 9466f559    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106269bdc: aa0003f8    	mov	x24, x0
106269be0: aa1903e0    	mov	x0, x25
106269be4: 9466f55c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106269be8: 900aae81    	adrp	x1, 0x11b839000 <dyld_stub_binder+0x11b839000>
106269bec: 9101bc21    	add	x1, x1, #0x6f
106269bf0: b00ab9a2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
106269bf4: 91112042    	add	x2, x2, #0x448
106269bf8: 900ab9c4    	adrp	x4, 0x11b9a1000 <dyld_stub_binder+0x11b9a1000>
106269bfc: 912b0c84    	add	x4, x4, #0xac3
106269c00: 52800040    	mov	w0, #0x2                ; =2
106269c04: 5281ee83    	mov	w3, #0xf74              ; =3956
106269c08: aa1803e5    	mov	x5, x24
106269c0c: 94668d8e    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106269c10: aa1803e0    	mov	x0, x24
106269c14: 9466f550    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106269c18: aa1703e0    	mov	x0, x23
106269c1c: 9466f564    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106269c20: 394002c8    	ldrb	w8, [x22]
106269c24: 7100051f    	cmp	w8, #0x1
106269c28: 54fff741    	b.ne	0x106269b10 <_Flutter_MMFoundation_BindContext+0x27456f4>
106269c2c: 900ce068    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
106269c30: f942d901    	ldr	x1, [x8, #0x5b0] ; setExceptionType:
106269c34: aa1503e0    	mov	x0, x21
106269c38: 52800062    	mov	w2, #0x3                ; =3
106269c3c: 9466f540    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106269c40: 17ffffb4    	b	0x106269b10 <_Flutter_MMFoundation_BindContext+0x27456f4>
