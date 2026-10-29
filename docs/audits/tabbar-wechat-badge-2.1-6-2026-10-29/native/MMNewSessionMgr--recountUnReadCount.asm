
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10452e620: d106c3ff    	sub	sp, sp, #0x1b0
10452e624: a9156ffc    	stp	x28, x27, [sp, #0x150]
10452e628: a91667fa    	stp	x26, x25, [sp, #0x160]
10452e62c: a9175ff8    	stp	x24, x23, [sp, #0x170]
10452e630: a91857f6    	stp	x22, x21, [sp, #0x180]
10452e634: a9194ff4    	stp	x20, x19, [sp, #0x190]
10452e638: a91a7bfd    	stp	x29, x30, [sp, #0x1a0]
10452e63c: 910683fd    	add	x29, sp, #0x1a0
10452e640: b00c8608    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10452e644: f9405908    	ldr	x8, [x8, #0xb0]
10452e648: f9400108    	ldr	x8, [x8]
10452e64c: f81a03a8    	stur	x8, [x29, #-0x60]
10452e650: d00e3868    	adrp	x8, 0x120c3c000 <dyld_stub_binder+0x120c3c000>
10452e654: 52800029    	mov	w9, #0x1                ; =1
10452e658: 393bf109    	strb	w9, [x8, #0xefc]
10452e65c: f00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452e660: b9873908    	ldrsw	x8, [x8, #0x738]
10452e664: 8b080008    	add	x8, x0, x8
10452e668: a90423e0    	stp	x0, x8, [sp, #0x40]
10452e66c: b900011f    	str	wzr, [x8]
10452e670: f00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452e674: b9873d08    	ldrsw	x8, [x8, #0x73c]
10452e678: f9000fe8    	str	x8, [sp, #0x18]
10452e67c: b828681f    	str	wzr, [x0, x8]
10452e680: f00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452e684: b9874108    	ldrsw	x8, [x8, #0x740]
10452e688: f9001be8    	str	x8, [sp, #0x30]
10452e68c: b828681f    	str	wzr, [x0, x8]
10452e690: f00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452e694: b9874508    	ldrsw	x8, [x8, #0x744]
10452e698: 8b080008    	add	x8, x0, x8
10452e69c: f90013e8    	str	x8, [sp, #0x20]
10452e6a0: b900011f    	str	wzr, [x8]
10452e6a4: b00de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452e6a8: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
10452e6ac: 900dd208    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
10452e6b0: f942b101    	ldr	x1, [x8, #0x560] ; selector shouldEnableDebugLog
10452e6b4: 94dbe2a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e6b8: 34000140    	cbz	w0, 0x10452e6e0 <_Flutter_MMFoundation_BindContext+0xa0a2c4>
10452e6bc: b00de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452e6c0: f9455500    	ldr	x0, [x8, #0xaa8] ; class NSMutableArray
10452e6c4: b00dde88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10452e6c8: f941a101    	ldr	x1, [x8, #0x340] ; selector array
10452e6cc: 94dbe29c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e6d0: aa1d03fd    	mov	x29, x29
10452e6d4: 94dbe29d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452e6d8: f9001fe0    	str	x0, [sp, #0x38]
10452e6dc: 14000002    	b	0x10452e6e4 <_Flutter_MMFoundation_BindContext+0xa0a2c8>
10452e6e0: f9001fff    	str	xzr, [sp, #0x38]
10452e6e4: 4f00e400    	movi.16b	v0, #0x0
10452e6e8: ad0503e0    	stp	q0, q0, [sp, #0xa0]
10452e6ec: ad0403e0    	stp	q0, q0, [sp, #0x80]
10452e6f0: f00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452e6f4: b9873508    	ldrsw	x8, [x8, #0x734]
10452e6f8: f94023e9    	ldr	x9, [sp, #0x40]
10452e6fc: f8686935    	ldr	x21, [x9, x8]
10452e700: aa1503e0    	mov	x0, x21
10452e704: 94dbe28d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10452e708: d00dde88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10452e70c: f9435501    	ldr	x1, [x8, #0x6a8] ; selector countByEnumeratingWithState:objects:count:
10452e710: 910203e2    	add	x2, sp, #0x80
10452e714: 910303e3    	add	x3, sp, #0xc0
10452e718: f90017e1    	str	x1, [sp, #0x28]
10452e71c: 52800204    	mov	w4, #0x10               ; =16
10452e720: 94dbe287    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e724: b4000f00    	cbz	x0, 0x10452e904 <_Flutter_MMFoundation_BindContext+0xa0a4e8>
10452e728: aa0003f7    	mov	x23, x0
10452e72c: f9404be8    	ldr	x8, [sp, #0x90]
10452e730: f9400116    	ldr	x22, [x8]
10452e734: d2800013    	mov	x19, #0x0               ; =0
10452e738: b00ddea8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10452e73c: f943f919    	ldr	x25, [x8, #0x7f0] ; selector isHidden
10452e740: d00dca88    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
10452e744: f943651a    	ldr	x26, [x8, #0x6c8] ; selector isInChatBox
10452e748: 900dd208    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
10452e74c: f942b51b    	ldr	x27, [x8, #0x568] ; selector isInBrandServiceBox
10452e750: d00dc8a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10452e754: f947d909    	ldr	x9, [x8, #0xfb0] ; selector m_nsUserName
10452e758: b00ddea8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10452e75c: f943c908    	ldr	x8, [x8, #0x790] ; selector isEqualToString:
10452e760: a906a7e8    	stp	x8, x9, [sp, #0x68]
10452e764: f00dc8a8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
10452e768: f9413509    	ldr	x9, [x8, #0x268] ; selector m_bShowUnReadAsRedDot
10452e76c: f00dc868    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10452e770: f942e508    	ldr	x8, [x8, #0x5c8] ; selector m_uUnReadCount
10452e774: f9003fe8    	str	x8, [sp, #0x78]
10452e778: 900dc868    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10452e77c: f943c508    	ldr	x8, [x8, #0x788] ; selector safeAddObject:
10452e780: f9002be8    	str	x8, [sp, #0x50]
10452e784: 900dcac8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10452e788: f943d508    	ldr	x8, [x8, #0x7a8] ; selector m_isFolding
10452e78c: a905a7e8    	stp	x8, x9, [sp, #0x58]
10452e790: f9404be8    	ldr	x8, [sp, #0x90]
10452e794: f9400108    	ldr	x8, [x8]
10452e798: eb16011f    	cmp	x8, x22
10452e79c: 54000060    	b.eq	0x10452e7a8 <_Flutter_MMFoundation_BindContext+0xa0a38c>
10452e7a0: aa1503e0    	mov	x0, x21
10452e7a4: 94dbe26b    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
10452e7a8: f94047e8    	ldr	x8, [sp, #0x88]
10452e7ac: f8737918    	ldr	x24, [x8, x19, lsl #3]
10452e7b0: aa1803e0    	mov	x0, x24
10452e7b4: aa1903e1    	mov	x1, x25
10452e7b8: 94dbe261    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e7bc: 370008e0    	tbnz	w0, #0x0, 0x10452e8d8 <_Flutter_MMFoundation_BindContext+0xa0a4bc>
10452e7c0: aa1803e0    	mov	x0, x24
10452e7c4: aa1a03e1    	mov	x1, x26
10452e7c8: 94dbe25d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e7cc: 37000860    	tbnz	w0, #0x0, 0x10452e8d8 <_Flutter_MMFoundation_BindContext+0xa0a4bc>
10452e7d0: aa1803e0    	mov	x0, x24
10452e7d4: aa1b03e1    	mov	x1, x27
10452e7d8: 94dbe259    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e7dc: 370007e0    	tbnz	w0, #0x0, 0x10452e8d8 <_Flutter_MMFoundation_BindContext+0xa0a4bc>
10452e7e0: aa1803e0    	mov	x0, x24
10452e7e4: f9403be1    	ldr	x1, [sp, #0x70]
10452e7e8: 94dbe255    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e7ec: aa1d03fd    	mov	x29, x29
10452e7f0: 94dbe256    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452e7f4: aa0003f4    	mov	x20, x0
10452e7f8: f94037e1    	ldr	x1, [sp, #0x68]
10452e7fc: d00cfc02    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
10452e800: 913aa042    	add	x2, x2, #0xea8 ; CFString 'chatroom_session_box'
10452e804: 94dbe24e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e808: aa0003fc    	mov	x28, x0
10452e80c: aa1403e0    	mov	x0, x20
10452e810: 94dbe251    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452e814: 3700063c    	tbnz	w28, #0x0, 0x10452e8d8 <_Flutter_MMFoundation_BindContext+0xa0a4bc>
10452e818: aa1803e0    	mov	x0, x24
10452e81c: f94033e1    	ldr	x1, [sp, #0x60]
10452e820: 94dbe247    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e824: aa0003f4    	mov	x20, x0
10452e828: aa1803e0    	mov	x0, x24
10452e82c: f9403fe1    	ldr	x1, [sp, #0x78]
10452e830: 94dbe243    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e834: f94027e8    	ldr	x8, [sp, #0x48]
10452e838: 34000194    	cbz	w20, 0x10452e868 <_Flutter_MMFoundation_BindContext+0xa0a44c>
10452e83c: f94023e9    	ldr	x9, [sp, #0x40]
10452e840: f9401bea    	ldr	x10, [sp, #0x30]
10452e844: b86a6928    	ldr	w8, [x9, x10]
10452e848: 0b000108    	add	w8, w8, w0
10452e84c: b82a6928    	str	w8, [x9, x10]
10452e850: aa1803e0    	mov	x0, x24
10452e854: f9403fe1    	ldr	x1, [sp, #0x78]
10452e858: 94dbe239    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e85c: 340000c0    	cbz	w0, 0x10452e874 <_Flutter_MMFoundation_BindContext+0xa0a458>
10452e860: 52800020    	mov	w0, #0x1                ; =1
10452e864: f94013e8    	ldr	x8, [sp, #0x20]
10452e868: b9400109    	ldr	w9, [x8]
10452e86c: 0b000129    	add	w9, w9, w0
10452e870: b9000109    	str	w9, [x8]
10452e874: aa1803e0    	mov	x0, x24
10452e878: f9403fe1    	ldr	x1, [sp, #0x78]
10452e87c: 94dbe230    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e880: 340000a0    	cbz	w0, 0x10452e894 <_Flutter_MMFoundation_BindContext+0xa0a478>
10452e884: f9401fe0    	ldr	x0, [sp, #0x38]
10452e888: f9402be1    	ldr	x1, [sp, #0x50]
10452e88c: aa1803e2    	mov	x2, x24
10452e890: 94dbe22b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e894: aa1803e0    	mov	x0, x24
10452e898: f9402fe1    	ldr	x1, [sp, #0x58]
10452e89c: 94dbe228    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e8a0: 370001c0    	tbnz	w0, #0x0, 0x10452e8d8 <_Flutter_MMFoundation_BindContext+0xa0a4bc>
10452e8a4: aa1803e0    	mov	x0, x24
10452e8a8: f9403fe1    	ldr	x1, [sp, #0x78]
10452e8ac: 94dbe224    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e8b0: 34000140    	cbz	w0, 0x10452e8d8 <_Flutter_MMFoundation_BindContext+0xa0a4bc>
10452e8b4: aa1803e0    	mov	x0, x24
10452e8b8: f94033e1    	ldr	x1, [sp, #0x60]
10452e8bc: 94dbe220    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e8c0: 370000c0    	tbnz	w0, #0x0, 0x10452e8d8 <_Flutter_MMFoundation_BindContext+0xa0a4bc>
10452e8c4: f94023e9    	ldr	x9, [sp, #0x40]
10452e8c8: f9400fea    	ldr	x10, [sp, #0x18]
10452e8cc: b86a6928    	ldr	w8, [x9, x10]
10452e8d0: 11000508    	add	w8, w8, #0x1
10452e8d4: b82a6928    	str	w8, [x9, x10]
10452e8d8: 91000673    	add	x19, x19, #0x1
10452e8dc: eb1302ff    	cmp	x23, x19
10452e8e0: 54fff581    	b.ne	0x10452e790 <_Flutter_MMFoundation_BindContext+0xa0a374>
10452e8e4: 910203e2    	add	x2, sp, #0x80
10452e8e8: 910303e3    	add	x3, sp, #0xc0
10452e8ec: aa1503e0    	mov	x0, x21
10452e8f0: f94017e1    	ldr	x1, [sp, #0x28]
10452e8f4: 52800204    	mov	w4, #0x10               ; =16
10452e8f8: 94dbe211    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e8fc: aa0003f7    	mov	x23, x0
10452e900: b5fff1a0    	cbnz	x0, 0x10452e734 <_Flutter_MMFoundation_BindContext+0xa0a318>
10452e904: aa1503e0    	mov	x0, x21
10452e908: 94dbe213    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452e90c: d00dde88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10452e910: f9435101    	ldr	x1, [x8, #0x6a0] ; selector count
10452e914: f9401ff3    	ldr	x19, [sp, #0x38]
10452e918: aa1303e0    	mov	x0, x19
10452e91c: 94dbe208    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e920: b4000220    	cbz	x0, 0x10452e964 <_Flutter_MMFoundation_BindContext+0xa0a548>
10452e924: b00de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452e928: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
10452e92c: f00dc848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10452e930: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
10452e934: d00d1128    	adrp	x8, 0x11e754000 <dyld_stub_binder+0x11e754000>
10452e938: 91382108    	add	x8, x8, #0xe08 ; CFString 'unread sessions[%@]'
10452e93c: a9004fe8    	stp	x8, x19, [sp]
10452e940: b00b9205    	adrp	x5, 0x11b76f000 <dyld_stub_binder+0x11b76f000>
10452e944: 913ffca5    	add	x5, x5, #0xfff ; string 'MMNewSessionMgr.mm'
10452e948: f00b9207    	adrp	x7, 0x11b771000 <dyld_stub_binder+0x11b771000>
10452e94c: 9118e4e7    	add	x7, x7, #0x639 ; string '-[MMNewSessionMgr recountUnReadCount]'
10452e950: 52800022    	mov	w2, #0x1                ; =1
10452e954: d2800003    	mov	x3, #0x0                ; =0
10452e958: 52800004    	mov	w4, #0x0                ; =0
10452e95c: 52812da6    	mov	w6, #0x96d              ; =2413
10452e960: 94dbe1f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e964: aa1303e0    	mov	x0, x19
10452e968: 94dbe1fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452e96c: f85a03a8    	ldur	x8, [x29, #-0x60]
10452e970: b00c8609    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10452e974: f9405929    	ldr	x9, [x9, #0xb0]
10452e978: f9400129    	ldr	x9, [x9]
10452e97c: eb08013f    	cmp	x9, x8
10452e980: 54000121    	b.ne	0x10452e9a4 <_Flutter_MMFoundation_BindContext+0xa0a588>
10452e984: a95a7bfd    	ldp	x29, x30, [sp, #0x1a0]
10452e988: a9594ff4    	ldp	x20, x19, [sp, #0x190]
10452e98c: a95857f6    	ldp	x22, x21, [sp, #0x180]
10452e990: a9575ff8    	ldp	x24, x23, [sp, #0x170]
10452e994: a95667fa    	ldp	x26, x25, [sp, #0x160]
10452e998: a9556ffc    	ldp	x28, x27, [sp, #0x150]
10452e99c: 9106c3ff    	add	sp, sp, #0x1b0
10452e9a0: d65f03c0    	ret
10452e9a4: 94dbe1f4    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
