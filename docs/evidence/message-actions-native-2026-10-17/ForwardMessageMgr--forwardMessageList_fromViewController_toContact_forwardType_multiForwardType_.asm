
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c3d624: d101c3ff    	sub	sp, sp, #0x70
101c3d628: a90267fa    	stp	x26, x25, [sp, #0x20]
101c3d62c: a9035ff8    	stp	x24, x23, [sp, #0x30]
101c3d630: a90457f6    	stp	x22, x21, [sp, #0x40]
101c3d634: a9054ff4    	stp	x20, x19, [sp, #0x50]
101c3d638: a9067bfd    	stp	x29, x30, [sp, #0x60]
101c3d63c: 910183fd    	add	x29, sp, #0x60
101c3d640: aa0603f7    	mov	x23, x6
101c3d644: aa0503f8    	mov	x24, x5
101c3d648: aa0403f5    	mov	x21, x4
101c3d64c: aa0303f4    	mov	x20, x3
101c3d650: aa0203f3    	mov	x19, x2
101c3d654: aa0003f9    	mov	x25, x0
101c3d658: d00dcd88    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101c3d65c: f9405908    	ldr	x8, [x8, #0xb0]
101c3d660: f9400108    	ldr	x8, [x8]
101c3d664: f9000fe8    	str	x8, [sp, #0x18]
101c3d668: d00f7fa8    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c3d66c: 52800029    	mov	w9, #0x1                ; =1
101c3d670: 39268909    	strb	w9, [x8, #0x9a2]
101c3d674: aa0203e0    	mov	x0, x2
101c3d678: 957fa6b0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c3d67c: aa1403e0    	mov	x0, x20
101c3d680: 957fa6ae    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c3d684: aa1503e0    	mov	x0, x21
101c3d688: 957fa6ac    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c3d68c: f00f2608    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101c3d690: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101c3d694: aa1303e0    	mov	x0, x19
101c3d698: 957fa6a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d69c: b4001000    	cbz	x0, 0x101c3d89c <_Flutter_Image_provideRelativePathByUrl+0x4a74c>
101c3d6a0: f00f2da8    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c3d6a4: b989e908    	ldrsw	x8, [x8, #0x9e8]
101c3d6a8: 8b080320    	add	x0, x25, x8
101c3d6ac: aa1403e1    	mov	x1, x20
101c3d6b0: 957fa6b9    	bl	0x107c27194 <_Flutter_MMFoundation_BindContext+0x4102d78>
101c3d6b4: f00f1388    	adrp	x8, 0x11feb0000 <dyld_stub_binder+0x11feb0000>
101c3d6b8: f942dd01    	ldr	x1, [x8, #0x5b8] ; currentLogicController
101c3d6bc: aa1903e0    	mov	x0, x25
101c3d6c0: 957fa69f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d6c4: aa1d03fd    	mov	x29, x29
101c3d6c8: 957fa6a0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c3d6cc: aa0003f6    	mov	x22, x0
101c3d6d0: 900f1408    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c3d6d4: f940d501    	ldr	x1, [x8, #0x1a8] ; configureForwardSuccessToastIfNeededForLogic:fromViewController:
101c3d6d8: aa1903e0    	mov	x0, x25
101c3d6dc: aa1603e2    	mov	x2, x22
101c3d6e0: aa1403e3    	mov	x3, x20
101c3d6e4: 957fa696    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d6e8: 900f2628    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
101c3d6ec: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
101c3d6f0: aa1303e0    	mov	x0, x19
101c3d6f4: 957fa692    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d6f8: aa1d03fd    	mov	x29, x29
101c3d6fc: 957fa693    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c3d700: aa0003f9    	mov	x25, x0
101c3d704: 900f1008    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
101c3d708: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
101c3d70c: 957fa68c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d710: aa1d03fd    	mov	x29, x29
101c3d714: 957fa68d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c3d718: aa0003fa    	mov	x26, x0
101c3d71c: d00f1248    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
101c3d720: f9479d01    	ldr	x1, [x8, #0xf38] ; setFromContactUserName:
101c3d724: aa1603e0    	mov	x0, x22
101c3d728: aa1a03e2    	mov	x2, x26
101c3d72c: 957fa684    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d730: aa1a03e0    	mov	x0, x26
101c3d734: 957fa688    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3d738: aa1903e0    	mov	x0, x25
101c3d73c: 957fa686    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3d740: d00f1068    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
101c3d744: f941bd01    	ldr	x1, [x8, #0x378] ; setM_forwardType:
101c3d748: aa1603e0    	mov	x0, x22
101c3d74c: aa1803e2    	mov	x2, x24
101c3d750: 957fa67b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d754: 900f1408    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c3d758: f940d901    	ldr	x1, [x8, #0x1b0] ; setEMultiForwardType:
101c3d75c: aa1603e0    	mov	x0, x22
101c3d760: aa1703e2    	mov	x2, x23
101c3d764: 957fa676    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d768: f10006ff    	cmp	x23, #0x1
101c3d76c: 540004c1    	b.ne	0x101c3d804 <_Flutter_Image_provideRelativePathByUrl+0x4a6b4>
101c3d770: f00f2628    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101c3d774: f9450901    	ldr	x1, [x8, #0xa10] ; mutableCopy
101c3d778: aa1303e0    	mov	x0, x19
101c3d77c: 957fa670    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d780: aa0003f7    	mov	x23, x0
101c3d784: f00f29a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101c3d788: f9469500    	ldr	x0, [x8, #0xd28] ; �C. 
101c3d78c: d00f10a8    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
101c3d790: f9416101    	ldr	x1, [x8, #0x2c0] ; ConvertMsgList2MsgWrap:
101c3d794: aa1703e2    	mov	x2, x23
101c3d798: 957fa669    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d79c: aa1d03fd    	mov	x29, x29
101c3d7a0: 957fa66a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c3d7a4: b4000740    	cbz	x0, 0x101c3d88c <_Flutter_Image_provideRelativePathByUrl+0x4a73c>
101c3d7a8: aa0003f8    	mov	x24, x0
101c3d7ac: b40005f5    	cbz	x21, 0x101c3d868 <_Flutter_Image_provideRelativePathByUrl+0x4a718>
101c3d7b0: f9000bf5    	str	x21, [sp, #0x10]
101c3d7b4: d00f29a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c3d7b8: f9456d00    	ldr	x0, [x8, #0xad8]
101c3d7bc: d00f2608    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101c3d7c0: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
101c3d7c4: 910043e2    	add	x2, sp, #0x10
101c3d7c8: 52800023    	mov	w3, #0x1                ; =1
101c3d7cc: 957fa65c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d7d0: aa1d03fd    	mov	x29, x29
101c3d7d4: 957fa65d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c3d7d8: aa0003f9    	mov	x25, x0
101c3d7dc: 900f1408    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c3d7e0: f940dd01    	ldr	x1, [x8, #0x1b8] ; forwardRecordMessage:msgList:toContacts:
101c3d7e4: aa1603e0    	mov	x0, x22
101c3d7e8: aa1803e2    	mov	x2, x24
101c3d7ec: aa1703e3    	mov	x3, x23
101c3d7f0: aa1903e4    	mov	x4, x25
101c3d7f4: 957fa652    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d7f8: aa1903e0    	mov	x0, x25
101c3d7fc: 957fa656    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3d800: 14000021    	b	0x101c3d884 <_Flutter_Image_provideRelativePathByUrl+0x4a734>
101c3d804: b4000275    	cbz	x21, 0x101c3d850 <_Flutter_Image_provideRelativePathByUrl+0x4a700>
101c3d808: f90007f5    	str	x21, [sp, #0x8]
101c3d80c: d00f29a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c3d810: f9456d00    	ldr	x0, [x8, #0xad8]
101c3d814: d00f2608    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101c3d818: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
101c3d81c: 910023e2    	add	x2, sp, #0x8
101c3d820: 52800023    	mov	w3, #0x1                ; =1
101c3d824: 957fa646    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d828: aa1d03fd    	mov	x29, x29
101c3d82c: 957fa647    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c3d830: aa0003f7    	mov	x23, x0
101c3d834: d00f12a8    	adrp	x8, 0x11fe93000 <dyld_stub_binder+0x11fe93000>
101c3d838: f9434101    	ldr	x1, [x8, #0x680] ; forwardMsgList:toContacts:
101c3d83c: aa1603e0    	mov	x0, x22
101c3d840: aa1303e2    	mov	x2, x19
101c3d844: aa1703e3    	mov	x3, x23
101c3d848: 957fa63d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d84c: 14000010    	b	0x101c3d88c <_Flutter_Image_provideRelativePathByUrl+0x4a73c>
101c3d850: d00f1068    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
101c3d854: f9438101    	ldr	x1, [x8, #0x700] ; forwardMsgList:
101c3d858: aa1603e0    	mov	x0, x22
101c3d85c: aa1303e2    	mov	x2, x19
101c3d860: 957fa637    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d864: 1400000c    	b	0x101c3d894 <_Flutter_Image_provideRelativePathByUrl+0x4a744>
101c3d868: 900f1408    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c3d86c: f940dd01    	ldr	x1, [x8, #0x1b8] ; forwardRecordMessage:msgList:toContacts:
101c3d870: aa1603e0    	mov	x0, x22
101c3d874: aa1803e2    	mov	x2, x24
101c3d878: aa1703e3    	mov	x3, x23
101c3d87c: d2800004    	mov	x4, #0x0                ; =0
101c3d880: 957fa62f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d884: aa1803e0    	mov	x0, x24
101c3d888: 957fa633    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3d88c: aa1703e0    	mov	x0, x23
101c3d890: 957fa631    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3d894: aa1603e0    	mov	x0, x22
101c3d898: 957fa62f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3d89c: aa1503e0    	mov	x0, x21
101c3d8a0: 957fa62d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3d8a4: aa1403e0    	mov	x0, x20
101c3d8a8: 957fa62b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3d8ac: aa1303e0    	mov	x0, x19
101c3d8b0: 957fa629    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3d8b4: f9400fe8    	ldr	x8, [sp, #0x18]
101c3d8b8: d00dcd89    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101c3d8bc: f9405929    	ldr	x9, [x9, #0xb0]
101c3d8c0: f9400129    	ldr	x9, [x9]
101c3d8c4: eb08013f    	cmp	x9, x8
101c3d8c8: 54000101    	b.ne	0x101c3d8e8 <_Flutter_Image_provideRelativePathByUrl+0x4a798>
101c3d8cc: a9467bfd    	ldp	x29, x30, [sp, #0x60]
101c3d8d0: a9454ff4    	ldp	x20, x19, [sp, #0x50]
101c3d8d4: a94457f6    	ldp	x22, x21, [sp, #0x40]
101c3d8d8: a9435ff8    	ldp	x24, x23, [sp, #0x30]
101c3d8dc: a94267fa    	ldp	x26, x25, [sp, #0x20]
101c3d8e0: 9101c3ff    	add	sp, sp, #0x70
101c3d8e4: d65f03c0    	ret
101c3d8e8: 957fa623    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>