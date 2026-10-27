
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e48aec: d105c3ff    	sub	sp, sp, #0x170
100e48af0: a9116ffc    	stp	x28, x27, [sp, #0x110]
100e48af4: a91267fa    	stp	x26, x25, [sp, #0x120]
100e48af8: a9135ff8    	stp	x24, x23, [sp, #0x130]
100e48afc: a91457f6    	stp	x22, x21, [sp, #0x140]
100e48b00: a9154ff4    	stp	x20, x19, [sp, #0x150]
100e48b04: a9167bfd    	stp	x29, x30, [sp, #0x160]
100e48b08: 910583fd    	add	x29, sp, #0x160
100e48b0c: aa0203fa    	mov	x26, x2
100e48b10: aa0003f9    	mov	x25, x0
100e48b14: f00e3d28    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100e48b18: f9405908    	ldr	x8, [x8, #0xb0]
100e48b1c: f9400108    	ldr	x8, [x8]
100e48b20: f81a03a8    	stur	x8, [x29, #-0x60]
100e48b24: 900fef48    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100e48b28: 52800029    	mov	w9, #0x1                ; =1
100e48b2c: 39187509    	strb	w9, [x8, #0x61d]
100e48b30: f00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e48b34: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
100e48b38: 900f95c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e48b3c: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
100e48b40: aa1603e1    	mov	x1, x22
100e48b44: 95b7797e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48b48: aa1d03fd    	mov	x29, x29
100e48b4c: 95b7797f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48b50: aa0003f3    	mov	x19, x0
100e48b54: 900f9968    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e48b58: f9401500    	ldr	x0, [x8, #0x28] ; CContactMgr
100e48b5c: f00f95a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e48b60: f947ad17    	ldr	x23, [x8, #0xf58] ; class
100e48b64: aa1703e1    	mov	x1, x23
100e48b68: 95b77975    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48b6c: aa0003e2    	mov	x2, x0
100e48b70: b00f7f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e48b74: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
100e48b78: aa1303e0    	mov	x0, x19
100e48b7c: aa1803e1    	mov	x1, x24
100e48b80: 95b7796f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48b84: aa1d03fd    	mov	x29, x29
100e48b88: 95b77970    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48b8c: aa0003f4    	mov	x20, x0
100e48b90: 900f7fa8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e48b94: f940c901    	ldr	x1, [x8, #0x190] ; getContactByName:
100e48b98: 900eb342    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
100e48b9c: 913aa042    	add	x2, x2, #0xea8 ; CFString 'chatroom_session_box'
100e48ba0: 95b77967    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48ba4: aa1d03fd    	mov	x29, x29
100e48ba8: 95b77968    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48bac: aa0003f5    	mov	x21, x0
100e48bb0: aa1403e0    	mov	x0, x20
100e48bb4: 95b77968    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48bb8: aa1303e0    	mov	x0, x19
100e48bbc: 95b77966    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48bc0: b4000a55    	cbz	x21, 0x100e48d08 <__text+0xe40d08>
100e48bc4: b9000ffa    	str	w26, [sp, #0xc]
100e48bc8: a9025ff8    	stp	x24, x23, [sp, #0x20]
100e48bcc: f9001bf6    	str	x22, [sp, #0x30]
100e48bd0: b00f9968    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
100e48bd4: f9458100    	ldr	x0, [x8, #0xb00] ; MMSessionInfo
100e48bd8: 95b77960    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
100e48bdc: f00f7f88    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100e48be0: f946dd01    	ldr	x1, [x8, #0xdb8] ; setM_contact:
100e48be4: f9000be0    	str	x0, [sp, #0x10]
100e48be8: f9001ff5    	str	x21, [sp, #0x38]
100e48bec: aa1503e2    	mov	x2, x21
100e48bf0: 95b77953    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48bf4: 4f00e400    	movi.16b	v0, #0x0
100e48bf8: ad0303e0    	stp	q0, q0, [sp, #0x60]
100e48bfc: ad0203e0    	stp	q0, q0, [sp, #0x40]
100e48c00: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48c04: f9433901    	ldr	x1, [x8, #0x670] ; chatBoxSessions
100e48c08: f9000ff9    	str	x25, [sp, #0x18]
100e48c0c: aa1903e0    	mov	x0, x25
100e48c10: 95b7794b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48c14: aa1d03fd    	mov	x29, x29
100e48c18: 95b7794c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48c1c: aa0003fb    	mov	x27, x0
100e48c20: 900f95c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e48c24: f943551c    	ldr	x28, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
100e48c28: 910103e2    	add	x2, sp, #0x40
100e48c2c: 910203e3    	add	x3, sp, #0x80
100e48c30: aa1c03e1    	mov	x1, x28
100e48c34: 52800204    	mov	w4, #0x10               ; =16
100e48c38: 95b77941    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48c3c: b40008a0    	cbz	x0, 0x100e48d50 <__text+0xe40d50>
100e48c40: aa0003fa    	mov	x26, x0
100e48c44: d2800019    	mov	x25, #0x0               ; =0
100e48c48: f9402be8    	ldr	x8, [sp, #0x50]
100e48c4c: f9400117    	ldr	x23, [x8]
100e48c50: d2800018    	mov	x24, #0x0               ; =0
100e48c54: b00f7fa8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100e48c58: f942e514    	ldr	x20, [x8, #0x5c8] ; m_uUnReadCount
100e48c5c: f00f7f88    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100e48c60: f947d915    	ldr	x21, [x8, #0xfb0] ; m_contact
100e48c64: 900f7fa8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e48c68: f944c516    	ldr	x22, [x8, #0x988] ; getContactDisplayName
100e48c6c: f9402be8    	ldr	x8, [sp, #0x50]
100e48c70: f9400108    	ldr	x8, [x8]
100e48c74: eb17011f    	cmp	x8, x23
100e48c78: 54000060    	b.eq	0x100e48c84 <__text+0xe40c84>
100e48c7c: aa1b03e0    	mov	x0, x27
100e48c80: 95b77934    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
100e48c84: f94027e8    	ldr	x8, [sp, #0x48]
100e48c88: f8787913    	ldr	x19, [x8, x24, lsl #3]
100e48c8c: aa1303e0    	mov	x0, x19
100e48c90: aa1403e1    	mov	x1, x20
100e48c94: 95b7792a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48c98: 7100001f    	cmp	w0, #0x0
100e48c9c: fa401b20    	ccmp	x25, #0x0, #0x0, ne
100e48ca0: 540001c1    	b.ne	0x100e48cd8 <__text+0xe40cd8>
100e48ca4: aa1303e0    	mov	x0, x19
100e48ca8: aa1503e1    	mov	x1, x21
100e48cac: 95b77924    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48cb0: aa1d03fd    	mov	x29, x29
100e48cb4: 95b77925    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48cb8: aa0003f3    	mov	x19, x0
100e48cbc: aa1603e1    	mov	x1, x22
100e48cc0: 95b7791f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48cc4: aa1d03fd    	mov	x29, x29
100e48cc8: 95b77920    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48ccc: aa0003f9    	mov	x25, x0
100e48cd0: aa1303e0    	mov	x0, x19
100e48cd4: 95b77920    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48cd8: 91000718    	add	x24, x24, #0x1
100e48cdc: eb18035f    	cmp	x26, x24
100e48ce0: 54fffc61    	b.ne	0x100e48c6c <__text+0xe40c6c>
100e48ce4: 910103e2    	add	x2, sp, #0x40
100e48ce8: 910203e3    	add	x3, sp, #0x80
100e48cec: aa1b03e0    	mov	x0, x27
100e48cf0: aa1c03e1    	mov	x1, x28
100e48cf4: 52800204    	mov	w4, #0x10               ; =16
100e48cf8: 95b77911    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48cfc: aa0003fa    	mov	x26, x0
100e48d00: b5fffa80    	cbnz	x0, 0x100e48c50 <__text+0xe40c50>
100e48d04: 14000014    	b	0x100e48d54 <__text+0xe40d54>
100e48d08: f00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e48d0c: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
100e48d10: b00f7f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e48d14: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
100e48d18: d00eb748    	adrp	x8, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e48d1c: 91252108    	add	x8, x8, #0x948 ; CFString 'can not get chatbox contact'
100e48d20: f90003e8    	str	x8, [sp]
100e48d24: b00d20a3    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
100e48d28: 911f2c63    	add	x3, x3, #0x7cb
100e48d2c: f00d2805    	adrp	x5, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e48d30: 910c4ca5    	add	x5, x5, #0x313
100e48d34: f00d2807    	adrp	x7, 0x11b34b000 <dyld_stub_binder+0x11b34b000>
100e48d38: 91144ce7    	add	x7, x7, #0x513
100e48d3c: 52800082    	mov	w2, #0x4                ; =4
100e48d40: 52800004    	mov	w4, #0x0                ; =0
100e48d44: 52802ce6    	mov	w6, #0x167              ; =359
100e48d48: 95b778fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48d4c: 14000073    	b	0x100e48f18 <__text+0xe40f18>
100e48d50: d2800019    	mov	x25, #0x0               ; =0
100e48d54: aa1b03e0    	mov	x0, x27
100e48d58: 95b778ff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48d5c: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48d60: f9439d01    	ldr	x1, [x8, #0x738] ; lastMsgForChatBoxSession
100e48d64: f9400ffa    	ldr	x26, [sp, #0x18]
100e48d68: aa1a03e0    	mov	x0, x26
100e48d6c: 95b778f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48d70: aa1d03fd    	mov	x29, x29
100e48d74: 95b778f5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48d78: aa0003f3    	mov	x19, x0
100e48d7c: d00f7fe8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
100e48d80: f942f901    	ldr	x1, [x8, #0x5f0] ; setM_msgWrap:
100e48d84: f9400bfb    	ldr	x27, [sp, #0x10]
100e48d88: aa1b03e0    	mov	x0, x27
100e48d8c: aa1303e2    	mov	x2, x19
100e48d90: 95b778eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48d94: aa1303e0    	mov	x0, x19
100e48d98: 95b778ef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48d9c: d00f7fe8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
100e48da0: f9430901    	ldr	x1, [x8, #0x610] ; setM_bShowUnReadAsRedDot:
100e48da4: aa1b03e0    	mov	x0, x27
100e48da8: 52800022    	mov	w2, #0x1                ; =1
100e48dac: 95b778e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48db0: f94017f7    	ldr	x23, [sp, #0x28]
100e48db4: b9400fe2    	ldr	w2, [sp, #0xc]
100e48db8: 34000122    	cbz	w2, 0x100e48ddc <__text+0xe40ddc>
100e48dbc: d00f7fe8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
100e48dc0: f9430d01    	ldr	x1, [x8, #0x618] ; setM_uLastTime:
100e48dc4: aa1b03e0    	mov	x0, x27
100e48dc8: 95b778dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48dcc: f9401ff5    	ldr	x21, [sp, #0x38]
100e48dd0: f00f9956    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
100e48dd4: f94013f8    	ldr	x24, [sp, #0x20]
100e48dd8: 14000029    	b	0x100e48e7c <__text+0xe40e7c>
100e48ddc: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48de0: f943a114    	ldr	x20, [x8, #0x740] ; chatBoxSession
100e48de4: aa1a03e0    	mov	x0, x26
100e48de8: aa1403e1    	mov	x1, x20
100e48dec: 95b778d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48df0: aa1d03fd    	mov	x29, x29
100e48df4: 95b778d5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48df8: aa0003f3    	mov	x19, x0
100e48dfc: 95b778d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48e00: f00f9956    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
100e48e04: f94013f8    	ldr	x24, [sp, #0x20]
100e48e08: b4000253    	cbz	x19, 0x100e48e50 <__text+0xe40e50>
100e48e0c: aa1a03e0    	mov	x0, x26
100e48e10: aa1403e1    	mov	x1, x20
100e48e14: 95b778ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48e18: aa1d03fd    	mov	x29, x29
100e48e1c: 95b778cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48e20: aa0003f3    	mov	x19, x0
100e48e24: b00f7fa8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100e48e28: f9413501    	ldr	x1, [x8, #0x268] ; m_uLastTime
100e48e2c: 95b778c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48e30: aa0003e2    	mov	x2, x0
100e48e34: d00f7fe8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
100e48e38: f9430d01    	ldr	x1, [x8, #0x618] ; setM_uLastTime:
100e48e3c: aa1b03e0    	mov	x0, x27
100e48e40: 95b778bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48e44: aa1303e0    	mov	x0, x19
100e48e48: 95b778c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48e4c: 1400000b    	b	0x100e48e78 <__text+0xe40e78>
100e48e50: f00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e48e54: f9467900    	ldr	x0, [x8, #0xcf0] ; CUtility
100e48e58: 900f7fa8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e48e5c: f9403501    	ldr	x1, [x8, #0x68] ; genServerCurrentTime
100e48e60: 95b778b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48e64: aa0003e2    	mov	x2, x0
100e48e68: d00f7fe8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
100e48e6c: f9430d01    	ldr	x1, [x8, #0x618] ; setM_uLastTime:
100e48e70: aa1b03e0    	mov	x0, x27
100e48e74: 95b778b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48e78: f9401ff5    	ldr	x21, [sp, #0x38]
100e48e7c: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48e80: f9434501    	ldr	x1, [x8, #0x688] ; isChatBoxSessionUnread
100e48e84: aa1a03e0    	mov	x0, x26
100e48e88: 95b778ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48e8c: aa0003e2    	mov	x2, x0
100e48e90: d00f7fe8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
100e48e94: f9431101    	ldr	x1, [x8, #0x620] ; setM_uUnReadCount:
100e48e98: aa1b03e0    	mov	x0, x27
100e48e9c: 95b778a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48ea0: f945eac0    	ldr	x0, [x22, #0xbd0] ; MMContext
100e48ea4: f9401be1    	ldr	x1, [sp, #0x30]
100e48ea8: 95b778a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48eac: aa1d03fd    	mov	x29, x29
100e48eb0: 95b778a6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48eb4: aa0003f3    	mov	x19, x0
100e48eb8: 900f9968    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e48ebc: f9401d00    	ldr	x0, [x8, #0x38] ; MMNewSessionMgr
100e48ec0: aa1703e1    	mov	x1, x23
100e48ec4: 95b7789e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48ec8: aa0003e2    	mov	x2, x0
100e48ecc: aa1303e0    	mov	x0, x19
100e48ed0: aa1803e1    	mov	x1, x24
100e48ed4: 95b7789a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48ed8: aa1d03fd    	mov	x29, x29
100e48edc: 95b7789b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48ee0: aa0003f4    	mov	x20, x0
100e48ee4: d00f7fe8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
100e48ee8: f9424901    	ldr	x1, [x8, #0x490] ; AddOrModifySession:withNotifyFlag:
100e48eec: aa1b03e2    	mov	x2, x27
100e48ef0: d2800003    	mov	x3, #0x0                ; =0
100e48ef4: 95b77892    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48ef8: aa1403e0    	mov	x0, x20
100e48efc: 95b77896    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48f00: aa1303e0    	mov	x0, x19
100e48f04: 95b77894    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48f08: aa1903e0    	mov	x0, x25
100e48f0c: 95b77892    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48f10: aa1b03e0    	mov	x0, x27
100e48f14: 95b77890    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48f18: aa1503e0    	mov	x0, x21
100e48f1c: 95b7788e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48f20: f85a03a8    	ldur	x8, [x29, #-0x60]
100e48f24: f00e3d29    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100e48f28: f9405929    	ldr	x9, [x9, #0xb0]
100e48f2c: f9400129    	ldr	x9, [x9]
100e48f30: eb08013f    	cmp	x9, x8
100e48f34: 54000121    	b.ne	0x100e48f58 <__text+0xe40f58>
100e48f38: a9567bfd    	ldp	x29, x30, [sp, #0x160]
100e48f3c: a9554ff4    	ldp	x20, x19, [sp, #0x150]
100e48f40: a95457f6    	ldp	x22, x21, [sp, #0x140]
100e48f44: a9535ff8    	ldp	x24, x23, [sp, #0x130]
100e48f48: a95267fa    	ldp	x26, x25, [sp, #0x120]
100e48f4c: a9516ffc    	ldp	x28, x27, [sp, #0x110]
100e48f50: 9105c3ff    	add	sp, sp, #0x170
100e48f54: d65f03c0    	ret
100e48f58: 95b77887    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
