
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ecd008: d10143ff    	sub	sp, sp, #0x50
101ecd00c: a9015ff8    	stp	x24, x23, [sp, #0x10]
101ecd010: a90257f6    	stp	x22, x21, [sp, #0x20]
101ecd014: a9034ff4    	stp	x20, x19, [sp, #0x30]
101ecd018: a9047bfd    	stp	x29, x30, [sp, #0x40]
101ecd01c: 910103fd    	add	x29, sp, #0x40
101ecd020: aa0003f3    	mov	x19, x0
101ecd024: f00f6b28    	adrp	x8, 0x120c34000 <dyld_stub_binder+0x120c34000>
101ecd028: 52800029    	mov	w9, #0x1                ; =1
101ecd02c: 390ea909    	strb	w9, [x8, #0x3aa]
101ecd030: b00efbe8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
101ecd034: f940c901    	ldr	x1, [x8, #0x190] ; isInPageSheetMode
101ecd038: 95756841    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd03c: 37000c80    	tbnz	w0, #0x0, 0x101ecd1cc <_Flutter_Image_provideRelativePathByUrl+0x2da07c>
101ecd040: b00effe8    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
101ecd044: f944c916    	ldr	x22, [x8, #0x990] ; m_rightBarButtonTitle
101ecd048: aa1303e0    	mov	x0, x19
101ecd04c: aa1603e1    	mov	x1, x22
101ecd050: 9575683b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd054: aa1d03fd    	mov	x29, x29
101ecd058: 9575683c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecd05c: aa0003f4    	mov	x20, x0
101ecd060: d00f11a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101ecd064: f946e901    	ldr	x1, [x8, #0xdd0] ; length
101ecd068: 95756835    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd06c: aa0003f5    	mov	x21, x0
101ecd070: aa1403e0    	mov	x0, x20
101ecd074: 95756838    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecd078: b4000ab5    	cbz	x21, 0x101ecd1cc <_Flutter_Image_provideRelativePathByUrl+0x2da07c>
101ecd07c: aa1303e0    	mov	x0, x19
101ecd080: aa1603e1    	mov	x1, x22
101ecd084: 9575682e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd088: aa1d03fd    	mov	x29, x29
101ecd08c: 9575682f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecd090: aa0003f4    	mov	x20, x0
101ecd094: d00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecd098: b987b518    	ldrsw	x24, [x8, #0x7b4]
101ecd09c: f8786a60    	ldr	x0, [x19, x24]
101ecd0a0: f00f1188    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101ecd0a4: f9435115    	ldr	x21, [x8, #0x6a0] ; count
101ecd0a8: aa1503e1    	mov	x1, x21
101ecd0ac: 95756824    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd0b0: b4000360    	cbz	x0, 0x101ecd11c <_Flutter_Image_provideRelativePathByUrl+0x2d9fcc>
101ecd0b4: d00f1528    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101ecd0b8: f9454517    	ldr	x23, [x8, #0xa88]
101ecd0bc: aa1303e0    	mov	x0, x19
101ecd0c0: aa1603e1    	mov	x1, x22
101ecd0c4: 9575681e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd0c8: aa1d03fd    	mov	x29, x29
101ecd0cc: 9575681f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecd0d0: aa0003f6    	mov	x22, x0
101ecd0d4: f8786a60    	ldr	x0, [x19, x24]
101ecd0d8: aa1503e1    	mov	x1, x21
101ecd0dc: 95756818    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd0e0: b00f11e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
101ecd0e4: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
101ecd0e8: a90003f6    	stp	x22, x0, [sp]
101ecd0ec: b00e30a2    	adrp	x2, 0x11e4e2000 <dyld_stub_binder+0x11e4e2000>
101ecd0f0: 91222042    	add	x2, x2, #0x888
101ecd0f4: aa1703e0    	mov	x0, x23
101ecd0f8: 95756811    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd0fc: aa1d03fd    	mov	x29, x29
101ecd100: 95756812    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecd104: aa0003f7    	mov	x23, x0
101ecd108: aa1403e0    	mov	x0, x20
101ecd10c: 95756812    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecd110: aa1603e0    	mov	x0, x22
101ecd114: 95756810    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecd118: aa1703f4    	mov	x20, x23
101ecd11c: d00f1528    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101ecd120: f947d900    	ldr	x0, [x8, #0xfb0]
101ecd124: 900efce8    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
101ecd128: f9413904    	ldr	x4, [x8, #0x270] ; onDone
101ecd12c: d00efb68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101ecd130: f945e101    	ldr	x1, [x8, #0xbc0] ; getBarButtonWithTitle:target:action:style:
101ecd134: aa1403e2    	mov	x2, x20
101ecd138: aa1303e3    	mov	x3, x19
101ecd13c: 528000a5    	mov	w5, #0x5                ; =5
101ecd140: 957567ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd144: aa1d03fd    	mov	x29, x29
101ecd148: 95756800    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecd14c: aa0003f6    	mov	x22, x0
101ecd150: f8786a60    	ldr	x0, [x19, x24]
101ecd154: aa1503e1    	mov	x1, x21
101ecd158: 957567f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd15c: f100001f    	cmp	x0, #0x0
101ecd160: 1a9f07e2    	cset	w2, ne
101ecd164: d00f11c8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
101ecd168: f946bd01    	ldr	x1, [x8, #0xd78] ; setEnabled:
101ecd16c: aa1603e0    	mov	x0, x22
101ecd170: 957567f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd174: f00f11a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101ecd178: f945e501    	ldr	x1, [x8, #0xbc8] ; navigationItem
101ecd17c: aa1303e0    	mov	x0, x19
101ecd180: 957567ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd184: aa1d03fd    	mov	x29, x29
101ecd188: 957567f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecd18c: aa0003f3    	mov	x19, x0
101ecd190: d00efb68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101ecd194: f945f101    	ldr	x1, [x8, #0xbe0] ; setRightBarButtonItem:
101ecd198: aa1603e2    	mov	x2, x22
101ecd19c: 957567e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd1a0: aa1303e0    	mov	x0, x19
101ecd1a4: 957567ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecd1a8: aa1603e0    	mov	x0, x22
101ecd1ac: 957567ea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecd1b0: aa1403e0    	mov	x0, x20
101ecd1b4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101ecd1b8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101ecd1bc: a94257f6    	ldp	x22, x21, [sp, #0x20]
101ecd1c0: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101ecd1c4: 910143ff    	add	sp, sp, #0x50
101ecd1c8: 157567e3    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecd1cc: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101ecd1d0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101ecd1d4: a94257f6    	ldp	x22, x21, [sp, #0x20]
101ecd1d8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101ecd1dc: 910143ff    	add	sp, sp, #0x50
101ecd1e0: d65f03c0    	ret
