
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c7fd20: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
105c7fd24: a9017bfd    	stp	x29, x30, [sp, #0x10]
105c7fd28: 910043fd    	add	x29, sp, #0x10
105c7fd2c: 900d0f48    	adrp	x8, 0x11fe67000 <dyld_stub_binder+0x11fe67000>
105c7fd30: f9438501    	ldr	x1, [x8, #0x708] ; usernameList
105c7fd34: 947e9d02    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fd38: aa1d03fd    	mov	x29, x29
105c7fd3c: 947e9d03    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c7fd40: aa0003f3    	mov	x19, x0
105c7fd44: b00d2408    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105c7fd48: f9435101    	ldr	x1, [x8, #0x6a0] ; count
105c7fd4c: 947e9cfc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c7fd50: aa0003f4    	mov	x20, x0
105c7fd54: aa1303e0    	mov	x0, x19
105c7fd58: 947e9cff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c7fd5c: aa1403e0    	mov	x0, x20
105c7fd60: a9417bfd    	ldp	x29, x30, [sp, #0x10]
105c7fd64: a8c24ff4    	ldp	x20, x19, [sp], #0x20
105c7fd68: d65f03c0    	ret
