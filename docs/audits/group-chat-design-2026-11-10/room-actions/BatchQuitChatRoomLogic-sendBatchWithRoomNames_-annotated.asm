
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10038f29c:     	sub	sp, sp, #0x160
10038f2a0:     	stp	x28, x27, [sp, #0x100]
10038f2a4:     	stp	x26, x25, [sp, #0x110]
10038f2a8:     	stp	x24, x23, [sp, #0x120]
10038f2ac:     	stp	x22, x21, [sp, #0x130]
10038f2b0:     	stp	x20, x19, [sp, #0x140]
10038f2b4:     	stp	x29, x30, [sp, #0x150]
10038f2b8:     	add	x29, sp, #0x150
10038f2bc:     	mov	x19, x2
10038f2c0:     	mov	x20, x0
10038f2c4:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038f2c8:     	ldr	x8, [x8, #0xa30]
10038f2cc:     	ldr	x8, [x8]
10038f2d0:     	stur	x8, [x29, #-0x60]
10038f2d4:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
10038f2d8:     	mov	w9, #0x1                ; =1
10038f2dc:     	strb	w9, [x8, #0xc04]
10038f2e0:     	mov	x0, x2
10038f2e4:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10038f2e8:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f2ec:     	ldr	x21, [x8, #0x400] ; selector: running
10038f2f0:     	mov	x0, x20
10038f2f4:     	mov	x1, x21
10038f2f8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f2fc:     	cbz	w0, 0x10038f4e0 <__text+0x3874e0>
10038f300:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038f304:     	ldr	x1, [x8, #0x850] ; selector: count
10038f308:     	mov	x0, x19
10038f30c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f310:     	cbz	x0, 0x10038f4e0 <__text+0x3874e0>
10038f314:     	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10038f318:     	ldr	x0, [x8, #0x9f8]
10038f31c:     	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
10038f320:     	mov	x21, x0
10038f324:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
10038f328:     	ldr	x1, [x8, #0x318] ; selector: mutableCopy
10038f32c:     	mov	x0, x19
10038f330:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f334:     	mov	x22, x0
10038f338:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f33c:     	ldr	x1, [x8, #0x4e8] ; selector: setChatroomUsernameList:
10038f340:     	mov	x0, x21
10038f344:     	mov	x2, x22
10038f348:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f34c:     	mov	x0, x22
10038f350:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f354:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f358:     	ldr	x0, [x8, #0xaf0]
10038f35c:     	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
10038f360:     	mov	x22, x0
10038f364:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10038f368:     	ldr	x1, [x8, #0x840] ; selector: setM_pbRequest:
10038f36c:     	mov	x2, x21
10038f370:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f374:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10038f378:     	ldr	x1, [x8, #0x848] ; selector: setM_uiCgi:
10038f37c:     	mov	x0, x22
10038f380:     	mov	w2, #0x4810             ; =18448
10038f384:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f388:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f38c:     	ldr	x1, [x8, #0x418] ; selector: setStage:
10038f390:     	mov	x0, x20
10038f394:     	mov	w2, #0x2                ; =2
10038f398:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f39c:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038f3a0:     	ldr	x1, [x8, #0x818] ; selector: copy
10038f3a4:     	mov	x0, x19
10038f3a8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f3ac:     	mov	x24, x0
10038f3b0:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f3b4:     	ldr	x23, [x8, #0x470] ; selector: setActiveRequestRoomNames:
10038f3b8:     	mov	x0, x20
10038f3bc:     	mov	x1, x23
10038f3c0:     	mov	x2, x24
10038f3c4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f3c8:     	mov	x0, x24
10038f3cc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f3d0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f3d4:     	ldr	x0, [x8, #0x780]
10038f3d8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038f3dc:     	ldr	x1, [x8, #0x800] ; selector: currentContext
10038f3e0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f3e4:     	mov	x29, x29
10038f3e8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f3ec:     	mov	x25, x0
10038f3f0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f3f4:     	ldr	x0, [x8, #0xaf8]
10038f3f8:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038f3fc:     	ldr	x1, [x8, #0x508] ; selector: class
10038f400:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f404:     	mov	x2, x0
10038f408:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038f40c:     	ldr	x1, [x8, #0xa40] ; selector: getService:
10038f410:     	mov	x0, x25
10038f414:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f418:     	mov	x29, x29
10038f41c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f420:     	mov	x26, x0
10038f424:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10038f428:     	ldr	x1, [x8, #0x850] ; selector: CreateProtobufEvent:Flag:
10038f42c:     	mov	x2, x22
10038f430:     	mov	w3, #0x5                ; =5
10038f434:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f438:     	mov	x24, x0
10038f43c:     	mov	x0, x26
10038f440:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f444:     	mov	x0, x25
10038f448:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f44c:     	cbz	w24, 0x10038f55c <__text+0x38755c>
10038f450:     	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10038f454:     	ldr	x1, [x8, #0x510] ; selector: setEventID:
10038f458:     	mov	x0, x20
10038f45c:     	mov	x2, x24
10038f460:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f464:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f468:     	ldr	x23, [x8, #0x618]
10038f46c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f470:     	ldr	x1, [x8, #0x488] ; selector: clearHistory
10038f474:     	mov	x0, x20
10038f478:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f47c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038f480:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10038f484:     	stp	x19, x0, [sp, #0x10]
10038f488:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10038f48c:     	add	x8, x8, #0xe98 ; CFString: send batch request, eventID:%u roomNames:%@ clearHistory:%d
10038f490:     	stp	x8, x24, [sp]
10038f494:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
10038f498:     	add	x3, x3, #0xff4
10038f49c:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038f4a0:     	add	x5, x5, #0xb
10038f4a4:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038f4a8:     	add	x7, x7, #0x30a
10038f4ac:     	mov	x0, x23
10038f4b0:     	mov	w2, #0x2                ; =2
10038f4b4:     	mov	w4, #0x0                ; =0
10038f4b8:     	mov	w6, #0x121              ; =289
10038f4bc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f4c0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f4c4:     	ldr	x0, [x8, #0x840]
10038f4c8:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10038f4cc:     	ldr	x1, [x8, #0x858] ; selector: addPBEventObserverListItem:andValue:
10038f4d0:     	mov	x2, x24
10038f4d4:     	mov	x3, x20
10038f4d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f4dc:     	b	0x10038f6ac <__text+0x3876ac>
10038f4e0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f4e4:     	ldr	x22, [x8, #0x618]
10038f4e8:     	mov	x0, x20
10038f4ec:     	mov	x1, x21
10038f4f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f4f4:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038f4f8:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10038f4fc:     	stp	x19, x0, [sp, #0x8]
10038f500:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10038f504:     	add	x8, x8, #0xe58 ; CFString: ignore batch request, roomNames:%@ running:%d
10038f508:     	str	x8, [sp]
10038f50c:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
10038f510:     	add	x3, x3, #0xff4
10038f514:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038f518:     	add	x5, x5, #0xb
10038f51c:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038f520:     	add	x7, x7, #0x30a
10038f524:     	mov	x0, x22
10038f528:     	mov	w2, #0x3                ; =3
10038f52c:     	mov	w4, #0x0                ; =0
10038f530:     	mov	w6, #0x105              ; =261
10038f534:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f538:     	mov	x0, x20
10038f53c:     	mov	x1, x21
10038f540:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f544:     	cbz	w0, 0x10038f6bc <__text+0x3876bc>
10038f548:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f54c:     	ldr	x1, [x8, #0x490] ; selector: complete
10038f550:     	mov	x0, x20
10038f554:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f558:     	b	0x10038f6bc <__text+0x3876bc>
10038f55c:     	stp	x22, x21, [sp, #0x20]
10038f560:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f564:     	ldr	x0, [x8, #0x618]
10038f568:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038f56c:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10038f570:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10038f574:     	add	x8, x8, #0xe78 ; CFString: create batch request event failed, roomNames:%@
10038f578:     	stp	x8, x19, [sp]
10038f57c:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
10038f580:     	add	x3, x3, #0xff4
10038f584:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038f588:     	add	x5, x5, #0xb
10038f58c:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038f590:     	add	x7, x7, #0x30a
10038f594:     	mov	w2, #0x3                ; =3
10038f598:     	mov	w4, #0x0                ; =0
10038f59c:     	mov	w6, #0x118              ; =280
10038f5a0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f5a4:     	adrp	x8, 0x11d74e000 <dyld_stub_binder+0x11d74e000>
10038f5a8:     	ldr	x8, [x8, #0xa10]
10038f5ac:     	ldr	x2, [x8]
10038f5b0:     	mov	x0, x20
10038f5b4:     	mov	x1, x23
10038f5b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f5bc:     	movi.16b	v0, #0x0
10038f5c0:     	stp	q0, q0, [sp, #0x50]
10038f5c4:     	stp	q0, q0, [sp, #0x30]
10038f5c8:     	mov	x0, x19
10038f5cc:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10038f5d0:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038f5d4:     	ldr	x23, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
10038f5d8:     	add	x2, sp, #0x30
10038f5dc:     	add	x3, sp, #0x70
10038f5e0:     	mov	x1, x23
10038f5e4:     	mov	w4, #0x10               ; =16
10038f5e8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f5ec:     	cbz	x0, 0x10038f690 <__text+0x387690>
10038f5f0:     	mov	x24, x0
10038f5f4:     	ldr	x8, [sp, #0x40]
10038f5f8:     	ldr	x21, [x8]
10038f5fc:     	mov	x22, #0x0               ; =0
10038f600:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f604:     	ldr	x25, [x8, #0x478] ; selector: genericQuitFailureMessage
10038f608:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f60c:     	ldr	x26, [x8, #0x480] ; selector: recordFailureForRoom:errorMessage:
10038f610:     	ldr	x8, [sp, #0x40]
10038f614:     	ldr	x8, [x8]
10038f618:     	cmp	x8, x21
10038f61c:     	b.eq	0x10038f628 <__text+0x387628>
10038f620:     	mov	x0, x19
10038f624:     	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10038f628:     	ldr	x8, [sp, #0x38]
10038f62c:     	ldr	x27, [x8, x22, lsl #3]
10038f630:     	mov	x0, x20
10038f634:     	mov	x1, x25
10038f638:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f63c:     	mov	x29, x29
10038f640:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f644:     	mov	x28, x0
10038f648:     	mov	x0, x20
10038f64c:     	mov	x1, x26
10038f650:     	mov	x2, x27
10038f654:     	mov	x3, x28
10038f658:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f65c:     	mov	x0, x28
10038f660:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f664:     	add	x22, x22, #0x1
10038f668:     	cmp	x24, x22
10038f66c:     	b.ne	0x10038f610 <__text+0x387610>
10038f670:     	add	x2, sp, #0x30
10038f674:     	add	x3, sp, #0x70
10038f678:     	mov	x0, x19
10038f67c:     	mov	x1, x23
10038f680:     	mov	w4, #0x10               ; =16
10038f684:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f688:     	mov	x24, x0
10038f68c:     	cbnz	x0, 0x10038f5fc <__text+0x3875fc>
10038f690:     	mov	x0, x19
10038f694:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f698:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f69c:     	ldr	x1, [x8, #0x490] ; selector: complete
10038f6a0:     	mov	x0, x20
10038f6a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f6a8:     	ldp	x22, x21, [sp, #0x20]
10038f6ac:     	mov	x0, x22
10038f6b0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f6b4:     	mov	x0, x21
10038f6b8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f6bc:     	mov	x0, x19
10038f6c0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f6c4:     	ldur	x8, [x29, #-0x60]
10038f6c8:     	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038f6cc:     	ldr	x9, [x9, #0xa30]
10038f6d0:     	ldr	x9, [x9]
10038f6d4:     	cmp	x9, x8
10038f6d8:     	b.ne	0x10038f6fc <__text+0x3876fc>
10038f6dc:     	ldp	x29, x30, [sp, #0x150]
10038f6e0:     	ldp	x20, x19, [sp, #0x140]
10038f6e4:     	ldp	x22, x21, [sp, #0x130]
10038f6e8:     	ldp	x24, x23, [sp, #0x120]
10038f6ec:     	ldp	x26, x25, [sp, #0x110]
10038f6f0:     	ldp	x28, x27, [sp, #0x100]
10038f6f4:     	add	sp, sp, #0x160
10038f6f8:     	ret
10038f6fc:     	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
