
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057f3e84: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1057f3e88: a9014ff4    	stp	x20, x19, [sp, #0x10]
1057f3e8c: a9027bfd    	stp	x29, x30, [sp, #0x20]
1057f3e90: 910083fd    	add	x29, sp, #0x20
1057f3e94: aa0203f3    	mov	x19, x2
1057f3e98: aa0003f4    	mov	x20, x0
1057f3e9c: aa0203e0    	mov	x0, x2
1057f3ea0: 9490cca6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1057f3ea4: b00d3248    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057f3ea8: f9427d15    	ldr	x21, [x8, #0x4f8] ; section
1057f3eac: aa1303e0    	mov	x0, x19
1057f3eb0: aa1503e1    	mov	x1, x21
1057f3eb4: 9490cca2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3eb8: aa0003e2    	mov	x2, x0
1057f3ebc: d00d3de8    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057f3ec0: f9449d16    	ldr	x22, [x8, #0x938] ; sectionTypeFor:
1057f3ec4: aa1403e0    	mov	x0, x20
1057f3ec8: aa1603e1    	mov	x1, x22
1057f3ecc: 9490cc9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3ed0: f1000c1f    	cmp	x0, #0x3
1057f3ed4: 540000e1    	b.ne	0x1057f3ef0 <_Flutter_MMFoundation_BindContext+0x1ccfad4>
1057f3ed8: f00d4888    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1057f3edc: f9440901    	ldr	x1, [x8, #0x810] ; row
1057f3ee0: aa1303e0    	mov	x0, x19
1057f3ee4: 9490cc96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3ee8: aa0003f4    	mov	x20, x0
1057f3eec: 14000016    	b	0x1057f3f44 <_Flutter_MMFoundation_BindContext+0x1ccfb28>
1057f3ef0: aa1303e0    	mov	x0, x19
1057f3ef4: aa1503e1    	mov	x1, x21
1057f3ef8: 9490cc91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3efc: aa0003e2    	mov	x2, x0
1057f3f00: aa1403e0    	mov	x0, x20
1057f3f04: aa1603e1    	mov	x1, x22
1057f3f08: 9490cc8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3f0c: f100101f    	cmp	x0, #0x4
1057f3f10: 54000181    	b.ne	0x1057f3f40 <_Flutter_MMFoundation_BindContext+0x1ccfb24>
1057f3f14: f00d4888    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1057f3f18: f9440901    	ldr	x1, [x8, #0x810] ; row
1057f3f1c: aa1303e0    	mov	x0, x19
1057f3f20: 9490cc87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3f24: aa0003f5    	mov	x21, x0
1057f3f28: d00d3c88    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
1057f3f2c: f940dd01    	ldr	x1, [x8, #0x1b8] ; topSessionCount
1057f3f30: aa1403e0    	mov	x0, x20
1057f3f34: 9490cc82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057f3f38: 8b150014    	add	x20, x0, x21
1057f3f3c: 14000002    	b	0x1057f3f44 <_Flutter_MMFoundation_BindContext+0x1ccfb28>
1057f3f40: d2800014    	mov	x20, #0x0               ; =0
1057f3f44: aa1303e0    	mov	x0, x19
1057f3f48: 9490cc83    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057f3f4c: aa1403e0    	mov	x0, x20
1057f3f50: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1057f3f54: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1057f3f58: a8c357f6    	ldp	x22, x21, [sp], #0x30
1057f3f5c: d65f03c0    	ret
