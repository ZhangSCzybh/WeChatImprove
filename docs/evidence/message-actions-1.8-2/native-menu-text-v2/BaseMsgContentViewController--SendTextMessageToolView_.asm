
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100327a64: d10343ff    	sub	sp, sp, #0xd0
100327a68: 6d0723e9    	stp	d9, d8, [sp, #0x70]
100327a6c: a90867fa    	stp	x26, x25, [sp, #0x80]
100327a70: a9095ff8    	stp	x24, x23, [sp, #0x90]
100327a74: a90a57f6    	stp	x22, x21, [sp, #0xa0]
100327a78: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
100327a7c: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
100327a80: 910303fd    	add	x29, sp, #0xc0
100327a84: aa0203f3    	mov	x19, x2
100327a88: aa0003f4    	mov	x20, x0
100327a8c: d0104828    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
100327a90: 52800029    	mov	w9, #0x1                ; =1
100327a94: 3937fd09    	strb	w9, [x8, #0xdff]
100327a98: aa0203e0    	mov	x0, x2
100327a9c: 95e3fda7    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100327aa0: 900ff5c8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100327aa4: b9842518    	ldrsw	x24, [x8, #0x424]
100327aa8: 8b180280    	add	x0, x20, x24
100327aac: 95e3fdb8    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100327ab0: aa0003f5    	mov	x21, x0
100327ab4: b40002c0    	cbz	x0, 0x100327b0c <__text+0x31fb0c>
100327ab8: 8b180280    	add	x0, x20, x24
100327abc: 95e3fdb4    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100327ac0: aa0003f6    	mov	x22, x0
100327ac4: f00fd928    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100327ac8: f943e117    	ldr	x23, [x8, #0x7c0] ; canSendTextMessageWithText:
100327acc: f00feee8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
100327ad0: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
100327ad4: aa1703e2    	mov	x2, x23
100327ad8: 95e3fd99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327adc: 340001c0    	cbz	w0, 0x100327b14 <__text+0x31fb14>
100327ae0: 8b180280    	add	x0, x20, x24
100327ae4: 95e3fdaa    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100327ae8: aa0003f8    	mov	x24, x0
100327aec: aa1703e1    	mov	x1, x23
100327af0: aa1303e2    	mov	x2, x19
100327af4: 95e3fd92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327af8: aa0003f7    	mov	x23, x0
100327afc: aa1803e0    	mov	x0, x24
100327b00: 95e3fd95    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327b04: 520002f7    	eor	w23, w23, #0x1
100327b08: 14000004    	b	0x100327b18 <__text+0x31fb18>
100327b0c: 52800017    	mov	w23, #0x0               ; =0
100327b10: 14000004    	b	0x100327b20 <__text+0x31fb20>
100327b14: 52800017    	mov	w23, #0x0               ; =0
100327b18: aa1603e0    	mov	x0, x22
100327b1c: 95e3fd8e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327b20: aa1503e0    	mov	x0, x21
100327b24: 95e3fd8c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327b28: f00fd928    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100327b2c: f943e501    	ldr	x1, [x8, #0x7c8] ; canSendTextMessage:
100327b30: aa1403e0    	mov	x0, x20
100327b34: aa1303e2    	mov	x2, x19
100327b38: 95e3fd81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327b3c: 37000f17    	tbnz	w23, #0x0, 0x100327d1c <__text+0x31fd1c>
100327b40: 34000ee0    	cbz	w0, 0x100327d1c <__text+0x31fd1c>
100327b44: 900fd928    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
100327b48: f940cd16    	ldr	x22, [x8, #0x198] ; inputPresenter
100327b4c: aa1403e0    	mov	x0, x20
100327b50: aa1603e1    	mov	x1, x22
100327b54: 95e3fd7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327b58: aa1d03fd    	mov	x29, x29
100327b5c: 95e3fd7b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100327b60: aa0003f7    	mov	x23, x0
100327b64: 900fd928    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
100327b68: f946c101    	ldr	x1, [x8, #0xd80] ; replyingMessage
100327b6c: 95e3fd74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327b70: aa1d03fd    	mov	x29, x29
100327b74: 95e3fd75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100327b78: aa0003f5    	mov	x21, x0
100327b7c: aa1703e0    	mov	x0, x23
100327b80: 95e3fd75    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327b84: aa1403e0    	mov	x0, x20
100327b88: aa1603e1    	mov	x1, x22
100327b8c: 95e3fd6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327b90: aa1d03fd    	mov	x29, x29
100327b94: 95e3fd6d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100327b98: aa0003f7    	mov	x23, x0
100327b9c: 900fd928    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
100327ba0: f9468501    	ldr	x1, [x8, #0xd08] ; replyingReferPartialInfo
100327ba4: 95e3fd66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327ba8: aa1d03fd    	mov	x29, x29
100327bac: 95e3fd67    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100327bb0: aa0003f6    	mov	x22, x0
100327bb4: aa1703e0    	mov	x0, x23
100327bb8: 95e3fd67    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327bbc: 900ff5c8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100327bc0: b9843d19    	ldrsw	x25, [x8, #0x43c]
100327bc4: f8796a80    	ldr	x0, [x20, x25]
100327bc8: f00fd928    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100327bcc: f943e901    	ldr	x1, [x8, #0x7d0] ; lastPastedText
100327bd0: 95e3fd5b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327bd4: aa1d03fd    	mov	x29, x29
100327bd8: 95e3fd5c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100327bdc: aa0003f7    	mov	x23, x0
100327be0: 900feee8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100327be4: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
100327be8: aa1303e0    	mov	x0, x19
100327bec: aa1703e2    	mov	x2, x23
100327bf0: 95e3fd53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327bf4: aa0003f8    	mov	x24, x0
100327bf8: aa1703e0    	mov	x0, x23
100327bfc: 95e3fd56    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327c00: f8796a80    	ldr	x0, [x20, x25]
100327c04: f00fd928    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100327c08: f943ed01    	ldr	x1, [x8, #0x7d8] ; resetText
100327c0c: 95e3fd4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327c10: d2800000    	mov	x0, #0x0                ; =0
100327c14: 5292d001    	mov	w1, #0x9680             ; =38528
100327c18: 72a01301    	movk	w1, #0x98, lsl #16
100327c1c: 95e3fd69    	bl	0x107c271c0 <_Flutter_MMFoundation_BindContext+0x4102da4>
100327c20: aa0003f7    	mov	x23, x0
100327c24: f00e9639    	adrp	x25, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
100327c28: f947e339    	ldr	x25, [x25, #0xfc0]
100327c2c: f90017f9    	str	x25, [sp, #0x28]
100327c30: d00c52c8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
100327c34: fd41c108    	ldr	d8, [x8, #0x380]
100327c38: 90000008    	adrp	x8, 0x100327000 <__text+0x31f000>
100327c3c: 91351108    	add	x8, x8, #0xd44
100327c40: fd001be8    	str	d8, [sp, #0x30]
100327c44: 900e96a9    	adrp	x9, 0x11d5fb000 <dyld_stub_binder+0x11d5fb000>
100327c48: 9128a129    	add	x9, x9, #0xa28
100327c4c: a903a7e8    	stp	x8, x9, [sp, #0x38]
100327c50: f90027f4    	str	x20, [sp, #0x48]
100327c54: aa1303e0    	mov	x0, x19
100327c58: 95e3fd38    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100327c5c: a90557f3    	stp	x19, x21, [sp, #0x50]
100327c60: f90033f6    	str	x22, [sp, #0x60]
100327c64: 3901a3f8    	strb	w24, [sp, #0x68]
100327c68: aa1603e0    	mov	x0, x22
100327c6c: 95e3fd33    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100327c70: aa1503e0    	mov	x0, x21
100327c74: 95e3fd31    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100327c78: 900e9641    	adrp	x1, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100327c7c: f9408c21    	ldr	x1, [x1, #0x118]
100327c80: 9100a3e2    	add	x2, sp, #0x28
100327c84: aa1703e0    	mov	x0, x23
100327c88: 95e39568    	bl	0x107c0d228 <_Flutter_MMFoundation_BindContext+0x40e8e0c>
100327c8c: 900ff268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100327c90: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100327c94: b00feec8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100327c98: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100327c9c: 95e3fd28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327ca0: aa1d03fd    	mov	x29, x29
100327ca4: 95e3fd29    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100327ca8: aa0003f7    	mov	x23, x0
100327cac: b00ff248    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
100327cb0: f9468502    	ldr	x2, [x8, #0xd08]
100327cb4: f00fd928    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100327cb8: f943f503    	ldr	x3, [x8, #0x7e8] ; onExtChatUploadReplyChat:
100327cbc: f90003f9    	str	x25, [sp]
100327cc0: 90000008    	adrp	x8, 0x100327000 <__text+0x31f000>
100327cc4: 91358108    	add	x8, x8, #0xd60
100327cc8: f00e9669    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
100327ccc: 91238129    	add	x9, x9, #0x8e0
100327cd0: fd0007e8    	str	d8, [sp, #0x8]
100327cd4: a90127e8    	stp	x8, x9, [sp, #0x10]
100327cd8: f90013f4    	str	x20, [sp, #0x20]
100327cdc: f00fd888    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100327ce0: f9404901    	ldr	x1, [x8, #0x90] ; callExtension:selector:block:
100327ce4: 910003e4    	mov	x4, sp
100327ce8: 95e3fd15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327cec: aa1703e0    	mov	x0, x23
100327cf0: 95e3fd19    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327cf4: f94033e0    	ldr	x0, [sp, #0x60]
100327cf8: 95e3fd17    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327cfc: f9402fe0    	ldr	x0, [sp, #0x58]
100327d00: 95e3fd15    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327d04: f9402be0    	ldr	x0, [sp, #0x50]
100327d08: 95e3fd13    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327d0c: aa1603e0    	mov	x0, x22
100327d10: 95e3fd11    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327d14: aa1503e0    	mov	x0, x21
100327d18: 95e3fd0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327d1c: aa1303e0    	mov	x0, x19
100327d20: 95e3fd0d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327d24: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
100327d28: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
100327d2c: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
100327d30: a9495ff8    	ldp	x24, x23, [sp, #0x90]
100327d34: a94867fa    	ldp	x26, x25, [sp, #0x80]
100327d38: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
100327d3c: 910343ff    	add	sp, sp, #0xd0
100327d40: d65f03c0    	ret
100327d44: a9420808    	ldp	x8, x2, [x0, #0x20]
100327d48: a9431003    	ldp	x3, x4, [x0, #0x30]
100327d4c: 39410005    	ldrb	w5, [x0, #0x40]
100327d50: f00fd929    	adrp	x9, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100327d54: f943f121    	ldr	x1, [x9, #0x7e0] ; AsyncSendMessage:replyingMsg:referPartialInfo:isPasted:
100327d58: aa0803e0    	mov	x0, x8
100327d5c: 15e3fcf8    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327d60: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100327d64: a9014ff4    	stp	x20, x19, [sp, #0x10]
100327d68: a9027bfd    	stp	x29, x30, [sp, #0x20]
100327d6c: 910083fd    	add	x29, sp, #0x20
100327d70: aa0103f3    	mov	x19, x1
100327d74: f9401014    	ldr	x20, [x0, #0x20]
100327d78: b00fd8e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
100327d7c: f944fd15    	ldr	x21, [x8, #0x9f8] ; GetContact
100327d80: aa0103e0    	mov	x0, x1
100327d84: 95e3fced    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100327d88: aa1403e0    	mov	x0, x20
100327d8c: aa1503e1    	mov	x1, x21
100327d90: 95e3fceb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327d94: aa1d03fd    	mov	x29, x29
100327d98: 95e3fcec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100327d9c: aa0003f4    	mov	x20, x0
100327da0: 900fd8a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100327da4: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
100327da8: 95e3fce5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327dac: aa1d03fd    	mov	x29, x29
100327db0: 95e3fce6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100327db4: aa0003f5    	mov	x21, x0
100327db8: f00fd928    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100327dbc: f943f501    	ldr	x1, [x8, #0x7e8] ; onExtChatUploadReplyChat:
100327dc0: aa1303e0    	mov	x0, x19
100327dc4: aa1503e2    	mov	x2, x21
100327dc8: 95e3fcdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100327dcc: aa1303e0    	mov	x0, x19
100327dd0: 95e3fce1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327dd4: aa1503e0    	mov	x0, x21
100327dd8: 95e3fcdf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100327ddc: aa1403e0    	mov	x0, x20
100327de0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100327de4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100327de8: a8c357f6    	ldp	x22, x21, [sp], #0x30
100327dec: 15e3fcda    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>