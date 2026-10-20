
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10109f8b8: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
10109f8bc: a90167fa    	stp	x26, x25, [sp, #0x10]
10109f8c0: a9025ff8    	stp	x24, x23, [sp, #0x20]
10109f8c4: a90357f6    	stp	x22, x21, [sp, #0x30]
10109f8c8: a9044ff4    	stp	x20, x19, [sp, #0x40]
10109f8cc: a9057bfd    	stp	x29, x30, [sp, #0x50]
10109f8d0: 910143fd    	add	x29, sp, #0x50
10109f8d4: d106c3ff    	sub	sp, sp, #0x1b0
10109f8d8: aa0203fb    	mov	x27, x2
10109f8dc: aa0003f4    	mov	x20, x0
10109f8e0: 900e2a88    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10109f8e4: f9405908    	ldr	x8, [x8, #0xb0]
10109f8e8: f9400108    	ldr	x8, [x8]
10109f8ec: f81a03a8    	stur	x8, [x29, #-0x60]
10109f8f0: b00fdc88    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
10109f8f4: 52800029    	mov	w9, #0x1                ; =1
10109f8f8: 393c8509    	strb	w9, [x8, #0xf21]
10109f8fc: aa0203e0    	mov	x0, x2
10109f900: 95ae1e0e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10109f904: 4f00e400    	movi.16b	v0, #0x0
10109f908: ad0803e0    	stp	q0, q0, [sp, #0x100]
10109f90c: ad0703e0    	stp	q0, q0, [sp, #0xe0]
10109f910: b00f8308    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10109f914: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
10109f918: 910383e2    	add	x2, sp, #0xe0
10109f91c: d10383a3    	sub	x3, x29, #0xe0
10109f920: aa1b03e0    	mov	x0, x27
10109f924: f9000fe1    	str	x1, [sp, #0x18]
10109f928: 52800204    	mov	w4, #0x10               ; =16
10109f92c: 95ae1e04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109f930: b4002ce0    	cbz	x0, 0x10109fecc <__text+0x1097ecc>
10109f934: aa0003f6    	mov	x22, x0
10109f938: f9407be8    	ldr	x8, [sp, #0xf0]
10109f93c: f940011a    	ldr	x26, [x8]
10109f940: d2800017    	mov	x23, #0x0               ; =0
10109f944: 900f8328    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10109f948: f9454119    	ldr	x25, [x8, #0xa80] ; isValid
10109f94c: 900f6ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10109f950: f947b508    	ldr	x8, [x8, #0xf68] ; isBrandContact
10109f954: f9006fe8    	str	x8, [sp, #0xd8]
10109f958: 900f6d68    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
10109f95c: f9413909    	ldr	x9, [x8, #0x270] ; isWeixinTeamContact
10109f960: 900f6ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10109f964: f9470908    	ldr	x8, [x8, #0xe10] ; isSelf
10109f968: f9004fe8    	str	x8, [sp, #0x98]
10109f96c: 900f6ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10109f970: f947d108    	ldr	x8, [x8, #0xfa0] ; isChatroom
10109f974: f90047e8    	str	x8, [sp, #0x88]
10109f978: 900f6ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10109f97c: f947b908    	ldr	x8, [x8, #0xf70] ; isLocalizedContact
10109f980: f9003fe8    	str	x8, [sp, #0x78]
10109f984: 900f6ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10109f988: f947bd08    	ldr	x8, [x8, #0xf78] ; m_isPlugin
10109f98c: a90c23e9    	stp	x9, x8, [sp, #0xc0]
10109f990: f00f6f48    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
10109f994: f9416108    	ldr	x8, [x8, #0x2c0] ; myNormalContactArrayUnfiltered
10109f998: f90027e8    	str	x8, [sp, #0x48]
10109f99c: f00f6cc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10109f9a0: f943c508    	ldr	x8, [x8, #0x788] ; safeAddObject:
10109f9a4: f9002fe8    	str	x8, [sp, #0x58]
10109f9a8: f00f6f48    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
10109f9ac: f9418108    	ldr	x8, [x8, #0x300] ; m_bCanFilterInContactsView
10109f9b0: f9006be8    	str	x8, [sp, #0xd0]
10109f9b4: b00f6f48    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10109f9b8: f942dd09    	ldr	x9, [x8, #0x5b8] ; onFilterContactCandidate:
10109f9bc: f00f8328    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10109f9c0: f9436108    	ldr	x8, [x8, #0x6c0] ; respondsToSelector:
10109f9c4: a90a27e8    	stp	x8, x9, [sp, #0xa0]
10109f9c8: 900f6d68    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
10109f9cc: f946e908    	ldr	x8, [x8, #0xdd0] ; isWeClawBot
10109f9d0: f9005fe8    	str	x8, [sp, #0xb8]
10109f9d4: f00f6f28    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10109f9d8: f945b908    	ldr	x8, [x8, #0xb70] ; isGroupCard
10109f9dc: f9004be8    	str	x8, [sp, #0x90]
10109f9e0: 900f6ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10109f9e4: f947c108    	ldr	x8, [x8, #0xf80] ; isHolderContact
10109f9e8: f90043e8    	str	x8, [sp, #0x80]
10109f9ec: 900f6ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10109f9f0: f9434d09    	ldr	x9, [x8, #0x698] ; m_nsUsrName
10109f9f4: 900f6ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10109f9f8: f947f108    	ldr	x8, [x8, #0xfe0] ; IsOpenImContactUserName:
10109f9fc: a906a7e8    	stp	x8, x9, [sp, #0x68]
10109fa00: 900f6ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10109fa04: f947f508    	ldr	x8, [x8, #0xfe8] ; isChatBotAndEnableShowOpenIMInfo
10109fa08: f9002be8    	str	x8, [sp, #0x50]
10109fa0c: f00f6f28    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10109fa10: f9409d09    	ldr	x9, [x8, #0x138] ; getChatBotOpenIMAppid
10109fa14: 900f8328    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10109fa18: f946e908    	ldr	x8, [x8, #0xdd0] ; length
10109fa1c: a903a7e8    	stp	x8, x9, [sp, #0x38]
10109fa20: f00f6f48    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
10109fa24: f9418909    	ldr	x9, [x8, #0x310] ; addHiddenSectionKey:
10109fa28: 900f6d68    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
10109fa2c: f9435908    	ldr	x8, [x8, #0x6b0] ; isEnterpriseBrand
10109fa30: a90227e8    	stp	x8, x9, [sp, #0x20]
10109fa34: b00f6d28    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10109fa38: f9437109    	ldr	x9, [x8, #0x6e0] ; isServiceBrand
10109fa3c: b00f6d68    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
10109fa40: f940f908    	ldr	x8, [x8, #0x1f0] ; isEnterpriseMainBrand
10109fa44: a900a7e8    	stp	x8, x9, [sp, #0x8]
10109fa48: d00f6dc8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
10109fa4c: f9456108    	ldr	x8, [x8, #0xac0] ; addContact:
10109fa50: f9001be8    	str	x8, [sp, #0x30]
10109fa54: f00f6f48    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
10109fa58: f9415d08    	ldr	x8, [x8, #0x2b8] ; myNormalContactArray
10109fa5c: f90003e8    	str	x8, [sp]
10109fa60: f00f6f48    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
10109fa64: f9418508    	ldr	x8, [x8, #0x308] ; filterOpenImContactViewContacts:
10109fa68: f90033e8    	str	x8, [sp, #0x60]
10109fa6c: f9005bf6    	str	x22, [sp, #0xb0]
10109fa70: f9407be8    	ldr	x8, [sp, #0xf0]
10109fa74: f9400108    	ldr	x8, [x8]
10109fa78: eb1a011f    	cmp	x8, x26
10109fa7c: 54000060    	b.eq	0x10109fa88 <__text+0x1097a88>
10109fa80: aa1b03e0    	mov	x0, x27
10109fa84: 95ae1db3    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
10109fa88: f94077e8    	ldr	x8, [sp, #0xe8]
10109fa8c: f877791c    	ldr	x28, [x8, x23, lsl #3]
10109fa90: aa1c03e0    	mov	x0, x28
10109fa94: aa1903e1    	mov	x1, x25
10109fa98: 95ae1da9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fa9c: 340010c0    	cbz	w0, 0x10109fcb4 <__text+0x1097cb4>
10109faa0: aa1c03e0    	mov	x0, x28
10109faa4: f9406fe1    	ldr	x1, [sp, #0xd8]
10109faa8: 95ae1da5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109faac: 37000400    	tbnz	w0, #0x0, 0x10109fb2c <__text+0x1097b2c>
10109fab0: aa1c03e0    	mov	x0, x28
10109fab4: f94063e1    	ldr	x1, [sp, #0xc0]
10109fab8: 95ae1da1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fabc: 37000380    	tbnz	w0, #0x0, 0x10109fb2c <__text+0x1097b2c>
10109fac0: aa1c03e0    	mov	x0, x28
10109fac4: f9404fe1    	ldr	x1, [sp, #0x98]
10109fac8: 95ae1d9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109facc: 37000300    	tbnz	w0, #0x0, 0x10109fb2c <__text+0x1097b2c>
10109fad0: aa1c03e0    	mov	x0, x28
10109fad4: f94047e1    	ldr	x1, [sp, #0x88]
10109fad8: 95ae1d99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fadc: 37000280    	tbnz	w0, #0x0, 0x10109fb2c <__text+0x1097b2c>
10109fae0: aa1c03e0    	mov	x0, x28
10109fae4: f9403fe1    	ldr	x1, [sp, #0x78]
10109fae8: 95ae1d95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109faec: 37000200    	tbnz	w0, #0x0, 0x10109fb2c <__text+0x1097b2c>
10109faf0: aa1c03e0    	mov	x0, x28
10109faf4: f94067e1    	ldr	x1, [sp, #0xc8]
10109faf8: 95ae1d91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fafc: 37000180    	tbnz	w0, #0x0, 0x10109fb2c <__text+0x1097b2c>
10109fb00: aa1403e0    	mov	x0, x20
10109fb04: f94027e1    	ldr	x1, [sp, #0x48]
10109fb08: 95ae1d8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fb0c: aa1d03fd    	mov	x29, x29
10109fb10: 95ae1d8e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10109fb14: aa0003f8    	mov	x24, x0
10109fb18: f9402fe1    	ldr	x1, [sp, #0x58]
10109fb1c: aa1c03e2    	mov	x2, x28
10109fb20: 95ae1d87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fb24: aa1803e0    	mov	x0, x24
10109fb28: 95ae1d8b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fb2c: aa1403e0    	mov	x0, x20
10109fb30: f9406be1    	ldr	x1, [sp, #0xd0]
10109fb34: 95ae1d82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fb38: 34000520    	cbz	w0, 0x10109fbdc <__text+0x1097bdc>
10109fb3c: f00f8a48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10109fb40: b9860913    	ldrsw	x19, [x8, #0x608] ; ivar ContactsDataLogic.m_delegate
10109fb44: 8b130280    	add	x0, x20, x19
10109fb48: 95ae1d91    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10109fb4c: b4000480    	cbz	x0, 0x10109fbdc <__text+0x1097bdc>
10109fb50: aa0003f8    	mov	x24, x0
10109fb54: aa1a03f6    	mov	x22, x26
10109fb58: aa1b03fa    	mov	x26, x27
10109fb5c: 8b130280    	add	x0, x20, x19
10109fb60: 95ae1d8b    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10109fb64: aa0003fb    	mov	x27, x0
10109fb68: a94a57e1    	ldp	x1, x21, [sp, #0xa0]
10109fb6c: aa1503e2    	mov	x2, x21
10109fb70: 95ae1d73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fb74: 36000260    	tbz	w0, #0x0, 0x10109fbc0 <__text+0x1097bc0>
10109fb78: 8b130280    	add	x0, x20, x19
10109fb7c: 95ae1d84    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10109fb80: aa0003f3    	mov	x19, x0
10109fb84: aa1503e1    	mov	x1, x21
10109fb88: aa1c03e2    	mov	x2, x28
10109fb8c: 95ae1d6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fb90: aa0003f5    	mov	x21, x0
10109fb94: aa1303e0    	mov	x0, x19
10109fb98: 95ae1d6f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fb9c: aa1b03e0    	mov	x0, x27
10109fba0: 95ae1d6d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fba4: aa1803e0    	mov	x0, x24
10109fba8: 95ae1d6b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fbac: aa1a03fb    	mov	x27, x26
10109fbb0: aa1603fa    	mov	x26, x22
10109fbb4: f9405bf6    	ldr	x22, [sp, #0xb0]
10109fbb8: 35000135    	cbnz	w21, 0x10109fbdc <__text+0x1097bdc>
10109fbbc: 1400003e    	b	0x10109fcb4 <__text+0x1097cb4>
10109fbc0: aa1b03e0    	mov	x0, x27
10109fbc4: 95ae1d64    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fbc8: aa1803e0    	mov	x0, x24
10109fbcc: 95ae1d62    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fbd0: aa1a03fb    	mov	x27, x26
10109fbd4: aa1603fa    	mov	x26, x22
10109fbd8: f9405bf6    	ldr	x22, [sp, #0xb0]
10109fbdc: aa1c03e0    	mov	x0, x28
10109fbe0: f94067e1    	ldr	x1, [sp, #0xc8]
10109fbe4: 95ae1d56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fbe8: 37000660    	tbnz	w0, #0x0, 0x10109fcb4 <__text+0x1097cb4>
10109fbec: aa1c03e0    	mov	x0, x28
10109fbf0: f9405fe1    	ldr	x1, [sp, #0xb8]
10109fbf4: 95ae1d52    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fbf8: 370005e0    	tbnz	w0, #0x0, 0x10109fcb4 <__text+0x1097cb4>
10109fbfc: aa1c03e0    	mov	x0, x28
10109fc00: f9404be1    	ldr	x1, [sp, #0x90]
10109fc04: 95ae1d4e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fc08: 37000560    	tbnz	w0, #0x0, 0x10109fcb4 <__text+0x1097cb4>
10109fc0c: aa1c03e0    	mov	x0, x28
10109fc10: f94043e1    	ldr	x1, [sp, #0x80]
10109fc14: 95ae1d4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fc18: 370004e0    	tbnz	w0, #0x0, 0x10109fcb4 <__text+0x1097cb4>
10109fc1c: b00f86a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10109fc20: f9400113    	ldr	x19, [x8]
10109fc24: aa1c03e0    	mov	x0, x28
10109fc28: f9403be1    	ldr	x1, [sp, #0x70]
10109fc2c: 95ae1d44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fc30: aa1d03fd    	mov	x29, x29
10109fc34: 95ae1d45    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10109fc38: aa0003f8    	mov	x24, x0
10109fc3c: aa1303e0    	mov	x0, x19
10109fc40: f94037e1    	ldr	x1, [sp, #0x68]
10109fc44: aa1803e2    	mov	x2, x24
10109fc48: 95ae1d3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fc4c: 34000080    	cbz	w0, 0x10109fc5c <__text+0x1097c5c>
10109fc50: aa1803e0    	mov	x0, x24
10109fc54: 95ae1d40    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fc58: 14000013    	b	0x10109fca4 <__text+0x1097ca4>
10109fc5c: aa1c03e0    	mov	x0, x28
10109fc60: f9402be1    	ldr	x1, [sp, #0x50]
10109fc64: 95ae1d36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fc68: 360002e0    	tbz	w0, #0x0, 0x10109fcc4 <__text+0x1097cc4>
10109fc6c: aa1c03e0    	mov	x0, x28
10109fc70: f94023e1    	ldr	x1, [sp, #0x40]
10109fc74: 95ae1d32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fc78: aa1d03fd    	mov	x29, x29
10109fc7c: 95ae1d33    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10109fc80: aa0003f3    	mov	x19, x0
10109fc84: f9401fe1    	ldr	x1, [sp, #0x38]
10109fc88: 95ae1d2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fc8c: aa0003f5    	mov	x21, x0
10109fc90: aa1303e0    	mov	x0, x19
10109fc94: 95ae1d30    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fc98: aa1803e0    	mov	x0, x24
10109fc9c: 95ae1d2e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fca0: b4000175    	cbz	x21, 0x10109fccc <__text+0x1097ccc>
10109fca4: aa1403e0    	mov	x0, x20
10109fca8: f94033e1    	ldr	x1, [sp, #0x60]
10109fcac: aa1c03e2    	mov	x2, x28
10109fcb0: 95ae1d23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fcb4: 910006f7    	add	x23, x23, #0x1
10109fcb8: eb1702df    	cmp	x22, x23
10109fcbc: 54ffeda1    	b.ne	0x10109fa70 <__text+0x1097a70>
10109fcc0: 1400007b    	b	0x10109feac <__text+0x1097eac>
10109fcc4: aa1803e0    	mov	x0, x24
10109fcc8: 95ae1d23    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fccc: aa1c03e0    	mov	x0, x28
10109fcd0: f94047e1    	ldr	x1, [sp, #0x88]
10109fcd4: 95ae1d1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fcd8: 340000a0    	cbz	w0, 0x10109fcec <__text+0x1097cec>
10109fcdc: f00f8a48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10109fce0: b9862d08    	ldrsw	x8, [x8, #0x62c] ; ivar ContactsDataLogic.m_extendChatRoom
10109fce4: 38686a88    	ldrb	w8, [x20, x8]
10109fce8: 36000668    	tbz	w8, #0x0, 0x10109fdb4 <__text+0x1097db4>
10109fcec: aa1c03e0    	mov	x0, x28
10109fcf0: f9406fe1    	ldr	x1, [sp, #0xd8]
10109fcf4: 95ae1d12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fcf8: f9402ff5    	ldr	x21, [sp, #0x58]
10109fcfc: 340000a0    	cbz	w0, 0x10109fd10 <__text+0x1097d10>
10109fd00: aa1c03e0    	mov	x0, x28
10109fd04: f94063e1    	ldr	x1, [sp, #0xc0]
10109fd08: 95ae1d0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fd0c: 360008c0    	tbz	w0, #0x0, 0x10109fe24 <__text+0x1097e24>
10109fd10: aa1403e0    	mov	x0, x20
10109fd14: f9401be1    	ldr	x1, [sp, #0x30]
10109fd18: aa1c03e2    	mov	x2, x28
10109fd1c: 95ae1d08    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fd20: aa1c03e0    	mov	x0, x28
10109fd24: f9406fe1    	ldr	x1, [sp, #0xd8]
10109fd28: 95ae1d05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fd2c: 3707fc40    	tbnz	w0, #0x0, 0x10109fcb4 <__text+0x1097cb4>
10109fd30: aa1c03e0    	mov	x0, x28
10109fd34: f94063e1    	ldr	x1, [sp, #0xc0]
10109fd38: 95ae1d01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fd3c: 3707fbc0    	tbnz	w0, #0x0, 0x10109fcb4 <__text+0x1097cb4>
10109fd40: aa1c03e0    	mov	x0, x28
10109fd44: f9404fe1    	ldr	x1, [sp, #0x98]
10109fd48: 95ae1cfd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fd4c: 3707fb40    	tbnz	w0, #0x0, 0x10109fcb4 <__text+0x1097cb4>
10109fd50: aa1c03e0    	mov	x0, x28
10109fd54: f94047e1    	ldr	x1, [sp, #0x88]
10109fd58: 95ae1cf9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fd5c: 3707fac0    	tbnz	w0, #0x0, 0x10109fcb4 <__text+0x1097cb4>
10109fd60: aa1c03e0    	mov	x0, x28
10109fd64: f9403fe1    	ldr	x1, [sp, #0x78]
10109fd68: 95ae1cf5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fd6c: 3707fa40    	tbnz	w0, #0x0, 0x10109fcb4 <__text+0x1097cb4>
10109fd70: f00f8a48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10109fd74: b9861d08    	ldrsw	x8, [x8, #0x61c] ; ivar ContactsDataLogic.m_uiNormalContact
10109fd78: b8686a89    	ldr	w9, [x20, x8]
10109fd7c: 11000529    	add	w9, w9, #0x1
10109fd80: b8286a89    	str	w9, [x20, x8]
10109fd84: aa1403e0    	mov	x0, x20
10109fd88: f94003e1    	ldr	x1, [sp]
10109fd8c: 95ae1cec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fd90: aa1d03fd    	mov	x29, x29
10109fd94: 95ae1ced    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10109fd98: aa0003f3    	mov	x19, x0
10109fd9c: f9402fe1    	ldr	x1, [sp, #0x58]
10109fda0: aa1c03e2    	mov	x2, x28
10109fda4: 95ae1ce6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fda8: aa1303e0    	mov	x0, x19
10109fdac: 95ae1cea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fdb0: 17ffffc1    	b	0x10109fcb4 <__text+0x1097cb4>
10109fdb4: aa1403e0    	mov	x0, x20
10109fdb8: f94017e1    	ldr	x1, [sp, #0x28]
10109fdbc: 900ea542    	adrp	x2, 0x11e547000 <dyld_stub_binder+0x11e547000>
10109fdc0: 910ca042    	add	x2, x2, #0x328
10109fdc4: 95ae1cde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fdc8: aa1d03fd    	mov	x29, x29
10109fdcc: 95ae1cdf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10109fdd0: aa0003f3    	mov	x19, x0
10109fdd4: f9402ff5    	ldr	x21, [sp, #0x58]
10109fdd8: aa1503e1    	mov	x1, x21
10109fddc: aa1c03e2    	mov	x2, x28
10109fde0: 95ae1cd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fde4: aa1303e0    	mov	x0, x19
10109fde8: 95ae1cdb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fdec: f00f8a48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10109fdf0: b9862513    	ldrsw	x19, [x8, #0x624] ; ivar ContactsDataLogic.m_arrChatRooms
10109fdf4: f8736a80    	ldr	x0, [x20, x19]
10109fdf8: b5000120    	cbnz	x0, 0x10109fe1c <__text+0x1097e1c>
10109fdfc: 900f86a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10109fe00: f9455500    	ldr	x0, [x8, #0xaa8]
10109fe04: 95ae1cd5    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10109fe08: f8736a88    	ldr	x8, [x20, x19]
10109fe0c: f8336a80    	str	x0, [x20, x19]
10109fe10: aa0803e0    	mov	x0, x8
10109fe14: 95ae1cd0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fe18: f8736a80    	ldr	x0, [x20, x19]
10109fe1c: aa1503e1    	mov	x1, x21
10109fe20: 17ffffa3    	b	0x10109fcac <__text+0x1097cac>
10109fe24: aa1c03e0    	mov	x0, x28
10109fe28: f94013e1    	ldr	x1, [sp, #0x20]
10109fe2c: 95ae1cc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fe30: 34000140    	cbz	w0, 0x10109fe58 <__text+0x1097e58>
10109fe34: aa1c03e0    	mov	x0, x28
10109fe38: f94007e1    	ldr	x1, [sp, #0x8]
10109fe3c: 95ae1cc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fe40: 34fff700    	cbz	w0, 0x10109fd20 <__text+0x1097d20>
10109fe44: aa1403e0    	mov	x0, x20
10109fe48: f94017e1    	ldr	x1, [sp, #0x28]
10109fe4c: 900ea562    	adrp	x2, 0x11e54b000 <dyld_stub_binder+0x11e54b000>
10109fe50: 9124a042    	add	x2, x2, #0x928
10109fe54: 1400000c    	b	0x10109fe84 <__text+0x1097e84>
10109fe58: aa1c03e0    	mov	x0, x28
10109fe5c: f9400be1    	ldr	x1, [sp, #0x10]
10109fe60: 95ae1cb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fe64: 7100001f    	cmp	w0, #0x0
10109fe68: 900ea548    	adrp	x8, 0x11e547000 <dyld_stub_binder+0x11e547000>
10109fe6c: 910d2108    	add	x8, x8, #0x348
10109fe70: 900ea549    	adrp	x9, 0x11e547000 <dyld_stub_binder+0x11e547000>
10109fe74: 910da129    	add	x9, x9, #0x368
10109fe78: 9a881122    	csel	x2, x9, x8, ne
10109fe7c: aa1403e0    	mov	x0, x20
10109fe80: f94017e1    	ldr	x1, [sp, #0x28]
10109fe84: 95ae1cae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fe88: aa1d03fd    	mov	x29, x29
10109fe8c: 95ae1caf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10109fe90: aa0003f3    	mov	x19, x0
10109fe94: aa1503e1    	mov	x1, x21
10109fe98: aa1c03e2    	mov	x2, x28
10109fe9c: 95ae1ca8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fea0: aa1303e0    	mov	x0, x19
10109fea4: 95ae1cac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fea8: 17ffff9e    	b	0x10109fd20 <__text+0x1097d20>
10109feac: 910383e2    	add	x2, sp, #0xe0
10109feb0: d10383a3    	sub	x3, x29, #0xe0
10109feb4: aa1b03e0    	mov	x0, x27
10109feb8: f9400fe1    	ldr	x1, [sp, #0x18]
10109febc: 52800204    	mov	w4, #0x10               ; =16
10109fec0: 95ae1c9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10109fec4: aa0003f6    	mov	x22, x0
10109fec8: b5ffd3c0    	cbnz	x0, 0x10109f940 <__text+0x1097940>
10109fecc: aa1b03e0    	mov	x0, x27
10109fed0: 95ae1ca1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10109fed4: f85a03a8    	ldur	x8, [x29, #-0x60]
10109fed8: 900e2a89    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10109fedc: f9405929    	ldr	x9, [x9, #0xb0]
10109fee0: f9400129    	ldr	x9, [x9]
10109fee4: eb08013f    	cmp	x9, x8
10109fee8: 54000121    	b.ne	0x10109ff0c <__text+0x1097f0c>
10109feec: 9106c3ff    	add	sp, sp, #0x1b0
10109fef0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10109fef4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10109fef8: a94357f6    	ldp	x22, x21, [sp, #0x30]
10109fefc: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10109ff00: a94167fa    	ldp	x26, x25, [sp, #0x10]
10109ff04: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10109ff08: d65f03c0    	ret
10109ff0c: 95ae1c9a    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
