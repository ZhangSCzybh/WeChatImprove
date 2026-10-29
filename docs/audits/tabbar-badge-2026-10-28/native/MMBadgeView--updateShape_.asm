
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167146b8: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1167146bc: a90157f6    	stp	x22, x21, [sp, #0x10]
1167146c0: a9024ff4    	stp	x20, x19, [sp, #0x20]
1167146c4: a9037bfd    	stp	x29, x30, [sp, #0x30]
1167146c8: 9100c3fd    	add	x29, sp, #0x30
1167146cc: aa0203f3    	mov	x19, x2
1167146d0: aa0003f5    	mov	x21, x0
1167146d4: 9004c0a8    	adrp	x8, 0x11ff28000 <dyld_stub_binder+0x11ff28000>
1167146d8: f9417101    	ldr	x1, [x8, #0x2e0] ; selector shape
1167146dc: 94705584    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167146e0: aa0003f4    	mov	x20, x0
1167146e4: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
1167146e8: f942c101    	ldr	x1, [x8, #0x580] ; selector setShape:
1167146ec: aa1503e0    	mov	x0, x21
1167146f0: aa1303e2    	mov	x2, x19
1167146f4: 9470557e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167146f8: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
1167146fc: f942c516    	ldr	x22, [x8, #0x588] ; selector shapeChangeBlock
116714700: aa1503e0    	mov	x0, x21
116714704: aa1603e1    	mov	x1, x22
116714708: 94705579    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11671470c: aa1d03fd    	mov	x29, x29
116714710: 947055a1    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714714: aa0003f7    	mov	x23, x0
116714718: 94705590    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11671471c: b4000237    	cbz	x23, 0x116714760 <_O266DecReleaseOutputPicture+0x3487ca8>
116714720: aa1503e0    	mov	x0, x21
116714724: aa1603e1    	mov	x1, x22
116714728: 94705571    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11671472c: aa1d03fd    	mov	x29, x29
116714730: 94705599    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714734: aa0003f5    	mov	x21, x0
116714738: f9400808    	ldr	x8, [x0, #0x10]
11671473c: aa1403e1    	mov	x1, x20
116714740: aa1303e2    	mov	x2, x19
116714744: d63f0100    	blr	x8
116714748: aa1503e0    	mov	x0, x21
11671474c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
116714750: a9424ff4    	ldp	x20, x19, [sp, #0x20]
116714754: a94157f6    	ldp	x22, x21, [sp, #0x10]
116714758: a8c45ff8    	ldp	x24, x23, [sp], #0x40
11671475c: 1470557f    	b	0x118329d58 <dyld_stub_binder+0x118329d58>
116714760: a9437bfd    	ldp	x29, x30, [sp, #0x30]
116714764: a9424ff4    	ldp	x20, x19, [sp, #0x20]
116714768: a94157f6    	ldp	x22, x21, [sp, #0x10]
11671476c: a8c45ff8    	ldp	x24, x23, [sp], #0x40
116714770: d65f03c0    	ret
