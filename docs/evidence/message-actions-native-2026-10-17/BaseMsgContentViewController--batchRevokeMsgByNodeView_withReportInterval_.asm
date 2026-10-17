
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10031165c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
100311660: a9015ff8    	stp	x24, x23, [sp, #0x10]
100311664: a90257f6    	stp	x22, x21, [sp, #0x20]
100311668: a9034ff4    	stp	x20, x19, [sp, #0x30]
10031166c: a9047bfd    	stp	x29, x30, [sp, #0x40]
100311670: 910103fd    	add	x29, sp, #0x40
100311674: aa0303f4    	mov	x20, x3
100311678: aa0203f3    	mov	x19, x2
10031167c: aa0003f5    	mov	x21, x0
100311680: aa0203e0    	mov	x0, x2
100311684: 95e456ad    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100311688: d00ff668    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10031168c: b984251a    	ldrsw	x26, [x8, #0x424]
100311690: 8b1a02a0    	add	x0, x21, x26
100311694: 95e456be    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100311698: b4000340    	cbz	x0, 0x100311700 <__text+0x309700>
10031169c: aa0003f7    	mov	x23, x0
1003116a0: 8b1a02a0    	add	x0, x21, x26
1003116a4: 95e456ba    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1003116a8: aa0003f8    	mov	x24, x0
1003116ac: 900fd9e8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
1003116b0: f946c116    	ldr	x22, [x8, #0xd80] ; BatchRevokeMsg:withReportInterval:
1003116b4: b00fefa8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1003116b8: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
1003116bc: aa1603e2    	mov	x2, x22
1003116c0: 95e4569f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1003116c4: aa0003f9    	mov	x25, x0
1003116c8: aa1803e0    	mov	x0, x24
1003116cc: 95e456a2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1003116d0: aa1703e0    	mov	x0, x23
1003116d4: 95e456a0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1003116d8: 34000159    	cbz	w25, 0x100311700 <__text+0x309700>
1003116dc: 8b1a02a0    	add	x0, x21, x26
1003116e0: 95e456ab    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1003116e4: aa0003f5    	mov	x21, x0
1003116e8: aa1603e1    	mov	x1, x22
1003116ec: aa1303e2    	mov	x2, x19
1003116f0: aa1403e3    	mov	x3, x20
1003116f4: 95e45692    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1003116f8: aa1503e0    	mov	x0, x21
1003116fc: 95e45696    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100311700: aa1303e0    	mov	x0, x19
100311704: a9447bfd    	ldp	x29, x30, [sp, #0x40]
100311708: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10031170c: a94257f6    	ldp	x22, x21, [sp, #0x20]
100311710: a9415ff8    	ldp	x24, x23, [sp, #0x10]
100311714: a8c567fa    	ldp	x26, x25, [sp], #0x50
100311718: 15e4568f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>