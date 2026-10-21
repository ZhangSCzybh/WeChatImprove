
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ff8e20: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104ff8e24: a9017bfd    	stp	x29, x30, [sp, #0x10]
104ff8e28: 910043fd    	add	x29, sp, #0x10
104ff8e2c: aa0203e0    	mov	x0, x2
104ff8e30: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8e34: f9473101    	ldr	x1, [x8, #0xe60] ; currentAction
104ff8e38: 94b0b8c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8e3c: aa1d03fd    	mov	x29, x29
104ff8e40: 94b0b8c2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff8e44: aa0003f3    	mov	x19, x0
104ff8e48: f00d8888    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104ff8e4c: f941c901    	ldr	x1, [x8, #0x390] ; type
104ff8e50: 94b0b8bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8e54: 7100101f    	cmp	w0, #0x4
104ff8e58: 1a9f17f4    	cset	w20, eq
104ff8e5c: aa1303e0    	mov	x0, x19
104ff8e60: 94b0b8bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8e64: aa1403e0    	mov	x0, x20
104ff8e68: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104ff8e6c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104ff8e70: d65f03c0    	ret
