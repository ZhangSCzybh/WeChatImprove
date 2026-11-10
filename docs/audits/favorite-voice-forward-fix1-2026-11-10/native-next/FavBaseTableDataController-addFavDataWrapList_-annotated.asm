
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a4bfb8: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
101a4bfbc: a9015ff8    	stp	x24, x23, [sp, #0x10]
101a4bfc0: a90257f6    	stp	x22, x21, [sp, #0x20]
101a4bfc4: a9034ff4    	stp	x20, x19, [sp, #0x30]
101a4bfc8: a9047bfd    	stp	x29, x30, [sp, #0x40]
101a4bfcc: 910103fd    	add	x29, sp, #0x40
101a4bfd0: aa0203f3    	mov	x19, x2
101a4bfd4: aa0003f4    	mov	x20, x0
101a4bfd8: d00ee7c8    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a4bfdc: 52800029    	mov	w9, #0x1                ; =1
101a4bfe0: 393e4109    	strb	w9, [x8, #0xf90]
101a4bfe4: aa0203e0    	mov	x0, x2
101a4bfe8: 95876f23    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a4bfec: f00e9a28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a4bff0: b98f0908    	ldrsw	x8, [x8, #0xf08] ; ivar: FavBaseTableDataController.m_arrFavItem offset=80
101a4bff4: f8686a80    	ldr	x0, [x20, x8]
101a4bff8: f00e92c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a4bffc: f9442915    	ldr	x21, [x8, #0x850] ; selector: count
101a4c000: aa1503e1    	mov	x1, x21
101a4c004: 95876f18    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4c008: b5000800    	cbnz	x0, 0x101a4c108 <__text+0x1a44108>
101a4c00c: aa1303e0    	mov	x0, x19
101a4c010: aa1503e1    	mov	x1, x21
101a4c014: 95876f14    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4c018: b4000780    	cbz	x0, 0x101a4c108 <__text+0x1a44108>
101a4c01c: d00e9a28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a4c020: b98f5519    	ldrsw	x25, [x8, #0xf54] ; ivar: FavBaseTableDataController.m_bReadyToLoad offset=9
101a4c024: 38396a9f    	strb	wzr, [x20, x25]
101a4c028: d00e9a28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a4c02c: b98f1d18    	ldrsw	x24, [x8, #0xf1c] ; ivar: FavBaseTableDataController.m_arrFavDataWrap offset=72
101a4c030: f8786a80    	ldr	x0, [x20, x24]
101a4c034: b00e92c8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
101a4c038: f9452101    	ldr	x1, [x8, #0xa40] ; selector: addObjectsFromArray:
101a4c03c: aa1303e2    	mov	x2, x19
101a4c040: 95876f09    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4c044: d00e9a28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a4c048: b98f491a    	ldrsw	x26, [x8, #0xf48] ; ivar: FavBaseTableDataController._tableView offset=176
101a4c04c: f87a6a80    	ldr	x0, [x20, x26]
101a4c050: d00e7c68    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
101a4c054: f945bd01    	ldr	x1, [x8, #0xb78] ; selector: beginUpdates
101a4c058: 95876f03    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4c05c: f87a6a96    	ldr	x22, [x20, x26]
101a4c060: 900e9648    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101a4c064: f946e117    	ldr	x23, [x8, #0xdc0]
101a4c068: f8786a80    	ldr	x0, [x20, x24]
101a4c06c: aa1503e1    	mov	x1, x21
101a4c070: 95876efd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4c074: aa0003f8    	mov	x24, x0
101a4c078: aa1303e0    	mov	x0, x19
101a4c07c: aa1503e1    	mov	x1, x21
101a4c080: 95876ef9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4c084: cb000318    	sub	x24, x24, x0
101a4c088: aa1303e0    	mov	x0, x19
101a4c08c: aa1503e1    	mov	x1, x21
101a4c090: 95876ef5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4c094: aa0003e3    	mov	x3, x0
101a4c098: 900e92e8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
101a4c09c: f9403501    	ldr	x1, [x8, #0x68] ; selector: indexSetWithIndexesInRange:
101a4c0a0: aa1703e0    	mov	x0, x23
101a4c0a4: aa1803e2    	mov	x2, x24
101a4c0a8: 95876eef    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4c0ac: aa1d03fd    	mov	x29, x29
101a4c0b0: 95876ef4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a4c0b4: aa0003f5    	mov	x21, x0
101a4c0b8: b00e7c88    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
101a4c0bc: f945e101    	ldr	x1, [x8, #0xbc0] ; selector: insertSections:withRowAnimation:
101a4c0c0: aa1603e0    	mov	x0, x22
101a4c0c4: aa1503e2    	mov	x2, x21
101a4c0c8: 528000a3    	mov	w3, #0x5                ; =5
101a4c0cc: 95876ee6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4c0d0: aa1503e0    	mov	x0, x21
101a4c0d4: 95876ee7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a4c0d8: f87a6a80    	ldr	x0, [x20, x26]
101a4c0dc: d00e7c68    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
101a4c0e0: f945c101    	ldr	x1, [x8, #0xb80] ; selector: endUpdates
101a4c0e4: 95876ee0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4c0e8: d00e9a28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a4c0ec: b98f5108    	ldrsw	x8, [x8, #0xf50] ; ivar: FavBaseTableDataController.m_activityView offset=40
101a4c0f0: f8686a80    	ldr	x0, [x20, x8]
101a4c0f4: b00e9308    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
101a4c0f8: f941e501    	ldr	x1, [x8, #0x3c8] ; selector: stopAnimating
101a4c0fc: 95876eda    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4c100: 52800028    	mov	w8, #0x1                ; =1
101a4c104: 38396a88    	strb	w8, [x20, x25]
101a4c108: aa1303e0    	mov	x0, x19
101a4c10c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101a4c110: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101a4c114: a94257f6    	ldp	x22, x21, [sp, #0x20]
101a4c118: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101a4c11c: a8c567fa    	ldp	x26, x25, [sp], #0x50
101a4c120: 15876ed4    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
