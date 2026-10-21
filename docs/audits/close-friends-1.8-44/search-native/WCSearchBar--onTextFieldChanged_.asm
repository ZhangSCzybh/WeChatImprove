
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109dd4e90: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
109dd4e94: a9014ff4    	stp	x20, x19, [sp, #0x10]
109dd4e98: a9027bfd    	stp	x29, x30, [sp, #0x20]
109dd4e9c: 910083fd    	add	x29, sp, #0x20
109dd4ea0: aa0203f3    	mov	x19, x2
109dd4ea4: aa0003f4    	mov	x20, x0
109dd4ea8: f00b19a8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
109dd4eac: f9401515    	ldr	x21, [x8, #0x28] ; text
109dd4eb0: aa0203e0    	mov	x0, x2
109dd4eb4: 956a1963    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109dd4eb8: aa1303e0    	mov	x0, x19
109dd4ebc: aa1503e1    	mov	x1, x21
109dd4ec0: 956a1961    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd4ec4: aa1d03fd    	mov	x29, x29
109dd4ec8: 956a1962    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd4ecc: aa0003f5    	mov	x21, x0
109dd4ed0: d00b03a8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
109dd4ed4: f9444101    	ldr	x1, [x8, #0x880] ; isEditing
109dd4ed8: aa1303e0    	mov	x0, x19
109dd4edc: 956a195a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd4ee0: aa0003f6    	mov	x22, x0
109dd4ee4: aa1303e0    	mov	x0, x19
109dd4ee8: 956a195d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd4eec: b00b15e8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109dd4ef0: f9402d01    	ldr	x1, [x8, #0x58] ; inputBoxTextChanged:isEditing:
109dd4ef4: aa1403e0    	mov	x0, x20
109dd4ef8: aa1503e2    	mov	x2, x21
109dd4efc: aa1603e3    	mov	x3, x22
109dd4f00: 956a1951    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd4f04: aa1503e0    	mov	x0, x21
109dd4f08: a9427bfd    	ldp	x29, x30, [sp, #0x20]
109dd4f0c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
109dd4f10: a8c357f6    	ldp	x22, x21, [sp], #0x30
109dd4f14: 156a1952    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
