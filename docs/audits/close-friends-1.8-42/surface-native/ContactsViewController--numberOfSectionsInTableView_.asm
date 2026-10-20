
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010e830c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1010e8310: a9014ff4    	stp	x20, x19, [sp, #0x10]
1010e8314: a9027bfd    	stp	x29, x30, [sp, #0x20]
1010e8318: 910083fd    	add	x29, sp, #0x20
1010e831c: aa0003f3    	mov	x19, x0
1010e8320: b00fda48    	adrp	x8, 0x120c31000 <dyld_stub_binder+0x120c31000>
1010e8324: 52800029    	mov	w9, #0x1                ; =1
1010e8328: 39013509    	strb	w9, [x8, #0x4d]
1010e832c: d00f8808    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010e8330: b98a6d08    	ldrsw	x8, [x8, #0xa6c] ; ivar ContactsViewController.m_contactsDataLogic
1010e8334: f8686800    	ldr	x0, [x0, x8]
1010e8338: d00f6b68    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1010e833c: f942d901    	ldr	x1, [x8, #0x5b0] ; getKeysArray
1010e8340: 95acfb7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e8344: aa1d03fd    	mov	x29, x29
1010e8348: 95acfb80    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010e834c: aa0003f4    	mov	x20, x0
1010e8350: 900f80c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010e8354: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1010e8358: 95acfb79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e835c: aa0003f5    	mov	x21, x0
1010e8360: aa1403e0    	mov	x0, x20
1010e8364: 95acfb7c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010e8368: f00f6d08    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010e836c: f9441901    	ldr	x1, [x8, #0x830] ; HasHelloGroup
1010e8370: aa1303e0    	mov	x0, x19
1010e8374: 95acfb72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e8378: 8b2042b4    	add	x20, x21, w0, uxtw
1010e837c: f00f6d08    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010e8380: f9441d01    	ldr	x1, [x8, #0x838] ; HasBrandGroup
1010e8384: aa1303e0    	mov	x0, x19
1010e8388: 95acfb6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e838c: 8b204294    	add	x20, x20, w0, uxtw
1010e8390: f00f6d08    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010e8394: f9442101    	ldr	x1, [x8, #0x840] ; HasServiceBrandGroup
1010e8398: aa1303e0    	mov	x0, x19
1010e839c: 95acfb68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e83a0: 8b204294    	add	x20, x20, w0, uxtw
1010e83a4: f00f6d08    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010e83a8: f9442901    	ldr	x1, [x8, #0x850] ; HasOpenIMEntrance
1010e83ac: aa1303e0    	mov	x0, x19
1010e83b0: 95acfb63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e83b4: 8b204294    	add	x20, x20, w0, uxtw
1010e83b8: f00f6d08    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010e83bc: f9442501    	ldr	x1, [x8, #0x848] ; HasEnterpriseBrandGroup
1010e83c0: aa1303e0    	mov	x0, x19
1010e83c4: 95acfb5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010e83c8: 8b204280    	add	x0, x20, w0, uxtw
1010e83cc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1010e83d0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1010e83d4: a8c357f6    	ldp	x22, x21, [sp], #0x30
1010e83d8: d65f03c0    	ret
