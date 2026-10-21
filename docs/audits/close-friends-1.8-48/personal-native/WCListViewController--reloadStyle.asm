
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109018c48: d10243ff    	sub	sp, sp, #0x90
109018c4c: 6d012beb    	stp	d11, d10, [sp, #0x10]
109018c50: 6d0223e9    	stp	d9, d8, [sp, #0x20]
109018c54: a9036ffc    	stp	x28, x27, [sp, #0x30]
109018c58: a90467fa    	stp	x26, x25, [sp, #0x40]
109018c5c: a9055ff8    	stp	x24, x23, [sp, #0x50]
109018c60: a90657f6    	stp	x22, x21, [sp, #0x60]
109018c64: a9074ff4    	stp	x20, x19, [sp, #0x70]
109018c68: a9087bfd    	stp	x29, x30, [sp, #0x80]
109018c6c: 910203fd    	add	x29, sp, #0x80
109018c70: aa0003f3    	mov	x19, x0
109018c74: b00be1a8    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
109018c78: 52800029    	mov	w9, #0x1                ; =1
109018c7c: 393bd109    	strb	w9, [x8, #0xef4]
109018c80: f00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109018c84: f9470100    	ldr	x0, [x8, #0xe00]
109018c88: d00b71e8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
109018c8c: f9475501    	ldr	x1, [x8, #0xea8] ; screenBounds
109018c90: 95a109ed    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018c94: 1e604048    	fmov	d8, d2
109018c98: 900b9268    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
109018c9c: b986411c    	ldrsw	x28, [x8, #0x640]
109018ca0: f87c6a60    	ldr	x0, [x19, x28]
109018ca4: d00b8788    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
109018ca8: f9412d16    	ldr	x22, [x8, #0x258] ; setViewController:
109018cac: b4000140    	cbz	x0, 0x109018cd4 <_Flutter_MMFoundation_BindContext+0x54f48b8>
109018cb0: aa1603e1    	mov	x1, x22
109018cb4: d2800002    	mov	x2, #0x0                ; =0
109018cb8: 95a109e3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018cbc: f00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109018cc0: f9467500    	ldr	x0, [x8, #0xce8]
109018cc4: f87c6a62    	ldr	x2, [x19, x28]
109018cc8: b00b7128    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
109018ccc: f947d901    	ldr	x1, [x8, #0xfb0] ; safeCancelPreviousPerformRequestsWithTarget:
109018cd0: 95a109dd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018cd4: f00b8c68    	adrp	x8, 0x1201a7000 <dyld_stub_binder+0x1201a7000>
109018cd8: f9404d00    	ldr	x0, [x8, #0x98] ; ([C
109018cdc: 95a109e1    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
109018ce0: aa0003f4    	mov	x20, x0
109018ce4: f00b8268    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
109018ce8: f940c901    	ldr	x1, [x8, #0x190] ; bHideBackgroundCover
109018cec: aa1303e0    	mov	x0, x19
109018cf0: 95a109d5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018cf4: aa0003e2    	mov	x2, x0
109018cf8: f00b8268    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
109018cfc: f9435901    	ldr	x1, [x8, #0x6b0] ; setBHideBackgroundCover:
109018d00: aa1403e0    	mov	x0, x20
109018d04: 95a109d0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018d08: 900b7ee8    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
109018d0c: f9426d01    	ldr	x1, [x8, #0x4d8] ; isStarBrowsingEnabled
109018d10: aa1303e0    	mov	x0, x19
109018d14: 95a109cc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018d18: aa0003e2    	mov	x2, x0
109018d1c: f00b8268    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
109018d20: f943fd01    	ldr	x1, [x8, #0x7f8] ; setIsStarBrowsingEnabled:
109018d24: aa1403e0    	mov	x0, x20
109018d28: 95a109c7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018d2c: b00b7e68    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
109018d30: f9426d01    	ldr	x1, [x8, #0x4d8] ; pageContext
109018d34: aa1303e0    	mov	x0, x19
109018d38: 95a109c3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018d3c: aa1d03fd    	mov	x29, x29
109018d40: 95a109c4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109018d44: aa0003f5    	mov	x21, x0
109018d48: b00b7f28    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
109018d4c: f947e501    	ldr	x1, [x8, #0xfc8] ; setPageContext:
109018d50: aa1403e0    	mov	x0, x20
109018d54: aa1503e2    	mov	x2, x21
109018d58: 95a109bb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018d5c: aa1503e0    	mov	x0, x21
109018d60: 95a109bf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109018d64: d00b8268    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
109018d68: f947f101    	ldr	x1, [x8, #0xfe0] ; puzzleImageViewLayoutStyle
109018d6c: aa1303e0    	mov	x0, x19
109018d70: 95a109b5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018d74: aa0003e2    	mov	x2, x0
109018d78: d00b8268    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
109018d7c: f947f501    	ldr	x1, [x8, #0xfe8] ; setPuzzleImageViewLayoutStyle:
109018d80: aa1403e0    	mov	x0, x20
109018d84: 95a109b0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018d88: f00b8c68    	adrp	x8, 0x1201a7000 <dyld_stub_binder+0x1201a7000>
109018d8c: f9404900    	ldr	x0, [x8, #0x90]
109018d90: 95a109b6    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
109018d94: aa0003f5    	mov	x21, x0
109018d98: 900b9268    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
109018d9c: b9864508    	ldrsw	x8, [x8, #0x644]
109018da0: f8686a77    	ldr	x23, [x19, x8]
109018da4: 900b9268    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
109018da8: b9864908    	ldrsw	x8, [x8, #0x648]
109018dac: f8686a78    	ldr	x24, [x19, x8]
109018db0: 900b7128    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109018db4: f9419501    	ldr	x1, [x8, #0x328] ; getVisibleHeight
109018db8: aa1303e0    	mov	x0, x19
109018dbc: 95a109a2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018dc0: 1e604003    	fmov	d3, d0
109018dc4: 900b9268    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
109018dc8: b9863d08    	ldrsw	x8, [x8, #0x63c]
109018dcc: f8686a64    	ldr	x4, [x19, x8]
109018dd0: f00b8268    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
109018dd4: f9440101    	ldr	x1, [x8, #0x800] ; initWithData:starredDataItems:frame:contact:viewController:params:
109018dd8: 9e6703e0    	fmov	d0, xzr
109018ddc: 9e6703e1    	fmov	d1, xzr
109018de0: aa1503e0    	mov	x0, x21
109018de4: aa1703e2    	mov	x2, x23
109018de8: aa1803e3    	mov	x3, x24
109018dec: 1e604102    	fmov	d2, d8
109018df0: aa1303e5    	mov	x5, x19
109018df4: aa1403e6    	mov	x6, x20
109018df8: 95a10993    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018dfc: aa0003f5    	mov	x21, x0
109018e00: f00b8768    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
109018e04: f9451501    	ldr	x1, [x8, #0xa28] ; setDelegate:
109018e08: aa1303e2    	mov	x2, x19
109018e0c: 95a1098e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018e10: 8b1c0260    	add	x0, x19, x28
109018e14: aa1503e1    	mov	x1, x21
109018e18: 95a1098c    	bl	0x10f85b448 <_UR_96F1_B25D+0x3a640b8>
109018e1c: f87c6a60    	ldr	x0, [x19, x28]
109018e20: aa1603e1    	mov	x1, x22
109018e24: aa1303e2    	mov	x2, x19
109018e28: 95a10987    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018e2c: d00b7348    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
109018e30: f9448501    	ldr	x1, [x8, #0x908] ; autoresizingWithStrechFullSize
109018e34: aa1503e0    	mov	x0, x21
109018e38: 95a10983    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018e3c: b00b7228    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
109018e40: f9424d01    	ldr	x1, [x8, #0x498] ; setView:
109018e44: aa1303e0    	mov	x0, x19
109018e48: aa1503e2    	mov	x2, x21
109018e4c: 95a1097e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018e50: f00b8268    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
109018e54: f9440501    	ldr	x1, [x8, #0x808] ; bForbiddenNavgationBarInteractive
109018e58: aa1303e0    	mov	x0, x19
109018e5c: 95a1097a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018e60: 370011c0    	tbnz	w0, #0x0, 0x109019098 <_Flutter_MMFoundation_BindContext+0x54f4c7c>
109018e64: f00b8adb    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
109018e68: f945eb60    	ldr	x0, [x27, #0xbd0]
109018e6c: 900b8748    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109018e70: f944e918    	ldr	x24, [x8, #0x9d0] ; currentContext
109018e74: aa1803e1    	mov	x1, x24
109018e78: 95a10973    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018e7c: aa1d03fd    	mov	x29, x29
109018e80: 95a10974    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109018e84: aa0003f6    	mov	x22, x0
109018e88: d00b8ae8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
109018e8c: f946d100    	ldr	x0, [x8, #0xda0] ;  h>
109018e90: f00b8728    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109018e94: f947ad19    	ldr	x25, [x8, #0xf58] ; class
109018e98: aa1903e1    	mov	x1, x25
109018e9c: 95a1096a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018ea0: aa0003e2    	mov	x2, x0
109018ea4: b00b7108    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109018ea8: f946411a    	ldr	x26, [x8, #0xc80] ; getService:
109018eac: aa1603e0    	mov	x0, x22
109018eb0: aa1a03e1    	mov	x1, x26
109018eb4: 95a10964    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018eb8: aa1d03fd    	mov	x29, x29
109018ebc: 95a10965    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109018ec0: aa0003f7    	mov	x23, x0
109018ec4: b00b73e8    	adrp	x8, 0x11fe95000 <dyld_stub_binder+0x11fe95000>
109018ec8: f9408101    	ldr	x1, [x8, #0x100] ; Timeline_isCoverNewVersion
109018ecc: 95a1095e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018ed0: 34000320    	cbz	w0, 0x109018f34 <_Flutter_MMFoundation_BindContext+0x54f4b18>
109018ed4: f00b8ad8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
109018ed8: f9470300    	ldr	x0, [x24, #0xe00]
109018edc: 900b7128    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109018ee0: f9419101    	ldr	x1, [x8, #0x320] ; pageScopeWidthFor:
109018ee4: aa1303e2    	mov	x2, x19
109018ee8: 95a10957    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018eec: 1e604008    	fmov	d8, d0
109018ef0: d00b72a8    	adrp	x8, 0x11fe6e000 <dyld_stub_binder+0x11fe6e000>
109018ef4: f9440501    	ldr	x1, [x8, #0x808] ; aspectRatio
109018ef8: aa1303e0    	mov	x0, x19
109018efc: 95a10952    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018f00: 1e604009    	fmov	d9, d0
109018f04: f9470300    	ldr	x0, [x24, #0xe00]
109018f08: 900b7168    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
109018f0c: f940f501    	ldr	x1, [x8, #0x1e8] ; statusBarHeight
109018f10: 95a1094d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018f14: 1e60400a    	fmov	d10, d0
109018f18: f9470300    	ldr	x0, [x24, #0xe00]
109018f1c: 900b7168    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
109018f20: f9451d01    	ldr	x1, [x8, #0xa38] ; navigationBarHeight
109018f24: 95a10948    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018f28: 1e602940    	fadd	d0, d10, d0
109018f2c: 1f698108    	fnmsub	d8, d8, d9, d0
109018f30: 1400002b    	b	0x109018fdc <_Flutter_MMFoundation_BindContext+0x54f4bc0>
109018f34: 900b8ae8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
109018f38: f9403d08    	ldr	x8, [x8, #0x78]
109018f3c: f90007e8    	str	x8, [sp, #0x8]
109018f40: f945eb60    	ldr	x0, [x27, #0xbd0]
109018f44: aa1803e1    	mov	x1, x24
109018f48: 95a1093f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018f4c: aa1d03fd    	mov	x29, x29
109018f50: 95a10940    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109018f54: aa0003f8    	mov	x24, x0
109018f58: 900b8ae8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
109018f5c: f9404100    	ldr	x0, [x8, #0x80]
109018f60: aa1903e1    	mov	x1, x25
109018f64: 95a10938    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018f68: aa0003e2    	mov	x2, x0
109018f6c: aa1803e0    	mov	x0, x24
109018f70: aa1a03e1    	mov	x1, x26
109018f74: 95a10934    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018f78: aa1d03fd    	mov	x29, x29
109018f7c: 95a10935    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109018f80: aa0003f9    	mov	x25, x0
109018f84: f00b7108    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
109018f88: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
109018f8c: d00acd02    	adrp	x2, 0x11e9ba000 <dyld_stub_binder+0x11e9ba000>
109018f90: 91332042    	add	x2, x2, #0xcc8
109018f94: d00acd03    	adrp	x3, 0x11e9ba000 <dyld_stub_binder+0x11e9ba000>
109018f98: 9133a063    	add	x3, x3, #0xce8
109018f9c: 95a1092a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018fa0: aa1d03fd    	mov	x29, x29
109018fa4: 95a1092b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109018fa8: aa0003fa    	mov	x26, x0
109018fac: 900b7128    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109018fb0: f9400101    	ldr	x1, [x8]
109018fb4: f94007e0    	ldr	x0, [sp, #0x8]
109018fb8: aa1a03e2    	mov	x2, x26
109018fbc: 95a10922    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109018fc0: 1e604008    	fmov	d8, d0
109018fc4: aa1a03e0    	mov	x0, x26
109018fc8: 95a10925    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109018fcc: aa1903e0    	mov	x0, x25
109018fd0: 95a10923    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109018fd4: aa1803e0    	mov	x0, x24
109018fd8: 95a10921    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109018fdc: aa1703e0    	mov	x0, x23
109018fe0: 95a1091f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109018fe4: aa1603e0    	mov	x0, x22
109018fe8: 95a1091d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109018fec: f00b8ae8    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
109018ff0: f9448d00    	ldr	x0, [x8, #0x918]
109018ff4: 95a1091d    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
109018ff8: aa0003f6    	mov	x22, x0
109018ffc: f87c6a60    	ldr	x0, [x19, x28]
109019000: f00b7108    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109019004: f940d501    	ldr	x1, [x8, #0x1a8] ; getTableView
109019008: 95a1090f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901900c: aa1d03fd    	mov	x29, x29
109019010: 95a10910    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109019014: aa0003f7    	mov	x23, x0
109019018: 1e669000    	fmov	d0, #20.00000000
10901901c: 1e602901    	fadd	d1, d8, d0
109019020: b00b71e8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
109019024: f9454d01    	ldr	x1, [x8, #0xa98] ; initFadeStyleWithScrollView:fadeInColor:fadeInStartOffset:fadeInEndOffset:
109019028: aa1603e0    	mov	x0, x22
10901902c: aa1703e2    	mov	x2, x23
109019030: d2800003    	mov	x3, #0x0                ; =0
109019034: 1e604100    	fmov	d0, d8
109019038: 95a10903    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901903c: aa0003f6    	mov	x22, x0
109019040: b00b71e8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
109019044: f9455101    	ldr	x1, [x8, #0xaa0] ; setNavBarInteractiveConfig:
109019048: aa1303e0    	mov	x0, x19
10901904c: aa1603e2    	mov	x2, x22
109019050: 95a108fd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109019054: aa1603e0    	mov	x0, x22
109019058: 95a10901    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901905c: aa1703e0    	mov	x0, x23
109019060: 95a108ff    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109019064: 900b7ae8    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
109019068: f9434101    	ldr	x1, [x8, #0x680] ; navBarInteractiveConfig
10901906c: aa1303e0    	mov	x0, x19
109019070: 95a108f5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109019074: aa1d03fd    	mov	x29, x29
109019078: 95a108f6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901907c: aa0003f3    	mov	x19, x0
109019080: 900b7108    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109019084: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
109019088: aa1503e2    	mov	x2, x21
10901908c: 95a108ee    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109019090: aa1303e0    	mov	x0, x19
109019094: 95a108f2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109019098: aa1503e0    	mov	x0, x21
10901909c: 95a108f0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1090190a0: aa1403e0    	mov	x0, x20
1090190a4: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1090190a8: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1090190ac: a94657f6    	ldp	x22, x21, [sp, #0x60]
1090190b0: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1090190b4: a94467fa    	ldp	x26, x25, [sp, #0x40]
1090190b8: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1090190bc: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
1090190c0: 6d412beb    	ldp	d11, d10, [sp, #0x10]
1090190c4: 910243ff    	add	sp, sp, #0x90
1090190c8: 15a108e5    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
