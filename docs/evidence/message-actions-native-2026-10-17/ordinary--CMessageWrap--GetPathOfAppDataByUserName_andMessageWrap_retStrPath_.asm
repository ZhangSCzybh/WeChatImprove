
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b79258: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104b7925c: a90157f6    	stp	x22, x21, [sp, #0x10]
104b79260: a9024ff4    	stp	x20, x19, [sp, #0x20]
104b79264: a9037bfd    	stp	x29, x30, [sp, #0x30]
104b79268: 9100c3fd    	add	x29, sp, #0x30
104b7926c: aa0403f3    	mov	x19, x4
104b79270: aa0303f4    	mov	x20, x3
104b79274: aa0203f5    	mov	x21, x2
104b79278: aa0003f6    	mov	x22, x0
104b7927c: d00d9628    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b79280: f9411517    	ldr	x23, [x8, #0x228] ; m_nsAppAttachID
104b79284: aa0303e0    	mov	x0, x3
104b79288: 94c2b7ac    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b7928c: aa1503e0    	mov	x0, x21
104b79290: 94c2b7aa    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b79294: aa1403e0    	mov	x0, x20
104b79298: aa1703e1    	mov	x1, x23
104b7929c: 94c2b7a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b792a0: aa1d03fd    	mov	x29, x29
104b792a4: 94c2b7a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b792a8: aa0003f7    	mov	x23, x0
104b792ac: b00d9628    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b792b0: f9453101    	ldr	x1, [x8, #0xa60] ; m_nsAppFileExt
104b792b4: aa1403e0    	mov	x0, x20
104b792b8: 94c2b7a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b792bc: aa1d03fd    	mov	x29, x29
104b792c0: 94c2b7a2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b792c4: aa0003f8    	mov	x24, x0
104b792c8: d00da068    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104b792cc: f9434101    	ldr	x1, [x8, #0x680] ; GetPathOfAppDataByUserName:andMessageWrap:andAttachId:andAttachFileExt:retStrPath:
104b792d0: aa1603e0    	mov	x0, x22
104b792d4: aa1503e2    	mov	x2, x21
104b792d8: aa1403e3    	mov	x3, x20
104b792dc: aa1703e4    	mov	x4, x23
104b792e0: aa1803e5    	mov	x5, x24
104b792e4: aa1303e6    	mov	x6, x19
104b792e8: 94c2b795    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b792ec: aa1403e0    	mov	x0, x20
104b792f0: 94c2b799    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b792f4: aa1503e0    	mov	x0, x21
104b792f8: 94c2b797    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b792fc: aa1803e0    	mov	x0, x24
104b79300: 94c2b795    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b79304: aa1703e0    	mov	x0, x23
104b79308: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104b7930c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104b79310: a94157f6    	ldp	x22, x21, [sp, #0x10]
104b79314: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104b79318: 14c2b78f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>