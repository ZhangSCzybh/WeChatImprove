
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bde8c: d10343ff    	sub	sp, sp, #0xd0
10a9bde90: 6d0723e9    	stp	d9, d8, [sp, #0x70]
10a9bde94: a90867fa    	stp	x26, x25, [sp, #0x80]
10a9bde98: a9095ff8    	stp	x24, x23, [sp, #0x90]
10a9bde9c: a90a57f6    	stp	x22, x21, [sp, #0xa0]
10a9bdea0: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
10a9bdea4: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
10a9bdea8: 910303fd    	add	x29, sp, #0xc0
10a9bdeac: aa0003f4    	mov	x20, x0
10a9bdeb0: d00b14a8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a9bdeb4: 52800029    	mov	w9, #0x1                ; =1
10a9bdeb8: 39140109    	strb	w9, [x8, #0x500]
10a9bdebc: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdec0: f945e901    	ldr	x1, [x8, #0xbd0] ; isDynamicImg
10a9bdec4: 953a7560    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdec8: 34000260    	cbz	w0, 0x10a9bdf14 <_Flutter_MMFoundation_BindContext+0x6e99af8>
10a9bdecc: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bded0: f945f101    	ldr	x1, [x8, #0xbe0] ; decodeImageDM
10a9bded4: aa1403e0    	mov	x0, x20
10a9bded8: 953a755b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdedc: aa1d03fd    	mov	x29, x29
10a9bdee0: 953a755c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdee4: aa0003f3    	mov	x19, x0
10a9bdee8: b40002a0    	cbz	x0, 0x10a9bdf3c <_Flutter_MMFoundation_BindContext+0x6e99b20>
10a9bdeec: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdef0: f945f501    	ldr	x1, [x8, #0xbe8] ; decodeImageLM
10a9bdef4: aa1403e0    	mov	x0, x20
10a9bdef8: 953a7553    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdefc: aa1d03fd    	mov	x29, x29
10a9bdf00: 953a7554    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdf04: f100001f    	cmp	x0, #0x0
10a9bdf08: 1a9f07f5    	cset	w21, ne
10a9bdf0c: 953a7554    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bdf10: 1400000c    	b	0x10a9bdf40 <_Flutter_MMFoundation_BindContext+0x6e99b24>
10a9bdf14: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdf18: f945f501    	ldr	x1, [x8, #0xbe8] ; decodeImageLM
10a9bdf1c: aa1403e0    	mov	x0, x20
10a9bdf20: 953a7549    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdf24: aa1d03fd    	mov	x29, x29
10a9bdf28: 953a754a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdf2c: aa0003f3    	mov	x19, x0
10a9bdf30: f100001f    	cmp	x0, #0x0
10a9bdf34: 1a9f07f5    	cset	w21, ne
10a9bdf38: 14000002    	b	0x10a9bdf40 <_Flutter_MMFoundation_BindContext+0x6e99b24>
10a9bdf3c: 52800015    	mov	w21, #0x0               ; =0
10a9bdf40: aa1303e0    	mov	x0, x19
10a9bdf44: 953a7546    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bdf48: 37000cb5    	tbnz	w21, #0x0, 0x10a9be0dc <_Flutter_MMFoundation_BindContext+0x6e99cc0>
10a9bdf4c: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bdf50: b98ead08    	ldrsw	x8, [x8, #0xeac]
10a9bdf54: 38686a89    	ldrb	w9, [x20, x8]
10a9bdf58: 37000c29    	tbnz	w9, #0x0, 0x10a9be0dc <_Flutter_MMFoundation_BindContext+0x6e99cc0>
10a9bdf5c: 52800029    	mov	w9, #0x1                ; =1
10a9bdf60: 38286a89    	strb	w9, [x20, x8]
10a9bdf64: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bdf68: b98e9d08    	ldrsw	x8, [x8, #0xe9c]
10a9bdf6c: f8686a93    	ldr	x19, [x20, x8]
10a9bdf70: aa1303e0    	mov	x0, x19
10a9bdf74: 953a7533    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bdf78: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bdf7c: b98ea108    	ldrsw	x8, [x8, #0xea0]
10a9bdf80: f8686a95    	ldr	x21, [x20, x8]
10a9bdf84: aa1503e0    	mov	x0, x21
10a9bdf88: 953a752e    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bdf8c: d00aba68    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a9bdf90: f9461501    	ldr	x1, [x8, #0xc28] ; value
10a9bdf94: aa1303e0    	mov	x0, x19
10a9bdf98: 953a752b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdf9c: b0096197    	adrp	x23, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10a9bdfa0: f947e2f7    	ldr	x23, [x23, #0xfc0]
10a9bdfa4: f90023f7    	str	x23, [sp, #0x40]
10a9bdfa8: 90071e28    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10a9bdfac: fd41c108    	ldr	d8, [x8, #0x380]
10a9bdfb0: fd0027e8    	str	d8, [sp, #0x48]
10a9bdfb4: b0000008    	adrp	x8, 0x10a9be000 <_Flutter_MMFoundation_BindContext+0x6e99be4>
10a9bdfb8: 9103f108    	add	x8, x8, #0xfc
10a9bdfbc: b00968c9    	adrp	x9, 0x11d6d6000 <dyld_stub_binder+0x11d6d6000>
10a9bdfc0: 91116129    	add	x9, x9, #0x458
10a9bdfc4: a90527e8    	stp	x8, x9, [sp, #0x50]
10a9bdfc8: b9006be0    	str	w0, [sp, #0x68]
10a9bdfcc: f90033f3    	str	x19, [sp, #0x60]
10a9bdfd0: aa1303e0    	mov	x0, x19
10a9bdfd4: 953a751b    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bdfd8: 910103e0    	add	x0, sp, #0x40
10a9bdfdc: 953a7534    	bl	0x10f85b4ac <_UR_96F1_B25D+0x3a6411c>
10a9bdfe0: aa0003f6    	mov	x22, x0
10a9bdfe4: 9100e3e0    	add	x0, sp, #0x38
10a9bdfe8: aa1403e1    	mov	x1, x20
10a9bdfec: 953a7522    	bl	0x10f85b474 <_UR_96F1_B25D+0x3a640e4>
10a9bdff0: 9539d643    	bl	0x10f8338fc <_UR_96F1_B25D+0x3a3c56c>
10a9bdff4: aa1d03fd    	mov	x29, x29
10a9bdff8: 953a7516    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdffc: aa0003f4    	mov	x20, x0
10a9be000: f90003f7    	str	x23, [sp]
10a9be004: 90000008    	adrp	x8, 0x10a9be000 <_Flutter_MMFoundation_BindContext+0x6e99be4>
10a9be008: 9104c108    	add	x8, x8, #0x130
10a9be00c: b00961c9    	adrp	x9, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
10a9be010: 9134e129    	add	x9, x9, #0xd38
10a9be014: fd0007e8    	str	d8, [sp, #0x8]
10a9be018: a90127e8    	stp	x8, x9, [sp, #0x10]
10a9be01c: a9025bf5    	stp	x21, x22, [sp, #0x20]
10a9be020: 910003f9    	mov	x25, sp
10a9be024: aa1603e0    	mov	x0, x22
10a9be028: 953a7506    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9be02c: aa1503e0    	mov	x0, x21
10a9be030: 953a7504    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9be034: 9100c320    	add	x0, x25, #0x30
10a9be038: 9100e3e1    	add	x1, sp, #0x38
10a9be03c: 953a7511    	bl	0x10f85b480 <_UR_96F1_B25D+0x3a640f0>
10a9be040: b00abda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a9be044: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10a9be048: d00aba08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a9be04c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a9be050: 953a74fd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be054: aa1d03fd    	mov	x29, x29
10a9be058: 953a74fe    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be05c: aa0003f7    	mov	x23, x0
10a9be060: 910003e0    	mov	x0, sp
10a9be064: aa1703e1    	mov	x1, x23
10a9be068: 97492862    	bl	0x107c081f0 <_Flutter_MMFoundation_BindContext+0x40e3dd4>
10a9be06c: aa1d03fd    	mov	x29, x29
10a9be070: 953a74f8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be074: aa0003f8    	mov	x24, x0
10a9be078: aa1703e0    	mov	x0, x23
10a9be07c: 953a74f8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be080: aa1403e0    	mov	x0, x20
10a9be084: aa1803e1    	mov	x1, x24
10a9be088: 9539d5fb    	bl	0x10f833874 <_UR_96F1_B25D+0x3a3c4e4>
10a9be08c: aa1803e0    	mov	x0, x24
10a9be090: 953a74f3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be094: aa1403e0    	mov	x0, x20
10a9be098: 953a74f1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be09c: 9100c320    	add	x0, x25, #0x30
10a9be0a0: 953a74fe    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
10a9be0a4: f94017e0    	ldr	x0, [sp, #0x28]
10a9be0a8: 953a74ed    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be0ac: f94013e0    	ldr	x0, [sp, #0x20]
10a9be0b0: 953a74eb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be0b4: aa1603e0    	mov	x0, x22
10a9be0b8: 953a74e9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be0bc: 9100e3e0    	add	x0, sp, #0x38
10a9be0c0: 953a74f6    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
10a9be0c4: f94033e0    	ldr	x0, [sp, #0x60]
10a9be0c8: 953a74e5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be0cc: aa1503e0    	mov	x0, x21
10a9be0d0: 953a74e3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be0d4: aa1303e0    	mov	x0, x19
10a9be0d8: 953a74e1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be0dc: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
10a9be0e0: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
10a9be0e4: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
10a9be0e8: a9495ff8    	ldp	x24, x23, [sp, #0x90]
10a9be0ec: a94867fa    	ldp	x26, x25, [sp, #0x80]
10a9be0f0: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
10a9be0f4: 910343ff    	add	sp, sp, #0xd0
10a9be0f8: d65f03c0    	ret