
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1003905d8:     	sub	sp, sp, #0x70
1003905dc:     	stp	x26, x25, [sp, #0x20]
1003905e0:     	stp	x24, x23, [sp, #0x30]
1003905e4:     	stp	x22, x21, [sp, #0x40]
1003905e8:     	stp	x20, x19, [sp, #0x50]
1003905ec:     	stp	x29, x30, [sp, #0x60]
1003905f0:     	add	x29, sp, #0x60
1003905f4:     	mov	x20, x3
1003905f8:     	mov	x19, x2
1003905fc:     	mov	x22, x0
100390600:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
100390604:     	mov	w9, #0x1                ; =1
100390608:     	strb	w9, [x8, #0xc07]
10039060c:     	mov	x0, x2
100390610:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100390614:     	mov	x0, x20
100390618:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10039061c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390620:     	ldr	x23, [x8, #0x460] ; selector: retryCountByRoomName
100390624:     	mov	x0, x22
100390628:     	mov	x1, x23
10039062c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390630:     	mov	x29, x29
100390634:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390638:     	mov	x24, x0
10039063c:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100390640:     	ldr	x1, [x8, #0x650] ; selector: objectForKeyedSubscript:
100390644:     	mov	x2, x19
100390648:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039064c:     	mov	x29, x29
100390650:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390654:     	mov	x25, x0
100390658:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10039065c:     	ldr	x1, [x8, #0xad0] ; selector: unsignedIntegerValue
100390660:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390664:     	mov	x21, x0
100390668:     	mov	x0, x25
10039066c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390670:     	mov	x0, x24
100390674:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390678:     	cmp	x21, #0x3
10039067c:     	b.hs	0x1003906f8 <__text+0x3886f8>
100390680:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100390684:     	ldr	x0, [x8, #0x6c0]
100390688:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
10039068c:     	ldr	x1, [x8, #0x5e0] ; selector: numberWithUnsignedInteger:
100390690:     	add	x2, x21, #0x1
100390694:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390698:     	mov	x29, x29
10039069c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003906a0:     	mov	x24, x0
1003906a4:     	mov	x0, x22
1003906a8:     	mov	x1, x23
1003906ac:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003906b0:     	mov	x29, x29
1003906b4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003906b8:     	mov	x22, x0
1003906bc:     	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1003906c0:     	ldr	x1, [x8, #0x298] ; selector: setObject:forKeyedSubscript:
1003906c4:     	mov	x2, x24
1003906c8:     	mov	x3, x19
1003906cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003906d0:     	mov	x0, x22
1003906d4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003906d8:     	mov	x0, x24
1003906dc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003906e0:     	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
1003906e4:     	ldr	x1, [x8, #0xa38] ; selector: addObject:
1003906e8:     	mov	x0, x20
1003906ec:     	mov	x2, x19
1003906f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003906f4:     	b	0x100390780 <__text+0x388780>
1003906f8:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1003906fc:     	ldr	x0, [x8, #0x618]
100390700:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100390704:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
100390708:     	mov	w8, #0x3                ; =3
10039070c:     	stp	x21, x8, [sp, #0x10]
100390710:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
100390714:     	add	x8, x8, #0xf78 ; CFString: retry exhausted, room:%@ retryCount:%lu maxRetryCount:%lu
100390718:     	stp	x8, x19, [sp]
10039071c:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
100390720:     	add	x3, x3, #0xff4
100390724:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100390728:     	add	x5, x5, #0xb
10039072c:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100390730:     	add	x7, x7, #0x657
100390734:     	mov	w2, #0x3                ; =3
100390738:     	mov	w4, #0x0                ; =0
10039073c:     	mov	w6, #0x1a0              ; =416
100390740:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390744:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390748:     	ldr	x1, [x8, #0x478] ; selector: genericQuitFailureMessage
10039074c:     	mov	x0, x22
100390750:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390754:     	mov	x29, x29
100390758:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10039075c:     	mov	x23, x0
100390760:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390764:     	ldr	x1, [x8, #0x480] ; selector: recordFailureForRoom:errorMessage:
100390768:     	mov	x0, x22
10039076c:     	mov	x2, x19
100390770:     	mov	x3, x23
100390774:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390778:     	mov	x0, x23
10039077c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390780:     	cmp	x21, #0x3
100390784:     	cset	w21, lo
100390788:     	mov	x0, x20
10039078c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390790:     	mov	x0, x19
100390794:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390798:     	mov	x0, x21
10039079c:     	ldp	x29, x30, [sp, #0x60]
1003907a0:     	ldp	x20, x19, [sp, #0x50]
1003907a4:     	ldp	x22, x21, [sp, #0x40]
1003907a8:     	ldp	x24, x23, [sp, #0x30]
1003907ac:     	ldp	x26, x25, [sp, #0x20]
1003907b0:     	add	sp, sp, #0x70
1003907b4:     	ret
