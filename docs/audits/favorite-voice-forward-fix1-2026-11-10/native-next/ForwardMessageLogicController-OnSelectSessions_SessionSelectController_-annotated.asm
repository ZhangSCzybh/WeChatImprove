
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
101dc1408: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
101dc140c: a9015ff8    	stp	x24, x23, [sp, #0x10]
101dc1410: a90257f6    	stp	x22, x21, [sp, #0x20]
101dc1414: a9034ff4    	stp	x20, x19, [sp, #0x30]
101dc1418: a9047bfd    	stp	x29, x30, [sp, #0x40]
101dc141c: 910103fd    	add	x29, sp, #0x40
101dc1420: aa0203f3    	mov	x19, x2
101dc1424: aa0003f4    	mov	x20, x0
101dc1428: b00ecc28    	adrp	x8, 0x11f746000 <dyld_stub_binder+0x11f746000>
101dc142c: 52800029    	mov	w9, #0x1                ; =1
101dc1430: 392fa109    	strb	w9, [x8, #0xbe8]
101dc1434: aa0203e0    	mov	x0, x2
101dc1438: 95799a0f    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101dc143c: 900e7ea8    	adrp	x8, 0x11ed95000 <dyld_stub_binder+0x11ed95000>
101dc1440: b9855119    	ldrsw	x25, [x8, #0x550] ; ivar: ForwardMessageLogicController.m_delegate offset=8
101dc1444: 8b190280    	add	x0, x20, x25
101dc1448: 95799a05    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101dc144c: b00e775a    	adrp	x26, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
101dc1450: b40003c0    	cbz	x0, 0x101dc14c8 <_Flutter_Image_provideRelativePathByUrl+0x49954>
101dc1454: aa0003f5    	mov	x21, x0
101dc1458: 8b190280    	add	x0, x20, x25
101dc145c: 95799a00    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101dc1460: aa0003f6    	mov	x22, x0
101dc1464: 900e64a8    	adrp	x8, 0x11ea55000 <dyld_stub_binder+0x11ea55000>
101dc1468: f9409517    	ldr	x23, [x8, #0x128] ; selector: OnForwardMessageNeedCancelConfirm:
101dc146c: f9440741    	ldr	x1, [x26, #0x808] ; selector: respondsToSelector:
101dc1470: aa1703e2    	mov	x2, x23
101dc1474: 957999fc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc1478: 36000200    	tbz	w0, #0x0, 0x101dc14b8 <_Flutter_Image_provideRelativePathByUrl+0x49944>
101dc147c: 8b190280    	add	x0, x20, x25
101dc1480: 957999f7    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101dc1484: aa0003f8    	mov	x24, x0
101dc1488: aa1703e1    	mov	x1, x23
101dc148c: aa1403e2    	mov	x2, x20
101dc1490: 957999f5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc1494: aa0003f7    	mov	x23, x0
101dc1498: aa1803e0    	mov	x0, x24
101dc149c: 957999f5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc14a0: aa1603e0    	mov	x0, x22
101dc14a4: 957999f3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc14a8: aa1503e0    	mov	x0, x21
101dc14ac: 957999f1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc14b0: 360000d7    	tbz	w23, #0x0, 0x101dc14c8 <_Flutter_Image_provideRelativePathByUrl+0x49954>
101dc14b4: 1400007b    	b	0x101dc16a0 <_Flutter_Image_provideRelativePathByUrl+0x49b2c>
101dc14b8: aa1603e0    	mov	x0, x22
101dc14bc: 957999ed    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc14c0: aa1503e0    	mov	x0, x21
101dc14c4: 957999eb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc14c8: b00e7a88    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101dc14cc: f943c100    	ldr	x0, [x8, #0x780]
101dc14d0: 900e6048    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101dc14d4: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
101dc14d8: 957999e3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc14dc: aa1d03fd    	mov	x29, x29
101dc14e0: 957999e8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101dc14e4: aa0003f6    	mov	x22, x0
101dc14e8: f00e7ae8    	adrp	x8, 0x11ed20000 <dyld_stub_binder+0x11ed20000>
101dc14ec: f944b900    	ldr	x0, [x8, #0x970]
101dc14f0: b00e7728    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101dc14f4: f9428515    	ldr	x21, [x8, #0x508] ; selector: class
101dc14f8: aa1503e1    	mov	x1, x21
101dc14fc: 957999da    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc1500: aa0003e2    	mov	x2, x0
101dc1504: 900e6048    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101dc1508: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
101dc150c: aa1603e0    	mov	x0, x22
101dc1510: 957999d5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc1514: aa1d03fd    	mov	x29, x29
101dc1518: 957999da    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101dc151c: aa0003f7    	mov	x23, x0
101dc1520: b00e63e8    	adrp	x8, 0x11ea3e000 <dyld_stub_binder+0x11ea3e000>
101dc1524: f9476101    	ldr	x1, [x8, #0xec0] ; selector: currentSession
101dc1528: 957999cf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc152c: aa1d03fd    	mov	x29, x29
101dc1530: 957999d4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101dc1534: aa0003f8    	mov	x24, x0
101dc1538: 900e64a8    	adrp	x8, 0x11ea55000 <dyld_stub_binder+0x11ea55000>
101dc153c: f9409901    	ldr	x1, [x8, #0x130] ; selector: restoreConfirmScreenFromForReport
101dc1540: 957999c9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc1544: aa1803e0    	mov	x0, x24
101dc1548: 957999ca    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc154c: aa1703e0    	mov	x0, x23
101dc1550: 957999c8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc1554: aa1603e0    	mov	x0, x22
101dc1558: 957999c6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc155c: b00e7728    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101dc1560: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
101dc1564: aa1303e0    	mov	x0, x19
101dc1568: 957999bf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc156c: f100041f    	cmp	x0, #0x1
101dc1570: 540005a1    	b.ne	0x101dc1624 <_Flutter_Image_provideRelativePathByUrl+0x49ab0>
101dc1574: f00e6488    	adrp	x8, 0x11ea54000 <dyld_stub_binder+0x11ea54000>
101dc1578: f946e501    	ldr	x1, [x8, #0xdc8] ; selector: isYuanBaoBotForwardSwitchOn
101dc157c: aa1403e0    	mov	x0, x20
101dc1580: 957999b9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc1584: 34000500    	cbz	w0, 0x101dc1624 <_Flutter_Image_provideRelativePathByUrl+0x49ab0>
101dc1588: d00e7728    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
101dc158c: f942cd01    	ldr	x1, [x8, #0x598] ; selector: firstObject
101dc1590: aa1303e0    	mov	x0, x19
101dc1594: 957999b4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc1598: aa1d03fd    	mov	x29, x29
101dc159c: 957999b9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101dc15a0: aa0003f6    	mov	x22, x0
101dc15a4: b00e7a88    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101dc15a8: f9456100    	ldr	x0, [x8, #0xac0]
101dc15ac: aa1503e1    	mov	x1, x21
101dc15b0: 957999ad    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc15b4: aa0003e2    	mov	x2, x0
101dc15b8: f00e7728    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
101dc15bc: f9444901    	ldr	x1, [x8, #0x890] ; selector: isKindOfClass:
101dc15c0: aa1603e0    	mov	x0, x22
101dc15c4: 957999a8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc15c8: 340002a0    	cbz	w0, 0x101dc161c <_Flutter_Image_provideRelativePathByUrl+0x49aa8>
101dc15cc: 900e6288    	adrp	x8, 0x11ea11000 <dyld_stub_binder+0x11ea11000>
101dc15d0: f9477101    	ldr	x1, [x8, #0xee0] ; selector: isYuanBao
101dc15d4: aa1603e0    	mov	x0, x22
101dc15d8: 957999a3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc15dc: 34000200    	cbz	w0, 0x101dc161c <_Flutter_Image_provideRelativePathByUrl+0x49aa8>
101dc15e0: f00e6488    	adrp	x8, 0x11ea54000 <dyld_stub_binder+0x11ea54000>
101dc15e4: f946e901    	ldr	x1, [x8, #0xdd0] ; selector: needShowBotForwardZipAlertForContacts:
101dc15e8: aa1403e0    	mov	x0, x20
101dc15ec: aa1303e2    	mov	x2, x19
101dc15f0: 9579999d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc15f4: f00e6488    	adrp	x8, 0x11ea54000 <dyld_stub_binder+0x11ea54000>
101dc15f8: 91376108    	add	x8, x8, #0xdd8
101dc15fc: f00e6489    	adrp	x9, 0x11ea54000 <dyld_stub_binder+0x11ea54000>
101dc1600: 91378129    	add	x9, x9, #0xde0
101dc1604: 7100001f    	cmp	w0, #0x0
101dc1608: 9a891108    	csel	x8, x8, x9, ne
101dc160c: f9400101    	ldr	x1, [x8]
101dc1610: aa1403e0    	mov	x0, x20
101dc1614: aa1303e2    	mov	x2, x19
101dc1618: 1400001f    	b	0x101dc1694 <_Flutter_Image_provideRelativePathByUrl+0x49b20>
101dc161c: aa1603e0    	mov	x0, x22
101dc1620: 95799994    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc1624: f00e6488    	adrp	x8, 0x11ea54000 <dyld_stub_binder+0x11ea54000>
101dc1628: f946f501    	ldr	x1, [x8, #0xde8] ; selector: showConfirmView:
101dc162c: aa1403e0    	mov	x0, x20
101dc1630: aa1303e2    	mov	x2, x19
101dc1634: 9579998c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc1638: 8b190280    	add	x0, x20, x25
101dc163c: 95799988    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101dc1640: b4000300    	cbz	x0, 0x101dc16a0 <_Flutter_Image_provideRelativePathByUrl+0x49b2c>
101dc1644: aa0003f6    	mov	x22, x0
101dc1648: 8b190280    	add	x0, x20, x25
101dc164c: 95799984    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101dc1650: aa0003f7    	mov	x23, x0
101dc1654: 900e64a8    	adrp	x8, 0x11ea55000 <dyld_stub_binder+0x11ea55000>
101dc1658: f9409d15    	ldr	x21, [x8, #0x138] ; selector: OnForwardMessageSelectSession:
101dc165c: f9440741    	ldr	x1, [x26, #0x808] ; selector: respondsToSelector:
101dc1660: aa1503e2    	mov	x2, x21
101dc1664: 95799980    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc1668: aa0003f8    	mov	x24, x0
101dc166c: aa1703e0    	mov	x0, x23
101dc1670: 95799980    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc1674: aa1603e0    	mov	x0, x22
101dc1678: 9579997e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc167c: 34000138    	cbz	w24, 0x101dc16a0 <_Flutter_Image_provideRelativePathByUrl+0x49b2c>
101dc1680: 8b190280    	add	x0, x20, x25
101dc1684: 95799976    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101dc1688: aa0003f6    	mov	x22, x0
101dc168c: aa1503e1    	mov	x1, x21
101dc1690: aa1403e2    	mov	x2, x20
101dc1694: 95799974    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dc1698: aa1603e0    	mov	x0, x22
101dc169c: 95799975    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101dc16a0: aa1303e0    	mov	x0, x19
101dc16a4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101dc16a8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101dc16ac: a94257f6    	ldp	x22, x21, [sp, #0x20]
101dc16b0: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101dc16b4: a8c567fa    	ldp	x26, x25, [sp], #0x50
101dc16b8: 1579996e    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
