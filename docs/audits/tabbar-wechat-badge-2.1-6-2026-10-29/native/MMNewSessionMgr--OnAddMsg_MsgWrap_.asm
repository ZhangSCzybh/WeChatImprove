
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10452f328: d101c3ff    	sub	sp, sp, #0x70
10452f32c: a9016ffc    	stp	x28, x27, [sp, #0x10]
10452f330: a90267fa    	stp	x26, x25, [sp, #0x20]
10452f334: a9035ff8    	stp	x24, x23, [sp, #0x30]
10452f338: a90457f6    	stp	x22, x21, [sp, #0x40]
10452f33c: a9054ff4    	stp	x20, x19, [sp, #0x50]
10452f340: a9067bfd    	stp	x29, x30, [sp, #0x60]
10452f344: 910183fd    	add	x29, sp, #0x60
10452f348: aa0303f4    	mov	x20, x3
10452f34c: aa0203f3    	mov	x19, x2
10452f350: aa0003f5    	mov	x21, x0
10452f354: b00e3868    	adrp	x8, 0x120c3c000 <dyld_stub_binder+0x120c3c000>
10452f358: 52800029    	mov	w9, #0x1                ; =1
10452f35c: 393bfd09    	strb	w9, [x8, #0xeff]
10452f360: aa0203e0    	mov	x0, x2
10452f364: 94dbdf75    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10452f368: aa1403e0    	mov	x0, x20
10452f36c: 94dbdf73    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10452f370: b4000354    	cbz	x20, 0x10452f3d8 <_Flutter_MMFoundation_BindContext+0xa0afbc>
10452f374: b00de23a    	adrp	x26, 0x120174000 <dyld_stub_binder+0x120174000>
10452f378: f9411f40    	ldr	x0, [x26, #0x238] ; class CMessageWrap
10452f37c: d00dc868    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10452f380: f9478d16    	ldr	x22, [x8, #0xf18] ; selector isSenderFromMsgWrap:
10452f384: aa1603e1    	mov	x1, x22
10452f388: aa1403e2    	mov	x2, x20
10452f38c: 94dbdf6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f390: 34000480    	cbz	w0, 0x10452f420 <_Flutter_MMFoundation_BindContext+0xa0b004>
10452f394: 900de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452f398: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
10452f39c: d00dc848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10452f3a0: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
10452f3a4: b00d1128    	adrp	x8, 0x11e754000 <dyld_stub_binder+0x11e754000>
10452f3a8: 9132a108    	add	x8, x8, #0xca8 ; CFString 'AddMsg is send from myself'
10452f3ac: f90003e8    	str	x8, [sp]
10452f3b0: d00b6963    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
10452f3b4: 911f2c63    	add	x3, x3, #0x7cb ; string 'Session'
10452f3b8: 900b9205    	adrp	x5, 0x11b76f000 <dyld_stub_binder+0x11b76f000>
10452f3bc: 913ffca5    	add	x5, x5, #0xfff ; string 'MMNewSessionMgr.mm'
10452f3c0: d00b9207    	adrp	x7, 0x11b771000 <dyld_stub_binder+0x11b771000>
10452f3c4: 9120ace7    	add	x7, x7, #0x82b ; string '-[MMNewSessionMgr OnAddMsg:MsgWrap:]'
10452f3c8: 52800042    	mov	w2, #0x2                ; =2
10452f3cc: 52800004    	mov	w4, #0x0                ; =0
10452f3d0: 52813986    	mov	w6, #0x9cc              ; =2508
10452f3d4: 14000011    	b	0x10452f418 <_Flutter_MMFoundation_BindContext+0xa0affc>
10452f3d8: 900de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452f3dc: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
10452f3e0: d00dc848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10452f3e4: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
10452f3e8: b00d1128    	adrp	x8, 0x11e754000 <dyld_stub_binder+0x11e754000>
10452f3ec: 91322108    	add	x8, x8, #0xc88 ; CFString 'return for wrapMsg is nil'
10452f3f0: f90003e8    	str	x8, [sp]
10452f3f4: d00b6963    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
10452f3f8: 911f2c63    	add	x3, x3, #0x7cb ; string 'Session'
10452f3fc: 900b9205    	adrp	x5, 0x11b76f000 <dyld_stub_binder+0x11b76f000>
10452f400: 913ffca5    	add	x5, x5, #0xfff ; string 'MMNewSessionMgr.mm'
10452f404: d00b9207    	adrp	x7, 0x11b771000 <dyld_stub_binder+0x11b771000>
10452f408: 9120ace7    	add	x7, x7, #0x82b ; string '-[MMNewSessionMgr OnAddMsg:MsgWrap:]'
10452f40c: 52800082    	mov	w2, #0x4                ; =4
10452f410: 52800004    	mov	w4, #0x0                ; =0
10452f414: 528138e6    	mov	w6, #0x9c7              ; =2503
10452f418: 94dbdf49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f41c: 140000c7    	b	0x10452f738 <_Flutter_MMFoundation_BindContext+0xa0b31c>
10452f420: 900de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452f424: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
10452f428: b00dde88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10452f42c: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
10452f430: 94dbdf43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f434: aa1d03fd    	mov	x29, x29
10452f438: 94dbdf44    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452f43c: aa0003f7    	mov	x23, x0
10452f440: b00de228    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10452f444: f940f500    	ldr	x0, [x8, #0x1e8] ; class MMLimitedModeMgr
10452f448: 900dde88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10452f44c: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
10452f450: 94dbdf3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f454: aa0003e2    	mov	x2, x0
10452f458: d00dc848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10452f45c: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
10452f460: aa1703e0    	mov	x0, x23
10452f464: 94dbdf36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f468: aa1d03fd    	mov	x29, x29
10452f46c: 94dbdf37    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452f470: aa0003f8    	mov	x24, x0
10452f474: b00dc868    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10452f478: f9447501    	ldr	x1, [x8, #0x8e8] ; selector isLimitedModeOn
10452f47c: 94dbdf30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f480: aa0003f9    	mov	x25, x0
10452f484: aa1803e0    	mov	x0, x24
10452f488: 94dbdf33    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f48c: aa1703e0    	mov	x0, x23
10452f490: 94dbdf31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f494: 340001f9    	cbz	w25, 0x10452f4d0 <_Flutter_MMFoundation_BindContext+0xa0b0b4>
10452f498: 900ddea8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10452f49c: f943c917    	ldr	x23, [x8, #0x790] ; selector isEqualToString:
10452f4a0: 900cfc02    	adrp	x2, 0x11e4af000 <dyld_stub_binder+0x11e4af000>
10452f4a4: 911a2042    	add	x2, x2, #0x688 ; CFString 'newsapp'
10452f4a8: aa1303e0    	mov	x0, x19
10452f4ac: aa1703e1    	mov	x1, x23
10452f4b0: 94dbdf23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f4b4: 37001420    	tbnz	w0, #0x0, 0x10452f738 <_Flutter_MMFoundation_BindContext+0xa0b31c>
10452f4b8: b00cfc02    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
10452f4bc: 913b2042    	add	x2, x2, #0xec8 ; CFString 'gh_25d9ac85a4bc'
10452f4c0: aa1303e0    	mov	x0, x19
10452f4c4: aa1703e1    	mov	x1, x23
10452f4c8: 94dbdf1d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f4cc: 37001360    	tbnz	w0, #0x0, 0x10452f738 <_Flutter_MMFoundation_BindContext+0xa0b31c>
10452f4d0: f00dc8c8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
10452f4d4: f9460501    	ldr	x1, [x8, #0xc08] ; selector IsNewInvitation
10452f4d8: aa1403e0    	mov	x0, x20
10452f4dc: 94dbdf18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f4e0: 34000480    	cbz	w0, 0x10452f570 <_Flutter_MMFoundation_BindContext+0xa0b154>
10452f4e4: d00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452f4e8: b9875518    	ldrsw	x24, [x8, #0x754]
10452f4ec: f8786aa0    	ldr	x0, [x21, x24]
10452f4f0: b5000120    	cbnz	x0, 0x10452f514 <_Flutter_MMFoundation_BindContext+0xa0b0f8>
10452f4f4: 900de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452f4f8: f9454100    	ldr	x0, [x8, #0xa80] ; class NSMutableDictionary
10452f4fc: 94dbdf17    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10452f500: f8786aa8    	ldr	x8, [x21, x24]
10452f504: f8386aa0    	str	x0, [x21, x24]
10452f508: aa0803e0    	mov	x0, x8
10452f50c: 94dbdf12    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f510: f8786aa0    	ldr	x0, [x21, x24]
10452f514: b00ddea8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10452f518: f947f101    	ldr	x1, [x8, #0xfe0] ; selector objectForKey:
10452f51c: aa1303e2    	mov	x2, x19
10452f520: 94dbdf07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f524: aa1d03fd    	mov	x29, x29
10452f528: 94dbdf08    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452f52c: aa0003f6    	mov	x22, x0
10452f530: 900ddea8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10452f534: f9425101    	ldr	x1, [x8, #0x4a0] ; selector integerValue
10452f538: 94dbdf01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f53c: aa0003f7    	mov	x23, x0
10452f540: aa1603e0    	mov	x0, x22
10452f544: 94dbdf04    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f548: f8786ab5    	ldr	x21, [x21, x24]
10452f54c: 900de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452f550: f9454500    	ldr	x0, [x8, #0xa88] ; class NSString
10452f554: 910006e8    	add	x8, x23, #0x1
10452f558: f00ddec9    	adrp	x9, 0x12010a000 <dyld_stub_binder+0x12010a000>
10452f55c: f946a521    	ldr	x1, [x9, #0xd48] ; selector stringWithFormat:
10452f560: f90003e8    	str	x8, [sp]
10452f564: f00cfc82    	adrp	x2, 0x11e4c2000 <dyld_stub_binder+0x11e4c2000>
10452f568: 913d2042    	add	x2, x2, #0xf48 ; CFString '%ld'
10452f56c: 14000067    	b	0x10452f708 <_Flutter_MMFoundation_BindContext+0xa0b2ec>
10452f570: 900dc8e8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
10452f574: f9435501    	ldr	x1, [x8, #0x6a8] ; selector m_bIsUpdatableMsgSubscribeMsg
10452f578: aa1403e0    	mov	x0, x20
10452f57c: 94dbdef0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f580: 340005e0    	cbz	w0, 0x10452f63c <_Flutter_MMFoundation_BindContext+0xa0b220>
10452f584: d00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452f588: b9875918    	ldrsw	x24, [x8, #0x758]
10452f58c: f8786aa8    	ldr	x8, [x21, x24]
10452f590: b5000188    	cbnz	x8, 0x10452f5c0 <_Flutter_MMFoundation_BindContext+0xa0b1a4>
10452f594: 900de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452f598: f9454100    	ldr	x0, [x8, #0xa80] ; class NSMutableDictionary
10452f59c: d00dde88    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10452f5a0: f9400501    	ldr	x1, [x8, #0x8] ; selector dictionary
10452f5a4: 94dbdee6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f5a8: aa1d03fd    	mov	x29, x29
10452f5ac: 94dbdee7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452f5b0: f8786aa8    	ldr	x8, [x21, x24]
10452f5b4: f8386aa0    	str	x0, [x21, x24]
10452f5b8: aa0803e0    	mov	x0, x8
10452f5bc: 94dbdee6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f5c0: b00de308    	adrp	x8, 0x120190000 <dyld_stub_binder+0x120190000>
10452f5c4: f9432100    	ldr	x0, [x8, #0x640] ; class WAUpdatableMsgSessionInfo
10452f5c8: 94dbdee4    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10452f5cc: aa0003f6    	mov	x22, x0
10452f5d0: d00dc8c8    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
10452f5d4: f9473101    	ldr	x1, [x8, #0xe60] ; selector GetDisplaySessionContent
10452f5d8: aa1403e0    	mov	x0, x20
10452f5dc: 94dbded8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f5e0: aa1d03fd    	mov	x29, x29
10452f5e4: 94dbded9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452f5e8: aa0003f7    	mov	x23, x0
10452f5ec: f00dd1e8    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
10452f5f0: f942c101    	ldr	x1, [x8, #0x580] ; selector setDigestContent:
10452f5f4: aa1603e0    	mov	x0, x22
10452f5f8: aa1703e2    	mov	x2, x23
10452f5fc: 94dbded0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f600: aa1703e0    	mov	x0, x23
10452f604: 94dbded4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f608: f00dd1e8    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
10452f60c: f942c501    	ldr	x1, [x8, #0x588] ; selector m_updatableMsgType
10452f610: aa1403e0    	mov	x0, x20
10452f614: 94dbdeca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f618: aa0003e2    	mov	x2, x0
10452f61c: f00dd1e8    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
10452f620: f942c901    	ldr	x1, [x8, #0x590] ; selector setUpdatableMsgType:
10452f624: aa1603e0    	mov	x0, x22
10452f628: 94dbdec5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f62c: f8786aa0    	ldr	x0, [x21, x24]
10452f630: d00dc848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10452f634: f942c901    	ldr	x1, [x8, #0x590] ; selector safeSetObject:forKey:
10452f638: 1400003b    	b	0x10452f724 <_Flutter_MMFoundation_BindContext+0xa0b308>
10452f63c: f00dd1e8    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
10452f640: f942cd01    	ldr	x1, [x8, #0x598] ; selector isTransferMessageForNewWCPayBizExt
10452f644: aa1403e0    	mov	x0, x20
10452f648: 94dbdebd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f64c: 34000080    	cbz	w0, 0x10452f65c <_Flutter_MMFoundation_BindContext+0xa0b240>
10452f650: d00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452f654: b9875d16    	ldrsw	x22, [x8, #0x75c]
10452f658: 14000010    	b	0x10452f698 <_Flutter_MMFoundation_BindContext+0xa0b27c>
10452f65c: f00dd1e8    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
10452f660: f942d101    	ldr	x1, [x8, #0x5a0] ; selector isAAMessageForSessionStick
10452f664: aa1403e0    	mov	x0, x20
10452f668: 94dbdeb5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f66c: 34000080    	cbz	w0, 0x10452f67c <_Flutter_MMFoundation_BindContext+0xa0b260>
10452f670: d00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452f674: b9876116    	ldrsw	x22, [x8, #0x760]
10452f678: 14000008    	b	0x10452f698 <_Flutter_MMFoundation_BindContext+0xa0b27c>
10452f67c: f00dd1e8    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
10452f680: f942d501    	ldr	x1, [x8, #0x5a8] ; selector isExclusiveHbMessageForMe
10452f684: aa1403e0    	mov	x0, x20
10452f688: 94dbdead    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f68c: 340006c0    	cbz	w0, 0x10452f764 <_Flutter_MMFoundation_BindContext+0xa0b348>
10452f690: d00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452f694: b9876516    	ldrsw	x22, [x8, #0x764]
10452f698: f8766aa0    	ldr	x0, [x21, x22]
10452f69c: b50001a0    	cbnz	x0, 0x10452f6d0 <_Flutter_MMFoundation_BindContext+0xa0b2b4>
10452f6a0: 900de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452f6a4: f9454100    	ldr	x0, [x8, #0xa80] ; class NSMutableDictionary
10452f6a8: d00dde88    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10452f6ac: f9400501    	ldr	x1, [x8, #0x8] ; selector dictionary
10452f6b0: 94dbdea3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f6b4: aa1d03fd    	mov	x29, x29
10452f6b8: 94dbdea4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452f6bc: f8766aa8    	ldr	x8, [x21, x22]
10452f6c0: f8366aa0    	str	x0, [x21, x22]
10452f6c4: aa0803e0    	mov	x0, x8
10452f6c8: 94dbdea3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f6cc: f8766aa0    	ldr	x0, [x21, x22]
10452f6d0: 900ddea8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10452f6d4: f9424d01    	ldr	x1, [x8, #0x498] ; selector integerForKey:
10452f6d8: aa1303e2    	mov	x2, x19
10452f6dc: 94dbde98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f6e0: f8766ab5    	ldr	x21, [x21, x22]
10452f6e4: 900de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452f6e8: f9454508    	ldr	x8, [x8, #0xa88] ; class NSString
10452f6ec: 91000409    	add	x9, x0, #0x1
10452f6f0: f00ddeca    	adrp	x10, 0x12010a000 <dyld_stub_binder+0x12010a000>
10452f6f4: f946a541    	ldr	x1, [x10, #0xd48] ; selector stringWithFormat:
10452f6f8: f90003e9    	str	x9, [sp]
10452f6fc: f00cfc82    	adrp	x2, 0x11e4c2000 <dyld_stub_binder+0x11e4c2000>
10452f700: 913d2042    	add	x2, x2, #0xf48 ; CFString '%ld'
10452f704: aa0803e0    	mov	x0, x8
10452f708: 94dbde8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f70c: aa1d03fd    	mov	x29, x29
10452f710: 94dbde8e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452f714: aa0003f6    	mov	x22, x0
10452f718: d00dc848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10452f71c: f942c901    	ldr	x1, [x8, #0x590] ; selector safeSetObject:forKey:
10452f720: aa1503e0    	mov	x0, x21
10452f724: aa1603e2    	mov	x2, x22
10452f728: aa1303e3    	mov	x3, x19
10452f72c: 94dbde84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f730: aa1603e0    	mov	x0, x22
10452f734: 94dbde88    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f738: aa1403e0    	mov	x0, x20
10452f73c: 94dbde86    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f740: aa1303e0    	mov	x0, x19
10452f744: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10452f748: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10452f74c: a94457f6    	ldp	x22, x21, [sp, #0x40]
10452f750: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10452f754: a94267fa    	ldp	x26, x25, [sp, #0x20]
10452f758: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10452f75c: 9101c3ff    	add	sp, sp, #0x70
10452f760: 14dbde7d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f764: d00dca88    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
10452f768: f942e517    	ldr	x23, [x8, #0x5c8] ; selector IsAtMe
10452f76c: aa1403e0    	mov	x0, x20
10452f770: aa1703e1    	mov	x1, x23
10452f774: 94dbde72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f778: 370000c0    	tbnz	w0, #0x0, 0x10452f790 <_Flutter_MMFoundation_BindContext+0xa0b374>
10452f77c: d00dca88    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
10452f780: f942e901    	ldr	x1, [x8, #0x5d0] ; selector IsAtAll
10452f784: aa1403e0    	mov	x0, x20
10452f788: 94dbde6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f78c: 360006e0    	tbz	w0, #0x0, 0x10452f868 <_Flutter_MMFoundation_BindContext+0xa0b44c>
10452f790: d00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452f794: b987691b    	ldrsw	x27, [x8, #0x768]
10452f798: f87b6aa0    	ldr	x0, [x21, x27]
10452f79c: b00ddea8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10452f7a0: 900ddeb8    	adrp	x24, 0x120103000 <dyld_stub_binder+0x120103000>
10452f7a4: b4000180    	cbz	x0, 0x10452f7d4 <_Flutter_MMFoundation_BindContext+0xa0b3b8>
10452f7a8: f947f101    	ldr	x1, [x8, #0xfe0] ; selector objectForKey:
10452f7ac: aa1303e2    	mov	x2, x19
10452f7b0: 94dbde63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f7b4: aa1d03fd    	mov	x29, x29
10452f7b8: 94dbde64    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452f7bc: aa0003f9    	mov	x25, x0
10452f7c0: aa1803fc    	mov	x28, x24
10452f7c4: f9425301    	ldr	x1, [x24, #0x4a0] ; selector integerValue
10452f7c8: 94dbde5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f7cc: aa0003f8    	mov	x24, x0
10452f7d0: 14000008    	b	0x10452f7f0 <_Flutter_MMFoundation_BindContext+0xa0b3d4>
10452f7d4: aa1803fc    	mov	x28, x24
10452f7d8: 900de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452f7dc: f9454100    	ldr	x0, [x8, #0xa80] ; class NSMutableDictionary
10452f7e0: 94dbde5e    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10452f7e4: 52800018    	mov	w24, #0x0               ; =0
10452f7e8: f87b6ab9    	ldr	x25, [x21, x27]
10452f7ec: f83b6aa0    	str	x0, [x21, x27]
10452f7f0: aa1903e0    	mov	x0, x25
10452f7f4: 94dbde58    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f7f8: aa1403e0    	mov	x0, x20
10452f7fc: aa1703e1    	mov	x1, x23
10452f800: 94dbde4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f804: 52800028    	mov	w8, #0x1                ; =1
10452f808: 37000680    	tbnz	w0, #0x0, 0x10452f8d8 <_Flutter_MMFoundation_BindContext+0xa0b4bc>
10452f80c: 7100071f    	cmp	w24, #0x1
10452f810: 54000640    	b.eq	0x10452f8d8 <_Flutter_MMFoundation_BindContext+0xa0b4bc>
10452f814: d00dca88    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
10452f818: f942e901    	ldr	x1, [x8, #0x5d0] ; selector IsAtAll
10452f81c: aa1403e0    	mov	x0, x20
10452f820: 94dbde47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f824: 52800068    	mov	w8, #0x3                ; =3
10452f828: 71000f1f    	cmp	w24, #0x3
10452f82c: 54000560    	b.eq	0x10452f8d8 <_Flutter_MMFoundation_BindContext+0xa0b4bc>
10452f830: 37000540    	tbnz	w0, #0x0, 0x10452f8d8 <_Flutter_MMFoundation_BindContext+0xa0b4bc>
10452f834: d00dca88    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
10452f838: f942ed01    	ldr	x1, [x8, #0x5d8] ; selector IsRoomAnnouncement
10452f83c: aa1403e0    	mov	x0, x20
10452f840: 94dbde3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f844: 34000480    	cbz	w0, 0x10452f8d4 <_Flutter_MMFoundation_BindContext+0xa0b4b8>
10452f848: f9411f40    	ldr	x0, [x26, #0x238] ; class CMessageWrap
10452f84c: aa1603e1    	mov	x1, x22
10452f850: aa1403e2    	mov	x2, x20
10452f854: 94dbde3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f858: 7100001f    	cmp	w0, #0x0
10452f85c: 52800048    	mov	w8, #0x2                ; =2
10452f860: 1a881308    	csel	w8, w24, w8, ne
10452f864: 1400001d    	b	0x10452f8d8 <_Flutter_MMFoundation_BindContext+0xa0b4bc>
10452f868: d00dca88    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
10452f86c: f942ed01    	ldr	x1, [x8, #0x5d8] ; selector IsRoomAnnouncement
10452f870: aa1403e0    	mov	x0, x20
10452f874: 94dbde32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f878: 340000c0    	cbz	w0, 0x10452f890 <_Flutter_MMFoundation_BindContext+0xa0b474>
10452f87c: f9411f40    	ldr	x0, [x26, #0x238] ; class CMessageWrap
10452f880: aa1603e1    	mov	x1, x22
10452f884: aa1403e2    	mov	x2, x20
10452f888: 94dbde2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f88c: 34fff820    	cbz	w0, 0x10452f790 <_Flutter_MMFoundation_BindContext+0xa0b374>
10452f890: 900de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452f894: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
10452f898: d00dc848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10452f89c: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
10452f8a0: b00d1128    	adrp	x8, 0x11e754000 <dyld_stub_binder+0x11e754000>
10452f8a4: 913d2108    	add	x8, x8, #0xf48 ; CFString 'AddMsg is not At Me'
10452f8a8: f90003e8    	str	x8, [sp]
10452f8ac: d00b6963    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
10452f8b0: 911f2c63    	add	x3, x3, #0x7cb ; string 'Session'
10452f8b4: 900b9205    	adrp	x5, 0x11b76f000 <dyld_stub_binder+0x11b76f000>
10452f8b8: 913ffca5    	add	x5, x5, #0xfff ; string 'MMNewSessionMgr.mm'
10452f8bc: d00b9207    	adrp	x7, 0x11b771000 <dyld_stub_binder+0x11b771000>
10452f8c0: 9120ace7    	add	x7, x7, #0x82b ; string '-[MMNewSessionMgr OnAddMsg:MsgWrap:]'
10452f8c4: 52800042    	mov	w2, #0x2                ; =2
10452f8c8: 52800004    	mov	w4, #0x0                ; =0
10452f8cc: 528141c6    	mov	w6, #0xa0e              ; =2574
10452f8d0: 17fffed2    	b	0x10452f418 <_Flutter_MMFoundation_BindContext+0xa0affc>
10452f8d4: aa1803e8    	mov	x8, x24
10452f8d8: f87b6ab8    	ldr	x24, [x21, x27]
10452f8dc: 900de23a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
10452f8e0: f9454740    	ldr	x0, [x26, #0xa88] ; class NSString
10452f8e4: 2a0803e8    	mov	w8, w8
10452f8e8: f00ddec9    	adrp	x9, 0x12010a000 <dyld_stub_binder+0x12010a000>
10452f8ec: f946a536    	ldr	x22, [x9, #0xd48] ; selector stringWithFormat:
10452f8f0: f90003e8    	str	x8, [sp]
10452f8f4: f00cfc82    	adrp	x2, 0x11e4c2000 <dyld_stub_binder+0x11e4c2000>
10452f8f8: 913d2042    	add	x2, x2, #0xf48 ; CFString '%ld'
10452f8fc: aa1603e1    	mov	x1, x22
10452f900: 94dbde0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f904: aa1d03fd    	mov	x29, x29
10452f908: 94dbde10    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452f90c: aa0003f9    	mov	x25, x0
10452f910: d00dc848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10452f914: f942c917    	ldr	x23, [x8, #0x590] ; selector safeSetObject:forKey:
10452f918: aa1803e0    	mov	x0, x24
10452f91c: aa1703e1    	mov	x1, x23
10452f920: aa1903e2    	mov	x2, x25
10452f924: aa1303e3    	mov	x3, x19
10452f928: 94dbde05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f92c: aa1903e0    	mov	x0, x25
10452f930: 94dbde09    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f934: d00de768    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10452f938: b9876d1b    	ldrsw	x27, [x8, #0x76c]
10452f93c: f87b6aa0    	ldr	x0, [x21, x27]
10452f940: b5000120    	cbnz	x0, 0x10452f964 <_Flutter_MMFoundation_BindContext+0xa0b548>
10452f944: 900de228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10452f948: f9454100    	ldr	x0, [x8, #0xa80] ; class NSMutableDictionary
10452f94c: 94dbde03    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10452f950: f87b6aa8    	ldr	x8, [x21, x27]
10452f954: f83b6aa0    	str	x0, [x21, x27]
10452f958: aa0803e0    	mov	x0, x8
10452f95c: 94dbddfe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f960: f87b6aa0    	ldr	x0, [x21, x27]
10452f964: b00ddea8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10452f968: f947f101    	ldr	x1, [x8, #0xfe0] ; selector objectForKey:
10452f96c: aa1303e2    	mov	x2, x19
10452f970: 94dbddf3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f974: aa1d03fd    	mov	x29, x29
10452f978: 94dbddf4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452f97c: aa0003f8    	mov	x24, x0
10452f980: f9425381    	ldr	x1, [x28, #0x4a0]
10452f984: 94dbddee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f988: aa0003f9    	mov	x25, x0
10452f98c: aa1803e0    	mov	x0, x24
10452f990: 94dbddf1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10452f994: f87b6ab5    	ldr	x21, [x21, x27]
10452f998: f9454740    	ldr	x0, [x26, #0xa88] ; class NSString
10452f99c: 91000728    	add	x8, x25, #0x1
10452f9a0: f90003e8    	str	x8, [sp]
10452f9a4: f00cfc82    	adrp	x2, 0x11e4c2000 <dyld_stub_binder+0x11e4c2000>
10452f9a8: 913d2042    	add	x2, x2, #0xf48 ; CFString '%ld'
10452f9ac: aa1603e1    	mov	x1, x22
10452f9b0: 94dbdde3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10452f9b4: aa1d03fd    	mov	x29, x29
10452f9b8: 94dbdde4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10452f9bc: aa0003f6    	mov	x22, x0
10452f9c0: aa1503e0    	mov	x0, x21
10452f9c4: aa1703e1    	mov	x1, x23
10452f9c8: 17ffff57    	b	0x10452f724 <_Flutter_MMFoundation_BindContext+0xa0b308>
