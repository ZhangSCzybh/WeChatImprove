
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106277ca0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106277ca4: a9014ff4    	stp	x20, x19, [sp, #0x10]
106277ca8: a9027bfd    	stp	x29, x30, [sp, #0x20]
106277cac: 910083fd    	add	x29, sp, #0x20
106277cb0: aa0003f3    	mov	x19, x0
106277cb4: b00cfe08    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
106277cb8: b98d4d15    	ldrsw	x21, [x8, #0xd4c]
106277cbc: f8756808    	ldr	x8, [x0, x21]
106277cc0: b50001c8    	cbnz	x8, 0x106277cf8 <_Flutter_MMFoundation_BindContext+0x27538dc>
106277cc4: 900cf7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106277cc8: f9462500    	ldr	x0, [x8, #0xc48] ; �9c 
106277ccc: 9466bd23    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
106277cd0: f8756a68    	ldr	x8, [x19, x21]
106277cd4: f8356a60    	str	x0, [x19, x21]
106277cd8: aa0803e0    	mov	x0, x8
106277cdc: 9466bd1e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106277ce0: f8756a60    	ldr	x0, [x19, x21]
106277ce4: d00cf488    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
106277ce8: f944c101    	ldr	x1, [x8, #0x980] ; setShadowOffset:
106277cec: 9e6703e0    	fmov	d0, xzr
106277cf0: 1e6e1001    	fmov	d1, #1.00000000
106277cf4: 9466bd12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277cf8: 900cf7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106277cfc: f9461900    	ldr	x0, [x8, #0xc30]
106277d00: d00cde08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106277d04: f9464d01    	ldr	x1, [x8, #0xc98] ; dynamicSystemFontOfSize:
106277d08: 1e659000    	fmov	d0, #14.00000000
106277d0c: 9466bd0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277d10: aa1d03fd    	mov	x29, x29
106277d14: 9466bd0d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106277d18: aa0003f4    	mov	x20, x0
106277d1c: f8756a60    	ldr	x0, [x19, x21]
106277d20: b00cf488    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106277d24: f9400501    	ldr	x1, [x8, #0x8] ; setFont:
106277d28: aa1403e2    	mov	x2, x20
106277d2c: 9466bd04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106277d30: aa1403e0    	mov	x0, x20
106277d34: 9466bd08    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106277d38: 900ceae8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106277d3c: f9467901    	ldr	x1, [x8, #0xcf0] ; updateSecLabelColor
106277d40: aa1303e0    	mov	x0, x19
106277d44: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106277d48: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106277d4c: a8c357f6    	ldp	x22, x21, [sp], #0x30
106277d50: 1466bcfb    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>