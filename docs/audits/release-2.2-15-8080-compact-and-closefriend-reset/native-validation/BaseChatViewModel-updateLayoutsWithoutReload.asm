
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002ac2e8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1002ac2ec: a9014ff4    	stp	x20, x19, [sp, #0x10]
1002ac2f0: a9027bfd    	stp	x29, x30, [sp, #0x20]
1002ac2f4: 910083fd    	add	x29, sp, #0x20
1002ac2f8: aa0003f4    	mov	x20, x0
1002ac2fc: 91008000    	add	x0, x0, #0x20
1002ac300: 95e5ee57    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1002ac304: aa0003f3    	mov	x19, x0
1002ac308: b40000c0    	cbz	x0, 0x1002ac320 <__text+0x2a4320>
1002ac30c: d00f3968    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
1002ac310: f945b101    	ldr	x1, [x8, #0xb60]
1002ac314: aa1303e0    	mov	x0, x19
1002ac318: 95e5ee53    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ac31c: 370004c0    	tbnz	w0, #0x0, 0x1002ac3b4 <__text+0x2a43b4>
1002ac320: b00f3928    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1002ac324: f9436d15    	ldr	x21, [x8, #0x6d8]
1002ac328: aa1403e0    	mov	x0, x20
1002ac32c: aa1503e1    	mov	x1, x21
1002ac330: 95e5ee4d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ac334: aa1303e0    	mov	x0, x19
1002ac338: aa1503e1    	mov	x1, x21
1002ac33c: 95e5ee4a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ac340: b00f3928    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1002ac344: f9436901    	ldr	x1, [x8, #0x6d0]
1002ac348: aa1403e0    	mov	x0, x20
1002ac34c: 95e5ee46    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ac350: d00f4fc8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002ac354: f9469d01    	ldr	x1, [x8, #0xd38]
1002ac358: aa1403e0    	mov	x0, x20
1002ac35c: 95e5ee42    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ac360: aa1d03fd    	mov	x29, x29
1002ac364: 95e5ee47    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002ac368: aa0003f4    	mov	x20, x0
1002ac36c: 900f3908    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1002ac370: f940b501    	ldr	x1, [x8, #0x168]
1002ac374: 95e5ee3c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ac378: aa1d03fd    	mov	x29, x29
1002ac37c: 95e5ee41    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002ac380: aa0003f5    	mov	x21, x0
1002ac384: aa1403e0    	mov	x0, x20
1002ac388: 95e5ee3a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002ac38c: d00f3968    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
1002ac390: f945bd01    	ldr	x1, [x8, #0xb78]
1002ac394: aa1503e0    	mov	x0, x21
1002ac398: 95e5ee33    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ac39c: d00f3968    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
1002ac3a0: f945c101    	ldr	x1, [x8, #0xb80]
1002ac3a4: aa1503e0    	mov	x0, x21
1002ac3a8: 95e5ee2f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ac3ac: aa1503e0    	mov	x0, x21
1002ac3b0: 95e5ee30    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002ac3b4: aa1303e0    	mov	x0, x19
1002ac3b8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1002ac3bc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1002ac3c0: a8c357f6    	ldp	x22, x21, [sp], #0x30
1002ac3c4: 15e5ee2b    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
