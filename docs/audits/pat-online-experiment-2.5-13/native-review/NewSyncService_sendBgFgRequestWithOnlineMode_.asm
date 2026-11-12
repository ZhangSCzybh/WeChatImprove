
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105461764: d10203ff    	sub	sp, sp, #0x80
105461768: a9026ffc    	stp	x28, x27, [sp, #0x20]
10546176c: a90367fa    	stp	x26, x25, [sp, #0x30]
105461770: a9045ff8    	stp	x24, x23, [sp, #0x40]
105461774: a90557f6    	stp	x22, x21, [sp, #0x50]
105461778: a9064ff4    	stp	x20, x19, [sp, #0x60]
10546177c: a9077bfd    	stp	x29, x30, [sp, #0x70]
105461780: 9101c3fd    	add	x29, sp, #0x70
105461784: aa0203f5    	mov	x21, x2
105461788: aa0003f3    	mov	x19, x0
10546178c: d00d1788    	adrp	x8, 0x11f753000 <dyld_stub_binder+0x11f753000>
105461790: 52800029    	mov	w9, #0x1                ; =1
105461794: 3911e109    	strb	w9, [x8, #0x478]
105461798: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10546179c: f9442100    	ldr	x0, [x8, #0x840] ; class CAppUtil
1054617a0: b00cab68    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1054617a4: f9410101    	ldr	x1, [x8, #0x200] ; selector isLogin
1054617a8: 949f192f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054617ac: 34001280    	cbz	w0, 0x1054619fc <_Flutter_MMFoundation_BindContext+0x16e86c8>
1054617b0: b00cc59b    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1054617b4: f943c360    	ldr	x0, [x27, #0x780] ; class MMContext
1054617b8: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1054617bc: f9440117    	ldr	x23, [x8, #0x800] ; selector currentContext
1054617c0: aa1703e1    	mov	x1, x23
1054617c4: 949f1928    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054617c8: aa1d03fd    	mov	x29, x29
1054617cc: 949f192d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1054617d0: aa0003f4    	mov	x20, x0
1054617d4: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1054617d8: f9444900    	ldr	x0, [x8, #0x890] ; class ExptService
1054617dc: b00cc228    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1054617e0: f9428518    	ldr	x24, [x8, #0x508] ; selector class
1054617e4: aa1803e1    	mov	x1, x24
1054617e8: 949f191f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054617ec: aa0003e2    	mov	x2, x0
1054617f0: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1054617f4: f9452119    	ldr	x25, [x8, #0xa40] ; selector getService:
1054617f8: aa1403e0    	mov	x0, x20
1054617fc: aa1903e1    	mov	x1, x25
105461800: 949f1919    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461804: aa1d03fd    	mov	x29, x29
105461808: 949f191e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10546180c: aa0003fa    	mov	x26, x0
105461810: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105461814: f9472501    	ldr	x1, [x8, #0xe48] ; selector getExpt:withBoolDef:
105461818: b00bf4a2    	adrp	x2, 0x11d2f6000 <dyld_stub_binder+0x11d2f6000>
10546181c: 9130e042    	add	x2, x2, #0xc38 ; cfstring 'clicfg_bgfg_task_timeout_switch'
105461820: 52800003    	mov	w3, #0x0                ; =0
105461824: 949f1910    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461828: aa0003f6    	mov	x22, x0
10546182c: aa1a03e0    	mov	x0, x26
105461830: 949f1910    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461834: aa1403e0    	mov	x0, x20
105461838: 949f190e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10546183c: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461840: f9430d00    	ldr	x0, [x8, #0x618] ; class iConsole
105461844: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105461848: f9418901    	ldr	x1, [x8, #0x310] ; selector logWithLevel:module:errorCode:file:line:func:format:
10546184c: a900dbf5    	stp	x21, x22, [sp, #0x8]
105461850: b00bf4a8    	adrp	x8, 0x11d2f6000 <dyld_stub_binder+0x11d2f6000>
105461854: 91316108    	add	x8, x8, #0xc58 ; cfstring 'BgFgRequest onlineMode=%d, waitResponse=%d'
105461858: f90003e8    	str	x8, [sp]
10546185c: 900a44a3    	adrp	x3, 0x119cf5000 <dyld_stub_binder+0x119cf5000>
105461860: 913ebc63    	add	x3, x3, #0xfaf ; 'Sync'
105461864: d00a6de5    	adrp	x5, 0x11a21f000 <dyld_stub_binder+0x11a21f000>
105461868: 912b44a5    	add	x5, x5, #0xad1 ; 'NewSyncService.mm'
10546186c: d00a6de7    	adrp	x7, 0x11a21f000 <dyld_stub_binder+0x11a21f000>
105461870: 912e68e7    	add	x7, x7, #0xb9a ; '-[NewSyncService sendBgFgRequestWithOnlineMode:]'
105461874: 52800042    	mov	w2, #0x2                ; =2
105461878: 52800004    	mov	w4, #0x0                ; =0
10546187c: 52801706    	mov	w6, #0xb8               ; =184
105461880: 949f18f9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461884: f00cc688    	adrp	x8, 0x11ed34000 <dyld_stub_binder+0x11ed34000>
105461888: f9416900    	ldr	x0, [x8, #0x2d0] ; class BgFgRequest
10546188c: 949f18e0    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
105461890: aa0003f4    	mov	x20, x0
105461894: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461898: f9445100    	ldr	x0, [x8, #0x8a0] ; class CUtility
10546189c: 900cc228    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
1054618a0: f9428901    	ldr	x1, [x8, #0x510] ; selector GetVersion
1054618a4: 949f18f0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054618a8: aa0003e2    	mov	x2, x0
1054618ac: d00cc248    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1054618b0: f941b901    	ldr	x1, [x8, #0x370] ; selector setClientVersion:
1054618b4: aa1403e0    	mov	x0, x20
1054618b8: 949f18eb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054618bc: b00cc5c8    	adrp	x8, 0x11ed1a000 <dyld_stub_binder+0x11ed1a000>
1054618c0: f941f500    	ldr	x0, [x8, #0x3e8] ; class DeviceUtility
1054618c4: 900cb588    	adrp	x8, 0x11eb11000 <dyld_stub_binder+0x11eb11000>
1054618c8: f940fd01    	ldr	x1, [x8, #0x1f8] ; selector HeadDeviceType
1054618cc: 949f18e6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054618d0: aa0003e2    	mov	x2, x0
1054618d4: d00cab88    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1054618d8: f9407d01    	ldr	x1, [x8, #0xf8] ; selector setDeviceTypeId:
1054618dc: aa1403e0    	mov	x0, x20
1054618e0: 949f18e1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054618e4: f943c360    	ldr	x0, [x27, #0x780] ; class MMContext
1054618e8: aa1703e1    	mov	x1, x23
1054618ec: 949f18de    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054618f0: aa1d03fd    	mov	x29, x29
1054618f4: 949f18e3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1054618f8: aa0003f7    	mov	x23, x0
1054618fc: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105461900: f947fd00    	ldr	x0, [x8, #0xff8] ; class CNetworkStatus
105461904: aa1803e1    	mov	x1, x24
105461908: 949f18d7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10546190c: aa0003e2    	mov	x2, x0
105461910: aa1703e0    	mov	x0, x23
105461914: aa1903e1    	mov	x1, x25
105461918: 949f18d3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10546191c: aa1d03fd    	mov	x29, x29
105461920: 949f18d8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105461924: aa0003f8    	mov	x24, x0
105461928: d00cab88    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10546192c: f9415501    	ldr	x1, [x8, #0x2a8] ; selector getNewNetType
105461930: 949f18cd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461934: aa0003e2    	mov	x2, x0
105461938: f00cc248    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
10546193c: f9411d01    	ldr	x1, [x8, #0x238] ; selector setNetworkMode:
105461940: aa1403e0    	mov	x0, x20
105461944: 949f18c8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461948: aa1803e0    	mov	x0, x24
10546194c: 949f18c9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461950: aa1703e0    	mov	x0, x23
105461954: 949f18c7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461958: b00cb6c8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
10546195c: f945c901    	ldr	x1, [x8, #0xb90] ; selector setOnlineMode:
105461960: aa1403e0    	mov	x0, x20
105461964: aa1503e2    	mov	x2, x21
105461968: 949f18bf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10546196c: b00cc248    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
105461970: f9462d01    	ldr	x1, [x8, #0xc58] ; selector serializedData
105461974: aa1403e0    	mov	x0, x20
105461978: 949f18bb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10546197c: aa1d03fd    	mov	x29, x29
105461980: 949f18c0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105461984: aa0003f5    	mov	x21, x0
105461988: 360004b6    	tbz	w22, #0x0, 0x105461a1c <_Flutter_MMFoundation_BindContext+0x16e86e8>
10546198c: b00cc5e8    	adrp	x8, 0x11ed1e000 <dyld_stub_binder+0x11ed1e000>
105461990: f9401500    	ldr	x0, [x8, #0x28] ; class NetCmdLongLinkEvent
105461994: 949f189e    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
105461998: aa0003f6    	mov	x22, x0
10546199c: b00cb6a8    	adrp	x8, 0x11eb36000 <dyld_stub_binder+0x11eb36000>
1054619a0: f9407501    	ldr	x1, [x8, #0xe8] ; selector setTaskRetryCount:
1054619a4: 52800002    	mov	w2, #0x0                ; =0
1054619a8: 949f18af    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054619ac: b00cb6a8    	adrp	x8, 0x11eb36000 <dyld_stub_binder+0x11eb36000>
1054619b0: f9407901    	ldr	x1, [x8, #0xf0] ; selector setTaskTotalTimeoutMS:
1054619b4: aa1603e0    	mov	x0, x22
1054619b8: 5284e202    	mov	w2, #0x2710             ; =10000
1054619bc: 949f18aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054619c0: b00cb6c8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
1054619c4: f945d501    	ldr	x1, [x8, #0xba8] ; selector setResponseDecoder:
1054619c8: 900b74e2    	adrp	x2, 0x11c2fd000 <dyld_stub_binder+0x11c2fd000>
1054619cc: 9139a042    	add	x2, x2, #0xe68 ; 0x11c2fde68 __const
1054619d0: aa1603e0    	mov	x0, x22
1054619d4: 949f18a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054619d8: b00cb6c8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
1054619dc: f945dd01    	ldr	x1, [x8, #0xbb8] ; selector setResponseHandler:
1054619e0: 900b74e2    	adrp	x2, 0x11c2fd000 <dyld_stub_binder+0x11c2fd000>
1054619e4: 913aa042    	add	x2, x2, #0xea8 ; 0x11c2fdea8 __const
1054619e8: aa1603e0    	mov	x0, x22
1054619ec: 949f189e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054619f0: b00cb6d8    	adrp	x24, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
1054619f4: 912f0318    	add	x24, x24, #0xbc0 ; selector addBgFgLongLinkEvent:
1054619f8: 1400000f    	b	0x105461a34 <_Flutter_MMFoundation_BindContext+0x16e8700>
1054619fc: a9477bfd    	ldp	x29, x30, [sp, #0x70]
105461a00: a9464ff4    	ldp	x20, x19, [sp, #0x60]
105461a04: a94557f6    	ldp	x22, x21, [sp, #0x50]
105461a08: a9445ff8    	ldp	x24, x23, [sp, #0x40]
105461a0c: a94367fa    	ldp	x26, x25, [sp, #0x30]
105461a10: a9426ffc    	ldp	x28, x27, [sp, #0x20]
105461a14: 910203ff    	add	sp, sp, #0x80
105461a18: d65f03c0    	ret
105461a1c: b00cc5e8    	adrp	x8, 0x11ed1e000 <dyld_stub_binder+0x11ed1e000>
105461a20: f9401100    	ldr	x0, [x8, #0x20] ; class NetCmdSendOnlyEvent
105461a24: 949f187a    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
105461a28: aa0003f6    	mov	x22, x0
105461a2c: b00cb6d8    	adrp	x24, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
105461a30: 912e8318    	add	x24, x24, #0xba0 ; selector addBgFgSendOnlyEvent:
105461a34: 52800300    	mov	w0, #0x18               ; =24
105461a38: 949f1730    	bl	0x107c276f8 <_Flutter_MMFoundation_BindContext+0x3eae3c4>
105461a3c: aa0003f7    	mov	x23, x0
105461a40: aa1503e1    	mov	x1, x21
105461a44: 52802702    	mov	w2, #0x138              ; =312
105461a48: 97fb035a    	bl	0x1053227b0 <_Flutter_MMFoundation_BindContext+0x15a947c>
105461a4c: b00cb6c8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
105461a50: f945cd01    	ldr	x1, [x8, #0xb98] ; selector setM_netcmd:
105461a54: aa1603e0    	mov	x0, x22
105461a58: aa1703e2    	mov	x2, x23
105461a5c: 949f1882    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461a60: f9400302    	ldr	x2, [x24]
105461a64: 900cc248    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105461a68: f946f901    	ldr	x1, [x8, #0xdf0] ; selector performSelectorOnMainThread:withObject:waitUntilDone:
105461a6c: aa1303e0    	mov	x0, x19
105461a70: aa1603e3    	mov	x3, x22
105461a74: 52800004    	mov	w4, #0x0                ; =0
105461a78: 949f187b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461a7c: aa1603e0    	mov	x0, x22
105461a80: 949f187c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461a84: aa1503e0    	mov	x0, x21
105461a88: 949f187a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461a8c: aa1403e0    	mov	x0, x20
105461a90: a9477bfd    	ldp	x29, x30, [sp, #0x70]
105461a94: a9464ff4    	ldp	x20, x19, [sp, #0x60]
105461a98: a94557f6    	ldp	x22, x21, [sp, #0x50]
105461a9c: a9445ff8    	ldp	x24, x23, [sp, #0x40]
105461aa0: a94367fa    	ldp	x26, x25, [sp, #0x30]
105461aa4: a9426ffc    	ldp	x28, x27, [sp, #0x20]
105461aa8: 910203ff    	add	sp, sp, #0x80
105461aac: 149f1871    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
