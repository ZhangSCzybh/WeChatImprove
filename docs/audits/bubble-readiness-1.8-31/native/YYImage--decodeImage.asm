
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bdc18: d10183ff    	sub	sp, sp, #0x60
10a9bdc1c: a90167fa    	stp	x26, x25, [sp, #0x10]
10a9bdc20: a9025ff8    	stp	x24, x23, [sp, #0x20]
10a9bdc24: a90357f6    	stp	x22, x21, [sp, #0x30]
10a9bdc28: a9044ff4    	stp	x20, x19, [sp, #0x40]
10a9bdc2c: a9057bfd    	stp	x29, x30, [sp, #0x50]
10a9bdc30: 910143fd    	add	x29, sp, #0x50
10a9bdc34: aa0003f3    	mov	x19, x0
10a9bdc38: d00b14a8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a9bdc3c: 52800029    	mov	w9, #0x1                ; =1
10a9bdc40: 3913fd09    	strb	w9, [x8, #0x4ff]
10a9bdc44: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bdc48: b98ea108    	ldrsw	x8, [x8, #0xea0]
10a9bdc4c: f8686801    	ldr	x1, [x0, x8]
10a9bdc50: 910023e0    	add	x0, sp, #0x8
10a9bdc54: 94001285    	bl	0x10a9c2668 <_Flutter_MMFoundation_BindContext+0x6e9e24c>
10a9bdc58: d00aba28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a9bdc5c: f9438501    	ldr	x1, [x8, #0x708] ; isDarkMode
10a9bdc60: aa1303e0    	mov	x0, x19
10a9bdc64: 953a75f8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdc68: aa0003f5    	mov	x21, x0
10a9bdc6c: f00aa4c8    	adrp	x8, 0x11fe58000 <dyld_stub_binder+0x11fe58000>
10a9bdc70: f940cd01    	ldr	x1, [x8, #0x198] ; originImage
10a9bdc74: aa1303e0    	mov	x0, x19
10a9bdc78: 953a75f3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdc7c: aa1d03fd    	mov	x29, x29
10a9bdc80: 953a75f4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdc84: aa0003f4    	mov	x20, x0
10a9bdc88: 900ab7b8    	adrp	x24, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdc8c: 34000255    	cbz	w21, 0x10a9bdcd4 <_Flutter_MMFoundation_BindContext+0x6e998b8>
10a9bdc90: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdc94: f945f115    	ldr	x21, [x8, #0xbe0] ; decodeImageDM
10a9bdc98: aa1303e0    	mov	x0, x19
10a9bdc9c: aa1503e1    	mov	x1, x21
10a9bdca0: 953a75e9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdca4: aa1d03fd    	mov	x29, x29
10a9bdca8: 953a75ea    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdcac: aa0003f6    	mov	x22, x0
10a9bdcb0: 953a75eb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bdcb4: b50006d6    	cbnz	x22, 0x10a9bdd8c <_Flutter_MMFoundation_BindContext+0x6e99970>
10a9bdcb8: 900ab7b9    	adrp	x25, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdcbc: 91304339    	add	x25, x25, #0xc10
10a9bdcc0: b00968d6    	adrp	x22, 0x11d6d6000 <dyld_stub_binder+0x11d6d6000>
10a9bdcc4: 911062d6    	add	x22, x22, #0x418
10a9bdcc8: f00aa6f7    	adrp	x23, 0x11fe9c000 <dyld_stub_binder+0x11fe9c000>
10a9bdccc: 910f22f7    	add	x23, x23, #0x3c8
10a9bdcd0: 14000010    	b	0x10a9bdd10 <_Flutter_MMFoundation_BindContext+0x6e998f4>
10a9bdcd4: f945f715    	ldr	x21, [x24, #0xbe8] ; decodeImageLM
10a9bdcd8: aa1303e0    	mov	x0, x19
10a9bdcdc: aa1503e1    	mov	x1, x21
10a9bdce0: 953a75d9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdce4: aa1d03fd    	mov	x29, x29
10a9bdce8: 953a75da    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdcec: aa0003f6    	mov	x22, x0
10a9bdcf0: 953a75db    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bdcf4: b50004d6    	cbnz	x22, 0x10a9bdd8c <_Flutter_MMFoundation_BindContext+0x6e99970>
10a9bdcf8: 900ab7b9    	adrp	x25, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdcfc: 91306339    	add	x25, x25, #0xc18
10a9bdd00: b00968d6    	adrp	x22, 0x11d6d6000 <dyld_stub_binder+0x11d6d6000>
10a9bdd04: 9110e2d6    	add	x22, x22, #0x438
10a9bdd08: f00aa6f7    	adrp	x23, 0x11fe9c000 <dyld_stub_binder+0x11fe9c000>
10a9bdd0c: 910ee2f7    	add	x23, x23, #0x3b8
10a9bdd10: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdd14: f945fd01    	ldr	x1, [x8, #0xbf8] ; _cancelAsyncLoad
10a9bdd18: aa1303e0    	mov	x0, x19
10a9bdd1c: 953a75ca    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdd20: f94002e1    	ldr	x1, [x23]
10a9bdd24: aa1403e0    	mov	x0, x20
10a9bdd28: 953a75c7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdd2c: aa1d03fd    	mov	x29, x29
10a9bdd30: 953a75c8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdd34: aa0003f7    	mov	x23, x0
10a9bdd38: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdd3c: f9460101    	ldr	x1, [x8, #0xc00] ; prefertSize
10a9bdd40: aa1303e0    	mov	x0, x19
10a9bdd44: 953a75c0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdd48: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdd4c: f9460501    	ldr	x1, [x8, #0xc08] ; _fourceDecodeImage:prefertSize:isCancelled:
10a9bdd50: aa1303e0    	mov	x0, x19
10a9bdd54: aa1703e2    	mov	x2, x23
10a9bdd58: aa1603e3    	mov	x3, x22
10a9bdd5c: 953a75ba    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdd60: aa1d03fd    	mov	x29, x29
10a9bdd64: 953a75bb    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdd68: aa0003f6    	mov	x22, x0
10a9bdd6c: f9400321    	ldr	x1, [x25]
10a9bdd70: aa1303e0    	mov	x0, x19
10a9bdd74: aa1603e2    	mov	x2, x22
10a9bdd78: 953a75b3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdd7c: aa1603e0    	mov	x0, x22
10a9bdd80: 953a75b7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bdd84: aa1703e0    	mov	x0, x23
10a9bdd88: 953a75b5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bdd8c: aa1303e0    	mov	x0, x19
10a9bdd90: aa1503e1    	mov	x1, x21
10a9bdd94: 953a75ac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdd98: aa1d03fd    	mov	x29, x29
10a9bdd9c: 953a75ad    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdda0: aa0003f5    	mov	x21, x0
10a9bdda4: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdda8: f945e901    	ldr	x1, [x8, #0xbd0] ; isDynamicImg
10a9bddac: aa1303e0    	mov	x0, x19
10a9bddb0: 953a75a5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bddb4: aa0003f7    	mov	x23, x0
10a9bddb8: f945f701    	ldr	x1, [x24, #0xbe8] ; decodeImageLM
10a9bddbc: aa1303e0    	mov	x0, x19
10a9bddc0: 953a75a1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bddc4: aa1d03fd    	mov	x29, x29
10a9bddc8: 953a75a2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bddcc: aa0003f6    	mov	x22, x0
10a9bddd0: 340001d7    	cbz	w23, 0x10a9bde08 <_Flutter_MMFoundation_BindContext+0x6e999ec>
10a9bddd4: b40002b6    	cbz	x22, 0x10a9bde28 <_Flutter_MMFoundation_BindContext+0x6e99a0c>
10a9bddd8: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdddc: f945f101    	ldr	x1, [x8, #0xbe0] ; decodeImageDM
10a9bdde0: aa1303e0    	mov	x0, x19
10a9bdde4: 953a7598    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdde8: aa1d03fd    	mov	x29, x29
10a9bddec: 953a7599    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bddf0: aa0003f7    	mov	x23, x0
10a9bddf4: 953a759a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bddf8: aa1603e0    	mov	x0, x22
10a9bddfc: 953a7598    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bde00: b50000b7    	cbnz	x23, 0x10a9bde14 <_Flutter_MMFoundation_BindContext+0x6e999f8>
10a9bde04: 14000009    	b	0x10a9bde28 <_Flutter_MMFoundation_BindContext+0x6e99a0c>
10a9bde08: aa1603e0    	mov	x0, x22
10a9bde0c: 953a7594    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bde10: b40000d6    	cbz	x22, 0x10a9bde28 <_Flutter_MMFoundation_BindContext+0x6e99a0c>
10a9bde14: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bde18: b98ea908    	ldrsw	x8, [x8, #0xea8]
10a9bde1c: f8686a60    	ldr	x0, [x19, x8]
10a9bde20: f8286a7f    	str	xzr, [x19, x8]
10a9bde24: 953a758e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bde28: aa1403e0    	mov	x0, x20
10a9bde2c: 953a758c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bde30: 910023e0    	add	x0, sp, #0x8
10a9bde34: 94001223    	bl	0x10a9c26c0 <_Flutter_MMFoundation_BindContext+0x6e9e2a4>
10a9bde38: aa1503e0    	mov	x0, x21
10a9bde3c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10a9bde40: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10a9bde44: a94357f6    	ldp	x22, x21, [sp, #0x30]
10a9bde48: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10a9bde4c: a94167fa    	ldp	x26, x25, [sp, #0x10]
10a9bde50: 910183ff    	add	sp, sp, #0x60
10a9bde54: 153a7589    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>