
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101759e3c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
101759e40: a9015ff8    	stp	x24, x23, [sp, #0x10]
101759e44: a90257f6    	stp	x22, x21, [sp, #0x20]
101759e48: a9034ff4    	stp	x20, x19, [sp, #0x30]
101759e4c: a9047bfd    	stp	x29, x30, [sp, #0x40]
101759e50: 910103fd    	add	x29, sp, #0x40
101759e54: aa0303f4    	mov	x20, x3
101759e58: aa0203f5    	mov	x21, x2
101759e5c: aa0003f3    	mov	x19, x0
101759e60: b00fa6c8    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
101759e64: 52800029    	mov	w9, #0x1                ; =1
101759e68: 39220909    	strb	w9, [x8, #0x882]
101759e6c: f00f3a68    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
101759e70: f9475116    	ldr	x22, [x8, #0xea0] ; isCreateChatRoomCellAtRow:
101759e74: aa0303e0    	mov	x0, x3
101759e78: 959334b0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101759e7c: aa1303e0    	mov	x0, x19
101759e80: aa1603e1    	mov	x1, x22
101759e84: aa1503e2    	mov	x2, x21
101759e88: 959334ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759e8c: 340007e0    	cbz	w0, 0x101759f88 <__text+0x1751f88>
101759e90: b00f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101759e94: f9424901    	ldr	x1, [x8, #0x490] ; tableViewContext
101759e98: aa1303e0    	mov	x0, x19
101759e9c: 959334a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759ea0: aa1d03fd    	mov	x29, x29
101759ea4: 959334a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101759ea8: aa0003f5    	mov	x21, x0
101759eac: d00f5128    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
101759eb0: f9422900    	ldr	x0, [x8, #0x450]
101759eb4: d00f4d28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101759eb8: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101759ebc: 959334a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759ec0: aa0003f6    	mov	x22, x0
101759ec4: b00f4d68    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101759ec8: f9440901    	ldr	x1, [x8, #0x810] ; row
101759ecc: aa1403e0    	mov	x0, x20
101759ed0: 9593349b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759ed4: aa0003f7    	mov	x23, x0
101759ed8: aa1403e0    	mov	x0, x20
101759edc: 9593349e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101759ee0: b00f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101759ee4: f9424d01    	ldr	x1, [x8, #0x498] ; dequeueReusableCellOfClass:forSectionController:atIndex:
101759ee8: aa1503e0    	mov	x0, x21
101759eec: aa1603e2    	mov	x2, x22
101759ef0: aa1303e3    	mov	x3, x19
101759ef4: aa1703e4    	mov	x4, x23
101759ef8: 95933491    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759efc: aa1d03fd    	mov	x29, x29
101759f00: 95933492    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101759f04: aa0003f4    	mov	x20, x0
101759f08: aa1503e0    	mov	x0, x21
101759f0c: 95933492    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101759f10: b00f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101759f14: f942f901    	ldr	x1, [x8, #0x5f0] ; ftsPresenter
101759f18: aa1303e0    	mov	x0, x19
101759f1c: 95933488    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759f20: aa1d03fd    	mov	x29, x29
101759f24: 95933489    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101759f28: aa0003f5    	mov	x21, x0
101759f2c: b00f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101759f30: f9431901    	ldr	x1, [x8, #0x630] ; curSearchText
101759f34: aa1303e0    	mov	x0, x19
101759f38: 95933481    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759f3c: aa1d03fd    	mov	x29, x29
101759f40: 95933482    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101759f44: aa0003f3    	mov	x19, x0
101759f48: f00f3a68    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
101759f4c: f9475501    	ldr	x1, [x8, #0xea8] ; parseSeperatedKeyword:
101759f50: aa1503e0    	mov	x0, x21
101759f54: aa1303e2    	mov	x2, x19
101759f58: 95933479    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759f5c: aa1d03fd    	mov	x29, x29
101759f60: 9593347a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101759f64: aa0003f6    	mov	x22, x0
101759f68: f00f3a68    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
101759f6c: f9475901    	ldr	x1, [x8, #0xeb0] ; updateCellWithKeywords:
101759f70: aa1403e0    	mov	x0, x20
101759f74: aa1603e2    	mov	x2, x22
101759f78: 95933471    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759f7c: aa1603e0    	mov	x0, x22
101759f80: 95933475    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101759f84: 14000086    	b	0x10175a19c <__text+0x175219c>
101759f88: f00f3a68    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
101759f8c: f9474d01    	ldr	x1, [x8, #0xe98] ; shouldDisplayChatRoomEntry
101759f90: aa1303e0    	mov	x0, x19
101759f94: 9593346a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759f98: 340000c0    	cbz	w0, 0x101759fb0 <__text+0x1751fb0>
101759f9c: b00f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101759fa0: f9426101    	ldr	x1, [x8, #0x4c0] ; isDetailSearch
101759fa4: aa1303e0    	mov	x0, x19
101759fa8: 95933465    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759fac: cb2042b5    	sub	x21, x21, w0, uxtw
101759fb0: b00f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101759fb4: f9424901    	ldr	x1, [x8, #0x490] ; tableViewContext
101759fb8: aa1303e0    	mov	x0, x19
101759fbc: 95933460    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759fc0: aa1d03fd    	mov	x29, x29
101759fc4: 95933461    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101759fc8: aa0003f7    	mov	x23, x0
101759fcc: d00f50c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101759fd0: f9461d00    	ldr	x0, [x8, #0xc38]
101759fd4: d00f4d28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101759fd8: f947ad16    	ldr	x22, [x8, #0xf58] ; class
101759fdc: aa1603e1    	mov	x1, x22
101759fe0: 95933457    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759fe4: aa0003f8    	mov	x24, x0
101759fe8: b00f4d68    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101759fec: f9440901    	ldr	x1, [x8, #0x810] ; row
101759ff0: aa1403e0    	mov	x0, x20
101759ff4: 95933452    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759ff8: aa0003f9    	mov	x25, x0
101759ffc: aa1403e0    	mov	x0, x20
10175a000: 95933455    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a004: 900f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10175a008: f9424d01    	ldr	x1, [x8, #0x498] ; dequeueReusableCellOfClass:forSectionController:atIndex:
10175a00c: aa1703e0    	mov	x0, x23
10175a010: aa1803e2    	mov	x2, x24
10175a014: aa1303e3    	mov	x3, x19
10175a018: aa1903e4    	mov	x4, x25
10175a01c: 95933448    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a020: aa1d03fd    	mov	x29, x29
10175a024: 95933449    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a028: aa0003f4    	mov	x20, x0
10175a02c: aa1703e0    	mov	x0, x23
10175a030: 95933449    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a034: d00f54a8    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
10175a038: b98d9d08    	ldrsw	x8, [x8, #0xd9c]
10175a03c: f8686a60    	ldr	x0, [x19, x8]
10175a040: 900f3708    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10175a044: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
10175a048: aa1503e2    	mov	x2, x21
10175a04c: 9593343c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a050: aa1d03fd    	mov	x29, x29
10175a054: 9593343d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a058: aa0003f7    	mov	x23, x0
10175a05c: d00f4d48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10175a060: f9447d01    	ldr	x1, [x8, #0x8f8] ; model
10175a064: 95933436    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a068: aa1d03fd    	mov	x29, x29
10175a06c: 95933437    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a070: aa0003f5    	mov	x21, x0
10175a074: aa1703e0    	mov	x0, x23
10175a078: 95933437    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a07c: b00f50c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10175a080: f945e900    	ldr	x0, [x8, #0xbd0]
10175a084: d00f4d28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10175a088: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10175a08c: 9593342c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a090: aa1d03fd    	mov	x29, x29
10175a094: 9593342d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a098: aa0003f7    	mov	x23, x0
10175a09c: b00f50c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10175a0a0: f9477100    	ldr	x0, [x8, #0xee0]
10175a0a4: aa1603e1    	mov	x1, x22
10175a0a8: 95933425    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a0ac: aa0003e2    	mov	x2, x0
10175a0b0: f00f36e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10175a0b4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10175a0b8: aa1703e0    	mov	x0, x23
10175a0bc: 95933420    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a0c0: aa1d03fd    	mov	x29, x29
10175a0c4: 95933421    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a0c8: aa0003f6    	mov	x22, x0
10175a0cc: b00f3708    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10175a0d0: f9430d01    	ldr	x1, [x8, #0x618] ; ftsContactMgr
10175a0d4: 9593341a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a0d8: aa1d03fd    	mov	x29, x29
10175a0dc: 9593341b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a0e0: aa0003f8    	mov	x24, x0
10175a0e4: b00f3708    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10175a0e8: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
10175a0ec: aa1503e0    	mov	x0, x21
10175a0f0: 95933413    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a0f4: aa1d03fd    	mov	x29, x29
10175a0f8: 95933414    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a0fc: aa0003f9    	mov	x25, x0
10175a100: 900f3a68    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10175a104: f943a101    	ldr	x1, [x8, #0x740] ; ftsTaskKey
10175a108: aa1303e0    	mov	x0, x19
10175a10c: 9593340c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a110: aa1d03fd    	mov	x29, x29
10175a114: 9593340d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a118: aa0003fa    	mov	x26, x0
10175a11c: 900f3968    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10175a120: f9441901    	ldr	x1, [x8, #0x830] ; getMatchTipForUserName:taskKey:
10175a124: aa1803e0    	mov	x0, x24
10175a128: aa1903e2    	mov	x2, x25
10175a12c: aa1a03e3    	mov	x3, x26
10175a130: 95933403    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a134: aa1d03fd    	mov	x29, x29
10175a138: 95933404    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10175a13c: aa0003f3    	mov	x19, x0
10175a140: aa1a03e0    	mov	x0, x26
10175a144: 95933404    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a148: aa1903e0    	mov	x0, x25
10175a14c: 95933402    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a150: aa1803e0    	mov	x0, x24
10175a154: 95933400    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a158: aa1603e0    	mov	x0, x22
10175a15c: 959333fe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a160: aa1703e0    	mov	x0, x23
10175a164: 959333fc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a168: f00f36e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10175a16c: f9463d01    	ldr	x1, [x8, #0xc78] ; updateContact:matchTip:
10175a170: aa1403e0    	mov	x0, x20
10175a174: aa1503e2    	mov	x2, x21
10175a178: aa1303e3    	mov	x3, x19
10175a17c: 959333f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a180: 900f3708    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10175a184: f943a501    	ldr	x1, [x8, #0x748] ; attachObject:forKey:
10175a188: b00e7183    	adrp	x3, 0x11e58b000 <dyld_stub_binder+0x11e58b000>
10175a18c: 91092063    	add	x3, x3, #0x248
10175a190: aa1403e0    	mov	x0, x20
10175a194: aa1303e2    	mov	x2, x19
10175a198: 959333e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10175a19c: aa1303e0    	mov	x0, x19
10175a1a0: 959333ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a1a4: aa1503e0    	mov	x0, x21
10175a1a8: 959333eb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10175a1ac: aa1403e0    	mov	x0, x20
10175a1b0: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10175a1b4: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10175a1b8: a94257f6    	ldp	x22, x21, [sp, #0x20]
10175a1bc: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10175a1c0: a8c567fa    	ldp	x26, x25, [sp], #0x50
10175a1c4: 159333eb    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
