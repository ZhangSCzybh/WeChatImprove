
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ea9ce8: 6dba23e9    	stp	d9, d8, [sp, #-0x60]!
104ea9cec: a90167fa    	stp	x26, x25, [sp, #0x10]
104ea9cf0: a9025ff8    	stp	x24, x23, [sp, #0x20]
104ea9cf4: a90357f6    	stp	x22, x21, [sp, #0x30]
104ea9cf8: a9044ff4    	stp	x20, x19, [sp, #0x40]
104ea9cfc: a9057bfd    	stp	x29, x30, [sp, #0x50]
104ea9d00: 910143fd    	add	x29, sp, #0x50
104ea9d04: aa0003f4    	mov	x20, x0
104ea9d08: d00deca8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104ea9d0c: 52800029    	mov	w9, #0x1                ; =1
104ea9d10: b00d9bea    	adrp	x10, 0x120226000 <dyld_stub_binder+0x120226000>
104ea9d14: b9885555    	ldrsw	x21, [x10, #0x854]
104ea9d18: b875680a    	ldr	w10, [x0, x21]
104ea9d1c: 39082509    	strb	w9, [x8, #0x209]
104ea9d20: 71007d5f    	cmp	w10, #0x1f
104ea9d24: 1aca2128    	lsl	w8, w9, w10
104ea9d28: 121d7108    	and	w8, w8, #0xfffffff8
104ea9d2c: 12011908    	and	w8, w8, #0x8000003f
104ea9d30: 7a409904    	ccmp	w8, #0x0, #0x4, ls
104ea9d34: 540022a0    	b.eq	0x104eaa188 <_Flutter_MMFoundation_BindContext+0x1385d6c>
104ea9d38: d00d9688    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
104ea9d3c: f9431500    	ldr	x0, [x8, #0x628] ;  "/
104ea9d40: 94b5f506    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104ea9d44: aa0003f3    	mov	x19, x0
104ea9d48: 900d7c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ea9d4c: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
104ea9d50: aa1403e2    	mov	x2, x20
104ea9d54: 94b5f4fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9d58: b8756a82    	ldr	w2, [x20, x21]
104ea9d5c: 900d7ec8    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
104ea9d60: f9460101    	ldr	x1, [x8, #0xc00] ; setM_uiDataScene:
104ea9d64: aa1303e0    	mov	x0, x19
104ea9d68: 94b5f4f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9d6c: 900d7ec8    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
104ea9d70: f9460515    	ldr	x21, [x8, #0xc08] ; setM_bShowSearchBar:
104ea9d74: aa1303e0    	mov	x0, x19
104ea9d78: aa1503e1    	mov	x1, x21
104ea9d7c: 52800002    	mov	w2, #0x0                ; =0
104ea9d80: 94b5f4ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9d84: 900d8748    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea9d88: f945e501    	ldr	x1, [x8, #0xbc8] ; useNewSearchControllerAndBottomBar
104ea9d8c: aa1403e0    	mov	x0, x20
104ea9d90: 94b5f4eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9d94: 340000a0    	cbz	w0, 0x104ea9da8 <_Flutter_MMFoundation_BindContext+0x138598c>
104ea9d98: aa1303e0    	mov	x0, x19
104ea9d9c: aa1503e1    	mov	x1, x21
104ea9da0: 52800022    	mov	w2, #0x1                ; =1
104ea9da4: 94b5f4e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9da8: d00d7c88    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104ea9dac: f946e101    	ldr	x1, [x8, #0xdc0] ; setHidesBottomBarWhenPushed:
104ea9db0: aa1303e0    	mov	x0, x19
104ea9db4: 52800022    	mov	w2, #0x1                ; =1
104ea9db8: 94b5f4e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9dbc: 900d8748    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea9dc0: f9465d01    	ldr	x1, [x8, #0xcb8] ; setGroupSelectContactsViewController:
104ea9dc4: aa1403e0    	mov	x0, x20
104ea9dc8: aa1303e2    	mov	x2, x19
104ea9dcc: 94b5f4dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9dd0: d00d9648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ea9dd4: f9454100    	ldr	x0, [x8, #0xa80]
104ea9dd8: b00d9be8    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea9ddc: b9881508    	ldrsw	x8, [x8, #0x814]
104ea9de0: f8686a82    	ldr	x2, [x20, x8]
104ea9de4: 900d92c8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104ea9de8: f9401d01    	ldr	x1, [x8, #0x38] ; dictionaryWithDictionary:
104ea9dec: 94b5f4d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9df0: aa1d03fd    	mov	x29, x29
104ea9df4: 94b5f4d5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea9df8: aa0003f5    	mov	x21, x0
104ea9dfc: b00d9be8    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea9e00: b9882908    	ldrsw	x8, [x8, #0x828]
104ea9e04: f8686a82    	ldr	x2, [x20, x8]
104ea9e08: b00d92a8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104ea9e0c: f946a101    	ldr	x1, [x8, #0xd40] ; addEntriesFromDictionary:
104ea9e10: 94b5f4cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9e14: 900d8748    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea9e18: f9466501    	ldr	x1, [x8, #0xcc8] ; m_bSecondaryPage
104ea9e1c: aa1403e0    	mov	x0, x20
104ea9e20: 94b5f4c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9e24: 34000720    	cbz	w0, 0x104ea9f08 <_Flutter_MMFoundation_BindContext+0x1385aec>
104ea9e28: d00d9648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ea9e2c: f945e900    	ldr	x0, [x8, #0xbd0]
104ea9e30: f00d92a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104ea9e34: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104ea9e38: 94b5f4c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9e3c: aa1d03fd    	mov	x29, x29
104ea9e40: 94b5f4c2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea9e44: aa0003f6    	mov	x22, x0
104ea9e48: d00d9648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ea9e4c: f9462900    	ldr	x0, [x8, #0xc50]
104ea9e50: d00d92a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104ea9e54: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104ea9e58: 94b5f4b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9e5c: aa0003e2    	mov	x2, x0
104ea9e60: 900d7c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ea9e64: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104ea9e68: aa1603e0    	mov	x0, x22
104ea9e6c: 94b5f4b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9e70: aa1d03fd    	mov	x29, x29
104ea9e74: 94b5f4b5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea9e78: aa0003f7    	mov	x23, x0
104ea9e7c: 900d7c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ea9e80: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
104ea9e84: d00cb4e2    	adrp	x2, 0x11e547000 <dyld_stub_binder+0x11e547000>
104ea9e88: 911fa042    	add	x2, x2, #0x7e8
104ea9e8c: 94b5f4ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9e90: aa1d03fd    	mov	x29, x29
104ea9e94: 94b5f4ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea9e98: aa0003f8    	mov	x24, x0
104ea9e9c: 900d7f08    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
104ea9ea0: f9434501    	ldr	x1, [x8, #0x688] ; setM_rightBarButtonTitle:
104ea9ea4: aa1303e0    	mov	x0, x19
104ea9ea8: aa1803e2    	mov	x2, x24
104ea9eac: 94b5f4a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9eb0: aa1803e0    	mov	x0, x24
104ea9eb4: 94b5f4a8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea9eb8: aa1703e0    	mov	x0, x23
104ea9ebc: 94b5f4a6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea9ec0: aa1603e0    	mov	x0, x22
104ea9ec4: 94b5f4a4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea9ec8: d00d9648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ea9ecc: f9458900    	ldr	x0, [x8, #0xb10]
104ea9ed0: f00d92c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104ea9ed4: f947c101    	ldr	x1, [x8, #0xf80] ; numberWithUnsignedInteger:
104ea9ed8: d2800002    	mov	x2, #0x0                ; =0
104ea9edc: 94b5f498    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9ee0: aa1d03fd    	mov	x29, x29
104ea9ee4: 94b5f499    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea9ee8: aa0003f6    	mov	x22, x0
104ea9eec: b00d8748    	adrp	x8, 0x11ff92000 <dyld_stub_binder+0x11ff92000>
104ea9ef0: f9406101    	ldr	x1, [x8, #0xc0] ; setM_leftBarButtonStyle:
104ea9ef4: aa1303e0    	mov	x0, x19
104ea9ef8: aa1603e2    	mov	x2, x22
104ea9efc: 94b5f490    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9f00: aa1603e0    	mov	x0, x22
104ea9f04: 94b5f494    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea9f08: d00d7c88    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104ea9f0c: f946fd01    	ldr	x1, [x8, #0xdf8] ; setM_dicExistContact:
104ea9f10: aa1303e0    	mov	x0, x19
104ea9f14: aa1503e2    	mov	x2, x21
104ea9f18: 94b5f489    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9f1c: b00d7d08    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104ea9f20: f940c901    	ldr	x1, [x8, #0x190] ; isInPageSheetMode
104ea9f24: aa1403e0    	mov	x0, x20
104ea9f28: 94b5f485    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9f2c: 34000fe0    	cbz	w0, 0x104eaa128 <_Flutter_MMFoundation_BindContext+0x1385d0c>
104ea9f30: b00d7ee8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
104ea9f34: f941d101    	ldr	x1, [x8, #0x3a0] ; setIsInPageSheetMode:
104ea9f38: aa1303e0    	mov	x0, x19
104ea9f3c: 52800022    	mov	w2, #0x1                ; =1
104ea9f40: 94b5f47f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9f44: d00d8288    	adrp	x8, 0x11fefb000 <dyld_stub_binder+0x11fefb000>
104ea9f48: f943ed01    	ldr	x1, [x8, #0x7d8] ; setForbidCreateNavHeader:
104ea9f4c: aa1303e0    	mov	x0, x19
104ea9f50: 52800022    	mov	w2, #0x1                ; =1
104ea9f54: 94b5f47a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9f58: d00d9648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ea9f5c: f9470100    	ldr	x0, [x8, #0xe00]
104ea9f60: f00d7de8    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
104ea9f64: f9478901    	ldr	x1, [x8, #0xf10] ; screenHeightCurOri
104ea9f68: 94b5f475    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9f6c: 1e611001    	fmov	d1, #3.00000000
104ea9f70: 1e610800    	fmul	d0, d0, d1
104ea9f74: 1e6a1001    	fmov	d1, #0.25000000
104ea9f78: 1e610808    	fmul	d8, d0, d1
104ea9f7c: b00d9668    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104ea9f80: f9458100    	ldr	x0, [x8, #0xb00]
104ea9f84: b00d7dc8    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
104ea9f88: f9437d01    	ldr	x1, [x8, #0x6f8] ; adapterWithViewController:height:
104ea9f8c: aa1303e2    	mov	x2, x19
104ea9f90: 1e604100    	fmov	d0, d8
104ea9f94: 94b5f46a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9f98: aa1d03fd    	mov	x29, x29
104ea9f9c: 94b5f46b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea9fa0: aa0003f6    	mov	x22, x0
104ea9fa4: f00d7d08    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
104ea9fa8: f9445901    	ldr	x1, [x8, #0x8b0] ; setPageSheetAdapter:
104ea9fac: aa1303e0    	mov	x0, x19
104ea9fb0: aa1603e2    	mov	x2, x22
104ea9fb4: 94b5f462    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9fb8: f00d7d08    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
104ea9fbc: f943f917    	ldr	x23, [x8, #0x7f0] ; pageSheetConfig
104ea9fc0: aa1603e0    	mov	x0, x22
104ea9fc4: aa1703e1    	mov	x1, x23
104ea9fc8: 94b5f45d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9fcc: aa1d03fd    	mov	x29, x29
104ea9fd0: 94b5f45e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea9fd4: aa0003f8    	mov	x24, x0
104ea9fd8: f00d7d08    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
104ea9fdc: f9442101    	ldr	x1, [x8, #0x840] ; headerHeight
104ea9fe0: 94b5f457    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea9fe4: 1e603908    	fsub	d8, d8, d0
104ea9fe8: aa1803e0    	mov	x0, x24
104ea9fec: 94b5f45a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea9ff0: f00d7d08    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
104ea9ff4: f9442501    	ldr	x1, [x8, #0x848] ; updateDetailViewHeight:animated:
104ea9ff8: aa1603e0    	mov	x0, x22
104ea9ffc: 1e604100    	fmov	d0, d8
104eaa000: 52800002    	mov	w2, #0x0                ; =0
104eaa004: 94b5f44e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa008: b00d9648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104eaa00c: f9462d00    	ldr	x0, [x8, #0xc58]
104eaa010: b00d92a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104eaa014: f942f101    	ldr	x1, [x8, #0x5e0] ; backgroundColor
104eaa018: 94b5f449    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa01c: aa1d03fd    	mov	x29, x29
104eaa020: 94b5f44a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa024: aa0003f8    	mov	x24, x0
104eaa028: aa1603e0    	mov	x0, x22
104eaa02c: aa1703e1    	mov	x1, x23
104eaa030: 94b5f443    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa034: aa1d03fd    	mov	x29, x29
104eaa038: 94b5f444    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa03c: aa0003f9    	mov	x25, x0
104eaa040: b00d7d68    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
104eaa044: f9458d01    	ldr	x1, [x8, #0xb18] ; setNavBarBackgroundColor:
104eaa048: aa1803e2    	mov	x2, x24
104eaa04c: 94b5f43c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa050: aa1903e0    	mov	x0, x25
104eaa054: 94b5f440    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa058: aa1803e0    	mov	x0, x24
104eaa05c: 94b5f43e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa060: aa1603e0    	mov	x0, x22
104eaa064: aa1703e1    	mov	x1, x23
104eaa068: 94b5f435    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa06c: aa1d03fd    	mov	x29, x29
104eaa070: 94b5f436    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa074: aa0003f8    	mov	x24, x0
104eaa078: 900d7d28    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
104eaa07c: f9454901    	ldr	x1, [x8, #0xa90] ; setIsAllowTapBgMaskToClose:
104eaa080: 52800022    	mov	w2, #0x1                ; =1
104eaa084: 94b5f42e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa088: aa1803e0    	mov	x0, x24
104eaa08c: 94b5f432    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa090: aa1603e0    	mov	x0, x22
104eaa094: aa1703e1    	mov	x1, x23
104eaa098: 94b5f429    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa09c: aa1d03fd    	mov	x29, x29
104eaa0a0: 94b5f42a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa0a4: aa0003f8    	mov	x24, x0
104eaa0a8: d00d7d08    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
104eaa0ac: f9445d01    	ldr	x1, [x8, #0x8b8] ; setEnableDragToClose:
104eaa0b0: 52800022    	mov	w2, #0x1                ; =1
104eaa0b4: 94b5f422    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa0b8: aa1803e0    	mov	x0, x24
104eaa0bc: 94b5f426    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa0c0: aa1603e0    	mov	x0, x22
104eaa0c4: aa1703e1    	mov	x1, x23
104eaa0c8: 94b5f41d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa0cc: aa1d03fd    	mov	x29, x29
104eaa0d0: 94b5f41e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa0d4: aa0003f7    	mov	x23, x0
104eaa0d8: b00d7d68    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
104eaa0dc: f9458101    	ldr	x1, [x8, #0xb00] ; setEnableEdgeSlideToClose:
104eaa0e0: 52800022    	mov	w2, #0x1                ; =1
104eaa0e4: 94b5f416    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa0e8: aa1703e0    	mov	x0, x23
104eaa0ec: 94b5f41a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa0f0: 900d7d08    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104eaa0f4: f940cd01    	ldr	x1, [x8, #0x198] ; pageSheetAdapter
104eaa0f8: aa1403e0    	mov	x0, x20
104eaa0fc: 94b5f410    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa100: aa1d03fd    	mov	x29, x29
104eaa104: 94b5f411    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa108: aa0003f4    	mov	x20, x0
104eaa10c: b00d7d68    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
104eaa110: f9476901    	ldr	x1, [x8, #0xed0] ; pushPageSheet:
104eaa114: aa1603e2    	mov	x2, x22
104eaa118: 94b5f409    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa11c: aa1403e0    	mov	x0, x20
104eaa120: 94b5f40d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa124: 1400000d    	b	0x104eaa158 <_Flutter_MMFoundation_BindContext+0x1385d3c>
104eaa128: d00d92c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104eaa12c: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
104eaa130: aa1403e0    	mov	x0, x20
104eaa134: 94b5f402    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa138: aa1d03fd    	mov	x29, x29
104eaa13c: 94b5f403    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104eaa140: aa0003f6    	mov	x22, x0
104eaa144: b00d7c88    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104eaa148: f944e101    	ldr	x1, [x8, #0x9c0] ; PushViewController:animated:
104eaa14c: aa1303e2    	mov	x2, x19
104eaa150: 52800023    	mov	w3, #0x1                ; =1
104eaa154: 94b5f3fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eaa158: aa1603e0    	mov	x0, x22
104eaa15c: 94b5f3fe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa160: aa1503e0    	mov	x0, x21
104eaa164: 94b5f3fc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa168: aa1303e0    	mov	x0, x19
104eaa16c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104eaa170: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104eaa174: a94357f6    	ldp	x22, x21, [sp, #0x30]
104eaa178: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104eaa17c: a94167fa    	ldp	x26, x25, [sp, #0x10]
104eaa180: 6cc623e9    	ldp	d9, d8, [sp], #0x60
104eaa184: 14b5f3f4    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eaa188: 900d8748    	adrp	x8, 0x11ff92000 <dyld_stub_binder+0x11ff92000>
104eaa18c: f9406501    	ldr	x1, [x8, #0xc8] ; openChatRoomlistHalfScreen
104eaa190: aa1403e0    	mov	x0, x20
104eaa194: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104eaa198: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104eaa19c: a94357f6    	ldp	x22, x21, [sp, #0x30]
104eaa1a0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104eaa1a4: a94167fa    	ldp	x26, x25, [sp, #0x10]
104eaa1a8: 6cc623e9    	ldp	d9, d8, [sp], #0x60
104eaa1ac: 14b5f3e4    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
