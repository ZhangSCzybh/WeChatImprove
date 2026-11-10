
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100177d30: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100177d34: a9014ff4    	stp	x20, x19, [sp, #0x10]
100177d38: a9027bfd    	stp	x29, x30, [sp, #0x20]
100177d3c: 910083fd    	add	x29, sp, #0x20
100177d40: aa0003f3    	mov	x19, x0
100177d44: d00f6028    	adrp	x8, 0x11ed7d000 <dyld_stub_binder+0x11ed7d000>
100177d48: b98b0108    	ldrsw	x8, [x8, #0xb00]
100177d4c: f8686800    	ldr	x0, [x0, x8]
100177d50: eb02001f    	cmp	x0, x2
100177d54: 540000a0    	b.eq	0x100177d68 <__text+0x16fd68>
100177d58: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100177d5c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100177d60: a8c357f6    	ldp	x22, x21, [sp], #0x30
100177d64: d65f03c0    	ret
100177d68: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177d6c: f9455d01    	ldr	x1, [x8, #0xab8]
100177d70: 95eabfbd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177d74: aa1d03fd    	mov	x29, x29
100177d78: 95eabfc2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100177d7c: aa0003f4    	mov	x20, x0
100177d80: b00f42c8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
100177d84: f9433101    	ldr	x1, [x8, #0x660]
100177d88: 95eabfb7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177d8c: aa1d03fd    	mov	x29, x29
100177d90: 95eabfbc    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100177d94: aa0003f5    	mov	x21, x0
100177d98: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177d9c: f9456501    	ldr	x1, [x8, #0xac8]
100177da0: aa1303e0    	mov	x0, x19
100177da4: aa1503e2    	mov	x2, x21
100177da8: 95eabfaf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177dac: aa1503e0    	mov	x0, x21
100177db0: 95eabfb0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177db4: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177db8: f9451501    	ldr	x1, [x8, #0xa28]
100177dbc: aa1303e0    	mov	x0, x19
100177dc0: aa1403e2    	mov	x2, x20
100177dc4: 52800023    	mov	w3, #0x1                ; =1
100177dc8: 95eabfa7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177dcc: aa1403e0    	mov	x0, x20
100177dd0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100177dd4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100177dd8: a8c357f6    	ldp	x22, x21, [sp], #0x30
100177ddc: 15eabfa5    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
