
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101017dcc: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101017dd0: a90157f6    	stp	x22, x21, [sp, #0x10]
101017dd4: a9024ff4    	stp	x20, x19, [sp, #0x20]
101017dd8: a9037bfd    	stp	x29, x30, [sp, #0x30]
101017ddc: 9100c3fd    	add	x29, sp, #0x30
101017de0: aa0003f3    	mov	x19, x0
101017de4: d00f8e88    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
101017de8: b98fb918    	ldrsw	x24, [x8, #0xfb8]
101017dec: 8b180000    	add	x0, x0, x24
101017df0: 95b03ce7    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101017df4: b4000380    	cbz	x0, 0x101017e64 <__text+0x100fe64>
101017df8: aa0003f5    	mov	x21, x0
101017dfc: 8b180260    	add	x0, x19, x24
101017e00: 95b03ce3    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101017e04: aa0003f6    	mov	x22, x0
101017e08: b00f7388    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
101017e0c: f9425d14    	ldr	x20, [x8, #0x4b8] ; onSelectContactTag
101017e10: f00f8768    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101017e14: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
101017e18: aa1403e2    	mov	x2, x20
101017e1c: 95b03cc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101017e20: aa0003f7    	mov	x23, x0
101017e24: aa1603e0    	mov	x0, x22
101017e28: 95b03ccb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101017e2c: aa1503e0    	mov	x0, x21
101017e30: 95b03cc9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101017e34: 34000197    	cbz	w23, 0x101017e64 <__text+0x100fe64>
101017e38: 8b180260    	add	x0, x19, x24
101017e3c: 95b03cd4    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101017e40: aa0003f3    	mov	x19, x0
101017e44: aa1403e1    	mov	x1, x20
101017e48: 95b03cbd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101017e4c: aa1303e0    	mov	x0, x19
101017e50: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101017e54: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101017e58: a94157f6    	ldp	x22, x21, [sp, #0x10]
101017e5c: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101017e60: 15b03cbd    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101017e64: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101017e68: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101017e6c: a94157f6    	ldp	x22, x21, [sp, #0x10]
101017e70: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101017e74: d65f03c0    	ret
