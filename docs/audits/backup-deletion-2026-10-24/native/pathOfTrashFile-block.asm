
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c9cf0: d10103ff    	sub	sp, sp, #0x40
1029c9cf4: a90157f6    	stp	x22, x21, [sp, #0x10]
1029c9cf8: a9024ff4    	stp	x20, x19, [sp, #0x20]
1029c9cfc: a9037bfd    	stp	x29, x30, [sp, #0x30]
1029c9d00: 9100c3fd    	add	x29, sp, #0x30
1029c9d04: aa0003f3    	mov	x19, x0
1029c9d08: f9401000    	ldr	x0, [x0, #0x20]
1029c9d0c: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c9d10: f941e101    	ldr	x1, [x8, #0x3c0] ; pathOfTrash
1029c9d14: 9549750a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9d18: aa1d03fd    	mov	x29, x29
1029c9d1c: 9549750b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c9d20: aa0003f4    	mov	x20, x0
1029c9d24: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c9d28: f9454500    	ldr	x0, [x8, #0xa88]
1029c9d2c: 9549750d    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1029c9d30: b00eb9c8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1029c9d34: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
1029c9d38: f90003f4    	str	x20, [sp]
1029c9d3c: 900de582    	adrp	x2, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9d40: 91062042    	add	x2, x2, #0x188 ; CFString %@/File
1029c9d44: 954974fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9d48: d00f15f5    	adrp	x21, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029c9d4c: f946eea8    	ldr	x8, [x21, #0xdd8]
1029c9d50: f906eea0    	str	x0, [x21, #0xdd8]
1029c9d54: aa0803e0    	mov	x0, x8
1029c9d58: 954974ff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9d5c: f9401260    	ldr	x0, [x19, #0x20]
1029c9d60: f946eea2    	ldr	x2, [x21, #0xdd8]
1029c9d64: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c9d68: f941e501    	ldr	x1, [x8, #0x3c8] ; createDir:
1029c9d6c: 954974f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9d70: aa1403e0    	mov	x0, x20
1029c9d74: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1029c9d78: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1029c9d7c: a94157f6    	ldp	x22, x21, [sp, #0x10]
1029c9d80: 910103ff    	add	sp, sp, #0x40
1029c9d84: 154974f4    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
