-[CSCustomViewController setupUI]:
    45b4:	stp	x22, x21, [sp, #-0x30]!
    45b8:	stp	x20, x19, [sp, #0x10]
    45bc:	stp	x29, x30, [sp, #0x20]
    45c0:	add	x29, sp, #0x20
    45c4:	mov	x19, x0
    45c8:	adrp	x22, _OBJC_CLASSLIST_REFERENCES_$_@PAGE
    45cc:	ldr	x0, [x22, _OBJC_CLASSLIST_REFERENCES_$_@PAGEOFF]
    45d0:	bl	_objc_msgSend$systemGroupedBackgroundColor
    45d4:	mov	x29, x29
    45d8:	bl	_objc_retainAutoreleasedReturnValue
    45dc:	mov	x20, x0
    45e0:	mov	x0, x19
    45e4:	bl	_objc_msgSend$view
    45e8:	mov	x29, x29
    45ec:	bl	_objc_retainAutoreleasedReturnValue
    45f0:	mov	x21, x0
    45f4:	mov	x2, x20
    45f8:	bl	"_objc_msgSend$setBackgroundColor:"
    45fc:	mov	x0, x21
    4600:	bl	_objc_release
    4604:	mov	x0, x20
    4608:	bl	_objc_release
    460c:	adrp	x8, _OBJC_CLASSLIST_REFERENCES_$_.285@PAGE
    4610:	ldr	x0, [x8, _OBJC_CLASSLIST_REFERENCES_$_.285@PAGEOFF]
    4614:	bl	_objc_alloc
    4618:	mov	x20, x0
    461c:	mov	x0, x19
    4620:	bl	_objc_msgSend$view
    4624:	mov	x29, x29
    4628:	bl	_objc_retainAutoreleasedReturnValue
    462c:	mov	x21, x0
    4630:	bl	_objc_msgSend$bounds
    4634:	mov	x0, x20
    4638:	mov	w2, #0x2
    463c:	bl	"_objc_msgSend$initWithFrame:style:"
    4640:	mov	x20, x0
    4644:	mov	x0, x19
    4648:	mov	x2, x20
    464c:	bl	"_objc_msgSend$setTableView:"
    4650:	mov	x0, x20
    4654:	bl	_objc_release
    4658:	mov	x0, x21
    465c:	bl	_objc_release
    4660:	mov	x0, x19
    4664:	bl	_objc_msgSend$tableView
    4668:	mov	x29, x29
    466c:	bl	_objc_retainAutoreleasedReturnValue
    4670:	mov	x20, x0
    4674:	fmov	d0, xzr
    4678:	bl	"_objc_msgSend$setEstimatedSectionHeaderHeight:"
    467c:	mov	x0, x20
    4680:	bl	_objc_release
    4684:	mov	x0, x19
    4688:	bl	_objc_msgSend$tableView
    468c:	mov	x29, x29
    4690:	bl	_objc_retainAutoreleasedReturnValue
    4694:	mov	x20, x0
    4698:	mov	w2, #0x12
    469c:	bl	"_objc_msgSend$setAutoresizingMask:"
    46a0:	mov	x0, x20
    46a4:	bl	_objc_release
    46a8:	ldr	x0, [x22, _OBJC_CLASSLIST_REFERENCES_$_@PAGEOFF]
    46ac:	bl	_objc_msgSend$systemGroupedBackgroundColor
    46b0:	mov	x29, x29
    46b4:	bl	_objc_retainAutoreleasedReturnValue
    46b8:	mov	x20, x0
    46bc:	mov	x0, x19
    46c0:	bl	_objc_msgSend$tableView
    46c4:	mov	x29, x29
    46c8:	bl	_objc_retainAutoreleasedReturnValue
    46cc:	mov	x21, x0
    46d0:	mov	x2, x20
    46d4:	bl	"_objc_msgSend$setBackgroundColor:"
    46d8:	mov	x0, x21
    46dc:	bl	_objc_release
    46e0:	mov	x0, x20
    46e4:	bl	_objc_release
    46e8:	mov	x0, x19
    46ec:	bl	_objc_msgSend$tableView
    46f0:	mov	x29, x29
    46f4:	bl	_objc_retainAutoreleasedReturnValue
    46f8:	mov	x20, x0
    46fc:	mov	w2, #0x1
    4700:	bl	"_objc_msgSend$setSeparatorStyle:"
    4704:	mov	x0, x20
    4708:	bl	_objc_release
    470c:	mov	x0, x19
    4710:	bl	_objc_msgSend$tableView
    4714:	mov	x29, x29
    4718:	bl	_objc_retainAutoreleasedReturnValue
    471c:	mov	x20, x0
    4720:	mov	x8, #0x404b000000000000
    4724:	fmov	d1, x8
    4728:	fmov	d0, xzr
    472c:	fmov	d2, xzr
    4730:	fmov	d3, xzr
    4734:	bl	"_objc_msgSend$setSeparatorInset:"
    4738:	mov	x0, x20
    473c:	bl	_objc_release
    4740:	mov	x0, x19
    4744:	bl	_objc_msgSend$headerView
    4748:	mov	x29, x29
    474c:	bl	_objc_retainAutoreleasedReturnValue
    4750:	mov	x20, x0
    4754:	mov	x0, x19
    4758:	bl	_objc_msgSend$tableView
    475c:	mov	x29, x29
    4760:	bl	_objc_retainAutoreleasedReturnValue
    4764:	mov	x21, x0
    4768:	mov	x2, x20
    476c:	bl	"_objc_msgSend$setTableHeaderView:"
    4770:	mov	x0, x21
    4774:	bl	_objc_release
    4778:	mov	x0, x20
    477c:	bl	_objc_release
    4780:	mov	x0, x19
    4784:	bl	_objc_msgSend$tableView
    4788:	mov	x29, x29
    478c:	bl	_objc_retainAutoreleasedReturnValue
    4790:	mov	x20, x0
    4794:	mov	x2, x19
    4798:	bl	"_objc_msgSend$setDelegate:"
    479c:	mov	x0, x20
    47a0:	bl	_objc_release
    47a4:	mov	x0, x19
    47a8:	bl	_objc_msgSend$tableView
    47ac:	mov	x29, x29
    47b0:	bl	_objc_retainAutoreleasedReturnValue
    47b4:	mov	x20, x0
    47b8:	mov	x2, x19
    47bc:	bl	"_objc_msgSend$setDataSource:"
    47c0:	mov	x0, x20
    47c4:	bl	_objc_release
    47c8:	adrp	x8, _OBJC_CLASSLIST_REFERENCES_$_.9@PAGE
    47cc:	ldr	x20, [x8, _OBJC_CLASSLIST_REFERENCES_$_.9@PAGEOFF]
    47d0:	mov	x0, x19
    47d4:	bl	_objc_msgSend$tableView
    47d8:	mov	x29, x29
    47dc:	bl	_objc_retainAutoreleasedReturnValue
    47e0:	mov	x21, x0
    47e4:	mov	x0, x20
    47e8:	mov	x2, x21
    47ec:	bl	"_objc_msgSend$registerToTableView:"
    47f0:	mov	x0, x21
    47f4:	bl	_objc_release
    47f8:	mov	x0, x19
    47fc:	bl	_objc_msgSend$view
    4800:	mov	x29, x29
    4804:	bl	_objc_retainAutoreleasedReturnValue
    4808:	mov	x20, x0
    480c:	mov	x0, x19
    4810:	bl	_objc_msgSend$tableView
    4814:	mov	x29, x29
    4818:	bl	_objc_retainAutoreleasedReturnValue
    481c:	mov	x19, x0
    4820:	mov	x0, x20
    4824:	mov	x2, x19
    4828:	bl	"_objc_msgSend$addSubview:"
    482c:	mov	x0, x19
    4830:	bl	_objc_release
    4834:	mov	x0, x20
    4838:	ldp	x29, x30, [sp, #0x20]
    483c:	ldp	x20, x19, [sp, #0x10]
    4840:	ldp	x22, x21, [sp], #0x30
    4844:	b	_objc_release
