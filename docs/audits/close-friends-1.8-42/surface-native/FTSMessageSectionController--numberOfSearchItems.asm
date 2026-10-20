
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101795d6c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
101795d70: a9015ff8    	stp	x24, x23, [sp, #0x10]
101795d74: a90257f6    	stp	x22, x21, [sp, #0x20]
101795d78: a9034ff4    	stp	x20, x19, [sp, #0x30]
101795d7c: a9047bfd    	stp	x29, x30, [sp, #0x40]
101795d80: 910103fd    	add	x29, sp, #0x40
101795d84: aa0003f3    	mov	x19, x0
101795d88: b00fa4e8    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
101795d8c: 52800029    	mov	w9, #0x1                ; =1
101795d90: 3925a109    	strb	w9, [x8, #0x968]
101795d94: d00f4f48    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
101795d98: f9418d00    	ldr	x0, [x8, #0x318]
101795d9c: b00f4ba8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
101795da0: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
101795da4: 959244e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795da8: aa1d03fd    	mov	x29, x29
101795dac: 959244e7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795db0: aa0003f4    	mov	x20, x0
101795db4: f00f3888    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
101795db8: f9405501    	ldr	x1, [x8, #0xa8] ; splitEnabled
101795dbc: 959244e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795dc0: aa0003f7    	mov	x23, x0
101795dc4: aa1403e0    	mov	x0, x20
101795dc8: 959244e3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795dcc: f00f4b68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101795dd0: f9447d14    	ldr	x20, [x8, #0x8f8] ; model
101795dd4: aa1303e0    	mov	x0, x19
101795dd8: aa1403e1    	mov	x1, x20
101795ddc: 959244d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795de0: aa1d03fd    	mov	x29, x29
101795de4: 959244d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795de8: aa0003f8    	mov	x24, x0
101795dec: f00f4b48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101795df0: f9459515    	ldr	x21, [x8, #0xb28] ; data
101795df4: aa1503e1    	mov	x1, x21
101795df8: 959244d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795dfc: aa1d03fd    	mov	x29, x29
101795e00: 959244d2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795e04: aa0003f9    	mov	x25, x0
101795e08: d00f4f48    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
101795e0c: f942e900    	ldr	x0, [x8, #0x5d0]
101795e10: d00f4b48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101795e14: f947ad16    	ldr	x22, [x8, #0xf58] ; class
101795e18: aa1603e1    	mov	x1, x22
101795e1c: 959244c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795e20: aa0003e2    	mov	x2, x0
101795e24: d00f4b68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101795e28: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
101795e2c: aa1903e0    	mov	x0, x25
101795e30: 959244c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795e34: aa0003fa    	mov	x26, x0
101795e38: aa1903e0    	mov	x0, x25
101795e3c: 959244c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795e40: aa1803e0    	mov	x0, x24
101795e44: 959244c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795e48: 7100035f    	cmp	w26, #0x0
101795e4c: 7a401ae0    	ccmp	w23, #0x0, #0x0, ne
101795e50: 540008e0    	b.eq	0x101795f6c <__text+0x178df6c>
101795e54: b00f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101795e58: f9409101    	ldr	x1, [x8, #0x120] ; displayedSessionUserCount
101795e5c: aa1303e0    	mov	x0, x19
101795e60: 959244b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795e64: aa0003f4    	mov	x20, x0
101795e68: b00f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101795e6c: f9406d01    	ldr	x1, [x8, #0xd8] ; isTalkerEntryEnabled
101795e70: aa1303e0    	mov	x0, x19
101795e74: 959244b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795e78: 34000760    	cbz	w0, 0x101795f64 <__text+0x178df64>
101795e7c: d00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101795e80: f945e900    	ldr	x0, [x8, #0xbd0]
101795e84: f00f4b48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101795e88: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101795e8c: 959244ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795e90: aa1d03fd    	mov	x29, x29
101795e94: 959244ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795e98: aa0003f5    	mov	x21, x0
101795e9c: d00f4ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101795ea0: f9477100    	ldr	x0, [x8, #0xee0]
101795ea4: aa1603e1    	mov	x1, x22
101795ea8: 959244a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795eac: aa0003e2    	mov	x2, x0
101795eb0: 900f3528    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101795eb4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101795eb8: aa1503e0    	mov	x0, x21
101795ebc: 959244a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795ec0: aa1d03fd    	mov	x29, x29
101795ec4: 959244a1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795ec8: aa0003f6    	mov	x22, x0
101795ecc: 900f35c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
101795ed0: f9472d01    	ldr	x1, [x8, #0xe58] ; ftsMessageMgr
101795ed4: 9592449a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795ed8: aa1d03fd    	mov	x29, x29
101795edc: 9592449b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795ee0: aa0003f7    	mov	x23, x0
101795ee4: b00f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101795ee8: f9431901    	ldr	x1, [x8, #0x630] ; curSearchText
101795eec: aa1303e0    	mov	x0, x19
101795ef0: 95924493    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795ef4: aa1d03fd    	mov	x29, x29
101795ef8: 95924494    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795efc: aa0003f8    	mov	x24, x0
101795f00: b00f3888    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101795f04: f943a101    	ldr	x1, [x8, #0x740] ; ftsTaskKey
101795f08: aa1303e0    	mov	x0, x19
101795f0c: 9592448c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795f10: aa1d03fd    	mov	x29, x29
101795f14: 9592448d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795f18: aa0003f3    	mov	x19, x0
101795f1c: b00f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101795f20: f9407101    	ldr	x1, [x8, #0xe0] ; isLikelyTalkerSearch:taskKey:
101795f24: aa1703e0    	mov	x0, x23
101795f28: aa1803e2    	mov	x2, x24
101795f2c: aa1303e3    	mov	x3, x19
101795f30: 95924483    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795f34: aa0003f9    	mov	x25, x0
101795f38: aa1303e0    	mov	x0, x19
101795f3c: 95924486    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795f40: aa1803e0    	mov	x0, x24
101795f44: 95924484    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795f48: aa1703e0    	mov	x0, x23
101795f4c: 95924482    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795f50: aa1603e0    	mov	x0, x22
101795f54: 95924480    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795f58: aa1503e0    	mov	x0, x21
101795f5c: 9592447e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795f60: 8b394294    	add	x20, x20, w25, uxtw
101795f64: aa1403e0    	mov	x0, x20
101795f68: 14000016    	b	0x101795fc0 <__text+0x178dfc0>
101795f6c: aa1303e0    	mov	x0, x19
101795f70: aa1403e1    	mov	x1, x20
101795f74: 95924472    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795f78: aa1d03fd    	mov	x29, x29
101795f7c: 95924473    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795f80: aa0003f3    	mov	x19, x0
101795f84: aa1503e1    	mov	x1, x21
101795f88: 9592446d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795f8c: aa1d03fd    	mov	x29, x29
101795f90: 9592446e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101795f94: aa0003f4    	mov	x20, x0
101795f98: aa1303e0    	mov	x0, x19
101795f9c: 9592446e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795fa0: b00f38a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101795fa4: f9408d01    	ldr	x1, [x8, #0x118] ; getResultCountForDisplay
101795fa8: aa1403e0    	mov	x0, x20
101795fac: 95924464    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101795fb0: aa0003f3    	mov	x19, x0
101795fb4: aa1403e0    	mov	x0, x20
101795fb8: 95924467    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101795fbc: aa1303e0    	mov	x0, x19
101795fc0: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101795fc4: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101795fc8: a94257f6    	ldp	x22, x21, [sp, #0x20]
101795fcc: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101795fd0: a8c567fa    	ldp	x26, x25, [sp], #0x50
101795fd4: d65f03c0    	ret
