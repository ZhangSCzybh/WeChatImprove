
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fdb178: d101c3ff    	sub	sp, sp, #0x70
100fdb17c: a9035ff8    	stp	x24, x23, [sp, #0x30]
100fdb180: a90457f6    	stp	x22, x21, [sp, #0x40]
100fdb184: a9054ff4    	stp	x20, x19, [sp, #0x50]
100fdb188: a9067bfd    	stp	x29, x30, [sp, #0x60]
100fdb18c: 910183fd    	add	x29, sp, #0x60
100fdb190: aa0403f5    	mov	x21, x4
100fdb194: aa0303f4    	mov	x20, x3
100fdb198: aa0203f3    	mov	x19, x2
100fdb19c: aa0003f6    	mov	x22, x0
100fdb1a0: b00fe2a8    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100fdb1a4: 52800029    	mov	w9, #0x1                ; =1
100fdb1a8: 39307d09    	strb	w9, [x8, #0xc1f]
100fdb1ac: aa0203e0    	mov	x0, x2
100fdb1b0: 95b12fe2    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100fdb1b4: b00f74c8    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
100fdb1b8: f9456901    	ldr	x1, [x8, #0xad0] ; reportContactImportantChangeData:actionCode:actionScene:
100fdb1bc: aa1603e0    	mov	x0, x22
100fdb1c0: aa1303e2    	mov	x2, x19
100fdb1c4: 52800103    	mov	w3, #0x8                ; =8
100fdb1c8: 52800064    	mov	w4, #0x3                ; =3
100fdb1cc: 95b12fdc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb1d0: 900f7308    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100fdb1d4: f947d101    	ldr	x1, [x8, #0xfa0] ; isChatroom
100fdb1d8: aa1303e0    	mov	x0, x19
100fdb1dc: 95b12fd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb1e0: 34000260    	cbz	w0, 0x100fdb22c <__text+0xfd322c>
100fdb1e4: 900f7308    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100fdb1e8: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
100fdb1ec: aa1303e0    	mov	x0, x19
100fdb1f0: 95b12fd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb1f4: aa1d03fd    	mov	x29, x29
100fdb1f8: 95b12fd4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fdb1fc: aa0003f7    	mov	x23, x0
100fdb200: 900f7568    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fdb204: f941ed01    	ldr	x1, [x8, #0x3d8] ; ChangeNotifyStatusForChatRoom:withStatus:sync:
100fdb208: aa1603e0    	mov	x0, x22
100fdb20c: aa1703e2    	mov	x2, x23
100fdb210: aa1403e3    	mov	x3, x20
100fdb214: aa1503e4    	mov	x4, x21
100fdb218: 95b12fc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb21c: aa0003f5    	mov	x21, x0
100fdb220: aa1703e0    	mov	x0, x23
100fdb224: 95b12fcc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fdb228: 14000009    	b	0x100fdb24c <__text+0xfd324c>
100fdb22c: d00f73e8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
100fdb230: f9414101    	ldr	x1, [x8, #0x280] ; setContact:notifyOpen:sync:
100fdb234: aa1603e0    	mov	x0, x22
100fdb238: aa1303e2    	mov	x2, x19
100fdb23c: aa1403e3    	mov	x3, x20
100fdb240: aa1503e4    	mov	x4, x21
100fdb244: 95b12fbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb248: aa0003f5    	mov	x21, x0
100fdb24c: 900f8cc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fdb250: f945e900    	ldr	x0, [x8, #0xbd0]
100fdb254: b00f8928    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100fdb258: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100fdb25c: 95b12fb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb260: aa1d03fd    	mov	x29, x29
100fdb264: 95b12fb9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fdb268: aa0003f6    	mov	x22, x0
100fdb26c: b00f8ca8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
100fdb270: f9452917    	ldr	x23, [x8, #0xa50]
100fdb274: d00f73e8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
100fdb278: f9414518    	ldr	x24, [x8, #0x288] ; OnChangeNotifyStatus:withStatus:
100fdb27c: f00e3088    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
100fdb280: f947e108    	ldr	x8, [x8, #0xfc0]
100fdb284: f90003e8    	str	x8, [sp]
100fdb288: d00bed28    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
100fdb28c: fd41c100    	ldr	d0, [x8, #0x380]
100fdb290: fd0007e0    	str	d0, [sp, #0x8]
100fdb294: 90000008    	adrp	x8, 0x100fdb000 <__text+0xfd3000>
100fdb298: 910c3108    	add	x8, x8, #0x30c
100fdb29c: 900e30e9    	adrp	x9, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
100fdb2a0: 912ee129    	add	x9, x9, #0xbb8
100fdb2a4: a90127e8    	stp	x8, x9, [sp, #0x10]
100fdb2a8: f90013f3    	str	x19, [sp, #0x20]
100fdb2ac: 3900a3f4    	strb	w20, [sp, #0x28]
100fdb2b0: f00f72e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100fdb2b4: f9404914    	ldr	x20, [x8, #0x90] ; callExtension:selector:block:
100fdb2b8: aa1303e0    	mov	x0, x19
100fdb2bc: 95b12f9f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100fdb2c0: 910003e4    	mov	x4, sp
100fdb2c4: aa1603e0    	mov	x0, x22
100fdb2c8: aa1403e1    	mov	x1, x20
100fdb2cc: aa1703e2    	mov	x2, x23
100fdb2d0: aa1803e3    	mov	x3, x24
100fdb2d4: 95b12f9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb2d8: aa1603e0    	mov	x0, x22
100fdb2dc: 95b12f9e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fdb2e0: f94013e0    	ldr	x0, [sp, #0x20]
100fdb2e4: 95b12f9c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fdb2e8: aa1303e0    	mov	x0, x19
100fdb2ec: 95b12f9a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fdb2f0: aa1503e0    	mov	x0, x21
100fdb2f4: a9467bfd    	ldp	x29, x30, [sp, #0x60]
100fdb2f8: a9454ff4    	ldp	x20, x19, [sp, #0x50]
100fdb2fc: a94457f6    	ldp	x22, x21, [sp, #0x40]
100fdb300: a9435ff8    	ldp	x24, x23, [sp, #0x30]
100fdb304: 9101c3ff    	add	sp, sp, #0x70
100fdb308: d65f03c0    	ret
