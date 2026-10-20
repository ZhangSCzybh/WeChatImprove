
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a064bc4: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10a064bc8: a90157f6    	stp	x22, x21, [sp, #0x10]
10a064bcc: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a064bd0: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a064bd4: 9100c3fd    	add	x29, sp, #0x30
10a064bd8: aa0003f3    	mov	x19, x0
10a064bdc: d00b0028    	adrp	x8, 0x12006a000 <dyld_stub_binder+0x12006a000>
10a064be0: f940f114    	ldr	x20, [x8, #0x1e0] ; timelineCellViewDelegate
10a064be4: aa1403e1    	mov	x1, x20
10a064be8: 955fda17    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a064bec: aa1d03fd    	mov	x29, x29
10a064bf0: 955fda18    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a064bf4: b40004a0    	cbz	x0, 0x10a064c88 <_Flutter_MMFoundation_BindContext+0x654086c>
10a064bf8: aa0003f6    	mov	x22, x0
10a064bfc: aa1303e0    	mov	x0, x19
10a064c00: aa1403e1    	mov	x1, x20
10a064c04: 955fda10    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a064c08: aa1d03fd    	mov	x29, x29
10a064c0c: 955fda11    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a064c10: aa0003f7    	mov	x23, x0
10a064c14: 900b01a8    	adrp	x8, 0x120098000 <dyld_stub_binder+0x120098000>
10a064c18: f944d915    	ldr	x21, [x8, #0x9b0] ; onWCTimeLineCellViewShowGroup:
10a064c1c: d00b0508    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a064c20: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10a064c24: aa1503e2    	mov	x2, x21
10a064c28: 955fda07    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a064c2c: aa0003f8    	mov	x24, x0
10a064c30: aa1703e0    	mov	x0, x23
10a064c34: 955fda0a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a064c38: aa1603e0    	mov	x0, x22
10a064c3c: 955fda08    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a064c40: 34000258    	cbz	w24, 0x10a064c88 <_Flutter_MMFoundation_BindContext+0x654086c>
10a064c44: aa1303e0    	mov	x0, x19
10a064c48: aa1403e1    	mov	x1, x20
10a064c4c: 955fd9fe    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a064c50: aa1d03fd    	mov	x29, x29
10a064c54: 955fd9ff    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a064c58: aa0003f4    	mov	x20, x0
10a064c5c: 900b1088    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a064c60: b9800d08    	ldrsw	x8, [x8, #0xc] ; ivar WCTimeLineCellView.m_dataItem
10a064c64: f8686a62    	ldr	x2, [x19, x8]
10a064c68: aa1503e1    	mov	x1, x21
10a064c6c: 955fd9f6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a064c70: aa1403e0    	mov	x0, x20
10a064c74: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a064c78: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a064c7c: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a064c80: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10a064c84: 155fd9f6    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a064c88: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a064c8c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a064c90: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a064c94: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10a064c98: d65f03c0    	ret
