
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017bc658: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1017bc65c: a9014ff4    	stp	x20, x19, [sp, #0x10]
1017bc660: a9027bfd    	stp	x29, x30, [sp, #0x20]
1017bc664: 910083fd    	add	x29, sp, #0x20
1017bc668: aa0003f3    	mov	x19, x0
1017bc66c: b00f3768    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017bc670: f945e914    	ldr	x20, [x8, #0xbd0] ; arrSessionResult
1017bc674: aa1403e1    	mov	x1, x20
1017bc678: 9591aab1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017bc67c: aa1d03fd    	mov	x29, x29
1017bc680: 9591aab2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017bc684: aa0003f5    	mov	x21, x0
1017bc688: 9591aab3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017bc68c: b00f3768    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017bc690: f945ed08    	ldr	x8, [x8, #0xbd8] ; arrMsgItems
1017bc694: f10002bf    	cmp	x21, #0x0
1017bc698: 9a940101    	csel	x1, x8, x20, eq
1017bc69c: aa1303e0    	mov	x0, x19
1017bc6a0: 9591aaa7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017bc6a4: aa1d03fd    	mov	x29, x29
1017bc6a8: 9591aaa8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017bc6ac: aa0003f3    	mov	x19, x0
1017bc6b0: 900f4a28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1017bc6b4: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1017bc6b8: 9591aaa1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017bc6bc: aa0003f4    	mov	x20, x0
1017bc6c0: aa1303e0    	mov	x0, x19
1017bc6c4: 9591aaa4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017bc6c8: aa1403e0    	mov	x0, x20
1017bc6cc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1017bc6d0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1017bc6d4: a8c357f6    	ldp	x22, x21, [sp], #0x30
1017bc6d8: d65f03c0    	ret
