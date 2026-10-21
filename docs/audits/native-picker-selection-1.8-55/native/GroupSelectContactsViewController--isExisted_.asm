
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ecda24: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101ecda28: a9017bfd    	stp	x29, x30, [sp, #0x10]
101ecda2c: 910043fd    	add	x29, sp, #0x10
101ecda30: d00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecda34: b987c908    	ldrsw	x8, [x8, #0x7c8]
101ecda38: f8686813    	ldr	x19, [x0, x8]
101ecda3c: d00efb68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101ecda40: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
101ecda44: aa0203e0    	mov	x0, x2
101ecda48: 957565bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecda4c: aa1d03fd    	mov	x29, x29
101ecda50: 957565be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecda54: aa0003f4    	mov	x20, x0
101ecda58: f00f11a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101ecda5c: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
101ecda60: aa1303e0    	mov	x0, x19
101ecda64: aa1403e2    	mov	x2, x20
101ecda68: 957565b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecda6c: aa1d03fd    	mov	x29, x29
101ecda70: 957565b6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecda74: f100001f    	cmp	x0, #0x0
101ecda78: 1a9f07f3    	cset	w19, ne
101ecda7c: 957565b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecda80: aa1403e0    	mov	x0, x20
101ecda84: 957565b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecda88: aa1303e0    	mov	x0, x19
101ecda8c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
101ecda90: a8c24ff4    	ldp	x20, x19, [sp], #0x20
101ecda94: d65f03c0    	ret
