
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1016a444c: d100c3ff    	sub	sp, sp, #0x30
1016a4450: a9014ff4    	stp	x20, x19, [sp, #0x10]
1016a4454: a9027bfd    	stp	x29, x30, [sp, #0x20]
1016a4458: 910083fd    	add	x29, sp, #0x20
1016a445c: aa0003f3    	mov	x19, x0
1016a4460: f00f58a8    	adrp	x8, 0x1201bb000 <dyld_stub_binder+0x1201bb000>
1016a4464: f945b908    	ldr	x8, [x8, #0xb70]
1016a4468: a90023e0    	stp	x0, x8, [sp]
1016a446c: d00f3cc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1016a4470: f9410d01    	ldr	x1, [x8, #0x218] ; prepareForReuse
1016a4474: 910003e0    	mov	x0, sp
1016a4478: 95960b33    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1016a447c: 900f5a68    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1016a4480: b9838908    	ldrsw	x8, [x8, #0x388]
1016a4484: f8686a60    	ldr	x0, [x19, x8]
1016a4488: 900f5328    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1016a448c: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
1016a4490: 52800022    	mov	w2, #0x1                ; =1
1016a4494: 95960b2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1016a4498: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1016a449c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1016a44a0: 9100c3ff    	add	sp, sp, #0x30
1016a44a4: d65f03c0    	ret
