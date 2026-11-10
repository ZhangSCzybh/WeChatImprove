
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002b3428: d10503ff    	sub	sp, sp, #0x140
1002b342c: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
1002b3430: a90f67fa    	stp	x26, x25, [sp, #0xf0]
1002b3434: a9105ff8    	stp	x24, x23, [sp, #0x100]
1002b3438: a91157f6    	stp	x22, x21, [sp, #0x110]
1002b343c: a9124ff4    	stp	x20, x19, [sp, #0x120]
1002b3440: a9137bfd    	stp	x29, x30, [sp, #0x130]
1002b3444: 9104c3fd    	add	x29, sp, #0x130
1002b3448: aa0203f3    	mov	x19, x2
1002b344c: b00ea4c8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002b3450: f9451908    	ldr	x8, [x8, #0xa30]
1002b3454: f9400108    	ldr	x8, [x8]
1002b3458: f81a03a8    	stur	x8, [x29, #-0x60]
1002b345c: b00fa468    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002b3460: 52800029    	mov	w9, #0x1                ; =1
1002b3464: 39245909    	strb	w9, [x8, #0x916]
1002b3468: aa0203e0    	mov	x0, x2
1002b346c: 95e5d202    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1002b3470: f00f52e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002b3474: f9432d14    	ldr	x20, [x8, #0x658]
1002b3478: f00f4f88    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002b347c: f9442901    	ldr	x1, [x8, #0x850]
1002b3480: aa1303e0    	mov	x0, x19
1002b3484: 95e5d1f8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b3488: aa0003e2    	mov	x2, x0
1002b348c: d00f4f88    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
1002b3490: f946d501    	ldr	x1, [x8, #0xda8]
1002b3494: aa1403e0    	mov	x0, x20
1002b3498: 95e5d1f3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b349c: aa1d03fd    	mov	x29, x29
1002b34a0: 95e5d1f8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002b34a4: f90007e0    	str	x0, [sp, #0x8]
1002b34a8: 900f5308    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1002b34ac: f944bd00    	ldr	x0, [x8, #0x978]
1002b34b0: b00f38e8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
1002b34b4: f9470101    	ldr	x1, [x8, #0xe00]
1002b34b8: 95e5d1eb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b34bc: aa1d03fd    	mov	x29, x29
1002b34c0: 95e5d1f0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002b34c4: aa0003f5    	mov	x21, x0
1002b34c8: 4f00e400    	movi.16b	v0, #0x0
1002b34cc: ad0083e0    	stp	q0, q0, [sp, #0x10]
1002b34d0: ad0183e0    	stp	q0, q0, [sp, #0x30]
1002b34d4: aa1303e0    	mov	x0, x19
1002b34d8: 95e5d1e7    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1002b34dc: f00f4f88    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002b34e0: f9442d01    	ldr	x1, [x8, #0x858]
1002b34e4: 910043e2    	add	x2, sp, #0x10
1002b34e8: 910143e3    	add	x3, sp, #0x50
1002b34ec: aa1303f4    	mov	x20, x19
1002b34f0: f90003e1    	str	x1, [sp]
1002b34f4: 52800204    	mov	w4, #0x10               ; =16
1002b34f8: 95e5d1db    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b34fc: b4000660    	cbz	x0, 0x1002b35c8 <__text+0x2ab5c8>
1002b3500: aa0003f7    	mov	x23, x0
1002b3504: f94013e8    	ldr	x8, [sp, #0x20]
1002b3508: f9400116    	ldr	x22, [x8]
1002b350c: d2800013    	mov	x19, #0x0               ; =0
1002b3510: 900f38e8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
1002b3514: f9439518    	ldr	x24, [x8, #0x728]
1002b3518: f00f4f88    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002b351c: f9439519    	ldr	x25, [x8, #0x728]
1002b3520: d00f4f88    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
1002b3524: f944f91a    	ldr	x26, [x8, #0x9f0]
1002b3528: f00f38a8    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
1002b352c: f942c11b    	ldr	x27, [x8, #0x580]
1002b3530: f94013e8    	ldr	x8, [sp, #0x20]
1002b3534: f9400108    	ldr	x8, [x8]
1002b3538: eb16011f    	cmp	x8, x22
1002b353c: 54000060    	b.eq	0x1002b3548 <__text+0x2ab548>
1002b3540: aa1403e0    	mov	x0, x20
1002b3544: 95e5d1be    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
1002b3548: f9400fe8    	ldr	x8, [sp, #0x18]
1002b354c: f873791c    	ldr	x28, [x8, x19, lsl #3]
1002b3550: aa1c03e0    	mov	x0, x28
1002b3554: aa1803e1    	mov	x1, x24
1002b3558: 95e5d1c3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b355c: aa0003e2    	mov	x2, x0
1002b3560: aa1503e0    	mov	x0, x21
1002b3564: aa1903e1    	mov	x1, x25
1002b3568: 95e5d1bf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b356c: 37000180    	tbnz	w0, #0x0, 0x1002b359c <__text+0x2ab59c>
1002b3570: aa1c03e0    	mov	x0, x28
1002b3574: aa1803e1    	mov	x1, x24
1002b3578: 95e5d1bb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b357c: aa0003e2    	mov	x2, x0
1002b3580: aa1503e0    	mov	x0, x21
1002b3584: aa1a03e1    	mov	x1, x26
1002b3588: 95e5d1b7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b358c: f94007e0    	ldr	x0, [sp, #0x8]
1002b3590: aa1b03e1    	mov	x1, x27
1002b3594: aa1c03e2    	mov	x2, x28
1002b3598: 95e5d1b3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b359c: 91000673    	add	x19, x19, #0x1
1002b35a0: eb1302ff    	cmp	x23, x19
1002b35a4: 54fffc61    	b.ne	0x1002b3530 <__text+0x2ab530>
1002b35a8: 910043e2    	add	x2, sp, #0x10
1002b35ac: 910143e3    	add	x3, sp, #0x50
1002b35b0: aa1403e0    	mov	x0, x20
1002b35b4: f94003e1    	ldr	x1, [sp]
1002b35b8: 52800204    	mov	w4, #0x10               ; =16
1002b35bc: 95e5d1aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b35c0: aa0003f7    	mov	x23, x0
1002b35c4: b5fffa40    	cbnz	x0, 0x1002b350c <__text+0x2ab50c>
1002b35c8: aa1403e0    	mov	x0, x20
1002b35cc: 95e5d1a9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002b35d0: aa1503e0    	mov	x0, x21
1002b35d4: 95e5d1a7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002b35d8: aa1403e0    	mov	x0, x20
1002b35dc: 95e5d1a5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002b35e0: f85a03a8    	ldur	x8, [x29, #-0x60]
1002b35e4: b00ea4c9    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002b35e8: f9451929    	ldr	x9, [x9, #0xa30]
1002b35ec: f9400129    	ldr	x9, [x9]
1002b35f0: eb08013f    	cmp	x9, x8
1002b35f4: 54000141    	b.ne	0x1002b361c <__text+0x2ab61c>
1002b35f8: f94007e0    	ldr	x0, [sp, #0x8]
1002b35fc: a9537bfd    	ldp	x29, x30, [sp, #0x130]
1002b3600: a9524ff4    	ldp	x20, x19, [sp, #0x120]
1002b3604: a95157f6    	ldp	x22, x21, [sp, #0x110]
1002b3608: a9505ff8    	ldp	x24, x23, [sp, #0x100]
1002b360c: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
1002b3610: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
1002b3614: 910503ff    	add	sp, sp, #0x140
1002b3618: 15e5d182    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
1002b361c: 95e5d045    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
