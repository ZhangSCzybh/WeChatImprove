
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105461b7c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105461b80: a9014ff4    	stp	x20, x19, [sp, #0x10]
105461b84: a9027bfd    	stp	x29, x30, [sp, #0x20]
105461b88: 910083fd    	add	x29, sp, #0x20
105461b8c: aa0203f3    	mov	x19, x2
105461b90: aa0003f4    	mov	x20, x0
105461b94: aa0203e0    	mov	x0, x2
105461b98: 949f1837    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105461b9c: b00cb6c8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
105461ba0: f945c501    	ldr	x1, [x8, #0xb88] ; selector cancelBgFgEvent
105461ba4: aa1403e0    	mov	x0, x20
105461ba8: 949f182f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461bac: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461bb0: f9442100    	ldr	x0, [x8, #0x840] ; class CAppUtil
105461bb4: b00cab68    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
105461bb8: f9410101    	ldr	x1, [x8, #0x200] ; selector isLogin
105461bbc: 949f182a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461bc0: 340003c0    	cbz	w0, 0x105461c38 <_Flutter_MMFoundation_BindContext+0x16e8904>
105461bc4: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461bc8: f943c100    	ldr	x0, [x8, #0x780] ; class MMContext
105461bcc: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105461bd0: f9440101    	ldr	x1, [x8, #0x800] ; selector currentContext
105461bd4: 949f1824    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461bd8: aa1d03fd    	mov	x29, x29
105461bdc: 949f1829    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105461be0: aa0003f4    	mov	x20, x0
105461be4: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461be8: f9457d00    	ldr	x0, [x8, #0xaf8] ; class EventService
105461bec: b00cc228    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105461bf0: f9428501    	ldr	x1, [x8, #0x508] ; selector class
105461bf4: 949f181c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461bf8: aa0003e2    	mov	x2, x0
105461bfc: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105461c00: f9452101    	ldr	x1, [x8, #0xa40] ; selector getService:
105461c04: aa1403e0    	mov	x0, x20
105461c08: 949f1817    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461c0c: aa1d03fd    	mov	x29, x29
105461c10: 949f181c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105461c14: aa0003f5    	mov	x21, x0
105461c18: d00caec8    	adrp	x8, 0x11ea3b000 <dyld_stub_binder+0x11ea3b000>
105461c1c: f9430101    	ldr	x1, [x8, #0x600] ; selector AddEvent:
105461c20: aa1303e2    	mov	x2, x19
105461c24: 949f1810    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461c28: aa1503e0    	mov	x0, x21
105461c2c: 949f1811    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461c30: aa1403e0    	mov	x0, x20
105461c34: 949f180f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461c38: aa1303e0    	mov	x0, x19
105461c3c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105461c40: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105461c44: a8c357f6    	ldp	x22, x21, [sp], #0x30
105461c48: 149f180a    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
