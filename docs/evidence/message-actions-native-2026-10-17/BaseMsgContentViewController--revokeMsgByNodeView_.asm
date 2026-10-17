
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1003115a4: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
1003115a8: a9015ff8    	stp	x24, x23, [sp, #0x10]
1003115ac: a90257f6    	stp	x22, x21, [sp, #0x20]
1003115b0: a9034ff4    	stp	x20, x19, [sp, #0x30]
1003115b4: a9047bfd    	stp	x29, x30, [sp, #0x40]
1003115b8: 910103fd    	add	x29, sp, #0x40
1003115bc: aa0203f3    	mov	x19, x2
1003115c0: aa0003f4    	mov	x20, x0
1003115c4: aa0203e0    	mov	x0, x2
1003115c8: 95e456dc    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1003115cc: d00ff668    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1003115d0: b9842519    	ldrsw	x25, [x8, #0x424]
1003115d4: 8b190280    	add	x0, x20, x25
1003115d8: 95e456ed    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1003115dc: b4000320    	cbz	x0, 0x100311640 <__text+0x309640>
1003115e0: aa0003f6    	mov	x22, x0
1003115e4: 8b190280    	add	x0, x20, x25
1003115e8: 95e456e9    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1003115ec: aa0003f7    	mov	x23, x0
1003115f0: b00fd9c8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1003115f4: f9473115    	ldr	x21, [x8, #0xe60] ; RevokeMsg:
1003115f8: b00fefa8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1003115fc: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
100311600: aa1503e2    	mov	x2, x21
100311604: 95e456ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100311608: aa0003f8    	mov	x24, x0
10031160c: aa1703e0    	mov	x0, x23
100311610: 95e456d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100311614: aa1603e0    	mov	x0, x22
100311618: 95e456cf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10031161c: 34000138    	cbz	w24, 0x100311640 <__text+0x309640>
100311620: 8b190280    	add	x0, x20, x25
100311624: 95e456da    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100311628: aa0003f4    	mov	x20, x0
10031162c: aa1503e1    	mov	x1, x21
100311630: aa1303e2    	mov	x2, x19
100311634: 95e456c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100311638: aa1403e0    	mov	x0, x20
10031163c: 95e456c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100311640: aa1303e0    	mov	x0, x19
100311644: a9447bfd    	ldp	x29, x30, [sp, #0x40]
100311648: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10031164c: a94257f6    	ldp	x22, x21, [sp, #0x20]
100311650: a9415ff8    	ldp	x24, x23, [sp, #0x10]
100311654: a8c567fa    	ldp	x26, x25, [sp], #0x50
100311658: 15e456bf    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>