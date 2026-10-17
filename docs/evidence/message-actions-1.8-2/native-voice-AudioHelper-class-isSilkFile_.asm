
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10016fc84: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10016fc88: a9014ff4    	stp	x20, x19, [sp, #0x10]
10016fc8c: a9027bfd    	stp	x29, x30, [sp, #0x20]
10016fc90: 910083fd    	add	x29, sp, #0x20
10016fc94: aa0203f3    	mov	x19, x2
10016fc98: aa0203e0    	mov	x0, x2
10016fc9c: 95eadd27    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10016fca0: 900ffca8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10016fca4: f946e914    	ldr	x20, [x8, #0xdd0] ; length
10016fca8: aa1303e0    	mov	x0, x19
10016fcac: aa1403e1    	mov	x1, x20
10016fcb0: 95eadd23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10016fcb4: f1001c1f    	cmp	x0, #0x7
10016fcb8: 54000062    	b.hs	0x10016fcc4 <__text+0x167cc4>
10016fcbc: 52800014    	mov	w20, #0x0               ; =0
10016fcc0: 1400001e    	b	0x10016fd38 <__text+0x167d38>
10016fcc4: b00ffc88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10016fcc8: f945d901    	ldr	x1, [x8, #0xbb0] ; dataUsingEncoding:
10016fccc: d00f19e0    	adrp	x0, 0x11e4ad000 <dyld_stub_binder+0x11e4ad000>
10016fcd0: 91192000    	add	x0, x0, #0x648
10016fcd4: 52800022    	mov	w2, #0x1                ; =1
10016fcd8: 95eadd19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10016fcdc: aa1d03fd    	mov	x29, x29
10016fce0: 95eadd1a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10016fce4: aa0003f5    	mov	x21, x0
10016fce8: aa1403e1    	mov	x1, x20
10016fcec: 95eadd14    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10016fcf0: aa0003e3    	mov	x3, x0
10016fcf4: f00ffcc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10016fcf8: f9470d01    	ldr	x1, [x8, #0xe18] ; subdataWithRange:
10016fcfc: aa1303e0    	mov	x0, x19
10016fd00: 52800022    	mov	w2, #0x1                ; =1
10016fd04: 95eadd0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10016fd08: aa1d03fd    	mov	x29, x29
10016fd0c: 95eadd0f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10016fd10: aa0003f6    	mov	x22, x0
10016fd14: d00fe648    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10016fd18: f9467501    	ldr	x1, [x8, #0xce8] ; isEqualToData:
10016fd1c: aa1503e2    	mov	x2, x21
10016fd20: 95eadd07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10016fd24: aa0003f4    	mov	x20, x0
10016fd28: aa1603e0    	mov	x0, x22
10016fd2c: 95eadd0a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10016fd30: aa1503e0    	mov	x0, x21
10016fd34: 95eadd08    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10016fd38: aa1303e0    	mov	x0, x19
10016fd3c: 95eadd06    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10016fd40: aa1403e0    	mov	x0, x20
10016fd44: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10016fd48: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10016fd4c: a8c357f6    	ldp	x22, x21, [sp], #0x30
10016fd50: d65f03c0    	ret
