
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100c77bd0: d10283ff    	sub	sp, sp, #0xa0
100c77bd4: a9065ff8    	stp	x24, x23, [sp, #0x60]
100c77bd8: a90757f6    	stp	x22, x21, [sp, #0x70]
100c77bdc: a9084ff4    	stp	x20, x19, [sp, #0x80]
100c77be0: a9097bfd    	stp	x29, x30, [sp, #0x90]
100c77be4: 910243fd    	add	x29, sp, #0x90
100c77be8: aa0403f7    	mov	x23, x4
100c77bec: aa0303f3    	mov	x19, x3
100c77bf0: aa0203f4    	mov	x20, x2
100c77bf4: aa0003f6    	mov	x22, x0
100c77bf8: f00f5648    	adrp	x8, 0x11f742000 <dyld_stub_binder+0x11f742000>
100c77bfc: 52800029    	mov	w9, #0x1                ; =1
100c77c00: 39333909    	strb	w9, [x8, #0xcce]
100c77c04: aa0203e0    	mov	x0, x2
100c77c08: 95bec01b    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100c77c0c: aa1303e0    	mov	x0, x19
100c77c10: 95bec019    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100c77c14: 900eeaa8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100c77c18: f9431101    	ldr	x1, [x8, #0x620] ; selector: m_nsUsrName
100c77c1c: aa1403e0    	mov	x0, x20
100c77c20: 95bec011    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100c77c24: aa1d03fd    	mov	x29, x29
100c77c28: 95bec016    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100c77c2c: aa0003f5    	mov	x21, x0
100c77c30: b00e56a8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100c77c34: f9449908    	ldr	x8, [x8, #0x930]
100c77c38: f9001be8    	str	x8, [sp, #0x30]
100c77c3c: 900b6289    	adrp	x9, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
100c77c40: fd434120    	ldr	d0, [x9, #0x680] ; constant double=1.6080749353e-314
100c77c44: fd001fe0    	str	d0, [sp, #0x38]
100c77c48: 90000009    	adrp	x9, 0x100c77000 <__text+0xc6f000>
100c77c4c: 91341129    	add	x9, x9, #0xd04
100c77c50: 900db0ea    	adrp	x10, 0x11c293000 <dyld_stub_binder+0x11c293000>
100c77c54: 912f414a    	add	x10, x10, #0xbd0
100c77c58: a9042be9    	stp	x9, x10, [sp, #0x40]
100c77c5c: a90553f3    	stp	x19, x20, [sp, #0x50]
100c77c60: f90003e8    	str	x8, [sp]
100c77c64: fd0007e0    	str	d0, [sp, #0x8]
100c77c68: 90000008    	adrp	x8, 0x100c77000 <__text+0xc6f000>
100c77c6c: 91352108    	add	x8, x8, #0xd48
100c77c70: 900db0e9    	adrp	x9, 0x11c293000 <dyld_stub_binder+0x11c293000>
100c77c74: 91324129    	add	x9, x9, #0xc90
100c77c78: a90127e8    	stp	x8, x9, [sp, #0x10]
100c77c7c: 3900a3f7    	strb	w23, [sp, #0x28]
100c77c80: f90013f6    	str	x22, [sp, #0x20]
100c77c84: b00eec88    	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
100c77c88: f945e117    	ldr	x23, [x8, #0xbc0] ; selector: modifyContact:Des:WithBlock:WithDoneBlock:
100c77c8c: aa1403e0    	mov	x0, x20
100c77c90: 95bebff9    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100c77c94: aa1303e0    	mov	x0, x19
100c77c98: 95bebff7    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100c77c9c: f00e1d43    	adrp	x3, 0x11d022000 <dyld_stub_binder+0x11d022000>
100c77ca0: 911d6063    	add	x3, x3, #0x758 ; CFString: chatRoomMemList
100c77ca4: 9100c3e4    	add	x4, sp, #0x30
100c77ca8: 910003e5    	mov	x5, sp
100c77cac: aa1603e0    	mov	x0, x22
100c77cb0: aa1703e1    	mov	x1, x23
100c77cb4: aa1503e2    	mov	x2, x21
100c77cb8: 95bebfeb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100c77cbc: aa0003f6    	mov	x22, x0
100c77cc0: f9402fe0    	ldr	x0, [sp, #0x58]
100c77cc4: 95bebfeb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c77cc8: f9402be0    	ldr	x0, [sp, #0x50]
100c77ccc: 95bebfe9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c77cd0: aa1403e0    	mov	x0, x20
100c77cd4: 95bebfe7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c77cd8: aa1303e0    	mov	x0, x19
100c77cdc: 95bebfe5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c77ce0: aa1503e0    	mov	x0, x21
100c77ce4: 95bebfe3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c77ce8: aa1603e0    	mov	x0, x22
100c77cec: a9497bfd    	ldp	x29, x30, [sp, #0x90]
100c77cf0: a9484ff4    	ldp	x20, x19, [sp, #0x80]
100c77cf4: a94757f6    	ldp	x22, x21, [sp, #0x70]
100c77cf8: a9465ff8    	ldp	x24, x23, [sp, #0x60]
100c77cfc: 910283ff    	add	sp, sp, #0xa0
100c77d00: d65f03c0    	ret
100c77d04: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
100c77d08: a9017bfd    	stp	x29, x30, [sp, #0x10]
100c77d0c: 910043fd    	add	x29, sp, #0x10
100c77d10: aa0003f3    	mov	x19, x0
100c77d14: f9401002    	ldr	x2, [x0, #0x20]
100c77d18: b00eec88    	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
100c77d1c: f9465914    	ldr	x20, [x8, #0xcb0] ; selector: setM_nsChatRoomMemList:
100c77d20: aa0103e0    	mov	x0, x1
100c77d24: aa1403e1    	mov	x1, x20
100c77d28: 95bebfcf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100c77d2c: a9420262    	ldp	x2, x0, [x19, #0x20]
100c77d30: aa1403e1    	mov	x1, x20
100c77d34: 95bebfcc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100c77d38: 52800020    	mov	w0, #0x1                ; =1
100c77d3c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100c77d40: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100c77d44: d65f03c0    	ret
100c77d48: 3940a008    	ldrb	w8, [x0, #0x28]
100c77d4c: 7100051f    	cmp	w8, #0x1
100c77d50: 54000141    	b.ne	0x100c77d78 <__text+0xc6fd78>
100c77d54: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
100c77d58: 910003fd    	mov	x29, sp
100c77d5c: aa0103e2    	mov	x2, x1
100c77d60: f9401000    	ldr	x0, [x0, #0x20]
100c77d64: f00eebc8    	adrp	x8, 0x11e9f2000 <dyld_stub_binder+0x11e9f2000>
100c77d68: f9464d01    	ldr	x1, [x8, #0xc98] ; selector: internalModifyContact:CallExt:
100c77d6c: 52800023    	mov	w3, #0x1                ; =1
100c77d70: 95bebfbd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100c77d74: a8c17bfd    	ldp	x29, x30, [sp], #0x10
100c77d78: 52800020    	mov	w0, #0x1                ; =1
100c77d7c: d65f03c0    	ret
