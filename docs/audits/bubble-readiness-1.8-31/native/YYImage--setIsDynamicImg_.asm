
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bd7fc: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10a9bd800: a90157f6    	stp	x22, x21, [sp, #0x10]
10a9bd804: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a9bd808: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a9bd80c: 9100c3fd    	add	x29, sp, #0x30
10a9bd810: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bd814: b98ea508    	ldrsw	x8, [x8, #0xea4]
10a9bd818: 38286802    	strb	w2, [x0, x8]
10a9bd81c: 34000542    	cbz	w2, 0x10a9bd8c4 <_Flutter_MMFoundation_BindContext+0x6e994a8>
10a9bd820: aa0003f3    	mov	x19, x0
10a9bd824: f00aba08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a9bd828: f946f114    	ldr	x20, [x8, #0xde0] ; delegate
10a9bd82c: aa1403e1    	mov	x1, x20
10a9bd830: 953a7705    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bd834: aa1d03fd    	mov	x29, x29
10a9bd838: 953a7706    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bd83c: b4000440    	cbz	x0, 0x10a9bd8c4 <_Flutter_MMFoundation_BindContext+0x6e994a8>
10a9bd840: aa0003f6    	mov	x22, x0
10a9bd844: aa1303e0    	mov	x0, x19
10a9bd848: aa1403e1    	mov	x1, x20
10a9bd84c: 953a76fe    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bd850: aa1d03fd    	mov	x29, x29
10a9bd854: 953a76ff    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bd858: aa0003f7    	mov	x23, x0
10a9bd85c: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bd860: f945e515    	ldr	x21, [x8, #0xbc8] ; didSetDynamicYYImage
10a9bd864: b00aba48    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a9bd868: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10a9bd86c: aa1503e2    	mov	x2, x21
10a9bd870: 953a76f5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bd874: aa0003f8    	mov	x24, x0
10a9bd878: aa1703e0    	mov	x0, x23
10a9bd87c: 953a76f8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bd880: aa1603e0    	mov	x0, x22
10a9bd884: 953a76f6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bd888: 340001f8    	cbz	w24, 0x10a9bd8c4 <_Flutter_MMFoundation_BindContext+0x6e994a8>
10a9bd88c: aa1303e0    	mov	x0, x19
10a9bd890: aa1403e1    	mov	x1, x20
10a9bd894: 953a76ec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bd898: aa1d03fd    	mov	x29, x29
10a9bd89c: 953a76ed    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bd8a0: aa0003f3    	mov	x19, x0
10a9bd8a4: aa1503e1    	mov	x1, x21
10a9bd8a8: 953a76e7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bd8ac: aa1303e0    	mov	x0, x19
10a9bd8b0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a9bd8b4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a9bd8b8: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a9bd8bc: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10a9bd8c0: 153a76e7    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bd8c4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a9bd8c8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a9bd8cc: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a9bd8d0: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10a9bd8d4: d65f03c0    	ret