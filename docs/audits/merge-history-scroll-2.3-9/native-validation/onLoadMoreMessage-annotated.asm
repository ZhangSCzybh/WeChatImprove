
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10032d7d0: d10343ff    	sub	sp, sp, #0xd0
10032d7d4: 6d052beb    	stp	d11, d10, [sp, #0x50]
10032d7d8: 6d0623e9    	stp	d9, d8, [sp, #0x60]
10032d7dc: a9076ffc    	stp	x28, x27, [sp, #0x70]
10032d7e0: a90867fa    	stp	x26, x25, [sp, #0x80]
10032d7e4: a9095ff8    	stp	x24, x23, [sp, #0x90]
10032d7e8: a90a57f6    	stp	x22, x21, [sp, #0xa0]
10032d7ec: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
10032d7f0: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
10032d7f4: 910303fd    	add	x29, sp, #0xc0
10032d7f8: f00fa088    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
10032d7fc: 52800029    	mov	w9, #0x1                ; =1
10032d800: 392aa509    	strb	w9, [x8, #0xaa9]
10032d804: b00f5288    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032d808: b98d1d1a    	ldrsw	x26, [x8, #0xd1c] ; ivar: BaseMsgContentViewController.m_bReadtToLoadMoreMsg offset=144
10032d80c: 387a6808    	ldrb	w8, [x0, x26]
10032d810: 36000cc8    	tbz	w8, #0x0, 0x10032d9a8 <__text+0x3259a8>
10032d814: aa0003f3    	mov	x19, x0
10032d818: 910103e0    	add	x0, sp, #0x40
10032d81c: 52800041    	mov	w1, #0x2                ; =2
10032d820: 52800502    	mov	w2, #0x28               ; =40
10032d824: 9514c8a0    	bl	0x10485faa4 <_Flutter_MMFoundation_BindContext+0xae6770>
10032d828: b00f5288    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032d82c: b98d6d08    	ldrsw	x8, [x8, #0xd6c] ; ivar: BaseMsgContentViewController.m_moreMsgIndex offset=136
10032d830: f8286a7f    	str	xzr, [x19, x8]
10032d834: b00f5288    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032d838: b98d8508    	ldrsw	x8, [x8, #0xd84] ; ivar: BaseMsgContentViewController.m_uLastMoreMsgTime offset=124
10032d83c: b8286a7f    	str	wzr, [x19, x8]
10032d840: 900f3588    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
10032d844: f9431d14    	ldr	x20, [x8, #0x638] ; selector: getCurContentSizeHeight
10032d848: aa1303e0    	mov	x0, x19
10032d84c: aa1403e1    	mov	x1, x20
10032d850: 95e3e905    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032d854: aa0003f5    	mov	x21, x0
10032d858: b00f5288    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032d85c: b98cfd1b    	ldrsw	x27, [x8, #0xcfc] ; ivar: BaseMsgContentViewController.m_tableView offset=176
10032d860: f87b6a60    	ldr	x0, [x19, x27]
10032d864: b00f4bc8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10032d868: f943a501    	ldr	x1, [x8, #0x748] ; selector: contentOffset
10032d86c: 95e3e8fe    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032d870: 4ea11c28    	mov.16b	v8, v1
10032d874: b00cc4e1    	adrp	x1, 0x119bca000 <dyld_stub_binder+0x119bca000>
10032d878: 91112c21    	add	x1, x1, #0x44b
10032d87c: b00cc4e2    	adrp	x2, 0x119bca000 <dyld_stub_binder+0x119bca000>
10032d880: 91126042    	add	x2, x2, #0x498
10032d884: 910043e0    	add	x0, sp, #0x10
10032d888: d2800003    	mov	x3, #0x0                ; =0
10032d88c: 95e37cd2    	bl	0x107c0cbd4 <_Flutter_MMFoundation_BindContext+0x3e938a0>
10032d890: b00f5288    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032d894: b98cf11c    	ldrsw	x28, [x8, #0xcf0] ; ivar: BaseMsgContentViewController.m_delegate offset=152
10032d898: 8b1c0260    	add	x0, x19, x28
10032d89c: 95e3e8f0    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
10032d8a0: f00f3578    	adrp	x24, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10032d8a4: b4000d20    	cbz	x0, 0x10032da48 <__text+0x325a48>
10032d8a8: aa0003f7    	mov	x23, x0
10032d8ac: 8b1c0260    	add	x0, x19, x28
10032d8b0: 95e3e8eb    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
10032d8b4: aa0003f8    	mov	x24, x0
10032d8b8: b00f3568    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
10032d8bc: f943e516    	ldr	x22, [x8, #0x7c8] ; selector: onLoadMoreMessage
10032d8c0: b00f4be8    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
10032d8c4: f9440501    	ldr	x1, [x8, #0x808] ; selector: respondsToSelector:
10032d8c8: aa1603e2    	mov	x2, x22
10032d8cc: 95e3e8e6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032d8d0: aa0003f9    	mov	x25, x0
10032d8d4: aa1803e0    	mov	x0, x24
10032d8d8: f00f3578    	adrp	x24, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10032d8dc: 95e3e8e5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032d8e0: aa1703e0    	mov	x0, x23
10032d8e4: 95e3e8e3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032d8e8: 34000b19    	cbz	w25, 0x10032da48 <__text+0x325a48>
10032d8ec: 8b1c0260    	add	x0, x19, x28
10032d8f0: 95e3e8db    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
10032d8f4: aa0003f7    	mov	x23, x0
10032d8f8: aa1603e1    	mov	x1, x22
10032d8fc: 95e3e8da    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032d900: aa1d03fd    	mov	x29, x29
10032d904: 95e3e8df    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032d908: aa0003f6    	mov	x22, x0
10032d90c: aa1703e0    	mov	x0, x23
10032d910: 95e3e8d8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032d914: b00f4bc8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10032d918: f9442917    	ldr	x23, [x8, #0x850] ; selector: count
10032d91c: aa1603e0    	mov	x0, x22
10032d920: aa1703e1    	mov	x1, x23
10032d924: 95e3e8d0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032d928: b5000620    	cbnz	x0, 0x10032d9ec <__text+0x3259ec>
10032d92c: 8b1c0260    	add	x0, x19, x28
10032d930: 95e3e8cb    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
10032d934: aa0003f8    	mov	x24, x0
10032d938: f00f3568    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10032d93c: f9430901    	ldr	x1, [x8, #0x610] ; selector: hasMoreMsg
10032d940: 95e3e8c9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032d944: aa0003f9    	mov	x25, x0
10032d948: aa1803e0    	mov	x0, x24
10032d94c: 95e3e8c9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032d950: 340004f9    	cbz	w25, 0x10032d9ec <__text+0x3259ec>
10032d954: b00f4f28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10032d958: f9430d00    	ldr	x0, [x8, #0x618]
10032d95c: 900f34e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10032d960: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10032d964: d00e64a8    	adrp	x8, 0x11cfc3000 <dyld_stub_binder+0x11cfc3000>
10032d968: 9121e108    	add	x8, x8, #0x878 ; CFString: should get msg from server
10032d96c: f90003e8    	str	x8, [sp]
10032d970: f00cc4c5    	adrp	x5, 0x119bc8000 <dyld_stub_binder+0x119bc8000>
10032d974: 9100f4a5    	add	x5, x5, #0x3d
10032d978: b00cc4e7    	adrp	x7, 0x119bca000 <dyld_stub_binder+0x119bca000>
10032d97c: 91112ce7    	add	x7, x7, #0x44b
10032d980: 52800042    	mov	w2, #0x2                ; =2
10032d984: d2800003    	mov	x3, #0x0                ; =0
10032d988: 52800004    	mov	w4, #0x0                ; =0
10032d98c: 52835fa6    	mov	w6, #0x1afd             ; =6909
10032d990: 95e3e8b5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032d994: 910043e0    	add	x0, sp, #0x10
10032d998: 95e37c90    	bl	0x107c0cbd8 <_Flutter_MMFoundation_BindContext+0x3e938a4>
10032d99c: aa1603e0    	mov	x0, x22
10032d9a0: 95e3e8b4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032d9a4: 140000ae    	b	0x10032dc5c <__text+0x325c5c>
10032d9a8: b00f4f28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10032d9ac: f9430d00    	ldr	x0, [x8, #0x618]
10032d9b0: 900f34e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10032d9b4: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10032d9b8: d00e64a8    	adrp	x8, 0x11cfc3000 <dyld_stub_binder+0x11cfc3000>
10032d9bc: 91216108    	add	x8, x8, #0x858 ; CFString: not ready to load more msg
10032d9c0: f90003e8    	str	x8, [sp]
10032d9c4: f00cc4c5    	adrp	x5, 0x119bc8000 <dyld_stub_binder+0x119bc8000>
10032d9c8: 9100f4a5    	add	x5, x5, #0x3d
10032d9cc: b00cc4e7    	adrp	x7, 0x119bca000 <dyld_stub_binder+0x119bca000>
10032d9d0: 91112ce7    	add	x7, x7, #0x44b
10032d9d4: 52800042    	mov	w2, #0x2                ; =2
10032d9d8: d2800003    	mov	x3, #0x0                ; =0
10032d9dc: 52800004    	mov	w4, #0x0                ; =0
10032d9e0: 52835da6    	mov	w6, #0x1aed             ; =6893
10032d9e4: 95e3e8a0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032d9e8: 140000a1    	b	0x10032dc6c <__text+0x325c6c>
10032d9ec: b00f4f28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10032d9f0: f9430d18    	ldr	x24, [x8, #0x618]
10032d9f4: aa1603e0    	mov	x0, x22
10032d9f8: aa1703e1    	mov	x1, x23
10032d9fc: 95e3e89a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032da00: 900f34e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10032da04: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10032da08: d00e64a8    	adrp	x8, 0x11cfc3000 <dyld_stub_binder+0x11cfc3000>
10032da0c: 91226108    	add	x8, x8, #0x898 ; CFString: get msg count:%lu
10032da10: a90003e8    	stp	x8, x0, [sp]
10032da14: f00cc4c5    	adrp	x5, 0x119bc8000 <dyld_stub_binder+0x119bc8000>
10032da18: 9100f4a5    	add	x5, x5, #0x3d
10032da1c: b00cc4e7    	adrp	x7, 0x119bca000 <dyld_stub_binder+0x119bca000>
10032da20: 91112ce7    	add	x7, x7, #0x44b
10032da24: aa1803e0    	mov	x0, x24
10032da28: 52800042    	mov	w2, #0x2                ; =2
10032da2c: d2800003    	mov	x3, #0x0                ; =0
10032da30: 52800004    	mov	w4, #0x0                ; =0
10032da34: 52836026    	mov	w6, #0x1b01             ; =6913
10032da38: 95e3e88b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032da3c: aa1603e0    	mov	x0, x22
10032da40: 95e3e88c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032da44: f00f3578    	adrp	x24, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10032da48: 9e6302a9    	ucvtf	d9, x21
10032da4c: 910043e0    	add	x0, sp, #0x10
10032da50: 95e37c62    	bl	0x107c0cbd8 <_Flutter_MMFoundation_BindContext+0x3e938a4>
10032da54: b00f3588    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032da58: f9469501    	ldr	x1, [x8, #0xd28] ; selector: addFoldHistoryMessageNodeIfNeed
10032da5c: aa1303e0    	mov	x0, x19
10032da60: 95e3e881    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032da64: aa1303e0    	mov	x0, x19
10032da68: aa1403e1    	mov	x1, x20
10032da6c: 95e3e87e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032da70: 9e630000    	ucvtf	d0, x0
10032da74: 1e693800    	fsub	d0, d0, d9
10032da78: 1e602909    	fadd	d9, d8, d0
10032da7c: d00f34e8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10032da80: f9470101    	ldr	x1, [x8, #0xe00] ; selector: reloadTableData
10032da84: aa1303e0    	mov	x0, x19
10032da88: 95e3e877    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032da8c: 8b1c0260    	add	x0, x19, x28
10032da90: 95e3e873    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
10032da94: aa0003f4    	mov	x20, x0
10032da98: f9430b01    	ldr	x1, [x24, #0x610] ; selector: hasMoreMsg
10032da9c: 95e3e872    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032daa0: aa0003f5    	mov	x21, x0
10032daa4: aa1403e0    	mov	x0, x20
10032daa8: 95e3e872    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032daac: 34000095    	cbz	w21, 0x10032dabc <__text+0x325abc>
10032dab0: d00f4bc8    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
10032dab4: f9478114    	ldr	x20, [x8, #0xf00] ; selector: height
10032dab8: 1400000f    	b	0x10032daf4 <__text+0x325af4>
10032dabc: f87b6a60    	ldr	x0, [x19, x27]
10032dac0: 900f3588    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
10032dac4: f9439501    	ldr	x1, [x8, #0x728] ; selector: tableHeaderView
10032dac8: 95e3e867    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032dacc: aa1d03fd    	mov	x29, x29
10032dad0: 95e3e86c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032dad4: aa0003f5    	mov	x21, x0
10032dad8: d00f4bc8    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
10032dadc: f9478114    	ldr	x20, [x8, #0xf00] ; selector: height
10032dae0: aa1403e1    	mov	x1, x20
10032dae4: 95e3e860    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032dae8: 1e603929    	fsub	d9, d9, d0
10032daec: aa1503e0    	mov	x0, x21
10032daf0: 95e3e860    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032daf4: f87b6a60    	ldr	x0, [x19, x27]
10032daf8: d00f34e8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10032dafc: f9457515    	ldr	x21, [x8, #0xae8] ; selector: contentInset
10032db00: aa1503e1    	mov	x1, x21
10032db04: 95e3e858    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032db08: 1e61400a    	fneg	d10, d0
10032db0c: f87b6a60    	ldr	x0, [x19, x27]
10032db10: b00f3528    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
10032db14: f9455101    	ldr	x1, [x8, #0xaa0] ; selector: contentSize
10032db18: 95e3e853    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032db1c: 4ea11c28    	mov.16b	v8, v1
10032db20: f87b6a60    	ldr	x0, [x19, x27]
10032db24: aa1403e1    	mov	x1, x20
10032db28: 95e3e84f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032db2c: 1e603908    	fsub	d8, d8, d0
10032db30: f87b6a60    	ldr	x0, [x19, x27]
10032db34: aa1503e1    	mov	x1, x21
10032db38: 95e3e84b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032db3c: 1e622900    	fadd	d0, d8, d2
10032db40: 1e6a2000    	fcmp	d0, d10
10032db44: 1e6acc00    	fcsel	d0, d0, d10, gt
10032db48: 1e602120    	fcmp	d9, d0
10032db4c: 1e604d28    	fcsel	d8, d9, d0, mi
10032db50: b00f5288    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032db54: b98d9908    	ldrsw	x8, [x8, #0xd98] ; ivar: BaseMsgContentViewController.m_scrollingToTop offset=544
10032db58: b8686a68    	ldr	w8, [x19, x8]
10032db5c: f87b6a60    	ldr	x0, [x19, x27]
10032db60: 7100051f    	cmp	w8, #0x1
10032db64: 5400010b    	b.lt	0x10032db84 <__text+0x325b84>
10032db68: d00f34e8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10032db6c: f9457101    	ldr	x1, [x8, #0xae0] ; selector: setContentOffset:animated:
10032db70: 9e6703e0    	fmov	d0, xzr
10032db74: 4ea81d01    	mov.16b	v1, v8
10032db78: 52800002    	mov	w2, #0x0                ; =0
10032db7c: 95e3e83a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032db80: 14000006    	b	0x10032db98 <__text+0x325b98>
10032db84: d00f4be8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
10032db88: f9422501    	ldr	x1, [x8, #0x448] ; selector: setContentOffset:
10032db8c: 9e6703e0    	fmov	d0, xzr
10032db90: 4ea81d01    	mov.16b	v1, v8
10032db94: 95e3e834    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032db98: b00f4f28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10032db9c: f9430d00    	ldr	x0, [x8, #0x618]
10032dba0: 900f34e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10032dba4: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10032dba8: fd0007e8    	str	d8, [sp, #0x8]
10032dbac: d00e64a8    	adrp	x8, 0x11cfc3000 <dyld_stub_binder+0x11cfc3000>
10032dbb0: 9122e108    	add	x8, x8, #0x8b8 ; CFString: onLoadMore:%f
10032dbb4: f90003e8    	str	x8, [sp]
10032dbb8: f00cc4c5    	adrp	x5, 0x119bc8000 <dyld_stub_binder+0x119bc8000>
10032dbbc: 9100f4a5    	add	x5, x5, #0x3d
10032dbc0: b00cc4e7    	adrp	x7, 0x119bca000 <dyld_stub_binder+0x119bca000>
10032dbc4: 91112ce7    	add	x7, x7, #0x44b
10032dbc8: 52800042    	mov	w2, #0x2                ; =2
10032dbcc: d2800003    	mov	x3, #0x0                ; =0
10032dbd0: 52800004    	mov	w4, #0x0                ; =0
10032dbd4: 528362c6    	mov	w6, #0x1b16             ; =6934
10032dbd8: 95e3e823    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032dbdc: 383a6a7f    	strb	wzr, [x19, x26]
10032dbe0: b00f5288    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032dbe4: b98d9d08    	ldrsw	x8, [x8, #0xd9c] ; ivar: BaseMsgContentViewController.m_activityView offset=184
10032dbe8: f8686a60    	ldr	x0, [x19, x8]
10032dbec: 900f4c08    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10032dbf0: f941e501    	ldr	x1, [x8, #0x3c8] ; selector: stopAnimating
10032dbf4: 95e3e81c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032dbf8: b00f5288    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032dbfc: b98da108    	ldrsw	x8, [x8, #0xda0] ; ivar: BaseMsgContentViewController._autoTranslateAnchorMsg offset=1152
10032dc00: f8686a60    	ldr	x0, [x19, x8]
10032dc04: b40001a0    	cbz	x0, 0x10032dc38 <__text+0x325c38>
10032dc08: f00f34e8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10032dc0c: f947e501    	ldr	x1, [x8, #0xfc8] ; selector: m_uiMesLocalID
10032dc10: 95e3e815    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032dc14: aa0003e2    	mov	x2, x0
10032dc18: b00f3588    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032dc1c: f9469901    	ldr	x1, [x8, #0xd30] ; selector: getMsgContentSizeHeight:
10032dc20: aa1303e0    	mov	x0, x19
10032dc24: 95e3e810    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032dc28: 9e630000    	ucvtf	d0, x0
10032dc2c: b00f5288    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032dc30: b98da508    	ldrsw	x8, [x8, #0xda4] ; ivar: BaseMsgContentViewController._autoTranslateAnchorMsgLastContentOffset offset=1160
10032dc34: fc286a60    	str	d0, [x19, x8]
10032dc38: b00f3588    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10032dc3c: f944fd02    	ldr	x2, [x8, #0x9f8] ; selector: startTextAutoTranslate
10032dc40: 900f34e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10032dc44: f9476501    	ldr	x1, [x8, #0xec8] ; selector: safePerformSelector:withObject:afterDelay:
10032dc48: d00bacc8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
10032dc4c: fd445d00    	ldr	d0, [x8, #0x8b8] ; constant double=0.1
10032dc50: aa1303e0    	mov	x0, x19
10032dc54: d2800003    	mov	x3, #0x0                ; =0
10032dc58: 95e3e803    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032dc5c: 910043e0    	add	x0, sp, #0x10
10032dc60: 95e37bdf    	bl	0x107c0cbdc <_Flutter_MMFoundation_BindContext+0x3e938a8>
10032dc64: 910103e0    	add	x0, sp, #0x40
10032dc68: 9514c7a4    	bl	0x10485faf8 <_Flutter_MMFoundation_BindContext+0xae67c4>
10032dc6c: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
10032dc70: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
10032dc74: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
10032dc78: a9495ff8    	ldp	x24, x23, [sp, #0x90]
10032dc7c: a94867fa    	ldp	x26, x25, [sp, #0x80]
10032dc80: a9476ffc    	ldp	x28, x27, [sp, #0x70]
10032dc84: 6d4623e9    	ldp	d9, d8, [sp, #0x60]
10032dc88: 6d452beb    	ldp	d11, d10, [sp, #0x50]
10032dc8c: 910343ff    	add	sp, sp, #0xd0
10032dc90: d65f03c0    	ret
