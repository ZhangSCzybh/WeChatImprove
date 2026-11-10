
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100177238: d100c3ff    	sub	sp, sp, #0x30
10017723c: a9014ff4    	stp	x20, x19, [sp, #0x10]
100177240: a9027bfd    	stp	x29, x30, [sp, #0x20]
100177244: 910083fd    	add	x29, sp, #0x20
100177248: d00f6028    	adrp	x8, 0x11ed7d000 <dyld_stub_binder+0x11ed7d000>
10017724c: b98b0108    	ldrsw	x8, [x8, #0xb00]
100177250: f8686813    	ldr	x19, [x0, x8]
100177254: b40000d3    	cbz	x19, 0x10017726c <__text+0x16f26c>
100177258: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10017725c: f944e901    	ldr	x1, [x8, #0x9d0]
100177260: aa1303e0    	mov	x0, x19
100177264: 95eac280    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177268: 14000011    	b	0x1001772ac <__text+0x16f2ac>
10017726c: f00f5cc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100177270: f9430d00    	ldr	x0, [x8, #0x618]
100177274: d00f4288    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100177278: f9418901    	ldr	x1, [x8, #0x310]
10017727c: f00e71a8    	adrp	x8, 0x11cfae000 <dyld_stub_binder+0x11cfae000>
100177280: 9131e108    	add	x8, x8, #0xc78
100177284: f90003e8    	str	x8, [sp]
100177288: b00cd185    	adrp	x5, 0x119ba8000 <dyld_stub_binder+0x119ba8000>
10017728c: 910924a5    	add	x5, x5, #0x249
100177290: b00cd187    	adrp	x7, 0x119ba8000 <dyld_stub_binder+0x119ba8000>
100177294: 910d14e7    	add	x7, x7, #0x345
100177298: 52800042    	mov	w2, #0x2                ; =2
10017729c: d2800003    	mov	x3, #0x0                ; =0
1001772a0: 52800004    	mov	w4, #0x0                ; =0
1001772a4: 52801186    	mov	w6, #0x8c               ; =140
1001772a8: 95eac26f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1001772ac: f100027f    	cmp	x19, #0x0
1001772b0: 1a9f07e0    	cset	w0, ne
1001772b4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1001772b8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1001772bc: 9100c3ff    	add	sp, sp, #0x30
1001772c0: d65f03c0    	ret
