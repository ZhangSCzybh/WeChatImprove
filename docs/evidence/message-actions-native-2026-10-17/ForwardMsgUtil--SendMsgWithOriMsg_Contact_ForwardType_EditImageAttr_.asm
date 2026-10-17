
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c44b84: d103c3ff    	sub	sp, sp, #0xf0
101c44b88: 6d0823e9    	stp	d9, d8, [sp, #0x80]
101c44b8c: a9096ffc    	stp	x28, x27, [sp, #0x90]
101c44b90: a90a67fa    	stp	x26, x25, [sp, #0xa0]
101c44b94: a90b5ff8    	stp	x24, x23, [sp, #0xb0]
101c44b98: a90c57f6    	stp	x22, x21, [sp, #0xc0]
101c44b9c: a90d4ff4    	stp	x20, x19, [sp, #0xd0]
101c44ba0: a90e7bfd    	stp	x29, x30, [sp, #0xe0]
101c44ba4: 910383fd    	add	x29, sp, #0xe0
101c44ba8: b9000fe4    	str	w4, [sp, #0xc]
101c44bac: aa0303f3    	mov	x19, x3
101c44bb0: aa0203f4    	mov	x20, x2
101c44bb4: aa0003f5    	mov	x21, x0
101c44bb8: f00f7f68    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c44bbc: 52800029    	mov	w9, #0x1                ; =1
101c44bc0: 3926ed09    	strb	w9, [x8, #0x9bb]
101c44bc4: aa0203e0    	mov	x0, x2
101c44bc8: 957f895c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c44bcc: aa1303e0    	mov	x0, x19
101c44bd0: 957f895a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c44bd4: b00f10c8    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
101c44bd8: f940e901    	ldr	x1, [x8, #0x1d0] ; GenForwardMsgFromMsgWrap:ToContact:
101c44bdc: aa1503e0    	mov	x0, x21
101c44be0: aa1403e2    	mov	x2, x20
101c44be4: aa1303e3    	mov	x3, x19
101c44be8: 957f8955    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44bec: aa1d03fd    	mov	x29, x29
101c44bf0: 957f8956    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c44bf4: aa0003f5    	mov	x21, x0
101c44bf8: f00f2968    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c44bfc: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
101c44c00: 900f25e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101c44c04: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
101c44c08: aa1603e1    	mov	x1, x22
101c44c0c: 957f894c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44c10: aa1d03fd    	mov	x29, x29
101c44c14: 957f894d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c44c18: aa0003fb    	mov	x27, x0
101c44c1c: d00f2988    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
101c44c20: f9420900    	ldr	x0, [x8, #0x410] ; ��E 
101c44c24: f00f25c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101c44c28: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101c44c2c: f9000be1    	str	x1, [sp, #0x10]
101c44c30: 957f8943    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44c34: aa0003e2    	mov	x2, x0
101c44c38: b00f0fa8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101c44c3c: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
101c44c40: aa1b03e0    	mov	x0, x27
101c44c44: aa1803e1    	mov	x1, x24
101c44c48: 957f893d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44c4c: aa1d03fd    	mov	x29, x29
101c44c50: 957f893e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c44c54: aa0003fc    	mov	x28, x0
101c44c58: f00f0fa8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101c44c5c: f9434d19    	ldr	x25, [x8, #0x698] ; m_nsUsrName
101c44c60: aa1303e0    	mov	x0, x19
101c44c64: aa1903e1    	mov	x1, x25
101c44c68: 957f8935    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44c6c: aa1d03fd    	mov	x29, x29
101c44c70: 957f8936    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c44c74: aa0003fa    	mov	x26, x0
101c44c78: f00f1028    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
101c44c7c: f942a101    	ldr	x1, [x8, #0x540] ; isTempChatForUserName:
101c44c80: aa1c03e0    	mov	x0, x28
101c44c84: aa1a03e2    	mov	x2, x26
101c44c88: 957f892d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44c8c: aa0003f7    	mov	x23, x0
101c44c90: aa1a03e0    	mov	x0, x26
101c44c94: 957f8930    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44c98: aa1c03e0    	mov	x0, x28
101c44c9c: 957f892e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44ca0: aa1b03e0    	mov	x0, x27
101c44ca4: 957f892c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44ca8: b00f10c8    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
101c44cac: f9411501    	ldr	x1, [x8, #0x228] ; fillMsgSourceFromContact:isFromTempSession:
101c44cb0: aa1503e0    	mov	x0, x21
101c44cb4: aa1303e2    	mov	x2, x19
101c44cb8: aa1703e3    	mov	x3, x23
101c44cbc: 957f8920    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44cc0: f00f1028    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
101c44cc4: f941bd01    	ldr	x1, [x8, #0x378] ; setM_forwardType:
101c44cc8: aa1503e0    	mov	x0, x21
101c44ccc: b9400fe2    	ldr	w2, [sp, #0xc]
101c44cd0: 957f891b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44cd4: f00f2968    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c44cd8: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
101c44cdc: aa1603e1    	mov	x1, x22
101c44ce0: 957f8917    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44ce4: aa1d03fd    	mov	x29, x29
101c44ce8: 957f8918    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c44cec: aa0003f7    	mov	x23, x0
101c44cf0: 900f2968    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
101c44cf4: f9472d1b    	ldr	x27, [x8, #0xe58]
101c44cf8: b00f13c8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c44cfc: f941791c    	ldr	x28, [x8, #0x2f0] ; onPreForwardMsgToContact:msgWrap:
101c44d00: d00dcd48    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
101c44d04: f947e108    	ldr	x8, [x8, #0xfc0]
101c44d08: f9002be8    	str	x8, [sp, #0x50]
101c44d0c: b00b89e8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
101c44d10: fd41c108    	ldr	d8, [x8, #0x380]
101c44d14: fd002fe8    	str	d8, [sp, #0x58]
101c44d18: 90000008    	adrp	x8, 0x101c44000 <_Flutter_Image_provideRelativePathByUrl+0x50eb0>
101c44d1c: 913ba108    	add	x8, x8, #0xee8
101c44d20: d00dcda9    	adrp	x9, 0x11d5fa000 <dyld_stub_binder+0x11d5fa000>
101c44d24: 911e4129    	add	x9, x9, #0x790
101c44d28: a90627e8    	stp	x8, x9, [sp, #0x60]
101c44d2c: aa1303e0    	mov	x0, x19
101c44d30: 957f8902    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c44d34: f9003bf3    	str	x19, [sp, #0x70]
101c44d38: aa1503e0    	mov	x0, x21
101c44d3c: 957f88ff    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c44d40: f9003ff5    	str	x21, [sp, #0x78]
101c44d44: d00f0fa8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101c44d48: f940491a    	ldr	x26, [x8, #0x90] ; callExtension:selector:block:
101c44d4c: 910143e4    	add	x4, sp, #0x50
101c44d50: aa1703e0    	mov	x0, x23
101c44d54: aa1a03e1    	mov	x1, x26
101c44d58: aa1b03e2    	mov	x2, x27
101c44d5c: aa1c03e3    	mov	x3, x28
101c44d60: 957f88f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44d64: aa1703e0    	mov	x0, x23
101c44d68: 957f88fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44d6c: f9403fe0    	ldr	x0, [sp, #0x78]
101c44d70: 957f88f9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44d74: f9403be0    	ldr	x0, [sp, #0x70]
101c44d78: 957f88f7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44d7c: f00f297b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
101c44d80: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
101c44d84: aa1603e1    	mov	x1, x22
101c44d88: 957f88ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44d8c: aa1d03fd    	mov	x29, x29
101c44d90: 957f88ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c44d94: aa0003f7    	mov	x23, x0
101c44d98: 900f2988    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101c44d9c: f9403100    	ldr	x0, [x8, #0x60] ; ��7 
101c44da0: f9400be1    	ldr	x1, [sp, #0x10]
101c44da4: 957f88e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44da8: aa0003e2    	mov	x2, x0
101c44dac: aa1703e0    	mov	x0, x23
101c44db0: aa1803e1    	mov	x1, x24
101c44db4: 957f88e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44db8: aa1d03fd    	mov	x29, x29
101c44dbc: 957f88e3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c44dc0: aa0003f8    	mov	x24, x0
101c44dc4: aa1303e0    	mov	x0, x19
101c44dc8: aa1903e1    	mov	x1, x25
101c44dcc: 957f88dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44dd0: aa1d03fd    	mov	x29, x29
101c44dd4: 957f88dd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c44dd8: aa0003f9    	mov	x25, x0
101c44ddc: f00f0fe8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101c44de0: f945a501    	ldr	x1, [x8, #0xb48] ; AddMsg:MsgWrap:
101c44de4: aa1803e0    	mov	x0, x24
101c44de8: aa1903e2    	mov	x2, x25
101c44dec: aa1503e3    	mov	x3, x21
101c44df0: 957f88d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44df4: aa1903e0    	mov	x0, x25
101c44df8: 957f88d7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44dfc: aa1803e0    	mov	x0, x24
101c44e00: 957f88d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44e04: aa1703e0    	mov	x0, x23
101c44e08: 957f88d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44e0c: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
101c44e10: aa1603e1    	mov	x1, x22
101c44e14: 957f88ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44e18: aa1d03fd    	mov	x29, x29
101c44e1c: 957f88cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c44e20: aa0003f6    	mov	x22, x0
101c44e24: 900f2968    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
101c44e28: f9472d17    	ldr	x23, [x8, #0xe58]
101c44e2c: b00f13c8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c44e30: f9417d18    	ldr	x24, [x8, #0x2f8] ; onAfterForwardMsgToContact:msgWrap:fromMsg:
101c44e34: d00dcd48    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
101c44e38: f947e108    	ldr	x8, [x8, #0xfc0]
101c44e3c: f9000fe8    	str	x8, [sp, #0x18]
101c44e40: 90000008    	adrp	x8, 0x101c44000 <_Flutter_Image_provideRelativePathByUrl+0x50eb0>
101c44e44: 913c0108    	add	x8, x8, #0xf00
101c44e48: fd0013e8    	str	d8, [sp, #0x20]
101c44e4c: 900dce49    	adrp	x9, 0x11d60c000 <dyld_stub_binder+0x11d60c000>
101c44e50: 91194129    	add	x9, x9, #0x650
101c44e54: a902a7e8    	stp	x8, x9, [sp, #0x28]
101c44e58: f9001ff3    	str	x19, [sp, #0x38]
101c44e5c: aa1503e0    	mov	x0, x21
101c44e60: 957f88b6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c44e64: a90453f5    	stp	x21, x20, [sp, #0x40]
101c44e68: aa1403e0    	mov	x0, x20
101c44e6c: 957f88b3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c44e70: aa1303e0    	mov	x0, x19
101c44e74: 957f88b1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c44e78: 910063e4    	add	x4, sp, #0x18
101c44e7c: aa1603e0    	mov	x0, x22
101c44e80: aa1a03e1    	mov	x1, x26
101c44e84: aa1703e2    	mov	x2, x23
101c44e88: aa1803e3    	mov	x3, x24
101c44e8c: 957f88ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44e90: aa1603e0    	mov	x0, x22
101c44e94: 957f88b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44e98: f94027e0    	ldr	x0, [sp, #0x48]
101c44e9c: 957f88ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44ea0: f94023e0    	ldr	x0, [sp, #0x40]
101c44ea4: 957f88ac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44ea8: f9401fe0    	ldr	x0, [sp, #0x38]
101c44eac: 957f88aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44eb0: aa1403e0    	mov	x0, x20
101c44eb4: 957f88a8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44eb8: aa1303e0    	mov	x0, x19
101c44ebc: 957f88a6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c44ec0: aa1503e0    	mov	x0, x21
101c44ec4: a94e7bfd    	ldp	x29, x30, [sp, #0xe0]
101c44ec8: a94d4ff4    	ldp	x20, x19, [sp, #0xd0]
101c44ecc: a94c57f6    	ldp	x22, x21, [sp, #0xc0]
101c44ed0: a94b5ff8    	ldp	x24, x23, [sp, #0xb0]
101c44ed4: a94a67fa    	ldp	x26, x25, [sp, #0xa0]
101c44ed8: a9496ffc    	ldp	x28, x27, [sp, #0x90]
101c44edc: 6d4823e9    	ldp	d9, d8, [sp, #0x80]
101c44ee0: 9103c3ff    	add	sp, sp, #0xf0
101c44ee4: 157f88a3    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
101c44ee8: aa0103e8    	mov	x8, x1
101c44eec: a9420c02    	ldp	x2, x3, [x0, #0x20]
101c44ef0: b00f13c9    	adrp	x9, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c44ef4: f9417921    	ldr	x1, [x9, #0x2f0] ; onPreForwardMsgToContact:msgWrap:
101c44ef8: aa0803e0    	mov	x0, x8
101c44efc: 157f8890    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c44f00: aa0103e8    	mov	x8, x1
101c44f04: a9420c02    	ldp	x2, x3, [x0, #0x20]
101c44f08: f9401804    	ldr	x4, [x0, #0x30]
101c44f0c: b00f13c9    	adrp	x9, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c44f10: f9417d21    	ldr	x1, [x9, #0x2f8] ; onAfterForwardMsgToContact:msgWrap:fromMsg:
101c44f14: aa0803e0    	mov	x0, x8
101c44f18: 157f8889    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>