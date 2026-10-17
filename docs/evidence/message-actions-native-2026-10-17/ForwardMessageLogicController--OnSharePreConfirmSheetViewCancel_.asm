
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c3237c: d10143ff    	sub	sp, sp, #0x50
101c32380: a9015ff8    	stp	x24, x23, [sp, #0x10]
101c32384: a90257f6    	stp	x22, x21, [sp, #0x20]
101c32388: a9034ff4    	stp	x20, x19, [sp, #0x30]
101c3238c: a9047bfd    	stp	x29, x30, [sp, #0x40]
101c32390: 910103fd    	add	x29, sp, #0x40
101c32394: aa0003f3    	mov	x19, x0
101c32398: b00f8008    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c3239c: 52800029    	mov	w9, #0x1                ; =1
101c323a0: 3925cd09    	strb	w9, [x8, #0x973]
101c323a4: d00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c323a8: f946c101    	ldr	x1, [x8, #0xd80] ; restoreMsgListsFromConvertBackupIfNeeded
101c323ac: 957fd364    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c323b0: d00f2e08    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c323b4: b9891508    	ldrsw	x8, [x8, #0x914]
101c323b8: f8686a60    	ldr	x0, [x19, x8]
101c323bc: b4000080    	cbz	x0, 0x101c323cc <_Flutter_Image_provideRelativePathByUrl+0x3f27c>
101c323c0: d00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c323c4: f946c501    	ldr	x1, [x8, #0xd88] ; cancelForwording
101c323c8: 957fd35d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c323cc: d00f2e08    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c323d0: b9890517    	ldrsw	x23, [x8, #0x904]
101c323d4: f8776a60    	ldr	x0, [x19, x23]
101c323d8: d00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c323dc: f9466501    	ldr	x1, [x8, #0xcc8] ; bGroupUndoneFlag
101c323e0: 957fd357    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c323e4: aa0003f4    	mov	x20, x0
101c323e8: f8776a60    	ldr	x0, [x19, x23]
101c323ec: d00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c323f0: f9466915    	ldr	x21, [x8, #0xcd0] ; groupUndoneShareReport
101c323f4: aa1503e1    	mov	x1, x21
101c323f8: 957fd351    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c323fc: aa1d03fd    	mov	x29, x29
101c32400: 957fd352    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c32404: aa0003f6    	mov	x22, x0
101c32408: d00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c3240c: f9466d01    	ldr	x1, [x8, #0xcd8] ; setIsOpenTodo:
101c32410: aa1403e2    	mov	x2, x20
101c32414: 957fd34a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c32418: aa1603e0    	mov	x0, x22
101c3241c: 957fd34e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c32420: f8776a60    	ldr	x0, [x19, x23]
101c32424: aa1503e1    	mov	x1, x21
101c32428: 957fd345    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3242c: aa1d03fd    	mov	x29, x29
101c32430: 957fd346    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c32434: aa0003f4    	mov	x20, x0
101c32438: d00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c3243c: f9467101    	ldr	x1, [x8, #0xce0] ; setOper:
101c32440: 52800022    	mov	w2, #0x1                ; =1
101c32444: 957fd33e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c32448: aa1403e0    	mov	x0, x20
101c3244c: 957fd342    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c32450: f8776a60    	ldr	x0, [x19, x23]
101c32454: aa1503e1    	mov	x1, x21
101c32458: 957fd339    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3245c: aa1d03fd    	mov	x29, x29
101c32460: 957fd33a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c32464: aa0003f4    	mov	x20, x0
101c32468: b00f10c8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
101c3246c: f9420101    	ldr	x1, [x8, #0x400] ; report
101c32470: 957fd333    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c32474: aa1403e0    	mov	x0, x20
101c32478: 957fd337    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3247c: d00f2e08    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c32480: b9890118    	ldrsw	x24, [x8, #0x900]
101c32484: f8786a62    	ldr	x2, [x19, x24]
101c32488: d00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c3248c: f946c901    	ldr	x1, [x8, #0xd90] ; setCancelSendContacts:
101c32490: aa1303e0    	mov	x0, x19
101c32494: 957fd32a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c32498: f8786a60    	ldr	x0, [x19, x24]
101c3249c: f8386a7f    	str	xzr, [x19, x24]
101c324a0: 957fd32d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c324a4: f8776a60    	ldr	x0, [x19, x23]
101c324a8: d00f10c8    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
101c324ac: f943f101    	ldr	x1, [x8, #0x7e0] ; dismissWithAnimated:
101c324b0: 52800022    	mov	w2, #0x1                ; =1
101c324b4: 957fd322    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c324b8: d00f2e08    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c324bc: b9894108    	ldrsw	x8, [x8, #0x940]
101c324c0: f8686a60    	ldr	x0, [x19, x8]
101c324c4: f8286a7f    	str	xzr, [x19, x8]
101c324c8: 957fd323    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c324cc: d00f2e08    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c324d0: b9893108    	ldrsw	x8, [x8, #0x930]
101c324d4: 38286a7f    	strb	wzr, [x19, x8]
101c324d8: d00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c324dc: f9456914    	ldr	x20, [x8, #0xad0] ; eMultiForwardType
101c324e0: aa1303e0    	mov	x0, x19
101c324e4: aa1403e1    	mov	x1, x20
101c324e8: 957fd315    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c324ec: f100041f    	cmp	x0, #0x1
101c324f0: 540000c0    	b.eq	0x101c32508 <_Flutter_Image_provideRelativePathByUrl+0x3f3b8>
101c324f4: aa1303e0    	mov	x0, x19
101c324f8: aa1403e1    	mov	x1, x20
101c324fc: 957fd310    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c32500: f100081f    	cmp	x0, #0x2
101c32504: 54000501    	b.ne	0x101c325a4 <_Flutter_Image_provideRelativePathByUrl+0x3f454>
101c32508: aa1303e0    	mov	x0, x19
101c3250c: aa1403e1    	mov	x1, x20
101c32510: 957fd30b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c32514: d00f2e08    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c32518: 9123e108    	add	x8, x8, #0x8f8
101c3251c: d00f2e09    	adrp	x9, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c32520: 91244129    	add	x9, x9, #0x910
101c32524: f100041f    	cmp	x0, #0x1
101c32528: 9a880128    	csel	x8, x9, x8, eq
101c3252c: b9800108    	ldrsw	x8, [x8]
101c32530: f8686a75    	ldr	x21, [x19, x8]
101c32534: f00f2a08    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
101c32538: f946c916    	ldr	x22, [x8, #0xd90]
101c3253c: f8786a77    	ldr	x23, [x19, x24]
101c32540: d00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c32544: f9457118    	ldr	x24, [x8, #0xae0] ; m_uiIDKeyScene
101c32548: aa1503e0    	mov	x0, x21
101c3254c: 957fd2fb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c32550: aa1303e0    	mov	x0, x19
101c32554: aa1803e1    	mov	x1, x24
101c32558: 957fd2f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3255c: aa0003f8    	mov	x24, x0
101c32560: aa1303e0    	mov	x0, x19
101c32564: aa1403e1    	mov	x1, x20
101c32568: 957fd2f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3256c: f100041f    	cmp	x0, #0x1
101c32570: 1a9f17e6    	cset	w6, eq
101c32574: d00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c32578: f9468d01    	ldr	x1, [x8, #0xd18] ; StatForwardMultiMsgs:targets:scene:didSend:isRecord:isToWeWork:hasMessage:
101c3257c: 390003ff    	strb	wzr, [sp]
101c32580: aa1603e0    	mov	x0, x22
101c32584: aa1503e2    	mov	x2, x21
101c32588: aa1703e3    	mov	x3, x23
101c3258c: aa1803e4    	mov	x4, x24
101c32590: 52800005    	mov	w5, #0x0                ; =0
101c32594: 52800007    	mov	w7, #0x0                ; =0
101c32598: 957fd2e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3259c: aa1503e0    	mov	x0, x21
101c325a0: 957fd2ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c325a4: d00f2e08    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c325a8: b9892518    	ldrsw	x24, [x8, #0x924]
101c325ac: 8b180260    	add	x0, x19, x24
101c325b0: 957fd2f7    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c325b4: b40003c0    	cbz	x0, 0x101c3262c <_Flutter_Image_provideRelativePathByUrl+0x3f4dc>
101c325b8: aa0003f5    	mov	x21, x0
101c325bc: 8b180260    	add	x0, x19, x24
101c325c0: 957fd2f3    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c325c4: aa0003f6    	mov	x22, x0
101c325c8: d00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c325cc: f946cd14    	ldr	x20, [x8, #0xd98] ; OnForwardMessageConfirmCanceled:
101c325d0: 900f26a8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101c325d4: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
101c325d8: aa1403e2    	mov	x2, x20
101c325dc: 957fd2d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c325e0: aa0003f7    	mov	x23, x0
101c325e4: aa1603e0    	mov	x0, x22
101c325e8: 957fd2db    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c325ec: aa1503e0    	mov	x0, x21
101c325f0: 957fd2d9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c325f4: 340001d7    	cbz	w23, 0x101c3262c <_Flutter_Image_provideRelativePathByUrl+0x3f4dc>
101c325f8: 8b180260    	add	x0, x19, x24
101c325fc: 957fd2e4    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c32600: aa0003f5    	mov	x21, x0
101c32604: aa1403e1    	mov	x1, x20
101c32608: aa1303e2    	mov	x2, x19
101c3260c: 957fd2cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c32610: aa1503e0    	mov	x0, x21
101c32614: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101c32618: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101c3261c: a94257f6    	ldp	x22, x21, [sp, #0x20]
101c32620: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101c32624: 910143ff    	add	sp, sp, #0x50
101c32628: 157fd2cb    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3262c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101c32630: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101c32634: a94257f6    	ldp	x22, x21, [sp, #0x20]
101c32638: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101c3263c: 910143ff    	add	sp, sp, #0x50
101c32640: d65f03c0    	ret