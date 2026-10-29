
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104727694: d10103ff    	sub	sp, sp, #0x40
104727698: a90157f6    	stp	x22, x21, [sp, #0x10]
10472769c: a9024ff4    	stp	x20, x19, [sp, #0x20]
1047276a0: a9037bfd    	stp	x29, x30, [sp, #0x30]
1047276a4: 9100c3fd    	add	x29, sp, #0x30
1047276a8: aa0003f3    	mov	x19, x0
1047276ac: d00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
1047276b0: 52800029    	mov	w9, #0x1                ; =1
1047276b4: 391a1d09    	strb	w9, [x8, #0x687]
1047276b8: f00db8e8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
1047276bc: f9423d01    	ldr	x1, [x8, #0x478] ; selector unreadCount
1047276c0: 94d3fe9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047276c4: b50001e0    	cbnz	x0, 0x104727700 <_Flutter_MMFoundation_BindContext+0xc032e4>
1047276c8: d00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
1047276cc: f9467101    	ldr	x1, [x8, #0xce0] ; selector badgeString
1047276d0: aa1303e0    	mov	x0, x19
1047276d4: 94d3fe9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047276d8: aa1d03fd    	mov	x29, x29
1047276dc: 94d3fe9b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047276e0: aa0003f4    	mov	x20, x0
1047276e4: 900dcee8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1047276e8: f946e901    	ldr	x1, [x8, #0xdd0] ; selector length
1047276ec: 94d3fe94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047276f0: aa0003f5    	mov	x21, x0
1047276f4: aa1403e0    	mov	x0, x20
1047276f8: 94d3fe97    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047276fc: b4000315    	cbz	x21, 0x10472775c <_Flutter_MMFoundation_BindContext+0xc03340>
104727700: 900dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104727704: f9453514    	ldr	x20, [x8, #0xa68] ; class iConsole
104727708: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
10472770c: b98a0908    	ldrsw	x8, [x8, #0xa08]
104727710: f8686a60    	ldr	x0, [x19, x8]
104727714: f00dcec8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104727718: f945f501    	ldr	x1, [x8, #0xbe8] ; selector index
10472771c: 94d3fe88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727720: d00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104727724: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104727728: 900d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
10472772c: 9112a108    	add	x8, x8, #0x4a8 ; CFString 'TRDTemp show small reddot for index %ld'
104727730: a90003e8    	stp	x8, x0, [sp]
104727734: b00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
104727738: 913feca5    	add	x5, x5, #0xffb ; string 'MMTabBarItemView.mm'
10472773c: d00b8387    	adrp	x7, 0x11b799000 <dyld_stub_binder+0x11b799000>
104727740: 9103e8e7    	add	x7, x7, #0xfa ; string '-[MMTabBarItemView showSmallRedDot]'
104727744: aa1403e0    	mov	x0, x20
104727748: 52800042    	mov	w2, #0x2                ; =2
10472774c: d2800003    	mov	x3, #0x0                ; =0
104727750: 52800004    	mov	w4, #0x0                ; =0
104727754: 52800e66    	mov	w6, #0x73               ; =115
104727758: 94d3fe79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472775c: d00db8e8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104727760: f946c101    	ldr	x1, [x8, #0xd80] ; selector setUnreadCount:
104727764: aa1303e0    	mov	x0, x19
104727768: d2800002    	mov	x2, #0x0                ; =0
10472776c: 94d3fe74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727770: d00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104727774: f9467501    	ldr	x1, [x8, #0xce8] ; selector setBadgeString:
104727778: aa1303e0    	mov	x0, x19
10472777c: d2800002    	mov	x2, #0x0                ; =0
104727780: 94d3fe6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727784: f00dbb88    	adrp	x8, 0x11fe9a000 <dyld_stub_binder+0x11fe9a000>
104727788: f9408914    	ldr	x20, [x8, #0x110] ; selector badgeView
10472778c: aa1303e0    	mov	x0, x19
104727790: aa1403e1    	mov	x1, x20
104727794: 94d3fe6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727798: aa1d03fd    	mov	x29, x29
10472779c: 94d3fe6b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047277a0: aa0003f5    	mov	x21, x0
1047277a4: b00dbce8    	adrp	x8, 0x11fec4000 <dyld_stub_binder+0x11fec4000>
1047277a8: f9479901    	ldr	x1, [x8, #0xf30] ; selector setAsSmallDot
1047277ac: 94d3fe64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047277b0: aa1503e0    	mov	x0, x21
1047277b4: 94d3fe68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047277b8: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
1047277bc: b98a1108    	ldrsw	x8, [x8, #0xa10]
1047277c0: f8686a60    	ldr	x0, [x19, x8]
1047277c4: 900db9e8    	adrp	x8, 0x11fe63000 <dyld_stub_binder+0x11fe63000>
1047277c8: f940dd01    	ldr	x1, [x8, #0x1b8] ; selector dr_setViewParam
1047277cc: 94d3fe5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047277d0: aa1d03fd    	mov	x29, x29
1047277d4: 94d3fe5d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047277d8: aa0003f5    	mov	x21, x0
1047277dc: f9400808    	ldr	x8, [x0, #0x10]
1047277e0: b00cf4c1    	adrp	x1, 0x11e5c0000 <dyld_stub_binder+0x11e5c0000>
1047277e4: 9123a021    	add	x1, x1, #0x8e8 ; CFString 'red_dot_content'
1047277e8: 900ceba2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1047277ec: 91032042    	add	x2, x2, #0xc8 ; CFString ''
1047277f0: d63f0100    	blr	x8
1047277f4: aa1d03fd    	mov	x29, x29
1047277f8: 94d3fe5b    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
1047277fc: aa1503e0    	mov	x0, x21
104727800: 94d3fe55    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727804: aa1303e0    	mov	x0, x19
104727808: aa1403e1    	mov	x1, x20
10472780c: 94d3fe4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104727810: aa1d03fd    	mov	x29, x29
104727814: 94d3fe4d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104727818: aa0003f4    	mov	x20, x0
10472781c: b00dcf08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104727820: f9411101    	ldr	x1, [x8, #0x220] ; selector setHidden:
104727824: 52800002    	mov	w2, #0x0                ; =0
104727828: 94d3fe45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472782c: aa1403e0    	mov	x0, x20
104727830: 94d3fe49    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727834: d00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104727838: f9467901    	ldr	x1, [x8, #0xcf0] ; selector layoutIcon
10472783c: aa1303e0    	mov	x0, x19
104727840: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104727844: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104727848: a94157f6    	ldp	x22, x21, [sp, #0x10]
10472784c: 910103ff    	add	sp, sp, #0x40
104727850: 14d3fe3b    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
