
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106ad5020: d10143ff    	sub	sp, sp, #0x50
106ad5024: a9015ff8    	stp	x24, x23, [sp, #0x10]
106ad5028: a90257f6    	stp	x22, x21, [sp, #0x20]
106ad502c: a9034ff4    	stp	x20, x19, [sp, #0x30]
106ad5030: a9047bfd    	stp	x29, x30, [sp, #0x40]
106ad5034: 910103fd    	add	x29, sp, #0x40
106ad5038: aa0203f3    	mov	x19, x2
106ad503c: aa0003f4    	mov	x20, x0
106ad5040: 900d0b88    	adrp	x8, 0x120c45000 <dyld_stub_binder+0x120c45000>
106ad5044: 52800029    	mov	w9, #0x1                ; =1
106ad5048: 3921f109    	strb	w9, [x8, #0x87c]
106ad504c: aa0203e0    	mov	x0, x2
106ad5050: 9445483a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106ad5054: 900cbb68    	adrp	x8, 0x120241000 <dyld_stub_binder+0x120241000>
106ad5058: b98d4108    	ldrsw	x8, [x8, #0xd40]
106ad505c: 8b080280    	add	x0, x20, x8
106ad5060: aa1303e1    	mov	x1, x19
106ad5064: 94454837    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
106ad5068: b00c9d48    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
106ad506c: f947bd15    	ldr	x21, [x8, #0xf78] ; thumbImageView
106ad5070: aa1403e0    	mov	x0, x20
106ad5074: aa1503e1    	mov	x1, x21
106ad5078: 94454831    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad507c: aa1d03fd    	mov	x29, x29
106ad5080: 94454832    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad5084: aa0003f6    	mov	x22, x0
106ad5088: f00cb188    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106ad508c: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
106ad5090: 52800002    	mov	w2, #0x0                ; =0
106ad5094: 9445482a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5098: aa1603e0    	mov	x0, x22
106ad509c: 9445482e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad50a0: d00cb4e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106ad50a4: f9453516    	ldr	x22, [x8, #0xa68]
106ad50a8: 900c9b88    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
106ad50ac: f940cd01    	ldr	x1, [x8, #0x198] ; tid
106ad50b0: aa1303e0    	mov	x0, x19
106ad50b4: 94454822    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad50b8: aa1d03fd    	mov	x29, x29
106ad50bc: 94454823    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad50c0: aa0003f7    	mov	x23, x0
106ad50c4: 900c9b28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106ad50c8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
106ad50cc: b00befc8    	adrp	x8, 0x11e8ce000 <dyld_stub_binder+0x11e8ce000>
106ad50d0: 91182108    	add	x8, x8, #0x608
106ad50d4: a90003e8    	stp	x8, x0, [sp]
106ad50d8: d00a3a03    	adrp	x3, 0x11b217000 <dyld_stub_binder+0x11b217000>
106ad50dc: 912ff863    	add	x3, x3, #0xbfe
106ad50e0: f00a7ae5    	adrp	x5, 0x11ba34000 <dyld_stub_binder+0x11ba34000>
106ad50e4: 9100d8a5    	add	x5, x5, #0x36
106ad50e8: f00a7ae7    	adrp	x7, 0x11ba34000 <dyld_stub_binder+0x11ba34000>
106ad50ec: 910164e7    	add	x7, x7, #0x59
106ad50f0: aa1603e0    	mov	x0, x22
106ad50f4: 52800042    	mov	w2, #0x2                ; =2
106ad50f8: 52800004    	mov	w4, #0x0                ; =0
106ad50fc: 52800b86    	mov	w6, #0x5c               ; =92
106ad5100: 9445480f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5104: aa1703e0    	mov	x0, x23
106ad5108: 94454813    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad510c: aa1403e0    	mov	x0, x20
106ad5110: aa1503e1    	mov	x1, x21
106ad5114: 9445480a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5118: aa1d03fd    	mov	x29, x29
106ad511c: 9445480b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad5120: aa0003f6    	mov	x22, x0
106ad5124: 900cb528    	adrp	x8, 0x120179000 <dyld_stub_binder+0x120179000>
106ad5128: f9455100    	ldr	x0, [x8, #0xaa0]
106ad512c: 900ca4e8    	adrp	x8, 0x11ff71000 <dyld_stub_binder+0x11ff71000>
106ad5130: f945a101    	ldr	x1, [x8, #0xb40] ; centerSmall:
106ad5134: aa1303e2    	mov	x2, x19
106ad5138: 94454801    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad513c: aa1d03fd    	mov	x29, x29
106ad5140: 94454802    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad5144: aa0003f7    	mov	x23, x0
106ad5148: b00c9b88    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
106ad514c: f9471d01    	ldr	x1, [x8, #0xe38] ; updateViewModel:
106ad5150: aa1603e0    	mov	x0, x22
106ad5154: aa1703e2    	mov	x2, x23
106ad5158: 944547f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad515c: aa1703e0    	mov	x0, x23
106ad5160: 944547fd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad5164: aa1603e0    	mov	x0, x22
106ad5168: 944547fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad516c: f00cb168    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106ad5170: f943cd01    	ldr	x1, [x8, #0x798] ; mediaType
106ad5174: aa1303e0    	mov	x0, x19
106ad5178: 944547f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad517c: aa0003f7    	mov	x23, x0
106ad5180: d00cb4e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106ad5184: f945e900    	ldr	x0, [x8, #0xbd0]
106ad5188: f00cb148    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106ad518c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106ad5190: 944547eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5194: aa1d03fd    	mov	x29, x29
106ad5198: 944547ec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad519c: aa0003f6    	mov	x22, x0
106ad51a0: d00cb4e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106ad51a4: f9462900    	ldr	x0, [x8, #0xc50]
106ad51a8: d00cb148    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106ad51ac: f947ad01    	ldr	x1, [x8, #0xf58] ; class
106ad51b0: 944547e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad51b4: aa0003e2    	mov	x2, x0
106ad51b8: 900c9b28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106ad51bc: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106ad51c0: aa1603e0    	mov	x0, x22
106ad51c4: 944547de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad51c8: aa1d03fd    	mov	x29, x29
106ad51cc: 944547df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad51d0: aa0003f8    	mov	x24, x0
106ad51d4: 900c9b28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106ad51d8: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
106ad51dc: f00bd368    	adrp	x8, 0x11e544000 <dyld_stub_binder+0x11e544000>
106ad51e0: 9113a108    	add	x8, x8, #0x4e8
106ad51e4: 900bcf09    	adrp	x9, 0x11e4b5000 <dyld_stub_binder+0x11e4b5000>
106ad51e8: 91262129    	add	x9, x9, #0x988
106ad51ec: f10006ff    	cmp	x23, #0x1
106ad51f0: 9a880122    	csel	x2, x9, x8, eq
106ad51f4: 944547d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad51f8: aa1d03fd    	mov	x29, x29
106ad51fc: 944547d3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad5200: aa0003f7    	mov	x23, x0
106ad5204: aa1403e0    	mov	x0, x20
106ad5208: aa1503e1    	mov	x1, x21
106ad520c: 944547cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5210: aa1d03fd    	mov	x29, x29
106ad5214: 944547cd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad5218: aa0003f5    	mov	x21, x0
106ad521c: b00cb188    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106ad5220: f946bd01    	ldr	x1, [x8, #0xd78] ; setAccessibilityLabel:
106ad5224: aa1703e2    	mov	x2, x23
106ad5228: 944547c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad522c: aa1503e0    	mov	x0, x21
106ad5230: 944547c9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad5234: aa1703e0    	mov	x0, x23
106ad5238: 944547c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad523c: aa1803e0    	mov	x0, x24
106ad5240: 944547c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad5244: aa1603e0    	mov	x0, x22
106ad5248: 944547c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad524c: f00c9fe8    	adrp	x8, 0x11fed4000 <dyld_stub_binder+0x11fed4000>
106ad5250: f9479d01    	ldr	x1, [x8, #0xf38] ; updateAssetInfo
106ad5254: aa1403e0    	mov	x0, x20
106ad5258: 944547b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad525c: b00ca8e8    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
106ad5260: f9450501    	ldr	x1, [x8, #0xa08] ; updatePrivacyIcon
106ad5264: aa1403e0    	mov	x0, x20
106ad5268: 944547b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad526c: aa1303e0    	mov	x0, x19
106ad5270: a9447bfd    	ldp	x29, x30, [sp, #0x40]
106ad5274: a9434ff4    	ldp	x20, x19, [sp, #0x30]
106ad5278: a94257f6    	ldp	x22, x21, [sp, #0x20]
106ad527c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
106ad5280: 910143ff    	add	sp, sp, #0x50
106ad5284: 144547b4    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
