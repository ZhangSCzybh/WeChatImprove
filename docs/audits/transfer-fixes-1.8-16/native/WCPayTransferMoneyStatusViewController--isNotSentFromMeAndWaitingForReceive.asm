
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109a910ac: d101c3ff    	sub	sp, sp, #0x70
109a910b0: a9016ffc    	stp	x28, x27, [sp, #0x10]
109a910b4: a90267fa    	stp	x26, x25, [sp, #0x20]
109a910b8: a9035ff8    	stp	x24, x23, [sp, #0x30]
109a910bc: a90457f6    	stp	x22, x21, [sp, #0x40]
109a910c0: a9054ff4    	stp	x20, x19, [sp, #0x50]
109a910c4: a9067bfd    	stp	x29, x30, [sp, #0x60]
109a910c8: 910183fd    	add	x29, sp, #0x60
109a910cc: f00b8de8    	adrp	x8, 0x120c50000 <dyld_stub_binder+0x120c50000>
109a910d0: 52800029    	mov	w9, #0x1                ; =1
109a910d4: d00b3eaa    	adrp	x10, 0x120267000 <dyld_stub_binder+0x120267000>
109a910d8: 9132414a    	add	x10, x10, #0xc90
109a910dc: 39006509    	strb	w9, [x8, #0x19]
109a910e0: b9800148    	ldrsw	x8, [x10]
109a910e4: f8686800    	ldr	x0, [x0, x8]
109a910e8: 900b2ec8    	adrp	x8, 0x120069000 <dyld_stub_binder+0x120069000>
109a910ec: f9437901    	ldr	x1, [x8, #0x6f0] ; m_structOrderDetail
109a910f0: 957728d5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a910f4: aa1d03fd    	mov	x29, x29
109a910f8: 957728d6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a910fc: aa0003f4    	mov	x20, x0
109a91100: 900b2ec8    	adrp	x8, 0x120069000 <dyld_stub_binder+0x120069000>
109a91104: f9437d01    	ldr	x1, [x8, #0x6f8] ; m_orderDetailArray
109a91108: 957728cf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a9110c: aa1d03fd    	mov	x29, x29
109a91110: 957728d0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a91114: aa0003f5    	mov	x21, x0
109a91118: 900b3388    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
109a9111c: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
109a91120: 957728c9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91124: aa1d03fd    	mov	x29, x29
109a91128: 957728ca    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a9112c: aa0003f3    	mov	x19, x0
109a91130: aa1503e0    	mov	x0, x21
109a91134: 957728ca    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a91138: aa1403e0    	mov	x0, x20
109a9113c: 957728c8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a91140: b00b2fa8    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109a91144: f9462d01    	ldr	x1, [x8, #0xc58] ; trade_mem_type
109a91148: aa1303e0    	mov	x0, x19
109a9114c: 957728be    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91150: f100081f    	cmp	x0, #0x2
109a91154: 54000061    	b.ne	0x109a91160 <_Flutter_MMFoundation_BindContext+0x5f6cd44>
109a91158: 52800015    	mov	w21, #0x0               ; =0
109a9115c: 140000bc    	b	0x109a9144c <_Flutter_MMFoundation_BindContext+0x5f6d030>
109a91160: b00b2f48    	adrp	x8, 0x12007a000 <dyld_stub_binder+0x12007a000>
109a91164: f942b914    	ldr	x20, [x8, #0x570] ; m_nsSenderUserName
109a91168: aa1303e0    	mov	x0, x19
109a9116c: aa1403e1    	mov	x1, x20
109a91170: 957728b5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91174: aa1d03fd    	mov	x29, x29
109a91178: 957728b6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a9117c: aa0003f6    	mov	x22, x0
109a91180: d00b3388    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
109a91184: f946e915    	ldr	x21, [x8, #0xdd0] ; length
109a91188: aa1503e1    	mov	x1, x21
109a9118c: 957728ae    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91190: aa0003f7    	mov	x23, x0
109a91194: aa1603e0    	mov	x0, x22
109a91198: 957728b1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a9119c: d00b3708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109a911a0: 900b1d49    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109a911a4: d00b3716    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
109a911a8: f00b337a    	adrp	x26, 0x120100000 <dyld_stub_binder+0x120100000>
109a911ac: f00b3719    	adrp	x25, 0x120174000 <dyld_stub_binder+0x120174000>
109a911b0: d00b337c    	adrp	x28, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109a911b4: 900b1d58    	adrp	x24, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109a911b8: f00b1d5b    	adrp	x27, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109a911bc: b40006f7    	cbz	x23, 0x109a91298 <_Flutter_MMFoundation_BindContext+0x5f6ce7c>
109a911c0: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
109a911c4: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
109a911c8: f00a7c28    	adrp	x8, 0x11ea18000 <dyld_stub_binder+0x11ea18000>
109a911cc: 913e2108    	add	x8, x8, #0xf88 ; CFSTR has sender username
109a911d0: f90003e8    	str	x8, [sp]
109a911d4: f0090fc3    	adrp	x3, 0x11bc8c000 <dyld_stub_binder+0x11bc8c000>
109a911d8: 91334463    	add	x3, x3, #0xcd1
109a911dc: d0091145    	adrp	x5, 0x11bcbb000 <dyld_stub_binder+0x11bcbb000>
109a911e0: 91235ca5    	add	x5, x5, #0x8d7
109a911e4: f0091147    	adrp	x7, 0x11bcbc000 <dyld_stub_binder+0x11bcbc000>
109a911e8: 913394e7    	add	x7, x7, #0xce5
109a911ec: 52800042    	mov	w2, #0x2                ; =2
109a911f0: 52800004    	mov	w4, #0x0                ; =0
109a911f4: 5281eb66    	mov	w6, #0xf5b              ; =3931
109a911f8: 95772893    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a911fc: f945eac0    	ldr	x0, [x22, #0xbd0] ; ��d 
109a91200: f944eb41    	ldr	x1, [x26, #0x9d0] ; currentContext
109a91204: 95772890    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91208: aa1d03fd    	mov	x29, x29
109a9120c: 95772891    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a91210: aa0003f6    	mov	x22, x0
109a91214: aa1903fa    	mov	x26, x25
109a91218: f9401720    	ldr	x0, [x25, #0x28] ; P;, 
109a9121c: f947af81    	ldr	x1, [x28, #0xf58] ; class
109a91220: 95772889    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91224: aa0003e2    	mov	x2, x0
109a91228: aa1803f9    	mov	x25, x24
109a9122c: f9464301    	ldr	x1, [x24, #0xc80] ; getService:
109a91230: aa1603e0    	mov	x0, x22
109a91234: 95772884    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91238: aa1d03fd    	mov	x29, x29
109a9123c: 95772885    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a91240: aa0003f7    	mov	x23, x0
109a91244: aa1303e0    	mov	x0, x19
109a91248: aa1403e1    	mov	x1, x20
109a9124c: 9577287e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91250: aa1d03fd    	mov	x29, x29
109a91254: 9577287f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a91258: aa0003f8    	mov	x24, x0
109a9125c: aa1b03fc    	mov	x28, x27
109a91260: f940cb61    	ldr	x1, [x27, #0x190] ; getContactByName:
109a91264: aa1703e0    	mov	x0, x23
109a91268: aa1803e2    	mov	x2, x24
109a9126c: 95772876    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91270: aa1d03fd    	mov	x29, x29
109a91274: 95772877    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a91278: aa0003f4    	mov	x20, x0
109a9127c: aa1803e0    	mov	x0, x24
109a91280: 95772877    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a91284: aa1703e0    	mov	x0, x23
109a91288: 95772875    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a9128c: aa1603e0    	mov	x0, x22
109a91290: 95772873    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a91294: 14000005    	b	0x109a912a8 <_Flutter_MMFoundation_BindContext+0x5f6ce8c>
109a91298: aa1903fa    	mov	x26, x25
109a9129c: aa1803f9    	mov	x25, x24
109a912a0: aa1b03fc    	mov	x28, x27
109a912a4: d2800014    	mov	x20, #0x0               ; =0
109a912a8: d00b2f28    	adrp	x8, 0x120077000 <dyld_stub_binder+0x120077000>
109a912ac: f9437916    	ldr	x22, [x8, #0x6f0] ; m_nsReceiverUserName
109a912b0: aa1303e0    	mov	x0, x19
109a912b4: aa1603e1    	mov	x1, x22
109a912b8: 95772863    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a912bc: aa1d03fd    	mov	x29, x29
109a912c0: 95772864    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a912c4: aa0003f7    	mov	x23, x0
109a912c8: aa1503e1    	mov	x1, x21
109a912cc: 9577285e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a912d0: aa0003f5    	mov	x21, x0
109a912d4: aa1703e0    	mov	x0, x23
109a912d8: 95772861    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a912dc: b4000755    	cbz	x21, 0x109a913c4 <_Flutter_MMFoundation_BindContext+0x5f6cfa8>
109a912e0: d00b3708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109a912e4: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
109a912e8: 900b1d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109a912ec: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
109a912f0: f00a7c28    	adrp	x8, 0x11ea18000 <dyld_stub_binder+0x11ea18000>
109a912f4: 913ea108    	add	x8, x8, #0xfa8 ; CFSTR has receiver username
109a912f8: f90003e8    	str	x8, [sp]
109a912fc: f0090fc3    	adrp	x3, 0x11bc8c000 <dyld_stub_binder+0x11bc8c000>
109a91300: 91334463    	add	x3, x3, #0xcd1
109a91304: d0091145    	adrp	x5, 0x11bcbb000 <dyld_stub_binder+0x11bcbb000>
109a91308: 91235ca5    	add	x5, x5, #0x8d7
109a9130c: f0091147    	adrp	x7, 0x11bcbc000 <dyld_stub_binder+0x11bcbc000>
109a91310: 913394e7    	add	x7, x7, #0xce5
109a91314: 52800042    	mov	w2, #0x2                ; =2
109a91318: 52800004    	mov	w4, #0x0                ; =0
109a9131c: 5281ebe6    	mov	w6, #0xf5f              ; =3935
109a91320: 95772849    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91324: d00b3708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109a91328: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
109a9132c: f00b3368    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109a91330: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
109a91334: 95772844    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91338: aa1d03fd    	mov	x29, x29
109a9133c: 95772845    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a91340: aa0003f5    	mov	x21, x0
109a91344: f9401740    	ldr	x0, [x26, #0x28] ; clearServerProtocol
109a91348: d00b3368    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109a9134c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
109a91350: 9577283d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91354: aa0003e2    	mov	x2, x0
109a91358: f9464321    	ldr	x1, [x25, #0xc80] ; ��) 
109a9135c: aa1503e0    	mov	x0, x21
109a91360: 95772839    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91364: aa1d03fd    	mov	x29, x29
109a91368: 9577283a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a9136c: aa0003f7    	mov	x23, x0
109a91370: aa1303e0    	mov	x0, x19
109a91374: aa1603e1    	mov	x1, x22
109a91378: 95772833    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a9137c: aa1d03fd    	mov	x29, x29
109a91380: 95772834    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a91384: aa0003f6    	mov	x22, x0
109a91388: f940cb81    	ldr	x1, [x28, #0x190] ; annotationAccessibilityFrameClipToBounds
109a9138c: aa1703e0    	mov	x0, x23
109a91390: aa1603e2    	mov	x2, x22
109a91394: 9577282c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91398: aa1d03fd    	mov	x29, x29
109a9139c: 9577282d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109a913a0: aa0003f8    	mov	x24, x0
109a913a4: aa1603e0    	mov	x0, x22
109a913a8: 9577282d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a913ac: aa1703e0    	mov	x0, x23
109a913b0: 9577282b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a913b4: aa1503e0    	mov	x0, x21
109a913b8: 95772829    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a913bc: aa1803e0    	mov	x0, x24
109a913c0: 95772827    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a913c4: d00b1d48    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
109a913c8: f9470901    	ldr	x1, [x8, #0xe10] ; isSelf
109a913cc: aa1403e0    	mov	x0, x20
109a913d0: 9577281d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a913d4: 34000260    	cbz	w0, 0x109a91420 <_Flutter_MMFoundation_BindContext+0x5f6d004>
109a913d8: d00b3708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109a913dc: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
109a913e0: 900b1d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109a913e4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
109a913e8: f00a7c28    	adrp	x8, 0x11ea18000 <dyld_stub_binder+0x11ea18000>
109a913ec: 913f2108    	add	x8, x8, #0xfc8 ; CFSTR self is sender
109a913f0: f90003e8    	str	x8, [sp]
109a913f4: f0090fc3    	adrp	x3, 0x11bc8c000 <dyld_stub_binder+0x11bc8c000>
109a913f8: 91334463    	add	x3, x3, #0xcd1
109a913fc: d0091145    	adrp	x5, 0x11bcbb000 <dyld_stub_binder+0x11bcbb000>
109a91400: 91235ca5    	add	x5, x5, #0x8d7
109a91404: f0091147    	adrp	x7, 0x11bcbc000 <dyld_stub_binder+0x11bcbc000>
109a91408: 913394e7    	add	x7, x7, #0xce5
109a9140c: 52800042    	mov	w2, #0x2                ; =2
109a91410: 52800004    	mov	w4, #0x0                ; =0
109a91414: 5281ec86    	mov	w6, #0xf64              ; =3940
109a91418: 9577280b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a9141c: 14000009    	b	0x109a91440 <_Flutter_MMFoundation_BindContext+0x5f6d024>
109a91420: b00b2f48    	adrp	x8, 0x12007a000 <dyld_stub_binder+0x12007a000>
109a91424: f942c101    	ldr	x1, [x8, #0x580] ; m_eWCPayTransferMoneyOrderStatus
109a91428: aa1303e0    	mov	x0, x19
109a9142c: 95772806    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109a91430: 711f401f    	cmp	w0, #0x7d0
109a91434: 54000061    	b.ne	0x109a91440 <_Flutter_MMFoundation_BindContext+0x5f6d024>
109a91438: 52800035    	mov	w21, #0x1               ; =1
109a9143c: 14000002    	b	0x109a91444 <_Flutter_MMFoundation_BindContext+0x5f6d028>
109a91440: 52800015    	mov	w21, #0x0               ; =0
109a91444: aa1403e0    	mov	x0, x20
109a91448: 95772805    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a9144c: aa1303e0    	mov	x0, x19
109a91450: 95772803    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109a91454: aa1503e0    	mov	x0, x21
109a91458: a9467bfd    	ldp	x29, x30, [sp, #0x60]
109a9145c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
109a91460: a94457f6    	ldp	x22, x21, [sp, #0x40]
109a91464: a9435ff8    	ldp	x24, x23, [sp, #0x30]
109a91468: a94267fa    	ldp	x26, x25, [sp, #0x20]
109a9146c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
109a91470: 9101c3ff    	add	sp, sp, #0x70
109a91474: d65f03c0    	ret