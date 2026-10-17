
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1001764e0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1001764e4: a9017bfd    	stp	x29, x30, [sp, #0x10]
1001764e8: 910043fd    	add	x29, sp, #0x10
1001764ec: aa0003f3    	mov	x19, x0
1001764f0: 90100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
1001764f4: b9829508    	ldrsw	x8, [x8, #0x294]
1001764f8: f8686800    	ldr	x0, [x0, x8]
1001764fc: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100176500: f9447d14    	ldr	x20, [x8, #0x8f8] ; Start
100176504: aa1403e1    	mov	x1, x20
100176508: 95eac30d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017650c: 90100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
100176510: b982a508    	ldrsw	x8, [x8, #0x2a4]
100176514: f8686a60    	ldr	x0, [x19, x8]
100176518: aa1403e1    	mov	x1, x20
10017651c: 95eac308    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176520: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100176524: f9447501    	ldr	x1, [x8, #0x8e8] ; bypUploader
100176528: aa1303e0    	mov	x0, x19
10017652c: 95eac304    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176530: aa1d03fd    	mov	x29, x29
100176534: 95eac305    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100176538: aa0003f3    	mov	x19, x0
10017653c: aa1403e1    	mov	x1, x20
100176540: 95eac2ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176544: aa1303e0    	mov	x0, x19
100176548: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10017654c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100176550: 15eac301    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>