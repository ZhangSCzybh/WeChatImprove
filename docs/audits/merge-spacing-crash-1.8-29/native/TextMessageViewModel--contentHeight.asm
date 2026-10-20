
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c0c4ec: d10243ff    	sub	sp, sp, #0x90
105c0c4f0: 6d012beb    	stp	d11, d10, [sp, #0x10]
105c0c4f4: 6d0223e9    	stp	d9, d8, [sp, #0x20]
105c0c4f8: a9036ffc    	stp	x28, x27, [sp, #0x30]
105c0c4fc: a90467fa    	stp	x26, x25, [sp, #0x40]
105c0c500: a9055ff8    	stp	x24, x23, [sp, #0x50]
105c0c504: a90657f6    	stp	x22, x21, [sp, #0x60]
105c0c508: a9074ff4    	stp	x20, x19, [sp, #0x70]
105c0c50c: a9087bfd    	stp	x29, x30, [sp, #0x80]
105c0c510: 910203fd    	add	x29, sp, #0x80
105c0c514: aa0003f3    	mov	x19, x0
105c0c518: d00d81a8    	adrp	x8, 0x120c42000 <dyld_stub_binder+0x120c42000>
105c0c51c: 52800029    	mov	w9, #0x1                ; =1
105c0c520: 390fd109    	strb	w9, [x8, #0x3f4]
105c0c524: b00d1388    	adrp	x8, 0x11fe7d000 <dyld_stub_binder+0x11fe7d000>
105c0c528: f9401d01    	ldr	x1, [x8, #0x38] ; contentTextSize
105c0c52c: 94806b04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c530: 1e604028    	fmov	d8, d1
105c0c534: f00d1208    	adrp	x8, 0x11fe4f000 <dyld_stub_binder+0x11fe4f000>
105c0c538: f9459d01    	ldr	x1, [x8, #0xb38] ; isHeadPart
105c0c53c: aa1303e0    	mov	x0, x19
105c0c540: 94806aff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c544: 9e6703e9    	fmov	d9, xzr
105c0c548: 900d2b5c    	adrp	x28, 0x120174000 <dyld_stub_binder+0x120174000>
105c0c54c: f00d2b35    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
105c0c550: 900d27b6    	adrp	x22, 0x120100000 <dyld_stub_binder+0x120100000>
105c0c554: 900d2b57    	adrp	x23, 0x120174000 <dyld_stub_binder+0x120174000>
105c0c558: f00d2799    	adrp	x25, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105c0c55c: b00d117b    	adrp	x27, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105c0c560: f00d1178    	adrp	x24, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105c0c564: 34000620    	cbz	w0, 0x105c0c628 <_Flutter_MMFoundation_BindContext+0x20e820c>
105c0c568: f9403f94    	ldr	x20, [x28, #0x78] ; 8�6 
105c0c56c: f945eaa0    	ldr	x0, [x21, #0xbd0] ; ��d 
105c0c570: f944eac1    	ldr	x1, [x22, #0x9d0] ; currentContext
105c0c574: 94806af2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c578: aa1d03fd    	mov	x29, x29
105c0c57c: 94806af3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c580: aa0003f5    	mov	x21, x0
105c0c584: f94042e0    	ldr	x0, [x23, #0x80]
105c0c588: f947af21    	ldr	x1, [x25, #0xf58] ; class
105c0c58c: 94806aec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c590: aa0003e2    	mov	x2, x0
105c0c594: f9464361    	ldr	x1, [x27, #0xc80] ; getService:
105c0c598: aa1503e0    	mov	x0, x21
105c0c59c: 94806ae8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c5a0: aa1d03fd    	mov	x29, x29
105c0c5a4: 94806ae9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c5a8: aa0003f6    	mov	x22, x0
105c0c5ac: f947ff01    	ldr	x1, [x24, #0xff8] ; getValueOfProperty:inRuleSet:
105c0c5b0: b00c44e2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
105c0c5b4: 912ca042    	add	x2, x2, #0xb28
105c0c5b8: d00c44c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
105c0c5bc: 9124a063    	add	x3, x3, #0x928
105c0c5c0: 94806adf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c5c4: aa1d03fd    	mov	x29, x29
105c0c5c8: 94806ae0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c5cc: aa1903fa    	mov	x26, x25
105c0c5d0: aa1b03f9    	mov	x25, x27
105c0c5d4: aa1803fb    	mov	x27, x24
105c0c5d8: aa1703f8    	mov	x24, x23
105c0c5dc: aa0003f7    	mov	x23, x0
105c0c5e0: 900d1188    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105c0c5e4: f9400101    	ldr	x1, [x8]
105c0c5e8: aa1403e0    	mov	x0, x20
105c0c5ec: aa1703e2    	mov	x2, x23
105c0c5f0: 94806ad3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c5f4: 1e604009    	fmov	d9, d0
105c0c5f8: aa1703e0    	mov	x0, x23
105c0c5fc: aa1803f7    	mov	x23, x24
105c0c600: aa1b03f8    	mov	x24, x27
105c0c604: aa1903fb    	mov	x27, x25
105c0c608: aa1a03f9    	mov	x25, x26
105c0c60c: 94806ad2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c610: aa1603e0    	mov	x0, x22
105c0c614: 900d27b6    	adrp	x22, 0x120100000 <dyld_stub_binder+0x120100000>
105c0c618: 94806acf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c61c: aa1503e0    	mov	x0, x21
105c0c620: f00d2b35    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
105c0c624: 94806acc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c628: 1e692908    	fadd	d8, d8, d9
105c0c62c: f00d1188    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105c0c630: f9415d01    	ldr	x1, [x8, #0x2b8] ; isTailPart
105c0c634: aa1303e0    	mov	x0, x19
105c0c638: 94806ac1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c63c: 34002240    	cbz	w0, 0x105c0ca84 <_Flutter_MMFoundation_BindContext+0x20e8668>
105c0c640: f9403f94    	ldr	x20, [x28, #0x78] ; 8�6 
105c0c644: f945eaa0    	ldr	x0, [x21, #0xbd0] ; ��d 
105c0c648: f944ead6    	ldr	x22, [x22, #0x9d0] ; currentContext
105c0c64c: aa1603e1    	mov	x1, x22
105c0c650: 94806abb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c654: aa1d03fd    	mov	x29, x29
105c0c658: 94806abc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c65c: aa0003fa    	mov	x26, x0
105c0c660: f94042e0    	ldr	x0, [x23, #0x80]
105c0c664: f947af35    	ldr	x21, [x25, #0xf58] ; class
105c0c668: aa1503e1    	mov	x1, x21
105c0c66c: 94806ab4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c670: aa0003e2    	mov	x2, x0
105c0c674: f9464377    	ldr	x23, [x27, #0xc80] ; getService:
105c0c678: aa1a03e0    	mov	x0, x26
105c0c67c: aa1703e1    	mov	x1, x23
105c0c680: 94806aaf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c684: aa1d03fd    	mov	x29, x29
105c0c688: 94806ab0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c68c: aa0003fb    	mov	x27, x0
105c0c690: f947ff19    	ldr	x25, [x24, #0xff8] ; getValueOfProperty:inRuleSet:
105c0c694: b00c44e2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
105c0c698: 912ca042    	add	x2, x2, #0xb28
105c0c69c: d00c44c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
105c0c6a0: 9124a063    	add	x3, x3, #0x928
105c0c6a4: aa1903e1    	mov	x1, x25
105c0c6a8: 94806aa5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c6ac: aa1d03fd    	mov	x29, x29
105c0c6b0: 94806aa6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c6b4: aa0003fc    	mov	x28, x0
105c0c6b8: 900d1188    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105c0c6bc: f9400118    	ldr	x24, [x8]
105c0c6c0: aa1403e0    	mov	x0, x20
105c0c6c4: aa1803e1    	mov	x1, x24
105c0c6c8: aa1c03e2    	mov	x2, x28
105c0c6cc: 94806a9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c6d0: 1e602908    	fadd	d8, d8, d0
105c0c6d4: aa1c03e0    	mov	x0, x28
105c0c6d8: 94806a9f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c6dc: aa1b03e0    	mov	x0, x27
105c0c6e0: 94806a9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c6e4: aa1a03e0    	mov	x0, x26
105c0c6e8: 94806a9b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c6ec: b00d1d88    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
105c0c6f0: f9478d01    	ldr	x1, [x8, #0xf18] ; canShowTranslateView
105c0c6f4: aa1303e0    	mov	x0, x19
105c0c6f8: 94806a91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c6fc: 34001940    	cbz	w0, 0x105c0ca24 <_Flutter_MMFoundation_BindContext+0x20e8608>
105c0c700: b00d1d88    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
105c0c704: f9479101    	ldr	x1, [x8, #0xf20] ; canShowTranslatedText
105c0c708: aa1303e0    	mov	x0, x19
105c0c70c: 94806a8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c710: 34001180    	cbz	w0, 0x105c0c940 <_Flutter_MMFoundation_BindContext+0x20e8524>
105c0c714: f90007f9    	str	x25, [sp, #0x8]
105c0c718: d00d1528    	adrp	x8, 0x11feb2000 <dyld_stub_binder+0x11feb2000>
105c0c71c: f942c901    	ldr	x1, [x8, #0x590] ; translateInfo
105c0c720: aa1303e0    	mov	x0, x19
105c0c724: 94806a86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c728: aa1d03fd    	mov	x29, x29
105c0c72c: 94806a87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c730: aa0003f9    	mov	x25, x0
105c0c734: f00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0c738: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
105c0c73c: aa1603e1    	mov	x1, x22
105c0c740: 94806a7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c744: aa1d03fd    	mov	x29, x29
105c0c748: 94806a80    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c74c: aa0003fb    	mov	x27, x0
105c0c750: f00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0c754: f9462900    	ldr	x0, [x8, #0xc50]
105c0c758: aa1503e1    	mov	x1, x21
105c0c75c: 94806a78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c760: aa0003e2    	mov	x2, x0
105c0c764: aa1b03e0    	mov	x0, x27
105c0c768: aa1703e1    	mov	x1, x23
105c0c76c: 94806a74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c770: aa1d03fd    	mov	x29, x29
105c0c774: 94806a75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c778: aa0003fc    	mov	x28, x0
105c0c77c: b00d1168    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105c0c780: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
105c0c784: b00c4ce2    	adrp	x2, 0x11e5a9000 <dyld_stub_binder+0x11e5a9000>
105c0c788: 910ba042    	add	x2, x2, #0x2e8
105c0c78c: 94806a6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c790: aa1d03fd    	mov	x29, x29
105c0c794: 94806a6d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c798: aa0003fa    	mov	x26, x0
105c0c79c: aa1c03e0    	mov	x0, x28
105c0c7a0: 94806a6d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c7a4: aa1b03e0    	mov	x0, x27
105c0c7a8: 94806a6b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c7ac: d00d1528    	adrp	x8, 0x11feb2000 <dyld_stub_binder+0x11feb2000>
105c0c7b0: f942cd1b    	ldr	x27, [x8, #0x598] ; brandWording
105c0c7b4: aa1903e0    	mov	x0, x25
105c0c7b8: aa1b03e1    	mov	x1, x27
105c0c7bc: 94806a60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c7c0: aa1d03fd    	mov	x29, x29
105c0c7c4: 94806a61    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c7c8: aa0003fc    	mov	x28, x0
105c0c7cc: f00d27a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105c0c7d0: f946e901    	ldr	x1, [x8, #0xdd0] ; length
105c0c7d4: 94806a5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c7d8: aa0003f4    	mov	x20, x0
105c0c7dc: aa1c03e0    	mov	x0, x28
105c0c7e0: 94806a5d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c7e4: b4000154    	cbz	x20, 0x105c0c80c <_Flutter_MMFoundation_BindContext+0x20e83f0>
105c0c7e8: aa1903e0    	mov	x0, x25
105c0c7ec: aa1b03e1    	mov	x1, x27
105c0c7f0: 94806a53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c7f4: aa1d03fd    	mov	x29, x29
105c0c7f8: 94806a54    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c7fc: aa0003f4    	mov	x20, x0
105c0c800: aa1a03e0    	mov	x0, x26
105c0c804: 94806a54    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c808: aa1403fa    	mov	x26, x20
105c0c80c: aa1903fc    	mov	x28, x25
105c0c810: b00d1d88    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
105c0c814: f947d901    	ldr	x1, [x8, #0xfb0] ; translatedTextSize
105c0c818: aa1303e0    	mov	x0, x19
105c0c81c: 94806a48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c820: 1e604029    	fmov	d9, d1
105c0c824: 900d2b48    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105c0c828: f9404914    	ldr	x20, [x8, #0x90] ; ��c 
105c0c82c: f00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0c830: f9470100    	ldr	x0, [x8, #0xe00] ; �*c 
105c0c834: 900d1188    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105c0c838: f9419101    	ldr	x1, [x8, #0x320] ; pageScopeWidthFor:
105c0c83c: aa1303e2    	mov	x2, x19
105c0c840: 94806a3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c844: 1e60400a    	fmov	d10, d0
105c0c848: f00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0c84c: f9461900    	ldr	x0, [x8, #0xc30]
105c0c850: d00d27e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105c0c854: f9479101    	ldr	x1, [x8, #0xf20] ; systemFontOfSize:
105c0c858: 1e64d000    	fmov	d0, #11.00000000
105c0c85c: 94806a38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c860: aa1d03fd    	mov	x29, x29
105c0c864: 94806a39    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c868: aa0003fb    	mov	x27, x0
105c0c86c: 900d1188    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105c0c870: f9404901    	ldr	x1, [x8, #0x90] ; labelHeight:maxWidth:font:
105c0c874: aa1403e0    	mov	x0, x20
105c0c878: aa1a03e2    	mov	x2, x26
105c0c87c: 1e604140    	fmov	d0, d10
105c0c880: aa1b03e3    	mov	x3, x27
105c0c884: 94806a2e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c888: 1e60400a    	fmov	d10, d0
105c0c88c: aa1b03e0    	mov	x0, x27
105c0c890: 94806a31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c894: 900d2b48    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105c0c898: f9403d14    	ldr	x20, [x8, #0x78] ; 8�6 
105c0c89c: f00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0c8a0: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
105c0c8a4: aa1603e1    	mov	x1, x22
105c0c8a8: 94806a25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c8ac: aa1d03fd    	mov	x29, x29
105c0c8b0: 94806a26    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c8b4: aa0003f9    	mov	x25, x0
105c0c8b8: 900d2b48    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105c0c8bc: f9404100    	ldr	x0, [x8, #0x80]
105c0c8c0: aa1503e1    	mov	x1, x21
105c0c8c4: 94806a1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c8c8: aa0003e2    	mov	x2, x0
105c0c8cc: aa1903e0    	mov	x0, x25
105c0c8d0: aa1703e1    	mov	x1, x23
105c0c8d4: 94806a1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c8d8: aa1d03fd    	mov	x29, x29
105c0c8dc: 94806a1b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c8e0: aa0003f7    	mov	x23, x0
105c0c8e4: b00c44e2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
105c0c8e8: 912ca042    	add	x2, x2, #0xb28
105c0c8ec: d00c44c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
105c0c8f0: 9124a063    	add	x3, x3, #0x928
105c0c8f4: f94007e1    	ldr	x1, [sp, #0x8]
105c0c8f8: 94806a11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c8fc: aa1d03fd    	mov	x29, x29
105c0c900: 94806a12    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c904: aa0003f6    	mov	x22, x0
105c0c908: aa1403e0    	mov	x0, x20
105c0c90c: aa1803e1    	mov	x1, x24
105c0c910: aa1603e2    	mov	x2, x22
105c0c914: 94806a0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c918: 1e601001    	fmov	d1, #2.00000000
105c0c91c: 1f412400    	fmadd	d0, d0, d1, d9
105c0c920: 1e631001    	fmov	d1, #6.00000000
105c0c924: 1e612800    	fadd	d0, d0, d1
105c0c928: 1e602940    	fadd	d0, d10, d0
105c0c92c: 1e621001    	fmov	d1, #4.00000000
105c0c930: 1e612809    	fadd	d9, d0, d1
105c0c934: aa1603e0    	mov	x0, x22
105c0c938: 94806a07    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0c93c: 14000031    	b	0x105c0ca00 <_Flutter_MMFoundation_BindContext+0x20e85e4>
105c0c940: 900d2b48    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105c0c944: f9403d14    	ldr	x20, [x8, #0x78] ; 8�6 
105c0c948: f00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0c94c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
105c0c950: aa1603e1    	mov	x1, x22
105c0c954: 948069fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c958: aa1d03fd    	mov	x29, x29
105c0c95c: 948069fb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c960: aa0003fc    	mov	x28, x0
105c0c964: 900d2b48    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105c0c968: f9404100    	ldr	x0, [x8, #0x80]
105c0c96c: aa1503e1    	mov	x1, x21
105c0c970: 948069f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c974: aa0003e2    	mov	x2, x0
105c0c978: aa1c03e0    	mov	x0, x28
105c0c97c: aa1703e1    	mov	x1, x23
105c0c980: 948069ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c984: aa1d03fd    	mov	x29, x29
105c0c988: 948069f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c98c: aa0003fa    	mov	x26, x0
105c0c990: b00c44e2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
105c0c994: 912ca042    	add	x2, x2, #0xb28
105c0c998: d00c44c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
105c0c99c: 9124a063    	add	x3, x3, #0x928
105c0c9a0: aa1903e1    	mov	x1, x25
105c0c9a4: 948069e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c9a8: aa1d03fd    	mov	x29, x29
105c0c9ac: 948069e7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c9b0: aa0003f9    	mov	x25, x0
105c0c9b4: aa1403e0    	mov	x0, x20
105c0c9b8: aa1803e1    	mov	x1, x24
105c0c9bc: aa1903e2    	mov	x2, x25
105c0c9c0: 948069df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c9c4: 1e604009    	fmov	d9, d0
105c0c9c8: f00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0c9cc: f9461900    	ldr	x0, [x8, #0xc30]
105c0c9d0: b00d1188    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
105c0c9d4: f9473101    	ldr	x1, [x8, #0xe60] ; systemFont
105c0c9d8: 948069d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c9dc: aa1d03fd    	mov	x29, x29
105c0c9e0: 948069da    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0c9e4: aa0003f7    	mov	x23, x0
105c0c9e8: f00d1168    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105c0c9ec: f947ed01    	ldr	x1, [x8, #0xfd8] ; lineHeight
105c0c9f0: 948069d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c9f4: 1e64c000    	frintp	d0, d0
105c0c9f8: 1e601001    	fmov	d1, #2.00000000
105c0c9fc: 1f410129    	fmadd	d9, d9, d1, d0
105c0ca00: 1e692908    	fadd	d8, d8, d9
105c0ca04: aa1703e0    	mov	x0, x23
105c0ca08: 948069d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0ca0c: aa1903e0    	mov	x0, x25
105c0ca10: 948069d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0ca14: aa1a03e0    	mov	x0, x26
105c0ca18: 948069cf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0ca1c: aa1c03e0    	mov	x0, x28
105c0ca20: 948069cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0ca24: b00d1d88    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
105c0ca28: f947ad01    	ldr	x1, [x8, #0xf58] ; canShowAutoTransButton
105c0ca2c: aa1303e0    	mov	x0, x19
105c0ca30: 948069c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ca34: 34000100    	cbz	w0, 0x105c0ca54 <_Flutter_MMFoundation_BindContext+0x20e8638>
105c0ca38: d00d1d88    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105c0ca3c: f9403501    	ldr	x1, [x8, #0x68] ; autoTransHeight
105c0ca40: aa1303e0    	mov	x0, x19
105c0ca44: 948069be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ca48: 1e621001    	fmov	d1, #4.00000000
105c0ca4c: 1e612800    	fadd	d0, d0, d1
105c0ca50: 1e602908    	fadd	d8, d8, d0
105c0ca54: b00d1d88    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
105c0ca58: f947b901    	ldr	x1, [x8, #0xf70] ; canShowAIReply
105c0ca5c: aa1303e0    	mov	x0, x19
105c0ca60: 948069b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ca64: 34000100    	cbz	w0, 0x105c0ca84 <_Flutter_MMFoundation_BindContext+0x20e8668>
105c0ca68: d00d1d88    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105c0ca6c: f9417501    	ldr	x1, [x8, #0x2e8] ; sourceFromHeight
105c0ca70: aa1303e0    	mov	x0, x19
105c0ca74: 948069b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ca78: 1e62d001    	fmov	d1, #5.50000000
105c0ca7c: 1e612800    	fadd	d0, d0, d1
105c0ca80: 1e602908    	fadd	d8, d8, d0
105c0ca84: 1e604100    	fmov	d0, d8
105c0ca88: a9487bfd    	ldp	x29, x30, [sp, #0x80]
105c0ca8c: a9474ff4    	ldp	x20, x19, [sp, #0x70]
105c0ca90: a94657f6    	ldp	x22, x21, [sp, #0x60]
105c0ca94: a9455ff8    	ldp	x24, x23, [sp, #0x50]
105c0ca98: a94467fa    	ldp	x26, x25, [sp, #0x40]
105c0ca9c: a9436ffc    	ldp	x28, x27, [sp, #0x30]
105c0caa0: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
105c0caa4: 6d412beb    	ldp	d11, d10, [sp, #0x10]
105c0caa8: 910243ff    	add	sp, sp, #0x90
105c0caac: d65f03c0    	ret