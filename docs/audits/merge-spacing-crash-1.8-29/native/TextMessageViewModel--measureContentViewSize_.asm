
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c0c4b4: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
105c0c4b8: 910003fd    	mov	x29, sp
105c0c4bc: b00d2ee8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
105c0c4c0: 9113c108    	add	x8, x8, #0x4f0
105c0c4c4: b9800108    	ldrsw	x8, [x8]
105c0c4c8: 52800189    	mov	w9, #0xc                ; =12
105c0c4cc: f8286809    	str	x9, [x0, x8]
105c0c4d0: b00d1288    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
105c0c4d4: f9422501    	ldr	x1, [x8, #0x448] ; contentHeight
105c0c4d8: 94806b19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0c4dc: 1e604001    	fmov	d1, d0
105c0c4e0: 9e6703e0    	fmov	d0, xzr
105c0c4e4: a8c17bfd    	ldp	x29, x30, [sp], #0x10
105c0c4e8: d65f03c0    	ret