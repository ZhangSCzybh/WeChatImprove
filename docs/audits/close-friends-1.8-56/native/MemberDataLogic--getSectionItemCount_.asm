
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adad84: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104adad88: a9014ff4    	stp	x20, x19, [sp, #0x10]
104adad8c: a9027bfd    	stp	x29, x30, [sp, #0x20]
104adad90: 910083fd    	add	x29, sp, #0x20
104adad94: f9400813    	ldr	x19, [x0, #0x10]
104adad98: f00da548    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104adad9c: f9450d01    	ldr	x1, [x8, #0xa18] ; getKeyAtSection:
104adada0: 94c530e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adada4: aa1d03fd    	mov	x29, x29
104adada8: 94c530e8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adadac: aa0003f4    	mov	x20, x0
104adadb0: d00db148    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104adadb4: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
104adadb8: aa1303e0    	mov	x0, x19
104adadbc: aa1403e2    	mov	x2, x20
104adadc0: 94c530df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adadc4: aa1d03fd    	mov	x29, x29
104adadc8: 94c530e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104adadcc: aa0003f3    	mov	x19, x0
104adadd0: d00db128    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104adadd4: f9435101    	ldr	x1, [x8, #0x6a0] ; count
104adadd8: 94c530d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104adaddc: aa0003f5    	mov	x21, x0
104adade0: aa1303e0    	mov	x0, x19
104adade4: 94c530dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adade8: aa1403e0    	mov	x0, x20
104adadec: 94c530da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104adadf0: aa1503e0    	mov	x0, x21
104adadf4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104adadf8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104adadfc: a8c357f6    	ldp	x22, x21, [sp], #0x30
104adae00: d65f03c0    	ret
