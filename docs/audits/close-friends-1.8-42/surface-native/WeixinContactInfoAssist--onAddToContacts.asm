
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a950f94: d101c3ff    	sub	sp, sp, #0x70
10a950f98: a9016ffc    	stp	x28, x27, [sp, #0x10]
10a950f9c: a90267fa    	stp	x26, x25, [sp, #0x20]
10a950fa0: a9035ff8    	stp	x24, x23, [sp, #0x30]
10a950fa4: a90457f6    	stp	x22, x21, [sp, #0x40]
10a950fa8: a9054ff4    	stp	x20, x19, [sp, #0x50]
10a950fac: a9067bfd    	stp	x29, x30, [sp, #0x60]
10a950fb0: 910183fd    	add	x29, sp, #0x60
10a950fb4: aa0003f3    	mov	x19, x0
10a950fb8: f00b1808    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a950fbc: 52800029    	mov	w9, #0x1                ; =1
10a950fc0: 390bf909    	strb	w9, [x8, #0x2fe]
10a950fc4: f00ab268    	adrp	x8, 0x11ff9f000 <dyld_stub_binder+0x11ff9f000>
10a950fc8: f940c914    	ldr	x20, [x8, #0x190] ; reportOpenimChatroomMember:viewId:
10a950fcc: 9009da82    	adrp	x2, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
10a950fd0: 9112a042    	add	x2, x2, #0x4a8
10a950fd4: b009f483    	adrp	x3, 0x11e7e1000 <dyld_stub_binder+0x11e7e1000>
10a950fd8: 911c2063    	add	x3, x3, #0x708
10a950fdc: aa1403e1    	mov	x1, x20
10a950fe0: 953c2919    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950fe4: f00ac948    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a950fe8: b986d515    	ldrsw	x21, [x8, #0x6d4] ; ivar WeixinContactInfoAssist.m_chatContact
10a950fec: f8756a60    	ldr	x0, [x19, x21]
10a950ff0: f00aa748    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a950ff4: f947d101    	ldr	x1, [x8, #0xfa0] ; isChatroom
10a950ff8: 953c2913    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a950ffc: 340004e0    	cbz	w0, 0x10a951098 <_Flutter_MMFoundation_BindContext+0x6e2cc7c>
10a951000: f8756a60    	ldr	x0, [x19, x21]
10a951004: f00aa908    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
10a951008: f9451501    	ldr	x1, [x8, #0xa28] ; m_uiTypeExt
10a95100c: 953c290e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951010: 36200440    	tbz	w0, #0x4, 0x10a951098 <_Flutter_MMFoundation_BindContext+0x6e2cc7c>
10a951014: f8756a60    	ldr	x0, [x19, x21]
10a951018: 900aa7e8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
10a95101c: f945a101    	ldr	x1, [x8, #0xb40] ; isOwner
10a951020: 953c2909    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951024: 370003a0    	tbnz	w0, #0x0, 0x10a951098 <_Flutter_MMFoundation_BindContext+0x6e2cc7c>
10a951028: f8756a60    	ldr	x0, [x19, x21]
10a95102c: d00aa748    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a951030: f9460101    	ldr	x1, [x8, #0xc00] ; m_nsOwner
10a951034: 953c2904    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951038: aa1d03fd    	mov	x29, x29
10a95103c: 953c2905    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951040: aa0003f5    	mov	x21, x0
10a951044: d00ac468    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a951048: 91093108    	add	x8, x8, #0x24c
10a95104c: b9800108    	ldrsw	x8, [x8]
10a951050: f8686a60    	ldr	x0, [x19, x8]
10a951054: d00aa748    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a951058: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
10a95105c: 953c28fa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951060: aa1d03fd    	mov	x29, x29
10a951064: 953c28fb    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951068: aa0003f6    	mov	x22, x0
10a95106c: d00abd88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a951070: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
10a951074: aa1503e0    	mov	x0, x21
10a951078: aa1603e2    	mov	x2, x22
10a95107c: 953c28f2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951080: aa0003f7    	mov	x23, x0
10a951084: aa1603e0    	mov	x0, x22
10a951088: 953c28f5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a95108c: aa1503e0    	mov	x0, x21
10a951090: 953c28f3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951094: 360022f7    	tbz	w23, #0x0, 0x10a9514f0 <_Flutter_MMFoundation_BindContext+0x6e2d0d4>
10a951098: f00abae8    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a95109c: f9454d01    	ldr	x1, [x8, #0xa98] ; checkShareCardEffective
10a9510a0: aa1303e0    	mov	x0, x19
10a9510a4: 953c28e8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9510a8: 340000a0    	cbz	w0, 0x10a9510bc <_Flutter_MMFoundation_BindContext+0x6e2cca0>
10a9510ac: d00ac468    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a9510b0: 91093108    	add	x8, x8, #0x24c
10a9510b4: b980011b    	ldrsw	x27, [x8]
10a9510b8: 14000038    	b	0x10a951198 <_Flutter_MMFoundation_BindContext+0x6e2cd7c>
10a9510bc: d00ac11a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
10a9510c0: f945eb40    	ldr	x0, [x26, #0xbd0]
10a9510c4: f00abd68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a9510c8: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
10a9510cc: aa1603e1    	mov	x1, x22
10a9510d0: 953c28dd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9510d4: aa1d03fd    	mov	x29, x29
10a9510d8: 953c28de    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9510dc: aa0003f5    	mov	x21, x0
10a9510e0: f00ac108    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a9510e4: f9401500    	ldr	x0, [x8, #0x28] ; P;,
10a9510e8: d00abd68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a9510ec: f947ad17    	ldr	x23, [x8, #0xf58] ; class
10a9510f0: aa1703e1    	mov	x1, x23
10a9510f4: 953c28d4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9510f8: aa0003e2    	mov	x2, x0
10a9510fc: 900aa748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a951100: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
10a951104: aa1503e0    	mov	x0, x21
10a951108: aa1803e1    	mov	x1, x24
10a95110c: 953c28ce    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951110: aa1d03fd    	mov	x29, x29
10a951114: 953c28cf    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951118: aa0003f4    	mov	x20, x0
10a95111c: aa1503e0    	mov	x0, x21
10a951120: 953c28cf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951124: d00ac468    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a951128: 91093108    	add	x8, x8, #0x24c
10a95112c: b980011b    	ldrsw	x27, [x8]
10a951130: f87b6a60    	ldr	x0, [x19, x27]
10a951134: d00aa748    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a951138: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
10a95113c: 953c28c2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951140: aa1d03fd    	mov	x29, x29
10a951144: 953c28c3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951148: aa0003f9    	mov	x25, x0
10a95114c: f00aa748    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a951150: f940c901    	ldr	x1, [x8, #0x190] ; getContactByName:
10a951154: aa1403e0    	mov	x0, x20
10a951158: aa1903e2    	mov	x2, x25
10a95115c: 953c28ba    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951160: aa1d03fd    	mov	x29, x29
10a951164: 953c28bb    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951168: aa0003f5    	mov	x21, x0
10a95116c: aa1903e0    	mov	x0, x25
10a951170: 953c28bb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951174: f00aa748    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a951178: f940cd01    	ldr	x1, [x8, #0x198] ; isMMContact
10a95117c: aa1503e0    	mov	x0, x21
10a951180: 953c28b1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951184: 34000f60    	cbz	w0, 0x10a951370 <_Flutter_MMFoundation_BindContext+0x6e2cf54>
10a951188: aa1503e0    	mov	x0, x21
10a95118c: 953c28b4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951190: aa1403e0    	mov	x0, x20
10a951194: 953c28b2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951198: f87b6a60    	ldr	x0, [x19, x27]
10a95119c: d00aa7c8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
10a9511a0: f9414101    	ldr	x1, [x8, #0x280] ; isBlack
10a9511a4: 953c28a8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9511a8: 34000c00    	cbz	w0, 0x10a951328 <_Flutter_MMFoundation_BindContext+0x6e2cf0c>
10a9511ac: d00ac108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a9511b0: f9453500    	ldr	x0, [x8, #0xa68]
10a9511b4: 900aa748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a9511b8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a9511bc: 9009f488    	adrp	x8, 0x11e7e1000 <dyld_stub_binder+0x11e7e1000>
10a9511c0: 911da108    	add	x8, x8, #0x768
10a9511c4: f90003e8    	str	x8, [sp]
10a9511c8: f008a305    	adrp	x5, 0x11bdb4000 <dyld_stub_binder+0x11bdb4000>
10a9511cc: 9133cca5    	add	x5, x5, #0xcf3
10a9511d0: f008a307    	adrp	x7, 0x11bdb4000 <dyld_stub_binder+0x11bdb4000>
10a9511d4: 913ee0e7    	add	x7, x7, #0xfb8
10a9511d8: 52800042    	mov	w2, #0x2                ; =2
10a9511dc: d2800003    	mov	x3, #0x0                ; =0
10a9511e0: 52800004    	mov	w4, #0x0                ; =0
10a9511e4: 52817e06    	mov	w6, #0xbf0              ; =3056
10a9511e8: 953c2897    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9511ec: d00ac108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a9511f0: f9469514    	ldr	x20, [x8, #0xd28] ; x<c
10a9511f4: d00ac11b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
10a9511f8: f945eb60    	ldr	x0, [x27, #0xbd0]
10a9511fc: f00abd68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a951200: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
10a951204: aa1603e1    	mov	x1, x22
10a951208: 953c288f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95120c: aa1d03fd    	mov	x29, x29
10a951210: 953c2890    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951214: aa0003f3    	mov	x19, x0
10a951218: d00ac11c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10a95121c: f9462b80    	ldr	x0, [x28, #0xc50]
10a951220: d00abd68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a951224: f947ad17    	ldr	x23, [x8, #0xf58] ; class
10a951228: aa1703e1    	mov	x1, x23
10a95122c: 953c2886    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951230: aa0003e2    	mov	x2, x0
10a951234: 900aa748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a951238: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
10a95123c: aa1303e0    	mov	x0, x19
10a951240: aa1803e1    	mov	x1, x24
10a951244: 953c2880    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951248: aa1d03fd    	mov	x29, x29
10a95124c: 953c2881    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951250: aa0003f5    	mov	x21, x0
10a951254: 900aa748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a951258: f9464519    	ldr	x25, [x8, #0xc88] ; getStringForCurLanguage:
10a95125c: 9009f482    	adrp	x2, 0x11e7e1000 <dyld_stub_binder+0x11e7e1000>
10a951260: 911e2042    	add	x2, x2, #0x788
10a951264: aa1903e1    	mov	x1, x25
10a951268: 953c2877    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95126c: aa1d03fd    	mov	x29, x29
10a951270: 953c2878    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951274: aa0003fa    	mov	x26, x0
10a951278: f945eb60    	ldr	x0, [x27, #0xbd0]
10a95127c: aa1603e1    	mov	x1, x22
10a951280: 953c2871    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951284: aa1d03fd    	mov	x29, x29
10a951288: 953c2872    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a95128c: aa0003f6    	mov	x22, x0
10a951290: f9462b80    	ldr	x0, [x28, #0xc50]
10a951294: aa1703e1    	mov	x1, x23
10a951298: 953c286b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95129c: aa0003e2    	mov	x2, x0
10a9512a0: aa1603e0    	mov	x0, x22
10a9512a4: aa1803e1    	mov	x1, x24
10a9512a8: 953c2867    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9512ac: aa1d03fd    	mov	x29, x29
10a9512b0: 953c2868    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9512b4: aa0003f7    	mov	x23, x0
10a9512b8: f009da62    	adrp	x2, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
10a9512bc: 9106a042    	add	x2, x2, #0x1a8
10a9512c0: aa1903e1    	mov	x1, x25
10a9512c4: 953c2860    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9512c8: aa1d03fd    	mov	x29, x29
10a9512cc: 953c2861    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9512d0: aa0003f8    	mov	x24, x0
10a9512d4: b00aa748    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10a9512d8: f941cd01    	ldr	x1, [x8, #0x398] ; showAlertWithTitle:message:btnTitle:
10a9512dc: aa1403e0    	mov	x0, x20
10a9512e0: aa1a03e2    	mov	x2, x26
10a9512e4: d2800003    	mov	x3, #0x0                ; =0
10a9512e8: aa1803e4    	mov	x4, x24
10a9512ec: 953c2856    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9512f0: aa1d03fd    	mov	x29, x29
10a9512f4: 953c285e    	bl	0x10f85b46c <_UR_96F1_B25D+0x3a640dc>
10a9512f8: aa1803e0    	mov	x0, x24
10a9512fc: 953c2858    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951300: aa1703e0    	mov	x0, x23
10a951304: 953c2856    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951308: aa1603e0    	mov	x0, x22
10a95130c: 953c2854    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951310: aa1a03e0    	mov	x0, x26
10a951314: 953c2852    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951318: aa1503e0    	mov	x0, x21
10a95131c: 953c2850    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951320: aa1303e0    	mov	x0, x19
10a951324: 14000060    	b	0x10a9514a4 <_Flutter_MMFoundation_BindContext+0x6e2d088>
10a951328: f00ab2e8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
10a95132c: f9469101    	ldr	x1, [x8, #0xd20] ; goToAddContactWhenHadContactVerify
10a951330: aa1303e0    	mov	x0, x19
10a951334: 953c2844    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951338: 370000c0    	tbnz	w0, #0x0, 0x10a951350 <_Flutter_MMFoundation_BindContext+0x6e2cf34>
10a95133c: f00abae8    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a951340: f9457101    	ldr	x1, [x8, #0xae0] ; tryAddContactByPreFetchVerifyTicket
10a951344: aa1303e0    	mov	x0, x19
10a951348: 953c283f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95134c: 36000bc0    	tbz	w0, #0x0, 0x10a9514c4 <_Flutter_MMFoundation_BindContext+0x6e2d0a8>
10a951350: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10a951354: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10a951358: a94457f6    	ldp	x22, x21, [sp, #0x40]
10a95135c: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10a951360: a94267fa    	ldp	x26, x25, [sp, #0x20]
10a951364: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10a951368: 9101c3ff    	add	sp, sp, #0x70
10a95136c: d65f03c0    	ret
10a951370: d00ac108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a951374: f9469508    	ldr	x8, [x8, #0xd28] ; x<c
10a951378: f90007e8    	str	x8, [sp, #0x8]
10a95137c: f945eb40    	ldr	x0, [x26, #0xbd0]
10a951380: aa1603e1    	mov	x1, x22
10a951384: 953c2830    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951388: aa1d03fd    	mov	x29, x29
10a95138c: 953c2831    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951390: aa0003f3    	mov	x19, x0
10a951394: d00ac11a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
10a951398: f9462b40    	ldr	x0, [x26, #0xc50]
10a95139c: aa1703e1    	mov	x1, x23
10a9513a0: 953c2829    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9513a4: aa0003e2    	mov	x2, x0
10a9513a8: aa1303e0    	mov	x0, x19
10a9513ac: aa1803e1    	mov	x1, x24
10a9513b0: 953c2825    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9513b4: aa1d03fd    	mov	x29, x29
10a9513b8: 953c2826    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9513bc: aa0003f9    	mov	x25, x0
10a9513c0: 900aa748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a9513c4: f946451b    	ldr	x27, [x8, #0xc88] ; getStringForCurLanguage:
10a9513c8: f00a0a82    	adrp	x2, 0x11eaa4000 <dyld_stub_binder+0x11eaa4000>
10a9513cc: 911e2042    	add	x2, x2, #0x788
10a9513d0: aa1b03e1    	mov	x1, x27
10a9513d4: 953c281c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9513d8: aa1d03fd    	mov	x29, x29
10a9513dc: 953c281d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9513e0: aa0003fc    	mov	x28, x0
10a9513e4: d00ac108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a9513e8: f945e900    	ldr	x0, [x8, #0xbd0]
10a9513ec: aa1603e1    	mov	x1, x22
10a9513f0: 953c2815    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9513f4: aa1d03fd    	mov	x29, x29
10a9513f8: 953c2816    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9513fc: aa0003f6    	mov	x22, x0
10a951400: f9462b40    	ldr	x0, [x26, #0xc50]
10a951404: aa1703e1    	mov	x1, x23
10a951408: 953c280f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95140c: aa0003e2    	mov	x2, x0
10a951410: aa1603e0    	mov	x0, x22
10a951414: aa1803e1    	mov	x1, x24
10a951418: 953c280b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a95141c: aa1d03fd    	mov	x29, x29
10a951420: 953c280c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951424: aa0003f7    	mov	x23, x0
10a951428: f009da62    	adrp	x2, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
10a95142c: 9106a042    	add	x2, x2, #0x1a8
10a951430: aa1b03e1    	mov	x1, x27
10a951434: 953c2804    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951438: aa1d03fd    	mov	x29, x29
10a95143c: 953c2805    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951440: aa0003f8    	mov	x24, x0
10a951444: b00aa748    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10a951448: f941cd01    	ldr	x1, [x8, #0x398] ; showAlertWithTitle:message:btnTitle:
10a95144c: f94007e0    	ldr	x0, [sp, #0x8]
10a951450: aa1c03e2    	mov	x2, x28
10a951454: d2800003    	mov	x3, #0x0                ; =0
10a951458: aa1803e4    	mov	x4, x24
10a95145c: 953c27fa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951460: aa1d03fd    	mov	x29, x29
10a951464: 953c2802    	bl	0x10f85b46c <_UR_96F1_B25D+0x3a640dc>
10a951468: aa1803e0    	mov	x0, x24
10a95146c: 953c27fc    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951470: aa1703e0    	mov	x0, x23
10a951474: 953c27fa    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951478: aa1603e0    	mov	x0, x22
10a95147c: 953c27f8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951480: aa1c03e0    	mov	x0, x28
10a951484: 953c27f6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951488: aa1903e0    	mov	x0, x25
10a95148c: 953c27f4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951490: aa1303e0    	mov	x0, x19
10a951494: 953c27f2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951498: aa1503e0    	mov	x0, x21
10a95149c: 953c27f0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9514a0: aa1403e0    	mov	x0, x20
10a9514a4: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10a9514a8: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10a9514ac: a94457f6    	ldp	x22, x21, [sp, #0x40]
10a9514b0: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10a9514b4: a94267fa    	ldp	x26, x25, [sp, #0x20]
10a9514b8: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10a9514bc: 9101c3ff    	add	sp, sp, #0x70
10a9514c0: 153c27e7    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9514c4: f00abae8    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a9514c8: f9457501    	ldr	x1, [x8, #0xae8] ; doSendVerifyOrAddContact
10a9514cc: aa1303e0    	mov	x0, x19
10a9514d0: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10a9514d4: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10a9514d8: a94457f6    	ldp	x22, x21, [sp, #0x40]
10a9514dc: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10a9514e0: a94267fa    	ldp	x26, x25, [sp, #0x20]
10a9514e4: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10a9514e8: 9101c3ff    	add	sp, sp, #0x70
10a9514ec: 153c27d6    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9514f0: d00ac108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a9514f4: f9469508    	ldr	x8, [x8, #0xd28] ; x<c
10a9514f8: f90007e8    	str	x8, [sp, #0x8]
10a9514fc: d00ac108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a951500: f945e900    	ldr	x0, [x8, #0xbd0]
10a951504: f00abd68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a951508: f944e918    	ldr	x24, [x8, #0x9d0] ; currentContext
10a95150c: aa1803e1    	mov	x1, x24
10a951510: 953c27cd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951514: aa1d03fd    	mov	x29, x29
10a951518: 953c27ce    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a95151c: aa0003f5    	mov	x21, x0
10a951520: d00ac116    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10a951524: f9462ac0    	ldr	x0, [x22, #0xc50]
10a951528: d00abd68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a95152c: f947ad19    	ldr	x25, [x8, #0xf58] ; class
10a951530: aa1903e1    	mov	x1, x25
10a951534: 953c27c4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951538: aa0003e2    	mov	x2, x0
10a95153c: 900aa748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a951540: f946411a    	ldr	x26, [x8, #0xc80] ; getService:
10a951544: aa1503e0    	mov	x0, x21
10a951548: aa1a03e1    	mov	x1, x26
10a95154c: 953c27be    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951550: aa1d03fd    	mov	x29, x29
10a951554: 953c27bf    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951558: aa0003f7    	mov	x23, x0
10a95155c: 900aa748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a951560: f946451b    	ldr	x27, [x8, #0xc88] ; getStringForCurLanguage:
10a951564: 9009f482    	adrp	x2, 0x11e7e1000 <dyld_stub_binder+0x11e7e1000>
10a951568: 911ca042    	add	x2, x2, #0x728
10a95156c: aa1b03e1    	mov	x1, x27
10a951570: 953c27b5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951574: aa1d03fd    	mov	x29, x29
10a951578: 953c27b6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a95157c: aa0003fc    	mov	x28, x0
10a951580: d00ac108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a951584: f945e900    	ldr	x0, [x8, #0xbd0]
10a951588: aa1803e1    	mov	x1, x24
10a95158c: 953c27ae    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a951590: aa1d03fd    	mov	x29, x29
10a951594: 953c27af    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a951598: aa0003f8    	mov	x24, x0
10a95159c: f9462ac0    	ldr	x0, [x22, #0xc50]
10a9515a0: aa1903e1    	mov	x1, x25
10a9515a4: 953c27a8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9515a8: aa0003e2    	mov	x2, x0
10a9515ac: aa1803e0    	mov	x0, x24
10a9515b0: aa1a03e1    	mov	x1, x26
10a9515b4: 953c27a4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9515b8: aa1d03fd    	mov	x29, x29
10a9515bc: 953c27a5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9515c0: aa0003f9    	mov	x25, x0
10a9515c4: f009da62    	adrp	x2, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
10a9515c8: 9106a042    	add	x2, x2, #0x1a8
10a9515cc: aa1b03e1    	mov	x1, x27
10a9515d0: 953c279d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9515d4: aa1d03fd    	mov	x29, x29
10a9515d8: 953c279e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9515dc: aa0003fa    	mov	x26, x0
10a9515e0: b00aa748    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10a9515e4: f941cd01    	ldr	x1, [x8, #0x398] ; showAlertWithTitle:message:btnTitle:
10a9515e8: f94007e0    	ldr	x0, [sp, #0x8]
10a9515ec: aa1c03e2    	mov	x2, x28
10a9515f0: d2800003    	mov	x3, #0x0                ; =0
10a9515f4: aa1a03e4    	mov	x4, x26
10a9515f8: 953c2793    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9515fc: aa1d03fd    	mov	x29, x29
10a951600: 953c279b    	bl	0x10f85b46c <_UR_96F1_B25D+0x3a640dc>
10a951604: aa1a03e0    	mov	x0, x26
10a951608: 953c2795    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a95160c: aa1903e0    	mov	x0, x25
10a951610: 953c2793    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951614: aa1803e0    	mov	x0, x24
10a951618: 953c2791    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a95161c: aa1c03e0    	mov	x0, x28
10a951620: 953c278f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951624: aa1703e0    	mov	x0, x23
10a951628: 953c278d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a95162c: aa1503e0    	mov	x0, x21
10a951630: 953c278b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a951634: 9009da82    	adrp	x2, 0x11e4a1000 <dyld_stub_binder+0x11e4a1000>
10a951638: 91272042    	add	x2, x2, #0x9c8
10a95163c: 9009f483    	adrp	x3, 0x11e7e1000 <dyld_stub_binder+0x11e7e1000>
10a951640: 911d2063    	add	x3, x3, #0x748
10a951644: aa1303e0    	mov	x0, x19
10a951648: aa1403e1    	mov	x1, x20
10a95164c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10a951650: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10a951654: a94457f6    	ldp	x22, x21, [sp, #0x40]
10a951658: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10a95165c: a94267fa    	ldp	x26, x25, [sp, #0x20]
10a951660: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10a951664: 9101c3ff    	add	sp, sp, #0x70
10a951668: 153c2777    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
