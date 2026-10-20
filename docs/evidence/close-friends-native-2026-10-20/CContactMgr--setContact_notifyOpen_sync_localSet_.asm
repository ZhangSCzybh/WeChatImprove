
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fd1a6c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
100fd1a70: a90157f6    	stp	x22, x21, [sp, #0x10]
100fd1a74: a9024ff4    	stp	x20, x19, [sp, #0x20]
100fd1a78: a9037bfd    	stp	x29, x30, [sp, #0x30]
100fd1a7c: 9100c3fd    	add	x29, sp, #0x30
100fd1a80: aa0503f4    	mov	x20, x5
100fd1a84: aa0403f5    	mov	x21, x4
100fd1a88: aa0303f6    	mov	x22, x3
100fd1a8c: aa0203f3    	mov	x19, x2
100fd1a90: aa0003f7    	mov	x23, x0
100fd1a94: f00f7508    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
100fd1a98: f9456918    	ldr	x24, [x8, #0xad0] ; reportContactImportantChangeData:actionCode:actionScene:
100fd1a9c: aa0203e0    	mov	x0, x2
100fd1aa0: 95b155a6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100fd1aa4: aa1703e0    	mov	x0, x23
100fd1aa8: aa1803e1    	mov	x1, x24
100fd1aac: aa1303e2    	mov	x2, x19
100fd1ab0: 52800103    	mov	w3, #0x8                ; =8
100fd1ab4: 52800064    	mov	w4, #0x3                ; =3
100fd1ab8: 95b155a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fd1abc: f00f7468    	adrp	x8, 0x11fe60000 <dyld_stub_binder+0x11fe60000>
100fd1ac0: f9479101    	ldr	x1, [x8, #0xf20] ; isUseNewMuteFlag
100fd1ac4: aa1303e0    	mov	x0, x19
100fd1ac8: 95b1559d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fd1acc: d00f75a8    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fd1ad0: f940dd01    	ldr	x1, [x8, #0x1b8] ; setContact:typeBit:set:sync:localSet:
100fd1ad4: 340000c0    	cbz	w0, 0x100fd1aec <__text+0xfc9aec>
100fd1ad8: aa1703e0    	mov	x0, x23
100fd1adc: aa1303e2    	mov	x2, x19
100fd1ae0: 52b00003    	mov	w3, #-0x80000000        ; =-2147483648
100fd1ae4: aa1603e4    	mov	x4, x22
100fd1ae8: 14000005    	b	0x100fd1afc <__text+0xfc9afc>
100fd1aec: 520002c4    	eor	w4, w22, #0x1
100fd1af0: aa1703e0    	mov	x0, x23
100fd1af4: aa1303e2    	mov	x2, x19
100fd1af8: 52804003    	mov	w3, #0x200              ; =512
100fd1afc: aa1503e5    	mov	x5, x21
100fd1b00: aa1403e6    	mov	x6, x20
100fd1b04: 95b1558e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fd1b08: aa0003f4    	mov	x20, x0
100fd1b0c: aa1303e0    	mov	x0, x19
100fd1b10: 95b15591    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fd1b14: aa1403e0    	mov	x0, x20
100fd1b18: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100fd1b1c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100fd1b20: a94157f6    	ldp	x22, x21, [sp, #0x10]
100fd1b24: a8c45ff8    	ldp	x24, x23, [sp], #0x40
100fd1b28: d65f03c0    	ret
