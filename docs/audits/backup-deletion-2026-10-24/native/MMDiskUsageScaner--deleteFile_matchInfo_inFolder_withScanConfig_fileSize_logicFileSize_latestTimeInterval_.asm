
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c27f0: d10543ff    	sub	sp, sp, #0x150
1029c27f4: a90f6ffc    	stp	x28, x27, [sp, #0xf0]
1029c27f8: a91067fa    	stp	x26, x25, [sp, #0x100]
1029c27fc: a9115ff8    	stp	x24, x23, [sp, #0x110]
1029c2800: a91257f6    	stp	x22, x21, [sp, #0x120]
1029c2804: a9134ff4    	stp	x20, x19, [sp, #0x130]
1029c2808: a9147bfd    	stp	x29, x30, [sp, #0x140]
1029c280c: 910503fd    	add	x29, sp, #0x140
1029c2810: aa0703f9    	mov	x25, x7
1029c2814: aa0603f7    	mov	x23, x6
1029c2818: aa0503f5    	mov	x21, x5
1029c281c: aa0403f4    	mov	x20, x4
1029c2820: aa0303f6    	mov	x22, x3
1029c2824: aa0203f3    	mov	x19, x2
1029c2828: aa0003f8    	mov	x24, x0
1029c282c: 900f13a8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029c2830: 52800029    	mov	w9, #0x1                ; =1
1029c2834: 3934e509    	strb	w9, [x8, #0xd39]
1029c2838: aa0203e0    	mov	x0, x2
1029c283c: 9549923f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2840: aa1403e0    	mov	x0, x20
1029c2844: 9549923d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2848: aa1503e0    	mov	x0, x21
1029c284c: 9549923b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2850: f90002ff    	str	xzr, [x23]
1029c2854: f900033f    	str	xzr, [x25]
1029c2858: b40001d3    	cbz	x19, 0x1029c2890 <_Flutter_Image_provideRelativePathByUrl+0xdcf740>
1029c285c: f90033f8    	str	x24, [sp, #0x60]
1029c2860: d00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c2864: f945f91a    	ldr	x26, [x8, #0xbf0] ; m_urgentLevel
1029c2868: aa1503e0    	mov	x0, x21
1029c286c: aa1a03e1    	mov	x1, x26
1029c2870: 95499233    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2874: 7100081f    	cmp	w0, #0x2
1029c2878: 54000323    	b.lo	0x1029c28dc <_Flutter_Image_provideRelativePathByUrl+0xdcf78c>
1029c287c: aa1503e0    	mov	x0, x21
1029c2880: aa1a03e1    	mov	x1, x26
1029c2884: 9549922e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2888: aa0003fa    	mov	x26, x0
1029c288c: 14000015    	b	0x1029c28e0 <_Flutter_Image_provideRelativePathByUrl+0xdcf790>
1029c2890: b00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c2894: f9453500    	ldr	x0, [x8, #0xa68]
1029c2898: f00ea3a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c289c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c28a0: b00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c28a4: 91322108    	add	x8, x8, #0xc88
1029c28a8: f90003e8    	str	x8, [sp]
1029c28ac: d00c5dc3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c28b0: 9125d063    	add	x3, x3, #0x974
1029c28b4: f00c5e05    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c28b8: 9112f8a5    	add	x5, x5, #0x4be
1029c28bc: 900c5e27    	adrp	x7, 0x11b586000 <dyld_stub_binder+0x11b586000>
1029c28c0: 910914e7    	add	x7, x7, #0x245
1029c28c4: 52800062    	mov	w2, #0x3                ; =3
1029c28c8: 52800004    	mov	w4, #0x0                ; =0
1029c28cc: 5280ae06    	mov	w6, #0x570              ; =1392
1029c28d0: 9549921b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c28d4: 5280001b    	mov	w27, #0x0               ; =0
1029c28d8: 14000227    	b	0x1029c3174 <_Flutter_Image_provideRelativePathByUrl+0xdd0024>
1029c28dc: 5280003a    	mov	w26, #0x1               ; =1
1029c28e0: 5280001c    	mov	w28, #0x0               ; =0
1029c28e4: f94006c8    	ldr	x8, [x22, #0x8]
1029c28e8: 52800038    	mov	w24, #0x1               ; =1
1029c28ec: f100111f    	cmp	x8, #0x4
1029c28f0: f9003bf6    	str	x22, [sp, #0x70]
1029c28f4: 540001cd    	b.le	0x1029c292c <_Flutter_Image_provideRelativePathByUrl+0xdcf7dc>
1029c28f8: f100191f    	cmp	x8, #0x6
1029c28fc: 5400040d    	b.le	0x1029c297c <_Flutter_Image_provideRelativePathByUrl+0xdcf82c>
1029c2900: f1001d1f    	cmp	x8, #0x7
1029c2904: 540005c0    	b.eq	0x1029c29bc <_Flutter_Image_provideRelativePathByUrl+0xdcf86c>
1029c2908: f100211f    	cmp	x8, #0x8
1029c290c: 540006a0    	b.eq	0x1029c29e0 <_Flutter_Image_provideRelativePathByUrl+0xdcf890>
1029c2910: aa1c03e9    	mov	x9, x28
1029c2914: f100251f    	cmp	x8, #0x9
1029c2918: 54000881    	b.ne	0x1029c2a28 <_Flutter_Image_provideRelativePathByUrl+0xdcf8d8>
1029c291c: 5280001c    	mov	w28, #0x0               ; =0
1029c2920: 52800018    	mov	w24, #0x0               ; =0
1029c2924: 52800029    	mov	w9, #0x1                ; =1
1029c2928: 14000040    	b	0x1029c2a28 <_Flutter_Image_provideRelativePathByUrl+0xdcf8d8>
1029c292c: f100091f    	cmp	x8, #0x2
1029c2930: 5400014c    	b.gt	0x1029c2958 <_Flutter_Image_provideRelativePathByUrl+0xdcf808>
1029c2934: f100051f    	cmp	x8, #0x1
1029c2938: 54000340    	b.eq	0x1029c29a0 <_Flutter_Image_provideRelativePathByUrl+0xdcf850>
1029c293c: aa1c03e9    	mov	x9, x28
1029c2940: f100091f    	cmp	x8, #0x2
1029c2944: 54000721    	b.ne	0x1029c2a28 <_Flutter_Image_provideRelativePathByUrl+0xdcf8d8>
1029c2948: 52800009    	mov	w9, #0x0                ; =0
1029c294c: 528a3008    	mov	w8, #0x5180             ; =20864
1029c2950: 72a00028    	movk	w8, #0x1, lsl #16
1029c2954: 14000021    	b	0x1029c29d8 <_Flutter_Image_provideRelativePathByUrl+0xdcf888>
1029c2958: f1000d1f    	cmp	x8, #0x3
1029c295c: 54000280    	b.eq	0x1029c29ac <_Flutter_Image_provideRelativePathByUrl+0xdcf85c>
1029c2960: aa1c03e9    	mov	x9, x28
1029c2964: f100111f    	cmp	x8, #0x4
1029c2968: 54000601    	b.ne	0x1029c2a28 <_Flutter_Image_provideRelativePathByUrl+0xdcf8d8>
1029c296c: 52800009    	mov	w9, #0x0                ; =0
1029c2970: 5292f008    	mov	w8, #0x9780             ; =38784
1029c2974: 72a000c8    	movk	w8, #0x6, lsl #16
1029c2978: 14000018    	b	0x1029c29d8 <_Flutter_Image_provideRelativePathByUrl+0xdcf888>
1029c297c: f100151f    	cmp	x8, #0x5
1029c2980: 54000260    	b.eq	0x1029c29cc <_Flutter_Image_provideRelativePathByUrl+0xdcf87c>
1029c2984: aa1c03e9    	mov	x9, x28
1029c2988: f100191f    	cmp	x8, #0x6
1029c298c: 540004e1    	b.ne	0x1029c2a28 <_Flutter_Image_provideRelativePathByUrl+0xdcf8d8>
1029c2990: 52800009    	mov	w9, #0x0                ; =0
1029c2994: 528ea008    	mov	w8, #0x7500             ; =29952
1029c2998: 72a00248    	movk	w8, #0x12, lsl #16
1029c299c: 1400000f    	b	0x1029c29d8 <_Flutter_Image_provideRelativePathByUrl+0xdcf888>
1029c29a0: 5280001c    	mov	w28, #0x0               ; =0
1029c29a4: 52800018    	mov	w24, #0x0               ; =0
1029c29a8: 1400001f    	b	0x1029c2a24 <_Flutter_Image_provideRelativePathByUrl+0xdcf8d4>
1029c29ac: 52800009    	mov	w9, #0x0                ; =0
1029c29b0: 529e9008    	mov	w8, #0xf480             ; =62592
1029c29b4: 72a00068    	movk	w8, #0x3, lsl #16
1029c29b8: 14000008    	b	0x1029c29d8 <_Flutter_Image_provideRelativePathByUrl+0xdcf888>
1029c29bc: 52800009    	mov	w9, #0x0                ; =0
1029c29c0: 5291a008    	mov	w8, #0x8d00             ; =36096
1029c29c4: 72a004e8    	movk	w8, #0x27, lsl #16
1029c29c8: 14000004    	b	0x1029c29d8 <_Flutter_Image_provideRelativePathByUrl+0xdcf888>
1029c29cc: 52800009    	mov	w9, #0x0                ; =0
1029c29d0: 52875008    	mov	w8, #0x3a80             ; =14976
1029c29d4: 72a00128    	movk	w8, #0x9, lsl #16
1029c29d8: 1ada091c    	udiv	w28, w8, w26
1029c29dc: 14000013    	b	0x1029c2a28 <_Flutter_Image_provideRelativePathByUrl+0xdcf8d8>
1029c29e0: d00ea408    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
1029c29e4: f9458101    	ldr	x1, [x8, #0xb00] ; exptConfig
1029c29e8: f94033e0    	ldr	x0, [sp, #0x60]
1029c29ec: 954991d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c29f0: aa1d03fd    	mov	x29, x29
1029c29f4: 954991d5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c29f8: aa0003fb    	mov	x27, x0
1029c29fc: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2a00: f9412501    	ldr	x1, [x8, #0x248] ; getStoreTimeFromExpt:
1029c2a04: aa1303e2    	mov	x2, x19
1029c2a08: 954991cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2a0c: 528a3008    	mov	w8, #0x5180             ; =20864
1029c2a10: 72a00028    	movk	w8, #0x1, lsl #16
1029c2a14: 1b087c08    	mul	w8, w0, w8
1029c2a18: 1ada091c    	udiv	w28, w8, w26
1029c2a1c: aa1b03e0    	mov	x0, x27
1029c2a20: 954991cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2a24: 52800009    	mov	w9, #0x0                ; =0
1029c2a28: b9006fe9    	str	w9, [sp, #0x6c]
1029c2a2c: 2a1c03f6    	mov	w22, w28
1029c2a30: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2a34: f9412901    	ldr	x1, [x8, #0x250] ; m_isDeleteExpireFileForDebug
1029c2a38: aa1503e0    	mov	x0, x21
1029c2a3c: 954991c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2a40: 7100001f    	cmp	w0, #0x0
1029c2a44: 9a9613fc    	csel	x28, xzr, x22, ne
1029c2a48: b00ebdd6    	adrp	x22, 0x12017b000 <dyld_stub_binder+0x12017b000>
1029c2a4c: f94256c0    	ldr	x0, [x22, #0x4a8]
1029c2a50: d00ea988    	adrp	x8, 0x11fef4000 <dyld_stub_binder+0x11fef4000>
1029c2a54: f944f901    	ldr	x1, [x8, #0x9f0] ; secondsSince1970
1029c2a58: 954991b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2a5c: aa0003fa    	mov	x26, x0
1029c2a60: a939ffbf    	stp	xzr, xzr, [x29, #-0x68]
1029c2a64: a938ffbf    	stp	xzr, xzr, [x29, #-0x78]
1029c2a68: a937ffbf    	stp	xzr, xzr, [x29, #-0x88]
1029c2a6c: f81703bf    	stur	xzr, [x29, #-0x90]
1029c2a70: 7816e3bf    	sturh	wzr, [x29, #-0x92]
1029c2a74: f94256c0    	ldr	x0, [x22, #0x4a8]
1029c2a78: d00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c2a7c: f941f501    	ldr	x1, [x8, #0x3e8] ; GetFileStat:fileSize:logicFileSize:accessTime:motifyTime:changeTime:birthTime:inode:nlink_t:
1029c2a80: d1024ba8    	sub	x8, x29, #0x92
1029c2a84: f9000be8    	str	x8, [sp, #0x10]
1029c2a88: d10243a8    	sub	x8, x29, #0x90
1029c2a8c: d10223a9    	sub	x9, x29, #0x88
1029c2a90: a90023e9    	stp	x9, x8, [sp]
1029c2a94: d10183a3    	sub	x3, x29, #0x60
1029c2a98: d101a3a4    	sub	x4, x29, #0x68
1029c2a9c: d101c3a5    	sub	x5, x29, #0x70
1029c2aa0: d101e3a6    	sub	x6, x29, #0x78
1029c2aa4: d10203a7    	sub	x7, x29, #0x80
1029c2aa8: aa1303e2    	mov	x2, x19
1029c2aac: 954991a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2ab0: 5280001b    	mov	w27, #0x0               ; =0
1029c2ab4: 34003600    	cbz	w0, 0x1029c3174 <_Flutter_Image_provideRelativePathByUrl+0xdd0024>
1029c2ab8: f9400bb6    	ldr	x22, [x29, #0x10]
1029c2abc: f85a03a8    	ldur	x8, [x29, #-0x60]
1029c2ac0: d2c00809    	mov	x9, #0x4000000000       ; =274877906944
1029c2ac4: eb09011f    	cmp	x8, x9
1029c2ac8: 540000c8    	b.hi	0x1029c2ae0 <_Flutter_Image_provideRelativePathByUrl+0xdcf990>
1029c2acc: f85983a9    	ldur	x9, [x29, #-0x68]
1029c2ad0: d280002a    	mov	x10, #0x1               ; =1
1029c2ad4: f2c0080a    	movk	x10, #0x40, lsl #32
1029c2ad8: eb0a013f    	cmp	x9, x10
1029c2adc: 54000083    	b.lo	0x1029c2aec <_Flutter_Image_provideRelativePathByUrl+0xdcf99c>
1029c2ae0: d2800009    	mov	x9, #0x0                ; =0
1029c2ae4: d2800008    	mov	x8, #0x0                ; =0
1029c2ae8: a939ffbf    	stp	xzr, xzr, [x29, #-0x68]
1029c2aec: f90002e8    	str	x8, [x23]
1029c2af0: f9000329    	str	x9, [x25]
1029c2af4: b00ebddb    	adrp	x27, 0x12017b000 <dyld_stub_binder+0x12017b000>
1029c2af8: f9427f60    	ldr	x0, [x27, #0x4f8]
1029c2afc: a9788fa4    	ldp	x4, x3, [x29, #-0x78]
1029c2b00: a97797a6    	ldp	x6, x5, [x29, #-0x88]
1029c2b04: b00eba08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029c2b08: f9468119    	ldr	x25, [x8, #0xd00] ; latestTimeWithCurTime:accessTime:modifyTime:changeTime:birthTime:
1029c2b0c: aa1903e1    	mov	x1, x25
1029c2b10: aa1a03e2    	mov	x2, x26
1029c2b14: 9549918a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2b18: cb000348    	sub	x8, x26, x0
1029c2b1c: f90002c8    	str	x8, [x22]
1029c2b20: 340004b8    	cbz	w24, 0x1029c2bb4 <_Flutter_Image_provideRelativePathByUrl+0xdcfa64>
1029c2b24: a9788fa4    	ldp	x4, x3, [x29, #-0x78]
1029c2b28: f85803a5    	ldur	x5, [x29, #-0x80]
1029c2b2c: f9403bf6    	ldr	x22, [sp, #0x70]
1029c2b30: b4000463    	cbz	x3, 0x1029c2bbc <_Flutter_Image_provideRelativePathByUrl+0xdcfa6c>
1029c2b34: b4000444    	cbz	x4, 0x1029c2bbc <_Flutter_Image_provideRelativePathByUrl+0xdcfa6c>
1029c2b38: b4000425    	cbz	x5, 0x1029c2bbc <_Flutter_Image_provideRelativePathByUrl+0xdcfa6c>
1029c2b3c: f85783a6    	ldur	x6, [x29, #-0x88]
1029c2b40: b40003e6    	cbz	x6, 0x1029c2bbc <_Flutter_Image_provideRelativePathByUrl+0xdcfa6c>
1029c2b44: eb1a007f    	cmp	x3, x26
1029c2b48: 5400022d    	b.le	0x1029c2b8c <_Flutter_Image_provideRelativePathByUrl+0xdcfa3c>
1029c2b4c: eb1a00bf    	cmp	x5, x26
1029c2b50: 540001ed    	b.le	0x1029c2b8c <_Flutter_Image_provideRelativePathByUrl+0xdcfa3c>
1029c2b54: eb1a009f    	cmp	x4, x26
1029c2b58: 540001ad    	b.le	0x1029c2b8c <_Flutter_Image_provideRelativePathByUrl+0xdcfa3c>
1029c2b5c: eb1a00df    	cmp	x6, x26
1029c2b60: 5400016d    	b.le	0x1029c2b8c <_Flutter_Image_provideRelativePathByUrl+0xdcfa3c>
1029c2b64: a909ebfa    	stp	x26, x26, [sp, #0x98]
1029c2b68: aa1303e0    	mov	x0, x19
1029c2b6c: 9549918f    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
1029c2b70: 900eb9e8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1029c2b74: f944d901    	ldr	x1, [x8, #0x9b0] ; UTF8String
1029c2b78: 95499171    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2b7c: 910263e1    	add	x1, sp, #0x98
1029c2b80: 95499358    	bl	0x107c278e0 <_Flutter_MMFoundation_BindContext+0x41034c4>
1029c2b84: a9788fa4    	ldp	x4, x3, [x29, #-0x78]
1029c2b88: a97797a6    	ldp	x6, x5, [x29, #-0x88]
1029c2b8c: f9427f60    	ldr	x0, [x27, #0x4f8]
1029c2b90: aa1903e1    	mov	x1, x25
1029c2b94: aa1a03e2    	mov	x2, x26
1029c2b98: 95499169    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2b9c: cb000348    	sub	x8, x26, x0
1029c2ba0: eb1c011f    	cmp	x8, x28
1029c2ba4: b9406fe8    	ldr	w8, [sp, #0x6c]
1029c2ba8: 1a9fb508    	csinc	w8, w8, wzr, lt
1029c2bac: b9006fe8    	str	w8, [sp, #0x6c]
1029c2bb0: 14000016    	b	0x1029c2c08 <_Flutter_Image_provideRelativePathByUrl+0xdcfab8>
1029c2bb4: f9403bf6    	ldr	x22, [sp, #0x70]
1029c2bb8: 14000014    	b	0x1029c2c08 <_Flutter_Image_provideRelativePathByUrl+0xdcfab8>
1029c2bbc: b00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c2bc0: f9453500    	ldr	x0, [x8, #0xa68]
1029c2bc4: f00ea3a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c2bc8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c2bcc: a901cfe5    	stp	x5, x19, [sp, #0x18]
1029c2bd0: a90093e3    	stp	x3, x4, [sp, #0x8]
1029c2bd4: b00de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c2bd8: 9132a108    	add	x8, x8, #0xca8
1029c2bdc: f90003e8    	str	x8, [sp]
1029c2be0: d00c5dc3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c2be4: 9125d063    	add	x3, x3, #0x974
1029c2be8: f00c5e05    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c2bec: 9112f8a5    	add	x5, x5, #0x4be
1029c2bf0: 900c5e27    	adrp	x7, 0x11b586000 <dyld_stub_binder+0x11b586000>
1029c2bf4: 910914e7    	add	x7, x7, #0x245
1029c2bf8: 52800022    	mov	w2, #0x1                ; =1
1029c2bfc: 52800004    	mov	w4, #0x0                ; =0
1029c2c00: 5280b986    	mov	w6, #0x5cc              ; =1484
1029c2c04: 9549914e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2c08: f94002c8    	ldr	x8, [x22]
1029c2c0c: f9002fe8    	str	x8, [sp, #0x58]
1029c2c10: f85903a8    	ldur	x8, [x29, #-0x70]
1029c2c14: f100051f    	cmp	x8, #0x1
1029c2c18: 54000e6b    	b.lt	0x1029c2de4 <_Flutter_Image_provideRelativePathByUrl+0xdcfc94>
1029c2c1c: f85703a2    	ldur	x2, [x29, #-0x90]
1029c2c20: b4000e22    	cbz	x2, 0x1029c2de4 <_Flutter_Image_provideRelativePathByUrl+0xdcfc94>
1029c2c24: 7856e3a8    	ldurh	w8, [x29, #-0x92]
1029c2c28: 7100091f    	cmp	w8, #0x2
1029c2c2c: 54000dc3    	b.lo	0x1029c2de4 <_Flutter_Image_provideRelativePathByUrl+0xdcfc94>
1029c2c30: b00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c2c34: f9458900    	ldr	x0, [x8, #0xb10]
1029c2c38: d00eba08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1029c2c3c: f947c901    	ldr	x1, [x8, #0xf90] ; numberWithUnsignedLongLong:
1029c2c40: 9549913f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2c44: aa1d03fd    	mov	x29, x29
1029c2c48: 95499140    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2c4c: aa0003f9    	mov	x25, x0
1029c2c50: 900eba48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029c2c54: f9469101    	ldr	x1, [x8, #0xd20] ; stringValue
1029c2c58: 95499139    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2c5c: aa1d03fd    	mov	x29, x29
1029c2c60: 9549913a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2c64: aa0003fa    	mov	x26, x0
1029c2c68: d00eba08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1029c2c6c: f9402d01    	ldr	x1, [x8, #0x58] ; lock
1029c2c70: f94033f6    	ldr	x22, [sp, #0x60]
1029c2c74: aa1603e0    	mov	x0, x22
1029c2c78: 95499131    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2c7c: aa1d03fd    	mov	x29, x29
1029c2c80: 95499132    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2c84: aa0003fb    	mov	x27, x0
1029c2c88: 910263e0    	add	x0, sp, #0x98
1029c2c8c: aa1b03e1    	mov	x1, x27
1029c2c90: 954929a8    	bl	0x107c0d330 <_Flutter_MMFoundation_BindContext+0x40e8f14>
1029c2c94: aa1b03e0    	mov	x0, x27
1029c2c98: 9549912f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2c9c: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2ca0: f9409101    	ldr	x1, [x8, #0x120] ; hardlinkTotalCnt
1029c2ca4: aa1403e0    	mov	x0, x20
1029c2ca8: 95499125    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2cac: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2cb0: f9409501    	ldr	x1, [x8, #0x128] ; setHardlinkTotalCnt:
1029c2cb4: 91000402    	add	x2, x0, #0x1
1029c2cb8: aa1403e0    	mov	x0, x20
1029c2cbc: 95499120    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2cc0: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2cc4: f9412d1b    	ldr	x27, [x8, #0x258] ; hardlinkInodeDict
1029c2cc8: aa1603e0    	mov	x0, x22
1029c2ccc: aa1b03e1    	mov	x1, x27
1029c2cd0: 9549911b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2cd4: aa1d03fd    	mov	x29, x29
1029c2cd8: 9549911c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2cdc: aa0003fc    	mov	x28, x0
1029c2ce0: d00eba08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1029c2ce4: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
1029c2ce8: aa1a03e2    	mov	x2, x26
1029c2cec: 95499114    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2cf0: aa1d03fd    	mov	x29, x29
1029c2cf4: 95499115    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2cf8: aa0003f8    	mov	x24, x0
1029c2cfc: 95499116    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2d00: aa1c03e0    	mov	x0, x28
1029c2d04: 95499114    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2d08: b40002f8    	cbz	x24, 0x1029c2d64 <_Flutter_Image_provideRelativePathByUrl+0xdcfc14>
1029c2d0c: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2d10: f9409901    	ldr	x1, [x8, #0x130] ; hardlinkIgnoreSize
1029c2d14: aa1403e0    	mov	x0, x20
1029c2d18: 95499109    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2d1c: f85a03a8    	ldur	x8, [x29, #-0x60]
1029c2d20: f00ea9a9    	adrp	x9, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2d24: f9409d21    	ldr	x1, [x9, #0x138] ; setHardlinkIgnoreSize:
1029c2d28: 8b000102    	add	x2, x8, x0
1029c2d2c: aa1403e0    	mov	x0, x20
1029c2d30: 95499103    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2d34: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2d38: f940a101    	ldr	x1, [x8, #0x140] ; hardlinkIgnoreCnt
1029c2d3c: aa1403e0    	mov	x0, x20
1029c2d40: 954990ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2d44: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2d48: f940a501    	ldr	x1, [x8, #0x148] ; setHardlinkIgnoreCnt:
1029c2d4c: 91000402    	add	x2, x0, #0x1
1029c2d50: aa1403e0    	mov	x0, x20
1029c2d54: 954990fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2d58: f81a03bf    	stur	xzr, [x29, #-0x60]
1029c2d5c: f90002ff    	str	xzr, [x23]
1029c2d60: 1400001a    	b	0x1029c2dc8 <_Flutter_Image_provideRelativePathByUrl+0xdcfc78>
1029c2d64: aa1603e0    	mov	x0, x22
1029c2d68: aa1b03e1    	mov	x1, x27
1029c2d6c: 954990f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2d70: aa1d03fd    	mov	x29, x29
1029c2d74: 954990f5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2d78: aa0003f8    	mov	x24, x0
1029c2d7c: b00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c2d80: f9458900    	ldr	x0, [x8, #0xb10]
1029c2d84: d00eba08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1029c2d88: f947a501    	ldr	x1, [x8, #0xf48] ; numberWithInt:
1029c2d8c: 52800022    	mov	w2, #0x1                ; =1
1029c2d90: 954990eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2d94: aa1d03fd    	mov	x29, x29
1029c2d98: 954990ec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2d9c: aa0003fb    	mov	x27, x0
1029c2da0: f00eba28    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1029c2da4: f9400901    	ldr	x1, [x8, #0x10] ; setObject:forKey:
1029c2da8: aa1803e0    	mov	x0, x24
1029c2dac: aa1b03e2    	mov	x2, x27
1029c2db0: aa1a03e3    	mov	x3, x26
1029c2db4: 954990e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2db8: aa1b03e0    	mov	x0, x27
1029c2dbc: 954990e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2dc0: aa1803e0    	mov	x0, x24
1029c2dc4: 954990e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2dc8: 910263e0    	add	x0, sp, #0x98
1029c2dcc: 9549295a    	bl	0x107c0d334 <_Flutter_MMFoundation_BindContext+0x40e8f18>
1029c2dd0: aa1a03e0    	mov	x0, x26
1029c2dd4: 954990e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2dd8: aa1903e0    	mov	x0, x25
1029c2ddc: 954990de    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2de0: f9403bf6    	ldr	x22, [sp, #0x70]
1029c2de4: d00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c2de8: f9460101    	ldr	x1, [x8, #0xc00] ; isIgnoreCowFile
1029c2dec: aa1503e0    	mov	x0, x21
1029c2df0: 954990d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2df4: 37001860    	tbnz	w0, #0x0, 0x1029c3100 <_Flutter_Image_provideRelativePathByUrl+0xdcffb0>
1029c2df8: 7856e3a8    	ldurh	w8, [x29, #-0x92]
1029c2dfc: 34001828    	cbz	w8, 0x1029c3100 <_Flutter_Image_provideRelativePathByUrl+0xdcffb0>
1029c2e00: f85903a8    	ldur	x8, [x29, #-0x70]
1029c2e04: f100051f    	cmp	x8, #0x1
1029c2e08: 540017cb    	b.lt	0x1029c3100 <_Flutter_Image_provideRelativePathByUrl+0xdcffb0>
1029c2e0c: f85703a8    	ldur	x8, [x29, #-0x90]
1029c2e10: b4001788    	cbz	x8, 0x1029c3100 <_Flutter_Image_provideRelativePathByUrl+0xdcffb0>
1029c2e14: d00ebd88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1029c2e18: f9427100    	ldr	x0, [x8, #0x4e0]
1029c2e1c: f00eb9e8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1029c2e20: f944d501    	ldr	x1, [x8, #0x9a8] ; fileURLWithPath:isDirectory:
1029c2e24: aa1303e2    	mov	x2, x19
1029c2e28: 52800003    	mov	w3, #0x0                ; =0
1029c2e2c: 954990c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2e30: aa1d03fd    	mov	x29, x29
1029c2e34: 954990c5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2e38: aa0003f9    	mov	x25, x0
1029c2e3c: f9004bff    	str	xzr, [sp, #0x90]
1029c2e40: f00d6168    	adrp	x8, 0x11d5f1000 <dyld_stub_binder+0x11d5f1000>
1029c2e44: f940c908    	ldr	x8, [x8, #0x190]
1029c2e48: f9400103    	ldr	x3, [x8]
1029c2e4c: f90047ff    	str	xzr, [sp, #0x88]
1029c2e50: 900eba08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1029c2e54: f941b51c    	ldr	x28, [x8, #0x368] ; getResourceValue:forKey:error:
1029c2e58: 910243e2    	add	x2, sp, #0x90
1029c2e5c: 910223e4    	add	x4, sp, #0x88
1029c2e60: aa1c03e1    	mov	x1, x28
1029c2e64: 954990b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2e68: aa0003f8    	mov	x24, x0
1029c2e6c: f9404bfa    	ldr	x26, [sp, #0x90]
1029c2e70: aa1a03e0    	mov	x0, x26
1029c2e74: 954990b1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2e78: f94047fb    	ldr	x27, [sp, #0x88]
1029c2e7c: aa1b03e0    	mov	x0, x27
1029c2e80: 954990ae    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2e84: 340010f8    	cbz	w24, 0x1029c30a0 <_Flutter_Image_provideRelativePathByUrl+0xdcff50>
1029c2e88: b400131a    	cbz	x26, 0x1029c30e8 <_Flutter_Image_provideRelativePathByUrl+0xdcff98>
1029c2e8c: b00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c2e90: f9458900    	ldr	x0, [x8, #0xb10]
1029c2e94: b00eb9e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1029c2e98: f947ad18    	ldr	x24, [x8, #0xf58] ; class
1029c2e9c: aa1803e1    	mov	x1, x24
1029c2ea0: 954990a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2ea4: aa0003e2    	mov	x2, x0
1029c2ea8: b00eba08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029c2eac: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
1029c2eb0: aa1a03e0    	mov	x0, x26
1029c2eb4: f9002be1    	str	x1, [sp, #0x50]
1029c2eb8: 954990a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2ebc: 34001160    	cbz	w0, 0x1029c30e8 <_Flutter_Image_provideRelativePathByUrl+0xdcff98>
1029c2ec0: b00eb9e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1029c2ec4: f943b901    	ldr	x1, [x8, #0x770] ; boolValue
1029c2ec8: aa1a03e0    	mov	x0, x26
1029c2ecc: 9549909c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2ed0: 360010c0    	tbz	w0, #0x0, 0x1029c30e8 <_Flutter_Image_provideRelativePathByUrl+0xdcff98>
1029c2ed4: f90023f8    	str	x24, [sp, #0x40]
1029c2ed8: f90043ff    	str	xzr, [sp, #0x80]
1029c2edc: f00d6168    	adrp	x8, 0x11d5f1000 <dyld_stub_binder+0x11d5f1000>
1029c2ee0: f940b508    	ldr	x8, [x8, #0x168]
1029c2ee4: f9400103    	ldr	x3, [x8]
1029c2ee8: f9003fff    	str	xzr, [sp, #0x78]
1029c2eec: 910203e2    	add	x2, sp, #0x80
1029c2ef0: 9101e3e4    	add	x4, sp, #0x78
1029c2ef4: aa1903e0    	mov	x0, x25
1029c2ef8: aa1c03e1    	mov	x1, x28
1029c2efc: 95499090    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2f00: aa0003fc    	mov	x28, x0
1029c2f04: f94043e0    	ldr	x0, [sp, #0x80]
1029c2f08: f90027e0    	str	x0, [sp, #0x48]
1029c2f0c: 9549908b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2f10: f9403ff8    	ldr	x24, [sp, #0x78]
1029c2f14: aa1803e0    	mov	x0, x24
1029c2f18: 95499088    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c2f1c: 34001bdc    	cbz	w28, 0x1029c3294 <_Flutter_Image_provideRelativePathByUrl+0xdd0144>
1029c2f20: f94027fc    	ldr	x28, [sp, #0x48]
1029c2f24: b4001dfc    	cbz	x28, 0x1029c32e0 <_Flutter_Image_provideRelativePathByUrl+0xdd0190>
1029c2f28: b00ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c2f2c: f9458900    	ldr	x0, [x8, #0xb10]
1029c2f30: f94023e1    	ldr	x1, [sp, #0x40]
1029c2f34: 95499082    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2f38: aa0003e2    	mov	x2, x0
1029c2f3c: aa1c03e0    	mov	x0, x28
1029c2f40: f9402be1    	ldr	x1, [sp, #0x50]
1029c2f44: 9549907e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2f48: 36001cc0    	tbz	w0, #0x0, 0x1029c32e0 <_Flutter_Image_provideRelativePathByUrl+0xdd0190>
1029c2f4c: b00eba08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029c2f50: f9425101    	ldr	x1, [x8, #0x4a0] ; integerValue
1029c2f54: aa1c03e0    	mov	x0, x28
1029c2f58: 95499079    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2f5c: f100041f    	cmp	x0, #0x1
1029c2f60: 54001c0b    	b.lt	0x1029c32e0 <_Flutter_Image_provideRelativePathByUrl+0xdd0190>
1029c2f64: aa0003e2    	mov	x2, x0
1029c2f68: f90023f8    	str	x24, [sp, #0x40]
1029c2f6c: b00ebd9c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
1029c2f70: f9458b80    	ldr	x0, [x28, #0xb10]
1029c2f74: d00eba08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1029c2f78: f947a901    	ldr	x1, [x8, #0xf50] ; numberWithInteger:
1029c2f7c: 95499070    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2f80: aa1d03fd    	mov	x29, x29
1029c2f84: 95499071    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2f88: 900eba48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029c2f8c: f9469101    	ldr	x1, [x8, #0xd20] ; stringValue
1029c2f90: f9001fe0    	str	x0, [sp, #0x38]
1029c2f94: 9549906a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2f98: aa1d03fd    	mov	x29, x29
1029c2f9c: 9549906b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2fa0: f9002be0    	str	x0, [sp, #0x50]
1029c2fa4: d00eba08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1029c2fa8: f9402d01    	ldr	x1, [x8, #0x58] ; lock
1029c2fac: f94033fc    	ldr	x28, [sp, #0x60]
1029c2fb0: aa1c03e0    	mov	x0, x28
1029c2fb4: 95499062    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2fb8: aa1d03fd    	mov	x29, x29
1029c2fbc: 95499063    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c2fc0: aa0003f8    	mov	x24, x0
1029c2fc4: 910263e0    	add	x0, sp, #0x98
1029c2fc8: aa1803e1    	mov	x1, x24
1029c2fcc: 954928d9    	bl	0x107c0d330 <_Flutter_MMFoundation_BindContext+0x40e8f14>
1029c2fd0: aa1803e0    	mov	x0, x24
1029c2fd4: 95499060    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c2fd8: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2fdc: f940a901    	ldr	x1, [x8, #0x150] ; cowTotalCnt
1029c2fe0: aa1403e0    	mov	x0, x20
1029c2fe4: 95499056    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2fe8: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c2fec: f940ad01    	ldr	x1, [x8, #0x158] ; setCowTotalCnt:
1029c2ff0: 91000402    	add	x2, x0, #0x1
1029c2ff4: aa1403e0    	mov	x0, x20
1029c2ff8: 95499051    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c2ffc: f00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c3000: f9413101    	ldr	x1, [x8, #0x260] ; cowFileDict
1029c3004: aa1c03e0    	mov	x0, x28
1029c3008: f9001be1    	str	x1, [sp, #0x30]
1029c300c: 9549904c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3010: aa1d03fd    	mov	x29, x29
1029c3014: 9549904d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c3018: b00eba08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1029c301c: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
1029c3020: aa0003fc    	mov	x28, x0
1029c3024: f9402be2    	ldr	x2, [sp, #0x50]
1029c3028: 95499045    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c302c: aa1d03fd    	mov	x29, x29
1029c3030: 95499046    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c3034: aa0003f8    	mov	x24, x0
1029c3038: 95499047    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c303c: aa1c03e0    	mov	x0, x28
1029c3040: 95499045    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c3044: b4001598    	cbz	x24, 0x1029c32f4 <_Flutter_Image_provideRelativePathByUrl+0xdd01a4>
1029c3048: d00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c304c: f940b101    	ldr	x1, [x8, #0x160] ; cowIgnoreSize
1029c3050: aa1403e0    	mov	x0, x20
1029c3054: 9549903a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3058: f85a03a8    	ldur	x8, [x29, #-0x60]
1029c305c: d00ea9a9    	adrp	x9, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c3060: f940b521    	ldr	x1, [x9, #0x168] ; setCowIgnoreSize:
1029c3064: 8b000102    	add	x2, x8, x0
1029c3068: aa1403e0    	mov	x0, x20
1029c306c: 95499034    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3070: d00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c3074: f940b901    	ldr	x1, [x8, #0x170] ; cowIgnoreCnt
1029c3078: aa1403e0    	mov	x0, x20
1029c307c: 95499030    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3080: d00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c3084: f940bd01    	ldr	x1, [x8, #0x178] ; setCowIgnoreCnt:
1029c3088: 91000402    	add	x2, x0, #0x1
1029c308c: aa1403e0    	mov	x0, x20
1029c3090: 9549902b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3094: f81a03bf    	stur	xzr, [x29, #-0x60]
1029c3098: f90002ff    	str	xzr, [x23]
1029c309c: 140000af    	b	0x1029c3358 <_Flutter_Image_provideRelativePathByUrl+0xdd0208>
1029c30a0: 900ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c30a4: f9453500    	ldr	x0, [x8, #0xa68]
1029c30a8: d00ea3a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c30ac: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c30b0: a900cffb    	stp	x27, x19, [sp, #0x8]
1029c30b4: 900de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c30b8: 91332108    	add	x8, x8, #0xcc8
1029c30bc: f90003e8    	str	x8, [sp]
1029c30c0: b00c5dc3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c30c4: 9125d063    	add	x3, x3, #0x974
1029c30c8: d00c5e05    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c30cc: 9112f8a5    	add	x5, x5, #0x4be
1029c30d0: f00c5e07    	adrp	x7, 0x11b586000 <dyld_stub_binder+0x11b586000>
1029c30d4: 910914e7    	add	x7, x7, #0x245
1029c30d8: 52800082    	mov	w2, #0x4                ; =4
1029c30dc: 52800004    	mov	w4, #0x0                ; =0
1029c30e0: 5280c0c6    	mov	w6, #0x606              ; =1542
1029c30e4: 95499016    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c30e8: aa1a03e0    	mov	x0, x26
1029c30ec: 9549901a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c30f0: aa1b03e0    	mov	x0, x27
1029c30f4: 95499018    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c30f8: aa1903e0    	mov	x0, x25
1029c30fc: 95499016    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c3100: b9406fe8    	ldr	w8, [sp, #0x6c]
1029c3104: 34000308    	cbz	w8, 0x1029c3164 <_Flutter_Image_provideRelativePathByUrl+0xdd0014>
1029c3108: b00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c310c: f9429101    	ldr	x1, [x8, #0x520] ; m_isDelete
1029c3110: aa1503e0    	mov	x0, x21
1029c3114: 9549900a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3118: 34000260    	cbz	w0, 0x1029c3164 <_Flutter_Image_provideRelativePathByUrl+0xdd0014>
1029c311c: f9402fe8    	ldr	x8, [sp, #0x58]
1029c3120: f100091f    	cmp	x8, #0x2
1029c3124: 54000461    	b.ne	0x1029c31b0 <_Flutter_Image_provideRelativePathByUrl+0xdd0060>
1029c3128: b00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c312c: f9429501    	ldr	x1, [x8, #0x528] ; m_isDeleteUnknow
1029c3130: aa1503e0    	mov	x0, x21
1029c3134: 95499002    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3138: 34000160    	cbz	w0, 0x1029c3164 <_Flutter_Image_provideRelativePathByUrl+0xdd0014>
1029c313c: 900ebdc8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1029c3140: f9425500    	ldr	x0, [x8, #0x4a8]
1029c3144: d00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c3148: f9413501    	ldr	x1, [x8, #0x268] ; DeleteBizUnknowFile:
1029c314c: aa1303e2    	mov	x2, x19
1029c3150: 95498ffb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3154: aa1d03fd    	mov	x29, x29
1029c3158: 95498ffc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c315c: aa0003f7    	mov	x23, x0
1029c3160: 1400004b    	b	0x1029c328c <_Flutter_Image_provideRelativePathByUrl+0xdd013c>
1029c3164: 5280001b    	mov	w27, #0x0               ; =0
1029c3168: d2800017    	mov	x23, #0x0               ; =0
1029c316c: aa1703e0    	mov	x0, x23
1029c3170: 95498ff9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c3174: aa1503e0    	mov	x0, x21
1029c3178: 95498ff7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c317c: aa1403e0    	mov	x0, x20
1029c3180: 95498ff5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c3184: aa1303e0    	mov	x0, x19
1029c3188: 95498ff3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c318c: aa1b03e0    	mov	x0, x27
1029c3190: a9547bfd    	ldp	x29, x30, [sp, #0x140]
1029c3194: a9534ff4    	ldp	x20, x19, [sp, #0x130]
1029c3198: a95257f6    	ldp	x22, x21, [sp, #0x120]
1029c319c: a9515ff8    	ldp	x24, x23, [sp, #0x110]
1029c31a0: a95067fa    	ldp	x26, x25, [sp, #0x100]
1029c31a4: a94f6ffc    	ldp	x28, x27, [sp, #0xf0]
1029c31a8: 910543ff    	add	sp, sp, #0x150
1029c31ac: d65f03c0    	ret
1029c31b0: 900ebdc8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1029c31b4: f9425500    	ldr	x0, [x8, #0x4a8]
1029c31b8: b00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c31bc: f9420d01    	ldr	x1, [x8, #0x418] ; DeleteBizFile:
1029c31c0: aa1303e2    	mov	x2, x19
1029c31c4: 95498fde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c31c8: aa1d03fd    	mov	x29, x29
1029c31cc: 95498fdf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c31d0: aa0003f7    	mov	x23, x0
1029c31d4: 900ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c31d8: f9463500    	ldr	x0, [x8, #0xc68]
1029c31dc: 900ea3c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1029c31e0: f9467101    	ldr	x1, [x8, #0xce0] ; GetFileSize:
1029c31e4: aa1303e2    	mov	x2, x19
1029c31e8: 95498fd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c31ec: b4000500    	cbz	x0, 0x1029c328c <_Flutter_Image_provideRelativePathByUrl+0xdd013c>
1029c31f0: aa0003f8    	mov	x24, x0
1029c31f4: b94012c8    	ldr	w8, [x22, #0x10]
1029c31f8: b00eb9f6    	adrp	x22, 0x120100000 <dyld_stub_binder+0x120100000>
1029c31fc: 7100111f    	cmp	w8, #0x4
1029c3200: 54000241    	b.ne	0x1029c3248 <_Flutter_Image_provideRelativePathByUrl+0xdd00f8>
1029c3204: f94252c1    	ldr	x1, [x22, #0x4a0] ; containsString:
1029c3208: 900de5a2    	adrp	x2, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c320c: 9133a042    	add	x2, x2, #0xce8
1029c3210: aa1303e0    	mov	x0, x19
1029c3214: 95498fca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3218: 34000140    	cbz	w0, 0x1029c3240 <_Flutter_Image_provideRelativePathByUrl+0xdd00f0>
1029c321c: b00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c3220: f9469501    	ldr	x1, [x8, #0xd28] ; m_cleanedRawImgSize
1029c3224: aa1403e0    	mov	x0, x20
1029c3228: 95498fc5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c322c: d00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c3230: f9410901    	ldr	x1, [x8, #0x210] ; setM_cleanedRawImgSize:
1029c3234: 8b180002    	add	x2, x0, x24
1029c3238: aa1403e0    	mov	x0, x20
1029c323c: 95498fc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3240: f9403be8    	ldr	x8, [sp, #0x70]
1029c3244: b9401108    	ldr	w8, [x8, #0x10]
1029c3248: 7100151f    	cmp	w8, #0x5
1029c324c: 54000201    	b.ne	0x1029c328c <_Flutter_Image_provideRelativePathByUrl+0xdd013c>
1029c3250: f94252c1    	ldr	x1, [x22, #0x4a0] ; containsString:
1029c3254: 900de5a2    	adrp	x2, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c3258: 91342042    	add	x2, x2, #0xd08
1029c325c: aa1303e0    	mov	x0, x19
1029c3260: 95498fb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3264: 34000140    	cbz	w0, 0x1029c328c <_Flutter_Image_provideRelativePathByUrl+0xdd013c>
1029c3268: b00ea9a8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029c326c: f9469901    	ldr	x1, [x8, #0xd30] ; m_cleanedRawVideoSize
1029c3270: aa1403e0    	mov	x0, x20
1029c3274: 95498fb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3278: d00ea9a8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c327c: f9410d01    	ldr	x1, [x8, #0x218] ; setM_cleanedRawVideoSize:
1029c3280: 8b180002    	add	x2, x0, x24
1029c3284: aa1403e0    	mov	x0, x20
1029c3288: 95498fad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c328c: 5280003b    	mov	w27, #0x1               ; =1
1029c3290: 17ffffb7    	b	0x1029c316c <_Flutter_Image_provideRelativePathByUrl+0xdd001c>
1029c3294: 900ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c3298: f9453500    	ldr	x0, [x8, #0xa68]
1029c329c: d00ea3a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c32a0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c32a4: a900cff8    	stp	x24, x19, [sp, #0x8]
1029c32a8: 900de5a8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029c32ac: 91332108    	add	x8, x8, #0xcc8
1029c32b0: f90003e8    	str	x8, [sp]
1029c32b4: b00c5dc3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c32b8: 9125d063    	add	x3, x3, #0x974
1029c32bc: d00c5e05    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029c32c0: 9112f8a5    	add	x5, x5, #0x4be
1029c32c4: f00c5e07    	adrp	x7, 0x11b586000 <dyld_stub_binder+0x11b586000>
1029c32c8: 910914e7    	add	x7, x7, #0x245
1029c32cc: 52800082    	mov	w2, #0x4                ; =4
1029c32d0: 52800004    	mov	w4, #0x0                ; =0
1029c32d4: 5280c226    	mov	w6, #0x611              ; =1553
1029c32d8: 95498f99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c32dc: f94027fc    	ldr	x28, [sp, #0x48]
1029c32e0: aa1c03e0    	mov	x0, x28
1029c32e4: 95498f9c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c32e8: aa1803e0    	mov	x0, x24
1029c32ec: 95498f9a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c32f0: 17ffff7e    	b	0x1029c30e8 <_Flutter_Image_provideRelativePathByUrl+0xdcff98>
1029c32f4: f94033e0    	ldr	x0, [sp, #0x60]
1029c32f8: f9401be1    	ldr	x1, [sp, #0x30]
1029c32fc: 95498f90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3300: aa1d03fd    	mov	x29, x29
1029c3304: 95498f91    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c3308: aa0003f7    	mov	x23, x0
1029c330c: 900ebd88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c3310: f9458900    	ldr	x0, [x8, #0xb10]
1029c3314: b00eba08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1029c3318: f947a501    	ldr	x1, [x8, #0xf48] ; numberWithInt:
1029c331c: 52800022    	mov	w2, #0x1                ; =1
1029c3320: 95498f87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3324: aa1d03fd    	mov	x29, x29
1029c3328: 95498f88    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c332c: aa0003f8    	mov	x24, x0
1029c3330: d00eba28    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1029c3334: f9400901    	ldr	x1, [x8, #0x10] ; setObject:forKey:
1029c3338: aa1703e0    	mov	x0, x23
1029c333c: aa1803e2    	mov	x2, x24
1029c3340: f9402be3    	ldr	x3, [sp, #0x50]
1029c3344: 95498f7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c3348: aa1803e0    	mov	x0, x24
1029c334c: 95498f82    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c3350: aa1703e0    	mov	x0, x23
1029c3354: 95498f80    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c3358: 910263e0    	add	x0, sp, #0x98
1029c335c: 954927f6    	bl	0x107c0d334 <_Flutter_MMFoundation_BindContext+0x40e8f18>
1029c3360: f9402be0    	ldr	x0, [sp, #0x50]
1029c3364: 95498f7c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c3368: f9401fe0    	ldr	x0, [sp, #0x38]
1029c336c: 95498f7a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c3370: f94023f8    	ldr	x24, [sp, #0x40]
1029c3374: 17ffffda    	b	0x1029c32dc <_Flutter_Image_provideRelativePathByUrl+0xdd018c>
