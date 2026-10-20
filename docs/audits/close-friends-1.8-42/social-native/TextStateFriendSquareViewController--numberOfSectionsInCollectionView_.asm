
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c7e13c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105c7e140: a9014ff4    	stp	x20, x19, [sp, #0x10]
105c7e144: a9027bfd    	stp	x29, x30, [sp, #0x20]
105c7e148: 910083fd    	add	x29, sp, #0x20
105c7e14c: aa0003f3    	mov	x19, x0
105c7e150: d00d1a08    	adrp	x8, 0x11ffc0000 <dyld_stub_binder+0x11ffc0000>
105c7e154: f9401901    	ldr	x1, [x8, #0x30] ; friendTopicList
105c7e158: 947ea3f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7e15c: aa1d03fd    	mov	x29, x29
105c7e160: 947ea3fa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7e164: aa0003f4    	mov	x20, x0
105c7e168: d00d2408    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105c7e16c: f9435101    	ldr	x1, [x8, #0x6a0] ; count
105c7e170: 947ea3f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7e174: aa0003f5    	mov	x21, x0
105c7e178: aa1403e0    	mov	x0, x20
105c7e17c: 947ea3f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7e180: d00d1a08    	adrp	x8, 0x11ffc0000 <dyld_stub_binder+0x11ffc0000>
105c7e184: f9405101    	ldr	x1, [x8, #0xa0] ; topInfoCellCount
105c7e188: aa1303e0    	mov	x0, x19
105c7e18c: 947ea3ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7e190: 8b150000    	add	x0, x0, x21
105c7e194: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105c7e198: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105c7e19c: a8c357f6    	ldp	x22, x21, [sp], #0x30
105c7e1a0: d65f03c0    	ret
