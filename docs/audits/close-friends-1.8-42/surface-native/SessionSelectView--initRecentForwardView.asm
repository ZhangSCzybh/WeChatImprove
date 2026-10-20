
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057e598c: d10243ff    	sub	sp, sp, #0x90
1057e5990: 6d012beb    	stp	d11, d10, [sp, #0x10]
1057e5994: 6d0223e9    	stp	d9, d8, [sp, #0x20]
1057e5998: a9036ffc    	stp	x28, x27, [sp, #0x30]
1057e599c: a90467fa    	stp	x26, x25, [sp, #0x40]
1057e59a0: a9055ff8    	stp	x24, x23, [sp, #0x50]
1057e59a4: a90657f6    	stp	x22, x21, [sp, #0x60]
1057e59a8: a9074ff4    	stp	x20, x19, [sp, #0x70]
1057e59ac: a9087bfd    	stp	x29, x30, [sp, #0x80]
1057e59b0: 910203fd    	add	x29, sp, #0x80
1057e59b4: aa0003f3    	mov	x19, x0
1057e59b8: 900da2e8    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
1057e59bc: 52800029    	mov	w9, #0x1                ; =1
1057e59c0: 39131909    	strb	w9, [x8, #0x4c6]
1057e59c4: 900d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e59c8: f942d501    	ldr	x1, [x8, #0x5a8] ; m_recentForwardHidden
1057e59cc: 949105dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e59d0: 370000a0    	tbnz	w0, #0x0, 0x1057e59e4 <_Flutter_MMFoundation_BindContext+0x1cc15c8>
1057e59d4: d00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e59d8: b983cd1b    	ldrsw	x27, [x8, #0x3cc] ; ivar SessionSelectView._recentForwardScrollView
1057e59dc: f87b6a68    	ldr	x8, [x19, x27]
1057e59e0: b4000168    	cbz	x8, 0x1057e5a0c <_Flutter_MMFoundation_BindContext+0x1cc15f0>
1057e59e4: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1057e59e8: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1057e59ec: a94657f6    	ldp	x22, x21, [sp, #0x60]
1057e59f0: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1057e59f4: a94467fa    	ldp	x26, x25, [sp, #0x40]
1057e59f8: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1057e59fc: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
1057e5a00: 6d412beb    	ldp	d11, d10, [sp, #0x10]
1057e5a04: 910243ff    	add	sp, sp, #0x90
1057e5a08: d65f03c0    	ret
1057e5a0c: f00d4c68    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1057e5a10: f9401100    	ldr	x0, [x8, #0x20]
1057e5a14: f00d3e08    	adrp	x8, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
1057e5a18: f942c501    	ldr	x1, [x8, #0x588] ; getSessionForwardMaxCount
1057e5a1c: 949105c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5a20: 2a0003f4    	mov	w20, w0
1057e5a24: b00d4c88    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1057e5a28: f940a500    	ldr	x0, [x8, #0x148]
1057e5a2c: f00d3e28    	adrp	x8, 0x11ffac000 <dyld_stub_binder+0x11ffac000>
1057e5a30: f9446501    	ldr	x1, [x8, #0x8c8] ; isiPadLayoutScene:
1057e5a34: aa1303e2    	mov	x2, x19
1057e5a38: 949105c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5a3c: 1e661008    	fmov	d8, #16.00000000
1057e5a40: d00d4c7c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
1057e5a44: 900d32b8    	adrp	x24, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1057e5a48: 340000e0    	cbz	w0, 0x1057e5a64 <_Flutter_MMFoundation_BindContext+0x1cc1648>
1057e5a4c: f9461b80    	ldr	x0, [x28, #0xc30]
1057e5a50: f9463301    	ldr	x1, [x24, #0xc60] ; dynamicLength:
1057e5a54: d2e80988    	mov	x8, #0x404c000000000000 ; =4633078116657397760
1057e5a58: 9e670100    	fmov	d0, x8
1057e5a5c: 949105b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5a60: 1e604008    	fmov	d8, d0
1057e5a64: d00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e5a68: b983e119    	ldrsw	x25, [x8, #0x3e0] ; ivar SessionSelectView.m_delegate
1057e5a6c: 8b190260    	add	x0, x19, x25
1057e5a70: 949105c7    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1057e5a74: aa0003f6    	mov	x22, x0
1057e5a78: 900d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e5a7c: f9443d15    	ldr	x21, [x8, #0x878] ; recentForwardMarginForSelectView:defaultMargin:
1057e5a80: b00d4908    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1057e5a84: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
1057e5a88: aa1503e2    	mov	x2, x21
1057e5a8c: 949105ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5a90: aa0003f7    	mov	x23, x0
1057e5a94: aa1603e0    	mov	x0, x22
1057e5a98: 949105af    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5a9c: 34000177    	cbz	w23, 0x1057e5ac8 <_Flutter_MMFoundation_BindContext+0x1cc16ac>
1057e5aa0: 8b190260    	add	x0, x19, x25
1057e5aa4: 949105ba    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1057e5aa8: aa0003f6    	mov	x22, x0
1057e5aac: aa1503e1    	mov	x1, x21
1057e5ab0: aa1303e2    	mov	x2, x19
1057e5ab4: 1e604100    	fmov	d0, d8
1057e5ab8: 949105a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5abc: 1e604008    	fmov	d8, d0
1057e5ac0: aa1603e0    	mov	x0, x22
1057e5ac4: 949105a4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5ac8: f00d4c88    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
1057e5acc: f947c500    	ldr	x0, [x8, #0xf88]
1057e5ad0: 949105a4    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1057e5ad4: aa0003f6    	mov	x22, x0
1057e5ad8: 900d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e5adc: f9444101    	ldr	x1, [x8, #0x880] ; titleForRecentForwardSection
1057e5ae0: aa1303e0    	mov	x0, x19
1057e5ae4: 94910596    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5ae8: aa1d03fd    	mov	x29, x29
1057e5aec: 94910597    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e5af0: aa0003f5    	mov	x21, x0
1057e5af4: d00d4c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057e5af8: f9468d00    	ldr	x0, [x8, #0xd18]
1057e5afc: f00d32a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057e5b00: f9412501    	ldr	x1, [x8, #0x248] ; isVisionPro
1057e5b04: 9491058e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5b08: d00d4c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057e5b0c: 91318108    	add	x8, x8, #0xc60
1057e5b10: d00d4c69    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
1057e5b14: 91316129    	add	x9, x9, #0xc58
1057e5b18: 7100001f    	cmp	w0, #0x0
1057e5b1c: 9a891108    	csel	x8, x8, x9, ne
1057e5b20: f9400100    	ldr	x0, [x8]
1057e5b24: d00d48c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1057e5b28: 913ee108    	add	x8, x8, #0xfb8
1057e5b2c: d00d3309    	adrp	x9, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
1057e5b30: 91128129    	add	x9, x9, #0x4a0
1057e5b34: 9a891108    	csel	x8, x8, x9, ne
1057e5b38: f9400101    	ldr	x1, [x8]
1057e5b3c: 94910580    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5b40: aa1d03fd    	mov	x29, x29
1057e5b44: 94910581    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e5b48: aa0003f7    	mov	x23, x0
1057e5b4c: f9461b80    	ldr	x0, [x28, #0xc30]
1057e5b50: f9463301    	ldr	x1, [x24, #0xc60] ; dynamicLength:
1057e5b54: d2e80988    	mov	x8, #0x404c000000000000 ; =4633078116657397760
1057e5b58: 9e670100    	fmov	d0, x8
1057e5b5c: 94910578    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5b60: 1e604009    	fmov	d9, d0
1057e5b64: f9461b80    	ldr	x0, [x28, #0xc30]
1057e5b68: d00d3308    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
1057e5b6c: f9429519    	ldr	x25, [x8, #0x528] ; dynamicBoldSystemFontOfSize:
1057e5b70: 1e659000    	fmov	d0, #14.00000000
1057e5b74: aa1903e1    	mov	x1, x25
1057e5b78: 94910571    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5b7c: aa1d03fd    	mov	x29, x29
1057e5b80: 94910572    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e5b84: aa0003f8    	mov	x24, x0
1057e5b88: f00d4c68    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1057e5b8c: f940491a    	ldr	x26, [x8, #0x90]
1057e5b90: f9461b80    	ldr	x0, [x28, #0xc30]
1057e5b94: 1e659000    	fmov	d0, #14.00000000
1057e5b98: aa1903e1    	mov	x1, x25
1057e5b9c: 94910568    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5ba0: aa1d03fd    	mov	x29, x29
1057e5ba4: 94910569    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e5ba8: aa0003f9    	mov	x25, x0
1057e5bac: b00d32c8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1057e5bb0: f940f101    	ldr	x1, [x8, #0x1e0] ; labelLineHeight:
1057e5bb4: aa1a03e0    	mov	x0, x26
1057e5bb8: aa1903e2    	mov	x2, x25
1057e5bbc: 94910560    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5bc0: d2e80828    	mov	x8, #0x4041000000000000 ; =4629981891913580544
1057e5bc4: 9e670101    	fmov	d1, x8
1057e5bc8: 1e61280a    	fadd	d10, d0, d1
1057e5bcc: f9461b80    	ldr	x0, [x28, #0xc30]
1057e5bd0: 900d32a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1057e5bd4: f9464d01    	ldr	x1, [x8, #0xc98] ; dynamicSystemFontOfSize:
1057e5bd8: 1e651000    	fmov	d0, #12.00000000
1057e5bdc: 94910558    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5be0: aa1d03fd    	mov	x29, x29
1057e5be4: 94910559    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e5be8: aa0003fa    	mov	x26, x0
1057e5bec: d00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e5bf0: b983e908    	ldrsw	x8, [x8, #0x3e8] ; ivar SessionSelectView.m_bIgnoreChatRoom
1057e5bf4: 38686a68    	ldrb	w8, [x19, x8]
1057e5bf8: d00d5249    	adrp	x9, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e5bfc: b983ed29    	ldrsw	x9, [x9, #0x3ec] ; ivar SessionSelectView._chatRoomOnly
1057e5c00: 38696a69    	ldrb	w9, [x19, x9]
1057e5c04: f00d3e0a    	adrp	x10, 0x11ffa8000 <dyld_stub_binder+0x11ffa8000>
1057e5c08: f942c941    	ldr	x1, [x10, #0x590]
1057e5c0c: 39000be9    	strb	w9, [sp, #0x2]
1057e5c10: 52800029    	mov	w9, #0x1                ; =1
1057e5c14: 390007e9    	strb	w9, [sp, #0x1]
1057e5c18: 390003e8    	strb	w8, [sp]
1057e5c1c: 1e661001    	fmov	d1, #16.00000000
1057e5c20: 1e665002    	fmov	d2, #18.00000000
1057e5c24: 1e661004    	fmov	d4, #16.00000000
1057e5c28: 1e679006    	fmov	d6, #28.00000000
1057e5c2c: aa1603e0    	mov	x0, x22
1057e5c30: aa1403e2    	mov	x2, x20
1057e5c34: aa1503e3    	mov	x3, x21
1057e5c38: aa1703e4    	mov	x4, x23
1057e5c3c: 1e604120    	fmov	d0, d9
1057e5c40: aa1803e5    	mov	x5, x24
1057e5c44: 1e604143    	fmov	d3, d10
1057e5c48: 1e604105    	fmov	d5, d8
1057e5c4c: 52800006    	mov	w6, #0x0                ; =0
1057e5c50: aa1a03e7    	mov	x7, x26
1057e5c54: 9491053a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5c58: f87b6a68    	ldr	x8, [x19, x27]
1057e5c5c: f83b6a60    	str	x0, [x19, x27]
1057e5c60: aa0803e0    	mov	x0, x8
1057e5c64: 9491053c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5c68: aa1a03e0    	mov	x0, x26
1057e5c6c: 9491053a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5c70: aa1903e0    	mov	x0, x25
1057e5c74: 94910538    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5c78: aa1803e0    	mov	x0, x24
1057e5c7c: 94910536    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5c80: aa1703e0    	mov	x0, x23
1057e5c84: 94910534    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5c88: aa1503e0    	mov	x0, x21
1057e5c8c: 94910532    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5c90: d00d4928    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1057e5c94: f947a501    	ldr	x1, [x8, #0xf48] ; width
1057e5c98: aa1303e0    	mov	x0, x19
1057e5c9c: 94910528    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5ca0: f87b6a60    	ldr	x0, [x19, x27]
1057e5ca4: b00d4928    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1057e5ca8: f9418d01    	ldr	x1, [x8, #0x318] ; setWidth:
1057e5cac: 94910524    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5cb0: f87b6a60    	ldr	x0, [x19, x27]
1057e5cb4: d00d4908    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1057e5cb8: f9451501    	ldr	x1, [x8, #0xa28] ; setDelegate:
1057e5cbc: aa1303e2    	mov	x2, x19
1057e5cc0: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1057e5cc4: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1057e5cc8: a94657f6    	ldp	x22, x21, [sp, #0x60]
1057e5ccc: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1057e5cd0: a94467fa    	ldp	x26, x25, [sp, #0x40]
1057e5cd4: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1057e5cd8: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
1057e5cdc: 6d412beb    	ldp	d11, d10, [sp, #0x10]
1057e5ce0: 910243ff    	add	sp, sp, #0x90
1057e5ce4: 14910516    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
