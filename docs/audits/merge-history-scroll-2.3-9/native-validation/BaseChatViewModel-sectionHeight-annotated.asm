
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002abe10: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
1002abe14: a9015ff8    	stp	x24, x23, [sp, #0x10]
1002abe18: a90257f6    	stp	x22, x21, [sp, #0x20]
1002abe1c: a9034ff4    	stp	x20, x19, [sp, #0x30]
1002abe20: a9047bfd    	stp	x29, x30, [sp, #0x40]
1002abe24: 910103fd    	add	x29, sp, #0x40
1002abe28: aa0003f3    	mov	x19, x0
1002abe2c: 900f3968    	adrp	x8, 0x11e9d7000 <dyld_stub_binder+0x11e9d7000>
1002abe30: f9445d01    	ldr	x1, [x8, #0x8b8] ; selector: numberOfRowsInSection
1002abe34: 95e5ef8c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002abe38: f100081f    	cmp	x0, #0x2
1002abe3c: 540003cb    	b.lt	0x1002abeb4 <__text+0x2a3eb4>
1002abe40: aa0003f4    	mov	x20, x0
1002abe44: d2800015    	mov	x21, #0x0               ; =0
1002abe48: f00f3968    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
1002abe4c: f945ad16    	ldr	x22, [x8, #0xb58] ; selector: cellDataForRow:
1002abe50: d00f3928    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1002abe54: f9436917    	ldr	x23, [x8, #0x6d0] ; selector: rowHeight
1002abe58: 9e6703e8    	fmov	d8, xzr
1002abe5c: aa1303e0    	mov	x0, x19
1002abe60: aa1603e1    	mov	x1, x22
1002abe64: aa1503e2    	mov	x2, x21
1002abe68: 95e5ef7f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002abe6c: aa1d03fd    	mov	x29, x29
1002abe70: 95e5ef84    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002abe74: aa0003f8    	mov	x24, x0
1002abe78: aa1703e1    	mov	x1, x23
1002abe7c: 95e5ef7a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002abe80: 1e602908    	fadd	d8, d8, d0
1002abe84: aa1803e0    	mov	x0, x24
1002abe88: 95e5ef7a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002abe8c: 910006b5    	add	x21, x21, #0x1
1002abe90: eb15029f    	cmp	x20, x21
1002abe94: 54fffe41    	b.ne	0x1002abe5c <__text+0x2a3e5c>
1002abe98: 4ea81d00    	mov.16b	v0, v8
1002abe9c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1002abea0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1002abea4: a94257f6    	ldp	x22, x21, [sp, #0x20]
1002abea8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1002abeac: 6cc523e9    	ldp	d9, d8, [sp], #0x50
1002abeb0: d65f03c0    	ret
1002abeb4: d00f3928    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1002abeb8: f9436901    	ldr	x1, [x8, #0x6d0] ; selector: rowHeight
1002abebc: aa1303e0    	mov	x0, x19
1002abec0: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1002abec4: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1002abec8: a94257f6    	ldp	x22, x21, [sp, #0x20]
1002abecc: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1002abed0: 6cc523e9    	ldp	d9, d8, [sp], #0x50
1002abed4: 15e5ef64    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
