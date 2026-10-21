
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ea1220: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
104ea1224: a90167fa    	stp	x26, x25, [sp, #0x10]
104ea1228: a9025ff8    	stp	x24, x23, [sp, #0x20]
104ea122c: a90357f6    	stp	x22, x21, [sp, #0x30]
104ea1230: a9044ff4    	stp	x20, x19, [sp, #0x40]
104ea1234: a9057bfd    	stp	x29, x30, [sp, #0x50]
104ea1238: 910143fd    	add	x29, sp, #0x50
104ea123c: aa0003f3    	mov	x19, x0
104ea1240: d00dece8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104ea1244: 52800029    	mov	w9, #0x1                ; =1
104ea1248: 39079509    	strb	w9, [x8, #0x1e5]
104ea124c: b00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea1250: b988511a    	ldrsw	x26, [x8, #0x850]
104ea1254: f87a6800    	ldr	x0, [x0, x26]
104ea1258: f00d7f28    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104ea125c: f9404501    	ldr	x1, [x8, #0x88] ; m_bShowContactRecommend
104ea1260: 94b617b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1264: 340000c0    	cbz	w0, 0x104ea127c <_Flutter_MMFoundation_BindContext+0x137ce60>
104ea1268: d00d7f28    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
104ea126c: f9437d01    	ldr	x1, [x8, #0x6f8] ; reportRecommendInfo:
104ea1270: aa1303e0    	mov	x0, x19
104ea1274: 52800022    	mov	w2, #0x1                ; =1
104ea1278: 94b617b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea127c: d00d969b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
104ea1280: f945eb60    	ldr	x0, [x27, #0xbd0]
104ea1284: f00d92e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104ea1288: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
104ea128c: aa1403e1    	mov	x1, x20
104ea1290: 94b617ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1294: aa1d03fd    	mov	x29, x29
104ea1298: 94b617ac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea129c: aa0003f7    	mov	x23, x0
104ea12a0: f00d969c    	adrp	x28, 0x120174000 <dyld_stub_binder+0x120174000>
104ea12a4: f9411780    	ldr	x0, [x28, #0x228]
104ea12a8: d00d92e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104ea12ac: f947ad15    	ldr	x21, [x8, #0xf58] ; class
104ea12b0: aa1503e1    	mov	x1, x21
104ea12b4: 94b617a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea12b8: aa0003e2    	mov	x2, x0
104ea12bc: 900d7cc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ea12c0: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
104ea12c4: aa1703e0    	mov	x0, x23
104ea12c8: aa1603e1    	mov	x1, x22
104ea12cc: 94b6179c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea12d0: aa1d03fd    	mov	x29, x29
104ea12d4: 94b6179d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea12d8: aa0003f8    	mov	x24, x0
104ea12dc: f00d7cc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104ea12e0: f944e501    	ldr	x1, [x8, #0x9c8] ; oRoomHistoryStat
104ea12e4: 94b61796    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea12e8: aa1d03fd    	mov	x29, x29
104ea12ec: 94b61797    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea12f0: aa0003f9    	mov	x25, x0
104ea12f4: 900d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea12f8: f946dd01    	ldr	x1, [x8, #0xdb8] ; cancelShareReport
104ea12fc: 94b61790    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1300: aa1903e0    	mov	x0, x25
104ea1304: 94b61794    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1308: aa1803e0    	mov	x0, x24
104ea130c: 94b61792    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1310: aa1703e0    	mov	x0, x23
104ea1314: 94b61790    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1318: b00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea131c: b9886908    	ldrsw	x8, [x8, #0x868]
104ea1320: f8686a60    	ldr	x0, [x19, x8]
104ea1324: d00d9308    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104ea1328: f946e901    	ldr	x1, [x8, #0xdd0] ; length
104ea132c: 94b61784    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1330: b4000340    	cbz	x0, 0x104ea1398 <_Flutter_MMFoundation_BindContext+0x137cf7c>
104ea1334: f945eb60    	ldr	x0, [x27, #0xbd0]
104ea1338: aa1403e1    	mov	x1, x20
104ea133c: 94b61780    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1340: aa1d03fd    	mov	x29, x29
104ea1344: 94b61781    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1348: aa0003f8    	mov	x24, x0
104ea134c: f9411780    	ldr	x0, [x28, #0x228]
104ea1350: aa1503e1    	mov	x1, x21
104ea1354: 94b6177a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1358: aa0003e2    	mov	x2, x0
104ea135c: aa1803e0    	mov	x0, x24
104ea1360: aa1603e1    	mov	x1, x22
104ea1364: 94b61776    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1368: aa1d03fd    	mov	x29, x29
104ea136c: 94b61777    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1370: aa0003f9    	mov	x25, x0
104ea1374: d00d9308    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104ea1378: f9430917    	ldr	x23, [x8, #0x610] ; invalidate
104ea137c: aa1703e1    	mov	x1, x23
104ea1380: 94b6176f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1384: aa1903e0    	mov	x0, x25
104ea1388: 94b61773    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea138c: aa1803e0    	mov	x0, x24
104ea1390: 94b61771    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1394: 14000003    	b	0x104ea13a0 <_Flutter_MMFoundation_BindContext+0x137cf84>
104ea1398: d00d9308    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104ea139c: f9430917    	ldr	x23, [x8, #0x610] ; invalidate
104ea13a0: f945eb60    	ldr	x0, [x27, #0xbd0]
104ea13a4: aa1403e1    	mov	x1, x20
104ea13a8: 94b61765    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea13ac: aa1d03fd    	mov	x29, x29
104ea13b0: 94b61766    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea13b4: aa0003f4    	mov	x20, x0
104ea13b8: f00d9688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104ea13bc: f9412900    	ldr	x0, [x8, #0x250] ; HA8
104ea13c0: aa1503e1    	mov	x1, x21
104ea13c4: 94b6175e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea13c8: aa0003e2    	mov	x2, x0
104ea13cc: aa1403e0    	mov	x0, x20
104ea13d0: aa1603e1    	mov	x1, x22
104ea13d4: 94b6175a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea13d8: aa1d03fd    	mov	x29, x29
104ea13dc: 94b6175b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea13e0: aa0003f5    	mov	x21, x0
104ea13e4: aa1703e1    	mov	x1, x23
104ea13e8: 94b61755    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea13ec: aa1503e0    	mov	x0, x21
104ea13f0: 94b61759    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea13f4: aa1403e0    	mov	x0, x20
104ea13f8: 94b61757    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea13fc: 900d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea1400: f9469901    	ldr	x1, [x8, #0xd30] ; m_bSearchSnsContact
104ea1404: aa1303e0    	mov	x0, x19
104ea1408: 94b6174d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea140c: 340000c0    	cbz	w0, 0x104ea1424 <_Flutter_MMFoundation_BindContext+0x137d008>
104ea1410: d00d7cc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104ea1414: f9463101    	ldr	x1, [x8, #0xc60] ; DismissMyselfAnimated:
104ea1418: aa1303e0    	mov	x0, x19
104ea141c: 52800022    	mov	w2, #0x1                ; =1
104ea1420: 14000069    	b	0x104ea15c4 <_Flutter_MMFoundation_BindContext+0x137d1a8>
104ea1424: b00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea1428: b9885918    	ldrsw	x24, [x8, #0x858]
104ea142c: 8b180260    	add	x0, x19, x24
104ea1430: 94b61757    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea1434: b00d9339    	adrp	x25, 0x120106000 <dyld_stub_binder+0x120106000>
104ea1438: b4000300    	cbz	x0, 0x104ea1498 <_Flutter_MMFoundation_BindContext+0x137d07c>
104ea143c: aa0003f5    	mov	x21, x0
104ea1440: 8b180260    	add	x0, x19, x24
104ea1444: 94b61752    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea1448: aa0003f6    	mov	x22, x0
104ea144c: b00d7da8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104ea1450: f942b114    	ldr	x20, [x8, #0x560] ; onMultiSelectContactReturn:
104ea1454: f9436321    	ldr	x1, [x25, #0x6c0] ; respondsToSelector:
104ea1458: aa1403e2    	mov	x2, x20
104ea145c: 94b61738    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1460: aa0003f7    	mov	x23, x0
104ea1464: aa1603e0    	mov	x0, x22
104ea1468: 94b6173b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea146c: aa1503e0    	mov	x0, x21
104ea1470: 94b61739    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1474: 34000137    	cbz	w23, 0x104ea1498 <_Flutter_MMFoundation_BindContext+0x137d07c>
104ea1478: 8b180260    	add	x0, x19, x24
104ea147c: 94b61744    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea1480: aa0003f5    	mov	x21, x0
104ea1484: aa1403e1    	mov	x1, x20
104ea1488: d2800002    	mov	x2, #0x0                ; =0
104ea148c: 94b6172c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1490: aa1503e0    	mov	x0, x21
104ea1494: 94b61730    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1498: 8b180260    	add	x0, x19, x24
104ea149c: 94b6173c    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea14a0: b40002e0    	cbz	x0, 0x104ea14fc <_Flutter_MMFoundation_BindContext+0x137d0e0>
104ea14a4: aa0003f5    	mov	x21, x0
104ea14a8: 8b180260    	add	x0, x19, x24
104ea14ac: 94b61738    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea14b0: aa0003f6    	mov	x22, x0
104ea14b4: 900d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea14b8: f946e114    	ldr	x20, [x8, #0xdc0] ; onMultiSelectContactCancelForSns
104ea14bc: f9436321    	ldr	x1, [x25, #0x6c0] ; respondsToSelector:
104ea14c0: aa1403e2    	mov	x2, x20
104ea14c4: 94b6171e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea14c8: aa0003f7    	mov	x23, x0
104ea14cc: aa1603e0    	mov	x0, x22
104ea14d0: 94b61721    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea14d4: aa1503e0    	mov	x0, x21
104ea14d8: 94b6171f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea14dc: 34000117    	cbz	w23, 0x104ea14fc <_Flutter_MMFoundation_BindContext+0x137d0e0>
104ea14e0: 8b180260    	add	x0, x19, x24
104ea14e4: 94b6172a    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104ea14e8: aa0003f5    	mov	x21, x0
104ea14ec: aa1403e1    	mov	x1, x20
104ea14f0: 94b61713    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea14f4: aa1503e0    	mov	x0, x21
104ea14f8: 94b61717    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea14fc: b00d7f48    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
104ea1500: f9400d01    	ldr	x1, [x8, #0x18] ; reportBizType
104ea1504: aa1303e0    	mov	x0, x19
104ea1508: 94b6170d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea150c: b4000540    	cbz	x0, 0x104ea15b4 <_Flutter_MMFoundation_BindContext+0x137d198>
104ea1510: b00d7d48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104ea1514: f940cd01    	ldr	x1, [x8, #0x198] ; pageSheetAdapter
104ea1518: aa1303e0    	mov	x0, x19
104ea151c: 94b61708    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1520: aa1d03fd    	mov	x29, x29
104ea1524: 94b61709    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea1528: aa0003f4    	mov	x20, x0
104ea152c: 94b6170a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1530: b5000434    	cbnz	x20, 0x104ea15b4 <_Flutter_MMFoundation_BindContext+0x137d198>
104ea1534: b00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea1538: b9881508    	ldrsw	x8, [x8, #0x814]
104ea153c: f8686a60    	ldr	x0, [x19, x8]
104ea1540: f00d92e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104ea1544: f9435101    	ldr	x1, [x8, #0x6a0] ; count
104ea1548: 94b616fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea154c: aa0003f4    	mov	x20, x0
104ea1550: 900d7f48    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
104ea1554: f9435901    	ldr	x1, [x8, #0x6b0] ; isRemovingMember
104ea1558: aa1303e0    	mov	x0, x19
104ea155c: 94b616f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1560: 340001c0    	cbz	w0, 0x104ea1598 <_Flutter_MMFoundation_BindContext+0x137d17c>
104ea1564: f87a6a60    	ldr	x0, [x19, x26]
104ea1568: f00d7e88    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
104ea156c: f946e101    	ldr	x1, [x8, #0xdc0] ; m_contactsDataLogic
104ea1570: 94b616f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1574: aa1d03fd    	mov	x29, x29
104ea1578: 94b616f4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea157c: aa0003f5    	mov	x21, x0
104ea1580: f00d7e88    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
104ea1584: f9444101    	ldr	x1, [x8, #0x880] ; getContactCount
104ea1588: 94b616ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea158c: 2a0003f4    	mov	w20, w0
104ea1590: aa1503e0    	mov	x0, x21
104ea1594: 94b616f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1598: 900d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea159c: f946e501    	ldr	x1, [x8, #0xdc8] ; endDataReportSessionWithDone:originCount:submitCount:
104ea15a0: aa1303e0    	mov	x0, x19
104ea15a4: 52800002    	mov	w2, #0x0                ; =0
104ea15a8: aa1403e3    	mov	x3, x20
104ea15ac: d2800004    	mov	x4, #0x0                ; =0
104ea15b0: 94b616e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea15b4: 900d7f08    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
104ea15b8: f946bd01    	ldr	x1, [x8, #0xd78] ; doMultiSelectContactsInChatRoomReportWithExitScene:
104ea15bc: aa1303e0    	mov	x0, x19
104ea15c0: 52800042    	mov	w2, #0x2                ; =2
104ea15c4: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104ea15c8: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104ea15cc: a94357f6    	ldp	x22, x21, [sp, #0x30]
104ea15d0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104ea15d4: a94167fa    	ldp	x26, x25, [sp, #0x10]
104ea15d8: a8c66ffc    	ldp	x28, x27, [sp], #0x60
104ea15dc: 14b616d8    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
