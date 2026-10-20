
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a951830: d10103ff    	sub	sp, sp, #0x40
10a951834: a90157f6    	stp	x22, x21, [sp, #0x10]
10a951838: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a95183c: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a951840: 9100c3fd    	add	x29, sp, #0x30
10a951844: aa0003f3    	mov	x19, x0
10a951848: d00b1808    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a95184c: 52800029    	mov	w9, #0x1                ; =1
10a951850: 390c0109    	strb	w9, [x8, #0x300]
10a951854: d00ac468    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a951858: 91096108    	add	x8, x8, #0x258
10a95185c: b9800108    	ldrsw	x8, [x8]
10a951860: 8b080000    	add	x0, x0, x8
10a951864: 953c270c    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a951868: aa0003f5    	mov	x21, x0
10a95186c: b00aa7c8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
10a951870: f9410101    	ldr	x1, [x8, #0x200] ; getContactVerifyLogic
10a951874: 953c26f4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951878: aa1d03fd    	mov	x29, x29
10a95187c: 953c26f5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951880: aa0003f4    	mov	x20, x0
10a951884: aa1503e0    	mov	x0, x21
10a951888: 953c26f5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a95188c: 900aa748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a951890: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
10a951894: aa1403e0    	mov	x0, x20
10a951898: aa1303e2    	mov	x2, x19
10a95189c: 953c26ea    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9518a0: f00ac108    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a9518a4: f9401100    	ldr	x0, [x8, #0x20]
10a9518a8: 900aa768    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a9518ac: f9408901    	ldr	x1, [x8, #0x110] ; checkNeedDoVerifyUserPreCheck
10a9518b0: 953c26e5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9518b4: 34000620    	cbz	w0, 0x10a951978 <_Flutter_MMFoundation_BindContext+0x6e2d55c>
10a9518b8: 900aa768    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a9518bc: f9408d01    	ldr	x1, [x8, #0x118] ; getVerifyPreCheckBusinessLogic
10a9518c0: aa1303e0    	mov	x0, x19
10a9518c4: 953c26e0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9518c8: aa1d03fd    	mov	x29, x29
10a9518cc: 953c26e1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9518d0: aa0003f5    	mov	x21, x0
10a9518d4: d00ac468    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a9518d8: 91093108    	add	x8, x8, #0x24c
10a9518dc: b9800108    	ldrsw	x8, [x8]
10a9518e0: f8686a60    	ldr	x0, [x19, x8]
10a9518e4: d00aa748    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a9518e8: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
10a9518ec: 953c26d6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9518f0: aa1d03fd    	mov	x29, x29
10a9518f4: 953c26d7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9518f8: aa0003f6    	mov	x22, x0
10a9518fc: 900aa768    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a951900: f9409101    	ldr	x1, [x8, #0x120] ; sendVerifyUserPreCheck:opcode:
10a951904: aa1503e0    	mov	x0, x21
10a951908: aa1603e2    	mov	x2, x22
10a95190c: 52800023    	mov	w3, #0x1                ; =1
10a951910: 953c26cd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951914: aa1603e0    	mov	x0, x22
10a951918: 953c26d1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a95191c: aa1503e0    	mov	x0, x21
10a951920: 953c26cf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951924: f00abd68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a951928: f946f101    	ldr	x1, [x8, #0xde0] ; delegate
10a95192c: aa1303e0    	mov	x0, x19
10a951930: 953c26c5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951934: aa1d03fd    	mov	x29, x29
10a951938: 953c26c6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a95193c: aa0003f5    	mov	x21, x0
10a951940: d00aa748    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a951944: f945d501    	ldr	x1, [x8, #0xba8] ; getViewController
10a951948: 953c26bf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95194c: aa1d03fd    	mov	x29, x29
10a951950: 953c26c0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951954: aa0003f6    	mov	x22, x0
10a951958: b00aa748    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10a95195c: f9402901    	ldr	x1, [x8, #0x50] ; startLoadingNonBlock
10a951960: 953c26b9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951964: aa1603e0    	mov	x0, x22
10a951968: 953c26bd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a95196c: aa1503e0    	mov	x0, x21
10a951970: 953c26bb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951974: 14000008    	b	0x10a951994 <_Flutter_MMFoundation_BindContext+0x6e2d578>
10a951978: 900ac428    	adrp	x8, 0x1201d5000 <dyld_stub_binder+0x1201d5000>
10a95197c: f9446508    	ldr	x8, [x8, #0x8c8]
10a951980: a90023f3    	stp	x19, x8, [sp]
10a951984: f00aa868    	adrp	x8, 0x11fe60000 <dyld_stub_binder+0x11fe60000>
10a951988: f9467501    	ldr	x1, [x8, #0xce8] ; onAddToContacts
10a95198c: 910003e0    	mov	x0, sp
10a951990: 953c26af    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
10a951994: d00ab268    	adrp	x8, 0x11ff9f000 <dyld_stub_binder+0x11ff9f000>
10a951998: f940d901    	ldr	x1, [x8, #0x1b0] ; reportFriendAssistActionIfNeeded:
10a95199c: aa1303e0    	mov	x0, x19
10a9519a0: 52800062    	mov	w2, #0x3                ; =3
10a9519a4: 953c26a8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9519a8: aa1403e0    	mov	x0, x20
10a9519ac: 953c26ac    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9519b0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a9519b4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a9519b8: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a9519bc: 910103ff    	add	sp, sp, #0x40
10a9519c0: d65f03c0    	ret
