
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101049b04: d10143ff    	sub	sp, sp, #0x50
101049b08: a9015ff8    	stp	x24, x23, [sp, #0x10]
101049b0c: a90257f6    	stp	x22, x21, [sp, #0x20]
101049b10: a9034ff4    	stp	x20, x19, [sp, #0x30]
101049b14: a9047bfd    	stp	x29, x30, [sp, #0x40]
101049b18: 910103fd    	add	x29, sp, #0x40
101049b1c: aa0303f3    	mov	x19, x3
101049b20: aa0203f5    	mov	x21, x2
101049b24: aa0003f4    	mov	x20, x0
101049b28: f00fdf28    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
101049b2c: 52800029    	mov	w9, #0x1                ; =1
101049b30: 39371509    	strb	w9, [x8, #0xdc5]
101049b34: aa0303e0    	mov	x0, x3
101049b38: 95af7580    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101049b3c: f00f6f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101049b40: f947f901    	ldr	x1, [x8, #0xff0] ; deselectRowAtIndexPath:animated:
101049b44: aa1503e0    	mov	x0, x21
101049b48: aa1303e2    	mov	x2, x19
101049b4c: 52800023    	mov	w3, #0x1                ; =1
101049b50: 95af757b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049b54: b00f7008    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
101049b58: f9444101    	ldr	x1, [x8, #0x880] ; isEditing
101049b5c: aa1403e0    	mov	x0, x20
101049b60: 95af7577    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049b64: 340006c0    	cbz	w0, 0x101049c3c <__text+0x1041c3c>
101049b68: b00f8d08    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101049b6c: b982a908    	ldrsw	x8, [x8, #0x2a8]
101049b70: f8686a95    	ldr	x21, [x20, x8]
101049b74: b00f85e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101049b78: f9440901    	ldr	x1, [x8, #0x810] ; row
101049b7c: aa1303e0    	mov	x0, x19
101049b80: 95af756f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049b84: aa0003e2    	mov	x2, x0
101049b88: b00f6f88    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101049b8c: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
101049b90: aa1503e0    	mov	x0, x21
101049b94: 95af756a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049b98: aa1d03fd    	mov	x29, x29
101049b9c: 95af756b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049ba0: aa0003f5    	mov	x21, x0
101049ba4: f00f8988    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
101049ba8: f9402900    	ldr	x0, [x8, #0x50]
101049bac: d00f85a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101049bb0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101049bb4: 95af7562    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049bb8: aa0003e2    	mov	x2, x0
101049bbc: d00f85c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101049bc0: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
101049bc4: aa1503e0    	mov	x0, x21
101049bc8: 95af755d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049bcc: 340009c0    	cbz	w0, 0x101049d04 <__text+0x1041d04>
101049bd0: b00f7068    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
101049bd4: f9429901    	ldr	x1, [x8, #0x530] ; isSelected:
101049bd8: aa1403e0    	mov	x0, x20
101049bdc: aa1503e2    	mov	x2, x21
101049be0: 95af7557    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049be4: aa0003f6    	mov	x22, x0
101049be8: b00f71e8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
101049bec: f941f501    	ldr	x1, [x8, #0x3e8] ; m_nsName
101049bf0: aa1503e0    	mov	x0, x21
101049bf4: 95af7552    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049bf8: aa1d03fd    	mov	x29, x29
101049bfc: 95af7553    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049c00: aa0003f7    	mov	x23, x0
101049c04: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049c08: 91070108    	add	x8, x8, #0x1c0
101049c0c: 900f7209    	adrp	x9, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049c10: 91072129    	add	x9, x9, #0x1c8
101049c14: 710002df    	cmp	w22, #0x0
101049c18: 9a891108    	csel	x8, x8, x9, ne
101049c1c: f9400101    	ldr	x1, [x8]
101049c20: aa1403e0    	mov	x0, x20
101049c24: aa1703e2    	mov	x2, x23
101049c28: aa1303e3    	mov	x3, x19
101049c2c: 95af7544    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049c30: aa1703e0    	mov	x0, x23
101049c34: 95af7548    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101049c38: 14000033    	b	0x101049d04 <__text+0x1041d04>
101049c3c: f00f6f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101049c40: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
101049c44: aa1303e0    	mov	x0, x19
101049c48: 95af753d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049c4c: aa0003e2    	mov	x2, x0
101049c50: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049c54: f9408901    	ldr	x1, [x8, #0x110] ; checkNoTagSectionWithSection:
101049c58: aa1403e0    	mov	x0, x20
101049c5c: 95af7538    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049c60: 340000c0    	cbz	w0, 0x101049c78 <__text+0x1041c78>
101049c64: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049c68: f940e901    	ldr	x1, [x8, #0x1d0] ; onShowNoTagMembers
101049c6c: aa1403e0    	mov	x0, x20
101049c70: 95af7533    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049c74: 1400003b    	b	0x101049d60 <__text+0x1041d60>
101049c78: b00f85e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101049c7c: f9440915    	ldr	x21, [x8, #0x810] ; row
101049c80: aa1303e0    	mov	x0, x19
101049c84: aa1503e1    	mov	x1, x21
101049c88: 95af752d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049c8c: b7f80420    	tbnz	x0, #0x3f, 0x101049d10 <__text+0x1041d10>
101049c90: aa1303e0    	mov	x0, x19
101049c94: aa1503e1    	mov	x1, x21
101049c98: 95af7529    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049c9c: aa0003f6    	mov	x22, x0
101049ca0: b00f8d08    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101049ca4: b982a917    	ldrsw	x23, [x8, #0x2a8]
101049ca8: f8776a80    	ldr	x0, [x20, x23]
101049cac: f00f85a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101049cb0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101049cb4: 95af7522    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049cb8: eb0002df    	cmp	x22, x0
101049cbc: 540002a2    	b.hs	0x101049d10 <__text+0x1041d10>
101049cc0: f8776a96    	ldr	x22, [x20, x23]
101049cc4: aa1303e0    	mov	x0, x19
101049cc8: aa1503e1    	mov	x1, x21
101049ccc: 95af751c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049cd0: aa0003e2    	mov	x2, x0
101049cd4: b00f6f88    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101049cd8: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
101049cdc: aa1603e0    	mov	x0, x22
101049ce0: 95af7517    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049ce4: aa1d03fd    	mov	x29, x29
101049ce8: 95af7518    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101049cec: aa0003f5    	mov	x21, x0
101049cf0: 900f7208    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101049cf4: f9407d01    	ldr	x1, [x8, #0xf8] ; onEditContactLabel:
101049cf8: aa1403e0    	mov	x0, x20
101049cfc: aa1503e2    	mov	x2, x21
101049d00: 95af750f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049d04: aa1503e0    	mov	x0, x21
101049d08: 95af7513    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101049d0c: 14000015    	b	0x101049d60 <__text+0x1041d60>
101049d10: d00f8948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101049d14: f9453514    	ldr	x20, [x8, #0xa68]
101049d18: aa1303e0    	mov	x0, x19
101049d1c: aa1503e1    	mov	x1, x21
101049d20: 95af7507    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049d24: 900f6f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101049d28: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101049d2c: f00ea7e8    	adrp	x8, 0x11e548000 <dyld_stub_binder+0x11e548000>
101049d30: 91322108    	add	x8, x8, #0xc88
101049d34: a90003e8    	stp	x8, x0, [sp]
101049d38: f00d1905    	adrp	x5, 0x11b36c000 <dyld_stub_binder+0x11b36c000>
101049d3c: 9118fca5    	add	x5, x5, #0x63f
101049d40: f00d1907    	adrp	x7, 0x11b36c000 <dyld_stub_binder+0x11b36c000>
101049d44: 911fece7    	add	x7, x7, #0x7fb
101049d48: aa1403e0    	mov	x0, x20
101049d4c: 52800082    	mov	w2, #0x4                ; =4
101049d50: d2800003    	mov	x3, #0x0                ; =0
101049d54: 52800004    	mov	w4, #0x0                ; =0
101049d58: 52804f26    	mov	w6, #0x279              ; =633
101049d5c: 95af74f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101049d60: aa1303e0    	mov	x0, x19
101049d64: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101049d68: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101049d6c: a94257f6    	ldp	x22, x21, [sp, #0x20]
101049d70: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101049d74: 910143ff    	add	sp, sp, #0x50
101049d78: 15af74f7    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
