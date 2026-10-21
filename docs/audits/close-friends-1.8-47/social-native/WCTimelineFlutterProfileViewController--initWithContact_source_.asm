
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a124450: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
10a124454: a90167fa    	stp	x26, x25, [sp, #0x10]
10a124458: a9025ff8    	stp	x24, x23, [sp, #0x20]
10a12445c: a90357f6    	stp	x22, x21, [sp, #0x30]
10a124460: a9044ff4    	stp	x20, x19, [sp, #0x40]
10a124464: a9057bfd    	stp	x29, x30, [sp, #0x50]
10a124468: 910143fd    	add	x29, sp, #0x50
10a12446c: d10703ff    	sub	sp, sp, #0x1c0
10a124470: aa0303fa    	mov	x26, x3
10a124474: aa0203f9    	mov	x25, x2
10a124478: aa0003fc    	mov	x28, x0
10a12447c: f009a648    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a124480: f9405908    	ldr	x8, [x8, #0xb0]
10a124484: f9400108    	ldr	x8, [x8]
10a124488: f81a03a8    	stur	x8, [x29, #-0x60]
10a12448c: b00b5968    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a124490: 52800029    	mov	w9, #0x1                ; =1
10a124494: 3917b109    	strb	w9, [x8, #0x5ec]
10a124498: aa0203e0    	mov	x0, x2
10a12449c: 955cdbe9    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a1244a0: aa1a03e0    	mov	x0, x26
10a1244a4: 955cdbe7    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a1244a8: b00b0288    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10a1244ac: f9434d00    	ldr	x0, [x8, #0x698]
10a1244b0: 955cdbee    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a1244b4: aa0003f3    	mov	x19, x0
10a1244b8: b00b0288    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10a1244bc: f9435100    	ldr	x0, [x8, #0x6a0]
10a1244c0: 900ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a1244c4: f944b901    	ldr	x1, [x8, #0x970] ; defaultGroup
10a1244c8: 955cdbdf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1244cc: aa1d03fd    	mov	x29, x29
10a1244d0: 955cdbe0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1244d4: aa0003f4    	mov	x20, x0
10a1244d8: 900ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a1244dc: f944bd01    	ldr	x1, [x8, #0x978] ; initWithEngineGroup:plugin:
10a1244e0: f00a1c23    	adrp	x3, 0x11e4ab000 <dyld_stub_binder+0x11e4ab000>
10a1244e4: 9109a063    	add	x3, x3, #0x268
10a1244e8: aa1303e0    	mov	x0, x19
10a1244ec: aa1403e2    	mov	x2, x20
10a1244f0: 955cdbd5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1244f4: f90053e0    	str	x0, [sp, #0xa0]
10a1244f8: aa1403e0    	mov	x0, x20
10a1244fc: 955cdbd8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124500: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a124504: f945e900    	ldr	x0, [x8, #0xbd0]
10a124508: 900afee8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a12450c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a124510: 955cdbcd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124514: aa1d03fd    	mov	x29, x29
10a124518: 955cdbce    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a12451c: aa0003f3    	mov	x19, x0
10a124520: b00b02e8    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
10a124524: f9418d00    	ldr	x0, [x8, #0x318]
10a124528: f00afec8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a12452c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a124530: 955cdbc5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124534: aa0003e2    	mov	x2, x0
10a124538: b00ae8a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a12453c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a124540: aa1303e0    	mov	x0, x19
10a124544: 955cdbc0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124548: aa1d03fd    	mov	x29, x29
10a12454c: 955cdbc1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124550: aa0003f4    	mov	x20, x0
10a124554: 900ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a124558: f9437501    	ldr	x1, [x8, #0x6e8] ; getSessionId
10a12455c: 955cdbba    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124560: aa1d03fd    	mov	x29, x29
10a124564: 955cdbbb    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124568: aa0003f5    	mov	x21, x0
10a12456c: aa1403e0    	mov	x0, x20
10a124570: 955cdbbb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124574: aa1303e0    	mov	x0, x19
10a124578: 955cdbb9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12457c: f00afee8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a124580: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10a124584: aa1503e0    	mov	x0, x21
10a124588: 955cdbaf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a12458c: b50002a0    	cbnz	x0, 0x10a1245e0 <_Flutter_MMFoundation_BindContext+0x66001c4>
10a124590: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a124594: f9454513    	ldr	x19, [x8, #0xa88]
10a124598: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a12459c: f9467900    	ldr	x0, [x8, #0xcf0]
10a1245a0: 900ae8e8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10a1245a4: f942c501    	ldr	x1, [x8, #0x588] ; genCurrentTimeInMsFrom1970
10a1245a8: 955cdba7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1245ac: d00aff28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a1245b0: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
10a1245b4: f90003e0    	str	x0, [sp]
10a1245b8: d00a48e2    	adrp	x2, 0x11ea42000 <dyld_stub_binder+0x11ea42000>
10a1245bc: 913e2042    	add	x2, x2, #0xf88
10a1245c0: aa1303e0    	mov	x0, x19
10a1245c4: 955cdba0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1245c8: aa1d03fd    	mov	x29, x29
10a1245cc: 955cdba1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1245d0: aa0003f3    	mov	x19, x0
10a1245d4: aa1503e0    	mov	x0, x21
10a1245d8: 955cdba1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1245dc: aa1303f5    	mov	x21, x19
10a1245e0: f00a1d08    	adrp	x8, 0x11e4c7000 <dyld_stub_binder+0x11e4c7000>
10a1245e4: 910ba108    	add	x8, x8, #0x2e8
10a1245e8: f81403a8    	stur	x8, [x29, #-0xc0]
10a1245ec: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a1245f0: f9471100    	ldr	x0, [x8, #0xe20]
10a1245f4: b00ae8c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a1245f8: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
10a1245fc: 955cdb92    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124600: aa1d03fd    	mov	x29, x29
10a124604: 955cdb93    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124608: aa0003f4    	mov	x20, x0
10a12460c: f81703a0    	stur	x0, [x29, #-0x90]
10a124610: f00a48e8    	adrp	x8, 0x11ea43000 <dyld_stub_binder+0x11ea43000>
10a124614: 9107a108    	add	x8, x8, #0x1e8
10a124618: f81483a8    	stur	x8, [x29, #-0xb8]
10a12461c: f00ae8a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a124620: f9434d13    	ldr	x19, [x8, #0x698] ; m_nsUsrName
10a124624: aa1903e0    	mov	x0, x25
10a124628: aa1303e1    	mov	x1, x19
10a12462c: 955cdb86    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124630: aa1d03fd    	mov	x29, x29
10a124634: 955cdb87    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124638: aa0003fb    	mov	x27, x0
10a12463c: f81783a0    	stur	x0, [x29, #-0x88]
10a124640: d00a1e08    	adrp	x8, 0x11e4e6000 <dyld_stub_binder+0x11e4e6000>
10a124644: 91282108    	add	x8, x8, #0xa08
10a124648: f81503a8    	stur	x8, [x29, #-0xb0]
10a12464c: 900ae8c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a124650: f946d501    	ldr	x1, [x8, #0xda8] ; m_nsSignature
10a124654: aa1903e0    	mov	x0, x25
10a124658: 955cdb7b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a12465c: aa1d03fd    	mov	x29, x29
10a124660: 955cdb7c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124664: aa0003f7    	mov	x23, x0
10a124668: f9002ff9    	str	x25, [sp, #0x58]
10a12466c: f00a1bb6    	adrp	x22, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10a124670: 910322d6    	add	x22, x22, #0xc8
10a124674: f100001f    	cmp	x0, #0x0
10a124678: 9a8002c8    	csel	x8, x22, x0, eq
10a12467c: d00a48e9    	adrp	x9, 0x11ea42000 <dyld_stub_binder+0x11ea42000>
10a124680: 913ea129    	add	x9, x9, #0xfa8
10a124684: f81803a8    	stur	x8, [x29, #-0x80]
10a124688: f81583a9    	stur	x9, [x29, #-0xa8]
10a12468c: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a124690: f9458900    	ldr	x0, [x8, #0xb10]
10a124694: 900aff08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a124698: f9479501    	ldr	x1, [x8, #0xf28] ; numberWithBool:
10a12469c: 52800002    	mov	w2, #0x0                ; =0
10a1246a0: 955cdb69    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1246a4: aa1d03fd    	mov	x29, x29
10a1246a8: 955cdb6a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1246ac: aa0003f8    	mov	x24, x0
10a1246b0: d00a48e8    	adrp	x8, 0x11ea42000 <dyld_stub_binder+0x11ea42000>
10a1246b4: 913f2108    	add	x8, x8, #0xfc8
10a1246b8: a938d7a0    	stp	x0, x21, [x29, #-0x78]
10a1246bc: a9096bf5    	stp	x21, x26, [sp, #0x90]
10a1246c0: b00a2529    	adrp	x9, 0x11e5c9000 <dyld_stub_binder+0x11e5c9000>
10a1246c4: 9126a129    	add	x9, x9, #0x9a8
10a1246c8: a93627a8    	stp	x8, x9, [x29, #-0xa0]
10a1246cc: f100035f    	cmp	x26, #0x0
10a1246d0: 9a9a02c8    	csel	x8, x22, x26, eq
10a1246d4: f81983a8    	stur	x8, [x29, #-0x68]
10a1246d8: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a1246dc: f9457500    	ldr	x0, [x8, #0xae8]
10a1246e0: b00afee8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a1246e4: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
10a1246e8: d10243a2    	sub	x2, x29, #0x90
10a1246ec: d10303a3    	sub	x3, x29, #0xc0
10a1246f0: 528000c4    	mov	w4, #0x6                ; =6
10a1246f4: 955cdb54    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1246f8: aa1d03fd    	mov	x29, x29
10a1246fc: 955cdb55    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124700: aa0003f5    	mov	x21, x0
10a124704: aa1803e0    	mov	x0, x24
10a124708: 955cdb55    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12470c: aa1703e0    	mov	x0, x23
10a124710: 955cdb53    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124714: aa1b03e0    	mov	x0, x27
10a124718: 955cdb51    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12471c: aa1403e0    	mov	x0, x20
10a124720: 955cdb4f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124724: 900ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a124728: f944c101    	ldr	x1, [x8, #0x980] ; push:arguments:
10a12472c: 900a2522    	adrp	x2, 0x11e5c8000 <dyld_stub_binder+0x11e5c8000>
10a124730: 913ba042    	add	x2, x2, #0xee8
10a124734: f94053e0    	ldr	x0, [sp, #0xa0]
10a124738: f90047f5    	str	x21, [sp, #0x88]
10a12473c: aa1503e3    	mov	x3, x21
10a124740: 955cdb41    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124744: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a124748: f9453514    	ldr	x20, [x8, #0xa68]
10a12474c: aa1903e0    	mov	x0, x25
10a124750: aa1303e1    	mov	x1, x19
10a124754: 955cdb3c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124758: aa1d03fd    	mov	x29, x29
10a12475c: 955cdb3d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124760: aa0003f3    	mov	x19, x0
10a124764: b00ae8a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a124768: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a12476c: f00a48e8    	adrp	x8, 0x11ea43000 <dyld_stub_binder+0x11ea43000>
10a124770: 91082108    	add	x8, x8, #0x208
10a124774: a90003e8    	stp	x8, x0, [sp]
10a124778: b008df45    	adrp	x5, 0x11bd0d000 <dyld_stub_binder+0x11bd0d000>
10a12477c: 911b9ca5    	add	x5, x5, #0x6e7
10a124780: b008df47    	adrp	x7, 0x11bd0d000 <dyld_stub_binder+0x11bd0d000>
10a124784: 911c44e7    	add	x7, x7, #0x711
10a124788: aa1403e0    	mov	x0, x20
10a12478c: 52800042    	mov	w2, #0x2                ; =2
10a124790: d2800003    	mov	x3, #0x0                ; =0
10a124794: 52800004    	mov	w4, #0x0                ; =0
10a124798: 528035a6    	mov	w6, #0x1ad              ; =429
10a12479c: 955cdb2a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1247a0: aa1303e0    	mov	x0, x19
10a1247a4: 955cdb2e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1247a8: f00b0368    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a1247ac: f9432900    	ldr	x0, [x8, #0x650]
10a1247b0: 955cdb2c    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1247b4: aa0003f4    	mov	x20, x0
10a1247b8: f00aff08    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a1247bc: f9451513    	ldr	x19, [x8, #0xa28] ; setDelegate:
10a1247c0: aa1303e1    	mov	x1, x19
10a1247c4: aa1c03f8    	mov	x24, x28
10a1247c8: f9001bfc    	str	x28, [sp, #0x30]
10a1247cc: aa1c03e2    	mov	x2, x28
10a1247d0: 955cdb1d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1247d4: d00b0428    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
10a1247d8: f9429500    	ldr	x0, [x8, #0x528]
10a1247dc: 955cdb21    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1247e0: aa0003f6    	mov	x22, x0
10a1247e4: aa1303e1    	mov	x1, x19
10a1247e8: aa1c03e2    	mov	x2, x28
10a1247ec: 955cdb16    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1247f0: b00b02a8    	adrp	x8, 0x120179000 <dyld_stub_binder+0x120179000>
10a1247f4: f940d500    	ldr	x0, [x8, #0x1a8]
10a1247f8: 955cdb1a    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1247fc: aa0003f7    	mov	x23, x0
10a124800: aa1303e1    	mov	x1, x19
10a124804: aa1c03e2    	mov	x2, x28
10a124808: 955cdb0f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a12480c: f00b0435    	adrp	x21, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124810: f942b2a0    	ldr	x0, [x21, #0x560]
10a124814: 955cdb13    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124818: aa0003fa    	mov	x26, x0
10a12481c: aa1303e1    	mov	x1, x19
10a124820: aa1c03e2    	mov	x2, x28
10a124824: 955cdb08    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124828: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a12482c: f942b500    	ldr	x0, [x8, #0x568]
10a124830: 955cdb0c    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124834: aa0003f9    	mov	x25, x0
10a124838: aa1303e1    	mov	x1, x19
10a12483c: aa1c03e2    	mov	x2, x28
10a124840: 955cdb01    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124844: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124848: f942b900    	ldr	x0, [x8, #0x570]
10a12484c: 955cdb05    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124850: f90013e0    	str	x0, [sp, #0x20]
10a124854: aa1303e1    	mov	x1, x19
10a124858: aa1c03e2    	mov	x2, x28
10a12485c: 955cdafa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124860: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124864: f942bd00    	ldr	x0, [x8, #0x578]
10a124868: 955cdafe    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a12486c: aa0003fb    	mov	x27, x0
10a124870: aa1303e1    	mov	x1, x19
10a124874: aa1c03e2    	mov	x2, x28
10a124878: 955cdaf3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a12487c: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124880: f942c100    	ldr	x0, [x8, #0x580] ; Hx.
10a124884: 955cdaf7    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124888: aa0003fc    	mov	x28, x0
10a12488c: aa1303e1    	mov	x1, x19
10a124890: aa1803e2    	mov	x2, x24
10a124894: 955cdaec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124898: d00b0288    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a12489c: f946fd00    	ldr	x0, [x8, #0xdf8]
10a1248a0: 955cdaf0    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1248a4: f90027e0    	str	x0, [sp, #0x48]
10a1248a8: f9005fe0    	str	x0, [sp, #0xb8]
10a1248ac: f00b0368    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a1248b0: f9431100    	ldr	x0, [x8, #0x620]
10a1248b4: 955cdaeb    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1248b8: f90023e0    	str	x0, [sp, #0x40]
10a1248bc: f90063e0    	str	x0, [sp, #0xc0]
10a1248c0: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a1248c4: f9429900    	ldr	x0, [x8, #0x530] ; Xw.
10a1248c8: 955cdae6    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1248cc: f9001fe0    	str	x0, [sp, #0x38]
10a1248d0: a90cd3e0    	stp	x0, x20, [sp, #0xc8]
10a1248d4: f90043f4    	str	x20, [sp, #0x80]
10a1248d8: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a1248dc: f9429d00    	ldr	x0, [x8, #0x538]
10a1248e0: 955cdae0    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1248e4: f90017e0    	str	x0, [sp, #0x28]
10a1248e8: a90ddfe0    	stp	x0, x23, [sp, #0xd8]
10a1248ec: f9003bf7    	str	x23, [sp, #0x70]
10a1248f0: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a1248f4: f942a100    	ldr	x0, [x8, #0x540]
10a1248f8: 955cdada    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1248fc: f9000fe0    	str	x0, [sp, #0x18]
10a124900: f90077e0    	str	x0, [sp, #0xe8]
10a124904: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124908: f942a500    	ldr	x0, [x8, #0x548]
10a12490c: 955cdad5    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124910: aa0003f8    	mov	x24, x0
10a124914: a90f5be0    	stp	x0, x22, [sp, #0xf0]
10a124918: f9003ff6    	str	x22, [sp, #0x78]
10a12491c: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124920: f942a900    	ldr	x0, [x8, #0x550] ; 8y.
10a124924: 955cdacf    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124928: aa0003f4    	mov	x20, x0
10a12492c: f90083e0    	str	x0, [sp, #0x100]
10a124930: d00b02c8    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
10a124934: f947d100    	ldr	x0, [x8, #0xfa0]
10a124938: 955cdaca    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a12493c: aa0003f7    	mov	x23, x0
10a124940: f90087e0    	str	x0, [sp, #0x108]
10a124944: f942b2a0    	ldr	x0, [x21, #0x560]
10a124948: 955cdac6    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a12494c: aa0003f3    	mov	x19, x0
10a124950: f9008be0    	str	x0, [sp, #0x110]
10a124954: f00b0288    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
10a124958: f940e900    	ldr	x0, [x8, #0x1d0]
10a12495c: d00ae968    	adrp	x8, 0x11fe52000 <dyld_stub_binder+0x11fe52000>
10a124960: f9413101    	ldr	x1, [x8, #0x260] ; plugin
10a124964: 955cdab8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124968: aa1d03fd    	mov	x29, x29
10a12496c: 955cdab9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124970: aa0003f5    	mov	x21, x0
10a124974: a911ebe0    	stp	x0, x26, [sp, #0x118]
10a124978: a9066bf9    	stp	x25, x26, [sp, #0x60]
10a12497c: f94013fa    	ldr	x26, [sp, #0x20]
10a124980: a912ebf9    	stp	x25, x26, [sp, #0x128]
10a124984: a913f3fb    	stp	x27, x28, [sp, #0x138]
10a124988: f9002bfc    	str	x28, [sp, #0x50]
10a12498c: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124990: f942ad00    	ldr	x0, [x8, #0x558]
10a124994: 955cdab3    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124998: aa0003f6    	mov	x22, x0
10a12499c: f900a7e0    	str	x0, [sp, #0x148]
10a1249a0: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a1249a4: f9456d00    	ldr	x0, [x8, #0xad8]
10a1249a8: f00afec8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a1249ac: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
10a1249b0: 9102e3e2    	add	x2, sp, #0xb8
10a1249b4: 52800263    	mov	w3, #0x13               ; =19
10a1249b8: 955cdaa3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1249bc: aa1d03fd    	mov	x29, x29
10a1249c0: 955cdaa4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1249c4: aa0003f9    	mov	x25, x0
10a1249c8: 900ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a1249cc: f944c901    	ldr	x1, [x8, #0x990] ; addPlugins:
10a1249d0: f94053e0    	ldr	x0, [sp, #0xa0]
10a1249d4: aa1903e2    	mov	x2, x25
10a1249d8: 955cda9b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1249dc: aa1903e0    	mov	x0, x25
10a1249e0: f9402ff9    	ldr	x25, [sp, #0x58]
10a1249e4: 955cda9e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1249e8: aa1603e0    	mov	x0, x22
10a1249ec: 955cda9c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1249f0: aa1503e0    	mov	x0, x21
10a1249f4: 955cda9a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1249f8: aa1303e0    	mov	x0, x19
10a1249fc: 955cda98    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124a00: aa1703e0    	mov	x0, x23
10a124a04: 955cda96    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124a08: aa1403e0    	mov	x0, x20
10a124a0c: 955cda94    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124a10: aa1803e0    	mov	x0, x24
10a124a14: 955cda92    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124a18: f9400fe0    	ldr	x0, [sp, #0x18]
10a124a1c: 955cda90    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124a20: f94017e0    	ldr	x0, [sp, #0x28]
10a124a24: f94053f4    	ldr	x20, [sp, #0xa0]
10a124a28: 955cda8d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124a2c: f9401fe0    	ldr	x0, [sp, #0x38]
10a124a30: 955cda8b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124a34: f94023e0    	ldr	x0, [sp, #0x40]
10a124a38: 955cda89    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124a3c: f94027e0    	ldr	x0, [sp, #0x48]
10a124a40: 955cda87    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124a44: 900b0588    	adrp	x8, 0x1201d4000 <dyld_stub_binder+0x1201d4000>
10a124a48: f940b108    	ldr	x8, [x8, #0x160]
10a124a4c: f9401be9    	ldr	x9, [sp, #0x30]
10a124a50: a90aa3e9    	stp	x9, x8, [sp, #0xa8]
10a124a54: 900ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a124a58: f944c501    	ldr	x1, [x8, #0x988] ; initWithFlutterInstance:
10a124a5c: 9102a3e0    	add	x0, sp, #0xa8
10a124a60: aa1403e2    	mov	x2, x20
10a124a64: 955cda7a    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
10a124a68: aa0003f3    	mov	x19, x0
10a124a6c: b4000160    	cbz	x0, 0x10a124a98 <_Flutter_MMFoundation_BindContext+0x660067c>
10a124a70: 900af348    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10a124a74: f942ad01    	ldr	x1, [x8, #0x558] ; setInstance:
10a124a78: aa1303e0    	mov	x0, x19
10a124a7c: aa1403e2    	mov	x2, x20
10a124a80: 955cda71    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124a84: b00ae8a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a124a88: f9462d01    	ldr	x1, [x8, #0xc58] ; setContact:
10a124a8c: aa1303e0    	mov	x0, x19
10a124a90: aa1903e2    	mov	x2, x25
10a124a94: 955cda6c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124a98: f9402be0    	ldr	x0, [sp, #0x50]
10a124a9c: 955cda70    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124aa0: aa1b03e0    	mov	x0, x27
10a124aa4: 955cda6e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124aa8: aa1a03e0    	mov	x0, x26
10a124aac: 955cda6c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124ab0: f94033e0    	ldr	x0, [sp, #0x60]
10a124ab4: 955cda6a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124ab8: f94037e0    	ldr	x0, [sp, #0x68]
10a124abc: 955cda68    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124ac0: f9403be0    	ldr	x0, [sp, #0x70]
10a124ac4: 955cda66    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124ac8: f9403fe0    	ldr	x0, [sp, #0x78]
10a124acc: 955cda64    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124ad0: f94043e0    	ldr	x0, [sp, #0x80]
10a124ad4: 955cda62    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124ad8: f94047e0    	ldr	x0, [sp, #0x88]
10a124adc: 955cda60    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124ae0: f9404be0    	ldr	x0, [sp, #0x90]
10a124ae4: 955cda5e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124ae8: aa1403e0    	mov	x0, x20
10a124aec: 955cda5c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124af0: f9404fe0    	ldr	x0, [sp, #0x98]
10a124af4: 955cda5a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124af8: aa1903e0    	mov	x0, x25
10a124afc: 955cda58    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124b00: f85a03a8    	ldur	x8, [x29, #-0x60]
10a124b04: f009a649    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a124b08: f9405929    	ldr	x9, [x9, #0xb0]
10a124b0c: f9400129    	ldr	x9, [x9]
10a124b10: eb08013f    	cmp	x9, x8
10a124b14: 54000141    	b.ne	0x10a124b3c <_Flutter_MMFoundation_BindContext+0x6600720>
10a124b18: aa1303e0    	mov	x0, x19
10a124b1c: 910703ff    	add	sp, sp, #0x1c0
10a124b20: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10a124b24: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10a124b28: a94357f6    	ldp	x22, x21, [sp, #0x30]
10a124b2c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10a124b30: a94167fa    	ldp	x26, x25, [sp, #0x10]
10a124b34: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10a124b38: d65f03c0    	ret
10a124b3c: 955cda50    	bl	0x10f85b47c <_UR_96F1_B25D+0x3a640ec>
