
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a94fd34: d10183ff    	sub	sp, sp, #0x60
10a94fd38: a90167fa    	stp	x26, x25, [sp, #0x10]
10a94fd3c: a9025ff8    	stp	x24, x23, [sp, #0x20]
10a94fd40: a90357f6    	stp	x22, x21, [sp, #0x30]
10a94fd44: a9044ff4    	stp	x20, x19, [sp, #0x40]
10a94fd48: a9057bfd    	stp	x29, x30, [sp, #0x50]
10a94fd4c: 910143fd    	add	x29, sp, #0x50
10a94fd50: aa0003f3    	mov	x19, x0
10a94fd54: 900b1828    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a94fd58: 52800029    	mov	w9, #0x1                ; =1
10a94fd5c: 390be109    	strb	w9, [x8, #0x2f8]
10a94fd60: b00aa768    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a94fd64: f940c114    	ldr	x20, [x8, #0x180] ; isInMyContactList
10a94fd68: aa1403e1    	mov	x1, x20
10a94fd6c: 953c2db6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fd70: 370007c0    	tbnz	w0, #0x0, 0x10a94fe68 <_Flutter_MMFoundation_BindContext+0x6e2ba4c>
10a94fd74: 900ac968    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a94fd78: b986d517    	ldrsw	x23, [x8, #0x6d4] ; ivar WeixinContactInfoAssist.m_chatContact
10a94fd7c: f8776a60    	ldr	x0, [x19, x23]
10a94fd80: 900aa768    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a94fd84: f947d101    	ldr	x1, [x8, #0xfa0] ; isChatroom
10a94fd88: 953c2daf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fd8c: 340006e0    	cbz	w0, 0x10a94fe68 <_Flutter_MMFoundation_BindContext+0x6e2ba4c>
10a94fd90: 900ac128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a94fd94: f945e900    	ldr	x0, [x8, #0xbd0]
10a94fd98: b00abd88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a94fd9c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a94fda0: 953c2da9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fda4: aa1d03fd    	mov	x29, x29
10a94fda8: 953c2daa    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94fdac: aa0003f5    	mov	x21, x0
10a94fdb0: 900ac128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a94fdb4: f947dd00    	ldr	x0, [x8, #0xfb8]
10a94fdb8: 900abd88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a94fdbc: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a94fdc0: 953c2da1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fdc4: aa0003e2    	mov	x2, x0
10a94fdc8: d00aa748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a94fdcc: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a94fdd0: aa1503e0    	mov	x0, x21
10a94fdd4: 953c2d9c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fdd8: aa1d03fd    	mov	x29, x29
10a94fddc: 953c2d9d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94fde0: aa0003f6    	mov	x22, x0
10a94fde4: f8776a60    	ldr	x0, [x19, x23]
10a94fde8: 900aa768    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a94fdec: f9434d17    	ldr	x23, [x8, #0x698] ; m_nsUsrName
10a94fdf0: aa1703e1    	mov	x1, x23
10a94fdf4: 953c2d94    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fdf8: aa1d03fd    	mov	x29, x29
10a94fdfc: 953c2d95    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94fe00: aa0003f8    	mov	x24, x0
10a94fe04: 900ac488    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a94fe08: 91093108    	add	x8, x8, #0x24c
10a94fe0c: b9800108    	ldrsw	x8, [x8]
10a94fe10: f8686a60    	ldr	x0, [x19, x8]
10a94fe14: aa1703e1    	mov	x1, x23
10a94fe18: 953c2d8b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fe1c: aa1d03fd    	mov	x29, x29
10a94fe20: 953c2d8c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94fe24: aa0003f7    	mov	x23, x0
10a94fe28: 900aa7e8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
10a94fe2c: f9407901    	ldr	x1, [x8, #0xf0] ; IsUsrInChatRoom:Usr:
10a94fe30: aa1603e0    	mov	x0, x22
10a94fe34: aa1803e2    	mov	x2, x24
10a94fe38: aa1703e3    	mov	x3, x23
10a94fe3c: 953c2d82    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fe40: aa0003f9    	mov	x25, x0
10a94fe44: aa1703e0    	mov	x0, x23
10a94fe48: 953c2d85    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94fe4c: aa1803e0    	mov	x0, x24
10a94fe50: 953c2d83    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94fe54: aa1603e0    	mov	x0, x22
10a94fe58: 953c2d81    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94fe5c: aa1503e0    	mov	x0, x21
10a94fe60: 953c2d7f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94fe64: 360004d9    	tbz	w25, #0x0, 0x10a94fefc <_Flutter_MMFoundation_BindContext+0x6e2bae0>
10a94fe68: f00aab28    	adrp	x8, 0x11feb6000 <dyld_stub_binder+0x11feb6000>
10a94fe6c: f9462101    	ldr	x1, [x8, #0xc40] ; m_bDisableAllOperation
10a94fe70: aa1303e0    	mov	x0, x19
10a94fe74: 953c2d74    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fe78: 37000620    	tbnz	w0, #0x0, 0x10a94ff3c <_Flutter_MMFoundation_BindContext+0x6e2bb20>
10a94fe7c: 900ac488    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a94fe80: 91093108    	add	x8, x8, #0x24c
10a94fe84: b9800117    	ldrsw	x23, [x8]
10a94fe88: f8776a60    	ldr	x0, [x19, x23]
10a94fe8c: f00aa828    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
10a94fe90: f942c501    	ldr	x1, [x8, #0x588] ; isAccountDeleted
10a94fe94: 953c2d6c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fe98: 37000520    	tbnz	w0, #0x0, 0x10a94ff3c <_Flutter_MMFoundation_BindContext+0x6e2bb20>
10a94fe9c: f8776a60    	ldr	x0, [x19, x23]
10a94fea0: 900aa768    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a94fea4: f9470901    	ldr	x1, [x8, #0xe10] ; isSelf
10a94fea8: 953c2d67    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94feac: 37000480    	tbnz	w0, #0x0, 0x10a94ff3c <_Flutter_MMFoundation_BindContext+0x6e2bb20>
10a94feb0: aa1303e0    	mov	x0, x19
10a94feb4: aa1403e1    	mov	x1, x20
10a94feb8: 953c2d63    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94febc: 37000400    	tbnz	w0, #0x0, 0x10a94ff3c <_Flutter_MMFoundation_BindContext+0x6e2bb20>
10a94fec0: b00aa9c8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10a94fec4: f9445501    	ldr	x1, [x8, #0x8a8] ; isNeedVerify
10a94fec8: aa1303e0    	mov	x0, x19
10a94fecc: 953c2d5e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fed0: 34000440    	cbz	w0, 0x10a94ff58 <_Flutter_MMFoundation_BindContext+0x6e2bb3c>
10a94fed4: 900ab288    	adrp	x8, 0x11ff9f000 <dyld_stub_binder+0x11ff9f000>
10a94fed8: f9407101    	ldr	x1, [x8, #0xe0] ; initBlackAndExposeContactBtn
10a94fedc: aa1303e0    	mov	x0, x19
10a94fee0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10a94fee4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10a94fee8: a94357f6    	ldp	x22, x21, [sp, #0x30]
10a94feec: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10a94fef0: a94167fa    	ldp	x26, x25, [sp, #0x10]
10a94fef4: 910183ff    	add	sp, sp, #0x60
10a94fef8: 153c2d53    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fefc: 900ac128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a94ff00: f9453500    	ldr	x0, [x8, #0xa68]
10a94ff04: d00aa748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a94ff08: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a94ff0c: d009f488    	adrp	x8, 0x11e7e1000 <dyld_stub_binder+0x11e7e1000>
10a94ff10: 91102108    	add	x8, x8, #0x408
10a94ff14: f90003e8    	str	x8, [sp]
10a94ff18: b008a325    	adrp	x5, 0x11bdb4000 <dyld_stub_binder+0x11bdb4000>
10a94ff1c: 9133cca5    	add	x5, x5, #0xcf3
10a94ff20: b008a327    	adrp	x7, 0x11bdb4000 <dyld_stub_binder+0x11bdb4000>
10a94ff24: 913d28e7    	add	x7, x7, #0xf4a
10a94ff28: 52800042    	mov	w2, #0x2                ; =2
10a94ff2c: d2800003    	mov	x3, #0x0                ; =0
10a94ff30: 52800004    	mov	w4, #0x0                ; =0
10a94ff34: 52816786    	mov	w6, #0xb3c              ; =2876
10a94ff38: 953c2d43    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ff3c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10a94ff40: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10a94ff44: a94357f6    	ldp	x22, x21, [sp, #0x30]
10a94ff48: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10a94ff4c: a94167fa    	ldp	x26, x25, [sp, #0x10]
10a94ff50: 910183ff    	add	sp, sp, #0x60
10a94ff54: d65f03c0    	ret
10a94ff58: 900ac488    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a94ff5c: 91096108    	add	x8, x8, #0x258
10a94ff60: b9800118    	ldrsw	x24, [x8]
10a94ff64: 8b180260    	add	x0, x19, x24
10a94ff68: 953c2d4b    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a94ff6c: aa0003f5    	mov	x21, x0
10a94ff70: f00aa7c8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
10a94ff74: f9410514    	ldr	x20, [x8, #0x208] ; GetFromScene
10a94ff78: aa1403e1    	mov	x1, x20
10a94ff7c: 953c2d32    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ff80: aa0003f6    	mov	x22, x0
10a94ff84: aa1503e0    	mov	x0, x21
10a94ff88: 953c2d35    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94ff8c: 710006df    	cmp	w22, #0x1
10a94ff90: 54fffd60    	b.eq	0x10a94ff3c <_Flutter_MMFoundation_BindContext+0x6e2bb20>
10a94ff94: f00ab268    	adrp	x8, 0x11ff9e000 <dyld_stub_binder+0x11ff9e000>
10a94ff98: f946d101    	ldr	x1, [x8, #0xda0] ; isFromStrangeScene
10a94ff9c: aa1303e0    	mov	x0, x19
10a94ffa0: 953c2d29    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ffa4: 340001e0    	cbz	w0, 0x10a94ffe0 <_Flutter_MMFoundation_BindContext+0x6e2bbc4>
10a94ffa8: f8776a60    	ldr	x0, [x19, x23]
10a94ffac: d00aa768    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a94ffb0: f9406d01    	ldr	x1, [x8, #0xd8] ; realFriendScene
10a94ffb4: 953c2d24    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ffb8: 7100781f    	cmp	w0, #0x1e
10a94ffbc: 540000c1    	b.ne	0x10a94ffd4 <_Flutter_MMFoundation_BindContext+0x6e2bbb8>
10a94ffc0: f8776a60    	ldr	x0, [x19, x23]
10a94ffc4: 900aa7e8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
10a94ffc8: f9414101    	ldr	x1, [x8, #0x280] ; isBlack
10a94ffcc: 953c2d1e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ffd0: 34fffb60    	cbz	w0, 0x10a94ff3c <_Flutter_MMFoundation_BindContext+0x6e2bb20>
10a94ffd4: 900ab288    	adrp	x8, 0x11ff9f000 <dyld_stub_binder+0x11ff9f000>
10a94ffd8: f9406d01    	ldr	x1, [x8, #0xd8] ; initExposeBtn
10a94ffdc: 17ffffc0    	b	0x10a94fedc <_Flutter_MMFoundation_BindContext+0x6e2bac0>
10a94ffe0: 8b180260    	add	x0, x19, x24
10a94ffe4: 953c2d2c    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a94ffe8: aa0003f5    	mov	x21, x0
10a94ffec: aa1403e1    	mov	x1, x20
10a94fff0: 953c2d15    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94fff4: 71003c1f    	cmp	w0, #0xf
10a94fff8: 54000081    	b.ne	0x10a950008 <_Flutter_MMFoundation_BindContext+0x6e2bbec>
10a94fffc: aa1503e0    	mov	x0, x21
10a950000: 953c2d17    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a950004: 17ffffb4    	b	0x10a94fed4 <_Flutter_MMFoundation_BindContext+0x6e2bab8>
10a950008: 8b180260    	add	x0, x19, x24
10a95000c: 953c2d22    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a950010: aa0003f6    	mov	x22, x0
10a950014: aa1403e1    	mov	x1, x20
10a950018: 953c2d0b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95001c: aa0003f4    	mov	x20, x0
10a950020: aa1603e0    	mov	x0, x22
10a950024: 953c2d0e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a950028: aa1503e0    	mov	x0, x21
10a95002c: 953c2d0c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a950030: 71002e9f    	cmp	w20, #0xb
10a950034: 54fff500    	b.eq	0x10a94fed4 <_Flutter_MMFoundation_BindContext+0x6e2bab8>
10a950038: 17ffffc1    	b	0x10a94ff3c <_Flutter_MMFoundation_BindContext+0x6e2bb20>
