
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a09b81c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10a09b820: a9014ff4    	stp	x20, x19, [sp, #0x10]
10a09b824: a9027bfd    	stp	x29, x30, [sp, #0x20]
10a09b828: 910083fd    	add	x29, sp, #0x20
10a09b82c: aa0003f3    	mov	x19, x0
10a09b830: b00affe8    	adrp	x8, 0x120098000 <dyld_stub_binder+0x120098000>
10a09b834: f9470901    	ldr	x1, [x8, #0xe10] ; isShowLikeCell
10a09b838: 955eff03    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09b83c: 370001e0    	tbnz	w0, #0x0, 0x10a09b878 <_Flutter_MMFoundation_BindContext+0x657745c>
10a09b840: 900b0808    	adrp	x8, 0x12019b000 <dyld_stub_binder+0x12019b000>
10a09b844: f9467900    	ldr	x0, [x8, #0xcf0]
10a09b848: b00b0ec8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a09b84c: b9813115    	ldrsw	x21, [x8, #0x130]
10a09b850: f8756a62    	ldr	x2, [x19, x21]
10a09b854: b00b0ec8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a09b858: b9812908    	ldrsw	x8, [x8, #0x128]
10a09b85c: f8686a63    	ldr	x3, [x19, x8]
10a09b860: b00affe8    	adrp	x8, 0x120098000 <dyld_stub_binder+0x120098000>
10a09b864: f946fd01    	ldr	x1, [x8, #0xdf8] ; getCommentIndexForDataItem:RowIndex:
10a09b868: 955efef7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09b86c: 92f00008    	mov	x8, #0x7fffffffffffffff ; =9223372036854775807
10a09b870: eb08001f    	cmp	x0, x8
10a09b874: 54000061    	b.ne	0x10a09b880 <_Flutter_MMFoundation_BindContext+0x6577464>
10a09b878: d2800013    	mov	x19, #0x0               ; =0
10a09b87c: 14000012    	b	0x10a09b8c4 <_Flutter_MMFoundation_BindContext+0x65774a8>
10a09b880: aa0003f4    	mov	x20, x0
10a09b884: f8756a60    	ldr	x0, [x19, x21]
10a09b888: 900af108    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
10a09b88c: f9475101    	ldr	x1, [x8, #0xea0] ; commentUsers
10a09b890: 955efeed    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09b894: aa1d03fd    	mov	x29, x29
10a09b898: 955efeee    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09b89c: aa0003f5    	mov	x21, x0
10a09b8a0: f00aece8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10a09b8a4: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
10a09b8a8: aa1403e2    	mov	x2, x20
10a09b8ac: 955efee6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09b8b0: aa1d03fd    	mov	x29, x29
10a09b8b4: 955efee7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a09b8b8: aa0003f3    	mov	x19, x0
10a09b8bc: aa1503e0    	mov	x0, x21
10a09b8c0: 955efee7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09b8c4: aa1303e0    	mov	x0, x19
10a09b8c8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10a09b8cc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10a09b8d0: a8c357f6    	ldp	x22, x21, [sp], #0x30
10a09b8d4: 155efee9    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>
