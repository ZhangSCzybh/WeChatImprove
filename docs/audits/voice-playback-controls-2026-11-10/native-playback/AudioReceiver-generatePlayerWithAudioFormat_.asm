
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100176b90: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
100176b94: 910003fd    	mov	x29, sp
100176b98: d00f5ce8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
100176b9c: 9102a108    	add	x8, x8, #0xa8
100176ba0: d00f5ce9    	adrp	x9, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
100176ba4: 9102e129    	add	x9, x9, #0xb8
100176ba8: 7100105f    	cmp	w2, #0x4
100176bac: d00f5cea    	adrp	x10, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
100176bb0: 9103014a    	add	x10, x10, #0xc0
100176bb4: d00f5ceb    	adrp	x11, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
100176bb8: 9102c16b    	add	x11, x11, #0xb0
100176bbc: 9a8b114a    	csel	x10, x10, x11, ne
100176bc0: 71001c5f    	cmp	w2, #0x7
100176bc4: 9a8a0129    	csel	x9, x9, x10, eq
100176bc8: 7100005f    	cmp	w2, #0x0
100176bcc: 9a890108    	csel	x8, x8, x9, eq
100176bd0: f9400100    	ldr	x0, [x8]
100176bd4: 95eac40e    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
100176bd8: a8c17bfd    	ldp	x29, x30, [sp], #0x10
100176bdc: 15eac411    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
