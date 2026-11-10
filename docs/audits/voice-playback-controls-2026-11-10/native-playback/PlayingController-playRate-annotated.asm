
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10565c6a4: 6dbd23e9    	stp	d9, d8, [sp, #-0x30]!
10565c6a8: a9014ff4    	stp	x20, x19, [sp, #0x10]
10565c6ac: a9027bfd    	stp	x29, x30, [sp, #0x20]
10565c6b0: 910083fd    	add	x29, sp, #0x20
10565c6b4: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565c6b8: f943c100    	ldr	x0, [x8, #0x780]
10565c6bc: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565c6c0: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10565c6c4: 94972d68    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c6c8: aa1d03fd    	mov	x29, x29
10565c6cc: 94972d6d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c6d0: aa0003f3    	mov	x19, x0
10565c6d4: 900cb5c8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10565c6d8: f9401500    	ldr	x0, [x8, #0x28]
10565c6dc: d00cb248    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10565c6e0: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10565c6e4: 94972d60    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c6e8: aa0003e2    	mov	x2, x0
10565c6ec: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565c6f0: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10565c6f4: aa1303e0    	mov	x0, x19
10565c6f8: 94972d5b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c6fc: aa1d03fd    	mov	x29, x29
10565c700: 94972d60    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c704: aa0003f4    	mov	x20, x0
10565c708: f00c9ba8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10565c70c: f9453501    	ldr	x1, [x8, #0xa68] ; selector: playRate
10565c710: 94972d55    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c714: 4ea01c08    	mov.16b	v8, v0
10565c718: aa1403e0    	mov	x0, x20
10565c71c: 94972d55    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c720: aa1303e0    	mov	x0, x19
10565c724: 94972d53    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c728: 4ea81d00    	mov.16b	v0, v8
10565c72c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10565c730: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10565c734: 6cc323e9    	ldp	d9, d8, [sp], #0x30
10565c738: d65f03c0    	ret
