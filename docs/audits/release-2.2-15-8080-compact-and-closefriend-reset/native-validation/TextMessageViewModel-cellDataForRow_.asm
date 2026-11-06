
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105f0f3ac: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105f0f3b0: a9014ff4    	stp	x20, x19, [sp, #0x10]
105f0f3b4: a9027bfd    	stp	x29, x30, [sp, #0x20]
105f0f3b8: 910083fd    	add	x29, sp, #0x20
105f0f3bc: aa0203f4    	mov	x20, x2
105f0f3c0: aa0003f3    	mov	x19, x0
105f0f3c4: d00c6268    	adrp	x8, 0x11eb5d000 <dyld_stub_binder+0x11eb5d000>
105f0f3c8: f9442901    	ldr	x1, [x8, #0x850]
105f0f3cc: 94746226    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105f0f3d0: 34000240    	cbz	w0, 0x105f0f418 <_Flutter_MMFoundation_BindContext+0x21960e4>
105f0f3d4: 900c5668    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
105f0f3d8: f9414901    	ldr	x1, [x8, #0x290]
105f0f3dc: aa1303e0    	mov	x0, x19
105f0f3e0: 94746221    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105f0f3e4: aa1d03fd    	mov	x29, x29
105f0f3e8: 94746226    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105f0f3ec: aa0003f5    	mov	x21, x0
105f0f3f0: f00c55c8    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
105f0f3f4: f941b101    	ldr	x1, [x8, #0x360]
105f0f3f8: aa1403e2    	mov	x2, x20
105f0f3fc: 9474621a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105f0f400: aa1d03fd    	mov	x29, x29
105f0f404: 9474621f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105f0f408: aa0003f3    	mov	x19, x0
105f0f40c: aa1503e0    	mov	x0, x21
105f0f410: 94746218    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105f0f414: 14000003    	b	0x105f0f420 <_Flutter_MMFoundation_BindContext+0x21960ec>
105f0f418: aa1303e0    	mov	x0, x19
105f0f41c: 94746216    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105f0f420: aa1303e0    	mov	x0, x19
105f0f424: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105f0f428: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105f0f42c: a8c357f6    	ldp	x22, x21, [sp], #0x30
105f0f430: 147461fc    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
