
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1046ade98: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1046ade9c: a9017bfd    	stp	x29, x30, [sp, #0x10]
1046adea0: 910043fd    	add	x29, sp, #0x10
1046adea4: aa0003f3    	mov	x19, x0
1046adea8: 900dd648    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1046adeac: f9458100    	ldr	x0, [x8, #0xb00] ; MMSessionInfo
1046adeb0: 94d5e4aa    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1046adeb4: aa0003f4    	mov	x20, x0
1046adeb8: 900dbd68    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
1046adebc: f9444901    	ldr	x1, [x8, #0x890] ; copyFrom:
1046adec0: aa1303e2    	mov	x2, x19
1046adec4: 94d5e49e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046adec8: aa1403e0    	mov	x0, x20
1046adecc: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1046aded0: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1046aded4: d65f03c0    	ret
