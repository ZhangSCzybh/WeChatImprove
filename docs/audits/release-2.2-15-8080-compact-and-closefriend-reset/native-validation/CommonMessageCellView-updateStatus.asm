
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101038288: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10103828c: a90157f6    	stp	x22, x21, [sp, #0x10]
101038290: a9024ff4    	stp	x20, x19, [sp, #0x20]
101038294: a9037bfd    	stp	x29, x30, [sp, #0x30]
101038298: 9100c3fd    	add	x29, sp, #0x30
10103829c: aa0003f3    	mov	x19, x0
1010382a0: f00f3848    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
1010382a4: 52800029    	mov	w9, #0x1                ; =1
1010382a8: 39278509    	strb	w9, [x8, #0x9e1]
1010382ac: d00ecca8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1010382b0: f941c114    	ldr	x20, [x8, #0x380]
1010382b4: aa1403e1    	mov	x1, x20
1010382b8: 95afbe6b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010382bc: aa1d03fd    	mov	x29, x29
1010382c0: 95afbe70    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010382c4: aa0003f5    	mov	x21, x0
1010382c8: f00ecca8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
1010382cc: f941b101    	ldr	x1, [x8, #0x360]
1010382d0: 95afbe65    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010382d4: 36000460    	tbz	w0, #0x0, 0x101038360 <__text+0x1030360>
1010382d8: aa1303e0    	mov	x0, x19
1010382dc: aa1403e1    	mov	x1, x20
1010382e0: 95afbe61    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010382e4: aa1d03fd    	mov	x29, x29
1010382e8: 95afbe66    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010382ec: aa0003f6    	mov	x22, x0
1010382f0: b00ecf08    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
1010382f4: f946d501    	ldr	x1, [x8, #0xda8]
1010382f8: 95afbe5b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010382fc: 360002e0    	tbz	w0, #0x0, 0x101038358 <__text+0x1030358>
101038300: aa1303e0    	mov	x0, x19
101038304: aa1403e1    	mov	x1, x20
101038308: 95afbe57    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103830c: aa1d03fd    	mov	x29, x29
101038310: 95afbe5c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101038314: aa0003f7    	mov	x23, x0
101038318: b00eccc8    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
10103831c: f9458101    	ldr	x1, [x8, #0xb00]
101038320: 95afbe51    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101038324: aa0003f8    	mov	x24, x0
101038328: aa1703e0    	mov	x0, x23
10103832c: 95afbe51    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101038330: aa1603e0    	mov	x0, x22
101038334: 95afbe4f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101038338: aa1503e0    	mov	x0, x21
10103833c: 95afbe4d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101038340: 360001d8    	tbz	w24, #0x0, 0x101038378 <__text+0x1030378>
101038344: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101038348: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10103834c: a94157f6    	ldp	x22, x21, [sp, #0x10]
101038350: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101038354: d65f03c0    	ret
101038358: aa1603e0    	mov	x0, x22
10103835c: 95afbe45    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101038360: aa1503e0    	mov	x0, x21
101038364: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101038368: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10103836c: a94157f6    	ldp	x22, x21, [sp, #0x10]
101038370: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101038374: 15afbe3f    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101038378: aa1303e0    	mov	x0, x19
10103837c: aa1403e1    	mov	x1, x20
101038380: 95afbe39    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101038384: aa1d03fd    	mov	x29, x29
101038388: 95afbe3e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103838c: aa0003f5    	mov	x21, x0
101038390: b00ecf08    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
101038394: f946d901    	ldr	x1, [x8, #0xdb0]
101038398: 95afbe33    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103839c: aa0003f6    	mov	x22, x0
1010383a0: aa1503e0    	mov	x0, x21
1010383a4: 95afbe33    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010383a8: 34000096    	cbz	w22, 0x1010383b8 <__text+0x10303b8>
1010383ac: b00ecf08    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
1010383b0: f946dd01    	ldr	x1, [x8, #0xdb8]
1010383b4: 14000010    	b	0x1010383f4 <__text+0x10303f4>
1010383b8: aa1303e0    	mov	x0, x19
1010383bc: aa1403e1    	mov	x1, x20
1010383c0: 95afbe29    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010383c4: aa1d03fd    	mov	x29, x29
1010383c8: 95afbe2e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010383cc: aa0003f4    	mov	x20, x0
1010383d0: 900ecd28    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
1010383d4: f9440501    	ldr	x1, [x8, #0x808]
1010383d8: 95afbe23    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010383dc: aa0003f5    	mov	x21, x0
1010383e0: aa1403e0    	mov	x0, x20
1010383e4: 95afbe23    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010383e8: 34fffaf5    	cbz	w21, 0x101038344 <__text+0x1030344>
1010383ec: d00eccc8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
1010383f0: f945a101    	ldr	x1, [x8, #0xb40]
1010383f4: aa1303e0    	mov	x0, x19
1010383f8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1010383fc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101038400: a94157f6    	ldp	x22, x21, [sp, #0x10]
101038404: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101038408: 15afbe17    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
