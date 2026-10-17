
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104baa93c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104baa940: a90157f6    	stp	x22, x21, [sp, #0x10]
104baa944: a9024ff4    	stp	x20, x19, [sp, #0x20]
104baa948: a9037bfd    	stp	x29, x30, [sp, #0x30]
104baa94c: 9100c3fd    	add	x29, sp, #0x30
104baa950: aa0203f3    	mov	x19, x2
104baa954: d00dae48    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104baa958: f9411d14    	ldr	x20, [x8, #0x238]
104baa95c: 900d94e8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104baa960: f942c515    	ldr	x21, [x8, #0x588] ; getUserNameFromMsgWrap:
104baa964: aa0203e0    	mov	x0, x2
104baa968: 94c1f1f4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104baa96c: aa1403e0    	mov	x0, x20
104baa970: aa1503e1    	mov	x1, x21
104baa974: aa1303e2    	mov	x2, x19
104baa978: 94c1f1f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104baa97c: aa1d03fd    	mov	x29, x29
104baa980: 94c1f1f2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104baa984: aa0003f4    	mov	x20, x0
104baa988: b00dae57    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
104baa98c: f9467af5    	ldr	x21, [x23, #0xcf0]
104baa990: d00d9488    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104baa994: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
104baa998: aa1303e0    	mov	x0, x19
104baa99c: 94c1f1e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104baa9a0: aa0003f6    	mov	x22, x0
104baa9a4: aa1303e0    	mov	x0, x19
104baa9a8: 94c1f1eb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104baa9ac: f9467ae0    	ldr	x0, [x23, #0xcf0]
104baa9b0: b00d94c8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104baa9b4: f943a501    	ldr	x1, [x8, #0x748] ; GetDocPath
104baa9b8: 94c1f1e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104baa9bc: aa1d03fd    	mov	x29, x29
104baa9c0: 94c1f1e2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104baa9c4: aa0003f3    	mov	x19, x0
104baa9c8: b00d94c8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104baa9cc: f943a901    	ldr	x1, [x8, #0x750] ; GetPathOfMesAudio:LocalID:DocPath:
104baa9d0: aa1503e0    	mov	x0, x21
104baa9d4: aa1403e2    	mov	x2, x20
104baa9d8: aa1603e3    	mov	x3, x22
104baa9dc: aa1303e4    	mov	x4, x19
104baa9e0: 94c1f1d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104baa9e4: aa1d03fd    	mov	x29, x29
104baa9e8: 94c1f1d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104baa9ec: aa0003f5    	mov	x21, x0
104baa9f0: aa1303e0    	mov	x0, x19
104baa9f4: 94c1f1d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104baa9f8: aa1403e0    	mov	x0, x20
104baa9fc: 94c1f1d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104baaa00: aa1503e0    	mov	x0, x21
104baaa04: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104baaa08: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104baaa0c: a94157f6    	ldp	x22, x21, [sp, #0x10]
104baaa10: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104baaa14: 14c1f1d7    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
