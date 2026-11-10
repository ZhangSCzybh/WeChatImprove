
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a4ee50: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101a4ee54: a9014ff4    	stp	x20, x19, [sp, #0x10]
101a4ee58: a9027bfd    	stp	x29, x30, [sp, #0x20]
101a4ee5c: 910083fd    	add	x29, sp, #0x20
101a4ee60: aa0203f3    	mov	x19, x2
101a4ee64: aa0003f4    	mov	x20, x0
101a4ee68: 900e9a28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a4ee6c: b98f1d08    	ldrsw	x8, [x8, #0xf1c] ; ivar: FavBaseTableDataController.m_arrFavDataWrap offset=72
101a4ee70: 8b080015    	add	x21, x0, x8
101a4ee74: f94002a0    	ldr	x0, [x21]
101a4ee78: 900e92c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a4ee7c: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
101a4ee80: 95876379    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4ee84: b5000080    	cbnz	x0, 0x101a4ee94 <__text+0x1a46e94>
101a4ee88: 900e9a28    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a4ee8c: b98f0908    	ldrsw	x8, [x8, #0xf08] ; ivar: FavBaseTableDataController.m_arrFavItem offset=80
101a4ee90: 8b080295    	add	x21, x20, x8
101a4ee94: f94002a0    	ldr	x0, [x21]
101a4ee98: 900e7be8    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
101a4ee9c: f941b101    	ldr	x1, [x8, #0x360] ; selector: safeObjectAtIndex:
101a4eea0: aa1303e2    	mov	x2, x19
101a4eea4: 95876370    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a4eea8: aa1d03fd    	mov	x29, x29
101a4eeac: 95876375    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a4eeb0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101a4eeb4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101a4eeb8: a8c357f6    	ldp	x22, x21, [sp], #0x30
101a4eebc: 15876359    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
