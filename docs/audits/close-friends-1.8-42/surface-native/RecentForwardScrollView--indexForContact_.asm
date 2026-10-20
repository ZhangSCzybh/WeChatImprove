
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105515c14: d10203ff    	sub	sp, sp, #0x80
105515c18: a9026ffc    	stp	x28, x27, [sp, #0x20]
105515c1c: a90367fa    	stp	x26, x25, [sp, #0x30]
105515c20: a9045ff8    	stp	x24, x23, [sp, #0x40]
105515c24: a90557f6    	stp	x22, x21, [sp, #0x50]
105515c28: a9064ff4    	stp	x20, x19, [sp, #0x60]
105515c2c: a9077bfd    	stp	x29, x30, [sp, #0x70]
105515c30: 9101c3fd    	add	x29, sp, #0x70
105515c34: aa0003f4    	mov	x20, x0
105515c38: f00db948    	adrp	x8, 0x120c40000 <dyld_stub_binder+0x120c40000>
105515c3c: 52800029    	mov	w9, #0x1                ; =1
105515c40: 3928c109    	strb	w9, [x8, #0xa30]
105515c44: f9000fe2    	str	x2, [sp, #0x18]
105515c48: aa0203e0    	mov	x0, x2
105515c4c: 949c453b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105515c50: f00d68a8    	adrp	x8, 0x12022c000 <dyld_stub_binder+0x12022c000>
105515c54: b9852118    	ldrsw	x24, [x8, #0x520] ; ivar RecentForwardScrollView._iconViews
105515c58: f00d5f48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105515c5c: f9435101    	ldr	x1, [x8, #0x6a0] ; count
105515c60: f8786a80    	ldr	x0, [x20, x24]
105515c64: f9000be1    	str	x1, [sp, #0x10]
105515c68: 949c4535    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105515c6c: b40006c0    	cbz	x0, 0x105515d44 <_Flutter_MMFoundation_BindContext+0x19f1928>
105515c70: d2800015    	mov	x21, #0x0               ; =0
105515c74: b00d4928    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105515c78: f942c109    	ldr	x9, [x8, #0x580] ; safeObjectAtIndex:
105515c7c: d00d4be8    	adrp	x8, 0x11fe93000 <dyld_stub_binder+0x11fe93000>
105515c80: f9428508    	ldr	x8, [x8, #0x508] ; oContact
105515c84: a90027e8    	stp	x8, x9, [sp]
105515c88: d00d4928    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105515c8c: f9434d19    	ldr	x25, [x8, #0x698] ; m_nsUsrName
105515c90: d00d5f68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105515c94: f943c91a    	ldr	x26, [x8, #0x790] ; isEqualToString:
105515c98: f8786a80    	ldr	x0, [x20, x24]
105515c9c: f94007e1    	ldr	x1, [sp, #0x8]
105515ca0: aa1503e2    	mov	x2, x21
105515ca4: 949c4526    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105515ca8: aa1d03fd    	mov	x29, x29
105515cac: 949c4527    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105515cb0: aa0003fb    	mov	x27, x0
105515cb4: f94003e1    	ldr	x1, [sp]
105515cb8: 949c4521    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105515cbc: aa1d03fd    	mov	x29, x29
105515cc0: 949c4522    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105515cc4: aa0003fc    	mov	x28, x0
105515cc8: aa1903e1    	mov	x1, x25
105515ccc: 949c451c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105515cd0: aa1d03fd    	mov	x29, x29
105515cd4: 949c451d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105515cd8: aa0003f3    	mov	x19, x0
105515cdc: f9400fe0    	ldr	x0, [sp, #0x18]
105515ce0: aa1903e1    	mov	x1, x25
105515ce4: 949c4516    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105515ce8: aa1d03fd    	mov	x29, x29
105515cec: 949c4517    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105515cf0: aa0003f6    	mov	x22, x0
105515cf4: aa1303e0    	mov	x0, x19
105515cf8: aa1a03e1    	mov	x1, x26
105515cfc: aa1603e2    	mov	x2, x22
105515d00: 949c450f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105515d04: aa0003f7    	mov	x23, x0
105515d08: aa1603e0    	mov	x0, x22
105515d0c: 949c4512    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105515d10: aa1303e0    	mov	x0, x19
105515d14: 949c4510    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105515d18: aa1c03e0    	mov	x0, x28
105515d1c: 949c450e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105515d20: aa1b03e0    	mov	x0, x27
105515d24: 949c450c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105515d28: 35000117    	cbnz	w23, 0x105515d48 <_Flutter_MMFoundation_BindContext+0x19f192c>
105515d2c: 910006b5    	add	x21, x21, #0x1
105515d30: f8786a80    	ldr	x0, [x20, x24]
105515d34: f9400be1    	ldr	x1, [sp, #0x10]
105515d38: 949c4501    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105515d3c: eb15001f    	cmp	x0, x21
105515d40: 54fffac8    	b.hi	0x105515c98 <_Flutter_MMFoundation_BindContext+0x19f187c>
105515d44: 92f00015    	mov	x21, #0x7fffffffffffffff ; =9223372036854775807
105515d48: f9400fe0    	ldr	x0, [sp, #0x18]
105515d4c: 949c4502    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105515d50: aa1503e0    	mov	x0, x21
105515d54: a9477bfd    	ldp	x29, x30, [sp, #0x70]
105515d58: a9464ff4    	ldp	x20, x19, [sp, #0x60]
105515d5c: a94557f6    	ldp	x22, x21, [sp, #0x50]
105515d60: a9445ff8    	ldp	x24, x23, [sp, #0x40]
105515d64: a94367fa    	ldp	x26, x25, [sp, #0x30]
105515d68: a9426ffc    	ldp	x28, x27, [sp, #0x20]
105515d6c: 910203ff    	add	sp, sp, #0x80
105515d70: d65f03c0    	ret
