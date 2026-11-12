
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105461d28: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105461d2c: a9014ff4    	stp	x20, x19, [sp, #0x10]
105461d30: a9027bfd    	stp	x29, x30, [sp, #0x20]
105461d34: 910083fd    	add	x29, sp, #0x20
105461d38: b00ccb48    	adrp	x8, 0x11edca000 <dyld_stub_binder+0x11edca000>
105461d3c: b988ed16    	ldrsw	x22, [x8, #0x8ec]
105461d40: b8766808    	ldr	w8, [x0, x22]
105461d44: 34000408    	cbz	w8, 0x105461dc4 <_Flutter_MMFoundation_BindContext+0x16e8a90>
105461d48: aa0003f3    	mov	x19, x0
105461d4c: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461d50: f943c100    	ldr	x0, [x8, #0x780] ; class MMContext
105461d54: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105461d58: f9440101    	ldr	x1, [x8, #0x800] ; selector currentContext
105461d5c: 949f17c2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461d60: aa1d03fd    	mov	x29, x29
105461d64: 949f17c7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105461d68: aa0003f4    	mov	x20, x0
105461d6c: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461d70: f9457d00    	ldr	x0, [x8, #0xaf8] ; class EventService
105461d74: b00cc228    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105461d78: f9428501    	ldr	x1, [x8, #0x508] ; selector class
105461d7c: 949f17ba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461d80: aa0003e2    	mov	x2, x0
105461d84: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105461d88: f9452101    	ldr	x1, [x8, #0xa40] ; selector getService:
105461d8c: aa1403e0    	mov	x0, x20
105461d90: 949f17b5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461d94: aa1d03fd    	mov	x29, x29
105461d98: 949f17ba    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105461d9c: aa0003f5    	mov	x21, x0
105461da0: b8766a62    	ldr	w2, [x19, x22]
105461da4: f00cad68    	adrp	x8, 0x11ea10000 <dyld_stub_binder+0x11ea10000>
105461da8: f9464101    	ldr	x1, [x8, #0xc80] ; selector StopEvent:
105461dac: 949f17ae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461db0: aa1503e0    	mov	x0, x21
105461db4: 949f17af    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461db8: aa1403e0    	mov	x0, x20
105461dbc: 949f17ad    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461dc0: b8366a7f    	str	wzr, [x19, x22]
105461dc4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105461dc8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105461dcc: a8c357f6    	ldp	x22, x21, [sp], #0x30
105461dd0: d65f03c0    	ret
