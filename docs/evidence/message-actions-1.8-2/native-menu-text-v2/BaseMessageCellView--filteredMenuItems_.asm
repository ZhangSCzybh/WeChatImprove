
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a4294: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1002a4298: a90167fa    	stp	x26, x25, [sp, #0x10]
1002a429c: a9025ff8    	stp	x24, x23, [sp, #0x20]
1002a42a0: a90357f6    	stp	x22, x21, [sp, #0x30]
1002a42a4: a9044ff4    	stp	x20, x19, [sp, #0x40]
1002a42a8: a9057bfd    	stp	x29, x30, [sp, #0x50]
1002a42ac: 910143fd    	add	x29, sp, #0x50
1002a42b0: d10ec3ff    	sub	sp, sp, #0x3b0
1002a42b4: aa0203f7    	mov	x23, x2
1002a42b8: aa0003f6    	mov	x22, x0
1002a42bc: f00e9a48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a42c0: f9405908    	ldr	x8, [x8, #0xb0]
1002a42c4: f9400108    	ldr	x8, [x8]
1002a42c8: f81a03a8    	stur	x8, [x29, #-0x60]
1002a42cc: b0104c48    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002a42d0: 52800029    	mov	w9, #0x1                ; =1
1002a42d4: 39311509    	strb	w9, [x8, #0xc45]
1002a42d8: aa0203e0    	mov	x0, x2
1002a42dc: 95e60b97    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a42e0: d00fdcc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a42e4: f9410901    	ldr	x1, [x8, #0x210] ; viewModel
1002a42e8: aa1603e0    	mov	x0, x22
1002a42ec: 95e60b94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a42f0: aa1d03fd    	mov	x29, x29
1002a42f4: 95e60b95    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a42f8: aa0003f3    	mov	x19, x0
1002a42fc: f00fdcc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a4300: f9437901    	ldr	x1, [x8, #0x6f0] ; chatContact
1002a4304: 95e60b8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4308: aa1d03fd    	mov	x29, x29
1002a430c: 95e60b8f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4310: aa0003f4    	mov	x20, x0
1002a4314: aa1303e0    	mov	x0, x19
1002a4318: 95e60b8f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a431c: f00fdca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002a4320: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
1002a4324: f90003f4    	str	x20, [sp]
1002a4328: aa1403e0    	mov	x0, x20
1002a432c: 95e60b84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4330: aa1d03fd    	mov	x29, x29
1002a4334: 95e60b85    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4338: aa0003f5    	mov	x21, x0
1002a433c: f00ff2e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1002a4340: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1002a4344: 95e60b7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4348: f90007f5    	str	x21, [sp, #0x8]
1002a434c: b4000c60    	cbz	x0, 0x1002a44d8 <__text+0x29c4d8>
1002a4350: 900ff694    	adrp	x20, 0x120174000 <dyld_stub_binder+0x120174000>
1002a4354: f9400280    	ldr	x0, [x20]
1002a4358: f00fdce8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1002a435c: f9447901    	ldr	x1, [x8, #0x8f0] ; IsBypMsgUserName:
1002a4360: aa1503e2    	mov	x2, x21
1002a4364: 95e60b76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4368: 34000b80    	cbz	w0, 0x1002a44d8 <__text+0x29c4d8>
1002a436c: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a4370: f9455513    	ldr	x19, [x8, #0xaa8]
1002a4374: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4378: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1002a437c: aa1703e0    	mov	x0, x23
1002a4380: 95e60b6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4384: aa0003e2    	mov	x2, x0
1002a4388: f00ff2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a438c: f941b501    	ldr	x1, [x8, #0x368] ; arrayWithCapacity:
1002a4390: aa1303e0    	mov	x0, x19
1002a4394: 95e60b6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4398: aa1d03fd    	mov	x29, x29
1002a439c: 95e60b6b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a43a0: f9002fe0    	str	x0, [sp, #0x58]
1002a43a4: f9400280    	ldr	x0, [x20]
1002a43a8: b00fdcc8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1002a43ac: f9447501    	ldr	x1, [x8, #0x8e8] ; IsWeClawBot:
1002a43b0: aa1503e2    	mov	x2, x21
1002a43b4: 95e60b62    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a43b8: 900ff2f3    	adrp	x19, 0x120100000 <dyld_stub_binder+0x120100000>
1002a43bc: f9002bf7    	str	x23, [sp, #0x50]
1002a43c0: 34000900    	cbz	w0, 0x1002a44e0 <__text+0x29c4e0>
1002a43c4: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a43c8: f9424501    	ldr	x1, [x8, #0x488] ; weclawMessageMenuItemsBlacklist:
1002a43cc: aa1603e0    	mov	x0, x22
1002a43d0: aa1503e2    	mov	x2, x21
1002a43d4: 95e60b5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a43d8: aa1d03fd    	mov	x29, x29
1002a43dc: 95e60b5b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a43e0: aa0003f8    	mov	x24, x0
1002a43e4: 4f00e400    	movi.16b	v0, #0x0
1002a43e8: ad0903e0    	stp	q0, q0, [sp, #0x120]
1002a43ec: ad0a03e0    	stp	q0, q0, [sp, #0x140]
1002a43f0: aa1703e0    	mov	x0, x23
1002a43f4: 95e60b51    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a43f8: f9435661    	ldr	x1, [x19, #0x6a8] ; countByEnumeratingWithState:objects:count:
1002a43fc: 910483e2    	add	x2, sp, #0x120
1002a4400: d10383a3    	sub	x3, x29, #0xe0
1002a4404: f90027e1    	str	x1, [sp, #0x48]
1002a4408: 52800204    	mov	w4, #0x10               ; =16
1002a440c: 95e60b4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4410: b4000f40    	cbz	x0, 0x1002a45f8 <__text+0x29c5f8>
1002a4414: aa0003f4    	mov	x20, x0
1002a4418: f90023f6    	str	x22, [sp, #0x40]
1002a441c: f9409be8    	ldr	x8, [sp, #0x130]
1002a4420: f9400115    	ldr	x21, [x8]
1002a4424: d2800017    	mov	x23, #0x0               ; =0
1002a4428: f00ff328    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1002a442c: f940d119    	ldr	x25, [x8, #0x1a0] ; title
1002a4430: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4434: f9424d1a    	ldr	x26, [x8, #0x498] ; containsObject:
1002a4438: d00fdca8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a443c: f943c51b    	ldr	x27, [x8, #0x788] ; safeAddObject:
1002a4440: f9409be8    	ldr	x8, [sp, #0x130]
1002a4444: f9400108    	ldr	x8, [x8]
1002a4448: eb15011f    	cmp	x8, x21
1002a444c: 54000060    	b.eq	0x1002a4458 <__text+0x29c458>
1002a4450: f9402be0    	ldr	x0, [sp, #0x50]
1002a4454: 95e60b3f    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1002a4458: f94097e8    	ldr	x8, [sp, #0x128]
1002a445c: f877791c    	ldr	x28, [x8, x23, lsl #3]
1002a4460: aa1c03e0    	mov	x0, x28
1002a4464: aa1903e1    	mov	x1, x25
1002a4468: 95e60b35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a446c: aa1d03fd    	mov	x29, x29
1002a4470: 95e60b36    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4474: aa0003f6    	mov	x22, x0
1002a4478: aa1803e0    	mov	x0, x24
1002a447c: aa1a03e1    	mov	x1, x26
1002a4480: aa1603e2    	mov	x2, x22
1002a4484: 95e60b2e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4488: aa0003f3    	mov	x19, x0
1002a448c: aa1603e0    	mov	x0, x22
1002a4490: 95e60b31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4494: 370000b3    	tbnz	w19, #0x0, 0x1002a44a8 <__text+0x29c4a8>
1002a4498: f9402fe0    	ldr	x0, [sp, #0x58]
1002a449c: aa1b03e1    	mov	x1, x27
1002a44a0: aa1c03e2    	mov	x2, x28
1002a44a4: 95e60b26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a44a8: 910006f7    	add	x23, x23, #0x1
1002a44ac: eb17029f    	cmp	x20, x23
1002a44b0: 54fffc81    	b.ne	0x1002a4440 <__text+0x29c440>
1002a44b4: 910483e2    	add	x2, sp, #0x120
1002a44b8: d10383a3    	sub	x3, x29, #0xe0
1002a44bc: a944dfe1    	ldp	x1, x23, [sp, #0x48]
1002a44c0: aa1703e0    	mov	x0, x23
1002a44c4: 52800204    	mov	w4, #0x10               ; =16
1002a44c8: 95e60b1d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a44cc: aa0003f4    	mov	x20, x0
1002a44d0: b5fffaa0    	cbnz	x0, 0x1002a4424 <__text+0x29c424>
1002a44d4: 14000047    	b	0x1002a45f0 <__text+0x29c5f0>
1002a44d8: f9002ff7    	str	x23, [sp, #0x58]
1002a44dc: 1400004d    	b	0x1002a4610 <__text+0x29c610>
1002a44e0: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a44e4: f9424901    	ldr	x1, [x8, #0x490] ; bypassMessageMenuItemsWhitelist:
1002a44e8: aa1603e0    	mov	x0, x22
1002a44ec: aa1503e2    	mov	x2, x21
1002a44f0: 95e60b13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a44f4: aa1d03fd    	mov	x29, x29
1002a44f8: 95e60b14    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a44fc: aa0003f8    	mov	x24, x0
1002a4500: 4f00e400    	movi.16b	v0, #0x0
1002a4504: ad0703e0    	stp	q0, q0, [sp, #0xe0]
1002a4508: ad0803e0    	stp	q0, q0, [sp, #0x100]
1002a450c: aa1703e0    	mov	x0, x23
1002a4510: 95e60b0a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a4514: f9435661    	ldr	x1, [x19, #0x6a8] ; countByEnumeratingWithState:objects:count:
1002a4518: 910383e2    	add	x2, sp, #0xe0
1002a451c: 910a83e3    	add	x3, sp, #0x2a0
1002a4520: f90027e1    	str	x1, [sp, #0x48]
1002a4524: 52800204    	mov	w4, #0x10               ; =16
1002a4528: 95e60b05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a452c: b4000660    	cbz	x0, 0x1002a45f8 <__text+0x29c5f8>
1002a4530: aa0003f4    	mov	x20, x0
1002a4534: f90023f6    	str	x22, [sp, #0x40]
1002a4538: f9407be8    	ldr	x8, [sp, #0xf0]
1002a453c: f9400115    	ldr	x21, [x8]
1002a4540: d2800017    	mov	x23, #0x0               ; =0
1002a4544: f00ff328    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1002a4548: f940d119    	ldr	x25, [x8, #0x1a0] ; title
1002a454c: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4550: f9424d1a    	ldr	x26, [x8, #0x498] ; containsObject:
1002a4554: d00fdca8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a4558: f943c51b    	ldr	x27, [x8, #0x788] ; safeAddObject:
1002a455c: f9407be8    	ldr	x8, [sp, #0xf0]
1002a4560: f9400108    	ldr	x8, [x8]
1002a4564: eb15011f    	cmp	x8, x21
1002a4568: 54000060    	b.eq	0x1002a4574 <__text+0x29c574>
1002a456c: f9402be0    	ldr	x0, [sp, #0x50]
1002a4570: 95e60af8    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1002a4574: f94077e8    	ldr	x8, [sp, #0xe8]
1002a4578: f877791c    	ldr	x28, [x8, x23, lsl #3]
1002a457c: aa1c03e0    	mov	x0, x28
1002a4580: aa1903e1    	mov	x1, x25
1002a4584: 95e60aee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4588: aa1d03fd    	mov	x29, x29
1002a458c: 95e60aef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4590: aa0003f6    	mov	x22, x0
1002a4594: aa1803e0    	mov	x0, x24
1002a4598: aa1a03e1    	mov	x1, x26
1002a459c: aa1603e2    	mov	x2, x22
1002a45a0: 95e60ae7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a45a4: aa0003f3    	mov	x19, x0
1002a45a8: aa1603e0    	mov	x0, x22
1002a45ac: 95e60aea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a45b0: 340000b3    	cbz	w19, 0x1002a45c4 <__text+0x29c5c4>
1002a45b4: f9402fe0    	ldr	x0, [sp, #0x58]
1002a45b8: aa1b03e1    	mov	x1, x27
1002a45bc: aa1c03e2    	mov	x2, x28
1002a45c0: 95e60adf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a45c4: 910006f7    	add	x23, x23, #0x1
1002a45c8: eb17029f    	cmp	x20, x23
1002a45cc: 54fffc81    	b.ne	0x1002a455c <__text+0x29c55c>
1002a45d0: 910383e2    	add	x2, sp, #0xe0
1002a45d4: 910a83e3    	add	x3, sp, #0x2a0
1002a45d8: a944dfe1    	ldp	x1, x23, [sp, #0x48]
1002a45dc: aa1703e0    	mov	x0, x23
1002a45e0: 52800204    	mov	w4, #0x10               ; =16
1002a45e4: 95e60ad6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a45e8: aa0003f4    	mov	x20, x0
1002a45ec: b5fffaa0    	cbnz	x0, 0x1002a4540 <__text+0x29c540>
1002a45f0: f94007f5    	ldr	x21, [sp, #0x8]
1002a45f4: f94023f6    	ldr	x22, [sp, #0x40]
1002a45f8: aa1703e0    	mov	x0, x23
1002a45fc: 95e60ad6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4600: aa1803e0    	mov	x0, x24
1002a4604: 95e60ad4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4608: aa1703e0    	mov	x0, x23
1002a460c: 95e60ad2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4610: d00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a4614: f9424d01    	ldr	x1, [x8, #0x498] ; isOnlyShowDeleteMenu
1002a4618: aa1603e0    	mov	x0, x22
1002a461c: 95e60ac8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4620: 34001220    	cbz	w0, 0x1002a4864 <__text+0x29c864>
1002a4624: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a4628: f9455513    	ldr	x19, [x8, #0xaa8]
1002a462c: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4630: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1002a4634: f9402ff4    	ldr	x20, [sp, #0x58]
1002a4638: aa1403e0    	mov	x0, x20
1002a463c: 95e60ac0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4640: aa0003e2    	mov	x2, x0
1002a4644: f00ff2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a4648: f941b501    	ldr	x1, [x8, #0x368] ; arrayWithCapacity:
1002a464c: aa1303e0    	mov	x0, x19
1002a4650: 95e60abb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4654: aa1d03fd    	mov	x29, x29
1002a4658: 95e60abc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a465c: aa0003f7    	mov	x23, x0
1002a4660: 4f00e400    	movi.16b	v0, #0x0
1002a4664: ad0503e0    	stp	q0, q0, [sp, #0xa0]
1002a4668: ad0603e0    	stp	q0, q0, [sp, #0xc0]
1002a466c: aa1403e0    	mov	x0, x20
1002a4670: 95e60ab2    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a4674: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4678: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1002a467c: 910283e2    	add	x2, sp, #0xa0
1002a4680: 910883e3    	add	x3, sp, #0x220
1002a4684: f9000be1    	str	x1, [sp, #0x10]
1002a4688: 52800204    	mov	w4, #0x10               ; =16
1002a468c: 95e60aac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4690: b4000dc0    	cbz	x0, 0x1002a4848 <__text+0x29c848>
1002a4694: aa0003f8    	mov	x24, x0
1002a4698: f9405be8    	ldr	x8, [sp, #0xb0]
1002a469c: f9400114    	ldr	x20, [x8]
1002a46a0: a901d3f7    	stp	x23, x20, [sp, #0x18]
1002a46a4: d2800013    	mov	x19, #0x0               ; =0
1002a46a8: f00fdcc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a46ac: f943651a    	ldr	x26, [x8, #0x6c8] ; menuType
1002a46b0: f00ff328    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1002a46b4: f940d109    	ldr	x9, [x8, #0x1a0] ; title
1002a46b8: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a46bc: f944e908    	ldr	x8, [x8, #0x9d0] ; currentContext
1002a46c0: a904a7e8    	stp	x8, x9, [sp, #0x48]
1002a46c4: f00ff2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a46c8: f947ad09    	ldr	x9, [x8, #0xf58] ; class
1002a46cc: b00fdca8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002a46d0: f9464108    	ldr	x8, [x8, #0xc80] ; getService:
1002a46d4: a903a7e8    	stp	x8, x9, [sp, #0x38]
1002a46d8: b00fdca8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002a46dc: f9464509    	ldr	x9, [x8, #0xc88] ; getStringForCurLanguage:
1002a46e0: f00ff2e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1002a46e4: f943c908    	ldr	x8, [x8, #0x790] ; isEqualToString:
1002a46e8: a902a7e8    	stp	x8, x9, [sp, #0x28]
1002a46ec: d00fdca8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a46f0: f943c51b    	ldr	x27, [x8, #0x788] ; safeAddObject:
1002a46f4: f9405be8    	ldr	x8, [sp, #0xb0]
1002a46f8: f9400108    	ldr	x8, [x8]
1002a46fc: eb14011f    	cmp	x8, x20
1002a4700: 54000060    	b.eq	0x1002a470c <__text+0x29c70c>
1002a4704: f9402fe0    	ldr	x0, [sp, #0x58]
1002a4708: 95e60a92    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1002a470c: f94057e8    	ldr	x8, [sp, #0xa8]
1002a4710: f873791c    	ldr	x28, [x8, x19, lsl #3]
1002a4714: aa1c03e0    	mov	x0, x28
1002a4718: aa1a03e1    	mov	x1, x26
1002a471c: 95e60a88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4720: f100201f    	cmp	x0, #0x8
1002a4724: 54000740    	b.eq	0x1002a480c <__text+0x29c80c>
1002a4728: aa1c03e0    	mov	x0, x28
1002a472c: aa1a03e1    	mov	x1, x26
1002a4730: 95e60a83    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4734: f100101f    	cmp	x0, #0x4
1002a4738: 540006a0    	b.eq	0x1002a480c <__text+0x29c80c>
1002a473c: aa1c03e0    	mov	x0, x28
1002a4740: aa1a03e1    	mov	x1, x26
1002a4744: 95e60a7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4748: f100141f    	cmp	x0, #0x5
1002a474c: 54000600    	b.eq	0x1002a480c <__text+0x29c80c>
1002a4750: aa1c03e0    	mov	x0, x28
1002a4754: f9402be1    	ldr	x1, [sp, #0x50]
1002a4758: 95e60a79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a475c: aa1d03fd    	mov	x29, x29
1002a4760: 95e60a7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4764: aa0003f6    	mov	x22, x0
1002a4768: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a476c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1002a4770: f94027e1    	ldr	x1, [sp, #0x48]
1002a4774: 95e60a72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4778: aa1d03fd    	mov	x29, x29
1002a477c: 95e60a73    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4780: aa0003f4    	mov	x20, x0
1002a4784: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a4788: f9462900    	ldr	x0, [x8, #0xc50]
1002a478c: f94023e1    	ldr	x1, [sp, #0x40]
1002a4790: 95e60a6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4794: aa0003e2    	mov	x2, x0
1002a4798: aa1403e0    	mov	x0, x20
1002a479c: f9401fe1    	ldr	x1, [sp, #0x38]
1002a47a0: 95e60a67    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a47a4: aa1d03fd    	mov	x29, x29
1002a47a8: 95e60a68    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a47ac: aa0003f7    	mov	x23, x0
1002a47b0: f9401be1    	ldr	x1, [sp, #0x30]
1002a47b4: d00f1082    	adrp	x2, 0x11e4b6000 <dyld_stub_binder+0x11e4b6000>
1002a47b8: 910ea042    	add	x2, x2, #0x3a8
1002a47bc: 95e60a60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a47c0: aa1d03fd    	mov	x29, x29
1002a47c4: 95e60a61    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a47c8: aa0003f9    	mov	x25, x0
1002a47cc: aa1603e0    	mov	x0, x22
1002a47d0: f94017e1    	ldr	x1, [sp, #0x28]
1002a47d4: aa1903e2    	mov	x2, x25
1002a47d8: 95e60a59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a47dc: aa0003f5    	mov	x21, x0
1002a47e0: aa1903e0    	mov	x0, x25
1002a47e4: 95e60a5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a47e8: aa1703e0    	mov	x0, x23
1002a47ec: f9400ff7    	ldr	x23, [sp, #0x18]
1002a47f0: 95e60a59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a47f4: aa1403e0    	mov	x0, x20
1002a47f8: f94013f4    	ldr	x20, [sp, #0x20]
1002a47fc: 95e60a56    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4800: aa1603e0    	mov	x0, x22
1002a4804: 95e60a54    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4808: 340000b5    	cbz	w21, 0x1002a481c <__text+0x29c81c>
1002a480c: aa1703e0    	mov	x0, x23
1002a4810: aa1b03e1    	mov	x1, x27
1002a4814: aa1c03e2    	mov	x2, x28
1002a4818: 95e60a49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a481c: 91000673    	add	x19, x19, #0x1
1002a4820: eb13031f    	cmp	x24, x19
1002a4824: 54fff681    	b.ne	0x1002a46f4 <__text+0x29c6f4>
1002a4828: 910283e2    	add	x2, sp, #0xa0
1002a482c: 910883e3    	add	x3, sp, #0x220
1002a4830: f9402fe0    	ldr	x0, [sp, #0x58]
1002a4834: f9400be1    	ldr	x1, [sp, #0x10]
1002a4838: 52800204    	mov	w4, #0x10               ; =16
1002a483c: 95e60a40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4840: aa0003f8    	mov	x24, x0
1002a4844: b5fff300    	cbnz	x0, 0x1002a46a4 <__text+0x29c6a4>
1002a4848: f9402ff3    	ldr	x19, [sp, #0x58]
1002a484c: aa1303e0    	mov	x0, x19
1002a4850: 95e60a41    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4854: aa1303e0    	mov	x0, x19
1002a4858: 95e60a3f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a485c: f94007f5    	ldr	x21, [sp, #0x8]
1002a4860: 14000002    	b	0x1002a4868 <__text+0x29c868>
1002a4864: f9402ff7    	ldr	x23, [sp, #0x58]
1002a4868: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a486c: f9468d00    	ldr	x0, [x8, #0xd18]
1002a4870: 900fdcc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1002a4874: f9412501    	ldr	x1, [x8, #0x248] ; isVisionPro
1002a4878: 95e60a31    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a487c: 34001760    	cbz	w0, 0x1002a4b68 <__text+0x29cb68>
1002a4880: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a4884: f9455513    	ldr	x19, [x8, #0xaa8]
1002a4888: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a488c: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1002a4890: aa1703e0    	mov	x0, x23
1002a4894: 95e60a2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4898: aa0003e2    	mov	x2, x0
1002a489c: f00ff2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a48a0: f941b501    	ldr	x1, [x8, #0x368] ; arrayWithCapacity:
1002a48a4: aa1303e0    	mov	x0, x19
1002a48a8: 95e60a25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a48ac: aa1d03fd    	mov	x29, x29
1002a48b0: 95e60a26    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a48b4: f90027e0    	str	x0, [sp, #0x48]
1002a48b8: 900ff688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002a48bc: f9406918    	ldr	x24, [x8, #0xd0]
1002a48c0: f00ff673    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
1002a48c4: f9458a60    	ldr	x0, [x19, #0xb10]
1002a48c8: 900ff308    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1002a48cc: f947a914    	ldr	x20, [x8, #0xf50] ; numberWithInteger:
1002a48d0: aa1403e1    	mov	x1, x20
1002a48d4: 528001c2    	mov	w2, #0xe                ; =14
1002a48d8: 95e60a19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a48dc: aa1d03fd    	mov	x29, x29
1002a48e0: 95e60a1a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a48e4: aa0003f5    	mov	x21, x0
1002a48e8: f900f7e0    	str	x0, [sp, #0x1e8]
1002a48ec: f9458a60    	ldr	x0, [x19, #0xb10]
1002a48f0: aa1403e1    	mov	x1, x20
1002a48f4: 528001a2    	mov	w2, #0xd                ; =13
1002a48f8: 95e60a11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a48fc: aa1d03fd    	mov	x29, x29
1002a4900: 95e60a12    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4904: aa0003f6    	mov	x22, x0
1002a4908: f900fbe0    	str	x0, [sp, #0x1f0]
1002a490c: f9458a60    	ldr	x0, [x19, #0xb10]
1002a4910: aa1403e1    	mov	x1, x20
1002a4914: 52800062    	mov	w2, #0x3                ; =3
1002a4918: 95e60a09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a491c: aa1d03fd    	mov	x29, x29
1002a4920: 95e60a0a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4924: aa0003f9    	mov	x25, x0
1002a4928: f900ffe0    	str	x0, [sp, #0x1f8]
1002a492c: f9458a60    	ldr	x0, [x19, #0xb10]
1002a4930: aa1403e1    	mov	x1, x20
1002a4934: 52800322    	mov	w2, #0x19               ; =25
1002a4938: 95e60a01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a493c: aa1d03fd    	mov	x29, x29
1002a4940: 95e60a02    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4944: aa0003fa    	mov	x26, x0
1002a4948: f90103e0    	str	x0, [sp, #0x200]
1002a494c: f9458a60    	ldr	x0, [x19, #0xb10]
1002a4950: aa1403e1    	mov	x1, x20
1002a4954: 52800182    	mov	w2, #0xc                ; =12
1002a4958: 95e609f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a495c: aa1d03fd    	mov	x29, x29
1002a4960: 95e609fa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4964: aa0003fb    	mov	x27, x0
1002a4968: f90107e0    	str	x0, [sp, #0x208]
1002a496c: f9458a60    	ldr	x0, [x19, #0xb10]
1002a4970: aa1403e1    	mov	x1, x20
1002a4974: 52800262    	mov	w2, #0x13               ; =19
1002a4978: 95e609f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a497c: aa1d03fd    	mov	x29, x29
1002a4980: 95e609f2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4984: aa0003fc    	mov	x28, x0
1002a4988: f9010be0    	str	x0, [sp, #0x210]
1002a498c: f9458a60    	ldr	x0, [x19, #0xb10]
1002a4990: f9002bf4    	str	x20, [sp, #0x50]
1002a4994: aa1403e1    	mov	x1, x20
1002a4998: 528001e2    	mov	w2, #0xf                ; =15
1002a499c: 95e609e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a49a0: aa1d03fd    	mov	x29, x29
1002a49a4: 95e609e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a49a8: aa0003f3    	mov	x19, x0
1002a49ac: f9010fe0    	str	x0, [sp, #0x218]
1002a49b0: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a49b4: f9456d00    	ldr	x0, [x8, #0xad8]
1002a49b8: f00ff2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a49bc: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
1002a49c0: 9107a3e2    	add	x2, sp, #0x1e8
1002a49c4: 528000e3    	mov	w3, #0x7                ; =7
1002a49c8: 95e609dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a49cc: aa1d03fd    	mov	x29, x29
1002a49d0: 95e609de    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a49d4: aa0003f4    	mov	x20, x0
1002a49d8: d00ff328    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1002a49dc: f9419101    	ldr	x1, [x8, #0x320] ; setWithArray:
1002a49e0: aa1803e0    	mov	x0, x24
1002a49e4: aa1403e2    	mov	x2, x20
1002a49e8: 95e609d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a49ec: aa1d03fd    	mov	x29, x29
1002a49f0: 95e609d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a49f4: f9002fe0    	str	x0, [sp, #0x58]
1002a49f8: aa1403e0    	mov	x0, x20
1002a49fc: 95e609d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4a00: aa1303e0    	mov	x0, x19
1002a4a04: 95e609d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4a08: aa1c03e0    	mov	x0, x28
1002a4a0c: 95e609d2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4a10: aa1b03e0    	mov	x0, x27
1002a4a14: 95e609d0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4a18: aa1a03e0    	mov	x0, x26
1002a4a1c: 95e609ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4a20: aa1903e0    	mov	x0, x25
1002a4a24: 95e609cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4a28: aa1603e0    	mov	x0, x22
1002a4a2c: 95e609ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4a30: aa1503e0    	mov	x0, x21
1002a4a34: 95e609c8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4a38: 4f00e400    	movi.16b	v0, #0x0
1002a4a3c: ad0403e0    	stp	q0, q0, [sp, #0x80]
1002a4a40: ad0303e0    	stp	q0, q0, [sp, #0x60]
1002a4a44: aa1703e0    	mov	x0, x23
1002a4a48: 95e609bc    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a4a4c: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4a50: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1002a4a54: 910183e2    	add	x2, sp, #0x60
1002a4a58: 9105a3e3    	add	x3, sp, #0x168
1002a4a5c: f90023e1    	str	x1, [sp, #0x40]
1002a4a60: 52800204    	mov	w4, #0x10               ; =16
1002a4a64: 95e609b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4a68: b4000700    	cbz	x0, 0x1002a4b48 <__text+0x29cb48>
1002a4a6c: aa0003f4    	mov	x20, x0
1002a4a70: f9403be8    	ldr	x8, [sp, #0x70]
1002a4a74: f9400116    	ldr	x22, [x8]
1002a4a78: aa1703f8    	mov	x24, x23
1002a4a7c: d2800017    	mov	x23, #0x0               ; =0
1002a4a80: f00fdcc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a4a84: f9436519    	ldr	x25, [x8, #0x6c8] ; menuType
1002a4a88: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4a8c: f9424d1a    	ldr	x26, [x8, #0x498] ; containsObject:
1002a4a90: d00fdca8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a4a94: f943c51b    	ldr	x27, [x8, #0x788] ; safeAddObject:
1002a4a98: f9403be8    	ldr	x8, [sp, #0x70]
1002a4a9c: f9400108    	ldr	x8, [x8]
1002a4aa0: eb16011f    	cmp	x8, x22
1002a4aa4: 54000060    	b.eq	0x1002a4ab0 <__text+0x29cab0>
1002a4aa8: aa1803e0    	mov	x0, x24
1002a4aac: 95e609a9    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1002a4ab0: f94037e8    	ldr	x8, [sp, #0x68]
1002a4ab4: f877791c    	ldr	x28, [x8, x23, lsl #3]
1002a4ab8: f00ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a4abc: f9458913    	ldr	x19, [x8, #0xb10]
1002a4ac0: aa1c03e0    	mov	x0, x28
1002a4ac4: aa1903e1    	mov	x1, x25
1002a4ac8: 95e6099d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4acc: aa0003e2    	mov	x2, x0
1002a4ad0: aa1303e0    	mov	x0, x19
1002a4ad4: f9402be1    	ldr	x1, [sp, #0x50]
1002a4ad8: 95e60999    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4adc: aa1d03fd    	mov	x29, x29
1002a4ae0: 95e6099a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a4ae4: aa0003f3    	mov	x19, x0
1002a4ae8: f9402fe0    	ldr	x0, [sp, #0x58]
1002a4aec: aa1a03e1    	mov	x1, x26
1002a4af0: aa1303e2    	mov	x2, x19
1002a4af4: 95e60992    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4af8: aa0003f5    	mov	x21, x0
1002a4afc: aa1303e0    	mov	x0, x19
1002a4b00: 95e60995    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4b04: 370000b5    	tbnz	w21, #0x0, 0x1002a4b18 <__text+0x29cb18>
1002a4b08: f94027e0    	ldr	x0, [sp, #0x48]
1002a4b0c: aa1b03e1    	mov	x1, x27
1002a4b10: aa1c03e2    	mov	x2, x28
1002a4b14: 95e6098a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4b18: 910006f7    	add	x23, x23, #0x1
1002a4b1c: eb17029f    	cmp	x20, x23
1002a4b20: 54fffbc1    	b.ne	0x1002a4a98 <__text+0x29ca98>
1002a4b24: 910183e2    	add	x2, sp, #0x60
1002a4b28: 9105a3e3    	add	x3, sp, #0x168
1002a4b2c: aa1803f7    	mov	x23, x24
1002a4b30: aa1803e0    	mov	x0, x24
1002a4b34: f94023e1    	ldr	x1, [sp, #0x40]
1002a4b38: 52800204    	mov	w4, #0x10               ; =16
1002a4b3c: 95e60980    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4b40: aa0003f4    	mov	x20, x0
1002a4b44: b5fff9a0    	cbnz	x0, 0x1002a4a78 <__text+0x29ca78>
1002a4b48: aa1703e0    	mov	x0, x23
1002a4b4c: 95e60982    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4b50: aa1703e0    	mov	x0, x23
1002a4b54: 95e60980    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4b58: f9402fe0    	ldr	x0, [sp, #0x58]
1002a4b5c: 95e6097e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4b60: f94007f5    	ldr	x21, [sp, #0x8]
1002a4b64: f94027f7    	ldr	x23, [sp, #0x48]
1002a4b68: 900ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a4b6c: f9431501    	ldr	x1, [x8, #0x628] ; copy
1002a4b70: aa1703e0    	mov	x0, x23
1002a4b74: 95e60972    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a4b78: aa0003f3    	mov	x19, x0
1002a4b7c: aa1503e0    	mov	x0, x21
1002a4b80: 95e60975    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4b84: f94003e0    	ldr	x0, [sp]
1002a4b88: 95e60973    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4b8c: aa1703e0    	mov	x0, x23
1002a4b90: 95e60971    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a4b94: f85a03a8    	ldur	x8, [x29, #-0x60]
1002a4b98: f00e9a49    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a4b9c: f9405929    	ldr	x9, [x9, #0xb0]
1002a4ba0: f9400129    	ldr	x9, [x9]
1002a4ba4: eb08013f    	cmp	x9, x8
1002a4ba8: 54000141    	b.ne	0x1002a4bd0 <__text+0x29cbd0>
1002a4bac: aa1303e0    	mov	x0, x19
1002a4bb0: 910ec3ff    	add	sp, sp, #0x3b0
1002a4bb4: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1002a4bb8: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1002a4bbc: a94357f6    	ldp	x22, x21, [sp, #0x30]
1002a4bc0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1002a4bc4: a94167fa    	ldp	x26, x25, [sp, #0x10]
1002a4bc8: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1002a4bcc: 15e60969    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
1002a4bd0: 95e60969    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>