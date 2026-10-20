
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104f38dc4: d10103ff    	sub	sp, sp, #0x40
104f38dc8: a90157f6    	stp	x22, x21, [sp, #0x10]
104f38dcc: a9024ff4    	stp	x20, x19, [sp, #0x20]
104f38dd0: a9037bfd    	stp	x29, x30, [sp, #0x30]
104f38dd4: 9100c3fd    	add	x29, sp, #0x30
104f38dd8: aa0203f3    	mov	x19, x2
104f38ddc: f00de828    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104f38de0: 52800029    	mov	w9, #0x1                ; =1
104f38de4: 39102909    	strb	w9, [x8, #0x40a]
104f38de8: 52800040    	mov	w0, #0x2                ; =2
104f38dec: 94b35115    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
104f38df0: 34000560    	cbz	w0, 0x104f38e9c <_Flutter_MMFoundation_BindContext+0x1414a80>
104f38df4: 94b3b8eb    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
104f38df8: aa0003f4    	mov	x20, x0
104f38dfc: f00d91d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104f38e00: f94546c0    	ldr	x0, [x22, #0xa88]
104f38e04: 94b3b8d7    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104f38e08: aa0003f5    	mov	x21, x0
104f38e0c: f94546c0    	ldr	x0, [x22, #0xa88]
104f38e10: d00d8e88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104f38e14: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
104f38e18: f90003ff    	str	xzr, [sp]
104f38e1c: d00cc442    	adrp	x2, 0x11e7c2000 <dyld_stub_binder+0x11e7c2000>
104f38e20: 91272042    	add	x2, x2, #0x9c8 ; cfstring='MultiTalkReject'
104f38e24: 94b3b8c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38e28: aa1d03fd    	mov	x29, x29
104f38e2c: 94b3b8c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f38e30: aa0003f6    	mov	x22, x0
104f38e34: d00d8e48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104f38e38: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
104f38e3c: f00cab08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f38e40: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
104f38e44: a90003e8    	stp	x8, x0, [sp]
104f38e48: f00cab02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f38e4c: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
104f38e50: aa1503e0    	mov	x0, x21
104f38e54: 94b3b8ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38e58: aa0003f5    	mov	x21, x0
104f38e5c: aa1603e0    	mov	x0, x22
104f38e60: 94b3b8bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f38e64: f00b4721    	adrp	x1, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f38e68: 9124bc21    	add	x1, x1, #0x92f ; cstring='MultiTalk'
104f38e6c: d00b47e2    	adrp	x2, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f38e70: 912f0842    	add	x2, x2, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f38e74: f00b47e4    	adrp	x4, 0x11b837000 <dyld_stub_binder+0x11b837000>
104f38e78: 912cec84    	add	x4, x4, #0xb3b ; cstring='-[MultiTalkMgr MultiTalkReject:]'
104f38e7c: 52800040    	mov	w0, #0x2                ; =2
104f38e80: 5280be43    	mov	w3, #0x5f2              ; =1522
104f38e84: aa1503e5    	mov	x5, x21
104f38e88: 94b350ef    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
104f38e8c: aa1503e0    	mov	x0, x21
104f38e90: 94b3b8b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f38e94: aa1403e0    	mov	x0, x20
104f38e98: 94b3b8c5    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
104f38e9c: f00d91c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f38ea0: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
104f38ea4: 900d8e48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104f38ea8: f944e901    	ldr	x1, [x8, #0x9d0] ; selector=currentContext
104f38eac: 94b3b8a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38eb0: aa1d03fd    	mov	x29, x29
104f38eb4: 94b3b8a5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f38eb8: aa0003f4    	mov	x20, x0
104f38ebc: d00d91e8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104f38ec0: f945ed00    	ldr	x0, [x8, #0xbd8] ; class=MMConfSDKService
104f38ec4: f00d8e28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104f38ec8: f947ad01    	ldr	x1, [x8, #0xf58] ; selector=class
104f38ecc: 94b3b89c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38ed0: aa0003e2    	mov	x2, x0
104f38ed4: b00d7808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104f38ed8: f9464101    	ldr	x1, [x8, #0xc80] ; selector=getService:
104f38edc: aa1403e0    	mov	x0, x20
104f38ee0: 94b3b897    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38ee4: aa1d03fd    	mov	x29, x29
104f38ee8: 94b3b898    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f38eec: aa0003f5    	mov	x21, x0
104f38ef0: d00d7de8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
104f38ef4: f9431d01    	ldr	x1, [x8, #0x638] ; selector=hangup:roomID:
104f38ef8: 52800022    	mov	w2, #0x1                ; =1
104f38efc: aa1303e3    	mov	x3, x19
104f38f00: 94b3b88f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f38f04: aa1503e0    	mov	x0, x21
104f38f08: 94b3b893    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f38f0c: aa1403e0    	mov	x0, x20
104f38f10: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104f38f14: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104f38f18: a94157f6    	ldp	x22, x21, [sp, #0x10]
104f38f1c: 910103ff    	add	sp, sp, #0x40
104f38f20: 14b3b88d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
