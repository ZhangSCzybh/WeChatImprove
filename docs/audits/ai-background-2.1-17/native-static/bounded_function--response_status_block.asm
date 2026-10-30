
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10517de94: d101c3ff    	sub	sp, sp, #0x70
10517de98: a9035ff8    	stp	x24, x23, [sp, #0x30]
10517de9c: a90457f6    	stp	x22, x21, [sp, #0x40]
10517dea0: a9054ff4    	stp	x20, x19, [sp, #0x50]
10517dea4: a9067bfd    	stp	x29, x30, [sp, #0x60]
10517dea8: 910183fd    	add	x29, sp, #0x60
10517deac: aa0003f3    	mov	x19, x0
10517deb0: d00d7fb6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10517deb4: f945eac0    	ldr	x0, [x22, #0xbd0]
10517deb8: f00d7c08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10517debc: f944e914    	ldr	x20, [x8, #0x9d0]
10517dec0: aa1403e1    	mov	x1, x20
10517dec4: 94aaa49e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517dec8: aa1d03fd    	mov	x29, x29
10517decc: 94aaa49f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517ded0: aa0003f5    	mov	x21, x0
10517ded4: f00d7f97    	adrp	x23, 0x120170000 <dyld_stub_binder+0x120170000>
10517ded8: f94626e2    	ldr	x2, [x23, #0xc48]
10517dedc: f00d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517dee0: f9423903    	ldr	x3, [x8, #0x470]
10517dee4: b00c2388    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10517dee8: f947e108    	ldr	x8, [x8, #0xfc0]
10517deec: f90007e8    	str	x8, [sp, #0x8]
10517def0: 9009e028    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10517def4: fd423900    	ldr	d0, [x8, #0x470]
10517def8: fd000be0    	str	d0, [sp, #0x10]
10517defc: 90000008    	adrp	x8, 0x10517d000 <_Flutter_MMFoundation_BindContext+0x1658be4>
10517df00: 913e2108    	add	x8, x8, #0xf88
10517df04: b00c23c9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
10517df08: 91230129    	add	x9, x9, #0x8c0
10517df0c: a901a7e8    	stp	x8, x9, [sp, #0x18]
10517df10: fd401260    	ldr	d0, [x19, #0x20]
10517df14: fd0017e0    	str	d0, [sp, #0x28]
10517df18: b00d65e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10517df1c: f9404913    	ldr	x19, [x8, #0x90]
10517df20: 910023e4    	add	x4, sp, #0x8
10517df24: aa1303e1    	mov	x1, x19
10517df28: 94aaa485    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517df2c: aa1503e0    	mov	x0, x21
10517df30: 94aaa489    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517df34: f945eac0    	ldr	x0, [x22, #0xbd0]
10517df38: aa1403e1    	mov	x1, x20
10517df3c: 94aaa480    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517df40: aa1d03fd    	mov	x29, x29
10517df44: 94aaa481    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517df48: aa0003f4    	mov	x20, x0
10517df4c: f94626e2    	ldr	x2, [x23, #0xc48]
10517df50: d00d70c8    	adrp	x8, 0x11ff97000 <dyld_stub_binder+0x11ff97000>
10517df54: f9469903    	ldr	x3, [x8, #0xd30]
10517df58: b00c2784    	adrp	x4, 0x11d66e000 <dyld_stub_binder+0x11d66e000>
10517df5c: 91178084    	add	x4, x4, #0x5e0
10517df60: aa1303e1    	mov	x1, x19
10517df64: 94aaa476    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517df68: aa1403e0    	mov	x0, x20
10517df6c: 94aaa47a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517df70: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10517df74: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10517df78: a94457f6    	ldp	x22, x21, [sp, #0x40]
10517df7c: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10517df80: 9101c3ff    	add	sp, sp, #0x70
10517df84: d65f03c0    	ret
