
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1067face8: d10283ff    	sub	sp, sp, #0xa0
1067facec: a9046ffc    	stp	x28, x27, [sp, #0x40]
1067facf0: a90567fa    	stp	x26, x25, [sp, #0x50]
1067facf4: a9065ff8    	stp	x24, x23, [sp, #0x60]
1067facf8: a90757f6    	stp	x22, x21, [sp, #0x70]
1067facfc: a9084ff4    	stp	x20, x19, [sp, #0x80]
1067fad00: a9097bfd    	stp	x29, x30, [sp, #0x90]
1067fad04: 910243fd    	add	x29, sp, #0x90
1067fad08: aa0003f3    	mov	x19, x0
1067fad0c: d00d2248    	adrp	x8, 0x120c44000 <dyld_stub_binder+0x120c44000>
1067fad10: 52800029    	mov	w9, #0x1                ; =1
1067fad14: 3934f109    	strb	w9, [x8, #0xd3c]
1067fad18: 900ccbe8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1067fad1c: f9465900    	ldr	x0, [x8, #0xcb0]
1067fad20: 9450b10e    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1067fad24: aa0003f4    	mov	x20, x0
1067fad28: b00ccd08    	adrp	x8, 0x12019b000 <dyld_stub_binder+0x12019b000>
1067fad2c: f940c900    	ldr	x0, [x8, #0x190]
1067fad30: 9450b10c    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1067fad34: b00cb288    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1067fad38: f9450901    	ldr	x1, [x8, #0xa10] ; initWithType:
1067fad3c: f90007e1    	str	x1, [sp, #0x8]
1067fad40: 52800022    	mov	w2, #0x1                ; =1
1067fad44: 9450b0fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fad48: aa0003f7    	mov	x23, x0
1067fad4c: b00ccbc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1067fad50: f9458900    	ldr	x0, [x8, #0xb10]
1067fad54: d00cc848    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1067fad58: f947c101    	ldr	x1, [x8, #0xf80] ; numberWithUnsignedInteger:
1067fad5c: f9000fe1    	str	x1, [sp, #0x18]
1067fad60: 52800022    	mov	w2, #0x1                ; =1
1067fad64: 9450b0f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fad68: aa1d03fd    	mov	x29, x29
1067fad6c: 9450b0f7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fad70: aa0003f8    	mov	x24, x0
1067fad74: f00cc868    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1067fad78: f9400901    	ldr	x1, [x8, #0x10] ; setObject:forKey:
1067fad7c: f9000bf4    	str	x20, [sp, #0x10]
1067fad80: aa1403e0    	mov	x0, x20
1067fad84: aa1703e2    	mov	x2, x23
1067fad88: aa1803e3    	mov	x3, x24
1067fad8c: 9450b0ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fad90: aa1803e0    	mov	x0, x24
1067fad94: 9450b0f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fad98: aa1703e0    	mov	x0, x23
1067fad9c: 9450b0ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fada0: b00cc828    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1067fada4: f947ad17    	ldr	x23, [x8, #0xf58] ; class
1067fada8: aa1303e0    	mov	x0, x19
1067fadac: aa1703e1    	mov	x1, x23
1067fadb0: 9450b0e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fadb4: aa0003fa    	mov	x26, x0
1067fadb8: f00cb208    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1067fadbc: f943c118    	ldr	x24, [x8, #0x780] ; dataItem
1067fadc0: aa1303e0    	mov	x0, x19
1067fadc4: aa1803e1    	mov	x1, x24
1067fadc8: 9450b0dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fadcc: aa1d03fd    	mov	x29, x29
1067fadd0: 9450b0de    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fadd4: aa0003fb    	mov	x27, x0
1067fadd8: f00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067faddc: f9426d19    	ldr	x25, [x8, #0x4d8] ; pageContext
1067fade0: aa1303e0    	mov	x0, x19
1067fade4: aa1903e1    	mov	x1, x25
1067fade8: 9450b0d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fadec: aa1d03fd    	mov	x29, x29
1067fadf0: 9450b0d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fadf4: aa0003fc    	mov	x28, x0
1067fadf8: f00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067fadfc: f9427101    	ldr	x1, [x8, #0x4e0] ; showsIndividualSourceWithDataItem:pageContext:
1067fae00: aa1a03e0    	mov	x0, x26
1067fae04: aa1b03e2    	mov	x2, x27
1067fae08: aa1c03e3    	mov	x3, x28
1067fae0c: 9450b0cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fae10: aa0003fa    	mov	x26, x0
1067fae14: aa1c03e0    	mov	x0, x28
1067fae18: 9450b0cf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fae1c: aa1b03e0    	mov	x0, x27
1067fae20: 9450b0cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fae24: 3400027a    	cbz	w26, 0x1067fae70 <_Flutter_MMFoundation_BindContext+0x2cd6a54>
1067fae28: b00ccbc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1067fae2c: f9453500    	ldr	x0, [x8, #0xa68]
1067fae30: f00cb1e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1067fae34: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1067fae38: b00c05a8    	adrp	x8, 0x11e8af000 <dyld_stub_binder+0x11e8af000>
1067fae3c: 91152108    	add	x8, x8, #0x548
1067fae40: f90003e8    	str	x8, [sp]
1067fae44: d00a5103    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
1067fae48: 912b2863    	add	x3, x3, #0xaca
1067fae4c: b00a9045    	adrp	x5, 0x11ba03000 <dyld_stub_binder+0x11ba03000>
1067fae50: 911b1ca5    	add	x5, x5, #0x6c7
1067fae54: b00a9047    	adrp	x7, 0x11ba03000 <dyld_stub_binder+0x11ba03000>
1067fae58: 911b60e7    	add	x7, x7, #0x6d8
1067fae5c: 52800042    	mov	w2, #0x2                ; =2
1067fae60: 52800004    	mov	w4, #0x0                ; =0
1067fae64: 52803086    	mov	w6, #0x184              ; =388
1067fae68: 9450b0b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fae6c: 1400005f    	b	0x1067fafe8 <_Flutter_MMFoundation_BindContext+0x2cd6bcc>
1067fae70: f9001fff    	str	xzr, [sp, #0x38]
1067fae74: aa1303e0    	mov	x0, x19
1067fae78: aa1703e1    	mov	x1, x23
1067fae7c: 9450b0b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fae80: aa0003fa    	mov	x26, x0
1067fae84: aa1303e0    	mov	x0, x19
1067fae88: aa1803e1    	mov	x1, x24
1067fae8c: 9450b0ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fae90: aa1d03fd    	mov	x29, x29
1067fae94: 9450b0ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fae98: aa0003f5    	mov	x21, x0
1067fae9c: a902ffff    	stp	xzr, xzr, [sp, #0x28]
1067faea0: f90013ff    	str	xzr, [sp, #0x20]
1067faea4: aa1303e0    	mov	x0, x19
1067faea8: aa1903e1    	mov	x1, x25
1067faeac: 9450b0a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067faeb0: aa1d03fd    	mov	x29, x29
1067faeb4: 9450b0a5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067faeb8: aa0003f6    	mov	x22, x0
1067faebc: f00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067faec0: f9427501    	ldr	x1, [x8, #0x4e8] ; canShowSourceWithDataItem:showType:text:url:backupUrl:pageContext:
1067faec4: 9100e3e3    	add	x3, sp, #0x38
1067faec8: 9100c3e4    	add	x4, sp, #0x30
1067faecc: 9100a3e5    	add	x5, sp, #0x28
1067faed0: 910083e6    	add	x6, sp, #0x20
1067faed4: aa1a03e0    	mov	x0, x26
1067faed8: aa1503e2    	mov	x2, x21
1067faedc: aa1603e7    	mov	x7, x22
1067faee0: 9450b097    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067faee4: aa0003f4    	mov	x20, x0
1067faee8: f9401bfa    	ldr	x26, [sp, #0x30]
1067faeec: aa1a03e0    	mov	x0, x26
1067faef0: 9450b092    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1067faef4: f94017fb    	ldr	x27, [sp, #0x28]
1067faef8: aa1b03e0    	mov	x0, x27
1067faefc: 9450b08f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1067faf00: f94013fc    	ldr	x28, [sp, #0x20]
1067faf04: aa1c03e0    	mov	x0, x28
1067faf08: 9450b08c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1067faf0c: aa1603e0    	mov	x0, x22
1067faf10: 9450b091    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067faf14: aa1503e0    	mov	x0, x21
1067faf18: 9450b08f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067faf1c: 340005b4    	cbz	w20, 0x1067fafd0 <_Flutter_MMFoundation_BindContext+0x2cd6bb4>
1067faf20: b00ccd08    	adrp	x8, 0x12019b000 <dyld_stub_binder+0x12019b000>
1067faf24: f940cd00    	ldr	x0, [x8, #0x198]
1067faf28: 9450b08e    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1067faf2c: f94007e1    	ldr	x1, [sp, #0x8]
1067faf30: 52800042    	mov	w2, #0x2                ; =2
1067faf34: 9450b082    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067faf38: aa0003f4    	mov	x20, x0
1067faf3c: f9401fe2    	ldr	x2, [sp, #0x38]
1067faf40: f00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067faf44: f9427901    	ldr	x1, [x8, #0x4f0] ; setSourceShowType:
1067faf48: 9450b07d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067faf4c: f00cb228    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
1067faf50: f940dd01    	ldr	x1, [x8, #0x1b8] ; setSourceText:
1067faf54: aa1403e0    	mov	x0, x20
1067faf58: aa1a03e2    	mov	x2, x26
1067faf5c: 9450b078    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067faf60: f00cb368    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
1067faf64: f941b901    	ldr	x1, [x8, #0x370] ; setSourceUrl:
1067faf68: aa1403e0    	mov	x0, x20
1067faf6c: aa1b03e2    	mov	x2, x27
1067faf70: 9450b073    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067faf74: f00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067faf78: f9427d01    	ldr	x1, [x8, #0x4f8] ; setSourceBackupUrl:
1067faf7c: aa1403e0    	mov	x0, x20
1067faf80: aa1c03e2    	mov	x2, x28
1067faf84: 9450b06e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067faf88: b00ccbc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1067faf8c: f9458900    	ldr	x0, [x8, #0xb10]
1067faf90: f9400fe1    	ldr	x1, [sp, #0x18]
1067faf94: 52800042    	mov	w2, #0x2                ; =2
1067faf98: 9450b069    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067faf9c: aa1d03fd    	mov	x29, x29
1067fafa0: 9450b06a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fafa4: aa0003f5    	mov	x21, x0
1067fafa8: f00cb1e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1067fafac: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
1067fafb0: f9400be0    	ldr	x0, [sp, #0x10]
1067fafb4: aa1403e2    	mov	x2, x20
1067fafb8: aa1503e3    	mov	x3, x21
1067fafbc: 9450b060    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fafc0: aa1503e0    	mov	x0, x21
1067fafc4: 9450b064    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fafc8: aa1403e0    	mov	x0, x20
1067fafcc: 9450b062    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fafd0: aa1c03e0    	mov	x0, x28
1067fafd4: 9450b060    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fafd8: aa1b03e0    	mov	x0, x27
1067fafdc: 9450b05e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fafe0: aa1a03e0    	mov	x0, x26
1067fafe4: 9450b05c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fafe8: aa1303e0    	mov	x0, x19
1067fafec: aa1703e1    	mov	x1, x23
1067faff0: 9450b053    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067faff4: aa0003f4    	mov	x20, x0
1067faff8: aa1303e0    	mov	x0, x19
1067faffc: aa1803e1    	mov	x1, x24
1067fb000: 9450b04f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb004: aa1d03fd    	mov	x29, x29
1067fb008: 9450b050    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb00c: aa0003f5    	mov	x21, x0
1067fb010: aa1303e0    	mov	x0, x19
1067fb014: aa1903e1    	mov	x1, x25
1067fb018: 9450b049    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb01c: aa1d03fd    	mov	x29, x29
1067fb020: 9450b04a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb024: aa0003f6    	mov	x22, x0
1067fb028: d00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067fb02c: f9428101    	ldr	x1, [x8, #0x500] ; canShowWeAppInfoWithDataItem:pageContext:
1067fb030: aa1403e0    	mov	x0, x20
1067fb034: aa1503e2    	mov	x2, x21
1067fb038: aa1603e3    	mov	x3, x22
1067fb03c: 9450b040    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb040: aa0003f4    	mov	x20, x0
1067fb044: aa1603e0    	mov	x0, x22
1067fb048: 9450b043    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb04c: aa1503e0    	mov	x0, x21
1067fb050: 9450b041    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb054: a940ebfb    	ldp	x27, x26, [sp, #0x8]
1067fb058: 900ccd1c    	adrp	x28, 0x12019b000 <dyld_stub_binder+0x12019b000>
1067fb05c: 34000334    	cbz	w20, 0x1067fb0c0 <_Flutter_MMFoundation_BindContext+0x2cd6ca4>
1067fb060: f940cb80    	ldr	x0, [x28, #0x190]
1067fb064: 9450b03f    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1067fb068: aa1b03e1    	mov	x1, x27
1067fb06c: 52800062    	mov	w2, #0x3                ; =3
1067fb070: 9450b033    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb074: aa0003f4    	mov	x20, x0
1067fb078: 900ccbc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1067fb07c: f9458900    	ldr	x0, [x8, #0xb10]
1067fb080: f9400fe1    	ldr	x1, [sp, #0x18]
1067fb084: 52800062    	mov	w2, #0x3                ; =3
1067fb088: 9450b02d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb08c: aa1d03fd    	mov	x29, x29
1067fb090: 9450b02e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb094: aa0003f5    	mov	x21, x0
1067fb098: d00cb1e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1067fb09c: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
1067fb0a0: aa1a03e0    	mov	x0, x26
1067fb0a4: aa1403e2    	mov	x2, x20
1067fb0a8: aa1503e3    	mov	x3, x21
1067fb0ac: 9450b024    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb0b0: aa1503e0    	mov	x0, x21
1067fb0b4: 9450b028    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb0b8: aa1403e0    	mov	x0, x20
1067fb0bc: 9450b026    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb0c0: aa1303e0    	mov	x0, x19
1067fb0c4: aa1703e1    	mov	x1, x23
1067fb0c8: 9450b01d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb0cc: aa0003f4    	mov	x20, x0
1067fb0d0: aa1303e0    	mov	x0, x19
1067fb0d4: aa1803e1    	mov	x1, x24
1067fb0d8: 9450b019    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb0dc: aa1d03fd    	mov	x29, x29
1067fb0e0: 9450b01a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb0e4: aa0003f5    	mov	x21, x0
1067fb0e8: aa1303e0    	mov	x0, x19
1067fb0ec: aa1903e1    	mov	x1, x25
1067fb0f0: 9450b013    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb0f4: aa1d03fd    	mov	x29, x29
1067fb0f8: 9450b014    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb0fc: aa0003f6    	mov	x22, x0
1067fb100: d00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067fb104: f9428501    	ldr	x1, [x8, #0x508] ; canShowLocationInfoWithDataItem:pageContext:
1067fb108: aa1403e0    	mov	x0, x20
1067fb10c: aa1503e2    	mov	x2, x21
1067fb110: aa1603e3    	mov	x3, x22
1067fb114: 9450b00a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb118: aa0003f4    	mov	x20, x0
1067fb11c: aa1603e0    	mov	x0, x22
1067fb120: 9450b00d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb124: aa1503e0    	mov	x0, x21
1067fb128: 9450b00b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb12c: f9400ff9    	ldr	x25, [sp, #0x18]
1067fb130: 34000334    	cbz	w20, 0x1067fb194 <_Flutter_MMFoundation_BindContext+0x2cd6d78>
1067fb134: f940cb80    	ldr	x0, [x28, #0x190]
1067fb138: 9450b00a    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1067fb13c: aa1b03e1    	mov	x1, x27
1067fb140: 528000e2    	mov	w2, #0x7                ; =7
1067fb144: 9450affe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb148: aa0003f4    	mov	x20, x0
1067fb14c: 900ccbc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1067fb150: f9458900    	ldr	x0, [x8, #0xb10]
1067fb154: aa1903e1    	mov	x1, x25
1067fb158: 528000e2    	mov	w2, #0x7                ; =7
1067fb15c: 9450aff8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb160: aa1d03fd    	mov	x29, x29
1067fb164: 9450aff9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb168: aa0003f5    	mov	x21, x0
1067fb16c: d00cb1e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1067fb170: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
1067fb174: aa1a03e0    	mov	x0, x26
1067fb178: aa1403e2    	mov	x2, x20
1067fb17c: aa1503e3    	mov	x3, x21
1067fb180: 9450afef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb184: aa1503e0    	mov	x0, x21
1067fb188: 9450aff3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb18c: aa1403e0    	mov	x0, x20
1067fb190: 9450aff1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb194: aa1303e0    	mov	x0, x19
1067fb198: aa1703e1    	mov	x1, x23
1067fb19c: 9450afe8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb1a0: aa0003f4    	mov	x20, x0
1067fb1a4: aa1303e0    	mov	x0, x19
1067fb1a8: aa1803e1    	mov	x1, x24
1067fb1ac: 9450afe4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb1b0: aa1d03fd    	mov	x29, x29
1067fb1b4: 9450afe5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb1b8: aa0003f5    	mov	x21, x0
1067fb1bc: f00cc848    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1067fb1c0: f9450901    	ldr	x1, [x8, #0xa10] ; scene
1067fb1c4: aa1303e0    	mov	x0, x19
1067fb1c8: 9450afdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb1cc: aa0003f6    	mov	x22, x0
1067fb1d0: d00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067fb1d4: f9428901    	ldr	x1, [x8, #0x510] ; isStarEnabled
1067fb1d8: aa1303e0    	mov	x0, x19
1067fb1dc: 9450afd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb1e0: aa0003e4    	mov	x4, x0
1067fb1e4: d00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067fb1e8: f9428d01    	ldr	x1, [x8, #0x518] ; canShowStarIconWithDataItem:scene:isStarEnabled:
1067fb1ec: aa1403e0    	mov	x0, x20
1067fb1f0: aa1503e2    	mov	x2, x21
1067fb1f4: aa1603e3    	mov	x3, x22
1067fb1f8: 9450afd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb1fc: aa0003f4    	mov	x20, x0
1067fb200: aa1503e0    	mov	x0, x21
1067fb204: 9450afd4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb208: 34000334    	cbz	w20, 0x1067fb26c <_Flutter_MMFoundation_BindContext+0x2cd6e50>
1067fb20c: f940cb80    	ldr	x0, [x28, #0x190]
1067fb210: 9450afd4    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1067fb214: aa1b03e1    	mov	x1, x27
1067fb218: 52800082    	mov	w2, #0x4                ; =4
1067fb21c: 9450afc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb220: aa0003f4    	mov	x20, x0
1067fb224: 900ccbc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1067fb228: f9458900    	ldr	x0, [x8, #0xb10]
1067fb22c: aa1903e1    	mov	x1, x25
1067fb230: 52800082    	mov	w2, #0x4                ; =4
1067fb234: 9450afc2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb238: aa1d03fd    	mov	x29, x29
1067fb23c: 9450afc3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb240: aa0003f5    	mov	x21, x0
1067fb244: d00cb1e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1067fb248: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
1067fb24c: aa1a03e0    	mov	x0, x26
1067fb250: aa1403e2    	mov	x2, x20
1067fb254: aa1503e3    	mov	x3, x21
1067fb258: 9450afb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb25c: aa1503e0    	mov	x0, x21
1067fb260: 9450afbd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb264: aa1403e0    	mov	x0, x20
1067fb268: 9450afbb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb26c: aa1303e0    	mov	x0, x19
1067fb270: aa1703e1    	mov	x1, x23
1067fb274: 9450afb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb278: aa0003f4    	mov	x20, x0
1067fb27c: aa1303e0    	mov	x0, x19
1067fb280: aa1803e1    	mov	x1, x24
1067fb284: 9450afae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb288: aa1d03fd    	mov	x29, x29
1067fb28c: 9450afaf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb290: aa0003f5    	mov	x21, x0
1067fb294: d00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067fb298: f9429101    	ldr	x1, [x8, #0x520] ; isDynamicTagEnabled
1067fb29c: aa1303e0    	mov	x0, x19
1067fb2a0: 9450afa7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb2a4: aa0003e3    	mov	x3, x0
1067fb2a8: d00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067fb2ac: f9429501    	ldr	x1, [x8, #0x528] ; canShowShareGroupButtonWithDataItem:isDynamicTagEnabled:
1067fb2b0: aa1403e0    	mov	x0, x20
1067fb2b4: aa1503e2    	mov	x2, x21
1067fb2b8: 9450afa1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb2bc: aa0003f4    	mov	x20, x0
1067fb2c0: aa1503e0    	mov	x0, x21
1067fb2c4: 9450afa4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb2c8: 34000334    	cbz	w20, 0x1067fb32c <_Flutter_MMFoundation_BindContext+0x2cd6f10>
1067fb2cc: f940cb80    	ldr	x0, [x28, #0x190]
1067fb2d0: 9450afa4    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1067fb2d4: aa1b03e1    	mov	x1, x27
1067fb2d8: 528000a2    	mov	w2, #0x5                ; =5
1067fb2dc: 9450af98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb2e0: aa0003f4    	mov	x20, x0
1067fb2e4: 900ccbc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1067fb2e8: f9458900    	ldr	x0, [x8, #0xb10]
1067fb2ec: aa1903e1    	mov	x1, x25
1067fb2f0: 528000a2    	mov	w2, #0x5                ; =5
1067fb2f4: 9450af92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb2f8: aa1d03fd    	mov	x29, x29
1067fb2fc: 9450af93    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb300: aa0003f5    	mov	x21, x0
1067fb304: d00cb1e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1067fb308: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
1067fb30c: aa1a03e0    	mov	x0, x26
1067fb310: aa1403e2    	mov	x2, x20
1067fb314: aa1503e3    	mov	x3, x21
1067fb318: 9450af89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb31c: aa1503e0    	mov	x0, x21
1067fb320: 9450af8d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb324: aa1403e0    	mov	x0, x20
1067fb328: 9450af8b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb32c: aa1303e0    	mov	x0, x19
1067fb330: aa1703e1    	mov	x1, x23
1067fb334: 9450af82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb338: aa0003f4    	mov	x20, x0
1067fb33c: aa1303e0    	mov	x0, x19
1067fb340: aa1803e1    	mov	x1, x24
1067fb344: 9450af7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb348: aa1d03fd    	mov	x29, x29
1067fb34c: 9450af7f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb350: aa0003f5    	mov	x21, x0
1067fb354: d00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067fb358: f9429901    	ldr	x1, [x8, #0x530] ; canShowDeleteButtonWithDataItem:
1067fb35c: aa1403e0    	mov	x0, x20
1067fb360: aa1503e2    	mov	x2, x21
1067fb364: 9450af76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb368: aa0003f4    	mov	x20, x0
1067fb36c: aa1503e0    	mov	x0, x21
1067fb370: 9450af79    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb374: 34000334    	cbz	w20, 0x1067fb3d8 <_Flutter_MMFoundation_BindContext+0x2cd6fbc>
1067fb378: f940cb80    	ldr	x0, [x28, #0x190]
1067fb37c: 9450af79    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1067fb380: aa1b03e1    	mov	x1, x27
1067fb384: 528000c2    	mov	w2, #0x6                ; =6
1067fb388: 9450af6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb38c: aa0003f4    	mov	x20, x0
1067fb390: 900ccbc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1067fb394: f9458900    	ldr	x0, [x8, #0xb10]
1067fb398: aa1903e1    	mov	x1, x25
1067fb39c: 528000c2    	mov	w2, #0x6                ; =6
1067fb3a0: 9450af67    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb3a4: aa1d03fd    	mov	x29, x29
1067fb3a8: 9450af68    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fb3ac: aa0003f5    	mov	x21, x0
1067fb3b0: d00cb1e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1067fb3b4: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
1067fb3b8: aa1a03e0    	mov	x0, x26
1067fb3bc: aa1403e2    	mov	x2, x20
1067fb3c0: aa1503e3    	mov	x3, x21
1067fb3c4: 9450af5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb3c8: aa1503e0    	mov	x0, x21
1067fb3cc: 9450af62    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb3d0: aa1403e0    	mov	x0, x20
1067fb3d4: 9450af60    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb3d8: d00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067fb3dc: f9429d01    	ldr	x1, [x8, #0x538] ; setLayoutInfoMap:
1067fb3e0: aa1303e0    	mov	x0, x19
1067fb3e4: aa1a03e2    	mov	x2, x26
1067fb3e8: 9450af55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fb3ec: aa1a03e0    	mov	x0, x26
1067fb3f0: 9450af59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fb3f4: a9497bfd    	ldp	x29, x30, [sp, #0x90]
1067fb3f8: a9484ff4    	ldp	x20, x19, [sp, #0x80]
1067fb3fc: a94757f6    	ldp	x22, x21, [sp, #0x70]
1067fb400: a9465ff8    	ldp	x24, x23, [sp, #0x60]
1067fb404: a94567fa    	ldp	x26, x25, [sp, #0x50]
1067fb408: a9446ffc    	ldp	x28, x27, [sp, #0x40]
1067fb40c: 910283ff    	add	sp, sp, #0xa0
1067fb410: d65f03c0    	ret
