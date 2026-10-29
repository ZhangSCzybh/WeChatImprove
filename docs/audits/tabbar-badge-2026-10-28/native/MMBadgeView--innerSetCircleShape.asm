
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167149c4: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
1167149c8: a9015ff8    	stp	x24, x23, [sp, #0x10]
1167149cc: a90257f6    	stp	x22, x21, [sp, #0x20]
1167149d0: a9034ff4    	stp	x20, x19, [sp, #0x30]
1167149d4: a9047bfd    	stp	x29, x30, [sp, #0x40]
1167149d8: 910103fd    	add	x29, sp, #0x40
1167149dc: aa0003f3    	mov	x19, x0
1167149e0: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
1167149e4: f942d514    	ldr	x20, [x8, #0x5a8] ; selector updateShape:
1167149e8: aa1403e1    	mov	x1, x20
1167149ec: 52800022    	mov	w2, #0x1                ; =1
1167149f0: 947054bf    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167149f4: 9004c208    	adrp	x8, 0x11ff54000 <dyld_stub_binder+0x11ff54000>
1167149f8: f940fd15    	ldr	x21, [x8, #0x1f8] ; selector badgeLabel
1167149fc: aa1303e0    	mov	x0, x19
116714a00: aa1503e1    	mov	x1, x21
116714a04: 947054ba    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714a08: aa1d03fd    	mov	x29, x29
116714a0c: 947054e2    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714a10: aa0003f6    	mov	x22, x0
116714a14: d004cf68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
116714a18: f9449d17    	ldr	x23, [x8, #0x938] ; selector height
116714a1c: aa1703e1    	mov	x1, x23
116714a20: 947054b3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714a24: 1e611001    	fmov	d1, #3.00000000
116714a28: 1e612808    	fadd	d8, d0, d1
116714a2c: aa1603e0    	mov	x0, x22
116714a30: 947054ca    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714a34: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116714a38: f942d901    	ldr	x1, [x8, #0x5b0] ; selector setRedDotImageWithDiameter:shouldStretch:
116714a3c: aa1303e0    	mov	x0, x19
116714a40: 1e604100    	fmov	d0, d8
116714a44: 52800002    	mov	w2, #0x0                ; =0
116714a48: 947054a9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714a4c: b004cfa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
116714a50: f9453d01    	ldr	x1, [x8, #0xa78] ; selector setSize:
116714a54: aa1303e0    	mov	x0, x19
116714a58: 1e604100    	fmov	d0, d8
116714a5c: 1e604101    	fmov	d1, d8
116714a60: 947054a3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714a64: f004cfa8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
116714a68: f947a501    	ldr	x1, [x8, #0xf48] ; selector width
116714a6c: aa1303e0    	mov	x0, x19
116714a70: 9470549f    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714a74: 1e6c1009    	fmov	d9, #0.50000000
116714a78: 1e690808    	fmul	d8, d0, d9
116714a7c: aa1303e0    	mov	x0, x19
116714a80: aa1703e1    	mov	x1, x23
116714a84: 9470549a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714a88: 1e690809    	fmul	d9, d0, d9
116714a8c: aa1303e0    	mov	x0, x19
116714a90: aa1503e1    	mov	x1, x21
116714a94: 94705496    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714a98: aa1d03fd    	mov	x29, x29
116714a9c: 947054be    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714aa0: aa0003f5    	mov	x21, x0
116714aa4: f004cf88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
116714aa8: f9425101    	ldr	x1, [x8, #0x4a0] ; selector setCenter:
116714aac: 1e604100    	fmov	d0, d8
116714ab0: 1e604121    	fmov	d1, d9
116714ab4: 9470548e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714ab8: aa1503e0    	mov	x0, x21
116714abc: 947054a7    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714ac0: aa1303e0    	mov	x0, x19
116714ac4: aa1403e1    	mov	x1, x20
116714ac8: 52800022    	mov	w2, #0x1                ; =1
116714acc: a9447bfd    	ldp	x29, x30, [sp, #0x40]
116714ad0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
116714ad4: a94257f6    	ldp	x22, x21, [sp, #0x20]
116714ad8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
116714adc: 6cc523e9    	ldp	d9, d8, [sp], #0x50
116714ae0: 14705483    	b	0x118329cec <dyld_stub_binder+0x118329cec>
