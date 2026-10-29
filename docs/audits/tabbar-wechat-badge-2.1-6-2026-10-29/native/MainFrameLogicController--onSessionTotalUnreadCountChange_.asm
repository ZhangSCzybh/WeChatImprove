
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104aa8180: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104aa8184: a90157f6    	stp	x22, x21, [sp, #0x10]
104aa8188: a9024ff4    	stp	x20, x19, [sp, #0x20]
104aa818c: a9037bfd    	stp	x29, x30, [sp, #0x30]
104aa8190: 9100c3fd    	add	x29, sp, #0x30
104aa8194: aa0003f3    	mov	x19, x0
104aa8198: f00dbbc8    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104aa819c: b9831517    	ldrsw	x23, [x8, #0x314]
104aa81a0: 8b170000    	add	x0, x0, x23
104aa81a4: 94c5fbfa    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104aa81a8: aa0003f5    	mov	x21, x0
104aa81ac: 900da6e8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104aa81b0: f9466914    	ldr	x20, [x8, #0xcd0] ; selector updateUnReadCount
104aa81b4: d00db2e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104aa81b8: f9436101    	ldr	x1, [x8, #0x6c0] ; selector respondsToSelector:
104aa81bc: aa1403e2    	mov	x2, x20
104aa81c0: 94c5fbdf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa81c4: aa0003f6    	mov	x22, x0
104aa81c8: aa1503e0    	mov	x0, x21
104aa81cc: 94c5fbe2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa81d0: 34000196    	cbz	w22, 0x104aa8200 <_Flutter_MMFoundation_BindContext+0xf83de4>
104aa81d4: 8b170260    	add	x0, x19, x23
104aa81d8: 94c5fbed    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104aa81dc: aa0003f3    	mov	x19, x0
104aa81e0: aa1403e1    	mov	x1, x20
104aa81e4: 94c5fbd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa81e8: aa1303e0    	mov	x0, x19
104aa81ec: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104aa81f0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104aa81f4: a94157f6    	ldp	x22, x21, [sp, #0x10]
104aa81f8: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104aa81fc: 14c5fbd6    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa8200: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104aa8204: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104aa8208: a94157f6    	ldp	x22, x21, [sp, #0x10]
104aa820c: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104aa8210: d65f03c0    	ret
