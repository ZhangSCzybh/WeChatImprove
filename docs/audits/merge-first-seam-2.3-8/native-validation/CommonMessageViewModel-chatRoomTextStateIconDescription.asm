
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10104c8b0: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10104c8b4: a90157f6    	stp	x22, x21, [sp, #0x10]
10104c8b8: a9024ff4    	stp	x20, x19, [sp, #0x20]
10104c8bc: a9037bfd    	stp	x29, x30, [sp, #0x30]
10104c8c0: 9100c3fd    	add	x29, sp, #0x30
10104c8c4: aa0003f3    	mov	x19, x0
10104c8c8: f00f37a8    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
10104c8cc: 52800029    	mov	w9, #0x1                ; =1
10104c8d0: 3928b509    	strb	w9, [x8, #0xa2d]
10104c8d4: b00ece28    	adrp	x8, 0x11ea11000 <dyld_stub_binder+0x11ea11000>
10104c8d8: f946e501    	ldr	x1, [x8, #0xdc8]
10104c8dc: 95af6ce2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104c8e0: 34000980    	cbz	w0, 0x10104ca10 <__text+0x1044a10>
10104c8e4: 900ecca8    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
10104c8e8: f9440901    	ldr	x1, [x8, #0x810]
10104c8ec: aa1303e0    	mov	x0, x19
10104c8f0: 95af6cdd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104c8f4: 340008e0    	cbz	w0, 0x10104ca10 <__text+0x1044a10>
10104c8f8: d00ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104c8fc: f943c100    	ldr	x0, [x8, #0x780]
10104c900: b00ecbe8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104c904: f9440101    	ldr	x1, [x8, #0x800]
10104c908: 95af6cd7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104c90c: aa1d03fd    	mov	x29, x29
10104c910: 95af6cdc    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104c914: aa0003f5    	mov	x21, x0
10104c918: f00ee628    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10104c91c: f9440100    	ldr	x0, [x8, #0x800]
10104c920: d00ee2c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10104c924: f9428514    	ldr	x20, [x8, #0x508]
10104c928: aa1403e1    	mov	x1, x20
10104c92c: 95af6cce    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104c930: aa0003e2    	mov	x2, x0
10104c934: b00ecbe8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10104c938: f9452101    	ldr	x1, [x8, #0xa40]
10104c93c: aa1503e0    	mov	x0, x21
10104c940: 95af6cc9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104c944: aa1d03fd    	mov	x29, x29
10104c948: 95af6cce    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104c94c: aa0003f6    	mov	x22, x0
10104c950: b00ece68    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
10104c954: f9468101    	ldr	x1, [x8, #0xd00]
10104c958: 95af6cc3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104c95c: aa0003f7    	mov	x23, x0
10104c960: aa1603e0    	mov	x0, x22
10104c964: 95af6cc3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104c968: aa1503e0    	mov	x0, x21
10104c96c: 95af6cc1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104c970: 34000517    	cbz	w23, 0x10104ca10 <__text+0x1044a10>
10104c974: d00ee988    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10104c978: 912e4108    	add	x8, x8, #0xb90
10104c97c: b9800116    	ldrsw	x22, [x8]
10104c980: f8766a75    	ldr	x21, [x19, x22]
10104c984: d00ee628    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10104c988: f9456100    	ldr	x0, [x8, #0xac0]
10104c98c: aa1403e1    	mov	x1, x20
10104c990: 95af6cb5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104c994: aa0003e2    	mov	x2, x0
10104c998: 900ee2e8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10104c99c: f9444901    	ldr	x1, [x8, #0x890]
10104c9a0: aa1503e0    	mov	x0, x21
10104c9a4: 95af6cb0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104c9a8: 34000340    	cbz	w0, 0x10104ca10 <__text+0x1044a10>
10104c9ac: f8766a60    	ldr	x0, [x19, x22]
10104c9b0: 900ecc88    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10104c9b4: f9439901    	ldr	x1, [x8, #0x730]
10104c9b8: 95af6cab    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104c9bc: aa1d03fd    	mov	x29, x29
10104c9c0: 95af6cb0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104c9c4: b4000260    	cbz	x0, 0x10104ca10 <__text+0x1044a10>
10104c9c8: aa0003f4    	mov	x20, x0
10104c9cc: 900ecde8    	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
10104c9d0: f942c101    	ldr	x1, [x8, #0x580]
10104c9d4: 95af6ca4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104c9d8: aa1d03fd    	mov	x29, x29
10104c9dc: 95af6ca9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104c9e0: aa0003f5    	mov	x21, x0
10104c9e4: 900ecc28    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
10104c9e8: f940d901    	ldr	x1, [x8, #0x1b0]
10104c9ec: 95af6c9e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104c9f0: aa1d03fd    	mov	x29, x29
10104c9f4: 95af6ca3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104c9f8: aa0003f3    	mov	x19, x0
10104c9fc: aa1503e0    	mov	x0, x21
10104ca00: 95af6c9c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104ca04: aa1403e0    	mov	x0, x20
10104ca08: 95af6c9a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104ca0c: 14000003    	b	0x10104ca18 <__text+0x1044a18>
10104ca10: f00dfa73    	adrp	x19, 0x11cf9b000 <dyld_stub_binder+0x11cf9b000>
10104ca14: 91396273    	add	x19, x19, #0xe58
10104ca18: aa1303e0    	mov	x0, x19
10104ca1c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10104ca20: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10104ca24: a94157f6    	ldp	x22, x21, [sp, #0x10]
10104ca28: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10104ca2c: 15af6c7d    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
