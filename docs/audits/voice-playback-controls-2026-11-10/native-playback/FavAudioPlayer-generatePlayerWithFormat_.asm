
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a18070: 34000162    	cbz	w2, 0x101a1809c <__text+0x1a1009c>
101a18074: 7100105f    	cmp	w2, #0x4
101a18078: 540000c0    	b.eq	0x101a18090 <__text+0x1a10090>
101a1807c: 7100045f    	cmp	w2, #0x1
101a18080: 540001e1    	b.ne	0x101a180bc <__text+0x1a100bc>
101a18084: 900e97e8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101a18088: 91030108    	add	x8, x8, #0xc0
101a1808c: 14000006    	b	0x101a180a4 <__text+0x1a100a4>
101a18090: 900e97e8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101a18094: 9102c108    	add	x8, x8, #0xb0
101a18098: 14000003    	b	0x101a180a4 <__text+0x1a100a4>
101a1809c: 900e97e8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101a180a0: 9102a108    	add	x8, x8, #0xa8
101a180a4: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
101a180a8: 910003fd    	mov	x29, sp
101a180ac: f9400100    	ldr	x0, [x8]
101a180b0: 95883ed7    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
101a180b4: a8c17bfd    	ldp	x29, x30, [sp], #0x10
101a180b8: 15883eda    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
101a180bc: d2800000    	mov	x0, #0x0                ; =0
101a180c0: 15883ed8    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
