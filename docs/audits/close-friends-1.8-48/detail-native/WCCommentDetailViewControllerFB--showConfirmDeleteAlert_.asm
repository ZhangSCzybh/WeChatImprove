
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e90ccc: d10383ff    	sub	sp, sp, #0xe0
106e90cd0: 6d0723e9    	stp	d9, d8, [sp, #0x70]
106e90cd4: a9086ffc    	stp	x28, x27, [sp, #0x80]
106e90cd8: a90967fa    	stp	x26, x25, [sp, #0x90]
106e90cdc: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
106e90ce0: a90b57f6    	stp	x22, x21, [sp, #0xb0]
106e90ce4: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
106e90ce8: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
106e90cec: 910343fd    	add	x29, sp, #0xd0
106e90cf0: f90003e2    	str	x2, [sp]
106e90cf4: aa0003f9    	mov	x25, x0
106e90cf8: d00ceda8    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106e90cfc: 52800029    	mov	w9, #0x1                ; =1
106e90d00: 391af109    	strb	w9, [x8, #0x6bc]
106e90d04: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e90d08: f947ad00    	ldr	x0, [x8, #0xf58]
106e90d0c: 94365915    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106e90d10: aa0003f4    	mov	x20, x0
106e90d14: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e90d18: f945e900    	ldr	x0, [x8, #0xbd0]
106e90d1c: 900c9388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e90d20: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
106e90d24: aa1503e1    	mov	x1, x21
106e90d28: 94365905    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90d2c: aa1d03fd    	mov	x29, x29
106e90d30: 94365906    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90d34: aa0003fa    	mov	x26, x0
106e90d38: f00c9713    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
106e90d3c: f9462a60    	ldr	x0, [x19, #0xc50]
106e90d40: f00c9368    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e90d44: f947ad16    	ldr	x22, [x8, #0xf58] ; class
106e90d48: aa1603e1    	mov	x1, x22
106e90d4c: 943658fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90d50: aa0003e2    	mov	x2, x0
106e90d54: b00c7d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e90d58: f9464117    	ldr	x23, [x8, #0xc80] ; getService:
106e90d5c: aa1a03e0    	mov	x0, x26
106e90d60: aa1703e1    	mov	x1, x23
106e90d64: 943658f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90d68: aa1d03fd    	mov	x29, x29
106e90d6c: 943658f7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90d70: aa0003fb    	mov	x27, x0
106e90d74: b00c7d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e90d78: f9464518    	ldr	x24, [x8, #0xc88] ; getStringForCurLanguage:
106e90d7c: 900bd2e2    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e90d80: 9136a042    	add	x2, x2, #0xda8
106e90d84: aa1803e1    	mov	x1, x24
106e90d88: 943658ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90d8c: aa1d03fd    	mov	x29, x29
106e90d90: 943658ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90d94: aa0003fc    	mov	x28, x0
106e90d98: d00c7d88    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
106e90d9c: f9464901    	ldr	x1, [x8, #0xc90] ; initWithTitle:content:buttons:
106e90da0: aa1403e0    	mov	x0, x20
106e90da4: aa1c03e2    	mov	x2, x28
106e90da8: d2800003    	mov	x3, #0x0                ; =0
106e90dac: d2800004    	mov	x4, #0x0                ; =0
106e90db0: 943658e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90db4: aa0003f4    	mov	x20, x0
106e90db8: aa1c03e0    	mov	x0, x28
106e90dbc: 943658e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90dc0: aa1b03e0    	mov	x0, x27
106e90dc4: 943658e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90dc8: aa1a03e0    	mov	x0, x26
106e90dcc: 943658e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90dd0: 9101a3e0    	add	x0, sp, #0x68
106e90dd4: aa1903e1    	mov	x1, x25
106e90dd8: 943658e5    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
106e90ddc: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e90de0: f945e900    	ldr	x0, [x8, #0xbd0]
106e90de4: aa1503e1    	mov	x1, x21
106e90de8: 943658d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90dec: aa1d03fd    	mov	x29, x29
106e90df0: 943658d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90df4: aa0003f9    	mov	x25, x0
106e90df8: f9462a60    	ldr	x0, [x19, #0xc50]
106e90dfc: aa1603e1    	mov	x1, x22
106e90e00: 943658cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90e04: aa0003e2    	mov	x2, x0
106e90e08: aa1903e0    	mov	x0, x25
106e90e0c: aa1703e1    	mov	x1, x23
106e90e10: 943658cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90e14: aa1d03fd    	mov	x29, x29
106e90e18: 943658cc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90e1c: aa0003fa    	mov	x26, x0
106e90e20: f00bb062    	adrp	x2, 0x11e49f000 <dyld_stub_binder+0x11e49f000>
106e90e24: 9128a042    	add	x2, x2, #0xa28
106e90e28: aa1803e1    	mov	x1, x24
106e90e2c: 943658c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90e30: aa1d03fd    	mov	x29, x29
106e90e34: 943658c5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90e38: aa0003fb    	mov	x27, x0
106e90e3c: d00b3ae8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
106e90e40: f947e108    	ldr	x8, [x8, #0xfc0]
106e90e44: f9001fe8    	str	x8, [sp, #0x38]
106e90e48: b008f788    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
106e90e4c: fd41c108    	ldr	d8, [x8, #0x380]
106e90e50: 90000008    	adrp	x8, 0x106e90000 <_Flutter_MMFoundation_BindContext+0x336bbe4>
106e90e54: 913f3108    	add	x8, x8, #0xfcc
106e90e58: fd0023e8    	str	d8, [sp, #0x40]
106e90e5c: f00b3b33    	adrp	x19, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
106e90e60: 91182273    	add	x19, x19, #0x608
106e90e64: a904cfe8    	stp	x8, x19, [sp, #0x48]
106e90e68: 9100e3e8    	add	x8, sp, #0x38
106e90e6c: 91008100    	add	x0, x8, #0x20
106e90e70: 9101a3e1    	add	x1, sp, #0x68
106e90e74: 943658c1    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
106e90e78: f94003fc    	ldr	x28, [sp]
106e90e7c: f90033fc    	str	x28, [sp, #0x60]
106e90e80: d00c7d88    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
106e90e84: f9464d01    	ldr	x1, [x8, #0xc98] ; addButtonWithTitle:handler:
106e90e88: 9100e3e3    	add	x3, sp, #0x38
106e90e8c: aa1403e0    	mov	x0, x20
106e90e90: aa1b03e2    	mov	x2, x27
106e90e94: 943658aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90e98: aa1b03e0    	mov	x0, x27
106e90e9c: 943658ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90ea0: aa1a03e0    	mov	x0, x26
106e90ea4: 943658ac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90ea8: aa1903e0    	mov	x0, x25
106e90eac: 943658aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90eb0: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e90eb4: f945e900    	ldr	x0, [x8, #0xbd0]
106e90eb8: aa1503e1    	mov	x1, x21
106e90ebc: 943658a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90ec0: aa1d03fd    	mov	x29, x29
106e90ec4: 943658a1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90ec8: aa0003f5    	mov	x21, x0
106e90ecc: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e90ed0: f9462900    	ldr	x0, [x8, #0xc50]
106e90ed4: aa1603e1    	mov	x1, x22
106e90ed8: 94365899    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90edc: aa0003e2    	mov	x2, x0
106e90ee0: aa1503e0    	mov	x0, x21
106e90ee4: aa1703e1    	mov	x1, x23
106e90ee8: 94365895    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90eec: aa1d03fd    	mov	x29, x29
106e90ef0: 94365896    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90ef4: aa0003f6    	mov	x22, x0
106e90ef8: b00bb0c2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
106e90efc: 91042042    	add	x2, x2, #0x108
106e90f00: aa1803e1    	mov	x1, x24
106e90f04: 9436588e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90f08: aa1d03fd    	mov	x29, x29
106e90f0c: 9436588f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90f10: aa0003f7    	mov	x23, x0
106e90f14: d00b3ae8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
106e90f18: f947e108    	ldr	x8, [x8, #0xfc0]
106e90f1c: f90007e8    	str	x8, [sp, #0x8]
106e90f20: fd000be8    	str	d8, [sp, #0x10]
106e90f24: b0000008    	adrp	x8, 0x106e91000 <_Flutter_MMFoundation_BindContext+0x336cbe4>
106e90f28: 91023108    	add	x8, x8, #0x8c
106e90f2c: a901cfe8    	stp	x8, x19, [sp, #0x18]
106e90f30: 910023f3    	add	x19, sp, #0x8
106e90f34: 91008260    	add	x0, x19, #0x20
106e90f38: 9101a3e1    	add	x1, sp, #0x68
106e90f3c: 9436588f    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
106e90f40: f9001bfc    	str	x28, [sp, #0x30]
106e90f44: d00c7d88    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
106e90f48: f9465901    	ldr	x1, [x8, #0xcb0] ; addDestructiveButtonWithTitle:handler:
106e90f4c: 910023e3    	add	x3, sp, #0x8
106e90f50: aa1403e0    	mov	x0, x20
106e90f54: aa1703e2    	mov	x2, x23
106e90f58: 94365879    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90f5c: aa1703e0    	mov	x0, x23
106e90f60: 9436587d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90f64: aa1603e0    	mov	x0, x22
106e90f68: 9436587b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90f6c: aa1503e0    	mov	x0, x21
106e90f70: 94365879    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90f74: f00c7d48    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106e90f78: f944d501    	ldr	x1, [x8, #0x9a8] ; show
106e90f7c: aa1403e0    	mov	x0, x20
106e90f80: 9436586f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90f84: 91008260    	add	x0, x19, #0x20
106e90f88: 94365882    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
106e90f8c: 9100e3e8    	add	x8, sp, #0x38
106e90f90: 91008100    	add	x0, x8, #0x20
106e90f94: 9436587f    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
106e90f98: 9101a3e0    	add	x0, sp, #0x68
106e90f9c: 9436587d    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
106e90fa0: aa1403e0    	mov	x0, x20
106e90fa4: 9436586c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90fa8: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
106e90fac: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
106e90fb0: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
106e90fb4: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
106e90fb8: a94967fa    	ldp	x26, x25, [sp, #0x90]
106e90fbc: a9486ffc    	ldp	x28, x27, [sp, #0x80]
106e90fc0: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
106e90fc4: 910383ff    	add	sp, sp, #0xe0
106e90fc8: d65f03c0    	ret
