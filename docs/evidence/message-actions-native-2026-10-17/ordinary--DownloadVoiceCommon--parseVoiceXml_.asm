
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101174448: d10343ff    	sub	sp, sp, #0xd0
10117444c: a9095ff8    	stp	x24, x23, [sp, #0x90]
101174450: a90a57f6    	stp	x22, x21, [sp, #0xa0]
101174454: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
101174458: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
10117445c: 910303fd    	add	x29, sp, #0xc0
101174460: aa0203f4    	mov	x20, x2
101174464: b00fd5e8    	adrp	x8, 0x120c31000 <dyld_stub_binder+0x120c31000>
101174468: 52800029    	mov	w9, #0x1                ; =1
10117446c: 39095d09    	strb	w9, [x8, #0x257]
101174470: 900f8048    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
101174474: f9442d13    	ldr	x19, [x8, #0x858]
101174478: 900f7c88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10117447c: f9461d15    	ldr	x21, [x8, #0xc38] ; new
101174480: aa0203e0    	mov	x0, x2
101174484: 95aacb2d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101174488: aa1303e0    	mov	x0, x19
10117448c: aa1503e1    	mov	x1, x21
101174490: 95aacb2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101174494: aa0003f3    	mov	x19, x0
101174498: d10143a0    	sub	x0, x29, #0x50
10117449c: 52800021    	mov	w1, #0x1                ; =1
1011744a0: 95aa6393    	bl	0x107c0d2ec <_Flutter_MMFoundation_BindContext+0x40e8ed0>
1011744a4: aa1403e0    	mov	x0, x20
1011744a8: 95aacb40    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
1011744ac: d00f7c48    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1011744b0: f944d901    	ldr	x1, [x8, #0x9b0] ; UTF8String
1011744b4: 95aacb22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011744b8: aa0003f5    	mov	x21, x0
1011744bc: f00f7c68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1011744c0: f946ed01    	ldr	x1, [x8, #0xdd8] ; lengthOfBytesUsingEncoding:
1011744c4: aa1403e0    	mov	x0, x20
1011744c8: 52800082    	mov	w2, #0x4                ; =4
1011744cc: 95aacb1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011744d0: aa0003f6    	mov	x22, x0
1011744d4: aa1403e0    	mov	x0, x20
1011744d8: 95aacb1f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1011744dc: d10143a0    	sub	x0, x29, #0x50
1011744e0: aa1503e1    	mov	x1, x21
1011744e4: aa1603e2    	mov	x2, x22
1011744e8: 95aa6382    	bl	0x107c0d2f0 <_Flutter_MMFoundation_BindContext+0x40e8ed4>
1011744ec: d10143a0    	sub	x0, x29, #0x50
1011744f0: 95aa6381    	bl	0x107c0d2f4 <_Flutter_MMFoundation_BindContext+0x40e8ed8>
1011744f4: b40015c0    	cbz	x0, 0x1011747ac <__text+0x116c7ac>
1011744f8: f00dc181    	adrp	x1, 0x11c9a7000 <dyld_stub_binder+0x11c9a7000>
1011744fc: 9138f021    	add	x1, x1, #0xe3c ; msg
101174500: 95aa6373    	bl	0x107c0d2cc <_Flutter_MMFoundation_BindContext+0x40e8eb0>
101174504: b4001760    	cbz	x0, 0x1011747f0 <__text+0x116c7f0>
101174508: b00d06e1    	adrp	x1, 0x11b251000 <dyld_stub_binder+0x11b251000>
10117450c: 911bc021    	add	x1, x1, #0x6f0 ; voicemsg
101174510: 95aa636f    	bl	0x107c0d2cc <_Flutter_MMFoundation_BindContext+0x40e8eb0>
101174514: aa0003f4    	mov	x20, x0
101174518: b4001a60    	cbz	x0, 0x101174864 <__text+0x116c864>
10117451c: 900d1041    	adrp	x1, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101174520: 911fd021    	add	x1, x1, #0x7f4 ; endflag
101174524: aa1403e0    	mov	x0, x20
101174528: 95aa6366    	bl	0x107c0d2c0 <_Flutter_MMFoundation_BindContext+0x40e8ea4>
10117452c: aa0003e1    	mov	x1, x0
101174530: 910163f5    	add	x21, sp, #0x58
101174534: 910163e0    	add	x0, sp, #0x58
101174538: 97bc2591    	bl	0x10007db7c <__text+0x75b7c>
10117453c: 39c1bfe8    	ldrsb	w8, [sp, #0x6f]
101174540: f9402fe9    	ldr	x9, [sp, #0x58]
101174544: 7100011f    	cmp	w8, #0x0
101174548: 9a95b120    	csel	x0, x9, x21, lt
10117454c: 95aacb3c    	bl	0x107c2723c <_Flutter_MMFoundation_BindContext+0x4102e20>
101174550: aa0003e2    	mov	x2, x0
101174554: d00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101174558: f9446501    	ldr	x1, [x8, #0x8c8] ; setM_uiEndFlag:
10117455c: aa1303e0    	mov	x0, x19
101174560: 95aacaf7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101174564: 900d1041    	adrp	x1, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101174568: 911ff021    	add	x1, x1, #0x7fc ; length
10117456c: aa1403e0    	mov	x0, x20
101174570: 95aa6354    	bl	0x107c0d2c0 <_Flutter_MMFoundation_BindContext+0x40e8ea4>
101174574: aa0003e1    	mov	x1, x0
101174578: 910103f5    	add	x21, sp, #0x40
10117457c: 910103e0    	add	x0, sp, #0x40
101174580: 97bc257f    	bl	0x10007db7c <__text+0x75b7c>
101174584: 39c15fe8    	ldrsb	w8, [sp, #0x57]
101174588: f94023e9    	ldr	x9, [sp, #0x40]
10117458c: 7100011f    	cmp	w8, #0x0
101174590: 9a95b120    	csel	x0, x9, x21, lt
101174594: 95aacb2a    	bl	0x107c2723c <_Flutter_MMFoundation_BindContext+0x4102e20>
101174598: aa0003e2    	mov	x2, x0
10117459c: d00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
1011745a0: f9446101    	ldr	x1, [x8, #0x8c0] ; setM_uiVoiceLen:
1011745a4: aa1303e0    	mov	x0, x19
1011745a8: 95aacae5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011745ac: 900d1041    	adrp	x1, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
1011745b0: 91200c21    	add	x1, x1, #0x803 ; voicelength
1011745b4: aa1403e0    	mov	x0, x20
1011745b8: 95aa6342    	bl	0x107c0d2c0 <_Flutter_MMFoundation_BindContext+0x40e8ea4>
1011745bc: aa0003e1    	mov	x1, x0
1011745c0: 9100a3f5    	add	x21, sp, #0x28
1011745c4: 9100a3e0    	add	x0, sp, #0x28
1011745c8: 97bc256d    	bl	0x10007db7c <__text+0x75b7c>
1011745cc: 39c0ffe8    	ldrsb	w8, [sp, #0x3f]
1011745d0: f94017e9    	ldr	x9, [sp, #0x28]
1011745d4: 7100011f    	cmp	w8, #0x0
1011745d8: 9a95b120    	csel	x0, x9, x21, lt
1011745dc: 95aacb18    	bl	0x107c2723c <_Flutter_MMFoundation_BindContext+0x4102e20>
1011745e0: aa0003e2    	mov	x2, x0
1011745e4: f00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1011745e8: f9455901    	ldr	x1, [x8, #0xab0] ; setM_uiVoiceTime:
1011745ec: aa1303e0    	mov	x0, x19
1011745f0: 95aacad3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011745f4: 900d1041    	adrp	x1, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
1011745f8: 91203c21    	add	x1, x1, #0x80f ; cancelflag
1011745fc: aa1403e0    	mov	x0, x20
101174600: 95aa6330    	bl	0x107c0d2c0 <_Flutter_MMFoundation_BindContext+0x40e8ea4>
101174604: aa0003e1    	mov	x1, x0
101174608: 910043f5    	add	x21, sp, #0x10
10117460c: 910043e0    	add	x0, sp, #0x10
101174610: 97bc255b    	bl	0x10007db7c <__text+0x75b7c>
101174614: 39c09fe8    	ldrsb	w8, [sp, #0x27]
101174618: f9400be9    	ldr	x9, [sp, #0x10]
10117461c: 7100011f    	cmp	w8, #0x0
101174620: 9a95b120    	csel	x0, x9, x21, lt
101174624: 95aacb06    	bl	0x107c2723c <_Flutter_MMFoundation_BindContext+0x4102e20>
101174628: aa0003e2    	mov	x2, x0
10117462c: d00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101174630: f944a901    	ldr	x1, [x8, #0x950] ; setM_uiCancelFlag:
101174634: aa1303e0    	mov	x0, x19
101174638: 95aacac1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10117463c: f00f7ff8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
101174640: f9454715    	ldr	x21, [x24, #0xa88]
101174644: 900d1041    	adrp	x1, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101174648: 91206821    	add	x1, x1, #0x81a ; bufid
10117464c: aa1403e0    	mov	x0, x20
101174650: 95aa631c    	bl	0x107c0d2c0 <_Flutter_MMFoundation_BindContext+0x40e8ea4>
101174654: aa0003e2    	mov	x2, x0
101174658: d00f7ca8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10117465c: f946ad01    	ldr	x1, [x8, #0xd58] ; stringWithUTF8String:
101174660: aa1503e0    	mov	x0, x21
101174664: 95aacab6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101174668: aa1d03fd    	mov	x29, x29
10117466c: 95aacab7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101174670: aa0003f5    	mov	x21, x0
101174674: 900f7c88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101174678: f940a901    	ldr	x1, [x8, #0x150] ; longLongValue
10117467c: 95aacab0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101174680: aa0003e2    	mov	x2, x0
101174684: d00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101174688: f9446901    	ldr	x1, [x8, #0x8d0] ; setM_ui64BufId:
10117468c: aa1303e0    	mov	x0, x19
101174690: 95aacaab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101174694: f9454716    	ldr	x22, [x24, #0xa88]
101174698: 900d1041    	adrp	x1, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
10117469c: 91208021    	add	x1, x1, #0x820 ; voiceurl
1011746a0: aa1403e0    	mov	x0, x20
1011746a4: 95aa6307    	bl	0x107c0d2c0 <_Flutter_MMFoundation_BindContext+0x40e8ea4>
1011746a8: aa0003e2    	mov	x2, x0
1011746ac: d00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
1011746b0: f944ad17    	ldr	x23, [x8, #0x958] ; safeStringWithUTF8String:
1011746b4: aa1603e0    	mov	x0, x22
1011746b8: aa1703e1    	mov	x1, x23
1011746bc: 95aacaa0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011746c0: aa1d03fd    	mov	x29, x29
1011746c4: 95aacaa1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1011746c8: aa0003f6    	mov	x22, x0
1011746cc: 900f6868    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
1011746d0: f942dd01    	ldr	x1, [x8, #0x5b8] ; setVoiceUrl:
1011746d4: aa1303e0    	mov	x0, x19
1011746d8: aa1603e2    	mov	x2, x22
1011746dc: 95aaca98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011746e0: aa1603e0    	mov	x0, x22
1011746e4: 95aaca9c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1011746e8: f9454716    	ldr	x22, [x24, #0xa88]
1011746ec: b00d09e1    	adrp	x1, 0x11b2b1000 <dyld_stub_binder+0x11b2b1000>
1011746f0: 911bc821    	add	x1, x1, #0x6f2 ; aeskey
1011746f4: aa1403e0    	mov	x0, x20
1011746f8: 95aa62f2    	bl	0x107c0d2c0 <_Flutter_MMFoundation_BindContext+0x40e8ea4>
1011746fc: aa0003e2    	mov	x2, x0
101174700: aa1603e0    	mov	x0, x22
101174704: aa1703e1    	mov	x1, x23
101174708: 95aaca8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10117470c: aa1d03fd    	mov	x29, x29
101174710: 95aaca8e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101174714: aa0003f4    	mov	x20, x0
101174718: 900f6668    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10117471c: f9445901    	ldr	x1, [x8, #0x8b0] ; setAesKey:
101174720: aa1303e0    	mov	x0, x19
101174724: aa1403e2    	mov	x2, x20
101174728: 95aaca85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10117472c: aa1403e0    	mov	x0, x20
101174730: 95aaca89    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101174734: aa1303e0    	mov	x0, x19
101174738: 95aaca80    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10117473c: aa1503e0    	mov	x0, x21
101174740: 95aaca85    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101174744: 39c09fe8    	ldrsb	w8, [sp, #0x27]
101174748: 36f800a8    	tbz	w8, #0x1f, 0x10117475c <__text+0x116c75c>
10117474c: f9400be0    	ldr	x0, [sp, #0x10]
101174750: f94013e8    	ldr	x8, [sp, #0x20]
101174754: 9240f901    	and	x1, x8, #0x7fffffffffffffff
101174758: 95aaca9d    	bl	0x107c271cc <_Flutter_MMFoundation_BindContext+0x4102db0>
10117475c: 39c0ffe8    	ldrsb	w8, [sp, #0x3f]
101174760: 36f800a8    	tbz	w8, #0x1f, 0x101174774 <__text+0x116c774>
101174764: f94017e0    	ldr	x0, [sp, #0x28]
101174768: f9401fe8    	ldr	x8, [sp, #0x38]
10117476c: 9240f901    	and	x1, x8, #0x7fffffffffffffff
101174770: 95aaca97    	bl	0x107c271cc <_Flutter_MMFoundation_BindContext+0x4102db0>
101174774: 39c15fe8    	ldrsb	w8, [sp, #0x57]
101174778: 36f800a8    	tbz	w8, #0x1f, 0x10117478c <__text+0x116c78c>
10117477c: f94023e0    	ldr	x0, [sp, #0x40]
101174780: f9402be8    	ldr	x8, [sp, #0x50]
101174784: 9240f901    	and	x1, x8, #0x7fffffffffffffff
101174788: 95aaca91    	bl	0x107c271cc <_Flutter_MMFoundation_BindContext+0x4102db0>
10117478c: 39c1bfe8    	ldrsb	w8, [sp, #0x6f]
101174790: 36f800a8    	tbz	w8, #0x1f, 0x1011747a4 <__text+0x116c7a4>
101174794: f9402fe0    	ldr	x0, [sp, #0x58]
101174798: f94037e8    	ldr	x8, [sp, #0x68]
10117479c: 9240f901    	and	x1, x8, #0x7fffffffffffffff
1011747a0: 95aaca8b    	bl	0x107c271cc <_Flutter_MMFoundation_BindContext+0x4102db0>
1011747a4: aa1303f4    	mov	x20, x19
1011747a8: 14000024    	b	0x101174838 <__text+0x116c838>
1011747ac: f00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1011747b0: f9453500    	ldr	x0, [x8, #0xa68]
1011747b4: b00f6628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1011747b8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1011747bc: d00e9ee8    	adrp	x8, 0x11e552000 <dyld_stub_binder+0x11e552000>
1011747c0: 911ba108    	add	x8, x8, #0x6e8
1011747c4: f90003e8    	str	x8, [sp]
1011747c8: b00d0583    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
1011747cc: 9107f063    	add	x3, x3, #0x1fc ; Msg
1011747d0: 900d1045    	adrp	x5, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
1011747d4: 911be8a5    	add	x5, x5, #0x6fa ; DownloadVoiceCommon.mm
1011747d8: 900d1047    	adrp	x7, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
1011747dc: 911e58e7    	add	x7, x7, #0x796 ; +[DownloadVoiceCommon parseVoiceXml:]
1011747e0: 52800062    	mov	w2, #0x3                ; =3
1011747e4: 52800004    	mov	w4, #0x0                ; =0
1011747e8: 52800766    	mov	w6, #0x3b               ; =59
1011747ec: 14000011    	b	0x101174830 <__text+0x116c830>
1011747f0: f00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1011747f4: f9453500    	ldr	x0, [x8, #0xa68]
1011747f8: b00f6628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1011747fc: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101174800: d00e9ee8    	adrp	x8, 0x11e552000 <dyld_stub_binder+0x11e552000>
101174804: 911c2108    	add	x8, x8, #0x708
101174808: f90003e8    	str	x8, [sp]
10117480c: b00d0583    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
101174810: 9107f063    	add	x3, x3, #0x1fc ; Msg
101174814: 900d1045    	adrp	x5, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101174818: 911be8a5    	add	x5, x5, #0x6fa ; DownloadVoiceCommon.mm
10117481c: 900d1047    	adrp	x7, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101174820: 911e58e7    	add	x7, x7, #0x796 ; +[DownloadVoiceCommon parseVoiceXml:]
101174824: 52800062    	mov	w2, #0x3                ; =3
101174828: 52800004    	mov	w4, #0x0                ; =0
10117482c: 52800826    	mov	w6, #0x41               ; =65
101174830: 95aaca43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101174834: d2800014    	mov	x20, #0x0               ; =0
101174838: d10143a0    	sub	x0, x29, #0x50
10117483c: 95aa62a9    	bl	0x107c0d2e0 <_Flutter_MMFoundation_BindContext+0x40e8ec4>
101174840: aa1303e0    	mov	x0, x19
101174844: 95aaca44    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101174848: aa1403e0    	mov	x0, x20
10117484c: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
101174850: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
101174854: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
101174858: a9495ff8    	ldp	x24, x23, [sp, #0x90]
10117485c: 910343ff    	add	sp, sp, #0xd0
101174860: 15aaca44    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
101174864: f00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101174868: f9453500    	ldr	x0, [x8, #0xa68]
10117486c: b00f6628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101174870: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101174874: d00e9ee8    	adrp	x8, 0x11e552000 <dyld_stub_binder+0x11e552000>
101174878: 911ca108    	add	x8, x8, #0x728
10117487c: f90003e8    	str	x8, [sp]
101174880: b00d0583    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
101174884: 9107f063    	add	x3, x3, #0x1fc ; Msg
101174888: 900d1045    	adrp	x5, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
10117488c: 911be8a5    	add	x5, x5, #0x6fa ; DownloadVoiceCommon.mm
101174890: 900d1047    	adrp	x7, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101174894: 911e58e7    	add	x7, x7, #0x796 ; +[DownloadVoiceCommon parseVoiceXml:]
101174898: 52800062    	mov	w2, #0x3                ; =3
10117489c: 52800004    	mov	w4, #0x0                ; =0
1011748a0: 528008e6    	mov	w6, #0x47               ; =71
1011748a4: 95aaca26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011748a8: 17ffffe4    	b	0x101174838 <__text+0x116c838>