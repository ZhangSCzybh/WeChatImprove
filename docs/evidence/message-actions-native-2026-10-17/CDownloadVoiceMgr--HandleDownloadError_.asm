
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1011763e8: d10243ff    	sub	sp, sp, #0x90
1011763ec: a9036ffc    	stp	x28, x27, [sp, #0x30]
1011763f0: a90467fa    	stp	x26, x25, [sp, #0x40]
1011763f4: a9055ff8    	stp	x24, x23, [sp, #0x50]
1011763f8: a90657f6    	stp	x22, x21, [sp, #0x60]
1011763fc: a9074ff4    	stp	x20, x19, [sp, #0x70]
101176400: a9087bfd    	stp	x29, x30, [sp, #0x80]
101176404: 910203fd    	add	x29, sp, #0x80
101176408: aa0203f3    	mov	x19, x2
10117640c: aa0003f4    	mov	x20, x0
101176410: f00fd5c8    	adrp	x8, 0x120c31000 <dyld_stub_binder+0x120c31000>
101176414: 52800029    	mov	w9, #0x1                ; =1
101176418: 39097909    	strb	w9, [x8, #0x25e]
10117641c: aa0203e0    	mov	x0, x2
101176420: 95aac346    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101176424: b4000c13    	cbz	x19, 0x1011765a4 <__text+0x116e5a4>
101176428: b00f83a8    	adrp	x8, 0x1201eb000 <dyld_stub_binder+0x1201eb000>
10117642c: b982e508    	ldrsw	x8, [x8, #0x2e4]
101176430: 8b080280    	add	x0, x20, x8
101176434: 95aac356    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101176438: aa0003f7    	mov	x23, x0
10117643c: 900f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101176440: f9448501    	ldr	x1, [x8, #0x908] ; m_nsChatUsrName
101176444: f90017e1    	str	x1, [sp, #0x28]
101176448: aa1303e0    	mov	x0, x19
10117644c: 95aac33c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101176450: aa1d03fd    	mov	x29, x29
101176454: 95aac33d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101176458: aa0003f8    	mov	x24, x0
10117645c: b00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101176460: f9467501    	ldr	x1, [x8, #0xce8] ; m_uiLocalID
101176464: f90013e1    	str	x1, [sp, #0x20]
101176468: aa1303e0    	mov	x0, x19
10117646c: 95aac334    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101176470: b9001fe0    	str	w0, [sp, #0x1c]
101176474: b00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101176478: f9467901    	ldr	x1, [x8, #0xcf0] ; m_n64SvrID
10117647c: aa1303e0    	mov	x0, x19
101176480: 95aac32f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101176484: aa0003fa    	mov	x26, x0
101176488: d00f6628    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10117648c: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
101176490: aa1303e0    	mov	x0, x19
101176494: 95aac32a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101176498: aa0003fb    	mov	x27, x0
10117649c: b00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1011764a0: f943ed01    	ldr	x1, [x8, #0x7d8] ; m_uiVoiceTime
1011764a4: aa1303e0    	mov	x0, x19
1011764a8: 95aac325    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011764ac: aa0003fc    	mov	x28, x0
1011764b0: b00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1011764b4: f9467d01    	ldr	x1, [x8, #0xcf8] ; m_uiOffset
1011764b8: aa1303e0    	mov	x0, x19
1011764bc: 95aac320    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011764c0: aa0003f9    	mov	x25, x0
1011764c4: b00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1011764c8: f9468101    	ldr	x1, [x8, #0xd00] ; m_uiLen
1011764cc: aa1303e0    	mov	x0, x19
1011764d0: 95aac31b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011764d4: aa0003f5    	mov	x21, x0
1011764d8: b00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1011764dc: f9456501    	ldr	x1, [x8, #0xac8] ; m_dtVoice
1011764e0: aa1303e0    	mov	x0, x19
1011764e4: 95aac316    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011764e8: aa1d03fd    	mov	x29, x29
1011764ec: 95aac317    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1011764f0: aa0003f6    	mov	x22, x0
1011764f4: 900f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
1011764f8: f9447501    	ldr	x1, [x8, #0x8e8] ; OnRecvData:MesLocalID:n64MesSvrID:CreateTime:VoiceTime:Offset:Len:Data:EndFlag:ErrNo:
1011764fc: d2c00088    	mov	x8, #0x400000000        ; =17179869184
101176500: a900a3e0    	stp	x0, x8, [sp, #0x8]
101176504: b90003f5    	str	w21, [sp]
101176508: aa1703e0    	mov	x0, x23
10117650c: aa1803e2    	mov	x2, x24
101176510: b9401fe3    	ldr	w3, [sp, #0x1c]
101176514: aa1a03e4    	mov	x4, x26
101176518: aa1b03e5    	mov	x5, x27
10117651c: aa1c03e6    	mov	x6, x28
101176520: aa1903e7    	mov	x7, x25
101176524: 95aac306    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101176528: aa1603e0    	mov	x0, x22
10117652c: 95aac30a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101176530: aa1803e0    	mov	x0, x24
101176534: 95aac308    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101176538: aa1703e0    	mov	x0, x23
10117653c: 95aac306    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101176540: aa1303e0    	mov	x0, x19
101176544: f94017e1    	ldr	x1, [sp, #0x28]
101176548: 95aac2fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10117654c: aa1d03fd    	mov	x29, x29
101176550: 95aac2fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101176554: aa0003f5    	mov	x21, x0
101176558: aa1303e0    	mov	x0, x19
10117655c: f94013e1    	ldr	x1, [sp, #0x20]
101176560: 95aac2f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101176564: aa0003e3    	mov	x3, x0
101176568: 900f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
10117656c: f944e501    	ldr	x1, [x8, #0x9c8] ; DeleteMsg:LocalID:
101176570: aa1403e0    	mov	x0, x20
101176574: aa1503e2    	mov	x2, x21
101176578: 95aac2f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10117657c: aa1503e0    	mov	x0, x21
101176580: 95aac2f5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101176584: b00f83a8    	adrp	x8, 0x1201eb000 <dyld_stub_binder+0x1201eb000>
101176588: b982e108    	ldrsw	x8, [x8, #0x2e0]
10117658c: b8286a9f    	str	wzr, [x20, x8]
101176590: 900f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101176594: f944b901    	ldr	x1, [x8, #0x970] ; CheckDownloadQueue
101176598: aa1403e0    	mov	x0, x20
10117659c: 95aac2e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011765a0: 14000012    	b	0x1011765e8 <__text+0x116e5e8>
1011765a4: b00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1011765a8: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
1011765ac: f00f6608    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1011765b0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1011765b4: 900e9ee8    	adrp	x8, 0x11e552000 <dyld_stub_binder+0x11e552000>
1011765b8: 91242108    	add	x8, x8, #0x908
1011765bc: f90003e8    	str	x8, [sp]
1011765c0: f00d0563    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
1011765c4: 9107f063    	add	x3, x3, #0x1fc
1011765c8: d00d1025    	adrp	x5, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
1011765cc: 9120a4a5    	add	x5, x5, #0x829
1011765d0: d00d1027    	adrp	x7, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
1011765d4: 9130ace7    	add	x7, x7, #0xc2b
1011765d8: 52800082    	mov	w2, #0x4                ; =4
1011765dc: 52800004    	mov	w4, #0x0                ; =0
1011765e0: 528034a6    	mov	w6, #0x1a5              ; =421
1011765e4: 95aac2d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011765e8: aa1303e0    	mov	x0, x19
1011765ec: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1011765f0: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1011765f4: a94657f6    	ldp	x22, x21, [sp, #0x60]
1011765f8: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1011765fc: a94467fa    	ldp	x26, x25, [sp, #0x40]
101176600: a9436ffc    	ldp	x28, x27, [sp, #0x30]
101176604: 910243ff    	add	sp, sp, #0x90
101176608: 15aac2d3    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>