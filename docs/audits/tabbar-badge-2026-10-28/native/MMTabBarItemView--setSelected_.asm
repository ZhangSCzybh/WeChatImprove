
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104728ea0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104728ea4: a9014ff4    	stp	x20, x19, [sp, #0x10]
104728ea8: a9027bfd    	stp	x29, x30, [sp, #0x20]
104728eac: 910083fd    	add	x29, sp, #0x20
104728eb0: aa0203f3    	mov	x19, x2
104728eb4: aa0003f4    	mov	x20, x0
104728eb8: f00dd7a8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104728ebc: b98a2108    	ldrsw	x8, [x8, #0xa20]
104728ec0: 38286802    	strb	w2, [x0, x8]
104728ec4: b00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104728ec8: f9469501    	ldr	x1, [x8, #0xd28] ; selector reloadIconImage
104728ecc: 94d3f89c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728ed0: b00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104728ed4: f9469915    	ldr	x21, [x8, #0xd30] ; selector customIconView
104728ed8: aa1403e0    	mov	x0, x20
104728edc: aa1503e1    	mov	x1, x21
104728ee0: 94d3f897    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728ee4: aa1d03fd    	mov	x29, x29
104728ee8: 94d3f898    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728eec: aa0003f6    	mov	x22, x0
104728ef0: 94d3f899    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728ef4: b4000216    	cbz	x22, 0x104728f34 <_Flutter_MMFoundation_BindContext+0xc04b18>
104728ef8: aa1403e0    	mov	x0, x20
104728efc: aa1503e1    	mov	x1, x21
104728f00: 94d3f88f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728f04: aa1d03fd    	mov	x29, x29
104728f08: 94d3f890    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728f0c: aa0003f4    	mov	x20, x0
104728f10: b00dcf08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104728f14: f9444d01    	ldr	x1, [x8, #0x898] ; selector setSelected:
104728f18: aa1303e2    	mov	x2, x19
104728f1c: 94d3f888    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728f20: aa1403e0    	mov	x0, x20
104728f24: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104728f28: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104728f2c: a8c357f6    	ldp	x22, x21, [sp], #0x30
104728f30: 14d3f889    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728f34: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104728f38: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104728f3c: a8c357f6    	ldp	x22, x21, [sp], #0x30
104728f40: d65f03c0    	ret
