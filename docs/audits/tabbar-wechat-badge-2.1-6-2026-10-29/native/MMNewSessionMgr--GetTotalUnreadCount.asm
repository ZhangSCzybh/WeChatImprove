
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104521bf8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104521bfc: a9017bfd    	stp	x29, x30, [sp, #0x10]
104521c00: 910043fd    	add	x29, sp, #0x10
104521c04: aa0003f3    	mov	x19, x0
104521c08: d00dce88    	adrp	x8, 0x11fef3000 <dyld_stub_binder+0x11fef3000>
104521c0c: f945e101    	ldr	x1, [x8, #0xbc0] ; selector checkLoadData
104521c10: 94dc154b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104521c14: 900de7e8    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
104521c18: b9873908    	ldrsw	x8, [x8, #0x738]
104521c1c: b8686a60    	ldr	w0, [x19, x8]
104521c20: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104521c24: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104521c28: d65f03c0    	ret
