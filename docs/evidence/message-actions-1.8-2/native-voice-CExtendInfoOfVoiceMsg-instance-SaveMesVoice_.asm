
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9a35c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
104b9a360: a9015ff8    	stp	x24, x23, [sp, #0x10]
104b9a364: a90257f6    	stp	x22, x21, [sp, #0x20]
104b9a368: a9034ff4    	stp	x20, x19, [sp, #0x30]
104b9a36c: a9047bfd    	stp	x29, x30, [sp, #0x40]
104b9a370: 910103fd    	add	x29, sp, #0x40
104b9a374: aa0203f3    	mov	x19, x2
104b9a378: aa0003f4    	mov	x20, x0
104b9a37c: 900e0528    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b9a380: 52800029    	mov	w9, #0x1                ; =1
104b9a384: 3919fd09    	strb	w9, [x8, #0x67f]
104b9a388: aa0203e0    	mov	x0, x2
104b9a38c: 94c2336b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b9a390: b00d9548    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b9a394: f9456515    	ldr	x21, [x8, #0xac8] ; m_dtVoice
104b9a398: aa1403e0    	mov	x0, x20
104b9a39c: aa1503e1    	mov	x1, x21
104b9a3a0: 94c23367    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a3a4: aa1d03fd    	mov	x29, x29
104b9a3a8: 94c23368    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a3ac: b4000d80    	cbz	x0, 0x104b9a55c <_Flutter_MMFoundation_BindContext+0x1076140>
104b9a3b0: aa0003f7    	mov	x23, x0
104b9a3b4: aa1403e0    	mov	x0, x20
104b9a3b8: aa1503e1    	mov	x1, x21
104b9a3bc: 94c23360    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a3c0: aa1d03fd    	mov	x29, x29
104b9a3c4: 94c23361    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a3c8: aa0003f8    	mov	x24, x0
104b9a3cc: b00dab48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104b9a3d0: f946e916    	ldr	x22, [x8, #0xdd0] ; length
104b9a3d4: aa1603e1    	mov	x1, x22
104b9a3d8: 94c23359    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a3dc: aa0003f9    	mov	x25, x0
104b9a3e0: aa1803e0    	mov	x0, x24
104b9a3e4: 94c2335c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a3e8: aa1703e0    	mov	x0, x23
104b9a3ec: 94c2335a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a3f0: b4000b79    	cbz	x25, 0x104b9a55c <_Flutter_MMFoundation_BindContext+0x1076140>
104b9a3f4: b00daeda    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
104b9a3f8: f9467b57    	ldr	x23, [x26, #0xcf0]
104b9a3fc: f00d9908    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b9a400: f9426501    	ldr	x1, [x8, #0x4c8] ; m_refMessageWrap
104b9a404: aa1403e0    	mov	x0, x20
104b9a408: 94c2334d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a40c: aa1d03fd    	mov	x29, x29
104b9a410: 94c2334e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a414: aa0003f8    	mov	x24, x0
104b9a418: d00d9508    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b9a41c: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
104b9a420: 94c23347    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a424: aa0003f9    	mov	x25, x0
104b9a428: f9467b40    	ldr	x0, [x26, #0xcf0]
104b9a42c: b00d9548    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b9a430: f943a501    	ldr	x1, [x8, #0x748] ; GetDocPath
104b9a434: 94c23342    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a438: aa1d03fd    	mov	x29, x29
104b9a43c: 94c23343    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a440: aa0003fa    	mov	x26, x0
104b9a444: b00d9548    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b9a448: f943a901    	ldr	x1, [x8, #0x750] ; GetPathOfMesAudio:LocalID:DocPath:
104b9a44c: aa1703e0    	mov	x0, x23
104b9a450: aa1303e2    	mov	x2, x19
104b9a454: aa1903e3    	mov	x3, x25
104b9a458: aa1a03e4    	mov	x4, x26
104b9a45c: 94c23338    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a460: aa1d03fd    	mov	x29, x29
104b9a464: 94c23339    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a468: aa0003f7    	mov	x23, x0
104b9a46c: aa1a03e0    	mov	x0, x26
104b9a470: 94c23339    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a474: aa1803e0    	mov	x0, x24
104b9a478: 94c23337    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a47c: b00daec8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b9a480: f9463d00    	ldr	x0, [x8, #0xc78]
104b9a484: 94c23335    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104b9a488: aa0003f8    	mov	x24, x0
104b9a48c: b00daec8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b9a490: f9463500    	ldr	x0, [x8, #0xc68]
104b9a494: f00d94e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b9a498: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
104b9a49c: aa1703e2    	mov	x2, x23
104b9a4a0: 94c23327    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a4a4: f00d94e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b9a4a8: 9134a108    	add	x8, x8, #0xd28
104b9a4ac: f00d94e9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b9a4b0: 9137a129    	add	x9, x9, #0xde8
104b9a4b4: 7100001f    	cmp	w0, #0x0
104b9a4b8: 9a891108    	csel	x8, x8, x9, ne
104b9a4bc: f9400101    	ldr	x1, [x8]
104b9a4c0: aa1803e0    	mov	x0, x24
104b9a4c4: aa1703e2    	mov	x2, x23
104b9a4c8: 94c2331d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a4cc: aa1403e0    	mov	x0, x20
104b9a4d0: aa1503e1    	mov	x1, x21
104b9a4d4: 94c2331a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a4d8: aa1d03fd    	mov	x29, x29
104b9a4dc: 94c2331b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a4e0: aa0003f9    	mov	x25, x0
104b9a4e4: aa1603e1    	mov	x1, x22
104b9a4e8: 94c23315    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a4ec: aa0003f6    	mov	x22, x0
104b9a4f0: aa1403e0    	mov	x0, x20
104b9a4f4: aa1503e1    	mov	x1, x21
104b9a4f8: 94c23311    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a4fc: aa1d03fd    	mov	x29, x29
104b9a500: 94c23312    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9a504: aa0003f5    	mov	x21, x0
104b9a508: 94c23328    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
104b9a50c: b00dab28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b9a510: f9447501    	ldr	x1, [x8, #0x8e8] ; bytes
104b9a514: 94c2330a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a518: aa0003e4    	mov	x4, x0
104b9a51c: f00d94e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b9a520: f9471d01    	ldr	x1, [x8, #0xe38] ; writeBytes:len:buffer:
104b9a524: aa1803e0    	mov	x0, x24
104b9a528: 52800002    	mov	w2, #0x0                ; =0
104b9a52c: aa1603e3    	mov	x3, x22
104b9a530: 94c23303    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9a534: aa0003f4    	mov	x20, x0
104b9a538: aa1503e0    	mov	x0, x21
104b9a53c: 94c23306    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a540: aa1903e0    	mov	x0, x25
104b9a544: 94c23304    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a548: aa1803e0    	mov	x0, x24
104b9a54c: 94c23302    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a550: aa1703e0    	mov	x0, x23
104b9a554: 94c23300    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a558: 14000002    	b	0x104b9a560 <_Flutter_MMFoundation_BindContext+0x1076144>
104b9a55c: 52800014    	mov	w20, #0x0               ; =0
104b9a560: aa1303e0    	mov	x0, x19
104b9a564: 94c232fc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9a568: aa1403e0    	mov	x0, x20
104b9a56c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104b9a570: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104b9a574: a94257f6    	ldp	x22, x21, [sp, #0x20]
104b9a578: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104b9a57c: a8c567fa    	ldp	x26, x25, [sp], #0x50
104b9a580: d65f03c0    	ret
