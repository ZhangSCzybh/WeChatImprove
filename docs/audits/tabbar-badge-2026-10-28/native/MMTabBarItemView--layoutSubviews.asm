
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104728d90: d10103ff    	sub	sp, sp, #0x40
104728d94: a90157f6    	stp	x22, x21, [sp, #0x10]
104728d98: a9024ff4    	stp	x20, x19, [sp, #0x20]
104728d9c: a9037bfd    	stp	x29, x30, [sp, #0x30]
104728da0: 9100c3fd    	add	x29, sp, #0x30
104728da4: aa0003f3    	mov	x19, x0
104728da8: b00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
104728dac: 52800029    	mov	w9, #0x1                ; =1
104728db0: 391a3909    	strb	w9, [x8, #0x68e]
104728db4: 900dd4e8    	adrp	x8, 0x1201c4000 <dyld_stub_binder+0x1201c4000>
104728db8: f9460d08    	ldr	x8, [x8, #0xc18]
104728dbc: a90023e0    	stp	x0, x8, [sp]
104728dc0: d00db8a8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104728dc4: f940a901    	ldr	x1, [x8, #0x150] ; selector layoutSubviews
104728dc8: 910003e0    	mov	x0, sp
104728dcc: 94d3f8de    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104728dd0: f00dd7a8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104728dd4: b98a0d15    	ldrsw	x21, [x8, #0xa0c]
104728dd8: f8756a60    	ldr	x0, [x19, x21]
104728ddc: b00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104728de0: f9465101    	ldr	x1, [x8, #0xca0] ; selector sizeToFit
104728de4: 94d3f8d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728de8: f00dcf08    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104728dec: f947a514    	ldr	x20, [x8, #0xf48] ; selector width
104728df0: aa1303e0    	mov	x0, x19
104728df4: aa1403e1    	mov	x1, x20
104728df8: 94d3f8d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728dfc: f8756a60    	ldr	x0, [x19, x21]
104728e00: d00dcf08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104728e04: f9418d01    	ldr	x1, [x8, #0x318] ; selector setWidth:
104728e08: 94d3f8cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728e0c: f00dd248    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104728e10: f9461900    	ldr	x0, [x8, #0xc30] ; class UIFont
104728e14: b00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104728e18: f9463101    	ldr	x1, [x8, #0xc60] ; selector dynamicLength:
104728e1c: 1e679000    	fmov	d0, #28.00000000
104728e20: 94d3f8c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728e24: 1e641001    	fmov	d1, #8.00000000
104728e28: 1e612800    	fadd	d0, d0, d1
104728e2c: 1e601001    	fmov	d1, #2.00000000
104728e30: 1e612800    	fadd	d0, d0, d1
104728e34: f8756a60    	ldr	x0, [x19, x21]
104728e38: 900db8a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104728e3c: f9403d01    	ldr	x1, [x8, #0x78] ; selector setTop:
104728e40: 94d3f8bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728e44: aa1303e0    	mov	x0, x19
104728e48: aa1403e1    	mov	x1, x20
104728e4c: 94d3f8bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728e50: 1e6c1001    	fmov	d1, #0.50000000
104728e54: 1e610800    	fmul	d0, d0, d1
104728e58: f8756a60    	ldr	x0, [x19, x21]
104728e5c: 900db8a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104728e60: f942dd01    	ldr	x1, [x8, #0x5b8] ; selector setCenterX:
104728e64: 94d3f8b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728e68: f8756a60    	ldr	x0, [x19, x21]
104728e6c: d00dcee8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104728e70: f946b501    	ldr	x1, [x8, #0xd68] ; selector setAccessibilityElementsHidden:
104728e74: 52800022    	mov	w2, #0x1                ; =1
104728e78: 94d3f8b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728e7c: b00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104728e80: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector relayoutIconAndBadge
104728e84: aa1303e0    	mov	x0, x19
104728e88: 94d3f8ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728e8c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104728e90: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104728e94: a94157f6    	ldp	x22, x21, [sp, #0x10]
104728e98: 910103ff    	add	sp, sp, #0x40
104728e9c: d65f03c0    	ret
