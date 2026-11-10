
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100177de0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100177de4: a9014ff4    	stp	x20, x19, [sp, #0x10]
100177de8: a9027bfd    	stp	x29, x30, [sp, #0x20]
100177dec: 910083fd    	add	x29, sp, #0x20
100177df0: aa0003f3    	mov	x19, x0
100177df4: d00f6028    	adrp	x8, 0x11ed7d000 <dyld_stub_binder+0x11ed7d000>
100177df8: b98b0108    	ldrsw	x8, [x8, #0xb00]
100177dfc: f8686800    	ldr	x0, [x0, x8]
100177e00: eb02001f    	cmp	x0, x2
100177e04: 540000a0    	b.eq	0x100177e18 <__text+0x16fe18>
100177e08: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100177e0c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100177e10: a8c357f6    	ldp	x22, x21, [sp], #0x30
100177e14: d65f03c0    	ret
100177e18: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177e1c: f9455d01    	ldr	x1, [x8, #0xab8]
100177e20: 95eabf91    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177e24: aa1d03fd    	mov	x29, x29
100177e28: 95eabf96    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100177e2c: aa0003f4    	mov	x20, x0
100177e30: b00f42c8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
100177e34: f9433101    	ldr	x1, [x8, #0x660]
100177e38: 95eabf8b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177e3c: aa1d03fd    	mov	x29, x29
100177e40: 95eabf90    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100177e44: aa0003f5    	mov	x21, x0
100177e48: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177e4c: f9456501    	ldr	x1, [x8, #0xac8]
100177e50: aa1303e0    	mov	x0, x19
100177e54: aa1503e2    	mov	x2, x21
100177e58: 95eabf83    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177e5c: aa1503e0    	mov	x0, x21
100177e60: 95eabf84    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177e64: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177e68: f9451501    	ldr	x1, [x8, #0xa28]
100177e6c: aa1303e0    	mov	x0, x19
100177e70: aa1403e2    	mov	x2, x20
100177e74: 52800003    	mov	w3, #0x0                ; =0
100177e78: 95eabf7b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177e7c: aa1403e0    	mov	x0, x20
100177e80: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100177e84: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100177e88: a8c357f6    	ldp	x22, x21, [sp], #0x30
100177e8c: 15eabf79    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
