
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e87648: 6db82beb    	stp	d11, d10, [sp, #-0x80]!
106e8764c: 6d0123e9    	stp	d9, d8, [sp, #0x10]
106e87650: a9026ffc    	stp	x28, x27, [sp, #0x20]
106e87654: a90367fa    	stp	x26, x25, [sp, #0x30]
106e87658: a9045ff8    	stp	x24, x23, [sp, #0x40]
106e8765c: a90557f6    	stp	x22, x21, [sp, #0x50]
106e87660: a9064ff4    	stp	x20, x19, [sp, #0x60]
106e87664: a9077bfd    	stp	x29, x30, [sp, #0x70]
106e87668: 9101c3fd    	add	x29, sp, #0x70
106e8766c: d10743ff    	sub	sp, sp, #0x1d0
106e87670: aa0003f7    	mov	x23, x0
106e87674: 900b3b48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106e87678: f9405908    	ldr	x8, [x8, #0xb0]
106e8767c: f9400108    	ldr	x8, [x8]
106e87680: f81803a8    	stur	x8, [x29, #-0x80]
106e87684: f00cede8    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106e87688: 52800029    	mov	w9, #0x1                ; =1
106e8768c: 391a6509    	strb	w9, [x8, #0x699]
106e87690: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e87694: f9422901    	ldr	x1, [x8, #0x450] ; canShowSourceLabel
106e87698: 94367ea9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8769c: aa0003f4    	mov	x20, x0
106e876a0: d00c7dc8    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
106e876a4: f9414d01    	ldr	x1, [x8, #0x298] ; sourceLabel
106e876a8: aa1703e0    	mov	x0, x23
106e876ac: 94367ea4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e876b0: aa1d03fd    	mov	x29, x29
106e876b4: 94367ea5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e876b8: aa0003f5    	mov	x21, x0
106e876bc: b00c9408    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106e876c0: f9411113    	ldr	x19, [x8, #0x220] ; setHidden:
106e876c4: 52000282    	eor	w2, w20, #0x1
106e876c8: aa1303e1    	mov	x1, x19
106e876cc: 94367e9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e876d0: aa1503e0    	mov	x0, x21
106e876d4: 94367ea0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e876d8: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e876dc: f9422d01    	ldr	x1, [x8, #0x458] ; canShowWeAppView
106e876e0: aa1703e0    	mov	x0, x23
106e876e4: 94367e96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e876e8: aa0003f4    	mov	x20, x0
106e876ec: f00c8aa8    	adrp	x8, 0x11ffde000 <dyld_stub_binder+0x11ffde000>
106e876f0: f9445101    	ldr	x1, [x8, #0x8a0] ; weAppView
106e876f4: aa1703e0    	mov	x0, x23
106e876f8: 94367e91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e876fc: aa1d03fd    	mov	x29, x29
106e87700: 94367e92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87704: aa0003f5    	mov	x21, x0
106e87708: 52000282    	eor	w2, w20, #0x1
106e8770c: aa1303e1    	mov	x1, x19
106e87710: 94367e8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87714: aa1503e0    	mov	x0, x21
106e87718: 94367e8f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8771c: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e87720: f9423101    	ldr	x1, [x8, #0x460] ; canShowLocationLabel
106e87724: aa1703e0    	mov	x0, x23
106e87728: 94367e85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8772c: aa0003f4    	mov	x20, x0
106e87730: 900c7f48    	adrp	x8, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
106e87734: f9415501    	ldr	x1, [x8, #0x2a8] ; locationLabel
106e87738: aa1703e0    	mov	x0, x23
106e8773c: 94367e80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87740: aa1d03fd    	mov	x29, x29
106e87744: 94367e81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87748: aa0003f5    	mov	x21, x0
106e8774c: 52000282    	eor	w2, w20, #0x1
106e87750: aa1303e1    	mov	x1, x19
106e87754: 94367e7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87758: aa1503e0    	mov	x0, x21
106e8775c: 94367e7e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87760: 900c98a8    	adrp	x8, 0x12019b000 <dyld_stub_binder+0x12019b000>
106e87764: f940d100    	ldr	x0, [x8, #0x1a0]
106e87768: 94367e7e    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106e8776c: aa0003f3    	mov	x19, x0
106e87770: d00c7da8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
106e87774: f943c101    	ldr	x1, [x8, #0x780] ; dataItem
106e87778: aa1703e0    	mov	x0, x23
106e8777c: 94367e70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87780: aa1d03fd    	mov	x29, x29
106e87784: 94367e71    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87788: aa0003f4    	mov	x20, x0
106e8778c: b00c8b68    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
106e87790: f9426501    	ldr	x1, [x8, #0x4c8] ; actionAreaWrapEnabled
106e87794: aa1703e0    	mov	x0, x23
106e87798: 94367e69    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8779c: aa0003f5    	mov	x21, x0
106e877a0: b00c8b68    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
106e877a4: f9426901    	ldr	x1, [x8, #0x4d0] ; dynamicTagEnabled
106e877a8: aa1703e0    	mov	x0, x23
106e877ac: 94367e64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e877b0: aa0003f6    	mov	x22, x0
106e877b4: b00c8b68    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
106e877b8: f9426d01    	ldr	x1, [x8, #0x4d8] ; isStarBrowsingEnabled
106e877bc: aa1703e0    	mov	x0, x23
106e877c0: 94367e5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e877c4: aa0003f9    	mov	x25, x0
106e877c8: d00c8ae8    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
106e877cc: f9426d01    	ldr	x1, [x8, #0x4d8] ; pageContext
106e877d0: aa1703e0    	mov	x0, x23
106e877d4: 94367e5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e877d8: aa1d03fd    	mov	x29, x29
106e877dc: 94367e5b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e877e0: aa0003f8    	mov	x24, x0
106e877e4: b00c8b68    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
106e877e8: f9427101    	ldr	x1, [x8, #0x4e0] ; initWithDataItem:enabledWrap:scene:isDynamicTagEnabled:isStarEnabled:pageContext:
106e877ec: aa1303e0    	mov	x0, x19
106e877f0: aa1403e2    	mov	x2, x20
106e877f4: aa1503e3    	mov	x3, x21
106e877f8: 52800024    	mov	w4, #0x1                ; =1
106e877fc: aa1603e5    	mov	x5, x22
106e87800: aa1903e6    	mov	x6, x25
106e87804: aa1803e7    	mov	x7, x24
106e87808: 94367e4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8780c: aa0003fa    	mov	x26, x0
106e87810: aa1803e0    	mov	x0, x24
106e87814: 94367e50    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87818: aa1403e0    	mov	x0, x20
106e8781c: 94367e4e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87820: d00c98a8    	adrp	x8, 0x12019d000 <dyld_stub_binder+0x12019d000>
106e87824: f9448100    	ldr	x0, [x8, #0x900]
106e87828: 94367e4c    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
106e8782c: aa0003f8    	mov	x24, x0
106e87830: 900c977b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
106e87834: f9461b74    	ldr	x20, [x27, #0xc30]
106e87838: b00c9768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e8783c: f9403d15    	ldr	x21, [x8, #0x78]
106e87840: 900c9768    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e87844: f945e900    	ldr	x0, [x8, #0xbd0]
106e87848: b00c93c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e8784c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106e87850: f90033e1    	str	x1, [sp, #0x60]
106e87854: 94367e3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87858: aa1d03fd    	mov	x29, x29
106e8785c: 94367e3b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87860: aa0003f3    	mov	x19, x0
106e87864: b00c9768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e87868: f9404100    	ldr	x0, [x8, #0x80]
106e8786c: 900c93c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e87870: f947ad01    	ldr	x1, [x8, #0xf58] ; class
106e87874: f9002fe1    	str	x1, [sp, #0x58]
106e87878: 94367e31    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8787c: aa0003e2    	mov	x2, x0
106e87880: d00c7d88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e87884: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106e87888: aa1303e0    	mov	x0, x19
106e8788c: f9002be1    	str	x1, [sp, #0x50]
106e87890: 94367e2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87894: aa1d03fd    	mov	x29, x29
106e87898: 94367e2c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8789c: aa0003f6    	mov	x22, x0
106e878a0: 900c7da8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106e878a4: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
106e878a8: d00bb402    	adrp	x2, 0x11e509000 <dyld_stub_binder+0x11e509000>
106e878ac: 9101a042    	add	x2, x2, #0x68
106e878b0: d00bb403    	adrp	x3, 0x11e509000 <dyld_stub_binder+0x11e509000>
106e878b4: 91002063    	add	x3, x3, #0x8
106e878b8: f90027e1    	str	x1, [sp, #0x48]
106e878bc: 94367e20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e878c0: aa1d03fd    	mov	x29, x29
106e878c4: 94367e21    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e878c8: aa0003f9    	mov	x25, x0
106e878cc: b00c7da8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e878d0: f9400101    	ldr	x1, [x8]
106e878d4: aa1503e0    	mov	x0, x21
106e878d8: f90023e1    	str	x1, [sp, #0x40]
106e878dc: aa1903e2    	mov	x2, x25
106e878e0: 94367e17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e878e4: 900c7f08    	adrp	x8, 0x11fe67000 <dyld_stub_binder+0x11fe67000>
106e878e8: f9400901    	ldr	x1, [x8, #0x10] ; dynamicSystemFontOfSize:forModule:
106e878ec: aa1403e0    	mov	x0, x20
106e878f0: 52800022    	mov	w2, #0x1                ; =1
106e878f4: 94367e12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e878f8: aa1d03fd    	mov	x29, x29
106e878fc: 94367e13    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87900: aa0003f4    	mov	x20, x0
106e87904: 900c7e88    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
106e87908: f9458901    	ldr	x1, [x8, #0xb10] ; setTitleFont:
106e8790c: aa1803e0    	mov	x0, x24
106e87910: aa1403e2    	mov	x2, x20
106e87914: 94367e0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87918: aa1403e0    	mov	x0, x20
106e8791c: 94367e0e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87920: aa1903e0    	mov	x0, x25
106e87924: 94367e0c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87928: aa1603e0    	mov	x0, x22
106e8792c: 94367e0a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87930: aa1303e0    	mov	x0, x19
106e87934: 94367e08    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87938: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8793c: f9432501    	ldr	x1, [x8, #0x648] ; maxActionAreaWidth
106e87940: aa1703e0    	mov	x0, x23
106e87944: 94367dfe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87948: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8794c: f9432901    	ldr	x1, [x8, #0x650] ; setActionAreaWidth:
106e87950: aa1803e0    	mov	x0, x24
106e87954: 94367dfa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87958: f9461b60    	ldr	x0, [x27, #0xc30]
106e8795c: 900c82c8    	adrp	x8, 0x11fedf000 <dyld_stub_binder+0x11fedf000>
106e87960: f944cd13    	ldr	x19, [x8, #0x998] ; dynamicLength:forModule:
106e87964: 1e661000    	fmov	d0, #16.00000000
106e87968: aa1303e1    	mov	x1, x19
106e8796c: 52800022    	mov	w2, #0x1                ; =1
106e87970: 94367df3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87974: 1e604008    	fmov	d8, d0
106e87978: f9461b60    	ldr	x0, [x27, #0xc30]
106e8797c: 1e661000    	fmov	d0, #16.00000000
106e87980: f9001ff3    	str	x19, [sp, #0x38]
106e87984: aa1303e1    	mov	x1, x19
106e87988: 52800022    	mov	w2, #0x1                ; =1
106e8798c: 94367dec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87990: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e87994: f9432d01    	ldr	x1, [x8, #0x658] ; setIconViewLen:
106e87998: aa1803e0    	mov	x0, x24
106e8799c: 1e604100    	fmov	d0, d8
106e879a0: 94367de7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e879a4: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e879a8: f9433101    	ldr	x1, [x8, #0x660] ; setElementSpacing:
106e879ac: 1e64100a    	fmov	d10, #8.00000000
106e879b0: 1e641000    	fmov	d0, #8.00000000
106e879b4: aa1803e0    	mov	x0, x24
106e879b8: 94367de1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e879bc: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e879c0: f9433501    	ldr	x1, [x8, #0x668] ; calculateLayoutInfoWithParams:
106e879c4: aa1a03e0    	mov	x0, x26
106e879c8: f90007f8    	str	x24, [sp, #0x8]
106e879cc: aa1803e2    	mov	x2, x24
106e879d0: 94367ddb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e879d4: d00c8ae8    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
106e879d8: f9421d01    	ldr	x1, [x8, #0x438] ; layoutInfoMap
106e879dc: f9000bfa    	str	x26, [sp, #0x10]
106e879e0: aa1a03e0    	mov	x0, x26
106e879e4: 94367dd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e879e8: aa1d03fd    	mov	x29, x29
106e879ec: 94367dd7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e879f0: aa0003f8    	mov	x24, x0
106e879f4: d00c9de8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e879f8: b9851113    	ldrsw	x19, [x8, #0x510]
106e879fc: f8736ae0    	ldr	x0, [x23, x19]
106e87a00: b00c9428    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
106e87a04: f9402101    	ldr	x1, [x8, #0x40] ; x
106e87a08: f9001be1    	str	x1, [sp, #0x30]
106e87a0c: 94367dcc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87a10: 1e604009    	fmov	d9, d0
106e87a14: f90037f3    	str	x19, [sp, #0x68]
106e87a18: f8736ae0    	ldr	x0, [x23, x19]
106e87a1c: b00c7da8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e87a20: f9432501    	ldr	x1, [x8, #0x648] ; centerY
106e87a24: f90003e1    	str	x1, [sp]
106e87a28: 94367dc5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87a2c: 1e604008    	fmov	d8, d0
106e87a30: 4f00e400    	movi.16b	v0, #0x0
106e87a34: ad0803e0    	stp	q0, q0, [sp, #0x100]
106e87a38: ad0903e0    	stp	q0, q0, [sp, #0x120]
106e87a3c: b00c7e48    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
106e87a40: f9400901    	ldr	x1, [x8, #0x10] ; allKeysInOrder
106e87a44: aa1803e0    	mov	x0, x24
106e87a48: 94367dbd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87a4c: aa1d03fd    	mov	x29, x29
106e87a50: 94367dbe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87a54: b00c93c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e87a58: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
106e87a5c: 910403e2    	add	x2, sp, #0x100
106e87a60: d10403a3    	sub	x3, x29, #0x100
106e87a64: f90047e0    	str	x0, [sp, #0x88]
106e87a68: f9000fe1    	str	x1, [sp, #0x18]
106e87a6c: 52800204    	mov	w4, #0x10               ; =16
106e87a70: 94367db3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87a74: b4001aa0    	cbz	x0, 0x106e87dc8 <_Flutter_MMFoundation_BindContext+0x33639ac>
106e87a78: aa0003fc    	mov	x28, x0
106e87a7c: d280001b    	mov	x27, #0x0               ; =0
106e87a80: f9408be8    	ldr	x8, [sp, #0x110]
106e87a84: f9400108    	ldr	x8, [x8]
106e87a88: f90063e8    	str	x8, [sp, #0xc0]
106e87a8c: 1e6e100b    	fmov	d11, #1.00000000
106e87a90: a9025ff8    	stp	x24, x23, [sp, #0x20]
106e87a94: d2800016    	mov	x22, #0x0               ; =0
106e87a98: 900c9428    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106e87a9c: f9424d19    	ldr	x25, [x8, #0x498] ; unsignedIntegerValue
106e87aa0: b00c93e8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106e87aa4: f947f109    	ldr	x9, [x8, #0xfe0] ; objectForKey:
106e87aa8: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e87aac: f943391a    	ldr	x26, [x8, #0x670] ; actionAreaSubViewWithType:
106e87ab0: d00c8ae8    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
106e87ab4: f9420508    	ldr	x8, [x8, #0x408] ; displayLine
106e87ab8: a90f27e8    	stp	x8, x9, [sp, #0xf0]
106e87abc: d00c8ae8    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
106e87ac0: f941fd09    	ldr	x9, [x8, #0x3f8] ; adjustedWidth
106e87ac4: f00c9408    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106e87ac8: f9418d08    	ldr	x8, [x8, #0x318] ; setWidth:
106e87acc: a90e27e8    	stp	x8, x9, [sp, #0xe0]
106e87ad0: b00c7da8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e87ad4: f9432109    	ldr	x9, [x8, #0x640] ; setLeft:
106e87ad8: b00c7da8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e87adc: f9401908    	ldr	x8, [x8, #0x30] ; setCenterY:
106e87ae0: a90d27e8    	stp	x8, x9, [sp, #0xd0]
106e87ae4: b00c7da8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e87ae8: f9431d08    	ldr	x8, [x8, #0x638] ; right
106e87aec: f90067e8    	str	x8, [sp, #0xc8]
106e87af0: a907e7fa    	stp	x26, x25, [sp, #0x78]
106e87af4: f9003bfc    	str	x28, [sp, #0x70]
106e87af8: f9408be8    	ldr	x8, [sp, #0x110]
106e87afc: f9400108    	ldr	x8, [x8]
106e87b00: f94063e9    	ldr	x9, [sp, #0xc0]
106e87b04: eb09011f    	cmp	x8, x9
106e87b08: 54000060    	b.eq	0x106e87b14 <_Flutter_MMFoundation_BindContext+0x33636f8>
106e87b0c: f94047e0    	ldr	x0, [sp, #0x88]
106e87b10: 94367d90    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
106e87b14: f94087e8    	ldr	x8, [sp, #0x108]
106e87b18: f8767913    	ldr	x19, [x8, x22, lsl #3]
106e87b1c: aa1303e0    	mov	x0, x19
106e87b20: aa1903e1    	mov	x1, x25
106e87b24: 94367d86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87b28: aa0003f4    	mov	x20, x0
106e87b2c: aa1803e0    	mov	x0, x24
106e87b30: f9407fe1    	ldr	x1, [sp, #0xf8]
106e87b34: aa1303e2    	mov	x2, x19
106e87b38: 94367d81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87b3c: aa1d03fd    	mov	x29, x29
106e87b40: 94367d82    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87b44: aa0003f5    	mov	x21, x0
106e87b48: aa1703e0    	mov	x0, x23
106e87b4c: aa1a03e1    	mov	x1, x26
106e87b50: aa1403e2    	mov	x2, x20
106e87b54: 94367d7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87b58: aa1d03fd    	mov	x29, x29
106e87b5c: 94367d7b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87b60: aa0003f4    	mov	x20, x0
106e87b64: aa1503e0    	mov	x0, x21
106e87b68: f9407be1    	ldr	x1, [sp, #0xf0]
106e87b6c: 94367d74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87b70: eb1b001f    	cmp	x0, x27
106e87b74: 54000e69    	b.ls	0x106e87d40 <_Flutter_MMFoundation_BindContext+0x3363924>
106e87b78: 9100077b    	add	x27, x27, #0x1
106e87b7c: f9005ffb    	str	x27, [sp, #0xb8]
106e87b80: 900c9768    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e87b84: f946191b    	ldr	x27, [x8, #0xc30]
106e87b88: b00c9768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e87b8c: f9403d19    	ldr	x25, [x8, #0x78]
106e87b90: 900c9768    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e87b94: f945e900    	ldr	x0, [x8, #0xbd0]
106e87b98: f94033fa    	ldr	x26, [sp, #0x60]
106e87b9c: aa1a03e1    	mov	x1, x26
106e87ba0: 94367d67    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87ba4: aa1d03fd    	mov	x29, x29
106e87ba8: 94367d68    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87bac: aa0003f3    	mov	x19, x0
106e87bb0: f9005be0    	str	x0, [sp, #0xb0]
106e87bb4: b00c9768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e87bb8: f9404100    	ldr	x0, [x8, #0x80]
106e87bbc: f9402ffc    	ldr	x28, [sp, #0x58]
106e87bc0: aa1c03e1    	mov	x1, x28
106e87bc4: 94367d5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87bc8: aa0003e2    	mov	x2, x0
106e87bcc: aa1303e0    	mov	x0, x19
106e87bd0: f9402bf3    	ldr	x19, [sp, #0x50]
106e87bd4: aa1303e1    	mov	x1, x19
106e87bd8: 94367d59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87bdc: aa1d03fd    	mov	x29, x29
106e87be0: 94367d5a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87be4: f90057e0    	str	x0, [sp, #0xa8]
106e87be8: f94027f7    	ldr	x23, [sp, #0x48]
106e87bec: aa1703e1    	mov	x1, x23
106e87bf0: b00bd322    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e87bf4: 911ba042    	add	x2, x2, #0x6e8
106e87bf8: d00bb403    	adrp	x3, 0x11e509000 <dyld_stub_binder+0x11e509000>
106e87bfc: 91002063    	add	x3, x3, #0x8
106e87c00: 94367d4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87c04: aa1d03fd    	mov	x29, x29
106e87c08: 94367d50    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87c0c: aa0003e2    	mov	x2, x0
106e87c10: f90053e0    	str	x0, [sp, #0xa0]
106e87c14: aa1903e0    	mov	x0, x25
106e87c18: f94023f8    	ldr	x24, [sp, #0x40]
106e87c1c: aa1803e1    	mov	x1, x24
106e87c20: 94367d47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87c24: aa1b03e0    	mov	x0, x27
106e87c28: f9401ff9    	ldr	x25, [sp, #0x38]
106e87c2c: aa1903e1    	mov	x1, x25
106e87c30: 52800022    	mov	w2, #0x1                ; =1
106e87c34: 94367d42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87c38: 1e6b2809    	fadd	d9, d0, d11
106e87c3c: 900c9768    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e87c40: f9461909    	ldr	x9, [x8, #0xc30]
106e87c44: b00c9768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e87c48: f9403d08    	ldr	x8, [x8, #0x78]
106e87c4c: a90927e8    	stp	x8, x9, [sp, #0x90]
106e87c50: 900c9768    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e87c54: f945e900    	ldr	x0, [x8, #0xbd0]
106e87c58: aa1a03e1    	mov	x1, x26
106e87c5c: 94367d38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87c60: aa1d03fd    	mov	x29, x29
106e87c64: 94367d39    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87c68: aa0003fb    	mov	x27, x0
106e87c6c: b00c9768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e87c70: f9404100    	ldr	x0, [x8, #0x80]
106e87c74: aa1c03e1    	mov	x1, x28
106e87c78: 94367d31    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87c7c: aa0003e2    	mov	x2, x0
106e87c80: aa1b03e0    	mov	x0, x27
106e87c84: aa1303e1    	mov	x1, x19
106e87c88: 94367d2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87c8c: aa1d03fd    	mov	x29, x29
106e87c90: 94367d2e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87c94: aa0003fc    	mov	x28, x0
106e87c98: aa1703e1    	mov	x1, x23
106e87c9c: b00bd322    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e87ca0: 911c2042    	add	x2, x2, #0x708
106e87ca4: d00bb403    	adrp	x3, 0x11e509000 <dyld_stub_binder+0x11e509000>
106e87ca8: 91002063    	add	x3, x3, #0x8
106e87cac: 94367d24    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87cb0: aa1d03fd    	mov	x29, x29
106e87cb4: 94367d25    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87cb8: aa0003fa    	mov	x26, x0
106e87cbc: f9404be0    	ldr	x0, [sp, #0x90]
106e87cc0: f94017f7    	ldr	x23, [sp, #0x28]
106e87cc4: aa1803e1    	mov	x1, x24
106e87cc8: aa1a03e2    	mov	x2, x26
106e87ccc: 94367d1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87cd0: f9404fe0    	ldr	x0, [sp, #0x98]
106e87cd4: f94013f8    	ldr	x24, [sp, #0x20]
106e87cd8: aa1903e1    	mov	x1, x25
106e87cdc: f94043f9    	ldr	x25, [sp, #0x80]
106e87ce0: 52800022    	mov	w2, #0x1                ; =1
106e87ce4: 94367d16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87ce8: 1e602920    	fadd	d0, d9, d0
106e87cec: 1e602908    	fadd	d8, d8, d0
106e87cf0: aa1a03e0    	mov	x0, x26
106e87cf4: f9403ffa    	ldr	x26, [sp, #0x78]
106e87cf8: 94367d17    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87cfc: aa1c03e0    	mov	x0, x28
106e87d00: f9403bfc    	ldr	x28, [sp, #0x70]
106e87d04: 94367d14    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87d08: aa1b03e0    	mov	x0, x27
106e87d0c: f9405ffb    	ldr	x27, [sp, #0xb8]
106e87d10: 94367d11    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87d14: f94053e0    	ldr	x0, [sp, #0xa0]
106e87d18: 94367d0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87d1c: f94057e0    	ldr	x0, [sp, #0xa8]
106e87d20: 94367d0d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87d24: f9405be0    	ldr	x0, [sp, #0xb0]
106e87d28: 94367d0b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87d2c: f94037e8    	ldr	x8, [sp, #0x68]
106e87d30: f8686ae0    	ldr	x0, [x23, x8]
106e87d34: f9401be1    	ldr	x1, [sp, #0x30]
106e87d38: 94367d01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87d3c: 1e604009    	fmov	d9, d0
106e87d40: aa1503e0    	mov	x0, x21
106e87d44: f94077e1    	ldr	x1, [sp, #0xe8]
106e87d48: 94367cfd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87d4c: aa1403e0    	mov	x0, x20
106e87d50: f94073e1    	ldr	x1, [sp, #0xe0]
106e87d54: 94367cfa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87d58: aa1403e0    	mov	x0, x20
106e87d5c: f9406fe1    	ldr	x1, [sp, #0xd8]
106e87d60: 1e604120    	fmov	d0, d9
106e87d64: 94367cf6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87d68: aa1403e0    	mov	x0, x20
106e87d6c: f9406be1    	ldr	x1, [sp, #0xd0]
106e87d70: 1e604100    	fmov	d0, d8
106e87d74: 94367cf2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87d78: aa1403e0    	mov	x0, x20
106e87d7c: f94067e1    	ldr	x1, [sp, #0xc8]
106e87d80: 94367cef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87d84: 1e6a2809    	fadd	d9, d0, d10
106e87d88: aa1403e0    	mov	x0, x20
106e87d8c: 94367cf2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87d90: aa1503e0    	mov	x0, x21
106e87d94: 94367cf0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87d98: 910006d6    	add	x22, x22, #0x1
106e87d9c: eb16039f    	cmp	x28, x22
106e87da0: 54ffeac1    	b.ne	0x106e87af8 <_Flutter_MMFoundation_BindContext+0x33636dc>
106e87da4: 910403e2    	add	x2, sp, #0x100
106e87da8: d10403a3    	sub	x3, x29, #0x100
106e87dac: f94047e0    	ldr	x0, [sp, #0x88]
106e87db0: f9400fe1    	ldr	x1, [sp, #0x18]
106e87db4: 52800204    	mov	w4, #0x10               ; =16
106e87db8: 94367ce1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87dbc: aa0003fc    	mov	x28, x0
106e87dc0: b5ffe6a0    	cbnz	x0, 0x106e87a94 <_Flutter_MMFoundation_BindContext+0x3363678>
106e87dc4: 14000005    	b	0x106e87dd8 <_Flutter_MMFoundation_BindContext+0x33639bc>
106e87dc8: 900c9428    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106e87dcc: f9424d19    	ldr	x25, [x8, #0x498] ; unsignedIntegerValue
106e87dd0: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e87dd4: f943391a    	ldr	x26, [x8, #0x670] ; actionAreaSubViewWithType:
106e87dd8: f94047e0    	ldr	x0, [sp, #0x88]
106e87ddc: 94367cde    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87de0: b00c9768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e87de4: f9404913    	ldr	x19, [x8, #0x90]
106e87de8: f94037f6    	ldr	x22, [sp, #0x68]
106e87dec: f8766ae0    	ldr	x0, [x23, x22]
106e87df0: 900c9428    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106e87df4: f9401501    	ldr	x1, [x8, #0x28] ; text
106e87df8: 94367cd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87dfc: aa1d03fd    	mov	x29, x29
106e87e00: 94367cd2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87e04: aa0003f4    	mov	x20, x0
106e87e08: f8766ae0    	ldr	x0, [x23, x22]
106e87e0c: d00c93c8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
106e87e10: f9456d01    	ldr	x1, [x8, #0xad8] ; font
106e87e14: 94367cca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87e18: aa1d03fd    	mov	x29, x29
106e87e1c: 94367ccb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87e20: aa0003f5    	mov	x21, x0
106e87e24: 900c7dc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106e87e28: f941d501    	ldr	x1, [x8, #0x3a8] ; labelWidth:maxWidth:font:
106e87e2c: d008f7c8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
106e87e30: fd43c900    	ldr	d0, [x8, #0x790]
106e87e34: aa1303e0    	mov	x0, x19
106e87e38: aa1403e2    	mov	x2, x20
106e87e3c: aa1503e3    	mov	x3, x21
106e87e40: 94367cbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87e44: 1e604008    	fmov	d8, d0
106e87e48: aa1503e0    	mov	x0, x21
106e87e4c: 94367cc2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87e50: aa1403e0    	mov	x0, x20
106e87e54: 94367cc0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87e58: f8766ae0    	ldr	x0, [x23, x22]
106e87e5c: 900c9428    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106e87e60: f947a501    	ldr	x1, [x8, #0xf48] ; width
106e87e64: 94367cb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87e68: 1e682000    	fcmp	d0, d8
106e87e6c: 1a9f57e2    	cset	w2, mi
106e87e70: f8766ae0    	ldr	x0, [x23, x22]
106e87e74: f00c93e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106e87e78: f9471901    	ldr	x1, [x8, #0xe30] ; setAdjustsFontSizeToFitWidth:
106e87e7c: 94367cb0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87e80: b00c7e48    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
106e87e84: f9400101    	ldr	x1, [x8]
106e87e88: aa1803e0    	mov	x0, x24
106e87e8c: 94367cac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87e90: aa1d03fd    	mov	x29, x29
106e87e94: 94367cad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87e98: aa0003f3    	mov	x19, x0
106e87e9c: aa1903e1    	mov	x1, x25
106e87ea0: 94367ca7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87ea4: aa0003e2    	mov	x2, x0
106e87ea8: aa1703e0    	mov	x0, x23
106e87eac: aa1a03e1    	mov	x1, x26
106e87eb0: 94367ca3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87eb4: aa1d03fd    	mov	x29, x29
106e87eb8: 94367ca4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87ebc: aa0003f4    	mov	x20, x0
106e87ec0: b00c7da8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e87ec4: f9432901    	ldr	x1, [x8, #0x650] ; bottom
106e87ec8: 94367c9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87ecc: 1e604008    	fmov	d8, d0
106e87ed0: d00c9de8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e87ed4: b9858119    	ldrsw	x25, [x8, #0x580]
106e87ed8: f8796ae0    	ldr	x0, [x23, x25]
106e87edc: b40002e0    	cbz	x0, 0x106e87f38 <_Flutter_MMFoundation_BindContext+0x3363b1c>
106e87ee0: f00c9408    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106e87ee4: f9475d01    	ldr	x1, [x8, #0xeb8] ; superview
106e87ee8: 94367c95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87eec: aa1d03fd    	mov	x29, x29
106e87ef0: 94367c96    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e87ef4: b4000220    	cbz	x0, 0x106e87f38 <_Flutter_MMFoundation_BindContext+0x3363b1c>
106e87ef8: aa0003f5    	mov	x21, x0
106e87efc: f8796ae0    	ldr	x0, [x23, x25]
106e87f00: 900c93e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106e87f04: f943f901    	ldr	x1, [x8, #0x7f0] ; isHidden
106e87f08: 94367c8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87f0c: aa0003f6    	mov	x22, x0
106e87f10: aa1503e0    	mov	x0, x21
106e87f14: 94367c90    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87f18: 37000116    	tbnz	w22, #0x0, 0x106e87f38 <_Flutter_MMFoundation_BindContext+0x3363b1c>
106e87f1c: aa1403e0    	mov	x0, x20
106e87f20: f94003e1    	ldr	x1, [sp]
106e87f24: 94367c86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87f28: f8796ae0    	ldr	x0, [x23, x25]
106e87f2c: b00c7da8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e87f30: f9401901    	ldr	x1, [x8, #0x30] ; setCenterY:
106e87f34: 94367c82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87f38: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e87f3c: f9433d01    	ldr	x1, [x8, #0x678] ; totalLine
106e87f40: f9400bf5    	ldr	x21, [sp, #0x10]
106e87f44: aa1503e0    	mov	x0, x21
106e87f48: 94367c7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87f4c: aa0003e2    	mov	x2, x0
106e87f50: f00c8ba8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e87f54: f9434101    	ldr	x1, [x8, #0x680] ; setActionAreaRowCount:
106e87f58: aa1703e0    	mov	x0, x23
106e87f5c: 94367c78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87f60: aa1403e0    	mov	x0, x20
106e87f64: 94367c7c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87f68: aa1303e0    	mov	x0, x19
106e87f6c: 94367c7a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87f70: aa1803e0    	mov	x0, x24
106e87f74: 94367c78    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87f78: f94007e0    	ldr	x0, [sp, #0x8]
106e87f7c: 94367c76    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87f80: aa1503e0    	mov	x0, x21
106e87f84: 94367c74    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87f88: f85803a8    	ldur	x8, [x29, #-0x80]
106e87f8c: 900b3b49    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106e87f90: f9405929    	ldr	x9, [x9, #0xb0]
106e87f94: f9400129    	ldr	x9, [x9]
106e87f98: eb08013f    	cmp	x9, x8
106e87f9c: 54000181    	b.ne	0x106e87fcc <_Flutter_MMFoundation_BindContext+0x3363bb0>
106e87fa0: 1e604100    	fmov	d0, d8
106e87fa4: 910743ff    	add	sp, sp, #0x1d0
106e87fa8: a9477bfd    	ldp	x29, x30, [sp, #0x70]
106e87fac: a9464ff4    	ldp	x20, x19, [sp, #0x60]
106e87fb0: a94557f6    	ldp	x22, x21, [sp, #0x50]
106e87fb4: a9445ff8    	ldp	x24, x23, [sp, #0x40]
106e87fb8: a94367fa    	ldp	x26, x25, [sp, #0x30]
106e87fbc: a9426ffc    	ldp	x28, x27, [sp, #0x20]
106e87fc0: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
106e87fc4: 6cc82beb    	ldp	d11, d10, [sp], #0x80
106e87fc8: d65f03c0    	ret
106e87fcc: 94367c6a    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
