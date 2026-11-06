
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105f0f284: d10143ff    	sub	sp, sp, #0x50
105f0f288: a90257f6    	stp	x22, x21, [sp, #0x20]
105f0f28c: a9034ff4    	stp	x20, x19, [sp, #0x30]
105f0f290: a9047bfd    	stp	x29, x30, [sp, #0x40]
105f0f294: 910103fd    	add	x29, sp, #0x40
105f0f298: aa0003f3    	mov	x19, x0
105f0f29c: d00cc228    	adrp	x8, 0x11f755000 <dyld_stub_binder+0x11f755000>
105f0f2a0: 52800035    	mov	w21, #0x1               ; =1
105f0f2a4: 392fcd15    	strb	w21, [x8, #0xbf3]
105f0f2a8: d00c6268    	adrp	x8, 0x11eb5d000 <dyld_stub_binder+0x11eb5d000>
105f0f2ac: f9442901    	ldr	x1, [x8, #0x850]
105f0f2b0: 9474626d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105f0f2b4: 34000700    	cbz	w0, 0x105f0f394 <_Flutter_MMFoundation_BindContext+0x2196060>
105f0f2b8: 900c5668    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
105f0f2bc: f9414901    	ldr	x1, [x8, #0x290]
105f0f2c0: aa1303e0    	mov	x0, x19
105f0f2c4: 94746268    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105f0f2c8: aa1d03fd    	mov	x29, x29
105f0f2cc: 9474626d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105f0f2d0: aa0003f6    	mov	x22, x0
105f0f2d4: f00c6ca8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105f0f2d8: f9442914    	ldr	x20, [x8, #0x850]
105f0f2dc: aa1403e1    	mov	x1, x20
105f0f2e0: 94746261    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105f0f2e4: aa0003f5    	mov	x21, x0
105f0f2e8: aa1603e0    	mov	x0, x22
105f0f2ec: 94746261    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105f0f2f0: b5000535    	cbnz	x21, 0x105f0f394 <_Flutter_MMFoundation_BindContext+0x2196060>
105f0f2f4: f00c7008    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105f0f2f8: f9430d15    	ldr	x21, [x8, #0x618]
105f0f2fc: d00c5808    	adrp	x8, 0x11ea11000 <dyld_stub_binder+0x11ea11000>
105f0f300: f9462501    	ldr	x1, [x8, #0xc48]
105f0f304: aa1303e0    	mov	x0, x19
105f0f308: 94746257    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105f0f30c: 94745e2e    	bl	0x107c26bc4 <_Flutter_MMFoundation_BindContext+0x3ead890>
105f0f310: aa1d03fd    	mov	x29, x29
105f0f314: 9474625b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105f0f318: aa0003f6    	mov	x22, x0
105f0f31c: d00c5a48    	adrp	x8, 0x11ea59000 <dyld_stub_binder+0x11ea59000>
105f0f320: f943d101    	ldr	x1, [x8, #0x7a0]
105f0f324: aa1303e0    	mov	x0, x19
105f0f328: 9474624f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105f0f32c: aa1d03fd    	mov	x29, x29
105f0f330: 94746254    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105f0f334: aa0003f3    	mov	x19, x0
105f0f338: aa1403e1    	mov	x1, x20
105f0f33c: 9474624a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105f0f340: d00c55c8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105f0f344: f9418901    	ldr	x1, [x8, #0x310]
105f0f348: a90083f6    	stp	x22, x0, [sp, #0x8]
105f0f34c: 900ba288    	adrp	x8, 0x11d35f000 <dyld_stub_binder+0x11d35f000>
105f0f350: 91236108    	add	x8, x8, #0x8d8
105f0f354: f90003e8    	str	x8, [sp]
105f0f358: b00a1ee5    	adrp	x5, 0x11a2ec000 <dyld_stub_binder+0x11a2ec000>
105f0f35c: 9107e4a5    	add	x5, x5, #0x1f9
105f0f360: b00a1ee7    	adrp	x7, 0x11a2ec000 <dyld_stub_binder+0x11a2ec000>
105f0f364: 910844e7    	add	x7, x7, #0x211
105f0f368: aa1503e0    	mov	x0, x21
105f0f36c: 52800082    	mov	w2, #0x4                ; =4
105f0f370: d2800003    	mov	x3, #0x0                ; =0
105f0f374: 52800004    	mov	w4, #0x0                ; =0
105f0f378: 52801286    	mov	w6, #0x94               ; =148
105f0f37c: 9474623a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105f0f380: aa1303e0    	mov	x0, x19
105f0f384: 9474623b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105f0f388: aa1603e0    	mov	x0, x22
105f0f38c: 94746239    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105f0f390: d2800015    	mov	x21, #0x0               ; =0
105f0f394: aa1503e0    	mov	x0, x21
105f0f398: a9447bfd    	ldp	x29, x30, [sp, #0x40]
105f0f39c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
105f0f3a0: a94257f6    	ldp	x22, x21, [sp, #0x20]
105f0f3a4: 910143ff    	add	sp, sp, #0x50
105f0f3a8: d65f03c0    	ret
