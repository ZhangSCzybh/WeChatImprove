
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100335424: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
100335428: a9015ff8    	stp	x24, x23, [sp, #0x10]
10033542c: a90257f6    	stp	x22, x21, [sp, #0x20]
100335430: a9034ff4    	stp	x20, x19, [sp, #0x30]
100335434: a9047bfd    	stp	x29, x30, [sp, #0x40]
100335438: 910103fd    	add	x29, sp, #0x40
10033543c: aa0303f4    	mov	x20, x3
100335440: aa0203f3    	mov	x19, x2
100335444: aa0003f5    	mov	x21, x0
100335448: f00fa048    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
10033544c: 52800029    	mov	w9, #0x1                ; =1
100335450: 392b2d09    	strb	w9, [x8, #0xacb]
100335454: aa0203e0    	mov	x0, x2
100335458: 95e3ca07    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10033545c: aa1403e0    	mov	x0, x20
100335460: 95e3ca05    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100335464: b00f5248    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
100335468: b98df508    	ldrsw	x8, [x8, #0xdf4]
10033546c: 8b0802b7    	add	x23, x21, x8
100335470: f94006e8    	ldr	x8, [x23, #0x8]
100335474: f00f34b6    	adrp	x22, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100335478: b4000128    	cbz	x8, 0x10033549c <__text+0x32d49c>
10033547c: f94276c1    	ldr	x1, [x22, #0x4e8]
100335480: aa1403e0    	mov	x0, x20
100335484: 95e3c9f8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100335488: a94026e8    	ldp	x8, x9, [x23]
10033548c: eb080008    	subs	x8, x0, x8
100335490: 9e6703e8    	fmov	d8, xzr
100335494: fa492102    	ccmp	x8, x9, #0x2, hs
100335498: 54000623    	b.lo	0x10033555c <__text+0x32d55c>
10033549c: b00f5248    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1003354a0: b98cf518    	ldrsw	x24, [x8, #0xcf4]
1003354a4: f8786aa0    	ldr	x0, [x21, x24]
1003354a8: 9e6703e8    	fmov	d8, xzr
1003354ac: b4000580    	cbz	x0, 0x10033555c <__text+0x32d55c>
1003354b0: b00f4b88    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1003354b4: f9442901    	ldr	x1, [x8, #0x850]
1003354b8: 95e3c9eb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003354bc: aa0003f7    	mov	x23, x0
1003354c0: f94276d6    	ldr	x22, [x22, #0x4e8]
1003354c4: aa1403e0    	mov	x0, x20
1003354c8: aa1603e1    	mov	x1, x22
1003354cc: 95e3c9e6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003354d0: eb0002ff    	cmp	x23, x0
1003354d4: 54000449    	b.ls	0x10033555c <__text+0x32d55c>
1003354d8: f8786ab5    	ldr	x21, [x21, x24]
1003354dc: aa1403e0    	mov	x0, x20
1003354e0: aa1603e1    	mov	x1, x22
1003354e4: 95e3c9e0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003354e8: aa0003e2    	mov	x2, x0
1003354ec: 900f4ba8    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
1003354f0: f9431101    	ldr	x1, [x8, #0x620]
1003354f4: aa1503e0    	mov	x0, x21
1003354f8: 95e3c9db    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003354fc: aa1d03fd    	mov	x29, x29
100335500: 95e3c9e0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100335504: aa0003f5    	mov	x21, x0
100335508: b4000260    	cbz	x0, 0x100335554 <__text+0x32d554>
10033550c: 900f34a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100335510: f9450d01    	ldr	x1, [x8, #0xa18]
100335514: aa1403e0    	mov	x0, x20
100335518: 95e3c9d3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10033551c: aa0003e2    	mov	x2, x0
100335520: b00f3528    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
100335524: f945ad01    	ldr	x1, [x8, #0xb58]
100335528: aa1503e0    	mov	x0, x21
10033552c: 95e3c9ce    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100335530: aa1d03fd    	mov	x29, x29
100335534: 95e3c9d3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100335538: aa0003f6    	mov	x22, x0
10033553c: 900f34e8    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
100335540: f9436901    	ldr	x1, [x8, #0x6d0]
100335544: 95e3c9c8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100335548: 4ea01c08    	mov.16b	v8, v0
10033554c: aa1603e0    	mov	x0, x22
100335550: 95e3c9c8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100335554: aa1503e0    	mov	x0, x21
100335558: 95e3c9c6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10033555c: aa1403e0    	mov	x0, x20
100335560: 95e3c9c4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100335564: aa1303e0    	mov	x0, x19
100335568: 95e3c9c2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10033556c: 4ea81d00    	mov.16b	v0, v8
100335570: a9447bfd    	ldp	x29, x30, [sp, #0x40]
100335574: a9434ff4    	ldp	x20, x19, [sp, #0x30]
100335578: a94257f6    	ldp	x22, x21, [sp, #0x20]
10033557c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
100335580: 6cc523e9    	ldp	d9, d8, [sp], #0x50
100335584: d65f03c0    	ret
