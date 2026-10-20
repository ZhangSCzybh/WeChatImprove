
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101759ba8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101759bac: a9017bfd    	stp	x29, x30, [sp, #0x10]
101759bb0: 910043fd    	add	x29, sp, #0x10
101759bb4: aa0003f3    	mov	x19, x0
101759bb8: f00f4d28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101759bbc: f9459501    	ldr	x1, [x8, #0xb28] ; data
101759bc0: aa0203e0    	mov	x0, x2
101759bc4: 9593355e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101759bc8: aa1d03fd    	mov	x29, x29
101759bcc: 9593355f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101759bd0: f00f54a8    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
101759bd4: b98d9d09    	ldrsw	x9, [x8, #0xd9c] ; ivar FTSGroupContactSectionController._contacts
101759bd8: f8696a68    	ldr	x8, [x19, x9]
101759bdc: f8296a60    	str	x0, [x19, x9]
101759be0: aa0803e0    	mov	x0, x8
101759be4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101759be8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101759bec: 1593355a    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
