
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a4eec0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101a4eec4: a9014ff4    	stp	x20, x19, [sp, #0x10]
101a4eec8: a9027bfd    	stp	x29, x30, [sp, #0x20]
101a4eecc: 910083fd    	add	x29, sp, #0x20
101a4eed0: aa0203f3    	mov	x19, x2
101a4eed4: aa0003f4    	mov	x20, x0
101a4eed8: 900e9a28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a4eedc: b98f1d15    	ldrsw	x21, [x8, #0xf1c] ; ivar: FavBaseTableDataController.m_arrFavDataWrap offset=72
101a4eee0: f8756800    	ldr	x0, [x0, x21]
101a4eee4: 900e92c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a4eee8: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
101a4eeec: 9587635e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4eef0: b4000140    	cbz	x0, 0x101a4ef18 <__text+0x1a46f18>
101a4eef4: f8756a80    	ldr	x0, [x20, x21]
101a4eef8: 900e7be8    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
101a4eefc: f941b101    	ldr	x1, [x8, #0x360] ; selector: safeObjectAtIndex:
101a4ef00: aa1303e2    	mov	x2, x19
101a4ef04: 95876358    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4ef08: aa1d03fd    	mov	x29, x29
101a4ef0c: 9587635d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a4ef10: aa0003f3    	mov	x19, x0
101a4ef14: 14000019    	b	0x101a4ef78 <__text+0x1a46f78>
101a4ef18: b00e9688    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
101a4ef1c: f9407900    	ldr	x0, [x8, #0xf0]
101a4ef20: 9587633a    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
101a4ef24: aa0003f5    	mov	x21, x0
101a4ef28: 900e9a28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a4ef2c: b98f0908    	ldrsw	x8, [x8, #0xf08] ; ivar: FavBaseTableDataController.m_arrFavItem offset=80
101a4ef30: f8686a80    	ldr	x0, [x20, x8]
101a4ef34: 900e7be8    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
101a4ef38: f941b101    	ldr	x1, [x8, #0x360] ; selector: safeObjectAtIndex:
101a4ef3c: aa1303e2    	mov	x2, x19
101a4ef40: 95876349    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4ef44: aa1d03fd    	mov	x29, x29
101a4ef48: 9587634e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a4ef4c: aa0003f4    	mov	x20, x0
101a4ef50: 900e7fc8    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101a4ef54: f9451901    	ldr	x1, [x8, #0xa30] ; selector: initWithParent:DataItem:Index:
101a4ef58: aa1503e0    	mov	x0, x21
101a4ef5c: aa1403e2    	mov	x2, x20
101a4ef60: d2800003    	mov	x3, #0x0                ; =0
101a4ef64: 52800004    	mov	w4, #0x0                ; =0
101a4ef68: 9587633f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4ef6c: aa0003f3    	mov	x19, x0
101a4ef70: aa1403e0    	mov	x0, x20
101a4ef74: 9587633f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a4ef78: aa1303e0    	mov	x0, x19
101a4ef7c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101a4ef80: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101a4ef84: a8c357f6    	ldp	x22, x21, [sp], #0x30
101a4ef88: 15876326    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
