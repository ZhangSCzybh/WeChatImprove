
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105f88288: d10583ff    	sub	sp, sp, #0x160
105f8828c: 6d0f23e9    	stp	d9, d8, [sp, #0xf0]
105f88290: a9106ffc    	stp	x28, x27, [sp, #0x100]
105f88294: a91167fa    	stp	x26, x25, [sp, #0x110]
105f88298: a9125ff8    	stp	x24, x23, [sp, #0x120]
105f8829c: a91357f6    	stp	x22, x21, [sp, #0x130]
105f882a0: a9144ff4    	stp	x20, x19, [sp, #0x140]
105f882a4: a9157bfd    	stp	x29, x30, [sp, #0x150]
105f882a8: 910543fd    	add	x29, sp, #0x150
105f882ac: aa0203fb    	mov	x27, x2
105f882b0: f00d65c8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
105f882b4: 52800029    	mov	w9, #0x1                ; =1
105f882b8: 39053509    	strb	w9, [x8, #0x14d]
105f882bc: aa0203e0    	mov	x0, x2
105f882c0: 94727b9e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105f882c4: 900d0028    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
105f882c8: f9446501    	ldr	x1, [x8, #0x8c8] ; isParaVaild
105f882cc: aa1b03e0    	mov	x0, x27
105f882d0: 94727b9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f882d4: 36002640    	tbz	w0, #0x0, 0x105f8879c <_Flutter_MMFoundation_BindContext+0x2464380>
105f882d8: f00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f882dc: f945e900    	ldr	x0, [x8, #0xbd0]
105f882e0: 900d0bc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105f882e4: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
105f882e8: aa1603e1    	mov	x1, x22
105f882ec: 94727b94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f882f0: aa1d03fd    	mov	x29, x29
105f882f4: 94727b95    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f882f8: aa0003f5    	mov	x21, x0
105f882fc: 900d0f68    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105f88300: f9401500    	ldr	x0, [x8, #0x28] ; P;,
105f88304: f00d0ba8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105f88308: f947ad17    	ldr	x23, [x8, #0xf58] ; class
105f8830c: aa1703e1    	mov	x1, x23
105f88310: 94727b8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88314: aa0003e2    	mov	x2, x0
105f88318: b00cf588    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105f8831c: f9464113    	ldr	x19, [x8, #0xc80] ; getService:
105f88320: aa1503e0    	mov	x0, x21
105f88324: aa1303e1    	mov	x1, x19
105f88328: 94727b85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8832c: aa1d03fd    	mov	x29, x29
105f88330: 94727b86    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88334: aa0003f9    	mov	x25, x0
105f88338: 900d0028    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
105f8833c: f9450918    	ldr	x24, [x8, #0xa10] ; m_fromUser
105f88340: aa1b03e0    	mov	x0, x27
105f88344: aa1803e1    	mov	x1, x24
105f88348: 94727b7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8834c: aa1d03fd    	mov	x29, x29
105f88350: 94727b7e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88354: aa0003fa    	mov	x26, x0
105f88358: 900cf5a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105f8835c: f940c901    	ldr	x1, [x8, #0x190] ; getContactByName:
105f88360: aa1903e0    	mov	x0, x25
105f88364: aa1a03e2    	mov	x2, x26
105f88368: 94727b75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8836c: aa1d03fd    	mov	x29, x29
105f88370: 94727b76    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88374: aa0003fc    	mov	x28, x0
105f88378: aa1a03e0    	mov	x0, x26
105f8837c: 94727b76    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88380: aa1903e0    	mov	x0, x25
105f88384: 94727b74    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88388: aa1503e0    	mov	x0, x21
105f8838c: 94727b72    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88390: b40026fc    	cbz	x28, 0x105f8886c <_Flutter_MMFoundation_BindContext+0x2464450>
105f88394: d00d1048    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
105f88398: f9479900    	ldr	x0, [x8, #0xf30]
105f8839c: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f883a0: f9420d01    	ldr	x1, [x8, #0x418] ; genInviteMessageFromVoipMonoMsg:
105f883a4: aa1b03e2    	mov	x2, x27
105f883a8: 94727b65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f883ac: aa1d03fd    	mov	x29, x29
105f883b0: 94727b66    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f883b4: aa0003f9    	mov	x25, x0
105f883b8: b4002d40    	cbz	x0, 0x105f88960 <_Flutter_MMFoundation_BindContext+0x2464544>
105f883bc: f9003bf9    	str	x25, [sp, #0x70]
105f883c0: f90043fc    	str	x28, [sp, #0x80]
105f883c4: f00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f883c8: f9457100    	ldr	x0, [x8, #0xae0]
105f883cc: 900d0bc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105f883d0: f9460d15    	ldr	x21, [x8, #0xc18] ; date
105f883d4: aa1503e1    	mov	x1, x21
105f883d8: 94727b59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f883dc: aa1d03fd    	mov	x29, x29
105f883e0: 94727b5a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f883e4: aa0003fa    	mov	x26, x0
105f883e8: f00d0c08    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
105f883ec: f940a919    	ldr	x25, [x8, #0x150] ; timeIntervalSince1970
105f883f0: aa1903e1    	mov	x1, x25
105f883f4: 94727b52    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f883f8: b0096fc8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
105f883fc: fd41cd08    	ldr	d8, [x8, #0x398]
105f88400: 1e680800    	fmul	d0, d0, d8
105f88404: aa1603e1    	mov	x1, x22
105f88408: f9004bf6    	str	x22, [sp, #0x90]
105f8840c: 9e790016    	fcvtzu	x22, d0
105f88410: f90033f8    	str	x24, [sp, #0x60]
105f88414: f00d0f58    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
105f88418: f945eb00    	ldr	x0, [x24, #0xbd0]
105f8841c: 94727b48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88420: aa1d03fd    	mov	x29, x29
105f88424: 94727b49    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88428: aa0003f4    	mov	x20, x0
105f8842c: f00d0f58    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
105f88430: f9472f00    	ldr	x0, [x24, #0xe58]
105f88434: aa1703e1    	mov	x1, x23
105f88438: 94727b41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8843c: aa0003e2    	mov	x2, x0
105f88440: aa1403e0    	mov	x0, x20
105f88444: aa1303e1    	mov	x1, x19
105f88448: 94727b3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8844c: aa1d03fd    	mov	x29, x29
105f88450: 94727b3e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88454: aa0003fc    	mov	x28, x0
105f88458: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8845c: f9421501    	ldr	x1, [x8, #0x428] ; setMRecvInviteTime:
105f88460: aa1603e2    	mov	x2, x22
105f88464: 94727b36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88468: aa1c03e0    	mov	x0, x28
105f8846c: 94727b3a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88470: aa1403e0    	mov	x0, x20
105f88474: 94727b38    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88478: aa1a03e0    	mov	x0, x26
105f8847c: aa1803f6    	mov	x22, x24
105f88480: 94727b35    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88484: f00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f88488: f9457100    	ldr	x0, [x8, #0xae0]
105f8848c: aa1503e1    	mov	x1, x21
105f88490: 94727b2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88494: aa1d03fd    	mov	x29, x29
105f88498: 94727b2c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8849c: aa0003f4    	mov	x20, x0
105f884a0: aa1903e1    	mov	x1, x25
105f884a4: 94727b26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f884a8: 1e680800    	fmul	d0, d0, d8
105f884ac: 9e790018    	fcvtzu	x24, d0
105f884b0: aa1403e0    	mov	x0, x20
105f884b4: 94727b28    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f884b8: f00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f884bc: f945e900    	ldr	x0, [x8, #0xbd0]
105f884c0: f9404bfa    	ldr	x26, [sp, #0x90]
105f884c4: aa1a03e1    	mov	x1, x26
105f884c8: 94727b1d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f884cc: aa1d03fd    	mov	x29, x29
105f884d0: 94727b1e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f884d4: aa0003f9    	mov	x25, x0
105f884d8: f9472ec0    	ldr	x0, [x22, #0xe58]
105f884dc: f90047f7    	str	x23, [sp, #0x88]
105f884e0: aa1703e1    	mov	x1, x23
105f884e4: 94727b16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f884e8: aa0003e2    	mov	x2, x0
105f884ec: aa1903e0    	mov	x0, x25
105f884f0: aa1303f7    	mov	x23, x19
105f884f4: aa1303e1    	mov	x1, x19
105f884f8: 94727b11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f884fc: aa1d03fd    	mov	x29, x29
105f88500: 94727b12    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88504: aa0003f4    	mov	x20, x0
105f88508: aa1b03e0    	mov	x0, x27
105f8850c: f94033e1    	ldr	x1, [sp, #0x60]
105f88510: 94727b0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88514: aa1d03fd    	mov	x29, x29
105f88518: 94727b0c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8851c: aa0003f5    	mov	x21, x0
105f88520: 900d0028    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
105f88524: f944c901    	ldr	x1, [x8, #0x990] ; m_mode
105f88528: aa1b03e0    	mov	x0, x27
105f8852c: f90027e1    	str	x1, [sp, #0x48]
105f88530: 94727b03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88534: aa0003f6    	mov	x22, x0
105f88538: 900d0028    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
105f8853c: f9450d13    	ldr	x19, [x8, #0xa18] ; m_roomId
105f88540: aa1b03e0    	mov	x0, x27
105f88544: aa1303e1    	mov	x1, x19
105f88548: 94727afd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8854c: aa0003fc    	mov	x28, x0
105f88550: 900d0028    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
105f88554: f9451101    	ldr	x1, [x8, #0xa20] ; m_roomKey
105f88558: f9003ffb    	str	x27, [sp, #0x78]
105f8855c: aa1b03e0    	mov	x0, x27
105f88560: f90037e1    	str	x1, [sp, #0x68]
105f88564: 94727af6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88568: aa0003e6    	mov	x6, x0
105f8856c: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f88570: f9421901    	ldr	x1, [x8, #0x430] ; doSimuCallJudge:isCallin:inviteType:roomId:roomKey:timeStamp:
105f88574: aa1403e0    	mov	x0, x20
105f88578: aa1503e2    	mov	x2, x21
105f8857c: 52800023    	mov	w3, #0x1                ; =1
105f88580: aa1603e4    	mov	x4, x22
105f88584: aa1c03e5    	mov	x5, x28
105f88588: f9002ff8    	str	x24, [sp, #0x58]
105f8858c: aa1803e7    	mov	x7, x24
105f88590: 94727aeb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88594: aa0003f6    	mov	x22, x0
105f88598: aa1503e0    	mov	x0, x21
105f8859c: 94727aee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f885a0: aa1403e0    	mov	x0, x20
105f885a4: 94727aec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f885a8: aa1903e0    	mov	x0, x25
105f885ac: 94727aea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f885b0: f00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f885b4: f945e900    	ldr	x0, [x8, #0xbd0]
105f885b8: aa1a03e1    	mov	x1, x26
105f885bc: 94727ae0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f885c0: aa1d03fd    	mov	x29, x29
105f885c4: 94727ae1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f885c8: aa0003f9    	mov	x25, x0
105f885cc: 710006df    	cmp	w22, #0x1
105f885d0: 540022e1    	b.ne	0x105f88a2c <_Flutter_MMFoundation_BindContext+0x2464610>
105f885d4: aa1303fa    	mov	x26, x19
105f885d8: f00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f885dc: f9472d00    	ldr	x0, [x8, #0xe58]
105f885e0: f94047e1    	ldr	x1, [sp, #0x88]
105f885e4: 94727ad6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f885e8: aa0003e2    	mov	x2, x0
105f885ec: aa1903e0    	mov	x0, x25
105f885f0: aa1703fb    	mov	x27, x23
105f885f4: aa1703e1    	mov	x1, x23
105f885f8: 94727ad1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f885fc: aa1d03fd    	mov	x29, x29
105f88600: 94727ad2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88604: aa0003f4    	mov	x20, x0
105f88608: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8860c: f9421d01    	ldr	x1, [x8, #0x438] ; isSendAckOrAnswerEnabled
105f88610: 94727acb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88614: aa0003f5    	mov	x21, x0
105f88618: aa1403e0    	mov	x0, x20
105f8861c: 94727ace    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88620: aa1903e0    	mov	x0, x25
105f88624: 94727acc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88628: 52800040    	mov	w0, #0x2                ; =2
105f8862c: 94721305    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f88630: f94043f7    	ldr	x23, [sp, #0x80]
105f88634: 34003435    	cbz	w21, 0x105f88cb8 <_Flutter_MMFoundation_BindContext+0x246489c>
105f88638: f9403ff3    	ldr	x19, [sp, #0x78]
105f8863c: f94037f8    	ldr	x24, [sp, #0x68]
105f88640: 340005e0    	cbz	w0, 0x105f886fc <_Flutter_MMFoundation_BindContext+0x24642e0>
105f88644: 94727ad7    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f88648: aa0003f5    	mov	x21, x0
105f8864c: f00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f88650: f94546c0    	ldr	x0, [x22, #0xa88]
105f88654: 94727ac3    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f88658: aa0003f4    	mov	x20, x0
105f8865c: f94546d9    	ldr	x25, [x22, #0xa88]
105f88660: aa1303e0    	mov	x0, x19
105f88664: aa1a03e1    	mov	x1, x26
105f88668: 94727ab5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8866c: d00d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f88670: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f88674: a9007fe0    	stp	x0, xzr, [sp]
105f88678: f00c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f8867c: 91182042    	add	x2, x2, #0x608
105f88680: aa1903e0    	mov	x0, x25
105f88684: 94727aae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88688: aa1d03fd    	mov	x29, x29
105f8868c: 94727aaf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88690: aa0003f9    	mov	x25, x0
105f88694: d00d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f88698: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f8869c: f00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f886a0: 91352108    	add	x8, x8, #0xd48
105f886a4: a90003e8    	stp	x8, x0, [sp]
105f886a8: f00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f886ac: 9134a042    	add	x2, x2, #0xd28
105f886b0: aa1403e0    	mov	x0, x20
105f886b4: 94727aa2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f886b8: aa0003f4    	mov	x20, x0
105f886bc: aa1903e0    	mov	x0, x25
105f886c0: 94727aa5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f886c4: d00acec1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f886c8: 91373c21    	add	x1, x1, #0xdcf
105f886cc: d00acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f886d0: 9135dc42    	add	x2, x2, #0xd77
105f886d4: f00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f886d8: 9138bc84    	add	x4, x4, #0xe2f
105f886dc: 52800040    	mov	w0, #0x2                ; =2
105f886e0: 5280a503    	mov	w3, #0x528              ; =1320
105f886e4: aa1403e5    	mov	x5, x20
105f886e8: 947212d7    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f886ec: aa1403e0    	mov	x0, x20
105f886f0: 94727a99    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f886f4: aa1503e0    	mov	x0, x21
105f886f8: 94727aad    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f886fc: f00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f88700: f945e900    	ldr	x0, [x8, #0xbd0]
105f88704: f9404be1    	ldr	x1, [sp, #0x90]
105f88708: 94727a8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8870c: aa1d03fd    	mov	x29, x29
105f88710: 94727a8e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88714: aa0003f4    	mov	x20, x0
105f88718: 900d1088    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f8871c: f9463900    	ldr	x0, [x8, #0xc70]
105f88720: f94047e1    	ldr	x1, [sp, #0x88]
105f88724: 94727a86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88728: aa0003e2    	mov	x2, x0
105f8872c: aa1403e0    	mov	x0, x20
105f88730: aa1b03fc    	mov	x28, x27
105f88734: aa1b03e1    	mov	x1, x27
105f88738: 94727a81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8873c: aa1d03fd    	mov	x29, x29
105f88740: 94727a82    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88744: aa0003f5    	mov	x21, x0
105f88748: aa1303e0    	mov	x0, x19
105f8874c: aa1a03e1    	mov	x1, x26
105f88750: 94727a7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88754: aa0003f9    	mov	x25, x0
105f88758: aa1303e0    	mov	x0, x19
105f8875c: aa1803e1    	mov	x1, x24
105f88760: 94727a77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88764: aa0003e3    	mov	x3, x0
105f88768: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8876c: f9415101    	ldr	x1, [x8, #0x2a0] ; SendAckRequestByRoomId:andRoomKey:andContact:andAckStatus:needPreconnect:
105f88770: aa1503e0    	mov	x0, x21
105f88774: aa1903e2    	mov	x2, x25
105f88778: aa1703e4    	mov	x4, x23
105f8877c: 528000a5    	mov	w5, #0x5                ; =5
105f88780: 52800006    	mov	w6, #0x0                ; =0
105f88784: 94727a6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88788: aa1503e0    	mov	x0, x21
105f8878c: 94727a72    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88790: aa1403e0    	mov	x0, x20
105f88794: 94727a70    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88798: 1400017a    	b	0x105f88d80 <_Flutter_MMFoundation_BindContext+0x2464964>
105f8879c: 900d1088    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f887a0: f9463100    	ldr	x0, [x8, #0xc60]
105f887a4: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f887a8: f941fd01    	ldr	x1, [x8, #0x3f8] ; logicUiErrorMsgType
105f887ac: 94727a64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f887b0: 52800080    	mov	w0, #0x4                ; =4
105f887b4: 947212a3    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f887b8: 34000560    	cbz	w0, 0x105f88864 <_Flutter_MMFoundation_BindContext+0x2464448>
105f887bc: 94727a79    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f887c0: aa0003f4    	mov	x20, x0
105f887c4: f00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f887c8: f94546c0    	ldr	x0, [x22, #0xa88]
105f887cc: 94727a65    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f887d0: aa0003f5    	mov	x21, x0
105f887d4: f94546c0    	ldr	x0, [x22, #0xa88]
105f887d8: d00d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f887dc: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f887e0: f90003ff    	str	xzr, [sp]
105f887e4: b00c4162    	adrp	x2, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
105f887e8: 910e2042    	add	x2, x2, #0x388
105f887ec: 94727a54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f887f0: aa1d03fd    	mov	x29, x29
105f887f4: 94727a55    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f887f8: aa0003f6    	mov	x22, x0
105f887fc: d00d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f88800: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f88804: f00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f88808: 91362108    	add	x8, x8, #0xd88
105f8880c: a90003e8    	stp	x8, x0, [sp]
105f88810: f00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f88814: 9134a042    	add	x2, x2, #0xd28
105f88818: aa1503e0    	mov	x0, x21
105f8881c: 94727a48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88820: aa0003f5    	mov	x21, x0
105f88824: aa1603e0    	mov	x0, x22
105f88828: 94727a4b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8882c: d00acec1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f88830: 91373c21    	add	x1, x1, #0xdcf
105f88834: d00acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f88838: 9135dc42    	add	x2, x2, #0xd77
105f8883c: f00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f88840: 9138bc84    	add	x4, x4, #0xe2f
105f88844: 52800080    	mov	w0, #0x4                ; =4
105f88848: 5280a143    	mov	w3, #0x50a              ; =1290
105f8884c: aa1503e5    	mov	x5, x21
105f88850: 9472127d    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f88854: aa1503e0    	mov	x0, x21
105f88858: 94727a3f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8885c: aa1403e0    	mov	x0, x20
105f88860: 94727a53    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f88864: 52800015    	mov	w21, #0x0               ; =0
105f88868: 140003a0    	b	0x105f896e8 <_Flutter_MMFoundation_BindContext+0x24652cc>
105f8886c: 900d1088    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f88870: f9463100    	ldr	x0, [x8, #0xc60]
105f88874: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f88878: f9420101    	ldr	x1, [x8, #0x400] ; logicUiErrorInviteUserNotExist
105f8887c: 94727a30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88880: 52800080    	mov	w0, #0x4                ; =4
105f88884: 9472126f    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f88888: 34000680    	cbz	w0, 0x105f88958 <_Flutter_MMFoundation_BindContext+0x246453c>
105f8888c: 94727a45    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f88890: aa0003f5    	mov	x21, x0
105f88894: f00d0f54    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
105f88898: f9454680    	ldr	x0, [x20, #0xa88]
105f8889c: 94727a31    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f888a0: aa0003f6    	mov	x22, x0
105f888a4: f9454697    	ldr	x23, [x20, #0xa88]
105f888a8: aa1b03e0    	mov	x0, x27
105f888ac: aa1803e1    	mov	x1, x24
105f888b0: 94727a23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f888b4: aa1d03fd    	mov	x29, x29
105f888b8: 94727a24    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f888bc: aa0003f8    	mov	x24, x0
105f888c0: d00d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f888c4: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f888c8: a9007fe0    	stp	x0, xzr, [sp]
105f888cc: 900c41e2    	adrp	x2, 0x11e7c4000 <dyld_stub_binder+0x11e7c4000>
105f888d0: 911fa042    	add	x2, x2, #0x7e8
105f888d4: aa1703e0    	mov	x0, x23
105f888d8: 94727a19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f888dc: aa1d03fd    	mov	x29, x29
105f888e0: 94727a1a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f888e4: aa0003f7    	mov	x23, x0
105f888e8: d00d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f888ec: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f888f0: f00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f888f4: 91362108    	add	x8, x8, #0xd88
105f888f8: a90003e8    	stp	x8, x0, [sp]
105f888fc: f00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f88900: 9134a042    	add	x2, x2, #0xd28
105f88904: aa1603e0    	mov	x0, x22
105f88908: 94727a0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8890c: aa0003f6    	mov	x22, x0
105f88910: aa1703e0    	mov	x0, x23
105f88914: 94727a10    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88918: aa1803e0    	mov	x0, x24
105f8891c: 94727a0e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88920: d00acec1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f88924: 91373c21    	add	x1, x1, #0xdcf
105f88928: d00acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f8892c: 9135dc42    	add	x2, x2, #0xd77
105f88930: f00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f88934: 9138bc84    	add	x4, x4, #0xe2f
105f88938: 52800080    	mov	w0, #0x4                ; =4
105f8893c: 5280a223    	mov	w3, #0x511              ; =1297
105f88940: aa1603e5    	mov	x5, x22
105f88944: 94721240    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f88948: aa1603e0    	mov	x0, x22
105f8894c: 94727a02    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88950: aa1503e0    	mov	x0, x21
105f88954: 94727a16    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f88958: 52800015    	mov	w21, #0x0               ; =0
105f8895c: 14000361    	b	0x105f896e0 <_Flutter_MMFoundation_BindContext+0x24652c4>
105f88960: 900d1088    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f88964: f9463100    	ldr	x0, [x8, #0xc60]
105f88968: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8896c: f9421101    	ldr	x1, [x8, #0x420] ; logicUiErrorMsgTransformFailed
105f88970: 947279f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88974: 52800080    	mov	w0, #0x4                ; =4
105f88978: 94721232    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f8897c: 340019a0    	cbz	w0, 0x105f88cb0 <_Flutter_MMFoundation_BindContext+0x2464894>
105f88980: 94727a08    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f88984: aa0003f5    	mov	x21, x0
105f88988: f00d0f54    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
105f8898c: f9454680    	ldr	x0, [x20, #0xa88]
105f88990: 947279f4    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f88994: aa0003f6    	mov	x22, x0
105f88998: f9454680    	ldr	x0, [x20, #0xa88]
105f8899c: d00d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f889a0: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f889a4: f90003ff    	str	xzr, [sp]
105f889a8: f00c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f889ac: 9117a042    	add	x2, x2, #0x5e8
105f889b0: 947279e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f889b4: aa1d03fd    	mov	x29, x29
105f889b8: 947279e4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f889bc: aa0003f7    	mov	x23, x0
105f889c0: d00d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f889c4: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f889c8: f00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f889cc: 91362108    	add	x8, x8, #0xd88
105f889d0: a90003e8    	stp	x8, x0, [sp]
105f889d4: f00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f889d8: 9134a042    	add	x2, x2, #0xd28
105f889dc: aa1603e0    	mov	x0, x22
105f889e0: 947279d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f889e4: aa0003f6    	mov	x22, x0
105f889e8: aa1703e0    	mov	x0, x23
105f889ec: 947279da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f889f0: d00acec1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f889f4: 91373c21    	add	x1, x1, #0xdcf
105f889f8: d00acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f889fc: 9135dc42    	add	x2, x2, #0xd77
105f88a00: f00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f88a04: 9138bc84    	add	x4, x4, #0xe2f
105f88a08: 52800080    	mov	w0, #0x4                ; =4
105f88a0c: 5280a323    	mov	w3, #0x519              ; =1305
105f88a10: aa1603e5    	mov	x5, x22
105f88a14: 9472120c    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f88a18: aa1603e0    	mov	x0, x22
105f88a1c: 947279ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88a20: aa1503e0    	mov	x0, x21
105f88a24: 947279e2    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f88a28: 140000a2    	b	0x105f88cb0 <_Flutter_MMFoundation_BindContext+0x2464894>
105f88a2c: f90023f3    	str	x19, [sp, #0x40]
105f88a30: f00d0f94    	adrp	x20, 0x12017b000 <dyld_stub_binder+0x12017b000>
105f88a34: f940fe80    	ldr	x0, [x20, #0x1f8]
105f88a38: f94047f8    	ldr	x24, [sp, #0x88]
105f88a3c: aa1803e1    	mov	x1, x24
105f88a40: 947279bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88a44: aa0003e2    	mov	x2, x0
105f88a48: aa1903e0    	mov	x0, x25
105f88a4c: aa1703f3    	mov	x19, x23
105f88a50: aa1703e1    	mov	x1, x23
105f88a54: 947279ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88a58: aa1d03fd    	mov	x29, x29
105f88a5c: 947279bb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88a60: aa0003fb    	mov	x27, x0
105f88a64: b00cf7e8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
105f88a68: f9458501    	ldr	x1, [x8, #0xb08] ; getIfThisTalkIlink
105f88a6c: 947279b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88a70: b9003bf6    	str	w22, [sp, #0x38]
105f88a74: 360022e0    	tbz	w0, #0x0, 0x105f88ed0 <_Flutter_MMFoundation_BindContext+0x2464ab4>
105f88a78: f00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f88a7c: f945e900    	ldr	x0, [x8, #0xbd0]
105f88a80: aa1a03e1    	mov	x1, x26
105f88a84: 947279ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88a88: aa1d03fd    	mov	x29, x29
105f88a8c: 947279af    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88a90: aa0003f5    	mov	x21, x0
105f88a94: f940fe80    	ldr	x0, [x20, #0x1f8]
105f88a98: aa1803e1    	mov	x1, x24
105f88a9c: 947279a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88aa0: aa0003e2    	mov	x2, x0
105f88aa4: aa1503e0    	mov	x0, x21
105f88aa8: aa1303e1    	mov	x1, x19
105f88aac: 947279a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88ab0: aa1d03fd    	mov	x29, x29
105f88ab4: 947279a5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88ab8: aa0003f4    	mov	x20, x0
105f88abc: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f88ac0: f9422101    	ldr	x1, [x8, #0x440] ; remoteContact
105f88ac4: 9472799e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88ac8: aa1d03fd    	mov	x29, x29
105f88acc: 9472799f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88ad0: aa0003fc    	mov	x28, x0
105f88ad4: f00cf588    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105f88ad8: f9434d1a    	ldr	x26, [x8, #0x698] ; m_nsUsrName
105f88adc: aa1a03e1    	mov	x1, x26
105f88ae0: 94727997    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88ae4: aa1d03fd    	mov	x29, x29
105f88ae8: 94727998    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88aec: aa0003f6    	mov	x22, x0
105f88af0: f94043e0    	ldr	x0, [sp, #0x80]
105f88af4: aa1a03e1    	mov	x1, x26
105f88af8: 94727991    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88afc: aa1d03fd    	mov	x29, x29
105f88b00: 94727992    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88b04: aa0003fa    	mov	x26, x0
105f88b08: f00d0bc8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105f88b0c: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
105f88b10: aa1603e0    	mov	x0, x22
105f88b14: aa1a03e2    	mov	x2, x26
105f88b18: 94727989    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88b1c: aa0003f7    	mov	x23, x0
105f88b20: aa1a03e0    	mov	x0, x26
105f88b24: 9472798c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88b28: aa1603e0    	mov	x0, x22
105f88b2c: 9472798a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88b30: aa1c03e0    	mov	x0, x28
105f88b34: 94727988    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88b38: aa1403e0    	mov	x0, x20
105f88b3c: 94727986    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88b40: aa1503e0    	mov	x0, x21
105f88b44: 94727984    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88b48: aa1b03e0    	mov	x0, x27
105f88b4c: 94727982    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88b50: aa1903e0    	mov	x0, x25
105f88b54: 94727980    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88b58: f9403bf9    	ldr	x25, [sp, #0x70]
105f88b5c: 34001c57    	cbz	w23, 0x105f88ee4 <_Flutter_MMFoundation_BindContext+0x2464ac8>
105f88b60: 52800040    	mov	w0, #0x2                ; =2
105f88b64: 947211b7    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f88b68: a947f3fb    	ldp	x27, x28, [sp, #0x78]
105f88b6c: 34000560    	cbz	w0, 0x105f88c18 <_Flutter_MMFoundation_BindContext+0x24647fc>
105f88b70: 9472798c    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f88b74: aa0003f4    	mov	x20, x0
105f88b78: f00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f88b7c: f94546c0    	ldr	x0, [x22, #0xa88]
105f88b80: 94727978    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f88b84: aa0003f5    	mov	x21, x0
105f88b88: f94546c0    	ldr	x0, [x22, #0xa88]
105f88b8c: d00d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f88b90: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f88b94: f90003ff    	str	xzr, [sp]
105f88b98: f00c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f88b9c: 91192042    	add	x2, x2, #0x648
105f88ba0: 94727967    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88ba4: aa1d03fd    	mov	x29, x29
105f88ba8: 94727968    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88bac: aa0003f6    	mov	x22, x0
105f88bb0: d00d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f88bb4: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f88bb8: f00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f88bbc: 91352108    	add	x8, x8, #0xd48
105f88bc0: a90003e8    	stp	x8, x0, [sp]
105f88bc4: f00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f88bc8: 9134a042    	add	x2, x2, #0xd28
105f88bcc: aa1503e0    	mov	x0, x21
105f88bd0: 9472795b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88bd4: aa0003f5    	mov	x21, x0
105f88bd8: aa1603e0    	mov	x0, x22
105f88bdc: 9472795e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88be0: b00a9461    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
105f88be4: 9124e421    	add	x1, x1, #0x939
105f88be8: d00acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f88bec: 9135dc42    	add	x2, x2, #0xd77
105f88bf0: f00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f88bf4: 9138bc84    	add	x4, x4, #0xe2f
105f88bf8: 52800040    	mov	w0, #0x2                ; =2
105f88bfc: 5280a803    	mov	w3, #0x540              ; =1344
105f88c00: aa1503e5    	mov	x5, x21
105f88c04: 94721190    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f88c08: aa1503e0    	mov	x0, x21
105f88c0c: 94727952    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88c10: aa1403e0    	mov	x0, x20
105f88c14: 94727966    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f88c18: f00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f88c1c: f945e900    	ldr	x0, [x8, #0xbd0]
105f88c20: f9404be1    	ldr	x1, [sp, #0x90]
105f88c24: 94727946    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88c28: aa1d03fd    	mov	x29, x29
105f88c2c: 94727947    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88c30: aa0003f4    	mov	x20, x0
105f88c34: 900d1088    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f88c38: f9463900    	ldr	x0, [x8, #0xc70]
105f88c3c: aa1803e1    	mov	x1, x24
105f88c40: 9472793f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88c44: aa0003e2    	mov	x2, x0
105f88c48: aa1403e0    	mov	x0, x20
105f88c4c: aa1303e1    	mov	x1, x19
105f88c50: 9472793b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88c54: aa1d03fd    	mov	x29, x29
105f88c58: 9472793c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88c5c: aa0003f5    	mov	x21, x0
105f88c60: aa1b03e0    	mov	x0, x27
105f88c64: f94023e1    	ldr	x1, [sp, #0x40]
105f88c68: 94727935    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88c6c: aa0003f6    	mov	x22, x0
105f88c70: aa1b03e0    	mov	x0, x27
105f88c74: f94037e1    	ldr	x1, [sp, #0x68]
105f88c78: 94727931    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88c7c: aa0003e3    	mov	x3, x0
105f88c80: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f88c84: f9415101    	ldr	x1, [x8, #0x2a0] ; SendAckRequestByRoomId:andRoomKey:andContact:andAckStatus:needPreconnect:
105f88c88: aa1503e0    	mov	x0, x21
105f88c8c: aa1603e2    	mov	x2, x22
105f88c90: aa1c03e4    	mov	x4, x28
105f88c94: 52800045    	mov	w5, #0x2                ; =2
105f88c98: 52800006    	mov	w6, #0x0                ; =0
105f88c9c: 94727928    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88ca0: aa1503e0    	mov	x0, x21
105f88ca4: 9472792c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88ca8: aa1403e0    	mov	x0, x20
105f88cac: 9472792a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88cb0: 52800015    	mov	w21, #0x0               ; =0
105f88cb4: 14000289    	b	0x105f896d8 <_Flutter_MMFoundation_BindContext+0x24652bc>
105f88cb8: aa1b03fc    	mov	x28, x27
105f88cbc: f9403ff3    	ldr	x19, [sp, #0x78]
105f88cc0: f94037f8    	ldr	x24, [sp, #0x68]
105f88cc4: 340005e0    	cbz	w0, 0x105f88d80 <_Flutter_MMFoundation_BindContext+0x2464964>
105f88cc8: 94727936    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f88ccc: aa0003f5    	mov	x21, x0
105f88cd0: f00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f88cd4: f94546c0    	ldr	x0, [x22, #0xa88]
105f88cd8: 94727922    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f88cdc: aa0003f4    	mov	x20, x0
105f88ce0: f94546d9    	ldr	x25, [x22, #0xa88]
105f88ce4: aa1303e0    	mov	x0, x19
105f88ce8: aa1a03e1    	mov	x1, x26
105f88cec: 94727914    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88cf0: d00d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f88cf4: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f88cf8: a9007fe0    	stp	x0, xzr, [sp]
105f88cfc: f00c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f88d00: 9118a042    	add	x2, x2, #0x628
105f88d04: aa1903e0    	mov	x0, x25
105f88d08: 9472790d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88d0c: aa1d03fd    	mov	x29, x29
105f88d10: 9472790e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88d14: aa0003f9    	mov	x25, x0
105f88d18: d00d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f88d1c: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f88d20: f00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f88d24: 91352108    	add	x8, x8, #0xd48
105f88d28: a90003e8    	stp	x8, x0, [sp]
105f88d2c: f00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f88d30: 9134a042    	add	x2, x2, #0xd28
105f88d34: aa1403e0    	mov	x0, x20
105f88d38: 94727901    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88d3c: aa0003f4    	mov	x20, x0
105f88d40: aa1903e0    	mov	x0, x25
105f88d44: 94727904    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88d48: d00acec1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f88d4c: 91373c21    	add	x1, x1, #0xdcf
105f88d50: d00acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f88d54: 9135dc42    	add	x2, x2, #0xd77
105f88d58: f00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f88d5c: 9138bc84    	add	x4, x4, #0xe2f
105f88d60: 52800040    	mov	w0, #0x2                ; =2
105f88d64: 5280a603    	mov	w3, #0x530              ; =1328
105f88d68: aa1403e5    	mov	x5, x20
105f88d6c: 94721136    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f88d70: aa1403e0    	mov	x0, x20
105f88d74: 947278f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88d78: aa1503e0    	mov	x0, x21
105f88d7c: 9472790c    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f88d80: d00d0f68    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
105f88d84: f9421508    	ldr	x8, [x8, #0x428]
105f88d88: f90037e8    	str	x8, [sp, #0x68]
105f88d8c: aa1303e0    	mov	x0, x19
105f88d90: aa1a03e1    	mov	x1, x26
105f88d94: 947278ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88d98: aa0003fa    	mov	x26, x0
105f88d9c: aa1303e0    	mov	x0, x19
105f88da0: aa1803e1    	mov	x1, x24
105f88da4: 947278e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88da8: aa0003fb    	mov	x27, x0
105f88dac: f00d0f57    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
105f88db0: f945eae0    	ldr	x0, [x23, #0xbd0]
105f88db4: f9404bf6    	ldr	x22, [sp, #0x90]
105f88db8: aa1603e1    	mov	x1, x22
105f88dbc: 947278e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88dc0: aa1d03fd    	mov	x29, x29
105f88dc4: 947278e1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88dc8: aa0003f5    	mov	x21, x0
105f88dcc: f00d0f58    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
105f88dd0: f9472f00    	ldr	x0, [x24, #0xe58]
105f88dd4: f94047f3    	ldr	x19, [sp, #0x88]
105f88dd8: aa1303e1    	mov	x1, x19
105f88ddc: 947278d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88de0: aa0003e2    	mov	x2, x0
105f88de4: aa1503e0    	mov	x0, x21
105f88de8: aa1c03f9    	mov	x25, x28
105f88dec: aa1c03e1    	mov	x1, x28
105f88df0: 947278d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88df4: aa1d03fd    	mov	x29, x29
105f88df8: 947278d4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88dfc: aa0003fc    	mov	x28, x0
105f88e00: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f88e04: f9415501    	ldr	x1, [x8, #0x2a8] ; mVoIPType
105f88e08: 947278cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88e0c: aa0003f4    	mov	x20, x0
105f88e10: f945eae0    	ldr	x0, [x23, #0xbd0]
105f88e14: aa1603e1    	mov	x1, x22
105f88e18: 947278c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88e1c: aa1d03fd    	mov	x29, x29
105f88e20: 947278ca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88e24: aa0003f6    	mov	x22, x0
105f88e28: f9472f00    	ldr	x0, [x24, #0xe58]
105f88e2c: aa1303e1    	mov	x1, x19
105f88e30: 947278c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88e34: aa0003e2    	mov	x2, x0
105f88e38: aa1603e0    	mov	x0, x22
105f88e3c: aa1903e1    	mov	x1, x25
105f88e40: 947278bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88e44: aa1d03fd    	mov	x29, x29
105f88e48: 947278c0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88e4c: aa0003f7    	mov	x23, x0
105f88e50: 900cf928    	adrp	x8, 0x11feac000 <dyld_stub_binder+0x11feac000>
105f88e54: f9420101    	ldr	x1, [x8, #0x400] ; GetNetType
105f88e58: 947278b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88e5c: aa0003e6    	mov	x6, x0
105f88e60: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f88e64: f9415901    	ldr	x1, [x8, #0x2b0] ; ReportPushUIReportWithRoomId:WithRoomKey:WithRoomType:WithAckStatus:WithNetType:WithTimeStamp:
105f88e68: f94037e0    	ldr	x0, [sp, #0x68]
105f88e6c: aa1a03e2    	mov	x2, x26
105f88e70: aa1b03e3    	mov	x3, x27
105f88e74: f9403ffb    	ldr	x27, [sp, #0x78]
105f88e78: aa1403e4    	mov	x4, x20
105f88e7c: 528000a5    	mov	w5, #0x5                ; =5
105f88e80: f9402fe7    	ldr	x7, [sp, #0x58]
105f88e84: 947278ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88e88: aa1703e0    	mov	x0, x23
105f88e8c: 947278b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88e90: aa1603e0    	mov	x0, x22
105f88e94: 947278b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88e98: aa1c03e0    	mov	x0, x28
105f88e9c: 947278ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88ea0: aa1503e0    	mov	x0, x21
105f88ea4: 947278ac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88ea8: d00d1048    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
105f88eac: f9479900    	ldr	x0, [x8, #0xf30]
105f88eb0: d00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f88eb4: f9415d01    	ldr	x1, [x8, #0x2b8] ; reportAckWithCallResult:ByVoipMsg:
105f88eb8: 52800202    	mov	w2, #0x10               ; =16
105f88ebc: aa1b03e3    	mov	x3, x27
105f88ec0: 9472789f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88ec4: 52800015    	mov	w21, #0x0               ; =0
105f88ec8: f94043fc    	ldr	x28, [sp, #0x80]
105f88ecc: 14000202    	b	0x105f896d4 <_Flutter_MMFoundation_BindContext+0x24652b8>
105f88ed0: aa1b03e0    	mov	x0, x27
105f88ed4: 947278a0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88ed8: aa1903e0    	mov	x0, x25
105f88edc: 9472789e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88ee0: f9403bf9    	ldr	x25, [sp, #0x70]
105f88ee4: f00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f88ee8: f9002bf3    	str	x19, [sp, #0x50]
105f88eec: aa1803f3    	mov	x19, x24
105f88ef0: aa0803f8    	mov	x24, x8
105f88ef4: f945e900    	ldr	x0, [x8, #0xbd0]
105f88ef8: f9404bf7    	ldr	x23, [sp, #0x90]
105f88efc: aa1703e1    	mov	x1, x23
105f88f00: 9472788f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88f04: aa1d03fd    	mov	x29, x29
105f88f08: 94727890    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88f0c: aa0003f4    	mov	x20, x0
105f88f10: f00d0ff6    	adrp	x22, 0x120187000 <dyld_stub_binder+0x120187000>
105f88f14: f943a6c0    	ldr	x0, [x22, #0x748]
105f88f18: aa1303e1    	mov	x1, x19
105f88f1c: 94727888    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88f20: aa0003e2    	mov	x2, x0
105f88f24: aa1403e0    	mov	x0, x20
105f88f28: f9402be1    	ldr	x1, [sp, #0x50]
105f88f2c: 94727884    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88f30: aa1d03fd    	mov	x29, x29
105f88f34: 94727885    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88f38: aa0003f5    	mov	x21, x0
105f88f3c: b00cf928    	adrp	x8, 0x11fead000 <dyld_stub_binder+0x11fead000>
105f88f40: f9400901    	ldr	x1, [x8, #0x10] ; startCheck
105f88f44: 9472787e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88f48: aa1503e0    	mov	x0, x21
105f88f4c: 94727882    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88f50: aa1403e0    	mov	x0, x20
105f88f54: 94727880    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88f58: f945eb00    	ldr	x0, [x24, #0xbd0]
105f88f5c: f9402bf8    	ldr	x24, [sp, #0x50]
105f88f60: aa1703e1    	mov	x1, x23
105f88f64: 94727876    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88f68: aa1d03fd    	mov	x29, x29
105f88f6c: 94727877    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88f70: aa0003f4    	mov	x20, x0
105f88f74: f943a6c0    	ldr	x0, [x22, #0x748]
105f88f78: aa1303e1    	mov	x1, x19
105f88f7c: f94027f3    	ldr	x19, [sp, #0x48]
105f88f80: 9472786f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88f84: aa0003e2    	mov	x2, x0
105f88f88: aa1403e0    	mov	x0, x20
105f88f8c: aa1803e1    	mov	x1, x24
105f88f90: 9472786b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88f94: aa1d03fd    	mov	x29, x29
105f88f98: 9472786c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f88f9c: aa0003f5    	mov	x21, x0
105f88fa0: b00cfb68    	adrp	x8, 0x11fef5000 <dyld_stub_binder+0x11fef5000>
105f88fa4: f9472901    	ldr	x1, [x8, #0xe50] ; isPhoneCalling
105f88fa8: 94727865    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88fac: aa0003f6    	mov	x22, x0
105f88fb0: aa1503e0    	mov	x0, x21
105f88fb4: 94727868    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88fb8: aa1403e0    	mov	x0, x20
105f88fbc: 94727866    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f88fc0: a947f3fb    	ldp	x27, x28, [sp, #0x78]
105f88fc4: 34002196    	cbz	w22, 0x105f893f4 <_Flutter_MMFoundation_BindContext+0x2464fd8>
105f88fc8: f00d0ff5    	adrp	x21, 0x120187000 <dyld_stub_binder+0x120187000>
105f88fcc: f943aab4    	ldr	x20, [x21, #0x750]
105f88fd0: aa1b03e0    	mov	x0, x27
105f88fd4: aa1303e1    	mov	x1, x19
105f88fd8: 94727859    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88fdc: 7100001f    	cmp	w0, #0x0
105f88fe0: 1a9f17e2    	cset	w2, eq
105f88fe4: b00d0068    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
105f88fe8: f9407901    	ldr	x1, [x8, #0xf0] ; getIfCanUseCX:isMultiTalk:
105f88fec: aa1403e0    	mov	x0, x20
105f88ff0: 52800003    	mov	w3, #0x0                ; =0
105f88ff4: 94727852    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f88ff8: 340000c0    	cbz	w0, 0x105f89010 <_Flutter_MMFoundation_BindContext+0x2464bf4>
105f88ffc: f943aaa0    	ldr	x0, [x21, #0x750]
105f89000: 900d0068    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
105f89004: f9407501    	ldr	x1, [x8, #0xe8] ; isAppStateActive
105f89008: 9472784d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8900c: 34001f40    	cbz	w0, 0x105f893f4 <_Flutter_MMFoundation_BindContext+0x2464fd8>
105f89010: f00d1068    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f89014: f9463100    	ldr	x0, [x8, #0xc60]
105f89018: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8901c: f9422501    	ldr	x1, [x8, #0x448] ; logicUiErrorPhoneCalling
105f89020: 94727847    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89024: 52800040    	mov	w0, #0x2                ; =2
105f89028: 94721086    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f8902c: 34000560    	cbz	w0, 0x105f890d8 <_Flutter_MMFoundation_BindContext+0x2464cbc>
105f89030: 9472785c    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f89034: aa0003f4    	mov	x20, x0
105f89038: d00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f8903c: f94546c0    	ldr	x0, [x22, #0xa88]
105f89040: 94727848    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f89044: aa0003f5    	mov	x21, x0
105f89048: f94546c0    	ldr	x0, [x22, #0xa88]
105f8904c: b00d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f89050: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f89054: f90003ff    	str	xzr, [sp]
105f89058: d00c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f8905c: 9119a042    	add	x2, x2, #0x668
105f89060: 94727837    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89064: aa1d03fd    	mov	x29, x29
105f89068: 94727838    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8906c: aa0003f6    	mov	x22, x0
105f89070: b00d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f89074: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f89078: d00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f8907c: 91352108    	add	x8, x8, #0xd48
105f89080: a90003e8    	stp	x8, x0, [sp]
105f89084: d00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f89088: 9134a042    	add	x2, x2, #0xd28
105f8908c: aa1503e0    	mov	x0, x21
105f89090: 9472782b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89094: aa0003f5    	mov	x21, x0
105f89098: aa1603e0    	mov	x0, x22
105f8909c: 9472782e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f890a0: b00acec1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f890a4: 91373c21    	add	x1, x1, #0xdcf
105f890a8: b00acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f890ac: 9135dc42    	add	x2, x2, #0xd77
105f890b0: d00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f890b4: 9138bc84    	add	x4, x4, #0xe2f
105f890b8: 52800040    	mov	w0, #0x2                ; =2
105f890bc: 5280aa83    	mov	w3, #0x554              ; =1364
105f890c0: aa1503e5    	mov	x5, x21
105f890c4: 94721060    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f890c8: aa1503e0    	mov	x0, x21
105f890cc: 94727822    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f890d0: aa1403e0    	mov	x0, x20
105f890d4: 94727836    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f890d8: d00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f890dc: f945e900    	ldr	x0, [x8, #0xbd0]
105f890e0: aa0803f3    	mov	x19, x8
105f890e4: aa1703e1    	mov	x1, x23
105f890e8: 94727815    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f890ec: aa1d03fd    	mov	x29, x29
105f890f0: 94727816    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f890f4: aa0003f4    	mov	x20, x0
105f890f8: b00d0f48    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
105f890fc: f942e115    	ldr	x21, [x8, #0x5c0]
105f89100: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89104: f9422916    	ldr	x22, [x8, #0x450] ; onVoIPMessageMgrRejectCallBecasueOfPhoneCallingWithRoomID:roomKey:
105f89108: b00bb328    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
105f8910c: f947e108    	ldr	x8, [x8, #0xfc0]
105f89110: f81703a8    	stur	x8, [x29, #-0x90]
105f89114: 90096fc8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
105f89118: fd41c100    	ldr	d0, [x8, #0x380]
105f8911c: fc1783a0    	stur	d0, [x29, #-0x88]
105f89120: b0000008    	adrp	x8, 0x105f8a000 <_Flutter_MMFoundation_BindContext+0x2465be4>
105f89124: 91126108    	add	x8, x8, #0x498
105f89128: b00bb369    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
105f8912c: 91238129    	add	x9, x9, #0x8e0
105f89130: a93827a8    	stp	x8, x9, [x29, #-0x80]
105f89134: aa1b03e0    	mov	x0, x27
105f89138: 94727800    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105f8913c: f81903bb    	stur	x27, [x29, #-0x70]
105f89140: b00cf588    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105f89144: f940d501    	ldr	x1, [x8, #0x1a8] ; callExtensionOnMainThread:selector:sync:block:
105f89148: d10243a5    	sub	x5, x29, #0x90
105f8914c: aa1403e0    	mov	x0, x20
105f89150: aa1503e2    	mov	x2, x21
105f89154: aa1603e3    	mov	x3, x22
105f89158: 52800024    	mov	w4, #0x1                ; =1
105f8915c: 947277f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89160: aa1403e0    	mov	x0, x20
105f89164: 947277fc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89168: f85903a0    	ldur	x0, [x29, #-0x70]
105f8916c: 947277fa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89170: f945ea60    	ldr	x0, [x19, #0xbd0]
105f89174: aa1703e1    	mov	x1, x23
105f89178: 947277f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8917c: aa1d03fd    	mov	x29, x29
105f89180: 947277f2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89184: aa0003f4    	mov	x20, x0
105f89188: f00d1068    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f8918c: f9463900    	ldr	x0, [x8, #0xc70]
105f89190: f94047f3    	ldr	x19, [sp, #0x88]
105f89194: aa1303e1    	mov	x1, x19
105f89198: 947277e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8919c: aa0003e2    	mov	x2, x0
105f891a0: aa1403e0    	mov	x0, x20
105f891a4: aa1803e1    	mov	x1, x24
105f891a8: 947277e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f891ac: aa1d03fd    	mov	x29, x29
105f891b0: 947277e6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f891b4: aa0003f5    	mov	x21, x0
105f891b8: aa1b03e0    	mov	x0, x27
105f891bc: f94023f9    	ldr	x25, [sp, #0x40]
105f891c0: aa1903e1    	mov	x1, x25
105f891c4: 947277de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f891c8: aa0003f6    	mov	x22, x0
105f891cc: aa1b03e0    	mov	x0, x27
105f891d0: f94037fa    	ldr	x26, [sp, #0x68]
105f891d4: aa1a03e1    	mov	x1, x26
105f891d8: 947277d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f891dc: aa0003e3    	mov	x3, x0
105f891e0: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f891e4: f9415101    	ldr	x1, [x8, #0x2a0] ; SendAckRequestByRoomId:andRoomKey:andContact:andAckStatus:needPreconnect:
105f891e8: aa1503e0    	mov	x0, x21
105f891ec: aa1603e2    	mov	x2, x22
105f891f0: aa1c03e4    	mov	x4, x28
105f891f4: 52800065    	mov	w5, #0x3                ; =3
105f891f8: 52800006    	mov	w6, #0x0                ; =0
105f891fc: 947277d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89200: aa1503e0    	mov	x0, x21
105f89204: 947277d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89208: aa1403e0    	mov	x0, x20
105f8920c: 947277d2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89210: b00d0f68    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
105f89214: f9421508    	ldr	x8, [x8, #0x428]
105f89218: f90033e8    	str	x8, [sp, #0x60]
105f8921c: aa1b03e0    	mov	x0, x27
105f89220: aa1903e1    	mov	x1, x25
105f89224: 947277c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89228: f90027e0    	str	x0, [sp, #0x48]
105f8922c: aa1b03e0    	mov	x0, x27
105f89230: aa1a03e1    	mov	x1, x26
105f89234: 947277c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89238: aa0003fb    	mov	x27, x0
105f8923c: d00d0f5a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
105f89240: f945eb40    	ldr	x0, [x26, #0xbd0]
105f89244: aa1703e1    	mov	x1, x23
105f89248: 947277bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8924c: aa1d03fd    	mov	x29, x29
105f89250: 947277be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89254: aa0003f5    	mov	x21, x0
105f89258: d00d0f59    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
105f8925c: f9472f20    	ldr	x0, [x25, #0xe58]
105f89260: aa1303e1    	mov	x1, x19
105f89264: 947277b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89268: aa0003e2    	mov	x2, x0
105f8926c: aa1503e0    	mov	x0, x21
105f89270: aa1803e1    	mov	x1, x24
105f89274: 947277b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89278: aa1d03fd    	mov	x29, x29
105f8927c: 947277b3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89280: aa0003fc    	mov	x28, x0
105f89284: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89288: f9415501    	ldr	x1, [x8, #0x2a8] ; mVoIPType
105f8928c: 947277ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89290: aa0003f4    	mov	x20, x0
105f89294: f945eb40    	ldr	x0, [x26, #0xbd0]
105f89298: aa1703e1    	mov	x1, x23
105f8929c: 947277a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f892a0: aa1d03fd    	mov	x29, x29
105f892a4: 947277a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f892a8: aa0003f6    	mov	x22, x0
105f892ac: f9472f20    	ldr	x0, [x25, #0xe58]
105f892b0: aa1303e1    	mov	x1, x19
105f892b4: 947277a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f892b8: aa0003e2    	mov	x2, x0
105f892bc: aa1603e0    	mov	x0, x22
105f892c0: aa1803e1    	mov	x1, x24
105f892c4: 9472779e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f892c8: aa1d03fd    	mov	x29, x29
105f892cc: 9472779f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f892d0: aa1703f9    	mov	x25, x23
105f892d4: aa0003f7    	mov	x23, x0
105f892d8: f00cf908    	adrp	x8, 0x11feac000 <dyld_stub_binder+0x11feac000>
105f892dc: f9420101    	ldr	x1, [x8, #0x400] ; GetNetType
105f892e0: 94727797    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f892e4: aa0003e6    	mov	x6, x0
105f892e8: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f892ec: f9415901    	ldr	x1, [x8, #0x2b0] ; ReportPushUIReportWithRoomId:WithRoomKey:WithRoomType:WithAckStatus:WithNetType:WithTimeStamp:
105f892f0: a94583e7    	ldp	x7, x0, [sp, #0x58]
105f892f4: f94027e2    	ldr	x2, [sp, #0x48]
105f892f8: aa1b03e3    	mov	x3, x27
105f892fc: f9403ffb    	ldr	x27, [sp, #0x78]
105f89300: aa1403e4    	mov	x4, x20
105f89304: 52800065    	mov	w5, #0x3                ; =3
105f89308: 9472778d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8930c: aa1703e0    	mov	x0, x23
105f89310: 94727791    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89314: aa1603e0    	mov	x0, x22
105f89318: 9472778f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8931c: aa1c03e0    	mov	x0, x28
105f89320: f94043fc    	ldr	x28, [sp, #0x80]
105f89324: 9472778c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89328: aa1503e0    	mov	x0, x21
105f8932c: 9472778a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89330: b00d1054    	adrp	x20, 0x120192000 <dyld_stub_binder+0x120192000>
105f89334: f9479a80    	ldr	x0, [x20, #0xf30]
105f89338: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8933c: f9415d01    	ldr	x1, [x8, #0x2b8] ; reportAckWithCallResult:ByVoipMsg:
105f89340: 528001a2    	mov	w2, #0xd                ; =13
105f89344: aa1b03e3    	mov	x3, x27
105f89348: 9472777d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8934c: f9479a80    	ldr	x0, [x20, #0xf30]
105f89350: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89354: f9416101    	ldr	x1, [x8, #0x2c0] ; handleVoipLocalBusy:
105f89358: aa1b03e2    	mov	x2, x27
105f8935c: 94727778    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89360: f00d0ba8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105f89364: f9431501    	ldr	x1, [x8, #0x628] ; copy
105f89368: aa1b03e0    	mov	x0, x27
105f8936c: 94727774    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89370: aa0003f4    	mov	x20, x0
105f89374: 900cf768    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
105f89378: f942fd01    	ldr	x1, [x8, #0x5f8] ; setM_msgType:
105f8937c: 52800102    	mov	w2, #0x8                ; =8
105f89380: 9472776f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89384: f945eb40    	ldr	x0, [x26, #0xbd0]
105f89388: aa1903e1    	mov	x1, x25
105f8938c: 9472776c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89390: aa1d03fd    	mov	x29, x29
105f89394: 9472776d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89398: aa0003f5    	mov	x21, x0
105f8939c: d00d1028    	adrp	x8, 0x12018f000 <dyld_stub_binder+0x12018f000>
105f893a0: f9473900    	ldr	x0, [x8, #0xe70]
105f893a4: aa1303e1    	mov	x1, x19
105f893a8: 94727765    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f893ac: aa0003e2    	mov	x2, x0
105f893b0: aa1503e0    	mov	x0, x21
105f893b4: aa1803e1    	mov	x1, x24
105f893b8: 94727761    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f893bc: aa1d03fd    	mov	x29, x29
105f893c0: 94727762    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f893c4: aa0003f6    	mov	x22, x0
105f893c8: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f893cc: f9416501    	ldr	x1, [x8, #0x2c8] ; addCancelHistory:
105f893d0: aa1403e2    	mov	x2, x20
105f893d4: 9472775a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f893d8: aa1603e0    	mov	x0, x22
105f893dc: 9472775e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f893e0: aa1503e0    	mov	x0, x21
105f893e4: 9472775c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f893e8: aa1403e0    	mov	x0, x20
105f893ec: 9472775a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f893f0: 140000b8    	b	0x105f896d0 <_Flutter_MMFoundation_BindContext+0x24652b4>
105f893f4: aa1b03e0    	mov	x0, x27
105f893f8: aa1303e1    	mov	x1, x19
105f893fc: 94727750    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89400: 7100041f    	cmp	w0, #0x1
105f89404: 540018a0    	b.eq	0x105f89718 <_Flutter_MMFoundation_BindContext+0x24652fc>
105f89408: aa1b03e0    	mov	x0, x27
105f8940c: aa1303e1    	mov	x1, x19
105f89410: 9472774b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89414: 34001820    	cbz	w0, 0x105f89718 <_Flutter_MMFoundation_BindContext+0x24652fc>
105f89418: f00d1068    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f8941c: f9463100    	ldr	x0, [x8, #0xc60]
105f89420: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89424: f9422d01    	ldr	x1, [x8, #0x458] ; logicUiErrorInviteType
105f89428: 94727745    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8942c: 52800040    	mov	w0, #0x2                ; =2
105f89430: 94720f84    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f89434: 340005e0    	cbz	w0, 0x105f894f0 <_Flutter_MMFoundation_BindContext+0x24650d4>
105f89438: 9472775a    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f8943c: aa0003f5    	mov	x21, x0
105f89440: d00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f89444: f94546c0    	ldr	x0, [x22, #0xa88]
105f89448: 94727746    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f8944c: aa0003f4    	mov	x20, x0
105f89450: f94546d6    	ldr	x22, [x22, #0xa88]
105f89454: aa1b03e0    	mov	x0, x27
105f89458: aa1303e1    	mov	x1, x19
105f8945c: 94727738    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89460: b00d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f89464: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f89468: a9007fe0    	stp	x0, xzr, [sp]
105f8946c: d00c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f89470: 911a2042    	add	x2, x2, #0x688
105f89474: aa1603e0    	mov	x0, x22
105f89478: 94727731    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8947c: aa1d03fd    	mov	x29, x29
105f89480: 94727732    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89484: aa0003f6    	mov	x22, x0
105f89488: b00d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f8948c: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f89490: d00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f89494: 91352108    	add	x8, x8, #0xd48
105f89498: a90003e8    	stp	x8, x0, [sp]
105f8949c: d00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f894a0: 9134a042    	add	x2, x2, #0xd28
105f894a4: aa1403e0    	mov	x0, x20
105f894a8: 94727725    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f894ac: aa0003f4    	mov	x20, x0
105f894b0: aa1603e0    	mov	x0, x22
105f894b4: 94727728    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f894b8: b00acec1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f894bc: 91373c21    	add	x1, x1, #0xdcf
105f894c0: b00acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f894c4: 9135dc42    	add	x2, x2, #0xd77
105f894c8: d00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f894cc: 9138bc84    	add	x4, x4, #0xe2f
105f894d0: 52800040    	mov	w0, #0x2                ; =2
105f894d4: 5280aec3    	mov	w3, #0x576              ; =1398
105f894d8: aa1403e5    	mov	x5, x20
105f894dc: 94720f5a    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f894e0: aa1403e0    	mov	x0, x20
105f894e4: 9472771c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f894e8: aa1503e0    	mov	x0, x21
105f894ec: 94727730    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f894f0: d00d0f58    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
105f894f4: f945eb00    	ldr	x0, [x24, #0xbd0]
105f894f8: aa1703e1    	mov	x1, x23
105f894fc: 94727710    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89500: aa1d03fd    	mov	x29, x29
105f89504: 94727711    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89508: aa0003f4    	mov	x20, x0
105f8950c: f00d1068    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f89510: f9463900    	ldr	x0, [x8, #0xc70]
105f89514: f94047f8    	ldr	x24, [sp, #0x88]
105f89518: aa1803e1    	mov	x1, x24
105f8951c: 94727708    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89520: aa0003e2    	mov	x2, x0
105f89524: aa1403e0    	mov	x0, x20
105f89528: f9402bf3    	ldr	x19, [sp, #0x50]
105f8952c: aa1303e1    	mov	x1, x19
105f89530: 94727703    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89534: aa1d03fd    	mov	x29, x29
105f89538: 94727704    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8953c: aa0003f5    	mov	x21, x0
105f89540: aa1b03e0    	mov	x0, x27
105f89544: f94023f9    	ldr	x25, [sp, #0x40]
105f89548: aa1903e1    	mov	x1, x25
105f8954c: 947276fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89550: aa0003f6    	mov	x22, x0
105f89554: aa1b03e0    	mov	x0, x27
105f89558: f94037fa    	ldr	x26, [sp, #0x68]
105f8955c: aa1a03e1    	mov	x1, x26
105f89560: 947276f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89564: aa0003e3    	mov	x3, x0
105f89568: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8956c: f9415101    	ldr	x1, [x8, #0x2a0] ; SendAckRequestByRoomId:andRoomKey:andContact:andAckStatus:needPreconnect:
105f89570: aa1503e0    	mov	x0, x21
105f89574: aa1603e2    	mov	x2, x22
105f89578: aa1c03e4    	mov	x4, x28
105f8957c: 52800085    	mov	w5, #0x4                ; =4
105f89580: 52800006    	mov	w6, #0x0                ; =0
105f89584: 947276ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89588: aa1503e0    	mov	x0, x21
105f8958c: 947276f2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89590: aa1403e0    	mov	x0, x20
105f89594: 947276f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89598: b00d0f68    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
105f8959c: f9421508    	ldr	x8, [x8, #0x428]
105f895a0: f90033e8    	str	x8, [sp, #0x60]
105f895a4: aa1b03e0    	mov	x0, x27
105f895a8: aa1903e1    	mov	x1, x25
105f895ac: 947276e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f895b0: f90027e0    	str	x0, [sp, #0x48]
105f895b4: aa1b03e0    	mov	x0, x27
105f895b8: aa1a03e1    	mov	x1, x26
105f895bc: 947276e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f895c0: aa0003fb    	mov	x27, x0
105f895c4: d00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f895c8: f945eac0    	ldr	x0, [x22, #0xbd0]
105f895cc: aa1703e1    	mov	x1, x23
105f895d0: 947276db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f895d4: aa1d03fd    	mov	x29, x29
105f895d8: 947276dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f895dc: aa0003f5    	mov	x21, x0
105f895e0: d00d0f59    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
105f895e4: f9472f20    	ldr	x0, [x25, #0xe58]
105f895e8: aa1803e1    	mov	x1, x24
105f895ec: 947276d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f895f0: aa0003e2    	mov	x2, x0
105f895f4: aa1503e0    	mov	x0, x21
105f895f8: aa1303e1    	mov	x1, x19
105f895fc: 947276d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89600: aa1d03fd    	mov	x29, x29
105f89604: 947276d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89608: aa0003fc    	mov	x28, x0
105f8960c: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89610: f9415501    	ldr	x1, [x8, #0x2a8] ; mVoIPType
105f89614: 947276ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89618: aa0003f4    	mov	x20, x0
105f8961c: f945eac0    	ldr	x0, [x22, #0xbd0]
105f89620: aa1703e1    	mov	x1, x23
105f89624: 947276c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89628: aa1d03fd    	mov	x29, x29
105f8962c: 947276c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89630: aa0003f6    	mov	x22, x0
105f89634: f9472f20    	ldr	x0, [x25, #0xe58]
105f89638: aa1803e1    	mov	x1, x24
105f8963c: 947276c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89640: aa0003e2    	mov	x2, x0
105f89644: aa1603e0    	mov	x0, x22
105f89648: aa1303e1    	mov	x1, x19
105f8964c: 947276bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89650: aa1d03fd    	mov	x29, x29
105f89654: 947276bd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89658: aa0003f7    	mov	x23, x0
105f8965c: f00cf908    	adrp	x8, 0x11feac000 <dyld_stub_binder+0x11feac000>
105f89660: f9420101    	ldr	x1, [x8, #0x400] ; GetNetType
105f89664: 947276b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89668: aa0003e6    	mov	x6, x0
105f8966c: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89670: f9415901    	ldr	x1, [x8, #0x2b0] ; ReportPushUIReportWithRoomId:WithRoomKey:WithRoomType:WithAckStatus:WithNetType:WithTimeStamp:
105f89674: a94583e7    	ldp	x7, x0, [sp, #0x58]
105f89678: f94027e2    	ldr	x2, [sp, #0x48]
105f8967c: aa1b03e3    	mov	x3, x27
105f89680: f9403ffb    	ldr	x27, [sp, #0x78]
105f89684: aa1403e4    	mov	x4, x20
105f89688: 52800085    	mov	w5, #0x4                ; =4
105f8968c: 947276ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89690: aa1703e0    	mov	x0, x23
105f89694: 947276b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89698: aa1603e0    	mov	x0, x22
105f8969c: 947276ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f896a0: aa1c03e0    	mov	x0, x28
105f896a4: f94043fc    	ldr	x28, [sp, #0x80]
105f896a8: 947276ab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f896ac: aa1503e0    	mov	x0, x21
105f896b0: 947276a9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f896b4: b00d1048    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
105f896b8: f9479900    	ldr	x0, [x8, #0xf30]
105f896bc: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f896c0: f9415d01    	ldr	x1, [x8, #0x2b8] ; reportAckWithCallResult:ByVoipMsg:
105f896c4: 528001c2    	mov	w2, #0xe                ; =14
105f896c8: aa1b03e3    	mov	x3, x27
105f896cc: 9472769c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f896d0: 52800015    	mov	w21, #0x0               ; =0
105f896d4: f9403bf9    	ldr	x25, [sp, #0x70]
105f896d8: aa1903e0    	mov	x0, x25
105f896dc: 9472769e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f896e0: aa1c03e0    	mov	x0, x28
105f896e4: 9472769c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f896e8: aa1b03e0    	mov	x0, x27
105f896ec: 9472769a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f896f0: aa1503e0    	mov	x0, x21
105f896f4: a9557bfd    	ldp	x29, x30, [sp, #0x150]
105f896f8: a9544ff4    	ldp	x20, x19, [sp, #0x140]
105f896fc: a95357f6    	ldp	x22, x21, [sp, #0x130]
105f89700: a9525ff8    	ldp	x24, x23, [sp, #0x120]
105f89704: a95167fa    	ldp	x26, x25, [sp, #0x110]
105f89708: a9506ffc    	ldp	x28, x27, [sp, #0x100]
105f8970c: 6d4f23e9    	ldp	d9, d8, [sp, #0xf0]
105f89710: 910583ff    	add	sp, sp, #0x160
105f89714: d65f03c0    	ret
105f89718: d00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f8971c: f945e900    	ldr	x0, [x8, #0xbd0]
105f89720: aa1703e1    	mov	x1, x23
105f89724: 94727686    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89728: aa1d03fd    	mov	x29, x29
105f8972c: 94727687    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89730: aa0003f4    	mov	x20, x0
105f89734: d00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f89738: f9472d00    	ldr	x0, [x8, #0xe58]
105f8973c: f94047e1    	ldr	x1, [sp, #0x88]
105f89740: 9472767f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89744: aa0003e2    	mov	x2, x0
105f89748: aa1403e0    	mov	x0, x20
105f8974c: aa1803e1    	mov	x1, x24
105f89750: 9472767b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89754: aa1d03fd    	mov	x29, x29
105f89758: 9472767c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8975c: aa0003f5    	mov	x21, x0
105f89760: f00d00a8    	adrp	x8, 0x11ffa0000 <dyld_stub_binder+0x11ffa0000>
105f89764: f9461501    	ldr	x1, [x8, #0xc28] ; mDialData
105f89768: 94727675    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8976c: aa1d03fd    	mov	x29, x29
105f89770: 94727676    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89774: aa0003f6    	mov	x22, x0
105f89778: b00cfb68    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
105f8977c: f9402901    	ldr	x1, [x8, #0x50] ; mRoomId
105f89780: 9472766f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89784: f90013e0    	str	x0, [sp, #0x20]
105f89788: aa1603e0    	mov	x0, x22
105f8978c: 94727672    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89790: aa1503e0    	mov	x0, x21
105f89794: 94727670    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89798: aa1403e0    	mov	x0, x20
105f8979c: 9472766e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f897a0: 52800040    	mov	w0, #0x2                ; =2
105f897a4: 94720ea7    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f897a8: 34000560    	cbz	w0, 0x105f89854 <_Flutter_MMFoundation_BindContext+0x2465438>
105f897ac: 9472767d    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f897b0: aa0003f4    	mov	x20, x0
105f897b4: d00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f897b8: f94546c0    	ldr	x0, [x22, #0xa88]
105f897bc: 94727669    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f897c0: aa0003f5    	mov	x21, x0
105f897c4: f94546c0    	ldr	x0, [x22, #0xa88]
105f897c8: b00d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f897cc: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f897d0: f90003ff    	str	xzr, [sp]
105f897d4: d00c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f897d8: 911aa042    	add	x2, x2, #0x6a8
105f897dc: 94727658    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f897e0: aa1d03fd    	mov	x29, x29
105f897e4: 94727659    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f897e8: aa0003f6    	mov	x22, x0
105f897ec: b00d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f897f0: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f897f4: d00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f897f8: 91352108    	add	x8, x8, #0xd48
105f897fc: a90003e8    	stp	x8, x0, [sp]
105f89800: d00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f89804: 9134a042    	add	x2, x2, #0xd28
105f89808: aa1503e0    	mov	x0, x21
105f8980c: 9472764c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89810: aa0003f5    	mov	x21, x0
105f89814: aa1603e0    	mov	x0, x22
105f89818: 9472764f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8981c: b00acec1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f89820: 91373c21    	add	x1, x1, #0xdcf
105f89824: b00acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f89828: 9135dc42    	add	x2, x2, #0xd77
105f8982c: d00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f89830: 9138bc84    	add	x4, x4, #0xe2f
105f89834: 52800040    	mov	w0, #0x2                ; =2
105f89838: 5280b143    	mov	w3, #0x58a              ; =1418
105f8983c: aa1503e5    	mov	x5, x21
105f89840: 94720e81    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f89844: aa1503e0    	mov	x0, x21
105f89848: 94727643    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8984c: aa1403e0    	mov	x0, x20
105f89850: 94727657    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f89854: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89858: f9412101    	ldr	x1, [x8, #0x240] ; m_fromScene
105f8985c: f9001be1    	str	x1, [sp, #0x30]
105f89860: aa1b03e0    	mov	x0, x27
105f89864: 94727636    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89868: 71000c1f    	cmp	w0, #0x3
105f8986c: 52800088    	mov	w8, #0x4                ; =4
105f89870: 528000c9    	mov	w9, #0x6                ; =6
105f89874: 9a880128    	csel	x8, x9, x8, eq
105f89878: 7100081f    	cmp	w0, #0x2
105f8987c: 528000a9    	mov	w9, #0x5                ; =5
105f89880: 9a880134    	csel	x20, x9, x8, eq
105f89884: b00d0f68    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
105f89888: f9421900    	ldr	x0, [x8, #0x430]
105f8988c: 94727633    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105f89890: aa0003fa    	mov	x26, x0
105f89894: 900cf588    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105f89898: f9462d01    	ldr	x1, [x8, #0xc58] ; setContact:
105f8989c: aa1c03e2    	mov	x2, x28
105f898a0: 94727627    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f898a4: d00cf5a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105f898a8: f9410101    	ldr	x1, [x8, #0x200] ; setMsgWrap:
105f898ac: aa1a03e0    	mov	x0, x26
105f898b0: aa1903e2    	mov	x2, x25
105f898b4: 94727622    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f898b8: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f898bc: f9423101    	ldr	x1, [x8, #0x460] ; setMonoMsg:
105f898c0: aa1a03e0    	mov	x0, x26
105f898c4: aa1b03e2    	mov	x2, x27
105f898c8: 9472761d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f898cc: d00cf608    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
105f898d0: f942f101    	ldr	x1, [x8, #0x5e0] ; setIsCaller:
105f898d4: aa1a03e0    	mov	x0, x26
105f898d8: 52800002    	mov	w2, #0x0                ; =0
105f898dc: 94727618    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f898e0: d00cf588    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105f898e4: f9432501    	ldr	x1, [x8, #0x648] ; setFrom:
105f898e8: aa1a03e0    	mov	x0, x26
105f898ec: aa1403e2    	mov	x2, x20
105f898f0: 94727613    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f898f4: d00cf608    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
105f898f8: f942f501    	ldr	x1, [x8, #0x5e8] ; setStartInApp:
105f898fc: aa1a03e0    	mov	x0, x26
105f89900: 52800022    	mov	w2, #0x1                ; =1
105f89904: 9472760e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89908: aa1b03e0    	mov	x0, x27
105f8990c: aa1303e1    	mov	x1, x19
105f89910: 9472760b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89914: aa0003f4    	mov	x20, x0
105f89918: d00d0f58    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
105f8991c: f945eb00    	ldr	x0, [x24, #0xbd0]
105f89920: aa1703e1    	mov	x1, x23
105f89924: 94727606    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89928: aa1d03fd    	mov	x29, x29
105f8992c: 94727607    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89930: aa0003f5    	mov	x21, x0
105f89934: aa1703f9    	mov	x25, x23
105f89938: d00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f8993c: f9467d00    	ldr	x0, [x8, #0xcf8]
105f89940: f94047f7    	ldr	x23, [sp, #0x88]
105f89944: aa1703e1    	mov	x1, x23
105f89948: 947275fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8994c: aa0003e2    	mov	x2, x0
105f89950: aa1503e0    	mov	x0, x21
105f89954: f9402bf3    	ldr	x19, [sp, #0x50]
105f89958: aa1303e1    	mov	x1, x19
105f8995c: 947275f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89960: aa1d03fd    	mov	x29, x29
105f89964: 947275f9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89968: aa0003f6    	mov	x22, x0
105f8996c: d00cf608    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
105f89970: 9117e108    	add	x8, x8, #0x5f8
105f89974: d00cf609    	adrp	x9, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
105f89978: 91182129    	add	x9, x9, #0x608
105f8997c: 7100069f    	cmp	w20, #0x1
105f89980: 9a890108    	csel	x8, x8, x9, eq
105f89984: f9400101    	ldr	x1, [x8]
105f89988: f90017fa    	str	x26, [sp, #0x28]
105f8998c: aa1a03e2    	mov	x2, x26
105f89990: 947275eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89994: aa1603e0    	mov	x0, x22
105f89998: 947275ef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8999c: aa1503e0    	mov	x0, x21
105f899a0: 947275ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f899a4: f945eb00    	ldr	x0, [x24, #0xbd0]
105f899a8: aa1903e1    	mov	x1, x25
105f899ac: 947275e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f899b0: aa1d03fd    	mov	x29, x29
105f899b4: 947275e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f899b8: aa0003f4    	mov	x20, x0
105f899bc: d00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f899c0: f9467ec0    	ldr	x0, [x22, #0xcf8]
105f899c4: aa1703e1    	mov	x1, x23
105f899c8: 947275dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f899cc: aa0003e2    	mov	x2, x0
105f899d0: aa1403e0    	mov	x0, x20
105f899d4: aa1303e1    	mov	x1, x19
105f899d8: 947275d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f899dc: aa1d03fd    	mov	x29, x29
105f899e0: 947275da    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f899e4: aa0003f5    	mov	x21, x0
105f899e8: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f899ec: f9423501    	ldr	x1, [x8, #0x468] ; setReceiverViewMonoMsgForCloseNotification:
105f899f0: aa1b03e2    	mov	x2, x27
105f899f4: 947275d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f899f8: aa1503e0    	mov	x0, x21
105f899fc: 947275d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89a00: aa1403e0    	mov	x0, x20
105f89a04: 947275d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89a08: f945eb00    	ldr	x0, [x24, #0xbd0]
105f89a0c: aa1303f8    	mov	x24, x19
105f89a10: aa1903e1    	mov	x1, x25
105f89a14: 947275ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89a18: aa1d03fd    	mov	x29, x29
105f89a1c: 947275cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89a20: aa0003f4    	mov	x20, x0
105f89a24: f9467ec0    	ldr	x0, [x22, #0xcf8]
105f89a28: aa1703e1    	mov	x1, x23
105f89a2c: 947275c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89a30: aa0003e2    	mov	x2, x0
105f89a34: aa1403e0    	mov	x0, x20
105f89a38: aa1303e1    	mov	x1, x19
105f89a3c: 947275c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89a40: aa1d03fd    	mov	x29, x29
105f89a44: 947275c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89a48: aa0003f5    	mov	x21, x0
105f89a4c: aa1b03e0    	mov	x0, x27
105f89a50: f94023e1    	ldr	x1, [sp, #0x40]
105f89a54: 947275ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89a58: aa0003f6    	mov	x22, x0
105f89a5c: aa1b03e0    	mov	x0, x27
105f89a60: f94037e1    	ldr	x1, [sp, #0x68]
105f89a64: 947275b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89a68: aa0003e3    	mov	x3, x0
105f89a6c: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89a70: f9423901    	ldr	x1, [x8, #0x470] ; setRoomInfoToCurrentVoipViewWith:And:
105f89a74: aa1503e0    	mov	x0, x21
105f89a78: aa1603e2    	mov	x2, x22
105f89a7c: 947275b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89a80: aa1503e0    	mov	x0, x21
105f89a84: 947275b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89a88: aa1403e0    	mov	x0, x20
105f89a8c: 947275b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89a90: aa1b03e0    	mov	x0, x27
105f89a94: f9401be1    	ldr	x1, [sp, #0x30]
105f89a98: 947275a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89a9c: 34000260    	cbz	w0, 0x105f89ae8 <_Flutter_MMFoundation_BindContext+0x24656cc>
105f89aa0: aa1b03e0    	mov	x0, x27
105f89aa4: f9401be1    	ldr	x1, [sp, #0x30]
105f89aa8: 947275a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89aac: 7100081f    	cmp	w0, #0x2
105f89ab0: 54000361    	b.ne	0x105f89b1c <_Flutter_MMFoundation_BindContext+0x2465700>
105f89ab4: f00d1068    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f89ab8: f9463100    	ldr	x0, [x8, #0xc60]
105f89abc: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89ac0: f9424101    	ldr	x1, [x8, #0x480] ; logicUiOkApnsMsgClosePreConnect
105f89ac4: 9472759e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89ac8: 52800040    	mov	w0, #0x2                ; =2
105f89acc: 94720ddd    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f89ad0: 5280001a    	mov	w26, #0x0               ; =0
105f89ad4: 36000d40    	tbz	w0, #0x0, 0x105f89c7c <_Flutter_MMFoundation_BindContext+0x2465860>
105f89ad8: 5280b679    	mov	w25, #0x5b3             ; =1459
105f89adc: d00c46b5    	adrp	x21, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f89ae0: 911ba2b5    	add	x21, x21, #0x6e8
105f89ae4: 1400003d    	b	0x105f89bd8 <_Flutter_MMFoundation_BindContext+0x24657bc>
105f89ae8: f00d1068    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f89aec: f9463100    	ldr	x0, [x8, #0xc60]
105f89af0: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89af4: f9423d01    	ldr	x1, [x8, #0x478] ; logicUiOkSyncMsgClosePreConnect
105f89af8: 94727591    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89afc: 52800040    	mov	w0, #0x2                ; =2
105f89b00: 94720dd0    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f89b04: 5280001a    	mov	w26, #0x0               ; =0
105f89b08: 36000ba0    	tbz	w0, #0x0, 0x105f89c7c <_Flutter_MMFoundation_BindContext+0x2465860>
105f89b0c: 5280b5f9    	mov	w25, #0x5af             ; =1455
105f89b10: d00c46b5    	adrp	x21, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f89b14: 911b22b5    	add	x21, x21, #0x6c8
105f89b18: 14000030    	b	0x105f89bd8 <_Flutter_MMFoundation_BindContext+0x24657bc>
105f89b1c: aa1b03e0    	mov	x0, x27
105f89b20: f9401be1    	ldr	x1, [sp, #0x30]
105f89b24: 94727586    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89b28: 71000c1f    	cmp	w0, #0x3
105f89b2c: 540001c1    	b.ne	0x105f89b64 <_Flutter_MMFoundation_BindContext+0x2465748>
105f89b30: f00d1068    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f89b34: f9463100    	ldr	x0, [x8, #0xc60]
105f89b38: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89b3c: f9424501    	ldr	x1, [x8, #0x488] ; logicUiOkPushKitMsgClosePreConnect
105f89b40: 9472757f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89b44: 52800040    	mov	w0, #0x2                ; =2
105f89b48: 94720dbe    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f89b4c: 5280001a    	mov	w26, #0x0               ; =0
105f89b50: 36000960    	tbz	w0, #0x0, 0x105f89c7c <_Flutter_MMFoundation_BindContext+0x2465860>
105f89b54: 5280b6f9    	mov	w25, #0x5b7             ; =1463
105f89b58: d00c46b5    	adrp	x21, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f89b5c: 911c22b5    	add	x21, x21, #0x708
105f89b60: 1400001e    	b	0x105f89bd8 <_Flutter_MMFoundation_BindContext+0x24657bc>
105f89b64: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89b68: f9424901    	ldr	x1, [x8, #0x490] ; receiveTimeOutOfDate
105f89b6c: aa1b03e0    	mov	x0, x27
105f89b70: 94727573    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89b74: aa0003e8    	mov	x8, x0
105f89b78: f00d1069    	adrp	x9, 0x120198000 <dyld_stub_binder+0x120198000>
105f89b7c: f9463120    	ldr	x0, [x9, #0xc60]
105f89b80: 34000188    	cbz	w8, 0x105f89bb0 <_Flutter_MMFoundation_BindContext+0x2465794>
105f89b84: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89b88: f9424d01    	ldr	x1, [x8, #0x498] ; logicUiOkNotifyMsgTimeUnRealClosePreConnect
105f89b8c: 9472756c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89b90: 52800040    	mov	w0, #0x2                ; =2
105f89b94: 94720dab    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f89b98: 5280001a    	mov	w26, #0x0               ; =0
105f89b9c: 36000700    	tbz	w0, #0x0, 0x105f89c7c <_Flutter_MMFoundation_BindContext+0x2465860>
105f89ba0: 5280b799    	mov	w25, #0x5bc             ; =1468
105f89ba4: d00c46b5    	adrp	x21, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f89ba8: 911ca2b5    	add	x21, x21, #0x728
105f89bac: 1400000b    	b	0x105f89bd8 <_Flutter_MMFoundation_BindContext+0x24657bc>
105f89bb0: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89bb4: f9425101    	ldr	x1, [x8, #0x4a0] ; logicUiOkNotifyMsgOpenPreConnect
105f89bb8: 94727561    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89bbc: 52800040    	mov	w0, #0x2                ; =2
105f89bc0: 94720da0    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f89bc4: 5280003a    	mov	w26, #0x1               ; =1
105f89bc8: 340005a0    	cbz	w0, 0x105f89c7c <_Flutter_MMFoundation_BindContext+0x2465860>
105f89bcc: 5280b819    	mov	w25, #0x5c0             ; =1472
105f89bd0: d00c46b5    	adrp	x21, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f89bd4: 911d22b5    	add	x21, x21, #0x748
105f89bd8: 94727572    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f89bdc: aa0003f4    	mov	x20, x0
105f89be0: d00d0f57    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
105f89be4: f94546e0    	ldr	x0, [x23, #0xa88]
105f89be8: 9472755e    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f89bec: aa0003f6    	mov	x22, x0
105f89bf0: f94546e0    	ldr	x0, [x23, #0xa88]
105f89bf4: b00d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f89bf8: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f89bfc: f90003ff    	str	xzr, [sp]
105f89c00: aa1503e2    	mov	x2, x21
105f89c04: 9472754e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89c08: aa1d03fd    	mov	x29, x29
105f89c0c: 9472754f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89c10: aa0003f5    	mov	x21, x0
105f89c14: b00d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f89c18: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f89c1c: d00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f89c20: 91352108    	add	x8, x8, #0xd48
105f89c24: a90003e8    	stp	x8, x0, [sp]
105f89c28: d00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f89c2c: 9134a042    	add	x2, x2, #0xd28
105f89c30: aa1603e0    	mov	x0, x22
105f89c34: 94727542    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89c38: aa0003f6    	mov	x22, x0
105f89c3c: aa1503e0    	mov	x0, x21
105f89c40: 94727545    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89c44: b00acec1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f89c48: 91373c21    	add	x1, x1, #0xdcf
105f89c4c: b00acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f89c50: 9135dc42    	add	x2, x2, #0xd77
105f89c54: d00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f89c58: 9138bc84    	add	x4, x4, #0xe2f
105f89c5c: 52800040    	mov	w0, #0x2                ; =2
105f89c60: aa1903e3    	mov	x3, x25
105f89c64: aa1603e5    	mov	x5, x22
105f89c68: 94720d77    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f89c6c: aa1603e0    	mov	x0, x22
105f89c70: 94727539    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89c74: aa1403e0    	mov	x0, x20
105f89c78: 9472754d    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f89c7c: f9404bf7    	ldr	x23, [sp, #0x90]
105f89c80: b9403be8    	ldr	w8, [sp, #0x38]
105f89c84: 7100091f    	cmp	w8, #0x2
105f89c88: 54001421    	b.ne	0x105f89f0c <_Flutter_MMFoundation_BindContext+0x2465af0>
105f89c8c: aa1b03e0    	mov	x0, x27
105f89c90: f94023e1    	ldr	x1, [sp, #0x40]
105f89c94: 9472752a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89c98: f94013e8    	ldr	x8, [sp, #0x20]
105f89c9c: eb00011f    	cmp	x8, x0
105f89ca0: 54000800    	b.eq	0x105f89da0 <_Flutter_MMFoundation_BindContext+0x2465984>
105f89ca4: d00d0f54    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
105f89ca8: f945ea80    	ldr	x0, [x20, #0xbd0]
105f89cac: aa1703e1    	mov	x1, x23
105f89cb0: 94727523    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89cb4: aa1d03fd    	mov	x29, x29
105f89cb8: 94727524    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89cbc: aa0003f5    	mov	x21, x0
105f89cc0: d00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f89cc4: f9472ec0    	ldr	x0, [x22, #0xe58]
105f89cc8: f94047f3    	ldr	x19, [sp, #0x88]
105f89ccc: aa1303e1    	mov	x1, x19
105f89cd0: 9472751b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89cd4: aa0003e2    	mov	x2, x0
105f89cd8: aa1503e0    	mov	x0, x21
105f89cdc: aa1803e1    	mov	x1, x24
105f89ce0: 94727517    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89ce4: aa1d03fd    	mov	x29, x29
105f89ce8: 94727518    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89cec: aa0003f9    	mov	x25, x0
105f89cf0: f945ea80    	ldr	x0, [x20, #0xbd0]
105f89cf4: aa1703e1    	mov	x1, x23
105f89cf8: 94727511    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89cfc: aa1d03fd    	mov	x29, x29
105f89d00: 94727512    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89d04: aa0003f4    	mov	x20, x0
105f89d08: f9472ec0    	ldr	x0, [x22, #0xe58]
105f89d0c: aa1303e1    	mov	x1, x19
105f89d10: 9472750b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89d14: aa0003e2    	mov	x2, x0
105f89d18: aa1403e0    	mov	x0, x20
105f89d1c: aa1803e1    	mov	x1, x24
105f89d20: 94727507    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89d24: aa1d03fd    	mov	x29, x29
105f89d28: 94727508    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89d2c: aa0003f6    	mov	x22, x0
105f89d30: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89d34: f9415501    	ldr	x1, [x8, #0x2a8] ; mVoIPType
105f89d38: 94727501    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89d3c: aa0003f7    	mov	x23, x0
105f89d40: aa1b03e0    	mov	x0, x27
105f89d44: f94023e1    	ldr	x1, [sp, #0x40]
105f89d48: 947274fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89d4c: aa0003f8    	mov	x24, x0
105f89d50: aa1b03e0    	mov	x0, x27
105f89d54: f94037e1    	ldr	x1, [sp, #0x68]
105f89d58: 947274f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89d5c: aa0003e5    	mov	x5, x0
105f89d60: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89d64: f9425501    	ldr	x1, [x8, #0x4a8] ; onNewSimuCallAutoAccept:andContact:withRoomId:andKey:
105f89d68: aa1903e0    	mov	x0, x25
105f89d6c: aa1703e2    	mov	x2, x23
105f89d70: f9404bf7    	ldr	x23, [sp, #0x90]
105f89d74: aa1c03e3    	mov	x3, x28
105f89d78: aa1803e4    	mov	x4, x24
105f89d7c: 947274f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89d80: aa1603e0    	mov	x0, x22
105f89d84: 947274f4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89d88: aa1403e0    	mov	x0, x20
105f89d8c: 947274f2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89d90: aa1903e0    	mov	x0, x25
105f89d94: 947274f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89d98: aa1503e0    	mov	x0, x21
105f89d9c: 947274ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89da0: 52800040    	mov	w0, #0x2                ; =2
105f89da4: 94720d27    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f89da8: f9403bf9    	ldr	x25, [sp, #0x70]
105f89dac: 34000620    	cbz	w0, 0x105f89e70 <_Flutter_MMFoundation_BindContext+0x2465a54>
105f89db0: 947274fc    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f89db4: aa0003f5    	mov	x21, x0
105f89db8: d00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f89dbc: f94546c0    	ldr	x0, [x22, #0xa88]
105f89dc0: 947274e8    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f89dc4: aa0003f4    	mov	x20, x0
105f89dc8: f94546d6    	ldr	x22, [x22, #0xa88]
105f89dcc: aa1b03e0    	mov	x0, x27
105f89dd0: f94023e1    	ldr	x1, [sp, #0x40]
105f89dd4: 947274da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89dd8: b00d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f89ddc: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f89de0: a900ffe0    	stp	x0, xzr, [sp, #0x8]
105f89de4: f94013e8    	ldr	x8, [sp, #0x20]
105f89de8: f90003e8    	str	x8, [sp]
105f89dec: d00c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f89df0: 911da042    	add	x2, x2, #0x768
105f89df4: aa1603e0    	mov	x0, x22
105f89df8: 947274d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89dfc: aa1d03fd    	mov	x29, x29
105f89e00: 947274d2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89e04: aa0003f6    	mov	x22, x0
105f89e08: b00d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f89e0c: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f89e10: d00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f89e14: 91352108    	add	x8, x8, #0xd48
105f89e18: a90003e8    	stp	x8, x0, [sp]
105f89e1c: d00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f89e20: 9134a042    	add	x2, x2, #0xd28
105f89e24: aa1403e0    	mov	x0, x20
105f89e28: 947274c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89e2c: aa0003f4    	mov	x20, x0
105f89e30: aa1603e0    	mov	x0, x22
105f89e34: 947274c8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89e38: b00acec1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f89e3c: 91373c21    	add	x1, x1, #0xdcf
105f89e40: b00acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f89e44: 9135dc42    	add	x2, x2, #0xd77
105f89e48: d00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f89e4c: 9138bc84    	add	x4, x4, #0xe2f
105f89e50: 52800040    	mov	w0, #0x2                ; =2
105f89e54: 5280b9c3    	mov	w3, #0x5ce              ; =1486
105f89e58: aa1403e5    	mov	x5, x20
105f89e5c: 94720cfa    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f89e60: aa1403e0    	mov	x0, x20
105f89e64: 947274bc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89e68: aa1503e0    	mov	x0, x21
105f89e6c: 947274d0    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f89e70: d00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f89e74: f945e900    	ldr	x0, [x8, #0xbd0]
105f89e78: aa1703e1    	mov	x1, x23
105f89e7c: 947274b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89e80: aa1d03fd    	mov	x29, x29
105f89e84: 947274b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89e88: aa0003f4    	mov	x20, x0
105f89e8c: b00d0f48    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
105f89e90: f942e115    	ldr	x21, [x8, #0x5c0]
105f89e94: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89e98: f9425916    	ldr	x22, [x8, #0x4b0] ; onVoIPMessageMgrRejectCallBecasueOfSimucallingByCalleeWithRoomID:roomKey:
105f89e9c: b00bb328    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
105f89ea0: f947e108    	ldr	x8, [x8, #0xfc0]
105f89ea4: f9004fe8    	str	x8, [sp, #0x98]
105f89ea8: 90096fc8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
105f89eac: fd41c100    	ldr	d0, [x8, #0x380]
105f89eb0: fd0053e0    	str	d0, [sp, #0xa0]
105f89eb4: b0000008    	adrp	x8, 0x105f8a000 <_Flutter_MMFoundation_BindContext+0x2465be4>
105f89eb8: 91144108    	add	x8, x8, #0x510
105f89ebc: b00bb369    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
105f89ec0: 91238129    	add	x9, x9, #0x8e0
105f89ec4: a90aa7e8    	stp	x8, x9, [sp, #0xa8]
105f89ec8: aa1b03e0    	mov	x0, x27
105f89ecc: 9472749b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105f89ed0: f9005ffb    	str	x27, [sp, #0xb8]
105f89ed4: b00cf588    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105f89ed8: f940d501    	ldr	x1, [x8, #0x1a8] ; callExtensionOnMainThread:selector:sync:block:
105f89edc: 910263e5    	add	x5, sp, #0x98
105f89ee0: aa1403e0    	mov	x0, x20
105f89ee4: aa1503e2    	mov	x2, x21
105f89ee8: aa1603e3    	mov	x3, x22
105f89eec: 52800024    	mov	w4, #0x1                ; =1
105f89ef0: 94727493    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89ef4: aa1403e0    	mov	x0, x20
105f89ef8: 94727497    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89efc: f9405fe0    	ldr	x0, [sp, #0xb8]
105f89f00: 94727495    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89f04: 52800015    	mov	w21, #0x0               ; =0
105f89f08: 140000ad    	b	0x105f8a1bc <_Flutter_MMFoundation_BindContext+0x2465da0>
105f89f0c: d00d0f58    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
105f89f10: f945eb00    	ldr	x0, [x24, #0xbd0]
105f89f14: aa1703e1    	mov	x1, x23
105f89f18: 94727489    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89f1c: aa1d03fd    	mov	x29, x29
105f89f20: 9472748a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89f24: aa0003f4    	mov	x20, x0
105f89f28: f00d1068    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
105f89f2c: f9463900    	ldr	x0, [x8, #0xc70]
105f89f30: f94047f3    	ldr	x19, [sp, #0x88]
105f89f34: aa1303e1    	mov	x1, x19
105f89f38: 94727481    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89f3c: aa0003e2    	mov	x2, x0
105f89f40: aa1403e0    	mov	x0, x20
105f89f44: f9402be1    	ldr	x1, [sp, #0x50]
105f89f48: 9472747d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89f4c: aa1d03fd    	mov	x29, x29
105f89f50: 9472747e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89f54: aa0003f5    	mov	x21, x0
105f89f58: aa1b03e0    	mov	x0, x27
105f89f5c: f94023f8    	ldr	x24, [sp, #0x40]
105f89f60: aa1803e1    	mov	x1, x24
105f89f64: 94727476    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89f68: aa0003f6    	mov	x22, x0
105f89f6c: aa1b03e0    	mov	x0, x27
105f89f70: f94037f9    	ldr	x25, [sp, #0x68]
105f89f74: aa1903e1    	mov	x1, x25
105f89f78: 94727471    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89f7c: aa0003e3    	mov	x3, x0
105f89f80: b00d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f89f84: f9415101    	ldr	x1, [x8, #0x2a0] ; SendAckRequestByRoomId:andRoomKey:andContact:andAckStatus:needPreconnect:
105f89f88: aa1503e0    	mov	x0, x21
105f89f8c: aa1603e2    	mov	x2, x22
105f89f90: aa1c03e4    	mov	x4, x28
105f89f94: 52800025    	mov	w5, #0x1                ; =1
105f89f98: aa1a03e6    	mov	x6, x26
105f89f9c: 94727468    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89fa0: aa1503e0    	mov	x0, x21
105f89fa4: 9472746c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89fa8: aa1403e0    	mov	x0, x20
105f89fac: 9472746a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f89fb0: b00d0f68    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
105f89fb4: f9421508    	ldr	x8, [x8, #0x428]
105f89fb8: f9001fe8    	str	x8, [sp, #0x38]
105f89fbc: aa1b03e0    	mov	x0, x27
105f89fc0: aa1803e1    	mov	x1, x24
105f89fc4: 9472745e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89fc8: f90013e0    	str	x0, [sp, #0x20]
105f89fcc: aa1b03e0    	mov	x0, x27
105f89fd0: aa1903e1    	mov	x1, x25
105f89fd4: 9472745a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89fd8: aa0003f9    	mov	x25, x0
105f89fdc: d00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f89fe0: f945eac0    	ldr	x0, [x22, #0xbd0]
105f89fe4: aa1703e1    	mov	x1, x23
105f89fe8: 94727455    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f89fec: aa1d03fd    	mov	x29, x29
105f89ff0: 94727456    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f89ff4: aa0003f5    	mov	x21, x0
105f89ff8: d00d0f5a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
105f89ffc: f9472f40    	ldr	x0, [x26, #0xe58]
105f8a000: aa1303e1    	mov	x1, x19
105f8a004: 9472744e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a008: aa0003e2    	mov	x2, x0
105f8a00c: aa1503e0    	mov	x0, x21
105f8a010: f9402be1    	ldr	x1, [sp, #0x50]
105f8a014: 9472744a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a018: aa1d03fd    	mov	x29, x29
105f8a01c: 9472744b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a020: aa0003fb    	mov	x27, x0
105f8a024: 900d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8a028: f9415501    	ldr	x1, [x8, #0x2a8] ; mVoIPType
105f8a02c: 94727444    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a030: aa0003f4    	mov	x20, x0
105f8a034: f945eac0    	ldr	x0, [x22, #0xbd0]
105f8a038: f9402bf8    	ldr	x24, [sp, #0x50]
105f8a03c: aa1703e1    	mov	x1, x23
105f8a040: 9472743f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a044: aa1d03fd    	mov	x29, x29
105f8a048: 94727440    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a04c: aa0003f6    	mov	x22, x0
105f8a050: f9472f40    	ldr	x0, [x26, #0xe58]
105f8a054: aa1303e1    	mov	x1, x19
105f8a058: 94727439    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a05c: aa0003e2    	mov	x2, x0
105f8a060: aa1603e0    	mov	x0, x22
105f8a064: aa1803e1    	mov	x1, x24
105f8a068: 94727435    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a06c: aa1d03fd    	mov	x29, x29
105f8a070: 94727436    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a074: aa0003f7    	mov	x23, x0
105f8a078: d00cf908    	adrp	x8, 0x11feac000 <dyld_stub_binder+0x11feac000>
105f8a07c: f9420101    	ldr	x1, [x8, #0x400] ; GetNetType
105f8a080: 9472742f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a084: aa0003e6    	mov	x6, x0
105f8a088: 900d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8a08c: f9415901    	ldr	x1, [x8, #0x2b0] ; ReportPushUIReportWithRoomId:WithRoomKey:WithRoomType:WithAckStatus:WithNetType:WithTimeStamp:
105f8a090: f9401fe0    	ldr	x0, [sp, #0x38]
105f8a094: f94013e2    	ldr	x2, [sp, #0x20]
105f8a098: aa1903e3    	mov	x3, x25
105f8a09c: aa1403e4    	mov	x4, x20
105f8a0a0: 52800025    	mov	w5, #0x1                ; =1
105f8a0a4: f9402fe7    	ldr	x7, [sp, #0x58]
105f8a0a8: 94727425    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a0ac: aa1703e0    	mov	x0, x23
105f8a0b0: 94727429    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a0b4: aa1603e0    	mov	x0, x22
105f8a0b8: 94727427    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a0bc: aa1b03e0    	mov	x0, x27
105f8a0c0: f9403ffb    	ldr	x27, [sp, #0x78]
105f8a0c4: 94727424    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a0c8: aa1503e0    	mov	x0, x21
105f8a0cc: 94727422    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a0d0: b00d0ff7    	adrp	x23, 0x120187000 <dyld_stub_binder+0x120187000>
105f8a0d4: f943aaf4    	ldr	x20, [x23, #0x750]
105f8a0d8: aa1b03e0    	mov	x0, x27
105f8a0dc: f94027e1    	ldr	x1, [sp, #0x48]
105f8a0e0: 94727417    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a0e4: 7100001f    	cmp	w0, #0x0
105f8a0e8: 1a9f17e2    	cset	w2, eq
105f8a0ec: f00d0048    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
105f8a0f0: f9407901    	ldr	x1, [x8, #0xf0] ; getIfCanUseCX:isMultiTalk:
105f8a0f4: aa1403e0    	mov	x0, x20
105f8a0f8: 52800003    	mov	w3, #0x0                ; =0
105f8a0fc: 94727410    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a100: 340000c0    	cbz	w0, 0x105f8a118 <_Flutter_MMFoundation_BindContext+0x2465cfc>
105f8a104: f943aae0    	ldr	x0, [x23, #0x750]
105f8a108: f00d0048    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
105f8a10c: f9407501    	ldr	x1, [x8, #0xe8] ; isAppStateActive
105f8a110: 9472740b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a114: 360005a0    	tbz	w0, #0x0, 0x105f8a1c8 <_Flutter_MMFoundation_BindContext+0x2465dac>
105f8a118: b00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f8a11c: f945e900    	ldr	x0, [x8, #0xbd0]
105f8a120: f9404be1    	ldr	x1, [sp, #0x90]
105f8a124: 94727406    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a128: aa1d03fd    	mov	x29, x29
105f8a12c: 94727407    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a130: aa0003f4    	mov	x20, x0
105f8a134: b00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f8a138: f9472d00    	ldr	x0, [x8, #0xe58]
105f8a13c: f94047e1    	ldr	x1, [sp, #0x88]
105f8a140: 947273ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a144: aa0003e2    	mov	x2, x0
105f8a148: aa1403e0    	mov	x0, x20
105f8a14c: aa1803e1    	mov	x1, x24
105f8a150: 947273fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a154: aa1d03fd    	mov	x29, x29
105f8a158: 947273fc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a15c: aa0003f5    	mov	x21, x0
105f8a160: 900d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8a164: f9425d01    	ldr	x1, [x8, #0x4b8] ; setMVoIPCallKitType:
105f8a168: 52800002    	mov	w2, #0x0                ; =0
105f8a16c: 947273f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a170: aa1503e0    	mov	x0, x21
105f8a174: 947273f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a178: aa1403e0    	mov	x0, x20
105f8a17c: 947273f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a180: 900d1048    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
105f8a184: f9479914    	ldr	x20, [x8, #0xf30]
105f8a188: 900d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8a18c: f940f501    	ldr	x1, [x8, #0x1e8] ; isFromIlink
105f8a190: aa1b03e0    	mov	x0, x27
105f8a194: 947273ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a198: aa0003e4    	mov	x4, x0
105f8a19c: 900d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8a1a0: f9426101    	ldr	x1, [x8, #0x4c0] ; openVoipViewByVoipMonoMsg:haveAnswered:isilink:
105f8a1a4: aa1403e0    	mov	x0, x20
105f8a1a8: aa1b03e2    	mov	x2, x27
105f8a1ac: 52800003    	mov	w3, #0x0                ; =0
105f8a1b0: 947273e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a1b4: aa0003f5    	mov	x21, x0
105f8a1b8: f9403bf9    	ldr	x25, [sp, #0x70]
105f8a1bc: f94017e0    	ldr	x0, [sp, #0x28]
105f8a1c0: 947273e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a1c4: 17fffd45    	b	0x105f896d8 <_Flutter_MMFoundation_BindContext+0x24652bc>
105f8a1c8: 52800040    	mov	w0, #0x2                ; =2
105f8a1cc: 528001e1    	mov	w1, #0xf                ; =15
105f8a1d0: 52800082    	mov	w2, #0x4                ; =4
105f8a1d4: 52800003    	mov	w3, #0x0                ; =0
105f8a1d8: 94720d37    	bl	0x107c0d6b4 <_Flutter_MMFoundation_BindContext+0x40e9298>
105f8a1dc: f9403bf9    	ldr	x25, [sp, #0x70]
105f8a1e0: 340000c0    	cbz	w0, 0x105f8a1f8 <_Flutter_MMFoundation_BindContext+0x2465ddc>
105f8a1e4: aa1b03e0    	mov	x0, x27
105f8a1e8: f9401be1    	ldr	x1, [sp, #0x30]
105f8a1ec: 947273d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a1f0: 71000c1f    	cmp	w0, #0x3
105f8a1f4: 540011a0    	b.eq	0x105f8a428 <_Flutter_MMFoundation_BindContext+0x246600c>
105f8a1f8: 52800040    	mov	w0, #0x2                ; =2
105f8a1fc: 94720c11    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f8a200: 34000560    	cbz	w0, 0x105f8a2ac <_Flutter_MMFoundation_BindContext+0x2465e90>
105f8a204: 947273e7    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f8a208: aa0003f5    	mov	x21, x0
105f8a20c: b00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f8a210: f94546c0    	ldr	x0, [x22, #0xa88]
105f8a214: 947273d3    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f8a218: aa0003f4    	mov	x20, x0
105f8a21c: f94546c0    	ldr	x0, [x22, #0xa88]
105f8a220: 900d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f8a224: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f8a228: a9007ffb    	stp	x27, xzr, [sp]
105f8a22c: b00c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f8a230: 911e2042    	add	x2, x2, #0x788
105f8a234: 947273c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a238: aa1d03fd    	mov	x29, x29
105f8a23c: 947273c3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a240: aa0003f6    	mov	x22, x0
105f8a244: 900d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f8a248: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f8a24c: b00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f8a250: 91352108    	add	x8, x8, #0xd48
105f8a254: a90003e8    	stp	x8, x0, [sp]
105f8a258: b00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f8a25c: 9134a042    	add	x2, x2, #0xd28
105f8a260: aa1403e0    	mov	x0, x20
105f8a264: 947273b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a268: aa0003f4    	mov	x20, x0
105f8a26c: aa1603e0    	mov	x0, x22
105f8a270: 947273b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a274: f00a9441    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
105f8a278: 9124e421    	add	x1, x1, #0x939
105f8a27c: 900acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f8a280: 9135dc42    	add	x2, x2, #0xd77
105f8a284: b00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f8a288: 9138bc84    	add	x4, x4, #0xe2f
105f8a28c: 52800040    	mov	w0, #0x2                ; =2
105f8a290: 5280bda3    	mov	w3, #0x5ed              ; =1517
105f8a294: aa1403e5    	mov	x5, x20
105f8a298: 94720beb    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f8a29c: aa1403e0    	mov	x0, x20
105f8a2a0: 947273ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a2a4: aa1503e0    	mov	x0, x21
105f8a2a8: 947273c1    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f8a2ac: f943aaf4    	ldr	x20, [x23, #0x750]
105f8a2b0: aa1b03e0    	mov	x0, x27
105f8a2b4: f94023e1    	ldr	x1, [sp, #0x40]
105f8a2b8: 947273a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a2bc: aa0003e2    	mov	x2, x0
105f8a2c0: d00d0048    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
105f8a2c4: f9472101    	ldr	x1, [x8, #0xe40] ; isProcessWithRoom:
105f8a2c8: aa1403e0    	mov	x0, x20
105f8a2cc: 9472739c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a2d0: f94033f3    	ldr	x19, [sp, #0x60]
105f8a2d4: 340005e0    	cbz	w0, 0x105f8a390 <_Flutter_MMFoundation_BindContext+0x2465f74>
105f8a2d8: 52800040    	mov	w0, #0x2                ; =2
105f8a2dc: 94720bd9    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f8a2e0: 34ffe120    	cbz	w0, 0x105f89f04 <_Flutter_MMFoundation_BindContext+0x2465ae8>
105f8a2e4: 947273af    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f8a2e8: aa0003f4    	mov	x20, x0
105f8a2ec: b00d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f8a2f0: f94546c0    	ldr	x0, [x22, #0xa88]
105f8a2f4: 9472739b    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f8a2f8: aa0003f5    	mov	x21, x0
105f8a2fc: f94546c0    	ldr	x0, [x22, #0xa88]
105f8a300: 900d0c08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f8a304: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f8a308: f90003ff    	str	xzr, [sp]
105f8a30c: b00c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f8a310: 911ea042    	add	x2, x2, #0x7a8
105f8a314: 9472738a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a318: aa1d03fd    	mov	x29, x29
105f8a31c: 9472738b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a320: aa0003f6    	mov	x22, x0
105f8a324: 900d0bc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f8a328: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
105f8a32c: b00c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f8a330: 91352108    	add	x8, x8, #0xd48
105f8a334: a90003e8    	stp	x8, x0, [sp]
105f8a338: b00c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f8a33c: 9134a042    	add	x2, x2, #0xd28
105f8a340: aa1503e0    	mov	x0, x21
105f8a344: 9472737e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a348: aa0003f5    	mov	x21, x0
105f8a34c: aa1603e0    	mov	x0, x22
105f8a350: 94727381    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a354: f00a9441    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
105f8a358: 9124e421    	add	x1, x1, #0x939
105f8a35c: 900acec2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f8a360: 9135dc42    	add	x2, x2, #0xd77
105f8a364: b00acec4    	adrp	x4, 0x11b963000 <dyld_stub_binder+0x11b963000>
105f8a368: 9138bc84    	add	x4, x4, #0xe2f
105f8a36c: 52800040    	mov	w0, #0x2                ; =2
105f8a370: 5280bde3    	mov	w3, #0x5ef              ; =1519
105f8a374: aa1503e5    	mov	x5, x21
105f8a378: 94720bb3    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f8a37c: aa1503e0    	mov	x0, x21
105f8a380: 94727375    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a384: aa1403e0    	mov	x0, x20
105f8a388: 94727389    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f8a38c: 17fffede    	b	0x105f89f04 <_Flutter_MMFoundation_BindContext+0x2465ae8>
105f8a390: b00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f8a394: f945e900    	ldr	x0, [x8, #0xbd0]
105f8a398: f9404be1    	ldr	x1, [sp, #0x90]
105f8a39c: 94727368    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a3a0: aa1d03fd    	mov	x29, x29
105f8a3a4: 94727369    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a3a8: aa0003f4    	mov	x20, x0
105f8a3ac: f943aae0    	ldr	x0, [x23, #0x750]
105f8a3b0: f94047e1    	ldr	x1, [sp, #0x88]
105f8a3b4: 94727362    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a3b8: aa0003e2    	mov	x2, x0
105f8a3bc: aa1403e0    	mov	x0, x20
105f8a3c0: aa1803e1    	mov	x1, x24
105f8a3c4: 9472735e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a3c8: aa1d03fd    	mov	x29, x29
105f8a3cc: 9472735f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a3d0: aa0003f5    	mov	x21, x0
105f8a3d4: aa1b03e0    	mov	x0, x27
105f8a3d8: aa1303e1    	mov	x1, x19
105f8a3dc: 94727358    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a3e0: aa1d03fd    	mov	x29, x29
105f8a3e4: 94727359    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a3e8: aa0003f6    	mov	x22, x0
105f8a3ec: f00d0048    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
105f8a3f0: f9407d01    	ldr	x1, [x8, #0xf8] ; reportIncomingCallFromUser:ofType:withMsg:isPushKit:isMultitalk:
105f8a3f4: aa1503e0    	mov	x0, x21
105f8a3f8: aa1603e2    	mov	x2, x22
105f8a3fc: 52800023    	mov	w3, #0x1                ; =1
105f8a400: aa1b03e4    	mov	x4, x27
105f8a404: 52800005    	mov	w5, #0x0                ; =0
105f8a408: 52800006    	mov	w6, #0x0                ; =0
105f8a40c: 9472734c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a410: aa1603e0    	mov	x0, x22
105f8a414: 94727350    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a418: aa1503e0    	mov	x0, x21
105f8a41c: 9472734e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a420: aa1403e0    	mov	x0, x20
105f8a424: 9472734c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a428: b00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f8a42c: f945e900    	ldr	x0, [x8, #0xbd0]
105f8a430: f9404be1    	ldr	x1, [sp, #0x90]
105f8a434: 94727342    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a438: aa1d03fd    	mov	x29, x29
105f8a43c: 94727343    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a440: aa0003f4    	mov	x20, x0
105f8a444: b00d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f8a448: f9472d00    	ldr	x0, [x8, #0xe58]
105f8a44c: f94047e1    	ldr	x1, [sp, #0x88]
105f8a450: 9472733b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a454: aa0003e2    	mov	x2, x0
105f8a458: aa1403e0    	mov	x0, x20
105f8a45c: aa1803e1    	mov	x1, x24
105f8a460: 94727337    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a464: aa1d03fd    	mov	x29, x29
105f8a468: 94727338    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8a46c: aa0003f6    	mov	x22, x0
105f8a470: 900d0208    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8a474: f9425d01    	ldr	x1, [x8, #0x4b8] ; setMVoIPCallKitType:
105f8a478: 52800035    	mov	w21, #0x1               ; =1
105f8a47c: 52800022    	mov	w2, #0x1                ; =1
105f8a480: 9472732f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8a484: aa1603e0    	mov	x0, x22
105f8a488: 94727333    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a48c: aa1403e0    	mov	x0, x20
105f8a490: 94727331    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8a494: 17ffff4a    	b	0x105f8a1bc <_Flutter_MMFoundation_BindContext+0x2465da0>
