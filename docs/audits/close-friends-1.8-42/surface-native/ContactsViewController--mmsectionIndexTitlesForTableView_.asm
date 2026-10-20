
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010edb68: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1010edb6c: a90157f6    	stp	x22, x21, [sp, #0x10]
1010edb70: a9024ff4    	stp	x20, x19, [sp, #0x20]
1010edb74: a9037bfd    	stp	x29, x30, [sp, #0x30]
1010edb78: 9100c3fd    	add	x29, sp, #0x30
1010edb7c: aa0003f4    	mov	x20, x0
1010edb80: d00f8428    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1010edb84: f9455500    	ldr	x0, [x8, #0xaa8]
1010edb88: d00f8088    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1010edb8c: f941a101    	ldr	x1, [x8, #0x340] ; array
1010edb90: 95ace56b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010edb94: aa1d03fd    	mov	x29, x29
1010edb98: 95ace56c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010edb9c: aa0003f3    	mov	x19, x0
1010edba0: b00f87e8    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010edba4: b98a6d18    	ldrsw	x24, [x8, #0xa6c] ; ivar ContactsViewController.m_contactsDataLogic
1010edba8: f8786a80    	ldr	x0, [x20, x24]
1010edbac: b00f6b48    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
1010edbb0: f942d915    	ldr	x21, [x8, #0x5b0] ; getKeysArray
1010edbb4: aa1503e1    	mov	x1, x21
1010edbb8: 95ace561    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010edbbc: aa1d03fd    	mov	x29, x29
1010edbc0: 95ace562    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010edbc4: aa0003f6    	mov	x22, x0
1010edbc8: f00f8088    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010edbcc: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1010edbd0: 95ace55b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010edbd4: aa0003f7    	mov	x23, x0
1010edbd8: aa1603e0    	mov	x0, x22
1010edbdc: 95ace55e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010edbe0: b4000117    	cbz	x23, 0x1010edc00 <__text+0x10e5c00>
1010edbe4: f00e27e8    	adrp	x8, 0x11d5ec000 <dyld_stub_binder+0x11d5ec000>
1010edbe8: f9423108    	ldr	x8, [x8, #0x460]
1010edbec: f9400102    	ldr	x2, [x8]
1010edbf0: b00f6a68    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1010edbf4: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1010edbf8: aa1303e0    	mov	x0, x19
1010edbfc: 95ace550    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010edc00: f8786a80    	ldr	x0, [x20, x24]
1010edc04: aa1503e1    	mov	x1, x21
1010edc08: 95ace54d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010edc0c: aa1d03fd    	mov	x29, x29
1010edc10: 95ace54e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010edc14: aa0003f4    	mov	x20, x0
1010edc18: b00f8088    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1010edc1c: f946f901    	ldr	x1, [x8, #0xdf0] ; addObjectsFromArray:
1010edc20: aa1303e0    	mov	x0, x19
1010edc24: aa1403e2    	mov	x2, x20
1010edc28: 95ace545    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010edc2c: aa1403e0    	mov	x0, x20
1010edc30: 95ace549    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1010edc34: aa1303e0    	mov	x0, x19
1010edc38: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1010edc3c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1010edc40: a94157f6    	ldp	x22, x21, [sp, #0x10]
1010edc44: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1010edc48: 15ace54a    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
