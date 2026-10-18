
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1099940a0: d10283ff    	sub	sp, sp, #0xa0
1099940a4: a9046ffc    	stp	x28, x27, [sp, #0x40]
1099940a8: a90567fa    	stp	x26, x25, [sp, #0x50]
1099940ac: a9065ff8    	stp	x24, x23, [sp, #0x60]
1099940b0: a90757f6    	stp	x22, x21, [sp, #0x70]
1099940b4: a9084ff4    	stp	x20, x19, [sp, #0x80]
1099940b8: a9097bfd    	stp	x29, x30, [sp, #0x90]
1099940bc: 910243fd    	add	x29, sp, #0x90
1099940c0: aa0003f3    	mov	x19, x0
1099940c4: f00b95c8    	adrp	x8, 0x120c4f000 <dyld_stub_binder+0x120c4f000>
1099940c8: 52800029    	mov	w9, #0x1                ; =1
1099940cc: 39356509    	strb	w9, [x8, #0xd59]
1099940d0: d00b41e8    	adrp	x8, 0x1201d2000 <dyld_stub_binder+0x1201d2000>
1099940d4: f9478108    	ldr	x8, [x8, #0xf00]
1099940d8: a90323e0    	stp	x0, x8, [sp, #0x30]
1099940dc: f00b25a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1099940e0: f940a901    	ldr	x1, [x8, #0x150] ; startLogic
1099940e4: 9100c3e0    	add	x0, sp, #0x30
1099940e8: 957b1cd9    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
1099940ec: b00b40a8    	adrp	x8, 0x1201a9000 <dyld_stub_binder+0x1201a9000>
1099940f0: f947ed00    	ldr	x0, [x8, #0xfd8]
1099940f4: f00b3b48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1099940f8: f947ad14    	ldr	x20, [x8, #0xf58] ; class
1099940fc: aa1403e1    	mov	x1, x20
109994100: 957b1cd1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994104: aa0003e2    	mov	x2, x0
109994108: 900b46a8    	adrp	x8, 0x120268000 <dyld_stub_binder+0x120268000>
10999410c: 91264108    	add	x8, x8, #0x990
109994110: b9800115    	ldrsw	x21, [x8]
109994114: f8756a63    	ldr	x3, [x19, x21]
109994118: f00b29a8    	adrp	x8, 0x11fecb000 <dyld_stub_binder+0x11fecb000>
10999411c: f946c901    	ldr	x1, [x8, #0xd90] ; gotoViewController:withData:
109994120: aa1303e0    	mov	x0, x19
109994124: 957b1cc8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994128: aa1d03fd    	mov	x29, x29
10999412c: 957b1cd0    	bl	0x10f85b46c <_UR_96F1_B25D+0x3a640dc>
109994130: d00b4568    	adrp	x8, 0x120242000 <dyld_stub_binder+0x120242000>
109994134: 910e1108    	add	x8, x8, #0x384
109994138: b9800108    	ldrsw	x8, [x8]
10999413c: 52800069    	mov	w9, #0x3                ; =3
109994140: b8286a69    	str	w9, [x19, x8]
109994144: f8756a60    	ldr	x0, [x19, x21]
109994148: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
10999414c: f945b119    	ldr	x25, [x8, #0xb60] ; setM_isOpenIM:
109994150: aa1903e1    	mov	x1, x25
109994154: 52800002    	mov	w2, #0x0                ; =0
109994158: 957b1cbb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999415c: f00b3ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109994160: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
109994164: 900b3b68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109994168: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10999416c: f90013e1    	str	x1, [sp, #0x20]
109994170: 957b1cb5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994174: aa1d03fd    	mov	x29, x29
109994178: 957b1cb6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999417c: aa0003fb    	mov	x27, x0
109994180: 900b3f17    	adrp	x23, 0x120174000 <dyld_stub_binder+0x120174000>
109994184: f94016e0    	ldr	x0, [x23, #0x28] ; P;, 
109994188: f90017f4    	str	x20, [sp, #0x28]
10999418c: aa1403e1    	mov	x1, x20
109994190: 957b1cad    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994194: aa0003e2    	mov	x2, x0
109994198: b00b2528    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10999419c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1099941a0: aa1b03e0    	mov	x0, x27
1099941a4: f9000fe1    	str	x1, [sp, #0x18]
1099941a8: 957b1ca7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099941ac: aa1d03fd    	mov	x29, x29
1099941b0: 957b1ca8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099941b4: aa0003fc    	mov	x28, x0
1099941b8: f8756a60    	ldr	x0, [x19, x21]
1099941bc: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
1099941c0: f9459d1a    	ldr	x26, [x8, #0xb38] ; m_nsCurrentUserName
1099941c4: aa1a03e1    	mov	x1, x26
1099941c8: 957b1c9f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099941cc: aa1d03fd    	mov	x29, x29
1099941d0: 957b1ca0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099941d4: aa0003f4    	mov	x20, x0
1099941d8: 900b2548    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1099941dc: f940c916    	ldr	x22, [x8, #0x190] ; getContactByName:
1099941e0: aa1c03e0    	mov	x0, x28
1099941e4: aa1603e1    	mov	x1, x22
1099941e8: aa1403e2    	mov	x2, x20
1099941ec: 957b1c96    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099941f0: aa1d03fd    	mov	x29, x29
1099941f4: 957b1c97    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099941f8: aa0003f8    	mov	x24, x0
1099941fc: aa1403e0    	mov	x0, x20
109994200: 957b1c97    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994204: aa1c03e0    	mov	x0, x28
109994208: 957b1c95    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999420c: aa1b03e0    	mov	x0, x27
109994210: 957b1c93    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994214: f00b2528    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
109994218: f947491b    	ldr	x27, [x8, #0xe90] ; isOpenImContact
10999421c: f9000bf8    	str	x24, [sp, #0x10]
109994220: aa1803e0    	mov	x0, x24
109994224: aa1b03e1    	mov	x1, x27
109994228: 957b1c87    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999422c: f00b3ef4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
109994230: b00b2538    	adrp	x24, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109994234: 34000280    	cbz	w0, 0x109994284 <_Flutter_MMFoundation_BindContext+0x5e6fe68>
109994238: f8756a60    	ldr	x0, [x19, x21]
10999423c: aa1903e1    	mov	x1, x25
109994240: 52800022    	mov	w2, #0x1                ; =1
109994244: 957b1c80    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994248: f9453680    	ldr	x0, [x20, #0xa68] ; �gH 
10999424c: f942ab01    	ldr	x1, [x24, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
109994250: d00a83e8    	adrp	x8, 0x11ea12000 <dyld_stub_binder+0x11ea12000>
109994254: 913aa108    	add	x8, x8, #0xea8 ; CFSTR Receiver ControllLogic, fromContact is OpenIM user
109994258: f90003e8    	str	x8, [sp]
10999425c: 9008c5e3    	adrp	x3, 0x11b250000 <dyld_stub_binder+0x11b250000>
109994260: 912b9063    	add	x3, x3, #0xae4
109994264: b00918e5    	adrp	x5, 0x11bcb1000 <dyld_stub_binder+0x11bcb1000>
109994268: 911188a5    	add	x5, x5, #0x462
10999426c: b00918e7    	adrp	x7, 0x11bcb1000 <dyld_stub_binder+0x11bcb1000>
109994270: 911238e7    	add	x7, x7, #0x48e
109994274: 52800042    	mov	w2, #0x2                ; =2
109994278: 52800004    	mov	w4, #0x0                ; =0
10999427c: 52800926    	mov	w6, #0x49               ; =73
109994280: 957b1c71    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994284: f00b3ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109994288: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10999428c: f94013e1    	ldr	x1, [sp, #0x20]
109994290: 957b1c6d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994294: aa1d03fd    	mov	x29, x29
109994298: 957b1c6e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999429c: aa0003f4    	mov	x20, x0
1099942a0: f94016e0    	ldr	x0, [x23, #0x28] ; P;, 
1099942a4: f94017e1    	ldr	x1, [sp, #0x28]
1099942a8: 957b1c67    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099942ac: aa0003e2    	mov	x2, x0
1099942b0: aa1403e0    	mov	x0, x20
1099942b4: f9400fe1    	ldr	x1, [sp, #0x18]
1099942b8: 957b1c63    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099942bc: aa1d03fd    	mov	x29, x29
1099942c0: 957b1c64    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099942c4: aa0003fc    	mov	x28, x0
1099942c8: f8756a60    	ldr	x0, [x19, x21]
1099942cc: f00b3768    	adrp	x8, 0x120083000 <dyld_stub_binder+0x120083000>
1099942d0: f9461501    	ldr	x1, [x8, #0xc28] ; m_receiverUserName
1099942d4: 957b1c5c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099942d8: aa1d03fd    	mov	x29, x29
1099942dc: 957b1c5d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099942e0: aa0003f7    	mov	x23, x0
1099942e4: aa1c03e0    	mov	x0, x28
1099942e8: aa1603e1    	mov	x1, x22
1099942ec: aa1703e2    	mov	x2, x23
1099942f0: 957b1c55    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099942f4: aa1d03fd    	mov	x29, x29
1099942f8: 957b1c56    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099942fc: aa0003f6    	mov	x22, x0
109994300: aa1703e0    	mov	x0, x23
109994304: 957b1c56    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994308: aa1c03e0    	mov	x0, x28
10999430c: 957b1c54    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994310: aa1403e0    	mov	x0, x20
109994314: 957b1c52    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994318: aa1603e0    	mov	x0, x22
10999431c: aa1b03e1    	mov	x1, x27
109994320: 957b1c49    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994324: 340002a0    	cbz	w0, 0x109994378 <_Flutter_MMFoundation_BindContext+0x5e6ff5c>
109994328: f8756a60    	ldr	x0, [x19, x21]
10999432c: aa1903e1    	mov	x1, x25
109994330: 52800022    	mov	w2, #0x1                ; =1
109994334: 957b1c44    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994338: f00b3ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10999433c: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
109994340: f942ab01    	ldr	x1, [x24, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
109994344: d00a83e8    	adrp	x8, 0x11ea12000 <dyld_stub_binder+0x11ea12000>
109994348: 913b2108    	add	x8, x8, #0xec8 ; CFSTR Receiver ControllLogic, receiverContact is OpenIM user
10999434c: f90003e8    	str	x8, [sp]
109994350: 9008c5e3    	adrp	x3, 0x11b250000 <dyld_stub_binder+0x11b250000>
109994354: 912b9063    	add	x3, x3, #0xae4
109994358: b00918e5    	adrp	x5, 0x11bcb1000 <dyld_stub_binder+0x11bcb1000>
10999435c: 911188a5    	add	x5, x5, #0x462
109994360: b00918e7    	adrp	x7, 0x11bcb1000 <dyld_stub_binder+0x11bcb1000>
109994364: 911238e7    	add	x7, x7, #0x48e
109994368: 52800042    	mov	w2, #0x2                ; =2
10999436c: 52800004    	mov	w4, #0x0                ; =0
109994370: 528009c6    	mov	w6, #0x4e               ; =78
109994374: 957b1c34    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994378: f8756a60    	ldr	x0, [x19, x21]
10999437c: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994380: f9458901    	ldr	x1, [x8, #0xb10] ; m_isOpenIM
109994384: 957b1c30    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994388: aa0003e2    	mov	x2, x0
10999438c: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994390: f945b501    	ldr	x1, [x8, #0xb68] ; setBIsOpenIM:
109994394: aa1303e0    	mov	x0, x19
109994398: 957b1c2b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999439c: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
1099943a0: f945b901    	ldr	x1, [x8, #0xb70] ; bIsOpenIM
1099943a4: aa1303e0    	mov	x0, x19
1099943a8: 957b1c27    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099943ac: 34000780    	cbz	w0, 0x10999449c <_Flutter_MMFoundation_BindContext+0x5e70080>
1099943b0: b00b40a8    	adrp	x8, 0x1201a9000 <dyld_stub_binder+0x1201a9000>
1099943b4: f947f100    	ldr	x0, [x8, #0xfe0]
1099943b8: 957b1c2a    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
1099943bc: aa0003f9    	mov	x25, x0
1099943c0: f8756a60    	ldr	x0, [x19, x21]
1099943c4: b00b25c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
1099943c8: f9409901    	ldr	x1, [x8, #0x130] ; m_nsTransferID
1099943cc: 957b1c1e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099943d0: aa1d03fd    	mov	x29, x29
1099943d4: 957b1c1f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099943d8: aa0003f4    	mov	x20, x0
1099943dc: d00b3748    	adrp	x8, 0x12007e000 <dyld_stub_binder+0x12007e000>
1099943e0: f9478901    	ldr	x1, [x8, #0xf10] ; setTransferId:
1099943e4: aa1903e0    	mov	x0, x25
1099943e8: aa1403e2    	mov	x2, x20
1099943ec: 957b1c16    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099943f0: aa1403e0    	mov	x0, x20
1099943f4: 957b1c1a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099943f8: f8756a60    	ldr	x0, [x19, x21]
1099943fc: b00b29e8    	adrp	x8, 0x11fed1000 <dyld_stub_binder+0x11fed1000>
109994400: f941dd01    	ldr	x1, [x8, #0x3b8] ; selectedTransferChatroomUsername
109994404: 957b1c10    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994408: aa1d03fd    	mov	x29, x29
10999440c: 957b1c11    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994410: aa0003f4    	mov	x20, x0
109994414: b00b2708    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
109994418: f942a901    	ldr	x1, [x8, #0x550] ; setRoomid:
10999441c: aa1903e0    	mov	x0, x25
109994420: aa1403e2    	mov	x2, x20
109994424: 957b1c08    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994428: aa1403e0    	mov	x0, x20
10999442c: 957b1c0c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994430: b00b40a8    	adrp	x8, 0x1201a9000 <dyld_stub_binder+0x1201a9000>
109994434: f947f500    	ldr	x0, [x8, #0xfe8] ; 0GE 
109994438: 957b1c0c    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10999443c: 900b2548    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109994440: f942a101    	ldr	x1, [x8, #0x540] ; initWithDelegate:
109994444: aa1303e2    	mov	x2, x19
109994448: 957b1bff    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999444c: aa0003f4    	mov	x20, x0
109994450: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994454: f945bd01    	ldr	x1, [x8, #0xb78] ; setUnionQueryCgi:
109994458: aa1303e0    	mov	x0, x19
10999445c: aa1403e2    	mov	x2, x20
109994460: 957b1bf9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994464: aa1403e0    	mov	x0, x20
109994468: 957b1bfd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999446c: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994470: f945c101    	ldr	x1, [x8, #0xb80] ; unionQueryCgi
109994474: aa1303e0    	mov	x0, x19
109994478: 957b1bf3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999447c: aa1d03fd    	mov	x29, x29
109994480: 957b1bf4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994484: aa0003f7    	mov	x23, x0
109994488: b00b28c8    	adrp	x8, 0x11fead000 <dyld_stub_binder+0x11fead000>
10999448c: f946fd01    	ldr	x1, [x8, #0xdf8] ; startWithRequest:
109994490: aa1903e2    	mov	x2, x25
109994494: 957b1bec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994498: 14000092    	b	0x1099946e0 <_Flutter_MMFoundation_BindContext+0x5e702c4>
10999449c: b00b40a8    	adrp	x8, 0x1201a9000 <dyld_stub_binder+0x1201a9000>
1099944a0: f947f900    	ldr	x0, [x8, #0xff0] ; (�D 
1099944a4: 957b1bef    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
1099944a8: aa0003f9    	mov	x25, x0
1099944ac: f8756a60    	ldr	x0, [x19, x21]
1099944b0: b00b25c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
1099944b4: f9409901    	ldr	x1, [x8, #0x130] ; m_nsTransferID
1099944b8: 957b1be3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099944bc: aa1d03fd    	mov	x29, x29
1099944c0: 957b1be4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099944c4: aa0003f4    	mov	x20, x0
1099944c8: b00b25c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
1099944cc: f9409d01    	ldr	x1, [x8, #0x138] ; setM_nsTransferID:
1099944d0: aa1903e0    	mov	x0, x25
1099944d4: aa1403e2    	mov	x2, x20
1099944d8: 957b1bdb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099944dc: aa1403e0    	mov	x0, x20
1099944e0: 957b1bdf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099944e4: f8756a60    	ldr	x0, [x19, x21]
1099944e8: aa1a03e1    	mov	x1, x26
1099944ec: 957b1bd6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099944f0: aa1d03fd    	mov	x29, x29
1099944f4: 957b1bd7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099944f8: aa0003f4    	mov	x20, x0
1099944fc: f00b3328    	adrp	x8, 0x11fffb000 <dyld_stub_binder+0x11fffb000>
109994500: f9426101    	ldr	x1, [x8, #0x4c0] ; setM_nsFromUserName:
109994504: aa1903e0    	mov	x0, x25
109994508: aa1403e2    	mov	x2, x20
10999450c: 957b1bce    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994510: aa1403e0    	mov	x0, x20
109994514: 957b1bd2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994518: f8756a60    	ldr	x0, [x19, x21]
10999451c: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994520: f945a101    	ldr	x1, [x8, #0xb40] ; m_uiTransferInvalidTime
109994524: f90007e1    	str	x1, [sp, #0x8]
109994528: 957b1bc7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999452c: aa0003e2    	mov	x2, x0
109994530: d00b3728    	adrp	x8, 0x12007a000 <dyld_stub_binder+0x12007a000>
109994534: f943c114    	ldr	x20, [x8, #0x780] ; setM_uiInvalidTime:
109994538: aa1903e0    	mov	x0, x25
10999453c: aa1403e1    	mov	x1, x20
109994540: 957b1bc1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994544: f8756a60    	ldr	x0, [x19, x21]
109994548: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
10999454c: f9459917    	ldr	x23, [x8, #0xb30] ; m_nsControlTransationID
109994550: aa1703e1    	mov	x1, x23
109994554: 957b1bbc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994558: aa1d03fd    	mov	x29, x29
10999455c: 957b1bbd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994560: aa0003fb    	mov	x27, x0
109994564: d00b3748    	adrp	x8, 0x12007e000 <dyld_stub_binder+0x12007e000>
109994568: f9438d1c    	ldr	x28, [x8, #0x718] ; setM_nsTransactionID:
10999456c: aa1903e0    	mov	x0, x25
109994570: aa1c03e1    	mov	x1, x28
109994574: aa1b03e2    	mov	x2, x27
109994578: 957b1bb3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999457c: aa1b03e0    	mov	x0, x27
109994580: 957b1bb7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994584: f8756a60    	ldr	x0, [x19, x21]
109994588: b00b29e8    	adrp	x8, 0x11fed1000 <dyld_stub_binder+0x11fed1000>
10999458c: f941dd1b    	ldr	x27, [x8, #0x3b8] ; selectedTransferChatroomUsername
109994590: aa1b03e1    	mov	x1, x27
109994594: 957b1bac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994598: aa1d03fd    	mov	x29, x29
10999459c: 957b1bad    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099945a0: aa1603fa    	mov	x26, x22
1099945a4: aa0003f6    	mov	x22, x0
1099945a8: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
1099945ac: f945c518    	ldr	x24, [x8, #0xb88] ; setGroup_username:
1099945b0: aa1903e0    	mov	x0, x25
1099945b4: aa1803e1    	mov	x1, x24
1099945b8: aa1603e2    	mov	x2, x22
1099945bc: 957b1ba2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099945c0: aa1603e0    	mov	x0, x22
1099945c4: aa1a03f6    	mov	x22, x26
1099945c8: 957b1ba5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099945cc: f8756a60    	ldr	x0, [x19, x21]
1099945d0: f94007e1    	ldr	x1, [sp, #0x8]
1099945d4: 957b1b9c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099945d8: aa0003e2    	mov	x2, x0
1099945dc: aa1903e0    	mov	x0, x25
1099945e0: aa1403e1    	mov	x1, x20
1099945e4: 957b1b98    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099945e8: f8756a60    	ldr	x0, [x19, x21]
1099945ec: aa1703e1    	mov	x1, x23
1099945f0: 957b1b95    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099945f4: aa1d03fd    	mov	x29, x29
1099945f8: 957b1b96    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099945fc: aa0003f4    	mov	x20, x0
109994600: aa1903e0    	mov	x0, x25
109994604: aa1c03e1    	mov	x1, x28
109994608: aa1403e2    	mov	x2, x20
10999460c: 957b1b8e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994610: aa1403e0    	mov	x0, x20
109994614: 957b1b92    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994618: f8756a60    	ldr	x0, [x19, x21]
10999461c: aa1b03e1    	mov	x1, x27
109994620: 957b1b89    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994624: aa1d03fd    	mov	x29, x29
109994628: 957b1b8a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999462c: aa0003f4    	mov	x20, x0
109994630: aa1903e0    	mov	x0, x25
109994634: aa1803e1    	mov	x1, x24
109994638: aa1403e2    	mov	x2, x20
10999463c: 957b1b82    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994640: aa1403e0    	mov	x0, x20
109994644: 957b1b86    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994648: f8756a60    	ldr	x0, [x19, x21]
10999464c: f00b3748    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
109994650: f9454901    	ldr	x1, [x8, #0xa90] ; m_nsTransferAttach
109994654: 957b1b7c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994658: aa1d03fd    	mov	x29, x29
10999465c: 957b1b7d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994660: aa0003f4    	mov	x20, x0
109994664: b00b25c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
109994668: f940e101    	ldr	x1, [x8, #0x1c0] ; setM_nsTransferAttach:
10999466c: aa1903e0    	mov	x0, x25
109994670: aa1403e2    	mov	x2, x20
109994674: 957b1b74    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994678: aa1403e0    	mov	x0, x20
10999467c: 957b1b78    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994680: f00b3ee8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109994684: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
109994688: f94013e1    	ldr	x1, [sp, #0x20]
10999468c: 957b1b6e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994690: aa1d03fd    	mov	x29, x29
109994694: 957b1b6f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994698: aa0003f7    	mov	x23, x0
10999469c: d00b3f08    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1099946a0: f943bd00    	ldr	x0, [x8, #0x778] ; ��D 
1099946a4: f94017e1    	ldr	x1, [sp, #0x28]
1099946a8: 957b1b67    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099946ac: aa0003e2    	mov	x2, x0
1099946b0: aa1703e0    	mov	x0, x23
1099946b4: f9400fe1    	ldr	x1, [sp, #0x18]
1099946b8: 957b1b63    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099946bc: aa1d03fd    	mov	x29, x29
1099946c0: 957b1b64    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099946c4: aa0003f4    	mov	x20, x0
1099946c8: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
1099946cc: f945c901    	ldr	x1, [x8, #0xb90] ; CheckTransferMoneyStatus:
1099946d0: aa1903e2    	mov	x2, x25
1099946d4: 957b1b5c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099946d8: aa1403e0    	mov	x0, x20
1099946dc: 957b1b60    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099946e0: aa1703e0    	mov	x0, x23
1099946e4: 957b1b5e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099946e8: aa1903e0    	mov	x0, x25
1099946ec: 957b1b5c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099946f0: d00b3ba8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1099946f4: f9452101    	ldr	x1, [x8, #0xa40] ; startLoading
1099946f8: aa1303e0    	mov	x0, x19
1099946fc: 957b1b52    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994700: aa1603e0    	mov	x0, x22
109994704: 957b1b56    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994708: f9400be0    	ldr	x0, [sp, #0x10]
10999470c: 957b1b54    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994710: a9497bfd    	ldp	x29, x30, [sp, #0x90]
109994714: a9484ff4    	ldp	x20, x19, [sp, #0x80]
109994718: a94757f6    	ldp	x22, x21, [sp, #0x70]
10999471c: a9465ff8    	ldp	x24, x23, [sp, #0x60]
109994720: a94567fa    	ldp	x26, x25, [sp, #0x50]
109994724: a9446ffc    	ldp	x28, x27, [sp, #0x40]
109994728: 910283ff    	add	sp, sp, #0xa0
10999472c: d65f03c0    	ret