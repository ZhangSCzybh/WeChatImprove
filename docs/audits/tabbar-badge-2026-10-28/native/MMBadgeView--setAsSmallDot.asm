
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116714e60: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
116714e64: a9017bfd    	stp	x29, x30, [sp, #0x10]
116714e68: 910043fd    	add	x29, sp, #0x10
116714e6c: aa0003f3    	mov	x19, x0
116714e70: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116714e74: f942d501    	ldr	x1, [x8, #0x5a8] ; selector updateShape:
116714e78: d2800002    	mov	x2, #0x0                ; =0
116714e7c: 9470539c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714e80: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116714e84: f942e501    	ldr	x1, [x8, #0x5c8] ; selector setCircleDotWithDiameter:
116714e88: 1e641000    	fmov	d0, #8.00000000
116714e8c: aa1303e0    	mov	x0, x19
116714e90: a9417bfd    	ldp	x29, x30, [sp, #0x10]
116714e94: a8c24ff4    	ldp	x20, x19, [sp], #0x20
116714e98: 14705395    	b	0x118329cec <dyld_stub_binder+0x118329cec>
