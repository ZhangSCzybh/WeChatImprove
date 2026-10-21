
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101730c9c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
101730ca0: a9015ff8    	stp	x24, x23, [sp, #0x10]
101730ca4: a90257f6    	stp	x22, x21, [sp, #0x20]
101730ca8: a9034ff4    	stp	x20, x19, [sp, #0x30]
101730cac: a9047bfd    	stp	x29, x30, [sp, #0x40]
101730cb0: 910103fd    	add	x29, sp, #0x40
101730cb4: aa0303f4    	mov	x20, x3
101730cb8: aa0203f3    	mov	x19, x2
101730cbc: aa0003f5    	mov	x21, x0
101730cc0: d00fa808    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
101730cc4: 52800029    	mov	w9, #0x1                ; =1
101730cc8: 39204109    	strb	w9, [x8, #0x810]
101730ccc: 900f5608    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
101730cd0: b98b5d08    	ldrsw	x8, [x8, #0xb5c]
101730cd4: f8686816    	ldr	x22, [x0, x8]
101730cd8: d00f3848    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101730cdc: f942c117    	ldr	x23, [x8, #0x580] ; safeObjectAtIndex:
101730ce0: aa0303e0    	mov	x0, x3
101730ce4: 9593d915    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101730ce8: aa1603e0    	mov	x0, x22
101730cec: aa1703e1    	mov	x1, x23
101730cf0: aa1303e2    	mov	x2, x19
101730cf4: 9593d912    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730cf8: aa1d03fd    	mov	x29, x29
101730cfc: 9593d913    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101730d00: aa0003f6    	mov	x22, x0
101730d04: 900f4ea8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101730d08: f9447d01    	ldr	x1, [x8, #0x8f8] ; model
101730d0c: 9593d90c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730d10: aa1d03fd    	mov	x29, x29
101730d14: 9593d90d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101730d18: aa0003f3    	mov	x19, x0
101730d1c: aa1603e0    	mov	x0, x22
101730d20: 9593d90d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101730d24: d00f3ba8    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101730d28: f9424901    	ldr	x1, [x8, #0x490] ; tableViewContext
101730d2c: aa1503e0    	mov	x0, x21
101730d30: 9593d903    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730d34: aa1d03fd    	mov	x29, x29
101730d38: 9593d904    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101730d3c: aa0003f6    	mov	x22, x0
101730d40: f00f5208    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101730d44: f9461d00    	ldr	x0, [x8, #0xc38]
101730d48: f00f4e68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101730d4c: f947ad17    	ldr	x23, [x8, #0xf58] ; class
101730d50: aa1703e1    	mov	x1, x23
101730d54: 9593d8fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730d58: aa0003f8    	mov	x24, x0
101730d5c: d00f4ea8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101730d60: f9440901    	ldr	x1, [x8, #0x810] ; row
101730d64: aa1403e0    	mov	x0, x20
101730d68: 9593d8f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730d6c: aa0003f9    	mov	x25, x0
101730d70: aa1403e0    	mov	x0, x20
101730d74: 9593d8f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101730d78: d00f3ba8    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101730d7c: f9424d01    	ldr	x1, [x8, #0x498] ; dequeueReusableCellOfClass:forSectionController:atIndex:
101730d80: aa1603e0    	mov	x0, x22
101730d84: aa1803e2    	mov	x2, x24
101730d88: aa1503e3    	mov	x3, x21
101730d8c: aa1903e4    	mov	x4, x25
101730d90: 9593d8eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730d94: aa1d03fd    	mov	x29, x29
101730d98: 9593d8ec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101730d9c: aa0003f4    	mov	x20, x0
101730da0: aa1603e0    	mov	x0, x22
101730da4: 9593d8ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101730da8: d00f3ba8    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101730dac: f9425101    	ldr	x1, [x8, #0x4a0] ; isGlobalSearch
101730db0: aa1503e0    	mov	x0, x21
101730db4: 9593d8e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730db8: aa0003f6    	mov	x22, x0
101730dbc: f00f5208    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101730dc0: f945e900    	ldr	x0, [x8, #0xbd0]
101730dc4: 900f4e88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101730dc8: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101730dcc: 9593d8dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730dd0: aa1d03fd    	mov	x29, x29
101730dd4: 9593d8dd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101730dd8: aa0003f5    	mov	x21, x0
101730ddc: f00f5208    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101730de0: f9477100    	ldr	x0, [x8, #0xee0]
101730de4: aa1703e1    	mov	x1, x23
101730de8: 9593d8d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730dec: aa0003e2    	mov	x2, x0
101730df0: b00f3848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101730df4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101730df8: aa1503e0    	mov	x0, x21
101730dfc: 9593d8d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730e00: aa1d03fd    	mov	x29, x29
101730e04: 9593d8d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101730e08: aa0003f7    	mov	x23, x0
101730e0c: 900f3bc8    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
101730e10: f9416101    	ldr	x1, [x8, #0x2c0] ; finderLocalSearchMgr
101730e14: 9593d8ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730e18: aa1d03fd    	mov	x29, x29
101730e1c: 9593d8cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101730e20: aa0003f8    	mov	x24, x0
101730e24: f00f3848    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101730e28: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
101730e2c: aa1303e0    	mov	x0, x19
101730e30: 9593d8c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730e34: aa1d03fd    	mov	x29, x29
101730e38: 9593d8c4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101730e3c: aa0003f9    	mov	x25, x0
101730e40: 900f3bc8    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
101730e44: 910b2108    	add	x8, x8, #0x2c8
101730e48: 900f3bc9    	adrp	x9, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
101730e4c: 910b4129    	add	x9, x9, #0x2d0
101730e50: 710002df    	cmp	w22, #0x0
101730e54: 9a891108    	csel	x8, x8, x9, ne
101730e58: f9400101    	ldr	x1, [x8]
101730e5c: aa1803e0    	mov	x0, x24
101730e60: aa1903e2    	mov	x2, x25
101730e64: 9593d8b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730e68: aa1d03fd    	mov	x29, x29
101730e6c: 9593d8b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101730e70: aa0003f6    	mov	x22, x0
101730e74: aa1903e0    	mov	x0, x25
101730e78: 9593d8b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101730e7c: aa1803e0    	mov	x0, x24
101730e80: 9593d8b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101730e84: aa1703e0    	mov	x0, x23
101730e88: 9593d8b3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101730e8c: aa1503e0    	mov	x0, x21
101730e90: 9593d8b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101730e94: b00f3848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101730e98: f9463d01    	ldr	x1, [x8, #0xc78] ; updateContact:matchTip:
101730e9c: aa1403e0    	mov	x0, x20
101730ea0: aa1303e2    	mov	x2, x19
101730ea4: aa1603e3    	mov	x3, x22
101730ea8: 9593d8a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730eac: d00f3848    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101730eb0: f943a501    	ldr	x1, [x8, #0x748] ; attachObject:forKey:
101730eb4: f00e72c3    	adrp	x3, 0x11e58b000 <dyld_stub_binder+0x11e58b000>
101730eb8: 91092063    	add	x3, x3, #0x248
101730ebc: aa1403e0    	mov	x0, x20
101730ec0: aa1603e2    	mov	x2, x22
101730ec4: 9593d89e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101730ec8: aa1603e0    	mov	x0, x22
101730ecc: 9593d8a2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101730ed0: aa1303e0    	mov	x0, x19
101730ed4: 9593d8a0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101730ed8: aa1403e0    	mov	x0, x20
101730edc: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101730ee0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101730ee4: a94257f6    	ldp	x22, x21, [sp, #0x20]
101730ee8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101730eec: a8c567fa    	ldp	x26, x25, [sp], #0x50
101730ef0: 1593d8a0    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
