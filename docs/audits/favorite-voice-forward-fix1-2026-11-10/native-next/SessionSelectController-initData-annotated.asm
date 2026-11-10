
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae3134: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
105ae3138: a9017bfd    	stp	x29, x30, [sp, #0x10]
105ae313c: 910043fd    	add	x29, sp, #0x10
105ae3140: aa0003f3    	mov	x19, x0
105ae3144: f00c91a8    	adrp	x8, 0x11ed1a000 <dyld_stub_binder+0x11ed1a000>
105ae3148: f943c900    	ldr	x0, [x8, #0x790]
105ae314c: 948512b0    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
105ae3150: d00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae3154: b984b109    	ldrsw	x9, [x8, #0x4b0] ; ivar: SessionSelectController.m_multiSelectContactsInChatRoomReport offset=280
105ae3158: f8696a68    	ldr	x8, [x19, x9]
105ae315c: f8296a60    	str	x0, [x19, x9]
105ae3160: aa0803e0    	mov	x0, x8
105ae3164: 948512c3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae3168: f00c9168    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105ae316c: f945f100    	ldr	x0, [x8, #0xbe0]
105ae3170: d00c7b88    	adrp	x8, 0x11ea55000 <dyld_stub_binder+0x11ea55000>
105ae3174: f9468d01    	ldr	x1, [x8, #0xd18] ; selector: getAllowForwardToClawBotSwitch
105ae3178: 948512bb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae317c: 34000420    	cbz	w0, 0x105ae3200 <_Flutter_MMFoundation_BindContext+0x1d69ecc>
105ae3180: f00c9168    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105ae3184: f943c100    	ldr	x0, [x8, #0x780]
105ae3188: d00c7728    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105ae318c: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
105ae3190: 948512b5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae3194: aa1d03fd    	mov	x29, x29
105ae3198: 948512ba    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae319c: aa0003f3    	mov	x19, x0
105ae31a0: f00c9188    	adrp	x8, 0x11ed16000 <dyld_stub_binder+0x11ed16000>
105ae31a4: f9407d00    	ldr	x0, [x8, #0xf8]
105ae31a8: f00c8e08    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae31ac: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
105ae31b0: 948512ad    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae31b4: aa0003e2    	mov	x2, x0
105ae31b8: d00c7728    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105ae31bc: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
105ae31c0: aa1303e0    	mov	x0, x19
105ae31c4: 948512a8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae31c8: aa1d03fd    	mov	x29, x29
105ae31cc: 948512ad    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae31d0: aa0003f4    	mov	x20, x0
105ae31d4: b00c7808    	adrp	x8, 0x11e9e4000 <dyld_stub_binder+0x11e9e4000>
105ae31d8: f9418901    	ldr	x1, [x8, #0x310] ; selector: getMMBotContact
105ae31dc: 948512a2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae31e0: aa1d03fd    	mov	x29, x29
105ae31e4: 948512b2    	bl	0x107c27cac <_Flutter_MMFoundation_BindContext+0x3eae978>
105ae31e8: aa1403e0    	mov	x0, x20
105ae31ec: 948512a1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae31f0: aa1303e0    	mov	x0, x19
105ae31f4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
105ae31f8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
105ae31fc: 1485129d    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae3200: a9417bfd    	ldp	x29, x30, [sp, #0x10]
105ae3204: a8c24ff4    	ldp	x20, x19, [sp], #0x20
105ae3208: d65f03c0    	ret
