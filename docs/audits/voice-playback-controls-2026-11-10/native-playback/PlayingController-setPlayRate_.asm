
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10565c5f8: 900cbb88    	adrp	x8, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565c5fc: b9880508    	ldrsw	x8, [x8, #0x804]
10565c600: 38686808    	ldrb	w8, [x0, x8]
10565c604: 7100051f    	cmp	w8, #0x1
10565c608: 540004c1    	b.ne	0x10565c6a0 <_Flutter_MMFoundation_BindContext+0x18e336c>
10565c60c: 6dbd23e9    	stp	d9, d8, [sp, #-0x30]!
10565c610: a9014ff4    	stp	x20, x19, [sp, #0x10]
10565c614: a9027bfd    	stp	x29, x30, [sp, #0x20]
10565c618: 910083fd    	add	x29, sp, #0x20
10565c61c: 4ea01c08    	mov.16b	v8, v0
10565c620: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565c624: f943c100    	ldr	x0, [x8, #0x780]
10565c628: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565c62c: f9440101    	ldr	x1, [x8, #0x800]
10565c630: 94972d8d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c634: aa1d03fd    	mov	x29, x29
10565c638: 94972d92    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c63c: aa0003f3    	mov	x19, x0
10565c640: 900cb5c8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10565c644: f9401500    	ldr	x0, [x8, #0x28]
10565c648: d00cb248    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10565c64c: f9428501    	ldr	x1, [x8, #0x508]
10565c650: 94972d85    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c654: aa0003e2    	mov	x2, x0
10565c658: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565c65c: f9452101    	ldr	x1, [x8, #0xa40]
10565c660: aa1303e0    	mov	x0, x19
10565c664: 94972d80    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c668: aa1d03fd    	mov	x29, x29
10565c66c: 94972d85    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c670: aa0003f4    	mov	x20, x0
10565c674: f00c9ba8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10565c678: f9453101    	ldr	x1, [x8, #0xa60]
10565c67c: 4ea81d00    	mov.16b	v0, v8
10565c680: 94972d79    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c684: aa1403e0    	mov	x0, x20
10565c688: 94972d7a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c68c: aa1303e0    	mov	x0, x19
10565c690: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10565c694: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10565c698: 6cc323e9    	ldp	d9, d8, [sp], #0x30
10565c69c: 14972d75    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c6a0: d65f03c0    	ret
