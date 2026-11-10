
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae11b4: d10243ff    	sub	sp, sp, #0x90
105ae11b8: a9036ffc    	stp	x28, x27, [sp, #0x30]
105ae11bc: a90467fa    	stp	x26, x25, [sp, #0x40]
105ae11c0: a9055ff8    	stp	x24, x23, [sp, #0x50]
105ae11c4: a90657f6    	stp	x22, x21, [sp, #0x60]
105ae11c8: a9074ff4    	stp	x20, x19, [sp, #0x70]
105ae11cc: a9087bfd    	stp	x29, x30, [sp, #0x80]
105ae11d0: 910203fd    	add	x29, sp, #0x80
105ae11d4: aa0203f3    	mov	x19, x2
105ae11d8: f90003e0    	str	x0, [sp]
105ae11dc: f00ce388    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
105ae11e0: 52800029    	mov	w9, #0x1                ; =1
105ae11e4: 3932b109    	strb	w9, [x8, #0xcac]
105ae11e8: aa0203e0    	mov	x0, x2
105ae11ec: 94851aa2    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae11f0: 900c8e48    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105ae11f4: f9418d01    	ldr	x1, [x8, #0x318]
105ae11f8: f90007f3    	str	x19, [sp, #0x8]
105ae11fc: aa1303e0    	mov	x0, x19
105ae1200: 94851a99    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1204: aa0003f4    	mov	x20, x0
105ae1208: d00c9188    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
105ae120c: f944bd00    	ldr	x0, [x8, #0x978]
105ae1210: f00c7768    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
105ae1214: f9470101    	ldr	x1, [x8, #0xe00]
105ae1218: 94851a93    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae121c: aa1d03fd    	mov	x29, x29
105ae1220: 94851a98    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae1224: aa0003f6    	mov	x22, x0
105ae1228: b00c8e28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae122c: f944291b    	ldr	x27, [x8, #0x850]
105ae1230: aa1403e0    	mov	x0, x20
105ae1234: aa1b03e1    	mov	x1, x27
105ae1238: 94851a8b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae123c: b4000de0    	cbz	x0, 0x105ae13f8 <_Flutter_MMFoundation_BindContext+0x1d680c4>
105ae1240: a901ffff    	stp	xzr, xzr, [sp, #0x18]
105ae1244: d280001c    	mov	x28, #0x0               ; =0
105ae1248: f90017ff    	str	xzr, [sp, #0x28]
105ae124c: f9000bff    	str	xzr, [sp, #0x10]
105ae1250: b00c7748    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
105ae1254: f941b113    	ldr	x19, [x8, #0x360]
105ae1258: b00c8e28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae125c: f9428515    	ldr	x21, [x8, #0x508]
105ae1260: f00c8e28    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
105ae1264: f9444917    	ldr	x23, [x8, #0x890]
105ae1268: d00c7768    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
105ae126c: f9439518    	ldr	x24, [x8, #0x728]
105ae1270: 900c8e28    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
105ae1274: f944f919    	ldr	x25, [x8, #0x9f0]
105ae1278: aa1403e0    	mov	x0, x20
105ae127c: aa1303e1    	mov	x1, x19
105ae1280: aa1c03e2    	mov	x2, x28
105ae1284: 94851a78    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1288: aa1d03fd    	mov	x29, x29
105ae128c: 94851a7d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae1290: aa0003fa    	mov	x26, x0
105ae1294: d00c9188    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
105ae1298: f9431d00    	ldr	x0, [x8, #0x638]
105ae129c: aa1503e1    	mov	x1, x21
105ae12a0: 94851a71    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae12a4: aa0003e2    	mov	x2, x0
105ae12a8: aa1a03e0    	mov	x0, x26
105ae12ac: aa1703e1    	mov	x1, x23
105ae12b0: 94851a6d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae12b4: 34000900    	cbz	w0, 0x105ae13d4 <_Flutter_MMFoundation_BindContext+0x1d680a0>
105ae12b8: aa1a03e0    	mov	x0, x26
105ae12bc: aa1803e1    	mov	x1, x24
105ae12c0: 94851a69    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae12c4: f100141f    	cmp	x0, #0x5
105ae12c8: 54000141    	b.ne	0x105ae12f0 <_Flutter_MMFoundation_BindContext+0x1d67fbc>
105ae12cc: aa1603e0    	mov	x0, x22
105ae12d0: aa1903e1    	mov	x1, x25
105ae12d4: aa1c03e2    	mov	x2, x28
105ae12d8: 94851a63    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae12dc: aa1a03e0    	mov	x0, x26
105ae12e0: 94851a65    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae12e4: f94013e0    	ldr	x0, [sp, #0x20]
105ae12e8: 94851a62    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae12ec: f90013fa    	str	x26, [sp, #0x20]
105ae12f0: aa1a03e0    	mov	x0, x26
105ae12f4: aa1803e1    	mov	x1, x24
105ae12f8: 94851a5b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae12fc: f100101f    	cmp	x0, #0x4
105ae1300: 54000141    	b.ne	0x105ae1328 <_Flutter_MMFoundation_BindContext+0x1d67ff4>
105ae1304: aa1603e0    	mov	x0, x22
105ae1308: aa1903e1    	mov	x1, x25
105ae130c: aa1c03e2    	mov	x2, x28
105ae1310: 94851a55    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1314: aa1a03e0    	mov	x0, x26
105ae1318: 94851a57    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae131c: f9400fe0    	ldr	x0, [sp, #0x18]
105ae1320: 94851a54    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae1324: f9000ffa    	str	x26, [sp, #0x18]
105ae1328: aa1a03e0    	mov	x0, x26
105ae132c: aa1803e1    	mov	x1, x24
105ae1330: 94851a4d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1334: f100201f    	cmp	x0, #0x8
105ae1338: 54000141    	b.ne	0x105ae1360 <_Flutter_MMFoundation_BindContext+0x1d6802c>
105ae133c: aa1603e0    	mov	x0, x22
105ae1340: aa1903e1    	mov	x1, x25
105ae1344: aa1c03e2    	mov	x2, x28
105ae1348: 94851a47    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae134c: aa1a03e0    	mov	x0, x26
105ae1350: 94851a49    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae1354: f9400be0    	ldr	x0, [sp, #0x10]
105ae1358: 94851a46    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae135c: f9000bfa    	str	x26, [sp, #0x10]
105ae1360: aa1a03e0    	mov	x0, x26
105ae1364: aa1803e1    	mov	x1, x24
105ae1368: 94851a3f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae136c: f100b81f    	cmp	x0, #0x2e
105ae1370: 54000200    	b.eq	0x105ae13b0 <_Flutter_MMFoundation_BindContext+0x1d6807c>
105ae1374: aa1a03e0    	mov	x0, x26
105ae1378: aa1803e1    	mov	x1, x24
105ae137c: 94851a3a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1380: f100bc1f    	cmp	x0, #0x2f
105ae1384: 54000160    	b.eq	0x105ae13b0 <_Flutter_MMFoundation_BindContext+0x1d6807c>
105ae1388: aa1a03e0    	mov	x0, x26
105ae138c: aa1803e1    	mov	x1, x24
105ae1390: 94851a35    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1394: f100e41f    	cmp	x0, #0x39
105ae1398: 540000c0    	b.eq	0x105ae13b0 <_Flutter_MMFoundation_BindContext+0x1d6807c>
105ae139c: aa1a03e0    	mov	x0, x26
105ae13a0: aa1803e1    	mov	x1, x24
105ae13a4: 94851a30    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae13a8: f100e81f    	cmp	x0, #0x3a
105ae13ac: 54000141    	b.ne	0x105ae13d4 <_Flutter_MMFoundation_BindContext+0x1d680a0>
105ae13b0: aa1603e0    	mov	x0, x22
105ae13b4: aa1903e1    	mov	x1, x25
105ae13b8: aa1c03e2    	mov	x2, x28
105ae13bc: 94851a2a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae13c0: aa1a03e0    	mov	x0, x26
105ae13c4: 94851a2c    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae13c8: f94017e0    	ldr	x0, [sp, #0x28]
105ae13cc: 94851a29    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae13d0: f90017fa    	str	x26, [sp, #0x28]
105ae13d4: aa1a03e0    	mov	x0, x26
105ae13d8: 94851a26    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae13dc: 9100079c    	add	x28, x28, #0x1
105ae13e0: aa1403e0    	mov	x0, x20
105ae13e4: aa1b03e1    	mov	x1, x27
105ae13e8: 94851a1f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae13ec: eb00039f    	cmp	x28, x0
105ae13f0: 54000082    	b.hs	0x105ae1400 <_Flutter_MMFoundation_BindContext+0x1d680cc>
105ae13f4: 17ffffa1    	b	0x105ae1278 <_Flutter_MMFoundation_BindContext+0x1d67f44>
105ae13f8: a9017fff    	stp	xzr, xzr, [sp, #0x10]
105ae13fc: a9027fff    	stp	xzr, xzr, [sp, #0x20]
105ae1400: d00c7d88    	adrp	x8, 0x11ea93000 <dyld_stub_binder+0x11ea93000>
105ae1404: f9471901    	ldr	x1, [x8, #0xe30]
105ae1408: aa1603e0    	mov	x0, x22
105ae140c: 94851a16    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1410: 92f00018    	mov	x24, #0x7fffffffffffffff ; =9223372036854775807
105ae1414: eb18001f    	cmp	x0, x24
105ae1418: 54000220    	b.eq	0x105ae145c <_Flutter_MMFoundation_BindContext+0x1d68128>
105ae141c: aa0003f3    	mov	x19, x0
105ae1420: b00c7748    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
105ae1424: f9433515    	ldr	x21, [x8, #0x668]
105ae1428: f00c8368    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae142c: f943d917    	ldr	x23, [x8, #0x7b0]
105ae1430: aa1403e0    	mov	x0, x20
105ae1434: aa1503e1    	mov	x1, x21
105ae1438: aa1303e2    	mov	x2, x19
105ae143c: 94851a0a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1440: aa1603e0    	mov	x0, x22
105ae1444: aa1703e1    	mov	x1, x23
105ae1448: aa1303e2    	mov	x2, x19
105ae144c: 94851a06    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1450: aa0003f3    	mov	x19, x0
105ae1454: eb18001f    	cmp	x0, x24
105ae1458: 54fffec1    	b.ne	0x105ae1430 <_Flutter_MMFoundation_BindContext+0x1d680fc>
105ae145c: f00c8368    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105ae1460: f943dd13    	ldr	x19, [x8, #0x7b8]
105ae1464: f94003f5    	ldr	x21, [sp]
105ae1468: aa1503e0    	mov	x0, x21
105ae146c: aa1303e1    	mov	x1, x19
105ae1470: f9400bf8    	ldr	x24, [sp, #0x10]
105ae1474: aa1803e2    	mov	x2, x24
105ae1478: aa1403e3    	mov	x3, x20
105ae147c: 52800064    	mov	w4, #0x3                ; =3
105ae1480: 948519f9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1484: aa1503e0    	mov	x0, x21
105ae1488: aa1303e1    	mov	x1, x19
105ae148c: f9400ff7    	ldr	x23, [sp, #0x18]
105ae1490: aa1703e2    	mov	x2, x23
105ae1494: aa1403e3    	mov	x3, x20
105ae1498: 52800064    	mov	w4, #0x3                ; =3
105ae149c: 948519f2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae14a0: aa1503e0    	mov	x0, x21
105ae14a4: aa1303e1    	mov	x1, x19
105ae14a8: f94013f5    	ldr	x21, [sp, #0x20]
105ae14ac: aa1503e2    	mov	x2, x21
105ae14b0: aa1403e3    	mov	x3, x20
105ae14b4: 52800084    	mov	w4, #0x4                ; =4
105ae14b8: 948519eb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae14bc: b00c7748    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
105ae14c0: f942c101    	ldr	x1, [x8, #0x580]
105ae14c4: aa1403e0    	mov	x0, x20
105ae14c8: f94017f9    	ldr	x25, [sp, #0x28]
105ae14cc: aa1903e2    	mov	x2, x25
105ae14d0: 948519e5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae14d4: b00c8e28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae14d8: f9440d01    	ldr	x1, [x8, #0x818]
105ae14dc: aa1403e0    	mov	x0, x20
105ae14e0: 948519e1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae14e4: aa0003f3    	mov	x19, x0
105ae14e8: aa1603e0    	mov	x0, x22
105ae14ec: 948519e1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae14f0: aa1903e0    	mov	x0, x25
105ae14f4: 948519df    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae14f8: aa1803e0    	mov	x0, x24
105ae14fc: 948519dd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae1500: aa1703e0    	mov	x0, x23
105ae1504: 948519db    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae1508: aa1503e0    	mov	x0, x21
105ae150c: 948519d9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae1510: aa1403e0    	mov	x0, x20
105ae1514: 948519d7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae1518: f94007e0    	ldr	x0, [sp, #0x8]
105ae151c: 948519d5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae1520: aa1303e0    	mov	x0, x19
105ae1524: a9487bfd    	ldp	x29, x30, [sp, #0x80]
105ae1528: a9474ff4    	ldp	x20, x19, [sp, #0x70]
105ae152c: a94657f6    	ldp	x22, x21, [sp, #0x60]
105ae1530: a9455ff8    	ldp	x24, x23, [sp, #0x50]
105ae1534: a94467fa    	ldp	x26, x25, [sp, #0x40]
105ae1538: a9436ffc    	ldp	x28, x27, [sp, #0x30]
105ae153c: 910243ff    	add	sp, sp, #0x90
105ae1540: 148519b8    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
