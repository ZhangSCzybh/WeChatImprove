
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1028fe834: d10143ff    	sub	sp, sp, #0x50
1028fe838: a90257f6    	stp	x22, x21, [sp, #0x20]
1028fe83c: a9034ff4    	stp	x20, x19, [sp, #0x30]
1028fe840: a9047bfd    	stp	x29, x30, [sp, #0x40]
1028fe844: 910103fd    	add	x29, sp, #0x40
1028fe848: 900f19c8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1028fe84c: 52800029    	mov	w9, #0x1                ; =1
1028fe850: 3928d909    	strb	w9, [x8, #0xa36]
1028fe854: b00ec3a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe858: f945e900    	ldr	x0, [x8, #0xbd0]
1028fe85c: d00ec008    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1028fe860: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1028fe864: 954ca236    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe868: aa1d03fd    	mov	x29, x29
1028fe86c: 954ca237    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe870: aa0003f3    	mov	x19, x0
1028fe874: f00ec408    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
1028fe878: f9410900    	ldr	x0, [x8, #0x210]
1028fe87c: b00ec008    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1028fe880: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1028fe884: 954ca22e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe888: aa0003e2    	mov	x2, x0
1028fe88c: f00ea9c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1028fe890: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1028fe894: aa1303e0    	mov	x0, x19
1028fe898: 954ca229    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe89c: aa1d03fd    	mov	x29, x29
1028fe8a0: 954ca22a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe8a4: aa0003f4    	mov	x20, x0
1028fe8a8: b00eaa28    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1028fe8ac: f9427901    	ldr	x1, [x8, #0x4f0] ; isIdle
1028fe8b0: 954ca223    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe8b4: aa0003f5    	mov	x21, x0
1028fe8b8: aa1403e0    	mov	x0, x20
1028fe8bc: 954ca226    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe8c0: aa1303e0    	mov	x0, x19
1028fe8c4: 954ca224    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe8c8: 360008b5    	tbz	w21, #0x0, 0x1028fe9dc <_Flutter_Image_provideRelativePathByUrl+0xd0b88c>
1028fe8cc: b00ec3a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe8d0: f9467900    	ldr	x0, [x8, #0xcf0]
1028fe8d4: b00ea9e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1028fe8d8: f9466901    	ldr	x1, [x8, #0xcd0] ; GetSystemCachePath
1028fe8dc: 954ca218    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe8e0: aa1d03fd    	mov	x29, x29
1028fe8e4: 954ca219    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe8e8: aa0003f4    	mov	x20, x0
1028fe8ec: 900ec068    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1028fe8f0: f9465101    	ldr	x1, [x8, #0xca0] ; stringByAppendingPathComponent:
1028fe8f4: d00deb22    	adrp	x2, 0x11e664000 <dyld_stub_binder+0x11e664000>
1028fe8f8: 91342042    	add	x2, x2, #0xd08
1028fe8fc: 954ca210    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe900: aa1d03fd    	mov	x29, x29
1028fe904: 954ca211    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe908: aa0003f3    	mov	x19, x0
1028fe90c: aa1403e0    	mov	x0, x20
1028fe910: 954ca211    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe914: b00ec3b6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe918: f94636c0    	ldr	x0, [x22, #0xc68]
1028fe91c: f00ea9c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1028fe920: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
1028fe924: aa1303e2    	mov	x2, x19
1028fe928: 954ca205    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe92c: aa0003f5    	mov	x21, x0
1028fe930: f94636d4    	ldr	x20, [x22, #0xc68]
1028fe934: aa1303e0    	mov	x0, x19
1028fe938: 954ca21c    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
1028fe93c: 900ec008    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1028fe940: f944d901    	ldr	x1, [x8, #0x9b0] ; UTF8String
1028fe944: 954ca1fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe948: aa0003e2    	mov	x2, x0
1028fe94c: f00eac48    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
1028fe950: f945e101    	ldr	x1, [x8, #0xbc0] ; FolderSizeAtPath:
1028fe954: aa1403e0    	mov	x0, x20
1028fe958: 954ca1f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe95c: aa0003f4    	mov	x20, x0
1028fe960: f94636c0    	ldr	x0, [x22, #0xc68]
1028fe964: f00ea9c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1028fe968: f946f101    	ldr	x1, [x8, #0xde0] ; RemoveFile:
1028fe96c: aa1303e2    	mov	x2, x19
1028fe970: 954ca1f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe974: 340000d5    	cbz	w21, 0x1028fe98c <_Flutter_Image_provideRelativePathByUrl+0xd0b83c>
1028fe978: f94636c0    	ldr	x0, [x22, #0xc68]
1028fe97c: f00eaa48    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
1028fe980: f9470501    	ldr	x1, [x8, #0xe08] ; CreatePath:
1028fe984: aa1303e2    	mov	x2, x19
1028fe988: 954ca1ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe98c: b00ec3a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe990: f9453500    	ldr	x0, [x8, #0xa68]
1028fe994: f00ea9c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1028fe998: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1028fe99c: a900d7f4    	stp	x20, x21, [sp, #0x8]
1028fe9a0: d00deb28    	adrp	x8, 0x11e664000 <dyld_stub_binder+0x11e664000>
1028fe9a4: 9134a108    	add	x8, x8, #0xd28
1028fe9a8: f90003e8    	str	x8, [sp]
1028fe9ac: f00c6365    	adrp	x5, 0x11b56d000 <dyld_stub_binder+0x11b56d000>
1028fe9b0: 911a9ca5    	add	x5, x5, #0x6a7
1028fe9b4: f00c6367    	adrp	x7, 0x11b56d000 <dyld_stub_binder+0x11b56d000>
1028fe9b8: 9126bce7    	add	x7, x7, #0x9af
1028fe9bc: 52800042    	mov	w2, #0x2                ; =2
1028fe9c0: d2800003    	mov	x3, #0x0                ; =0
1028fe9c4: 52800004    	mov	w4, #0x0                ; =0
1028fe9c8: 52806d46    	mov	w6, #0x36a              ; =874
1028fe9cc: 954ca1dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe9d0: aa1303e0    	mov	x0, x19
1028fe9d4: 954ca1e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe9d8: 14000012    	b	0x1028fea20 <_Flutter_Image_provideRelativePathByUrl+0xd0b8d0>
1028fe9dc: b00ec3a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1028fe9e0: f9453500    	ldr	x0, [x8, #0xa68]
1028fe9e4: f00ea9c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1028fe9e8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1028fe9ec: d00deb28    	adrp	x8, 0x11e664000 <dyld_stub_binder+0x11e664000>
1028fe9f0: 9133a108    	add	x8, x8, #0xce8
1028fe9f4: f90003e8    	str	x8, [sp]
1028fe9f8: f00c6365    	adrp	x5, 0x11b56d000 <dyld_stub_binder+0x11b56d000>
1028fe9fc: 911a9ca5    	add	x5, x5, #0x6a7
1028fea00: f00c6367    	adrp	x7, 0x11b56d000 <dyld_stub_binder+0x11b56d000>
1028fea04: 9126bce7    	add	x7, x7, #0x9af
1028fea08: 52800062    	mov	w2, #0x3                ; =3
1028fea0c: d2800003    	mov	x3, #0x0                ; =0
1028fea10: 52800004    	mov	w4, #0x0                ; =0
1028fea14: 52806ba6    	mov	w6, #0x35d              ; =861
1028fea18: 954ca1c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fea1c: d2800014    	mov	x20, #0x0               ; =0
1028fea20: aa1403e0    	mov	x0, x20
1028fea24: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1028fea28: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1028fea2c: a94257f6    	ldp	x22, x21, [sp, #0x20]
1028fea30: 910143ff    	add	sp, sp, #0x50
1028fea34: d65f03c0    	ret
