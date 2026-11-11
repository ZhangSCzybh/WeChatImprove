
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f9b45c:     	sub	sp, sp, #0xa0
100f9b460:     	stp	x28, x27, [sp, #0x40]
100f9b464:     	stp	x26, x25, [sp, #0x50]
100f9b468:     	stp	x24, x23, [sp, #0x60]
100f9b46c:     	stp	x22, x21, [sp, #0x70]
100f9b470:     	stp	x20, x19, [sp, #0x80]
100f9b474:     	stp	x29, x30, [sp, #0x90]
100f9b478:     	add	x29, sp, #0x90
100f9b47c:     	mov	x23, x2
100f9b480:     	mov	x19, x0
100f9b484:     	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100f9b488:     	mov	w9, #0x1                ; =1
100f9b48c:     	strb	w9, [x8, #0x779]
100f9b490:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b494:     	ldr	x21, [x8, #0x618]
100f9b498:     	adrp	x8, 0x11ed88000 <dyld_stub_binder+0x11ed88000>
100f9b49c:     	ldrsw	x20, [x8, #0xfb8]
100f9b4a0:     	ldr	x0, [x0, x20]
100f9b4a4:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100f9b4a8:     	ldr	x27, [x8, #0x620] ; selector: m_nsUsrName
100f9b4ac:     	mov	x1, x27
100f9b4b0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b4b4:     	mov	x29, x29
100f9b4b8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b4bc:     	mov	x22, x0
100f9b4c0:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100f9b4c4:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
100f9b4c8:     	str	x23, [sp, #0x30]
100f9b4cc:     	stp	x0, x23, [sp, #0x8]
100f9b4d0:     	adrp	x8, 0x11d044000 <dyld_stub_binder+0x11d044000>
100f9b4d4:     	add	x8, x8, #0x178 ; CFString: Do QuitGroup: %@ %u
100f9b4d8:     	str	x8, [sp]
100f9b4dc:     	adrp	x5, 0x119ce6000 <dyld_stub_binder+0x119ce6000>
100f9b4e0:     	add	x5, x5, #0x900
100f9b4e4:     	adrp	x7, 0x119ce7000 <dyld_stub_binder+0x119ce7000>
100f9b4e8:     	add	x7, x7, #0x1f6
100f9b4ec:     	mov	x0, x21
100f9b4f0:     	mov	w2, #0x2                ; =2
100f9b4f4:     	mov	x3, #0x0                ; =0
100f9b4f8:     	mov	w4, #0x0                ; =0
100f9b4fc:     	mov	w6, #0x85a              ; =2138
100f9b500:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b504:     	mov	x0, x22
100f9b508:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b50c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b510:     	ldr	x0, [x8, #0x780]
100f9b514:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100f9b518:     	ldr	x21, [x8, #0x800] ; selector: currentContext
100f9b51c:     	mov	x1, x21
100f9b520:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b524:     	mov	x29, x29
100f9b528:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b52c:     	mov	x25, x0
100f9b530:     	adrp	x23, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
100f9b534:     	ldr	x0, [x23, #0x9f0]
100f9b538:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100f9b53c:     	ldr	x22, [x8, #0x508] ; selector: class
100f9b540:     	mov	x1, x22
100f9b544:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b548:     	mov	x2, x0
100f9b54c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100f9b550:     	ldr	x24, [x8, #0xa40] ; selector: getService:
100f9b554:     	mov	x0, x25
100f9b558:     	mov	x1, x24
100f9b55c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b560:     	mov	x29, x29
100f9b564:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b568:     	mov	x26, x0
100f9b56c:     	ldr	x0, [x19, x20]
100f9b570:     	str	x27, [sp, #0x38]
100f9b574:     	mov	x1, x27
100f9b578:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b57c:     	mov	x29, x29
100f9b580:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b584:     	mov	x27, x0
100f9b588:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100f9b58c:     	ldr	x1, [x8, #0x4d0] ; selector: IsOpenWXTalkMode:
100f9b590:     	mov	x0, x26
100f9b594:     	mov	x2, x27
100f9b598:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b59c:     	mov	x28, x0
100f9b5a0:     	mov	x0, x27
100f9b5a4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b5a8:     	mov	x0, x26
100f9b5ac:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b5b0:     	mov	x0, x25
100f9b5b4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b5b8:     	cbz	w28, 0x100f9b620 <__text+0xf93620>
100f9b5bc:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b5c0:     	ldr	x0, [x8, #0x780]
100f9b5c4:     	mov	x1, x21
100f9b5c8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b5cc:     	mov	x29, x29
100f9b5d0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b5d4:     	mov	x25, x0
100f9b5d8:     	ldr	x0, [x23, #0x9f0]
100f9b5dc:     	mov	x1, x22
100f9b5e0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b5e4:     	mov	x2, x0
100f9b5e8:     	mov	x0, x25
100f9b5ec:     	mov	x1, x24
100f9b5f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b5f4:     	mov	x29, x29
100f9b5f8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b5fc:     	mov	x26, x0
100f9b600:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100f9b604:     	ldr	x1, [x8, #0x4d8] ; selector: CloseWXTalkModeAndNotifyUI:
100f9b608:     	mov	w2, #0x1                ; =1
100f9b60c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b610:     	mov	x0, x26
100f9b614:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b618:     	mov	x0, x25
100f9b61c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b620:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b624:     	ldr	x0, [x8, #0x780]
100f9b628:     	mov	x1, x21
100f9b62c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b630:     	mov	x29, x29
100f9b634:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b638:     	mov	x26, x0
100f9b63c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b640:     	ldr	x0, [x8, #0xb78]
100f9b644:     	mov	x1, x22
100f9b648:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b64c:     	mov	x2, x0
100f9b650:     	mov	x0, x26
100f9b654:     	mov	x1, x24
100f9b658:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b65c:     	mov	x29, x29
100f9b660:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b664:     	mov	x25, x0
100f9b668:     	mov	x0, x26
100f9b66c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b670:     	cbz	x25, 0x100f9b894 <__text+0xf93894>
100f9b674:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100f9b678:     	ldr	x1, [x8, #0xe18] ; selector: startLoadingNonBlock
100f9b67c:     	mov	x0, x19
100f9b680:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b684:     	ldr	x0, [x19, x20]
100f9b688:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100f9b68c:     	ldr	x1, [x8, #0xed0] ; selector: m_uiType
100f9b690:     	str	x1, [sp, #0x28]
100f9b694:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b698:     	mov	x28, x0
100f9b69c:     	ldr	x0, [x19, x20]
100f9b6a0:     	ldr	x1, [sp, #0x38]
100f9b6a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b6a8:     	mov	x29, x29
100f9b6ac:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b6b0:     	mov	x27, x0
100f9b6b4:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b6b8:     	ldr	x0, [x8, #0x9d0]
100f9b6bc:     	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
100f9b6c0:     	ldr	x1, [x8, #0x120] ; selector: getLocalUsrName:
100f9b6c4:     	mov	w2, #0x0                ; =0
100f9b6c8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b6cc:     	mov	x29, x29
100f9b6d0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b6d4:     	mov	x23, x0
100f9b6d8:     	adrp	x8, 0x11ea17000 <dyld_stub_binder+0x11ea17000>
100f9b6dc:     	ldr	x1, [x8, #0x7a8] ; selector: QuitGroup:withUsrName:deleteAllMsg:
100f9b6e0:     	mov	x0, x25
100f9b6e4:     	mov	x2, x27
100f9b6e8:     	mov	x3, x23
100f9b6ec:     	ldr	x4, [sp, #0x30]
100f9b6f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b6f4:     	mov	x0, x23
100f9b6f8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b6fc:     	mov	x0, x27
100f9b700:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b704:     	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b708:     	ldr	x0, [x27, #0x780]
100f9b70c:     	mov	x1, x21
100f9b710:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b714:     	mov	x29, x29
100f9b718:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b71c:     	mov	x23, x0
100f9b720:     	str	x0, [sp, #0x30]
100f9b724:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b728:     	ldr	x0, [x8, #0xbe8]
100f9b72c:     	mov	x1, x22
100f9b730:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b734:     	mov	x2, x0
100f9b738:     	mov	x0, x23
100f9b73c:     	mov	x1, x24
100f9b740:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b744:     	mov	x29, x29
100f9b748:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b74c:     	ldr	x8, [x19, x20]
100f9b750:     	stp	x0, x8, [sp, #0x18]
100f9b754:     	adrp	x26, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b758:     	ldr	x0, [x26, #0x638]
100f9b75c:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
100f9b760:     	ldr	x23, [x8, #0x5c8] ; selector: stringWithFormat:
100f9b764:     	str	x28, [sp]
100f9b768:     	adrp	x2, 0x11cf9d000 <dyld_stub_binder+0x11cf9d000>
100f9b76c:     	add	x2, x2, #0xff8 ; CFString: %d
100f9b770:     	mov	x1, x23
100f9b774:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b778:     	mov	x29, x29
100f9b77c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b780:     	mov	x28, x0
100f9b784:     	ldr	x26, [x26, #0x638]
100f9b788:     	ldr	x0, [x27, #0x780]
100f9b78c:     	mov	x1, x21
100f9b790:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b794:     	mov	x29, x29
100f9b798:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b79c:     	mov	x21, x0
100f9b7a0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b7a4:     	ldr	x0, [x8, #0xbe8]
100f9b7a8:     	mov	x1, x22
100f9b7ac:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b7b0:     	mov	x2, x0
100f9b7b4:     	mov	x0, x21
100f9b7b8:     	mov	x1, x24
100f9b7bc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b7c0:     	mov	x29, x29
100f9b7c4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b7c8:     	mov	x22, x0
100f9b7cc:     	ldr	x0, [x19, x20]
100f9b7d0:     	ldr	x1, [sp, #0x38]
100f9b7d4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b7d8:     	mov	x29, x29
100f9b7dc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b7e0:     	mov	x19, x0
100f9b7e4:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100f9b7e8:     	ldr	x1, [x8, #0x150] ; selector: getContactByName:
100f9b7ec:     	mov	x0, x22
100f9b7f0:     	mov	x2, x19
100f9b7f4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b7f8:     	mov	x29, x29
100f9b7fc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b800:     	mov	x20, x0
100f9b804:     	ldr	x1, [sp, #0x28]
100f9b808:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b80c:     	str	x0, [sp]
100f9b810:     	mov	x0, x26
100f9b814:     	mov	x1, x23
100f9b818:     	adrp	x2, 0x11cf9d000 <dyld_stub_binder+0x11cf9d000>
100f9b81c:     	add	x2, x2, #0xff8 ; CFString: %d
100f9b820:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b824:     	mov	x29, x29
100f9b828:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b82c:     	mov	x23, x0
100f9b830:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100f9b834:     	ldr	x1, [x8, #0x548] ; selector: reportContactImportantChangeData:actionCode:actionScene:oldValue:newValue:
100f9b838:     	ldp	x24, x2, [sp, #0x18]
100f9b83c:     	mov	x0, x24
100f9b840:     	mov	w3, #0x6                ; =6
100f9b844:     	mov	w4, #0x3                ; =3
100f9b848:     	mov	x5, x28
100f9b84c:     	mov	x6, x23
100f9b850:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b854:     	mov	x0, x23
100f9b858:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b85c:     	mov	x0, x20
100f9b860:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b864:     	mov	x0, x19
100f9b868:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b86c:     	mov	x0, x22
100f9b870:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b874:     	mov	x0, x21
100f9b878:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b87c:     	mov	x0, x28
100f9b880:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b884:     	mov	x0, x24
100f9b888:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b88c:     	ldr	x0, [sp, #0x30]
100f9b890:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b894:     	mov	x0, x25
100f9b898:     	ldp	x29, x30, [sp, #0x90]
100f9b89c:     	ldp	x20, x19, [sp, #0x80]
100f9b8a0:     	ldp	x22, x21, [sp, #0x70]
100f9b8a4:     	ldp	x24, x23, [sp, #0x60]
100f9b8a8:     	ldp	x26, x25, [sp, #0x50]
100f9b8ac:     	ldp	x28, x27, [sp, #0x40]
100f9b8b0:     	add	sp, sp, #0xa0
100f9b8b4:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
