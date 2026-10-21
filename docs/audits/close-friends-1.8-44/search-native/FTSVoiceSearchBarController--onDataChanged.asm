
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10182dfb0: d100c3ff    	sub	sp, sp, #0x30
10182dfb4: a9014ff4    	stp	x20, x19, [sp, #0x10]
10182dfb8: a9027bfd    	stp	x29, x30, [sp, #0x20]
10182dfbc: 910083fd    	add	x29, sp, #0x20
10182dfc0: aa0003f3    	mov	x19, x0
10182dfc4: d00f4a28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182dfc8: f9453500    	ldr	x0, [x8, #0xa68]
10182dfcc: 900f3068    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10182dfd0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10182dfd4: 900e6b68    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10182dfd8: 912ca108    	add	x8, x8, #0xb28
10182dfdc: f90003e8    	str	x8, [sp]
10182dfe0: f00cdd23    	adrp	x3, 0x11b3d4000 <dyld_stub_binder+0x11b3d4000>
10182dfe4: 91212063    	add	x3, x3, #0x848
10182dfe8: d00cde05    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10182dfec: 912160a5    	add	x5, x5, #0x858
10182dff0: f00cde07    	adrp	x7, 0x11b3f0000 <dyld_stub_binder+0x11b3f0000>
10182dff4: 910afce7    	add	x7, x7, #0x2bf
10182dff8: 52800042    	mov	w2, #0x2                ; =2
10182dffc: 52800004    	mov	w4, #0x0                ; =0
10182e000: 5280f806    	mov	w6, #0x7c0              ; =1984
10182e004: 958fe44e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182e008: b00f33e8    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182e00c: f945d901    	ldr	x1, [x8, #0xbb0] ; reloadSearchDataWithFromChanged
10182e010: aa1303e0    	mov	x0, x19
10182e014: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10182e018: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10182e01c: 9100c3ff    	add	sp, sp, #0x30
10182e020: 158fe447    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
