
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a702dc: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104a702e0: a90157f6    	stp	x22, x21, [sp, #0x10]
104a702e4: a9024ff4    	stp	x20, x19, [sp, #0x20]
104a702e8: a9037bfd    	stp	x29, x30, [sp, #0x30]
104a702ec: 9100c3fd    	add	x29, sp, #0x30
104a702f0: aa0203f3    	mov	x19, x2
104a702f4: aa0003f4    	mov	x20, x0
104a702f8: aa0203e0    	mov	x0, x2
104a702fc: 94c6db8f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a70300: 900db828    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a70304: f941bd00    	ldr	x0, [x8, #0x378] ; class MainSessionMgr
104a70308: 900da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a7030c: f9408d01    	ldr	x1, [x8, #0x118] ; selector canShowInMainFrame:
104a70310: aa1303e2    	mov	x2, x19
104a70314: 94c6db8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70318: 34000360    	cbz	w0, 0x104a70384 <_Flutter_MMFoundation_BindContext+0xf4bf68>
104a7031c: 900da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a70320: f9406501    	ldr	x1, [x8, #0xc8] ; selector canShowSession:
104a70324: aa1403e0    	mov	x0, x20
104a70328: aa1303e2    	mov	x2, x19
104a7032c: 94c6db84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70330: 340002a0    	cbz	w0, 0x104a70384 <_Flutter_MMFoundation_BindContext+0xf4bf68>
104a70334: f9401a95    	ldr	x21, [x20, #0x30]
104a70338: 900d9ea8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a7033c: f947d901    	ldr	x1, [x8, #0xfb0] ; selector m_nsUserName
104a70340: aa1303e0    	mov	x0, x19
104a70344: 94c6db7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70348: aa1d03fd    	mov	x29, x29
104a7034c: 94c6db7f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a70350: aa0003f6    	mov	x22, x0
104a70354: d00d9e48    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104a70358: f943c517    	ldr	x23, [x8, #0x788] ; selector safeAddObject:
104a7035c: aa1503e0    	mov	x0, x21
104a70360: aa1703e1    	mov	x1, x23
104a70364: aa1603e2    	mov	x2, x22
104a70368: 94c6db75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7036c: aa1603e0    	mov	x0, x22
104a70370: 94c6db79    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a70374: f9401280    	ldr	x0, [x20, #0x20]
104a70378: aa1703e1    	mov	x1, x23
104a7037c: aa1303e2    	mov	x2, x19
104a70380: 94c6db6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70384: aa1303e0    	mov	x0, x19
104a70388: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104a7038c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104a70390: a94157f6    	ldp	x22, x21, [sp, #0x10]
104a70394: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104a70398: 14c6db6f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
