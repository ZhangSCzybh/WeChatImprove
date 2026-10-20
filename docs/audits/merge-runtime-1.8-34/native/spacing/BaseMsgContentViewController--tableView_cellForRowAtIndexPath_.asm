
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100320d74: d10343ff    	sub	sp, sp, #0xd0
100320d78: 6d0623e9    	stp	d9, d8, [sp, #0x60]
100320d7c: a9076ffc    	stp	x28, x27, [sp, #0x70]
100320d80: a90867fa    	stp	x26, x25, [sp, #0x80]
100320d84: a9095ff8    	stp	x24, x23, [sp, #0x90]
100320d88: a90a57f6    	stp	x22, x21, [sp, #0xa0]
100320d8c: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
100320d90: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
100320d94: 910303fd    	add	x29, sp, #0xc0
100320d98: aa0303f4    	mov	x20, x3
100320d9c: aa0203f3    	mov	x19, x2
100320da0: aa0003f6    	mov	x22, x0
100320da4: b0104868    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
100320da8: 52800029    	mov	w9, #0x1                ; =1
100320dac: 3937a909    	strb	w9, [x8, #0xdea]
100320db0: aa0203e0    	mov	x0, x2
100320db4: 95e418e1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100320db8: aa1403e0    	mov	x0, x20
100320dbc: 95e418df    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100320dc0: f00ff5e8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100320dc4: b9852508    	ldrsw	x8, [x8, #0x524]
100320dc8: 8b0802d5    	add	x21, x22, x8
100320dcc: f94006a8    	ldr	x8, [x21, #0x8]
100320dd0: 900fd8f8    	adrp	x24, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100320dd4: b4000108    	cbz	x8, 0x100320df4 <__text+0x318df4>
100320dd8: f9427f01    	ldr	x1, [x24, #0x4f8] ; section
100320ddc: aa1403e0    	mov	x0, x20
100320de0: 95e418d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320de4: a94026a8    	ldp	x8, x9, [x21]
100320de8: eb080008    	subs	x8, x0, x8
100320dec: fa492102    	ccmp	x8, x9, #0x2, hs
100320df0: 54001da3    	b.lo	0x1003211a4 <__text+0x3191a4>
100320df4: f00ff5e8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100320df8: b9842917    	ldrsw	x23, [x8, #0x428]
100320dfc: f8776ac0    	ldr	x0, [x22, x23]
100320e00: b4001d20    	cbz	x0, 0x1003211a4 <__text+0x3191a4>
100320e04: 900fef08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100320e08: f9435101    	ldr	x1, [x8, #0x6a0] ; count
100320e0c: 95e418cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320e10: aa0003f5    	mov	x21, x0
100320e14: f9427f18    	ldr	x24, [x24, #0x4f8] ; section
100320e18: aa1403e0    	mov	x0, x20
100320e1c: aa1803e1    	mov	x1, x24
100320e20: 95e418c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320e24: eb0002bf    	cmp	x21, x0
100320e28: 54001be9    	b.ls	0x1003211a4 <__text+0x3191a4>
100320e2c: f8776ad5    	ldr	x21, [x22, x23]
100320e30: aa1403e0    	mov	x0, x20
100320e34: aa1803e1    	mov	x1, x24
100320e38: 95e418c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320e3c: aa0003e2    	mov	x2, x0
100320e40: 900fef28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100320e44: f947e101    	ldr	x1, [x8, #0xfc0] ; objectAtIndexedSubscript:
100320e48: aa1503e0    	mov	x0, x21
100320e4c: 95e418bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320e50: aa1d03fd    	mov	x29, x29
100320e54: 95e418bd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100320e58: aa0003f5    	mov	x21, x0
100320e5c: f00fd928    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
100320e60: f943f101    	ldr	x1, [x8, #0x7e0] ; cellIdentifier
100320e64: 95e418b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320e68: aa1d03fd    	mov	x29, x29
100320e6c: 95e418b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100320e70: aa0003fb    	mov	x27, x0
100320e74: d00fd968    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100320e78: f9422d01    	ldr	x1, [x8, #0x458] ; shouldReCreate
100320e7c: aa1503e0    	mov	x0, x21
100320e80: 95e418af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320e84: 34000aa0    	cbz	w0, 0x100320fd8 <__text+0x318fd8>
100320e88: d00ff2a8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
100320e8c: f9452900    	ldr	x0, [x8, #0xa50]
100320e90: f00feee8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100320e94: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100320e98: 95e418a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320e9c: aa0003e2    	mov	x2, x0
100320ea0: f00fef08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100320ea4: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
100320ea8: aa1503e0    	mov	x0, x21
100320eac: 95e418a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320eb0: 34000940    	cbz	w0, 0x100320fd8 <__text+0x318fd8>
100320eb4: f00ff288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100320eb8: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
100320ebc: b00fd8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100320ec0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
100320ec4: b00f0d08    	adrp	x8, 0x11e4c1000 <dyld_stub_binder+0x11e4c1000>
100320ec8: 910da108    	add	x8, x8, #0x368
100320ecc: f90003e8    	str	x8, [sp]
100320ed0: f00d7945    	adrp	x5, 0x11b24b000 <dyld_stub_binder+0x11b24b000>
100320ed4: 9122c4a5    	add	x5, x5, #0x8b1
100320ed8: d00d7967    	adrp	x7, 0x11b24e000 <dyld_stub_binder+0x11b24e000>
100320edc: 9102f8e7    	add	x7, x7, #0xbe
100320ee0: 52800042    	mov	w2, #0x2                ; =2
100320ee4: d2800003    	mov	x3, #0x0                ; =0
100320ee8: 52800004    	mov	w4, #0x0                ; =0
100320eec: 5283ddc6    	mov	w6, #0x1eee             ; =7918
100320ef0: 95e41893    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320ef4: d00ff2a8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
100320ef8: f9418119    	ldr	x25, [x8, #0x300] ; �+* 
100320efc: d00fd8e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100320f00: f941051a    	ldr	x26, [x8, #0x208] ; messageWrap
100320f04: aa1503e0    	mov	x0, x21
100320f08: 95e4188c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100320f0c: aa1a03e1    	mov	x1, x26
100320f10: 95e4188b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320f14: aa1d03fd    	mov	x29, x29
100320f18: 95e4188c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100320f1c: aa0003fa    	mov	x26, x0
100320f20: b00fd8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100320f24: f9463901    	ldr	x1, [x8, #0xc70] ; contact
100320f28: aa1503e0    	mov	x0, x21
100320f2c: 95e41884    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320f30: aa1d03fd    	mov	x29, x29
100320f34: 95e41885    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100320f38: f90007fb    	str	x27, [sp, #0x8]
100320f3c: aa0003fb    	mov	x27, x0
100320f40: f00fd8e8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100320f44: f9437901    	ldr	x1, [x8, #0x6f0] ; chatContact
100320f48: aa1503e0    	mov	x0, x21
100320f4c: 95e4187c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320f50: aa1d03fd    	mov	x29, x29
100320f54: 95e4187d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100320f58: aa0003fc    	mov	x28, x0
100320f5c: aa1503e0    	mov	x0, x21
100320f60: 95e4187d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100320f64: b00fd968    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
100320f68: f9476901    	ldr	x1, [x8, #0xed0] ; createMessageViewModelWithMessageWrap:contact:chatContact:
100320f6c: aa1903e0    	mov	x0, x25
100320f70: aa1a03e2    	mov	x2, x26
100320f74: aa1b03e3    	mov	x3, x27
100320f78: aa1c03e4    	mov	x4, x28
100320f7c: 95e41870    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320f80: aa1d03fd    	mov	x29, x29
100320f84: 95e41871    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100320f88: aa0003f9    	mov	x25, x0
100320f8c: aa1c03e0    	mov	x0, x28
100320f90: 95e41871    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100320f94: aa1b03e0    	mov	x0, x27
100320f98: f94007fb    	ldr	x27, [sp, #0x8]
100320f9c: 95e4186e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100320fa0: aa1a03e0    	mov	x0, x26
100320fa4: 95e4186c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100320fa8: f8776ada    	ldr	x26, [x22, x23]
100320fac: aa1403e0    	mov	x0, x20
100320fb0: aa1803e1    	mov	x1, x24
100320fb4: 95e41862    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320fb8: aa0003e2    	mov	x2, x0
100320fbc: d00fd8e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100320fc0: f946d901    	ldr	x1, [x8, #0xdb0] ; safeReplaceObjectAtIndex:withObject:
100320fc4: aa1a03e0    	mov	x0, x26
100320fc8: aa1903e3    	mov	x3, x25
100320fcc: 95e4185c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320fd0: aa1903e0    	mov	x0, x25
100320fd4: 95e41860    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100320fd8: 900fef08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100320fdc: f9477501    	ldr	x1, [x8, #0xee8] ; dequeueReusableCellWithIdentifier:
100320fe0: aa1303e0    	mov	x0, x19
100320fe4: aa1b03e2    	mov	x2, x27
100320fe8: 95e41855    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100320fec: aa1d03fd    	mov	x29, x29
100320ff0: 95e41856    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100320ff4: aa0003f8    	mov	x24, x0
100320ff8: b5000260    	cbnz	x0, 0x100321044 <__text+0x319044>
100320ffc: d00ff2a8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
100321000: f940b900    	ldr	x0, [x8, #0x170]
100321004: 95e41857    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100321008: 900fd8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10032100c: f9463501    	ldr	x1, [x8, #0xc68] ; initWithStyle:reuseIdentifier:
100321010: d2800002    	mov	x2, #0x0                ; =0
100321014: aa1b03e3    	mov	x3, x27
100321018: 95e41849    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10032101c: aa0003f8    	mov	x24, x0
100321020: f00fd8c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100321024: f9436501    	ldr	x1, [x8, #0x6c8] ; setSelectionStyle:
100321028: d2800002    	mov	x2, #0x0                ; =0
10032102c: 95e41844    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100321030: f00fd8c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100321034: f9405501    	ldr	x1, [x8, #0xa8] ; setAccessoryType:
100321038: aa1803e0    	mov	x0, x24
10032103c: d2800002    	mov	x2, #0x0                ; =0
100321040: 95e4183f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100321044: 910163e0    	add	x0, sp, #0x58
100321048: aa1603e1    	mov	x1, x22
10032104c: 95e41848    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
100321050: 910143e0    	add	x0, sp, #0x50
100321054: aa1303e1    	mov	x1, x19
100321058: 95e41845    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
10032105c: 910123e0    	add	x0, sp, #0x48
100321060: aa1803e1    	mov	x1, x24
100321064: 95e41842    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
100321068: b00e9668    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10032106c: f947e108    	ldr	x8, [x8, #0xfc0]
100321070: f9000be8    	str	x8, [sp, #0x10]
100321074: 900c5308    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
100321078: fd41c100    	ldr	d0, [x8, #0x380]
10032107c: 90000008    	adrp	x8, 0x100321000 <__text+0x319000>
100321080: 9109c108    	add	x8, x8, #0x270
100321084: fd000fe0    	str	d0, [sp, #0x18]
100321088: d00e96c9    	adrp	x9, 0x11d5fb000 <dyld_stub_binder+0x11d5fb000>
10032108c: 91272129    	add	x9, x9, #0x9c8
100321090: a90227e8    	stp	x8, x9, [sp, #0x20]
100321094: 910043f7    	add	x23, sp, #0x10
100321098: 910082e0    	add	x0, x23, #0x20
10032109c: 910163e1    	add	x1, sp, #0x58
1003210a0: 95e41836    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1003210a4: 9100a2e0    	add	x0, x23, #0x28
1003210a8: 910143e1    	add	x1, sp, #0x50
1003210ac: 95e41833    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1003210b0: 9100c2e0    	add	x0, x23, #0x30
1003210b4: 910123e1    	add	x1, sp, #0x48
1003210b8: 95e41830    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1003210bc: b00fd968    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1003210c0: f9423501    	ldr	x1, [x8, #0x468] ; setM_accessibilityElementsHiddenBlock:
1003210c4: 910043e2    	add	x2, sp, #0x10
1003210c8: aa1803e0    	mov	x0, x24
1003210cc: 95e4181c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1003210d0: b00fd948    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1003210d4: f9444101    	ldr	x1, [x8, #0x880] ; isEditing
1003210d8: aa1303e0    	mov	x0, x19
1003210dc: 95e41818    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1003210e0: aa0003e2    	mov	x2, x0
1003210e4: b00fd968    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1003210e8: f9423901    	ldr	x1, [x8, #0x470] ; setM_bIsEditting:
1003210ec: aa1803e0    	mov	x0, x24
1003210f0: 95e41813    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1003210f4: b00fd968    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1003210f8: f9423d01    	ldr	x1, [x8, #0x478] ; makeCell:indexPath:
1003210fc: aa1603e0    	mov	x0, x22
100321100: aa1803e2    	mov	x2, x24
100321104: aa1403e3    	mov	x3, x20
100321108: 95e4180d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10032110c: b00fef48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100321110: f9406901    	ldr	x1, [x8, #0xd0] ; setUserInteractionEnabled:
100321114: aa1803e0    	mov	x0, x24
100321118: 52800022    	mov	w2, #0x1                ; =1
10032111c: 95e41808    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100321120: d00ff5e8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100321124: b9842508    	ldrsw	x8, [x8, #0x424]
100321128: 8b0802c0    	add	x0, x22, x8
10032112c: 95e41818    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100321130: aa0003f9    	mov	x25, x0
100321134: b00fd948    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
100321138: f946a501    	ldr	x1, [x8, #0xd48] ; isInMultiSelectMsg
10032113c: 95e41800    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100321140: 340003c0    	cbz	w0, 0x1003211b8 <__text+0x3191b8>
100321144: d00ff5e8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100321148: b9851d08    	ldrsw	x8, [x8, #0x51c]
10032114c: 38686ac8    	ldrb	w8, [x22, x8]
100321150: 36000348    	tbz	w8, #0x0, 0x1003211b8 <__text+0x3191b8>
100321154: b00fd8e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100321158: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
10032115c: aa1503e0    	mov	x0, x21
100321160: 95e417f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100321164: aa1d03fd    	mov	x29, x29
100321168: 95e417f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10032116c: aa0003fa    	mov	x26, x0
100321170: b00fd968    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100321174: f9424101    	ldr	x1, [x8, #0x480] ; isMultiSelected:
100321178: aa1603e0    	mov	x0, x22
10032117c: aa1a03e2    	mov	x2, x26
100321180: 95e417ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100321184: aa0003f6    	mov	x22, x0
100321188: aa1a03e0    	mov	x0, x26
10032118c: 95e417f2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100321190: aa1903e0    	mov	x0, x25
100321194: 95e417f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100321198: 1e6c1008    	fmov	d8, #0.50000000
10032119c: 35000136    	cbnz	w22, 0x1003211c0 <__text+0x3191c0>
1003211a0: 14000009    	b	0x1003211c4 <__text+0x3191c4>
1003211a4: b00ff2a8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1003211a8: f940b900    	ldr	x0, [x8, #0x170]
1003211ac: 95e417eb    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1003211b0: aa0003f8    	mov	x24, x0
1003211b4: 14000021    	b	0x100321238 <__text+0x319238>
1003211b8: aa1903e0    	mov	x0, x25
1003211bc: 95e417e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1003211c0: 1e6e1008    	fmov	d8, #1.00000000
1003211c4: f00feee8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1003211c8: f9427501    	ldr	x1, [x8, #0x4e8] ; contentView
1003211cc: aa1803e0    	mov	x0, x24
1003211d0: 95e417db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1003211d4: aa1d03fd    	mov	x29, x29
1003211d8: 95e417dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1003211dc: aa0003f6    	mov	x22, x0
1003211e0: b00fef28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1003211e4: f9476901    	ldr	x1, [x8, #0xed0] ; setAlpha:
1003211e8: 1e604100    	fmov	d0, d8
1003211ec: 95e417d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1003211f0: aa1603e0    	mov	x0, x22
1003211f4: 95e417d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1003211f8: 9100c2e0    	add	x0, x23, #0x30
1003211fc: 95e417e5    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
100321200: 9100a2e0    	add	x0, x23, #0x28
100321204: 95e417e3    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
100321208: 910082e0    	add	x0, x23, #0x20
10032120c: 95e417e1    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
100321210: 910123e0    	add	x0, sp, #0x48
100321214: 95e417df    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
100321218: 910143e0    	add	x0, sp, #0x50
10032121c: 95e417dd    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
100321220: 910163e0    	add	x0, sp, #0x58
100321224: 95e417db    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
100321228: aa1b03e0    	mov	x0, x27
10032122c: 95e417ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100321230: aa1503e0    	mov	x0, x21
100321234: 95e417c8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100321238: aa1403e0    	mov	x0, x20
10032123c: 95e417c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100321240: aa1303e0    	mov	x0, x19
100321244: 95e417c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100321248: aa1803e0    	mov	x0, x24
10032124c: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
100321250: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
100321254: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
100321258: a9495ff8    	ldp	x24, x23, [sp, #0x90]
10032125c: a94867fa    	ldp	x26, x25, [sp, #0x80]
100321260: a9476ffc    	ldp	x28, x27, [sp, #0x70]
100321264: 6d4623e9    	ldp	d9, d8, [sp, #0x60]
100321268: 910343ff    	add	sp, sp, #0xd0
10032126c: 15e417c1    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>