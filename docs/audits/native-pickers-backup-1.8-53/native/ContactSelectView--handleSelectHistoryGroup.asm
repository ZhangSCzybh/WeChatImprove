
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101017cc8: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101017ccc: a90157f6    	stp	x22, x21, [sp, #0x10]
101017cd0: a9024ff4    	stp	x20, x19, [sp, #0x20]
101017cd4: a9037bfd    	stp	x29, x30, [sp, #0x30]
101017cd8: 9100c3fd    	add	x29, sp, #0x30
101017cdc: aa0003f3    	mov	x19, x0
101017ce0: b00fe0c8    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
101017ce4: 52800029    	mov	w9, #0x1                ; =1
101017ce8: 39340109    	strb	w9, [x8, #0xd00]
101017cec: d00f8e88    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
101017cf0: b98ff108    	ldrsw	x8, [x8, #0xff0]
101017cf4: f8686800    	ldr	x0, [x0, x8]
101017cf8: b00f7388    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
101017cfc: f9421501    	ldr	x1, [x8, #0x428] ; hasHistoryGroupContacts
101017d00: 95b03d0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101017d04: 370001a0    	tbnz	w0, #0x0, 0x101017d38 <__text+0x100fd38>
101017d08: d00f8e88    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
101017d0c: b98ff908    	ldrsw	x8, [x8, #0xff8]
101017d10: b8686a68    	ldr	w8, [x19, x8]
101017d14: 7100a11f    	cmp	w8, #0x28
101017d18: 52800029    	mov	w9, #0x1                ; =1
101017d1c: 9ac82128    	lsl	x8, x9, x8
101017d20: d2901009    	mov	x9, #0x8080             ; =32896
101017d24: f2a12009    	movk	x9, #0x900, lsl #16
101017d28: f2c02069    	movk	x9, #0x103, lsl #32
101017d2c: 8a090108    	and	x8, x8, x9
101017d30: fa409904    	ccmp	x8, #0x0, #0x4, ls
101017d34: 54000420    	b.eq	0x101017db8 <__text+0x100fdb8>
101017d38: d00f8e88    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
101017d3c: b98fb918    	ldrsw	x24, [x8, #0xfb8]
101017d40: 8b180260    	add	x0, x19, x24
101017d44: 95b03d12    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101017d48: b4000380    	cbz	x0, 0x101017db8 <__text+0x100fdb8>
101017d4c: aa0003f5    	mov	x21, x0
101017d50: 8b180260    	add	x0, x19, x24
101017d54: 95b03d0e    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101017d58: aa0003f6    	mov	x22, x0
101017d5c: b00f7388    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
101017d60: f9425914    	ldr	x20, [x8, #0x4b0] ; onSelectHistoryGroup
101017d64: f00f8768    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101017d68: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
101017d6c: aa1403e2    	mov	x2, x20
101017d70: 95b03cf3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101017d74: aa0003f7    	mov	x23, x0
101017d78: aa1603e0    	mov	x0, x22
101017d7c: 95b03cf6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101017d80: aa1503e0    	mov	x0, x21
101017d84: 95b03cf4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101017d88: 34000197    	cbz	w23, 0x101017db8 <__text+0x100fdb8>
101017d8c: 8b180260    	add	x0, x19, x24
101017d90: 95b03cff    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101017d94: aa0003f3    	mov	x19, x0
101017d98: aa1403e1    	mov	x1, x20
101017d9c: 95b03ce8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101017da0: aa1303e0    	mov	x0, x19
101017da4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101017da8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101017dac: a94157f6    	ldp	x22, x21, [sp, #0x10]
101017db0: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101017db4: 15b03ce8    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101017db8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101017dbc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101017dc0: a94157f6    	ldp	x22, x21, [sp, #0x10]
101017dc4: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101017dc8: d65f03c0    	ret
