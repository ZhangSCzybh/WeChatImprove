
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
103dd8fe8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
103dd8fec: a9017bfd    	stp	x29, x30, [sp, #0x10]
103dd8ff0: 910043fd    	add	x29, sp, #0x10
103dd8ff4: aa0003f3    	mov	x19, x0
103dd8ff8: 900d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd8ffc: b98f7508    	ldrsw	x8, [x8, #0xf74]
103dd9000: 8b080008    	add	x8, x0, x8
103dd9004: 6d000500    	stp	d0, d1, [x8]
103dd9008: 900d6868    	adrp	x8, 0x11eae5000 <dyld_stub_binder+0x11eae5000>
103dd900c: f9440d01    	ldr	x1, [x8, #0x818]
103dd9010: 94f93b15    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd9014: f00d7ec8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd9018: b98f8508    	ldrsw	x8, [x8, #0xf84]
103dd901c: f8686a60    	ldr	x0, [x19, x8]
103dd9020: 900d5fc8    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
103dd9024: f940d901    	ldr	x1, [x8, #0x1b0]
103dd9028: a9417bfd    	ldp	x29, x30, [sp, #0x10]
103dd902c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
103dd9030: 14f93b0d    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
