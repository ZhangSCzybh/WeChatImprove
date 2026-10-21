
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109ddb3a0: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
109ddb3a4: a90157f6    	stp	x22, x21, [sp, #0x10]
109ddb3a8: a9024ff4    	stp	x20, x19, [sp, #0x20]
109ddb3ac: a9037bfd    	stp	x29, x30, [sp, #0x30]
109ddb3b0: 9100c3fd    	add	x29, sp, #0x30
109ddb3b4: aa0003f3    	mov	x19, x0
109ddb3b8: d00b15a8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109ddb3bc: f9411914    	ldr	x20, [x8, #0x230] ; searchBarDelegate
109ddb3c0: aa1403e1    	mov	x1, x20
109ddb3c4: 956a0020    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb3c8: aa1d03fd    	mov	x29, x29
109ddb3cc: 956a0021    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb3d0: b4000440    	cbz	x0, 0x109ddb458 <_Flutter_MMFoundation_BindContext+0x62b703c>
109ddb3d4: aa0003f6    	mov	x22, x0
109ddb3d8: aa1303e0    	mov	x0, x19
109ddb3dc: aa1403e1    	mov	x1, x20
109ddb3e0: 956a0019    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb3e4: aa1d03fd    	mov	x29, x29
109ddb3e8: 956a001a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb3ec: aa0003f7    	mov	x23, x0
109ddb3f0: d00b15a8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109ddb3f4: f9413515    	ldr	x21, [x8, #0x268] ; mmInputBoxKeyBoardClick
109ddb3f8: f00b1948    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109ddb3fc: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
109ddb400: aa1503e2    	mov	x2, x21
109ddb404: 956a0010    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb408: aa0003f8    	mov	x24, x0
109ddb40c: aa1703e0    	mov	x0, x23
109ddb410: 956a0013    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb414: aa1603e0    	mov	x0, x22
109ddb418: 956a0011    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb41c: 340001f8    	cbz	w24, 0x109ddb458 <_Flutter_MMFoundation_BindContext+0x62b703c>
109ddb420: aa1303e0    	mov	x0, x19
109ddb424: aa1403e1    	mov	x1, x20
109ddb428: 956a0007    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb42c: aa1d03fd    	mov	x29, x29
109ddb430: 956a0008    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb434: aa0003f3    	mov	x19, x0
109ddb438: aa1503e1    	mov	x1, x21
109ddb43c: 956a0002    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb440: aa1303e0    	mov	x0, x19
109ddb444: a9437bfd    	ldp	x29, x30, [sp, #0x30]
109ddb448: a9424ff4    	ldp	x20, x19, [sp, #0x20]
109ddb44c: a94157f6    	ldp	x22, x21, [sp, #0x10]
109ddb450: a8c45ff8    	ldp	x24, x23, [sp], #0x40
109ddb454: 156a0002    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb458: a9437bfd    	ldp	x29, x30, [sp, #0x30]
109ddb45c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
109ddb460: a94157f6    	ldp	x22, x21, [sp, #0x10]
109ddb464: a8c45ff8    	ldp	x24, x23, [sp], #0x40
109ddb468: d65f03c0    	ret
