
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106fe912c: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
106fe9130: 910003fd    	mov	x29, sp
106fe9134: d00c7388    	adrp	x8, 0x11fe5b000 <dyld_stub_binder+0x11fe5b000>
106fe9138: f9448101    	ldr	x1, [x8, #0x900]
106fe913c: 9430f800    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106fe9140: 7219001f    	tst	w0, #0x80
106fe9144: 1a9f17e0    	cset	w0, eq
106fe9148: a8c17bfd    	ldp	x29, x30, [sp], #0x10
106fe914c: d65f03c0    	ret
