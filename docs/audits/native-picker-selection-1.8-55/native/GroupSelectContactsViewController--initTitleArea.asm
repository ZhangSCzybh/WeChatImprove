
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101eccb1c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101eccb20: a90157f6    	stp	x22, x21, [sp, #0x10]
101eccb24: a9024ff4    	stp	x20, x19, [sp, #0x20]
101eccb28: a9037bfd    	stp	x29, x30, [sp, #0x30]
101eccb2c: 9100c3fd    	add	x29, sp, #0x30
101eccb30: aa0003f3    	mov	x19, x0
101eccb34: 900f6b48    	adrp	x8, 0x120c34000 <dyld_stub_binder+0x120c34000>
101eccb38: 52800029    	mov	w9, #0x1                ; =1
101eccb3c: 390e9d09    	strb	w9, [x8, #0x3a7]
101eccb40: f00f1528    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101eccb44: f945e900    	ldr	x0, [x8, #0xbd0]
101eccb48: 900f11a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101eccb4c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101eccb50: 9575697b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccb54: aa1d03fd    	mov	x29, x29
101eccb58: 9575697c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccb5c: aa0003f5    	mov	x21, x0
101eccb60: f00f1528    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101eccb64: f9462900    	ldr	x0, [x8, #0xc50]
101eccb68: f00f1188    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101eccb6c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101eccb70: 95756973    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccb74: aa0003e2    	mov	x2, x0
101eccb78: b00efb68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101eccb7c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101eccb80: aa1503e0    	mov	x0, x21
101eccb84: 9575696e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccb88: aa1d03fd    	mov	x29, x29
101eccb8c: 9575696f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccb90: aa0003f6    	mov	x22, x0
101eccb94: b00efb68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101eccb98: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
101eccb9c: 900e38e2    	adrp	x2, 0x11e5e8000 <dyld_stub_binder+0x11e5e8000>
101eccba0: 91362042    	add	x2, x2, #0xd88
101eccba4: 95756966    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccba8: aa1d03fd    	mov	x29, x29
101eccbac: 95756967    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccbb0: aa0003f7    	mov	x23, x0
101eccbb4: b00f11e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
101eccbb8: f9472114    	ldr	x20, [x8, #0xe40] ; setTitle:
101eccbbc: aa1303e0    	mov	x0, x19
101eccbc0: aa1403e1    	mov	x1, x20
101eccbc4: aa1703e2    	mov	x2, x23
101eccbc8: 9575695d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccbcc: aa1703e0    	mov	x0, x23
101eccbd0: 95756961    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccbd4: aa1603e0    	mov	x0, x22
101eccbd8: 9575695f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccbdc: aa1503e0    	mov	x0, x21
101eccbe0: 9575695d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccbe4: d00effe8    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
101eccbe8: f944bd15    	ldr	x21, [x8, #0x978] ; m_viewControllerTitle
101eccbec: aa1303e0    	mov	x0, x19
101eccbf0: aa1503e1    	mov	x1, x21
101eccbf4: 95756952    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccbf8: aa1d03fd    	mov	x29, x29
101eccbfc: 95756953    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccc00: aa0003f6    	mov	x22, x0
101eccc04: f00f11a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101eccc08: f946e901    	ldr	x1, [x8, #0xdd0] ; length
101eccc0c: 9575694c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccc10: aa0003f7    	mov	x23, x0
101eccc14: aa1603e0    	mov	x0, x22
101eccc18: 9575694f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccc1c: b40001b7    	cbz	x23, 0x101eccc50 <_Flutter_Image_provideRelativePathByUrl+0x2d9b00>
101eccc20: aa1303e0    	mov	x0, x19
101eccc24: aa1503e1    	mov	x1, x21
101eccc28: 95756945    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccc2c: aa1d03fd    	mov	x29, x29
101eccc30: 95756946    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccc34: aa0003f5    	mov	x21, x0
101eccc38: aa1303e0    	mov	x0, x19
101eccc3c: aa1403e1    	mov	x1, x20
101eccc40: aa1503e2    	mov	x2, x21
101eccc44: 9575693e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccc48: aa1503e0    	mov	x0, x21
101eccc4c: 95756942    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccc50: f00f11e8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
101eccc54: f940d101    	ldr	x1, [x8, #0x1a0] ; title
101eccc58: aa1303e0    	mov	x0, x19
101eccc5c: 95756938    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccc60: aa1d03fd    	mov	x29, x29
101eccc64: 95756939    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccc68: aa0003f4    	mov	x20, x0
101eccc6c: d00efdc8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
101eccc70: f9416501    	ldr	x1, [x8, #0x2c8] ; setTitleInPageSheetModeIfNeeded:
101eccc74: aa1303e0    	mov	x0, x19
101eccc78: aa1403e2    	mov	x2, x20
101eccc7c: 95756930    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccc80: aa1403e0    	mov	x0, x20
101eccc84: 95756934    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccc88: d00efdc8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
101eccc8c: f9413d01    	ldr	x1, [x8, #0x278] ; createInitLeftBarItem
101eccc90: aa1303e0    	mov	x0, x19
101eccc94: 9575692a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccc98: aa1d03fd    	mov	x29, x29
101eccc9c: 9575692b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccca0: aa0003f4    	mov	x20, x0
101eccca4: 900f11c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101eccca8: f945e515    	ldr	x21, [x8, #0xbc8] ; navigationItem
101ecccac: aa1303e0    	mov	x0, x19
101ecccb0: aa1503e1    	mov	x1, x21
101ecccb4: 95756922    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecccb8: aa1d03fd    	mov	x29, x29
101ecccbc: 95756923    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecccc0: aa0003f6    	mov	x22, x0
101ecccc4: 900f11e8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
101ecccc8: f9446d01    	ldr	x1, [x8, #0x8d8] ; setLeftBarButtonItem:
101eccccc: aa1403e2    	mov	x2, x20
101ecccd0: 9575691b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecccd4: aa1603e0    	mov	x0, x22
101ecccd8: 9575691f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecccdc: aa1403e0    	mov	x0, x20
101eccce0: 9575691d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccce4: d00efdc8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
101eccce8: f9417101    	ldr	x1, [x8, #0x2e0] ; initLeftBarItemInPageSheetModeIfNeeded
101ecccec: aa1303e0    	mov	x0, x19
101ecccf0: 95756913    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecccf4: d00efdc8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
101ecccf8: f9414501    	ldr	x1, [x8, #0x288] ; createInitRightBarItem
101ecccfc: aa1303e0    	mov	x0, x19
101eccd00: 9575690f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccd04: aa1d03fd    	mov	x29, x29
101eccd08: 95756910    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccd0c: aa0003f4    	mov	x20, x0
101eccd10: aa1303e0    	mov	x0, x19
101eccd14: aa1503e1    	mov	x1, x21
101eccd18: 95756909    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccd1c: aa1d03fd    	mov	x29, x29
101eccd20: 9575690a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101eccd24: aa0003f5    	mov	x21, x0
101eccd28: f00efb68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101eccd2c: f945f101    	ldr	x1, [x8, #0xbe0] ; setRightBarButtonItem:
101eccd30: aa1403e2    	mov	x2, x20
101eccd34: 95756902    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccd38: aa1503e0    	mov	x0, x21
101eccd3c: 95756906    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccd40: aa1403e0    	mov	x0, x20
101eccd44: 95756904    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101eccd48: d00efdc8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
101eccd4c: f9417501    	ldr	x1, [x8, #0x2e8] ; initRightBarItemInPageSheetModeIfNeeded
101eccd50: aa1303e0    	mov	x0, x19
101eccd54: 957568fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101eccd58: d00effe8    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
101eccd5c: f944c101    	ldr	x1, [x8, #0x980] ; updateRightBarBtn
101eccd60: aa1303e0    	mov	x0, x19
101eccd64: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101eccd68: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101eccd6c: a94157f6    	ldp	x22, x21, [sp, #0x10]
101eccd70: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101eccd74: 157568f2    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
