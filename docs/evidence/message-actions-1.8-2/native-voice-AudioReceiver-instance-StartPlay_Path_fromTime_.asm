
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10017323c: d103c3ff    	sub	sp, sp, #0xf0
100173240: a9096ffc    	stp	x28, x27, [sp, #0x90]
100173244: a90a67fa    	stp	x26, x25, [sp, #0xa0]
100173248: a90b5ff8    	stp	x24, x23, [sp, #0xb0]
10017324c: a90c57f6    	stp	x22, x21, [sp, #0xc0]
100173250: a90d4ff4    	stp	x20, x19, [sp, #0xd0]
100173254: a90e7bfd    	stp	x29, x30, [sp, #0xe0]
100173258: 910383fd    	add	x29, sp, #0xe0
10017325c: aa0403fc    	mov	x28, x4
100173260: aa0303f4    	mov	x20, x3
100173264: aa0203f3    	mov	x19, x2
100173268: aa0003f6    	mov	x22, x0
10017326c: d01055c8    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
100173270: 52800029    	mov	w9, #0x1                ; =1
100173274: 391ead09    	strb	w9, [x8, #0x7ab]
100173278: aa0203e0    	mov	x0, x2
10017327c: 95eacfaf    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100173280: aa1403e0    	mov	x0, x20
100173284: 95eacfad    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100173288: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017328c: f9438101    	ldr	x1, [x8, #0x700] ; getVoiceFormat
100173290: aa1303e0    	mov	x0, x19
100173294: 95eacfaa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173298: aa0003e2    	mov	x2, x0
10017329c: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001732a0: f9438501    	ldr	x1, [x8, #0x708] ; generatePlayerWithAudioFormat:
1001732a4: aa1603e0    	mov	x0, x22
1001732a8: 95eacfa5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001732ac: aa1d03fd    	mov	x29, x29
1001732b0: 95eacfa6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001732b4: aa0003f5    	mov	x21, x0
1001732b8: b40008a0    	cbz	x0, 0x1001733cc <__text+0x16b3cc>
1001732bc: f0100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
1001732c0: b9828117    	ldrsw	x23, [x8, #0x280]
1001732c4: f8776ac0    	ldr	x0, [x22, x23]
1001732c8: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001732cc: f9438d01    	ldr	x1, [x8, #0x718] ; stopAndNotifyUI
1001732d0: 95eacf9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001732d4: 8b1702c0    	add	x0, x22, x23
1001732d8: aa1503e1    	mov	x1, x21
1001732dc: 95eacf99    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1001732e0: d0100008    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1001732e4: f9426100    	ldr	x0, [x8, #0x4c0]
1001732e8: 95eacf9c    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1001732ec: aa0003f8    	mov	x24, x0
1001732f0: b00fe648    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1001732f4: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
1001732f8: aa1303e0    	mov	x0, x19
1001732fc: f9001fe1    	str	x1, [sp, #0x38]
100173300: 95eacf8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173304: aa0003e2    	mov	x2, x0
100173308: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017330c: f9439101    	ldr	x1, [x8, #0x720] ; setAudioid:
100173310: aa1803e0    	mov	x0, x24
100173314: 95eacf8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173318: 900fe668    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10017331c: f9410101    	ldr	x1, [x8, #0x200] ; setMsgWrap:
100173320: aa1803e0    	mov	x0, x24
100173324: aa1303e2    	mov	x2, x19
100173328: 95eacf85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017332c: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100173330: f9439501    	ldr	x1, [x8, #0x728] ; setLastRecordTime:
100173334: aa1803e0    	mov	x0, x24
100173338: aa1c03e2    	mov	x2, x28
10017333c: 95eacf80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173340: 90100008    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100173344: f9471100    	ldr	x0, [x8, #0xe20]
100173348: d00fe668    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
10017334c: f947a501    	ldr	x1, [x8, #0xf48] ; getMainSettingExt
100173350: 95eacf7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173354: aa1d03fd    	mov	x29, x29
100173358: 95eacf7c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017335c: aa0003fa    	mov	x26, x0
100173360: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100173364: f9439901    	ldr	x1, [x8, #0x730] ; m_isForceEarpieceMode
100173368: 95eacf75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017336c: aa0003fb    	mov	x27, x0
100173370: aa1a03e0    	mov	x0, x26
100173374: 95eacf78    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100173378: 90100017    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10017337c: f94536e0    	ldr	x0, [x23, #0xa68]
100173380: d00fe628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100173384: f942a91a    	ldr	x26, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
100173388: 3400051b    	cbz	w27, 0x100173428 <__text+0x16b428>
10017338c: d00f19c8    	adrp	x8, 0x11e4ad000 <dyld_stub_binder+0x11e4ad000>
100173390: 91202108    	add	x8, x8, #0x808
100173394: f90003e8    	str	x8, [sp]
100173398: f00d85c5    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017339c: 910050a5    	add	x5, x5, #0x14
1001733a0: f00d85c7    	adrp	x7, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
1001733a4: 910094e7    	add	x7, x7, #0x25
1001733a8: aa1a03e1    	mov	x1, x26
1001733ac: 52800042    	mov	w2, #0x2                ; =2
1001733b0: d2800003    	mov	x3, #0x0                ; =0
1001733b4: 52800004    	mov	w4, #0x0                ; =0
1001733b8: 52800b06    	mov	w6, #0x58               ; =88
1001733bc: 95eacf60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001733c0: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001733c4: 911ce108    	add	x8, x8, #0x738
1001733c8: 14000027    	b	0x100173464 <__text+0x16b464>
1001733cc: 90100008    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1001733d0: f9453500    	ldr	x0, [x8, #0xa68]
1001733d4: d00fe628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1001733d8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1001733dc: d00f19c8    	adrp	x8, 0x11e4ad000 <dyld_stub_binder+0x11e4ad000>
1001733e0: 911fa108    	add	x8, x8, #0x7e8
1001733e4: f90003e8    	str	x8, [sp]
1001733e8: f00d85c5    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
1001733ec: 910050a5    	add	x5, x5, #0x14
1001733f0: f00d85c7    	adrp	x7, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
1001733f4: 910094e7    	add	x7, x7, #0x25
1001733f8: 52800082    	mov	w2, #0x4                ; =4
1001733fc: d2800003    	mov	x3, #0x0                ; =0
100173400: 52800004    	mov	w4, #0x0                ; =0
100173404: 52800906    	mov	w6, #0x48               ; =72
100173408: 95eacf4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017340c: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100173410: f9438901    	ldr	x1, [x8, #0x710] ; notifyOnPlaying:success:
100173414: aa1603e0    	mov	x0, x22
100173418: aa1303e2    	mov	x2, x19
10017341c: 52800003    	mov	w3, #0x0                ; =0
100173420: 95eacf47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173424: 14000098    	b	0x100173684 <__text+0x16b684>
100173428: d00f19c8    	adrp	x8, 0x11e4ad000 <dyld_stub_binder+0x11e4ad000>
10017342c: 9120a108    	add	x8, x8, #0x828
100173430: f90003e8    	str	x8, [sp]
100173434: f00d85c5    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
100173438: 910050a5    	add	x5, x5, #0x14
10017343c: f00d85c7    	adrp	x7, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
100173440: 910094e7    	add	x7, x7, #0x25
100173444: aa1a03e1    	mov	x1, x26
100173448: 52800042    	mov	w2, #0x2                ; =2
10017344c: d2800003    	mov	x3, #0x0                ; =0
100173450: 52800004    	mov	w4, #0x0                ; =0
100173454: 52800b66    	mov	w6, #0x5b               ; =91
100173458: 95eacf39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017345c: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100173460: 911d0108    	add	x8, x8, #0x740
100173464: f9400101    	ldr	x1, [x8]
100173468: aa1503e0    	mov	x0, x21
10017346c: 95eacf34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173470: d00fe648    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100173474: f9479d1b    	ldr	x27, [x8, #0xf38] ; GetChatName
100173478: b50004b4    	cbnz	x20, 0x10017350c <__text+0x16b50c>
10017347c: 90100019    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
100173480: f9467b34    	ldr	x20, [x25, #0xcf0]
100173484: aa1303e0    	mov	x0, x19
100173488: aa1b03e1    	mov	x1, x27
10017348c: 95eacf2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173490: aa1d03fd    	mov	x29, x29
100173494: 95eacf2d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100173498: f9001bfc    	str	x28, [sp, #0x30]
10017349c: aa0003fc    	mov	x28, x0
1001734a0: aa1303e0    	mov	x0, x19
1001734a4: f9401fe1    	ldr	x1, [sp, #0x38]
1001734a8: 95eacf25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001734ac: aa0003f7    	mov	x23, x0
1001734b0: f9467b20    	ldr	x0, [x25, #0xcf0]
1001734b4: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001734b8: f943a501    	ldr	x1, [x8, #0x748] ; GetDocPath
1001734bc: 95eacf20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001734c0: aa1d03fd    	mov	x29, x29
1001734c4: 95eacf21    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001734c8: aa0003f9    	mov	x25, x0
1001734cc: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001734d0: f943a901    	ldr	x1, [x8, #0x750] ; GetPathOfMesAudio:LocalID:DocPath:
1001734d4: aa1403e0    	mov	x0, x20
1001734d8: aa1c03e2    	mov	x2, x28
1001734dc: aa1703e3    	mov	x3, x23
1001734e0: 90100017    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1001734e4: aa1903e4    	mov	x4, x25
1001734e8: 95eacf15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001734ec: aa1d03fd    	mov	x29, x29
1001734f0: 95eacf16    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001734f4: aa0003f4    	mov	x20, x0
1001734f8: aa1903e0    	mov	x0, x25
1001734fc: 95eacf16    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100173500: aa1c03e0    	mov	x0, x28
100173504: f9401bfc    	ldr	x28, [sp, #0x30]
100173508: 95eacf13    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017350c: f94536f7    	ldr	x23, [x23, #0xa68]
100173510: aa1303e0    	mov	x0, x19
100173514: aa1b03e1    	mov	x1, x27
100173518: 95eacf09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017351c: aa1d03fd    	mov	x29, x29
100173520: 95eacf0a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100173524: aa0003f9    	mov	x25, x0
100173528: aa1303e0    	mov	x0, x19
10017352c: f9401fe1    	ldr	x1, [sp, #0x38]
100173530: 95eacf03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173534: a901d3fc    	stp	x28, x20, [sp, #0x18]
100173538: a90083f9    	stp	x25, x0, [sp, #0x8]
10017353c: d00f19c8    	adrp	x8, 0x11e4ad000 <dyld_stub_binder+0x11e4ad000>
100173540: 91212108    	add	x8, x8, #0x848
100173544: f90003e8    	str	x8, [sp]
100173548: f00d85c5    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017354c: 910050a5    	add	x5, x5, #0x14
100173550: f00d85c7    	adrp	x7, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
100173554: 910094e7    	add	x7, x7, #0x25
100173558: aa1703e0    	mov	x0, x23
10017355c: aa1a03e1    	mov	x1, x26
100173560: 52800042    	mov	w2, #0x2                ; =2
100173564: d2800003    	mov	x3, #0x0                ; =0
100173568: 52800004    	mov	w4, #0x0                ; =0
10017356c: 52800c66    	mov	w6, #0x63               ; =99
100173570: 95eacef3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173574: aa1903e0    	mov	x0, x25
100173578: 95eacef7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017357c: f00ffca8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100173580: f9405501    	ldr	x1, [x8, #0xa8] ; setUserData:
100173584: aa1503e0    	mov	x0, x21
100173588: aa1803e2    	mov	x2, x24
10017358c: 95eaceec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173590: d0100008    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
100173594: f9425500    	ldr	x0, [x8, #0x4a8]
100173598: 900ffc68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10017359c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1001735a0: 95eacee7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001735a4: aa0003e2    	mov	x2, x0
1001735a8: 900ffc88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1001735ac: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
1001735b0: aa1503e0    	mov	x0, x21
1001735b4: 95eacee2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001735b8: 340001e0    	cbz	w0, 0x1001735f4 <__text+0x16b5f4>
1001735bc: f81a83bf    	stur	xzr, [x29, #-0x58]
1001735c0: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001735c4: f943ad01    	ldr	x1, [x8, #0x758] ; resolveHAidCfgForMsg:outMode:outDevice:
1001735c8: d10153a3    	sub	x3, x29, #0x54
1001735cc: d10163a4    	sub	x4, x29, #0x58
1001735d0: aa1603e0    	mov	x0, x22
1001735d4: aa1303e2    	mov	x2, x19
1001735d8: 95eaced9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001735dc: 340000c0    	cbz	w0, 0x1001735f4 <__text+0x16b5f4>
1001735e0: 29750ba3    	ldp	w3, w2, [x29, #-0x58]
1001735e4: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001735e8: f943b101    	ldr	x1, [x8, #0x760] ; setHAidMode:device:
1001735ec: aa1503e0    	mov	x0, x21
1001735f0: 95eaced3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001735f4: f00ea3c8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1001735f8: f947e108    	ldr	x8, [x8, #0xfc0]
1001735fc: f90023e8    	str	x8, [sp, #0x40]
100173600: d00c6068    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
100173604: fd41c100    	ldr	d0, [x8, #0x380]
100173608: fd0027e0    	str	d0, [sp, #0x48]
10017360c: 90000008    	adrp	x8, 0x100173000 <__text+0x16b000>
100173610: 911af108    	add	x8, x8, #0x6bc
100173614: d00ea429    	adrp	x9, 0x11d5f9000 <dyld_stub_binder+0x11d5f9000>
100173618: 9113c129    	add	x9, x9, #0x4f0
10017361c: a90527e8    	stp	x8, x9, [sp, #0x50]
100173620: a90663f6    	stp	x22, x24, [sp, #0x60]
100173624: aa1503e0    	mov	x0, x21
100173628: 95eacec4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10017362c: f9003bf5    	str	x21, [sp, #0x70]
100173630: aa1303e0    	mov	x0, x19
100173634: 95eacec1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100173638: f9003ff3    	str	x19, [sp, #0x78]
10017363c: b90083fc    	str	w28, [sp, #0x80]
100173640: 900fe688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100173644: f943c916    	ldr	x22, [x8, #0x790] ; asyncPreparePlayWithFile:finished:
100173648: aa1803e0    	mov	x0, x24
10017364c: 95eacebb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100173650: 910103e3    	add	x3, sp, #0x40
100173654: aa1503e0    	mov	x0, x21
100173658: aa1603e1    	mov	x1, x22
10017365c: aa1403e2    	mov	x2, x20
100173660: 95eaceb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100173664: f9403fe0    	ldr	x0, [sp, #0x78]
100173668: 95eacebb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017366c: f9403be0    	ldr	x0, [sp, #0x70]
100173670: 95eaceb9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100173674: f94037e0    	ldr	x0, [sp, #0x68]
100173678: 95eaceb7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017367c: aa1803e0    	mov	x0, x24
100173680: 95eaceb5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100173684: aa1503e0    	mov	x0, x21
100173688: 95eaceb3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017368c: aa1403e0    	mov	x0, x20
100173690: 95eaceb1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100173694: aa1303e0    	mov	x0, x19
100173698: 95eaceaf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017369c: a94e7bfd    	ldp	x29, x30, [sp, #0xe0]
1001736a0: a94d4ff4    	ldp	x20, x19, [sp, #0xd0]
1001736a4: a94c57f6    	ldp	x22, x21, [sp, #0xc0]
1001736a8: a94b5ff8    	ldp	x24, x23, [sp, #0xb0]
1001736ac: a94a67fa    	ldp	x26, x25, [sp, #0xa0]
1001736b0: a9496ffc    	ldp	x28, x27, [sp, #0x90]
1001736b4: 9103c3ff    	add	sp, sp, #0xf0
1001736b8: d65f03c0    	ret
