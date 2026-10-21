
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0b92b0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10a0b92b4: a9017bfd    	stp	x29, x30, [sp, #0x10]
10a0b92b8: 910043fd    	add	x29, sp, #0x10
10a0b92bc: aa0003f3    	mov	x19, x0
10a0b92c0: f00b0dc8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0b92c4: b9825108    	ldrsw	x8, [x8, #0x250]
10a0b92c8: 38686809    	ldrb	w9, [x0, x8]
10a0b92cc: 7100053f    	cmp	w9, #0x1
10a0b92d0: 540000c1    	b.ne	0x10a0b92e8 <_Flutter_MMFoundation_BindContext+0x6594ecc>
10a0b92d4: 38286a7f    	strb	wzr, [x19, x8]
10a0b92d8: b00aec88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
10a0b92dc: f9454501    	ldr	x1, [x8, #0xa88] ; handleAppmsgWhenInPage
10a0b92e0: aa1303e0    	mov	x0, x19
10a0b92e4: 955e8858    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b92e8: f00aec48    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a0b92ec: f944d901    	ldr	x1, [x8, #0x9b0] ; autoplayVideoProcess
10a0b92f0: aa1303e0    	mov	x0, x19
10a0b92f4: 955e8854    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b92f8: 900aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b92fc: f9413d01    	ldr	x1, [x8, #0x278] ; startAdOnTimelineReloaded
10a0b9300: aa1303e0    	mov	x0, x19
10a0b9304: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10a0b9308: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10a0b930c: 155e884e    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
