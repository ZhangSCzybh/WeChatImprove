
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175f12ec: d101c3ff    	sub	sp, sp, #0x70
1175f12f0: a90267fa    	stp	x26, x25, [sp, #0x20]
1175f12f4: a9035ff8    	stp	x24, x23, [sp, #0x30]
1175f12f8: a90457f6    	stp	x22, x21, [sp, #0x40]
1175f12fc: a9054ff4    	stp	x20, x19, [sp, #0x50]
1175f1300: a9067bfd    	stp	x29, x30, [sp, #0x60]
1175f1304: 910183fd    	add	x29, sp, #0x60
1175f1308: aa0203f3    	mov	x19, x2
1175f130c: aa0203e0    	mov	x0, x2
1175f1310: 9434e298    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175f1314: d0045888    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1175f1318: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1175f131c: aa1303e0    	mov	x0, x19
1175f1320: 9434e273    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1324: b40008a0    	cbz	x0, 0x1175f1438 <_O266DecReleaseOutputPicture+0x4364980>
1175f1328: 90045c28    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1175f132c: f9420900    	ldr	x0, [x8, #0x410]
1175f1330: f0045868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1175f1334: f946dd01    	ldr	x1, [x8, #0xdb8] ; defaultManager
1175f1338: d2800014    	mov	x20, #0x0               ; =0
1175f133c: 9434e26c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1340: aa1d03fd    	mov	x29, x29
1175f1344: 9434e294    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175f1348: aa0003f6    	mov	x22, x0
1175f134c: f9000fff    	str	xzr, [sp, #0x18]
1175f1350: b00458a8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1175f1354: f9411101    	ldr	x1, [x8, #0x220] ; removeItemAtPath:error:
1175f1358: 910063e3    	add	x3, sp, #0x18
1175f135c: aa1303e2    	mov	x2, x19
1175f1360: 9434e263    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1364: aa0003f5    	mov	x21, x0
1175f1368: f9400ff4    	ldr	x20, [sp, #0x18]
1175f136c: aa1403e0    	mov	x0, x20
1175f1370: 9434e280    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175f1374: aa1603e0    	mov	x0, x22
1175f1378: 9434e278    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f137c: 36000635    	tbz	w21, #0x0, 0x1175f1440 <_O266DecReleaseOutputPicture+0x4364988>
1175f1380: 52800020    	mov	w0, #0x1                ; =1
1175f1384: 97fe3657    	bl	0x11757ece0 <_O266DecReleaseOutputPicture+0x42f2228>
1175f1388: 340006a0    	cbz	w0, 0x1175f145c <_O266DecReleaseOutputPicture+0x43649a4>
1175f138c: 9434e210    	bl	0x118329bcc <dyld_stub_binder+0x118329bcc>
1175f1390: aa0003f5    	mov	x21, x0
1175f1394: d0045c17    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1175f1398: f94546e0    	ldr	x0, [x23, #0xa88]
1175f139c: 9434e1f7    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
1175f13a0: aa0003f6    	mov	x22, x0
1175f13a4: f94546e0    	ldr	x0, [x23, #0xa88]
1175f13a8: b00458c8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1175f13ac: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1175f13b0: a9007ff3    	stp	x19, xzr, [sp]
1175f13b4: 9003acc2    	adrp	x2, 0x11eb89000 <dyld_stub_binder+0x11eb89000>
1175f13b8: 911e2042    	add	x2, x2, #0x788
1175f13bc: 9434e24c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f13c0: aa1d03fd    	mov	x29, x29
1175f13c4: 9434e274    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175f13c8: aa0003f7    	mov	x23, x0
1175f13cc: b0045888    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1175f13d0: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
1175f13d4: 90038da8    	adrp	x8, 0x11e7a5000 <dyld_stub_binder+0x11e7a5000>
1175f13d8: 9100a108    	add	x8, x8, #0x28
1175f13dc: a90003e8    	stp	x8, x0, [sp]
1175f13e0: d0037542    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1175f13e4: 9134a042    	add	x2, x2, #0xd28
1175f13e8: aa1603e0    	mov	x0, x22
1175f13ec: 9434e240    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f13f0: aa0003f6    	mov	x22, x0
1175f13f4: aa1703e0    	mov	x0, x23
1175f13f8: 9434e258    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f13fc: f001e821    	adrp	x1, 0x11b2f8000 <dyld_stub_binder+0x11b2f8000>
1175f1400: 911c9821    	add	x1, x1, #0x726
1175f1404: d0029d42    	adrp	x2, 0x11c99b000 <dyld_stub_binder+0x11c99b000>
1175f1408: 91230c42    	add	x2, x2, #0x8c3
1175f140c: f0029d44    	adrp	x4, 0x11c99c000 <dyld_stub_binder+0x11c99c000>
1175f1410: 9103d484    	add	x4, x4, #0xf5
1175f1414: 52800020    	mov	w0, #0x1                ; =1
1175f1418: 52809d03    	mov	w3, #0x4e8              ; =1256
1175f141c: aa1603e5    	mov	x5, x22
1175f1420: 97fe363d    	bl	0x11757ed14 <_O266DecReleaseOutputPicture+0x42f225c>
1175f1424: aa1603e0    	mov	x0, x22
1175f1428: 9434e24c    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f142c: aa1503e0    	mov	x0, x21
1175f1430: 9434e1e4    	bl	0x118329bc0 <dyld_stub_binder+0x118329bc0>
1175f1434: 1400000a    	b	0x1175f145c <_O266DecReleaseOutputPicture+0x43649a4>
1175f1438: 52800035    	mov	w21, #0x1               ; =1
1175f143c: 14000049    	b	0x1175f1560 <_O266DecReleaseOutputPicture+0x4364aa8>
1175f1440: f0045868    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1175f1444: f9404115    	ldr	x21, [x8, #0x80] ; code
1175f1448: aa1403e0    	mov	x0, x20
1175f144c: aa1503e1    	mov	x1, x21
1175f1450: 9434e227    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1454: f100101f    	cmp	x0, #0x4
1175f1458: 54000061    	b.ne	0x1175f1464 <_O266DecReleaseOutputPicture+0x43649ac>
1175f145c: 52800035    	mov	w21, #0x1               ; =1
1175f1460: 1400003e    	b	0x1175f1558 <_O266DecReleaseOutputPicture+0x4364aa0>
1175f1464: 52800080    	mov	w0, #0x4                ; =4
1175f1468: 97fe361e    	bl	0x11757ece0 <_O266DecReleaseOutputPicture+0x42f2228>
1175f146c: 340006c0    	cbz	w0, 0x1175f1544 <_O266DecReleaseOutputPicture+0x4364a8c>
1175f1470: 9434e1d7    	bl	0x118329bcc <dyld_stub_binder+0x118329bcc>
1175f1474: aa0003f6    	mov	x22, x0
1175f1478: d0045c17    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1175f147c: f94546e0    	ldr	x0, [x23, #0xa88]
1175f1480: 9434e1be    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
1175f1484: aa0003f8    	mov	x24, x0
1175f1488: f94546f9    	ldr	x25, [x23, #0xa88]
1175f148c: d0045888    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1175f1490: f947f901    	ldr	x1, [x8, #0xff0] ; localizedDescription
1175f1494: aa1403e0    	mov	x0, x20
1175f1498: 9434e215    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f149c: aa1d03fd    	mov	x29, x29
1175f14a0: 9434e23d    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175f14a4: aa0003f7    	mov	x23, x0
1175f14a8: b00458c8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1175f14ac: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1175f14b0: a900ffe0    	stp	x0, xzr, [sp, #0x8]
1175f14b4: f90003f3    	str	x19, [sp]
1175f14b8: d003a7a2    	adrp	x2, 0x11eae7000 <dyld_stub_binder+0x11eae7000>
1175f14bc: 9122a042    	add	x2, x2, #0x8a8
1175f14c0: aa1903e0    	mov	x0, x25
1175f14c4: 9434e20a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f14c8: aa1d03fd    	mov	x29, x29
1175f14cc: 9434e232    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175f14d0: aa0003f9    	mov	x25, x0
1175f14d4: b0045888    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1175f14d8: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
1175f14dc: d0037548    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1175f14e0: 91362108    	add	x8, x8, #0xd88
1175f14e4: a90003e8    	stp	x8, x0, [sp]
1175f14e8: d0037542    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1175f14ec: 9134a042    	add	x2, x2, #0xd28
1175f14f0: aa1803e0    	mov	x0, x24
1175f14f4: 9434e1fe    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f14f8: aa0003f8    	mov	x24, x0
1175f14fc: aa1903e0    	mov	x0, x25
1175f1500: 9434e216    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1504: aa1703e0    	mov	x0, x23
1175f1508: 9434e214    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f150c: f001e821    	adrp	x1, 0x11b2f8000 <dyld_stub_binder+0x11b2f8000>
1175f1510: 911c9821    	add	x1, x1, #0x726
1175f1514: d0029d42    	adrp	x2, 0x11c99b000 <dyld_stub_binder+0x11c99b000>
1175f1518: 91230c42    	add	x2, x2, #0x8c3
1175f151c: f0029d44    	adrp	x4, 0x11c99c000 <dyld_stub_binder+0x11c99c000>
1175f1520: 9103d484    	add	x4, x4, #0xf5
1175f1524: 52800080    	mov	w0, #0x4                ; =4
1175f1528: 52809c83    	mov	w3, #0x4e4              ; =1252
1175f152c: aa1803e5    	mov	x5, x24
1175f1530: 97fe35f9    	bl	0x11757ed14 <_O266DecReleaseOutputPicture+0x42f225c>
1175f1534: aa1803e0    	mov	x0, x24
1175f1538: 9434e208    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f153c: aa1603e0    	mov	x0, x22
1175f1540: 9434e1a0    	bl	0x118329bc0 <dyld_stub_binder+0x118329bc0>
1175f1544: aa1403e0    	mov	x0, x20
1175f1548: aa1503e1    	mov	x1, x21
1175f154c: 9434e1e8    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175f1550: 97ffe87e    	bl	0x1175eb748 <_O266DecReleaseOutputPicture+0x435ec90>
1175f1554: 52800015    	mov	w21, #0x0               ; =0
1175f1558: aa1403e0    	mov	x0, x20
1175f155c: 9434e1ff    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1560: aa1303e0    	mov	x0, x19
1175f1564: 9434e1fd    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f1568: aa1503e0    	mov	x0, x21
1175f156c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1175f1570: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1175f1574: a94457f6    	ldp	x22, x21, [sp, #0x40]
1175f1578: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1175f157c: a94267fa    	ldp	x26, x25, [sp, #0x20]
1175f1580: 9101c3ff    	add	sp, sp, #0x70
1175f1584: d65f03c0    	ret
1175f1588: aa0003f5    	mov	x21, x0
1175f158c: aa1803e0    	mov	x0, x24
1175f1590: 1400000b    	b	0x1175f15bc <_O266DecReleaseOutputPicture+0x4364b04>
1175f1594: aa0003f5    	mov	x21, x0
1175f1598: aa1903e0    	mov	x0, x25
1175f159c: 9434e1ef    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f15a0: 14000006    	b	0x1175f15b8 <_O266DecReleaseOutputPicture+0x4364b00>
1175f15a4: 14000004    	b	0x1175f15b4 <_O266DecReleaseOutputPicture+0x4364afc>
1175f15a8: aa0003f5    	mov	x21, x0
1175f15ac: aa1603e0    	mov	x0, x22
1175f15b0: 14000003    	b	0x1175f15bc <_O266DecReleaseOutputPicture+0x4364b04>
1175f15b4: aa0003f5    	mov	x21, x0
1175f15b8: aa1703e0    	mov	x0, x23
1175f15bc: 9434e1e7    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f15c0: 14000009    	b	0x1175f15e4 <_O266DecReleaseOutputPicture+0x4364b2c>
1175f15c4: 14000007    	b	0x1175f15e0 <_O266DecReleaseOutputPicture+0x4364b28>
1175f15c8: 14000006    	b	0x1175f15e0 <_O266DecReleaseOutputPicture+0x4364b28>
1175f15cc: aa0003f5    	mov	x21, x0
1175f15d0: aa1603f4    	mov	x20, x22
1175f15d4: 14000004    	b	0x1175f15e4 <_O266DecReleaseOutputPicture+0x4364b2c>
1175f15d8: aa0003f5    	mov	x21, x0
1175f15dc: 14000004    	b	0x1175f15ec <_O266DecReleaseOutputPicture+0x4364b34>
1175f15e0: aa0003f5    	mov	x21, x0
1175f15e4: aa1403e0    	mov	x0, x20
1175f15e8: 9434e1dc    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f15ec: aa1303e0    	mov	x0, x19
1175f15f0: 9434e1da    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175f15f4: aa1503e0    	mov	x0, x21
1175f15f8: 9434ca83    	bl	0x118324004 <dyld_stub_binder+0x118324004>
