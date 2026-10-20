
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057e4d5c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1057e4d60: a90157f6    	stp	x22, x21, [sp, #0x10]
1057e4d64: a9024ff4    	stp	x20, x19, [sp, #0x20]
1057e4d68: a9037bfd    	stp	x29, x30, [sp, #0x30]
1057e4d6c: 9100c3fd    	add	x29, sp, #0x30
1057e4d70: aa0203f3    	mov	x19, x2
1057e4d74: aa0003f4    	mov	x20, x0
1057e4d78: b00da2e8    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
1057e4d7c: 52800029    	mov	w9, #0x1                ; =1
1057e4d80: 39131109    	strb	w9, [x8, #0x4c4]
1057e4d84: aa0203e0    	mov	x0, x2
1057e4d88: 949108ec    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057e4d8c: f00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e4d90: b983e117    	ldrsw	x23, [x8, #0x3e0] ; ivar SessionSelectView.m_delegate
1057e4d94: 8b170280    	add	x0, x20, x23
1057e4d98: 949108fd    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1057e4d9c: aa0003f5    	mov	x21, x0
1057e4da0: b00d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e4da4: f9426116    	ldr	x22, [x8, #0x4c0] ; onShouldFilterContact:
1057e4da8: d00d4908    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1057e4dac: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
1057e4db0: aa1603e2    	mov	x2, x22
1057e4db4: 949108e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4db8: 360001c0    	tbz	w0, #0x0, 0x1057e4df0 <_Flutter_MMFoundation_BindContext+0x1cc09d4>
1057e4dbc: 8b170280    	add	x0, x20, x23
1057e4dc0: 949108f3    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1057e4dc4: aa0003f7    	mov	x23, x0
1057e4dc8: aa1603e1    	mov	x1, x22
1057e4dcc: aa1303e2    	mov	x2, x19
1057e4dd0: 949108db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4dd4: aa0003f6    	mov	x22, x0
1057e4dd8: aa1703e0    	mov	x0, x23
1057e4ddc: 949108de    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4de0: aa1503e0    	mov	x0, x21
1057e4de4: 949108dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4de8: 36000096    	tbz	w22, #0x0, 0x1057e4df8 <_Flutter_MMFoundation_BindContext+0x1cc09dc>
1057e4dec: 14000088    	b	0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e4df0: aa1503e0    	mov	x0, x21
1057e4df4: 949108d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4df8: b00d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e4dfc: f942bd15    	ldr	x21, [x8, #0x578] ; m_ignoresChatBox
1057e4e00: aa1403e0    	mov	x0, x20
1057e4e04: aa1503e1    	mov	x1, x21
1057e4e08: 949108cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4e0c: 34000260    	cbz	w0, 0x1057e4e58 <_Flutter_MMFoundation_BindContext+0x1cc0a3c>
1057e4e10: f00d4ca8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1057e4e14: f941fd16    	ldr	x22, [x8, #0x3f8]
1057e4e18: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4e1c: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
1057e4e20: aa1303e0    	mov	x0, x19
1057e4e24: 949108c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4e28: aa1d03fd    	mov	x29, x29
1057e4e2c: 949108c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4e30: aa0003f7    	mov	x23, x0
1057e4e34: 900d34e8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
1057e4e38: f9437901    	ldr	x1, [x8, #0x6f0] ; isChatBox:
1057e4e3c: aa1603e0    	mov	x0, x22
1057e4e40: aa1703e2    	mov	x2, x23
1057e4e44: 949108be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4e48: aa0003f6    	mov	x22, x0
1057e4e4c: aa1703e0    	mov	x0, x23
1057e4e50: 949108c1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4e54: 37000dd6    	tbnz	w22, #0x0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e4e58: aa1403e0    	mov	x0, x20
1057e4e5c: aa1503e1    	mov	x1, x21
1057e4e60: 949108b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4e64: 340000c0    	cbz	w0, 0x1057e4e7c <_Flutter_MMFoundation_BindContext+0x1cc0a60>
1057e4e68: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4e6c: f946c901    	ldr	x1, [x8, #0xd90] ; isChatBoxContact
1057e4e70: aa1303e0    	mov	x0, x19
1057e4e74: 949108b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4e78: 37000ca0    	tbnz	w0, #0x0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e4e7c: b00d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e4e80: f942c101    	ldr	x1, [x8, #0x580] ; m_ignoresFileTransfer
1057e4e84: aa1403e0    	mov	x0, x20
1057e4e88: 949108ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4e8c: 34000220    	cbz	w0, 0x1057e4ed0 <_Flutter_MMFoundation_BindContext+0x1cc0ab4>
1057e4e90: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4e94: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
1057e4e98: aa1303e0    	mov	x0, x19
1057e4e9c: 949108a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4ea0: aa1d03fd    	mov	x29, x29
1057e4ea4: 949108a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4ea8: aa0003f5    	mov	x21, x0
1057e4eac: f00d48e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1057e4eb0: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
1057e4eb4: 900c6662    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
1057e4eb8: 9137a042    	add	x2, x2, #0xde8
1057e4ebc: 949108a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4ec0: aa0003f6    	mov	x22, x0
1057e4ec4: aa1503e0    	mov	x0, x21
1057e4ec8: 949108a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4ecc: 37000a16    	tbnz	w22, #0x0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e4ed0: b00d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e4ed4: f9443101    	ldr	x1, [x8, #0x860] ; m_ignoresChatBotTransfer
1057e4ed8: aa1403e0    	mov	x0, x20
1057e4edc: 94910898    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4ee0: 34000160    	cbz	w0, 0x1057e4f0c <_Flutter_MMFoundation_BindContext+0x1cc0af0>
1057e4ee4: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4ee8: f947c901    	ldr	x1, [x8, #0xf90] ; isChatBot
1057e4eec: aa1303e0    	mov	x0, x19
1057e4ef0: 94910893    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4ef4: 370008c0    	tbnz	w0, #0x0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e4ef8: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4efc: f947cd01    	ldr	x1, [x8, #0xf98] ; isAIAssistant
1057e4f00: aa1303e0    	mov	x0, x19
1057e4f04: 9491088e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4f08: 37000820    	tbnz	w0, #0x0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e4f0c: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4f10: f947bd01    	ldr	x1, [x8, #0xf78] ; m_isPlugin
1057e4f14: aa1303e0    	mov	x0, x19
1057e4f18: 94910889    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4f1c: 37000780    	tbnz	w0, #0x0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e4f20: f00d3328    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1057e4f24: f946e901    	ldr	x1, [x8, #0xdd0] ; isWeClawBot
1057e4f28: aa1303e0    	mov	x0, x19
1057e4f2c: 94910884    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4f30: 370006e0    	tbnz	w0, #0x0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e4f34: b00d33a8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
1057e4f38: f9418101    	ldr	x1, [x8, #0x300] ; isShowToolBarInMsg
1057e4f3c: aa1303e0    	mov	x0, x19
1057e4f40: 9491087f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4f44: 34000640    	cbz	w0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e4f48: f00d3328    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1057e4f4c: f9413d01    	ldr	x1, [x8, #0x278] ; isBrandSessionHolder
1057e4f50: aa1303e0    	mov	x0, x19
1057e4f54: 9491087a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4f58: 370005a0    	tbnz	w0, #0x0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e4f5c: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4f60: f947c101    	ldr	x1, [x8, #0xf80] ; isHolderContact
1057e4f64: aa1303e0    	mov	x0, x19
1057e4f68: 94910875    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4f6c: 34000460    	cbz	w0, 0x1057e4ff8 <_Flutter_MMFoundation_BindContext+0x1cc0bdc>
1057e4f70: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4f74: f9434d16    	ldr	x22, [x8, #0x698] ; m_nsUsrName
1057e4f78: aa1303e0    	mov	x0, x19
1057e4f7c: aa1603e1    	mov	x1, x22
1057e4f80: 9491086f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4f84: aa1d03fd    	mov	x29, x29
1057e4f88: 94910870    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4f8c: aa0003f5    	mov	x21, x0
1057e4f90: f00d48e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1057e4f94: f943c917    	ldr	x23, [x8, #0x790] ; isEqualToString:
1057e4f98: 900c6662    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
1057e4f9c: 913aa042    	add	x2, x2, #0xea8
1057e4fa0: aa1703e1    	mov	x1, x23
1057e4fa4: 94910866    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4fa8: 34000080    	cbz	w0, 0x1057e4fb8 <_Flutter_MMFoundation_BindContext+0x1cc0b9c>
1057e4fac: aa1503e0    	mov	x0, x21
1057e4fb0: 94910869    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4fb4: 14000011    	b	0x1057e4ff8 <_Flutter_MMFoundation_BindContext+0x1cc0bdc>
1057e4fb8: aa1303e0    	mov	x0, x19
1057e4fbc: aa1603e1    	mov	x1, x22
1057e4fc0: 9491085f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4fc4: aa1d03fd    	mov	x29, x29
1057e4fc8: 94910860    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e4fcc: aa0003f6    	mov	x22, x0
1057e4fd0: 900c6662    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
1057e4fd4: 913a2042    	add	x2, x2, #0xe88
1057e4fd8: aa1703e1    	mov	x1, x23
1057e4fdc: 94910858    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e4fe0: aa0003f7    	mov	x23, x0
1057e4fe4: aa1603e0    	mov	x0, x22
1057e4fe8: 9491085b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4fec: aa1503e0    	mov	x0, x21
1057e4ff0: 94910859    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e4ff4: 340000d7    	cbz	w23, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e4ff8: f00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e4ffc: f947b501    	ldr	x1, [x8, #0xf68] ; isBrandContact
1057e5000: aa1303e0    	mov	x0, x19
1057e5004: 9491084e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5008: 36000140    	tbz	w0, #0x0, 0x1057e5030 <_Flutter_MMFoundation_BindContext+0x1cc0c14>
1057e500c: 52800014    	mov	w20, #0x0               ; =0
1057e5010: aa1303e0    	mov	x0, x19
1057e5014: 94910850    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5018: aa1403e0    	mov	x0, x20
1057e501c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1057e5020: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1057e5024: a94157f6    	ldp	x22, x21, [sp, #0x10]
1057e5028: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1057e502c: d65f03c0    	ret
1057e5030: d00d4c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057e5034: f9471117    	ldr	x23, [x8, #0xe20]
1057e5038: d00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e503c: f9434d15    	ldr	x21, [x8, #0x698] ; m_nsUsrName
1057e5040: aa1303e0    	mov	x0, x19
1057e5044: aa1503e1    	mov	x1, x21
1057e5048: 9491083d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e504c: aa1d03fd    	mov	x29, x29
1057e5050: 9491083e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e5054: aa0003f6    	mov	x22, x0
1057e5058: f00d3508    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
1057e505c: f9416101    	ldr	x1, [x8, #0x2c0] ; isCurUsrName:
1057e5060: aa1703e0    	mov	x0, x23
1057e5064: aa1603e2    	mov	x2, x22
1057e5068: 94910835    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e506c: 34000100    	cbz	w0, 0x1057e508c <_Flutter_MMFoundation_BindContext+0x1cc0c70>
1057e5070: d00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e5074: b983e508    	ldrsw	x8, [x8, #0x3e4] ; ivar SessionSelectView.m_bFilterMyContact
1057e5078: 38686a97    	ldrb	w23, [x20, x8]
1057e507c: aa1603e0    	mov	x0, x22
1057e5080: 94910835    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5084: 3707fc57    	tbnz	w23, #0x0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e5088: 14000003    	b	0x1057e5094 <_Flutter_MMFoundation_BindContext+0x1cc0c78>
1057e508c: aa1603e0    	mov	x0, x22
1057e5090: 94910831    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5094: d00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e5098: b983e908    	ldrsw	x8, [x8, #0x3e8] ; ivar SessionSelectView.m_bIgnoreChatRoom
1057e509c: 38686a88    	ldrb	w8, [x20, x8]
1057e50a0: 7100051f    	cmp	w8, #0x1
1057e50a4: 540000c1    	b.ne	0x1057e50bc <_Flutter_MMFoundation_BindContext+0x1cc0ca0>
1057e50a8: d00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e50ac: f947d101    	ldr	x1, [x8, #0xfa0] ; isChatroom
1057e50b0: aa1303e0    	mov	x0, x19
1057e50b4: 94910822    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e50b8: 3707faa0    	tbnz	w0, #0x0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e50bc: d00d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e50c0: b983ed08    	ldrsw	x8, [x8, #0x3ec] ; ivar SessionSelectView._chatRoomOnly
1057e50c4: 38686a88    	ldrb	w8, [x20, x8]
1057e50c8: 7100051f    	cmp	w8, #0x1
1057e50cc: 540000c1    	b.ne	0x1057e50e4 <_Flutter_MMFoundation_BindContext+0x1cc0cc8>
1057e50d0: d00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e50d4: f947d101    	ldr	x1, [x8, #0xfa0] ; isChatroom
1057e50d8: aa1303e0    	mov	x0, x19
1057e50dc: 94910818    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e50e0: 34fff960    	cbz	w0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e50e4: 900d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e50e8: f9443501    	ldr	x1, [x8, #0x868] ; m_bIgnoreOpenIM
1057e50ec: aa1403e0    	mov	x0, x20
1057e50f0: 94910813    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e50f4: 34000460    	cbz	w0, 0x1057e5180 <_Flutter_MMFoundation_BindContext+0x1cc0d64>
1057e50f8: f00d4c78    	adrp	x24, 0x120174000 <dyld_stub_binder+0x120174000>
1057e50fc: f9400317    	ldr	x23, [x24]
1057e5100: aa1303e0    	mov	x0, x19
1057e5104: aa1503e1    	mov	x1, x21
1057e5108: 9491080d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e510c: aa1d03fd    	mov	x29, x29
1057e5110: 9491080e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e5114: aa0003f6    	mov	x22, x0
1057e5118: d00d32a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057e511c: f947f101    	ldr	x1, [x8, #0xfe0] ; IsOpenImContactUserName:
1057e5120: aa1703e0    	mov	x0, x23
1057e5124: aa1603e2    	mov	x2, x22
1057e5128: 94910805    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e512c: 36000060    	tbz	w0, #0x0, 0x1057e5138 <_Flutter_MMFoundation_BindContext+0x1cc0d1c>
1057e5130: 52800014    	mov	w20, #0x0               ; =0
1057e5134: 1400002c    	b	0x1057e51e4 <_Flutter_MMFoundation_BindContext+0x1cc0dc8>
1057e5138: f9400317    	ldr	x23, [x24]
1057e513c: aa1303e0    	mov	x0, x19
1057e5140: aa1503e1    	mov	x1, x21
1057e5144: 949107fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5148: aa1d03fd    	mov	x29, x29
1057e514c: 949107ff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e5150: aa0003f8    	mov	x24, x0
1057e5154: f00d32a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057e5158: f944e101    	ldr	x1, [x8, #0x9c0] ; IsOpenIMChatRoom:
1057e515c: aa1703e0    	mov	x0, x23
1057e5160: aa1803e2    	mov	x2, x24
1057e5164: 949107f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5168: aa0003f7    	mov	x23, x0
1057e516c: aa1803e0    	mov	x0, x24
1057e5170: 949107f9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e5174: aa1603e0    	mov	x0, x22
1057e5178: 949107f7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e517c: 3707f497    	tbnz	w23, #0x0, 0x1057e500c <_Flutter_MMFoundation_BindContext+0x1cc0bf0>
1057e5180: 900d3e68    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e5184: f942d901    	ldr	x1, [x8, #0x5b0] ; m_ignoredContacts
1057e5188: aa1403e0    	mov	x0, x20
1057e518c: 949107ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e5190: aa1d03fd    	mov	x29, x29
1057e5194: 949107ed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e5198: aa0003f6    	mov	x22, x0
1057e519c: aa1303e0    	mov	x0, x19
1057e51a0: aa1503e1    	mov	x1, x21
1057e51a4: 949107e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e51a8: aa1d03fd    	mov	x29, x29
1057e51ac: 949107e7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e51b0: aa0003f5    	mov	x21, x0
1057e51b4: f00d48e8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1057e51b8: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
1057e51bc: aa1603e0    	mov	x0, x22
1057e51c0: aa1503e2    	mov	x2, x21
1057e51c4: 949107de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e51c8: aa1d03fd    	mov	x29, x29
1057e51cc: 949107df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057e51d0: f100001f    	cmp	x0, #0x0
1057e51d4: 1a9f17f4    	cset	w20, eq
1057e51d8: 949107df    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e51dc: aa1503e0    	mov	x0, x21
1057e51e0: 949107dd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e51e4: aa1603e0    	mov	x0, x22
1057e51e8: 949107db    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057e51ec: 17ffff89    	b	0x1057e5010 <_Flutter_MMFoundation_BindContext+0x1cc0bf4>
