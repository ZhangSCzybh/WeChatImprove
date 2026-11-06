
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10104d938: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10104d93c: a90157f6    	stp	x22, x21, [sp, #0x10]
10104d940: a9024ff4    	stp	x20, x19, [sp, #0x20]
10104d944: a9037bfd    	stp	x29, x30, [sp, #0x30]
10104d948: 9100c3fd    	add	x29, sp, #0x30
10104d94c: aa0003f7    	mov	x23, x0
10104d950: d00f37a8    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
10104d954: 52800035    	mov	w21, #0x1               ; =1
10104d958: 3928c915    	strb	w21, [x8, #0xa32]
10104d95c: b00ee668    	adrp	x8, 0x11ed1a000 <dyld_stub_binder+0x11ed1a000>
10104d960: f9461100    	ldr	x0, [x8, #0xc20]
10104d964: 900ee308    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10104d968: f9400d01    	ldr	x1, [x8, #0x18]
10104d96c: 95af68be    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104d970: aa1d03fd    	mov	x29, x29
10104d974: 95af68c3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104d978: aa0003f3    	mov	x19, x0
10104d97c: 900ee9e8    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
10104d980: b9891108    	ldrsw	x8, [x8, #0x910]
10104d984: f8686af4    	ldr	x20, [x23, x8]
10104d988: b00ecc68    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
10104d98c: f945c501    	ldr	x1, [x8, #0xb88]
10104d990: aa1703e0    	mov	x0, x23
10104d994: 95af68b4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104d998: aa0003f6    	mov	x22, x0
10104d99c: b00ece68    	adrp	x8, 0x11ea1a000 <dyld_stub_binder+0x11ea1a000>
10104d9a0: f941dd01    	ldr	x1, [x8, #0x3b8]
10104d9a4: aa1703e0    	mov	x0, x23
10104d9a8: 95af68af    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104d9ac: aa0003f8    	mov	x24, x0
10104d9b0: d00ecc08    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10104d9b4: f941b101    	ldr	x1, [x8, #0x360]
10104d9b8: aa1703e0    	mov	x0, x23
10104d9bc: 95af68aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104d9c0: 37000180    	tbnz	w0, #0x0, 0x10104d9f0 <__text+0x10459f0>
10104d9c4: b00ee988    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10104d9c8: 912e3108    	add	x8, x8, #0xb8c
10104d9cc: b9800108    	ldrsw	x8, [x8]
10104d9d0: f8686ae0    	ldr	x0, [x23, x8]
10104d9d4: b00ee2c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10104d9d8: f9428501    	ldr	x1, [x8, #0x508]
10104d9dc: 95af68a2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104d9e0: b00ecc68    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
10104d9e4: f9477101    	ldr	x1, [x8, #0xee0]
10104d9e8: 95af689f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104d9ec: aa0003f5    	mov	x21, x0
10104d9f0: b00ece68    	adrp	x8, 0x11ea1a000 <dyld_stub_binder+0x11ea1a000>
10104d9f4: f941e101    	ldr	x1, [x8, #0x3c0]
10104d9f8: aa1303e0    	mov	x0, x19
10104d9fc: aa1403e2    	mov	x2, x20
10104da00: aa1603e3    	mov	x3, x22
10104da04: aa1803e4    	mov	x4, x24
10104da08: aa1503e5    	mov	x5, x21
10104da0c: 95af6896    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10104da10: aa1d03fd    	mov	x29, x29
10104da14: 95af689b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10104da18: aa0003f4    	mov	x20, x0
10104da1c: aa1303e0    	mov	x0, x19
10104da20: 95af6894    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10104da24: aa1403e0    	mov	x0, x20
10104da28: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10104da2c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10104da30: a94157f6    	ldp	x22, x21, [sp, #0x10]
10104da34: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10104da38: 15af687a    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
