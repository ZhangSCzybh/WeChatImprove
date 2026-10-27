
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104eaa7b4: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
104eaa7b8: a90167fa    	stp	x26, x25, [sp, #0x10]
104eaa7bc: a9025ff8    	stp	x24, x23, [sp, #0x20]
104eaa7c0: a90357f6    	stp	x22, x21, [sp, #0x30]
104eaa7c4: a9044ff4    	stp	x20, x19, [sp, #0x40]
104eaa7c8: a9057bfd    	stp	x29, x30, [sp, #0x50]
104eaa7cc: 910143fd    	add	x29, sp, #0x50
104eaa7d0: aa0003f9    	mov	x25, x0
104eaa7d4: b00deca8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104eaa7d8: 52800029    	mov	w9, #0x1                ; =1
104eaa7dc: 39082d09    	strb	w9, [x8, #0x20b]
104eaa7e0: f00d96a8    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
104eaa7e4: f9412900    	ldr	x0, [x8, #0x250]
104eaa7e8: 94b5f25c    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104eaa7ec: aa0003f4    	mov	x20, x0
104eaa7f0: b00d9648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104eaa7f4: f945e900    	ldr	x0, [x8, #0xbd0]
104eaa7f8: d00d92a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104eaa7fc: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
104eaa800: aa1503e1    	mov	x1, x21
104eaa804: 94b5f24e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa808: aa1d03fd    	mov	x29, x29
104eaa80c: 94b5f24f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa810: aa0003fa    	mov	x26, x0
104eaa814: b00d9653    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
104eaa818: f9462a60    	ldr	x0, [x19, #0xc50]
104eaa81c: b00d92a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104eaa820: f947ad16    	ldr	x22, [x8, #0xf58] ; class
104eaa824: aa1603e1    	mov	x1, x22
104eaa828: 94b5f245    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa82c: aa0003e2    	mov	x2, x0
104eaa830: f00d7c68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104eaa834: f9464117    	ldr	x23, [x8, #0xc80] ; getService:
104eaa838: aa1a03e0    	mov	x0, x26
104eaa83c: aa1703e1    	mov	x1, x23
104eaa840: 94b5f23f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa844: aa1d03fd    	mov	x29, x29
104eaa848: 94b5f240    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa84c: aa0003fb    	mov	x27, x0
104eaa850: f00d7c68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104eaa854: f9464518    	ldr	x24, [x8, #0xc88] ; getStringForCurLanguage:
104eaa858: d00cb8e2    	adrp	x2, 0x11e5c8000 <dyld_stub_binder+0x11e5c8000>
104eaa85c: 9115a042    	add	x2, x2, #0x568
104eaa860: aa1803e1    	mov	x1, x24
104eaa864: 94b5f236    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa868: aa1d03fd    	mov	x29, x29
104eaa86c: 94b5f237    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa870: aa0003fc    	mov	x28, x0
104eaa874: b00d8088    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
104eaa878: f945c101    	ldr	x1, [x8, #0xb80] ; setViewControllerTitle:
104eaa87c: aa1403e0    	mov	x0, x20
104eaa880: aa1c03e2    	mov	x2, x28
104eaa884: 94b5f22e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa888: aa1c03e0    	mov	x0, x28
104eaa88c: 94b5f232    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa890: aa1b03e0    	mov	x0, x27
104eaa894: 94b5f230    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa898: aa1a03e0    	mov	x0, x26
104eaa89c: 94b5f22e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa8a0: b00d92e8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104eaa8a4: f9451501    	ldr	x1, [x8, #0xa28] ; setDelegate:
104eaa8a8: aa1403e0    	mov	x0, x20
104eaa8ac: aa1903e2    	mov	x2, x25
104eaa8b0: 94b5f223    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa8b4: b00d8088    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
104eaa8b8: f945c501    	ldr	x1, [x8, #0xb88] ; setCanEditTagLabel:
104eaa8bc: aa1403e0    	mov	x0, x20
104eaa8c0: 52800002    	mov	w2, #0x0                ; =0
104eaa8c4: 94b5f21e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa8c8: b00d9648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104eaa8cc: f945e900    	ldr	x0, [x8, #0xbd0]
104eaa8d0: aa1503e1    	mov	x1, x21
104eaa8d4: 94b5f21a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa8d8: aa1d03fd    	mov	x29, x29
104eaa8dc: 94b5f21b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa8e0: aa0003fa    	mov	x26, x0
104eaa8e4: f9462a60    	ldr	x0, [x19, #0xc50]
104eaa8e8: aa1603e1    	mov	x1, x22
104eaa8ec: 94b5f214    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa8f0: aa0003e2    	mov	x2, x0
104eaa8f4: aa1a03e0    	mov	x0, x26
104eaa8f8: aa1703e1    	mov	x1, x23
104eaa8fc: 94b5f210    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa900: aa1d03fd    	mov	x29, x29
104eaa904: 94b5f211    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa908: aa0003fb    	mov	x27, x0
104eaa90c: 900cbda2    	adrp	x2, 0x11e65e000 <dyld_stub_binder+0x11e65e000>
104eaa910: 9135a042    	add	x2, x2, #0xd68
104eaa914: aa1803e1    	mov	x1, x24
104eaa918: 94b5f209    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa91c: aa1d03fd    	mov	x29, x29
104eaa920: 94b5f20a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa924: aa0003fc    	mov	x28, x0
104eaa928: b00d8088    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
104eaa92c: f945cd01    	ldr	x1, [x8, #0xb98] ; setRightBarTitle:
104eaa930: aa1403e0    	mov	x0, x20
104eaa934: aa1c03e2    	mov	x2, x28
104eaa938: 94b5f201    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa93c: aa1c03e0    	mov	x0, x28
104eaa940: 94b5f205    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa944: aa1b03e0    	mov	x0, x27
104eaa948: 94b5f203    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa94c: aa1a03e0    	mov	x0, x26
104eaa950: 94b5f201    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa954: f00d7de8    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104eaa958: f9405d01    	ldr	x1, [x8, #0xb8] ; setSourceScene:
104eaa95c: aa1403e0    	mov	x0, x20
104eaa960: 52800042    	mov	w2, #0x2                ; =2
104eaa964: 94b5f1f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa968: d00d7cc8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104eaa96c: f9448101    	ldr	x1, [x8, #0x900] ; setEnterScene:
104eaa970: aa1403e0    	mov	x0, x20
104eaa974: 52800042    	mov	w2, #0x2                ; =2
104eaa978: 94b5f1f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa97c: 900d9668    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104eaa980: f945811a    	ldr	x26, [x8, #0xb00]
104eaa984: b00d9308    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104eaa988: f946d501    	ldr	x1, [x8, #0xda8] ; view
104eaa98c: aa1903e0    	mov	x0, x25
104eaa990: 94b5f1eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa994: aa1d03fd    	mov	x29, x29
104eaa998: 94b5f1ec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa99c: aa0003fb    	mov	x27, x0
104eaa9a0: 900d92c8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104eaa9a4: f9449d01    	ldr	x1, [x8, #0x938] ; height
104eaa9a8: 94b5f1e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa9ac: 1e6d1001    	fmov	d1, #0.75000000
104eaa9b0: 1e610800    	fmul	d0, d0, d1
104eaa9b4: 900d7dc8    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
104eaa9b8: f9437d01    	ldr	x1, [x8, #0x6f8] ; adapterWithViewController:height:
104eaa9bc: aa1a03e0    	mov	x0, x26
104eaa9c0: aa1403e2    	mov	x2, x20
104eaa9c4: 94b5f1de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa9c8: aa1d03fd    	mov	x29, x29
104eaa9cc: 94b5f1df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa9d0: aa0003fa    	mov	x26, x0
104eaa9d4: aa1b03e0    	mov	x0, x27
104eaa9d8: 94b5f1df    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa9dc: d00d7d08    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
104eaa9e0: f943f91b    	ldr	x27, [x8, #0x7f0] ; pageSheetConfig
104eaa9e4: aa1a03e0    	mov	x0, x26
104eaa9e8: aa1b03e1    	mov	x1, x27
104eaa9ec: 94b5f1d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa9f0: aa1d03fd    	mov	x29, x29
104eaa9f4: 94b5f1d5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa9f8: aa0003fc    	mov	x28, x0
104eaa9fc: d00d7d08    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
104eaaa00: f9445d01    	ldr	x1, [x8, #0x8b8] ; setEnableDragToClose:
104eaaa04: 52800022    	mov	w2, #0x1                ; =1
104eaaa08: 94b5f1cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaaa0c: aa1c03e0    	mov	x0, x28
104eaaa10: 94b5f1d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaaa14: b00d9648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104eaaa18: f945e900    	ldr	x0, [x8, #0xbd0]
104eaaa1c: aa1503e1    	mov	x1, x21
104eaaa20: 94b5f1c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaaa24: aa1d03fd    	mov	x29, x29
104eaaa28: 94b5f1c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaaa2c: aa0003f5    	mov	x21, x0
104eaaa30: f9462a60    	ldr	x0, [x19, #0xc50]
104eaaa34: aa1603e1    	mov	x1, x22
104eaaa38: 94b5f1c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaaa3c: aa0003e2    	mov	x2, x0
104eaaa40: aa1503e0    	mov	x0, x21
104eaaa44: aa1703e1    	mov	x1, x23
104eaaa48: 94b5f1bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaaa4c: aa1d03fd    	mov	x29, x29
104eaaa50: 94b5f1be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaaa54: aa0003f6    	mov	x22, x0
104eaaa58: aa1803e1    	mov	x1, x24
104eaaa5c: d00cb8e2    	adrp	x2, 0x11e5c8000 <dyld_stub_binder+0x11e5c8000>
104eaaa60: 9115a042    	add	x2, x2, #0x568
104eaaa64: 94b5f1b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaaa68: aa1d03fd    	mov	x29, x29
104eaaa6c: 94b5f1b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaaa70: aa0003f7    	mov	x23, x0
104eaaa74: aa1a03e0    	mov	x0, x26
104eaaa78: aa1b03e1    	mov	x1, x27
104eaaa7c: 94b5f1b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaaa80: aa1d03fd    	mov	x29, x29
104eaaa84: 94b5f1b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaaa88: aa0003f8    	mov	x24, x0
104eaaa8c: f00d92e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104eaaa90: f9472101    	ldr	x1, [x8, #0xe40] ; setTitle:
104eaaa94: aa1703e2    	mov	x2, x23
104eaaa98: 94b5f1a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaaa9c: aa1803e0    	mov	x0, x24
104eaaaa0: 94b5f1ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaaaa4: aa1703e0    	mov	x0, x23
104eaaaa8: 94b5f1ab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaaaac: aa1603e0    	mov	x0, x22
104eaaab0: 94b5f1a9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaaab4: aa1503e0    	mov	x0, x21
104eaaab8: 94b5f1a7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaaabc: aa1a03e0    	mov	x0, x26
104eaaac0: aa1b03e1    	mov	x1, x27
104eaaac4: 94b5f19e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaaac8: aa1d03fd    	mov	x29, x29
104eaaacc: 94b5f19f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaaad0: aa0003f5    	mov	x21, x0
104eaaad4: 900d7d68    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104eaaad8: f9415501    	ldr	x1, [x8, #0x2a8] ; setNavLeftStyle:
104eaaadc: 52800042    	mov	w2, #0x2                ; =2
104eaaae0: 94b5f197    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaaae4: aa1503e0    	mov	x0, x21
104eaaae8: 94b5f19b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaaaec: d00d7ee8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104eaaaf0: f9407501    	ldr	x1, [x8, #0xe8] ; colorProxy
104eaaaf4: aa1903e0    	mov	x0, x25
104eaaaf8: 94b5f191    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaaafc: aa1d03fd    	mov	x29, x29
104eaab00: 94b5f192    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaab04: aa0003f5    	mov	x21, x0
104eaab08: b00d7ce8    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
104eaab0c: f9425101    	ldr	x1, [x8, #0x4a0] ; BG_0
104eaab10: 94b5f18b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaab14: aa1d03fd    	mov	x29, x29
104eaab18: 94b5f18c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaab1c: aa0003f6    	mov	x22, x0
104eaab20: aa1a03e0    	mov	x0, x26
104eaab24: aa1b03e1    	mov	x1, x27
104eaab28: 94b5f185    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaab2c: aa1d03fd    	mov	x29, x29
104eaab30: 94b5f186    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaab34: aa0003f7    	mov	x23, x0
104eaab38: b00d7d68    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
104eaab3c: f9458d01    	ldr	x1, [x8, #0xb18] ; setNavBarBackgroundColor:
104eaab40: aa1603e2    	mov	x2, x22
104eaab44: 94b5f17e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaab48: aa1703e0    	mov	x0, x23
104eaab4c: 94b5f182    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaab50: aa1603e0    	mov	x0, x22
104eaab54: 94b5f180    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaab58: aa1503e0    	mov	x0, x21
104eaab5c: 94b5f17e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaab60: aa1a03e0    	mov	x0, x26
104eaab64: aa1b03e1    	mov	x1, x27
104eaab68: 94b5f175    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaab6c: aa1d03fd    	mov	x29, x29
104eaab70: 94b5f176    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaab74: aa0003f5    	mov	x21, x0
104eaab78: 900d7d28    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
104eaab7c: f9454901    	ldr	x1, [x8, #0xa90] ; setIsAllowTapBgMaskToClose:
104eaab80: 52800022    	mov	w2, #0x1                ; =1
104eaab84: 94b5f16e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaab88: aa1503e0    	mov	x0, x21
104eaab8c: 94b5f172    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaab90: d00d7d08    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
104eaab94: f9445901    	ldr	x1, [x8, #0x8b0] ; setPageSheetAdapter:
104eaab98: aa1403e0    	mov	x0, x20
104eaab9c: aa1a03e2    	mov	x2, x26
104eaaba0: 94b5f167    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaaba4: d00d7c88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104eaaba8: f9456101    	ldr	x1, [x8, #0xac0] ; showFromViewController:animated:
104eaabac: aa1a03e0    	mov	x0, x26
104eaabb0: aa1903e2    	mov	x2, x25
104eaabb4: 52800023    	mov	w3, #0x1                ; =1
104eaabb8: 94b5f161    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaabbc: aa1a03e0    	mov	x0, x26
104eaabc0: 94b5f165    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaabc4: aa1403e0    	mov	x0, x20
104eaabc8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104eaabcc: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104eaabd0: a94357f6    	ldp	x22, x21, [sp, #0x30]
104eaabd4: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104eaabd8: a94167fa    	ldp	x26, x25, [sp, #0x10]
104eaabdc: a8c66ffc    	ldp	x28, x27, [sp], #0x60
104eaabe0: 14b5f15d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
