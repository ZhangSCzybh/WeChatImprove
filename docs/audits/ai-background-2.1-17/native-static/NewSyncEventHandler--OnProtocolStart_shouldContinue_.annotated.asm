
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10517ca40: d10143ff    	sub	sp, sp, #0x50
10517ca44: a90257f6    	stp	x22, x21, [sp, #0x20]
10517ca48: a9034ff4    	stp	x20, x19, [sp, #0x30]
10517ca4c: a9047bfd    	stp	x29, x30, [sp, #0x40]
10517ca50: 910103fd    	add	x29, sp, #0x40
10517ca54: aa0203f4    	mov	x20, x2
10517ca58: aa0003f3    	mov	x19, x0
10517ca5c: f00c2388    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10517ca60: f9405908    	ldr	x8, [x8, #0xb0] ; bind ___stack_chk_guard
10517ca64: f9400108    	ldr	x8, [x8]
10517ca68: f9000fe8    	str	x8, [sp, #0x18]
10517ca6c: f00dd608    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
10517ca70: 52800029    	mov	w9, #0x1                ; =1
10517ca74: 39330d09    	strb	w9, [x8, #0xcc3]
10517ca78: 39000069    	strb	w9, [x3]
10517ca7c: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517ca80: f9457115    	ldr	x21, [x8, #0xae0] ; bind _OBJC_CLASS_$_NSDate
10517ca84: 900d7c28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10517ca88: f9460d16    	ldr	x22, [x8, #0xc18] ; selector/string date
10517ca8c: aa0203e0    	mov	x0, x2
10517ca90: 94aaa9aa    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10517ca94: aa1503e0    	mov	x0, x21
10517ca98: aa1603e1    	mov	x1, x22
10517ca9c: 94aaa9a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517caa0: aa1d03fd    	mov	x29, x29
10517caa4: 94aaa9a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517caa8: aa0003f5    	mov	x21, x0
10517caac: f00d7c68    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10517cab0: f940a901    	ldr	x1, [x8, #0x150] ; selector/string timeIntervalSince1970
10517cab4: 94aaa9a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cab8: 1e790008    	fcvtzu	w8, d0
10517cabc: 900d8569    	adrp	x9, 0x120228000 <dyld_stub_binder+0x120228000>
10517cac0: b988e129    	ldrsw	x9, [x9, #0x8e0] ; ivar NewSyncEventHandler.ct1 offset=8 type=I
10517cac4: b8296a68    	str	w8, [x19, x9]
10517cac8: aa1503e0    	mov	x0, x21
10517cacc: 94aaa9a2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cad0: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517cad4: f9467900    	ldr	x0, [x8, #0xcf0] ; class CUtility
10517cad8: d00d65e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10517cadc: f940ad01    	ldr	x1, [x8, #0x158] ; selector/string genCurrentTimeInMs
10517cae0: 94aaa997    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cae4: 900d8568    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10517cae8: b988e508    	ldrsw	x8, [x8, #0x8e4] ; ivar NewSyncEventHandler.m_startTime offset=16 type=Q
10517caec: f8286a60    	str	x0, [x19, x8]
10517caf0: f00d65e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10517caf4: f9447901    	ldr	x1, [x8, #0x8f0] ; selector/string m_pbRequest
10517caf8: aa1403e0    	mov	x0, x20
10517cafc: 94aaa990    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cb00: aa1d03fd    	mov	x29, x29
10517cb04: 94aaa991    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cb08: aa0003f3    	mov	x19, x0
10517cb0c: aa1403e0    	mov	x0, x20
10517cb10: 94aaa991    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cb14: d00d7c48    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10517cb18: f9450901    	ldr	x1, [x8, #0xa10] ; selector/string scene
10517cb1c: aa1303e0    	mov	x0, x19
10517cb20: 94aaa987    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cb24: 7100181f    	cmp	w0, #0x6
10517cb28: 54000860    	b.eq	0x10517cc34 <_Flutter_MMFoundation_BindContext+0x1658818>
10517cb2c: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517cb30: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
10517cb34: 900d7c28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10517cb38: f944e901    	ldr	x1, [x8, #0x9d0] ; selector/string currentContext
10517cb3c: 94aaa980    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cb40: aa1d03fd    	mov	x29, x29
10517cb44: 94aaa981    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cb48: aa0003f4    	mov	x20, x0
10517cb4c: 900d7fa8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10517cb50: f9462502    	ldr	x2, [x8, #0xc48]
10517cb54: 900d7108    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517cb58: f9420903    	ldr	x3, [x8, #0x410] ; selector/string onNewSyncBegin
10517cb5c: d00d65e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10517cb60: f940d501    	ldr	x1, [x8, #0x1a8] ; selector/string callExtensionOnMainThread:selector:sync:block:
10517cb64: d00c2785    	adrp	x5, 0x11d66e000 <dyld_stub_binder+0x11d66e000>
10517cb68: 911500a5    	add	x5, x5, #0x540
10517cb6c: 52800004    	mov	w4, #0x0                ; =0
10517cb70: 94aaa973    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cb74: aa1403e0    	mov	x0, x20
10517cb78: 94aaa977    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cb7c: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517cb80: f9458d00    	ldr	x0, [x8, #0xb18] ; bind _OBJC_CLASS_$_NSNotificationCenter
10517cb84: 900d7c28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10517cb88: f946b101    	ldr	x1, [x8, #0xd60] ; selector/string defaultCenter
10517cb8c: 94aaa96c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cb90: aa1d03fd    	mov	x29, x29
10517cb94: 94aaa96d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cb98: aa0003f4    	mov	x20, x0
10517cb9c: d00cb268    	adrp	x8, 0x11e7ca000 <dyld_stub_binder+0x11e7ca000>
10517cba0: 91162108    	add	x8, x8, #0x588 ; CFString 'isFromPush'
10517cba4: f90007e8    	str	x8, [sp, #0x8]
10517cba8: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517cbac: f9458900    	ldr	x0, [x8, #0xb10] ; bind _OBJC_CLASS_$_NSNumber
10517cbb0: 900d7c48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10517cbb4: f9479501    	ldr	x1, [x8, #0xf28] ; selector/string numberWithBool:
10517cbb8: 52800002    	mov	w2, #0x0                ; =0
10517cbbc: 94aaa960    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cbc0: aa1d03fd    	mov	x29, x29
10517cbc4: 94aaa961    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cbc8: aa0003f5    	mov	x21, x0
10517cbcc: f9000be0    	str	x0, [sp, #0x10]
10517cbd0: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517cbd4: f9457500    	ldr	x0, [x8, #0xae8] ; bind _OBJC_CLASS_$_NSDictionary
10517cbd8: b00d7c28    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10517cbdc: f9402901    	ldr	x1, [x8, #0x50] ; selector/string dictionaryWithObjects:forKeys:count:
10517cbe0: 910043e2    	add	x2, sp, #0x10
10517cbe4: 910023e3    	add	x3, sp, #0x8
10517cbe8: 52800024    	mov	w4, #0x1                ; =1
10517cbec: 94aaa954    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cbf0: aa1d03fd    	mov	x29, x29
10517cbf4: 94aaa955    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cbf8: aa0003f6    	mov	x22, x0
10517cbfc: b00d7c48    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
10517cc00: f944d901    	ldr	x1, [x8, #0x9b0] ; selector/string postNotificationName:object:userInfo:
10517cc04: d00cb262    	adrp	x2, 0x11e7ca000 <dyld_stub_binder+0x11e7ca000>
10517cc08: 9103a042    	add	x2, x2, #0xe8 ; CFString 'NewSyncBeginNotifyEvent'
10517cc0c: aa1403e0    	mov	x0, x20
10517cc10: d2800003    	mov	x3, #0x0                ; =0
10517cc14: aa1603e4    	mov	x4, x22
10517cc18: 94aaa949    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cc1c: aa1603e0    	mov	x0, x22
10517cc20: 94aaa94d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cc24: aa1503e0    	mov	x0, x21
10517cc28: 94aaa94b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cc2c: aa1403e0    	mov	x0, x20
10517cc30: 94aaa949    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cc34: aa1303e0    	mov	x0, x19
10517cc38: 94aaa947    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cc3c: f9400fe8    	ldr	x8, [sp, #0x18]
10517cc40: f00c2389    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10517cc44: f9405929    	ldr	x9, [x9, #0xb0] ; bind ___stack_chk_guard
10517cc48: f9400129    	ldr	x9, [x9]
10517cc4c: eb08013f    	cmp	x9, x8
10517cc50: 540000c1    	b.ne	0x10517cc68 <_Flutter_MMFoundation_BindContext+0x165884c>
10517cc54: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10517cc58: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10517cc5c: a94257f6    	ldp	x22, x21, [sp, #0x20]
10517cc60: 910143ff    	add	sp, sp, #0x50
10517cc64: d65f03c0    	ret
10517cc68: 94aaa943    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
