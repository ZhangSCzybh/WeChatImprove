
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1050a629c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1050a62a0: a9014ff4    	stp	x20, x19, [sp, #0x10]
1050a62a4: a9027bfd    	stp	x29, x30, [sp, #0x20]
1050a62a8: 910083fd    	add	x29, sp, #0x20
1050a62ac: 900ce368    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1050a62b0: f943c100    	ldr	x0, [x8, #0x780]
1050a62b4: f00cc908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1050a62b8: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1050a62bc: 94ae066a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a62c0: aa1d03fd    	mov	x29, x29
1050a62c4: 94ae066f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1050a62c8: aa0003f3    	mov	x19, x0
1050a62cc: d00ce368    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
1050a62d0: f9401500    	ldr	x0, [x8, #0x28]
1050a62d4: 900ce008    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1050a62d8: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
1050a62dc: 94ae0662    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a62e0: aa0003e2    	mov	x2, x0
1050a62e4: f00cc908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1050a62e8: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
1050a62ec: aa1303e0    	mov	x0, x19
1050a62f0: 94ae065d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a62f4: aa1d03fd    	mov	x29, x29
1050a62f8: 94ae0662    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1050a62fc: aa0003f4    	mov	x20, x0
1050a6300: b00cc968    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1050a6304: f9452d01    	ldr	x1, [x8, #0xa58] ; selector: getCurrentTimeMs
1050a6308: 94ae0657    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1050a630c: aa0003f5    	mov	x21, x0
1050a6310: aa1403e0    	mov	x0, x20
1050a6314: 94ae0657    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a6318: aa1303e0    	mov	x0, x19
1050a631c: 94ae0655    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1050a6320: aa1503e0    	mov	x0, x21
1050a6324: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1050a6328: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1050a632c: a8c357f6    	ldp	x22, x21, [sp], #0x30
1050a6330: d65f03c0    	ret
