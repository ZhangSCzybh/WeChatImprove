
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c105f4: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
105c105f8: 910003fd    	mov	x29, sp
105c105fc: f00d2e68    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
105c10600: 910b0108    	add	x8, x8, #0x2c0
105c10604: b9800108    	ldrsw	x8, [x8]
105c10608: f8686800    	ldr	x0, [x0, x8]
105c1060c: d00d1d68    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105c10610: f941c501    	ldr	x1, [x8, #0x388] ; m_showAIReply
105c10614: 94805aca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10618: 7100001f    	cmp	w0, #0x0
105c1061c: 1a9f07e0    	cset	w0, ne
105c10620: a8c17bfd    	ldp	x29, x30, [sp], #0x10
105c10624: d65f03c0    	ret