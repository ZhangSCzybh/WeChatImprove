
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10029ed74: d101c3ff    	sub	sp, sp, #0x70
10029ed78: a90267fa    	stp	x26, x25, [sp, #0x20]
10029ed7c: a9035ff8    	stp	x24, x23, [sp, #0x30]
10029ed80: a90457f6    	stp	x22, x21, [sp, #0x40]
10029ed84: a9054ff4    	stp	x20, x19, [sp, #0x50]
10029ed88: a9067bfd    	stp	x29, x30, [sp, #0x60]
10029ed8c: 910183fd    	add	x29, sp, #0x60
10029ed90: aa0003f5    	mov	x21, x0
10029ed94: f0104c68    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
10029ed98: 52800029    	mov	w9, #0x1                ; =1
10029ed9c: 3930d509    	strb	w9, [x8, #0xc35]
10029eda0: b00ff6a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10029eda4: f945e900    	ldr	x0, [x8, #0xbd0]
10029eda8: d00ff308    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10029edac: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10029edb0: 95e620e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029edb4: aa1d03fd    	mov	x29, x29
10029edb8: 95e620e4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10029edbc: aa0003f4    	mov	x20, x0
10029edc0: d00ff6a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10029edc4: f9401500    	ldr	x0, [x8, #0x28] ; P;,
10029edc8: b00ff308    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10029edcc: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10029edd0: 95e620db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029edd4: aa0003e2    	mov	x2, x0
10029edd8: f00fdcc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10029eddc: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10029ede0: aa1403e0    	mov	x0, x20
10029ede4: 95e620d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029ede8: aa1d03fd    	mov	x29, x29
10029edec: 95e620d7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10029edf0: aa0003f3    	mov	x19, x0
10029edf4: aa1403e0    	mov	x0, x20
10029edf8: 95e620d7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10029edfc: b00ffa08    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10029ee00: b9824d1a    	ldrsw	x26, [x8, #0x24c] ; ivar CBaseContactInfoAssist.m_contact
10029ee04: f87a6aa0    	ldr	x0, [x21, x26]
10029ee08: b00fdce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10029ee0c: f9434d16    	ldr	x22, [x8, #0x698] ; m_nsUsrName
10029ee10: aa1603e1    	mov	x1, x22
10029ee14: 95e620ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029ee18: aa1d03fd    	mov	x29, x29
10029ee1c: 95e620cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10029ee20: aa0003f7    	mov	x23, x0
10029ee24: d00fdce8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10029ee28: f940c901    	ldr	x1, [x8, #0x190] ; getContactByName:
10029ee2c: aa1303e0    	mov	x0, x19
10029ee30: aa1703e2    	mov	x2, x23
10029ee34: 95e620c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029ee38: aa1d03fd    	mov	x29, x29
10029ee3c: 95e620c3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10029ee40: aa0003f4    	mov	x20, x0
10029ee44: aa1703e0    	mov	x0, x23
10029ee48: 95e620c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10029ee4c: b00ff6a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10029ee50: f9453517    	ldr	x23, [x8, #0xa68]
10029ee54: f87a6aa0    	ldr	x0, [x21, x26]
10029ee58: aa1603e1    	mov	x1, x22
10029ee5c: 95e620b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029ee60: aa1d03fd    	mov	x29, x29
10029ee64: 95e620b9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10029ee68: aa0003f6    	mov	x22, x0
10029ee6c: f87a6aa0    	ldr	x0, [x21, x26]
10029ee70: d00fdce8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10029ee74: f9476118    	ldr	x24, [x8, #0xec0] ; m_uiType
10029ee78: aa1803e1    	mov	x1, x24
10029ee7c: 95e620b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029ee80: aa0003f9    	mov	x25, x0
10029ee84: f87a6aa0    	ldr	x0, [x21, x26]
10029ee88: aa1803e1    	mov	x1, x24
10029ee8c: 95e620ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029ee90: 12000008    	and	w8, w0, #0x1
10029ee94: f00fdcc9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10029ee98: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10029ee9c: a90123f9    	stp	x25, x8, [sp, #0x10]
10029eea0: b00f10e8    	adrp	x8, 0x11e4bb000 <dyld_stub_binder+0x11e4bb000>
10029eea4: 911a2108    	add	x8, x8, #0x688
10029eea8: a9005be8    	stp	x8, x22, [sp]
10029eeac: 900d7d45    	adrp	x5, 0x11b246000 <dyld_stub_binder+0x11b246000>
10029eeb0: 910654a5    	add	x5, x5, #0x195
10029eeb4: 900d7d47    	adrp	x7, 0x11b246000 <dyld_stub_binder+0x11b246000>
10029eeb8: 9106b8e7    	add	x7, x7, #0x1ae
10029eebc: aa1703e0    	mov	x0, x23
10029eec0: 52800042    	mov	w2, #0x2                ; =2
10029eec4: d2800003    	mov	x3, #0x0                ; =0
10029eec8: 52800004    	mov	w4, #0x0                ; =0
10029eecc: 52801b66    	mov	w6, #0xdb               ; =219
10029eed0: 95e6209b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029eed4: aa1603e0    	mov	x0, x22
10029eed8: 95e6209f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10029eedc: b40000f4    	cbz	x20, 0x10029eef8 <__text+0x296ef8>
10029eee0: d00fdce8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10029eee4: f940cd01    	ldr	x1, [x8, #0x198] ; isMMContact
10029eee8: aa1403e0    	mov	x0, x20
10029eeec: 95e62094    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029eef0: aa0003f5    	mov	x21, x0
10029eef4: 14000002    	b	0x10029eefc <__text+0x296efc>
10029eef8: 52800015    	mov	w21, #0x0               ; =0
10029eefc: aa1403e0    	mov	x0, x20
10029ef00: 95e62095    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10029ef04: aa1303e0    	mov	x0, x19
10029ef08: 95e62093    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10029ef0c: aa1503e0    	mov	x0, x21
10029ef10: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10029ef14: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10029ef18: a94457f6    	ldp	x22, x21, [sp, #0x40]
10029ef1c: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10029ef20: a94267fa    	ldp	x26, x25, [sp, #0x20]
10029ef24: 9101c3ff    	add	sp, sp, #0x70
10029ef28: d65f03c0    	ret
