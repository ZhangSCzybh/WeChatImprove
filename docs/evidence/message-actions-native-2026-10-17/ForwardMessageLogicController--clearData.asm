
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c2d158: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101c2d15c: a9017bfd    	stp	x29, x30, [sp, #0x10]
101c2d160: 910043fd    	add	x29, sp, #0x10
101c2d164: aa0003f3    	mov	x19, x0
101c2d168: d00f8028    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c2d16c: 52800029    	mov	w9, #0x1                ; =1
101c2d170: 3925ad09    	strb	w9, [x8, #0x96b]
101c2d174: f00f1468    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c2d178: f9453901    	ldr	x1, [x8, #0xa70] ; forwardToThirdAppZipHandler
101c2d17c: 957fe7f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c2d180: aa1d03fd    	mov	x29, x29
101c2d184: 957fe7f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c2d188: aa0003f4    	mov	x20, x0
101c2d18c: f00f1468    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c2d190: f9453d01    	ldr	x1, [x8, #0xa78] ; cancelAndCleanupZipTask
101c2d194: 957fe7ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c2d198: aa1403e0    	mov	x0, x20
101c2d19c: 957fe7ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c2d1a0: f00f2e28    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c2d1a4: b9890514    	ldrsw	x20, [x8, #0x904]
101c2d1a8: f8746a60    	ldr	x0, [x19, x20]
101c2d1ac: f00f10e8    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
101c2d1b0: f943f101    	ldr	x1, [x8, #0x7e0] ; dismissWithAnimated:
101c2d1b4: 52800002    	mov	w2, #0x0                ; =0
101c2d1b8: 957fe7e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c2d1bc: f8746a60    	ldr	x0, [x19, x20]
101c2d1c0: f8346a7f    	str	xzr, [x19, x20]
101c2d1c4: 957fe7e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c2d1c8: f00f2e28    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c2d1cc: b9890108    	ldrsw	x8, [x8, #0x900]
101c2d1d0: f8686a60    	ldr	x0, [x19, x8]
101c2d1d4: f8286a7f    	str	xzr, [x19, x8]
101c2d1d8: 957fe7df    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c2d1dc: f00f2e28    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c2d1e0: b988f908    	ldrsw	x8, [x8, #0x8f8]
101c2d1e4: f8686a60    	ldr	x0, [x19, x8]
101c2d1e8: f8286a7f    	str	xzr, [x19, x8]
101c2d1ec: 957fe7da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c2d1f0: f00f2e28    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c2d1f4: b9890908    	ldrsw	x8, [x8, #0x908]
101c2d1f8: f8686a60    	ldr	x0, [x19, x8]
101c2d1fc: f8286a7f    	str	xzr, [x19, x8]
101c2d200: 957fe7d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c2d204: f00f2e28    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c2d208: b9890d08    	ldrsw	x8, [x8, #0x90c]
101c2d20c: f8686a60    	ldr	x0, [x19, x8]
101c2d210: f8286a7f    	str	xzr, [x19, x8]
101c2d214: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101c2d218: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101c2d21c: 157fe7ce    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>