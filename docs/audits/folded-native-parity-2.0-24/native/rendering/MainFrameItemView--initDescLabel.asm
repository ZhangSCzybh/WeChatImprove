
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a8dd60: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
104a8dd64: a9015ff8    	stp	x24, x23, [sp, #0x10]
104a8dd68: a90257f6    	stp	x22, x21, [sp, #0x20]
104a8dd6c: a9034ff4    	stp	x20, x19, [sp, #0x30]
104a8dd70: a9047bfd    	stp	x29, x30, [sp, #0x40]
104a8dd74: 910103fd    	add	x29, sp, #0x40
104a8dd78: aa0003f3    	mov	x19, x0
104a8dd7c: b00e0d88    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a8dd80: 52800029    	mov	w9, #0x1                ; =1
104a8dd84: 390c7509    	strb	w9, [x8, #0x31d]
104a8dd88: f00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8dd8c: f940c900    	ldr	x0, [x8, #0x190] ; MMCPLabel
104a8dd90: 94c664f4    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104a8dd94: aa0003f4    	mov	x20, x0
104a8dd98: d00db735    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
104a8dd9c: f9461aa0    	ldr	x0, [x21, #0xc30]
104a8dda0: 900d9d68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a8dda4: f9463101    	ldr	x1, [x8, #0xc60] ; dynamicLength:
104a8dda8: 1e673000    	fmov	d0, #25.00000000
104a8ddac: 94c664e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8ddb0: 1e604003    	fmov	d3, d0
104a8ddb4: b00db3a8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104a8ddb8: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
104a8ddbc: b00a17a8    	adrp	x8, 0x118d82000 <dyld_stub_binder+0x118d82000>
104a8ddc0: fd41e902    	ldr	d2, [x8, #0x3d0]
104a8ddc4: 9e6703e0    	fmov	d0, xzr
104a8ddc8: 9e6703e1    	fmov	d1, xzr
104a8ddcc: aa1403e0    	mov	x0, x20
104a8ddd0: 94c664db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8ddd4: d00dbca8    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a8ddd8: b9827119    	ldrsw	x25, [x8, #0x270]
104a8dddc: f8796a68    	ldr	x8, [x19, x25]
104a8dde0: f8396a60    	str	x0, [x19, x25]
104a8dde4: aa0803e0    	mov	x0, x8
104a8dde8: 94c664db    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8ddec: f8796a62    	ldr	x2, [x19, x25]
104a8ddf0: b00db388    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104a8ddf4: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
104a8ddf8: aa1303e0    	mov	x0, x19
104a8ddfc: 94c664d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8de00: f8796a60    	ldr	x0, [x19, x25]
104a8de04: 900db3e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104a8de08: f9469101    	ldr	x1, [x8, #0xd20] ; setTextAlignment:
104a8de0c: d2800002    	mov	x2, #0x0                ; =0
104a8de10: 94c664cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8de14: f9461ab5    	ldr	x21, [x21, #0xc30]
104a8de18: f00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8de1c: f9403d16    	ldr	x22, [x8, #0x78] ; MMThemeUtil
104a8de20: d00db728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a8de24: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a8de28: f00db388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a8de2c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104a8de30: 94c664c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8de34: aa1d03fd    	mov	x29, x29
104a8de38: 94c664c4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8de3c: aa0003f4    	mov	x20, x0
104a8de40: f00db728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a8de44: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
104a8de48: d00db388    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a8de4c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104a8de50: 94c664bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8de54: aa0003e2    	mov	x2, x0
104a8de58: 900d9d68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a8de5c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104a8de60: aa1403e0    	mov	x0, x20
104a8de64: 94c664b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8de68: aa1d03fd    	mov	x29, x29
104a8de6c: 94c664b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8de70: aa0003f7    	mov	x23, x0
104a8de74: d00d9d68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a8de78: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
104a8de7c: d00cde82    	adrp	x2, 0x11e65f000 <dyld_stub_binder+0x11e65f000>
104a8de80: 91262042    	add	x2, x2, #0x988 ; CFString 'cell_msglabel_desc_textsize'
104a8de84: 900cd163    	adrp	x3, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
104a8de88: 9137a063    	add	x3, x3, #0xde8 ; CFString '#mainframe_table'
104a8de8c: 94c664ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8de90: aa1d03fd    	mov	x29, x29
104a8de94: 94c664ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8de98: aa0003f8    	mov	x24, x0
104a8de9c: f00d9d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a8dea0: f9400101    	ldr	x1, [x8]
104a8dea4: aa1603e0    	mov	x0, x22
104a8dea8: aa1803e2    	mov	x2, x24
104a8deac: 94c664a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8deb0: f00d9d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a8deb4: f9401101    	ldr	x1, [x8, #0x20] ; dynamicSettingFont:
104a8deb8: aa1503e0    	mov	x0, x21
104a8debc: 94c664a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dec0: aa1d03fd    	mov	x29, x29
104a8dec4: 94c664a1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a8dec8: aa0003f5    	mov	x21, x0
104a8decc: f8796a60    	ldr	x0, [x19, x25]
104a8ded0: f00db3c8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a8ded4: f9400501    	ldr	x1, [x8, #0x8] ; setFont:
104a8ded8: aa1503e2    	mov	x2, x21
104a8dedc: 94c66498    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a8dee0: aa1503e0    	mov	x0, x21
104a8dee4: 94c6649c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8dee8: aa1803e0    	mov	x0, x24
104a8deec: 94c6649a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8def0: aa1703e0    	mov	x0, x23
104a8def4: 94c66498    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8def8: aa1403e0    	mov	x0, x20
104a8defc: 94c66496    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a8df00: f8796a60    	ldr	x0, [x19, x25]
104a8df04: f00db3c8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104a8df08: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
104a8df0c: 52800022    	mov	w2, #0x1                ; =1
104a8df10: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104a8df14: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104a8df18: a94257f6    	ldp	x22, x21, [sp, #0x20]
104a8df1c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104a8df20: a8c567fa    	ldp	x26, x25, [sp], #0x50
104a8df24: 14c66486    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
