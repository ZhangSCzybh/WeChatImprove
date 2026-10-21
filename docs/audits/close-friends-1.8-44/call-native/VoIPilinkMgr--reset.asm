
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10624f0f8: d100c3ff    	sub	sp, sp, #0x30
10624f0fc: a9014ff4    	stp	x20, x19, [sp, #0x10]
10624f100: a9027bfd    	stp	x29, x30, [sp, #0x20]
10624f104: 910083fd    	add	x29, sp, #0x20
10624f108: aa0003f3    	mov	x19, x0
10624f10c: 900d4fa8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10624f110: 52800029    	mov	w9, #0x1                ; =1
10624f114: 39256909    	strb	w9, [x8, #0x95a]
10624f118: 900cf928    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10624f11c: f9453514    	ldr	x20, [x8, #0xa68]
10624f120: f00ce528    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
10624f124: f9402901    	ldr	x1, [x8, #0x50] ; mRoomId
10624f128: 94676005    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f12c: d00cdf48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10624f130: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10624f134: b00c3148    	adrp	x8, 0x11e878000 <dyld_stub_binder+0x11e878000>
10624f138: 9123a108    	add	x8, x8, #0x8e8
10624f13c: a90003e8    	stp	x8, x0, [sp]
10624f140: d00a9183    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
10624f144: 91056463    	add	x3, x3, #0x159
10624f148: f00aba65    	adrp	x5, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
10624f14c: 911120a5    	add	x5, x5, #0x448
10624f150: f00aba67    	adrp	x7, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
10624f154: 911c6ce7    	add	x7, x7, #0x71b
10624f158: aa1403e0    	mov	x0, x20
10624f15c: 52800042    	mov	w2, #0x2                ; =2
10624f160: 52800004    	mov	w4, #0x0                ; =0
10624f164: 52804266    	mov	w6, #0x213              ; =531
10624f168: 94675ff5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f16c: b00cea88    	adrp	x8, 0x11ffa0000 <dyld_stub_binder+0x11ffa0000>
10624f170: f946f501    	ldr	x1, [x8, #0xde8] ; StopSession
10624f174: aa1303e0    	mov	x0, x19
10624f178: 94675ff1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f17c: f00cdf48    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10624f180: f947c101    	ldr	x1, [x8, #0xf80] ; setIsThisTalkIlink:
10624f184: aa1303e0    	mov	x0, x19
10624f188: 52800002    	mov	w2, #0x0                ; =0
10624f18c: 94675fec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f190: f00cebc8    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
10624f194: f945bd01    	ldr	x1, [x8, #0xb78] ; setIsConnected:
10624f198: aa1303e0    	mov	x0, x19
10624f19c: 52800002    	mov	w2, #0x0                ; =0
10624f1a0: 94675fe7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f1a4: f00ce328    	adrp	x8, 0x11feb6000 <dyld_stub_binder+0x11feb6000>
10624f1a8: f946e101    	ldr	x1, [x8, #0xdc0] ; setIsActived:
10624f1ac: aa1303e0    	mov	x0, x19
10624f1b0: 52800002    	mov	w2, #0x0                ; =0
10624f1b4: 94675fe2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f1b8: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f1bc: f942d501    	ldr	x1, [x8, #0x5a8] ; setChangeToMultiTalk:
10624f1c0: aa1303e0    	mov	x0, x19
10624f1c4: 52800002    	mov	w2, #0x0                ; =0
10624f1c8: 94675fdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f1cc: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f1d0: f9430d01    	ldr	x1, [x8, #0x618] ; setJoinToRoom:
10624f1d4: aa1303e0    	mov	x0, x19
10624f1d8: 52800002    	mov	w2, #0x0                ; =0
10624f1dc: 94675fd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f1e0: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f1e4: f9431101    	ldr	x1, [x8, #0x620] ; lowVersionMembers
10624f1e8: aa1303e0    	mov	x0, x19
10624f1ec: 94675fd4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f1f0: aa1d03fd    	mov	x29, x29
10624f1f4: 94675fd5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10624f1f8: aa0003f4    	mov	x20, x0
10624f1fc: f00cf5a8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10624f200: f9408101    	ldr	x1, [x8, #0x100] ; removeAllObjects
10624f204: 94675fce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f208: aa1403e0    	mov	x0, x20
10624f20c: 94675fd2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10624f210: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f214: f942cd01    	ldr	x1, [x8, #0x598] ; setIsCameraSetOn:
10624f218: aa1303e0    	mov	x0, x19
10624f21c: 52800002    	mov	w2, #0x0                ; =0
10624f220: 94675fc7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f224: d00cec08    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
10624f228: f9460501    	ldr	x1, [x8, #0xc08] ; setRemoteContact:
10624f22c: aa1303e0    	mov	x0, x19
10624f230: d2800002    	mov	x2, #0x0                ; =0
10624f234: 94675fc2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f238: b00cea88    	adrp	x8, 0x11ffa0000 <dyld_stub_binder+0x11ffa0000>
10624f23c: f947dd01    	ldr	x1, [x8, #0xfb8] ; setMCntTryStartAudioDev:
10624f240: aa1303e0    	mov	x0, x19
10624f244: 52800002    	mov	w2, #0x0                ; =0
10624f248: 94675fbd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f24c: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f250: f942b101    	ldr	x1, [x8, #0x560] ; setMRoomId:
10624f254: aa1303e0    	mov	x0, x19
10624f258: d2800002    	mov	x2, #0x0                ; =0
10624f25c: 94675fb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f260: 900cebe8    	adrp	x8, 0x11ffcb000 <dyld_stub_binder+0x11ffcb000>
10624f264: f940e501    	ldr	x1, [x8, #0x1c8] ; setCallID:
10624f268: aa1303e0    	mov	x0, x19
10624f26c: d2800002    	mov	x2, #0x0                ; =0
10624f270: 94675fb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f274: 900cebe8    	adrp	x8, 0x11ffcb000 <dyld_stub_binder+0x11ffcb000>
10624f278: f9451d01    	ldr	x1, [x8, #0xa38] ; remoteImageContext
10624f27c: aa1303e0    	mov	x0, x19
10624f280: 94675faf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f284: aa1d03fd    	mov	x29, x29
10624f288: 94675fb0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10624f28c: aa0003f4    	mov	x20, x0
10624f290: 900cdf68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10624f294: f940e101    	ldr	x1, [x8, #0x1c0] ; clear
10624f298: 94675fa9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f29c: aa1403e0    	mov	x0, x20
10624f2a0: 94675fad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10624f2a4: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f2a8: f942fd01    	ldr	x1, [x8, #0x5f8] ; setIsAlreadyHangup:
10624f2ac: aa1303e0    	mov	x0, x19
10624f2b0: 52800002    	mov	w2, #0x0                ; =0
10624f2b4: 94675fa2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f2b8: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f2bc: f9430501    	ldr	x1, [x8, #0x608] ; setIsRenderFirstFrameLocal:
10624f2c0: aa1303e0    	mov	x0, x19
10624f2c4: 52800002    	mov	w2, #0x0                ; =0
10624f2c8: 94675f9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f2cc: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f2d0: f9430901    	ldr	x1, [x8, #0x610] ; setIsRenderFirstFrameRemote:
10624f2d4: aa1303e0    	mov	x0, x19
10624f2d8: 52800002    	mov	w2, #0x0                ; =0
10624f2dc: 94675f98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f2e0: 900cebe8    	adrp	x8, 0x11ffcb000 <dyld_stub_binder+0x11ffcb000>
10624f2e4: f9401101    	ldr	x1, [x8, #0x20] ; setMIsInterruptByPhoneCall:
10624f2e8: aa1303e0    	mov	x0, x19
10624f2ec: 52800002    	mov	w2, #0x0                ; =0
10624f2f0: 94675f93    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f2f4: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f2f8: f942dd01    	ldr	x1, [x8, #0x5b8] ; setIsInviteInitEngineFail:
10624f2fc: aa1303e0    	mov	x0, x19
10624f300: 52800002    	mov	w2, #0x0                ; =0
10624f304: 94675f8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f308: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f30c: f942e101    	ldr	x1, [x8, #0x5c0] ; setIsInviteDeviceWaiting:
10624f310: aa1303e0    	mov	x0, x19
10624f314: 52800002    	mov	w2, #0x0                ; =0
10624f318: 94675f89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f31c: f00ce528    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
10624f320: f942c101    	ldr	x1, [x8, #0x580] ; setStartedAudioDeviceEarlier:
10624f324: aa1303e0    	mov	x0, x19
10624f328: 52800002    	mov	w2, #0x0                ; =0
10624f32c: 94675f84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f330: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f334: f942e501    	ldr	x1, [x8, #0x5c8] ; setStartWithExternalDevice:
10624f338: aa1303e0    	mov	x0, x19
10624f33c: 52800002    	mov	w2, #0x0                ; =0
10624f340: 94675f7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f344: d00cebe8    	adrp	x8, 0x11ffcd000 <dyld_stub_binder+0x11ffcd000>
10624f348: f9472101    	ldr	x1, [x8, #0xe40] ; setIsCallKit:
10624f34c: aa1303e0    	mov	x0, x19
10624f350: 52800002    	mov	w2, #0x0                ; =0
10624f354: 94675f7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f358: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f35c: f942a101    	ldr	x1, [x8, #0x540] ; setAcceptNewCall:
10624f360: aa1303e0    	mov	x0, x19
10624f364: 52800002    	mov	w2, #0x0                ; =0
10624f368: 94675f75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f36c: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f370: f9431501    	ldr	x1, [x8, #0x628] ; setStartedSecondPart:
10624f374: aa1303e0    	mov	x0, x19
10624f378: 52800002    	mov	w2, #0x0                ; =0
10624f37c: 94675f70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f380: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f384: f9431901    	ldr	x1, [x8, #0x630] ; setHangupByCall:
10624f388: aa1303e0    	mov	x0, x19
10624f38c: 52800002    	mov	w2, #0x0                ; =0
10624f390: 94675f6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f394: d00cec08    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
10624f398: f9462901    	ldr	x1, [x8, #0xc50] ; setIsLocalRendered:
10624f39c: aa1303e0    	mov	x0, x19
10624f3a0: 52800002    	mov	w2, #0x0                ; =0
10624f3a4: 94675f66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f3a8: d00cec08    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
10624f3ac: f9463101    	ldr	x1, [x8, #0xc60] ; setIsRemoteRendered:
10624f3b0: aa1303e0    	mov	x0, x19
10624f3b4: 52800002    	mov	w2, #0x0                ; =0
10624f3b8: 94675f61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f3bc: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f3c0: f9431d01    	ldr	x1, [x8, #0x638] ; setIsJoinedRoom:
10624f3c4: aa1303e0    	mov	x0, x19
10624f3c8: 52800002    	mov	w2, #0x0                ; =0
10624f3cc: 94675f5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f3d0: 900cebe8    	adrp	x8, 0x11ffcb000 <dyld_stub_binder+0x11ffcb000>
10624f3d4: f945f101    	ldr	x1, [x8, #0xbe0] ; setLastLocalCaptureFrameIndex:
10624f3d8: aa1303e0    	mov	x0, x19
10624f3dc: d2800002    	mov	x2, #0x0                ; =0
10624f3e0: 94675f57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f3e4: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f3e8: f9432101    	ldr	x1, [x8, #0x640] ; setLocalCaptureUnactiveCount:
10624f3ec: aa1303e0    	mov	x0, x19
10624f3f0: d2800002    	mov	x2, #0x0                ; =0
10624f3f4: 94675f52    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f3f8: f00cebc8    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
10624f3fc: f947b501    	ldr	x1, [x8, #0xf68] ; setMStartTalkingTime:
10624f400: aa1303e0    	mov	x0, x19
10624f404: d2800002    	mov	x2, #0x0                ; =0
10624f408: 94675f4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f40c: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f410: f9432501    	ldr	x1, [x8, #0x648] ; setMStartAcceptTime:
10624f414: aa1303e0    	mov	x0, x19
10624f418: d2800002    	mov	x2, #0x0                ; =0
10624f41c: 94675f48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10624f420: 900cec28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10624f424: f9432901    	ldr	x1, [x8, #0x650] ; setIsRemoteLandscapeMode:
10624f428: aa1303e0    	mov	x0, x19
10624f42c: 52800002    	mov	w2, #0x0                ; =0
10624f430: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10624f434: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10624f438: 9100c3ff    	add	sp, sp, #0x30
10624f43c: 14675f40    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
