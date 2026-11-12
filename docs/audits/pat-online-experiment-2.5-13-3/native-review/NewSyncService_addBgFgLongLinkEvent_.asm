
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105461c4c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105461c50: a9014ff4    	stp	x20, x19, [sp, #0x10]
105461c54: a9027bfd    	stp	x29, x30, [sp, #0x20]
105461c58: 910083fd    	add	x29, sp, #0x20
105461c5c: aa0203f3    	mov	x19, x2
105461c60: aa0003f4    	mov	x20, x0
105461c64: aa0203e0    	mov	x0, x2
105461c68: 949f1803    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105461c6c: b00cb6c8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
105461c70: f945c501    	ldr	x1, [x8, #0xb88] ; selector cancelBgFgEvent
105461c74: aa1403e0    	mov	x0, x20
105461c78: 949f17fb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461c7c: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461c80: f9442100    	ldr	x0, [x8, #0x840] ; class CAppUtil
105461c84: b00cab68    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
105461c88: f9410101    	ldr	x1, [x8, #0x200] ; selector isLogin
105461c8c: 949f17f6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461c90: 34000420    	cbz	w0, 0x105461d14 <_Flutter_MMFoundation_BindContext+0x16e89e0>
105461c94: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461c98: f943c100    	ldr	x0, [x8, #0x780] ; class MMContext
105461c9c: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105461ca0: f9440101    	ldr	x1, [x8, #0x800] ; selector currentContext
105461ca4: 949f17f0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461ca8: aa1d03fd    	mov	x29, x29
105461cac: 949f17f5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105461cb0: aa0003f5    	mov	x21, x0
105461cb4: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461cb8: f9457d00    	ldr	x0, [x8, #0xaf8] ; class EventService
105461cbc: b00cc228    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105461cc0: f9428501    	ldr	x1, [x8, #0x508] ; selector class
105461cc4: 949f17e8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461cc8: aa0003e2    	mov	x2, x0
105461ccc: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105461cd0: f9452101    	ldr	x1, [x8, #0xa40] ; selector getService:
105461cd4: aa1503e0    	mov	x0, x21
105461cd8: 949f17e3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461cdc: aa1d03fd    	mov	x29, x29
105461ce0: 949f17e8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105461ce4: aa0003f6    	mov	x22, x0
105461ce8: d00caec8    	adrp	x8, 0x11ea3b000 <dyld_stub_binder+0x11ea3b000>
105461cec: f9430101    	ldr	x1, [x8, #0x600] ; selector AddEvent:
105461cf0: aa1303e2    	mov	x2, x19
105461cf4: 949f17dc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461cf8: b00ccb48    	adrp	x8, 0x11edca000 <dyld_stub_binder+0x11edca000>
105461cfc: b988ed08    	ldrsw	x8, [x8, #0x8ec]
105461d00: b8286a80    	str	w0, [x20, x8]
105461d04: aa1603e0    	mov	x0, x22
105461d08: 949f17da    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461d0c: aa1503e0    	mov	x0, x21
105461d10: 949f17d8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461d14: aa1303e0    	mov	x0, x19
105461d18: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105461d1c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105461d20: a8c357f6    	ldp	x22, x21, [sp], #0x30
105461d24: 149f17d3    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
