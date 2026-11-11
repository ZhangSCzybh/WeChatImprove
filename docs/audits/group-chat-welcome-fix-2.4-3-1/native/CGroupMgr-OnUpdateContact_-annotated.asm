
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
102040438:     	sub	sp, sp, #0xa0
10204043c:     	stp	x28, x27, [sp, #0x40]
102040440:     	stp	x26, x25, [sp, #0x50]
102040444:     	stp	x24, x23, [sp, #0x60]
102040448:     	stp	x22, x21, [sp, #0x70]
10204044c:     	stp	x20, x19, [sp, #0x80]
102040450:     	stp	x29, x30, [sp, #0x90]
102040454:     	add	x29, sp, #0x90
102040458:     	mov	x0, x2
10204045c:     	adrp	x8, 0x11f747000 <dyld_stub_binder+0x11f747000>
102040460:     	mov	w9, #0x1                ; =1
102040464:     	strb	w9, [x8, #0x59c]
102040468:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10204046c:     	ldr	x1, [x8, #0x870] ; selector: m_pbResponse
102040470:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040474:     	mov	x29, x29
102040478:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10204047c:     	mov	x19, x0
102040480:     	cbz	x0, 0x1020404e0 <_Flutter_Image_provideRelativePathByUrl+0x2c896c>
102040484:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
102040488:     	ldr	x20, [x8, #0x480] ; selector: baseResponse
10204048c:     	mov	x0, x19
102040490:     	mov	x1, x20
102040494:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040498:     	mov	x29, x29
10204049c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020404a0:     	mov	x21, x0
1020404a4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020404a8:     	cbz	x21, 0x1020404e0 <_Flutter_Image_provideRelativePathByUrl+0x2c896c>
1020404ac:     	mov	x0, x19
1020404b0:     	mov	x1, x20
1020404b4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020404b8:     	mov	x29, x29
1020404bc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020404c0:     	mov	x20, x0
1020404c4:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1020404c8:     	ldr	x1, [x8, #0x488] ; selector: ret
1020404cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020404d0:     	mov	x21, x0
1020404d4:     	mov	x0, x20
1020404d8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020404dc:     	cbz	w21, 0x102040554 <_Flutter_Image_provideRelativePathByUrl+0x2c89e0>
1020404e0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1020404e4:     	ldr	x0, [x8, #0x780]
1020404e8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1020404ec:     	ldr	x1, [x8, #0x800] ; selector: currentContext
1020404f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020404f4:     	mov	x29, x29
1020404f8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020404fc:     	mov	x20, x0
102040500:     	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
102040504:     	ldr	x2, [x8, #0x558]
102040508:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204050c:     	ldr	x3, [x8, #0x738] ; selector: OnChatRoomContactUpdateOK:
102040510:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102040514:     	ldr	x1, [x8, #0xe58] ; selector: callExtension:selector:block:
102040518:     	adrp	x4, 0x11c2af000 <dyld_stub_binder+0x11c2af000>
10204051c:     	add	x4, x4, #0x1a8
102040520:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040524:     	mov	x0, x20
102040528:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204052c:     	mov	x0, x19
102040530:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102040534:     	ldp	x29, x30, [sp, #0x90]
102040538:     	ldp	x20, x19, [sp, #0x80]
10204053c:     	ldp	x22, x21, [sp, #0x70]
102040540:     	ldp	x24, x23, [sp, #0x60]
102040544:     	ldp	x26, x25, [sp, #0x50]
102040548:     	ldp	x28, x27, [sp, #0x40]
10204054c:     	add	sp, sp, #0xa0
102040550:     	ret
102040554:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102040558:     	ldr	x0, [x8, #0x780]
10204055c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102040560:     	ldr	x20, [x8, #0x800] ; selector: currentContext
102040564:     	mov	x1, x20
102040568:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204056c:     	mov	x29, x29
102040570:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102040574:     	mov	x21, x0
102040578:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10204057c:     	ldr	x0, [x8, #0xbe8]
102040580:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
102040584:     	ldr	x22, [x8, #0x508] ; selector: class
102040588:     	mov	x1, x22
10204058c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040590:     	mov	x2, x0
102040594:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102040598:     	ldr	x23, [x8, #0xa40] ; selector: getService:
10204059c:     	mov	x0, x21
1020405a0:     	mov	x1, x23
1020405a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020405a8:     	mov	x29, x29
1020405ac:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020405b0:     	mov	x24, x0
1020405b4:     	adrp	x8, 0x11ea1c000 <dyld_stub_binder+0x11ea1c000>
1020405b8:     	ldr	x1, [x8, #0x588] ; selector: sendMsgTicketList
1020405bc:     	mov	x0, x19
1020405c0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020405c4:     	mov	x29, x29
1020405c8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020405cc:     	mov	x25, x0
1020405d0:     	adrp	x8, 0x11ea1c000 <dyld_stub_binder+0x11ea1c000>
1020405d4:     	ldr	x1, [x8, #0x590] ; selector: asynUdpateContactSendMsgTicketList:
1020405d8:     	mov	x0, x24
1020405dc:     	mov	x2, x25
1020405e0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020405e4:     	mov	x0, x25
1020405e8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020405ec:     	mov	x0, x24
1020405f0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020405f4:     	mov	x0, x21
1020405f8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020405fc:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
102040600:     	ldr	x1, [x8, #0x3c8] ; selector: contactList
102040604:     	mov	x0, x19
102040608:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204060c:     	mov	x29, x29
102040610:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102040614:     	mov	x24, x0
102040618:     	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
10204061c:     	ldr	x1, [x8, #0x360] ; selector: safeObjectAtIndex:
102040620:     	mov	x2, #0x0                ; =0
102040624:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040628:     	mov	x29, x29
10204062c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102040630:     	mov	x21, x0
102040634:     	mov	x0, x24
102040638:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204063c:     	cbz	x21, 0x1020408c8 <_Flutter_Image_provideRelativePathByUrl+0x2c8d54>
102040640:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102040644:     	ldr	x0, [x8, #0xac0]
102040648:     	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
10204064c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
102040650:     	ldr	x1, [x8, #0x3d0] ; selector: initWithModContact:
102040654:     	mov	x2, x21
102040658:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204065c:     	mov	x24, x0
102040660:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102040664:     	ldr	x25, [x8, #0x618]
102040668:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10204066c:     	ldr	x27, [x8, #0x638]
102040670:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
102040674:     	ldr	x26, [x8, #0x620] ; selector: m_nsUsrName
102040678:     	mov	x1, x26
10204067c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040680:     	mov	x29, x29
102040684:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102040688:     	mov	x28, x0
10204068c:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
102040690:     	ldr	x1, [x8, #0xfb8] ; selector: generatePrivacyString:
102040694:     	mov	x0, x27
102040698:     	mov	x2, x28
10204069c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020406a0:     	mov	x29, x29
1020406a4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020406a8:     	mov	x27, x0
1020406ac:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1020406b0:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
1020406b4:     	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
1020406b8:     	add	x8, x8, #0xb78 ; CFString: Update ChatRoom Contact %@ Success.
1020406bc:     	stp	x8, x0, [sp]
1020406c0:     	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
1020406c4:     	add	x3, x3, #0x582
1020406c8:     	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
1020406cc:     	add	x5, x5, #0x24a
1020406d0:     	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
1020406d4:     	add	x7, x7, #0xd8d
1020406d8:     	mov	x0, x25
1020406dc:     	mov	w2, #0x2                ; =2
1020406e0:     	mov	w4, #0x0                ; =0
1020406e4:     	mov	w6, #0x565              ; =1381
1020406e8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020406ec:     	mov	x0, x27
1020406f0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020406f4:     	mov	x0, x28
1020406f8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020406fc:     	adrp	x8, 0x11ea1b000 <dyld_stub_binder+0x11ea1b000>
102040700:     	ldr	x1, [x8, #0x150] ; selector: m_nsChatRoomData
102040704:     	mov	x0, x24
102040708:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204070c:     	mov	x29, x29
102040710:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102040714:     	str	x0, [sp, #0x10]
102040718:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10204071c:     	ldr	x0, [x8, #0x780]
102040720:     	mov	x1, x20
102040724:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040728:     	mov	x29, x29
10204072c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102040730:     	mov	x27, x0
102040734:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102040738:     	ldr	x0, [x8, #0xbe8]
10204073c:     	mov	x1, x22
102040740:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040744:     	mov	x2, x0
102040748:     	mov	x0, x27
10204074c:     	mov	x1, x23
102040750:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040754:     	mov	x29, x29
102040758:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10204075c:     	mov	x28, x0
102040760:     	mov	x0, x24
102040764:     	mov	x1, x26
102040768:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204076c:     	mov	x29, x29
102040770:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102040774:     	mov	x25, x0
102040778:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10204077c:     	ldr	x1, [x8, #0x150] ; selector: getContactByName:
102040780:     	mov	x0, x28
102040784:     	mov	x2, x25
102040788:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204078c:     	mov	x29, x29
102040790:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102040794:     	mov	x26, x0
102040798:     	mov	x0, x25
10204079c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020407a0:     	mov	x0, x28
1020407a4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020407a8:     	mov	x0, x27
1020407ac:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020407b0:     	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1020407b4:     	ldr	x0, [x28, #0x780]
1020407b8:     	mov	x1, x20
1020407bc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020407c0:     	mov	x29, x29
1020407c4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020407c8:     	mov	x25, x0
1020407cc:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1020407d0:     	ldr	x0, [x8, #0xbe8]
1020407d4:     	mov	x1, x22
1020407d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020407dc:     	mov	x2, x0
1020407e0:     	mov	x0, x25
1020407e4:     	mov	x1, x23
1020407e8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020407ec:     	mov	x29, x29
1020407f0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020407f4:     	mov	x22, x0
1020407f8:     	adrp	x8, 0x11ea17000 <dyld_stub_binder+0x11ea17000>
1020407fc:     	ldr	x1, [x8, #0xfb0] ; selector: setContact:chatRoomData:
102040800:     	mov	x2, x26
102040804:     	ldr	x27, [sp, #0x10]
102040808:     	mov	x3, x27
10204080c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040810:     	mov	x0, x22
102040814:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102040818:     	mov	x0, x25
10204081c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102040820:     	ldr	x0, [x28, #0x780]
102040824:     	mov	x1, x20
102040828:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204082c:     	mov	x29, x29
102040830:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102040834:     	mov	x20, x0
102040838:     	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
10204083c:     	ldr	x22, [x8, #0x558]
102040840:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
102040844:     	ldr	x23, [x8, #0x738] ; selector: OnChatRoomContactUpdateOK:
102040848:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10204084c:     	ldr	x8, [x8, #0x930]
102040850:     	str	x8, [sp, #0x18]
102040854:     	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
102040858:     	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
10204085c:     	adrp	x8, 0x102040000 <_Flutter_Image_provideRelativePathByUrl+0x2c848c>
102040860:     	add	x8, x8, #0x8d0
102040864:     	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
102040868:     	add	x9, x9, #0x7e0
10204086c:     	str	d0, [sp, #0x20]
102040870:     	stp	x8, x9, [sp, #0x28]
102040874:     	str	x24, [sp, #0x38]
102040878:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10204087c:     	ldr	x25, [x8, #0xe58] ; selector: callExtension:selector:block:
102040880:     	mov	x0, x24
102040884:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102040888:     	add	x4, sp, #0x18
10204088c:     	mov	x0, x20
102040890:     	mov	x1, x25
102040894:     	mov	x2, x22
102040898:     	mov	x3, x23
10204089c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020408a0:     	mov	x0, x20
1020408a4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020408a8:     	ldr	x0, [sp, #0x38]
1020408ac:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020408b0:     	mov	x0, x24
1020408b4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020408b8:     	mov	x0, x26
1020408bc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020408c0:     	mov	x0, x27
1020408c4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020408c8:     	mov	x0, x21
1020408cc:     	b	0x102040528 <_Flutter_Image_provideRelativePathByUrl+0x2c89b4>
1020408d0:     	stp	x22, x21, [sp, #-0x30]!
1020408d4:     	stp	x20, x19, [sp, #0x10]
1020408d8:     	stp	x29, x30, [sp, #0x20]
1020408dc:     	add	x29, sp, #0x20
1020408e0:     	mov	x19, x1
1020408e4:     	ldr	x20, [x0, #0x20]
1020408e8:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1020408ec:     	ldr	x21, [x8, #0x620] ; selector: m_nsUsrName
1020408f0:     	mov	x0, x1
1020408f4:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1020408f8:     	mov	x0, x20
1020408fc:     	mov	x1, x21
102040900:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040904:     	mov	x29, x29
102040908:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10204090c:     	mov	x20, x0
102040910:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
102040914:     	ldr	x1, [x8, #0x738] ; selector: OnChatRoomContactUpdateOK:
102040918:     	mov	x0, x19
10204091c:     	mov	x2, x20
102040920:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102040924:     	mov	x0, x19
102040928:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204092c:     	mov	x0, x20
102040930:     	ldp	x29, x30, [sp, #0x20]
102040934:     	ldp	x20, x19, [sp, #0x10]
102040938:     	ldp	x22, x21, [sp], #0x30
10204093c:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102040940:     	mov	x0, x1
102040944:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
102040948:     	ldr	x1, [x8, #0x738] ; selector: OnChatRoomContactUpdateOK:
10204094c:     	mov	x2, #0x0                ; =0
102040950:     	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
