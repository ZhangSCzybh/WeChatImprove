
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
103dd73f4: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
103dd73f8: a9017bfd    	stp	x29, x30, [sp, #0x10]
103dd73fc: 910043fd    	add	x29, sp, #0x10
103dd7400: aa0203f3    	mov	x19, x2
103dd7404: aa0003f4    	mov	x20, x0
103dd7408: b00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd740c: b98fa508    	ldrsw	x8, [x8, #0xfa4] ; ivar: MMHeadImageView._borderImage offset=40
103dd7410: 8b080000    	add	x0, x0, x8
103dd7414: aa0203e1    	mov	x1, x2
103dd7418: 94f94221    	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
103dd741c: aa1303e0    	mov	x0, x19
103dd7420: 94f94215    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
103dd7424: b00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd7428: b98f8908    	ldrsw	x8, [x8, #0xf88] ; ivar: MMHeadImageView._borderImageView offset=8
103dd742c: f8686a80    	ldr	x0, [x20, x8]
103dd7430: 900d76a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
103dd7434: f945c501    	ldr	x1, [x8, #0xb88] ; selector: setImage:
103dd7438: aa1303e2    	mov	x2, x19
103dd743c: 94f9420a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd7440: aa1303e0    	mov	x0, x19
103dd7444: a9417bfd    	ldp	x29, x30, [sp, #0x10]
103dd7448: a8c24ff4    	ldp	x20, x19, [sp], #0x20
103dd744c: 14f94209    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
103dd7450: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
103dd7454: a9017bfd    	stp	x29, x30, [sp, #0x10]
103dd7458: 910043fd    	add	x29, sp, #0x10
103dd745c: aa0203f3    	mov	x19, x2
103dd7460: aa0003f4    	mov	x20, x0
103dd7464: b00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd7468: b98fa908    	ldrsw	x8, [x8, #0xfa8] ; ivar: MMHeadImageView._borderImageHL offset=48
103dd746c: 8b080000    	add	x0, x0, x8
103dd7470: aa0203e1    	mov	x1, x2
103dd7474: 94f9420a    	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
103dd7478: aa1303e0    	mov	x0, x19
103dd747c: 94f941fe    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
103dd7480: b00d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd7484: b98f8908    	ldrsw	x8, [x8, #0xf88] ; ivar: MMHeadImageView._borderImageView offset=8
103dd7488: f8686a80    	ldr	x0, [x20, x8]
103dd748c: 900d76a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
103dd7490: f9459901    	ldr	x1, [x8, #0xb30] ; selector: setHighlightedImage:
103dd7494: aa1303e2    	mov	x2, x19
103dd7498: 94f941f3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
103dd749c: aa1303e0    	mov	x0, x19
103dd74a0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
103dd74a4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
103dd74a8: 14f941f2    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
