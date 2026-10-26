
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1028fe30c: d10143ff    	sub	sp, sp, #0x50
1028fe310: a9015ff8    	stp	x24, x23, [sp, #0x10]
1028fe314: a90257f6    	stp	x22, x21, [sp, #0x20]
1028fe318: a9034ff4    	stp	x20, x19, [sp, #0x30]
1028fe31c: a9047bfd    	stp	x29, x30, [sp, #0x40]
1028fe320: 910103fd    	add	x29, sp, #0x40
1028fe324: 900f19c8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1028fe328: 52800029    	mov	w9, #0x1                ; =1
1028fe32c: 3928d109    	strb	w9, [x8, #0xa34]
1028fe330: b00ec3b6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe334: f9467ac0    	ldr	x0, [x22, #0xcf0]
1028fe338: f00ea9e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1028fe33c: f943f514    	ldr	x20, [x8, #0x7e8] ; GetTmpPath
1028fe340: aa1403e1    	mov	x1, x20
1028fe344: 954ca37e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe348: aa1d03fd    	mov	x29, x29
1028fe34c: 954ca37f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe350: aa0003f5    	mov	x21, x0
1028fe354: 900ec068    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1028fe358: f9465101    	ldr	x1, [x8, #0xca0] ; stringByAppendingPathComponent:
1028fe35c: d00deb22    	adrp	x2, 0x11e664000 <dyld_stub_binder+0x11e664000>
1028fe360: 9131a042    	add	x2, x2, #0xc68
1028fe364: 954ca376    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe368: aa1d03fd    	mov	x29, x29
1028fe36c: 954ca377    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe370: aa0003f3    	mov	x19, x0
1028fe374: aa1503e0    	mov	x0, x21
1028fe378: 954ca377    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe37c: b00ec3b7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe380: f94636e0    	ldr	x0, [x23, #0xc68]
1028fe384: f00ea9c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1028fe388: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
1028fe38c: aa1303e2    	mov	x2, x19
1028fe390: 954ca36b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe394: aa0003f5    	mov	x21, x0
1028fe398: f9467ac0    	ldr	x0, [x22, #0xcf0]
1028fe39c: aa1403e1    	mov	x1, x20
1028fe3a0: 954ca367    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe3a4: aa1d03fd    	mov	x29, x29
1028fe3a8: 954ca368    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe3ac: aa0003f4    	mov	x20, x0
1028fe3b0: f94636f6    	ldr	x22, [x23, #0xc68]
1028fe3b4: 954ca37d    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
1028fe3b8: 900ec008    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1028fe3bc: f944d901    	ldr	x1, [x8, #0x9b0] ; UTF8String
1028fe3c0: 954ca35f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe3c4: aa0003e2    	mov	x2, x0
1028fe3c8: f00eac48    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1028fe3cc: f945e101    	ldr	x1, [x8, #0xbc0] ; FolderSizeAtPath:
1028fe3d0: aa1603e0    	mov	x0, x22
1028fe3d4: 954ca35a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe3d8: aa0003f6    	mov	x22, x0
1028fe3dc: f94636e0    	ldr	x0, [x23, #0xc68]
1028fe3e0: f00ea9c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1028fe3e4: f946f101    	ldr	x1, [x8, #0xde0] ; RemoveFile:
1028fe3e8: aa1403e2    	mov	x2, x20
1028fe3ec: 954ca354    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe3f0: b00ec3a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe3f4: f9453500    	ldr	x0, [x8, #0xa68]
1028fe3f8: f00ea9c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1028fe3fc: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1028fe400: d00deb28    	adrp	x8, 0x11e664000 <dyld_stub_binder+0x11e664000>
1028fe404: 91322108    	add	x8, x8, #0xc88
1028fe408: a9005be8    	stp	x8, x22, [sp]
1028fe40c: f00c6365    	adrp	x5, 0x11b56d000 <dyld_stub_binder+0x11b56d000>
1028fe410: 911a9ca5    	add	x5, x5, #0x6a7
1028fe414: f00c6367    	adrp	x7, 0x11b56d000 <dyld_stub_binder+0x11b56d000>
1028fe418: 91238ce7    	add	x7, x7, #0x8e3
1028fe41c: 52800042    	mov	w2, #0x2                ; =2
1028fe420: d2800003    	mov	x3, #0x0                ; =0
1028fe424: 52800004    	mov	w4, #0x0                ; =0
1028fe428: 52806686    	mov	w6, #0x334              ; =820
1028fe42c: 954ca344    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe430: 340000d5    	cbz	w21, 0x1028fe448 <_Flutter_Image_provideRelativePathByUrl+0xd0b2f8>
1028fe434: f94636e0    	ldr	x0, [x23, #0xc68]
1028fe438: f00eaa48    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
1028fe43c: f9470501    	ldr	x1, [x8, #0xe08] ; CreatePath:
1028fe440: aa1303e2    	mov	x2, x19
1028fe444: 954ca33e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe448: aa1403e0    	mov	x0, x20
1028fe44c: 954ca342    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe450: aa1303e0    	mov	x0, x19
1028fe454: 954ca340    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe458: aa1603e0    	mov	x0, x22
1028fe45c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1028fe460: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1028fe464: a94257f6    	ldp	x22, x21, [sp, #0x20]
1028fe468: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1028fe46c: 910143ff    	add	sp, sp, #0x50
1028fe470: d65f03c0    	ret
