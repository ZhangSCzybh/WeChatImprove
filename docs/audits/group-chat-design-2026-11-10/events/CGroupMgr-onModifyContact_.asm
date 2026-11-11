
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
10204b370: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
10204b374: a90167fa    	stp	x26, x25, [sp, #0x10]
10204b378: a9025ff8    	stp	x24, x23, [sp, #0x20]
10204b37c: a90357f6    	stp	x22, x21, [sp, #0x30]
10204b380: a9044ff4    	stp	x20, x19, [sp, #0x40]
10204b384: a9057bfd    	stp	x29, x30, [sp, #0x50]
10204b388: 910143fd    	add	x29, sp, #0x50
10204b38c: aa0203f3    	mov	x19, x2
10204b390: aa0003f4    	mov	x20, x0
10204b394: 900eb7e8    	adrp	x8, 0x11f747000 <dyld_stub_binder+0x11f747000>
10204b398: 52800029    	mov	w9, #0x1                ; =1
10204b39c: 39170909    	strb	w9, [x8, #0x5c2]
10204b3a0: aa0203e0    	mov	x0, x2
10204b3a4: 956f7234    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10204b3a8: 900e4c08    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10204b3ac: f947d501    	ldr	x1, [x8, #0xfa8]
10204b3b0: aa1303e0    	mov	x0, x19
10204b3b4: 956f722c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b3b8: 34000a40    	cbz	w0, 0x10204b500 <_Flutter_Image_provideRelativePathByUrl+0x2d398c>
10204b3bc: f00e663b    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10204b3c0: f943c360    	ldr	x0, [x27, #0x780]
10204b3c4: d00e4be8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10204b3c8: f9440115    	ldr	x21, [x8, #0x800]
10204b3cc: aa1503e1    	mov	x1, x21
10204b3d0: 956f7225    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b3d4: aa1d03fd    	mov	x29, x29
10204b3d8: 956f722a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10204b3dc: aa0003f8    	mov	x24, x0
10204b3e0: f00e663c    	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10204b3e4: f945bf80    	ldr	x0, [x28, #0xb78]
10204b3e8: f00e62c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10204b3ec: f9428516    	ldr	x22, [x8, #0x508]
10204b3f0: aa1603e1    	mov	x1, x22
10204b3f4: 956f721c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b3f8: aa0003e2    	mov	x2, x0
10204b3fc: d00e4be8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10204b400: f9452117    	ldr	x23, [x8, #0xa40]
10204b404: aa1803e0    	mov	x0, x24
10204b408: aa1703e1    	mov	x1, x23
10204b40c: 956f7216    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b410: aa1d03fd    	mov	x29, x29
10204b414: 956f721b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10204b418: aa0003f9    	mov	x25, x0
10204b41c: f00e50a8    	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b420: f941d101    	ldr	x1, [x8, #0x3a0]
10204b424: aa1303e2    	mov	x2, x19
10204b428: 956f720f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b42c: aa0003fa    	mov	x26, x0
10204b430: aa1903e0    	mov	x0, x25
10204b434: 956f720f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204b438: aa1803e0    	mov	x0, x24
10204b43c: 956f720d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204b440: 3400047a    	cbz	w26, 0x10204b4cc <_Flutter_Image_provideRelativePathByUrl+0x2d3958>
10204b444: f943c360    	ldr	x0, [x27, #0x780]
10204b448: aa1503e1    	mov	x1, x21
10204b44c: 956f7206    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b450: aa1d03fd    	mov	x29, x29
10204b454: 956f720b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10204b458: aa0003f5    	mov	x21, x0
10204b45c: f945bf80    	ldr	x0, [x28, #0xb78]
10204b460: aa1603e1    	mov	x1, x22
10204b464: 956f7200    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b468: aa0003e2    	mov	x2, x0
10204b46c: aa1503e0    	mov	x0, x21
10204b470: aa1703e1    	mov	x1, x23
10204b474: 956f71fc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b478: aa1d03fd    	mov	x29, x29
10204b47c: 956f7201    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10204b480: aa0003f6    	mov	x22, x0
10204b484: 900e4c08    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10204b488: f9431101    	ldr	x1, [x8, #0x620]
10204b48c: aa1303e0    	mov	x0, x19
10204b490: 956f71f5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b494: aa1d03fd    	mov	x29, x29
10204b498: 956f71fa    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10204b49c: aa0003f7    	mov	x23, x0
10204b4a0: f00e50a8    	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b4a4: f9450901    	ldr	x1, [x8, #0xa10]
10204b4a8: aa1603e0    	mov	x0, x22
10204b4ac: aa1703e2    	mov	x2, x23
10204b4b0: 956f71ed    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b4b4: aa1703e0    	mov	x0, x23
10204b4b8: 956f71ee    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204b4bc: aa1603e0    	mov	x0, x22
10204b4c0: 956f71ec    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204b4c4: aa1503e0    	mov	x0, x21
10204b4c8: 956f71ea    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204b4cc: f00e50a8    	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b4d0: f9446901    	ldr	x1, [x8, #0x8d0]
10204b4d4: aa1403e0    	mov	x0, x20
10204b4d8: 956f71e3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b4dc: aa1d03fd    	mov	x29, x29
10204b4e0: 956f71e8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10204b4e4: aa0003f4    	mov	x20, x0
10204b4e8: f00e50a8    	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b4ec: f9450d01    	ldr	x1, [x8, #0xa18]
10204b4f0: aa1303e2    	mov	x2, x19
10204b4f4: 956f71dc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b4f8: aa1403e0    	mov	x0, x20
10204b4fc: 956f71dd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204b500: aa1303e0    	mov	x0, x19
10204b504: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10204b508: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10204b50c: a94357f6    	ldp	x22, x21, [sp, #0x30]
10204b510: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10204b514: a94167fa    	ldp	x26, x25, [sp, #0x10]
10204b518: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10204b51c: 156f71d5    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
