
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116714774: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
116714778: a90157f6    	stp	x22, x21, [sp, #0x10]
11671477c: a9024ff4    	stp	x20, x19, [sp, #0x20]
116714780: a9037bfd    	stp	x29, x30, [sp, #0x30]
116714784: 9100c3fd    	add	x29, sp, #0x30
116714788: aa0203f4    	mov	x20, x2
11671478c: aa0003f3    	mov	x19, x0
116714790: 9004cf88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
116714794: f9437916    	ldr	x22, [x8, #0x6f0] ; selector maxCount
116714798: aa1603e1    	mov	x1, x22
11671479c: 94705554    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167147a0: 7100001f    	cmp	w0, #0x0
1167147a4: 540000cc    	b.gt	0x1167147bc <_O266DecReleaseOutputPicture+0x3487d04>
1167147a8: 9004cfa8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1167147ac: f9464101    	ldr	x1, [x8, #0xc80] ; selector setMaxCount:
1167147b0: aa1303e0    	mov	x0, x19
1167147b4: 52800c62    	mov	w2, #0x63               ; =99
1167147b8: 9470554d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167147bc: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
1167147c0: f942c917    	ldr	x23, [x8, #0x590] ; selector maxCountTip
1167147c4: aa1303e0    	mov	x0, x19
1167147c8: aa1703e1    	mov	x1, x23
1167147cc: 94705548    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167147d0: aa1d03fd    	mov	x29, x29
1167147d4: 94705570    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167147d8: aa0003f5    	mov	x21, x0
1167147dc: f004cf68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1167147e0: f946e901    	ldr	x1, [x8, #0xdd0] ; selector length
1167147e4: 94705542    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167147e8: aa0003f8    	mov	x24, x0
1167147ec: aa1503e0    	mov	x0, x21
1167147f0: 9470555a    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167147f4: b50000f8    	cbnz	x24, 0x116714810 <_O266DecReleaseOutputPicture+0x3487d58>
1167147f8: d004bc48    	adrp	x8, 0x11fe9e000 <dyld_stub_binder+0x11fe9e000>
1167147fc: f942e501    	ldr	x1, [x8, #0x5c8] ; selector setMaxCountTip:
116714800: f00405a2    	adrp	x2, 0x11e7cb000 <dyld_stub_binder+0x11e7cb000>
116714804: 9126a042    	add	x2, x2, #0x9a8 ; CFString '�'
116714808: aa1303e0    	mov	x0, x19
11671480c: 94705538    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714810: 9004c208    	adrp	x8, 0x11ff54000 <dyld_stub_binder+0x11ff54000>
116714814: f940fd15    	ldr	x21, [x8, #0x1f8] ; selector badgeLabel
116714818: aa1303e0    	mov	x0, x19
11671481c: aa1503e1    	mov	x1, x21
116714820: 94705533    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714824: aa1d03fd    	mov	x29, x29
116714828: 9470555b    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11671482c: aa0003f8    	mov	x24, x0
116714830: 9004cfa8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
116714834: f9411101    	ldr	x1, [x8, #0x220] ; selector setHidden:
116714838: 52800002    	mov	w2, #0x0                ; =0
11671483c: 9470552c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714840: aa1803e0    	mov	x0, x24
116714844: 94705545    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714848: aa1303e0    	mov	x0, x19
11671484c: aa1603e1    	mov	x1, x22
116714850: 94705527    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714854: 93407c08    	sxtw	x8, w0
116714858: eb14011f    	cmp	x8, x20
11671485c: 54000462    	b.hs	0x1167148e8 <_O266DecReleaseOutputPicture+0x3487e30>
116714860: aa1303e0    	mov	x0, x19
116714864: aa1703e1    	mov	x1, x23
116714868: 94705521    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11671486c: aa1d03fd    	mov	x29, x29
116714870: 94705549    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714874: aa0003f4    	mov	x20, x0
116714878: aa1303e0    	mov	x0, x19
11671487c: aa1503e1    	mov	x1, x21
116714880: 9470551b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714884: aa1d03fd    	mov	x29, x29
116714888: 94705543    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11671488c: aa0003f6    	mov	x22, x0
116714890: b004cfa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
116714894: f9468d01    	ldr	x1, [x8, #0xd18] ; selector setText:
116714898: aa1403e2    	mov	x2, x20
11671489c: 94705514    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167148a0: aa1603e0    	mov	x0, x22
1167148a4: 9470552d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167148a8: aa1403e0    	mov	x0, x20
1167148ac: 9470552b    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167148b0: aa1303e0    	mov	x0, x19
1167148b4: aa1503e1    	mov	x1, x21
1167148b8: 9470550d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167148bc: aa1d03fd    	mov	x29, x29
1167148c0: 94705535    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167148c4: aa0003f4    	mov	x20, x0
1167148c8: b004b928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1167148cc: f9465101    	ldr	x1, [x8, #0xca0] ; selector sizeToFit
1167148d0: 94705507    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167148d4: aa1403e0    	mov	x0, x20
1167148d8: 94705520    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167148dc: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
1167148e0: 91166108    	add	x8, x8, #0x598 ; selector innerSetBadgeShape
1167148e4: 14000031    	b	0x1167149a8 <_O266DecReleaseOutputPicture+0x3487ef0>
1167148e8: f004d2e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1167148ec: f9458900    	ldr	x0, [x8, #0xb10] ; class NSNumber
1167148f0: 9004cf88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1167148f4: f947c101    	ldr	x1, [x8, #0xf80] ; selector numberWithUnsignedInteger:
1167148f8: aa1403e2    	mov	x2, x20
1167148fc: 947054fc    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714900: aa1d03fd    	mov	x29, x29
116714904: 94705524    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714908: aa0003f6    	mov	x22, x0
11671490c: d004cfa8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
116714910: f9469101    	ldr	x1, [x8, #0xd20] ; selector stringValue
116714914: 947054f6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714918: aa1d03fd    	mov	x29, x29
11671491c: 9470551e    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714920: aa0003f7    	mov	x23, x0
116714924: aa1303e0    	mov	x0, x19
116714928: aa1503e1    	mov	x1, x21
11671492c: 947054f0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714930: aa1d03fd    	mov	x29, x29
116714934: 94705518    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714938: aa0003f8    	mov	x24, x0
11671493c: b004cfa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
116714940: f9468d01    	ldr	x1, [x8, #0xd18] ; selector setText:
116714944: aa1703e2    	mov	x2, x23
116714948: 947054e9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11671494c: aa1803e0    	mov	x0, x24
116714950: 94705502    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714954: aa1703e0    	mov	x0, x23
116714958: 94705500    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11671495c: aa1603e0    	mov	x0, x22
116714960: 947054fe    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714964: aa1303e0    	mov	x0, x19
116714968: aa1503e1    	mov	x1, x21
11671496c: 947054e0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714970: aa1d03fd    	mov	x29, x29
116714974: 94705508    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714978: aa0003f5    	mov	x21, x0
11671497c: b004b928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
116714980: f9465101    	ldr	x1, [x8, #0xca0] ; selector sizeToFit
116714984: 947054da    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714988: aa1503e0    	mov	x0, x21
11671498c: 947054f3    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714990: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116714994: 91168108    	add	x8, x8, #0x5a0 ; selector innerSetCircleShape
116714998: d004cec9    	adrp	x9, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
11671499c: 91166129    	add	x9, x9, #0x598 ; selector innerSetBadgeShape
1167149a0: f100269f    	cmp	x20, #0x9
1167149a4: 9a888128    	csel	x8, x9, x8, hi
1167149a8: f9400101    	ldr	x1, [x8]
1167149ac: aa1303e0    	mov	x0, x19
1167149b0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1167149b4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1167149b8: a94157f6    	ldp	x22, x21, [sp, #0x10]
1167149bc: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1167149c0: 147054cb    	b	0x118329cec <dyld_stub_binder+0x118329cec>
