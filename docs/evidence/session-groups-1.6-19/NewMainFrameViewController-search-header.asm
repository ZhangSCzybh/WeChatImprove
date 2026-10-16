
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105126124: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105126128: a9014ff4    	stp	x20, x19, [sp, #0x10]
10512612c: a9027bfd    	stp	x29, x30, [sp, #0x20]
105126130: 910083fd    	add	x29, sp, #0x20
105126134: aa0003f3    	mov	x19, x0
105126138: b00d68a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10512613c: f9478d14    	ldr	x20, [x8, #0xf18]
105126140: aa1403e1    	mov	x1, x20
105126144: 94ac03fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105126148: aa1d03fd    	mov	x29, x29
10512614c: 94ac03ff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105126150: aa0003f5    	mov	x21, x0
105126154: 94ac0400    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105126158: b4000275    	cbz	x21, 0x1051261a4 <_Flutter_MMFoundation_BindContext+0x1601d88>
10512615c: aa1303e0    	mov	x0, x19
105126160: aa1403e1    	mov	x1, x20
105126164: 94ac03f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105126168: aa1d03fd    	mov	x29, x29
10512616c: 94ac03f7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105126170: aa0003f4    	mov	x20, x0
105126174: d00d8808    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105126178: b9831908    	ldrsw	x8, [x8, #0x318]
10512617c: f8686a60    	ldr	x0, [x19, x8]
105126180: d00d68a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105126184: f940d901    	ldr	x1, [x8, #0x1b0]
105126188: aa1403e2    	mov	x2, x20
10512618c: 94ac03ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105126190: aa1403e0    	mov	x0, x20
105126194: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105126198: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10512619c: a8c357f6    	ldp	x22, x21, [sp], #0x30
1051261a0: 14ac03ed    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051261a4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1051261a8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1051261ac: a8c357f6    	ldp	x22, x21, [sp], #0x30
1051261b0: d65f03c0    	ret
