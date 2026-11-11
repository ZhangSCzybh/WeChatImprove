
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
1020413dc:     	sub	sp, sp, #0x160
1020413e0:     	stp	x28, x27, [sp, #0x100]
1020413e4:     	stp	x26, x25, [sp, #0x110]
1020413e8:     	stp	x24, x23, [sp, #0x120]
1020413ec:     	stp	x22, x21, [sp, #0x130]
1020413f0:     	stp	x20, x19, [sp, #0x140]
1020413f4:     	stp	x29, x30, [sp, #0x150]
1020413f8:     	add	x29, sp, #0x150
1020413fc:     	mov	x19, x2
102041400:     	mov	x20, x0
102041404:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
102041408:     	ldr	x8, [x8, #0xa30]
10204140c:     	ldr	x8, [x8]
102041410:     	stur	x8, [x29, #-0x60]
102041414:     	adrp	x8, 0x11f747000 <dyld_stub_binder+0x11f747000>
102041418:     	mov	w9, #0x1                ; =1
10204141c:     	strb	w9, [x8, #0x5a0]
102041420:     	mov	x0, x2
102041424:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102041428:     	adrp	x8, 0x11ed98000 <dyld_stub_binder+0x11ed98000>
10204142c:     	ldrsw	x22, [x8, #0x33c]
102041430:     	ldr	x21, [x20, x22]
102041434:     	cbnz	x21, 0x102041458 <_Flutter_Image_provideRelativePathByUrl+0x2c98e4>
102041438:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10204143c:     	ldr	x0, [x8, #0x658]
102041440:     	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
102041444:     	ldr	x8, [x20, x22]
102041448:     	str	x0, [x20, x22]
10204144c:     	mov	x0, x8
102041450:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102041454:     	ldr	x21, [x20, x22]
102041458:     	stp	x22, x20, [sp, #0x18]
10204145c:     	movi.16b	v0, #0x0
102041460:     	stp	q0, q0, [sp, #0x50]
102041464:     	stp	q0, q0, [sp, #0x30]
102041468:     	mov	x0, x21
10204146c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102041470:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
102041474:     	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
102041478:     	add	x2, sp, #0x30
10204147c:     	add	x3, sp, #0x70
102041480:     	str	x1, [sp, #0x28]
102041484:     	mov	w4, #0x10               ; =16
102041488:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204148c:     	cbz	x0, 0x10204158c <_Flutter_Image_provideRelativePathByUrl+0x2c9a18>
102041490:     	mov	x24, x0
102041494:     	ldr	x8, [sp, #0x40]
102041498:     	ldr	x20, [x8]
10204149c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1020414a0:     	adrp	x9, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1020414a4:     	mov	x23, #0x0               ; =0
1020414a8:     	ldr	x22, [x8, #0x620] ; selector: m_nsUsrName
1020414ac:     	ldr	x25, [x9, #0x7b8] ; selector: isEqualToString:
1020414b0:     	ldr	x8, [sp, #0x40]
1020414b4:     	ldr	x8, [x8]
1020414b8:     	cmp	x8, x20
1020414bc:     	b.eq	0x1020414c8 <_Flutter_Image_provideRelativePathByUrl+0x2c9954>
1020414c0:     	mov	x0, x21
1020414c4:     	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
1020414c8:     	ldr	x8, [sp, #0x38]
1020414cc:     	ldr	x26, [x8, x23, lsl #3]
1020414d0:     	mov	x0, x19
1020414d4:     	mov	x1, x22
1020414d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020414dc:     	mov	x29, x29
1020414e0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020414e4:     	mov	x27, x0
1020414e8:     	mov	x0, x26
1020414ec:     	mov	x1, x25
1020414f0:     	mov	x2, x27
1020414f4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020414f8:     	mov	x28, x0
1020414fc:     	mov	x0, x27
102041500:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102041504:     	cbnz	w28, 0x102041540 <_Flutter_Image_provideRelativePathByUrl+0x2c99cc>
102041508:     	add	x23, x23, #0x1
10204150c:     	cmp	x24, x23
102041510:     	b.ne	0x1020414b0 <_Flutter_Image_provideRelativePathByUrl+0x2c993c>
102041514:     	add	x2, sp, #0x30
102041518:     	add	x3, sp, #0x70
10204151c:     	mov	x0, x21
102041520:     	ldr	x1, [sp, #0x28]
102041524:     	mov	w4, #0x10               ; =16
102041528:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204152c:     	mov	x24, x0
102041530:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
102041534:     	adrp	x9, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
102041538:     	cbnz	x0, 0x1020414a4 <_Flutter_Image_provideRelativePathByUrl+0x2c9930>
10204153c:     	b	0x102041594 <_Flutter_Image_provideRelativePathByUrl+0x2c9a20>
102041540:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102041544:     	ldr	x0, [x8, #0x618]
102041548:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10204154c:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
102041550:     	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
102041554:     	add	x8, x8, #0x3f8 ; CFString: Group %@ 's Detail is getting, ignore request
102041558:     	stp	x8, x26, [sp]
10204155c:     	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
102041560:     	add	x3, x3, #0x582
102041564:     	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
102041568:     	add	x5, x5, #0x24a
10204156c:     	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
102041570:     	add	x7, x7, #0xe8c
102041574:     	mov	w2, #0x2                ; =2
102041578:     	mov	w4, #0x0                ; =0
10204157c:     	mov	w6, #0x5d3              ; =1491
102041580:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102041584:     	mov	w20, #0x0               ; =0
102041588:     	b	0x10204166c <_Flutter_Image_provideRelativePathByUrl+0x2c9af8>
10204158c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
102041590:     	ldr	x22, [x8, #0x620] ; selector: m_nsUsrName
102041594:     	mov	x0, x21
102041598:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204159c:     	ldp	x8, x20, [sp, #0x18]
1020415a0:     	ldr	x21, [x20, x8]
1020415a4:     	mov	x0, x19
1020415a8:     	mov	x1, x22
1020415ac:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020415b0:     	mov	x29, x29
1020415b4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020415b8:     	mov	x23, x0
1020415bc:     	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
1020415c0:     	ldr	x1, [x8, #0x580] ; selector: safeAddObject:
1020415c4:     	mov	x0, x21
1020415c8:     	mov	x2, x23
1020415cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020415d0:     	mov	x0, x23
1020415d4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020415d8:     	adrp	x8, 0x11ed22000 <dyld_stub_binder+0x11ed22000>
1020415dc:     	ldr	x0, [x8, #0x140]
1020415e0:     	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
1020415e4:     	mov	x21, x0
1020415e8:     	mov	x0, x19
1020415ec:     	mov	x1, x22
1020415f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020415f4:     	mov	x29, x29
1020415f8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020415fc:     	mov	x22, x0
102041600:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
102041604:     	ldr	x1, [x8, #0x780] ; selector: setChatroomUserName:
102041608:     	mov	x0, x21
10204160c:     	mov	x2, x22
102041610:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102041614:     	mov	x0, x22
102041618:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204161c:     	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
102041620:     	ldr	x1, [x8, #0x370] ; selector: setClientVersion:
102041624:     	mov	x0, x21
102041628:     	mov	w2, #0x0                ; =0
10204162c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102041630:     	adrp	x8, 0x11ed22000 <dyld_stub_binder+0x11ed22000>
102041634:     	ldr	x0, [x8, #0x148]
102041638:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10204163c:     	ldr	x1, [x8, #0x508] ; selector: class
102041640:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102041644:     	mov	x5, x0
102041648:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204164c:     	ldr	x1, [x8, #0x750] ; selector: createProtoBufEvent:forCgi:andUserData:eventHandler:
102041650:     	mov	x0, x20
102041654:     	mov	x2, x21
102041658:     	mov	w3, #0x227              ; =551
10204165c:     	mov	x4, #0x0                ; =0
102041660:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102041664:     	cmp	w0, #0x0
102041668:     	cset	w20, ne
10204166c:     	mov	x0, x21
102041670:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102041674:     	mov	x0, x19
102041678:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204167c:     	ldur	x8, [x29, #-0x60]
102041680:     	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
102041684:     	ldr	x9, [x9, #0xa30]
102041688:     	ldr	x9, [x9]
10204168c:     	cmp	x9, x8
102041690:     	b.ne	0x1020416b8 <_Flutter_Image_provideRelativePathByUrl+0x2c9b44>
102041694:     	mov	x0, x20
102041698:     	ldp	x29, x30, [sp, #0x150]
10204169c:     	ldp	x20, x19, [sp, #0x140]
1020416a0:     	ldp	x22, x21, [sp, #0x130]
1020416a4:     	ldp	x24, x23, [sp, #0x120]
1020416a8:     	ldp	x26, x25, [sp, #0x110]
1020416ac:     	ldp	x28, x27, [sp, #0x100]
1020416b0:     	add	sp, sp, #0x160
1020416b4:     	ret
1020416b8:     	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
