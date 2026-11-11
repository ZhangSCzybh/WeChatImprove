
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
10203a1fc:     	sub	sp, sp, #0x190
10203a200:     	stp	x28, x27, [sp, #0x130]
10203a204:     	stp	x26, x25, [sp, #0x140]
10203a208:     	stp	x24, x23, [sp, #0x150]
10203a20c:     	stp	x22, x21, [sp, #0x160]
10203a210:     	stp	x20, x19, [sp, #0x170]
10203a214:     	stp	x29, x30, [sp, #0x180]
10203a218:     	add	x29, sp, #0x180
10203a21c:     	mov	x20, x3
10203a220:     	mov	x21, x2
10203a224:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10203a228:     	ldr	x8, [x8, #0xa30]
10203a22c:     	ldr	x8, [x8]
10203a230:     	stur	x8, [x29, #-0x60]
10203a234:     	adrp	x8, 0x11f747000 <dyld_stub_binder+0x11f747000>
10203a238:     	mov	w9, #0x1                ; =1
10203a23c:     	strb	w9, [x8, #0x58e]
10203a240:     	mov	x0, x2
10203a244:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10203a248:     	mov	x0, x20
10203a24c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10203a250:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a254:     	ldr	x0, [x8, #0x780]
10203a258:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a25c:     	ldr	x1, [x8, #0x800] ; selector: currentContext
10203a260:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a264:     	mov	x29, x29
10203a268:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a26c:     	mov	x19, x0
10203a270:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a274:     	ldr	x0, [x8, #0xbe8]
10203a278:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10203a27c:     	ldr	x1, [x8, #0x508] ; selector: class
10203a280:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a284:     	mov	x2, x0
10203a288:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a28c:     	ldr	x1, [x8, #0xa40] ; selector: getService:
10203a290:     	mov	x0, x19
10203a294:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a298:     	mov	x29, x29
10203a29c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a2a0:     	mov	x22, x0
10203a2a4:     	mov	x0, x19
10203a2a8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a2ac:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10203a2b0:     	ldr	x24, [x8, #0x150] ; selector: getContactByName:
10203a2b4:     	mov	x0, x22
10203a2b8:     	mov	x1, x24
10203a2bc:     	mov	x2, x21
10203a2c0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a2c4:     	mov	x29, x29
10203a2c8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a2cc:     	mov	x25, x0
10203a2d0:     	cbz	x0, 0x10203a524 <_Flutter_Image_provideRelativePathByUrl+0x2c29b0>
10203a2d4:     	adrp	x8, 0x11e9f2000 <dyld_stub_binder+0x11e9f2000>
10203a2d8:     	ldr	x1, [x8, #0xc18] ; selector: tryLoadExtInfoForContact:
10203a2dc:     	mov	x0, x22
10203a2e0:     	mov	x2, x25
10203a2e4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a2e8:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10203a2ec:     	ldr	x1, [x8, #0xfa8] ; selector: isChatroom
10203a2f0:     	mov	x0, x25
10203a2f4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a2f8:     	tbz	w0, #0x0, 0x10203a56c <_Flutter_Image_provideRelativePathByUrl+0x2c29f8>
10203a2fc:     	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
10203a300:     	ldr	x1, [x8, #0x7d0] ; selector: m_nsChatRoomMemList
10203a304:     	mov	x0, x25
10203a308:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a30c:     	mov	x29, x29
10203a310:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a314:     	mov	x19, x0
10203a318:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10203a31c:     	ldr	x1, [x8, #0x678] ; selector: componentsSeparatedByString:
10203a320:     	adrp	x2, 0x11cfa3000 <dyld_stub_binder+0x11cfa3000>
10203a324:     	add	x2, x2, #0xef8 ; CFString: ;
10203a328:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a32c:     	mov	x29, x29
10203a330:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a334:     	mov	x23, x0
10203a338:     	mov	x0, x19
10203a33c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a340:     	cbz	x23, 0x10203a5ec <_Flutter_Image_provideRelativePathByUrl+0x2c2a78>
10203a344:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10203a348:     	ldr	x1, [x8, #0x850] ; selector: count
10203a34c:     	mov	x0, x23
10203a350:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a354:     	cbz	x0, 0x10203a5ec <_Flutter_Image_provideRelativePathByUrl+0x2c2a78>
10203a358:     	stp	x25, x21, [sp, #0x20]
10203a35c:     	movi.16b	v0, #0x0
10203a360:     	stp	q0, q0, [sp, #0x80]
10203a364:     	stp	q0, q0, [sp, #0x60]
10203a368:     	mov	x0, x23
10203a36c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10203a370:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10203a374:     	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
10203a378:     	add	x2, sp, #0x60
10203a37c:     	add	x3, sp, #0xa0
10203a380:     	str	x1, [sp, #0x30]
10203a384:     	mov	w4, #0x10               ; =16
10203a388:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a38c:     	mov	x25, x23
10203a390:     	cbz	x0, 0x10203a514 <_Flutter_Image_provideRelativePathByUrl+0x2c29a0>
10203a394:     	mov	x26, x0
10203a398:     	ldr	x8, [sp, #0x70]
10203a39c:     	ldr	x27, [x8]
10203a3a0:     	mov	x23, #0x0               ; =0
10203a3a4:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10203a3a8:     	ldr	x9, [x8, #0xce8] ; selector: length
10203a3ac:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10203a3b0:     	ldr	x8, [x8, #0x7b8] ; selector: isEqualToString:
10203a3b4:     	stp	x9, x8, [sp, #0x50]
10203a3b8:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10203a3bc:     	ldr	x9, [x8, #0xfb8] ; selector: generatePrivacyString:
10203a3c0:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a3c4:     	ldr	x8, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10203a3c8:     	stp	x8, x9, [sp, #0x38]
10203a3cc:     	str	x26, [sp, #0x48]
10203a3d0:     	ldr	x8, [sp, #0x70]
10203a3d4:     	ldr	x8, [x8]
10203a3d8:     	cmp	x8, x27
10203a3dc:     	b.eq	0x10203a3e8 <_Flutter_Image_provideRelativePathByUrl+0x2c2874>
10203a3e0:     	mov	x0, x25
10203a3e4:     	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10203a3e8:     	ldr	x8, [sp, #0x68]
10203a3ec:     	ldr	x28, [x8, x23, lsl #3]
10203a3f0:     	cbz	x28, 0x10203a4e8 <_Flutter_Image_provideRelativePathByUrl+0x2c2974>
10203a3f4:     	mov	x0, x28
10203a3f8:     	ldr	x1, [sp, #0x50]
10203a3fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a400:     	cbz	x0, 0x10203a4e8 <_Flutter_Image_provideRelativePathByUrl+0x2c2974>
10203a404:     	mov	x0, x22
10203a408:     	mov	x1, x24
10203a40c:     	mov	x2, x28
10203a410:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a414:     	mov	x29, x29
10203a418:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a41c:     	mov	x19, x0
10203a420:     	mov	x0, x28
10203a424:     	ldr	x1, [sp, #0x58]
10203a428:     	mov	x2, x20
10203a42c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a430:     	cmp	x19, #0x0
10203a434:     	ccmp	w0, #0x0, #0x4, eq
10203a438:     	b.eq	0x10203a4c8 <_Flutter_Image_provideRelativePathByUrl+0x2c2954>
10203a43c:     	mov	x26, x27
10203a440:     	mov	x27, x24
10203a444:     	mov	x24, x25
10203a448:     	mov	x25, x22
10203a44c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a450:     	ldr	x22, [x8, #0x618]
10203a454:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a458:     	ldr	x0, [x8, #0x638]
10203a45c:     	ldr	x1, [sp, #0x40]
10203a460:     	mov	x2, x20
10203a464:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a468:     	mov	x29, x29
10203a46c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a470:     	mov	x21, x0
10203a474:     	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
10203a478:     	add	x8, x8, #0x8f8 ; CFString: member not in db %@
10203a47c:     	stp	x8, x0, [sp]
10203a480:     	mov	x0, x22
10203a484:     	mov	x22, x25
10203a488:     	mov	x25, x24
10203a48c:     	mov	x24, x27
10203a490:     	mov	x27, x26
10203a494:     	ldr	x26, [sp, #0x48]
10203a498:     	ldr	x1, [sp, #0x38]
10203a49c:     	mov	w2, #0x1                ; =1
10203a4a0:     	mov	x3, #0x0                ; =0
10203a4a4:     	mov	w4, #0x0                ; =0
10203a4a8:     	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a4ac:     	add	x5, x5, #0x24a
10203a4b0:     	mov	w6, #0x298              ; =664
10203a4b4:     	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a4b8:     	add	x7, x7, #0x682
10203a4bc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a4c0:     	mov	x0, x21
10203a4c4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a4c8:     	mov	x0, x28
10203a4cc:     	ldr	x1, [sp, #0x58]
10203a4d0:     	mov	x2, x20
10203a4d4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a4d8:     	mov	x21, x0
10203a4dc:     	mov	x0, x19
10203a4e0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a4e4:     	tbnz	w21, #0x0, 0x10203a66c <_Flutter_Image_provideRelativePathByUrl+0x2c2af8>
10203a4e8:     	add	x23, x23, #0x1
10203a4ec:     	cmp	x26, x23
10203a4f0:     	b.ne	0x10203a3d0 <_Flutter_Image_provideRelativePathByUrl+0x2c285c>
10203a4f4:     	add	x2, sp, #0x60
10203a4f8:     	add	x3, sp, #0xa0
10203a4fc:     	mov	x0, x25
10203a500:     	ldr	x1, [sp, #0x30]
10203a504:     	mov	w4, #0x10               ; =16
10203a508:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a50c:     	mov	x26, x0
10203a510:     	cbnz	x0, 0x10203a3a0 <_Flutter_Image_provideRelativePathByUrl+0x2c282c>
10203a514:     	mov	x0, x25
10203a518:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a51c:     	mov	w19, #0x0               ; =0
10203a520:     	b	0x10203a678 <_Flutter_Image_provideRelativePathByUrl+0x2c2b04>
10203a524:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a528:     	ldr	x0, [x8, #0x618]
10203a52c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a530:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10203a534:     	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
10203a538:     	add	x8, x8, #0x898 ; CFString: get chat room contact nil, roomName: %@
10203a53c:     	stp	x8, x21, [sp]
10203a540:     	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
10203a544:     	add	x3, x3, #0x582
10203a548:     	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a54c:     	add	x5, x5, #0x24a
10203a550:     	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a554:     	add	x7, x7, #0x682
10203a558:     	mov	w2, #0x2                ; =2
10203a55c:     	mov	w4, #0x0                ; =0
10203a560:     	mov	w6, #0x27f              ; =639
10203a564:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a568:     	b	0x10203a5e4 <_Flutter_Image_provideRelativePathByUrl+0x2c2a70>
10203a56c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a570:     	ldr	x19, [x8, #0x618]
10203a574:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a578:     	ldr	x0, [x8, #0x638]
10203a57c:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10203a580:     	ldr	x1, [x8, #0xfb8] ; selector: generatePrivacyString:
10203a584:     	mov	x2, x20
10203a588:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a58c:     	mov	x29, x29
10203a590:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a594:     	mov	x23, x0
10203a598:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a59c:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10203a5a0:     	stp	x21, x0, [sp, #0x8]
10203a5a4:     	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
10203a5a8:     	add	x8, x8, #0x8b8 ; CFString: return NO because [oGroupContact isChatroom] == NO, nsChatRoomName: %@, nsUsrName: %@
10203a5ac:     	str	x8, [sp]
10203a5b0:     	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
10203a5b4:     	add	x3, x3, #0x582
10203a5b8:     	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a5bc:     	add	x5, x5, #0x24a
10203a5c0:     	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a5c4:     	add	x7, x7, #0x682
10203a5c8:     	mov	x0, x19
10203a5cc:     	mov	w2, #0x2                ; =2
10203a5d0:     	mov	w4, #0x0                ; =0
10203a5d4:     	mov	w6, #0x287              ; =647
10203a5d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a5dc:     	mov	x0, x23
10203a5e0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a5e4:     	mov	w19, #0x0               ; =0
10203a5e8:     	b	0x10203a688 <_Flutter_Image_provideRelativePathByUrl+0x2c2b14>
10203a5ec:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a5f0:     	ldr	x19, [x8, #0x618]
10203a5f4:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a5f8:     	ldr	x0, [x8, #0x638]
10203a5fc:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10203a600:     	ldr	x1, [x8, #0xfb8] ; selector: generatePrivacyString:
10203a604:     	mov	x2, x20
10203a608:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a60c:     	mov	x29, x29
10203a610:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a614:     	mov	x24, x0
10203a618:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a61c:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10203a620:     	stp	x21, x0, [sp, #0x8]
10203a624:     	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
10203a628:     	add	x8, x8, #0x8d8 ; CFString: memlist is nil, roomName: %@, usrName: %@
10203a62c:     	str	x8, [sp]
10203a630:     	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
10203a634:     	add	x3, x3, #0x582
10203a638:     	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a63c:     	add	x5, x5, #0x24a
10203a640:     	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a644:     	add	x7, x7, #0x682
10203a648:     	mov	x0, x19
10203a64c:     	mov	w2, #0x2                ; =2
10203a650:     	mov	w4, #0x0                ; =0
10203a654:     	mov	w6, #0x28d              ; =653
10203a658:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a65c:     	mov	x0, x24
10203a660:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a664:     	mov	w19, #0x0               ; =0
10203a668:     	b	0x10203a680 <_Flutter_Image_provideRelativePathByUrl+0x2c2b0c>
10203a66c:     	mov	x0, x25
10203a670:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a674:     	mov	w19, #0x1               ; =1
10203a678:     	mov	x23, x25
10203a67c:     	ldp	x25, x21, [sp, #0x20]
10203a680:     	mov	x0, x23
10203a684:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a688:     	mov	x0, x25
10203a68c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a690:     	mov	x0, x22
10203a694:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a698:     	mov	x0, x20
10203a69c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a6a0:     	mov	x0, x21
10203a6a4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a6a8:     	ldur	x8, [x29, #-0x60]
10203a6ac:     	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10203a6b0:     	ldr	x9, [x9, #0xa30]
10203a6b4:     	ldr	x9, [x9]
10203a6b8:     	cmp	x9, x8
10203a6bc:     	b.ne	0x10203a6e4 <_Flutter_Image_provideRelativePathByUrl+0x2c2b70>
10203a6c0:     	mov	x0, x19
10203a6c4:     	ldp	x29, x30, [sp, #0x180]
10203a6c8:     	ldp	x20, x19, [sp, #0x170]
10203a6cc:     	ldp	x22, x21, [sp, #0x160]
10203a6d0:     	ldp	x24, x23, [sp, #0x150]
10203a6d4:     	ldp	x26, x25, [sp, #0x140]
10203a6d8:     	ldp	x28, x27, [sp, #0x130]
10203a6dc:     	add	sp, sp, #0x190
10203a6e0:     	ret
10203a6e4:     	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
