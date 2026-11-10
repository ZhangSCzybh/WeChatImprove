
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
101dc08f0: d10183ff    	sub	sp, sp, #0x60
101dc08f4: 6d0123e9    	stp	d9, d8, [sp, #0x10]
101dc08f8: a9025ff8    	stp	x24, x23, [sp, #0x20]
101dc08fc: a90357f6    	stp	x22, x21, [sp, #0x30]
101dc0900: a9044ff4    	stp	x20, x19, [sp, #0x40]
101dc0904: a9057bfd    	stp	x29, x30, [sp, #0x50]
101dc0908: 910143fd    	add	x29, sp, #0x50
101dc090c: aa0203f3    	mov	x19, x2
101dc0910: aa0003f4    	mov	x20, x0
101dc0914: d00ecc28    	adrp	x8, 0x11f746000 <dyld_stub_binder+0x11f746000>
101dc0918: 52800029    	mov	w9, #0x1                ; =1
101dc091c: 392f9909    	strb	w9, [x8, #0xbe6]
101dc0920: aa0203e0    	mov	x0, x2
101dc0924: 95799cd4    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101dc0928: b00e7ea8    	adrp	x8, 0x11ed95000 <dyld_stub_binder+0x11ed95000>
101dc092c: b9857108    	ldrsw	x8, [x8, #0x570] ; ivar: ForwardMessageLogicController.m_atUserList offset=80
101dc0930: f8686a80    	ldr	x0, [x20, x8]
101dc0934: f8286a9f    	str	xzr, [x20, x8]
101dc0938: 95799cce    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc093c: b00e7ea8    	adrp	x8, 0x11ed95000 <dyld_stub_binder+0x11ed95000>
101dc0940: b9852908    	ldrsw	x8, [x8, #0x528] ; ivar: ForwardMessageLogicController.m_toContacts offset=40
101dc0944: 8b080280    	add	x0, x20, x8
101dc0948: aa1303e1    	mov	x1, x19
101dc094c: 95799cd4    	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
101dc0950: b00e64a8    	adrp	x8, 0x11ea55000 <dyld_stub_binder+0x11ea55000>
101dc0954: f9402101    	ldr	x1, [x8, #0x40] ; selector: setCancelSendContacts:
101dc0958: aa1403e0    	mov	x0, x20
101dc095c: d2800002    	mov	x2, #0x0                ; =0
101dc0960: 95799cc1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0964: b00e64a8    	adrp	x8, 0x11ea55000 <dyld_stub_binder+0x11ea55000>
101dc0968: f9405d01    	ldr	x1, [x8, #0xb8] ; selector: checkIfShareGroupToolItem:
101dc096c: aa1403e0    	mov	x0, x20
101dc0970: aa1303e2    	mov	x2, x19
101dc0974: 95799cbc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0978: aa0003f6    	mov	x22, x0
101dc097c: d00e7a88    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101dc0980: f943c100    	ldr	x0, [x8, #0x780]
101dc0984: b00e6048    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101dc0988: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
101dc098c: 95799cb6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0990: aa1d03fd    	mov	x29, x29
101dc0994: 95799cbb    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101dc0998: aa0003f7    	mov	x23, x0
101dc099c: 900e7aa8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101dc09a0: f947ed00    	ldr	x0, [x8, #0xfd8]
101dc09a4: d00e7728    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101dc09a8: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
101dc09ac: 95799cae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc09b0: aa0003e2    	mov	x2, x0
101dc09b4: b00e6048    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101dc09b8: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
101dc09bc: aa1703e0    	mov	x0, x23
101dc09c0: 95799ca9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc09c4: aa1d03fd    	mov	x29, x29
101dc09c8: 95799cae    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101dc09cc: aa0003f8    	mov	x24, x0
101dc09d0: b00e64a8    	adrp	x8, 0x11ea55000 <dyld_stub_binder+0x11ea55000>
101dc09d4: f9406101    	ldr	x1, [x8, #0xc0] ; selector: shouldShowUndoneTips
101dc09d8: 95799ca3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc09dc: aa0003f5    	mov	x21, x0
101dc09e0: aa1803e0    	mov	x0, x24
101dc09e4: 95799ca3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc09e8: aa1703e0    	mov	x0, x23
101dc09ec: 95799ca1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc09f0: 34000916    	cbz	w22, 0x101dc0b10 <_Flutter_Image_provideRelativePathByUrl+0x48f9c>
101dc09f4: 340008f5    	cbz	w21, 0x101dc0b10 <_Flutter_Image_provideRelativePathByUrl+0x48f9c>
101dc09f8: f00e6048    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
101dc09fc: f9459101    	ldr	x1, [x8, #0xb20] ; selector: getViewController
101dc0a00: aa1403e0    	mov	x0, x20
101dc0a04: 95799c98    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0a08: aa1d03fd    	mov	x29, x29
101dc0a0c: 95799c9d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101dc0a10: aa0003f5    	mov	x21, x0
101dc0a14: b00e7768    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
101dc0a18: f9472901    	ldr	x1, [x8, #0xe50] ; selector: view
101dc0a1c: 95799c92    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0a20: aa1d03fd    	mov	x29, x29
101dc0a24: 95799c97    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101dc0a28: aa0003f6    	mov	x22, x0
101dc0a2c: d00e7728    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101dc0a30: f9409501    	ldr	x1, [x8, #0x128] ; selector: bounds
101dc0a34: 95799c8c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0a38: 9579976f    	bl	0x107c267f4 <_Flutter_MMFoundation_BindContext+0x3ead4c0>
101dc0a3c: 4ea01c08    	mov.16b	v8, v0
101dc0a40: aa1603e0    	mov	x0, x22
101dc0a44: 95799c8b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc0a48: aa1503e0    	mov	x0, x21
101dc0a4c: 95799c89    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc0a50: b00e7aa8    	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
101dc0a54: f9448500    	ldr	x0, [x8, #0x908]
101dc0a58: 95799c6c    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
101dc0a5c: 900e7748    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
101dc0a60: f9418501    	ldr	x1, [x8, #0x308] ; selector: initWithFrame:
101dc0a64: 9e6703e0    	fmov	d0, xzr
101dc0a68: 9e6703e1    	fmov	d1, xzr
101dc0a6c: 9e6703e3    	fmov	d3, xzr
101dc0a70: 4ea81d02    	mov.16b	v2, v8
101dc0a74: 95799c7c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0a78: aa0003f5    	mov	x21, x0
101dc0a7c: 900e6108    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
101dc0a80: f9438d01    	ldr	x1, [x8, #0x718] ; selector: setUndoneDelegate:
101dc0a84: aa1403e2    	mov	x2, x20
101dc0a88: 95799c77    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0a8c: 900e6108    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
101dc0a90: f9439101    	ldr	x1, [x8, #0x720] ; selector: setBShowCloseButton:
101dc0a94: aa1503e0    	mov	x0, x21
101dc0a98: 52800002    	mov	w2, #0x0                ; =0
101dc0a9c: 95799c72    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0aa0: 900e6108    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
101dc0aa4: f9439501    	ldr	x1, [x8, #0x728] ; selector: setBPageSheetStyle:
101dc0aa8: aa1503e0    	mov	x0, x21
101dc0aac: 52800022    	mov	w2, #0x1                ; =1
101dc0ab0: 95799c6d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0ab4: 900e6108    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
101dc0ab8: f9439901    	ldr	x1, [x8, #0x730] ; selector: showInPageSheet
101dc0abc: aa1503e0    	mov	x0, x21
101dc0ac0: 95799c69    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0ac4: d00e7a88    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101dc0ac8: f9430d00    	ldr	x0, [x8, #0x618]
101dc0acc: b00e6048    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101dc0ad0: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
101dc0ad4: b00d98e8    	adrp	x8, 0x11d0dd000 <dyld_stub_binder+0x11d0dd000>
101dc0ad8: 91286108    	add	x8, x8, #0xa18 ; CFString: show group undone tip
101dc0adc: f90003e8    	str	x8, [sp]
101dc0ae0: f00c0145    	adrp	x5, 0x119deb000 <dyld_stub_binder+0x119deb000>
101dc0ae4: 913f44a5    	add	x5, x5, #0xfd1
101dc0ae8: 900c0167    	adrp	x7, 0x119dec000 <dyld_stub_binder+0x119dec000>
101dc0aec: 911224e7    	add	x7, x7, #0x489
101dc0af0: 52800042    	mov	w2, #0x2                ; =2
101dc0af4: d2800003    	mov	x3, #0x0                ; =0
101dc0af8: 52800004    	mov	w4, #0x0                ; =0
101dc0afc: 528091c6    	mov	w6, #0x48e              ; =1166
101dc0b00: 95799c59    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0b04: aa1503e0    	mov	x0, x21
101dc0b08: 95799c5a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc0b0c: 14000005    	b	0x101dc0b20 <_Flutter_Image_provideRelativePathByUrl+0x48fac>
101dc0b10: b00e64a8    	adrp	x8, 0x11ea55000 <dyld_stub_binder+0x11ea55000>
101dc0b14: f9406501    	ldr	x1, [x8, #0xc8] ; selector: internalShowConfirmView
101dc0b18: aa1403e0    	mov	x0, x20
101dc0b1c: 95799c52    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc0b20: aa1303e0    	mov	x0, x19
101dc0b24: a9457bfd    	ldp	x29, x30, [sp, #0x50]
101dc0b28: a9444ff4    	ldp	x20, x19, [sp, #0x40]
101dc0b2c: a94357f6    	ldp	x22, x21, [sp, #0x30]
101dc0b30: a9425ff8    	ldp	x24, x23, [sp, #0x20]
101dc0b34: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
101dc0b38: 910183ff    	add	sp, sp, #0x60
101dc0b3c: 15799c4d    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
