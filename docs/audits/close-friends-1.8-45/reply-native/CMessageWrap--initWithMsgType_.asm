
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9c5ac: d10103ff    	sub	sp, sp, #0x40
104b9c5b0: a90157f6    	stp	x22, x21, [sp, #0x10]
104b9c5b4: a9024ff4    	stp	x20, x19, [sp, #0x20]
104b9c5b8: a9037bfd    	stp	x29, x30, [sp, #0x30]
104b9c5bc: 9100c3fd    	add	x29, sp, #0x30
104b9c5c0: aa0203f3    	mov	x19, x2
104b9c5c4: d00e0508    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b9c5c8: 52800035    	mov	w21, #0x1               ; =1
104b9c5cc: 391a2d15    	strb	w21, [x8, #0x68b]
104b9c5d0: b00db148    	adrp	x8, 0x1201c5000 <dyld_stub_binder+0x1201c5000>
104b9c5d4: f943b908    	ldr	x8, [x8, #0x770]
104b9c5d8: a90023e0    	stp	x0, x8, [sp]
104b9c5dc: d00dab28    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104b9c5e0: f9466901    	ldr	x1, [x8, #0xcd0] ; init
104b9c5e4: 910003e0    	mov	x0, sp
104b9c5e8: 94c22ad7    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104b9c5ec: aa0003f4    	mov	x20, x0
104b9c5f0: b4000a00    	cbz	x0, 0x104b9c730 <_Flutter_MMFoundation_BindContext+0x1078314>
104b9c5f4: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c5f8: b9825108    	ldrsw	x8, [x8, #0x250]
104b9c5fc: b8286a9f    	str	wzr, [x20, x8]
104b9c600: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c604: b9825508    	ldrsw	x8, [x8, #0x254]
104b9c608: b8286a9f    	str	wzr, [x20, x8]
104b9c60c: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c610: b9825908    	ldrsw	x8, [x8, #0x258]
104b9c614: f8286a9f    	str	xzr, [x20, x8]
104b9c618: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c61c: b9825d08    	ldrsw	x8, [x8, #0x25c]
104b9c620: f8686a80    	ldr	x0, [x20, x8]
104b9c624: f8286a9f    	str	xzr, [x20, x8]
104b9c628: 94c22acb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9c62c: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c630: b9826108    	ldrsw	x8, [x8, #0x260]
104b9c634: f8686a80    	ldr	x0, [x20, x8]
104b9c638: f8286a9f    	str	xzr, [x20, x8]
104b9c63c: 94c22ac6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9c640: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c644: b9826508    	ldrsw	x8, [x8, #0x264]
104b9c648: f8686a80    	ldr	x0, [x20, x8]
104b9c64c: f00cc7f6    	adrp	x22, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104b9c650: 910322d6    	add	x22, x22, #0xc8
104b9c654: f8286a96    	str	x22, [x20, x8]
104b9c658: 94c22abf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9c65c: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c660: b9826908    	ldrsw	x8, [x8, #0x268]
104b9c664: b8286a9f    	str	wzr, [x20, x8]
104b9c668: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c66c: b9826d08    	ldrsw	x8, [x8, #0x26c]
104b9c670: b8286a95    	str	w21, [x20, x8]
104b9c674: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c678: b9827108    	ldrsw	x8, [x8, #0x270]
104b9c67c: b8286a9f    	str	wzr, [x20, x8]
104b9c680: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c684: b9827508    	ldrsw	x8, [x8, #0x274]
104b9c688: f8686a80    	ldr	x0, [x20, x8]
104b9c68c: f8286a96    	str	x22, [x20, x8]
104b9c690: 94c22ab1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9c694: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c698: b9827908    	ldrsw	x8, [x8, #0x278]
104b9c69c: 38286a9f    	strb	wzr, [x20, x8]
104b9c6a0: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c6a4: b9827d08    	ldrsw	x8, [x8, #0x27c]
104b9c6a8: 38286a9f    	strb	wzr, [x20, x8]
104b9c6ac: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c6b0: b9828108    	ldrsw	x8, [x8, #0x280]
104b9c6b4: 38286a95    	strb	w21, [x20, x8]
104b9c6b8: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c6bc: b9828508    	ldrsw	x8, [x8, #0x284]
104b9c6c0: b8286a9f    	str	wzr, [x20, x8]
104b9c6c4: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c6c8: b9828908    	ldrsw	x8, [x8, #0x288]
104b9c6cc: b8286a9f    	str	wzr, [x20, x8]
104b9c6d0: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c6d4: b9828d08    	ldrsw	x8, [x8, #0x28c]
104b9c6d8: b8286a9f    	str	wzr, [x20, x8]
104b9c6dc: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c6e0: b9829108    	ldrsw	x8, [x8, #0x290]
104b9c6e4: f8686a80    	ldr	x0, [x20, x8]
104b9c6e8: f8286a9f    	str	xzr, [x20, x8]
104b9c6ec: 94c22a9a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9c6f0: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c6f4: b9829508    	ldrsw	x8, [x8, #0x294]
104b9c6f8: f8686a80    	ldr	x0, [x20, x8]
104b9c6fc: f8286a96    	str	x22, [x20, x8]
104b9c700: 94c22a95    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9c704: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c708: b9829908    	ldrsw	x8, [x8, #0x298]
104b9c70c: b8286a9f    	str	wzr, [x20, x8]
104b9c710: b00d9548    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104b9c714: f9405d01    	ldr	x1, [x8, #0xb8] ; setM_uiMessageType:
104b9c718: aa1403e0    	mov	x0, x20
104b9c71c: aa1303e2    	mov	x2, x19
104b9c720: 94c22a87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9c724: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9c728: b9829d08    	ldrsw	x8, [x8, #0x29c]
104b9c72c: b8286a9f    	str	wzr, [x20, x8]
104b9c730: aa1403e0    	mov	x0, x20
104b9c734: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104b9c738: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104b9c73c: a94157f6    	ldp	x22, x21, [sp, #0x10]
104b9c740: 910103ff    	add	sp, sp, #0x40
104b9c744: d65f03c0    	ret
