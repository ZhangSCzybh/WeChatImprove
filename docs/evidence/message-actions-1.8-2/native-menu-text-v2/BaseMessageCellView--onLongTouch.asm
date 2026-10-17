
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002ae698: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1002ae69c: a9017bfd    	stp	x29, x30, [sp, #0x10]
1002ae6a0: 910043fd    	add	x29, sp, #0x10
1002ae6a4: aa0003f3    	mov	x19, x0
1002ae6a8: 900fdce8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002ae6ac: f9444501    	ldr	x1, [x8, #0x888] ; canCellShowOperationMenu
1002ae6b0: 95e5e2a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ae6b4: aa0003f4    	mov	x20, x0
1002ae6b8: 340000a0    	cbz	w0, 0x1002ae6cc <__text+0x2a66cc>
1002ae6bc: d00fdc88    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002ae6c0: f9462901    	ldr	x1, [x8, #0xc50] ; showOperationMenu
1002ae6c4: aa1303e0    	mov	x0, x19
1002ae6c8: 95e5e29d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ae6cc: d00ff2c8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1002ae6d0: f9411901    	ldr	x1, [x8, #0x230] ; setHighlighted:
1002ae6d4: aa1303e0    	mov	x0, x19
1002ae6d8: aa1403e2    	mov	x2, x20
1002ae6dc: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1002ae6e0: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1002ae6e4: 15e5e296    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>