
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c9f08: d10143ff    	sub	sp, sp, #0x50
1029c9f0c: a9015ff8    	stp	x24, x23, [sp, #0x10]
1029c9f10: a90257f6    	stp	x22, x21, [sp, #0x20]
1029c9f14: a9034ff4    	stp	x20, x19, [sp, #0x30]
1029c9f18: a9047bfd    	stp	x29, x30, [sp, #0x40]
1029c9f1c: 910103fd    	add	x29, sp, #0x40
1029c9f20: aa0003f4    	mov	x20, x0
1029c9f24: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c9f28: f945e500    	ldr	x0, [x8, #0xbc8]
1029c9f2c: 9549748b    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1029c9f30: aa0003f3    	mov	x19, x0
1029c9f34: d00ebd68    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
1029c9f38: f9421500    	ldr	x0, [x8, #0x428]
1029c9f3c: d00eb9c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029c9f40: f947ed01    	ldr	x1, [x8, #0xfd8] ; localTimeZone
1029c9f44: 9549747e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9f48: aa1d03fd    	mov	x29, x29
1029c9f4c: 9549747f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c9f50: aa0003f5    	mov	x21, x0
1029c9f54: 900eba08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1029c9f58: f9470101    	ldr	x1, [x8, #0xe00] ; setTimeZone:
1029c9f5c: aa1303e0    	mov	x0, x19
1029c9f60: aa1503e2    	mov	x2, x21
1029c9f64: 95497476    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9f68: aa1503e0    	mov	x0, x21
1029c9f6c: 9549747a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9f70: d00eb9e8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1029c9f74: f944d901    	ldr	x1, [x8, #0x9b0] ; setDateFormat:
1029c9f78: 900de582    	adrp	x2, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9f7c: 91072042    	add	x2, x2, #0x1c8 ; CFString yyyy-MM-dd_HH
1029c9f80: aa1303e0    	mov	x0, x19
1029c9f84: 9549746e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9f88: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c9f8c: f9454500    	ldr	x0, [x8, #0xa88]
1029c9f90: 95497474    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1029c9f94: aa0003f5    	mov	x21, x0
1029c9f98: 9549755b    	bl	0x107c27504 <_Flutter_MMFoundation_BindContext+0x41030e8>
1029c9f9c: aa1d03fd    	mov	x29, x29
1029c9fa0: 9549746a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c9fa4: aa0003f6    	mov	x22, x0
1029c9fa8: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c9fac: f9457100    	ldr	x0, [x8, #0xae0]
1029c9fb0: f00eb9a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029c9fb4: f9460d01    	ldr	x1, [x8, #0xc18] ; date
1029c9fb8: 95497461    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9fbc: aa1d03fd    	mov	x29, x29
1029c9fc0: 95497462    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c9fc4: aa0003f7    	mov	x23, x0
1029c9fc8: b00eba08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029c9fcc: f9468d01    	ldr	x1, [x8, #0xd18] ; stringFromDate:
1029c9fd0: aa1303e0    	mov	x0, x19
1029c9fd4: aa1703e2    	mov	x2, x23
1029c9fd8: 95497459    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9fdc: aa1d03fd    	mov	x29, x29
1029c9fe0: 9549745a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c9fe4: aa0003f8    	mov	x24, x0
1029c9fe8: b00eb9c8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1029c9fec: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
1029c9ff0: a90003f6    	stp	x22, x0, [sp]
1029c9ff4: 900de582    	adrp	x2, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9ff8: 9107a042    	add	x2, x2, #0x1e8 ; CFString %@/DiskScanTrash/%@
1029c9ffc: aa1503e0    	mov	x0, x21
1029ca000: 9549744f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca004: b00f15f5    	adrp	x21, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029ca008: f946fea8    	ldr	x8, [x21, #0xdf8]
1029ca00c: f906fea0    	str	x0, [x21, #0xdf8]
1029ca010: aa0803e0    	mov	x0, x8
1029ca014: 95497450    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca018: aa1803e0    	mov	x0, x24
1029ca01c: 9549744e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca020: aa1703e0    	mov	x0, x23
1029ca024: 9549744c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca028: aa1603e0    	mov	x0, x22
1029ca02c: 9549744a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029ca030: f9401280    	ldr	x0, [x20, #0x20]
1029ca034: f946fea2    	ldr	x2, [x21, #0xdf8]
1029ca038: f00ea968    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029ca03c: f941e501    	ldr	x1, [x8, #0x3c8] ; createDir:
1029ca040: 9549743f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029ca044: aa1303e0    	mov	x0, x19
1029ca048: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1029ca04c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1029ca050: a94257f6    	ldp	x22, x21, [sp, #0x20]
1029ca054: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1029ca058: 910143ff    	add	sp, sp, #0x50
1029ca05c: 1549743e    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
