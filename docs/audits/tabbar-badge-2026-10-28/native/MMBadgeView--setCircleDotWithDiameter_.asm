
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116714ee8: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
116714eec: a90157f6    	stp	x22, x21, [sp, #0x10]
116714ef0: a9024ff4    	stp	x20, x19, [sp, #0x20]
116714ef4: a9037bfd    	stp	x29, x30, [sp, #0x30]
116714ef8: 9100c3fd    	add	x29, sp, #0x30
116714efc: 1e604008    	fmov	d8, d0
116714f00: aa0003f3    	mov	x19, x0
116714f04: 9004c208    	adrp	x8, 0x11ff54000 <dyld_stub_binder+0x11ff54000>
116714f08: f940fd14    	ldr	x20, [x8, #0x1f8] ; selector badgeLabel
116714f0c: aa1403e1    	mov	x1, x20
116714f10: 94705377    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714f14: aa1d03fd    	mov	x29, x29
116714f18: 9470539f    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714f1c: aa0003f5    	mov	x21, x0
116714f20: 9004cfa8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
116714f24: f9411101    	ldr	x1, [x8, #0x220] ; selector setHidden:
116714f28: 52800022    	mov	w2, #0x1                ; =1
116714f2c: 94705370    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714f30: aa1503e0    	mov	x0, x21
116714f34: 94705389    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714f38: aa1303e0    	mov	x0, x19
116714f3c: aa1403e1    	mov	x1, x20
116714f40: 9470536b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714f44: aa1d03fd    	mov	x29, x29
116714f48: 94705393    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714f4c: aa0003f4    	mov	x20, x0
116714f50: b004cfa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
116714f54: f9468d01    	ldr	x1, [x8, #0xd18] ; selector setText:
116714f58: d2800002    	mov	x2, #0x0                ; =0
116714f5c: 94705364    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714f60: aa1403e0    	mov	x0, x20
116714f64: 9470537d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714f68: f004d2e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
116714f6c: f9461900    	ldr	x0, [x8, #0xc30] ; class UIFont
116714f70: b004b928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
116714f74: f9463101    	ldr	x1, [x8, #0xc60] ; selector dynamicLength:
116714f78: 1e604100    	fmov	d0, d8
116714f7c: 9470535c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714f80: 1e604008    	fmov	d8, d0
116714f84: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116714f88: f942d901    	ldr	x1, [x8, #0x5b0] ; selector setRedDotImageWithDiameter:shouldStretch:
116714f8c: aa1303e0    	mov	x0, x19
116714f90: 52800002    	mov	w2, #0x0                ; =0
116714f94: 94705356    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714f98: b004cfa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
116714f9c: f9453d01    	ldr	x1, [x8, #0xa78] ; selector setSize:
116714fa0: aa1303e0    	mov	x0, x19
116714fa4: 1e604100    	fmov	d0, d8
116714fa8: 1e604101    	fmov	d1, d8
116714fac: a9437bfd    	ldp	x29, x30, [sp, #0x30]
116714fb0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
116714fb4: a94157f6    	ldp	x22, x21, [sp, #0x10]
116714fb8: 6cc423e9    	ldp	d9, d8, [sp], #0x40
116714fbc: 1470534c    	b	0x118329cec <dyld_stub_binder+0x118329cec>
