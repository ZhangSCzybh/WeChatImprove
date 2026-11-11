
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
104ddf51c:     	sub	sp, sp, #0x80
104ddf520:     	stp	x28, x27, [sp, #0x20]
104ddf524:     	stp	x26, x25, [sp, #0x30]
104ddf528:     	stp	x24, x23, [sp, #0x40]
104ddf52c:     	stp	x22, x21, [sp, #0x50]
104ddf530:     	stp	x20, x19, [sp, #0x60]
104ddf534:     	stp	x29, x30, [sp, #0x70]
104ddf538:     	add	x29, sp, #0x70
104ddf53c:     	mov	x20, x3
104ddf540:     	mov	x19, x2
104ddf544:     	mov	x21, x0
104ddf548:     	adrp	x8, 0x11f751000 <dyld_stub_binder+0x11f751000>
104ddf54c:     	mov	w9, #0x1                ; =1
104ddf550:     	strb	w9, [x8, #0xc27]
104ddf554:     	mov	x0, x2
104ddf558:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
104ddf55c:     	mov	x0, x20
104ddf560:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
104ddf564:     	cbz	x20, 0x104ddf5a0 <_Flutter_MMFoundation_BindContext+0x106626c>
104ddf568:     	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
104ddf56c:     	ldr	x1, [x8, #0xc98] ; selector: isReferMsgType
104ddf570:     	mov	x0, x20
104ddf574:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf578:     	cbz	w0, 0x104ddf5e8 <_Flutter_MMFoundation_BindContext+0x10662b4>
104ddf57c:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
104ddf580:     	ldr	x1, [x8, #0x730] ; selector: AddAppMsg:MsgWrap:Data:Scene:
104ddf584:     	mov	x0, x21
104ddf588:     	mov	x2, x19
104ddf58c:     	mov	x3, x20
104ddf590:     	mov	x4, #0x0                ; =0
104ddf594:     	mov	w5, #0x1                ; =1
104ddf598:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf59c:     	b	0x104ddfb04 <_Flutter_MMFoundation_BindContext+0x10667d0>
104ddf5a0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104ddf5a4:     	ldr	x0, [x8, #0x618]
104ddf5a8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104ddf5ac:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
104ddf5b0:     	adrp	x8, 0x11d2c2000 <dyld_stub_binder+0x11d2c2000>
104ddf5b4:     	add	x8, x8, #0x158 ; CFString: msg nil
104ddf5b8:     	str	x8, [sp]
104ddf5bc:     	adrp	x3, 0x119ba3000 <dyld_stub_binder+0x119ba3000>
104ddf5c0:     	add	x3, x3, #0x1d9
104ddf5c4:     	adrp	x5, 0x11a1b9000 <dyld_stub_binder+0x11a1b9000>
104ddf5c8:     	add	x5, x5, #0xfe2
104ddf5cc:     	adrp	x7, 0x11a1ba000 <dyld_stub_binder+0x11a1ba000>
104ddf5d0:     	add	x7, x7, #0x850
104ddf5d4:     	mov	w2, #0x4                ; =4
104ddf5d8:     	mov	w4, #0x0                ; =0
104ddf5dc:     	mov	w6, #0x427              ; =1063
104ddf5e0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf5e4:     	b	0x104ddfb04 <_Flutter_MMFoundation_BindContext+0x10667d0>
104ddf5e8:     	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
104ddf5ec:     	ldr	x1, [x8, #0xe10] ; selector: IsImgMsg
104ddf5f0:     	mov	x0, x20
104ddf5f4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf5f8:     	cbz	w0, 0x104ddf610 <_Flutter_MMFoundation_BindContext+0x10662dc>
104ddf5fc:     	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
104ddf600:     	ldr	x1, [x8, #0xd48] ; selector: UpdateContent:
104ddf604:     	mov	x0, x20
104ddf608:     	mov	x2, #0x0                ; =0
104ddf60c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf610:     	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
104ddf614:     	ldr	x1, [x8, #0xdf0] ; selector: IsTextMsg
104ddf618:     	mov	x0, x20
104ddf61c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf620:     	cbz	w0, 0x104ddf660 <_Flutter_MMFoundation_BindContext+0x106632c>
104ddf624:     	adrp	x8, 0x11ea94000 <dyld_stub_binder+0x11ea94000>
104ddf628:     	ldr	x1, [x8, #0x168] ; selector: m_easterEggIncludedType
104ddf62c:     	mov	x0, x20
104ddf630:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf634:     	cbnz	x0, 0x104ddf660 <_Flutter_MMFoundation_BindContext+0x106632c>
104ddf638:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
104ddf63c:     	ldr	x1, [x8, #0x970] ; selector: m_uiStatus
104ddf640:     	mov	x0, x20
104ddf644:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf648:     	cmp	w0, #0x1
104ddf64c:     	b.ne	0x104ddf660 <_Flutter_MMFoundation_BindContext+0x106632c>
104ddf650:     	adrp	x8, 0x11ea94000 <dyld_stub_binder+0x11ea94000>
104ddf654:     	ldr	x1, [x8, #0x530] ; selector: updateEasterEggRandomSeedIfNeeded
104ddf658:     	mov	x0, x20
104ddf65c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf660:     	adrp	x8, 0x11edc5000 <dyld_stub_binder+0x11edc5000>
104ddf664:     	ldrsw	x8, [x8, #0x6c4] ; ivar: CMessageMgr.m_oMsgDB offset=8
104ddf668:     	ldr	x0, [x21, x8]
104ddf66c:     	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
104ddf670:     	ldr	x1, [x8, #0xf10] ; selector: AddMsg:MsgWrap:
104ddf674:     	mov	x2, x19
104ddf678:     	mov	x3, x20
104ddf67c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf680:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
104ddf684:     	ldr	x1, [x8, #0xfc8] ; selector: m_uiMesLocalID
104ddf688:     	mov	x0, x20
104ddf68c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf690:     	cbz	w0, 0x104ddf784 <_Flutter_MMFoundation_BindContext+0x1066450>
104ddf694:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
104ddf698:     	ldr	x23, [x8, #0xb78] ; selector: revokeBatchId
104ddf69c:     	mov	x0, x20
104ddf6a0:     	mov	x1, x23
104ddf6a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf6a8:     	mov	x29, x29
104ddf6ac:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddf6b0:     	mov	x24, x0
104ddf6b4:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
104ddf6b8:     	ldr	x1, [x8, #0xce8] ; selector: length
104ddf6bc:     	str	x1, [sp, #0x18]
104ddf6c0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf6c4:     	mov	x25, x0
104ddf6c8:     	mov	x0, x24
104ddf6cc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddf6d0:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104ddf6d4:     	ldr	x24, [x8, #0x800] ; selector: currentContext
104ddf6d8:     	adrp	x22, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104ddf6dc:     	cbz	x25, 0x104ddf820 <_Flutter_MMFoundation_BindContext+0x10664ec>
104ddf6e0:     	ldr	x0, [x22, #0x780]
104ddf6e4:     	mov	x1, x24
104ddf6e8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf6ec:     	mov	x29, x29
104ddf6f0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddf6f4:     	mov	x27, x0
104ddf6f8:     	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
104ddf6fc:     	ldr	x0, [x8, #0xec8]
104ddf700:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104ddf704:     	ldr	x25, [x8, #0x508] ; selector: class
104ddf708:     	mov	x1, x25
104ddf70c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf710:     	mov	x2, x0
104ddf714:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104ddf718:     	ldr	x26, [x8, #0xa40] ; selector: getService:
104ddf71c:     	mov	x0, x27
104ddf720:     	mov	x1, x26
104ddf724:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf728:     	mov	x29, x29
104ddf72c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddf730:     	mov	x28, x0
104ddf734:     	mov	x0, x20
104ddf738:     	mov	x1, x23
104ddf73c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf740:     	mov	x29, x29
104ddf744:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddf748:     	mov	x23, x0
104ddf74c:     	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104ddf750:     	ldr	x1, [x8, #0xfa0] ; selector: addBatchSendForUser:record:identifier:
104ddf754:     	mov	x0, x28
104ddf758:     	mov	x2, x19
104ddf75c:     	mov	x3, x20
104ddf760:     	mov	x4, x23
104ddf764:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf768:     	mov	x0, x23
104ddf76c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddf770:     	mov	x0, x28
104ddf774:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddf778:     	mov	x0, x27
104ddf77c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddf780:     	b	0x104ddf830 <_Flutter_MMFoundation_BindContext+0x10664fc>
104ddf784:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104ddf788:     	ldr	x21, [x8, #0x618]
104ddf78c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104ddf790:     	ldr	x22, [x8, #0x638]
104ddf794:     	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
104ddf798:     	ldr	x1, [x8, #0x368] ; selector: m_nsToUsr
104ddf79c:     	mov	x0, x20
104ddf7a0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf7a4:     	mov	x29, x29
104ddf7a8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddf7ac:     	mov	x23, x0
104ddf7b0:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
104ddf7b4:     	ldr	x1, [x8, #0xfb8] ; selector: generatePrivacyString:
104ddf7b8:     	mov	x0, x22
104ddf7bc:     	mov	x2, x23
104ddf7c0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf7c4:     	mov	x29, x29
104ddf7c8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddf7cc:     	mov	x22, x0
104ddf7d0:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104ddf7d4:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
104ddf7d8:     	adrp	x8, 0x11d08f000 <dyld_stub_binder+0x11d08f000>
104ddf7dc:     	add	x8, x8, #0x6d8 ; CFString: add msg fail to usr %@ local id is 0
104ddf7e0:     	stp	x8, x0, [sp]
104ddf7e4:     	adrp	x3, 0x119ba3000 <dyld_stub_binder+0x119ba3000>
104ddf7e8:     	add	x3, x3, #0x1d9
104ddf7ec:     	adrp	x5, 0x11a1b9000 <dyld_stub_binder+0x11a1b9000>
104ddf7f0:     	add	x5, x5, #0xfe2
104ddf7f4:     	adrp	x7, 0x11a1ba000 <dyld_stub_binder+0x11a1ba000>
104ddf7f8:     	add	x7, x7, #0x850
104ddf7fc:     	mov	x0, x21
104ddf800:     	mov	w2, #0x4                ; =4
104ddf804:     	mov	w4, #0x0                ; =0
104ddf808:     	mov	w6, #0x43f              ; =1087
104ddf80c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf810:     	mov	x0, x22
104ddf814:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddf818:     	mov	x0, x23
104ddf81c:     	b	0x104ddfb00 <_Flutter_MMFoundation_BindContext+0x10667cc>
104ddf820:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104ddf824:     	ldr	x25, [x8, #0x508] ; selector: class
104ddf828:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104ddf82c:     	ldr	x26, [x8, #0xa40] ; selector: getService:
104ddf830:     	ldr	x0, [x22, #0x780]
104ddf834:     	mov	x1, x24
104ddf838:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf83c:     	mov	x29, x29
104ddf840:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddf844:     	mov	x23, x0
104ddf848:     	adrp	x8, 0x11ed1d000 <dyld_stub_binder+0x11ed1d000>
104ddf84c:     	ldr	x0, [x8, #0xc80]
104ddf850:     	mov	x1, x25
104ddf854:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf858:     	mov	x2, x0
104ddf85c:     	mov	x0, x23
104ddf860:     	mov	x1, x26
104ddf864:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf868:     	mov	x29, x29
104ddf86c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddf870:     	mov	x27, x0
104ddf874:     	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104ddf878:     	ldr	x1, [x8, #0xfa8] ; selector: tryEnqueueMsg:
104ddf87c:     	mov	x2, x20
104ddf880:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf884:     	mov	x0, x27
104ddf888:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddf88c:     	mov	x0, x23
104ddf890:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddf894:     	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104ddf898:     	ldr	x0, [x27, #0x8a0]
104ddf89c:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
104ddf8a0:     	ldr	x1, [x8, #0x38] ; selector: genServerCurrentTime
104ddf8a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf8a8:     	mov	x2, x0
104ddf8ac:     	adrp	x8, 0x11e9f2000 <dyld_stub_binder+0x11e9f2000>
104ddf8b0:     	ldr	x1, [x8, #0xdb8] ; selector: setM_uiSendTime:
104ddf8b4:     	mov	x0, x20
104ddf8b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf8bc:     	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
104ddf8c0:     	ldr	x23, [x8, #0x3f0] ; selector: m_uiMessageType
104ddf8c4:     	mov	x0, x20
104ddf8c8:     	mov	x1, x23
104ddf8cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf8d0:     	cmp	w0, #0x22
104ddf8d4:     	b.ne	0x104ddfa74 <_Flutter_MMFoundation_BindContext+0x1066740>
104ddf8d8:     	mov	x0, x20
104ddf8dc:     	mov	x1, x23
104ddf8e0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf8e4:     	cmp	w0, #0x1
104ddf8e8:     	b.ne	0x104ddf96c <_Flutter_MMFoundation_BindContext+0x1066638>
104ddf8ec:     	adrp	x25, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104ddf8f0:     	ldr	x0, [x25, #0xee8]
104ddf8f4:     	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104ddf8f8:     	ldr	x1, [x8, #0xfd0] ; selector: needParserAddress
104ddf8fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf900:     	cbz	w0, 0x104ddf96c <_Flutter_MMFoundation_BindContext+0x1066638>
104ddf904:     	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
104ddf908:     	ldr	x1, [x8, #0x460] ; selector: m_nsContent
104ddf90c:     	mov	x0, x20
104ddf910:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf914:     	mov	x29, x29
104ddf918:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddf91c:     	mov	x24, x0
104ddf920:     	ldr	x25, [x25, #0xee8]
104ddf924:     	ldr	x1, [sp, #0x18]
104ddf928:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf92c:     	mov	x4, x0
104ddf930:     	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
104ddf934:     	ldr	x1, [x8, #0x1a0] ; selector: RangeOfObjectInString:withRange:
104ddf938:     	mov	x0, x25
104ddf93c:     	mov	x2, x24
104ddf940:     	mov	x3, #0x0                ; =0
104ddf944:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf948:     	cbz	x1, 0x104ddf964 <_Flutter_MMFoundation_BindContext+0x1066630>
104ddf94c:     	adrp	x1, 0x11cfc1000 <dyld_stub_binder+0x11cfc1000>
104ddf950:     	add	x1, x1, #0x218 ; CFString: 6
104ddf954:     	mov	w0, #0x3209             ; =12809
104ddf958:     	mov	w2, #0x0                ; =0
104ddf95c:     	mov	w3, #0x0                ; =0
104ddf960:     	bl	0x10241a0cc <_Flutter_Image_provideRelativePathByUrl+0x6a2558>
104ddf964:     	mov	x0, x24
104ddf968:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddf96c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104ddf970:     	ldr	x0, [x8, #0x658]
104ddf974:     	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
104ddf978:     	ldr	x1, [x8, #0xdb0] ; selector: arrayWithObject:
104ddf97c:     	mov	x2, x20
104ddf980:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf984:     	mov	x29, x29
104ddf988:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddf98c:     	mov	x22, x0
104ddf990:     	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104ddf994:     	ldr	x1, [x8, #0xfd8] ; selector: HandleMsgList:MsgList:
104ddf998:     	mov	x0, x21
104ddf99c:     	mov	x2, x19
104ddf9a0:     	mov	x3, x22
104ddf9a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf9a8:     	mov	x0, x22
104ddf9ac:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddf9b0:     	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104ddf9b4:     	ldr	x1, [x8, #0xfe0] ; selector: AsyncOnPreAddMsg:MsgWrap:
104ddf9b8:     	mov	x0, x21
104ddf9bc:     	mov	x2, x19
104ddf9c0:     	mov	x3, x20
104ddf9c4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf9c8:     	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104ddf9cc:     	ldr	x1, [x8, #0xfe8] ; selector: AsyncOnAddMsg:MsgWrap:
104ddf9d0:     	mov	x0, x21
104ddf9d4:     	mov	x2, x19
104ddf9d8:     	mov	x3, x20
104ddf9dc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf9e0:     	adrp	x8, 0x11e9f0000 <dyld_stub_binder+0x11e9f0000>
104ddf9e4:     	ldr	x1, [x8, #0xf98] ; selector: AsyncOnAddMsgForSession:MsgWrap:
104ddf9e8:     	mov	x0, x21
104ddf9ec:     	mov	x2, x19
104ddf9f0:     	mov	x3, x20
104ddf9f4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddf9f8:     	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
104ddf9fc:     	ldr	x0, [x8, #0xda8]
104ddfa00:     	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
104ddfa04:     	ldr	x1, [x8, #0x8e8] ; selector: getPluginUserNameType:
104ddfa08:     	mov	x2, x19
104ddfa0c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfa10:     	cmp	x0, #0x5
104ddfa14:     	b.ne	0x104ddfb04 <_Flutter_MMFoundation_BindContext+0x10667d0>
104ddfa18:     	mov	x0, x20
104ddfa1c:     	mov	x1, x23
104ddfa20:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfa24:     	cmp	w0, #0x22
104ddfa28:     	b.eq	0x104ddfb04 <_Flutter_MMFoundation_BindContext+0x10667d0>
104ddfa2c:     	ldr	x0, [x27, #0x8a0]
104ddfa30:     	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
104ddfa34:     	ldr	x1, [x8, #0x90] ; selector: CheckSyncMediaNote:
104ddfa38:     	mov	x2, x19
104ddfa3c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfa40:     	tbnz	w0, #0x0, 0x104ddfb04 <_Flutter_MMFoundation_BindContext+0x10667d0>
104ddfa44:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
104ddfa48:     	ldr	x1, [x8, #0xa88] ; selector: setM_uiStatus:
104ddfa4c:     	mov	x0, x20
104ddfa50:     	mov	w2, #0x2                ; =2
104ddfa54:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfa58:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
104ddfa5c:     	ldr	x1, [x8, #0x720] ; selector: ModMsg:MsgWrap:
104ddfa60:     	mov	x0, x21
104ddfa64:     	mov	x2, x19
104ddfa68:     	mov	x3, x20
104ddfa6c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfa70:     	b	0x104ddfb04 <_Flutter_MMFoundation_BindContext+0x10667d0>
104ddfa74:     	adrp	x8, 0x11ea3a000 <dyld_stub_binder+0x11ea3a000>
104ddfa78:     	ldr	x1, [x8, #0xcb8] ; selector: m_uiImgStatus
104ddfa7c:     	mov	x0, x20
104ddfa80:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfa84:     	cmp	w0, #0x2
104ddfa88:     	b.ne	0x104ddfb30 <_Flutter_MMFoundation_BindContext+0x10667fc>
104ddfa8c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104ddfa90:     	ldr	x0, [x8, #0xe10]
104ddfa94:     	adrp	x8, 0x11ea3a000 <dyld_stub_binder+0x11ea3a000>
104ddfa98:     	ldr	x1, [x8, #0xce8] ; selector: clearLocalImage:
104ddfa9c:     	mov	x2, x20
104ddfaa0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfaa4:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
104ddfaa8:     	ldr	x1, [x8, #0xdc8] ; selector: m_asset
104ddfaac:     	mov	x0, x20
104ddfab0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfab4:     	mov	x29, x29
104ddfab8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddfabc:     	mov	x24, x0
104ddfac0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddfac4:     	cbz	x24, 0x104ddfc6c <_Flutter_MMFoundation_BindContext+0x1066938>
104ddfac8:     	adrp	x8, 0x11ea66000 <dyld_stub_binder+0x11ea66000>
104ddfacc:     	ldr	x1, [x8, #0xa80] ; selector: assetThreshold
104ddfad0:     	mov	x0, x21
104ddfad4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfad8:     	mov	x29, x29
104ddfadc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddfae0:     	mov	x22, x0
104ddfae4:     	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104ddfae8:     	ldr	x1, [x8, #0xfb0] ; selector: genImageFromMMAssetAndNotify:threshold:
104ddfaec:     	mov	x0, x20
104ddfaf0:     	mov	x2, x21
104ddfaf4:     	mov	x3, x22
104ddfaf8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfafc:     	mov	x0, x22
104ddfb00:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddfb04:     	mov	x0, x20
104ddfb08:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddfb0c:     	mov	x0, x19
104ddfb10:     	ldp	x29, x30, [sp, #0x70]
104ddfb14:     	ldp	x20, x19, [sp, #0x60]
104ddfb18:     	ldp	x22, x21, [sp, #0x50]
104ddfb1c:     	ldp	x24, x23, [sp, #0x40]
104ddfb20:     	ldp	x26, x25, [sp, #0x30]
104ddfb24:     	ldp	x28, x27, [sp, #0x20]
104ddfb28:     	add	sp, sp, #0x80
104ddfb2c:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddfb30:     	adrp	x8, 0x11e9f3000 <dyld_stub_binder+0x11e9f3000>
104ddfb34:     	ldr	x1, [x8, #0xb8] ; selector: IsBypassMessage
104ddfb38:     	mov	x0, x20
104ddfb3c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfb40:     	cbz	w0, 0x104ddfb64 <_Flutter_MMFoundation_BindContext+0x1066830>
104ddfb44:     	adrp	x8, 0x11edc5000 <dyld_stub_binder+0x11edc5000>
104ddfb48:     	ldrsw	x8, [x8, #0x6c8] ; ivar: CMessageMgr.m_bypSendMessageMgr offset=24
104ddfb4c:     	ldr	x0, [x21, x8]
104ddfb50:     	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104ddfb54:     	ldr	x1, [x8, #0xfc0] ; selector: StartSendMsg:
104ddfb58:     	mov	x2, x20
104ddfb5c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfb60:     	b	0x104ddf8d8 <_Flutter_MMFoundation_BindContext+0x10665a4>
104ddfb64:     	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
104ddfb68:     	ldr	x0, [x8, #0xda8]
104ddfb6c:     	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
104ddfb70:     	ldr	x1, [x8, #0x8e8] ; selector: getPluginUserNameType:
104ddfb74:     	mov	x2, x19
104ddfb78:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfb7c:     	cmp	x0, #0x5
104ddfb80:     	b.ne	0x104ddfb9c <_Flutter_MMFoundation_BindContext+0x1066868>
104ddfb84:     	ldr	x0, [x27, #0x8a0]
104ddfb88:     	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
104ddfb8c:     	ldr	x1, [x8, #0x90] ; selector: CheckSyncMediaNote:
104ddfb90:     	mov	x2, x19
104ddfb94:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfb98:     	cbz	w0, 0x104ddf8d8 <_Flutter_MMFoundation_BindContext+0x10665a4>
104ddfb9c:     	ldr	x0, [x22, #0x780]
104ddfba0:     	mov	x1, x24
104ddfba4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfba8:     	mov	x29, x29
104ddfbac:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddfbb0:     	mov	x27, x0
104ddfbb4:     	adrp	x8, 0x11ed20000 <dyld_stub_binder+0x11ed20000>
104ddfbb8:     	ldr	x0, [x8, #0xa48]
104ddfbbc:     	mov	x1, x25
104ddfbc0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfbc4:     	mov	x2, x0
104ddfbc8:     	mov	x0, x27
104ddfbcc:     	mov	x1, x26
104ddfbd0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfbd4:     	mov	x29, x29
104ddfbd8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddfbdc:     	mov	x28, x0
104ddfbe0:     	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104ddfbe4:     	ldr	x1, [x8, #0xfc8] ; selector: AddMsgToSendTable:MsgWrap:
104ddfbe8:     	mov	x2, x19
104ddfbec:     	mov	x3, x20
104ddfbf0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfbf4:     	mov	x0, x28
104ddfbf8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddfbfc:     	mov	x0, x27
104ddfc00:     	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104ddfc04:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddfc08:     	ldr	x0, [x22, #0x780]
104ddfc0c:     	mov	x1, x24
104ddfc10:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfc14:     	mov	x29, x29
104ddfc18:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddfc1c:     	mov	x24, x0
104ddfc20:     	adrp	x8, 0x11ed20000 <dyld_stub_binder+0x11ed20000>
104ddfc24:     	ldr	x0, [x8, #0xa48]
104ddfc28:     	mov	x1, x25
104ddfc2c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfc30:     	mov	x2, x0
104ddfc34:     	mov	x0, x24
104ddfc38:     	mov	x1, x26
104ddfc3c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfc40:     	mov	x29, x29
104ddfc44:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104ddfc48:     	mov	x25, x0
104ddfc4c:     	adrp	x8, 0x11ea55000 <dyld_stub_binder+0x11ea55000>
104ddfc50:     	ldr	x1, [x8, #0xce8] ; selector: SendMsg
104ddfc54:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfc58:     	mov	x0, x25
104ddfc5c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddfc60:     	mov	x0, x24
104ddfc64:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104ddfc68:     	b	0x104ddf8d8 <_Flutter_MMFoundation_BindContext+0x10665a4>
104ddfc6c:     	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104ddfc70:     	ldr	x1, [x8, #0xfb8] ; selector: StartUploadImageMsg:MsgWrap:
104ddfc74:     	mov	x0, x21
104ddfc78:     	mov	x2, x19
104ddfc7c:     	mov	x3, x20
104ddfc80:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104ddfc84:     	b	0x104ddf8d8 <_Flutter_MMFoundation_BindContext+0x10665a4>
