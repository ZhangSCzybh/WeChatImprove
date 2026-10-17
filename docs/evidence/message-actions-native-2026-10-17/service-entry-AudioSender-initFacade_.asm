
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1001760e4: d101c3ff    	sub	sp, sp, #0x70
1001760e8: a9016ffc    	stp	x28, x27, [sp, #0x10]
1001760ec: a90267fa    	stp	x26, x25, [sp, #0x20]
1001760f0: a9035ff8    	stp	x24, x23, [sp, #0x30]
1001760f4: a90457f6    	stp	x22, x21, [sp, #0x40]
1001760f8: a9054ff4    	stp	x20, x19, [sp, #0x50]
1001760fc: a9067bfd    	stp	x29, x30, [sp, #0x60]
100176100: 910183fd    	add	x29, sp, #0x60
100176104: aa0203f6    	mov	x22, x2
100176108: aa0003f4    	mov	x20, x0
10017610c: f01055a8    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
100176110: 52800029    	mov	w9, #0x1                ; =1
100176114: 391ed909    	strb	w9, [x8, #0x7b6]
100176118: aa0203e0    	mov	x0, x2
10017611c: 95eac407    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100176120: f00fffe8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
100176124: f9405100    	ldr	x0, [x8, #0xa0] ; AudioSender
100176128: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017612c: f9446101    	ldr	x1, [x8, #0x8c0] ; IsVoiceUseCdnUpload
100176130: 95eac403    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176134: aa0003e8    	mov	x8, x0
100176138: b00fffe9    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
10017613c: f9453520    	ldr	x0, [x9, #0xa68] ; iConsole
100176140: f00fe609    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100176144: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
100176148: f00ffff3    	adrp	x19, 0x120175000 <dyld_stub_binder+0x120175000>
10017614c: 340008c8    	cbz	w8, 0x100176264 <__text+0x16e264>
100176150: f00f19a8    	adrp	x8, 0x11e4ad000 <dyld_stub_binder+0x11e4ad000>
100176154: 91312108    	add	x8, x8, #0xc48
100176158: f90003e8    	str	x8, [sp]
10017615c: 900d85c3    	adrp	x3, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
100176160: 911fe463    	add	x3, x3, #0x7f9
100176164: 900d85c5    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
100176168: 912014a5    	add	x5, x5, #0x805
10017616c: 900d85c7    	adrp	x7, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
100176170: 912050e7    	add	x7, x7, #0x814
100176174: 52800042    	mov	w2, #0x2                ; =2
100176178: 52800004    	mov	w4, #0x0                ; =0
10017617c: 52800d66    	mov	w6, #0x6b               ; =107
100176180: 95eac3ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176184: f9427260    	ldr	x0, [x19, #0x4e0] ; UploadVoiceCDNMgr
100176188: 95eac3f4    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10017618c: 90100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
100176190: b9829513    	ldrsw	x19, [x8, #0x294]
100176194: f8736a88    	ldr	x8, [x20, x19]
100176198: f8336a80    	str	x0, [x20, x19]
10017619c: aa0803e0    	mov	x0, x8
1001761a0: 95eac3ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001761a4: f00fffe8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1001761a8: f9427500    	ldr	x0, [x8, #0x4e8] ; MMNewUploadVoiceMgr
1001761ac: 95eac3eb    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1001761b0: 90100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
1001761b4: b982a515    	ldrsw	x21, [x8, #0x2a4]
1001761b8: f8756a88    	ldr	x8, [x20, x21]
1001761bc: f8356a80    	str	x0, [x20, x21]
1001761c0: aa0803e0    	mov	x0, x8
1001761c4: 95eac3e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001761c8: f8756a99    	ldr	x25, [x20, x21]
1001761cc: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001761d0: f9446501    	ldr	x1, [x8, #0x8c8] ; m_oMMDB
1001761d4: aa1603e0    	mov	x0, x22
1001761d8: aa0103f5    	mov	x21, x1
1001761dc: 95eac3d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001761e0: aa1d03fd    	mov	x29, x29
1001761e4: 95eac3d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001761e8: aa0003fa    	mov	x26, x0
1001761ec: d00ffc48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1001761f0: f9428d01    	ldr	x1, [x8, #0x518] ; context
1001761f4: aa1403e0    	mov	x0, x20
1001761f8: f90007e1    	str	x1, [sp, #0x8]
1001761fc: 95eac3d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176200: aa1d03fd    	mov	x29, x29
100176204: 95eac3d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100176208: aa0003fb    	mov	x27, x0
10017620c: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100176210: f9446917    	ldr	x23, [x8, #0x8d0] ; contextLock
100176214: aa1703e1    	mov	x1, x23
100176218: 95eac3c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017621c: aa1d03fd    	mov	x29, x29
100176220: 95eac3ca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100176224: aa0003fc    	mov	x28, x0
100176228: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017622c: f9446d18    	ldr	x24, [x8, #0x8d8] ; InitUploadMgr:Lock:Delegate:
100176230: aa1903e0    	mov	x0, x25
100176234: aa1803e1    	mov	x1, x24
100176238: aa1a03e2    	mov	x2, x26
10017623c: aa1c03e3    	mov	x3, x28
100176240: aa1403e4    	mov	x4, x20
100176244: 95eac3be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176248: aa1c03e0    	mov	x0, x28
10017624c: 95eac3c2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100176250: aa1b03e0    	mov	x0, x27
100176254: 95eac3c0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100176258: aa1a03e0    	mov	x0, x26
10017625c: 95eac3be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100176260: 14000020    	b	0x1001762e0 <__text+0x16e2e0>
100176264: f00f19a8    	adrp	x8, 0x11e4ad000 <dyld_stub_binder+0x11e4ad000>
100176268: 9131a108    	add	x8, x8, #0xc68
10017626c: f90003e8    	str	x8, [sp]
100176270: 900d85c3    	adrp	x3, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
100176274: 911fe463    	add	x3, x3, #0x7f9
100176278: 900d85c5    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017627c: 912014a5    	add	x5, x5, #0x805
100176280: 900d85c7    	adrp	x7, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
100176284: 912050e7    	add	x7, x7, #0x814
100176288: 52800042    	mov	w2, #0x2                ; =2
10017628c: 52800004    	mov	w4, #0x0                ; =0
100176290: 52800e06    	mov	w6, #0x70               ; =112
100176294: 95eac3aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176298: f00fffe8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10017629c: f9427500    	ldr	x0, [x8, #0x4e8] ; MMNewUploadVoiceMgr
1001762a0: 95eac3ae    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1001762a4: 90100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
1001762a8: b9829513    	ldrsw	x19, [x8, #0x294]
1001762ac: f8736a88    	ldr	x8, [x20, x19]
1001762b0: f8336a80    	str	x0, [x20, x19]
1001762b4: aa0803e0    	mov	x0, x8
1001762b8: 95eac3a7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001762bc: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001762c0: f9446515    	ldr	x21, [x8, #0x8c8] ; m_oMMDB
1001762c4: d00ffc48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1001762c8: f9428d08    	ldr	x8, [x8, #0x518] ; context
1001762cc: f90007e8    	str	x8, [sp, #0x8]
1001762d0: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001762d4: f9446917    	ldr	x23, [x8, #0x8d0] ; contextLock
1001762d8: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
1001762dc: f9446d18    	ldr	x24, [x8, #0x8d8] ; InitUploadMgr:Lock:Delegate:
1001762e0: f8736a99    	ldr	x25, [x20, x19]
1001762e4: aa1603f3    	mov	x19, x22
1001762e8: aa1603e0    	mov	x0, x22
1001762ec: aa1503e1    	mov	x1, x21
1001762f0: 95eac393    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001762f4: aa1d03fd    	mov	x29, x29
1001762f8: 95eac394    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001762fc: aa0003fa    	mov	x26, x0
100176300: aa1403e0    	mov	x0, x20
100176304: f94007f6    	ldr	x22, [sp, #0x8]
100176308: aa1603e1    	mov	x1, x22
10017630c: 95eac38c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176310: aa1d03fd    	mov	x29, x29
100176314: 95eac38d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100176318: aa0003fb    	mov	x27, x0
10017631c: aa1703e1    	mov	x1, x23
100176320: 95eac387    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176324: aa1d03fd    	mov	x29, x29
100176328: 95eac388    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017632c: aa0003fc    	mov	x28, x0
100176330: aa1903e0    	mov	x0, x25
100176334: aa1803e1    	mov	x1, x24
100176338: aa1a03e2    	mov	x2, x26
10017633c: aa1c03e3    	mov	x3, x28
100176340: aa1403e4    	mov	x4, x20
100176344: 95eac37e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176348: aa1c03e0    	mov	x0, x28
10017634c: 95eac382    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100176350: aa1b03e0    	mov	x0, x27
100176354: 95eac380    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100176358: aa1a03e0    	mov	x0, x26
10017635c: 95eac37e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100176360: f00fffe8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
100176364: f9427100    	ldr	x0, [x8, #0x4e0] ; UploadVoiceCDNMgr
100176368: 95eac37c    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10017636c: aa0003f9    	mov	x25, x0
100176370: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100176374: f9447101    	ldr	x1, [x8, #0x8e0] ; setBypUploader:
100176378: aa1403e0    	mov	x0, x20
10017637c: aa1903e2    	mov	x2, x25
100176380: 95eac36f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176384: aa1903e0    	mov	x0, x25
100176388: 95eac373    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017638c: b00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100176390: f9447501    	ldr	x1, [x8, #0x8e8] ; bypUploader
100176394: aa1403e0    	mov	x0, x20
100176398: 95eac369    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017639c: aa1d03fd    	mov	x29, x29
1001763a0: 95eac36a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001763a4: aa0003f9    	mov	x25, x0
1001763a8: aa1303e0    	mov	x0, x19
1001763ac: aa1503e1    	mov	x1, x21
1001763b0: 95eac363    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001763b4: aa1d03fd    	mov	x29, x29
1001763b8: 95eac364    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001763bc: aa0003f5    	mov	x21, x0
1001763c0: aa1403e0    	mov	x0, x20
1001763c4: aa1603e1    	mov	x1, x22
1001763c8: 95eac35d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001763cc: aa1d03fd    	mov	x29, x29
1001763d0: 95eac35e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001763d4: aa0003f6    	mov	x22, x0
1001763d8: aa1703e1    	mov	x1, x23
1001763dc: 95eac358    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001763e0: aa1d03fd    	mov	x29, x29
1001763e4: 95eac359    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001763e8: aa0003f7    	mov	x23, x0
1001763ec: aa1903e0    	mov	x0, x25
1001763f0: aa1803e1    	mov	x1, x24
1001763f4: aa1503e2    	mov	x2, x21
1001763f8: aa1703e3    	mov	x3, x23
1001763fc: aa1403e4    	mov	x4, x20
100176400: 95eac34f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176404: aa1703e0    	mov	x0, x23
100176408: 95eac353    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017640c: aa1603e0    	mov	x0, x22
100176410: 95eac351    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100176414: aa1503e0    	mov	x0, x21
100176418: 95eac34f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017641c: aa1903e0    	mov	x0, x25
100176420: 95eac34d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100176424: aa1303e0    	mov	x0, x19
100176428: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10017642c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
100176430: a94457f6    	ldp	x22, x21, [sp, #0x40]
100176434: a9435ff8    	ldp	x24, x23, [sp, #0x30]
100176438: a94267fa    	ldp	x26, x25, [sp, #0x20]
10017643c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
100176440: 9101c3ff    	add	sp, sp, #0x70
100176444: 15eac344    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>