
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010eab8c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
1010eab90: a9015ff8    	stp	x24, x23, [sp, #0x10]
1010eab94: a90257f6    	stp	x22, x21, [sp, #0x20]
1010eab98: a9034ff4    	stp	x20, x19, [sp, #0x30]
1010eab9c: a9047bfd    	stp	x29, x30, [sp, #0x40]
1010eaba0: 910103fd    	add	x29, sp, #0x40
1010eaba4: aa0503f7    	mov	x23, x5
1010eaba8: aa0403f5    	mov	x21, x4
1010eabac: aa0303f3    	mov	x19, x3
1010eabb0: aa0003f4    	mov	x20, x0
1010eabb4: f00fda28    	adrp	x8, 0x120c31000 <dyld_stub_binder+0x120c31000>
1010eabb8: 52800029    	mov	w9, #0x1                ; =1
1010eabbc: 39015909    	strb	w9, [x8, #0x56]
1010eabc0: aa0303e0    	mov	x0, x3
1010eabc4: 95acf15d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010eabc8: 900f8808    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010eabcc: b98a6d19    	ldrsw	x25, [x8, #0xa6c] ; ivar ContactsViewController.m_contactsDataLogic
1010eabd0: f8796a80    	ldr	x0, [x20, x25]
1010eabd4: 900f6b68    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1010eabd8: f942d901    	ldr	x1, [x8, #0x5b0] ; getKeysArray
1010eabdc: 95acf158    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010eabe0: aa1d03fd    	mov	x29, x29
1010eabe4: 95acf159    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010eabe8: aa0003f6    	mov	x22, x0
1010eabec: 900f6a88    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1010eabf0: f942c118    	ldr	x24, [x8, #0x580] ; safeObjectAtIndex:
1010eabf4: aa1803e1    	mov	x1, x24
1010eabf8: aa1503e2    	mov	x2, x21
1010eabfc: 95acf150    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010eac00: aa1d03fd    	mov	x29, x29
1010eac04: 95acf151    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010eac08: aa0003f5    	mov	x21, x0
1010eac0c: aa1603e0    	mov	x0, x22
1010eac10: 95acf151    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010eac14: f8796a80    	ldr	x0, [x20, x25]
1010eac18: 900f6b68    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1010eac1c: f9430901    	ldr	x1, [x8, #0x610] ; getContactsArrayWith:
1010eac20: aa1503e2    	mov	x2, x21
1010eac24: 95acf146    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010eac28: aa1d03fd    	mov	x29, x29
1010eac2c: 95acf147    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010eac30: aa0003f6    	mov	x22, x0
1010eac34: d00f80a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010eac38: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1010eac3c: 95acf140    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010eac40: eb17001f    	cmp	x0, x23
1010eac44: 540003c9    	b.ls	0x1010eacbc <__text+0x10e2cbc>
1010eac48: aa1603e0    	mov	x0, x22
1010eac4c: aa1803e1    	mov	x1, x24
1010eac50: aa1703e2    	mov	x2, x23
1010eac54: 95acf13a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010eac58: aa1d03fd    	mov	x29, x29
1010eac5c: 95acf13b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010eac60: aa0003f7    	mov	x23, x0
1010eac64: 900f6b68    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1010eac68: f942c501    	ldr	x1, [x8, #0x588] ; isAccountDeleted
1010eac6c: 95acf134    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010eac70: 340000c0    	cbz	w0, 0x1010eac88 <__text+0x10e2c88>
1010eac74: f00f6b68    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
1010eac78: f9428901    	ldr	x1, [x8, #0x510] ; setContextMenuEnabled:
1010eac7c: aa1303e0    	mov	x0, x19
1010eac80: 52800002    	mov	w2, #0x0                ; =0
1010eac84: 95acf12e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010eac88: b00f6d08    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1010eac8c: f9445901    	ldr	x1, [x8, #0x8b0] ; updateNewContactsItemCell:contact:
1010eac90: aa1403e0    	mov	x0, x20
1010eac94: aa1303e2    	mov	x2, x19
1010eac98: aa1703e3    	mov	x3, x23
1010eac9c: 95acf128    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010eaca0: d00f6a88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1010eaca4: f9405501    	ldr	x1, [x8, #0xa8] ; setAccessoryType:
1010eaca8: aa1303e0    	mov	x0, x19
1010eacac: d2800002    	mov	x2, #0x0                ; =0
1010eacb0: 95acf123    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010eacb4: aa1703e0    	mov	x0, x23
1010eacb8: 95acf127    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010eacbc: aa1603e0    	mov	x0, x22
1010eacc0: 95acf125    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010eacc4: aa1503e0    	mov	x0, x21
1010eacc8: 95acf123    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010eaccc: aa1303e0    	mov	x0, x19
1010eacd0: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1010eacd4: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1010eacd8: a94257f6    	ldp	x22, x21, [sp, #0x20]
1010eacdc: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1010eace0: a8c567fa    	ldp	x26, x25, [sp], #0x50
1010eace4: 15acf11c    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
