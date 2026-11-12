
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105461de4: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
105461de8: a9017bfd    	stp	x29, x30, [sp, #0x10]
105461dec: 910043fd    	add	x29, sp, #0x10
105461df0: aa0003f3    	mov	x19, x0
105461df4: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461df8: f9442100    	ldr	x0, [x8, #0x840] ; class CAppUtil
105461dfc: b00cab68    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
105461e00: f9410101    	ldr	x1, [x8, #0x200] ; selector isLogin
105461e04: 949f1798    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461e08: 340001e0    	cbz	w0, 0x105461e44 <_Flutter_MMFoundation_BindContext+0x16e8b10>
105461e0c: b00ccb48    	adrp	x8, 0x11edca000 <dyld_stub_binder+0x11edca000>
105461e10: b9891508    	ldrsw	x8, [x8, #0x914]
105461e14: 52800029    	mov	w9, #0x1                ; =1
105461e18: 38286a69    	strb	w9, [x19, x8]
105461e1c: 52800300    	mov	w0, #0x18               ; =24
105461e20: d2800001    	mov	x1, #0x0                ; =0
105461e24: 949ea8cd    	bl	0x107c0c158 <_Flutter_MMFoundation_BindContext+0x3e92e24>
105461e28: b00cb6c8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
105461e2c: f945e501    	ldr	x1, [x8, #0xbc8] ; selector sendBgFgRequestWithOnlineMode:
105461e30: aa1303e0    	mov	x0, x19
105461e34: 52800022    	mov	w2, #0x1                ; =1
105461e38: a9417bfd    	ldp	x29, x30, [sp, #0x10]
105461e3c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
105461e40: 149f1789    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461e44: a9417bfd    	ldp	x29, x30, [sp, #0x10]
105461e48: a8c24ff4    	ldp	x20, x19, [sp], #0x20
105461e4c: d65f03c0    	ret
