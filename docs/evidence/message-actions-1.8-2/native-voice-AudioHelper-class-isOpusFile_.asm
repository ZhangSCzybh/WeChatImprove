
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10016fd54: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10016fd58: a9014ff4    	stp	x20, x19, [sp, #0x10]
10016fd5c: a9027bfd    	stp	x29, x30, [sp, #0x20]
10016fd60: 910083fd    	add	x29, sp, #0x20
10016fd64: aa0203f3    	mov	x19, x2
10016fd68: aa0203e0    	mov	x0, x2
10016fd6c: 95eadcf3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10016fd70: 900ffca8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10016fd74: f946e914    	ldr	x20, [x8, #0xdd0] ; length
10016fd78: aa1303e0    	mov	x0, x19
10016fd7c: aa1403e1    	mov	x1, x20
10016fd80: 95eadcef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10016fd84: f100401f    	cmp	x0, #0x10
10016fd88: 54000062    	b.hs	0x10016fd94 <__text+0x167d94>
10016fd8c: 52800014    	mov	w20, #0x0               ; =0
10016fd90: 1400001e    	b	0x10016fe08 <__text+0x167e08>
10016fd94: b00ffc88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10016fd98: f945d901    	ldr	x1, [x8, #0xbb0] ; dataUsingEncoding:
10016fd9c: d00f19e0    	adrp	x0, 0x11e4ad000 <dyld_stub_binder+0x11e4ad000>
10016fda0: 9119a000    	add	x0, x0, #0x668
10016fda4: 52800022    	mov	w2, #0x1                ; =1
10016fda8: 95eadce5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10016fdac: aa1d03fd    	mov	x29, x29
10016fdb0: 95eadce6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10016fdb4: aa0003f5    	mov	x21, x0
10016fdb8: aa1403e1    	mov	x1, x20
10016fdbc: 95eadce0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10016fdc0: aa0003e3    	mov	x3, x0
10016fdc4: f00ffcc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10016fdc8: f9470d01    	ldr	x1, [x8, #0xe18] ; subdataWithRange:
10016fdcc: aa1303e0    	mov	x0, x19
10016fdd0: d2800002    	mov	x2, #0x0                ; =0
10016fdd4: 95eadcda    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10016fdd8: aa1d03fd    	mov	x29, x29
10016fddc: 95eadcdb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10016fde0: aa0003f6    	mov	x22, x0
10016fde4: d00fe648    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10016fde8: f9467501    	ldr	x1, [x8, #0xce8] ; isEqualToData:
10016fdec: aa1503e2    	mov	x2, x21
10016fdf0: 95eadcd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10016fdf4: aa0003f4    	mov	x20, x0
10016fdf8: aa1603e0    	mov	x0, x22
10016fdfc: 95eadcd6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10016fe00: aa1503e0    	mov	x0, x21
10016fe04: 95eadcd4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10016fe08: aa1303e0    	mov	x0, x19
10016fe0c: 95eadcd2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10016fe10: aa1403e0    	mov	x0, x20
10016fe14: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10016fe18: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10016fe1c: a8c357f6    	ldp	x22, x21, [sp], #0x30
10016fe20: d65f03c0    	ret
