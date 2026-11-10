
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a98b8: d101c3ff    	sub	sp, sp, #0x70
1002a98bc: a9035ff8    	stp	x24, x23, [sp, #0x30]
1002a98c0: a90457f6    	stp	x22, x21, [sp, #0x40]
1002a98c4: a9054ff4    	stp	x20, x19, [sp, #0x50]
1002a98c8: a9067bfd    	stp	x29, x30, [sp, #0x60]
1002a98cc: 910183fd    	add	x29, sp, #0x60
1002a98d0: aa0203f3    	mov	x19, x2
1002a98d4: aa0003f4    	mov	x20, x0
1002a98d8: f00fa4a8    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002a98dc: 52800029    	mov	w9, #0x1                ; =1
1002a98e0: 3923c509    	strb	w9, [x8, #0x8f1]
1002a98e4: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a98e8: f943c100    	ldr	x0, [x8, #0x780]
1002a98ec: 900f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a98f0: f9440101    	ldr	x1, [x8, #0x800]
1002a98f4: 95e5f8dc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a98f8: aa1d03fd    	mov	x29, x29
1002a98fc: 95e5f8e1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002a9900: aa0003f5    	mov	x21, x0
1002a9904: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9908: f9444500    	ldr	x0, [x8, #0x888]
1002a990c: b00f4fe8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002a9910: f9428501    	ldr	x1, [x8, #0x508]
1002a9914: 95e5f8d4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9918: aa0003e2    	mov	x2, x0
1002a991c: 900f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a9920: f9452101    	ldr	x1, [x8, #0xa40]
1002a9924: aa1503e0    	mov	x0, x21
1002a9928: 95e5f8cf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a992c: aa1d03fd    	mov	x29, x29
1002a9930: 95e5f8d4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002a9934: aa0003f6    	mov	x22, x0
1002a9938: b00f3908    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
1002a993c: f9437901    	ldr	x1, [x8, #0x6f0]
1002a9940: 95e5f8c9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9944: aa1d03fd    	mov	x29, x29
1002a9948: 95e5f8ce    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002a994c: aa0003f7    	mov	x23, x0
1002a9950: f00ea508    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002a9954: f9449908    	ldr	x8, [x8, #0x930]
1002a9958: f90003e8    	str	x8, [sp]
1002a995c: d00bb0e8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1002a9960: fd434100    	ldr	d0, [x8, #0x680]
1002a9964: fd0007e0    	str	d0, [sp, #0x8]
1002a9968: 90000008    	adrp	x8, 0x1002a9000 <__text+0x2a1000>
1002a996c: 9126f108    	add	x8, x8, #0x9bc
1002a9970: f00dfea9    	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
1002a9974: 9121c129    	add	x9, x9, #0x870
1002a9978: a90127e8    	stp	x8, x9, [sp, #0x10]
1002a997c: f90013f4    	str	x20, [sp, #0x20]
1002a9980: b9002bf3    	str	w19, [sp, #0x28]
1002a9984: 910003e1    	mov	x1, sp
1002a9988: 95e58c85    	bl	0x107c0cb9c <_Flutter_MMFoundation_BindContext+0x3e93868>
1002a998c: aa1703e0    	mov	x0, x23
1002a9990: 95e5f8b8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a9994: aa1603e0    	mov	x0, x22
1002a9998: 95e5f8b6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a999c: aa1503e0    	mov	x0, x21
1002a99a0: 95e5f8b4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a99a4: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1002a99a8: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1002a99ac: a94457f6    	ldp	x22, x21, [sp, #0x40]
1002a99b0: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1002a99b4: 9101c3ff    	add	sp, sp, #0x70
1002a99b8: d65f03c0    	ret
1002a99bc: d10103ff    	sub	sp, sp, #0x40
1002a99c0: a9037bfd    	stp	x29, x30, [sp, #0x30]
1002a99c4: 9100c3fd    	add	x29, sp, #0x30
1002a99c8: f00ea508    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002a99cc: f9449908    	ldr	x8, [x8, #0x930]
1002a99d0: f90003e8    	str	x8, [sp]
1002a99d4: d00bb0e8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1002a99d8: fd434100    	ldr	d0, [x8, #0x680]
1002a99dc: fd0007e0    	str	d0, [sp, #0x8]
1002a99e0: 90000008    	adrp	x8, 0x1002a9000 <__text+0x2a1000>
1002a99e4: 91292108    	add	x8, x8, #0xa48
1002a99e8: f00dfea9    	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
1002a99ec: 9121c129    	add	x9, x9, #0x870
1002a99f0: a90127e8    	stp	x8, x9, [sp, #0x10]
1002a99f4: f9401008    	ldr	x8, [x0, #0x20]
1002a99f8: f90013e8    	str	x8, [sp, #0x20]
1002a99fc: b9402808    	ldr	w8, [x0, #0x28]
1002a9a00: b9002be8    	str	w8, [sp, #0x28]
1002a9a04: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9a08: f9447d00    	ldr	x0, [x8, #0x8f8]
1002a9a0c: f00f4fe8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1002a9a10: f9446501    	ldr	x1, [x8, #0x8c8]
1002a9a14: 95e5f894    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9a18: 340000a0    	cbz	w0, 0x1002a9a2c <__text+0x2a1a2c>
1002a9a1c: f9400be8    	ldr	x8, [sp, #0x10]
1002a9a20: 910003e0    	mov	x0, sp
1002a9a24: d63f0100    	blr	x8
1002a9a28: 14000005    	b	0x1002a9a3c <__text+0x2a1a3c>
1002a9a2c: f00ea500    	adrp	x0, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002a9a30: f9454c00    	ldr	x0, [x0, #0xa98]
1002a9a34: 910003e1    	mov	x1, sp
1002a9a38: 95e58c59    	bl	0x107c0cb9c <_Flutter_MMFoundation_BindContext+0x3e93868>
1002a9a3c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1002a9a40: 910103ff    	add	sp, sp, #0x40
1002a9a44: d65f03c0    	ret
1002a9a48: aa0003e8    	mov	x8, x0
1002a9a4c: f9401000    	ldr	x0, [x0, #0x20]
1002a9a50: f9400409    	ldr	x9, [x0, #0x8]
1002a9a54: b4000349    	cbz	x9, 0x1002a9abc <__text+0x2a1abc>
1002a9a58: 3941c129    	ldrb	w9, [x9, #0x70]
1002a9a5c: 7100053f    	cmp	w9, #0x1
1002a9a60: 540002e1    	b.ne	0x1002a9abc <__text+0x2a1abc>
1002a9a64: d10083ff    	sub	sp, sp, #0x20
1002a9a68: a9017bfd    	stp	x29, x30, [sp, #0x10]
1002a9a6c: 910043fd    	add	x29, sp, #0x10
1002a9a70: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9a74: f9430d00    	ldr	x0, [x8, #0x618]
1002a9a78: 900f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a9a7c: f9418901    	ldr	x1, [x8, #0x310]
1002a9a80: 900e68a8    	adrp	x8, 0x11cfbd000 <dyld_stub_binder+0x11cfbd000>
1002a9a84: 911e6108    	add	x8, x8, #0x798
1002a9a88: f90003e8    	str	x8, [sp]
1002a9a8c: 900cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9a90: 9120a4a5    	add	x5, x5, #0x829
1002a9a94: 900cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9a98: 912efce7    	add	x7, x7, #0xbbf
1002a9a9c: 52800062    	mov	w2, #0x3                ; =3
1002a9aa0: d2800003    	mov	x3, #0x0                ; =0
1002a9aa4: 52800004    	mov	w4, #0x0                ; =0
1002a9aa8: 52803fe6    	mov	w6, #0x1ff              ; =511
1002a9aac: 95e5f86e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9ab0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1002a9ab4: 910083ff    	add	sp, sp, #0x20
1002a9ab8: d65f03c0    	ret
1002a9abc: b9402902    	ldr	w2, [x8, #0x28]
1002a9ac0: 900f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a9ac4: f9456d01    	ldr	x1, [x8, #0xad8]
1002a9ac8: 15e5f867    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
