
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a5e98: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1002a5e9c: a90157f6    	stp	x22, x21, [sp, #0x10]
1002a5ea0: a9024ff4    	stp	x20, x19, [sp, #0x20]
1002a5ea4: a9037bfd    	stp	x29, x30, [sp, #0x30]
1002a5ea8: 9100c3fd    	add	x29, sp, #0x30
1002a5eac: aa0003f3    	mov	x19, x0
1002a5eb0: 90104c48    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002a5eb4: 52800029    	mov	w9, #0x1                ; =1
1002a5eb8: 39312d09    	strb	w9, [x8, #0xc4b]
1002a5ebc: d00ff9c8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002a5ec0: 91086108    	add	x8, x8, #0x218
1002a5ec4: b9800117    	ldrsw	x23, [x8]
1002a5ec8: 8b170000    	add	x0, x0, x23
1002a5ecc: 95e604b0    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1002a5ed0: aa0003f4    	mov	x20, x0
1002a5ed4: b00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a5ed8: f942b515    	ldr	x21, [x8, #0x568] ; tryHandleMenu:withViewModel:
1002a5edc: b00ff308    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1002a5ee0: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
1002a5ee4: aa1503e2    	mov	x2, x21
1002a5ee8: 95e60495    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5eec: aa0003f6    	mov	x22, x0
1002a5ef0: aa1403e0    	mov	x0, x20
1002a5ef4: 95e60498    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5ef8: 36000396    	tbz	w22, #0x0, 0x1002a5f68 <__text+0x29df68>
1002a5efc: 8b170260    	add	x0, x19, x23
1002a5f00: 95e604a3    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1002a5f04: aa0003f6    	mov	x22, x0
1002a5f08: b00fdcc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a5f0c: f9410914    	ldr	x20, [x8, #0x210] ; viewModel
1002a5f10: aa1303e0    	mov	x0, x19
1002a5f14: aa1403e1    	mov	x1, x20
1002a5f18: 95e60489    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5f1c: aa1d03fd    	mov	x29, x29
1002a5f20: 95e6048a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a5f24: aa0003f7    	mov	x23, x0
1002a5f28: aa1603e0    	mov	x0, x22
1002a5f2c: aa1503e1    	mov	x1, x21
1002a5f30: 52800042    	mov	w2, #0x2                ; =2
1002a5f34: aa1703e3    	mov	x3, x23
1002a5f38: 95e60481    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5f3c: aa0003f5    	mov	x21, x0
1002a5f40: aa1703e0    	mov	x0, x23
1002a5f44: 95e60484    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5f48: aa1603e0    	mov	x0, x22
1002a5f4c: 95e60482    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5f50: 36000115    	tbz	w21, #0x0, 0x1002a5f70 <__text+0x29df70>
1002a5f54: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1002a5f58: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1002a5f5c: a94157f6    	ldp	x22, x21, [sp, #0x10]
1002a5f60: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1002a5f64: d65f03c0    	ret
1002a5f68: b00fdcc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a5f6c: f9410914    	ldr	x20, [x8, #0x210] ; viewModel
1002a5f70: b00ff688    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1002a5f74: f940dd15    	ldr	x21, [x8, #0x1b8] ; h�7 
1002a5f78: aa1303e0    	mov	x0, x19
1002a5f7c: aa1403e1    	mov	x1, x20
1002a5f80: 95e6046f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5f84: aa1d03fd    	mov	x29, x29
1002a5f88: 95e60470    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a5f8c: aa0003f4    	mov	x20, x0
1002a5f90: b00fdcc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a5f94: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
1002a5f98: 95e60469    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5f9c: aa1d03fd    	mov	x29, x29
1002a5fa0: 95e6046a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a5fa4: aa0003f6    	mov	x22, x0
1002a5fa8: b00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a5fac: f942b901    	ldr	x1, [x8, #0x570] ; reportMessage:action:
1002a5fb0: aa1503e0    	mov	x0, x21
1002a5fb4: aa1603e2    	mov	x2, x22
1002a5fb8: 52800083    	mov	w3, #0x4                ; =4
1002a5fbc: 95e60460    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a5fc0: aa1603e0    	mov	x0, x22
1002a5fc4: 95e60464    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5fc8: aa1403e0    	mov	x0, x20
1002a5fcc: 95e60462    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a5fd0: b00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a5fd4: f942bd01    	ldr	x1, [x8, #0x578] ; doForward
1002a5fd8: aa1303e0    	mov	x0, x19
1002a5fdc: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1002a5fe0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1002a5fe4: a94157f6    	ldp	x22, x21, [sp, #0x10]
1002a5fe8: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1002a5fec: 15e60454    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>