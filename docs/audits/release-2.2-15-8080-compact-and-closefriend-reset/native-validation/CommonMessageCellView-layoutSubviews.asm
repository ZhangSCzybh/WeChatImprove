
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101035af0: d10143ff    	sub	sp, sp, #0x50
101035af4: a9015ff8    	stp	x24, x23, [sp, #0x10]
101035af8: a90257f6    	stp	x22, x21, [sp, #0x20]
101035afc: a9034ff4    	stp	x20, x19, [sp, #0x30]
101035b00: a9047bfd    	stp	x29, x30, [sp, #0x40]
101035b04: 910103fd    	add	x29, sp, #0x40
101035b08: aa0003f3    	mov	x19, x0
101035b0c: d00f3868    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
101035b10: 52800029    	mov	w9, #0x1                ; =1
101035b14: 39276d09    	strb	w9, [x8, #0x9db]
101035b18: 900ee928    	adrp	x8, 0x11ed59000 <dyld_stub_binder+0x11ed59000>
101035b1c: f947e108    	ldr	x8, [x8, #0xfc0]
101035b20: a90023e0    	stp	x0, x8, [sp]
101035b24: b00eccc8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
101035b28: f9415901    	ldr	x1, [x8, #0x2b0]
101035b2c: 910003e0    	mov	x0, sp
101035b30: 95afc84e    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
101035b34: b00eccc8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
101035b38: f941c114    	ldr	x20, [x8, #0x380]
101035b3c: aa1303e0    	mov	x0, x19
101035b40: aa1403e1    	mov	x1, x20
101035b44: 95afc848    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035b48: aa1d03fd    	mov	x29, x29
101035b4c: 95afc84d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101035b50: aa0003f5    	mov	x21, x0
101035b54: 900ecee8    	adrp	x8, 0x11ea11000 <dyld_stub_binder+0x11ea11000>
101035b58: f946e501    	ldr	x1, [x8, #0xdc8]
101035b5c: 95afc842    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035b60: 36000580    	tbz	w0, #0x0, 0x101035c10 <__text+0x102dc10>
101035b64: aa1303e0    	mov	x0, x19
101035b68: aa1403e1    	mov	x1, x20
101035b6c: 95afc83e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035b70: aa1d03fd    	mov	x29, x29
101035b74: 95afc843    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101035b78: aa0003f6    	mov	x22, x0
101035b7c: f00ecd48    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
101035b80: f9440901    	ldr	x1, [x8, #0x810]
101035b84: 95afc838    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035b88: aa0003f7    	mov	x23, x0
101035b8c: aa1603e0    	mov	x0, x22
101035b90: 95afc838    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101035b94: aa1503e0    	mov	x0, x21
101035b98: 95afc836    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101035b9c: 340003f7    	cbz	w23, 0x101035c18 <__text+0x102dc18>
101035ba0: 900ecf28    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
101035ba4: f9466901    	ldr	x1, [x8, #0xcd0]
101035ba8: aa1303e0    	mov	x0, x19
101035bac: 95afc82e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035bb0: aa0003f5    	mov	x21, x0
101035bb4: aa1303e0    	mov	x0, x19
101035bb8: aa1403e1    	mov	x1, x20
101035bbc: 95afc82a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035bc0: aa1d03fd    	mov	x29, x29
101035bc4: 95afc82f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101035bc8: aa0003f4    	mov	x20, x0
101035bcc: b00ecd28    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
101035bd0: f945cd01    	ldr	x1, [x8, #0xb98]
101035bd4: 95afc824    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035bd8: aa0003f6    	mov	x22, x0
101035bdc: aa1403e0    	mov	x0, x20
101035be0: 95afc824    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101035be4: 6b1602bf    	cmp	w21, w22
101035be8: 54000180    	b.eq	0x101035c18 <__text+0x102dc18>
101035bec: 900ecf28    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
101035bf0: f9466d01    	ldr	x1, [x8, #0xcd8]
101035bf4: aa1303e0    	mov	x0, x19
101035bf8: 95afc81b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035bfc: 900ecf28    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
101035c00: f9467101    	ldr	x1, [x8, #0xce0]
101035c04: aa1303e0    	mov	x0, x19
101035c08: 95afc817    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035c0c: 14000003    	b	0x101035c18 <__text+0x102dc18>
101035c10: aa1503e0    	mov	x0, x21
101035c14: 95afc817    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101035c18: 900ecf28    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
101035c1c: f9465901    	ldr	x1, [x8, #0xcb0]
101035c20: aa1303e0    	mov	x0, x19
101035c24: 95afc810    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035c28: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101035c2c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101035c30: a94257f6    	ldp	x22, x21, [sp, #0x20]
101035c34: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101035c38: 910143ff    	add	sp, sp, #0x50
101035c3c: d65f03c0    	ret
