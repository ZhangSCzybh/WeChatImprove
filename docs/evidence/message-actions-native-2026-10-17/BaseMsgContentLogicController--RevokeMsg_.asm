
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002b930c: d10243ff    	sub	sp, sp, #0x90
1002b9310: a9036ffc    	stp	x28, x27, [sp, #0x30]
1002b9314: a90467fa    	stp	x26, x25, [sp, #0x40]
1002b9318: a9055ff8    	stp	x24, x23, [sp, #0x50]
1002b931c: a90657f6    	stp	x22, x21, [sp, #0x60]
1002b9320: a9074ff4    	stp	x20, x19, [sp, #0x70]
1002b9324: a9087bfd    	stp	x29, x30, [sp, #0x80]
1002b9328: 910203fd    	add	x29, sp, #0x80
1002b932c: aa0203f3    	mov	x19, x2
1002b9330: aa0003f5    	mov	x21, x0
1002b9334: 90104ba8    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002b9338: 52800029    	mov	w9, #0x1                ; =1
1002b933c: 39329d09    	strb	w9, [x8, #0xca7]
1002b9340: aa0203e0    	mov	x0, x2
1002b9344: 95e5b77d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002b9348: d00ff5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002b934c: f9453514    	ldr	x20, [x8, #0xa68] ; �gH 
1002b9350: f00fdc08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1002b9354: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
1002b9358: aa1303e0    	mov	x0, x19
1002b935c: 95e5b778    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9360: aa0003f7    	mov	x23, x0
1002b9364: d00fdc28    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002b9368: f940d916    	ldr	x22, [x8, #0x1b0] ; m_nsToUsr
1002b936c: aa1303e0    	mov	x0, x19
1002b9370: aa1603e1    	mov	x1, x22
1002b9374: 95e5b772    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9378: aa1d03fd    	mov	x29, x29
1002b937c: 95e5b773    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b9380: aa0003f8    	mov	x24, x0
1002b9384: 900fdc08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002b9388: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1002b938c: a90083f7    	stp	x23, x0, [sp, #0x8]
1002b9390: 900f1028    	adrp	x8, 0x11e4bd000 <dyld_stub_binder+0x11e4bd000>
1002b9394: 91132108    	add	x8, x8, #0x4c8
1002b9398: f90003e8    	str	x8, [sp]
1002b939c: 900d7b63    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
1002b93a0: 9107f063    	add	x3, x3, #0x1fc
1002b93a4: d00d7c65    	adrp	x5, 0x11b247000 <dyld_stub_binder+0x11b247000>
1002b93a8: 913eb4a5    	add	x5, x5, #0xfad
1002b93ac: f00d7c67    	adrp	x7, 0x11b248000 <dyld_stub_binder+0x11b248000>
1002b93b0: 9116a4e7    	add	x7, x7, #0x5a9
1002b93b4: aa1403e0    	mov	x0, x20
1002b93b8: 52800042    	mov	w2, #0x2                ; =2
1002b93bc: 52800004    	mov	w4, #0x0                ; =0
1002b93c0: 52807f86    	mov	w6, #0x3fc              ; =1020
1002b93c4: 95e5b75e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b93c8: aa1803e0    	mov	x0, x24
1002b93cc: 95e5b762    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b93d0: d00ff5dc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
1002b93d4: f945eb80    	ldr	x0, [x28, #0xbd0] ; ��d 
1002b93d8: f00ff228    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002b93dc: f944e919    	ldr	x25, [x8, #0x9d0] ; currentContext
1002b93e0: aa1903e1    	mov	x1, x25
1002b93e4: 95e5b756    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b93e8: aa1d03fd    	mov	x29, x29
1002b93ec: 95e5b757    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b93f0: aa0003fa    	mov	x26, x0
1002b93f4: b00ff5e8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1002b93f8: f940f500    	ldr	x0, [x8, #0x1e8] ; ا7 
1002b93fc: d00ff228    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002b9400: f947ad18    	ldr	x24, [x8, #0xf58] ; class
1002b9404: aa1803e1    	mov	x1, x24
1002b9408: 95e5b74d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b940c: aa0003e2    	mov	x2, x0
1002b9410: 900fdc08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002b9414: f9464117    	ldr	x23, [x8, #0xc80] ; getService:
1002b9418: aa1a03e0    	mov	x0, x26
1002b941c: aa1703e1    	mov	x1, x23
1002b9420: 95e5b747    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9424: aa1d03fd    	mov	x29, x29
1002b9428: 95e5b748    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b942c: aa0003fb    	mov	x27, x0
1002b9430: b00fdc88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b9434: f9451101    	ldr	x1, [x8, #0xa20] ; getRevokeBatchIdentifierFromMsgWrap:
1002b9438: aa1303e2    	mov	x2, x19
1002b943c: 95e5b740    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9440: aa1d03fd    	mov	x29, x29
1002b9444: 95e5b741    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b9448: aa0003f4    	mov	x20, x0
1002b944c: aa1b03e0    	mov	x0, x27
1002b9450: 95e5b741    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b9454: aa1a03e0    	mov	x0, x26
1002b9458: 95e5b73f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b945c: d00ff248    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1002b9460: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1002b9464: aa1403e0    	mov	x0, x20
1002b9468: 95e5b735    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b946c: b40000c0    	cbz	x0, 0x1002b9484 <__text+0x2b1484>
1002b9470: b00fdc88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b9474: f9471101    	ldr	x1, [x8, #0xe20] ; setRevokeBatchId:
1002b9478: aa1303e0    	mov	x0, x19
1002b947c: aa1403e2    	mov	x2, x20
1002b9480: 95e5b72f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9484: b00fdc88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b9488: f9471501    	ldr	x1, [x8, #0xe28] ; shouldProcessPayMsgPreRevoke:
1002b948c: aa1503e0    	mov	x0, x21
1002b9490: aa1303e2    	mov	x2, x19
1002b9494: 95e5b72a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9498: 37001900    	tbnz	w0, #0x0, 0x1002b97b8 <__text+0x2b17b8>
1002b949c: f90017f5    	str	x21, [sp, #0x28]
1002b94a0: f00ff5c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002b94a4: f9457100    	ldr	x0, [x8, #0xae0] ; 0�7 
1002b94a8: b00fdc88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b94ac: f9471901    	ldr	x1, [x8, #0xe30] ; onUserRevoke:dataId:
1002b94b0: d00f0f03    	adrp	x3, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1002b94b4: 91032063    	add	x3, x3, #0xc8
1002b94b8: aa1303e2    	mov	x2, x19
1002b94bc: 95e5b720    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b94c0: d00ff5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002b94c4: f9471100    	ldr	x0, [x8, #0xe20] ; H�b 
1002b94c8: 900fdc48    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
1002b94cc: f947a501    	ldr	x1, [x8, #0xf48] ; getMainSettingExt
1002b94d0: 95e5b71b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b94d4: aa1d03fd    	mov	x29, x29
1002b94d8: 95e5b71c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b94dc: aa0003fb    	mov	x27, x0
1002b94e0: b00fdc68    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
1002b94e4: f9428101    	ldr	x1, [x8, #0x500] ; getUInt32ForKey:
1002b94e8: 900f1022    	adrp	x2, 0x11e4bd000 <dyld_stub_binder+0x11e4bd000>
1002b94ec: 9113a042    	add	x2, x2, #0x4e8
1002b94f0: 95e5b713    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b94f4: b90027e0    	str	w0, [sp, #0x24]
1002b94f8: aa1b03e0    	mov	x0, x27
1002b94fc: 95e5b716    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b9500: f945eb80    	ldr	x0, [x28, #0xbd0] ; ��d 
1002b9504: aa1903e1    	mov	x1, x25
1002b9508: 95e5b70d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b950c: aa1d03fd    	mov	x29, x29
1002b9510: 95e5b70e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b9514: aa0003fb    	mov	x27, x0
1002b9518: f00ff5c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002b951c: f9459500    	ldr	x0, [x8, #0xb28] ; (^1 
1002b9520: aa1803e1    	mov	x1, x24
1002b9524: 95e5b706    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9528: aa0003e2    	mov	x2, x0
1002b952c: aa1b03e0    	mov	x0, x27
1002b9530: aa1703e1    	mov	x1, x23
1002b9534: 95e5b702    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9538: aa1d03fd    	mov	x29, x29
1002b953c: 95e5b703    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b9540: aa1c03f5    	mov	x21, x28
1002b9544: aa0003fc    	mov	x28, x0
1002b9548: d00fdc28    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002b954c: f944c101    	ldr	x1, [x8, #0x980] ; checkAppMsgShowRevokeMenu:
1002b9550: aa1303e2    	mov	x2, x19
1002b9554: 95e5b6fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9558: aa0003fa    	mov	x26, x0
1002b955c: aa1c03e0    	mov	x0, x28
1002b9560: 95e5b6fd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b9564: aa1b03e0    	mov	x0, x27
1002b9568: 95e5b6fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b956c: f00ff5dc    	adrp	x28, 0x120174000 <dyld_stub_binder+0x120174000>
1002b9570: 340004ba    	cbz	w26, 0x1002b9604 <__text+0x2b1604>
1002b9574: f945eaa0    	ldr	x0, [x21, #0xbd0]
1002b9578: aa1903e1    	mov	x1, x25
1002b957c: 95e5b6f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9580: aa1d03fd    	mov	x29, x29
1002b9584: 95e5b6f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b9588: aa0003fa    	mov	x26, x0
1002b958c: f9403380    	ldr	x0, [x28, #0x60] ; ��7 
1002b9590: aa1803e1    	mov	x1, x24
1002b9594: 95e5b6ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9598: aa0003e2    	mov	x2, x0
1002b959c: aa1a03e0    	mov	x0, x26
1002b95a0: aa1703e1    	mov	x1, x23
1002b95a4: 95e5b6e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b95a8: aa1d03fd    	mov	x29, x29
1002b95ac: 95e5b6e7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b95b0: aa0003fb    	mov	x27, x0
1002b95b4: 900fdc28    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1002b95b8: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
1002b95bc: aa1303e0    	mov	x0, x19
1002b95c0: 95e5b6df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b95c4: aa1d03fd    	mov	x29, x29
1002b95c8: 95e5b6e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b95cc: aa0003fc    	mov	x28, x0
1002b95d0: b00fdc88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b95d4: f9471d01    	ldr	x1, [x8, #0xe38] ; StopDownloadAppAttach:MsgWrap:
1002b95d8: aa1b03e0    	mov	x0, x27
1002b95dc: aa1c03e2    	mov	x2, x28
1002b95e0: aa1303e3    	mov	x3, x19
1002b95e4: 95e5b6d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b95e8: aa1c03e0    	mov	x0, x28
1002b95ec: f00ff5dc    	adrp	x28, 0x120174000 <dyld_stub_binder+0x120174000>
1002b95f0: 95e5b6d9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b95f4: aa1b03e0    	mov	x0, x27
1002b95f8: 95e5b6d7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b95fc: aa1a03e0    	mov	x0, x26
1002b9600: 95e5b6d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b9604: b00fdc88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b9608: f9430501    	ldr	x1, [x8, #0x608] ; IsGroupNoticeMsg
1002b960c: aa1303e0    	mov	x0, x19
1002b9610: 95e5b6cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9614: aa0003fa    	mov	x26, x0
1002b9618: f945eaa0    	ldr	x0, [x21, #0xbd0]
1002b961c: aa1903e1    	mov	x1, x25
1002b9620: 95e5b6c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9624: aa1d03fd    	mov	x29, x29
1002b9628: 95e5b6c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b962c: aa0003fb    	mov	x27, x0
1002b9630: 3400075a    	cbz	w26, 0x1002b9718 <__text+0x2b1718>
1002b9634: b00ff5e8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1002b9638: f9418500    	ldr	x0, [x8, #0x308]
1002b963c: aa1803e1    	mov	x1, x24
1002b9640: 95e5b6bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9644: aa0003e2    	mov	x2, x0
1002b9648: aa1b03e0    	mov	x0, x27
1002b964c: aa1703e1    	mov	x1, x23
1002b9650: 95e5b6bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9654: aa1d03fd    	mov	x29, x29
1002b9658: 95e5b6bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b965c: aa0003f6    	mov	x22, x0
1002b9660: b00fdc88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b9664: f9472101    	ldr	x1, [x8, #0xe40] ; revokeAnnouncementMsg:
1002b9668: aa1303e2    	mov	x2, x19
1002b966c: 95e5b6b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9670: aa1603e0    	mov	x0, x22
1002b9674: 95e5b6b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b9678: aa1b03e0    	mov	x0, x27
1002b967c: 95e5b6b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b9680: f00fdc28    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002b9684: f941e901    	ldr	x1, [x8, #0x3d0] ; getMsgContentViewController
1002b9688: f94017e0    	ldr	x0, [sp, #0x28]
1002b968c: 95e5b6ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9690: aa1d03fd    	mov	x29, x29
1002b9694: 95e5b6ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b9698: aa0003fb    	mov	x27, x0
1002b969c: f945eaa0    	ldr	x0, [x21, #0xbd0]
1002b96a0: aa1903e1    	mov	x1, x25
1002b96a4: 95e5b6a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b96a8: aa1d03fd    	mov	x29, x29
1002b96ac: 95e5b6a7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b96b0: aa0003f9    	mov	x25, x0
1002b96b4: d00ff5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002b96b8: f9462900    	ldr	x0, [x8, #0xc50]
1002b96bc: aa1803e1    	mov	x1, x24
1002b96c0: 95e5b69f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b96c4: aa0003e2    	mov	x2, x0
1002b96c8: aa1903e0    	mov	x0, x25
1002b96cc: aa1703e1    	mov	x1, x23
1002b96d0: 95e5b69b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b96d4: aa1d03fd    	mov	x29, x29
1002b96d8: 95e5b69c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b96dc: aa0003f6    	mov	x22, x0
1002b96e0: 900fdc08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002b96e4: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
1002b96e8: 900f1022    	adrp	x2, 0x11e4bd000 <dyld_stub_binder+0x11e4bd000>
1002b96ec: 91142042    	add	x2, x2, #0x508
1002b96f0: 95e5b693    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b96f4: aa1d03fd    	mov	x29, x29
1002b96f8: 95e5b694    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b96fc: aa0003f5    	mov	x21, x0
1002b9700: b00fdc88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b9704: f9472501    	ldr	x1, [x8, #0xe48] ; showLoadingViewWithText:
1002b9708: aa1b03e0    	mov	x0, x27
1002b970c: aa1503e2    	mov	x2, x21
1002b9710: 95e5b68b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9714: 14000021    	b	0x1002b9798 <__text+0x2b1798>
1002b9718: f9403380    	ldr	x0, [x28, #0x60] ; ��7 
1002b971c: aa1803e1    	mov	x1, x24
1002b9720: 95e5b687    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9724: aa0003e2    	mov	x2, x0
1002b9728: aa1b03e0    	mov	x0, x27
1002b972c: aa1703e1    	mov	x1, x23
1002b9730: 95e5b683    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9734: aa1d03fd    	mov	x29, x29
1002b9738: 95e5b684    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b973c: aa0003f9    	mov	x25, x0
1002b9740: aa1303e0    	mov	x0, x19
1002b9744: aa1603e1    	mov	x1, x22
1002b9748: 95e5b67d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b974c: aa1d03fd    	mov	x29, x29
1002b9750: 95e5b67e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b9754: aa0003f6    	mov	x22, x0
1002b9758: f00fdc28    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002b975c: f941e901    	ldr	x1, [x8, #0x3d0] ; getMsgContentViewController
1002b9760: f94017e0    	ldr	x0, [sp, #0x28]
1002b9764: 95e5b676    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9768: aa1d03fd    	mov	x29, x29
1002b976c: 95e5b677    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b9770: aa0003f5    	mov	x21, x0
1002b9774: b00fdc88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b9778: f9472901    	ldr	x1, [x8, #0xe50] ; RevokeMsg:MsgWrap:Counter:revokeTicket:viewController:
1002b977c: aa1903e0    	mov	x0, x25
1002b9780: aa1603e2    	mov	x2, x22
1002b9784: aa1303e3    	mov	x3, x19
1002b9788: b94027e4    	ldr	w4, [sp, #0x24]
1002b978c: d2800005    	mov	x5, #0x0                ; =0
1002b9790: aa1503e6    	mov	x6, x21
1002b9794: 95e5b66a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9798: aa1503e0    	mov	x0, x21
1002b979c: 95e5b66e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b97a0: aa1603e0    	mov	x0, x22
1002b97a4: 95e5b66c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b97a8: aa1903e0    	mov	x0, x25
1002b97ac: 95e5b66a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b97b0: aa1b03e0    	mov	x0, x27
1002b97b4: 95e5b668    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b97b8: aa1403e0    	mov	x0, x20
1002b97bc: 95e5b666    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b97c0: aa1303e0    	mov	x0, x19
1002b97c4: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1002b97c8: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1002b97cc: a94657f6    	ldp	x22, x21, [sp, #0x60]
1002b97d0: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1002b97d4: a94467fa    	ldp	x26, x25, [sp, #0x40]
1002b97d8: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1002b97dc: 910243ff    	add	sp, sp, #0x90
1002b97e0: 15e5b65d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>