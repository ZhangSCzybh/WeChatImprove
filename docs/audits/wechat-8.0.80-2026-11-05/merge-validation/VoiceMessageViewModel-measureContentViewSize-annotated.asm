
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
106588d70: 6dbd23e9    	stp	d9, d8, [sp, #-0x30]!
106588d74: a9014ff4    	stp	x20, x19, [sp, #0x10]
106588d78: a9027bfd    	stp	x29, x30, [sp, #0x20]
106588d7c: 910083fd    	add	x29, sp, #0x20
106588d80: aa0003f3    	mov	x19, x0
106588d84: f00c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106588d88: f9437101    	ldr	x1, [x8, #0x6e0] ; selector: voiceNodeWidth
106588d8c: 945a7bb6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588d90: 4ea01c08    	mov.16b	v8, v0
106588d94: f00c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106588d98: f9432101    	ldr	x1, [x8, #0x640] ; selector: voiceNodeHeight
106588d9c: aa1303e0    	mov	x0, x19
106588da0: 945a7bb1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588da4: 4ea01c01    	mov.16b	v1, v0
106588da8: 4ea81d00    	mov.16b	v0, v8
106588dac: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106588db0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106588db4: 6cc323e9    	ldp	d9, d8, [sp], #0x30
106588db8: d65f03c0    	ret
