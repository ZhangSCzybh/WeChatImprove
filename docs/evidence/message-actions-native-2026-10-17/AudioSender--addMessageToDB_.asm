
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10017a3e0: d10143ff    	sub	sp, sp, #0x50
10017a3e4: a9015ff8    	stp	x24, x23, [sp, #0x10]
10017a3e8: a90257f6    	stp	x22, x21, [sp, #0x20]
10017a3ec: a9034ff4    	stp	x20, x19, [sp, #0x30]
10017a3f0: a9047bfd    	stp	x29, x30, [sp, #0x40]
10017a3f4: 910103fd    	add	x29, sp, #0x40
10017a3f8: aa0203f3    	mov	x19, x2
10017a3fc: aa0003f4    	mov	x20, x0
10017a400: f0105588    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
10017a404: 52800029    	mov	w9, #0x1                ; =1
10017a408: 391f1109    	strb	w9, [x8, #0x7c4]
10017a40c: aa0203e0    	mov	x0, x2
10017a410: 95eab34a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10017a414: b00fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017a418: f9459901    	ldr	x1, [x8, #0xb30] ; getChatName:
10017a41c: aa1403e0    	mov	x0, x20
10017a420: aa1303e2    	mov	x2, x19
10017a424: 95eab346    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a428: aa1d03fd    	mov	x29, x29
10017a42c: 95eab347    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a430: aa0003f4    	mov	x20, x0
10017a434: b4000740    	cbz	x0, 0x10017a51c <__text+0x17251c>
10017a438: b00fe628    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10017a43c: f9467101    	ldr	x1, [x8, #0xce0] ; UpdateContent:
10017a440: aa1303e0    	mov	x0, x19
10017a444: d2800002    	mov	x2, #0x0                ; =0
10017a448: 95eab33d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a44c: d00fe608    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10017a450: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
10017a454: aa1303e0    	mov	x0, x19
10017a458: 95eab339    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a45c: 35000980    	cbnz	w0, 0x10017a58c <__text+0x17258c>
10017a460: b00fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017a464: f9459d01    	ldr	x1, [x8, #0xb38] ; m_isEnterpriseMsg
10017a468: aa1303e0    	mov	x0, x19
10017a46c: 95eab334    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a470: aa0003f6    	mov	x22, x0
10017a474: b00fffc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10017a478: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10017a47c: d00ffc28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10017a480: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10017a484: 95eab32e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a488: aa1d03fd    	mov	x29, x29
10017a48c: 95eab32f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a490: aa0003f5    	mov	x21, x0
10017a494: b00ffc28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10017a498: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10017a49c: 340007d6    	cbz	w22, 0x10017a594 <__text+0x172594>
10017a4a0: f00fffc8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10017a4a4: f942a100    	ldr	x0, [x8, #0x540] ; ��- 
10017a4a8: 95eab325    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a4ac: aa0003e2    	mov	x2, x0
10017a4b0: f00fe5e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10017a4b4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10017a4b8: aa1503e0    	mov	x0, x21
10017a4bc: 95eab320    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a4c0: aa1d03fd    	mov	x29, x29
10017a4c4: 95eab321    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a4c8: aa0003f6    	mov	x22, x0
10017a4cc: b00fe628    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10017a4d0: f940d901    	ldr	x1, [x8, #0x1b0] ; m_nsToUsr
10017a4d4: aa1303e0    	mov	x0, x19
10017a4d8: 95eab319    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a4dc: aa1d03fd    	mov	x29, x29
10017a4e0: 95eab31a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a4e4: aa0003f7    	mov	x23, x0
10017a4e8: b00fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017a4ec: f945a101    	ldr	x1, [x8, #0xb40] ; AddMsg:MsgWrap:Brand:
10017a4f0: aa1603e0    	mov	x0, x22
10017a4f4: aa1403e2    	mov	x2, x20
10017a4f8: aa1303e3    	mov	x3, x19
10017a4fc: aa1703e4    	mov	x4, x23
10017a500: 95eab30f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a504: aa1703e0    	mov	x0, x23
10017a508: 95eab313    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017a50c: aa1603e0    	mov	x0, x22
10017a510: 95eab311    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017a514: aa1503e0    	mov	x0, x21
10017a518: 14000033    	b	0x10017a5e4 <__text+0x1725e4>
10017a51c: b00fffc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10017a520: f9453515    	ldr	x21, [x8, #0xa68] ; �gH 
10017a524: d00fe608    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10017a528: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
10017a52c: aa1303e0    	mov	x0, x19
10017a530: 95eab303    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a534: f00fe5e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10017a538: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10017a53c: 900f19a8    	adrp	x8, 0x11e4ae000 <dyld_stub_binder+0x11e4ae000>
10017a540: 91062108    	add	x8, x8, #0x188
10017a544: a90003e8    	stp	x8, x0, [sp]
10017a548: 900d85a3    	adrp	x3, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a54c: 911fe463    	add	x3, x3, #0x7f9
10017a550: 900d85a5    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a554: 912014a5    	add	x5, x5, #0x805
10017a558: 900d85a7    	adrp	x7, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a55c: 913a8ce7    	add	x7, x7, #0xea3
10017a560: aa1503e0    	mov	x0, x21
10017a564: 52800082    	mov	w2, #0x4                ; =4
10017a568: 52800004    	mov	w4, #0x0                ; =0
10017a56c: 52806a66    	mov	w6, #0x353              ; =851
10017a570: 95eab2f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a574: 528013c0    	mov	w0, #0x9e               ; =158
10017a578: 528007c1    	mov	w1, #0x3e               ; =62
10017a57c: 52800022    	mov	w2, #0x1                ; =1
10017a580: 52800003    	mov	w3, #0x0                ; =0
10017a584: 52800004    	mov	w4, #0x0                ; =0
10017a588: 947756fd    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10017a58c: 52800015    	mov	w21, #0x0               ; =0
10017a590: 14000017    	b	0x10017a5ec <__text+0x1725ec>
10017a594: d00fffc8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10017a598: f9403100    	ldr	x0, [x8, #0x60] ; ��7 
10017a59c: 95eab2e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a5a0: aa0003e2    	mov	x2, x0
10017a5a4: f00fe5e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10017a5a8: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10017a5ac: aa1503e0    	mov	x0, x21
10017a5b0: 95eab2e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a5b4: aa1d03fd    	mov	x29, x29
10017a5b8: 95eab2e4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a5bc: aa0003f6    	mov	x22, x0
10017a5c0: aa1503e0    	mov	x0, x21
10017a5c4: 95eab2e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017a5c8: b00fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017a5cc: f945a501    	ldr	x1, [x8, #0xb48] ; AddMsg:MsgWrap:
10017a5d0: aa1603e0    	mov	x0, x22
10017a5d4: aa1403e2    	mov	x2, x20
10017a5d8: aa1303e3    	mov	x3, x19
10017a5dc: 95eab2d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a5e0: aa1603e0    	mov	x0, x22
10017a5e4: 95eab2dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017a5e8: 52800035    	mov	w21, #0x1               ; =1
10017a5ec: aa1403e0    	mov	x0, x20
10017a5f0: 95eab2d9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017a5f4: aa1303e0    	mov	x0, x19
10017a5f8: 95eab2d7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017a5fc: aa1503e0    	mov	x0, x21
10017a600: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10017a604: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10017a608: a94257f6    	ldp	x22, x21, [sp, #0x20]
10017a60c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10017a610: 910143ff    	add	sp, sp, #0x50
10017a614: d65f03c0    	ret