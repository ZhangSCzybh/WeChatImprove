
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010381ac: d10103ff    	sub	sp, sp, #0x40
1010381b0: a90157f6    	stp	x22, x21, [sp, #0x10]
1010381b4: a9024ff4    	stp	x20, x19, [sp, #0x20]
1010381b8: a9037bfd    	stp	x29, x30, [sp, #0x30]
1010381bc: 9100c3fd    	add	x29, sp, #0x30
1010381c0: aa0003f3    	mov	x19, x0
1010381c4: f00f3848    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
1010381c8: 52800029    	mov	w9, #0x1                ; =1
1010381cc: 39278109    	strb	w9, [x8, #0x9e0]
1010381d0: b00ee908    	adrp	x8, 0x11ed59000 <dyld_stub_binder+0x11ed59000>
1010381d4: f947e108    	ldr	x8, [x8, #0xfc0]
1010381d8: a90023e0    	stp	x0, x8, [sp]
1010381dc: f00ecd08    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1010381e0: f9416901    	ldr	x1, [x8, #0x2d0]
1010381e4: 910003e0    	mov	x0, sp
1010381e8: 95afbea0    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
1010381ec: b00eea88    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
1010381f0: b988cd08    	ldrsw	x8, [x8, #0x8cc]
1010381f4: f8686a60    	ldr	x0, [x19, x8]
1010381f8: d00ee388    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1010381fc: f9424914    	ldr	x20, [x8, #0x490]
101038200: aa1403e1    	mov	x1, x20
101038204: 95afbe98    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101038208: b00eea88    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
10103820c: b988d108    	ldrsw	x8, [x8, #0x8d0]
101038210: f8686a60    	ldr	x0, [x19, x8]
101038214: aa1403e1    	mov	x1, x20
101038218: 95afbe93    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103821c: d00ecca8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
101038220: f941c101    	ldr	x1, [x8, #0x380]
101038224: aa1303e0    	mov	x0, x19
101038228: 95afbe8f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103822c: aa1d03fd    	mov	x29, x29
101038230: 95afbe94    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101038234: aa0003f4    	mov	x20, x0
101038238: d00ecd08    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
10103823c: f946c101    	ldr	x1, [x8, #0xd80]
101038240: 95afbe89    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101038244: aa0003f5    	mov	x21, x0
101038248: aa1403e0    	mov	x0, x20
10103824c: 95afbe89    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101038250: 37000135    	tbnz	w21, #0x0, 0x101038274 <__text+0x1030274>
101038254: b00ecc88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101038258: f9455501    	ldr	x1, [x8, #0xaa8]
10103825c: aa1303e0    	mov	x0, x19
101038260: 95afbe81    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101038264: b00ecf08    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
101038268: f946d101    	ldr	x1, [x8, #0xda0]
10103826c: aa1303e0    	mov	x0, x19
101038270: 95afbe7d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101038274: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101038278: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10103827c: a94157f6    	ldp	x22, x21, [sp, #0x10]
101038280: 910103ff    	add	sp, sp, #0x40
101038284: d65f03c0    	ret
