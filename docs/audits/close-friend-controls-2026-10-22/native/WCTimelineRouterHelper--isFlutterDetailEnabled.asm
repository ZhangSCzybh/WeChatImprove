
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a166404: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10a166408: a9014ff4    	stp	x20, x19, [sp, #0x10]
10a16640c: a9027bfd    	stp	x29, x30, [sp, #0x20]
10a166410: 910083fd    	add	x29, sp, #0x20
10a166414: b00b0068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a166418: f945e900    	ldr	x0, [x8, #0xbd0]
10a16641c: d00afcc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a166420: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a166424: 955bd408    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a166428: aa1d03fd    	mov	x29, x29
10a16642c: 955bd409    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a166430: aa0003f3    	mov	x19, x0
10a166434: 900b0088    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a166438: f946d100    	ldr	x0, [x8, #0xda0] ;  h>
10a16643c: b00afcc8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a166440: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a166444: 955bd400    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a166448: aa0003e2    	mov	x2, x0
10a16644c: f00ae688    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a166450: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a166454: aa1303e0    	mov	x0, x19
10a166458: 955bd3fb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a16645c: aa1d03fd    	mov	x29, x29
10a166460: 955bd3fc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a166464: aa0003f4    	mov	x20, x0
10a166468: b00af9a8    	adrp	x8, 0x12009b000 <dyld_stub_binder+0x12009b000>
10a16646c: f941d501    	ldr	x1, [x8, #0x3a8] ; Moments_enableFlutterDetail
10a166470: 955bd3f5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a166474: aa0003f5    	mov	x21, x0
10a166478: aa1403e0    	mov	x0, x20
10a16647c: 955bd3f8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a166480: aa1303e0    	mov	x0, x19
10a166484: 955bd3f6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a166488: aa1503e0    	mov	x0, x21
10a16648c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10a166490: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10a166494: a8c357f6    	ldp	x22, x21, [sp], #0x30
10a166498: d65f03c0    	ret
