
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10182a8d0: d10183ff    	sub	sp, sp, #0x60
10182a8d4: a90357f6    	stp	x22, x21, [sp, #0x30]
10182a8d8: a9044ff4    	stp	x20, x19, [sp, #0x40]
10182a8dc: a9057bfd    	stp	x29, x30, [sp, #0x50]
10182a8e0: 910143fd    	add	x29, sp, #0x50
10182a8e4: aa0003f3    	mov	x19, x0
10182a8e8: 900fa048    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
10182a8ec: 52800029    	mov	w9, #0x1                ; =1
10182a8f0: 392ced09    	strb	w9, [x8, #0xb3b]
10182a8f4: f9400c08    	ldr	x8, [x0, #0x18]
10182a8f8: f100051f    	cmp	x8, #0x1
10182a8fc: 540001c1    	b.ne	0x10182a934 <__text+0x1822934>
10182a900: b90023ff    	str	wzr, [sp, #0x20]
10182a904: 910083e8    	add	x8, sp, #0x20
10182a908: f90017e8    	str	x8, [sp, #0x28]
10182a90c: d00c5202    	adrp	x2, 0x11a26c000 <dyld_stub_binder+0x11a26c000>
10182a910: 91282842    	add	x2, x2, #0xa0a
10182a914: 91002260    	add	x0, x19, #0x8
10182a918: 910083e1    	add	x1, sp, #0x20
10182a91c: 9100a3e3    	add	x3, sp, #0x28
10182a920: 91009fe4    	add	x4, sp, #0x27
10182a924: 97ffa61f    	bl	0x1018141a0 <__text+0x180c1a0>
10182a928: b9402008    	ldr	w8, [x0, #0x20]
10182a92c: 7100251f    	cmp	w8, #0x9
10182a930: 540000c0    	b.eq	0x10182a948 <__text+0x1822948>
10182a934: f00f33e8    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10182a938: f941a101    	ldr	x1, [x8, #0x340] ; isLargeInputBox
10182a93c: aa1303e0    	mov	x0, x19
10182a940: 958ff1ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a944: 360001e0    	tbz	w0, #0x0, 0x10182a980 <__text+0x1822980>
10182a948: 900f33e8    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10182a94c: f9436901    	ldr	x1, [x8, #0x6d0] ; searchBarText
10182a950: aa1303e0    	mov	x0, x19
10182a954: 958ff1fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a958: aa1d03fd    	mov	x29, x29
10182a95c: 958ff1fb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a960: aa0003f4    	mov	x20, x0
10182a964: f00f33e8    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10182a968: f940f901    	ldr	x1, [x8, #0x1f0] ; directJumpToResultPage:isFromNewVoiceInput:
10182a96c: aa1303e0    	mov	x0, x19
10182a970: aa1403e2    	mov	x2, x20
10182a974: 52800003    	mov	w3, #0x0                ; =0
10182a978: 958ff1f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a97c: 14000040    	b	0x10182aa7c <__text+0x1822a7c>
10182a980: f9400e68    	ldr	x8, [x19, #0x18]
10182a984: b40001c8    	cbz	x8, 0x10182a9bc <__text+0x18229bc>
10182a988: b90023ff    	str	wzr, [sp, #0x20]
10182a98c: 910083e8    	add	x8, sp, #0x20
10182a990: f90017e8    	str	x8, [sp, #0x28]
10182a994: d00c5202    	adrp	x2, 0x11a26c000 <dyld_stub_binder+0x11a26c000>
10182a998: 91282842    	add	x2, x2, #0xa0a
10182a99c: 91002260    	add	x0, x19, #0x8
10182a9a0: 910083e1    	add	x1, sp, #0x20
10182a9a4: 9100a3e3    	add	x3, sp, #0x28
10182a9a8: 91009fe4    	add	x4, sp, #0x27
10182a9ac: 97ffa5fd    	bl	0x1018141a0 <__text+0x180c1a0>
10182a9b0: b9402009    	ldr	w9, [x0, #0x20]
10182a9b4: b9401a68    	ldr	w8, [x19, #0x18]
10182a9b8: 14000002    	b	0x10182a9c0 <__text+0x18229c0>
10182a9bc: 52800009    	mov	w9, #0x0                ; =0
10182a9c0: b00f4a4a    	adrp	x10, 0x120173000 <dyld_stub_binder+0x120173000>
10182a9c4: f9453540    	ldr	x0, [x10, #0xa68]
10182a9c8: f00f306a    	adrp	x10, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10182a9cc: f942a941    	ldr	x1, [x10, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10182a9d0: f00e6b6a    	adrp	x10, 0x11e599000 <dyld_stub_binder+0x11e599000>
10182a9d4: 9126214a    	add	x10, x10, #0x988
10182a9d8: a900a7e8    	stp	x8, x9, [sp, #0x8]
10182a9dc: d00cd243    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10182a9e0: 91388063    	add	x3, x3, #0xe20
10182a9e4: b00cde25    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10182a9e8: 912160a5    	add	x5, x5, #0x858
10182a9ec: f90003ea    	str	x10, [sp]
10182a9f0: b00cde27    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10182a9f4: 913fb4e7    	add	x7, x7, #0xfed
10182a9f8: 52800055    	mov	w21, #0x2               ; =2
10182a9fc: 52800042    	mov	w2, #0x2                ; =2
10182aa00: 52800004    	mov	w4, #0x0                ; =0
10182aa04: 5280c306    	mov	w6, #0x618              ; =1560
10182aa08: 958ff1cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182aa0c: b00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182aa10: f9454514    	ldr	x20, [x8, #0xa88]
10182aa14: 900f33e8    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10182aa18: f9436901    	ldr	x1, [x8, #0x6d0] ; searchBarText
10182aa1c: aa1303e0    	mov	x0, x19
10182aa20: 958ff1c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182aa24: aa1d03fd    	mov	x29, x29
10182aa28: 958ff1c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182aa2c: aa0003f3    	mov	x19, x0
10182aa30: 900f4708    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10182aa34: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
10182aa38: a90083f5    	stp	x21, x0, [sp, #0x8]
10182aa3c: 52800028    	mov	w8, #0x1                ; =1
10182aa40: f90003e8    	str	x8, [sp]
10182aa44: b00e6402    	adrp	x2, 0x11e4ab000 <dyld_stub_binder+0x11e4ab000>
10182aa48: 91122042    	add	x2, x2, #0x488
10182aa4c: aa1403e0    	mov	x0, x20
10182aa50: 958ff1bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182aa54: aa1d03fd    	mov	x29, x29
10182aa58: 958ff1bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182aa5c: aa0003f4    	mov	x20, x0
10182aa60: aa1303e0    	mov	x0, x19
10182aa64: 958ff1bc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182aa68: 5287b400    	mov	w0, #0x3da0             ; =15776
10182aa6c: aa1403e1    	mov	x1, x20
10182aa70: 52800002    	mov	w2, #0x0                ; =0
10182aa74: 52800003    	mov	w3, #0x0                ; =0
10182aa78: 9429089a    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
10182aa7c: aa1403e0    	mov	x0, x20
10182aa80: 958ff1b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182aa84: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10182aa88: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10182aa8c: a94357f6    	ldp	x22, x21, [sp, #0x30]
10182aa90: 910183ff    	add	sp, sp, #0x60
10182aa94: d65f03c0    	ret
