
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bb7e4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10a9bb7e8: a9014ff4    	stp	x20, x19, [sp, #0x10]
10a9bb7ec: a9027bfd    	stp	x29, x30, [sp, #0x20]
10a9bb7f0: 910083fd    	add	x29, sp, #0x20
10a9bb7f4: aa0203f3    	mov	x19, x2
10a9bb7f8: aa0003f4    	mov	x20, x0
10a9bb7fc: 900b14c8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a9bb800: 52800029    	mov	w9, #0x1                ; =1
10a9bb804: 3913c909    	strb	w9, [x8, #0x4f2]
10a9bb808: aa0203e0    	mov	x0, x2
10a9bb80c: 953a7f0d    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bb810: b00abdd5    	adrp	x21, 0x120174000 <dyld_stub_binder+0x120174000>
10a9bb814: f9450ea0    	ldr	x0, [x21, #0xa18]
10a9bb818: 900aba28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a9bb81c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a9bb820: 953a7f09    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb824: aa0003e2    	mov	x2, x0
10a9bb828: 900aba48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a9bb82c: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
10a9bb830: aa1303e0    	mov	x0, x19
10a9bb834: 953a7f04    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb838: 36000100    	tbz	w0, #0x0, 0x10a9bb858 <_Flutter_MMFoundation_BindContext+0x6e9743c>
10a9bb83c: 900ac608    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bb840: b98e7115    	ldrsw	x21, [x8, #0xe70]
10a9bb844: aa1303e0    	mov	x0, x19
10a9bb848: 953a7efe    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bb84c: f8756a80    	ldr	x0, [x20, x21]
10a9bb850: f8356a93    	str	x19, [x20, x21]
10a9bb854: 1400000d    	b	0x10a9bb888 <_Flutter_MMFoundation_BindContext+0x6e9746c>
10a9bb858: f9450ea0    	ldr	x0, [x21, #0xa18]
10a9bb85c: d00ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bb860: f945a501    	ldr	x1, [x8, #0xb48] ; imageWithUIImage:
10a9bb864: aa1303e2    	mov	x2, x19
10a9bb868: 953a7ef7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb86c: aa1d03fd    	mov	x29, x29
10a9bb870: 953a7ef8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bb874: aa0003e8    	mov	x8, x0
10a9bb878: 900ac609    	adrp	x9, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bb87c: b98e7135    	ldrsw	x21, [x9, #0xe70]
10a9bb880: f8756a80    	ldr	x0, [x20, x21]
10a9bb884: f8356a88    	str	x8, [x20, x21]
10a9bb888: 953a7ef5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bb88c: f8756a80    	ldr	x0, [x20, x21]
10a9bb890: 900aba68    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a9bb894: f9451501    	ldr	x1, [x8, #0xa28] ; setDelegate:
10a9bb898: aa1403e2    	mov	x2, x20
10a9bb89c: 953a7eea    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb8a0: aa1303e0    	mov	x0, x19
10a9bb8a4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10a9bb8a8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10a9bb8ac: a8c357f6    	ldp	x22, x21, [sp], #0x30
10a9bb8b0: 153a7eeb    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>