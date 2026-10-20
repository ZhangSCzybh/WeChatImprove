
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002b137c: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
1002b1380: a90157f6    	stp	x22, x21, [sp, #0x10]
1002b1384: a9024ff4    	stp	x20, x19, [sp, #0x20]
1002b1388: a9037bfd    	stp	x29, x30, [sp, #0x30]
1002b138c: 9100c3fd    	add	x29, sp, #0x30
1002b1390: aa0003f3    	mov	x19, x0
1002b1394: 90104be8    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002b1398: 52800029    	mov	w9, #0x1                ; =1
1002b139c: 39320109    	strb	w9, [x8, #0xc80]
1002b13a0: d00ff968    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002b13a4: b982dd08    	ldrsw	x8, [x8, #0x2dc]
1002b13a8: 8b080014    	add	x20, x0, x8
1002b13ac: 6d402688    	ldp	d8, d9, [x20]
1002b13b0: 900e99e8    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
1002b13b4: f9417908    	ldr	x8, [x8, #0x2f0]
1002b13b8: 6d400d02    	ldp	d2, d3, [x8]
1002b13bc: 1e622100    	fcmp	d8, d2
1002b13c0: 1e630520    	fccmp	d9, d3, #0x0, eq
1002b13c4: 54000101    	b.ne	0x1002b13e4 <__text+0x2a93e4>
1002b13c8: b00fdc68    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002b13cc: f9416901    	ldr	x1, [x8, #0x2d0] ; measureContentViewSize:
1002b13d0: aa1303e0    	mov	x0, x19
1002b13d4: 95e5d75a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b13d8: 1e604008    	fmov	d8, d0
1002b13dc: 1e604029    	fmov	d9, d1
1002b13e0: 6d000680    	stp	d0, d1, [x20]
1002b13e4: d00fdc68    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002b13e8: f9415d01    	ldr	x1, [x8, #0x2b8] ; isTailPart
1002b13ec: aa1303e0    	mov	x0, x19
1002b13f0: 95e5d753    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b13f4: 340005c0    	cbz	w0, 0x1002b14ac <__text+0x2a94ac>
1002b13f8: f00ff608    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002b13fc: f9403d13    	ldr	x19, [x8, #0x78] ; 8�6 
1002b1400: d00ff608    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002b1404: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1002b1408: f00ff268    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002b140c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1002b1410: 95e5d74b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b1414: aa1d03fd    	mov	x29, x29
1002b1418: 95e5d74c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b141c: aa0003f4    	mov	x20, x0
1002b1420: f00ff608    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002b1424: f9404100    	ldr	x0, [x8, #0x80]
1002b1428: d00ff268    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002b142c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1002b1430: 95e5d743    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b1434: aa0003e2    	mov	x2, x0
1002b1438: 900fdc48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002b143c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1002b1440: aa1403e0    	mov	x0, x20
1002b1444: 95e5d73e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b1448: aa1d03fd    	mov	x29, x29
1002b144c: 95e5d73f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b1450: aa0003f5    	mov	x21, x0
1002b1454: d00fdc48    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002b1458: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
1002b145c: 900f0fc2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
1002b1460: 9123a042    	add	x2, x2, #0x8e8
1002b1464: 900f0fc3    	adrp	x3, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
1002b1468: 91242063    	add	x3, x3, #0x908
1002b146c: 95e5d734    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b1470: aa1d03fd    	mov	x29, x29
1002b1474: 95e5d735    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b1478: aa0003f6    	mov	x22, x0
1002b147c: f00fdc48    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1002b1480: f9400101    	ldr	x1, [x8]
1002b1484: aa1303e0    	mov	x0, x19
1002b1488: aa1603e2    	mov	x2, x22
1002b148c: 95e5d72c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b1490: 1e602929    	fadd	d9, d9, d0
1002b1494: aa1603e0    	mov	x0, x22
1002b1498: 95e5d72f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b149c: aa1503e0    	mov	x0, x21
1002b14a0: 95e5d72d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b14a4: aa1403e0    	mov	x0, x20
1002b14a8: 95e5d72b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b14ac: 1e604100    	fmov	d0, d8
1002b14b0: 1e604121    	fmov	d1, d9
1002b14b4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1002b14b8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1002b14bc: a94157f6    	ldp	x22, x21, [sp, #0x10]
1002b14c0: 6cc423e9    	ldp	d9, d8, [sp], #0x40
1002b14c4: d65f03c0    	ret