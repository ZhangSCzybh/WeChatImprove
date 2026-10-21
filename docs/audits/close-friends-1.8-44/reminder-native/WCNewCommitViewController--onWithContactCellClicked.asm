
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109299dd8: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
109299ddc: a90167fa    	stp	x26, x25, [sp, #0x10]
109299de0: a9025ff8    	stp	x24, x23, [sp, #0x20]
109299de4: a90357f6    	stp	x22, x21, [sp, #0x30]
109299de8: a9044ff4    	stp	x20, x19, [sp, #0x40]
109299dec: a9057bfd    	stp	x29, x30, [sp, #0x50]
109299df0: 910143fd    	add	x29, sp, #0x50
109299df4: aa0003f3    	mov	x19, x0
109299df8: b00bcda8    	adrp	x8, 0x120c4e000 <dyld_stub_binder+0x120c4e000>
109299dfc: 52800029    	mov	w9, #0x1                ; =1
109299e00: 3922a909    	strb	w9, [x8, #0x8aa]
109299e04: d00b6368    	adrp	x8, 0x11ff07000 <dyld_stub_binder+0x11ff07000>
109299e08: f9463d01    	ldr	x1, [x8, #0xc78] ; resignInput
109299e0c: 9597058e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299e10: d00b76da    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
109299e14: f945eb40    	ldr	x0, [x26, #0xbd0] ; MMContext
109299e18: f00b7328    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109299e1c: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
109299e20: aa1603e1    	mov	x1, x22
109299e24: 95970588    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299e28: aa1d03fd    	mov	x29, x29
109299e2c: 95970589    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109299e30: aa0003f7    	mov	x23, x0
109299e34: f00b76db    	adrp	x27, 0x120174000 <dyld_stub_binder+0x120174000>
109299e38: f9428760    	ldr	x0, [x27, #0x508] ; WCFacade
109299e3c: d00b7328    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109299e40: f947ad15    	ldr	x21, [x8, #0xf58] ; class
109299e44: aa1503e1    	mov	x1, x21
109299e48: 9597057f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299e4c: aa0003e2    	mov	x2, x0
109299e50: 900b5d08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109299e54: f9464114    	ldr	x20, [x8, #0xc80] ; getService:
109299e58: aa1703e0    	mov	x0, x23
109299e5c: aa1403e1    	mov	x1, x20
109299e60: 95970579    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299e64: aa1d03fd    	mov	x29, x29
109299e68: 9597057a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109299e6c: aa0003f8    	mov	x24, x0
109299e70: d00b6e48    	adrp	x8, 0x120063000 <dyld_stub_binder+0x120063000>
109299e74: f946b101    	ldr	x1, [x8, #0xd60] ; getPostPrivacy
109299e78: 95970573    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299e7c: aa0003f9    	mov	x25, x0
109299e80: aa1803e0    	mov	x0, x24
109299e84: 95970576    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109299e88: aa1703e0    	mov	x0, x23
109299e8c: 95970574    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109299e90: f1000f3f    	cmp	x25, #0x3
109299e94: 54000541    	b.ne	0x109299f3c <_Flutter_MMFoundation_BindContext+0x5775b20>
109299e98: f00b6b28    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
109299e9c: f944a101    	ldr	x1, [x8, #0x940] ; togetherEnabled
109299ea0: aa1303e0    	mov	x0, x19
109299ea4: 95970568    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299ea8: 34000ac0    	cbz	w0, 0x10929a000 <_Flutter_MMFoundation_BindContext+0x5775be4>
109299eac: f945eb40    	ldr	x0, [x26, #0xbd0] ; MMContext
109299eb0: aa1603e1    	mov	x1, x22
109299eb4: 95970564    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299eb8: aa1d03fd    	mov	x29, x29
109299ebc: 95970565    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109299ec0: aa0003f6    	mov	x22, x0
109299ec4: d00b76c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109299ec8: f9462900    	ldr	x0, [x8, #0xc50] ; MMLanguageMgr
109299ecc: aa1503e1    	mov	x1, x21
109299ed0: 9597055d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299ed4: aa0003e2    	mov	x2, x0
109299ed8: aa1603e0    	mov	x0, x22
109299edc: aa1403e1    	mov	x1, x20
109299ee0: 95970559    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299ee4: aa1d03fd    	mov	x29, x29
109299ee8: 9597055a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109299eec: aa0003f4    	mov	x20, x0
109299ef0: 900b5d08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109299ef4: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
109299ef8: f00ab9a2    	adrp	x2, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
109299efc: 9100a042    	add	x2, x2, #0x28
109299f00: 95970551    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299f04: aa1d03fd    	mov	x29, x29
109299f08: 95970552    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109299f0c: aa0003f5    	mov	x21, x0
109299f10: f00b6ea8    	adrp	x8, 0x120070000 <dyld_stub_binder+0x120070000>
109299f14: f9415d01    	ldr	x1, [x8, #0x2b8] ; showTogetherAlertViewWithMessage:
109299f18: aa1303e0    	mov	x0, x19
109299f1c: aa1503e2    	mov	x2, x21
109299f20: 95970549    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299f24: aa1503e0    	mov	x0, x21
109299f28: 9597054d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109299f2c: aa1403e0    	mov	x0, x20
109299f30: 9597054b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109299f34: aa1603e0    	mov	x0, x22
109299f38: 1400002b    	b	0x109299fe4 <_Flutter_MMFoundation_BindContext+0x5775bc8>
109299f3c: f00b6b28    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
109299f40: f9430101    	ldr	x1, [x8, #0x600] ; postReportSession
109299f44: aa1303e0    	mov	x0, x19
109299f48: 9597053f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299f4c: aa1d03fd    	mov	x29, x29
109299f50: 95970540    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109299f54: aa0003f7    	mov	x23, x0
109299f58: f00b6b28    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
109299f5c: f943ad01    	ldr	x1, [x8, #0x758] ; didTakeEditAction:
109299f60: 52800062    	mov	w2, #0x3                ; =3
109299f64: 95970538    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299f68: aa1703e0    	mov	x0, x23
109299f6c: 9597053c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109299f70: b00b7e68    	adrp	x8, 0x120266000 <dyld_stub_binder+0x120266000>
109299f74: b98ecd08    	ldrsw	x8, [x8, #0xecc]
109299f78: f8686a60    	ldr	x0, [x19, x8]
109299f7c: f00b6ea8    	adrp	x8, 0x120070000 <dyld_stub_binder+0x120070000>
109299f80: f9417901    	ldr	x1, [x8, #0x2f0] ; addContact
109299f84: 95970530    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299f88: f945eb40    	ldr	x0, [x26, #0xbd0] ; MMContext
109299f8c: aa1603e1    	mov	x1, x22
109299f90: 9597052d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299f94: aa1d03fd    	mov	x29, x29
109299f98: 9597052e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109299f9c: aa0003f3    	mov	x19, x0
109299fa0: f9428760    	ldr	x0, [x27, #0x508] ; WCFacade
109299fa4: aa1503e1    	mov	x1, x21
109299fa8: 95970527    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299fac: aa0003e2    	mov	x2, x0
109299fb0: aa1303e0    	mov	x0, x19
109299fb4: aa1403e1    	mov	x1, x20
109299fb8: 95970523    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299fbc: aa1d03fd    	mov	x29, x29
109299fc0: 95970524    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109299fc4: aa0003f4    	mov	x20, x0
109299fc8: f00b6ea8    	adrp	x8, 0x120070000 <dyld_stub_binder+0x120070000>
109299fcc: f9417d01    	ldr	x1, [x8, #0x2f8] ; setShowsTogetherBadgeInPostPage:
109299fd0: 52800002    	mov	w2, #0x0                ; =0
109299fd4: 9597051c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109299fd8: aa1403e0    	mov	x0, x20
109299fdc: 95970520    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109299fe0: aa1303e0    	mov	x0, x19
109299fe4: a9457bfd    	ldp	x29, x30, [sp, #0x50]
109299fe8: a9444ff4    	ldp	x20, x19, [sp, #0x40]
109299fec: a94357f6    	ldp	x22, x21, [sp, #0x30]
109299ff0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
109299ff4: a94167fa    	ldp	x26, x25, [sp, #0x10]
109299ff8: a8c66ffc    	ldp	x28, x27, [sp], #0x60
109299ffc: 15970518    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10929a000: d00b6ea8    	adrp	x8, 0x120070000 <dyld_stub_binder+0x120070000>
10929a004: f9416501    	ldr	x1, [x8, #0x2c8] ; showPrivacyAlertView
10929a008: aa1303e0    	mov	x0, x19
10929a00c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10929a010: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10929a014: a94357f6    	ldp	x22, x21, [sp, #0x30]
10929a018: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10929a01c: a94167fa    	ldp	x26, x25, [sp, #0x10]
10929a020: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10929a024: 15970508    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
