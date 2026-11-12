
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
104e86180: d102c3ff    	sub	sp, sp, #0xb0
104e86184: a9056ffc    	stp	x28, x27, [sp, #0x50]
104e86188: a90667fa    	stp	x26, x25, [sp, #0x60]
104e8618c: a9075ff8    	stp	x24, x23, [sp, #0x70]
104e86190: a90857f6    	stp	x22, x21, [sp, #0x80]
104e86194: a9094ff4    	stp	x20, x19, [sp, #0x90]
104e86198: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
104e8619c: 910283fd    	add	x29, sp, #0xa0
104e861a0: aa0003f3    	mov	x19, x0
104e861a4: f00d4648    	adrp	x8, 0x11f751000 <dyld_stub_binder+0x11f751000>
104e861a8: 52800029    	mov	w9, #0x1                ; =1
104e861ac: 39387d09    	strb	w9, [x8, #0xe1f]
104e861b0: 900cf468    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104e861b4: f9430d00    	ldr	x0, [x8, #0x618] ; class iConsole
104e861b8: f00cda08    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104e861bc: f9418901    	ldr	x1, [x8, #0x310] ; selector logWithLevel:module:errorCode:file:line:func:format:
104e861c0: 900c2228    	adrp	x8, 0x11d2ca000 <dyld_stub_binder+0x11d2ca000>
104e861c4: 910ce108    	add	x8, x8, #0x338 ; cfstring '<!WXG!>applicationWillEnterForeground'
104e861c8: f90003e8    	str	x8, [sp]
104e861cc: b00a9a05    	adrp	x5, 0x11a1c7000 <dyld_stub_binder+0x11a1c7000>
104e861d0: 911470a5    	add	x5, x5, #0x51c ; 'MicroMessengerAppDelegate.mm'
104e861d4: d00a9a07    	adrp	x7, 0x11a1c8000 <dyld_stub_binder+0x11a1c8000>
104e861d8: 91373ce7    	add	x7, x7, #0xdcf ; '-[MicroMessengerAppDelegate applicationWillEnterForeground:]'
104e861dc: 52800042    	mov	w2, #0x2                ; =2
104e861e0: d2800003    	mov	x3, #0x0                ; =0
104e861e4: 52800004    	mov	w4, #0x0                ; =0
104e861e8: 52810ae6    	mov	w6, #0x857              ; =2135
104e861ec: 94b6869e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e861f0: d00cf4c8    	adrp	x8, 0x11ed20000 <dyld_stub_binder+0x11ed20000>
104e861f4: f9431d00    	ldr	x0, [x8, #0x638] ; class MMLocalNotificationUtil
104e861f8: 900ce408    	adrp	x8, 0x11eb06000 <dyld_stub_binder+0x11eb06000>
104e861fc: f9406501    	ldr	x1, [x8, #0xc8] ; selector cancelAllNotReservedLocalNotificationsWithCompletion:
104e86200: d2800002    	mov	x2, #0x0                ; =0
104e86204: 94b68698    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86208: 900cf47b    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104e8620c: f943c360    	ldr	x0, [x27, #0x780] ; class MMContext
104e86210: f00cda08    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104e86214: f9440115    	ldr	x21, [x8, #0x800] ; selector currentContext
104e86218: aa1503e1    	mov	x1, x21
104e8621c: 94b68692    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86220: aa1d03fd    	mov	x29, x29
104e86224: 94b68697    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e86228: aa0003f8    	mov	x24, x0
104e8622c: 900cf49c    	adrp	x28, 0x11ed16000 <dyld_stub_binder+0x11ed16000>
104e86230: f9461b80    	ldr	x0, [x28, #0xc30] ; class CNetworkStatusMgr
104e86234: 900cf108    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104e86238: f9428516    	ldr	x22, [x8, #0x508] ; selector class
104e8623c: aa1603e1    	mov	x1, x22
104e86240: 94b68689    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86244: aa0003e2    	mov	x2, x0
104e86248: f00cda08    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104e8624c: f9452117    	ldr	x23, [x8, #0xa40] ; selector getService:
104e86250: aa1803e0    	mov	x0, x24
104e86254: aa1703e1    	mov	x1, x23
104e86258: 94b68683    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e8625c: aa1d03fd    	mov	x29, x29
104e86260: 94b68688    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e86264: aa0003f4    	mov	x20, x0
104e86268: aa1803e0    	mov	x0, x24
104e8626c: 94b68681    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e86270: 900ce508    	adrp	x8, 0x11eb26000 <dyld_stub_binder+0x11eb26000>
104e86274: f9405101    	ldr	x1, [x8, #0xa0] ; selector setReadToGettingData
104e86278: aa1403e0    	mov	x0, x20
104e8627c: 94b6867a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86280: 900ce508    	adrp	x8, 0x11eb26000 <dyld_stub_binder+0x11eb26000>
104e86284: f9405501    	ldr	x1, [x8, #0xa8] ; selector handleOpenPush
104e86288: aa1303e0    	mov	x0, x19
104e8628c: 94b68676    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86290: d00cf468    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
104e86294: f940d900    	ldr	x0, [x8, #0x1b0] ; class MMContextManager
104e86298: 900cf108    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104e8629c: f9468501    	ldr	x1, [x8, #0xd08] ; selector defaultManager
104e862a0: 94b68671    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e862a4: aa1d03fd    	mov	x29, x29
104e862a8: 94b68676    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e862ac: aa0003f8    	mov	x24, x0
104e862b0: f00cda28    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
104e862b4: f9437901    	ldr	x1, [x8, #0x6f0] ; selector callEnterForeground
104e862b8: 94b6866b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e862bc: aa1803e0    	mov	x0, x24
104e862c0: 94b6866c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e862c4: 900cf468    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104e862c8: f9436500    	ldr	x0, [x8, #0x6c8] ; 0x11ed126c8 (?) bind pointer 0x801000000000280d
104e862cc: 900cf108    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104e862d0: f9466901    	ldr	x1, [x8, #0xcd0] ; selector defaultCenter
104e862d4: 94b68664    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e862d8: aa1d03fd    	mov	x29, x29
104e862dc: 94b68669    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e862e0: aa0003f8    	mov	x24, x0
104e862e4: b00ba328    	adrp	x8, 0x11c2eb000 <dyld_stub_binder+0x11c2eb000>
104e862e8: 91322108    	add	x8, x8, #0xc88 ; 0x11c2ebc88 __const
104e862ec: f9400102    	ldr	x2, [x8]
104e862f0: f00cf108    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
104e862f4: f9478501    	ldr	x1, [x8, #0xf08] ; selector postNotificationName:object:userInfo:
104e862f8: aa1303e3    	mov	x3, x19
104e862fc: d2800004    	mov	x4, #0x0                ; =0
104e86300: 94b68659    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86304: aa1803e0    	mov	x0, x24
104e86308: 94b6865a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e8630c: 9100e3e0    	add	x0, sp, #0x38
104e86310: 528000e1    	mov	w1, #0x7                ; =7
104e86314: 96c7e95d    	bl	0x100080888 <__text+0x78888>
104e86318: 528cac88    	mov	w8, #0x6564             ; =25956
104e8631c: 72ac2cc8    	movk	w8, #0x6166, lsl #16
104e86320: b9000008    	str	w8, [x0]
104e86324: 528eac28    	mov	w8, #0x7561             ; =30049
104e86328: 72ae8d88    	movk	w8, #0x746c, lsl #16
104e8632c: b8003008    	stur	w8, [x0, #0x3]
104e86330: 39001c1f    	strb	wzr, [x0, #0x7]
104e86334: 9100e3e1    	add	x1, sp, #0x38
104e86338: 52800020    	mov	w0, #0x1                ; =1
104e8633c: 94b617f5    	bl	0x107c0c310 <_Flutter_MMFoundation_BindContext+0x3e92fdc>
104e86340: 39c13fe8    	ldrsb	w8, [sp, #0x4f]
104e86344: 36f800a8    	tbz	w8, #0x1f, 0x104e86358 <_Flutter_MMFoundation_BindContext+0x110d024>
104e86348: f9401fe0    	ldr	x0, [sp, #0x38]
104e8634c: f94027e8    	ldr	x8, [sp, #0x48]
104e86350: 9240f901    	and	x1, x8, #0x7fffffffffffffff
104e86354: 94b684e7    	bl	0x107c276f0 <_Flutter_MMFoundation_BindContext+0x3eae3bc>
104e86358: 941deea5    	bl	0x105601dec <_Flutter_MMFoundation_BindContext+0x1888ab8>
104e8635c: 941def6a    	bl	0x105602104 <_Flutter_MMFoundation_BindContext+0x1888dd0>
104e86360: 34000280    	cbz	w0, 0x104e863b0 <_Flutter_MMFoundation_BindContext+0x110d07c>
104e86364: 9100e3e0    	add	x0, sp, #0x38
104e86368: 528000e1    	mov	w1, #0x7                ; =7
104e8636c: 96c7e947    	bl	0x100080888 <__text+0x78888>
104e86370: 528cac88    	mov	w8, #0x6564             ; =25956
104e86374: 72ac2cc8    	movk	w8, #0x6166, lsl #16
104e86378: b9000008    	str	w8, [x0]
104e8637c: 528eac28    	mov	w8, #0x7561             ; =30049
104e86380: 72ae8d88    	movk	w8, #0x746c, lsl #16
104e86384: b8003008    	stur	w8, [x0, #0x3]
104e86388: 39001c1f    	strb	wzr, [x0, #0x7]
104e8638c: 9100e3e1    	add	x1, sp, #0x38
104e86390: 52800020    	mov	w0, #0x1                ; =1
104e86394: 95a2f583    	bl	0x10b7439a0 <_mmkv_importFrom+0x880bfc>
104e86398: 39c13fe8    	ldrsb	w8, [sp, #0x4f]
104e8639c: 36f800a8    	tbz	w8, #0x1f, 0x104e863b0 <_Flutter_MMFoundation_BindContext+0x110d07c>
104e863a0: f9401fe0    	ldr	x0, [sp, #0x38]
104e863a4: f94027e8    	ldr	x8, [sp, #0x48]
104e863a8: 9240f901    	and	x1, x8, #0x7fffffffffffffff
104e863ac: 94b684d1    	bl	0x107c276f0 <_Flutter_MMFoundation_BindContext+0x3eae3bc>
104e863b0: 900d6f48    	adrp	x8, 0x11fc6e000 <dyld_stub_binder+0x11fc6e000>
104e863b4: 91282108    	add	x8, x8, #0xa08 ; 0x11fc6ea08 __common
104e863b8: 3900011f    	strb	wzr, [x8]
104e863bc: 900d6f48    	adrp	x8, 0x11fc6e000 <dyld_stub_binder+0x11fc6e000>
104e863c0: 91282508    	add	x8, x8, #0xa09 ; 0x11fc6ea09 __common
104e863c4: 3900011f    	strb	wzr, [x8]
104e863c8: f943c360    	ldr	x0, [x27, #0x780] ; class MMContext
104e863cc: aa1503e1    	mov	x1, x21
104e863d0: 94b68625    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e863d4: aa1d03fd    	mov	x29, x29
104e863d8: 94b6862a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e863dc: aa0003f8    	mov	x24, x0
104e863e0: d00cda28    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
104e863e4: f9453901    	ldr	x1, [x8, #0xa70] ; selector userName
104e863e8: 94b6861f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e863ec: aa1d03fd    	mov	x29, x29
104e863f0: 94b68624    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e863f4: aa0003f9    	mov	x25, x0
104e863f8: d00cf108    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
104e863fc: f9467501    	ldr	x1, [x8, #0xce8] ; selector length
104e86400: 94b68619    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86404: aa0003fa    	mov	x26, x0
104e86408: aa1903e0    	mov	x0, x25
104e8640c: 94b68619    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e86410: aa1803e0    	mov	x0, x24
104e86414: 94b68617    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e86418: b400061a    	cbz	x26, 0x104e864d8 <_Flutter_MMFoundation_BindContext+0x110d1a4>
104e8641c: f943c360    	ldr	x0, [x27, #0x780] ; class MMContext
104e86420: aa1503e1    	mov	x1, x21
104e86424: 94b68610    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86428: aa1d03fd    	mov	x29, x29
104e8642c: 94b68615    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e86430: aa0003f8    	mov	x24, x0
104e86434: b00cf47a    	adrp	x26, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
104e86438: f9461b40    	ldr	x0, [x26, #0xc30] ; class NewSyncService
104e8643c: aa1603e1    	mov	x1, x22
104e86440: 94b68609    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86444: aa0003e2    	mov	x2, x0
104e86448: aa1803e0    	mov	x0, x24
104e8644c: aa1703e1    	mov	x1, x23
104e86450: 94b68605    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86454: aa1d03fd    	mov	x29, x29
104e86458: 94b6860a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e8645c: aa0003f9    	mov	x25, x0
104e86460: 900ce508    	adrp	x8, 0x11eb26000 <dyld_stub_binder+0x11eb26000>
104e86464: f9405901    	ldr	x1, [x8, #0xb0] ; selector BackGroundToForeGroundSync
104e86468: 94b685ff    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e8646c: aa1903e0    	mov	x0, x25
104e86470: 94b68600    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e86474: aa1803e0    	mov	x0, x24
104e86478: 94b685fe    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e8647c: f943c360    	ldr	x0, [x27, #0x780] ; class MMContext
104e86480: aa1503e1    	mov	x1, x21
104e86484: 94b685f8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86488: aa1d03fd    	mov	x29, x29
104e8648c: 94b685fd    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e86490: aa0003f8    	mov	x24, x0
104e86494: f9461b40    	ldr	x0, [x26, #0xc30] ; class NewSyncService
104e86498: aa1603e1    	mov	x1, x22
104e8649c: 94b685f2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e864a0: aa0003e2    	mov	x2, x0
104e864a4: aa1803e0    	mov	x0, x24
104e864a8: aa1703e1    	mov	x1, x23
104e864ac: 94b685ee    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e864b0: aa1d03fd    	mov	x29, x29
104e864b4: 94b685f3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e864b8: aa0003f9    	mov	x25, x0
104e864bc: d00cdae8    	adrp	x8, 0x11e9e4000 <dyld_stub_binder+0x11e9e4000>
104e864c0: f9412901    	ldr	x1, [x8, #0x250] ; selector NeedToSyncOplog
104e864c4: 94b685e8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e864c8: aa1903e0    	mov	x0, x25
104e864cc: 94b685e9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e864d0: aa1803e0    	mov	x0, x24
104e864d4: 94b685e7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e864d8: f943c360    	ldr	x0, [x27, #0x780] ; class MMContext
104e864dc: aa1503e1    	mov	x1, x21
104e864e0: 94b685e1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e864e4: aa1d03fd    	mov	x29, x29
104e864e8: 94b685e6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e864ec: aa0003f8    	mov	x24, x0
104e864f0: 900cf568    	adrp	x8, 0x11ed32000 <dyld_stub_binder+0x11ed32000>
104e864f4: f945d900    	ldr	x0, [x8, #0xbb0] ; class VoIPFirstMessageStatisticsService
104e864f8: aa1603e1    	mov	x1, x22
104e864fc: 94b685da    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86500: aa0003e2    	mov	x2, x0
104e86504: aa1803e0    	mov	x0, x24
104e86508: aa1703e1    	mov	x1, x23
104e8650c: 94b685d6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86510: aa1d03fd    	mov	x29, x29
104e86514: 94b685db    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e86518: aa0003f9    	mov	x25, x0
104e8651c: 900ce508    	adrp	x8, 0x11eb26000 <dyld_stub_binder+0x11eb26000>
104e86520: f9405d01    	ldr	x1, [x8, #0xb8] ; selector didLaunchWhenApplicaionEnterForeground
104e86524: 94b685d0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86528: aa1903e0    	mov	x0, x25
104e8652c: 94b685d1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e86530: aa1803e0    	mov	x0, x24
104e86534: 94b685cf    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e86538: 900cf468    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104e8653c: f9442100    	ldr	x0, [x8, #0x840] ; class CAppUtil
104e86540: 900cda48    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
104e86544: f9410101    	ldr	x1, [x8, #0x200] ; selector isLogin
104e86548: 94b685c7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e8654c: 34000300    	cbz	w0, 0x104e865ac <_Flutter_MMFoundation_BindContext+0x110d278>
104e86550: f943c360    	ldr	x0, [x27, #0x780] ; class MMContext
104e86554: aa1503e1    	mov	x1, x21
104e86558: 94b685c3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e8655c: aa1d03fd    	mov	x29, x29
104e86560: 94b685c8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e86564: aa0003f5    	mov	x21, x0
104e86568: f9461b80    	ldr	x0, [x28, #0xc30] ; class CNetworkStatusMgr
104e8656c: aa1603e1    	mov	x1, x22
104e86570: 94b685bd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86574: aa0003e2    	mov	x2, x0
104e86578: aa1503e0    	mov	x0, x21
104e8657c: aa1703e1    	mov	x1, x23
104e86580: 94b685b9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e86584: aa1d03fd    	mov	x29, x29
104e86588: 94b685be    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104e8658c: aa0003f6    	mov	x22, x0
104e86590: 900ce508    	adrp	x8, 0x11eb26000 <dyld_stub_binder+0x11eb26000>
104e86594: f9406101    	ldr	x1, [x8, #0xc0] ; selector CheckBG2FG
104e86598: 94b685b3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e8659c: aa1603e0    	mov	x0, x22
104e865a0: 94b685b4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e865a4: aa1503e0    	mov	x0, x21
104e865a8: 94b685b2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e865ac: 900cfa08    	adrp	x8, 0x11edc6000 <dyld_stub_binder+0x11edc6000>
104e865b0: b9834508    	ldrsw	x8, [x8, #0x344]
104e865b4: 38686a68    	ldrb	w8, [x19, x8]
104e865b8: 37000188    	tbnz	w8, #0x0, 0x104e865e8 <_Flutter_MMFoundation_BindContext+0x110d2b4>
104e865bc: 900ce508    	adrp	x8, 0x11eb26000 <dyld_stub_binder+0x11eb26000>
104e865c0: f9406501    	ldr	x1, [x8, #0xc8] ; selector checkAppLockEnabled
104e865c4: aa1303e0    	mov	x0, x19
104e865c8: 94b685a7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e865cc: 340000e0    	cbz	w0, 0x104e865e8 <_Flutter_MMFoundation_BindContext+0x110d2b4>
104e865d0: 900ce508    	adrp	x8, 0x11eb26000 <dyld_stub_binder+0x11eb26000>
104e865d4: f9406901    	ldr	x1, [x8, #0xd0] ; selector reportAppLockEvent:
104e865d8: 900c2222    	adrp	x2, 0x11d2ca000 <dyld_stub_binder+0x11d2ca000>
104e865dc: 910d6042    	add	x2, x2, #0x358 ; cfstring 'app_lock_request_unlock'
104e865e0: aa1303e0    	mov	x0, x19
104e865e4: 94b685a0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104e865e8: 900cfa08    	adrp	x8, 0x11edc6000 <dyld_stub_binder+0x11edc6000>
104e865ec: b9834908    	ldrsw	x8, [x8, #0x348]
104e865f0: 38686a68    	ldrb	w8, [x19, x8]
104e865f4: 7100051f    	cmp	w8, #0x1
104e865f8: 540003a1    	b.ne	0x104e8666c <_Flutter_MMFoundation_BindContext+0x110d338>
104e865fc: 900cfa08    	adrp	x8, 0x11edc6000 <dyld_stub_binder+0x11edc6000>
104e86600: b9837108    	ldrsw	x8, [x8, #0x370]
104e86604: 38686a68    	ldrb	w8, [x19, x8]
104e86608: 37000328    	tbnz	w8, #0x0, 0x104e8666c <_Flutter_MMFoundation_BindContext+0x110d338>
104e8660c: 900cfa08    	adrp	x8, 0x11edc6000 <dyld_stub_binder+0x11edc6000>
104e86610: b9836108    	ldrsw	x8, [x8, #0x360]
104e86614: 38686a68    	ldrb	w8, [x19, x8]
104e86618: 370002a8    	tbnz	w8, #0x0, 0x104e8666c <_Flutter_MMFoundation_BindContext+0x110d338>
104e8661c: d2800000    	mov	x0, #0x0                ; =0
104e86620: 52928001    	mov	w1, #0x9400             ; =37888
104e86624: 72aee6a1    	movk	w1, #0x7735, lsl #16
104e86628: 94b684b5    	bl	0x107c278fc <_Flutter_MMFoundation_BindContext+0x3eae5c8>
104e8662c: d00c4628    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
104e86630: f9449908    	ldr	x8, [x8, #0x930] ; 0x11d74c930 __got
104e86634: f9000be8    	str	x8, [sp, #0x10]
104e86638: b0095208    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
104e8663c: fd434100    	ldr	d0, [x8, #0x680]
104e86640: 90000008    	adrp	x8, 0x104e86000 <_Flutter_MMFoundation_BindContext+0x110cccc>
104e86644: 911a5108    	add	x8, x8, #0x694 ; 0x104e86694 __text
104e86648: fd000fe0    	str	d0, [sp, #0x18]
104e8664c: d00b9fc9    	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
104e86650: 9111c129    	add	x9, x9, #0x470 ; 0x11c280470 __const
104e86654: a90227e8    	stp	x8, x9, [sp, #0x20]
104e86658: f9001bf3    	str	x19, [sp, #0x30]
104e8665c: d00c4621    	adrp	x1, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
104e86660: f9454c21    	ldr	x1, [x1, #0xa98] ; 0x11d74ca98 __got
104e86664: 910043e2    	add	x2, sp, #0x10
104e86668: 94b6194f    	bl	0x107c0cba4 <_Flutter_MMFoundation_BindContext+0x3e93870>
104e8666c: aa1403e0    	mov	x0, x20
104e86670: 94b68580    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104e86674: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
104e86678: a9494ff4    	ldp	x20, x19, [sp, #0x90]
104e8667c: a94857f6    	ldp	x22, x21, [sp, #0x80]
104e86680: a9475ff8    	ldp	x24, x23, [sp, #0x70]
104e86684: a94667fa    	ldp	x26, x25, [sp, #0x60]
104e86688: a9456ffc    	ldp	x28, x27, [sp, #0x50]
104e8668c: 9102c3ff    	add	sp, sp, #0xb0
104e86690: d65f03c0    	ret
