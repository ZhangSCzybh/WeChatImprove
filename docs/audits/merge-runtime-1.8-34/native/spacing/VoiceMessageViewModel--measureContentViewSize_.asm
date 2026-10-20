
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10628d230: 6dbd23e9    	stp	d9, d8, [sp, #-0x30]!
10628d234: a9014ff4    	stp	x20, x19, [sp, #0x10]
10628d238: a9027bfd    	stp	x29, x30, [sp, #0x20]
10628d23c: 910083fd    	add	x29, sp, #0x20
10628d240: aa0003f3    	mov	x19, x0
10628d244: d00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628d248: f9476901    	ldr	x1, [x8, #0xed0] ; voiceNodeWidth
10628d24c: 946667bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628d250: 1e604008    	fmov	d8, d0
10628d254: d00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628d258: f9471901    	ldr	x1, [x8, #0xe30] ; voiceNodeHeight
10628d25c: aa1303e0    	mov	x0, x19
10628d260: 946667b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628d264: 1e604001    	fmov	d1, d0
10628d268: 1e604100    	fmov	d0, d8
10628d26c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10628d270: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10628d274: 6cc323e9    	ldp	d9, d8, [sp], #0x30
10628d278: d65f03c0    	ret