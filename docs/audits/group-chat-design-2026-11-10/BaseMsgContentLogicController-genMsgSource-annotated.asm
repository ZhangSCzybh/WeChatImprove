
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002e44bc:     	stp	x22, x21, [sp, #-0x30]!
1002e44c0:     	stp	x20, x19, [sp, #0x10]
1002e44c4:     	stp	x29, x30, [sp, #0x20]
1002e44c8:     	add	x29, sp, #0x20
1002e44cc:     	mov	x19, x0
1002e44d0:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002e44d4:     	mov	w9, #0x1                ; =1
1002e44d8:     	strb	w9, [x8, #0x9cb]
1002e44dc:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002e44e0:     	ldr	x0, [x8, #0x780]
1002e44e4:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002e44e8:     	ldr	x1, [x8, #0x800] ; selector: currentContext
1002e44ec:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002e44f0:     	mov	x29, x29
1002e44f4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002e44f8:     	mov	x20, x0
1002e44fc:     	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
1002e4500:     	ldr	x0, [x8, #0xf8]
1002e4504:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002e4508:     	ldr	x1, [x8, #0x508] ; selector: class
1002e450c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002e4510:     	mov	x2, x0
1002e4514:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002e4518:     	ldr	x1, [x8, #0xa40] ; selector: getService:
1002e451c:     	mov	x0, x20
1002e4520:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002e4524:     	mov	x29, x29
1002e4528:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002e452c:     	mov	x21, x0
1002e4530:     	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1002e4534:     	ldrsw	x8, [x8, #0xc0c] ; ivar: BaseMsgContentLogicController.m_contact offset=16
1002e4538:     	ldr	x0, [x19, x8]
1002e453c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1002e4540:     	ldr	x1, [x8, #0x620] ; selector: m_nsUsrName
1002e4544:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002e4548:     	mov	x29, x29
1002e454c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002e4550:     	mov	x19, x0
1002e4554:     	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
1002e4558:     	ldr	x1, [x8, #0x8] ; selector: isTempChatForUserName:
1002e455c:     	mov	x0, x21
1002e4560:     	mov	x2, x19
1002e4564:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002e4568:     	mov	x22, x0
1002e456c:     	mov	x0, x19
1002e4570:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002e4574:     	mov	x0, x21
1002e4578:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002e457c:     	mov	x0, x20
1002e4580:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002e4584:     	cbz	w22, 0x1002e45e0 <__text+0x2dc5e0>
1002e4588:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002e458c:     	ldr	x0, [x8, #0xe10]
1002e4590:     	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
1002e4594:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1002e4598:     	ldr	x1, [x8, #0xa60] ; selector: initWithMsgType:
1002e459c:     	mov	w2, #0x1                ; =1
1002e45a0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002e45a4:     	mov	x20, x0
1002e45a8:     	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
1002e45ac:     	ldr	x1, [x8, #0x10] ; selector: setM_isTempSessionMsg:
1002e45b0:     	mov	w2, #0x1                ; =1
1002e45b4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002e45b8:     	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
1002e45bc:     	ldr	x1, [x8, #0xa58] ; selector: m_nsMsgSource
1002e45c0:     	mov	x0, x20
1002e45c4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002e45c8:     	mov	x29, x29
1002e45cc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002e45d0:     	mov	x19, x0
1002e45d4:     	mov	x0, x20
1002e45d8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002e45dc:     	b	0x1002e45e8 <__text+0x2dc5e8>
1002e45e0:     	adrp	x19, 0x11cf9b000 <dyld_stub_binder+0x11cf9b000>
1002e45e4:     	add	x19, x19, #0xe58 ; CFString: 
1002e45e8:     	mov	x0, x19
1002e45ec:     	ldp	x29, x30, [sp, #0x20]
1002e45f0:     	ldp	x20, x19, [sp, #0x10]
1002e45f4:     	ldp	x22, x21, [sp], #0x30
1002e45f8:     	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
