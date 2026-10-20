
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010617bc: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1010617c0: a9014ff4    	stp	x20, x19, [sp, #0x10]
1010617c4: a9027bfd    	stp	x29, x30, [sp, #0x20]
1010617c8: 910083fd    	add	x29, sp, #0x20
1010617cc: aa0303e2    	mov	x2, x3
1010617d0: aa0003f3    	mov	x19, x0
1010617d4: b00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010617d8: b9838508    	ldrsw	x8, [x8, #0x384] ; ivar ContactTagNewDetailViewController._contactsKeyArray
1010617dc: f8686800    	ldr	x0, [x0, x8]
1010617e0: b00f6ec8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1010617e4: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
1010617e8: 95af1655    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010617ec: aa1d03fd    	mov	x29, x29
1010617f0: 95af1656    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010617f4: aa0003f4    	mov	x20, x0
1010617f8: b00f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010617fc: b9838908    	ldrsw	x8, [x8, #0x388] ; ivar ContactTagNewDetailViewController._contactsDict
101061800: f8686a60    	ldr	x0, [x19, x8]
101061804: f00f8508    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101061808: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
10106180c: aa1403e2    	mov	x2, x20
101061810: 95af164b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101061814: aa1d03fd    	mov	x29, x29
101061818: 95af164c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10106181c: aa0003f3    	mov	x19, x0
101061820: f00f84e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101061824: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101061828: 95af1645    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10106182c: aa0003f5    	mov	x21, x0
101061830: aa1303e0    	mov	x0, x19
101061834: 95af1648    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101061838: aa1403e0    	mov	x0, x20
10106183c: 95af1646    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101061840: aa1503e0    	mov	x0, x21
101061844: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101061848: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10106184c: a8c357f6    	ldp	x22, x21, [sp], #0x30
101061850: d65f03c0    	ret
