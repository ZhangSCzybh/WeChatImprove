
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
107140ca8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
107140cac: a9017bfd    	stp	x29, x30, [sp, #0x10]
107140cb0: 910043fd    	add	x29, sp, #0x10
107140cb4: d00c7628    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
107140cb8: f942b101    	ldr	x1, [x8, #0x560] ; messageMgrWithDB
107140cbc: 942b9920    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107140cc0: aa1d03fd    	mov	x29, x29
107140cc4: 942b9921    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
107140cc8: aa0003f3    	mov	x19, x0
107140ccc: d00c7628    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
107140cd0: f942bd01    	ldr	x1, [x8, #0x578] ; getUnReadMessages
107140cd4: 942b991a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107140cd8: aa1d03fd    	mov	x29, x29
107140cdc: 942b991b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
107140ce0: aa0003f4    	mov	x20, x0
107140ce4: aa1303e0    	mov	x0, x19
107140ce8: 942b991b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
107140cec: aa1403e0    	mov	x0, x20
107140cf0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
107140cf4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
107140cf8: 142b991e    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
