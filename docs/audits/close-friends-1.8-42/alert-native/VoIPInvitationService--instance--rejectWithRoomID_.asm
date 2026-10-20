
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106122dc0: d10143ff    	sub	sp, sp, #0x50
106122dc4: a9015ff8    	stp	x24, x23, [sp, #0x10]
106122dc8: a90257f6    	stp	x22, x21, [sp, #0x20]
106122dcc: a9034ff4    	stp	x20, x19, [sp, #0x30]
106122dd0: a9047bfd    	stp	x29, x30, [sp, #0x40]
106122dd4: 910103fd    	add	x29, sp, #0x40
106122dd8: aa0203f4    	mov	x20, x2
106122ddc: aa0003f3    	mov	x19, x0
106122de0: b00d5908    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106122de4: 52800029    	mov	w9, #0x1                ; =1
106122de8: 39178909    	strb	w9, [x8, #0x5e2]
106122dec: 52800040    	mov	w0, #0x2                ; =2
106122df0: 946ba914    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106122df4: 340006e0    	cbz	w0, 0x106122ed0 <_Flutter_MMFoundation_BindContext+0x25feab4>
106122df8: 946c10ea    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106122dfc: aa0003f5    	mov	x21, x0
106122e00: b00d0297    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
106122e04: f94546e0    	ldr	x0, [x23, #0xa88]
106122e08: 946c10d6    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106122e0c: aa0003f6    	mov	x22, x0
106122e10: f94546f7    	ldr	x23, [x23, #0xa88]
106122e14: b00d0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106122e18: f9458900    	ldr	x0, [x8, #0xb10]
106122e1c: d00cff08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106122e20: f947c901    	ldr	x1, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
106122e24: aa1403e2    	mov	x2, x20
106122e28: 946c10c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122e2c: aa1d03fd    	mov	x29, x29
106122e30: 946c10c6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122e34: aa0003f8    	mov	x24, x0
106122e38: 900cff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106122e3c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
106122e40: a9007fe0    	stp	x0, xzr, [sp]
106122e44: d00c3a62    	adrp	x2, 0x11e870000 <dyld_stub_binder+0x11e870000>
106122e48: 9125a042    	add	x2, x2, #0x968 ; cfstring='Prepare to reject ... (%@)'
106122e4c: aa1703e0    	mov	x0, x23
106122e50: 946c10bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122e54: aa1d03fd    	mov	x29, x29
106122e58: 946c10bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122e5c: aa0003f7    	mov	x23, x0
106122e60: 900cff08    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106122e64: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
106122e68: b00c1bc8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106122e6c: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
106122e70: a90003e8    	stp	x8, x0, [sp]
106122e74: b00c1bc2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106122e78: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
106122e7c: aa1603e0    	mov	x0, x22
106122e80: 946c10af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122e84: aa0003f6    	mov	x22, x0
106122e88: aa1703e0    	mov	x0, x23
106122e8c: 946c10b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122e90: aa1803e0    	mov	x0, x24
106122e94: 946c10b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122e98: f00a8781    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
106122e9c: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
106122ea0: b00ac342    	adrp	x2, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106122ea4: 91103c42    	add	x2, x2, #0x40f ; cstring='VoIPInvitationService.mm'
106122ea8: b00ac344    	adrp	x4, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106122eac: 91221884    	add	x4, x4, #0x886 ; cstring='-[VoIPInvitationService rejectWithRoomID:]'
106122eb0: 52800040    	mov	w0, #0x2                ; =2
106122eb4: 52802b43    	mov	w3, #0x15a              ; =346
106122eb8: aa1603e5    	mov	x5, x22
106122ebc: 946ba8e2    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106122ec0: aa1603e0    	mov	x0, x22
106122ec4: 946c10a4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122ec8: aa1503e0    	mov	x0, x21
106122ecc: 946c10b8    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106122ed0: b00cff48    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106122ed4: f946dd01    	ldr	x1, [x8, #0xdb8] ; selector=viewController
106122ed8: aa1303e0    	mov	x0, x19
106122edc: 946c1098    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122ee0: aa1d03fd    	mov	x29, x29
106122ee4: 946c1099    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122ee8: aa0003f5    	mov	x21, x0
106122eec: b00ce908    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
106122ef0: f9422d01    	ldr	x1, [x8, #0x458] ; selector=info
106122ef4: 946c1092    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122ef8: aa1d03fd    	mov	x29, x29
106122efc: 946c1093    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106122f00: aa0003f6    	mov	x22, x0
106122f04: 900ce8c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106122f08: f9406101    	ldr	x1, [x8, #0xc0] ; selector=roomID
106122f0c: 946c108c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122f10: aa0003f7    	mov	x23, x0
106122f14: aa1603e0    	mov	x0, x22
106122f18: 946c108f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122f1c: aa1503e0    	mov	x0, x21
106122f20: 946c108d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106122f24: eb1402ff    	cmp	x23, x20
106122f28: 54000161    	b.ne	0x106122f54 <_Flutter_MMFoundation_BindContext+0x25feb38>
106122f2c: b00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106122f30: f9460d01    	ldr	x1, [x8, #0xc18] ; selector=rejectIfNeedAnimation:
106122f34: aa1303e0    	mov	x0, x19
106122f38: 52800002    	mov	w2, #0x0                ; =0
106122f3c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
106122f40: a9434ff4    	ldp	x20, x19, [sp, #0x30]
106122f44: a94257f6    	ldp	x22, x21, [sp, #0x20]
106122f48: a9415ff8    	ldp	x24, x23, [sp, #0x10]
106122f4c: 910143ff    	add	sp, sp, #0x50
106122f50: 146c107b    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106122f54: a9447bfd    	ldp	x29, x30, [sp, #0x40]
106122f58: a9434ff4    	ldp	x20, x19, [sp, #0x30]
106122f5c: a94257f6    	ldp	x22, x21, [sp, #0x20]
106122f60: a9415ff8    	ldp	x24, x23, [sp, #0x10]
106122f64: 910143ff    	add	sp, sp, #0x50
106122f68: d65f03c0    	ret
