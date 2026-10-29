
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10452e9a8: d10283ff    	sub	sp, sp, #0xa0
10452e9ac: a9065ff8    	stp	x24, x23, [sp, #0x60]
10452e9b0: a90757f6    	stp	x22, x21, [sp, #0x70]
10452e9b4: a9084ff4    	stp	x20, x19, [sp, #0x80]
10452e9b8: a9097bfd    	stp	x29, x30, [sp, #0x90]
10452e9bc: 910243fd    	add	x29, sp, #0x90
10452e9c0: aa0003f3    	mov	x19, x0
10452e9c4: d00e3868    	adrp	x8, 0x120c3c000 <dyld_stub_binder+0x120c3c000>
10452e9c8: 52800029    	mov	w9, #0x1                ; =1
10452e9cc: 393bf509    	strb	w9, [x8, #0xefd]
10452e9d0: f00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452e9d4: b9873915    	ldrsw	x21, [x8, #0x738]
10452e9d8: b8756814    	ldr	w20, [x0, x21]
10452e9dc: 900dd208    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
10452e9e0: f9425d01    	ldr	x1, [x8, #0x4b8] ; selector recountUnReadCount
10452e9e4: 94dbe1d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452e9e8: b8756a68    	ldr	w8, [x19, x21]
10452e9ec: 6b08029f    	cmp	w20, w8
10452e9f0: 54000620    	b.eq	0x10452eab4 <_Flutter_MMFoundation_BindContext+0xa0a698>
10452e9f4: b00de229    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
10452e9f8: f9453520    	ldr	x0, [x9, #0xa68] ; class iConsole
10452e9fc: f00dc849    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10452ea00: f942a921    	ldr	x1, [x9, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
10452ea04: d00d1129    	adrp	x9, 0x11e754000 <dyld_stub_binder+0x11e754000>
10452ea08: 9138a129    	add	x9, x9, #0xe28 ; CFString 'total unreadcount change to %u'
10452ea0c: a90023e9    	stp	x9, x8, [sp]
10452ea10: f00b6963    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
10452ea14: 911f2c63    	add	x3, x3, #0x7cb ; string 'Session'
10452ea18: b00b9205    	adrp	x5, 0x11b76f000 <dyld_stub_binder+0x11b76f000>
10452ea1c: 913ffca5    	add	x5, x5, #0xfff ; string 'MMNewSessionMgr.mm'
10452ea20: f00b9207    	adrp	x7, 0x11b771000 <dyld_stub_binder+0x11b771000>
10452ea24: 9119cce7    	add	x7, x7, #0x673 ; string '-[MMNewSessionMgr recountUnReadCountAndFireExtension]'
10452ea28: 52800042    	mov	w2, #0x2                ; =2
10452ea2c: 52800004    	mov	w4, #0x0                ; =0
10452ea30: 52812ee6    	mov	w6, #0x977              ; =2423
10452ea34: 94dbe1c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452ea38: b00de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452ea3c: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
10452ea40: d00dde88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10452ea44: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
10452ea48: 94dbe1bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452ea4c: aa1d03fd    	mov	x29, x29
10452ea50: 94dbe1be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452ea54: aa0003f4    	mov	x20, x0
10452ea58: d00de208    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10452ea5c: f9460502    	ldr	x2, [x8, #0xc08]
10452ea60: d00dcba8    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
10452ea64: f941cd03    	ldr	x3, [x8, #0x398] ; selector onSessionTotalUnreadCountChange:
10452ea68: 900c8608    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10452ea6c: f947e108    	ldr	x8, [x8, #0xfc0]
10452ea70: f9001fe8    	str	x8, [sp, #0x38]
10452ea74: f00a4288    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10452ea78: fd41c100    	ldr	d0, [x8, #0x380]
10452ea7c: 90000008    	adrp	x8, 0x10452e000 <_Flutter_MMFoundation_BindContext+0xa09be4>
10452ea80: 912ee108    	add	x8, x8, #0xbb8
10452ea84: 900c8649    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
10452ea88: 91238129    	add	x9, x9, #0x8e0
10452ea8c: fd0023e0    	str	d0, [sp, #0x40]
10452ea90: a904a7e8    	stp	x8, x9, [sp, #0x48]
10452ea94: f9002ff3    	str	x19, [sp, #0x58]
10452ea98: 900dc868    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10452ea9c: f9404901    	ldr	x1, [x8, #0x90] ; selector callExtension:selector:block:
10452eaa0: 9100e3e4    	add	x4, sp, #0x38
10452eaa4: 94dbe1a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452eaa8: aa1403e0    	mov	x0, x20
10452eaac: 94dbe1aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452eab0: b8756a74    	ldr	w20, [x19, x21]
10452eab4: f00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452eab8: b9875116    	ldrsw	x22, [x8, #0x750]
10452eabc: b8766a77    	ldr	w23, [x19, x22]
10452eac0: b8366a74    	str	w20, [x19, x22]
10452eac4: b00de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452eac8: f945c500    	ldr	x0, [x8, #0xb88] ; class UIApplication
10452eacc: 900ddee8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10452ead0: f9437101    	ldr	x1, [x8, #0x6e0] ; selector sharedApplication
10452ead4: 94dbe19a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452ead8: aa1d03fd    	mov	x29, x29
10452eadc: 94dbe19b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452eae0: aa0003f4    	mov	x20, x0
10452eae4: b00dde88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10452eae8: f9417501    	ldr	x1, [x8, #0x2e8] ; selector applicationState
10452eaec: 94dbe194    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452eaf0: aa0003f5    	mov	x21, x0
10452eaf4: aa1403e0    	mov	x0, x20
10452eaf8: 94dbe197    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452eafc: f1000abf    	cmp	x21, #0x2
10452eb00: 54000501    	b.ne	0x10452eba0 <_Flutter_MMFoundation_BindContext+0xa0a784>
10452eb04: 900dd208    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
10452eb08: f9410501    	ldr	x1, [x8, #0x208] ; selector GetActiveUserUnreadCount
10452eb0c: aa1303e0    	mov	x0, x19
10452eb10: 94dbe18b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452eb14: b8766a68    	ldr	w8, [x19, x22]
10452eb18: 0b000108    	add	w8, w8, w0
10452eb1c: b8366a68    	str	w8, [x19, x22]
10452eb20: 6b0802ff    	cmp	w23, w8
10452eb24: 540003e0    	b.eq	0x10452eba0 <_Flutter_MMFoundation_BindContext+0xa0a784>
10452eb28: b00de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452eb2c: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
10452eb30: d00dde88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10452eb34: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
10452eb38: 94dbe181    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452eb3c: aa1d03fd    	mov	x29, x29
10452eb40: 94dbe182    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452eb44: aa0003f4    	mov	x20, x0
10452eb48: d00de208    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10452eb4c: f9460502    	ldr	x2, [x8, #0xc08]
10452eb50: 900dd208    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
10452eb54: f942b903    	ldr	x3, [x8, #0x570] ; selector onAppIconTotalUnreadCountChange:
10452eb58: 900c8608    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10452eb5c: f947e108    	ldr	x8, [x8, #0xfc0]
10452eb60: f9000be8    	str	x8, [sp, #0x10]
10452eb64: f00a4288    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10452eb68: fd41c100    	ldr	d0, [x8, #0x380]
10452eb6c: 90000008    	adrp	x8, 0x10452e000 <_Flutter_MMFoundation_BindContext+0xa09be4>
10452eb70: 912f7108    	add	x8, x8, #0xbdc
10452eb74: 900c8649    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
10452eb78: 91238129    	add	x9, x9, #0x8e0
10452eb7c: fd000fe0    	str	d0, [sp, #0x18]
10452eb80: a90227e8    	stp	x8, x9, [sp, #0x20]
10452eb84: f9001bf3    	str	x19, [sp, #0x30]
10452eb88: 900dc868    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10452eb8c: f9404901    	ldr	x1, [x8, #0x90] ; selector callExtension:selector:block:
10452eb90: 910043e4    	add	x4, sp, #0x10
10452eb94: 94dbe16a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452eb98: aa1403e0    	mov	x0, x20
10452eb9c: 94dbe16e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452eba0: a9497bfd    	ldp	x29, x30, [sp, #0x90]
10452eba4: a9484ff4    	ldp	x20, x19, [sp, #0x80]
10452eba8: a94757f6    	ldp	x22, x21, [sp, #0x70]
10452ebac: a9465ff8    	ldp	x24, x23, [sp, #0x60]
10452ebb0: 910283ff    	add	sp, sp, #0xa0
10452ebb4: d65f03c0    	ret
