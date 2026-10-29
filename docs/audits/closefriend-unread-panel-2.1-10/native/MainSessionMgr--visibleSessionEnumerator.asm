
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ab7ec0: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104ab7ec4: a90157f6    	stp	x22, x21, [sp, #0x10]
104ab7ec8: a9024ff4    	stp	x20, x19, [sp, #0x20]
104ab7ecc: a9037bfd    	stp	x29, x30, [sp, #0x30]
104ab7ed0: 9100c3fd    	add	x29, sp, #0x30
104ab7ed4: aa0003f4    	mov	x20, x0
104ab7ed8: 900db5e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ab7edc: f9455500    	ldr	x0, [x8, #0xaa8] ; class NSMutableArray
104ab7ee0: 94c5bc9e    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104ab7ee4: aa0003f3    	mov	x19, x0
104ab7ee8: d00da668    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104ab7eec: f9401d01    	ldr	x1, [x8, #0x38] ; selector topSessions
104ab7ef0: aa1403e0    	mov	x0, x20
104ab7ef4: 94c5bc92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ab7ef8: aa1d03fd    	mov	x29, x29
104ab7efc: 94c5bc93    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ab7f00: aa0003f5    	mov	x21, x0
104ab7f04: b00db268    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104ab7f08: f947e516    	ldr	x22, [x8, #0xfc8] ; selector objectEnumerator
104ab7f0c: aa1603e1    	mov	x1, x22
104ab7f10: 94c5bc8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ab7f14: aa1d03fd    	mov	x29, x29
104ab7f18: 94c5bc8c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ab7f1c: aa0003f7    	mov	x23, x0
104ab7f20: f00d9c08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104ab7f24: f943c518    	ldr	x24, [x8, #0x788] ; selector safeAddObject:
104ab7f28: aa1303e0    	mov	x0, x19
104ab7f2c: aa1803e1    	mov	x1, x24
104ab7f30: aa1703e2    	mov	x2, x23
104ab7f34: 94c5bc82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ab7f38: aa1703e0    	mov	x0, x23
104ab7f3c: 94c5bc86    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ab7f40: aa1503e0    	mov	x0, x21
104ab7f44: 94c5bc84    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ab7f48: d00da668    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104ab7f4c: f9402101    	ldr	x1, [x8, #0x40] ; selector normalSessions
104ab7f50: aa1403e0    	mov	x0, x20
104ab7f54: 94c5bc7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ab7f58: aa1d03fd    	mov	x29, x29
104ab7f5c: 94c5bc7b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ab7f60: aa0003f4    	mov	x20, x0
104ab7f64: aa1603e1    	mov	x1, x22
104ab7f68: 94c5bc75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ab7f6c: aa1d03fd    	mov	x29, x29
104ab7f70: 94c5bc76    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ab7f74: aa0003f5    	mov	x21, x0
104ab7f78: aa1303e0    	mov	x0, x19
104ab7f7c: aa1803e1    	mov	x1, x24
104ab7f80: aa1503e2    	mov	x2, x21
104ab7f84: 94c5bc6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ab7f88: aa1503e0    	mov	x0, x21
104ab7f8c: 94c5bc72    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ab7f90: aa1403e0    	mov	x0, x20
104ab7f94: 94c5bc70    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ab7f98: f00db6c8    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
104ab7f9c: f9453100    	ldr	x0, [x8, #0xa60] ; class MMConcatEnumerator
104ab7fa0: d00da668    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104ab7fa4: f9402501    	ldr	x1, [x8, #0x48] ; selector concatEnumrators:
104ab7fa8: aa1303e2    	mov	x2, x19
104ab7fac: 94c5bc64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ab7fb0: aa1d03fd    	mov	x29, x29
104ab7fb4: 94c5bc65    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ab7fb8: aa0003f4    	mov	x20, x0
104ab7fbc: aa1303e0    	mov	x0, x19
104ab7fc0: 94c5bc65    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ab7fc4: aa1403e0    	mov	x0, x20
104ab7fc8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104ab7fcc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104ab7fd0: a94157f6    	ldp	x22, x21, [sp, #0x10]
104ab7fd4: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104ab7fd8: 14c5bc66    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
