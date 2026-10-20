
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c7fd6c: d10243ff    	sub	sp, sp, #0x90
105c7fd70: a90467fa    	stp	x26, x25, [sp, #0x40]
105c7fd74: a9055ff8    	stp	x24, x23, [sp, #0x50]
105c7fd78: a90657f6    	stp	x22, x21, [sp, #0x60]
105c7fd7c: a9074ff4    	stp	x20, x19, [sp, #0x70]
105c7fd80: a9087bfd    	stp	x29, x30, [sp, #0x80]
105c7fd84: 910203fd    	add	x29, sp, #0x80
105c7fd88: aa0303f4    	mov	x20, x3
105c7fd8c: aa0203f3    	mov	x19, x2
105c7fd90: aa0003f5    	mov	x21, x0
105c7fd94: f00d7e08    	adrp	x8, 0x120c42000 <dyld_stub_binder+0x120c42000>
105c7fd98: 52800029    	mov	w9, #0x1                ; =1
105c7fd9c: 39179509    	strb	w9, [x8, #0x5e5]
105c7fda0: aa0203e0    	mov	x0, x2
105c7fda4: 947e9ce5    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105c7fda8: 900d2448    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105c7fdac: f944cd01    	ldr	x1, [x8, #0x998] ; setDataSource:
105c7fdb0: aa1303e0    	mov	x0, x19
105c7fdb4: aa1503e2    	mov	x2, x21
105c7fdb8: 947e9ce1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fdbc: 900d0f48    	adrp	x8, 0x11fe67000 <dyld_stub_binder+0x11fe67000>
105c7fdc0: f9438501    	ldr	x1, [x8, #0x708] ; usernameList
105c7fdc4: aa1503e0    	mov	x0, x21
105c7fdc8: 947e9cdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fdcc: aa1d03fd    	mov	x29, x29
105c7fdd0: 947e9cde    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7fdd4: aa0003f6    	mov	x22, x0
105c7fdd8: f00d0dc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105c7fddc: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
105c7fde0: aa1403e2    	mov	x2, x20
105c7fde4: 947e9cd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fde8: aa1d03fd    	mov	x29, x29
105c7fdec: 947e9cd7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7fdf0: aa0003f4    	mov	x20, x0
105c7fdf4: aa1603e0    	mov	x0, x22
105c7fdf8: 947e9cd7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7fdfc: b00d1a08    	adrp	x8, 0x11ffc0000 <dyld_stub_binder+0x11ffc0000>
105c7fe00: f9409d01    	ldr	x1, [x8, #0x138] ; usernameToTextStateListDict
105c7fe04: aa1503e0    	mov	x0, x21
105c7fe08: 947e9ccd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fe0c: aa1d03fd    	mov	x29, x29
105c7fe10: 947e9cce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7fe14: aa0003f7    	mov	x23, x0
105c7fe18: b00d2428    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
105c7fe1c: f947f901    	ldr	x1, [x8, #0xff0] ; objectForKeyedSubscript:
105c7fe20: aa1403e2    	mov	x2, x20
105c7fe24: 947e9cc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fe28: aa1d03fd    	mov	x29, x29
105c7fe2c: 947e9cc7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7fe30: aa0003f6    	mov	x22, x0
105c7fe34: aa1703e0    	mov	x0, x23
105c7fe38: 947e9cc7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7fe3c: f00d19e8    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105c7fe40: f9467101    	ldr	x1, [x8, #0xce0] ; setStartPosition:
105c7fe44: aa1303e0    	mov	x0, x19
105c7fe48: d2800002    	mov	x2, #0x0                ; =0
105c7fe4c: 947e9cbc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fe50: 900d1808    	adrp	x8, 0x11ff7f000 <dyld_stub_binder+0x11ff7f000>
105c7fe54: f941c101    	ldr	x1, [x8, #0x380] ; setInfoList:
105c7fe58: aa1303e0    	mov	x0, x19
105c7fe5c: aa1603e2    	mov	x2, x22
105c7fe60: 947e9cb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fe64: 900d0e48    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
105c7fe68: f946f917    	ldr	x23, [x8, #0xdf0] ; headerView
105c7fe6c: aa1303e0    	mov	x0, x19
105c7fe70: aa1703e1    	mov	x1, x23
105c7fe74: 947e9cb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fe78: aa1d03fd    	mov	x29, x29
105c7fe7c: 947e9cb3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7fe80: aa0003f8    	mov	x24, x0
105c7fe84: d00d2448    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
105c7fe88: f947b501    	ldr	x1, [x8, #0xf68] ; setType:
105c7fe8c: 52800022    	mov	w2, #0x1                ; =1
105c7fe90: 947e9cab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fe94: aa1803e0    	mov	x0, x24
105c7fe98: 947e9caf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7fe9c: d00d2408    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
105c7fea0: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
105c7fea4: aa1603e0    	mov	x0, x22
105c7fea8: 947e9ca5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7feac: aa1d03fd    	mov	x29, x29
105c7feb0: 947e9ca6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7feb4: aa0003f8    	mov	x24, x0
105c7feb8: aa1303e0    	mov	x0, x19
105c7febc: aa1703e1    	mov	x1, x23
105c7fec0: 947e9c9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fec4: aa1d03fd    	mov	x29, x29
105c7fec8: 947e9ca0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7fecc: aa0003f9    	mov	x25, x0
105c7fed0: b00d1868    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
105c7fed4: f9478101    	ldr	x1, [x8, #0xf00] ; setTextState:
105c7fed8: aa1803e2    	mov	x2, x24
105c7fedc: 947e9c98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fee0: aa1903e0    	mov	x0, x25
105c7fee4: 947e9c9c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7fee8: aa1803e0    	mov	x0, x24
105c7feec: 947e9c9a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7fef0: aa1303e0    	mov	x0, x19
105c7fef4: aa1703e1    	mov	x1, x23
105c7fef8: 947e9c91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fefc: aa1d03fd    	mov	x29, x29
105c7ff00: 947e9c92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7ff04: aa0003f8    	mov	x24, x0
105c7ff08: f00d1228    	adrp	x8, 0x11fec6000 <dyld_stub_binder+0x11fec6000>
105c7ff0c: f9474501    	ldr	x1, [x8, #0xe88] ; setInsets:
105c7ff10: d2e80a08    	mov	x8, #0x4050000000000000 ; =4634204016564240384
105c7ff14: 9e670103    	fmov	d3, x8
105c7ff18: 9e6703e0    	fmov	d0, xzr
105c7ff1c: 1e671001    	fmov	d1, #24.00000000
105c7ff20: 9e6703e2    	fmov	d2, xzr
105c7ff24: 947e9c86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7ff28: aa1803e0    	mov	x0, x24
105c7ff2c: 947e9c8a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7ff30: 900d1888    	adrp	x8, 0x11ff8f000 <dyld_stub_binder+0x11ff8f000>
105c7ff34: f9434501    	ldr	x1, [x8, #0x688] ; activeCardView
105c7ff38: aa1303e0    	mov	x0, x19
105c7ff3c: 947e9c80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7ff40: aa1d03fd    	mov	x29, x29
105c7ff44: 947e9c81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7ff48: aa0003f8    	mov	x24, x0
105c7ff4c: f00d1028    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
105c7ff50: f9462901    	ldr	x1, [x8, #0xc50] ; textState
105c7ff54: 947e9c7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7ff58: aa1d03fd    	mov	x29, x29
105c7ff5c: 947e9c7b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7ff60: aa0003f9    	mov	x25, x0
105c7ff64: b00d1a08    	adrp	x8, 0x11ffc0000 <dyld_stub_binder+0x11ffc0000>
105c7ff68: f9411d01    	ldr	x1, [x8, #0x238] ; isMyCurrentStatus
105c7ff6c: 947e9c74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7ff70: aa0003fa    	mov	x26, x0
105c7ff74: aa1903e0    	mov	x0, x25
105c7ff78: 947e9c77    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7ff7c: aa1803e0    	mov	x0, x24
105c7ff80: 947e9c75    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7ff84: 340004da    	cbz	w26, 0x105c8001c <_Flutter_MMFoundation_BindContext+0x215bc00>
105c7ff88: 9100e3e0    	add	x0, sp, #0x38
105c7ff8c: aa1303e1    	mov	x1, x19
105c7ff90: 947e9c77    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
105c7ff94: aa1303e0    	mov	x0, x19
105c7ff98: aa1703e1    	mov	x1, x23
105c7ff9c: 947e9c68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7ffa0: aa1d03fd    	mov	x29, x29
105c7ffa4: 947e9c69    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7ffa8: aa0003f7    	mov	x23, x0
105c7ffac: f00bcb68    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
105c7ffb0: f947e108    	ldr	x8, [x8, #0xfc0]
105c7ffb4: f90007e8    	str	x8, [sp, #0x8]
105c7ffb8: d0098808    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
105c7ffbc: fd41c100    	ldr	d0, [x8, #0x380]
105c7ffc0: b0000008    	adrp	x8, 0x105c80000 <_Flutter_MMFoundation_BindContext+0x215bbe4>
105c7ffc4: 9101f108    	add	x8, x8, #0x7c
105c7ffc8: fd000be0    	str	d0, [sp, #0x10]
105c7ffcc: f00bcfc9    	adrp	x9, 0x11d67a000 <dyld_stub_binder+0x11d67a000>
105c7ffd0: 913a0129    	add	x9, x9, #0xe80
105c7ffd4: a901a7e8    	stp	x8, x9, [sp, #0x18]
105c7ffd8: 910023f8    	add	x24, sp, #0x8
105c7ffdc: 9100a300    	add	x0, x24, #0x28
105c7ffe0: 9100e3e1    	add	x1, sp, #0x38
105c7ffe4: 947e9c65    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
105c7ffe8: f90017f5    	str	x21, [sp, #0x28]
105c7ffec: b00d1a08    	adrp	x8, 0x11ffc0000 <dyld_stub_binder+0x11ffc0000>
105c7fff0: f9412901    	ldr	x1, [x8, #0x250] ; addMoreButtonWithHandler:
105c7fff4: 910023e2    	add	x2, sp, #0x8
105c7fff8: aa1703e0    	mov	x0, x23
105c7fffc: 947e9c50    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c80000: aa1703e0    	mov	x0, x23
105c80004: 947e9c54    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c80008: 9100a300    	add	x0, x24, #0x28
105c8000c: 947e9c61    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
105c80010: 9100e3e0    	add	x0, sp, #0x38
105c80014: 947e9c5f    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
105c80018: 1400000c    	b	0x105c80048 <_Flutter_MMFoundation_BindContext+0x215bc2c>
105c8001c: aa1303e0    	mov	x0, x19
105c80020: aa1703e1    	mov	x1, x23
105c80024: 947e9c46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c80028: aa1d03fd    	mov	x29, x29
105c8002c: 947e9c47    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c80030: aa0003f5    	mov	x21, x0
105c80034: 900d1a08    	adrp	x8, 0x11ffc0000 <dyld_stub_binder+0x11ffc0000>
105c80038: f9412d01    	ldr	x1, [x8, #0x258] ; removeMoreButton
105c8003c: 947e9c40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c80040: aa1503e0    	mov	x0, x21
105c80044: 947e9c44    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c80048: aa1603e0    	mov	x0, x22
105c8004c: 947e9c42    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c80050: aa1403e0    	mov	x0, x20
105c80054: 947e9c40    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c80058: aa1303e0    	mov	x0, x19
105c8005c: 947e9c3e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c80060: a9487bfd    	ldp	x29, x30, [sp, #0x80]
105c80064: a9474ff4    	ldp	x20, x19, [sp, #0x70]
105c80068: a94657f6    	ldp	x22, x21, [sp, #0x60]
105c8006c: a9455ff8    	ldp	x24, x23, [sp, #0x50]
105c80070: a94467fa    	ldp	x26, x25, [sp, #0x40]
105c80074: 910243ff    	add	sp, sp, #0x90
105c80078: d65f03c0    	ret
