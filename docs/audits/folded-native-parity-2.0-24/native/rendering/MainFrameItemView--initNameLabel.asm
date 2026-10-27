
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a8d974: d10283ff    	sub	sp, sp, #0xa0
104a8d978: 6d0323e9    	stp	d9, d8, [sp, #0x30]
104a8d97c: a9046ffc    	stp	x28, x27, [sp, #0x40]
104a8d980: a90567fa    	stp	x26, x25, [sp, #0x50]
104a8d984: a9065ff8    	stp	x24, x23, [sp, #0x60]
104a8d988: a90757f6    	stp	x22, x21, [sp, #0x70]
104a8d98c: a9084ff4    	stp	x20, x19, [sp, #0x80]
104a8d990: a9097bfd    	stp	x29, x30, [sp, #0x90]
104a8d994: 910243fd    	add	x29, sp, #0x90
104a8d998: aa0003f3    	mov	x19, x0
104a8d99c: b00e0d88    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a8d9a0: 52800029    	mov	w9, #0x1                ; =1
104a8d9a4: 390c7109    	strb	w9, [x8, #0x31c]
104a8d9a8: f00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8d9ac: f940c900    	ldr	x0, [x8, #0x190] ; MMCPLabel
104a8d9b0: 94c665ec    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104a8d9b4: f90017e0    	str	x0, [sp, #0x28]
104a8d9b8: d00dbca8    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a8d9bc: b9826915    	ldrsw	x21, [x8, #0x268]
104a8d9c0: f8756a60    	ldr	x0, [x19, x21]
104a8d9c4: 900db3a8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104a8d9c8: f945a114    	ldr	x20, [x8, #0xb40] ; frame
104a8d9cc: aa1403e1    	mov	x1, x20
104a8d9d0: 94c665db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8d9d4: 1e604008    	fmov	d8, d0
104a8d9d8: f8756a60    	ldr	x0, [x19, x21]
104a8d9dc: aa1403e1    	mov	x1, x20
104a8d9e0: 94c665d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8d9e4: 1e622908    	fadd	d8, d8, d2
104a8d9e8: f00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8d9ec: f9403d1a    	ldr	x26, [x8, #0x78] ; MMThemeUtil
104a8d9f0: d00db728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a8d9f4: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a8d9f8: aa0803fb    	mov	x27, x8
104a8d9fc: f00db388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a8da00: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
104a8da04: aa1503e1    	mov	x1, x21
104a8da08: f9000bf5    	str	x21, [sp, #0x10]
104a8da0c: 94c665cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8da10: aa1d03fd    	mov	x29, x29
104a8da14: 94c665cd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8da18: aa0003f4    	mov	x20, x0
104a8da1c: f90013e0    	str	x0, [sp, #0x20]
104a8da20: f00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8da24: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
104a8da28: d00db388    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a8da2c: f947ad16    	ldr	x22, [x8, #0xf58] ; class
104a8da30: aa1603e1    	mov	x1, x22
104a8da34: f90007f6    	str	x22, [sp, #0x8]
104a8da38: 94c665c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8da3c: aa0003e2    	mov	x2, x0
104a8da40: 900d9d68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a8da44: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
104a8da48: aa1403e0    	mov	x0, x20
104a8da4c: aa1803e1    	mov	x1, x24
104a8da50: 94c665bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8da54: aa1d03fd    	mov	x29, x29
104a8da58: 94c665bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8da5c: f9000fe0    	str	x0, [sp, #0x18]
104a8da60: d00d9d68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a8da64: f947fd17    	ldr	x23, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
104a8da68: f00cd782    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a8da6c: 9123a042    	add	x2, x2, #0x8e8 ; CFString 'cell_namelabel_left_margin'
104a8da70: 900cd163    	adrp	x3, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
104a8da74: 9137a063    	add	x3, x3, #0xde8 ; CFString '#mainframe_table'
104a8da78: aa1703e1    	mov	x1, x23
104a8da7c: 94c665b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8da80: aa1d03fd    	mov	x29, x29
104a8da84: 94c665b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8da88: aa0003e2    	mov	x2, x0
104a8da8c: f90003e0    	str	x0, [sp]
104a8da90: f00d9d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a8da94: f9400119    	ldr	x25, [x8]
104a8da98: aa1a03e0    	mov	x0, x26
104a8da9c: aa1903e1    	mov	x1, x25
104a8daa0: 94c665a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8daa4: 1e602908    	fadd	d8, d8, d0
104a8daa8: d00db728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a8daac: f946191c    	ldr	x28, [x8, #0xc30]
104a8dab0: f00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8dab4: f9403d14    	ldr	x20, [x8, #0x78] ; MMThemeUtil
104a8dab8: f945eb60    	ldr	x0, [x27, #0xbd0]
104a8dabc: aa1503e1    	mov	x1, x21
104a8dac0: 94c6659f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dac4: aa1d03fd    	mov	x29, x29
104a8dac8: 94c665a0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8dacc: aa0003fb    	mov	x27, x0
104a8dad0: f00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8dad4: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
104a8dad8: aa1603e1    	mov	x1, x22
104a8dadc: 94c66598    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dae0: aa0003e2    	mov	x2, x0
104a8dae4: aa1b03e0    	mov	x0, x27
104a8dae8: aa1803f6    	mov	x22, x24
104a8daec: aa1803e1    	mov	x1, x24
104a8daf0: 94c66593    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8daf4: aa1d03fd    	mov	x29, x29
104a8daf8: 94c66594    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8dafc: aa0003fa    	mov	x26, x0
104a8db00: f00cd782    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a8db04: 91232042    	add	x2, x2, #0x8c8 ; CFString 'cell_msglabel_top_margin'
104a8db08: aa1703e1    	mov	x1, x23
104a8db0c: 900cd163    	adrp	x3, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
104a8db10: 9137a063    	add	x3, x3, #0xde8 ; CFString '#mainframe_table'
104a8db14: 94c6658a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8db18: aa1d03fd    	mov	x29, x29
104a8db1c: 94c6658b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8db20: aa0003f5    	mov	x21, x0
104a8db24: aa1403e0    	mov	x0, x20
104a8db28: aa1903e1    	mov	x1, x25
104a8db2c: aa1503e2    	mov	x2, x21
104a8db30: 94c66583    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8db34: 900d9d68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a8db38: f9463114    	ldr	x20, [x8, #0xc60] ; dynamicLength:
104a8db3c: aa1c03e0    	mov	x0, x28
104a8db40: aa1403e1    	mov	x1, x20
104a8db44: 94c6657e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8db48: 1e604009    	fmov	d9, d0
104a8db4c: d00db738    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104a8db50: f9461b00    	ldr	x0, [x24, #0xc30]
104a8db54: 1e673000    	fmov	d0, #25.00000000
104a8db58: aa1403e1    	mov	x1, x20
104a8db5c: 94c66578    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8db60: 1e604003    	fmov	d3, d0
104a8db64: b00db3a8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104a8db68: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
104a8db6c: b00a17a8    	adrp	x8, 0x118d82000 <dyld_stub_binder+0x118d82000>
104a8db70: fd41e902    	ldr	d2, [x8, #0x3d0]
104a8db74: f94017e0    	ldr	x0, [sp, #0x28]
104a8db78: 1e604100    	fmov	d0, d8
104a8db7c: 1e604121    	fmov	d1, d9
104a8db80: 94c6656f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8db84: d00dbca8    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a8db88: b9826d1c    	ldrsw	x28, [x8, #0x26c]
104a8db8c: f87c6a68    	ldr	x8, [x19, x28]
104a8db90: f83c6a60    	str	x0, [x19, x28]
104a8db94: aa0803e0    	mov	x0, x8
104a8db98: 94c6656f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8db9c: aa1503e0    	mov	x0, x21
104a8dba0: 94c6656d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dba4: aa1a03e0    	mov	x0, x26
104a8dba8: 94c6656b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dbac: aa1b03e0    	mov	x0, x27
104a8dbb0: 94c66569    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dbb4: f94003e0    	ldr	x0, [sp]
104a8dbb8: 94c66567    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dbbc: f9400fe0    	ldr	x0, [sp, #0x18]
104a8dbc0: 94c66565    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dbc4: f94013e0    	ldr	x0, [sp, #0x20]
104a8dbc8: 94c66563    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dbcc: f87c6a60    	ldr	x0, [x19, x28]
104a8dbd0: 900db3e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104a8dbd4: f9469101    	ldr	x1, [x8, #0xd20] ; setTextAlignment:
104a8dbd8: d2800002    	mov	x2, #0x0                ; =0
104a8dbdc: 94c66558    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dbe0: f9461b15    	ldr	x21, [x24, #0xc30]
104a8dbe4: f00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8dbe8: f9403d18    	ldr	x24, [x8, #0x78] ; MMThemeUtil
104a8dbec: d00db728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a8dbf0: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a8dbf4: f9400be1    	ldr	x1, [sp, #0x10]
104a8dbf8: 94c66551    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dbfc: aa1d03fd    	mov	x29, x29
104a8dc00: 94c66552    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8dc04: aa0003f4    	mov	x20, x0
104a8dc08: f00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8dc0c: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
104a8dc10: f94007e1    	ldr	x1, [sp, #0x8]
104a8dc14: 94c6654a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dc18: aa0003e2    	mov	x2, x0
104a8dc1c: aa1403e0    	mov	x0, x20
104a8dc20: aa1603e1    	mov	x1, x22
104a8dc24: 94c66546    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dc28: aa1d03fd    	mov	x29, x29
104a8dc2c: 94c66547    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8dc30: aa0003f6    	mov	x22, x0
104a8dc34: b00cd8a2    	adrp	x2, 0x11e5a2000 <dyld_stub_binder+0x11e5a2000>
104a8dc38: 9114a042    	add	x2, x2, #0x528 ; CFString 'cell_msglabel_textsize'
104a8dc3c: aa1703e1    	mov	x1, x23
104a8dc40: 900cd163    	adrp	x3, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
104a8dc44: 9137a063    	add	x3, x3, #0xde8 ; CFString '#mainframe_table'
104a8dc48: 94c6653d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dc4c: aa1d03fd    	mov	x29, x29
104a8dc50: 94c6653e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8dc54: aa0003f7    	mov	x23, x0
104a8dc58: aa1803e0    	mov	x0, x24
104a8dc5c: aa1903e1    	mov	x1, x25
104a8dc60: aa1703e2    	mov	x2, x23
104a8dc64: 94c66536    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dc68: f00d9d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a8dc6c: f9401101    	ldr	x1, [x8, #0x20] ; dynamicSettingFont:
104a8dc70: aa1503e0    	mov	x0, x21
104a8dc74: 94c66532    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dc78: aa1d03fd    	mov	x29, x29
104a8dc7c: 94c66533    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8dc80: aa0003f5    	mov	x21, x0
104a8dc84: f87c6a60    	ldr	x0, [x19, x28]
104a8dc88: f00db3c8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a8dc8c: f9400501    	ldr	x1, [x8, #0x8] ; setFont:
104a8dc90: aa1503e2    	mov	x2, x21
104a8dc94: 94c6652a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dc98: aa1503e0    	mov	x0, x21
104a8dc9c: 94c6652e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dca0: aa1703e0    	mov	x0, x23
104a8dca4: 94c6652c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dca8: aa1603e0    	mov	x0, x22
104a8dcac: 94c6652a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dcb0: aa1403e0    	mov	x0, x20
104a8dcb4: 94c66528    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dcb8: b00da108    	adrp	x8, 0x11feae000 <dyld_stub_binder+0x11feae000>
104a8dcbc: f941d101    	ldr	x1, [x8, #0x3a0] ; getLabelNameColor
104a8dcc0: aa1303e0    	mov	x0, x19
104a8dcc4: 94c6651e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dcc8: aa1d03fd    	mov	x29, x29
104a8dccc: 94c6651f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8dcd0: aa0003f4    	mov	x20, x0
104a8dcd4: f87c6a60    	ldr	x0, [x19, x28]
104a8dcd8: 900db3e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104a8dcdc: f9469501    	ldr	x1, [x8, #0xd28] ; setTextColor:
104a8dce0: aa1403e2    	mov	x2, x20
104a8dce4: 94c66516    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dce8: aa1403e0    	mov	x0, x20
104a8dcec: 94c6651a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dcf0: d00db728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a8dcf4: f9462100    	ldr	x0, [x8, #0xc40] ; MMTableViewCell
104a8dcf8: f00d9d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a8dcfc: f9400d01    	ldr	x1, [x8, #0x18] ; getCellTextHightlightedColor
104a8dd00: 94c6650f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dd04: aa1d03fd    	mov	x29, x29
104a8dd08: 94c66510    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8dd0c: aa0003f4    	mov	x20, x0
104a8dd10: f87c6a60    	ldr	x0, [x19, x28]
104a8dd14: f00db3c8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a8dd18: f9412101    	ldr	x1, [x8, #0x240] ; setHighlightedTextColor:
104a8dd1c: aa1403e2    	mov	x2, x20
104a8dd20: 94c66507    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dd24: aa1403e0    	mov	x0, x20
104a8dd28: 94c6650b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dd2c: f87c6a62    	ldr	x2, [x19, x28]
104a8dd30: b00db388    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104a8dd34: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
104a8dd38: aa1303e0    	mov	x0, x19
104a8dd3c: a9497bfd    	ldp	x29, x30, [sp, #0x90]
104a8dd40: a9484ff4    	ldp	x20, x19, [sp, #0x80]
104a8dd44: a94757f6    	ldp	x22, x21, [sp, #0x70]
104a8dd48: a9465ff8    	ldp	x24, x23, [sp, #0x60]
104a8dd4c: a94567fa    	ldp	x26, x25, [sp, #0x50]
104a8dd50: a9446ffc    	ldp	x28, x27, [sp, #0x40]
104a8dd54: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
104a8dd58: 910283ff    	add	sp, sp, #0xa0
104a8dd5c: 14c664f8    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
