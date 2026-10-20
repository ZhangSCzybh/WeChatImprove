
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4ad90: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100e4ad94: a9014ff4    	stp	x20, x19, [sp, #0x10]
100e4ad98: a9027bfd    	stp	x29, x30, [sp, #0x20]
100e4ad9c: 910083fd    	add	x29, sp, #0x20
100e4ada0: b00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4ada4: f945e900    	ldr	x0, [x8, #0xbd0]
100e4ada8: d00f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4adac: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100e4adb0: 95b770e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4adb4: aa1d03fd    	mov	x29, x29
100e4adb8: 95b770e4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4adbc: aa0003f3    	mov	x19, x0
100e4adc0: b00f9988    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100e4adc4: f9420500    	ldr	x0, [x8, #0x408]
100e4adc8: b00f95a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e4adcc: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100e4add0: 95b770db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4add4: aa0003e2    	mov	x2, x0
100e4add8: f00f7f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e4addc: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100e4ade0: aa1303e0    	mov	x0, x19
100e4ade4: 95b770d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4ade8: aa1d03fd    	mov	x29, x29
100e4adec: 95b770d7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4adf0: aa0003f4    	mov	x20, x0
100e4adf4: d00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4adf8: f943dd01    	ldr	x1, [x8, #0x7b8] ; chatBoxSessionCount
100e4adfc: 95b770d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4ae00: aa0003f5    	mov	x21, x0
100e4ae04: aa1403e0    	mov	x0, x20
100e4ae08: 95b770d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4ae0c: aa1303e0    	mov	x0, x19
100e4ae10: 95b770d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4ae14: aa1503e0    	mov	x0, x21
100e4ae18: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100e4ae1c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100e4ae20: a8c357f6    	ldp	x22, x21, [sp], #0x30
100e4ae24: d65f03c0    	ret
