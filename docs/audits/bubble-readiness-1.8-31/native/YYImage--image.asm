
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bda00: d10103ff    	sub	sp, sp, #0x40
10a9bda04: a90157f6    	stp	x22, x21, [sp, #0x10]
10a9bda08: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a9bda0c: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a9bda10: 9100c3fd    	add	x29, sp, #0x30
10a9bda14: aa0003f4    	mov	x20, x0
10a9bda18: d00b14a8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a9bda1c: 52800029    	mov	w9, #0x1                ; =1
10a9bda20: 3913f509    	strb	w9, [x8, #0x4fd]
10a9bda24: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bda28: b98ea108    	ldrsw	x8, [x8, #0xea0]
10a9bda2c: f8686801    	ldr	x1, [x0, x8]
10a9bda30: 910023e0    	add	x0, sp, #0x8
10a9bda34: 9400130d    	bl	0x10a9c2668 <_Flutter_MMFoundation_BindContext+0x6e9e24c>
10a9bda38: f00aa4c8    	adrp	x8, 0x11fe58000 <dyld_stub_binder+0x11fe58000>
10a9bda3c: f940cd01    	ldr	x1, [x8, #0x198] ; originImage
10a9bda40: aa1403e0    	mov	x0, x20
10a9bda44: 953a7680    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bda48: aa1d03fd    	mov	x29, x29
10a9bda4c: 953a7681    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bda50: aa0003f3    	mov	x19, x0
10a9bda54: d00aba28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a9bda58: f9438501    	ldr	x1, [x8, #0x708] ; isDarkMode
10a9bda5c: aa1403e0    	mov	x0, x20
10a9bda60: 953a7679    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bda64: 340001c0    	cbz	w0, 0x10a9bda9c <_Flutter_MMFoundation_BindContext+0x6e99680>
10a9bda68: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bda6c: f945f115    	ldr	x21, [x8, #0xbe0] ; decodeImageDM
10a9bda70: aa1403e0    	mov	x0, x20
10a9bda74: aa1503e1    	mov	x1, x21
10a9bda78: 953a7673    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bda7c: aa1d03fd    	mov	x29, x29
10a9bda80: 953a7674    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bda84: aa0003f6    	mov	x22, x0
10a9bda88: 953a7675    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bda8c: b50001d6    	cbnz	x22, 0x10a9bdac4 <_Flutter_MMFoundation_BindContext+0x6e996a8>
10a9bda90: f00aa6e8    	adrp	x8, 0x11fe9c000 <dyld_stub_binder+0x11fe9c000>
10a9bda94: f941e501    	ldr	x1, [x8, #0x3c8] ; imageInDarkMode
10a9bda98: 14000010    	b	0x10a9bdad8 <_Flutter_MMFoundation_BindContext+0x6e996bc>
10a9bda9c: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdaa0: f945f515    	ldr	x21, [x8, #0xbe8] ; decodeImageLM
10a9bdaa4: aa1403e0    	mov	x0, x20
10a9bdaa8: aa1503e1    	mov	x1, x21
10a9bdaac: 953a7666    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdab0: aa1d03fd    	mov	x29, x29
10a9bdab4: 953a7667    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdab8: aa0003f6    	mov	x22, x0
10a9bdabc: 953a7668    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bdac0: b4000096    	cbz	x22, 0x10a9bdad0 <_Flutter_MMFoundation_BindContext+0x6e996b4>
10a9bdac4: aa1403e0    	mov	x0, x20
10a9bdac8: aa1503e1    	mov	x1, x21
10a9bdacc: 14000004    	b	0x10a9bdadc <_Flutter_MMFoundation_BindContext+0x6e996c0>
10a9bdad0: f00aa6e8    	adrp	x8, 0x11fe9c000 <dyld_stub_binder+0x11fe9c000>
10a9bdad4: f941dd01    	ldr	x1, [x8, #0x3b8] ; imageInLightMode
10a9bdad8: aa1303e0    	mov	x0, x19
10a9bdadc: 953a765a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdae0: aa1d03fd    	mov	x29, x29
10a9bdae4: 953a765b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdae8: aa0003f4    	mov	x20, x0
10a9bdaec: aa1303e0    	mov	x0, x19
10a9bdaf0: 953a765b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bdaf4: 910023e0    	add	x0, sp, #0x8
10a9bdaf8: 940012f2    	bl	0x10a9c26c0 <_Flutter_MMFoundation_BindContext+0x6e9e2a4>
10a9bdafc: aa1403e0    	mov	x0, x20
10a9bdb00: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a9bdb04: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a9bdb08: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a9bdb0c: 910103ff    	add	sp, sp, #0x40
10a9bdb10: 153a765a    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>