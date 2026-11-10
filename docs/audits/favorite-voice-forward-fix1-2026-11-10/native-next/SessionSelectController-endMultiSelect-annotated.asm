
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae8dd4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105ae8dd8: a9014ff4    	stp	x20, x19, [sp, #0x10]
105ae8ddc: a9027bfd    	stp	x29, x30, [sp, #0x20]
105ae8de0: 910083fd    	add	x29, sp, #0x20
105ae8de4: aa0003f3    	mov	x19, x0
105ae8de8: 900ce368    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
105ae8dec: 52800029    	mov	w9, #0x1                ; =1
105ae8df0: 39333109    	strb	w9, [x8, #0xccc]
105ae8df4: b00c79c8    	adrp	x8, 0x11ea21000 <dyld_stub_binder+0x11ea21000>
105ae8df8: f9424d01    	ldr	x1, [x8, #0x498] ; selector: m_bKeepCurViewAfterSelect
105ae8dfc: 9484fb9a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8e00: b00c9756    	adrp	x22, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae8e04: 37000600    	tbnz	w0, #0x0, 0x105ae8ec4 <_Flutter_MMFoundation_BindContext+0x1d6fb90>
105ae8e08: b00c8e08    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105ae8e0c: f941b101    	ldr	x1, [x8, #0x360] ; selector: navigationController
105ae8e10: aa1303e0    	mov	x0, x19
105ae8e14: 9484fb94    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8e18: aa1d03fd    	mov	x29, x29
105ae8e1c: 9484fb99    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae8e20: aa0003f4    	mov	x20, x0
105ae8e24: b00c8e08    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105ae8e28: f941ad01    	ldr	x1, [x8, #0x358] ; selector: navigationBar
105ae8e2c: 9484fb8e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8e30: aa1d03fd    	mov	x29, x29
105ae8e34: 9484fb93    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae8e38: aa0003f5    	mov	x21, x0
105ae8e3c: d00c8e08    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
105ae8e40: f946f501    	ldr	x1, [x8, #0xde8] ; selector: setAlpha:
105ae8e44: 1e6e1000    	fmov	d0, #1.00000000
105ae8e48: 9484fb87    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8e4c: aa1503e0    	mov	x0, x21
105ae8e50: 9484fb88    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae8e54: aa1403e0    	mov	x0, x20
105ae8e58: 9484fb86    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae8e5c: b00c7828    	adrp	x8, 0x11e9ed000 <dyld_stub_binder+0x11e9ed000>
105ae8e60: f942bd01    	ldr	x1, [x8, #0x578] ; selector: setStatusBarFontWhite
105ae8e64: aa1303e0    	mov	x0, x19
105ae8e68: 9484fb7f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8e6c: b984b6c8    	ldrsw	x8, [x22, #0x4b4] ; ivar: SessionSelectController.m_selectView offset=304
105ae8e70: f8686a60    	ldr	x0, [x19, x8]
105ae8e74: f00c7708    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
105ae8e78: f9455101    	ldr	x1, [x8, #0xaa0] ; selector: searcher
105ae8e7c: 9484fb7a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8e80: aa1d03fd    	mov	x29, x29
105ae8e84: 9484fb7f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae8e88: aa0003f4    	mov	x20, x0
105ae8e8c: 900c7728    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
105ae8e90: f9428501    	ldr	x1, [x8, #0x508] ; selector: searchController
105ae8e94: 9484fb74    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8e98: aa1d03fd    	mov	x29, x29
105ae8e9c: 9484fb79    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae8ea0: aa0003f5    	mov	x21, x0
105ae8ea4: b00c7708    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105ae8ea8: f9471101    	ldr	x1, [x8, #0xe20] ; selector: setActive:
105ae8eac: 52800002    	mov	w2, #0x0                ; =0
105ae8eb0: 9484fb6d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8eb4: aa1503e0    	mov	x0, x21
105ae8eb8: 9484fb6e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae8ebc: aa1403e0    	mov	x0, x20
105ae8ec0: 9484fb6c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae8ec4: b00c9748    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae8ec8: b984a914    	ldrsw	x20, [x8, #0x4a8] ; ivar: SessionSelectController.m_selectedContacts offset=128
105ae8ecc: f8746a60    	ldr	x0, [x19, x20]
105ae8ed0: b5000120    	cbnz	x0, 0x105ae8ef4 <_Flutter_MMFoundation_BindContext+0x1d6fbc0>
105ae8ed4: d00c9148    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105ae8ed8: f9432d00    	ldr	x0, [x8, #0x658]
105ae8edc: 9484fb4c    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
105ae8ee0: f8746a68    	ldr	x8, [x19, x20]
105ae8ee4: f8346a60    	str	x0, [x19, x20]
105ae8ee8: aa0803e0    	mov	x0, x8
105ae8eec: 9484fb61    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae8ef0: f8746a60    	ldr	x0, [x19, x20]
105ae8ef4: d00c8e08    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
105ae8ef8: f9421101    	ldr	x1, [x8, #0x420] ; selector: removeAllObjects
105ae8efc: 9484fb5a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8f00: f8746a74    	ldr	x20, [x19, x20]
105ae8f04: b984b6c8    	ldrsw	x8, [x22, #0x4b4] ; ivar: SessionSelectController.m_selectView offset=304
105ae8f08: f8686a60    	ldr	x0, [x19, x8]
105ae8f0c: f00c7888    	adrp	x8, 0x11e9fb000 <dyld_stub_binder+0x11e9fb000>
105ae8f10: f941ad01    	ldr	x1, [x8, #0x358] ; selector: m_dicMultiSelect
105ae8f14: 9484fb54    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8f18: aa1d03fd    	mov	x29, x29
105ae8f1c: 9484fb59    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae8f20: aa0003f5    	mov	x21, x0
105ae8f24: d00c7968    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
105ae8f28: f9464501    	ldr	x1, [x8, #0xc88] ; selector: allValuesInOrder
105ae8f2c: 9484fb4e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8f30: aa1d03fd    	mov	x29, x29
105ae8f34: 9484fb53    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae8f38: aa0003f6    	mov	x22, x0
105ae8f3c: b00c8de8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
105ae8f40: f9452101    	ldr	x1, [x8, #0xa40] ; selector: addObjectsFromArray:
105ae8f44: aa1403e0    	mov	x0, x20
105ae8f48: aa1603e2    	mov	x2, x22
105ae8f4c: 9484fb46    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae8f50: aa1603e0    	mov	x0, x22
105ae8f54: 9484fb47    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae8f58: aa1503e0    	mov	x0, x21
105ae8f5c: 9484fb45    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae8f60: 900c8348    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae8f64: f944e902    	ldr	x2, [x8, #0x9d0] ; selector: performCallback
105ae8f68: b00c8e08    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105ae8f6c: f946f501    	ldr	x1, [x8, #0xde8] ; selector: performSelector:withObject:afterDelay:
105ae8f70: f008eee8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
105ae8f74: fd43cd00    	ldr	d0, [x8, #0x798] ; constant double=0.10000000149011612
105ae8f78: aa1303e0    	mov	x0, x19
105ae8f7c: d2800003    	mov	x3, #0x0                ; =0
105ae8f80: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105ae8f84: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105ae8f88: a8c357f6    	ldp	x22, x21, [sp], #0x30
105ae8f8c: 1484fb36    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
