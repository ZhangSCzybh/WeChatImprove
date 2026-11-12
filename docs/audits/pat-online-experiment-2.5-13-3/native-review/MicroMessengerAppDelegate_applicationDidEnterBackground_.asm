
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
104e85520: d10243ff    	sub	sp, sp, #0x90
104e85524: a90467fa    	stp	x26, x25, [sp, #0x40]
104e85528: a9055ff8    	stp	x24, x23, [sp, #0x50]
104e8552c: a90657f6    	stp	x22, x21, [sp, #0x60]
104e85530: a9074ff4    	stp	x20, x19, [sp, #0x70]
104e85534: a9087bfd    	stp	x29, x30, [sp, #0x80]
104e85538: 910203fd    	add	x29, sp, #0x80
104e8553c: aa0203f3    	mov	x19, x2
104e85540: aa0003f4    	mov	x20, x0
104e85544: 900d4668    	adrp	x8, 0x11f751000 <dyld_stub_binder+0x11f751000>
104e85548: 52800029    	mov	w9, #0x1                ; =1
104e8554c: 39387909    	strb	w9, [x8, #0xe1e]
104e85550: aa0203e0    	mov	x0, x2
104e85554: 94b689c8    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
104e85558: b00cf477    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104e8555c: f943c2e0    	ldr	x0, [x23, #0x780] ; class MMContext
104e85560: 900cda28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104e85564: f9457d01    	ldr	x1, [x8, #0xaf8] ; selector activeUserContext
104e85568: 94b689bf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e8556c: aa1d03fd    	mov	x29, x29
104e85570: 94b689c4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e85574: aa0003f5    	mov	x21, x0
104e85578: 9100a3e0    	add	x0, sp, #0x28
104e8557c: aa1503e1    	mov	x1, x21
104e85580: 52800002    	mov	w2, #0x0                ; =0
104e85584: 94b61da7    	bl	0x107c0cc20 <_Flutter_MMFoundation_BindContext+0x3e938ec>
104e85588: aa1503e0    	mov	x0, x21
104e8558c: 94b689b9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e85590: b00cf478    	adrp	x24, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104e85594: f9430f16    	ldr	x22, [x24, #0x618] ; class iConsole
104e85598: b00cdaa8    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
104e8559c: f9433101    	ldr	x1, [x8, #0x660] ; selector backgroundTimeRemaining
104e855a0: aa1303e0    	mov	x0, x19
104e855a4: 94b689b0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e855a8: 900cda28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104e855ac: f9418915    	ldr	x21, [x8, #0x310] ; selector logWithLevel:module:errorCode:file:line:func:format:
104e855b0: fd0007e0    	str	d0, [sp, #0x8]
104e855b4: b00c2228    	adrp	x8, 0x11d2ca000 <dyld_stub_binder+0x11d2ca000>
104e855b8: 9109e108    	add	x8, x8, #0x278 ; cfstring '<!WXG!>applicationDidEnterBackground %f'
104e855bc: f90003e8    	str	x8, [sp]
104e855c0: d00a9a05    	adrp	x5, 0x11a1c7000 <dyld_stub_binder+0x11a1c7000>
104e855c4: 911470a5    	add	x5, x5, #0x51c ; 'MicroMessengerAppDelegate.mm'
104e855c8: f00a9a07    	adrp	x7, 0x11a1c8000 <dyld_stub_binder+0x11a1c8000>
104e855cc: 9132e0e7    	add	x7, x7, #0xcb8 ; '-[MicroMessengerAppDelegate applicationDidEnterBackground:]'
104e855d0: aa1603e0    	mov	x0, x22
104e855d4: aa1503e1    	mov	x1, x21
104e855d8: 52800042    	mov	w2, #0x2                ; =2
104e855dc: d2800003    	mov	x3, #0x0                ; =0
104e855e0: 52800004    	mov	w4, #0x0                ; =0
104e855e4: 5280fec6    	mov	w6, #0x7f6              ; =2038
104e855e8: 94b6899f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e855ec: b00ce508    	adrp	x8, 0x11eb26000 <dyld_stub_binder+0x11eb26000>
104e855f0: f9402501    	ldr	x1, [x8, #0x48] ; selector setupForShortcut
104e855f4: aa1403e0    	mov	x0, x20
104e855f8: 94b6899b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e855fc: b00cfa08    	adrp	x8, 0x11edc6000 <dyld_stub_binder+0x11edc6000>
104e85600: b9838908    	ldrsw	x8, [x8, #0x388]
104e85604: 38286a9f    	strb	wzr, [x20, x8]
104e85608: d2800000    	mov	x0, #0x0                ; =0
104e8560c: 94b68a08    	bl	0x107c27e2c <_Flutter_MMFoundation_BindContext+0x3eaeaf8>
104e85610: 900d6f56    	adrp	x22, 0x11fc6d000 <dyld_stub_binder+0x11fc6d000>
104e85614: f940a2c8    	ldr	x8, [x22, #0x140] ; 0x11fc6d140 __common
104e85618: cb080008    	sub	x8, x0, x8
104e8561c: 900d6f49    	adrp	x9, 0x11fc6d000 <dyld_stub_binder+0x11fc6d000>
104e85620: f900a528    	str	x8, [x9, #0x148]
104e85624: 900d6f59    	adrp	x25, 0x11fc6d000 <dyld_stub_binder+0x11fc6d000>
104e85628: f100051f    	cmp	x8, #0x1
104e8562c: 540000eb    	b.lt	0x104e85648 <_Flutter_MMFoundation_BindContext+0x110c314>
104e85630: f9409f29    	ldr	x9, [x25, #0x138] ; 0x11fc6d138 __common
104e85634: 8b080128    	add	x8, x9, x8
104e85638: f9009f28    	str	x8, [x25, #0x138]
104e8563c: d2800000    	mov	x0, #0x0                ; =0
104e85640: 94b689fb    	bl	0x107c27e2c <_Flutter_MMFoundation_BindContext+0x3eaeaf8>
104e85644: f900a2c0    	str	x0, [x22, #0x140]
104e85648: f9409f28    	ldr	x8, [x25, #0x138] ; 0x11fc6d138 __common
104e8564c: 528a3029    	mov	w9, #0x5181             ; =20865
104e85650: 72a00029    	movk	w9, #0x1, lsl #16
104e85654: eb09011f    	cmp	x8, x9
104e85658: 5400100a    	b.ge	0x104e85858 <_Flutter_MMFoundation_BindContext+0x110c524>
104e8565c: f00cf468    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
104e85660: f940d900    	ldr	x0, [x8, #0x1b0] ; class MMContextManager
104e85664: b00cf108    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104e85668: f9468501    	ldr	x1, [x8, #0xd08] ; selector defaultManager
104e8566c: 94b6897e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e85670: aa1d03fd    	mov	x29, x29
104e85674: 94b68983    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e85678: aa0003f5    	mov	x21, x0
104e8567c: 900cda48    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
104e85680: f9437501    	ldr	x1, [x8, #0x6e8] ; selector callEnterBackground
104e85684: 94b68978    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e85688: aa1503e0    	mov	x0, x21
104e8568c: 94b68979    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e85690: f943c2e0    	ldr	x0, [x23, #0x780] ; class MMContext
104e85694: 900cda28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104e85698: f9440101    	ldr	x1, [x8, #0x800] ; selector currentContext
104e8569c: 94b68972    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e856a0: aa1d03fd    	mov	x29, x29
104e856a4: 94b68977    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e856a8: aa0003f5    	mov	x21, x0
104e856ac: b00cf568    	adrp	x8, 0x11ed32000 <dyld_stub_binder+0x11ed32000>
104e856b0: f945d500    	ldr	x0, [x8, #0xba8] ; class AppleSearchMgr
104e856b4: b00cf108    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104e856b8: f9428501    	ldr	x1, [x8, #0x508] ; selector class
104e856bc: 94b6896a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e856c0: aa0003e2    	mov	x2, x0
104e856c4: 900cda28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104e856c8: f9452101    	ldr	x1, [x8, #0xa40] ; selector getService:
104e856cc: aa1503e0    	mov	x0, x21
104e856d0: 94b68965    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e856d4: aa1d03fd    	mov	x29, x29
104e856d8: 94b6896a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e856dc: aa0003f6    	mov	x22, x0
104e856e0: b00ce508    	adrp	x8, 0x11eb26000 <dyld_stub_binder+0x11eb26000>
104e856e4: f9402901    	ldr	x1, [x8, #0x50] ; selector indexActivities
104e856e8: 94b6895f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e856ec: aa1603e0    	mov	x0, x22
104e856f0: 94b68960    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e856f4: aa1503e0    	mov	x0, x21
104e856f8: 94b6895e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e856fc: b00cf468    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104e85700: f9436500    	ldr	x0, [x8, #0x6c8] ; 0x11ed126c8 (?) bind pointer 0x801000000000280d
104e85704: b00cf108    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104e85708: f9466901    	ldr	x1, [x8, #0xcd0] ; selector defaultCenter
104e8570c: 94b68956    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e85710: aa1d03fd    	mov	x29, x29
104e85714: 94b6895b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e85718: aa0003f5    	mov	x21, x0
104e8571c: d00ba328    	adrp	x8, 0x11c2eb000 <dyld_stub_binder+0x11c2eb000>
104e85720: 91320108    	add	x8, x8, #0xc80 ; 0x11c2ebc80 __const
104e85724: f9400102    	ldr	x2, [x8]
104e85728: 900cf128    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
104e8572c: f9478501    	ldr	x1, [x8, #0xf08] ; selector postNotificationName:object:userInfo:
104e85730: aa1403e3    	mov	x3, x20
104e85734: d2800004    	mov	x4, #0x0                ; =0
104e85738: 94b6894b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e8573c: aa1503e0    	mov	x0, x21
104e85740: 94b6894c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e85744: 900ce508    	adrp	x8, 0x11eb25000 <dyld_stub_binder+0x11eb25000>
104e85748: f947e101    	ldr	x1, [x8, #0xfc0] ; selector submitAppRefreshTaskRequest
104e8574c: aa1403e0    	mov	x0, x20
104e85750: 94b68945    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e85754: f00cf474    	adrp	x20, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
104e85758: f946d280    	ldr	x0, [x20, #0xda0] ; class BackgroundTask
104e8575c: d00cde28    	adrp	x8, 0x11ea4b000 <dyld_stub_binder+0x11ea4b000>
104e85760: f9421501    	ldr	x1, [x8, #0x428] ; selector run
104e85764: 94b68940    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e85768: f946d280    	ldr	x0, [x20, #0xda0] ; class BackgroundTask
104e8576c: b00ce508    	adrp	x8, 0x11eb26000 <dyld_stub_binder+0x11eb26000>
104e85770: f9402d01    	ldr	x1, [x8, #0x58] ; selector startSuspendObserver
104e85774: 94b6893c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e85778: 910043e0    	add	x0, sp, #0x10
104e8577c: 528000e1    	mov	w1, #0x7                ; =7
104e85780: 96c7ec42    	bl	0x100080888 <__text+0x78888>
104e85784: 528cac88    	mov	w8, #0x6564             ; =25956
104e85788: 72ac2cc8    	movk	w8, #0x6166, lsl #16
104e8578c: b9000008    	str	w8, [x0]
104e85790: 528eac28    	mov	w8, #0x7561             ; =30049
104e85794: 72ae8d88    	movk	w8, #0x746c, lsl #16
104e85798: b8003008    	stur	w8, [x0, #0x3]
104e8579c: 39001c1f    	strb	wzr, [x0, #0x7]
104e857a0: 910043e1    	add	x1, sp, #0x10
104e857a4: 52800000    	mov	w0, #0x0                ; =0
104e857a8: 94b61ada    	bl	0x107c0c310 <_Flutter_MMFoundation_BindContext+0x3e92fdc>
104e857ac: 39c09fe8    	ldrsb	w8, [sp, #0x27]
104e857b0: 36f800a8    	tbz	w8, #0x1f, 0x104e857c4 <_Flutter_MMFoundation_BindContext+0x110c490>
104e857b4: f9400be0    	ldr	x0, [sp, #0x10]
104e857b8: f94013e8    	ldr	x8, [sp, #0x20]
104e857bc: 9240f901    	and	x1, x8, #0x7fffffffffffffff
104e857c0: 94b687cc    	bl	0x107c276f0 <_Flutter_MMFoundation_BindContext+0x3eae3bc>
104e857c4: 941df18a    	bl	0x105601dec <_Flutter_MMFoundation_BindContext+0x1888ab8>
104e857c8: 941df24f    	bl	0x105602104 <_Flutter_MMFoundation_BindContext+0x1888dd0>
104e857cc: 34000280    	cbz	w0, 0x104e8581c <_Flutter_MMFoundation_BindContext+0x110c4e8>
104e857d0: 910043e0    	add	x0, sp, #0x10
104e857d4: 528000e1    	mov	w1, #0x7                ; =7
104e857d8: 96c7ec2c    	bl	0x100080888 <__text+0x78888>
104e857dc: 528cac88    	mov	w8, #0x6564             ; =25956
104e857e0: 72ac2cc8    	movk	w8, #0x6166, lsl #16
104e857e4: b9000008    	str	w8, [x0]
104e857e8: 528eac28    	mov	w8, #0x7561             ; =30049
104e857ec: 72ae8d88    	movk	w8, #0x746c, lsl #16
104e857f0: b8003008    	stur	w8, [x0, #0x3]
104e857f4: 39001c1f    	strb	wzr, [x0, #0x7]
104e857f8: 910043e1    	add	x1, sp, #0x10
104e857fc: 52800000    	mov	w0, #0x0                ; =0
104e85800: 95a2f868    	bl	0x10b7439a0 <_mmkv_importFrom+0x880bfc>
104e85804: 39c09fe8    	ldrsb	w8, [sp, #0x27]
104e85808: 36f800a8    	tbz	w8, #0x1f, 0x104e8581c <_Flutter_MMFoundation_BindContext+0x110c4e8>
104e8580c: f9400be0    	ldr	x0, [sp, #0x10]
104e85810: f94013e8    	ldr	x8, [sp, #0x20]
104e85814: 9240f901    	and	x1, x8, #0x7fffffffffffffff
104e85818: 94b687b6    	bl	0x107c276f0 <_Flutter_MMFoundation_BindContext+0x3eae3bc>
104e8581c: b00d6f48    	adrp	x8, 0x11fc6e000 <dyld_stub_binder+0x11fc6e000>
104e85820: 91282108    	add	x8, x8, #0xa08 ; 0x11fc6ea08 __common
104e85824: 52800029    	mov	w9, #0x1                ; =1
104e85828: 39000109    	strb	w9, [x8]
104e8582c: 9100a3e0    	add	x0, sp, #0x28
104e85830: 94b61cfd    	bl	0x107c0cc24 <_Flutter_MMFoundation_BindContext+0x3e938f0>
104e85834: aa1303e0    	mov	x0, x19
104e85838: 94b6890e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e8583c: a9487bfd    	ldp	x29, x30, [sp, #0x80]
104e85840: a9474ff4    	ldp	x20, x19, [sp, #0x70]
104e85844: a94657f6    	ldp	x22, x21, [sp, #0x60]
104e85848: a9455ff8    	ldp	x24, x23, [sp, #0x50]
104e8584c: a94467fa    	ldp	x26, x25, [sp, #0x40]
104e85850: 910243ff    	add	sp, sp, #0x90
104e85854: d65f03c0    	ret
104e85858: f9430f00    	ldr	x0, [x24, #0x618] ; class iConsole
104e8585c: b00c2228    	adrp	x8, 0x11d2ca000 <dyld_stub_binder+0x11d2ca000>
104e85860: 910a6108    	add	x8, x8, #0x298 ; cfstring 'totalRunningTime > 60 * 60 * MAX_RUNNING_HOURS '
104e85864: f90003e8    	str	x8, [sp]
104e85868: d00a9a05    	adrp	x5, 0x11a1c7000 <dyld_stub_binder+0x11a1c7000>
104e8586c: 911470a5    	add	x5, x5, #0x51c ; 'MicroMessengerAppDelegate.mm'
104e85870: f00a9a07    	adrp	x7, 0x11a1c8000 <dyld_stub_binder+0x11a1c8000>
104e85874: 9132e0e7    	add	x7, x7, #0xcb8 ; '-[MicroMessengerAppDelegate applicationDidEnterBackground:]'
104e85878: aa1503e1    	mov	x1, x21
104e8587c: 52800042    	mov	w2, #0x2                ; =2
104e85880: d2800003    	mov	x3, #0x0                ; =0
104e85884: 52800004    	mov	w4, #0x0                ; =0
104e85888: 528100a6    	mov	w6, #0x805              ; =2053
104e8588c: 94b688f6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e85890: f00cdc08    	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
104e85894: f9435501    	ldr	x1, [x8, #0x6a8] ; selector applicationWillTerminate:
104e85898: aa1403e0    	mov	x0, x20
104e8589c: aa1303e2    	mov	x2, x19
104e858a0: 94b688f1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e858a4: 52800000    	mov	w0, #0x0                ; =0
104e858a8: 94b6881d    	bl	0x107c2791c <_Flutter_MMFoundation_BindContext+0x3eae5e8>
