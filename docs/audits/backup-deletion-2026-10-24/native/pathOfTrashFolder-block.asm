
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c9dfc: d10103ff    	sub	sp, sp, #0x40
1029c9e00: a90157f6    	stp	x22, x21, [sp, #0x10]
1029c9e04: a9024ff4    	stp	x20, x19, [sp, #0x20]
1029c9e08: a9037bfd    	stp	x29, x30, [sp, #0x30]
1029c9e0c: 9100c3fd    	add	x29, sp, #0x30
1029c9e10: aa0003f3    	mov	x19, x0
1029c9e14: f9401000    	ldr	x0, [x0, #0x20]
1029c9e18: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c9e1c: f941e101    	ldr	x1, [x8, #0x3c0] ; pathOfTrash
1029c9e20: 954974c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9e24: aa1d03fd    	mov	x29, x29
1029c9e28: 954974c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c9e2c: aa0003f4    	mov	x20, x0
1029c9e30: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c9e34: f9454500    	ldr	x0, [x8, #0xa88]
1029c9e38: 954974ca    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1029c9e3c: b00eb9c8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1029c9e40: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
1029c9e44: f90003f4    	str	x20, [sp]
1029c9e48: 900de582    	adrp	x2, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9e4c: 9106a042    	add	x2, x2, #0x1a8 ; CFString %@/Folder
1029c9e50: 954974bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9e54: d00f15f5    	adrp	x21, 0x120c87000 <dyld_stub_binder+0x120c87000>
1029c9e58: f946f6a8    	ldr	x8, [x21, #0xde8]
1029c9e5c: f906f6a0    	str	x0, [x21, #0xde8]
1029c9e60: aa0803e0    	mov	x0, x8
1029c9e64: 954974bc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9e68: f9401260    	ldr	x0, [x19, #0x20]
1029c9e6c: f946f6a2    	ldr	x2, [x21, #0xde8]
1029c9e70: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c9e74: f941e501    	ldr	x1, [x8, #0x3c8] ; createDir:
1029c9e78: 954974b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9e7c: aa1403e0    	mov	x0, x20
1029c9e80: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1029c9e84: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1029c9e88: a94157f6    	ldp	x22, x21, [sp, #0x10]
1029c9e8c: 910103ff    	add	sp, sp, #0x40
1029c9e90: 154974b1    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
