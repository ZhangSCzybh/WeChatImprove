
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae2eb0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
105ae2eb4: a9017bfd    	stp	x29, x30, [sp, #0x10]
105ae2eb8: 910043fd    	add	x29, sp, #0x10
105ae2ebc: aa0203f3    	mov	x19, x2
105ae2ec0: aa0003f4    	mov	x20, x0
105ae2ec4: aa0203e0    	mov	x0, x2
105ae2ec8: 9485136b    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae2ecc: d00c8e28    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
105ae2ed0: f9404d01    	ldr	x1, [x8, #0x98] ; selector: init
105ae2ed4: aa1403e0    	mov	x0, x20
105ae2ed8: 94851363    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2edc: aa0003f4    	mov	x20, x0
105ae2ee0: b4000160    	cbz	x0, 0x105ae2f0c <_Flutter_MMFoundation_BindContext+0x1d69bd8>
105ae2ee4: f00c8e28    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105ae2ee8: f9418d01    	ldr	x1, [x8, #0x318] ; selector: mutableCopy
105ae2eec: aa1303e0    	mov	x0, x19
105ae2ef0: 9485135d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2ef4: f00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae2ef8: b984a909    	ldrsw	x9, [x8, #0x4a8] ; ivar: SessionSelectController.m_selectedContacts offset=128
105ae2efc: f8696a88    	ldr	x8, [x20, x9]
105ae2f00: f8296a80    	str	x0, [x20, x9]
105ae2f04: aa0803e0    	mov	x0, x8
105ae2f08: 9485135a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae2f0c: aa1303e0    	mov	x0, x19
105ae2f10: 94851358    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae2f14: aa1403e0    	mov	x0, x20
105ae2f18: a9417bfd    	ldp	x29, x30, [sp, #0x10]
105ae2f1c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
105ae2f20: d65f03c0    	ret
