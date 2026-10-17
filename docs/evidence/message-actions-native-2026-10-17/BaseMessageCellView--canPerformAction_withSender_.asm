
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a566c: d104c3ff    	sub	sp, sp, #0x130
1002a5670: a90d6ffc    	stp	x28, x27, [sp, #0xd0]
1002a5674: a90e67fa    	stp	x26, x25, [sp, #0xe0]
1002a5678: a90f5ff8    	stp	x24, x23, [sp, #0xf0]
1002a567c: a91057f6    	stp	x22, x21, [sp, #0x100]
1002a5680: a9114ff4    	stp	x20, x19, [sp, #0x110]
1002a5684: a9127bfd    	stp	x29, x30, [sp, #0x120]
1002a5688: 910483fd    	add	x29, sp, #0x120
1002a568c: aa0203f4    	mov	x20, x2
1002a5690: d00e9a48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a5694: f9405908    	ldr	x8, [x8, #0xb0]
1002a5698: f9400108    	ldr	x8, [x8]
1002a569c: f81a83a8    	stur	x8, [x29, #-0x58]
1002a56a0: 90104c48    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002a56a4: 52800029    	mov	w9, #0x1                ; =1
1002a56a8: 39312109    	strb	w9, [x8, #0xc48]
1002a56ac: 4f00e400    	movi.16b	v0, #0x0
1002a56b0: ad0003e0    	stp	q0, q0, [sp]
1002a56b4: ad0103e0    	stp	q0, q0, [sp, #0x20]
1002a56b8: d00ff9c8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002a56bc: 910ab108    	add	x8, x8, #0x2ac
1002a56c0: b9800108    	ldrsw	x8, [x8]
1002a56c4: f8686813    	ldr	x19, [x0, x8]
1002a56c8: aa1303e0    	mov	x0, x19
1002a56cc: 95e6069b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a56d0: f00ff2c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a56d4: f9435515    	ldr	x21, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1002a56d8: 910003e2    	mov	x2, sp
1002a56dc: 910123e3    	add	x3, sp, #0x48
1002a56e0: aa1503e1    	mov	x1, x21
1002a56e4: 52800204    	mov	w4, #0x10               ; =16
1002a56e8: 95e60695    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a56ec: b40003c0    	cbz	x0, 0x1002a5764 <__text+0x29d764>
1002a56f0: aa0003f6    	mov	x22, x0
1002a56f4: f9400be8    	ldr	x8, [sp, #0x10]
1002a56f8: f9400118    	ldr	x24, [x8]
1002a56fc: b00fdd39    	adrp	x25, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a5700: d280001a    	mov	x26, #0x0               ; =0
1002a5704: f9429737    	ldr	x23, [x25, #0x528] ; action
1002a5708: f9400be8    	ldr	x8, [sp, #0x10]
1002a570c: f9400108    	ldr	x8, [x8]
1002a5710: eb18011f    	cmp	x8, x24
1002a5714: 54000060    	b.eq	0x1002a5720 <__text+0x29d720>
1002a5718: aa1303e0    	mov	x0, x19
1002a571c: 95e6068d    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1002a5720: f94007e8    	ldr	x8, [sp, #0x8]
1002a5724: f87a7900    	ldr	x0, [x8, x26, lsl #3]
1002a5728: aa1703e1    	mov	x1, x23
1002a572c: 95e60684    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5730: eb14001f    	cmp	x0, x20
1002a5734: 540001c0    	b.eq	0x1002a576c <__text+0x29d76c>
1002a5738: 9100075a    	add	x26, x26, #0x1
1002a573c: eb1a02df    	cmp	x22, x26
1002a5740: 54fffe41    	b.ne	0x1002a5708 <__text+0x29d708>
1002a5744: 910003e2    	mov	x2, sp
1002a5748: 910123e3    	add	x3, sp, #0x48
1002a574c: aa1303e0    	mov	x0, x19
1002a5750: aa1503e1    	mov	x1, x21
1002a5754: 52800204    	mov	w4, #0x10               ; =16
1002a5758: 95e60679    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a575c: aa0003f6    	mov	x22, x0
1002a5760: b5fffd00    	cbnz	x0, 0x1002a5700 <__text+0x29d700>
1002a5764: 52800014    	mov	w20, #0x0               ; =0
1002a5768: 14000002    	b	0x1002a5770 <__text+0x29d770>
1002a576c: 52800034    	mov	w20, #0x1               ; =1
1002a5770: aa1303e0    	mov	x0, x19
1002a5774: 95e60678    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5778: f85a83a8    	ldur	x8, [x29, #-0x58]
1002a577c: d00e9a49    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a5780: f9405929    	ldr	x9, [x9, #0xb0]
1002a5784: f9400129    	ldr	x9, [x9]
1002a5788: eb08013f    	cmp	x9, x8
1002a578c: 54000141    	b.ne	0x1002a57b4 <__text+0x29d7b4>
1002a5790: aa1403e0    	mov	x0, x20
1002a5794: a9527bfd    	ldp	x29, x30, [sp, #0x120]
1002a5798: a9514ff4    	ldp	x20, x19, [sp, #0x110]
1002a579c: a95057f6    	ldp	x22, x21, [sp, #0x100]
1002a57a0: a94f5ff8    	ldp	x24, x23, [sp, #0xf0]
1002a57a4: a94e67fa    	ldp	x26, x25, [sp, #0xe0]
1002a57a8: a94d6ffc    	ldp	x28, x27, [sp, #0xd0]
1002a57ac: 9104c3ff    	add	sp, sp, #0x130
1002a57b0: d65f03c0    	ret
1002a57b4: 95e60670    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>