
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9f00c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104b9f010: a9017bfd    	stp	x29, x30, [sp, #0x10]
104b9f014: 910043fd    	add	x29, sp, #0x10
104b9f018: aa0203f3    	mov	x19, x2
104b9f01c: aa0003f4    	mov	x20, x0
104b9f020: 900dab08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b9f024: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104b9f028: 94c22045    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9f02c: 900dab08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b9f030: f9401d01    	ldr	x1, [x8, #0x38] ; allocWithZone:
104b9f034: aa1303e2    	mov	x2, x19
104b9f038: 94c22041    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9f03c: b00db428    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9f040: b982a108    	ldrsw	x8, [x8, #0x2a0]
104b9f044: b8686a82    	ldr	w2, [x20, x8]
104b9f048: b00d94e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b9f04c: f9452d01    	ldr	x1, [x8, #0xa58] ; initWithMsgType:
104b9f050: 94c2203b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9f054: aa0003f3    	mov	x19, x0
104b9f058: d00d9628    	adrp	x8, 0x11fe65000 <dyld_stub_binder+0x11fe65000>
104b9f05c: f941dd01    	ldr	x1, [x8, #0x3b8] ; copyToMsg:
104b9f060: aa1403e0    	mov	x0, x20
104b9f064: aa1303e2    	mov	x2, x19
104b9f068: 94c22035    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9f06c: aa1303e0    	mov	x0, x19
104b9f070: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104b9f074: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104b9f078: d65f03c0    	ret