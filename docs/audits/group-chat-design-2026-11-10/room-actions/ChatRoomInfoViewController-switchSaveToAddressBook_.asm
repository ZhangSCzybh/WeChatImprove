
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f8d53c:     	stp	x22, x21, [sp, #-0x30]!
100f8d540:     	stp	x20, x19, [sp, #0x10]
100f8d544:     	stp	x29, x30, [sp, #0x20]
100f8d548:     	add	x29, sp, #0x20
100f8d54c:     	mov	x19, x2
100f8d550:     	mov	x22, x0
100f8d554:     	mov	x0, x2
100f8d558:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100f8d55c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100f8d560:     	ldr	x20, [x8, #0xfb0]
100f8d564:     	mov	x0, x19
100f8d568:     	mov	x1, x20
100f8d56c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f8d570:     	adrp	x8, 0x11ed88000 <dyld_stub_binder+0x11ed88000>
100f8d574:     	ldrsw	x8, [x8, #0xfd0]
100f8d578:     	strb	w0, [x22, x8]
100f8d57c:     	adrp	x8, 0x11ed88000 <dyld_stub_binder+0x11ed88000>
100f8d580:     	ldrsw	x8, [x8, #0xfc0]
100f8d584:     	ldr	x21, [x22, x8]
100f8d588:     	cbz	x21, 0x100f8d5e0 <__text+0xf855e0>
100f8d58c:     	adrp	x8, 0x11ed88000 <dyld_stub_binder+0x11ed88000>
100f8d590:     	ldrsw	x8, [x8, #0xfb8]
100f8d594:     	ldr	x0, [x22, x8]
100f8d598:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100f8d59c:     	ldr	x1, [x8, #0x620]
100f8d5a0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f8d5a4:     	mov	x29, x29
100f8d5a8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f8d5ac:     	mov	x22, x0
100f8d5b0:     	mov	x0, x19
100f8d5b4:     	mov	x1, x20
100f8d5b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f8d5bc:     	mov	x4, x0
100f8d5c0:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100f8d5c4:     	ldr	x1, [x8, #0xdb8]
100f8d5c8:     	mov	x0, x21
100f8d5cc:     	mov	x2, x22
100f8d5d0:     	mov	w3, #0x3                ; =3
100f8d5d4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f8d5d8:     	mov	x0, x22
100f8d5dc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f8d5e0:     	mov	x0, x19
100f8d5e4:     	ldp	x29, x30, [sp, #0x20]
100f8d5e8:     	ldp	x20, x19, [sp, #0x10]
100f8d5ec:     	ldp	x22, x21, [sp], #0x30
100f8d5f0:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
