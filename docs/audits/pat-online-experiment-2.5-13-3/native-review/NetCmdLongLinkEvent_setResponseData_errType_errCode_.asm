
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105322450: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105322454: a9014ff4    	stp	x20, x19, [sp, #0x10]
105322458: a9027bfd    	stp	x29, x30, [sp, #0x20]
10532245c: 910083fd    	add	x29, sp, #0x20
105322460: aa0403f4    	mov	x20, x4
105322464: aa0303f6    	mov	x22, x3
105322468: aa0203f3    	mov	x19, x2
10532246c: aa0003f5    	mov	x21, x0
105322470: aa0203e0    	mov	x0, x2
105322474: 94a41600    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105322478: b40000d3    	cbz	x19, 0x105322490 <_Flutter_MMFoundation_BindContext+0x15a915c>
10532247c: b00cb8c8    	adrp	x8, 0x11ea3b000 <dyld_stub_binder+0x11ea3b000>
105322480: f9436101    	ldr	x1, [x8, #0x6c0] ; selector setResponseData:
105322484: aa1503e0    	mov	x0, x21
105322488: aa1303e2    	mov	x2, x19
10532248c: 94a415f6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105322490: 2a160288    	orr	w8, w20, w22
105322494: 34000168    	cbz	w8, 0x1053224c0 <_Flutter_MMFoundation_BindContext+0x15a918c>
105322498: 900cc0a8    	adrp	x8, 0x11eb36000 <dyld_stub_binder+0x11eb36000>
10532249c: f9406501    	ldr	x1, [x8, #0xc8] ; selector setResponseErrType:
1053224a0: aa1503e0    	mov	x0, x21
1053224a4: aa1603e2    	mov	x2, x22
1053224a8: 94a415ef    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1053224ac: 900cc0a8    	adrp	x8, 0x11eb36000 <dyld_stub_binder+0x11eb36000>
1053224b0: f9406101    	ldr	x1, [x8, #0xc0] ; selector setResponseErrCode:
1053224b4: aa1503e0    	mov	x0, x21
1053224b8: aa1403e2    	mov	x2, x20
1053224bc: 94a415ea    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1053224c0: aa1303e0    	mov	x0, x19
1053224c4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1053224c8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1053224cc: a8c357f6    	ldp	x22, x21, [sp], #0x30
1053224d0: 14a415e8    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
