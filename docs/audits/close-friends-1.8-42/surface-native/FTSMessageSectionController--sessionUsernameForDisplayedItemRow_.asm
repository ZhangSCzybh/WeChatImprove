
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101797eac: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101797eb0: a90157f6    	stp	x22, x21, [sp, #0x10]
101797eb4: a9024ff4    	stp	x20, x19, [sp, #0x20]
101797eb8: a9037bfd    	stp	x29, x30, [sp, #0x30]
101797ebc: 9100c3fd    	add	x29, sp, #0x30
101797ec0: aa0003f4    	mov	x20, x0
101797ec4: f00fa4c8    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
101797ec8: 52800029    	mov	w9, #0x1                ; =1
101797ecc: 3925cd09    	strb	w9, [x8, #0x973]
101797ed0: f00f3888    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101797ed4: f940c101    	ldr	x1, [x8, #0x180] ; mgrSessionIndexForDisplayedItemRow:
101797ed8: 95923c99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797edc: aa0003f5    	mov	x21, x0
101797ee0: 900f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101797ee4: f945e900    	ldr	x0, [x8, #0xbd0]
101797ee8: b00f4b48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101797eec: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101797ef0: 95923c93    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797ef4: aa1d03fd    	mov	x29, x29
101797ef8: 95923c94    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797efc: aa0003f3    	mov	x19, x0
101797f00: 900f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101797f04: f9477100    	ldr	x0, [x8, #0xee0]
101797f08: 900f4b48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101797f0c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101797f10: 95923c8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797f14: aa0003e2    	mov	x2, x0
101797f18: d00f3508    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101797f1c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101797f20: aa1303e0    	mov	x0, x19
101797f24: 95923c86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797f28: aa1d03fd    	mov	x29, x29
101797f2c: 95923c87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797f30: aa0003f6    	mov	x22, x0
101797f34: d00f35a8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
101797f38: f9472d01    	ldr	x1, [x8, #0xe58] ; ftsMessageMgr
101797f3c: 95923c80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797f40: aa1d03fd    	mov	x29, x29
101797f44: 95923c81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797f48: aa0003f7    	mov	x23, x0
101797f4c: f00f3868    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101797f50: f9431901    	ldr	x1, [x8, #0x630] ; curSearchText
101797f54: aa1403e0    	mov	x0, x20
101797f58: 95923c79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797f5c: aa1d03fd    	mov	x29, x29
101797f60: 95923c7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797f64: aa0003f8    	mov	x24, x0
101797f68: f00f3868    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101797f6c: f943a101    	ldr	x1, [x8, #0x740] ; ftsTaskKey
101797f70: aa1403e0    	mov	x0, x20
101797f74: 95923c72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797f78: aa1d03fd    	mov	x29, x29
101797f7c: 95923c73    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797f80: aa0003f4    	mov	x20, x0
101797f84: f00f3788    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
101797f88: f9436101    	ldr	x1, [x8, #0x6c0] ; getSessionUsernameForQuery:atIndex:taskKey:
101797f8c: aa1703e0    	mov	x0, x23
101797f90: aa1803e2    	mov	x2, x24
101797f94: aa1503e3    	mov	x3, x21
101797f98: aa1403e4    	mov	x4, x20
101797f9c: 95923c68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101797fa0: aa1d03fd    	mov	x29, x29
101797fa4: 95923c69    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101797fa8: aa0003f5    	mov	x21, x0
101797fac: aa1403e0    	mov	x0, x20
101797fb0: 95923c69    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101797fb4: aa1803e0    	mov	x0, x24
101797fb8: 95923c67    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101797fbc: aa1703e0    	mov	x0, x23
101797fc0: 95923c65    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101797fc4: aa1603e0    	mov	x0, x22
101797fc8: 95923c63    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101797fcc: aa1303e0    	mov	x0, x19
101797fd0: 95923c61    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101797fd4: aa1503e0    	mov	x0, x21
101797fd8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101797fdc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101797fe0: a94157f6    	ldp	x22, x21, [sp, #0x10]
101797fe4: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101797fe8: 15923c62    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
