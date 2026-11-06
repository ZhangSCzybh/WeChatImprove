
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
104d9ed10: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104d9ed14: a9017bfd    	stp	x29, x30, [sp, #0x10]
104d9ed18: 910043fd    	add	x29, sp, #0x10
104d9ed1c: aa0203f3    	mov	x19, x2
104d9ed20: aa0003f4    	mov	x20, x0
104d9ed24: 900cfba8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104d9ed28: f944d900    	ldr	x0, [x8, #0x9b0]
104d9ed2c: d00ce168    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
104d9ed30: f942b501    	ldr	x1, [x8, #0x568]
104d9ed34: 94ba23cc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104d9ed38: aa0003e3    	mov	x3, x0
104d9ed3c: b00cec28    	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104d9ed40: f943a501    	ldr	x1, [x8, #0x748]
104d9ed44: aa1403e0    	mov	x0, x20
104d9ed48: aa1303e2    	mov	x2, x19
104d9ed4c: 52800024    	mov	w4, #0x1                ; =1
104d9ed50: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104d9ed54: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104d9ed58: 14ba23c3    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
