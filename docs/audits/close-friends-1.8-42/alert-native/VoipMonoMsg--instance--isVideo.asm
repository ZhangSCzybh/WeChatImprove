
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106375308: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
10637530c: 910003fd    	mov	x29, sp
106375310: f00ce0a8    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
106375314: f944c901    	ldr	x1, [x8, #0x990] ; selector=m_mode
106375318: 9462c789    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10637531c: 7100001f    	cmp	w0, #0x0
106375320: 1a9f17e0    	cset	w0, eq
106375324: a8c17bfd    	ldp	x29, x30, [sp], #0x10
106375328: d65f03c0    	ret
