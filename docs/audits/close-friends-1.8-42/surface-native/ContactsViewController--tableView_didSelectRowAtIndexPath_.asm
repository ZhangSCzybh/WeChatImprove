
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010ecca0: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1010ecca4: a90167fa    	stp	x26, x25, [sp, #0x10]
1010ecca8: a9025ff8    	stp	x24, x23, [sp, #0x20]
1010eccac: a90357f6    	stp	x22, x21, [sp, #0x30]
1010eccb0: a9044ff4    	stp	x20, x19, [sp, #0x40]
1010eccb4: a9057bfd    	stp	x29, x30, [sp, #0x50]
1010eccb8: 910143fd    	add	x29, sp, #0x50
1010eccbc: aa0303f4    	mov	x20, x3
1010eccc0: aa0203f3    	mov	x19, x2
1010eccc4: aa0003f6    	mov	x22, x0
1010eccc8: b00fda28    	adrp	x8, 0x120c31000 <dyld_stub_binder+0x120c31000>
1010ecccc: 52800029    	mov	w9, #0x1                ; =1
1010eccd0: 39018909    	strb	w9, [x8, #0x62]
1010eccd4: aa0203e0    	mov	x0, x2
1010eccd8: 95ace918    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010eccdc: aa1403e0    	mov	x0, x20
1010ecce0: 95ace916    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010ecce4: 900f6a88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1010ecce8: f947f901    	ldr	x1, [x8, #0xff0] ; deselectRowAtIndexPath:animated:
1010eccec: aa1303e0    	mov	x0, x19
1010eccf0: aa1403e2    	mov	x2, x20
1010eccf4: 52800023    	mov	w3, #0x1                ; =1
1010eccf8: 95ace911    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010eccfc: f00f6ce8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010ecd00: f944a901    	ldr	x1, [x8, #0x950] ; transformIndexPathToAddressbookCellType:
1010ecd04: aa1603e0    	mov	x0, x22
1010ecd08: aa1403e2    	mov	x2, x20
1010ecd0c: 95ace90c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecd10: 340000c0    	cbz	w0, 0x1010ecd28 <__text+0x10e4d28>
1010ecd14: aa0003e2    	mov	x2, x0
1010ecd18: f00f6ce8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010ecd1c: f944ad01    	ldr	x1, [x8, #0x958] ; reportClickContactsAddressbookCell:
1010ecd20: aa1603e0    	mov	x0, x22
1010ecd24: 95ace906    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecd28: 900f6a88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1010ecd2c: f9427d15    	ldr	x21, [x8, #0x4f8] ; section
1010ecd30: aa1403e0    	mov	x0, x20
1010ecd34: aa1503e1    	mov	x1, x21
1010ecd38: 95ace901    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecd3c: aa0003e2    	mov	x2, x0
1010ecd40: d00f6cc8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
1010ecd44: f9418501    	ldr	x1, [x8, #0x308] ; getSectionType:
1010ecd48: aa1603e0    	mov	x0, x22
1010ecd4c: 95ace8fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecd50: 7100081f    	cmp	w0, #0x2
1010ecd54: 540001ed    	b.le	0x1010ecd90 <__text+0x10e4d90>
1010ecd58: 71000c1f    	cmp	w0, #0x3
1010ecd5c: 54000320    	b.eq	0x1010ecdc0 <__text+0x10e4dc0>
1010ecd60: 7100101f    	cmp	w0, #0x4
1010ecd64: 540003e0    	b.eq	0x1010ecde0 <__text+0x10e4de0>
1010ecd68: 7100141f    	cmp	w0, #0x5
1010ecd6c: 54000701    	b.ne	0x1010ece4c <__text+0x10e4e4c>
1010ecd70: d00f80c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1010ecd74: f9440901    	ldr	x1, [x8, #0x810] ; row
1010ecd78: aa1403e0    	mov	x0, x20
1010ecd7c: 95ace8f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecd80: aa0003e2    	mov	x2, x0
1010ecd84: f00f6ce8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010ecd88: f944b901    	ldr	x1, [x8, #0x970] ; handleSelectOpenIM:
1010ecd8c: 14000024    	b	0x1010ece1c <__text+0x10e4e1c>
1010ecd90: 7100041f    	cmp	w0, #0x1
1010ecd94: 54000360    	b.eq	0x1010ece00 <__text+0x10e4e00>
1010ecd98: 7100081f    	cmp	w0, #0x2
1010ecd9c: 54000581    	b.ne	0x1010ece4c <__text+0x10e4e4c>
1010ecda0: d00f80c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1010ecda4: f9440901    	ldr	x1, [x8, #0x810] ; row
1010ecda8: aa1403e0    	mov	x0, x20
1010ecdac: 95ace8e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecdb0: aa0003e2    	mov	x2, x0
1010ecdb4: f00f6ce8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010ecdb8: f944bd01    	ldr	x1, [x8, #0x978] ; handleSelectdBrandGroup:
1010ecdbc: 14000018    	b	0x1010ece1c <__text+0x10e4e1c>
1010ecdc0: d00f80c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1010ecdc4: f9440901    	ldr	x1, [x8, #0x810] ; row
1010ecdc8: aa1403e0    	mov	x0, x20
1010ecdcc: 95ace8dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecdd0: aa0003e2    	mov	x2, x0
1010ecdd4: f00f6ce8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010ecdd8: f944c101    	ldr	x1, [x8, #0x980] ; handleSelectedBrandServiceGroup:
1010ecddc: 14000010    	b	0x1010ece1c <__text+0x10e4e1c>
1010ecde0: d00f80c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1010ecde4: f9440901    	ldr	x1, [x8, #0x810] ; row
1010ecde8: aa1403e0    	mov	x0, x20
1010ecdec: 95ace8d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecdf0: aa0003e2    	mov	x2, x0
1010ecdf4: f00f6ce8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010ecdf8: f944b501    	ldr	x1, [x8, #0x968] ; handleSelectEnterpriseBrand:
1010ecdfc: 14000008    	b	0x1010ece1c <__text+0x10e4e1c>
1010ece00: d00f80c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1010ece04: f9440901    	ldr	x1, [x8, #0x810] ; row
1010ece08: aa1403e0    	mov	x0, x20
1010ece0c: 95ace8cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ece10: aa0003e2    	mov	x2, x0
1010ece14: f00f6ce8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010ece18: f944b101    	ldr	x1, [x8, #0x960] ; handleSelectdHelloGroup:
1010ece1c: aa1603e0    	mov	x0, x22
1010ece20: 95ace8c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ece24: aa1403e0    	mov	x0, x20
1010ece28: 95ace8cb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ece2c: aa1303e0    	mov	x0, x19
1010ece30: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1010ece34: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1010ece38: a94357f6    	ldp	x22, x21, [sp, #0x30]
1010ece3c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1010ece40: a94167fa    	ldp	x26, x25, [sp, #0x10]
1010ece44: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1010ece48: 15ace8c3    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ece4c: aa1403e0    	mov	x0, x20
1010ece50: aa1503e1    	mov	x1, x21
1010ece54: 95ace8ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ece58: aa0003e2    	mov	x2, x0
1010ece5c: f00f6ce8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010ece60: f9443501    	ldr	x1, [x8, #0x868] ; ConvertToNormalContactSection:
1010ece64: aa1603e0    	mov	x0, x22
1010ece68: 95ace8b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ece6c: aa0003f5    	mov	x21, x0
1010ece70: d00f80c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1010ece74: f9440901    	ldr	x1, [x8, #0x810] ; row
1010ece78: aa1403e0    	mov	x0, x20
1010ece7c: 95ace8b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ece80: aa0003f8    	mov	x24, x0
1010ece84: d00f87e8    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010ece88: b98a6d1a    	ldrsw	x26, [x8, #0xa6c] ; ivar ContactsViewController.m_contactsDataLogic
1010ece8c: f87a6ac0    	ldr	x0, [x22, x26]
1010ece90: d00f6b48    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1010ece94: f942d901    	ldr	x1, [x8, #0x5b0] ; getKeysArray
1010ece98: 95ace8a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ece9c: aa1d03fd    	mov	x29, x29
1010ecea0: 95ace8aa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010ecea4: aa0003f7    	mov	x23, x0
1010ecea8: d00f6a68    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1010eceac: f942c119    	ldr	x25, [x8, #0x580] ; safeObjectAtIndex:
1010eceb0: aa1903e1    	mov	x1, x25
1010eceb4: aa1503e2    	mov	x2, x21
1010eceb8: 95ace8a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecebc: aa1d03fd    	mov	x29, x29
1010ecec0: 95ace8a2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010ecec4: aa0003f5    	mov	x21, x0
1010ecec8: aa1703e0    	mov	x0, x23
1010ececc: 95ace8a2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010eced0: f87a6ac0    	ldr	x0, [x22, x26]
1010eced4: d00f6b48    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1010eced8: f9430901    	ldr	x1, [x8, #0x610] ; getContactsArrayWith:
1010ecedc: aa1503e2    	mov	x2, x21
1010ecee0: 95ace897    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecee4: aa1d03fd    	mov	x29, x29
1010ecee8: 95ace898    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010eceec: aa0003f7    	mov	x23, x0
1010ecef0: 900f80a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010ecef4: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1010ecef8: 95ace891    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecefc: eb00031f    	cmp	x24, x0
1010ecf00: 54001062    	b.hs	0x1010ed10c <__text+0x10e510c>
1010ecf04: aa1703e0    	mov	x0, x23
1010ecf08: aa1903e1    	mov	x1, x25
1010ecf0c: aa1803e2    	mov	x2, x24
1010ecf10: 95ace88b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecf14: aa1d03fd    	mov	x29, x29
1010ecf18: 95ace88c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010ecf1c: b4000f80    	cbz	x0, 0x1010ed10c <__text+0x10e510c>
1010ecf20: aa0003f8    	mov	x24, x0
1010ecf24: 900f6b68    	adrp	x8, 0x11fe58000 <dyld_stub_binder+0x11fe58000>
1010ecf28: f9448d01    	ldr	x1, [x8, #0x918] ; tryLoadExtInfo
1010ecf2c: 95ace884    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecf30: d00f6cc8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
1010ecf34: f9422501    	ldr	x1, [x8, #0x448] ; showContactInfoView:
1010ecf38: aa1603e0    	mov	x0, x22
1010ecf3c: aa1803e2    	mov	x2, x24
1010ecf40: 95ace87f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecf44: d00f80c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1010ecf48: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
1010ecf4c: aa1303e0    	mov	x0, x19
1010ecf50: 95ace87b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecf54: 900f6a88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1010ecf58: f9416101    	ldr	x1, [x8, #0x2c0] ; cellForRowAtIndexPath:
1010ecf5c: aa1303e0    	mov	x0, x19
1010ecf60: aa1403e2    	mov	x2, x20
1010ecf64: 95ace876    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecf68: aa1d03fd    	mov	x29, x29
1010ecf6c: 95ace877    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010ecf70: aa0003f6    	mov	x22, x0
1010ecf74: f00f8468    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1010ecf78: f943bd00    	ldr	x0, [x8, #0x778]
1010ecf7c: f00f8088    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1010ecf80: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1010ecf84: 95ace86e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecf88: aa0003e2    	mov	x2, x0
1010ecf8c: f00f80a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1010ecf90: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
1010ecf94: aa1603e0    	mov	x0, x22
1010ecf98: 95ace869    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecf9c: 34000b00    	cbz	w0, 0x1010ed0fc <__text+0x10e50fc>
1010ecfa0: f00f8468    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1010ecfa4: f9451500    	ldr	x0, [x8, #0xa28]
1010ecfa8: 95ace86c    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1010ecfac: aa0003f9    	mov	x25, x0
1010ecfb0: f00f6a68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1010ecfb4: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
1010ecfb8: aa1803e0    	mov	x0, x24
1010ecfbc: 95ace860    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecfc0: aa1d03fd    	mov	x29, x29
1010ecfc4: 95ace861    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010ecfc8: aa0003fa    	mov	x26, x0
1010ecfcc: b00f6b08    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
1010ecfd0: f942a901    	ldr	x1, [x8, #0x550] ; setToUsername:
1010ecfd4: aa1903e0    	mov	x0, x25
1010ecfd8: aa1a03e2    	mov	x2, x26
1010ecfdc: 95ace858    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecfe0: aa1a03e0    	mov	x0, x26
1010ecfe4: 95ace85c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ecfe8: f00f6ae8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1010ecfec: f9460d1a    	ldr	x26, [x8, #0xc18] ; mostRecentTextState
1010ecff0: aa1803e0    	mov	x0, x24
1010ecff4: aa1a03e1    	mov	x1, x26
1010ecff8: 95ace851    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ecffc: aa1d03fd    	mov	x29, x29
1010ed000: 95ace852    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010ed004: aa0003fb    	mov	x27, x0
1010ed008: f00f6c28    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
1010ed00c: f9470d01    	ldr	x1, [x8, #0xe18] ; textStateId
1010ed010: 95ace84b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ed014: aa1d03fd    	mov	x29, x29
1010ed018: 95ace84c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010ed01c: aa0003fc    	mov	x28, x0
1010ed020: f00f6ca8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
1010ed024: f947f501    	ldr	x1, [x8, #0xfe8] ; setToTextStateId:
1010ed028: aa1903e0    	mov	x0, x25
1010ed02c: aa1c03e2    	mov	x2, x28
1010ed030: 95ace843    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ed034: aa1c03e0    	mov	x0, x28
1010ed038: 95ace847    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ed03c: aa1b03e0    	mov	x0, x27
1010ed040: 95ace845    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ed044: aa1803e0    	mov	x0, x24
1010ed048: aa1a03e1    	mov	x1, x26
1010ed04c: 95ace83c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ed050: aa1d03fd    	mov	x29, x29
1010ed054: 95ace83d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010ed058: aa0003fa    	mov	x26, x0
1010ed05c: f00f6ca8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
1010ed060: f947f901    	ldr	x1, [x8, #0xff0] ; iconId
1010ed064: 95ace836    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ed068: aa1d03fd    	mov	x29, x29
1010ed06c: 95ace837    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010ed070: aa0003fb    	mov	x27, x0
1010ed074: f00f6ca8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
1010ed078: f947fd01    	ldr	x1, [x8, #0xff8] ; setToIconId:
1010ed07c: aa1903e0    	mov	x0, x25
1010ed080: aa1b03e2    	mov	x2, x27
1010ed084: 95ace82e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ed088: aa1b03e0    	mov	x0, x27
1010ed08c: 95ace832    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ed090: aa1a03e0    	mov	x0, x26
1010ed094: 95ace830    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ed098: 900f80e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1010ed09c: f943fd01    	ldr	x1, [x8, #0x7f8] ; setScene:
1010ed0a0: aa1903e0    	mov	x0, x25
1010ed0a4: 52800142    	mov	w2, #0xa                ; =10
1010ed0a8: 95ace825    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ed0ac: b00f6ca8    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
1010ed0b0: f9400101    	ldr	x1, [x8]
1010ed0b4: aa1603e0    	mov	x0, x22
1010ed0b8: 95ace821    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ed0bc: aa0003e2    	mov	x2, x0
1010ed0c0: 900f6cc8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
1010ed0c4: f9400101    	ldr	x1, [x8]
1010ed0c8: aa1903e0    	mov	x0, x25
1010ed0cc: 95ace81c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ed0d0: 900f6cc8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
1010ed0d4: f9400501    	ldr	x1, [x8, #0x8] ; setClickResult:
1010ed0d8: aa1903e0    	mov	x0, x25
1010ed0dc: 52800022    	mov	w2, #0x1                ; =1
1010ed0e0: 95ace817    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ed0e4: 900f6aa8    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
1010ed0e8: f9401d01    	ldr	x1, [x8, #0x38] ; doReport
1010ed0ec: aa1903e0    	mov	x0, x25
1010ed0f0: 95ace813    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010ed0f4: aa1903e0    	mov	x0, x25
1010ed0f8: 95ace817    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ed0fc: aa1603e0    	mov	x0, x22
1010ed100: 95ace815    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ed104: aa1803e0    	mov	x0, x24
1010ed108: 95ace813    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ed10c: aa1703e0    	mov	x0, x23
1010ed110: 95ace811    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ed114: aa1503e0    	mov	x0, x21
1010ed118: 95ace80f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010ed11c: 17ffff42    	b	0x1010ece24 <__text+0x10e4e24>
