
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104521c2c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104521c30: a9017bfd    	stp	x29, x30, [sp, #0x10]
104521c34: 910043fd    	add	x29, sp, #0x10
104521c38: aa0003f3    	mov	x19, x0
104521c3c: d00dce88    	adrp	x8, 0x11fef3000 <dyld_stub_binder+0x11fef3000>
104521c40: f945e101    	ldr	x1, [x8, #0xbc0] ; selector checkLoadData
104521c44: 94dc153e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104521c48: 900de7e8    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
104521c4c: b9873d08    	ldrsw	x8, [x8, #0x73c]
104521c50: b8686a60    	ldr	w0, [x19, x8]
104521c54: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104521c58: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104521c5c: d65f03c0    	ret
