
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109ddb2d4: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
109ddb2d8: a90157f6    	stp	x22, x21, [sp, #0x10]
109ddb2dc: a9024ff4    	stp	x20, x19, [sp, #0x20]
109ddb2e0: a9037bfd    	stp	x29, x30, [sp, #0x30]
109ddb2e4: 9100c3fd    	add	x29, sp, #0x30
109ddb2e8: aa0003f3    	mov	x19, x0
109ddb2ec: d00b15a8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109ddb2f0: f9411914    	ldr	x20, [x8, #0x230] ; searchBarDelegate
109ddb2f4: aa1403e1    	mov	x1, x20
109ddb2f8: 956a0053    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb2fc: aa1d03fd    	mov	x29, x29
109ddb300: 956a0054    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb304: b4000440    	cbz	x0, 0x109ddb38c <_Flutter_MMFoundation_BindContext+0x62b6f70>
109ddb308: aa0003f6    	mov	x22, x0
109ddb30c: aa1303e0    	mov	x0, x19
109ddb310: aa1403e1    	mov	x1, x20
109ddb314: 956a004c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb318: aa1d03fd    	mov	x29, x29
109ddb31c: 956a004d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb320: aa0003f7    	mov	x23, x0
109ddb324: d00b15a8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109ddb328: f9413115    	ldr	x21, [x8, #0x260] ; mmInputBoxSearchButtonClick
109ddb32c: f00b1948    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109ddb330: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
109ddb334: aa1503e2    	mov	x2, x21
109ddb338: 956a0043    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb33c: aa0003f8    	mov	x24, x0
109ddb340: aa1703e0    	mov	x0, x23
109ddb344: 956a0046    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb348: aa1603e0    	mov	x0, x22
109ddb34c: 956a0044    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb350: 340001f8    	cbz	w24, 0x109ddb38c <_Flutter_MMFoundation_BindContext+0x62b6f70>
109ddb354: aa1303e0    	mov	x0, x19
109ddb358: aa1403e1    	mov	x1, x20
109ddb35c: 956a003a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb360: aa1d03fd    	mov	x29, x29
109ddb364: 956a003b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb368: aa0003f3    	mov	x19, x0
109ddb36c: aa1503e1    	mov	x1, x21
109ddb370: 956a0035    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb374: aa1303e0    	mov	x0, x19
109ddb378: a9437bfd    	ldp	x29, x30, [sp, #0x30]
109ddb37c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
109ddb380: a94157f6    	ldp	x22, x21, [sp, #0x10]
109ddb384: a8c45ff8    	ldp	x24, x23, [sp], #0x40
109ddb388: 156a0035    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb38c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
109ddb390: a9424ff4    	ldp	x20, x19, [sp, #0x20]
109ddb394: a94157f6    	ldp	x22, x21, [sp, #0x10]
109ddb398: a8c45ff8    	ldp	x24, x23, [sp], #0x40
109ddb39c: d65f03c0    	ret
