
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101175198: d10443ff    	sub	sp, sp, #0x110
10117519c: a90b6ffc    	stp	x28, x27, [sp, #0xb0]
1011751a0: a90c67fa    	stp	x26, x25, [sp, #0xc0]
1011751a4: a90d5ff8    	stp	x24, x23, [sp, #0xd0]
1011751a8: a90e57f6    	stp	x22, x21, [sp, #0xe0]
1011751ac: a90f4ff4    	stp	x20, x19, [sp, #0xf0]
1011751b0: a9107bfd    	stp	x29, x30, [sp, #0x100]
1011751b4: 910403fd    	add	x29, sp, #0x100
1011751b8: aa0703f5    	mov	x21, x7
1011751bc: aa0603f3    	mov	x19, x6
1011751c0: aa0503f4    	mov	x20, x5
1011751c4: aa0403fc    	mov	x28, x4
1011751c8: aa0303f7    	mov	x23, x3
1011751cc: aa0203f8    	mov	x24, x2
1011751d0: aa0003f9    	mov	x25, x0
1011751d4: 900fd5e8    	adrp	x8, 0x120c31000 <dyld_stub_binder+0x120c31000>
1011751d8: 52800029    	mov	w9, #0x1                ; =1
1011751dc: 39096d09    	strb	w9, [x8, #0x25b]
1011751e0: aa0203e0    	mov	x0, x2
1011751e4: 95aac7d5    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1011751e8: aa1503e0    	mov	x0, x21
1011751ec: 95aac7d3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1011751f0: f00f8028    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
1011751f4: f9443100    	ldr	x0, [x8, #0x860]
1011751f8: b00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
1011751fc: f9444901    	ldr	x1, [x8, #0x890] ; parseVoiceXml:
101175200: aa1303e2    	mov	x2, x19
101175204: 95aac7ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175208: aa1d03fd    	mov	x29, x29
10117520c: 95aac7cf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101175210: aa0003fb    	mov	x27, x0
101175214: d00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101175218: f945351a    	ldr	x26, [x8, #0xa68]
10117521c: d00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101175220: f9454500    	ldr	x0, [x8, #0xa88]
101175224: f00f6628    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101175228: f947c913    	ldr	x19, [x8, #0xf90] ; generatePrivacyString:
10117522c: aa1303e1    	mov	x1, x19
101175230: aa1803e2    	mov	x2, x24
101175234: 95aac7c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175238: aa1d03fd    	mov	x29, x29
10117523c: 95aac7c3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101175240: aa0003f6    	mov	x22, x0
101175244: b400199b    	cbz	x27, 0x101175574 <__text+0x116d574>
101175248: f9002ff3    	str	x19, [sp, #0x58]
10117524c: f90043f9    	str	x25, [sp, #0x80]
101175250: f81883b8    	stur	x24, [x29, #-0x78]
101175254: d00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101175258: f9468501    	ldr	x1, [x8, #0xd08] ; m_uiEndFlag
10117525c: f9003be1    	str	x1, [sp, #0x70]
101175260: aa1b03e0    	mov	x0, x27
101175264: 95aac7b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175268: a9066be0    	stp	x0, x26, [sp, #0x60]
10117526c: b00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101175270: f9444d1a    	ldr	x26, [x8, #0x898] ; m_uiVoiceLen
101175274: aa1b03e0    	mov	x0, x27
101175278: aa1a03e1    	mov	x1, x26
10117527c: 95aac7b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175280: f81903b4    	stur	x20, [x29, #-0x70]
101175284: aa0003f4    	mov	x20, x0
101175288: d00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10117528c: f943ed18    	ldr	x24, [x8, #0x7d8] ; m_uiVoiceTime
101175290: aa1b03e0    	mov	x0, x27
101175294: aa1803e1    	mov	x1, x24
101175298: 95aac7a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10117529c: aa1c03f9    	mov	x25, x28
1011752a0: aa0003fc    	mov	x28, x0
1011752a4: d00f7c68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1011752a8: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1011752ac: aa1503e0    	mov	x0, x21
1011752b0: f9002be1    	str	x1, [sp, #0x50]
1011752b4: 95aac7a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011752b8: f9003ff5    	str	x21, [sp, #0x78]
1011752bc: aa0003f5    	mov	x21, x0
1011752c0: b00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
1011752c4: f9445113    	ldr	x19, [x8, #0x8a0] ; m_uiCancelFlag
1011752c8: aa1b03e0    	mov	x0, x27
1011752cc: aa1303e1    	mov	x1, x19
1011752d0: 95aac79b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011752d4: 900f6628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1011752d8: f942a908    	ldr	x8, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1011752dc: a90403f5    	stp	x21, x0, [sp, #0x40]
1011752e0: a90373f4    	stp	x20, x28, [sp, #0x30]
1011752e4: aa0803f4    	mov	x20, x8
1011752e8: f85903b5    	ldur	x21, [x29, #-0x70]
1011752ec: b00e9ee8    	adrp	x8, 0x11e552000 <dyld_stub_binder+0x11e552000>
1011752f0: 9120a108    	add	x8, x8, #0x828
1011752f4: 900d0583    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
1011752f8: 9107f063    	add	x3, x3, #0x1fc
1011752fc: f00d1025    	adrp	x5, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101175300: 9120a4a5    	add	x5, x5, #0x829
101175304: f00d1027    	adrp	x7, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101175308: 912730e7    	add	x7, x7, #0x9cc
10117530c: a94603e9    	ldp	x9, x0, [sp, #0x60]
101175310: a90227f5    	stp	x21, x9, [sp, #0x20]
101175314: a90167f7    	stp	x23, x25, [sp, #0x10]
101175318: aa1703fc    	mov	x28, x23
10117531c: a9005be8    	stp	x8, x22, [sp]
101175320: aa1403e1    	mov	x1, x20
101175324: 52800042    	mov	w2, #0x2                ; =2
101175328: 52800004    	mov	w4, #0x0                ; =0
10117532c: 528016e6    	mov	w6, #0xb7               ; =183
101175330: 95aac783    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175334: aa1603e0    	mov	x0, x22
101175338: 95aac787    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10117533c: aa1b03e0    	mov	x0, x27
101175340: f9403be1    	ldr	x1, [sp, #0x70]
101175344: 95aac77e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175348: b90073e0    	str	w0, [sp, #0x70]
10117534c: aa1b03e0    	mov	x0, x27
101175350: aa1a03e1    	mov	x1, x26
101175354: 95aac77a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175358: aa0003f6    	mov	x22, x0
10117535c: aa1b03e0    	mov	x0, x27
101175360: aa1803e1    	mov	x1, x24
101175364: 95aac776    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175368: aa0003f8    	mov	x24, x0
10117536c: aa1b03e0    	mov	x0, x27
101175370: aa1303e1    	mov	x1, x19
101175374: 95aac772    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175378: aa0003f3    	mov	x19, x0
10117537c: b00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101175380: f9445501    	ldr	x1, [x8, #0x8a8] ; m_ui64BufId
101175384: aa1b03e0    	mov	x0, x27
101175388: 95aac76d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10117538c: 7100067f    	cmp	w19, #0x1
101175390: 540011e1    	b.ne	0x1011755cc <__text+0x116d5cc>
101175394: d00f83a8    	adrp	x8, 0x1201eb000 <dyld_stub_binder+0x1201eb000>
101175398: b982d908    	ldrsw	x8, [x8, #0x2d8]
10117539c: f94043f3    	ldr	x19, [sp, #0x80]
1011753a0: f8686a61    	ldr	x1, [x19, x8]
1011753a4: d101a3a0    	sub	x0, x29, #0x68
1011753a8: 95aa5fe2    	bl	0x107c0d330 <_Flutter_MMFoundation_BindContext+0x40e8f14>
1011753ac: b00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
1011753b0: f944e501    	ldr	x1, [x8, #0x9c8] ; DeleteMsg:LocalID:
1011753b4: aa1303e0    	mov	x0, x19
1011753b8: f85883b8    	ldur	x24, [x29, #-0x78]
1011753bc: aa1803e2    	mov	x2, x24
1011753c0: aa1c03e3    	mov	x3, x28
1011753c4: 95aac75e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011753c8: f00f7fe8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1011753cc: f9411d00    	ldr	x0, [x8, #0x238]
1011753d0: 95aac764    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1011753d4: f00f6628    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1011753d8: f9452d01    	ldr	x1, [x8, #0xa58] ; initWithMsgType:
1011753dc: 52800022    	mov	w2, #0x1                ; =1
1011753e0: 95aac757    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011753e4: aa0003fa    	mov	x26, x0
1011753e8: f00f6628    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1011753ec: f9453101    	ldr	x1, [x8, #0xa60] ; setM_nsFromUsr:
1011753f0: aa1803e2    	mov	x2, x24
1011753f4: 95aac752    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011753f8: d00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1011753fc: f9467900    	ldr	x0, [x8, #0xcf0]
101175400: 900f6668    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
101175404: f9462501    	ldr	x1, [x8, #0xc48] ; CheckUsrNameType:
101175408: aa1803e2    	mov	x2, x24
10117540c: 95aac74c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175410: aa0003e2    	mov	x2, x0
101175414: d00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101175418: f9471100    	ldr	x0, [x8, #0xe20]
10117541c: 900f6648    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
101175420: f947e901    	ldr	x1, [x8, #0xfd0] ; getLocalUsrName:
101175424: 95aac746    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175428: aa1d03fd    	mov	x29, x29
10117542c: 95aac747    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101175430: aa0003f3    	mov	x19, x0
101175434: f00f6628    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101175438: f9453901    	ldr	x1, [x8, #0xa70] ; setM_nsToUsr:
10117543c: aa1a03e0    	mov	x0, x26
101175440: aa1303e2    	mov	x2, x19
101175444: 95aac73e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175448: aa1303e0    	mov	x0, x19
10117544c: 95aac742    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101175450: d00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101175454: f945c501    	ldr	x1, [x8, #0xb88] ; setM_uiMesLocalID:
101175458: aa1a03e0    	mov	x0, x26
10117545c: aa1c03e2    	mov	x2, x28
101175460: 95aac737    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175464: d00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101175468: f945e900    	ldr	x0, [x8, #0xbd0]
10117546c: f00f7c48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101175470: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101175474: 95aac732    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175478: aa1d03fd    	mov	x29, x29
10117547c: 95aac733    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101175480: aa0003f3    	mov	x19, x0
101175484: f00f7fe8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101175488: f9403100    	ldr	x0, [x8, #0x60]
10117548c: d00f7c48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101175490: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101175494: 95aac72a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175498: aa0003e2    	mov	x2, x0
10117549c: 900f6628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1011754a0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1011754a4: aa1303e0    	mov	x0, x19
1011754a8: 95aac725    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011754ac: aa1d03fd    	mov	x29, x29
1011754b0: 95aac726    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1011754b4: aa1403f6    	mov	x22, x20
1011754b8: aa0003f4    	mov	x20, x0
1011754bc: d00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1011754c0: f9458501    	ldr	x1, [x8, #0xb08] ; DelMsg:MsgWrap:
1011754c4: aa1803e2    	mov	x2, x24
1011754c8: aa1a03e3    	mov	x3, x26
1011754cc: 95aac71c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011754d0: aa1403e0    	mov	x0, x20
1011754d4: 95aac720    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1011754d8: aa1303e0    	mov	x0, x19
1011754dc: 95aac71e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1011754e0: d00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1011754e4: f9453513    	ldr	x19, [x8, #0xa68]
1011754e8: d00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1011754ec: f9454500    	ldr	x0, [x8, #0xa88]
1011754f0: f9402fe1    	ldr	x1, [sp, #0x58]
1011754f4: aa1803e2    	mov	x2, x24
1011754f8: 95aac711    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011754fc: aa1d03fd    	mov	x29, x29
101175500: 95aac712    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101175504: aa0003f4    	mov	x20, x0
101175508: aa1503e8    	mov	x8, x21
10117550c: a901a3f9    	stp	x25, x8, [sp, #0x18]
101175510: aa1c03e8    	mov	x8, x28
101175514: a900a3e0    	stp	x0, x8, [sp, #0x8]
101175518: b00e9ee8    	adrp	x8, 0x11e552000 <dyld_stub_binder+0x11e552000>
10117551c: 9115a108    	add	x8, x8, #0x568
101175520: f90003e8    	str	x8, [sp]
101175524: 900d0583    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
101175528: 9107f063    	add	x3, x3, #0x1fc
10117552c: f00d1025    	adrp	x5, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101175530: 9120a4a5    	add	x5, x5, #0x829
101175534: f00d1027    	adrp	x7, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101175538: 912730e7    	add	x7, x7, #0x9cc
10117553c: aa1303e0    	mov	x0, x19
101175540: aa1603e1    	mov	x1, x22
101175544: 52800042    	mov	w2, #0x2                ; =2
101175548: 52800004    	mov	w4, #0x0                ; =0
10117554c: 52801a06    	mov	w6, #0xd0               ; =208
101175550: 95aac6fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175554: aa1403e0    	mov	x0, x20
101175558: 95aac6ff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10117555c: aa1a03e0    	mov	x0, x26
101175560: 95aac6fd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101175564: d101a3a0    	sub	x0, x29, #0x68
101175568: 95aa5f73    	bl	0x107c0d334 <_Flutter_MMFoundation_BindContext+0x40e8f18>
10117556c: f9403ff5    	ldr	x21, [sp, #0x78]
101175570: 14000092    	b	0x1011757b8 <__text+0x116d7b8>
101175574: 900f6628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101175578: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10117557c: aa1403e8    	mov	x8, x20
101175580: a901a3fc    	stp	x28, x8, [sp, #0x18]
101175584: aa1703e8    	mov	x8, x23
101175588: a900a3f6    	stp	x22, x8, [sp, #0x8]
10117558c: b00e9ee8    	adrp	x8, 0x11e552000 <dyld_stub_binder+0x11e552000>
101175590: 9114a108    	add	x8, x8, #0x528
101175594: f90003e8    	str	x8, [sp]
101175598: 900d0583    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
10117559c: 9107f063    	add	x3, x3, #0x1fc
1011755a0: f00d1025    	adrp	x5, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
1011755a4: 9120a4a5    	add	x5, x5, #0x829
1011755a8: f00d1027    	adrp	x7, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
1011755ac: 912730e7    	add	x7, x7, #0x9cc
1011755b0: aa1a03e0    	mov	x0, x26
1011755b4: 52800062    	mov	w2, #0x3                ; =3
1011755b8: 52800004    	mov	w4, #0x0                ; =0
1011755bc: 52801566    	mov	w6, #0xab               ; =171
1011755c0: 95aac6df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011755c4: aa1603e0    	mov	x0, x22
1011755c8: 1400007b    	b	0x1011757b4 <__text+0x116d7b4>
1011755cc: aa0003f7    	mov	x23, x0
1011755d0: b9006bf8    	str	w24, [sp, #0x68]
1011755d4: aa1c03fa    	mov	x26, x28
1011755d8: f9403ff5    	ldr	x21, [sp, #0x78]
1011755dc: aa1503e0    	mov	x0, x21
1011755e0: f9402bfc    	ldr	x28, [sp, #0x50]
1011755e4: aa1c03e1    	mov	x1, x28
1011755e8: 95aac6d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011755ec: f85883b8    	ldur	x24, [x29, #-0x78]
1011755f0: b40004a0    	cbz	x0, 0x101175684 <__text+0x116d684>
1011755f4: 5280ec80    	mov	w0, #0x764              ; =1892
1011755f8: 528001e1    	mov	w1, #0xf                ; =15
1011755fc: 52800022    	mov	w2, #0x1                ; =1
101175600: 52800003    	mov	w3, #0x0                ; =0
101175604: 52800004    	mov	w4, #0x0                ; =0
101175608: 94376add    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10117560c: f00f8028    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
101175610: f9443113    	ldr	x19, [x8, #0x860]
101175614: aa1503e0    	mov	x0, x21
101175618: aa1c03e1    	mov	x1, x28
10117561c: 95aac6c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175620: aa0003e5    	mov	x5, x0
101175624: b00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101175628: f9447101    	ldr	x1, [x8, #0x8e0] ; WriteAudioFile:LocalID:Offset:Len:Data:
10117562c: aa1303e0    	mov	x0, x19
101175630: aa1803e2    	mov	x2, x24
101175634: aa1a03e3    	mov	x3, x26
101175638: 52800004    	mov	w4, #0x0                ; =0
10117563c: aa1503e6    	mov	x6, x21
101175640: 95aac6bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175644: aa0003f4    	mov	x20, x0
101175648: d00f83a8    	adrp	x8, 0x1201eb000 <dyld_stub_binder+0x1201eb000>
10117564c: b982e508    	ldrsw	x8, [x8, #0x2e4]
101175650: f94043e9    	ldr	x9, [sp, #0x80]
101175654: 8b080120    	add	x0, x9, x8
101175658: 95aac6cd    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10117565c: aa0003f3    	mov	x19, x0
101175660: aa1503e0    	mov	x0, x21
101175664: aa1c03e1    	mov	x1, x28
101175668: 95aac6b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10117566c: b00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101175670: f9447501    	ldr	x1, [x8, #0x8e8] ; OnRecvData:MesLocalID:n64MesSvrID:CreateTime:VoiceTime:Offset:Len:Data:EndFlag:ErrNo:
101175674: 34000874    	cbz	w20, 0x101175780 <__text+0x116d780>
101175678: d2800028    	mov	x8, #0x1                ; =1
10117567c: f2c00068    	movk	x8, #0x3, lsl #32
101175680: 14000042    	b	0x101175788 <__text+0x116d788>
101175684: f90033f4    	str	x20, [sp, #0x60]
101175688: d00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10117568c: f9467913    	ldr	x19, [x8, #0xcf0]
101175690: d00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101175694: f943a501    	ldr	x1, [x8, #0x748] ; GetDocPath
101175698: aa1303e0    	mov	x0, x19
10117569c: 95aac6a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011756a0: aa1d03fd    	mov	x29, x29
1011756a4: 95aac6a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1011756a8: aa0003f4    	mov	x20, x0
1011756ac: d00f6668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1011756b0: f943a901    	ldr	x1, [x8, #0x750] ; GetPathOfMesAudio:LocalID:DocPath:
1011756b4: aa1303e0    	mov	x0, x19
1011756b8: aa1803e2    	mov	x2, x24
1011756bc: aa1a03e3    	mov	x3, x26
1011756c0: aa1403e4    	mov	x4, x20
1011756c4: 95aac69e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011756c8: aa1d03fd    	mov	x29, x29
1011756cc: 95aac69f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1011756d0: aa0003f3    	mov	x19, x0
1011756d4: aa1403e0    	mov	x0, x20
1011756d8: 95aac69f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1011756dc: d00f7ff4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
1011756e0: f9463680    	ldr	x0, [x20, #0xc68]
1011756e4: 900f6628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1011756e8: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
1011756ec: aa1303e2    	mov	x2, x19
1011756f0: 95aac693    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011756f4: 340002c0    	cbz	w0, 0x10117574c <__text+0x116d74c>
1011756f8: d00f7fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1011756fc: f9453500    	ldr	x0, [x8, #0xa68]
101175700: b00e9ee8    	adrp	x8, 0x11e552000 <dyld_stub_binder+0x11e552000>
101175704: 91162108    	add	x8, x8, #0x588
101175708: f90003e8    	str	x8, [sp]
10117570c: 900d0583    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
101175710: 9107f063    	add	x3, x3, #0x1fc
101175714: f00d1025    	adrp	x5, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101175718: 9120a4a5    	add	x5, x5, #0x829
10117571c: f00d1027    	adrp	x7, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101175720: 912730e7    	add	x7, x7, #0x9cc
101175724: f94033e1    	ldr	x1, [sp, #0x60]
101175728: 52800042    	mov	w2, #0x2                ; =2
10117572c: 52800004    	mov	w4, #0x0                ; =0
101175730: 52801b26    	mov	w6, #0xd9               ; =217
101175734: 95aac682    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101175738: f9463680    	ldr	x0, [x20, #0xc68]
10117573c: 900f6628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101175740: f946f101    	ldr	x1, [x8, #0xde0] ; RemoveFile:
101175744: aa1303e2    	mov	x2, x19
101175748: 95aac67d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10117574c: b00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101175750: f944e901    	ldr	x1, [x8, #0x9d0] ; AddNewDownload:LocalID:n64SvrID:VoiceLen:VoiceTime:CreateTime:EndFlag:bufid:
101175754: f90007f7    	str	x23, [sp, #0x8]
101175758: b94073e8    	ldr	w8, [sp, #0x70]
10117575c: b90003e8    	str	w8, [sp]
101175760: f94043e0    	ldr	x0, [sp, #0x80]
101175764: aa1803e2    	mov	x2, x24
101175768: aa1a03e3    	mov	x3, x26
10117576c: aa1903e4    	mov	x4, x25
101175770: aa1603e5    	mov	x5, x22
101175774: b9406be6    	ldr	w6, [sp, #0x68]
101175778: f85903a7    	ldur	x7, [x29, #-0x70]
10117577c: 1400000c    	b	0x1011757ac <__text+0x116d7ac>
101175780: d2800028    	mov	x8, #0x1                ; =1
101175784: f2c00088    	movk	x8, #0x4, lsl #32
101175788: a900a3f5    	stp	x21, x8, [sp, #0x8]
10117578c: b90003e0    	str	w0, [sp]
101175790: aa1303e0    	mov	x0, x19
101175794: aa1803e2    	mov	x2, x24
101175798: aa1a03e3    	mov	x3, x26
10117579c: aa1903e4    	mov	x4, x25
1011757a0: f85903a5    	ldur	x5, [x29, #-0x70]
1011757a4: b9406be6    	ldr	w6, [sp, #0x68]
1011757a8: 52800007    	mov	w7, #0x0                ; =0
1011757ac: 95aac664    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011757b0: aa1303e0    	mov	x0, x19
1011757b4: 95aac668    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1011757b8: aa1b03e0    	mov	x0, x27
1011757bc: 95aac666    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1011757c0: aa1503e0    	mov	x0, x21
1011757c4: 95aac664    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1011757c8: aa1803e0    	mov	x0, x24
1011757cc: 95aac662    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1011757d0: a9507bfd    	ldp	x29, x30, [sp, #0x100]
1011757d4: a94f4ff4    	ldp	x20, x19, [sp, #0xf0]
1011757d8: a94e57f6    	ldp	x22, x21, [sp, #0xe0]
1011757dc: a94d5ff8    	ldp	x24, x23, [sp, #0xd0]
1011757e0: a94c67fa    	ldp	x26, x25, [sp, #0xc0]
1011757e4: a94b6ffc    	ldp	x28, x27, [sp, #0xb0]
1011757e8: 910443ff    	add	sp, sp, #0x110
1011757ec: d65f03c0    	ret