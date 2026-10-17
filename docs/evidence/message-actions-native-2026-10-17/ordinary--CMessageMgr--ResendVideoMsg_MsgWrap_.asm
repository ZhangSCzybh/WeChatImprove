
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b35264: d10383ff    	sub	sp, sp, #0xe0
104b35268: a9086ffc    	stp	x28, x27, [sp, #0x80]
104b3526c: a90967fa    	stp	x26, x25, [sp, #0x90]
104b35270: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
104b35274: a90b57f6    	stp	x22, x21, [sp, #0xb0]
104b35278: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
104b3527c: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
104b35280: 910343fd    	add	x29, sp, #0xd0
104b35284: aa0303f4    	mov	x20, x3
104b35288: aa0203f3    	mov	x19, x2
104b3528c: f9001fe0    	str	x0, [sp, #0x38]
104b35290: b00e0848    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b35294: 52800029    	mov	w9, #0x1                ; =1
104b35298: 39158509    	strb	w9, [x8, #0x561]
104b3529c: aa0203e0    	mov	x0, x2
104b352a0: 94c3c7a6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b352a4: aa1403e0    	mov	x0, x20
104b352a8: 94c3c7a4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b352ac: d00db1fb    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
104b352b0: f9467b75    	ldr	x21, [x27, #0xcf0]
104b352b4: f00d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b352b8: f947d119    	ldr	x25, [x8, #0xfa0] ; m_uiMesLocalID
104b352bc: aa1903e1    	mov	x1, x25
104b352c0: 94c3c79f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b352c4: aa0003f6    	mov	x22, x0
104b352c8: f9467b60    	ldr	x0, [x27, #0xcf0]
104b352cc: d00d9868    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b352d0: f943a517    	ldr	x23, [x8, #0x748] ; GetDocPath
104b352d4: aa1703e1    	mov	x1, x23
104b352d8: 94c3c799    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b352dc: aa1d03fd    	mov	x29, x29
104b352e0: 94c3c79a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b352e4: aa0003f8    	mov	x24, x0
104b352e8: f00d98c8    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
104b352ec: f944b101    	ldr	x1, [x8, #0x960] ; GetPathOfMesVideo:LocalID:DocPath:
104b352f0: aa1503e0    	mov	x0, x21
104b352f4: aa1303e2    	mov	x2, x19
104b352f8: aa1603e3    	mov	x3, x22
104b352fc: aa1803e4    	mov	x4, x24
104b35300: 94c3c78f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35304: aa1d03fd    	mov	x29, x29
104b35308: 94c3c790    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3530c: aa0003fa    	mov	x26, x0
104b35310: aa1803e0    	mov	x0, x24
104b35314: 94c3c790    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35318: f00db1e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3531c: f9411d00    	ldr	x0, [x8, #0x238]
104b35320: f00d9a48    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
104b35324: f9456501    	ldr	x1, [x8, #0xac8] ; GetPathOfRawVideoWithMessageWrap:
104b35328: aa1403e2    	mov	x2, x20
104b3532c: 94c3c784    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35330: aa1d03fd    	mov	x29, x29
104b35334: 94c3c785    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35338: aa0003f8    	mov	x24, x0
104b3533c: f9467b75    	ldr	x21, [x27, #0xcf0]
104b35340: aa1403e0    	mov	x0, x20
104b35344: f90013f9    	str	x25, [sp, #0x20]
104b35348: aa1903e1    	mov	x1, x25
104b3534c: 94c3c77c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35350: aa0003f6    	mov	x22, x0
104b35354: f9467b60    	ldr	x0, [x27, #0xcf0]
104b35358: aa1703e1    	mov	x1, x23
104b3535c: 94c3c778    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35360: aa1d03fd    	mov	x29, x29
104b35364: 94c3c779    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35368: aa0003f7    	mov	x23, x0
104b3536c: b00d9a28    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
104b35370: f9451901    	ldr	x1, [x8, #0xa30] ; GetPathOfMesVideoThumb:LocalID:DocPath:
104b35374: aa1503e0    	mov	x0, x21
104b35378: f90023f3    	str	x19, [sp, #0x40]
104b3537c: aa1303e2    	mov	x2, x19
104b35380: aa1603e3    	mov	x3, x22
104b35384: aa1703e4    	mov	x4, x23
104b35388: 94c3c76d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3538c: aa1d03fd    	mov	x29, x29
104b35390: 94c3c76e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35394: aa0003f6    	mov	x22, x0
104b35398: aa1703e0    	mov	x0, x23
104b3539c: 94c3c76e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b353a0: aa1603e0    	mov	x0, x22
104b353a4: 94c3c765    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b353a8: b00db208    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104b353ac: f9429100    	ldr	x0, [x8, #0x520]
104b353b0: 94c3c76a    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104b353b4: aa0003f9    	mov	x25, x0
104b353b8: d00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b353bc: f9463500    	ldr	x0, [x8, #0xc68]
104b353c0: d00d9828    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104b353c4: f9467101    	ldr	x1, [x8, #0xce0] ; GetFileSize:
104b353c8: aa1a03e2    	mov	x2, x26
104b353cc: 94c3c75c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b353d0: aa0003f5    	mov	x21, x0
104b353d4: 937ffc13    	asr	x19, x0, #63
104b353d8: b00d9be8    	adrp	x8, 0x11feb2000 <dyld_stub_binder+0x11feb2000>
104b353dc: f9476901    	ldr	x1, [x8, #0xed0] ; setThumb_path:
104b353e0: aa1903e0    	mov	x0, x25
104b353e4: f90017f6    	str	x22, [sp, #0x28]
104b353e8: aa1603e2    	mov	x2, x22
104b353ec: 94c3c754    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b353f0: b00d9be8    	adrp	x8, 0x11feb2000 <dyld_stub_binder+0x11feb2000>
104b353f4: f9477101    	ldr	x1, [x8, #0xee0] ; setVideo_path:
104b353f8: aa1903e0    	mov	x0, x25
104b353fc: f90027fa    	str	x26, [sp, #0x48]
104b35400: aa1a03e2    	mov	x2, x26
104b35404: 94c3c74e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35408: b00d9be8    	adrp	x8, 0x11feb2000 <dyld_stub_binder+0x11feb2000>
104b3540c: f9477501    	ldr	x1, [x8, #0xee8] ; setVideo_size:
104b35410: 0a3302a2    	bic	w2, w21, w19
104b35414: aa1903e0    	mov	x0, x25
104b35418: 94c3c749    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3541c: f00d9848    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b35420: f940d901    	ldr	x1, [x8, #0x1b0] ; m_uiMsgThumbWidth
104b35424: aa1403e0    	mov	x0, x20
104b35428: 94c3c745    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3542c: aa0003e2    	mov	x2, x0
104b35430: 900d9e28    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
104b35434: f943ed01    	ldr	x1, [x8, #0x7d8] ; setThumb_width:
104b35438: aa1903e0    	mov	x0, x25
104b3543c: 94c3c740    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35440: f00d9848    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b35444: f940dd01    	ldr	x1, [x8, #0x1b8] ; m_uiMsgThumbHeight
104b35448: aa1403e0    	mov	x0, x20
104b3544c: 94c3c73c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35450: aa0003e2    	mov	x2, x0
104b35454: 900d9e28    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
104b35458: f943f101    	ldr	x1, [x8, #0x7e0] ; setThumb_height:
104b3545c: aa1903e0    	mov	x0, x25
104b35460: 94c3c737    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35464: 900d9868    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
104b35468: f9460d01    	ldr	x1, [x8, #0xc18] ; m_nsStreamVideoUrl
104b3546c: aa1403e0    	mov	x0, x20
104b35470: 94c3c733    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35474: aa1d03fd    	mov	x29, x29
104b35478: 94c3c734    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3547c: aa0003f5    	mov	x21, x0
104b35480: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b35484: f945c101    	ldr	x1, [x8, #0xb80] ; setM_nsStreamVideoUrl:
104b35488: aa1903e0    	mov	x0, x25
104b3548c: aa1503e2    	mov	x2, x21
104b35490: 94c3c72b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35494: aa1503e0    	mov	x0, x21
104b35498: 94c3c72f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3549c: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b354a0: f945dd01    	ldr	x1, [x8, #0xbb8] ; m_uiStreamVideoTime
104b354a4: aa1403e0    	mov	x0, x20
104b354a8: 94c3c725    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b354ac: aa0003e2    	mov	x2, x0
104b354b0: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b354b4: f945e101    	ldr	x1, [x8, #0xbc0] ; setM_uiStreamVideoTime:
104b354b8: aa1903e0    	mov	x0, x25
104b354bc: 94c3c720    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b354c0: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b354c4: f945c501    	ldr	x1, [x8, #0xb88] ; m_nsStreamVideoTitle
104b354c8: aa1403e0    	mov	x0, x20
104b354cc: 94c3c71c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b354d0: aa1d03fd    	mov	x29, x29
104b354d4: 94c3c71d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b354d8: aa0003f5    	mov	x21, x0
104b354dc: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b354e0: f945c901    	ldr	x1, [x8, #0xb90] ; setM_nsStreamVideoTitle:
104b354e4: aa1903e0    	mov	x0, x25
104b354e8: aa1503e2    	mov	x2, x21
104b354ec: 94c3c714    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b354f0: aa1503e0    	mov	x0, x21
104b354f4: 94c3c718    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b354f8: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b354fc: f945cd01    	ldr	x1, [x8, #0xb98] ; m_nsStreamVideoWording
104b35500: aa1403e0    	mov	x0, x20
104b35504: 94c3c70e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35508: aa1d03fd    	mov	x29, x29
104b3550c: 94c3c70f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35510: aa0003f5    	mov	x21, x0
104b35514: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b35518: f945d101    	ldr	x1, [x8, #0xba0] ; setM_nsStreamVideoWording:
104b3551c: aa1903e0    	mov	x0, x25
104b35520: aa1503e2    	mov	x2, x21
104b35524: 94c3c706    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35528: aa1503e0    	mov	x0, x21
104b3552c: 94c3c70a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35530: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b35534: f945d501    	ldr	x1, [x8, #0xba8] ; m_nsStreamVideoWebUrl
104b35538: aa1403e0    	mov	x0, x20
104b3553c: 94c3c700    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35540: aa1d03fd    	mov	x29, x29
104b35544: 94c3c701    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35548: aa0003f5    	mov	x21, x0
104b3554c: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b35550: f945d901    	ldr	x1, [x8, #0xbb0] ; setM_nsStreamVideoWebUrl:
104b35554: aa1903e0    	mov	x0, x25
104b35558: aa1503e2    	mov	x2, x21
104b3555c: 94c3c6f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35560: aa1503e0    	mov	x0, x21
104b35564: 94c3c6fc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35568: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b3556c: f945e501    	ldr	x1, [x8, #0xbc8] ; m_nsStreamVideoThumbUrl
104b35570: aa1403e0    	mov	x0, x20
104b35574: 94c3c6f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35578: aa1d03fd    	mov	x29, x29
104b3557c: 94c3c6f3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35580: aa0003f5    	mov	x21, x0
104b35584: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b35588: f945e901    	ldr	x1, [x8, #0xbd0] ; setM_nsStreamVideoThumbUrl:
104b3558c: aa1903e0    	mov	x0, x25
104b35590: aa1503e2    	mov	x2, x21
104b35594: 94c3c6ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35598: aa1503e0    	mov	x0, x21
104b3559c: 94c3c6ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b355a0: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b355a4: f945ed01    	ldr	x1, [x8, #0xbd8] ; m_nsStreamVideoPublishId
104b355a8: aa1403e0    	mov	x0, x20
104b355ac: 94c3c6e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b355b0: aa1d03fd    	mov	x29, x29
104b355b4: 94c3c6e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b355b8: aa0003f5    	mov	x21, x0
104b355bc: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b355c0: f945f101    	ldr	x1, [x8, #0xbe0] ; setM_nsStreamVideoPublishId:
104b355c4: aa1903e0    	mov	x0, x25
104b355c8: aa1503e2    	mov	x2, x21
104b355cc: 94c3c6dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b355d0: aa1503e0    	mov	x0, x21
104b355d4: 94c3c6e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b355d8: 900d9868    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
104b355dc: f945b901    	ldr	x1, [x8, #0xb70] ; m_nsStreamVideoAdUxInfo
104b355e0: aa1403e0    	mov	x0, x20
104b355e4: 94c3c6d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b355e8: aa1d03fd    	mov	x29, x29
104b355ec: 94c3c6d7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b355f0: aa0003f5    	mov	x21, x0
104b355f4: 900d98c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
104b355f8: f945f501    	ldr	x1, [x8, #0xbe8] ; setM_nsStreamVideoAdUxInfo:
104b355fc: aa1903e0    	mov	x0, x25
104b35600: aa1503e2    	mov	x2, x21
104b35604: 94c3c6ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35608: aa1503e0    	mov	x0, x21
104b3560c: 94c3c6d2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35610: b00d9a28    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
104b35614: f9448501    	ldr	x1, [x8, #0x908] ; m_forwardType
104b35618: aa1403e0    	mov	x0, x20
104b3561c: 94c3c6c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35620: aa0003e2    	mov	x2, x0
104b35624: d00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b35628: f941bd01    	ldr	x1, [x8, #0x378] ; setM_forwardType:
104b3562c: aa1903e0    	mov	x0, x25
104b35630: 94c3c6c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35634: d00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b35638: f9433901    	ldr	x1, [x8, #0x670] ; m_nsSpecifiedChatName
104b3563c: aa1403e0    	mov	x0, x20
104b35640: 94c3c6bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35644: aa1d03fd    	mov	x29, x29
104b35648: 94c3c6c0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3564c: aa0003f5    	mov	x21, x0
104b35650: d00d9868    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b35654: f945c101    	ldr	x1, [x8, #0xb80] ; setM_nsSpecifiedChatName:
104b35658: aa1903e0    	mov	x0, x25
104b3565c: aa1503e2    	mov	x2, x21
104b35660: 94c3c6b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35664: aa1503e0    	mov	x0, x21
104b35668: 94c3c6bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3566c: 900d9928    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
104b35670: f9442d01    	ldr	x1, [x8, #0x858] ; m_uiIsSenderStatus
104b35674: aa1403e0    	mov	x0, x20
104b35678: 94c3c6b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3567c: aa0003e2    	mov	x2, x0
104b35680: 900d9968    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
104b35684: f9437501    	ldr	x1, [x8, #0x6e8] ; setM_uiIsSenderStatus:
104b35688: aa1903e0    	mov	x0, x25
104b3568c: 94c3c6ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35690: f00d98c8    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
104b35694: f9426501    	ldr	x1, [x8, #0x4c8] ; isRawVideo
104b35698: aa1403e0    	mov	x0, x20
104b3569c: 94c3c6a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b356a0: aa0003e2    	mov	x2, x0
104b356a4: 900d9c48    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b356a8: f943a101    	ldr	x1, [x8, #0x740] ; setBRawVideo:
104b356ac: aa1903e0    	mov	x0, x25
104b356b0: 94c3c6a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b356b4: 900d9c08    	adrp	x8, 0x11feb5000 <dyld_stub_binder+0x11feb5000>
104b356b8: f940e501    	ldr	x1, [x8, #0x1c8] ; setNsRawVidePath:
104b356bc: aa1903e0    	mov	x0, x25
104b356c0: f9001bf8    	str	x24, [sp, #0x30]
104b356c4: aa1803e2    	mov	x2, x24
104b356c8: 94c3c69d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b356cc: b00d9968    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
104b356d0: f9404901    	ldr	x1, [x8, #0x90] ; m_nsRawAeskey
104b356d4: aa1403e0    	mov	x0, x20
104b356d8: 94c3c699    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b356dc: aa1d03fd    	mov	x29, x29
104b356e0: 94c3c69a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b356e4: aa0003f5    	mov	x21, x0
104b356e8: 900d9c08    	adrp	x8, 0x11feb5000 <dyld_stub_binder+0x11feb5000>
104b356ec: f940dd01    	ldr	x1, [x8, #0x1b8] ; setNsRawAesKey:
104b356f0: aa1903e0    	mov	x0, x25
104b356f4: aa1503e2    	mov	x2, x21
104b356f8: 94c3c691    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b356fc: aa1503e0    	mov	x0, x21
104b35700: 94c3c695    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35704: b00d9968    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
104b35708: f9404101    	ldr	x1, [x8, #0x80] ; m_nsRawDataUrl
104b3570c: aa1403e0    	mov	x0, x20
104b35710: 94c3c68b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35714: aa1d03fd    	mov	x29, x29
104b35718: 94c3c68c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3571c: aa0003f5    	mov	x21, x0
104b35720: 900d9c08    	adrp	x8, 0x11feb5000 <dyld_stub_binder+0x11feb5000>
104b35724: f940d901    	ldr	x1, [x8, #0x1b0] ; setNsRawDataUrl:
104b35728: aa1903e0    	mov	x0, x25
104b3572c: aa1503e2    	mov	x2, x21
104b35730: 94c3c683    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35734: aa1503e0    	mov	x0, x21
104b35738: 94c3c687    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3573c: b00d9968    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
104b35740: f9404d01    	ldr	x1, [x8, #0x98] ; m_nsRawFileMd5
104b35744: aa1403e0    	mov	x0, x20
104b35748: 94c3c67d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3574c: aa1d03fd    	mov	x29, x29
104b35750: 94c3c67e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35754: aa0003f5    	mov	x21, x0
104b35758: 900d9c08    	adrp	x8, 0x11feb5000 <dyld_stub_binder+0x11feb5000>
104b3575c: f940e101    	ldr	x1, [x8, #0x1c0] ; setNsRawFileMd5:
104b35760: aa1903e0    	mov	x0, x25
104b35764: aa1503e2    	mov	x2, x21
104b35768: 94c3c675    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3576c: aa1503e0    	mov	x0, x21
104b35770: 94c3c679    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35774: b00d98c8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
104b35778: f9468101    	ldr	x1, [x8, #0xd00] ; m_uiRawFileLength
104b3577c: aa1403e0    	mov	x0, x20
104b35780: 94c3c66f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35784: aa0003e2    	mov	x2, x0
104b35788: 900d9c08    	adrp	x8, 0x11feb5000 <dyld_stub_binder+0x11feb5000>
104b3578c: f940e901    	ldr	x1, [x8, #0x1d0] ; setRawFileLength:
104b35790: aa1903e0    	mov	x0, x25
104b35794: 94c3c66a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35798: 900d9c48    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b3579c: f9424101    	ldr	x1, [x8, #0x480] ; m_nsOriginSourceDataMd5
104b357a0: aa1403e0    	mov	x0, x20
104b357a4: 94c3c666    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b357a8: aa1d03fd    	mov	x29, x29
104b357ac: 94c3c667    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b357b0: aa0003f5    	mov	x21, x0
104b357b4: 900d9c48    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b357b8: f943a501    	ldr	x1, [x8, #0x748] ; setNsOriginSourceDataMd5:
104b357bc: aa1903e0    	mov	x0, x25
104b357c0: aa1503e2    	mov	x2, x21
104b357c4: 94c3c65e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b357c8: aa1503e0    	mov	x0, x21
104b357cc: 94c3c662    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b357d0: d00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b357d4: f945e900    	ldr	x0, [x8, #0xbd0]
104b357d8: f00dae48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b357dc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104b357e0: 94c3c657    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b357e4: aa1d03fd    	mov	x29, x29
104b357e8: 94c3c658    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b357ec: aa0003f5    	mov	x21, x0
104b357f0: d00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b357f4: f9468900    	ldr	x0, [x8, #0xd10]
104b357f8: d00dae48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b357fc: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104b35800: 94c3c64f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35804: aa0003e2    	mov	x2, x0
104b35808: 900d9828    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3580c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104b35810: aa1503e0    	mov	x0, x21
104b35814: 94c3c64a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35818: aa1d03fd    	mov	x29, x29
104b3581c: 94c3c64b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35820: aa0003f6    	mov	x22, x0
104b35824: f00d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b35828: f9456901    	ldr	x1, [x8, #0xad0] ; valueFromDynamicConfigForKey:
104b3582c: f00ce362    	adrp	x2, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b35830: 911e2042    	add	x2, x2, #0x788
104b35834: 94c3c642    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35838: aa1d03fd    	mov	x29, x29
104b3583c: 94c3c643    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35840: aa0003fb    	mov	x27, x0
104b35844: aa1603e0    	mov	x0, x22
104b35848: 94c3c643    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3584c: aa1503e0    	mov	x0, x21
104b35850: 94c3c641    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35854: d00dae68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104b35858: f9424901    	ldr	x1, [x8, #0x490] ; intValue
104b3585c: aa1b03e0    	mov	x0, x27
104b35860: 94c3c637    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35864: aa0003f6    	mov	x22, x0
104b35868: d00db1f3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
104b3586c: f9453660    	ldr	x0, [x19, #0xa68]
104b35870: 900d9828    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b35874: f942a915    	ldr	x21, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b35878: f00ce368    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b3587c: 911ea108    	add	x8, x8, #0x7a8
104b35880: a9005be8    	stp	x8, x22, [sp]
104b35884: f00b6625    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b35888: 910cb4a5    	add	x5, x5, #0x32d
104b3588c: 900b6647    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b35890: 912720e7    	add	x7, x7, #0x9c8
104b35894: aa1503e1    	mov	x1, x21
104b35898: 52800042    	mov	w2, #0x2                ; =2
104b3589c: d2800003    	mov	x3, #0x0                ; =0
104b358a0: 52800004    	mov	w4, #0x0                ; =0
104b358a4: 52814e06    	mov	w6, #0xa70              ; =2672
104b358a8: 94c3c625    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b358ac: b00d9a28    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
104b358b0: f944d517    	ldr	x23, [x8, #0x9a8] ; m_uiContinueUploadCount
104b358b4: aa1403e0    	mov	x0, x20
104b358b8: aa1703e1    	mov	x1, x23
104b358bc: 94c3c620    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b358c0: 6b16001f    	cmp	w0, w22
104b358c4: 54000be2    	b.hs	0x104b35a40 <_Flutter_MMFoundation_BindContext+0x1011624>
104b358c8: b00d9a28    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
104b358cc: f944d11c    	ldr	x28, [x8, #0x9a0] ; m_nsAttachFileKey
104b358d0: aa1403e0    	mov	x0, x20
104b358d4: aa1c03e1    	mov	x1, x28
104b358d8: 94c3c619    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b358dc: aa1d03fd    	mov	x29, x29
104b358e0: 94c3c61a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b358e4: aa0003f6    	mov	x22, x0
104b358e8: f00d9be8    	adrp	x8, 0x11feb4000 <dyld_stub_binder+0x11feb4000>
104b358ec: f9474d01    	ldr	x1, [x8, #0xe98] ; setM_nsAttachFileKey:
104b358f0: aa1903e0    	mov	x0, x25
104b358f4: aa1603e2    	mov	x2, x22
104b358f8: 94c3c611    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b358fc: aa1603e0    	mov	x0, x22
104b35900: 94c3c615    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35904: f00d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b35908: f945a91a    	ldr	x26, [x8, #0xb50] ; m_nsAesKey
104b3590c: aa1403e0    	mov	x0, x20
104b35910: aa1a03e1    	mov	x1, x26
104b35914: 94c3c60a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35918: aa1d03fd    	mov	x29, x29
104b3591c: 94c3c60b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35920: aa0003f6    	mov	x22, x0
104b35924: 900d9988    	adrp	x8, 0x11fe65000 <dyld_stub_binder+0x11fe65000>
104b35928: f9410901    	ldr	x1, [x8, #0x210] ; setM_nsAesKey:
104b3592c: aa1903e0    	mov	x0, x25
104b35930: aa1603e2    	mov	x2, x22
104b35934: 94c3c602    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35938: aa1603e0    	mov	x0, x22
104b3593c: 94c3c606    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35940: b00d9868    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104b35944: f9447101    	ldr	x1, [x8, #0x8e0] ; m_uiPercent
104b35948: aa1403e0    	mov	x0, x20
104b3594c: 94c3c5fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35950: aa0003e2    	mov	x2, x0
104b35954: f00d9848    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b35958: f9436901    	ldr	x1, [x8, #0x6d0] ; setM_uiPercent:
104b3595c: aa1903e0    	mov	x0, x25
104b35960: 94c3c5f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35964: aa1403e0    	mov	x0, x20
104b35968: aa1703e1    	mov	x1, x23
104b3596c: 94c3c5f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35970: aa0003f6    	mov	x22, x0
104b35974: b00d9cc8    	adrp	x8, 0x11fece000 <dyld_stub_binder+0x11fece000>
104b35978: f941b118    	ldr	x24, [x8, #0x360] ; setM_uiContinueUploadCount:
104b3597c: 11000402    	add	w2, w0, #0x1
104b35980: aa1403e0    	mov	x0, x20
104b35984: aa1803e1    	mov	x1, x24
104b35988: 94c3c5ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3598c: 110006c2    	add	w2, w22, #0x1
104b35990: aa1903e0    	mov	x0, x25
104b35994: aa1803e1    	mov	x1, x24
104b35998: 94c3c5e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3599c: f9453676    	ldr	x22, [x19, #0xa68]
104b359a0: aa1403e0    	mov	x0, x20
104b359a4: aa1c03e1    	mov	x1, x28
104b359a8: 94c3c5e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b359ac: aa1d03fd    	mov	x29, x29
104b359b0: 94c3c5e6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b359b4: aa0003f8    	mov	x24, x0
104b359b8: aa1403e0    	mov	x0, x20
104b359bc: aa1a03e1    	mov	x1, x26
104b359c0: 94c3c5df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b359c4: aa1d03fd    	mov	x29, x29
104b359c8: 94c3c5e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b359cc: aa0003fa    	mov	x26, x0
104b359d0: aa1403e0    	mov	x0, x20
104b359d4: aa1703e1    	mov	x1, x23
104b359d8: 94c3c5d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b359dc: a90103fa    	stp	x26, x0, [sp, #0x10]
104b359e0: f00ce368    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b359e4: 911f2108    	add	x8, x8, #0x7c8
104b359e8: a90063e8    	stp	x8, x24, [sp]
104b359ec: f00b6625    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b359f0: 910cb4a5    	add	x5, x5, #0x32d
104b359f4: 900b6647    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b359f8: 912720e7    	add	x7, x7, #0x9c8
104b359fc: aa1603e0    	mov	x0, x22
104b35a00: aa1503e1    	mov	x1, x21
104b35a04: 52800042    	mov	w2, #0x2                ; =2
104b35a08: d2800003    	mov	x3, #0x0                ; =0
104b35a0c: 52800004    	mov	w4, #0x0                ; =0
104b35a10: 52814f46    	mov	w6, #0xa7a              ; =2682
104b35a14: 94c3c5ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35a18: aa1a03e0    	mov	x0, x26
104b35a1c: 94c3c5ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35a20: aa1803e0    	mov	x0, x24
104b35a24: 94c3c5cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35a28: 52806a60    	mov	w0, #0x353              ; =851
104b35a2c: 52800101    	mov	w1, #0x8                ; =8
104b35a30: 52800022    	mov	w2, #0x1                ; =1
104b35a34: 52800003    	mov	w3, #0x0                ; =0
104b35a38: 52800004    	mov	w4, #0x0                ; =0
104b35a3c: 975069d0    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
104b35a40: 900d9a88    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
104b35a44: f9448517    	ldr	x23, [x8, #0x908] ; m_nsAssetId
104b35a48: aa1403e0    	mov	x0, x20
104b35a4c: aa1703e1    	mov	x1, x23
104b35a50: 94c3c5bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35a54: aa1d03fd    	mov	x29, x29
104b35a58: 94c3c5bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35a5c: aa0003f6    	mov	x22, x0
104b35a60: d00dae68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104b35a64: f946e915    	ldr	x21, [x8, #0xdd0] ; length
104b35a68: aa1503e1    	mov	x1, x21
104b35a6c: 94c3c5b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35a70: aa0003f8    	mov	x24, x0
104b35a74: aa1603e0    	mov	x0, x22
104b35a78: 94c3c5b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35a7c: b40001d8    	cbz	x24, 0x104b35ab4 <_Flutter_MMFoundation_BindContext+0x1011698>
104b35a80: aa1403e0    	mov	x0, x20
104b35a84: aa1703e1    	mov	x1, x23
104b35a88: 94c3c5ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35a8c: aa1d03fd    	mov	x29, x29
104b35a90: 94c3c5ae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35a94: aa0003f6    	mov	x22, x0
104b35a98: 900d9cc8    	adrp	x8, 0x11fecd000 <dyld_stub_binder+0x11fecd000>
104b35a9c: f9434d01    	ldr	x1, [x8, #0x698] ; setVideo_assetId:
104b35aa0: aa1903e0    	mov	x0, x25
104b35aa4: aa1603e2    	mov	x2, x22
104b35aa8: 94c3c5a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35aac: aa1603e0    	mov	x0, x22
104b35ab0: 94c3c5a9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35ab4: b00db208    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104b35ab8: f9469916    	ldr	x22, [x8, #0xd30]
104b35abc: f00db1e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b35ac0: f9427100    	ldr	x0, [x8, #0x4e0]
104b35ac4: 900dae68    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104b35ac8: f944d101    	ldr	x1, [x8, #0x9a0] ; fileURLWithPath:
104b35acc: f94027e2    	ldr	x2, [sp, #0x48]
104b35ad0: 94c3c59b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35ad4: aa1d03fd    	mov	x29, x29
104b35ad8: 94c3c59c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35adc: aa0003f7    	mov	x23, x0
104b35ae0: b00dae48    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104b35ae4: f944b101    	ldr	x1, [x8, #0x960] ; URLAssetWithURL:options:
104b35ae8: aa1603e0    	mov	x0, x22
104b35aec: aa1703e2    	mov	x2, x23
104b35af0: d2800003    	mov	x3, #0x0                ; =0
104b35af4: 94c3c592    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35af8: aa1d03fd    	mov	x29, x29
104b35afc: 94c3c593    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35b00: aa0003fc    	mov	x28, x0
104b35b04: aa1703e0    	mov	x0, x23
104b35b08: 94c3c593    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35b0c: f9401ff3    	ldr	x19, [sp, #0x38]
104b35b10: b40000fc    	cbz	x28, 0x104b35b2c <_Flutter_MMFoundation_BindContext+0x1011710>
104b35b14: 900dae68    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104b35b18: f9426101    	ldr	x1, [x8, #0x4c0] ; duration
104b35b1c: 9101a3e8    	add	x8, sp, #0x68
104b35b20: aa1c03e0    	mov	x0, x28
104b35b24: 94c3c586    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35b28: 14000003    	b	0x104b35b34 <_Flutter_MMFoundation_BindContext+0x1011718>
104b35b2c: a906ffff    	stp	xzr, xzr, [sp, #0x68]
104b35b30: f9003fff    	str	xzr, [sp, #0x78]
104b35b34: 3cc683e0    	ldur	q0, [sp, #0x68]
104b35b38: 3d8017e0    	str	q0, [sp, #0x50]
104b35b3c: f9403fe8    	ldr	x8, [sp, #0x78]
104b35b40: f90033e8    	str	x8, [sp, #0x60]
104b35b44: 910143e0    	add	x0, sp, #0x50
104b35b48: 94c3c711    	bl	0x107c2778c <_Flutter_MMFoundation_BindContext+0x4103370>
104b35b4c: 1e624000    	fcvt	s0, d0
104b35b50: 1e250002    	fcvtau	w2, s0
104b35b54: d00d9ac8    	adrp	x8, 0x11fe8f000 <dyld_stub_binder+0x11fe8f000>
104b35b58: f9451501    	ldr	x1, [x8, #0xa28] ; setVideo_time:
104b35b5c: aa1903e0    	mov	x0, x25
104b35b60: 94c3c577    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35b64: b00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b35b68: f944c501    	ldr	x1, [x8, #0x988] ; m_nsEncodeJson
104b35b6c: aa1403e0    	mov	x0, x20
104b35b70: 94c3c573    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35b74: aa1d03fd    	mov	x29, x29
104b35b78: 94c3c574    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35b7c: aa0003f6    	mov	x22, x0
104b35b80: b00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b35b84: f944c901    	ldr	x1, [x8, #0x990] ; setM_nsEncodeJson:
104b35b88: aa1903e0    	mov	x0, x25
104b35b8c: aa1603e2    	mov	x2, x22
104b35b90: 94c3c56b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35b94: aa1603e0    	mov	x0, x22
104b35b98: 94c3c56f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35b9c: 900d9a88    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
104b35ba0: f943f101    	ldr	x1, [x8, #0x7e0] ; m_uiVideoSource
104b35ba4: aa1403e0    	mov	x0, x20
104b35ba8: 94c3c565    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35bac: d00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b35bb0: f947f901    	ldr	x1, [x8, #0xff0] ; setM_uiVideoSource:
104b35bb4: 7100101f    	cmp	w0, #0x4
104b35bb8: 52800068    	mov	w8, #0x3                ; =3
104b35bbc: 1a881502    	cinc	w2, w8, eq
104b35bc0: aa1903e0    	mov	x0, x25
104b35bc4: 94c3c55e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35bc8: 900d9848    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104b35bcc: f9429d01    	ldr	x1, [x8, #0x538] ; m_nsFromUsr
104b35bd0: aa1403e0    	mov	x0, x20
104b35bd4: 94c3c55a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35bd8: aa1d03fd    	mov	x29, x29
104b35bdc: 94c3c55b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35be0: aa0003f6    	mov	x22, x0
104b35be4: d00d9848    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b35be8: f940d91a    	ldr	x26, [x8, #0x1b0] ; m_nsToUsr
104b35bec: aa1403e0    	mov	x0, x20
104b35bf0: aa1a03e1    	mov	x1, x26
104b35bf4: 94c3c552    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35bf8: aa1d03fd    	mov	x29, x29
104b35bfc: 94c3c553    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35c00: aa0003f8    	mov	x24, x0
104b35c04: b00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b35c08: f944b901    	ldr	x1, [x8, #0x970] ; AddVideoMsg:ToUsr:VideoInfo:MsgType:
104b35c0c: aa1303e0    	mov	x0, x19
104b35c10: aa1603e2    	mov	x2, x22
104b35c14: aa1803e3    	mov	x3, x24
104b35c18: aa1903e4    	mov	x4, x25
104b35c1c: 52800565    	mov	w5, #0x2b               ; =43
104b35c20: 94c3c547    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35c24: aa1d03fd    	mov	x29, x29
104b35c28: 94c3c548    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35c2c: aa0003f7    	mov	x23, x0
104b35c30: aa1803e0    	mov	x0, x24
104b35c34: 94c3c548    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35c38: aa1603e0    	mov	x0, x22
104b35c3c: 94c3c546    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35c40: f00d9848    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b35c44: f9432516    	ldr	x22, [x8, #0x648] ; m_firstSendMsgId
104b35c48: aa1403e0    	mov	x0, x20
104b35c4c: aa1603e1    	mov	x1, x22
104b35c50: 94c3c53b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35c54: aa1d03fd    	mov	x29, x29
104b35c58: 94c3c53c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35c5c: aa0003f8    	mov	x24, x0
104b35c60: aa1503e1    	mov	x1, x21
104b35c64: 94c3c536    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35c68: aa0003f5    	mov	x21, x0
104b35c6c: aa1803e0    	mov	x0, x24
104b35c70: 94c3c539    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35c74: b40001b5    	cbz	x21, 0x104b35ca8 <_Flutter_MMFoundation_BindContext+0x101188c>
104b35c78: aa1403e0    	mov	x0, x20
104b35c7c: aa1603e1    	mov	x1, x22
104b35c80: 94c3c52f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35c84: aa1d03fd    	mov	x29, x29
104b35c88: 94c3c530    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35c8c: aa0003f5    	mov	x21, x0
104b35c90: b00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b35c94: f9441501    	ldr	x1, [x8, #0x828] ; setM_firstSendMsgId:
104b35c98: aa1703e0    	mov	x0, x23
104b35c9c: aa1503e2    	mov	x2, x21
104b35ca0: 94c3c527    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35ca4: 14000022    	b	0x104b35d2c <_Flutter_MMFoundation_BindContext+0x1011910>
104b35ca8: d00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b35cac: f9467916    	ldr	x22, [x8, #0xcf0]
104b35cb0: aa1403e0    	mov	x0, x20
104b35cb4: aa1a03e1    	mov	x1, x26
104b35cb8: 94c3c521    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35cbc: aa1d03fd    	mov	x29, x29
104b35cc0: 94c3c522    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35cc4: aa0003f5    	mov	x21, x0
104b35cc8: aa1403e0    	mov	x0, x20
104b35ccc: f94013e1    	ldr	x1, [sp, #0x20]
104b35cd0: 94c3c51b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35cd4: aa0003f8    	mov	x24, x0
104b35cd8: f00d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b35cdc: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
104b35ce0: aa1403e0    	mov	x0, x20
104b35ce4: 94c3c516    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35ce8: aa0003e4    	mov	x4, x0
104b35cec: f00d9848    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b35cf0: f942f501    	ldr	x1, [x8, #0x5e8] ; GetClientIDOfMsg:LocalID:Time:
104b35cf4: aa1603e0    	mov	x0, x22
104b35cf8: aa1503e2    	mov	x2, x21
104b35cfc: aa1803e3    	mov	x3, x24
104b35d00: 94c3c50f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35d04: aa1d03fd    	mov	x29, x29
104b35d08: 94c3c510    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35d0c: aa0003f6    	mov	x22, x0
104b35d10: b00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b35d14: f9441501    	ldr	x1, [x8, #0x828] ; setM_firstSendMsgId:
104b35d18: aa1703e0    	mov	x0, x23
104b35d1c: aa1603e2    	mov	x2, x22
104b35d20: 94c3c507    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35d24: aa1603e0    	mov	x0, x22
104b35d28: 94c3c50b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35d2c: aa1503e0    	mov	x0, x21
104b35d30: 94c3c509    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35d34: d00d9868    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b35d38: f9458501    	ldr	x1, [x8, #0xb08] ; DelMsg:MsgWrap:
104b35d3c: aa1303e0    	mov	x0, x19
104b35d40: f94023f3    	ldr	x19, [sp, #0x40]
104b35d44: aa1303e2    	mov	x2, x19
104b35d48: aa1403e3    	mov	x3, x20
104b35d4c: 94c3c4fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35d50: aa1703e0    	mov	x0, x23
104b35d54: 94c3c500    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35d58: aa1c03e0    	mov	x0, x28
104b35d5c: 94c3c4fe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35d60: aa1b03e0    	mov	x0, x27
104b35d64: 94c3c4fc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35d68: aa1903e0    	mov	x0, x25
104b35d6c: 94c3c4fa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35d70: f94017f5    	ldr	x21, [sp, #0x28]
104b35d74: aa1503e0    	mov	x0, x21
104b35d78: 94c3c4f7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35d7c: aa1503e0    	mov	x0, x21
104b35d80: 94c3c4f5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35d84: f9401be0    	ldr	x0, [sp, #0x30]
104b35d88: 94c3c4f3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35d8c: f94027e0    	ldr	x0, [sp, #0x48]
104b35d90: 94c3c4f1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35d94: aa1403e0    	mov	x0, x20
104b35d98: 94c3c4ef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35d9c: aa1303e0    	mov	x0, x19
104b35da0: 94c3c4ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35da4: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
104b35da8: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
104b35dac: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
104b35db0: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
104b35db4: a94967fa    	ldp	x26, x25, [sp, #0x90]
104b35db8: a9486ffc    	ldp	x28, x27, [sp, #0x80]
104b35dbc: 910383ff    	add	sp, sp, #0xe0
104b35dc0: d65f03c0    	ret