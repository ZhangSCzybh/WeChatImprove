
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a75c8: d10243ff    	sub	sp, sp, #0x90
1002a75cc: a9036ffc    	stp	x28, x27, [sp, #0x30]
1002a75d0: a90467fa    	stp	x26, x25, [sp, #0x40]
1002a75d4: a9055ff8    	stp	x24, x23, [sp, #0x50]
1002a75d8: a90657f6    	stp	x22, x21, [sp, #0x60]
1002a75dc: a9074ff4    	stp	x20, x19, [sp, #0x70]
1002a75e0: a9087bfd    	stp	x29, x30, [sp, #0x80]
1002a75e4: 910203fd    	add	x29, sp, #0x80
1002a75e8: aa0203f3    	mov	x19, x2
1002a75ec: aa0003f4    	mov	x20, x0
1002a75f0: d0104c28    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002a75f4: 52800029    	mov	w9, #0x1                ; =1
1002a75f8: 39314109    	strb	w9, [x8, #0xc50]
1002a75fc: aa0203e0    	mov	x0, x2
1002a7600: 95e5fece    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a7604: f00fdca8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a7608: f9410916    	ldr	x22, [x8, #0x210] ; viewModel
1002a760c: aa1403e0    	mov	x0, x20
1002a7610: aa1603e1    	mov	x1, x22
1002a7614: 95e5feca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a7618: aa1d03fd    	mov	x29, x29
1002a761c: 95e5fecb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a7620: aa0003f5    	mov	x21, x0
1002a7624: 900fdcc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a7628: f940d501    	ldr	x1, [x8, #0x1a8] ; isSender
1002a762c: 95e5fec4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a7630: aa0003f7    	mov	x23, x0
1002a7634: aa1503e0    	mov	x0, x21
1002a7638: 95e5fec7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a763c: 34000c37    	cbz	w23, 0x1002a77c0 <__text+0x29f7c0>
1002a7640: 900ff9c8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002a7644: 91086108    	add	x8, x8, #0x218
1002a7648: b9800108    	ldrsw	x8, [x8]
1002a764c: 8b080280    	add	x0, x20, x8
1002a7650: 95e5fecf    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1002a7654: aa0003f5    	mov	x21, x0
1002a7658: f00fdd08    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a765c: f9431901    	ldr	x1, [x8, #0x630] ; isMsgCanRevoke:
1002a7660: aa1303e2    	mov	x2, x19
1002a7664: 95e5feb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a7668: aa0003f7    	mov	x23, x0
1002a766c: aa1503e0    	mov	x0, x21
1002a7670: 95e5feb9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a7674: 34000a77    	cbz	w23, 0x1002a77c0 <__text+0x29f7c0>
1002a7678: 900ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a767c: f9467900    	ldr	x0, [x8, #0xcf0] ; ��b 
1002a7680: b00fdca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1002a7684: f9403501    	ldr	x1, [x8, #0x68] ; genServerCurrentTime
1002a7688: 95e5fead    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a768c: aa0003f5    	mov	x21, x0
1002a7690: b00fdca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1002a7694: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
1002a7698: aa1303e0    	mov	x0, x19
1002a769c: 95e5fea8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a76a0: aa0003f7    	mov	x23, x0
1002a76a4: aa1403e0    	mov	x0, x20
1002a76a8: aa1603e1    	mov	x1, x22
1002a76ac: 95e5fea4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a76b0: aa1d03fd    	mov	x29, x29
1002a76b4: 95e5fea5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a76b8: aa0003f6    	mov	x22, x0
1002a76bc: 900fdcc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a76c0: f944c501    	ldr	x1, [x8, #0x988] ; revokeTimeLimitInSecond
1002a76c4: 95e5fe9e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a76c8: 0b17001b    	add	w27, w0, w23
1002a76cc: aa1603e0    	mov	x0, x22
1002a76d0: 95e5fea1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a76d4: 900fdca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002a76d8: f9450101    	ldr	x1, [x8, #0xa00] ; m_uiStatus
1002a76dc: aa1303e0    	mov	x0, x19
1002a76e0: 95e5fe97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a76e4: aa0003f7    	mov	x23, x0
1002a76e8: 900ff668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a76ec: f9453519    	ldr	x25, [x8, #0xa68] ; �gH 
1002a76f0: b00fdca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1002a76f4: f947d516    	ldr	x22, [x8, #0xfa8] ; m_n64MesSvrID
1002a76f8: aa1303e0    	mov	x0, x19
1002a76fc: aa1603e1    	mov	x1, x22
1002a7700: 95e5fe8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a7704: aa0003fa    	mov	x26, x0
1002a7708: b00fdcc8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002a770c: f9427518    	ldr	x24, [x8, #0x4e8] ; m_overwriteNewMsgId
1002a7710: aa1303e0    	mov	x0, x19
1002a7714: aa1803e1    	mov	x1, x24
1002a7718: 95e5fe89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a771c: d00fdc88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002a7720: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1002a7724: a90203fa    	stp	x26, x0, [sp, #0x20]
1002a7728: a9015ffb    	stp	x27, x23, [sp, #0x10]
1002a772c: 900f10a8    	adrp	x8, 0x11e4bb000 <dyld_stub_binder+0x11e4bb000>
1002a7730: 91322108    	add	x8, x8, #0xc88
1002a7734: a90057e8    	stp	x8, x21, [sp]
1002a7738: f00d7ce5    	adrp	x5, 0x11b246000 <dyld_stub_binder+0x11b246000>
1002a773c: 911eb4a5    	add	x5, x5, #0x7ad
1002a7740: f00d7ce7    	adrp	x7, 0x11b246000 <dyld_stub_binder+0x11b246000>
1002a7744: 911f3ce7    	add	x7, x7, #0x7cf
1002a7748: aa1903e0    	mov	x0, x25
1002a774c: 52800042    	mov	w2, #0x2                ; =2
1002a7750: d2800003    	mov	x3, #0x0                ; =0
1002a7754: 52800004    	mov	w4, #0x0                ; =0
1002a7758: 52806ca6    	mov	w6, #0x365              ; =869
1002a775c: 95e5fe78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a7760: 710032ff    	cmp	w23, #0xc
1002a7764: 54000168    	b.hi	0x1002a7790 <__text+0x29f790>
1002a7768: 52800028    	mov	w8, #0x1                ; =1
1002a776c: 1ad72108    	lsl	w8, w8, w23
1002a7770: 52838049    	mov	w9, #0x1c02             ; =7170
1002a7774: 6a09011f    	tst	w8, w9
1002a7778: 540000c0    	b.eq	0x1002a7790 <__text+0x29f790>
1002a777c: f00fdd08    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a7780: f9431d01    	ldr	x1, [x8, #0x638] ; canRevokeWhenSending
1002a7784: aa1403e0    	mov	x0, x20
1002a7788: 95e5fe6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a778c: 37000120    	tbnz	w0, #0x0, 0x1002a77b0 <__text+0x29f7b0>
1002a7790: f00fdca8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a7794: f9413d01    	ldr	x1, [x8, #0x278] ; m_uiMessageType
1002a7798: aa1303e0    	mov	x0, x19
1002a779c: 95e5fe68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a77a0: 71001eff    	cmp	w23, #0x7
1002a77a4: 540000a1    	b.ne	0x1002a77b8 <__text+0x29f7b8>
1002a77a8: 7100ac1f    	cmp	w0, #0x2b
1002a77ac: 54000061    	b.ne	0x1002a77b8 <__text+0x29f7b8>
1002a77b0: 52800034    	mov	w20, #0x1               ; =1
1002a77b4: 14000004    	b	0x1002a77c4 <__text+0x29f7c4>
1002a77b8: 6b1b02bf    	cmp	w21, w27
1002a77bc: 540001a9    	b.ls	0x1002a77f0 <__text+0x29f7f0>
1002a77c0: 52800014    	mov	w20, #0x0               ; =0
1002a77c4: aa1303e0    	mov	x0, x19
1002a77c8: 95e5fe63    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a77cc: aa1403e0    	mov	x0, x20
1002a77d0: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1002a77d4: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1002a77d8: a94657f6    	ldp	x22, x21, [sp, #0x60]
1002a77dc: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1002a77e0: a94467fa    	ldp	x26, x25, [sp, #0x40]
1002a77e4: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1002a77e8: 910243ff    	add	sp, sp, #0x90
1002a77ec: d65f03c0    	ret
1002a77f0: 51000ae8    	sub	w8, w23, #0x2
1002a77f4: 71000d1f    	cmp	w8, #0x3
1002a77f8: 54fffdc3    	b.lo	0x1002a77b0 <__text+0x29f7b0>
1002a77fc: aa1303e0    	mov	x0, x19
1002a7800: aa1803e1    	mov	x1, x24
1002a7804: 95e5fe4e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a7808: f100001f    	cmp	x0, #0x0
1002a780c: 54fffd2c    	b.gt	0x1002a77b0 <__text+0x29f7b0>
1002a7810: aa1303e0    	mov	x0, x19
1002a7814: aa1603e1    	mov	x1, x22
1002a7818: 95e5fe49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a781c: f100001f    	cmp	x0, #0x0
1002a7820: 1a9fd7f4    	cset	w20, gt
1002a7824: 17ffffe8    	b	0x1002a77c4 <__text+0x29f7c4>