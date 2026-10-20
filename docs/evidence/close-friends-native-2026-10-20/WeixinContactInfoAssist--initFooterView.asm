
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a95003c: 6db923e9    	stp	d9, d8, [sp, #-0x70]!
10a950040: a9016ffc    	stp	x28, x27, [sp, #0x10]
10a950044: a90267fa    	stp	x26, x25, [sp, #0x20]
10a950048: a9035ff8    	stp	x24, x23, [sp, #0x30]
10a95004c: a90457f6    	stp	x22, x21, [sp, #0x40]
10a950050: a9054ff4    	stp	x20, x19, [sp, #0x50]
10a950054: a9067bfd    	stp	x29, x30, [sp, #0x60]
10a950058: 910183fd    	add	x29, sp, #0x60
10a95005c: aa0003f3    	mov	x19, x0
10a950060: f00b1808    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a950064: 52800029    	mov	w9, #0x1                ; =1
10a950068: f00ac46a    	adrp	x10, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a95006c: 9109c14a    	add	x10, x10, #0x270
10a950070: 390be509    	strb	w9, [x8, #0x2f9]
10a950074: b980015b    	ldrsw	x27, [x10]
10a950078: f87b6800    	ldr	x0, [x0, x27]
10a95007c: f83b6a7f    	str	xzr, [x19, x27]
10a950080: 953c2cf7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a950084: f00ac948    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a950088: b9872508    	ldrsw	x8, [x8, #0x724]
10a95008c: f8686a60    	ldr	x0, [x19, x8]
10a950090: f8286a7f    	str	xzr, [x19, x8]
10a950094: 953c2cf2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a950098: f00ac948    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a95009c: b9872d08    	ldrsw	x8, [x8, #0x72c]
10a9500a0: f8686a60    	ldr	x0, [x19, x8]
10a9500a4: f8286a7f    	str	xzr, [x19, x8]
10a9500a8: 953c2ced    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9500ac: f00ac948    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9500b0: b9872908    	ldrsw	x8, [x8, #0x728]
10a9500b4: f8686a60    	ldr	x0, [x19, x8]
10a9500b8: f8286a7f    	str	xzr, [x19, x8]
10a9500bc: 953c2ce8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9500c0: f00ac948    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9500c4: b9873108    	ldrsw	x8, [x8, #0x730]
10a9500c8: f8686a60    	ldr	x0, [x19, x8]
10a9500cc: f8286a7f    	str	xzr, [x19, x8]
10a9500d0: 953c2ce3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9500d4: f00ac114    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
10a9500d8: f9470280    	ldr	x0, [x20, #0xe00]
10a9500dc: b00aa768    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a9500e0: f946a501    	ldr	x1, [x8, #0xd48] ; pageScopeHeightFor:
10a9500e4: aa1303e2    	mov	x2, x19
10a9500e8: 953c2cd7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9500ec: 1e604008    	fmov	d8, d0
10a9500f0: f9470280    	ldr	x0, [x20, #0xe00]
10a9500f4: 900aa7a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a9500f8: f9451d01    	ldr	x1, [x8, #0xa38] ; navigationBarHeight
10a9500fc: 953c2cd2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950100: 1e603908    	fsub	d8, d8, d0
10a950104: f9470280    	ldr	x0, [x20, #0xe00]
10a950108: 900aa7a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a95010c: f940f501    	ldr	x1, [x8, #0x1e8] ; statusBarHeight
10a950110: 953c2ccd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950114: 1e603908    	fsub	d8, d8, d0
10a950118: f00ac948    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a95011c: b986f11c    	ldrsw	x28, [x8, #0x6f0]
10a950120: f87c6a60    	ldr	x0, [x19, x28]
10a950124: d00abdc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a950128: f947bd17    	ldr	x23, [x8, #0xf78] ; tableView
10a95012c: aa1703e1    	mov	x1, x23
10a950130: 953c2cc5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950134: aa1d03fd    	mov	x29, x29
10a950138: 953c2cc6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a95013c: aa0003f8    	mov	x24, x0
10a950140: d00aa788    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
10a950144: f9442901    	ldr	x1, [x8, #0x850] ; contentSize
10a950148: 953c2cbf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95014c: 1e613908    	fsub	d8, d8, d1
10a950150: b00aa748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a950154: f946b114    	ldr	x20, [x8, #0xd60] ; m_delegate
10a950158: aa1303e0    	mov	x0, x19
10a95015c: aa1403e1    	mov	x1, x20
10a950160: 953c2cb9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950164: aa1d03fd    	mov	x29, x29
10a950168: 953c2cba    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a95016c: aa0003f9    	mov	x25, x0
10a950170: f00aa748    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a950174: f945d515    	ldr	x21, [x8, #0xba8] ; getViewController
10a950178: aa1503e1    	mov	x1, x21
10a95017c: 953c2cb2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950180: aa1d03fd    	mov	x29, x29
10a950184: 953c2cb3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a950188: aa0003fa    	mov	x26, x0
10a95018c: d00aa788    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
10a950190: f9462d16    	ldr	x22, [x8, #0xc58] ; getSafeBottomInset
10a950194: aa1603e1    	mov	x1, x22
10a950198: 953c2cab    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95019c: 1e603908    	fsub	d8, d8, d0
10a9501a0: aa1a03e0    	mov	x0, x26
10a9501a4: 953c2cae    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9501a8: aa1903e0    	mov	x0, x25
10a9501ac: 953c2cac    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9501b0: aa1803e0    	mov	x0, x24
10a9501b4: 953c2caa    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9501b8: f87c6a60    	ldr	x0, [x19, x28]
10a9501bc: aa1703e1    	mov	x1, x23
10a9501c0: 953c2ca1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9501c4: aa1d03fd    	mov	x29, x29
10a9501c8: 953c2ca2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9501cc: aa0003f9    	mov	x25, x0
10a9501d0: 900aa808    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
10a9501d4: f9452118    	ldr	x24, [x8, #0xa40] ; tableFooterView
10a9501d8: aa1803e1    	mov	x1, x24
10a9501dc: 953c2c9a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9501e0: aa1d03fd    	mov	x29, x29
10a9501e4: 953c2c9b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9501e8: aa0003fa    	mov	x26, x0
10a9501ec: 953c2c9c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9501f0: aa1903e0    	mov	x0, x25
10a9501f4: 953c2c9a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9501f8: b400029a    	cbz	x26, 0x10a950248 <_Flutter_MMFoundation_BindContext+0x6e2be2c>
10a9501fc: f87c6a60    	ldr	x0, [x19, x28]
10a950200: aa1703e1    	mov	x1, x23
10a950204: 953c2c90    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950208: aa1d03fd    	mov	x29, x29
10a95020c: 953c2c91    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a950210: aa0003f7    	mov	x23, x0
10a950214: aa1803e1    	mov	x1, x24
10a950218: 953c2c8b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95021c: aa1d03fd    	mov	x29, x29
10a950220: 953c2c8c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a950224: aa0003f8    	mov	x24, x0
10a950228: d00abd88    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10a95022c: f9449d01    	ldr	x1, [x8, #0x938] ; height
10a950230: 953c2c85    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950234: 1e602908    	fadd	d8, d8, d0
10a950238: aa1803e0    	mov	x0, x24
10a95023c: 953c2c88    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a950240: aa1703e0    	mov	x0, x23
10a950244: 953c2c86    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a950248: aa1303e0    	mov	x0, x19
10a95024c: aa1403e1    	mov	x1, x20
10a950250: 953c2c7d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950254: aa1d03fd    	mov	x29, x29
10a950258: 953c2c7e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a95025c: aa0003f4    	mov	x20, x0
10a950260: aa1503e1    	mov	x1, x21
10a950264: 953c2c78    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950268: aa1d03fd    	mov	x29, x29
10a95026c: 953c2c79    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a950270: aa0003f5    	mov	x21, x0
10a950274: aa1603e1    	mov	x1, x22
10a950278: 953c2c73    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95027c: d2e80c28    	mov	x8, #0x4061000000000000 ; =4638989091168321536
10a950280: 9e670101    	fmov	d1, x8
10a950284: 1e612809    	fadd	d9, d0, d1
10a950288: aa1503e0    	mov	x0, x21
10a95028c: 953c2c74    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a950290: aa1403e0    	mov	x0, x20
10a950294: 953c2c72    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a950298: 1e682120    	fcmp	d9, d8
10a95029c: 1e694d08    	fcsel	d8, d8, d9, mi
10a9502a0: f00ac108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a9502a4: f9474d00    	ldr	x0, [x8, #0xe98]
10a9502a8: 953c2c70    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a9502ac: aa0003f4    	mov	x20, x0
10a9502b0: f00ac108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a9502b4: f9470100    	ldr	x0, [x8, #0xe00]
10a9502b8: 900aa768    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a9502bc: f9419101    	ldr	x1, [x8, #0x320] ; pageScopeWidthFor:
10a9502c0: aa1303e2    	mov	x2, x19
10a9502c4: 953c2c60    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9502c8: 1e604002    	fmov	d2, d0
10a9502cc: d00abd88    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10a9502d0: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
10a9502d4: 9e6703e0    	fmov	d0, xzr
10a9502d8: 9e6703e1    	fmov	d1, xzr
10a9502dc: aa1403e0    	mov	x0, x20
10a9502e0: 1e604103    	fmov	d3, d8
10a9502e4: 953c2c58    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9502e8: f87b6a68    	ldr	x8, [x19, x27]
10a9502ec: f83b6a60    	str	x0, [x19, x27]
10a9502f0: aa0803e0    	mov	x0, x8
10a9502f4: 953c2c5a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9502f8: f87b6a74    	ldr	x20, [x19, x27]
10a9502fc: f87c6a60    	ldr	x0, [x19, x28]
10a950300: 900aa768    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a950304: f940d501    	ldr	x1, [x8, #0x1a8] ; getTableView
10a950308: 953c2c4f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95030c: aa1d03fd    	mov	x29, x29
10a950310: 953c2c50    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a950314: aa0003f5    	mov	x21, x0
10a950318: d00aa7e8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
10a95031c: f9406d01    	ldr	x1, [x8, #0xd8] ; setTableFooterView:
10a950320: aa1403e2    	mov	x2, x20
10a950324: 953c2c48    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950328: aa1503e0    	mov	x0, x21
10a95032c: 953c2c4c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a950330: 900abb08    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a950334: f9455d01    	ldr	x1, [x8, #0xab8] ; initFooterStackView
10a950338: aa1303e0    	mov	x0, x19
10a95033c: 953c2c42    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950340: f00ab268    	adrp	x8, 0x11ff9f000 <dyld_stub_binder+0x11ff9f000>
10a950344: f9407501    	ldr	x1, [x8, #0xe8] ; initFooterBtnArea
10a950348: aa1303e0    	mov	x0, x19
10a95034c: 953c2c3e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950350: 900abb08    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a950354: f9456101    	ldr	x1, [x8, #0xac0] ; initOverSeasWechatLabel
10a950358: aa1303e0    	mov	x0, x19
10a95035c: 953c2c3a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950360: 900abb08    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a950364: f9454d01    	ldr	x1, [x8, #0xa98] ; checkShareCardEffective
10a950368: aa1303e0    	mov	x0, x19
10a95036c: 953c2c36    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950370: 370000a0    	tbnz	w0, #0x0, 0x10a950384 <_Flutter_MMFoundation_BindContext+0x6e2bf68>
10a950374: 900abb08    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a950378: f9456501    	ldr	x1, [x8, #0xac8] ; initShareCardAddErrorTipsLabel
10a95037c: aa1303e0    	mov	x0, x19
10a950380: 953c2c31    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950384: f00ac468    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a950388: 91093108    	add	x8, x8, #0x24c
10a95038c: b9800108    	ldrsw	x8, [x8]
10a950390: f8686a60    	ldr	x0, [x19, x8]
10a950394: f00aa7c8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
10a950398: f9414101    	ldr	x1, [x8, #0x280] ; isBlack
10a95039c: 953c2c2a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9503a0: 340000a0    	cbz	w0, 0x10a9503b4 <_Flutter_MMFoundation_BindContext+0x6e2bf98>
10a9503a4: f00ab268    	adrp	x8, 0x11ff9f000 <dyld_stub_binder+0x11ff9f000>
10a9503a8: f9407901    	ldr	x1, [x8, #0xf0] ; initBlackListTipsLabel
10a9503ac: aa1303e0    	mov	x0, x19
10a9503b0: 953c2c25    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9503b4: 900abb08    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a9503b8: f9456901    	ldr	x1, [x8, #0xad0] ; initQuitRoomTipsLabel
10a9503bc: aa1303e0    	mov	x0, x19
10a9503c0: 953c2c21    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9503c4: 900abb08    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a9503c8: f9456d01    	ldr	x1, [x8, #0xad8] ; updateFooterViewHeightForContentIfNeeded
10a9503cc: aa1303e0    	mov	x0, x19
10a9503d0: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10a9503d4: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10a9503d8: a94457f6    	ldp	x22, x21, [sp, #0x40]
10a9503dc: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10a9503e0: a94267fa    	ldp	x26, x25, [sp, #0x20]
10a9503e4: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10a9503e8: 6cc723e9    	ldp	d9, d8, [sp], #0x70
10a9503ec: 153c2c16    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
