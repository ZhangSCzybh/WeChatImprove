
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109afa824: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
109afa828: a9017bfd    	stp	x29, x30, [sp, #0x10]
109afa82c: 910043fd    	add	x29, sp, #0x10
109afa830: aa0003f3    	mov	x19, x0
109afa834: f00b3068    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109afa838: f9431501    	ldr	x1, [x8, #0x628] ; setRequest:
109afa83c: 95758302    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109afa840: f00b19e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109afa844: f947bd01    	ldr	x1, [x8, #0xf78] ; setRetryCount:
109afa848: aa1303e0    	mov	x0, x19
109afa84c: 52800042    	mov	w2, #0x2                ; =2
109afa850: 957582fd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109afa854: 900b3088    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
109afa858: f944d101    	ldr	x1, [x8, #0x9a0] ; start
109afa85c: aa1303e0    	mov	x0, x19
109afa860: a9417bfd    	ldp	x29, x30, [sp, #0x10]
109afa864: a8c24ff4    	ldp	x20, x19, [sp], #0x20
109afa868: 157582f7    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>